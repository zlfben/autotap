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


from .Build import tapFormat, generateCriticalValue, generateTimeExp, getChannelList, ltlFormat, generateChannelDict, textToformula
from .Fix import _fixPreProcessing, _getAction, _getLTLReq
import autotapmc.buchi.Buchi as Buchi


def evaluateRules(tap_list, ltl):
    pass


def checkTapListBehavior(tap_list, system, src_field, action):
    for tap in tap_list:
        if tap.trigger == action and system.tapConditionSatisfied(tap, src_field):
            # TODO: what does timing do in this case
            return tap.action
        else:
            continue
    return None


def compareRules(tap_list1, tap_list2, ltl, template_dict):
    """
    To show the differences between tap_list1 and tap_list2
    :param tap_list1:
    :param tap_list2:
    :param ltl:
    :param template_dict:
    :return:
    """
    if ltl == None:
        ltl_formula = '!(0)'
    else:
        ltl_formula = ltl

    crit_value_dict = generateCriticalValue(ltl_formula, tap_list1 + tap_list2)
    exp_t_list, record_exp_list = generateTimeExp(ltl_formula, tap_list1 + tap_list2)
    channel_name_list, cap_name_list, tap_list = getChannelList(ltl_formula, tap_list1 + tap_list2)

    tap_list1 = tapFormat(tap_list1, crit_value_dict)
    tap_list2 = tapFormat(tap_list2, crit_value_dict)

    new_ltl = ltlFormat(ltl_formula)
    # stage 4: generate system
    channel_dict = generateChannelDict(channel_name_list, crit_value_dict,
                                       {}, cap_name_list, template_dict)
    system = _fixPreProcessing(
        channel_dict=channel_dict,
        tap_dict={},
        template_numeric_dict=crit_value_dict,
        timing_exp_list=exp_t_list
    )

    ts = system.transition_system
    buchi_ts = Buchi.tsToGenBuchi(ts, record_exp_list)
    buchi_ltl = Buchi.ltlToBuchi(new_ltl)
    (buchi_final, pairs) = Buchi.product(buchi_ts, buchi_ltl)
    field_list = [state.field for state in ts.state_list]

    result = list()
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

                beh1 = checkTapListBehavior(tap_list1, system, src_field, action)
                beh2 = checkTapListBehavior(tap_list2, system, src_field, action)

                condition = [ap for ap in system.getApList(src_field)
                             if '@' not in ap and 'trigger' not in ap]
                condition = condition + ['!' + ap for ap in system.getAllAp()
                                         if '@' not in ap and 'trigger' not in ap and
                                         ap not in condition]

                if beh1 != beh2:
                    result.append((action, condition, (beh1, beh2)))

            except IndexError:
                # if this happen, this means that the system has already been in wrong state from the initial state
                raise Exception(
                    'The property is violated in the initial state, please try a different initial state')

    new_result = list()
    for action, condition, beh_tup in result:
        new_condition = [textToformula(cond) for cond in condition]
        new_beh_0 = None if not beh_tup[0] else textToformula(beh_tup[0])
        new_beh_1 = None if not beh_tup[1] else textToformula(beh_tup[1])
        new_result.append((
            textToformula(action),
            new_condition,
            (new_beh_0, new_beh_1)
        ))
    return new_result


def mergeRules(rule_list):
    """
    give a set of tap rules, based on their action/triggerring event, merge their state constraints
    to generate a minimum set of rules
    :param rule_list: the list of Rule objects
    :return: the merged list of Rule objects
    """
    pass
