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

from autotapmc.channels.CoffeeMachine import CoffeeMachine
from autotapmc.channels.Location import Location
from autotapmc.channels.Weather import Weather
from autotapmc.channels.GarageDoor import GarageDoor
from autotapmc.model.Tap import ESERule, EERule, SSERule
from autotapmc.model.IoTSystem import IoTSystem
import os


class RainGarage1(IoTSystem):
    weather = Weather()
    door = GarageDoor()
    rule = ESERule('weather.startsRaining', 'door.open', 'door.close')


class RainGarage2(IoTSystem):
    weather = Weather()
    door = GarageDoor()
    rule1 = ESERule('weather.startsRaining', 'door.open', 'door.close')
    rule2 = ESERule('door.open', 'weather.raining', 'door.close')


class CoffeeTest1(IoTSystem):
    coffee_machine = CoffeeMachine()
    loc = Location()
    rule = EERule('loc.walkin', 'coffee_machine.brew')


class CoffeeTest2(IoTSystem):
    coffee_machine = CoffeeMachine()
    weather = Weather()
    rule = ESERule('weather.startsRaining', 'coffee_machine.poweron', 'coffee_machine.turnoff')


try:
    os.stat('temp')
except FileNotFoundError:
    os.mkdir('temp')

rg1 = RainGarage1()
rg2 = RainGarage2()
ct1 = CoffeeTest1()
ct2 = CoffeeTest2()


rg1.transition_system.writeToGv('temp/rg1.gv')
rg2.transition_system.writeToGv('temp/rg2.gv')
ct1.transition_system.writeToGv('temp/ct1.gv')
ct2.transition_system.writeToGv('temp/ct2.gv')
