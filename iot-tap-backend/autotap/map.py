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

import backend.models as m


device_template = {
    'location_sensor': {'bedroom_anyone': 'bool, external', 'bathroom_nobody': 'bool, external', 'living_room_a_family_member': 'bool, external', 'bathroom_alice': 'bool, external', 'kitchen_a_family_member': 'bool, external', 'bedroom_nobody': 'bool, external', 'bedroom_a_guest': 'bool, external', 'kitchen_a_guest': 'bool, external', 'kitchen_alice': 'bool, external', 'bathroom_a_guest': 'bool, external', 'kitchen_anyone': 'bool, external', 'home_anyone': 'bool, external', 'home_a_family_member': 'bool, external', 'kitchen_nobody': 'bool, external', 'living_room_a_guest': 'bool, external', 'home_alice': 'bool, external', 'kitchen_bobbie': 'bool, external', 'bathroom_a_family_member': 'bool, external', 'living_room_alice': 'bool, external', 'bedroom_alice': 'bool, external', 'bathroom_bobbie': 'bool, external', 'living_room_anyone': 'bool, external', 'home_a_guest': 'bool, external', 'bedroom_a_family_member': 'bool, external', 'home_bobbie': 'bool, external', 'bathroom_anyone': 'bool, external', 'living_room_bobbie': 'bool, external', 'living_room_nobody': 'bool, external', 'bedroom_bobbie': 'bool, external', 'home_nobody': 'bool, external'},
    'front_door_lock': {'lockunlock_setting': 'bool'},
    'roomba': {'power_onoff_setting': 'bool'},
    'weather_sensor': {'current_temperature_temperature': 'numeric, external', 'is_it_raining_condition': 'bool, external', 'weather_sensor_weather': 'set, external, [Sunny, Cloudy, PartlyCloudy, Raining, Thunderstorms, Snowing, Hailing, Clear]'},
    'fitbit': {'sleep_sensor_status': 'bool, external', 'heart_rate_sensor_bpm': 'numeric, external'},
    'smart_faucet': {'water_onoff_setting': 'bool'},
    'security_camera': {'record_value': 'bool', 'detect_motion_status': 'bool, external', 'power_onoff_setting': 'bool', 'siren_value': 'bool'},
    'coffee_pot': {'power_onoff_setting': 'bool', 'brew_coffee_cups': 'numeric', 'how_much_coffee_is_there_cups': 'numeric, external'},
    'clock': {'is_it_daytime_time': 'bool, external', 'alarm_ringing_value': 'bool'},
    'thermostat': {'current_temperature_temperature': 'numeric, external', 'ac_onoff_setting': 'bool', 'thermostat_temperature': 'numeric'},
    'bathroom_window': {'openclose_window_position': 'bool', 'openclose_curtains_position': 'bool'},
    'smart_plug': {'power_onoff_setting': 'bool'},
    'power_main': {'power_onoff_setting': 'bool'},
    'speakers': {'genre_genre': 'set, [Pop, Jazz, RnB, Hip-Hop, Rap, Country, News, Stop]', 'power_onoff_setting': 'bool', 'fm_tuner_frequency': 'numeric', 'volume_level': 'numeric'},
    'hue_lights': {'power_onoff_setting': 'bool', 'light_color_color': 'set, [Red, Orange, Yellow, Green, Blue, Violet]', 'brightness_level': 'numeric'},
    'smart_tv': {'power_onoff_setting': 'bool', 'channel_channel': 'numeric', 'volume_level': 'numeric'},
    'bedroom_window': {'openclose_window_position': 'bool', 'openclose_curtains_position': 'bool', 'lockunlock_setting': 'bool'},
    'smart_oven': {'power_onoff_setting': 'bool', 'openclose_door_position': 'bool', 'oven_temperature_temperature': 'numeric', 'lockunlock_setting': 'bool'},
    'amazon_echo': {'genre_genre': 'set, [Pop, Jazz, RnB, Hip-Hop, Rap, Country, News, Stop]', 'fm_tuner_frequency': 'numeric', 'volume_level': 'numeric'},
    'smart_refrigerator': {'temperature_control_temperature': 'numeric', 'openclose_door_position': 'bool', 'current_temperature_temperature': 'numeric, external'},
    'living_room_window': {'openclose_window_position': 'bool', 'openclose_curtains_position': 'bool'},
    'smoke_detector': {'smoke_detection_condition': 'bool, external'}
}

device_list_backend = [dev.name for dev in m.Device.objects.all().order_by('id')]


def dev_map_to_backend(dev_name):
    device_list_backend = list(m.Device.objects.all().order_by('id'))
    def _dev_name_to_autotap(name):
        name = name.replace(' ', '_').lower()
        name = ''.join([ch for ch in name if ch.isalnum() or ch == '_'])
        return name

    device_name_list_backend = [_dev_name_to_autotap(dev.name) for dev in device_list_backend]
    device_list_index = device_name_list_backend.index(dev_name)
