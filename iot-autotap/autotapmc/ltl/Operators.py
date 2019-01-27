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


class Operator(object):
    def __init__(self, op, n_args, precedence, associativity):
        self.op = op
        self.n_args = n_args
        self.precedence = precedence
        self.associativity = associativity


ops = {
    '!': Operator('!', 1, 3, 0),
    'U': Operator('U', 2, 2, 1),
    'V': Operator('V', 2, 2, 1),
    'X': Operator('X', 1, 3, 0),
    '&': Operator('&', 2, 1, 0),
    '|': Operator('|', 2, 1, 0)
}


re_splitter = r'(\s+|U|V|X|\(|\)|\&|\||!)'
