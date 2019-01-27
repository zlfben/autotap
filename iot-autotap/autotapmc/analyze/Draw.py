"""
Copyright 2017-2019 Lefan Zhang

This file is part of AutoTap.

AutoTap is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

AutoTap is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with AutoTap.  If not, see <https://www.gnu.org/licenses/>.
"""


import autotapmc.buchi.Buchi as Buchi
import os
from autotapmc.utils.Boolean import calculateBoolean
from autotapmc.model.Tap import ESERule, EERule, translateTapToRule
import re


def generateGraph(system, ltl, folder, only_action=False):
    ts = system.transition_system
    buchi_ts = Buchi.tsToGenBuchi(ts)
    buchi_ltl = Buchi.ltlToBuchi(ltl)
    (buchi_final, pairs) = Buchi.product(buchi_ts, buchi_ltl)

    filename_ts = folder + 'ts.gv' if folder.endswith('/') else folder + '/ts.gv'
    filename_ltl = folder + 'ltl.gv' if folder.endswith('/') else folder + '/ltl.gv'
    filename_final = folder + 'final.gv' if folder.endswith('/') else folder + '/final.gv'

    png_ts = folder + 'ts.png' if folder.endswith('/') else folder + '/ts.png'
    png_ltl = folder + 'ltl.png' if folder.endswith('/') else folder + '/ltl.png'
    png_final = folder + 'final.png' if folder.endswith('/') else folder + '/final.png'

    group = [s2 for s1, s2 in pairs]

    try:
        os.stat(folder)
    except:
        os.mkdir(folder)

    buchi_ts.writeToGv(filename_ts, only_action=only_action)
    buchi_ltl.writeToGv(filename_ltl)
    buchi_final.writeToGv(filename_final, group, only_action=only_action)

    os.system('dot -Tpng -o %s %s' % (png_ts, filename_ts))
    os.system('dot -Tpng -o %s %s' % (png_ltl, filename_ltl))
    os.system('dot -Tpng -o %s %s' % (png_final, filename_final))


class ModifiedBuchi(Buchi.GenBuchi):
    def __init__(self, buchi):
        super(ModifiedBuchi, self).__init__()

        self.state_dict = buchi.state_dict
        self.edge_list = buchi.edge_list
        self.ap_list = buchi.ap_list
        self.init_state = buchi.init_state
        self.acc_num = buchi.acc_num

        self.deleted_edge = list() # should use dotted red line
        self.new_edge = list() # should use red line, should be tuple

    def printToGv(self, group=None):
        print('digraph G {')
        if not group:
            for index, state in self.state_dict.items():
                print('\ts%d [label=\"%d: %s, acc=<%s>\"]' % (index, index, state.description, str(state.acc)))
        else:
            cluster = dict()
            for index, group in enumerate(group):
                if group not in cluster:
                    cluster[group] = [index]
                else:
                    cluster[group].append(index)
            for group, index_list in cluster.items():
                print('\tsubgraph cluster%d {' % group)
                print('\t\tlabel = \"Cluster %d\"' % group)
                for index in index_list:
                    print('\t\ts%d [label=\"%s, acc=<%s>\"]' %
                          (index, self.state_dict[index].description, str(self.state_dict[index].acc)))
                print('\t}')
        for edge_index, edge in enumerate(self.edge_list):
            if edge_index in self.deleted_edge:
                print('\ts%d -> s%d [label=\"%s\", style=\"dotted\", color=\"blue\", fontcolor=\"blue\"]' % (edge.src, edge.dst, edge.ap))
            else:
                print('\ts%d -> s%d [label=\"%s\"]' % (edge.src, edge.dst, edge.ap))

        for edge in self.new_edge:
            print('\ts%d -> s%d [color=\"red\", fontcolor=\"red\"]' % edge)
        print('}')

    def markDeletedEdge(self, edge_index):
        self.deleted_edge.append(edge_index)

    def addNewEdge(self, src_index, dst_index):
        self.new_edge.append((src_index, dst_index))


def _getAction(ts, src_field, dst_field):
    tran = [t for t in ts.trans_list if t.src_field == src_field and t.dest_field == dst_field]
    assert len(tran) == 1
    return tran[0].act


def drawPatch(system, ltl, patch, file_name):
    """
    given system and ltl property, draw graph representation of certain patch as png
    :param system: the smart home system
    :param ltl: ltl formula
    :param patch: the patch (FixPatch)
    :param file_name: file to be written
    :return:
    """
    ts = system.transition_system
    buchi_ts = Buchi.tsToGenBuchi(ts)
    buchi_ltl = Buchi.ltlToBuchi(ltl)
    (buchi_final, pairs) = Buchi.product(buchi_ts, buchi_ltl)
    group = [s2 for s1, s2 in pairs]

    modified_buchi = ModifiedBuchi(buchi_final)

    rule_dict = dict([(tap_name, translateTapToRule(tap)) for tap_name, tap in system.tap_dict.items()])
    new_rule = None if patch.type == 'delete' else patch.rule
    old_rule = None if patch.type == 'add' else rule_dict[patch.rule_name]

    field_list = [state.field for state in ts.state_list]

    for edge_index, edge in enumerate(buchi_final.edge_list):
        src_index_ts = pairs[edge.src][0]
        dst_index_ts = pairs[edge.dst][0]
        src_index_ltl = pairs[edge.src][1]
        dst_index_ltl = pairs[edge.dst][1]
        src_field = field_list[src_index_ts]
        dst_field = field_list[dst_index_ts]
        action = _getAction(ts, src_field, dst_field)

        if '>' in action:
            # this is an action triggered by a rule
            # is it handled by old rule?
            flag_old, flag_new = False, False
            if old_rule:
                old_rule_name = patch.rule_name
                if old_rule_name in action:
                    # handled
                    flag_old = True
            # is it handled by new rule?
            if new_rule:
                if isinstance(new_rule, ESERule):
                    # TODO: should check if this is the correct! should it be last state?
                    if system.apSatisfied(new_rule.condition, src_field):
                        # handled
                        flag_new = True
                elif isinstance(new_rule, EERule):
                    # handled
                    flag_new = True

            if flag_old and not flag_new:
                # this edge is deleted
                modified_buchi.markDeletedEdge(edge_index)

        else:
            # this is an external event
            if '.' in action:
                # it is not handled by old rule
                # is it handled by new rule? old rule?
                if new_rule:
                    flag_new, flag_old = False, False
                    if new_rule.trigger == action:
                        if isinstance(new_rule, EERule):
                             flag_new = True
                        elif isinstance(new_rule, ESERule):
                            if system.apSatisfied(new_rule.condition, src_field):
                                flag_new = True
                    if old_rule:
                        if old_rule.trigger == action:
                            if isinstance(old_rule, EERule):
                                 flag_old = True
                            elif isinstance(old_rule, ESERule):
                                if system.apSatisfied(old_rule.condition, src_field):
                                    flag_old = True

                    if flag_new and not flag_old:
                        # this is a new triggered edge, redirection
                        new_field = system.applyActionWithoutTriggering(new_rule.action, dst_field)

                        new_index_ts = ts.getIndex(new_field)  # which node it goes in ts

                        ap_list = ts.ap_list
                        new_label = system.getLabel(new_field)

                        var_dict = dict()
                        for ap, label in zip(ap_list, new_label):
                            var_dict[ap] = label
                        # use var_dict to calculate which edge it goes in ltl buchi automata
                        new_index_ltl = -1  # which node it goes in ltl
                        for e in buchi_ltl.edge_list:
                            if e.src == src_index_ltl:
                                if calculateBoolean(e.ap, var_dict):
                                    new_index_ltl = e.dst

                        src_final_index = pairs.index((src_index_ts, src_index_ltl))
                        new_final_index = pairs.index((new_index_ts, new_index_ltl))

                        modified_buchi.markDeletedEdge(edge_index)
                        modified_buchi.addNewEdge(src_final_index, new_final_index)

    modified_buchi.writeToGv(file_name, group)


def drawPatchList(system, ltl, patch_list, file_name):
    """
    given system and ltl property, draw graph representation of certain patches as png
    :param system: the smart home system
    :param ltl: ltl formula
    :param patch_list: the patch_list (FixPatch)
    :param file_name: file to be written
    :return:
    """
    ts = system.transition_system
    buchi_ts = Buchi.tsToGenBuchi(ts)
    buchi_ltl = Buchi.ltlToBuchi(ltl)
    (buchi_final, pairs) = Buchi.product(buchi_ts, buchi_ltl)
    group = [s2 for s1, s2 in pairs]

    modified_buchi = ModifiedBuchi(buchi_final)

    field_list = [state.field for state in ts.state_list]

    for edge_index, edge in enumerate(buchi_final.edge_list):
        src_index_ts = pairs[edge.src][0]
        dst_index_ts = pairs[edge.dst][0]
        src_index_ltl = pairs[edge.src][1]
        dst_index_ltl = pairs[edge.dst][1]
        src_field = field_list[src_index_ts]
        dst_field = field_list[dst_index_ts]
        action = _getAction(ts, src_field, dst_field)

        if '>' in action:
            # this is an action triggered by some old rule
            # should see if it's not triggered in new rule
            rule_dict = dict([(tap_name, translateTapToRule(tap)) for tap_name, tap in system.tap_dict.items()])
            old_rule_name = re.match(r'rule\((?P<rule_name>\w+)\)->[^ ]+', action).group('rule_name')
            old_rule = rule_dict[old_rule_name]
            for patch in patch_list:
                if patch.type == 'delete' and patch.rule_name == old_rule_name:
                    # then this edge is deleted
                    modified_buchi.markDeletedEdge(edge_index)
                    break
                if patch.type == 'change' and patch.rule_name == old_rule_name:
                    # then this rule is changed, need to see whether edge still triggered
                    new_rule = patch.rule
                    if isinstance(new_rule, ESERule):
                        orig_field = system.getLastStateField(new_rule.trigger, src_field)
                        if orig_field:
                            if not system.apSatisfied(new_rule.condition, orig_field):
                                # then this rule is not triggered anymore
                                modified_buchi.markDeletedEdge(edge_index)
                                break
        elif '.' in action:
            # this is an external event
            # should see if some new rules trigger this
            for patch in patch_list:
                new_rule = patch.rule
                add_edge_flag = 0
                if patch.type in ('add', 'change') and not system.isTriggeredState(dst_field) and\
                        new_rule.trigger == action:
                    if isinstance(new_rule, EERule):
                        # should add an new edge
                        add_edge_flag = 1
                    elif isinstance(new_rule, ESERule) and \
                            system.apSatisfied(new_rule.condition, src_field):
                        # should add an new edge
                        add_edge_flag = 1

                if add_edge_flag:
                    # this is an new edge, redirection
                    new_field = system.applyActionWithoutTriggering(new_rule.action, dst_field)

                    new_index_ts = ts.getIndex(new_field)  # which node it goes in ts

                    ap_list = ts.ap_list
                    new_label = system.getLabel(new_field)

                    var_dict = dict()
                    for ap, label in zip(ap_list, new_label):
                        var_dict[ap] = label
                    # use var_dict to calculate which edge it goes in ltl buchi automata
                    new_index_ltl = -1  # which node it goes in ltl
                    for e in buchi_ltl.edge_list:
                        if e.src == src_index_ltl:
                            if calculateBoolean(e.ap, var_dict):
                                new_index_ltl = e.dst

                    src_final_index = pairs.index((src_index_ts, src_index_ltl))
                    new_final_index = pairs.index((new_index_ts, new_index_ltl))

                    modified_buchi.markDeletedEdge(edge_index)
                    modified_buchi.addNewEdge(src_final_index, new_final_index)
                    break

    modified_buchi.writeToGv(file_name, group)
