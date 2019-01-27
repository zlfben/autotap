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


import re
# from ltl.Operators import ops, re_splitter


class Operator(object):
    def __init__(self, op, n_args, precedence, associativity):
        self.op = op
        self.n_args = n_args
        self.precedence = precedence
        self.associativity = associativity


def _nextToken(formula, re_splitter):
    if not formula:
        return None, ''
    formula = formula.lstrip()
    token_list = re.split(re_splitter, formula, maxsplit=1)
    # print(token_list)
    if len(token_list) == 3:
        if token_list[0] == '':
            return token_list[1], token_list[2]
        else:
            if token_list[1] == ' ':
                return token_list[0], token_list[2]
            else:
                return token_list[0], token_list[1] + token_list[2]
    elif len(token_list) == 1:
        return token_list[0], ''


def parse(formula, ops, re_splitter):
    op_stack = list()
    output = list()

    while True:
        (token, formula) = _nextToken(formula, re_splitter)
        if token:
            if token in ops:
                while (ops[token].n_args != 1 and op_stack and op_stack[-1] != '(') \
                        and ((op_stack and ops[op_stack[-1]].precedence > ops[token].precedence)
                             or (op_stack and ops[op_stack[-1]].precedence == ops[token].precedence
                                 and ops[op_stack[-1]].associativity == 0)):
                    output.append(op_stack.pop())
                op_stack.append(token)
            elif token == '(':
                op_stack.append(token)
            elif token == ')':
                while op_stack and op_stack[-1] != '(':
                    output.append(op_stack.pop())
                op_stack.pop()
            else:
                output.append(token)
        else:
            if op_stack:
                op_stack.reverse()
                output = output + op_stack
            break
    return output


def calcIneq(formula):
    re_splitter = r'(\s+|\(|\)|\&|\||!|<|>|=)'
    ops = {
        '!': Operator('!', 1, 3, 1),
        '&': Operator('&', 2, 1, 0),
        '|': Operator('|', 2, 1, 0),
        '<': Operator('<', 2, 2, 0),
        '>': Operator('>', 2, 2, 0),
        '=': Operator('=', 2, 2, 0)
    }
    post_exp = parse(formula, ops, re_splitter)

    stack = list()
    for token in post_exp:
        if token not in ops:
            if token == 'true':
                stack.append(True)
            elif token == 'false':
                stack.append(False)
            elif token.replace('.', '').isnumeric():
                stack.append(float(token))
            else:
                stack.append(token)
        else:
            if token == '!':
                stack[-1] = not stack[-1]
            elif token == '&':
                stack[-2] = stack[-2] and stack[-1]
                stack.pop()
            elif token == '|':
                stack[-2] = stack[-2] or stack[-1]
                stack.pop()
            elif token == '<':
                stack[-2] = stack[-2] < stack[-1]
                stack.pop()
            elif token == '>':
                stack[-2] = stack[-2] > stack[-1]
                stack.pop()
            elif token == '=':
                stack[-2] = stack[-2] == stack[-1]
                stack.pop()

    return stack[0]