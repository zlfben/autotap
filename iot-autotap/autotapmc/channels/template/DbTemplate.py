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


template_dict = {
    'living_room_window': {'openclose_curtains_position': 'bool', 'openclose_window_position': 'bool'},
    'smart_tv': {'power_onoff_setting': 'bool', 'volume_level': 'numeric', 'channel_channel': 'numeric'},
    'speakers': {'fm_tuner_frequency': 'numeric', 'power_onoff_setting': 'bool', 'volume_level': 'numeric', 'genre_genre': 'set, [Pop, Jazz, R&B, Hip-Hop, Rap, Country, News]'},
    'power_main': {'power_onoff_setting': 'bool'},
    'location_sensor': {'kitchen_alice': 'bool, external', 'bathroom_a_family_member': 'bool, external', 'bathroom_a_guest': 'bool, external', 'living_room_nobody': 'bool, external', 'living_room_bobbie': 'bool, external', 'bedroom_nobody': 'bool, external', 'bedroom_bobbie': 'bool, external', 'home_nobody': 'bool, external', 'living_room_alice': 'bool, external', 'bedroom_a_guest': 'bool, external', 'bedroom_alice': 'bool, external', 'bathroom_bobbie': 'bool, external', 'bathroom_anyone': 'bool, external', 'home_anyone': 'bool, external', 'bedroom_anyone': 'bool, external', 'kitchen_nobody': 'bool, external', 'bedroom_a_family_member': 'bool, external', 'kitchen_bobbie': 'bool, external', 'bathroom_alice': 'bool, external', 'home_alice': 'bool, external', 'home_bobbie': 'bool, external', 'kitchen_anyone': 'bool, external', 'home_a_family_member': 'bool, external', 'living_room_a_guest': 'bool, external', 'kitchen_a_family_member': 'bool, external', 'living_room_a_family_member': 'bool, external', 'home_a_guest': 'bool, external', 'kitchen_a_guest': 'bool, external', 'living_room_anyone': 'bool, external', 'bathroom_nobody': 'bool, external'},
    'thermostat': {'thermostat_temperature': 'numeric', 'ac_onoff_setting': 'bool', 'current_temperature_temperature': 'numeric, external'},
    'smart_oven': {'openclose_door_position': 'bool', 'oven_temperature_temperature': 'numeric', 'lockunlock_setting': 'bool', 'power_onoff_setting': 'bool'},
    'bedroom_window': {'openclose_curtains_position': 'bool', 'lockunlock_setting': 'bool', 'openclose_window_position': 'bool'},
    'smoke_detector': {'smoke_detection_condition': 'bool, external'},
    'smart_plug': {'power_onoff_setting': 'bool'},
    'fitbit': {'sleep_sensor_status': 'bool, external', 'heart_rate_sensor_bpm': 'numeric, external'},
    'smart_faucet': {'water_onoff_setting': 'bool'},
    'front_door_lock': {'lockunlock_setting': 'bool'},
    'weather_sensor': {'is_it_raining_condition': 'bool, external', 'weather_sensor_weather': 'set, external, [Sunny, Cloudy, Partly Cloudy, Raining, Thunderstorms, Snowing, Hailing, Clear]', 'current_temperature_temperature': 'numeric, external'},
    'security_camera': {'record_value': 'bool', 'detect_motion_status': 'bool, external', 'power_onoff_setting': 'bool', 'siren_value': 'bool'},
    'hue_lights': {'power_onoff_setting': 'bool', 'light_color_color': 'set, [Red, Orange, Yellow, Green, Blue, Violet]', 'brightness_level': 'numeric'},
    'roomba': {'power_onoff_setting': 'bool'},
    'amazon_echo': {'fm_tuner_frequency': 'numeric', 'volume_level': 'numeric', 'genre_genre': 'set, [Pop, Jazz, RB, HipHop, Rap, Country, News]'},
    'clock': {'alarm_ringing_value': 'bool', 'is_it_daytime_time': 'bool, external'},
    'coffee_pot': {'how_much_coffee_is_there_cups': 'numeric, external', 'power_onoff_setting': 'bool', 'brew_coffee_cups': 'numeric'},
    'smart_refrigerator': {'openclose_door_position': 'bool', 'current_temperature_temperature': 'numeric, external', 'temperature_control_temperature': 'numeric'},
    'bathroom_window': {'openclose_curtains_position': 'bool', 'openclose_window_position': 'bool'}
}
