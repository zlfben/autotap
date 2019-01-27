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


from autotapmc.channels.Weather import Weather
from autotapmc.channels.GarageDoor import GarageDoor
from autotapmc.channels.Location import Location
from autotapmc.channels.CoffeeMachine import SimpleCoffeeMachine
from autotapmc.model.IoTSystem import IoTSystem
from autotapmc.model.Tap import ESERule, SSERule, EERule
from autotapmc.analyze.Fix import generateFixForSafety
import os


def mkdirWrapper(dirname):
    try:
        os.stat(dirname)
    except FileNotFoundError:
        os.mkdir(dirname)


class RainGarage(IoTSystem):
    weather = Weather()
    door = GarageDoor()
    rule = ESERule('weather.startsRaining', 'door.open', 'door.close')


class CoffeeBrewing(IoTSystem):
    coffee_machine = SimpleCoffeeMachine()
    loc = Location()
    rule = EERule('loc.walkin', 'coffee_machine.brew')


mkdirWrapper('temp')

rg = RainGarage()
rg_ltl = 'F (!rule & weather.raining & door.open)'
patch_result = generateFixForSafety(rg, rg_ltl)
print(patch_result[0][0][0].log())

cb = CoffeeBrewing()
cb_ltl = 'F (coffee_machine.wrong)'
patch_result = generateFixForSafety(cb, cb_ltl)
print(patch_result[0][0][0].log())
print(patch_result[0][0][1].log())
