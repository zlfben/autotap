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


def task2_1():
    print('----------------------------task2_1--------------------------------')
    ltl = 'F(window_liv.open=false & window_bed.open=false & window_bath.open=false)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task2_2():
    print('----------------------------task2_2--------------------------------')
    ltl1 = 'G(window_liv.open=true)'
    ltl2 = 'G(window_bath.open=true)'
    ltl3 = 'G(window_bed.open=true)'
    ltl = '!(%s & %s & %s)' % (ltl1, ltl2, ltl3)
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task2_3():
    print('----------------------------task2_3--------------------------------')
    ltl1 = 'G(!(window_bath.open=false & window_bed.open=false) | window_liv.open=true)'
    ltl2 = 'G(!(window_liv.open=false & window_bed.open=false) | window_bath.open=true)'
    ltl3 = 'G(!(window_bath.open=false & window_liv.open=false) | window_bed.open=true)'
    ltl = '!(%s & %s & %s)' % (ltl1, ltl2, ltl3)
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task2_4():
    print('----------------------------task2_4--------------------------------')
    ltl1 = 'G((window_bath.open=false & window_bed.open=false & window_liv.open=true) | ' \
           '(window_bath.open=true & window_bed.open=true & window_liv.open=false))'
    ltl = '!(%s)' % (ltl1)
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task2():
    task2_1()
    task2_2()
    task2_3()
    task2_4()


def task3_1():
    print('----------------------------task3_1--------------------------------')
    ltl = 'F(oven.lock=false & location.appear=true)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task3_2():
    print('----------------------------task3_2--------------------------------')
    ltl = 'F(oven.door=true & location.appear=true & oven.power=true)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task3_3():
    print('----------------------------task3_3--------------------------------')
    ltl = '!G(!location.appear=true | oven.lock=true)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task3_4():
    print('----------------------------task3_4--------------------------------')
    ltl = '!G((!location.appear=true | oven.lock=true) & (!oven.lock=true | location.appear=true))'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task3_5():
    print('----------------------------task3_5--------------------------------')
    ltl = 'F(oven.power=true & location.appear=false & oven.door=true)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task3_6():
    print('----------------------------task3_6--------------------------------')
    ltl1 = 'G(!location.appear=true | oven.lock=true)'
    ltl2 = 'G(!location.appear=true | oven.door=true)'
    ltl = '!(%s & %s)' % (ltl1, ltl2)
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task3():
    task3_1()
    task3_2()
    task3_3()
    task3_4()
    task3_5()
    task3_6()


def task4_1():
    print('----------------------------task4_1--------------------------------')
    ltl = 'F(thermostat.thermostat>80)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task4_2():
    print('----------------------------task4_2--------------------------------')
    ltl = 'F(@thermostat.thermostat>80)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task4_3():
    print('----------------------------task4_3--------------------------------')
    ltl = '!G(!weather.temperature>79 | (!thermostat.ac=false))'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task4():
    task4_1()
    task4_2()
    task4_3()


def task5_1():
    print('----------------------------task5_1--------------------------------')
    ltl = 'F(refrigerator.temperature_ctl<40)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task5_2():
    print('----------------------------task5_2--------------------------------')
    ltl = '!G(refrigerator.temperature_ctl=40)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task5_3():
    print('----------------------------task5_3--------------------------------')
    ltl = 'F(@refrigerator.temperature_ctl<40)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task5_4():
    print('----------------------------task5_4--------------------------------')
    ltl = 'F(@refrigerator.temperature_ctl<40 | @refrigerator.temperature_ctl>40)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task5():
    task5_1()
    task5_2()
    task5_3()
    task5_4()


def task6_1():
    print('----------------------------task6_1--------------------------------')
    ltl = 'F(120*refrigerator.door=true)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task6_2():
    print('----------------------------task6_2--------------------------------')
    ltl = '!G(!(@refrigerator.door=true) | (120#refrigerator.door=true W @refrigerator.door=false))'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task6():
    task6_1()
    task6_2()


def task7_1():
    print('----------------------------task7_1--------------------------------')
    ltl = 'F(15*faucet.water=true)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task7_2():
    print('----------------------------task7_2--------------------------------')
    ltl = '!G(!(@faucet.water=true) | (15#faucet.water=true W @faucet.water=false))'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task7():
    task7_1()
    task7_2()


def task9_1():
    print('----------------------------task9_1--------------------------------')
    ltl1 = 'G((!location.appear=true | thermostat.thermostat=71) & (!thermostat.thermostat=71 | location.appear=true))'
    ltl = '!%s' % ltl1
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task9_2():
    print('----------------------------task9_2--------------------------------')
    ltl1 = 'G(!location.appear=true | thermostat.thermostat=71)'
    ltl = '!%s' % ltl1
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task9_3():
    print('----------------------------task9_3--------------------------------')
    # this ltl cannot be achieved: <75 and >75 cannot be achieved together
    ltl1 = 'G((location.appear=true & thermostat.thermostat<75 & thermostat.thermostat>70) | ' \
           '(!location.appear=true & !thermostat.thermostat<75 & !thermostat.thermostat>70))'
    ltl = '!%s' % ltl1
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task9():
    task9_1()
    task9_2()
    task9_3()


def task10_1():
    print('----------------------------task10_1--------------------------------')
    ltl = '!G(window_bath.curtain=false)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('------------------------------------------------------------------')


def task10_2():
    print('----------------------------task10_2--------------------------------')
    ltl = 'F(@window_bath.curtain=true)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('------------------------------------------------------------------')


def task10():
    task10_1()
    task10_2()


def task11_1():
    print('----------------------------task11_1--------------------------------')
    ltl = 'F(@echo.is_pop=true)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('------------------------------------------------------------------')


def task11_2():
    print('----------------------------task11_2--------------------------------')
    ltl = 'F(echo.is_pop=true)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('------------------------------------------------------------------')


def task11():
    task11_1()
    task11_2()


def task12_1():
    print('----------------------------task12_1--------------------------------')
    ltl = 'F(roomba.power=true & window_liv.curtain=true)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('------------------------------------------------------------------')


def task12_2():
    print('----------------------------task12_2--------------------------------')
    ltl = '!G((!roomba.power=true) | window_liv.curtain=false)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('------------------------------------------------------------------')


def task12_3():
    print('----------------------------task12_3--------------------------------')
    ltl = '!G((!window_liv.curtain=true) | roomba.power=false)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('------------------------------------------------------------------')


def task12():
    task12_1()
    task12_2()
    task12_3()


def task14_1():
    print('----------------------------task14_1--------------------------------')
    ltl = '!G(!fitbit.sleep=true | door.lock=true)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('------------------------------------------------------------------')


def task14_2():
    print('----------------------------task14_2--------------------------------')
    ltl = '!G((!fitbit.sleep=true | door.lock=true) & (!door.lock=true | fitbit.sleep=true))'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('------------------------------------------------------------------')


def task14_3():
    print('----------------------------task14_3--------------------------------')
    ltl = 'F(fitbit.sleep=true & door.lock=false)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('------------------------------------------------------------------')


def task14_4():
    print('----------------------------task14_4--------------------------------')
    ltl = '!G(!(location.appear=true & hue_light.power=false) | door.lock=true)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('------------------------------------------------------------------')


def task14_5():
    print('----------------------------task14_5--------------------------------')
    ltl = 'F(X@door.lock=false & fitbit.sleep=true)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('------------------------------------------------------------------')


def task14():
    task14_1()
    task14_2()
    task14_3()
    task14_4()
    task14_5()


def task15_1():
    print('----------------------------task15_1--------------------------------')
    ltl = 'F(10800#location.appear=true & X(@roomba.power=true))'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('------------------------------------------------------------------')


def task15():
    task15_1()


def task16_1():
    print('----------------------------task16_1--------------------------------')
    ltl = '!G(!(@fitbit.sleep=true & smart_tv.power=true) | (1800#fitbit.sleep=true W @smart_tv.power=false))'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('------------------------------------------------------------------')


def task16_2():
    print('----------------------------task16_2--------------------------------')
    ltl = 'F(1800*smart_tv.power=true & fitbit.sleep=true)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('------------------------------------------------------------------')


def task16_3():
    print('----------------------------task16_3--------------------------------')
    ltl1 = 'G(!(@fitbit.sleep=true & smart_tv.power=true) | (1860#fitbit.sleep=true W @smart_tv.power=false))'
    ltl2 = '!F(1800#fitbit.sleep=true & X@smart_tv.power=false)'
    ltl = '!(%s & %s)' % (ltl1, ltl2)
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('------------------------------------------------------------------')


def task16():
    task16_1()
    task16_2()
    task16_3()

def testall():
    print('======================UserWritten testing==========================')
    task2()
    task3()
    task4()
    task5()
    task6()
    task7()
    task9()
    task10()
    task11()
    task12()
    task14()
    task15()
    task16()
    print('==================================================================')
