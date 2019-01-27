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


import autotapmc.buchi.Buchi as Buchi

buchi = Buchi.Buchi()

buchi.addAp('p1')
buchi.addAp('p2')

buchi.addState(0, 'State 0', 0)
buchi.addState(1, 'ACC_State 1', 1)
buchi.addState(2, 'State 2', 0)

buchi.setInitState(0)
buchi.addEdge(0, 1, 'p1')
buchi.addEdge(1, 1, 'p1 & p2')
buchi.addEdge(1, 2, 'p2')
buchi.addEdge(2, 1, 'p1 | p2')

(aut, state_map) = buchi.toSpot()

print(aut.to_str('hoa'))
