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


thermostat = {'ac': 'bool',
              'temperature': 'numeric, external',
              'thermostat': 'numeric'}
camera = {'recording': 'bool',
          'siren': 'bool',
          'motion': 'bool, external'}
roomba = {'power': 'bool'}
coffee_pot = {'numcup': 'numeric, external',
              'power': 'bool'}
faucet = {'water': 'bool'}
oven = {'lock': 'bool',
        'door': 'bool',
        'temperature': 'numeric',
        'power': 'bool'}
refrigerator = {'temperature': 'numeric, external',
                'door': 'bool',
                'temperature_ctl': 'numeric'}
fitbit = {'heart_rate': 'numeric, external',
          'sleep': 'bool, external'}
hue_light = {'brightness': 'numeric',
             'color': 'set, [red, blue, green]',
             'power': 'bool'}
location = {'appear': 'bool, external'}
echo = {'fm_tuner': 'numeric',
        'is_pop': 'bool',
        'playing': 'bool',
        'volume': 'numeric'}
smart_plug = {'power': 'bool'}
smart_tv = {'power': 'bool',
            'channel': 'numeric',
            'volume': 'numeric'}
window_liv = {'lock': 'bool',
              'curtain': 'bool',
              'open': 'bool'}
window_bath = {'lock': 'bool',
               'curtain': 'bool',
               'open': 'bool'}
window_bed = {'lock': 'bool',
              'curtain': 'bool',
              'open': 'bool'}
door = {'lock': 'bool'}
smoke_sensor = {'detect': 'bool'}
weather = {'temperature': 'numeric, external',
           'raining': 'bool, external'}
clock = {'time': 'numeric, external'}