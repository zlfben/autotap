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


from autotapmc.ltl.Parser import parse
from autotapmc.ltl.SubFormula import analyze


a = 'p U (p ^ !q)'
b = '!(true U (door ^ rain))'
c = 'true U (X q)'
d = '!(p U q)'

rna = parse(d)

print(rna)

(sub, rel) = analyze(rna)

print(sub)
for item in rel:
    print(item.log())
