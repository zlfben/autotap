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


from autotapmc.model.IoTSystem import IoTSystem
from autotapmc.model.Tap import EERule, ESERule, SSERule, SERule
from autotapmc.model.Channel import Channel
from autotapmc.analyze.Fix import generateFixForSafety
from autotapmc.analyze.Draw import drawPatchList

import os


def mkdirWrapper(dirname):
    try:
        os.stat(dirname)
    except FileNotFoundError:
        os.mkdir(dirname)


class GarageDoor(Channel):
    door_open = 0

    def enable_open(self):
        return self.door_open == 0

    def action_open(self):
        self.door_open = 1

    def enable_close(self):
        return self.door_open == 1

    def action_close(self):
        self.door_open = 0

    def ap_open(self):
        return self.door_open


class Weather(Channel):
    rain = 0

    def enable_startsRaining(self):
        return self.rain == 0

    def extaction_startsRaining(self):
        self.rain = 1

    def enable_stopsRaining(self):
        return self.rain == 1

    def extaction_stopsRaining(self):
        self.rain = 0

    def ap_raining(self):
        return self.rain

class SimpleCoffeeMachine(Channel):
    status = 0
    # 0: idle, 1: brewing, 2: wrong

    def enable_brew(self):
        return self.status == 0

    def action_brew(self):
        if self.status != 0:
            self.status = 2
        else:
            self.status = 1

    def action_tick(self):
        if self.status == 1:
            self.status = 0

    def enable_tick(self):
        return 1

    def ap_brewing(self):
        return self.status == 1

    def ap_wrong(self):
        return self.status == 2


class Location(Channel):
    within = 0

    def enable_walkin(self):
        return self.within == 0

    def action_walkin(self):
        self.within = 1

    def enable_walkout(self):
        return self.within == 1

    def action_walkout(self):
        self.within = 0

    def ap_within(self):
        return self.within


class RainGarage(IoTSystem):
    door = GarageDoor()
    weather = Weather()
    rule = ESERule('weather.startsRaining', 'door.open', 'door.close')


class CoffeeBrewing(IoTSystem):
    coffee_machine = SimpleCoffeeMachine()
    loc = Location()
    rule = EERule('loc.walkin', 'coffee_machine.brew')


rg = RainGarage()
rg_ltl = 'F (weather.raining & door.open)'

mkdirWrapper('temp')

rg.transition_system.writeToGv('temp/test.gv')
os.system('dot -Tpng -o temp/test.png temp/test.gv')

patch_result = generateFixForSafety(rg, rg_ltl)
print(patch_result)
patch_result[0][0][0].log()


# cb = CoffeeBrewing()
# cb_ltl = 'F (coffee_machine.wrong)'
#
# cb.transition_system.writeToGv('temp/test.gv')
# os.system('dot -Tpng -o temp/test.png temp/test.gv')
#
# patch_result = generateFixForSafety(cb, cb_ltl)
# print(patch_result)
# for patch in patch_result[0][0]:
#     patch.log()