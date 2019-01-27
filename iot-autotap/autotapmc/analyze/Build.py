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


from autotapmc.utils.Parser import Operator, parse
import re
import copy
from autotapmc.model.Tap import Tap
from autotapmc.model.Template import generateDctForBool, generateDctForNumeric, generateDctForSet
from autotapmc.model.Channel import Channel, MetaChannel


def _getValueDict(formula):
    value_dict = dict()
    re_splitter = r'(\s+|\(|\)|\&|\||!|<|>|=|F|G|U|W|\#|\*|X|@)'
    ops = {
        '!': Operator('!', 1, 4, 1),
        '&': Operator('&', 2, 2, 0),
        '|': Operator('|', 2, 2, 0),
        '<': Operator('<', 2, 6, 0),
        '>': Operator('>', 2, 6, 0),
        '=': Operator('=', 2, 6, 0),
        'G': Operator('G', 1, 3, 1),
        'F': Operator('F', 1, 3, 1),
        'U': Operator('U', 2, 3, 0),
        'X': Operator('X', 1, 3, 1),
        'W': Operator('W', 2, 3, 0),
        '#': Operator('#', 2, 5, 0),
        '*': Operator('*', 2, 5, 0),
        '@': Operator('@', 1, 5, 1)
    }
    post_exp = parse(formula, ops, re_splitter)
    stack = list()
    for token in post_exp:
        if token not in ops:
            stack.append(token)
        else:
            if ops[token].n_args == 1:
                stack[-1] = token + str(stack[-1])
            elif ops[token].n_args == 2:
                if token in ('<', '>', '='):
                    if stack[-2] not in value_dict:
                        value_dict[stack[-2]] = [stack[-1]]
                    elif stack[-1] not in value_dict[stack[-2]]:
                        value_dict[stack[-2]].append(stack[-1])
                stack[-2] = stack[-2] + token + stack[-1]
                stack.pop()

    return value_dict


def _getTimeExpList(formula):
    time_exp_list = list()
    recorded_list = list()
    re_splitter = r'(\s+|\(|\)|\&|\||!|<|>|=|F|G|U|W|\#|\*|X|@)'
    ops = {
        '!': Operator('!', 1, 4, 1),
        '&': Operator('&', 2, 2, 0),
        '|': Operator('|', 2, 2, 0),
        '<': Operator('<', 2, 6, 0),
        '>': Operator('>', 2, 6, 0),
        '=': Operator('=', 2, 6, 0),
        'G': Operator('G', 1, 3, 1),
        'F': Operator('F', 1, 3, 1),
        'U': Operator('U', 2, 3, 0),
        'X': Operator('X', 1, 3, 1),
        'W': Operator('W', 2, 3, 0),
        '#': Operator('#', 2, 5, 0),
        '*': Operator('*', 2, 5, 0),
        '@': Operator('@', 1, 5, 1)
    }
    post_exp = parse(formula, ops, re_splitter)
    stack = list()
    for token in post_exp:
        if token not in ops:
            stack.append(token)
        else:
            if ops[token].n_args == 1:
                stack[-1] = token + str(stack[-1])
                if token == '@':
                    recorded_list.append(stack[-1])
            elif ops[token].n_args == 2:
                stack[-2] = stack[-2] + token + stack[-1]
                if token in ('#', '*'):
                    time_exp_list.append(stack[-2])
                stack.pop()

    return list(set(time_exp_list)), list(set(recorded_list))


def generateCriticalValue(ltl, tap_list):
    def isfloat(s):
        try:
            float(s)
            return True
        except ValueError:
            return False

    crit_value_dict = dict()

    value_dict = _getValueDict(ltl)
    for key, val_l in value_dict.items():
        if key in crit_value_dict:
            crit_value_dict[key] = list(set(crit_value_dict[key] + val_l))
        else:
            crit_value_dict[key] = val_l

    for tap in tap_list:
        for cond in tap.condition:
            value_dict = _getValueDict(cond)
            for key, val_l in value_dict.items():
                if key in crit_value_dict:
                    crit_value_dict[key] = list(set(crit_value_dict[key]+val_l))
                else:
                    crit_value_dict[key] = val_l

    crit_value_dict = {key: sorted([int(v) for v in val_l])
                       for key, val_l in crit_value_dict.items() if all([isfloat(v) for v in val_l])}

    enhanced_value_dict = dict()
    for var_name, crit_list in crit_value_dict.items():
        left_list = crit_list[:-1]
        right_list = crit_list[1:]
        mid_list = [(v1+v2)/2 for v1, v2 in zip(left_list, right_list)]
        enhanced_value_dict[var_name] = sorted(crit_list + mid_list)
        enhanced_value_dict[var_name] = [min(enhanced_value_dict[var_name])-1] + \
                                        enhanced_value_dict[var_name] + \
                                        [max(enhanced_value_dict[var_name])+1]

    enhanced_value_dict = {key: [float(val) for val in val_l] for key, val_l in enhanced_value_dict.items()}

    for tap in tap_list:
        if tap.trigger.startswith('tick'):
            trigger = tap.trigger[5:-1]
            if '#' in trigger:
                trigger = trigger.split('#')[1]
            else:
                trigger = trigger.split('*')[1]
        else:
            trigger = tap.trigger
        value_dict = _getValueDict(trigger)
        for key, val_l in value_dict.items():
            if all([isfloat(v) for v in val_l]):
                for val in val_l:
                    if key not in crit_value_dict:
                        crit_value_dict[key] = [int(val)]
                    elif int(val) not in crit_value_dict[key]:
                        crit_value_dict[key].append(int(val))

        value_dict = _getValueDict(tap.action)
        for key, val_l in value_dict.items():
            if all([isfloat(v) for v in val_l]):
                for val in val_l:
                    if key not in enhanced_value_dict:
                        crit_value_dict[key] = [int(val)]
                    elif float(val) not in enhanced_value_dict[key]:
                        crit_value_dict[key].append(int(val))

    for key, val_l in crit_value_dict.items():
        crit_value_dict[key] = sorted(list(set(val_l)))

    return crit_value_dict


def generateTimeExp(ltl, tap_list):
    time_exp_list = list()
    t_exp_list, recorded_list = _getTimeExpList(ltl)
    time_exp_list = list(set(time_exp_list + t_exp_list))

    for tap in tap_list:
        trigger_match = re.match(r'^tick\[(?P<time_exp>[()\w<>=#*]+)\]$', tap.trigger)
        if trigger_match:
            time_exp_raw = trigger_match.group('time_exp')
            t_exp_list = _getTimeExpList(time_exp_raw)
            time_exp_list = list(set(time_exp_list + t_exp_list))

        for cond in tap.condition:
            if '*' in cond or '#' in cond:
                t_exp_list, recored_exp_list = _getTimeExpList(cond)
                time_exp_list = list(set(time_exp_list + t_exp_list))

    return time_exp_list, recorded_list


def getChannelList(ltl, tap_list):
    channel_list = list()
    re_splitter = r'(\s+|\(|\)|\&|\||!|<|>|=|F|G|U|W|\#|\*|X|@)'
    ops = {
        '!': Operator('!', 1, 4, 1),
        '&': Operator('&', 2, 2, 0),
        '|': Operator('|', 2, 2, 0),
        '<': Operator('<', 2, 6, 0),
        '>': Operator('>', 2, 6, 0),
        '=': Operator('=', 2, 6, 0),
        'G': Operator('G', 1, 3, 1),
        'F': Operator('F', 1, 3, 1),
        'U': Operator('U', 2, 3, 0),
        'X': Operator('X', 1, 3, 1),
        'W': Operator('W', 2, 3, 0),
        '#': Operator('#', 2, 5, 0),
        '*': Operator('*', 2, 5, 0),
        '@': Operator('@', 1, 5, 1)
    }
    ltl_post_exp = parse(ltl, ops, re_splitter)
    cap_list = [token for token in ltl_post_exp if token not in ops and '.' in token and not token[0].isnumeric()]
    channel_list = list(set(channel_list + [cap.split('.')[0] for cap in cap_list]))

    tap_channel_list = list()
    tap_cap_list = list()
    for tap in tap_list:
        time_match = re.match(r'^tick\[(?P<time_exp>[()\w<>=#*]+)\]$', tap.trigger)
        if time_match:
            trigger = time_match.group('time_exp')
        else:
            trigger = tap.trigger

        trigger_post_exp = parse(trigger, ops, re_splitter)
        trigger_channel_l = list({token.split('.')[0]
                                  for token in trigger_post_exp
                                  if token not in ops and '.' in token and not token[0].isnumeric()})
        trigger_cap_l = list({token
                              for token in trigger_post_exp
                              if token not in ops and '.' in token and not token[0].isnumeric()})

        action_post_exp = parse(tap.action, ops, re_splitter)
        action_channel_l = list({token.split('.')[0]
                                 for token in action_post_exp
                                 if token not in ops and '.' in token and not token[0].isnumeric()})
        action_cap_l = list({token
                            for token in action_post_exp
                            if token not in ops and '.' in token and not token[0].isnumeric()})

        for cond in tap.condition:
            cond_post_exp = parse(cond, ops, re_splitter)
            cond_channel_l = list({token.split('.')[0]
                                   for token in cond_post_exp
                                   if token not in ops and '.' in token and not token[0].isnumeric()})
            cond_cap_l = list({token
                              for token in cond_post_exp
                              if token not in ops and '.' in token and not token[0].isnumeric()})
            trigger_channel_l = list(set(trigger_channel_l + cond_channel_l))
            trigger_cap_l = list(set(trigger_cap_l + cond_cap_l))

        tap_channel_list.append((trigger_channel_l, action_channel_l, tap_list.index(tap)))
        tap_cap_list.append((trigger_cap_l, action_cap_l, tap_list.index(tap)))

    # TODO: should be careful about this change, seems dangerous to me

    # channel_to_search = copy.deepcopy(channel_list)
    # new_tap_list = list()
    # while channel_to_search:
    #     ch = channel_to_search.pop()
    #     for trigger_channel_l, action_channel_l, tap_index in tap_channel_list:
    #         if ch in action_channel_l:
    #             new_tap_list.append(tap_index)
    #             for ch_t in trigger_channel_l:
    #                 if ch_t not in channel_list:
    #                     channel_list.append(ch_t)
    #                     channel_to_search.append(ch_t)

    cap_to_search = copy.deepcopy(cap_list)
    new_tap_list = list()
    while cap_to_search:
        cap = cap_to_search.pop()
        for trigger_cap_l, action_cap_l, tap_index in tap_cap_list:
            if cap in action_cap_l:
                new_tap_list.append(tap_index)
                for cap_t in trigger_cap_l:
                    if cap_t not in cap_list:
                        cap_list.append(cap_t)
                        cap_to_search.append(cap_t)

    new_tap_list = list(set(new_tap_list))
    new_tap_list = [tap_list[index] for index in new_tap_list]
    channel_list = [cap_name.split('.')[0] for cap_name in cap_list]

    return list(set(channel_list)), list(set(cap_list)), new_tap_list


def textToformula(text_statement):
    if text_statement.startswith('tick'):
        return 'tick[%s]' % textToformula(text_statement[5:-1])
    else:
        if '=' in text_statement or '<' in text_statement or '>' in text_statement:
            return text_statement
        else:
            if text_statement[0] == '!':
                neg = True
                text_statement = text_statement[1:]
            else:
                neg = False

            dev = text_statement.split('.')[0]
            func = text_statement.split('.')[1]

            if 'SetTo' in func:
                var_name = func.split('SetTo')[0]
                var_value = func.split('SetTo')[1].replace('_', '.')
                return ('%s.%s=%s' if not neg else '!%s.%s=%s') % (dev, var_name, var_value)
            elif 'Set' in func:
                var_name = func.split('Set')[0]
                var_value = func.split('Set')[1]
                if var_value in ['True', 'False']:
                    return ('%s.%s=true' if (not neg) == (var_value == 'True') else '%s.%s=false') % (dev, var_name)
                else:
                    return ('%s.%s=%s' if not neg else '!%s.%s=%s') % (dev, var_name, var_value)
            elif 'GreaterThan' in func:
                var_name = func.split('GreaterThan')[0]
                var_value = func.split('GreaterThan')[1].replace('_', '.')
                return ('%s.%s>%s' if not neg else '!%s.%s>%s') % (dev, var_name, var_value)
            elif 'LessThan' in func:
                var_name = func.split('LessThan')[0]
                var_value = func.split('LessThan')[1].replace('_', '.')
                return ('%s.%s<%s' if not neg else '!%s.%s<%s') % (dev, var_name, var_value)
            elif 'Is' in func:
                var_name = func.split('Is')[0]
                var_value = func.split('Is')[1]
                if var_value in ['True', 'False']:
                    return ('%s.%s=true' if (not neg) == (var_value == 'True') else '%s.%s=false') % (dev, var_name)
                else:
                    return ('%s.%s=%s' if not neg else '!%s.%s=%s') % (dev, var_name, var_value)
            else:
                raise Exception('unable to parse %s into formula' % text_statement)


def tapFormat(tap_list, critical_value_dict):
    def isfloat(s):
        try:
            float(s)
            return True
        except ValueError:
            return False

    new_tap_list = list()
    re_splitter = r'(\s+|\(|\)|\&|\||!|<|>|=|F|G|U|W|\#|\*|X|@)'
    ops = {
        '!': Operator('!', 1, 4, 1),
        '&': Operator('&', 2, 2, 0),
        '|': Operator('|', 2, 2, 0),
        '<': Operator('<', 2, 6, 0),
        '>': Operator('>', 2, 6, 0),
        '=': Operator('=', 2, 6, 0),
        'G': Operator('G', 1, 3, 1),
        'F': Operator('F', 1, 3, 1),
        'U': Operator('U', 2, 3, 0),
        'X': Operator('X', 1, 3, 1),
        'W': Operator('W', 2, 3, 0),
        '#': Operator('#', 2, 5, 0),
        '*': Operator('*', 2, 5, 0),
        '@': Operator('@', 1, 5, 1)
    }
    for tap in tap_list:
        new_trigger = list()
        if not re.match(r'^tick\[(?P<time_exp>[()\w<>=#*.]+)\]$', tap.trigger):
            trigger_post_exp = parse(tap.trigger, ops, re_splitter)
            if trigger_post_exp[-1] == '<':
                value = int(trigger_post_exp[-2])
                crit_list = critical_value_dict[trigger_post_exp[-3]]
                left_list = crit_list[:-1]
                right_list = crit_list[1:]
                mid_list = [(v1+v2)/2 for v1, v2 in zip(left_list, right_list)]
                enhanced_list = crit_list + mid_list + [min(crit_list)-1, max(crit_list)+1]
                sat_list = [v for v in enhanced_list if v < value]
                for sat_val in sat_list:
                    new_trigger.append(trigger_post_exp[-3]+'SetTo'+str(sat_val).replace('.', '_'))
            elif trigger_post_exp[-1] == '>':
                value = int(trigger_post_exp[-2])
                crit_list = critical_value_dict[trigger_post_exp[-3]]
                left_list = crit_list[:-1]
                right_list = crit_list[1:]
                mid_list = [(v1 + v2) / 2 for v1, v2 in zip(left_list, right_list)]
                enhanced_list = crit_list + mid_list + [min(crit_list)-1, max(crit_list)+1]
                sat_list = [v for v in enhanced_list if v > value]
                for sat_val in sat_list:
                    new_trigger.append(trigger_post_exp[-3] + 'SetTo' + str(sat_val).replace('.', '_'))
            elif trigger_post_exp[-1] == '=':
                if not isfloat(trigger_post_exp[-2]):
                    new_trigger.append(trigger_post_exp[-3]+'Set'+trigger_post_exp[-2].capitalize())
                else:
                    new_trigger.append(trigger_post_exp[-3]+'SetTo'+trigger_post_exp[-2].replace('.', '_'))
        else:
            new_trigger.append(tap.trigger)

        condition = list()
        for cond in tap.condition:
            if '#' in cond or '*' in cond:
                condition.append(cond)
            else:
                cond_post_exp = parse(cond, ops, re_splitter)
                if cond_post_exp[-1] == '=':
                    if cond_post_exp[-2] == 'true':
                        condition.append(cond_post_exp[-3]+'IsTrue')
                    elif cond_post_exp[-2] == 'false':
                        condition.append('!'+cond_post_exp[-3]+'IsTrue')
                    elif isfloat(cond_post_exp[-2]):
                        condition.append('!'+cond_post_exp[-3]+'GreaterThan'+cond_post_exp[-2].replace('.', '_'))
                        condition.append('!'+cond_post_exp[-3]+'LessThan'+cond_post_exp[-2].replace('.', '_'))
                    else:
                        # should be 'set'
                        condition.append(cond_post_exp[-3] + 'Is' + cond_post_exp[2].capitalize())
                elif cond_post_exp[-1] == '<':
                    condition.append(cond_post_exp[-3] + 'LessThan' + cond_post_exp[-2].replace('.', '_'))
                elif cond_post_exp[-1] == '>':
                    condition.append(cond_post_exp[-3] + 'GreaterThan' + cond_post_exp[-2].replace('.', '_'))

        act_post_exp = parse(tap.action, ops, re_splitter)
        if not isfloat(act_post_exp[-2]):
            action = act_post_exp[-3] + 'Set' + act_post_exp[-2].capitalize()
        else:
            action = act_post_exp[-3] + 'SetTo' + act_post_exp[-2].replace('.', '_')

        for trigger in new_trigger:
            new_tap_list.append(Tap(action, trigger, condition))

    return new_tap_list


def namedTapFormat(tap_dict, critical_value_dict):
    def isfloat(s):
        try:
            float(s)
            return True
        except ValueError:
            return False

    new_tap_dict = dict()
    re_splitter = r'(\s+|\(|\)|\&|\||!|<|>|=|F|G|U|W|\#|\*|X|@)'
    ops = {
        '!': Operator('!', 1, 4, 1),
        '&': Operator('&', 2, 2, 0),
        '|': Operator('|', 2, 2, 0),
        '<': Operator('<', 2, 6, 0),
        '>': Operator('>', 2, 6, 0),
        '=': Operator('=', 2, 6, 0),
        'G': Operator('G', 1, 3, 1),
        'F': Operator('F', 1, 3, 1),
        'U': Operator('U', 2, 3, 0),
        'X': Operator('X', 1, 3, 1),
        'W': Operator('W', 2, 3, 0),
        '#': Operator('#', 2, 5, 0),
        '*': Operator('*', 2, 5, 0),
        '@': Operator('@', 1, 5, 1)
    }
    for tap_name, tap in tap_dict.items():
        new_trigger = list()
        if not re.match(r'^tick\[(?P<time_exp>[()\w<>=#*.]+)\]$', tap.trigger):
            trigger_post_exp = parse(tap.trigger, ops, re_splitter)
            if trigger_post_exp[-1] == '<':
                value = int(trigger_post_exp[-2])
                crit_list = critical_value_dict[trigger_post_exp[-3]]
                left_list = crit_list[:-1]
                right_list = crit_list[1:]
                mid_list = [(v1+v2)/2 for v1, v2 in zip(left_list, right_list)]
                enhanced_list = crit_list + mid_list + [min(crit_list)-1, max(crit_list)+1]
                sat_list = [v for v in enhanced_list if v < value]
                for sat_val in sat_list:
                    new_trigger.append(trigger_post_exp[-3]+'SetTo'+str(sat_val).replace('.', '_'))
            elif trigger_post_exp[-1] == '>':
                value = int(trigger_post_exp[-2])
                crit_list = critical_value_dict[trigger_post_exp[-3]]
                left_list = crit_list[:-1]
                right_list = crit_list[1:]
                mid_list = [(v1 + v2) / 2 for v1, v2 in zip(left_list, right_list)]
                enhanced_list = crit_list + mid_list + [min(crit_list)-1, max(crit_list)+1]
                sat_list = [v for v in enhanced_list if v > value]
                for sat_val in sat_list:
                    new_trigger.append(trigger_post_exp[-3] + 'SetTo' + str(sat_val).replace('.', '_'))
            elif trigger_post_exp[-1] == '=':
                if not isfloat(trigger_post_exp[-2]):
                    new_trigger.append(trigger_post_exp[-3]+'Set'+trigger_post_exp[-2].capitalize())
                else:
                    new_trigger.append(trigger_post_exp[-3]+'SetTo'+trigger_post_exp[-2].replace('.', '_'))
        else:
            new_trigger.append(tap.trigger)

        condition = list()
        for cond in tap.condition:
            if '#' in cond or '*' in cond:
                condition.append(cond)
            else:
                cond_post_exp = parse(cond, ops, re_splitter)
                if cond_post_exp[-1] == '=':
                    if cond_post_exp[-2] == 'true':
                        condition.append(cond_post_exp[-3]+'IsTrue')
                    elif cond_post_exp[-2] == 'false':
                        condition.append('!'+cond_post_exp[-3]+'IsTrue')
                    elif isfloat(cond_post_exp[-2]):
                        condition.append('!'+cond_post_exp[-3]+'GreaterThan'+cond_post_exp[-2].replace('.', '_'))
                        condition.append('!'+cond_post_exp[-3]+'LessThan'+cond_post_exp[-2].replace('.', '_'))
                    else:
                        # should be 'set'
                        condition.append(cond_post_exp[-3] + 'Is' + cond_post_exp[2].capitalize())
                elif cond_post_exp[-1] == '<':
                    condition.append(cond_post_exp[-3] + 'LessThan' + cond_post_exp[-2].replace('.', '_'))
                elif cond_post_exp[-1] == '>':
                    condition.append(cond_post_exp[-3] + 'GreaterThan' + cond_post_exp[-2].replace('.', '_'))

        act_post_exp = parse(tap.action, ops, re_splitter)
        if not isfloat(act_post_exp[-2]):
            action = act_post_exp[-3] + 'Set' + act_post_exp[-2].capitalize()
        else:
            action = act_post_exp[-3] + 'SetTo' + act_post_exp[-2].replace('.', '_')

        for trigger, new_tap_index in zip(new_trigger, range(len(new_trigger))):
            new_tap_dict['%s.%d' % (tap_name, new_tap_index)] = Tap(action, trigger, condition)

    return new_tap_dict


def ltlFormat(ltl):
    def isfloat(s):
        try:
            float(s)
            return True
        except ValueError:
            return False

    re_splitter = r'(\s+|\(|\)|\&|\||!|<|>|=|F|G|U|W|\#|\*|X|@)'
    ops = {
        '!': Operator('!', 1, 4, 1),
        '&': Operator('&', 2, 2, 0),
        '|': Operator('|', 2, 2, 0),
        '<': Operator('<', 2, 6, 0),
        '>': Operator('>', 2, 6, 0),
        '=': Operator('=', 2, 6, 0),
        'G': Operator('G', 1, 3, 1),
        'F': Operator('F', 1, 3, 1),
        'U': Operator('U', 2, 3, 0),
        'X': Operator('X', 1, 3, 1),
        'W': Operator('W', 2, 3, 0),
        '#': Operator('#', 2, 5, 0),
        '*': Operator('*', 2, 5, 0),
        '@': Operator('@', 1, 5, 1)
    }
    time_record_exp_dict = dict()
    time_record_prefix = '________________'
    ltl_post_exp = parse(ltl, ops, re_splitter)
    stack = list()
    for token in ltl_post_exp:
        if token not in ops:
            stack.append(token)
        else:
            if token in ('#', '*'):
                time_record_exp_dict[time_record_prefix+str(len(time_record_exp_dict))] = stack[-2]+token+stack[-1]
                stack[-2] = time_record_prefix+str(len(time_record_exp_dict)-1)
                stack.pop()
            elif token == '@':
                time_record_exp_dict[time_record_prefix+str(len(time_record_exp_dict))] = token + stack[-1]
                stack[-1] = time_record_prefix+str(len(time_record_exp_dict)-1)
            else:
                if ops[token].n_args == 2:
                    if token in ('<', '=', '>'):
                        stack[-2] = stack[-2] + token + stack[-1]
                    else:
                        stack[-2] = '(' + stack[-2] + token + stack[-1] + ')'
                    stack.pop()
                elif ops[token].n_args == 1:
                    stack[-1] = token + '(' + stack[-1] + ')'

    ltl_post_exp = parse(stack[0], ops, re_splitter)
    stack = list()
    for token in ltl_post_exp:
        if token not in ops:
            stack.append(token)
        else:
            if ops[token].n_args == 2:
                if token == '<':
                    stack[-2] = stack[-2] + 'LessThan' + stack[-1].replace('.', '_')
                elif token == '>':
                    stack[-2] = stack[-2] + 'GreaterThan' + stack[-1].replace('.', '_')
                elif token == '=':
                    if stack[-1] == 'true':
                        stack[-2] = stack[-2] + 'IsTrue'
                    elif stack[-1] == 'false':
                        stack[-2] = '!' + stack[-2] + 'IsTrue'
                    elif not isfloat(stack[-1]):
                        # should be set
                        stack[-2] = stack[-2] + 'Is' + stack[-1].capitalize()
                    else:
                        exp1 = '!' + stack[-2] + 'LessThan' + stack[-1].replace('.', '_')
                        exp2 = '!' + stack[-2] + 'GreaterThan' + stack[-1].replace('.', '_')
                        stack[-2] = '(' + exp1 + ' & ' + exp2 + ')'
                else:
                    stack[-2] = '(' + stack[-2] + ' ' + token + ' ' + stack[-1] + ')'
                stack.pop()
            elif ops[token].n_args == 1:
                stack[-1] = token + '(' + stack[-1] + ')'

    for key, time_exp in time_record_exp_dict.items():
        stack[0] = stack[0].replace(key, '"%s"' % time_exp)

    return stack[0]


def generateChannelDict(channel_name_list, crit_value_dict, init_value_dict, cap_name_list, template_dict):
    channel_dict = dict()
    for channel_name in channel_name_list:
        channel_template = template_dict[channel_name]
        template_list = list()
        dct = dict()
        name = channel_name.capitalize()
        parent = (Channel,)

        for cap_name, cap_type in channel_template.items():
            if '%s.%s' % (channel_name, cap_name) in cap_name_list:
                ext = 'ext' in cap_type
                new_dct = dict()
                if 'bool' in cap_type:
                    full_cap_name = '%s.%s' % (channel_name, cap_name)
                    if full_cap_name in init_value_dict:
                        new_dct = generateDctForBool(cap_name, ext, init_value_dict[full_cap_name])
                    else:
                        new_dct = generateDctForBool(cap_name, ext)
                elif 'numeric' in cap_type:
                    full_cap_name = '%s.%s' % (channel_name, cap_name)
                    if full_cap_name in init_value_dict:
                        new_dct = generateDctForNumeric(cap_name, crit_value_dict[full_cap_name], ext,
                                                        init_value_dict[full_cap_name])
                    else:
                        new_dct = generateDctForNumeric(cap_name, crit_value_dict[full_cap_name], ext)
                elif 'set' in cap_type:
                    full_cap_name = '%s.%s' % (channel_name, cap_name)
                    value_list = re.match(r'^.*\[(?P<vl>.*)\].*$', cap_type).group('vl')
                    value_list = re.split(r'\W+', value_list)
                    value_list = list(filter(None, value_list))
                    if full_cap_name in init_value_dict:
                        new_dct = generateDctForSet(cap_name, ext, value_list, init_value_dict[full_cap_name])
                    else:
                        new_dct = generateDctForSet(cap_name, ext, value_list)
                dct = {**dct, **new_dct}

        MyChannel = MetaChannel(name, parent, dct)
        channel_dict[channel_name] = MyChannel()

    return channel_dict
