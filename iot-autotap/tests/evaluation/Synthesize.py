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


def task2():
    print('----------------------------task2--------------------------------')
    ltl = 'F(window_liv.open=false & window_bed.open=false & window_bath.open=false)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task3():
    print('----------------------------task3--------------------------------')
    ltl = 'F(oven.lock=false & location.appear=true)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task4():
    print('----------------------------task4--------------------------------')
    ltl = 'F(thermostat.thermostat>80)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task5():
    print('----------------------------task5--------------------------------')
    ltl = 'F(refrigerator.temperature_ctl>40)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task6():
    print('----------------------------task6--------------------------------')
    ltl = 'F(60*refrigerator.door=true)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task7():
    print('----------------------------task7--------------------------------')
    ltl = 'F(15*faucet.water=true)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task8():
    print('----------------------------task8--------------------------------')
    ltl = '!G(!(weather.temperature>60 & weather.temperature<80 & weather.raining=false) | window_liv.open=true)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task9():
    print('----------------------------task9--------------------------------')
    ltl = '!(G(!(location.appear=true) | thermostat.thermostat>70) & ' \
          'G(!(location.appear=true) | thermostat.thermostat<75))'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task10():
    print('----------------------------task10--------------------------------')
    ltl = 'F(@window_bath.curtain=false)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('------------------------------------------------------------------')


def task11():
    print('----------------------------task11--------------------------------')
    ltl = 'F(X@echo.is_pop=true & echo.playing=true)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('------------------------------------------------------------------')


def task12():
    print('----------------------------task12--------------------------------')
    ltl = 'F(X@roomba.power=true & window_liv.curtain=true)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('------------------------------------------------------------------')


def task14():
    print('----------------------------task14--------------------------------')
    ltl = 'F(X@door.lock=false & fitbit.sleep=true)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('------------------------------------------------------------------')


def task15():
    print('----------------------------task15--------------------------------')
    ltl = 'F(10800#location.appear=true & X(@roomba.power=true))'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('------------------------------------------------------------------')


def task16():
    print('----------------------------task16--------------------------------')
    ltl = '!G(!(@fitbit.sleep=true & smart_tv.power=true) | (1800#fitbit.sleep=true W @smart_tv.power=false))'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('------------------------------------------------------------------')


def task_set():
    print('----------------------------task_set--------------------------------')
    ltl = '!G(!location.appear=true | hue_light.color=red)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('------------------------------------------------------------------')


def testall():
    print('======================Synthesize testing==========================')
    task2()
    task3()
    task4()
    task5()
    task6()
    task7()
    task8()
    task9()
    task10()
    task11()
    task12()
    task14()
    task15()
    task16()
    task_set()
    print('==================================================================')
