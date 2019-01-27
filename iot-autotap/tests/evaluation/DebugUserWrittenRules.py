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

from autotapmc.channels.template.DbTemplate import template_dict
from autotapmc.analyze.Fix import generateCompactFix, generateNamedFix
from autotapmc.model.Tap import Tap

def printTap(tap):
    return 'IF %s WHILE %s, THEN %s' % (tap.trigger, str(tap.condition), str(tap.action))

def testall():
    print('----------------------------task16--------------------------------')
    ltl = '!(!F(bedroom_window.openclose_window_position=true & weather_sensor.is_it_raining_condition=true))'
    tap_dict = {'0': Tap(action='bedroom_window.openclose_window_position=false', condition=[], trigger='weather_sensor.is_it_raining_condition=true')}
    new_patch, label = generateNamedFix(ltl, tap_dict, init_value_dict={}, template_dict=template_dict)
    for patch, label in zip(new_patch, label):
        print(label, printTap(patch))
    print('------------------------------------------------------------------')
