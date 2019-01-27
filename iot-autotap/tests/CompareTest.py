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


from autotapmc.analyze.Analyze import compareRules
from autotapmc.model.Tap import Tap
import autotapmc.channels.template.Evaluation as TemplateDict


template_dict = TemplateDict.__dict__
ltl = 'F(window_liv.open=true & weather.raining=true)'
# change trigger event 1a not revert
# tap_list_buggy = [Tap('window_liv.open=false', 'window_liv.open=true', ['weather.raining=true']),
#                   Tap('window_liv.open=false', 'weather.raining=false', ['window_liv.open=true'])]
tap_list_buggy = []
tap_list_correct = [Tap('window_liv.open=false', 'window_liv.open=true', ['weather.raining=true']),
                    Tap('window_liv.open=false', 'weather.raining=true', ['window_liv.open=true'])]
result = compareRules(tap_list_buggy, tap_list_correct, ltl, template_dict)
print(result)