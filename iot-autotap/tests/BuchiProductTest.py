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
from autotapmc.model.IoTSystem import IoTSystem
from autotapmc.model.Tap import ESERule
import autotapmc.buchi.Buchi as Buchi


class Test(IoTSystem):
    weather = Weather()
    door = GarageDoor()
    rule = ESERule('weather.startsRaining', 'door.open', 'door.close')


a = Test()
ts = a.transition_system

buchi_ts = Buchi.tsToGenBuchi(ts)
buchi_ltl = Buchi.ltlToBuchi('F (door.open & weather.raining)')

(buchi_final, pairs) = Buchi.product(buchi_ts, buchi_ltl)
buchi_ts.log()
buchi_ltl.log()
buchi_final.log()

group = [s2 for s1, s2 in pairs]

buchi_final.printToGv(group)

