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
from autotapmc.utils.Boolean import calculateBoolean
from autotapmc.utils.Algorithm import hittingSet, qmAlgorithm, qmPreProcess
from autotapmc.model.Tap import Tap
from autotapmc.model.IoTSystem import generateIoTSystem
import re
import copy
import itertools
from .Build import generateChannelDict, ltlFormat, tapFormat, \
    getChannelList, generateTimeExp, generateCriticalValue, textToformula, namedTapFormat
import autotapmc.channels.template.Evaluation as DeviceList


class Patch(object):
    def __init__(self, _type='add', tap_name='', tap=Tap()):
        self.type = _type
        self.tap_name = tap_name
        self.tap = tap

    def log(self):
        print('type = %s' % self.type)
        print('tap_name = %s' % self.tap_name)
        print('tap.trigger = %s' % str(self.tap.trigger))
        print('tap.condition = %s' % str(self.tap.condition))
        print('tap.action = %s' % str(self.tap.action))


class BadEdge(object):
    def __init__(self, src_index_ts=0, dst_index_ts=0, src_index_ltl=0, dst_index_ltl=0,
                 src_field=list(), dst_field=list(), action='', ltl_req='true'):
        self.src_index_ts = src_index_ts
        self.dst_index_ts = dst_index_ts
        self.src_index_ltl = src_index_ltl
        self.dst_index_ltl = dst_index_ltl
        self.src_field = src_field
        self.dst_field = dst_field
        self.action = action
        self.ltl_req = ltl_req


def _getLTLReq(buchi_ltl, src_index, dst_index):
    """
    should return a boolean expression: from src_index to accepting states, discard '!_triggered'
    :param buchi_ltl:
    :param src_index:
    :param dst_index:
    :return:
    """
    dangerous_condition_list = list()
    for edge in buchi_ltl.edge_list:
        if edge.src == src_index and buchi_ltl.getStateAcc(edge.dst):
            dangerous_condition_list.append(edge.ap)
            # return edge.description
    if dangerous_condition_list:
        return ' | '.join(['(%s)' % cond[:-14] for cond in dangerous_condition_list])
    else:
        return '0'



def _getAction(ts, src_index, dst_index):
    tran = [t for t in ts.trans_list if t.src_index == src_index and t.dst_index == dst_index]
    assert len(tran) == 1
    return tran[0].act


def _fixActionRule(rule_name, bad_edge_list, safe_state_list, system, only_print=False):
    """
    fix a bad edge caused by rule action
    :param rule_name: the rule to be fixed
    :param bad_edge_list: all bad edges
    :param safe_state_list: list of fields of safe states
    :param system: the IoTSystem
    :return: [[patches], [patches], ...], each 'patches' represents a possible fix
    """
    ts = system.transition_system

    bad_edge_src_field_list = [edge.src_field for edge in bad_edge_list]

    rule = system.tap_dict[rule_name]
    trigger = rule.trigger
    action = rule.action

    result_patch_list = list()
    result_patch_list.append(Patch('delete', rule_name))

    for trans in ts.trans_list:
        dst_field = ts.state_list[trans.dst_index].field
        src_field = ts.state_list[trans.src_index].field
        if trans.act == trigger and system.isTapTriggered(dst_field, rule_name):
            # this is an edge that will trigger the tap rule
            if dst_field not in bad_edge_src_field_list and dst_field in safe_state_list:
                # need to keep this condition
                label = system.getLabel(src_field)
                ap_list = [ap if label[index] else '!' + ap for index, ap in enumerate(ts.ap_list) if '.' in ap]

                hitting_set_list = list()
                for t in ts.trans_list:
                    t_src_field = ts.state_list[t.src_index].field
                    t_dst_field = ts.state_list[t.dst_index].field
                    if t.act == trigger and t_src_field != src_field and t_dst_field in safe_state_list:
                        l = system.getLabel(t_src_field)
                        conflict_ap_list = ['!'+ap if l[index] else ap
                                            for index, ap in enumerate(ts.ap_list) if '.' in ap]
                        hitting_set_list.append(conflict_ap_list)

                # print('ap_list = %s' % ap_list)
                # print('hitting_set = %s' % str(hitting_set_list))
                condition = hittingSet(ap_list, hitting_set_list)
                result_patch_list.append(Patch('add', '', Tap(action, trigger, condition)))

    if only_print:
        print('--- Fix rule edge ---')
        for patch in result_patch_list:
            print(patch.log())
        print('--- End ---')
    else:
        return [result_patch_list]


def _fixEventEdge(edge, system, only_print=False):
    """
    fix a bad edge caused by external event
    :param edge: the bad edge
    :param system: the IoTSystem
    :return: [[patches], [patches], ...], each 'patches' represents a possible fix
    """
    ts = system.transition_system

    # First: find all possible actions
    action_list = list()
    for action, dst_field in system.getAction(edge.dst_field, False):
        # after the external event, what action can be triggered?
        dst_label = system.getLabel(dst_field)
        ap_dict = dict()
        for ap, value in zip(ts.ap_list, dst_label):
            ap_dict[ap] = value
        if not calculateBoolean(edge.ltl_req, ap_dict):
            # is good for redirecting, doesn't violate ltl by entering accepting cluster
            action_list.append(action)

    # Second: get the correct trigger action
    trigger = edge.action

    # Third: find minimum condition that only cover the source state of the edge using hitting set
    src_label = ts.label_list[edge.src_index_ts]
    src_ap_list = [(ap if src_label[index] else '!'+ap) for index, ap in enumerate(ts.ap_list) if '.' in ap]

    hitting_set_list = list()
    for trans in ts.trans_list:
        if trans.act == edge.action and ts.state_list[trans.src_index].field != edge.src_field:
            label = system.getLabel(ts.state_list[trans.src_index].field)
            conflict_ap_list = ['!'+ap if label[index] else ap for index, ap in enumerate(ts.ap_list) if '.' in ap]
            hitting_set_list.append(conflict_ap_list)

    condition = hittingSet(src_ap_list, hitting_set_list)

    if only_print:
        print('trigger: %s, condition: %s' % (trigger, str(condition)))
    else:
    # return all possible patches
        result = list()
        for action in action_list:
            new_tap = Tap(action, trigger, condition)
            result.append([Patch('add', '', new_tap)])

        return result


def generateFixForSafety(system, ltl):
    """
    Given a ltl property for a transition system, generate new tap rules to fix them
    :param system: iot system
    :param ltl: the property to be fixed
    :return: a set of new tap rule? new system? list
    """
    result = list()

    ts = system.transition_system
    buchi_ts = Buchi.tsToGenBuchi(ts)
    buchi_ltl = Buchi.ltlToBuchi(ltl)
    (buchi_final, pairs) = Buchi.product(buchi_ts, buchi_ltl)

    field_list = [state.field for state in ts.state_list]
    bad_edges = list()

    # generate all edges to be fixed
    for edge in buchi_final.edge_list:
        if buchi_final.getStateAcc(edge.dst) and not buchi_final.getStateAcc(edge.src):
            try:
                src_index_ts = pairs[edge.src][0]
                dst_index_ts = pairs[edge.dst][0]
                if ts.num_state == src_index_ts:
                    # this is the initial node, skip
                    continue
                src_index_ltl = pairs[edge.src][1]
                dst_index_ltl = pairs[edge.dst][1]
                src_field = field_list[src_index_ts]
                dst_field = field_list[dst_index_ts]
                action = _getAction(ts, src_index_ts, dst_index_ts)
                ltl_req = _getLTLReq(buchi_ltl, src_index_ltl, dst_index_ltl)
                bad_edges.append(BadEdge(src_index_ts, dst_index_ts, src_index_ltl, dst_index_ltl,
                                         src_field, dst_field, action, ltl_req))
            except IndexError:
                # if this happen, this means that the system has already been in wrong state from the initial state
                raise Exception('The property is violated in the initial state, please try a different initial state')

    # find all states in safe cluster
    safe_states_list = buchi_final.getAccStates(None)
    safe_states_list = [field_list[pairs[index][0]] if pairs[index][0] < len(field_list) else []
                        for index in safe_states_list]

    bad_event_edge = list()
    bad_action_edge = list()
    bad_rule = list()

    for edge in bad_edges:
        if '->' in edge.action:
            # this bad edge is an action triggered by a tap rule
            # fix_list1 = list(_fixEdgeByDeleting(edge, system))
            # fix_list2 = list(_fixEdgeByAddingConstraints(edge, system))
            # result.append(fix_list1 + fix_list2)
            rule_name = re.match(r'rule\((?P<rule_name>\w+)\)->[^ ]+', edge.action).group('rule_name')
            bad_action_edge.append(edge)
            if rule_name not in bad_rule:
                bad_rule.append(rule_name)
            # result.append(_fixActionEdge(edge, system))
        else:
            # this bad edge is because of external events
            bad_event_edge.append(edge)
            # result.append(_fixEventEdge(edge, system))

    for edge in bad_event_edge:
        result.append(_fixEventEdge(edge, system))

    for rule_name in bad_rule:
        result.append(_fixActionRule(rule_name, bad_action_edge, safe_states_list, system))


    # return list(itertools.product(*result))
    return result


##########################################  New fix from this line on
def _generatePattern(crit_value_list, event_list, template):
    """
    return a pattern from a event_list
    :param crit_value_list: list of numeric
    :param event_list: list of string
    :param template: string
    :return:
    """
    crit_value_list = sorted(crit_value_list)
    prefix_crit = crit_value_list[:-1]
    suffix_crit = crit_value_list[1:]
    mid_crit = [(v1+v2)/2 for v1, v2 in zip(suffix_crit, prefix_crit)]
    enhanced_crit_value_list = sorted(mid_crit + [crit_value_list[0]-1, crit_value_list[-1]+1] + crit_value_list)
    enhanced_crit_value_str_list = [str(v).replace('.', '_') for v in enhanced_crit_value_list]
    event_set_str_list = [event[len(template) + len('SetTo'):] for event in event_list]
    hit_pattern = ''.join([str(int(value in event_set_str_list)) for value in enhanced_crit_value_str_list])
    return hit_pattern


def _triggerTemplateMatch(trigger, template_list):
    template_match = re.match(r'^(?P<template>[\w.]+)(?P<operator>[><=])(?P<value>[0-9.]+)', trigger)
    if not template_match:
        return None
    else:
        if template_match.group('template') in template_list:
            return template_match
        else:
            return None


def _getEnhancedNumericList(critical_value_list):
    critical_value_list = sorted(critical_value_list)
    prefix_crit = critical_value_list[:-1]
    suffix_crit = critical_value_list[1:]
    mid_crit = [(v1 + v2) / 2 for v1, v2 in zip(suffix_crit, prefix_crit)]
    enhanced_crit_value_list = sorted(mid_crit + [critical_value_list[0] - 1,
                                                  critical_value_list[-1] + 1] + critical_value_list)
    return enhanced_crit_value_list


def _fixPreProcessing(channel_dict, tap_dict, template_numeric_dict=None, timing_exp_list=None):
    """
    after applying this, there is no template rule anymore, and every tap rule only causes one edge
    :param system:
    :param template_numeric_dict:
    :return:
    """
    # break down templates
    if not template_numeric_dict:
        template_numeric_dict = dict()
    if not timing_exp_list:
        timing_exp_list = list()
    for tap_name, tap in tap_dict.items():
        template_match = _triggerTemplateMatch(tap.trigger, list(template_numeric_dict.keys()))
        if template_match:
            del tap_dict[tap_name]
            template = template_match.group('template')
            operator = template_match.group('operator')
            value = float(template_match.group('value'))
            for crit_value in _getEnhancedNumericList(template_numeric_dict[template]):
                if (crit_value > value and operator == '>') or \
                        (crit_value < value and operator == '<') or (crit_value == value and operator == '='):
                    new_tap_name = tap_name + str(crit_value).replace('.', '_')
                    new_trigger = template + 'SetTo' + str(crit_value).replace('.', '_')
                    tap_dict[new_tap_name] = Tap(tap.action, new_trigger, tap.condition)

    _channel_dict = copy.deepcopy(channel_dict)
    result = generateIoTSystem('TempSystem', _channel_dict, tap_dict, timing_exp_list)

    # break down every rule
    tap_index_dict = {key: 0 for key, tap in result.tap_dict.items()}
    new_tap_dict = dict()

    ts = result.transition_system

    for transition in ts.trans_list:
        if '->' in transition.act:

            # add a new rule handling this
            rule_name = re.match(r'rule\((?P<rule_name>[\s\S]+)\)->[^ ]+', transition.act).group('rule_name')
            prev_index = ts.getPrevIndex(transition.src_index)
            prev_field = ts.getField(prev_index)
            ap_list = [ap for ap in result.getApList(prev_field)
                       if '@' not in ap and 'trigger' not in ap and ap not in result.tap_dict]
            ap_list = ap_list + ['!' + ap for ap in result.getAllAp()
                                 if '@' not in ap and 'trigger' not in ap and
                                 ap not in ap_list and ap not in result.tap_dict]
            new_rule_name = rule_name + '_' + str(tap_index_dict[rule_name])
            action = result.tap_dict[rule_name].action
            trigger = result.tap_dict[rule_name].trigger
            tap_index_dict[rule_name] = tap_index_dict[rule_name] + 1
            new_tap_dict[new_rule_name] = Tap(action, trigger, ap_list)

    _channel_dict = copy.deepcopy(channel_dict)
    result = generateIoTSystem('systemAfterPreProcess', _channel_dict, new_tap_dict, timing_exp_list)
    ts = result.transition_system
    # put system back to initial state
    result._restoreFromStateVector(ts.getField(0))
    return result


def _getBadEdges(system, ltl, record_exp_list=[]):
    ts = system.transition_system
    buchi_ts = Buchi.tsToGenBuchi(ts, record_exp_list)
    buchi_ltl = Buchi.ltlToBuchi(ltl)
    (buchi_final, pairs) = Buchi.product(buchi_ts, buchi_ltl)

    field_list = [state.field for state in ts.state_list]
    # Stage 1: generate all bad edges
    bad_edges = list()
    other_edges = list()
    for edge in buchi_final.edge_list:
        if not buchi_final.getStateAcc(edge.src):
            try:
                src_index_ts = pairs[edge.src][0]
                dst_index_ts = pairs[edge.dst][0]
                if ts.num_state == src_index_ts:
                    # this is the initial node, skip
                    continue
                src_index_ltl = pairs[edge.src][1]
                dst_index_ltl = pairs[edge.dst][1]
                src_field = field_list[src_index_ts]
                dst_field = field_list[dst_index_ts]
                action = _getAction(ts, src_index_ts, dst_index_ts)
                ltl_req = _getLTLReq(buchi_ltl, src_index_ltl, dst_index_ltl)
                if buchi_final.getStateAcc(edge.dst):
                    bad_edges.append(BadEdge(src_index_ts, dst_index_ts, src_index_ltl, dst_index_ltl,
                                             src_field, dst_field, action, ltl_req))
                else:
                    other_edges.append(BadEdge(src_index_ts, dst_index_ts, src_index_ltl, dst_index_ltl,
                                               src_field, dst_field, action, ltl_req))
            except IndexError:
                # if this happen, this means that the system has already been in wrong state from the initial state
                raise Exception(
                    'The property is violated in the initial state, please try a different initial state')

    return bad_edges, other_edges


def _fixRuleEdges(system, ltl, record_exp_list):
    """
    a pre-requirement it that each tap rule in the system only triggers one rule edge
    :param system:
    :param ltl:
    :param template_numeric_dict:
    :return:
    """
    name = 'systemAfterRuleEdgeFixing'
    channel_dict = {key: copy.deepcopy(value) for key, value in system.channel_dict.items()}
    timing_exp_list = [key[0] for key in system.timer_type1_dict.items()] + \
                      [key[0] for key in system.timer_type2_dict.items()]
    while True:
        # find all bad edges
        bad_edges, other_edges = _getBadEdges(system, ltl, record_exp_list)
        bad_edges = [edge for edge in bad_edges if '->' in edge.action]

        if not bad_edges:
            # terminate, no bad edges caused by rule
            break
        else:
            # fix all rule edges
            tap_dict = system.tap_dict
            for edge in bad_edges:
                rule_name = re.match(r'rule\((?P<rule_name>[\s\S]+)\)->[^ ]+', edge.action).group('rule_name')
                if rule_name in tap_dict:
                    del tap_dict[rule_name]

            _channel_dict = copy.deepcopy(channel_dict)
            system = generateIoTSystem(name, _channel_dict, tap_dict, timing_exp_list)

    return system


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
    return False


def _fixConditionGenerator(system, ltl, record_exp_list, include_orig=False):
    """
    generate a set of bad edge conditions (trigger, condition, possible_actions_list)
    another return value is a set of all other edge conditions in safety or boundary [(trigger, condition)] ..
    :param system:
    :param ltl:
    :return:
    """
    bad_edges, other_edges = _getBadEdges(system, ltl, record_exp_list)
    buchi_ltl = Buchi.ltlToBuchi(ltl)

    result = list()
    others = list()
    for bad_edge in bad_edges:
        ap_list = [ap for ap in system.getApList(bad_edge.src_field) if '@' not in ap and 'trigger' not in ap]
        ap_list = ap_list + ['!' + ap for ap in system.getAllAp()
                             if '@' not in ap and 'trigger' not in ap and
                             ap not in ap_list and ap not in system.tap_dict]
        condition = ' & '.join(ap_list)
        trigger = bad_edge.action
        action_list = list()
        for action, dst_field in system.getAction(src_field=bad_edge.dst_field, ext=False):
            label = system.getLabel(dst_field)
            ap_dict = dict()
            for value, ap in zip(label, system.transition_system.ap_list):
                ap_dict[ap] = value
            ap_dict = {**ap_dict, **{key: _recordSatisfy(action, key) for key in record_exp_list}}
            if not calculateBoolean(_getLTLReq(buchi_ltl, bad_edge.src_index_ltl, bad_edge.dst_index_ltl), ap_dict):
                action_list.append(action)

        result.append((trigger, condition, action_list))

    if include_orig:
        for k, tap in system.tap_dict.items():
            condition = ' & '.join(tap.condition)
            trigger = tap.trigger
            action_list = [tap.action]
            result.append((trigger, condition, action_list))
        for edge in other_edges:
            # should add every edge that doesn't trigger any rule
            if not system.isTriggeredState(edge.dst_field):
                ap_list = [ap for ap in system.getApList(edge.src_field) if '@' not in ap and 'trigger' not in ap]
                ap_list = ap_list + ['!' + ap for ap in system.getAllAp()
                                     if '@' not in ap and 'trigger' not in ap and
                                     ap not in ap_list and ap not in system.tap_dict]
                condition = ' & '.join(ap_list)
                trigger = edge.action

                others.append((trigger, condition))
    else:
        for edge in other_edges:
            ap_list = [ap for ap in system.getApList(edge.src_field) if '@' not in ap and 'trigger' not in ap]
            ap_list = ap_list + ['!' + ap for ap in system.getAllAp()
                                 if '@' not in ap and 'trigger' not in ap and
                                 ap not in ap_list and ap not in system.tap_dict]
            condition = ' & '.join(ap_list)
            trigger = edge.action

            others.append((trigger, condition))

    return result, others


def _getPatternList(trigger_condition_t, template_numeric_dict=None):
    """
    generate a list with tuples: (template, condition, pattern, action_list)
    :param trigger_condition_t:
    :param template_numeric_dict:
    :return: template_t = [(template, condition, pattern, action_list), ...]
            other_t = [(trigger, condition, action_list), ...]
    """
    if not template_numeric_dict:
        template_numeric_dict = dict()

    condition_template_dict = dict()
    other_t = list()

    for trigger, condition, action_list in trigger_condition_t:
        potential_template = re.match(r'^(?P<template>[\w.]+)SetTo', trigger)
        if potential_template and potential_template.group('template') in template_numeric_dict:
            if (potential_template.group('template'), condition) in condition_template_dict:
                condition_template_dict[(potential_template.group('template'), condition)].append(
                    (trigger, action_list))
            else:
                condition_template_dict[(potential_template.group('template'), condition)] = [(trigger, action_list)]
        else:
            other_t.append((trigger, condition, action_list))

    template_t = list()

    for condition_template, trigger_action_list in condition_template_dict.items():
        template = condition_template[0]
        condition = condition_template[1]
        trigger_list = [trigger for trigger, action_list in trigger_action_list]
        action_list_l = [set(action_list) for trigger, action_list in trigger_action_list]

        pattern = _generatePattern(template_numeric_dict[template], trigger_list, template)
        action_list = list(set.intersection(*action_list_l))
        template_t.append((template, condition, pattern, action_list))

    return template_t, other_t


def _generateTriggerFromPattern(pattern, template, template_numeric_dict):
    crit_value_list = sorted(template_numeric_dict[template])
    prefix_crit = crit_value_list[:-1]
    suffix_crit = crit_value_list[1:]
    mid_crit = [(v1 + v2) / 2 for v1, v2 in zip(suffix_crit, prefix_crit)]
    enhanced_crit_value_list = sorted(mid_crit + [crit_value_list[0] - 1, crit_value_list[-1] + 1] + crit_value_list)
    enhanced_crit_value_str_list = [str(v).replace('.', '_') for v in enhanced_crit_value_list]
    hit_pattern_list = [m.group(0) for m in re.finditer(r'(\d)\1*', pattern)]

    cover_list = list()
    start_index = 0
    for hit_pattern in hit_pattern_list:
        if '1' in hit_pattern:
            cover_list.append((start_index, start_index + len(hit_pattern)))
        start_index = start_index + len(hit_pattern)

    statement_list = list()
    for cover in cover_list:
        if cover[0] != 0 and cover[1] != len(pattern):
            # raise Exception('this pattern %s is not supported' % pattern)
            # ugly fix:
            if cover[1] % 2 != 0:
                # non-critical value, "<"
                upper_str = '<' + enhanced_crit_value_str_list[cover[1]].replace('_', '.')
            else:
                # critical value, "<="
                upper_str = '<=' + enhanced_crit_value_str_list[cover[1]-1].replace('_', '.')
            if cover[0] % 2 == 0:
                # non-critical value, ">"
                lower_str = enhanced_crit_value_str_list[cover[0]-1].replace('_', '.') + '<'
            else:
                # critical value, ">="
                lower_str = enhanced_crit_value_str_list[cover[0]].replace('_', '.') + '<='
            statement_list.append('%s%s%s' % (lower_str, template, upper_str))
        elif cover[0] == 0 and cover[1] != len(pattern):
            if cover[1] % 2 != 0:
                # non-critical value, "<"
                statement_list.append('%s<%s' % (template, enhanced_crit_value_str_list[cover[1]].replace('_', '.')))
            else:
                # critical value, "<="
                statement_list.append('%s<=%s' % (template, enhanced_crit_value_str_list[cover[1]-1].replace('_', '.')))
                # statement_list.append('%s=%s' % (template, enhanced_crit_value_str_list[cover[1]-1].replace('_', '.')))
        elif cover[0] != 0 and cover[1] == len(pattern):
            if cover[0] % 2 == 0:
                # non-critical value, ">"
                statement_list.append('%s>%s' % (template, enhanced_crit_value_str_list[cover[0]-1].replace('_', '.')))
            else:
                # critical value, ">="
                statement_list.append('%s>=%s' % (template, enhanced_crit_value_str_list[cover[0]].replace('_', '.')))
                # statement_list.append('%s=%s' % (template, enhanced_crit_value_str_list[cover[0]].replace('_', '.')))
        elif cover[0] == 0 and cover[1] == len(pattern):
            statement_list.append('%s changed' % template)

    return statement_list


def _satisfyPattern(template, trigger, pattern, crit_value_list):
    crit_value_list = sorted(crit_value_list)
    prefix_crit = crit_value_list[:-1]
    suffix_crit = crit_value_list[1:]
    mid_crit = [(v1 + v2) / 2 for v1, v2 in zip(suffix_crit, prefix_crit)]
    enhanced_crit_value_list = sorted(mid_crit + [crit_value_list[0] - 1, crit_value_list[-1] + 1] + crit_value_list)
    enhanced_crit_value_str_list = [str(v).replace('.', '_') for v in enhanced_crit_value_list]

    if trigger.startswith(template + 'SetTo'):
        index = enhanced_crit_value_str_list.index(trigger[len(template)+5:])
        if pattern[index]:
            return True

    return False


def _fixPatternEdge(template_t, complete_edge_t, template_numeric_dict=None):
    if not template_numeric_dict:
        template_numeric_dict = dict()

    hier_dict = dict()
    # template -> pattern -> condition
    for tup in template_t:
        template = tup[0]
        condition = tup[1]
        pattern = tup[2]
        action_list = tup[3]

        if template not in hier_dict:
            hier_dict[template] = {pattern: [(condition, action_list)]}
        else:
            if pattern not in hier_dict[template]:
                hier_dict[template][pattern] = [(condition, action_list)]
            else:
                hier_dict[template][pattern].append((condition, action_list))

    result = list()

    for template, pattern_dict in hier_dict.items():
        for pattern, condition_action_list in pattern_dict.items():
            condition_list = [condition for condition, action_list in condition_action_list]
            action_list_l = [set(action_list) for condition, action_list in condition_action_list]
            # find trigger
            trigger_list = _generateTriggerFromPattern(pattern, template, template_numeric_dict)

            # find a set of conditions
            target_condition = condition_list
            zero_condition = list()

            for trig, cond in complete_edge_t:
                if cond not in target_condition \
                        and _satisfyPattern(template, trig, pattern, template_numeric_dict[template]):
                    zero_condition.append(cond)
            zero_condition = list(set(zero_condition))

            # for pat, con in pattern_dict.items():
            #     if pat != pattern:
            #         zero_condition = zero_condition + con
            target_condition, zero_condition = qmPreProcess(target_condition, zero_condition)
            final_condition = qmAlgorithm(target_condition, zero_condition)

            # find the public actions shared by all entries in this field
            action_list = list(set.intersection(*action_list_l))

            # trigger_list x final_condition
            patch_without_action = list(itertools.product(trigger_list, final_condition))
            patch_with_action = [(trigger, condition, action_list) for trigger, condition in patch_without_action]
            result = result + patch_with_action

    return result


def _fixRegualarEdge(other_t, complete_edge_t):
    hier_dict = dict()
    for tup in other_t:
        trigger = tup[0]
        condition = tup[1]
        action_list = tup[2]

        if trigger in hier_dict:
            hier_dict[trigger].append((condition, action_list))
        else:
            hier_dict[trigger] = [(condition, action_list)]

    result = list()
    for trigger, condition_action_list in hier_dict.items():
        # action should be the action accepted in every state
        action_list_l = [set(act_l) for cond, act_l in condition_action_list]
        action_list = list(set.intersection(*action_list_l))

        # conditions should be found by qm algorithm
        # ones: target conditions
        # zeros: conditions with the same event in the safety cluster (including the boundary)
        # dc: everything else
        ones = [cond for cond, act_l in condition_action_list]
        zeros = [cond for trig, cond in complete_edge_t if trig == trigger and cond not in ones]
        zeros = list(set(zeros))
        ones, zeros = qmPreProcess(ones, zeros)
        final_condition = qmAlgorithm(ones, zeros)

        patch_with_action = [(trigger, cond, action_list) for cond in final_condition]
        result = result + patch_with_action

    return result


def generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=vars(DeviceList)):
    # stage 0: remove all duplicated taps
    tap_list = list(set(tap_list))
    # stage 1: find all critical value
    crit_value_dict = generateCriticalValue(ltl, tap_list)
    # stage 2: find all timing expressions
    exp_t_list, record_exp_list = generateTimeExp(ltl, tap_list)
    # stage 3: generate channels
    channel_name_list, cap_name_list, tap_list = getChannelList(ltl, tap_list)
    # stage 4: change tap, ltl format
    new_tap_list = tapFormat(tap_list, crit_value_dict)
    new_ltl = ltlFormat(ltl)
    # stage 4: generate system
    tap_dict = {'rule'+str(key): value for key, value in zip(range(len(new_tap_list)), new_tap_list)}
    channel_dict = generateChannelDict(channel_name_list, crit_value_dict,
                                       init_value_dict, cap_name_list, template_dict)
    system = _fixPreProcessing(
        channel_dict=channel_dict,
        tap_dict=tap_dict,
        template_numeric_dict=crit_value_dict,
        timing_exp_list=exp_t_list
    )

    # stage 5: fix
    system = _fixRuleEdges(system, new_ltl, record_exp_list)
    edge_t, complete_edge_t = _fixConditionGenerator(system, new_ltl, record_exp_list, include_orig=True)
    template_t, other_t = _getPatternList(edge_t, template_numeric_dict=crit_value_dict)
    result_1 = _fixPatternEdge(template_t, complete_edge_t, crit_value_dict)
    result_2 = _fixRegualarEdge(other_t, complete_edge_t)

    # preserved_taps = [Tap(action=[tap.action], trigger=tap.trigger, condition=tap.condition)
    #                   for key, tap in system.tap_dict.items()]
    result = result_1 + result_2
    result_taps = [Tap(action=act, trigger=trig, condition=(cond.split(' & ') if cond else list()))
                   for trig, cond, act in result]
    # taps = preserved_taps + result_taps
    for tap in result_taps:
        tap.trigger = textToformula(tap.trigger)
        tap.condition = [textToformula(cond) for cond in tap.condition]
        tap.action = [textToformula(act) for act in tap.action]

    return result_taps


def generateNamedFix(ltl, tap_dict, init_value_dict={}, template_dict=vars(DeviceList)):
    # stage 0: remove all duplicated taps
    tap_dict_inv = {v: k for k, v in tap_dict.items()}
    tap_dict = {v: k for k, v in tap_dict_inv.items()}
    tap_list = [v for k, v in tap_dict.items()]
    # stage 1: find all critical value
    crit_value_dict = generateCriticalValue(ltl, tap_list)
    # stage 2: find all timing expressions
    exp_t_list, record_exp_list = generateTimeExp(ltl, tap_list)
    # stage 3: generate channels
    channel_name_list, cap_name_list, tap_list = getChannelList(ltl, tap_list)
    # stage 4: change tap, ltl format
    new_tap_dict = namedTapFormat(tap_dict, crit_value_dict)
    new_ltl = ltlFormat(ltl)
    # stage 4: generate system
    tap_dict = new_tap_dict
    channel_dict = generateChannelDict(channel_name_list, crit_value_dict,
                                       init_value_dict, cap_name_list, template_dict)
    system = _fixPreProcessing(
        channel_dict=channel_dict,
        tap_dict=tap_dict,
        template_numeric_dict=crit_value_dict,
        timing_exp_list=exp_t_list
    )

    # stage 5: fix
    system = _fixRuleEdges(system, new_ltl, record_exp_list)
    edge_t, complete_edge_t = _fixConditionGenerator(system, new_ltl, record_exp_list, include_orig=True)
    template_t, other_t = _getPatternList(edge_t, template_numeric_dict=crit_value_dict)
    result_1 = _fixPatternEdge(template_t, complete_edge_t, crit_value_dict)
    result_2 = _fixRegualarEdge(other_t, complete_edge_t)

    result = result_1 + result_2
    result_taps = [Tap(action=act, trigger=trig, condition=(cond.split(' & ') if cond else list()))
                   for trig, cond, act in result]

    # should be a mark phase marking the pre-existing rules
    result_tap_label = ['*'] * len(result_taps)
    for o_tap_name, o_tap in tap_dict.items():
        index = 0
        for tap_index, tap in zip(range(len(result_taps)), result_taps):
            if result_tap_label[tap_index] == '*' and o_tap.trigger == tap.trigger and [o_tap.action] == tap.action:
                result_tap_label[tap_index] = '%s.%d' % (o_tap_name, index)
                index = index + 1

    for tap in result_taps:
        tap.trigger = textToformula(tap.trigger)
        tap.condition = [textToformula(cond) for cond in tap.condition]
        tap.action = [textToformula(act) for act in tap.action]

    new_index = 0
    for ri in range(len(result_tap_label)):
        if result_tap_label[ri] == '*':
            result_tap_label[ri] = '*.%d' % new_index
            new_index = new_index + 1

    return result_taps, result_tap_label
