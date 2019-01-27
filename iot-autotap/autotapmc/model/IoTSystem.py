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


import autotapmc.ts.TransitionSystem as TransitionSystem
import autotapmc.model.Channel as Channel
import autotapmc.model.Tap as Tap
import copy
import re
import autotapmc.utils.Parser as Parser


class MetaIoTSystem(type):
    def __new__(cls, name, parents, dct):
        channel_dict = dict()
        tap_dict = dict()
        # timer_dict = dict()
        # assertion_dict = dict()
        trigger_dict = dict()

        for key, value in dct.items():
            if not key.startswith('__'):
                if isinstance(value, Tap.TapWrapper): # handle tap programs
                    tap_dict[key] = value.toTap()
                    trigger_dict[key] = 0
                elif isinstance(value, Tap.Tap): # handle tap programs
                    tap_dict[key] = value
                    trigger_dict[key] = 0
                elif isinstance(value, Channel.Channel):  # handle channels
                    channel_dict[key] = value

        dct['trigger_dict'] = trigger_dict
        dct['tap_dict'] = tap_dict
        # dct['timer_dict'] = timer_dict
        dct['channel_dict'] = channel_dict

        return super().__new__(cls, name, parents, dct)


class IoTSystem(metaclass=MetaIoTSystem):
    def __init__(self, timing_exp_list=[]):
        # different types of timers should be treated differently
        # time#exp: exp is an event, once exp happens, set timer to time, decrease when tick until reaching zero
        # time*exp: once exp happens, set timer to time, decrease when tick until reaching zero, once !exp happens, set
        #           to -1, here exp is a state
        self.timer_type1_dict = dict()
        self.timer_type1_time_dict = dict()
        self.timer_type1_event_l_dict = dict()
        self.timer_type2_dict = dict()
        self.timer_type2_time_dict = dict()
        self.timer_type2_ap_l_dict = dict()

        for t_exp in timing_exp_list:
            if '#' in t_exp:
                # type 1, exp is a set of action
                time_val = int(t_exp.split('#')[0])
                exp = t_exp.split('#')[1]
                self.timer_type1_time_dict[t_exp] = time_val
                self.timer_type1_event_l_dict[t_exp] = list()
                for ch_name, ch in self.channel_dict.items():
                    for act_name, act in ch.action_dict.items():
                        act_match_numeric = re.match(r'^(?P<var>\w+)SetTo(?P<val>\w+)$', act_name)
                        act_match_bool = re.match(r'^(?P<var>\w+)Set(?P<val>True|False)$', act_name)
                        if act_match_numeric:
                            var_name = '%s.%s' % (ch_name, act_match_numeric.group('var'))
                            value = act_match_numeric.group('val').replace('_', '.')
                            if var_name in exp:
                                exp_t = exp.replace(var_name, value)
                                if Parser.calcIneq(exp_t):
                                    self.timer_type1_event_l_dict[t_exp].append('%s.%s' % (ch_name, act_name))
                        elif act_match_bool:
                            var_name = '%s.%s' % (ch_name, act_match_bool.group('var'))
                            value = act_match_bool.group('val').lower()
                            if var_name in exp:
                                exp_t = exp.replace(var_name, value)
                                if Parser.calcIneq(exp_t):
                                    self.timer_type1_event_l_dict[t_exp].append('%s.%s' % (ch_name, act_name))
                self.timer_type1_dict[t_exp] = 0
            elif '*' in t_exp:
                # type 2
                time_val = int(t_exp.split('*')[0])
                exp = t_exp.split('*')[1]
                self.timer_type2_time_dict[t_exp] = time_val
                self.timer_type2_ap_l_dict[t_exp] = list()

                if '<' in exp:
                    var_val = exp.split('<')
                    self.timer_type2_ap_l_dict[t_exp].append(
                        '%sLessThan%s' % (var_val[0], var_val[1].replace('.', '_')))
                elif '>' in exp:
                    var_val = exp.split('>')
                    self.timer_type2_ap_l_dict[t_exp].append(
                        '%sGreaterThan%s' % (var_val[0], var_val[1].replace('.', '_')))
                elif '=' in exp:
                    var_val = exp.split('=')
                    if var_val[1] == 'true':
                        self.timer_type2_ap_l_dict[t_exp].append('%sIsTrue' % (var_val[0]))
                    elif var_val[1] == 'false':
                        self.timer_type2_ap_l_dict[t_exp].append('!%sIsTrue' % (var_val[0]))
                    else:
                        self.timer_type2_ap_l_dict[t_exp].append(
                            '!%sLessThan%s' % (var_val[0], var_val[1].replace('.', '_')))
                        self.timer_type2_ap_l_dict[t_exp].append(
                            '!%sGreaterThan%s' % (var_val[0], var_val[1].replace('.', '_')))

                if all([self._conditionSatisfied(ap) for ap in self.timer_type2_ap_l_dict[t_exp]]):
                    self.timer_type2_dict[t_exp] = time_val
                else:
                    self.timer_type2_dict[t_exp] = -1

        self._createTS()

    # Restoring current status
    def _restoreFromStateVector(self, field):
        keys = [tup[0] for tup in sorted(self.channel_dict.items())]
        for key in keys:
            len_state = self.channel_dict[key].lengthOfStates()
            self.channel_dict[key].restoreFromStateVector(field[:len_state])
            field = field[len_state:]
        keys = [key for key, val in sorted(self.timer_type1_dict.items())]
        for key in keys:
            self.timer_type1_dict[key] = field[0]
            del field[0]
        keys = [key for key, val in sorted(self.timer_type2_dict.items())]
        for key in keys:
            self.timer_type2_dict[key] = field[0]
            del field[0]
        assert len(field) == len(self.trigger_dict)
        keys = [tup[0] for tup in sorted(self.trigger_dict.items())]
        for key, value in zip(keys, field):
            self.trigger_dict[key] = value

    # Saving current status
    def _saveToStateVector(self):
        field = []
        channel_list = [item[1] for item in sorted(self.channel_dict.items())]
        state_list = [ch.saveToStateVector() for ch in channel_list]
        for s in state_list:
            field = field + s
        timer_list = [val for key, val in sorted(self.timer_type1_dict.items())] + \
                     [val for key, val in sorted(self.timer_type2_dict.items())]
        field = field + timer_list
        trigger_list = [item[1] for item in sorted(self.trigger_dict.items())]
        field = field + trigger_list
        return field

    def _actionTriggered(self):
        trigger_list = [tup[1] for tup in self.trigger_dict.items()]
        if 1 in trigger_list:
            return 1
        else:
            return 0

    def _conditionSatisfied(self, condition):
        neg = False
        if condition[0] == '!':
            neg = True
            condition = condition[1:]
        if '#' not in condition and '*' not in condition:
            channel_name, ap_name = condition.split('.')
            if channel_name not in self.channel_dict:
                raise Exception('Unfound channel %s' % channel_name)
            if ap_name not in self.channel_dict[channel_name].ap_dict:
                raise Exception('Unfound atomic proposition %s in channel %s' % (ap_name, channel_name))
            if neg:
                return not self.channel_dict[channel_name].ap_dict[ap_name](self.channel_dict[channel_name])
            else:
                return self.channel_dict[channel_name].ap_dict[ap_name](self.channel_dict[channel_name])
        else:
            if condition in self.timer_type1_dict:
                return not (self.timer_type1_dict[condition] > 0) if neg else (self.timer_type1_dict[condition] > 0)
            elif condition in self.timer_type2_dict:
                return not (self.timer_type2_dict[condition] == 0) if neg else (self.timer_type2_dict[condition] == 0)
            else:
                raise Exception('Condition: %s not found' % condition)

    # check if the condition of tap is satisfied in the current state
    def _tapConditionSatisfied(self, tap):
        for cond in tap.condition:
            if not self._conditionSatisfied(cond):
                return False
        return True

    def _descriptionGenerator(self):
        description = ''
        for channel_name, channel in self.channel_dict.items():
            for state_name, state_value in channel.state_dict.items():
                description = description + '%s.%s=%s, ' % (channel_name, state_name, str(state_value))
        for key, val in self.timer_type1_dict.items():
            description = description + '%s=%d, ' % (key, val)
        for key, val in self.timer_type2_dict.items():
            description = description + '%s=%d, ' % (key, val)
        for rule_name, trigger_bit in self.trigger_dict.items():
            description = description + 'trigger_bit_%s=%d, ' % (rule_name, trigger_bit)
        description = description[:-2]
        return description

    def _labelGenerator(self):
        label = []
        for ch_name, channel in sorted(self.channel_dict.items()):
            for ap_name, ap in sorted(channel.ap_dict.items()):
                label = label + [int(channel.ap_dict[ap_name](channel))]
        for key, val in sorted(self.timer_type1_dict.items()):
            label.append(int(val>0))
        for key, val in sorted(self.timer_type2_dict.items()):
            label.append(int(val==0))
        trigger_list = [int(tb) for ti, tb in sorted(self.trigger_dict.items())]
        label = label + trigger_list
        if self._actionTriggered():
            label.append(1)
        else:
            label.append(0)
        return label

    def _applyAction(self, action):
        channel_name, action_name = action.split('.')
        if channel_name not in self.channel_dict:
            raise Exception('Unfound channel %s' % channel_name)
        if action_name not in self.channel_dict[channel_name].action_dict:
            raise Exception('Unfound action %s in channel %s' % (action_name, channel_name))
        # apply the action and set up trigger bits
        for tap_name, tap in self.tap_dict.items():
            if tap.trigger and tap.trigger == action and self._tapConditionSatisfied(tap):
                self.trigger_dict[tap_name] = 1

        self.channel_dict[channel_name].action_dict[action_name](self.channel_dict[channel_name])
        # set up timer
        for exp_t, event_l in self.timer_type1_event_l_dict.items():
            if action in event_l:
                self.timer_type1_dict[exp_t] = self.timer_type1_time_dict[exp_t]
        for exp_t, ap_l in self.timer_type2_ap_l_dict.items():
            if all([self._conditionSatisfied(ap) for ap in ap_l]):
                if self.timer_type2_dict[exp_t] == -1:
                    self.timer_type2_dict[exp_t] = self.timer_type2_time_dict[exp_t]
            else:
                self.timer_type2_dict[exp_t] = -1
        # set up trigger bit (state)
        for tap_name, tap in self.tap_dict.items():
            if not tap.trigger and self._tapConditionSatisfied(tap):
                self.trigger_dict[tap_name] = 1

    def _applyTick(self):
        # action name is 'tick[time#exp]' or 'tick[time*exp]'
        exp_t_type1_l = [exp_t for exp_t, val in sorted(self.timer_type1_dict.items()) if val > 0]
        val_type1_l = [val for exp_t, val in sorted(self.timer_type1_dict.items()) if val > 0]
        exp_t_type2_l = [exp_t for exp_t, val in sorted(self.timer_type2_dict.items()) if val > 0]
        val_type2_l = [val for exp_t, val in sorted(self.timer_type2_dict.items()) if val > 0]

        exp_t_l = exp_t_type1_l + exp_t_type2_l
        val_l = val_type1_l + val_type2_l

        target_val = min(val_l)
        target_index = val_l.index(target_val)
        target_exp_t = exp_t_l[target_index]

        action_name = 'tick[%s]' % target_exp_t

        # set up trigger bit
        for tap_name, tap in self.tap_dict.items():
            if tap.trigger and tap.trigger == action_name and self._tapConditionSatisfied(tap):
                self.trigger_dict[tap_name] = 1

        # set up timer
        for exp_t, val in self.timer_type1_dict.items():
            if val > 0:
                self.timer_type1_dict[exp_t] = val - target_val if val > target_val else 0
        for exp_t, val in self.timer_type2_dict.items():
            if val > 0:
                self.timer_type2_dict[exp_t] = val - target_val if val > target_val else 0

        # set up trigger bit (state)
        for tap_name, tap in self.tap_dict.items():
            if not tap.trigger and self._tapConditionSatisfied(tap):
                self.trigger_dict[tap_name] = 1

        return action_name

    def applyActionWithoutTriggering(self, action, field=None):
        channel_name, action_name = action.split('.')
        if channel_name not in self.channel_dict:
            raise Exception('Unfound channel %s' % channel_name)
        if action_name not in self.channel_dict[channel_name].action_dict:
            raise Exception('Unfound action %s in channel %s' % (action_name, channel_name))

        if field:
            self._restoreFromStateVector(field)
        for tap_name in self.trigger_dict:
            self.trigger_dict[tap_name] = 0
        self.channel_dict[channel_name].action_dict[action_name](self.channel_dict[channel_name])
        return self._saveToStateVector()

    def getLastStateField(self, action, field):
        channel_name, action_name = action.split('.')
        if channel_name not in self.channel_dict:
            raise Exception('Unfound channel %s' % channel_name)
        if action_name not in self.channel_dict[channel_name].action_dict:
            raise Exception('Unfound action %s in channel %s' % (action_name, channel_name))

        for tran in self.transition_system.trans_list:
            if field == tran.dest_field and action == tran.act:
                return tran.src_field
        return None

    def _BFS(self, state_init_t):
        search_pool = [state_init_t]

        while search_pool:
            state_t = search_pool.pop()
            self._restoreFromStateVector(state_t[1].field)
            if self._actionTriggered():
                for tap_name, tap in sorted(self.tap_dict.items()):
                    if self.trigger_dict[tap_name]:
                        if not tap.trigger:
                            self.trigger_dict[tap_name] = self._tapConditionSatisfied(tap)
                        else:
                            self.trigger_dict[tap_name] = 0
                        self._applyAction(tap.action)
                        new_field = self._saveToStateVector()
                        new_description = self._descriptionGenerator()
                        new_state = TransitionSystem.State(new_field, new_description)
                        new_label = self._labelGenerator()
                        if self._actionTriggered() or not self.transition_system.ifStateExists(new_state):
                            if not self.trigger_dict[tap_name]:  # not add a new state for self triggering
                                new_index = self.transition_system.addState(new_state, new_label)
                                search_pool.append((new_index, new_state))
                            else:
                                new_index = self.transition_system.getIndex(new_field)
                        else:
                            new_index = self.transition_system.getIndex(new_field)
                        action_description = 'rule(%s)->%s' % (tap_name, tap.action)
                        trans = TransitionSystem.Transition(state_t[0], action_description, new_index)
                        if not self.transition_system.ifActionExists(action_description):
                            self.transition_system.addAction(action_description)
                        self.transition_system.addTrans(trans)
                        self._restoreFromStateVector(state_t[1].field)
            else:
                # apply action
                for channel_name, channel in sorted(self.channel_dict.items()):
                    for action_name, action in channel.action_dict.items():
                        if self.channel_dict[channel_name].enable_dict[action_name](channel):
                            self._applyAction('%s.%s' % (channel_name, action_name))
                            new_field = self._saveToStateVector()
                            new_description = self._descriptionGenerator()
                            new_state = TransitionSystem.State(new_field, new_description)
                            new_label = self._labelGenerator()
                            action_description = '%s.%s' % (channel_name, action_name)
                            if self._actionTriggered() or not self.transition_system.ifStateExists(new_state):
                                new_index = self.transition_system.addState(new_state, new_label)
                                search_pool.append((new_index, new_state))
                            else:
                                new_index = self.transition_system.getIndex(new_field)
                            new_trans = TransitionSystem.Transition(state_t[0], action_description, new_index)
                            if not self.transition_system.ifActionExists(action_description):
                                self.transition_system.addAction(action_description)
                            self.transition_system.addTrans(new_trans)
                            self._restoreFromStateVector(state_t[1].field)
                # apply tick
                if not (all([val == 0 for key, val in self.timer_type1_dict.items()])
                        and all([val <= 0 for key, val in self.timer_type2_dict.items()])):
                    action_description = self._applyTick()
                    new_field = self._saveToStateVector()
                    new_description = self._descriptionGenerator()
                    new_state = TransitionSystem.State(new_field, new_description)
                    new_label = self._labelGenerator()
                    if self._actionTriggered() or not self.transition_system.ifStateExists(new_state):
                        new_index = self.transition_system.addState(new_state, new_label)
                        search_pool.append((new_index, new_state))
                    else:
                        new_index = self.transition_system.getIndex(new_field)
                    new_trans = TransitionSystem.Transition(state_t[0], action_description, new_index)
                    if not self.transition_system.ifActionExists(action_description):
                        self.transition_system.addAction(action_description)
                    self.transition_system.addTrans(new_trans)
                    self._restoreFromStateVector(state_t[1].field)

    def _createTS(self):
        # create a transition system based on the current system
        # generate ap list: all APs in channels plus trigger bit for whole system
        ap_list = self.getAllAp()
        # initialize TS
        self.transition_system = TransitionSystem.TS(ap_list)
        # generate initial state
        for tap_name, tap in self.tap_dict.items():
            if not tap.trigger:
                self.trigger_dict[tap_name] = self._tapConditionSatisfied(tap)
        field_init = self._saveToStateVector()
        description_init = self._descriptionGenerator()
        state_init = TransitionSystem.State(field_init, description_init)
        init_label = self._labelGenerator()
        init_index = self.transition_system.addState(state_init, init_label)
        state_init_t = (init_index, state_init)
        # perform DFS
        self._BFS(state_init_t)

    def getAllAp(self):
        ap_list = list()
        for ch_name, channel in sorted(self.channel_dict.items()):
            for ap_name, ap in sorted(channel.ap_dict.items()):
                ap_list.append('%s.%s' % (ch_name, ap_name))
        ap_list = ap_list + sorted([exp for exp, val in self.timer_type1_dict.items()])
        ap_list = ap_list + sorted([exp for exp, val in self.timer_type2_dict.items()])
        ap_list = ap_list + [rule_name for rule_name, rule in sorted(self.tap_dict.items())]
        ap_list.append('_triggered')
        return ap_list

    def getApList(self, field):
        result = list()
        self._restoreFromStateVector(field)
        for ch_name, channel in sorted(self.channel_dict.items()):
            for ap_name, ap in sorted(channel.ap_dict.items()):
                if ap(channel):
                    result.append('%s.%s' % (ch_name, ap_name))
        result = result + sorted([exp for exp, val in self.timer_type1_dict.items() if val > 0])
        result = result + sorted([exp for exp, val in self.timer_type2_dict.items() if val == 0])
        for rule_name, triggered in sorted(self.trigger_dict.items()):
            if triggered:
                result.append(rule_name)
        if self._actionTriggered():
            result.append('_triggered')
        return result

    def getAction(self, src_field, ext=True):
        """
        given a source field, return all possible actions together with destination fields
        :param src_field: source field
        :param ext: whether external actions are included
        :return: a list, with tuples of action names and destination fields
        """
        self._restoreFromStateVector(src_field)
        for ch_name, channel in sorted(self.channel_dict.items()):
            for act_name, act in sorted(channel.action_dict.items()):
                if channel.enable_dict[act_name](channel) and (ext or act_name not in channel.ext_action_list):
                    self._applyAction('%s.%s' % (ch_name, act_name))
                    yield '%s.%s' % (ch_name, act_name), self._saveToStateVector()
                    self._restoreFromStateVector(src_field)

    def getLabel(self, field):
        """
        given a field, return the corresponding label
        :param field: field
        :return: the label
        """
        self._restoreFromStateVector(field)
        return self._labelGenerator()

    def apSatisfied(self, ap, field):
        # tell whether the state trigger in the rule is satisfied
        self._restoreFromStateVector(field)
        return self._conditionSatisfied(ap)

    def isTriggeredState(self, field):
        self._restoreFromStateVector(field)
        return self._actionTriggered()

    def isTapTriggered(self, field, tap_name):
        self._restoreFromStateVector(field)
        return self.trigger_dict[tap_name]

    def tapConditionSatisfied(self, tap, field):
        self._restoreFromStateVector(field)
        return self._tapConditionSatisfied(tap)


def generateIoTSystem(name, channel_dict, tap_dict, timing_exp_list):
    class_name = 'Class' + name
    dct = {**channel_dict, **tap_dict}
    TempIoTSystem = MetaIoTSystem(class_name, (IoTSystem,), dct)
    result = TempIoTSystem(timing_exp_list)
    return result
