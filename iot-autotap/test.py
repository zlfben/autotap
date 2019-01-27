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

import argparse
import os
import importlib

parser = argparse.ArgumentParser()
parser.add_argument("-s", "--show", help="show all available tests", action="store_true")


known_args, rems = parser.parse_known_args()

if known_args.show:
    test_list = os.listdir('tests')
    print("available tests:")
    for test in test_list:
        if test.endswith('.py') and test != '__init__.py':
            print('\t' + test)
else:
    parser.add_argument("script", help="the chosen test script")
    args = parser.parse_args()

    test_list = os.listdir('tests')
    test_file = args.script

    if test_file+'.py' not in test_list or test_file == '__init__.py':
        raise Exception('test %s not in test set.' % test_file)

    importlib.import_module('tests.' + test_file)

