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
from django.contrib.auth.models import User

# Create your models here.

class Rule(models.Model):
    rule_name = models.CharField(max_length=200, null=False)

class Device(models.Model):
    device_name = models.CharField(max_length=200, null=False)
    users = models.ManyToManyField(User)

class AbstractCharecteristic(models.Model):
    characteristic_name = models.CharField(max_length=200, null=False)

class DeviceCharecteristic(models.Model):
    device = models.ForeignKey(Device, on_delete=models.CASCADE)
    abstract_charecteristic = models.ForeignKey(AbstractCharecteristic,
                                                on_delete=models.CASCADE)
    affected_rules = models.ManyToManyField(Rule)
