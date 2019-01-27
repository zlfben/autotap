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


def scenario1():
    print('----------------------------scenario1--------------------------------')
    ltl1 = 'G(!(location.appear=true) | thermostat.thermostat>70)'
    ltl2 = 'G(!(location.appear=true) | thermostat.thermostat<75)'
    ltl = '!(%s & %s)' % (ltl1, ltl2)
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('---------------------------------------------------------------------')


def scenario2():
    print('----------------------------scenario2--------------------------------')
    ltl1 = 'G(!(weather.temperature>60 & weather.temperature<80 & weather.raining=false) | window_liv.open=true)'
    ltl2 = '!F(window_liv.open=true & weather.raining=true)'
    ltl3 = '!F(window_liv.open=true & !weather.temperature>60)'
    ltl4 = '!F(window_liv.open=true & !weather.temperature<80)'
    ltl = '!(%s & %s & %s & %s)' % (ltl1, ltl2, ltl3, ltl4)
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('---------------------------------------------------------------------')


def scenario3():
    print('----------------------------scenario3--------------------------------')
    ltl1 = '!F(window_liv.open=false & window_bed.open=false & window_bath.open=false)'
    ltl2 = 'G(!(weather.temperature>60 & weather.temperature<80 & weather.raining=false) | window_liv.open=true)'
    ltl = '!(%s & %s)' % (ltl1, ltl2)
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('---------------------------------------------------------------------')


def scenario4():
    print('----------------------------scenario4--------------------------------')
    ltl1 = '!F(10800#location.appear=true & X(@roomba.power=true))'
    ltl2 = '!F(X@roomba.power=true & window_liv.curtain=true)'
    ltl = '!(%s & %s)' % (ltl1, ltl2)
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('---------------------------------------------------------------------')


def scenario5():
    print('----------------------------scenario5--------------------------------')
    # those properties could not be achieved by only one action fix, limitation of AutoTap
    ltl1 = '!F(86400*window_liv.open=false)'
    ltl2 = 'G(!(thermostat.ac=true) | window_liv.open=false)'
    ltl = '!(%s & %s)' % (ltl1, ltl2)
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('---------------------------------------------------------------------')


def scenario6():
    print('----------------------------scenario6--------------------------------')
    # conflict properties
    ltl1 = 'G(!(weather.raining=true) | window_liv.open=false)'
    ltl2 = 'G(window_liv.open=true)'
    ltl = '!(%s & %s)' % (ltl1, ltl2)
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('---------------------------------------------------------------------')


def scenario7():
    print('----------------------------scenario7--------------------------------')
    ltl1 = 'G(!(@fitbit.sleep=true & smart_tv.power=true) | (1860#fitbit.sleep=true W @smart_tv.power=false))'
    ltl2 = '!F(1800#fitbit.sleep=true & X@smart_tv.power=false)'
    ltl = '!(%s & %s)' % (ltl1, ltl2)
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('---------------------------------------------------------------------')

def testall():
    print('=====================Multi-property Testing==========================')
    scenario1()
    scenario2()
    scenario3()
    scenario4()
    scenario5()
    scenario6()
    scenario7()
    print('=====================================================================')
