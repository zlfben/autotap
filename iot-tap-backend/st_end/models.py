"""
Copyright (C) 2018-2019  Jesse Martinez, Lefan Zhang, Weijia He, Noah Brackenbury

iot-tap-backend is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

iot-tap-backend is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with iot-tap-backend.  If not, see <https://www.gnu.org/licenses/>.
"""

from django.db import models

class STApp(models.Model):
	st_installed_app_id = models.CharField(max_length = 40, null = False)
	refresh_token = models.CharField(max_length = 40, null = False)

class Device(models.Model):
    """
    Info about a device
    """
    device_id = models.CharField(max_length = 40)
    device_name = models.CharField(max_length = 80)
    device_label = models.CharField(max_length = 80)