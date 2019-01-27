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


class Clock(Channel):
    inzone = 0

    def enable_enterzone(self):
        return not self.inzone

    def extaction_enterzone(self):
        self.inzone = 1

    def enable_leavezone(self):
        return self.inzone

    def extaction_leavezone(self):
        self.inzone = 0

    def ap_inzone(self):
        return self.inzone
