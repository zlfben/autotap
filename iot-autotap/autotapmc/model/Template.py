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


import abc
from collections import Callable


def apBoolTemplate(name, is_true=True):
    if is_true:
        return '    def ap_%sIsTrue(self):\n        return self.%s == 1' % (name, name)
    else:
        return '    def ap_%sIsFalse(self):\n        return self.%s == 0' % (name, name)


def apNumericTemplate(name, flag, value):
    if flag == '<':
        return '    def ap_%sLessThan%s(self):\n        return self.%s < %s' % (name, value, name, value)
    elif flag == '>':
        return '    def ap_%sGreaterThan%s(self):\n        return self.%s > %s' % (name, value, name, value)
    elif flag == '=':
        return '    def ap_%sEqualTo%s(self):\n        return self.%s == %s' % (name, value, name, value)


def eventBoolTemplate(name, is_true=True, if_external=False):
    value = str(int(is_true))
    if is_true:
        if if_external:
            code_1 = '    def extaction_%sSetTrue(self):\n        self.%s = 1' % (name, name)
            code_2 = '    def enable_%sSetTrue(self):\n        return self.%s != 1' % (name, name)
            return code_1 + '\n\n' + code_2
        else:
            code_1 = '    def action_%sSetTrue(self):\n        self.%s = 1' % (name, name)
            code_2 = '    def enable_%sSetTrue(self):\n        return self.%s != 1' % (name, name)
            return code_1 + '\n\n' + code_2
    else:
        if if_external:
            code_1 = '    def extaction_%sSetFalse(self):\n        self.%s = 0' % (name, name)
            code_2 = '    def enable_%sSetFalse(self):\n        return self.%s != 0' % (name, name)
            return code_1 + '\n\n' + code_2
        else:
            code_1 = '    def action_%sSetFalse(self):\n        self.%s = 0' % (name, name)
            code_2 = '    def enable_%sSetFalse(self):\n        return self.%s != 0' % (name, name)
            return code_1 + '\n\n' + code_2


def eventNumericTemplate(name, value, if_external=False):
    str_value = str(value).replace('.', '_')
    if if_external:
        code_1 = '    def extaction_%sSetTo%s(self):\n        self.%s = float(%s)' % (name, str_value, name, value)
        code_2 = '    def enable_%sSetTo%s(self):\n        return self.%s != %s' % (name, str_value, name, value)
        return code_1 + '\n\n' + code_2
    else:
        code_1 = '    def action_%sSetTo%s(self):\n        self.%s = float(%s)' % (name, str_value, name, value)
        code_2 = '    def enable_%sSetTo%s(self):\n        return self.%s != %s' % (name, str_value, name, value)
        return code_1 + '\n\n' + code_2


class BaseCapTemplate(object):
    def __init__(self, name='switch', if_external=False):
        self.name = name
        self.if_external = if_external

    @abc.abstractmethod
    def definitionGenerator(self):
        """

        :return: a string containing the definition of this capability
        """
        pass

    @abc.abstractmethod
    def apGenerator(self):
        """

        :return: a list of string, each one is a string of a ap code body
        """
        pass

    @abc.abstractmethod
    def eventGenerator(self):
        """

        :return: a list of string, each one is a string of action/enable function body
        """
        pass


class BoolCapTemplate(BaseCapTemplate):
    def __init__(self, name='switch', if_external=False, single_ap=True, init_value='0'):
        self.init_value = str(init_value)
        self.single_ap = single_ap
        super(BoolCapTemplate, self).__init__(name, if_external)

    def definitionGenerator(self):
        return '    %s = %s' % (self.name, self.init_value)

    def apGenerator(self):
        if not self.single_ap:
            ap_1 = apBoolTemplate(self.name, True)
            ap_2 = apBoolTemplate(self.name, False)
            return [ap_1, ap_2]
        else:
            ap_1 = apBoolTemplate(self.name, True)
            return [ap_1]

    def eventGenerator(self):
        event_1 = eventBoolTemplate(self.name, True, self.if_external)
        event_2 = eventBoolTemplate(self.name, False, self.if_external)
        return [event_1, event_2]


class NumericCapTemplate(BaseCapTemplate):
    def __init__(self, crit_value_list, name='value', if_external=False, if_consecutive=False, init_value = '0'):
        self.crit_value_list = sorted(crit_value_list)
        self.if_consecutive=if_consecutive
        self.init_value = init_value
        super(NumericCapTemplate, self).__init__(name, if_external)

    def definitionGenerator(self):
        return '    %s = %s' % (self.name, self.init_value)

    def apGenerator(self):
        ap_list = list()
        for value in self.crit_value_list:
            ap1 = apNumericTemplate(self.name, '<', value)
            ap2 = apNumericTemplate(self.name, '=', value)
            ap3 = apNumericTemplate(self.name, '>', value)
            ap_list = ap_list + [ap1, ap3]
        return ap_list

    def eventGenerator(self):
        if self.if_consecutive:
            # not supported yet
            pass
        else:
            post_value_list = self.crit_value_list[1:]
            pre_value_list = self.crit_value_list[:-1]
            mid_value_list = [(v2+v1)/2 for v1, v2 in zip(pre_value_list, post_value_list)]
            set_value_list = self.crit_value_list + mid_value_list
            set_value_list.append(self.crit_value_list[0] - 1)
            set_value_list.append(self.crit_value_list[-1] + 1)
            set_value_list = sorted(set_value_list)

            event_list = list()
            for value in set_value_list:
                event = eventNumericTemplate(self.name, str(value), self.if_external)
                event_list.append(event)

            return event_list


# should be some templates that directly construct usable items in dct here
# this should handle both boolean attributes and numeric attributes
class IsTrueApTemplate(Callable):
    def __init__(self, name):
        self.name = name

    def __call__(self, sf):
        return sf.__getattribute__(self.name)


class SetValueActionTemplate(Callable):
    def __init__(self, name, value):
        self.name = name
        self.value = value

    def __call__(self, sf):
        sf.__setattr__(self.name, self.value)


class SetValueEnableTemplate(Callable):
    def __init__(self, name, value):
        self.name = name
        self.value = value

    def __call__(self, sf):
        return sf.__getattribute__(self.name) != self.value


class GreaterThanApTemplate(Callable):
    def __init__(self, name, value):
        self.name = name
        self.value = value

    def __call__(self, sf):
        return sf.__getattribute__(self.name) > self.value


class LessThanApTemplate(Callable):
    def __init__(self, name, value):
        self.name = name
        self.value = value

    def __call__(self, sf):
        return sf.__getattribute__(self.name) < self.value


class EqualToApTemplate(Callable):
    def __init__(self, name, value):
        self.name = name
        self.value = value

    def __call__(self, sf):
        return sf.__getattribute__(self.name) == self.value


def generateDctForNumeric(name, crit_value_list, ext=False, init_value=0):
    dct = dict()

    dct[name] = init_value

    crit_value_list = sorted(crit_value_list)
    additional_crit_value_list = [(l+r)/2 for l, r in zip(crit_value_list[:-1], crit_value_list[1:])]
    additional_crit_value_list = additional_crit_value_list + [crit_value_list[0]-1, crit_value_list[-1]+1]

    for crit_value in crit_value_list:
        # setXX
        if not ext:
            set_value_action_name = 'action_%sSetTo%s' % (name, str(crit_value).replace('.', '_'))
        else:
            set_value_action_name = 'extaction_%sSetTo%s' % (name, str(crit_value).replace('.', '_'))
        set_value_enable_name = 'enable_%sSetTo%s' % (name, str(crit_value).replace('.', '_'))
        dct[set_value_action_name] = SetValueActionTemplate(name, crit_value)
        dct[set_value_enable_name] = SetValueEnableTemplate(name, crit_value)
        # <> tests
        greater_than_ap_name = 'ap_%sGreaterThan%s' % (name, str(crit_value).replace('.', '_'))
        less_than_ap_name = 'ap_%sLessThan%s' % (name, str(crit_value).replace('.', '_'))
        dct[greater_than_ap_name] = GreaterThanApTemplate(name, crit_value)
        dct[less_than_ap_name] = LessThanApTemplate(name, crit_value)

    for crit_value in additional_crit_value_list:
        # setXX
        if not ext:
            set_value_action_name = 'action_%sSetTo%s' % (name, str(crit_value).replace('.', '_'))
        else:
            set_value_action_name = 'extaction_%sSetTo%s' % (name, str(crit_value).replace('.', '_'))
        set_value_enable_name = 'enable_%sSetTo%s' % (name, str(crit_value).replace('.', '_'))
        dct[set_value_action_name] = SetValueActionTemplate(name, crit_value)
        dct[set_value_enable_name] = SetValueEnableTemplate(name, crit_value)

    return dct


def generateDctForBool(name, ext=False, init_value=0):
    dct = dict()

    dct[name] = init_value

    if not ext:
        set_true_action_name = 'action_%sSetTrue' % name
        set_false_action_name = 'action_%sSetFalse' % name
    else:
        set_true_action_name = 'extaction_%sSetTrue' % name
        set_false_action_name = 'extaction_%sSetFalse' % name

    set_true_enable_name = 'enable_%sSetTrue' % name
    set_false_enable_name = 'enable_%sSetFalse' % name

    is_true_ap_name = 'ap_%sIsTrue' % name

    dct[set_true_action_name] = SetValueActionTemplate(name, 1)
    dct[set_false_action_name] = SetValueActionTemplate(name, 0)
    dct[set_true_enable_name] = SetValueEnableTemplate(name, 1)
    dct[set_false_enable_name] = SetValueEnableTemplate(name, 0)
    dct[is_true_ap_name] = IsTrueApTemplate(name)

    return dct


def generateDctForSet(name, ext=False, value_list=list(['v1', 'v2']), init_value=None):
    # a "None" init value means that the set is initialized with the first value in the list
    dct = dict()

    if not init_value:
        dct[name] = value_list[0]
    else:
        dct[name] = init_value

    for value in value_list:
        if not ext:
            action_name = 'action_%sSet%s' % (name, value.capitalize())
        else:
            action_name = 'extaction_%sSet%s' % (name, value.capitalize())

        enable_name = 'enable_%sSet%s' % (name, value.capitalize())
        ap_name = 'ap_%sIs%s' % (name, value.capitalize())

        dct[action_name] = SetValueActionTemplate(name, value)
        dct[enable_name] = SetValueEnableTemplate(name, value)
        dct[ap_name] = EqualToApTemplate(name, value)

    return dct
