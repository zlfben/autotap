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


from autotapmc.model.Tap import Tap
from autotapmc.analyze.Fix import generateCompactFix


def testcase1():
    # living room window.open and raining should never appear together
    print('----------------------------testcase1--------------------------------')
    ltl = 'F(window_liv.open=true & weather.raining=true)'
    # change trigger event 1a not revert
    tap_list_buggy_1 = [Tap('window_liv.open=false', 'window_liv.open=true', ['weather.raining=true']),
                        Tap('window_liv.open=false', 'weather.raining=false', ['window_liv.open=true'])]
    new_rule_patch = generateCompactFix(ltl, tap_list_buggy_1, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))

    # add condition 1b revert
    tap_list_buggy_2 = [Tap('window_liv.open=false', 'window_liv.open=true',
                            ['weather.raining=true', 'hue_light.power=true']),
                        Tap('window_liv.open=false', 'weather.raining=true', ['window_liv.open=true'])]
    new_rule_patch = generateCompactFix(ltl, tap_list_buggy_2, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))

    # change condition 1d not revert
    tap_list_buggy_3 = [Tap('window_liv.open=false', 'window_liv.open=true', ['weather.raining=false']),
                        Tap('window_liv.open=false', 'weather.raining=true', ['window_liv.open=true'])]
    new_rule_patch = generateCompactFix(ltl, tap_list_buggy_3, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))

    # change action 1e not revert
    tap_list_buggy_4 = [Tap('thermostat.thermostat=70', 'window_liv.open=true', ['weather.raining=true']),
                        Tap('window_liv.open=false', 'weather.raining=true', ['window_liv.open=true'])]
    new_rule_patch = generateCompactFix(ltl, tap_list_buggy_4, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))

    # delete rule 3 revert
    tap_list_buggy_5 = [Tap('window_liv.open=false', 'weather.raining=true', ['window_liv.open=true'])]
    new_rule_patch = generateCompactFix(ltl, tap_list_buggy_5, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))

    print('---------------------------------------------------------------------')


def testcase2():
    # Living Room Window is closed and Bedroom Window is closed and
    # Bathroom Window is closed should NEVER occur together
    print('----------------------------testcase2--------------------------------')
    ltl = 'F(window_liv.open=false & window_bed.open=false & window_bath.open=false)'
    # add new condition 1b revert
    tap_list_buggy_1 = [
        Tap('window_liv.open=true', 'window_liv.open=false',
            ['window_bed.open=false', 'window_bath.open=false', 'thermostat.thermostat<80']),
        Tap('window_bed.open=true', 'window_bed.open=false', ['window_liv.open=false', 'window_bath.open=false']),
        Tap('window_bath.open=true', 'window_bath.open=false', ['window_bed.open=false', 'window_liv.open=false'])
    ]
    new_rule_patch = generateCompactFix(ltl, tap_list_buggy_1, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))

    # modify condition 1d not revert
    tap_list_buggy_2 = [
        Tap('window_liv.open=true', 'window_liv.open=false', ['window_bed.open=true']),
        Tap('window_bed.open=true', 'window_bed.open=false', ['window_liv.open=false', 'window_bath.open=false']),
        Tap('window_bath.open=true', 'window_bath.open=false', ['window_bed.open=false', 'window_liv.open=false'])
    ]
    new_rule_patch = generateCompactFix(ltl, tap_list_buggy_2, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))

    # change action 1e not revert
    tap_list_buggy_3 = [
        Tap('thermostat.ac=true', 'window_liv.open=false', ['window_bed.open=false', 'window_bath.open=false']),
        Tap('window_bed.open=true', 'window_bed.open=false', ['window_liv.open=false', 'window_bath.open=false']),
        Tap('window_bath.open=true', 'window_bath.open=false', ['window_bed.open=false', 'window_liv.open=false'])
    ]
    new_rule_patch = generateCompactFix(ltl, tap_list_buggy_3, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))

    # delete rule 3 revert
    tap_list_buggy_4 = [
        Tap('window_bed.open=true', 'window_bed.open=false', ['window_liv.open=false', 'window_bath.open=false']),
        Tap('window_bath.open=true', 'window_bath.open=false', ['window_bed.open=false', 'window_liv.open=false'])
    ]
    new_rule_patch = generateCompactFix(ltl, tap_list_buggy_4, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))

    print('---------------------------------------------------------------------')


def testcase3():
    # The thermostat temperature should always be less than 80℉ ever.
    print('----------------------------testcase3--------------------------------')
    ltl = '!G(!thermostat.thermostat>80)'
    # change trigger 1a revert
    tap_list_buggy_1 = [Tap('thermostat.thermostat=75', 'thermostat.thermostat>85', [])]
    new_rule_patch = generateCompactFix(ltl, tap_list_buggy_1, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    # add condition 1b revert
    tap_list_buggy_2 = [Tap('thermostat.thermostat=75', 'thermostat.thermostat>80', ['hue_light.power=true'])]
    new_rule_patch = generateCompactFix(ltl, tap_list_buggy_2, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))

    # not working change action 1e
    # tap_list_buggy_3 = [Tap('thermostat.thermostat=81', 'thermostat.thermostat>80', [])]
    # new_rule_patch = generateCompactFix(ltl, tap_list_buggy_3, init_value_dict={})
    # print('\n'.join([str(patch) for patch in new_rule_patch]))

    print('---------------------------------------------------------------------')


def testcase4():
    # Fridge door should never be open for more than 1 minute
    print('----------------------------testcase4--------------------------------')
    ltl = 'F(60*refrigerator.door=true)'
    # change trigger 1a not revert
    tap_list_buggy_1 = [Tap('refrigerator.door=false', 'tick[120*refrigerator.door=true]', [])]
    new_rule_patch = generateCompactFix(ltl, tap_list_buggy_1, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    # add condition 1b revert
    tap_list_buggy_1 = [Tap('refrigerator.door=false', 'tick[60*refrigerator.door=true]', ['location.appear=true'])]
    new_rule_patch = generateCompactFix(ltl, tap_list_buggy_1, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))

    print('---------------------------------------------------------------------')


def testcase5():
    # The bedroom window should always be open when the outside temperature is above 60℉,
    # and the outside temperature is below 80℉ and it is not raining
    print('----------------------------testcase5--------------------------------')
    # this testbench is slow ~30s
    ltl = '!G(!(weather.temperature>60 & weather.temperature<80 & weather.raining=false) | (window_bed.open=true))'
    # change trigger (not working) 1a
    tap_list_buggy_1 = [Tap('window_bed.open=true', 'weather.temperature>70',
                            ['weather.temperature<80', 'window_bed.open=false', 'weather.raining=false']),
                        Tap('window_bed.open=true', 'weather.raining=false',
                            ['weather.temperature>60', 'weather.temperature<80', 'window_bed.open=false']),
                        Tap('window_bed.open=true', 'window_bed.open=false',
                            ['weather.raining=false', 'weather.temperature>60', 'weather.temperature<80'])]
    new_rule_patch = generateCompactFix(ltl, tap_list_buggy_1, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))

    # delete rule 3 revert
    tap_list_buggy_2 = [Tap('window_bed.open=true', 'weather.raining=false',
                            ['weather.temperature>60', 'weather.temperature<80', 'window_bed.open=false']),
                        Tap('window_bed.open=true', 'window_bed.open=false',
                            ['weather.raining=false', 'weather.temperature>60', 'weather.temperature<80'])]
    new_rule_patch = generateCompactFix(ltl, tap_list_buggy_2, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))

    print('---------------------------------------------------------------------')


def testcase6():
    print('----------------------------testcase6--------------------------------')
    # delete rules 3 revert
    ltl = '!G(!(location.appear=true) | (thermostat.thermostat<75 & thermostat.thermostat>70))'
    tap_list_buggy_1 = [Tap('thermostat.thermostat=72.5', 'thermostat.thermostat<70', ['location.appear=true']),
                        Tap('thermostat.thermostat=72.5', 'thermostat.thermostat>75', ['location.appear=true']),
                        Tap('thermostat.thermostat=72.5', 'thermostat.thermostat=70', ['location.appear=true']),
                        Tap('thermostat.thermostat=72.5', 'thermostat.thermostat=75', ['location.appear=true']),
                        ]
    new_rule_patch = generateCompactFix(ltl, tap_list_buggy_1, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    # change condition 1d not revert
    tap_list_buggy_2 = [Tap('thermostat.thermostat=72.5', 'thermostat.thermostat<70', ['location.appear=true']),
                        Tap('thermostat.thermostat=72.5', 'thermostat.thermostat>75', ['location.appear=true']),
                        Tap('thermostat.thermostat=72.5', 'thermostat.thermostat=70', ['location.appear=true']),
                        Tap('thermostat.thermostat=72.5', 'thermostat.thermostat=75', ['location.appear=true']),
                        Tap('thermostat.thermostat=72.5', 'location.appear=true', ['thermostat.thermostat>75']),
                        # Tap('thermostat.thermostat=72.5', 'location.appear=true', ['thermostat.thermostat=75']),
                        Tap('thermostat.thermostat=72.5', 'location.appear=true', ['thermostat.thermostat<70']),
                        Tap('thermostat.thermostat=72.5', 'location.appear=true', ['thermostat.thermostat=70']),
                        ]
    new_rule_patch = generateCompactFix(ltl, tap_list_buggy_2, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('---------------------------------------------------------------------')


def testcase7():
    print('----------------------------testcase7--------------------------------')
    ltl = 'F(@window_bath.curtain=true)'
    # add condition 1b revert
    tap_list_buggy_1 = [Tap('window_bath.curtain=false', 'window_bath.curtain=true', ['hue_light.power=true'])]
    new_rule_patch = generateCompactFix(ltl, tap_list_buggy_1, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))

    # change trigger 1a not revert
    tap_list_buggy_2 = [Tap('window_bath.curtain=false', 'window_bed.curtain=true', [])]
    new_rule_patch = generateCompactFix(ltl, tap_list_buggy_2, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))

    # change action 1e not revert
    tap_list_buggy_3 = [Tap('window_bed.curtain=false', 'window_bath.curtain=true', [])]
    new_rule_patch = generateCompactFix(ltl, tap_list_buggy_3, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))


def testcase8():
    print('----------------------------testcase8--------------------------------')
    ltl = 'F(X(@door.lock=false) & fitbit.sleep=true)'
    # modify condition 1d not revert
    tap_list_buggy_1 = [Tap('door.lock=true', 'door.lock=false', ['hue_light.power=false'])]
    new_rule_patch = generateCompactFix(ltl, tap_list_buggy_1, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    # channge action 1e not revert
    tap_list_buggy_2 = [Tap('hue_light.power=true', 'door.lock=false', ['fitbit.sleep=true'])]
    new_rule_patch = generateCompactFix(ltl, tap_list_buggy_2, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    # add condition 1b revert
    tap_list_buggy_3 = [Tap('door.lock=true', 'door.lock=false', ['fitbit.sleep=true', 'hue_light.power=true'])]
    new_rule_patch = generateCompactFix(ltl, tap_list_buggy_3, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))

    print('---------------------------------------------------------------------')


def testcase9():
    # Roomba should never be turned on within 3 hours after a guest arrives
    print('----------------------------testcase9--------------------------------')
    ltl = 'F(10800#location.appear=true & X(@roomba.power=true))'
    # modify condition 1d revert
    tap_list_buggy_1 = [Tap('roomba.power=false', 'roomba.power=true', ['7200#location.appear=true'])]
    new_rule_patch = generateCompactFix(ltl, tap_list_buggy_1, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('---------------------------------------------------------------------')


def testcase10():
    # tv.turnoff should always happen within 30 minutes after I fall asleep
    print('----------------------------testcase10--------------------------------')
    # add condition 1b revert
    ltl = '!G(!(@fitbit.sleep=true & smart_tv.power=true) | (1800#fitbit.sleep=true W @smart_tv.power=false))'
    tap_list_buggy_1 = [Tap('smart_tv.power=false', 'tick[1800#fitbit.sleep=true]', ['smart_tv.powerSetFalse', 'hue_light.power=true'])]
    new_rule_patch = generateCompactFix(ltl, tap_list_buggy_1, init_value_dict={})
    print('\n'.join([str(patch) for patch in new_rule_patch]))
    print('---------------------------------------------------------------------')


def testall():
    print('==========================Debug testing==============================')
    testcase1()
    testcase2()
    testcase3()
    testcase4()
    testcase5()
    testcase6()
    testcase7()
    testcase8()
    testcase9()
    testcase10()
    print('=====================================================================')

