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


from autotapmc.analyze.Fix import generateCompactFix
from autotapmc.channels.template.DbTemplate import template_dict
from autotapmc.model.Tap import Tap


# print('----------------------------scenario1--------------------------------')
# ltl1 = '!F(living_room_window.openclose_window_position=false & ' \
#        'bathroom_window.openclose_window_position=false & ' \
#        'bedroom_window.openclose_window_position=false)'
# ltl = '!(%s)' % (ltl1)
# tap_list = [Tap(action='living_room_window.openclose_window_position=true',
#                 condition=['weather_sensor.is_it_raining_condition=false'],
#                 trigger='weather_sensor.weather_sensor_weather=Clear')]
# new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
# print('\n'.join([str(patch) for patch in new_rule_patch]))
# print('---------------------------------------------------------------------')


print('----------------------------scenario1--------------------------------')
ltl1 = '1'
ltl = '!(%s)' % (ltl1)
tap_list = [Tap(action='smart_refrigerator.openclose_door_position=true',
                condition=['!120#smart_refrigerator.openclose_door_position=true'],
                trigger='location_sensor.kitchen_alice=false')]
new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
print('\n'.join([str(patch) for patch in new_rule_patch]))
print('---------------------------------------------------------------------')

