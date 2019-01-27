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


import spot
import buddy
from autotapmc.ts.TransitionSystem import TS, State, Transition
import abc
import sys
import re

from autotapmc.utils.Parser import parse, Operator


ops = {
    '!': Operator('!', 1, 3, 0),
    '&': Operator('&', 2, 1, 0),
    '|': Operator('|', 2, 1, 0)
}

re_splitter = r'(\s+|\(|\)|\&|\||!)'

default_bdd_dict = spot.make_bdd_dict()


class BuchiState(object):
    """ Data structure to store information in a state-based (generalized) buchi automaton """
    def __init__(self, index, description, acc):
        self.index = index
        self.acc = acc
        self.description = description


class BuchiEdge(object):
    """ Data structure to store information in a state-based (generalized) buchi automaton """
    def __init__(self, src, dst, ap, description=''):
        self.src = src
        self.dst = dst
        self.ap = ap
        self.description = description


class BaseBuchi(object):
    """ Basic infrastructure for both GBA and BA """
    def __init__(self):
        self.state_dict = dict()
        self.edge_list = list()
        self.ap_list = list()
        self.init_state = 0
        self.acc_num = 0

    def setInitState(self, index):
        if index not in self.state_dict:
            raise Exception("State index %d invalid!" % index)
        self.init_state = index

    def getInitState(self):
        return self.init_state

    def addState(self, index, description, acc):
        self.state_dict[index] = BuchiState(index, description, acc)

    def setStateDescription(self, index, description):
        self.state_dict[index].description = description

    def addEdge(self, src, dst, ap, description=''):
        self.edge_list.append(BuchiEdge(src, dst, ap, description))

    def addAp(self, ap):
        if ap in self.ap_list:
            raise Exception("AP %s already exists!" % ap)
        self.ap_list.append(ap)

    def hasAp(self, ap):
        return ap in self.ap_list

    @abc.abstractmethod
    def getStateAcc(self, index):
        pass

    def log(self):
        for index, state in self.state_dict.items():
            print('state: %d, description: %s, accept: %s' %(index, state.description, str(state.acc)))
        for edge in self.edge_list:
            print('edge: %d->%d, ap: %s' % (edge.src, edge.dst, edge.ap))

    def toSpot(self, bdict=default_bdd_dict):
        """
        Translate a (generalized) buchi automaton into bdd in spot package
        :param bdict: the bdd_dict that the output automaton uses
        :return: an spot generalized buchi automaton
        """
        aut = spot.make_twa_graph(bdict)
        ap_list = dict()
        state_map = dict()

        for ap in self.ap_list:
            # if ap not in ['0', '1']:
            ap_list[ap] = buddy.bdd_ithvar(aut.register_ap(ap))

        aut.set_generalized_buchi(self.acc_num)

        aut.prop_state_acc(1)

        new_index = 0
        for index, state in self.state_dict.items():
            aut.new_state()
            state_map[index] = new_index
            new_index = new_index + 1

        aut.set_init_state(state_map[self.getInitState()])

        for edge in self.edge_list:
            acc = self.getStateAcc(edge.src)
            ap_calc_list = parse(edge.ap, ops, re_splitter)
            ap_stack = list()
            for token in ap_calc_list:
                if token == '!':
                    ap_stack[-1] = -ap_stack[-1]
                elif token == '&':
                    ap_stack[-2] = ap_stack[-1] & ap_stack[-2]
                    ap_stack.pop()
                elif token == '|':
                    ap_stack[-2] = ap_stack[-1] | ap_stack[-2]
                    ap_stack.pop()
                elif token in self.ap_list:
                    ap_stack.append(ap_list[token])
                elif token == '0':
                    ap_stack.append(buddy.bddfalse)
                elif token == '1':
                    ap_stack.append(buddy.bddtrue)
                else:
                    raise Exception('Unknown AP token %s in edge formula' % token)
            if len(ap_stack) != 1:
                raise Exception('Wrong edge AP formula format!')

            aut.new_edge(state_map[edge.src], state_map[edge.dst], ap_stack[0], acc)

        return aut, state_map

    def printToGv(self, group=None, only_action=False):
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
        for edge in self.edge_list:
            if only_action:
                ap_list = edge.ap.split(' & ')
                ap_list = [ap for ap in ap_list if ap.startswith('@')]
                fix_ap = ' & '.join(ap_list)
                print('\ts%d -> s%d [label=\"%s\"]' % (edge.src, edge.dst, fix_ap))
            else:
                fix_ap = edge.ap.replace('"', '') # ugly fix, there is '"' when "@" appears
                print('\ts%d -> s%d [label=\"%s\"]' % (edge.src, edge.dst, fix_ap))
        print('}')

    def writeToGv(self, filename, group=None, only_action=False):
        with open(filename, 'w') as fp:
            stdout = sys.stdout
            sys.stdout = fp
            self.printToGv(group, only_action)
            sys.stdout = stdout


class Buchi(BaseBuchi):
    """ In this class, State().acc store 1 (for acceptance states) or 0 (for non-acceptance states) """
    def __init__(self):
        super(Buchi, self).__init__()
        self.acc_num = 1

    def setStateAcc(self, index, acc):
        if index not in self.state_dict:
            raise Exception("State index %d invalid!" % index)
        self.state_dict[index].acc = acc

    def getAccStates(self):
        return [index for index, state in self.state_dict.items() if state.acc]

    def getStateAcc(self, index):
        return [0] if self.state_dict[index].acc else []


class GenBuchi(BaseBuchi):
    """ In this class, State().acc is a list of all acceptance sets a state is in """
    def __init__(self):
        super(GenBuchi, self).__init__()

    def setAccNum(self, acc_num):
        self.acc_num = acc_num

    def setStateAcc(self, index, acc):
        if index not in self.state_dict:
            raise Exception('State index %d invalid!' % index)
        for item in acc:
            if item >= self.acc_num:
                raise Exception('Acceptance set index should not be great or equal to %d!' % self.acc_num)
        self.state_dict[index].acc = acc

    def getStateAcc(self, index):
        return self.state_dict[index].acc

    def getAccStates(self, ac_index=None):
        if not ac_index:
            return [index for index, state in self.state_dict.items() if not state.acc]
        if ac_index >= self.acc_num:
            raise Exception('Acceptance set index should not be great or equal to %d!' % self.acc_num)
        return [index for index, state in self.state_dict.items() if ac_index in state.acc]


def tsToBuchi(ts):
    """
    Translate transition system (TS) into a buchi automaton. (all states are accepting)
    :param ts: transition system (TS)
    :return: a buchi automaton (Buchi)
    """
    state_list = ts.state_list
    field_list = [state.field for state in state_list]
    label_list = ts.label_list
    trans_list = ts.trans_list
    ap_list = ts.ap_list

    buchi = Buchi()

    for ap in ap_list:
        buchi.addAp(ap)

    for index, state in enumerate(state_list):
        buchi.addState(index, state.description, 1)

    buchi.setInitState(0)

    for trans in trans_list:
        index_src = field_list.index(trans.src_field)
        index_dst = field_list.index(trans.dest_field)
        description = trans.act

        if description.startswith('rule('):
            action_name = re.match(r'rule\(([\s\S]+)\)->(?P<action>[^ ]+)$', description).group('action')
        else:
            action_name = description
        action_name = '@' + action_name

        if not buchi.hasAp(action_name):
            buchi.addAp(action_name)

        label = list()
        for index, ap in enumerate(ap_list):
            entry = ap if label_list[index_src][index] else '!'+ap
            label.append(entry)

        ap = ' & '.join(label)
        ap = ap + ' & %s' % action_name
        buchi.addEdge(index_src, index_dst, ap, description)

    return buchi


def _recordSatisfy(action, record_exp):
    record_action_exp = record_exp[1:]
    if '<' in record_action_exp:
        record_var = record_action_exp.split('<')[0]
        record_val = record_action_exp.split('<')[1]
        if action.startswith(record_var + 'SetTo'):
            action_val = float(action[len(record_var) + 5:].replace('_', '.'))
            if action_val < float(record_val):
                return True
    elif '>' in record_action_exp:
        record_var = record_action_exp.split('>')[0]
        record_val = record_action_exp.split('>')[1]
        if action.startswith(record_var + 'SetTo'):
            action_val = float(action[len(record_var) + 5:].replace('_', '.'))
            if action_val > float(record_val):
                return True
    else:
        record_var = record_action_exp.split('=')[0]
        record_val = record_action_exp.split('=')[1]
        if record_val in ('true', 'false'):
            if action == record_var + 'Set' + record_val.capitalize():
                return True
        else:
            if action.startswith(record_var + 'SetTo'):
                action_val = float(action[len(record_var) + 5:].replace('_', '.'))
                if action_val == float(record_val):
                    return True
            else:
                action_val = action[len(record_var) + 3:]
                if action_val == record_val:
                    return True
    return False


def tsToGenBuchi(ts, record_exp_list=[]):
    """
    Translate transition system (TS) into a generalized buchi automaton. (no acceptance set)
    :param ts: transition system (TS)
    :return: a generalized buchi automaton (GenBuchi)
    """
    state_list = ts.state_list
    field_list = [state.field for state in state_list]
    label_list = ts.label_list
    trans_list = ts.trans_list
    ap_list = ts.ap_list

    buchi = GenBuchi()
    buchi.setAccNum(0)

    # action_set = set()
    # for trans in trans_list:
    #     description = trans.act
    #     if description.startswith('rule('):
    #         action_name = re.match(r'rule\((\w+)\)->(?P<action>[^ ]+)$', description).group('action')
    #     else:
    #         action_name = description
    #     action_name = '@' + action_name
    #     action_set.add(action_name)
    #     if not buchi.hasAp(action_name):
    #         buchi.addAp(action_name)

    for record_exp in record_exp_list:
        if not buchi.hasAp(record_exp):
            buchi.addAp(record_exp)

    for ap in ap_list:
        buchi.addAp(ap)

    for index, state in enumerate(state_list):
        buchi.addState(index, state.description, [])

    buchi.setInitState(0)

    for trans in trans_list:
        #index_src = field_list.index(trans.src_field)
        index_src = trans.src_index
        #index_dst = field_list.index(trans.dest_field)
        index_dst = trans.dst_index
        description = trans.act

        if description.startswith('rule('):
            action_name = re.match(r'rule\(([\s\S]+)\)->(?P<action>[^ ]+)$', description).group('action')
        else:
            action_name = description
        # action_name = '@' + action_name

        # other_action_set = set()
        # for act in action_set:
        #     if act != action_name:
        #         other_action_set.add('!' + act)
        # action_str = action_name + ' & ' + ' & '.join(other_action_set)
        #
        # if not buchi.hasAp(action_name):
        #     buchi.addAp(action_name)
        action_str = ' & '.join([record_exp if _recordSatisfy(action_name, record_exp) else '!' + record_exp
                                 for record_exp in record_exp_list])

        label = list()
        for index, ap in enumerate(ap_list):
            entry = ap if label_list[index_dst][index] else '!'+ap
            label.append(entry)

        ap = ' & '.join(label)
        if action_str:
            ap = ap + ' & %s' % action_str
        buchi.addEdge(index_src, index_dst, ap, description)

    # add edge to initial state
    buchi.addState(len(ts.state_list), 'init', [])
    buchi.setInitState(len(ts.state_list))

    for ii in range(ts.num_state):
        label = list()
        for index, ap in enumerate(ap_list):
            entry = ap if label_list[ii][index] else '!' + ap
            label.append(entry)
        for ap in record_exp_list:
            label.append('!'+ap)
        ap = ' & '.join(label)
        buchi.addEdge(len(ts.state_list), ii, ap, '')

    return buchi


def ltlToSpot(formula):
    """
    Translate LTL formula to Buchi Automaton with spot
    This function is a wrapper of spot translate function to merge the bdd_dict
    :param formula: input formula
    :return: spot buchi automaton
    """
    aut = spot.translate(formula, 'BA', dict=default_bdd_dict)
    return aut


def spotToBuchi(aut, state_map=None):
    """
    Translate spot representation back to Buchi object or GenBuchi object
    :param aut: input spot buchi automaton
    :return: a Buchi object or GenBuchi object
    """

    buchi = GenBuchi()
    buchi.setAccNum(aut.num_sets())

    for ap in list(aut.ap()):
        buchi.addAp(ap.to_str().replace('"', '')) # ugly fix, '"' might be used to bypass # and @

    init_index = aut.get_init_state_number()
    state_stack = [init_index]
    s_list = [init_index]

    if not state_map:
        buchi.addState(init_index, 'State %d' % init_index, [])
        buchi.setInitState(init_index)
    else:
        buchi.addState(state_map[init_index], 'State %d' % state_map[init_index], [])
        buchi.setInitState(state_map[init_index])

    while state_stack:
        index_src = state_stack.pop()
        for edge in aut.out(index_src):
            if edge.dst not in s_list:
                s_list.append(edge.dst)
                state_stack.append(edge.dst)
                if not state_map:
                    buchi.addState(edge.dst, 'State %d' % edge.dst, [])
                else:
                    buchi.addState(state_map[edge.dst], 'State %d' % state_map[edge.dst], [])

            acc = list()
            for index_set in range(aut.num_sets()):
                if edge.acc.has(index_set):
                    acc.append(index_set)
            if not state_map:
                buchi.setStateAcc(edge.src, acc)
            else:
                buchi.setStateAcc(state_map[edge.src], acc)
            cond_formula = spot.bdd_to_formula(edge.cond, aut.get_dict())
            cond_formula_str = cond_formula.to_str().replace('"', '') # ugly fix, when '@' appears there is '"'
            if not state_map:
                buchi.addEdge(edge.src, edge.dst, cond_formula_str, description=str(edge.cond))
            else:
                buchi.addEdge(state_map[edge.src], state_map[edge.dst],
                              cond_formula_str, description=str(edge.cond))

    return buchi


def ltlToBuchi(formula):
    """
    Translate LTL formula to Buchi Automaton (Buchi)
    This function is a wrapper of ltlToSpot
    :param formula: input formula
    :return: Buchi object
    """
    aut = ltlToSpot(formula)
    buchi = spotToBuchi(aut)
    buchi.addAp('_triggered')
    for index in range(len(buchi.edge_list)):
        buchi.edge_list[index].ap = '(%s) & !_triggered' % buchi.edge_list[index].ap
    for index, state in buchi.state_dict.items():
        buchi.addEdge(index, index, '_triggered', 'looping back')
    return buchi


def product(buchi1, buchi2):
    """
    wrapper of spot product function
    :param buchi1: left buchi
    :param buchi2: right buchi
    :return: result, the product of buchi1 and buchi2; pairs: index -> (index1, index2) the origin of states
    """
    (aut1, map1) = buchi1.toSpot()
    (aut2, map2) = buchi2.toSpot()
    aut = spot.product(aut1, aut2)

    # print(aut1.to_str())
    # print(aut2.to_str())
    # print(aut.to_str())

    result = spotToBuchi(aut)
    pairs_spot = aut.get_product_states()

    pairs = [(map1[s1], map2[s2]) for s1, s2 in pairs_spot]
    for index, pair in enumerate(pairs):
        result.setStateDescription(index, '%d, %d' % pair)

    return result, pairs
