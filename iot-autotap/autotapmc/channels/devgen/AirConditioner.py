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


from autotapmc.model.Template import BoolCapTemplate, NumericCapTemplate


def generateAirConditionerChannel(crit_value_list, init_value=None):
    if not init_value:
        init_value = crit_value_list[0]
    power_template = BoolCapTemplate('power', False)
    thermostat_template = NumericCapTemplate(crit_value_list, 'thermostat', init_value=init_value)
    return [power_template, thermostat_template]
