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


from autotapmc.model.Channel import Channel


class Outlet(Channel):
    power = 0

    def enable_poweron(self):
        return not self.power

    def action_poweron(self):
        self.power = 1

    def enable_poweroff(self):
        return self.power

    def action_poweroff(self):
        self.power = 0

    def ap_on(self):
        return self.power
