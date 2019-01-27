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
from autotapmc.analyze.Fix import generateCompactFix


def task2_1():
    print('----------------------------task2_1--------------------------------')
    ltl = 'F(living_room_window.openclose_window_position=false & ' \
          'bedroom_window.openclose_window_position=false & ' \
          'bathroom_window.openclose_window_position=false)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task2_2():
    print('----------------------------task2_2--------------------------------')
    ltl1 = 'G(living_room_window.openclose_window_position=true)'
    ltl2 = 'G(bedroom_window.openclose_window_position=true)'
    ltl3 = 'G(bathroom_window.openclose_window_position=true)'
    ltl = '!(%s & %s & %s)' % (ltl1, ltl2, ltl3)
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task2_3():
    print('----------------------------task2_3--------------------------------')
    ltl1 = 'G(!(bathroom_window.openclose_window_position=false & bedroom_window.openclose_window_position=false) | living_room_window.openclose_window_position=true)'
    ltl2 = 'G(!(living_room_window.openclose_window_position=false & bedroom_window.openclose_window_position=false) | bathroom_window.openclose_window_position=true)'
    ltl3 = 'G(!(bathroom_window.openclose_window_position=false & living_room_window.openclose_window_position=false) | bedroom_window.openclose_window_position=true)'
    ltl = '!(%s & %s & %s)' % (ltl1, ltl2, ltl3)
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task2_4():
    print('----------------------------task2_4--------------------------------')
    ltl1 = 'G((bathroom_window.openclose_window_position=false & bedroom_window.openclose_window_position=false & living_room_window.openclose_window_position=true) | ' \
           '(bathroom_window.openclose_window_position=true & bedroom_window.openclose_window_position=true & living_room_window.openclose_window_position=false))'
    ltl = '!(%s)' % (ltl1)
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task2():
    task2_1()
    task2_2()
    task2_3()
    task2_4()


def task3_1():
    print('----------------------------task3_1--------------------------------')
    ltl = 'F(smart_oven.openclose_door_position=true & location_sensor.kitchen_bobbie=true)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task3_2():
    print('----------------------------task3_2--------------------------------')
    ltl = 'F(smart_oven.openclose_door_position=true & location_sensor.kitchen_bobbie=true & smart_oven.power_onoff_setting=true)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task3_3():
    print('----------------------------task3_3--------------------------------')
    ltl = '!G(!location_sensor.kitchen_bobbie=true | smart_oven.lockunlock_setting=true)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task3_4():
    print('----------------------------task3_4--------------------------------')
    ltl = '!G((!location_sensor.kitchen_bobbie=true | smart_oven.lockunlock_setting=true) & ' \
          '(!smart_oven.lockunlock_setting=true | location_sensor.kitchen_bobbie=true))'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task3_5():
    print('----------------------------task3_5--------------------------------')
    ltl = 'F(smart_oven.power_onoff_setting=true & location_sensor.kitchen_anyone=false & smart_oven.openclose_door_position=true)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task3_6():
    print('----------------------------task3_6--------------------------------')
    ltl1 = 'G(!location_sensor.kitchen_bobbie=true | smart_oven.lockunlock_setting=true)'
    ltl2 = 'G(!location_sensor.kitchen_bobbie=true | smart_oven.openclose_door_position=true)'
    ltl = '!(%s & %s)' % (ltl1, ltl2)
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
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
    ltl = 'F(thermostat.thermostat_temperature>80)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task4_2():
    print('----------------------------task4_2--------------------------------')
    ltl = 'F(@thermostat.thermostat_temperature>80)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task4_3():
    print('----------------------------task4_3--------------------------------')
    ltl = '!G(!thermostat.current_temperature_temperature>79 | (!thermostat.ac_onoff_setting=false))'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task4():
    task4_1()
    task4_2()
    task4_3()


def task5_1():
    print('----------------------------task5_1--------------------------------')
    ltl = 'F(smart_refrigerator.temperature_control_temperature<40)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task5_2():
    print('----------------------------task5_2--------------------------------')
    ltl = '!G(smart_refrigerator.temperature_control_temperature=40)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task5_3():
    print('----------------------------task5_3--------------------------------')
    ltl = 'F(@smart_refrigerator.temperature_control_temperature<40)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task5_4():
    print('----------------------------task5_4--------------------------------')
    ltl = 'F(@smart_refrigerator.temperature_control_temperature<40 | ' \
          '@smart_refrigerator.temperature_control_temperature>40)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task5_5():
    # TODO: why?
    print('----------------------------task5_5--------------------------------')
    ltl1 = '!F(smart_refrigerator.temperature_control_temperature>45 | smart_refrigerator.temperature_control_temperature<40)'
    # ltl2 = '!F(smart_refrigerator.temperature_control_temperature<40'
    ltl = '!(%s)' % (ltl1)
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task5():
    task5_1()
    task5_2()
    task5_3()
    task5_4()
    task5_5()


def task6_1():
    print('----------------------------task6_1--------------------------------')
    ltl = 'F(120*smart_refrigerator.openclose_door_position=true)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task6_2():
    print('----------------------------task6_2--------------------------------')
    ltl = '!G(!(@smart_refrigerator.openclose_door_position=true) | ' \
          '(120#smart_refrigerator.openclose_door_position=true W @smart_refrigerator.openclose_door_position=false))'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task6_3():
    print('----------------------------task6_3--------------------------------')
    ltl = 'F(120*front_door_lock.lockunlock_setting=false)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task6():
    task6_1()
    task6_2()
    task6_3()


def task7_1():
    print('----------------------------task7_1--------------------------------')
    ltl = 'F(15*smart_faucet.water_onoff_setting=true)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task7_2():
    print('----------------------------task7_2--------------------------------')
    ltl = '!G(!(@smart_faucet.water_onoff_setting=true) | ' \
          '(900#smart_faucet.water_onoff_setting=true W @smart_faucet.water_onoff_setting=false))'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task7():
    task7_1()
    task7_2()


def task9_1():
    print('----------------------------task9_1--------------------------------')
    ltl1 = 'G((!location_sensor.home_anyone=true | thermostat.thermostat_temperature=72) & ' \
           '(!thermostat.thermostat_temperature=72 | location_sensor.home_anyone=true))'
    ltl = '!%s' % ltl1
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task9_2():
    print('----------------------------task9_2--------------------------------')
    ltl1 = 'G(!location_sensor.home_anyone=true | thermostat.thermostat_temperature=73)'
    ltl = '!%s' % ltl1
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task9_3():
    print('----------------------------task9_3--------------------------------')
    # this ltl cannot be achieved: <75 and >75 cannot be achieved together
    ltl1 = 'G((location_sensor.home_anyone=true & thermostat.thermostat_temperature<75 & thermostat.thermostat_temperature>70) | ' \
           '(!location_sensor.home_anyone=true & !thermostat.thermostat_temperature<75 & !thermostat.thermostat_temperature>70))'
    ltl = '!%s' % ltl1
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('-----------------------------------------------------------------')


def task9():
    task9_1()
    task9_2()
    # task9_3()


def task10_1():
    print('----------------------------task10_1--------------------------------')
    ltl = '!G(bathroom_window.openclose_curtains_position=false)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('------------------------------------------------------------------')


def task10_2():
    print('----------------------------task10_2--------------------------------')
    ltl = 'F(@bathroom_window.openclose_curtains_position=true)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('------------------------------------------------------------------')


def task10():
    task10_1()
    task10_2()


def task11_1():
    print('----------------------------task11_1--------------------------------')
    ltl = 'F(@amazon_echo.genre_genre=Pop)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('------------------------------------------------------------------')


def task11_2():
    print('----------------------------task11_2--------------------------------')
    ltl = 'F(amazon_echo.genre_genre=Pop)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('------------------------------------------------------------------')


def task11_3():
    print('----------------------------task11_3--------------------------------')
    ltl1 = 'G(!amazon_echo.genre_genre=Pop)'
    ltl2 = '!F(@amazon_echo.genre_genre=Pop)'
    ltl = '!(%s & %s)' % (ltl1, ltl2)
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('------------------------------------------------------------------')


def task11():
    task11_1()
    task11_2()
    task11_3()


def task12_1():
    print('----------------------------task12_1--------------------------------')
    ltl = 'F(roomba.power_onoff_setting=true & living_room_window.openclose_curtains_position=true)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('------------------------------------------------------------------')


def task12_2():
    print('----------------------------task12_2--------------------------------')
    ltl = '!G((!roomba.power_onoff_setting=true) | living_room_window.openclose_curtains_position=false)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('------------------------------------------------------------------')


def task12_4():
    print('----------------------------task12_4--------------------------------')
    ltl1 = '!F(roomba.power_onoff_setting=true & bedroom_window.openclose_curtains_position=true)'
    ltl2 = '!F(roomba.power_onoff_setting=true & bathroom_window.openclose_curtains_position=true)'
    ltl3 = '!F(roomba.power_onoff_setting=true & living_room_window.openclose_curtains_position=true)'
    ltl = '!(%s & %s & %s)' % (ltl1, ltl2, ltl3)
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('------------------------------------------------------------------')


def task12_3():
    print('----------------------------task12_3--------------------------------')
    ltl = '!G((!living_room_window.openclose_curtains_position=true) | roomba.power_onoff_setting=false)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('------------------------------------------------------------------')


def task12_5():
    print('----------------------------task12_5--------------------------------')
    ltl1 = '!F(X@roomba.power_onoff_setting=true & bedroom_window.openclose_curtains_position=true)'
    ltl3 = '!F(roomba.power_onoff_setting=true & living_room_window.openclose_curtains_position=true)'
    ltl = '!(%s & %s)' % (ltl1, ltl3)
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('------------------------------------------------------------------')


def task12():
    task12_1()
    task12_2()
    task12_3()
    task12_4()
    task12_5()


def task14_1():
    print('----------------------------task14_1--------------------------------')
    ltl = '!G(!fitbit.sleep_sensor_status=true | front_door_lock.lockunlock_setting=true)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('------------------------------------------------------------------')


def task14_2():
    print('----------------------------task14_2--------------------------------')
    ltl = '!G((!fitbit.sleep_sensor_status=true | front_door_lock.lockunlock_setting=true) & ' \
          '(!front_door_lock.lockunlock_setting=true | fitbit.sleep_sensor_status=true))'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('------------------------------------------------------------------')


def task14_3():
    print('----------------------------task14_3--------------------------------')
    ltl = 'F(fitbit.sleep_sensor_status=true & bedroom_window.lockunlock_setting=false)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('------------------------------------------------------------------')


def task14_4():
    print('----------------------------task14_4--------------------------------')
    ltl = '!G(!(location_sensor.home_anyone=true & clock.is_it_daytime_time=false) | front_door_lock.lockunlock_setting=true)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('------------------------------------------------------------------')


def task14_5():
    print('----------------------------task14_5--------------------------------')
    ltl = 'F(X@front_door_lock.lockunlock_setting=false & fitbit.sleep_sensor_status=true)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('------------------------------------------------------------------')


def task14_6():
    print('----------------------------task14_6--------------------------------')
    ltl = '!G(!(clock.is_it_daytime_time=false & hue_lights.power_onoff_setting=false) | front_door_lock.lockunlock_setting=true)'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('------------------------------------------------------------------')


def task14_7():
    print('----------------------------task14_7--------------------------------')
    ltl1 = '!F(X@front_door_lock.lockunlock_setting=false & fitbit.sleep_sensor_status=true)'
    ltl2 = '!F(front_door_lock.lockunlock_setting=false & fitbit.sleep_sensor_status=true)'
    ltl = '!(%s & %s)' % (ltl1, ltl2)
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('------------------------------------------------------------------')


def task14():
    task14_1()
    task14_2()
    task14_3()
    task14_4()
    task14_5()
    task14_6()
    task14_7()


def task15_1():
    print('----------------------------task15_1--------------------------------')
    ltl = 'F(10800#location_sensor.home_a_family_member=true & X(@roomba.power_onoff_setting=true))'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('------------------------------------------------------------------')


def task15():
    task15_1()


def task16_1():
    print('----------------------------task16_1--------------------------------')
    ltl = '!G(!(@fitbit.sleep_sensor_status=true & smart_tv.power_onoff_setting=true) | ' \
          '(1800#fitbit.sleep_sensor_status=true W @smart_tv.power_onoff_setting=false))'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('------------------------------------------------------------------')


def task16_2():
    # TODO: check this
    print('----------------------------task16_2--------------------------------')
    ltl = 'F(1800*smart_tv.power_onoff_setting=true & (fitbit.sleep_sensor_status=true))'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('------------------------------------------------------------------')


def task16_3():
    print('----------------------------task16_3--------------------------------')
    ltl1 = 'G(!(@fitbit.sleep_sensor_status=true & smart_tv.power_onoff_setting=true) | ' \
           '(1860#fitbit.sleep_sensor_status=true W @smart_tv.power_onoff_setting=false))'
    ltl2 = '!F(1800#fitbit.sleep_sensor_status=true & X@smart_tv.power_onoff_setting=false)'
    ltl = '!(%s & %s)' % (ltl1, ltl2)
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('------------------------------------------------------------------')


def task16_4():
    print('----------------------------task16_4--------------------------------')
    ltl = '!G(!(@fitbit.sleep_sensor_status=true & smart_tv.power_onoff_setting=true) | ' \
          '(2400#fitbit.sleep_sensor_status=true W @smart_tv.power_onoff_setting=false))'
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('------------------------------------------------------------------')


def task16_5():
    print('----------------------------task16_5--------------------------------')
    ltl1 = 'G(!(@fitbit.sleep_sensor_status=true & smart_tv.power_onoff_setting=true) | ' \
           '(3600#fitbit.sleep_sensor_status=true W @smart_tv.power_onoff_setting=false))'
    ltl2 = '!F(1800#fitbit.sleep_sensor_status=true & X@smart_tv.power_onoff_setting=false)'
    ltl3 = '!F(3600*smart_tv.power_onoff_setting=true & (fitbit.sleep_sensor_status=true))'
    ltl = '!(%s & %s & %s)' % (ltl1, ltl2, ltl3)
    tap_list = []
    new_rule_patch = generateCompactFix(ltl, tap_list, init_value_dict={}, template_dict=template_dict)
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('------------------------------------------------------------------')

def task16():
    task16_1()
    task16_2()
    task16_3()
    task16_4()
    task16_5()

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
