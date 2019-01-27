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

from . import views as v

# {reqname : func}
reqmap = {
        'get_chans' : v.fe_all_chans,
        'get_devs_and_chans' : v.fe_all_devs_and_chans,
        'get_devs_with_chan' : v.fe_devs_with_chan,
        'get_chans_with_dev' : v.fe_chans_with_dev,
        'get_caps' : v.fe_get_valid_caps,
        'get_params' : v.fe_get_params,
        'make_esrule' : v.fe_create_esrule,
        'view_device_status' : v.fe_current_device_status,
        'view_device_history' : v.fe_device_history
        }

def urlmap(request,**kwargs):
    f = reqmap[kwargs['reqname']]
    return f(request,kwargs)
