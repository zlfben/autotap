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


from autotapmc.utils.Parser import parse, Operator

ops = {
    '!': Operator('!', 1, 3, 0),
    '&': Operator('&', 2, 1, 0),
    '|': Operator('|', 2, 1, 0)
}

re_splitter = r'(\s+|\(|\)|\&|\||!)'


def calculateBoolean(formula, var_dict):
    """
    given boolean variable value, calculate the value of a boolean formula (!, &, |, brackets are supported)
    :param formula: the formula
    :param var_dict: var_name->value dictionary
    :return:
    """
    token_list = parse(formula, ops, re_splitter)
    stack = list()
    for token in token_list:
        if token == '!':
            stack[-1] = not stack[-1]
        elif token == '&':
            stack[-2] = stack[-1] and stack[-2]
            stack.pop()
        elif token == '|':
            stack[-2] = stack[-1] or stack[-2]
            stack.pop()
        elif token in var_dict:
            stack.append(var_dict[token])
        elif token == '0':
            stack.append(False)
        elif token == '1':
            stack.append(True)
        else:
            raise Exception('Unknown AP token %s in edge formula' % token)
    if len(stack) != 1:
        raise Exception('Wrong edge AP formula format!')

    return stack[0]
