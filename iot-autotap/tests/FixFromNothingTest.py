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
from autotapmc.analyze.Fix import generateFixForSafety
from autotapmc.analyze.Draw import drawPatchList, generateGraph
import os


def mkdirWrapper(dirname):
    try:
        os.stat(dirname)
    except FileNotFoundError:
        os.mkdir(dirname)


class RainGarage(IoTSystem):
    weather = Weather()
    door = GarageDoor()

rg = RainGarage()
rg_ltl = 'F(weather.raining & door.open)'

fix_result = generateFixForSafety(rg, rg_ltl)
print(fix_result[0][0][0].log())
print(fix_result[1][0][0].log())
mkdirWrapper('temp')
mkdirWrapper('temp/multi')

generateGraph(rg, rg_ltl, 'temp/multi/original')
