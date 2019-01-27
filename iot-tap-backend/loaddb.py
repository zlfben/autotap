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

#### CHANNELS & CAPABILITIES ####

# Power Channel
ch_power = m.Channel(name='Power')
ch_power.save()

cap_power = m.Capability(
        name='Power',
        channel=ch_power,
        changeable=True,
        statelabel="$$DEVICE$$ is $$STATE$$",
        commandlabel="Turn $$DEVICE$$ $$STATE$$",
        e_startlabel="$$DEVICE$$ turns $$STATE$$"
        )
cap_power.save()

# Lights Channel
ch_lights = m.Channel(name='Lighting')
ch_lights.save()

cap_brightness = m.Capability(
        name='Brightness',
        channel=ch_lights,
        changeable=True,
        #statelabel="$$DEVICE$$'s Brightness is $$STATE$$",
        #commandlabel="Set $$DEVICE$$'s Brightness to $$STATE$$",
        #e_startlabel="$$DEVICE$$'s Brightness is changed to $$STATE$$",
        #e_endlabel="$$DEVICE$$'s Brightness is changed from $$STATE$$"
        )
cap_color = m.Capability(
        name='Light Color',
        channel=ch_lights,
        changeable=True,
        #statelabel="$$DEVICE$$'s Color is $$STATE$$",
        #commandlabel="Set $$DEVICE$$'s Color to $$STATE$$",
        #e_startlabel = "$$DEVICE$$'s Color is changed to $$STATE$$",
        #e_endlabel = "$$DEVICE$$'s Color is changed from $$STATE$$"
        )
cap_effect = m.Capability(
        name='Light Effects',
        channel=ch_lights,
        changeable=True,
        #statelabel="$$DEVICE$$'s Effect is $$STATE$$",
        #commandlabel="Set $$DEVICE$$'s Effect to $$STATE$$",
        #e_startlabel = "$$DEVICE$$'s Effect is changed to $$STATE$$",
        #e_endlabel = "$$DEVICE$$'s Effect is changed from $$STATE$$"
        )
cap_daylight = m.Capability(
        name='Daylight',
        channel=ch_lights,
        changeable=False,
        statelabel="There is $$STATE$$",
        e_startlabel="There starts to be $$STATE$$",
        e_endlabel="There stops being $$STATE$$")

light_caps = [cap_brightness,cap_color,cap_effect,cap_daylight]
for cap in light_caps:
    cap.save()

# Music Channel
ch_music = m.Channel(name='Music')
ch_music.save()

cap_volume = m.Capability(
        name='Volume',
        channel=ch_music,
        changeable=True,
        #statelabel="$$DEVICE$$'s Volume is $$STATE$$",
        #commandlabel="Set $$DEVICE$$'s Volume to $$STATE$$",
        )
cap_genre = m.Capability(
        name='Genre',
        channel=ch_music,
        changeable=True,
        statelabel="$$DEVICE$$ is playing $$STATE$$",
        commandlabel="Start playing $$STATE$$ on $$DEVICE$$",
        e_startlabel="$$DEVICE$$ starts playing $$STATE",
        e_endlabel="$$DEVICE$$ stops playing $$STATE$$"
        )

music_caps = [cap_volume,cap_genre]
for cap in music_caps:
    cap.save()

# Locks Channel
ch_locks = m.Channel(name='Locks')
ch_locks.save()

cap_lock = m.Capability(
        name='Lock/Unlock',
        channel=ch_locks,
        changeable=True,
        statelabel="$$DEVICE$$ is $$STATE$$",
        commandlabel="Make $$DEVICE$$ $$STATE$$",
        e_startlabel="$$DEVICE$$ becomes $$STATE$$",
        e_endlabel="$$DEVICE$$ stops being $$STATE$$"
        )
cap_lock.save()

# Windows Channel
ch_windows = m.Channel(name='Windows')
ch_windows.save()

cap_openwindow = m.Capability(
        name='Open/Close Window',
        channel=ch_windows,
        changeable=True,
        statelabel="$$DEVICE$$ is $$STATE$$",
        commandlabel="Make $$DEVICE$$ $$STATE$$",
        e_startlabel="$$DEVICE$$ becomes $$STATE$$",
        e_endlabel="$$DEVICE$$ stops being $$STATE$$"
        )
cap_curtains = m.Capability(
        name='Open/Close Blinds',
        channel=ch_windows,
        changeable=True,
        statelabel="$$DEVICE$$'s Curtains are $$STATE$$",
        commandlabel="Make $$DEVICE$$'s Curtains $$STATE$$",
        e_startlabel="$$DEVICE$$'s Curtains become $$STATE$$",
        e_endlabel="$$DEVICE$$'s Curtains stop being $$STATE$$")

windows_caps = [cap_openwindow,cap_curtains]
for cap in windows_caps:
    cap.save()

# Cooking Channel
ch_cooking = m.Channel(name='Cooking')
ch_cooking.save()

cap_oventemp = m.Capability(
        name='Oven Temperature',
        channel=ch_cooking,
        changeable=True,
        statelabel="$$DEVICE$$ is set to $$STATE$$",
        commandlabel="Set $$DEVICE$$ to $$STATE$$",
        e_startlabel="$$DEVICE$$ reaches $$STATE$$",
        e_endlabel="$$DEVICE$$ stops being $$STATE$$")
## add more

cooking_caps = [cap_oventemp]
for cap in cooking_caps:
    cap.save()


# Weather Channel
ch_weather = m.Channel(name='Weather')
ch_weather.save()

cap_rain_bin = m.Capability(
        name='Is it Raining?',
        channel=ch_weather,
        changeable=False,
        statelabel='It is $$STATE$$',
        e_startlabel="It starts $$STATE$$",
        e_endlabel="It stops $$STATE$$"
        )
cap_rain = m.Capability(
        name='Rain',
        channel=ch_weather,
        changeable=False,
        statelabel='There is $$STATE$$',
        e_startlabel='There starts to be $$STATE$$',
        e_endlabel='There stops being $$STATE$$'
        )
cap_wind = m.Capability(
        name='Wind',
        channel=ch_weather,
        changeable=False,
        statelabel='There is $$STATE$$',
        e_startlabel='There starts to be $$STATE$$',
        e_endlabel='There stops being $$STATE$$'
        )
cap_cur_weather = m.Capability(
        name='Current Weather',
        channel=ch_weather,
        changeable=False,
        statelabel='The weather is $$STATE$$',
        e_startlabel='The weather changes to $$STATE$$',
        e_endlabel='The weather changes from $$STATE$$'
        )

weather_caps = [cap_rain_bin,cap_rain,cap_wind,cap_cur_weather]
for cap in weather_caps:
    cap.save()

# Shopping Channel
ch_shopping = m.Channel(name='Shopping')
ch_shopping.save()

cap_order = m.Capability(
        name='Order',
        channel=ch_shopping,
        changeable=True,
        statelabel='$$STATE$$ has been ordered',
        commandlabel='Order $$STATE$$',
        e_startlabel=None,
        e_endlabel=None
        )

shopping_caps = [cap_order]
for cap in shopping_caps:
    cap.save()

'''
# Location Channel
ch_location = m.Channel(name='Location')
ch_location.save()


# Temperature Channel
ch_temperature = m.Channel(name='Temperature')
ch_temperature.save()


# Time Channel
ch_time = m.Channel(name='Time')
ch_time.save()
'''




#### DEVICES ####

# Kitchen Lights (on/off)
dev_klights = m.Device(name='Kitchen Lights')
dev_klights.save()
dev_klights.caps.add(cap_power)
dev_klights.save()

for val in ['On','Off']:
    m.State(cap=cap_power,dev=dev_klights,value=val,bi=True).save()


# Bathroom Lights (on/off)
dev_brlights = m.Device(name='Bathroom Lights')
dev_brlights.save()
dev_brlights.caps.add(cap_power)
dev_brlights.save()
for val in ['On','Off']:
    m.State(cap=cap_power,dev=dev_brlights,value=val,bi=True).save()


# Bedroom Lights (on/off,white/red/blue/yellow,solid/flicker/strobe)
dev_bedlights = m.Device(name='Bedroom Lights')
dev_bedlights.save()
dev_bedlights.caps.add(cap_power,cap_color,cap_effect)
dev_bedlights.save()

for val in ['On','Off']:
    m.State(cap=cap_power,dev=dev_bedlights,value=val,bi=True).save()

for val in ['White','Red','Orange','Yellow','Green','Blue','Violet']:
    m.State(cap=cap_color,dev=dev_bedlights,value=val).save()

for val in ['Solid','Flicker','Strobe']:
    m.State(cap=cap_effect,dev=dev_bedlights,value=val).save()


# Living Room Lights (on/off,1-5,white/red/blue/yellow)
dev_lrlights = m.Device(name='Living Room Lights')
dev_lrlights.save()
dev_lrlights.caps.add(cap_power,cap_brightness,cap_color)
dev_lrlights.save()


for val in ['On','Off']:
    m.State(cap=cap_power,dev=dev_lrlights,value=val,bi=True).save()

for val in ['1 (Min)','2','3','4','5 (Max)']:
    m.State(cap=cap_brightness,dev=dev_lrlights,value=val).save()

for val in ['White','Red','Orange','Yellow','Green','Blue','Violet']:
    m.State(cap=cap_color,dev=dev_lrlights,value=val).save()

# Front Door Lock (lock/unlocked)
dev_frontdoor = m.Device(name='Front Door Lock')
dev_frontdoor.save()
dev_frontdoor.caps.add(cap_lock)
dev_frontdoor.save()

for val in ['Locked','Unlocked']:
    m.State(cap=cap_lock,dev=dev_frontdoor,value=val,bi=True).save()

# Bedroom Window (open/close,curtains)
dev_bwindow = m.Device(name='Bedroom Window')
dev_bwindow.save()
dev_bwindow.caps.add(cap_openwindow,cap_curtains)
dev_bwindow.save()

for val in ['Open','Closed']:
    m.State(cap=cap_openwindow,dev=dev_bwindow,value=val,bi=True).save()
for val in ['Open','Closed']:
    m.State(cap=cap_curtains,dev=dev_bwindow,value=val,bi=True).save()

# Living Room Window (curtains)
dev_lrwindow = m.Device(name='Living Room Window')
dev_lrwindow.save()
dev_lrwindow.caps.add(cap_curtains)
dev_lrwindow.save()

for val in ['Open','Closed']:
    m.State(cap=cap_curtains,dev=dev_lrwindow,value=val,bi=True).save()

# Kitchen Radio (off/low/high,jazz/pop/news/rock/rap/r&b)
dev_kradio = m.Device(name='Kitchen Radio')
dev_kradio.save()
dev_kradio.caps.add(cap_power,cap_volume,cap_genre)
dev_kradio.save()

for val in ['On','Off']:
    m.State(cap=cap_power,dev=dev_kradio,value=val,bi=True).save()
for val in ['1 (Min)','2','3','4','5 (Max)']:
    m.State(cap=cap_volume,dev=dev_kradio,value=val).save()
for val in ['Jazz','Pop','News','Rock','Rap','R&B']:
    m.State(cap=cap_genre,dev=dev_kradio,value=val).save()


# Living Room Record Player (on/low/high)
dev_record = m.Device(name='Record Player')
dev_record.save()
dev_record.caps.add(cap_power,cap_volume)
dev_record.save()

for val in ['On','Off']:
    m.State(cap=cap_power,dev=dev_record,value=val,bi=True).save()
for val in ['Low','Medium','High']:
    m.State(cap=cap_volume,dev=dev_record,value=val).save()

# Bathroom Radio (on/low/high,jazz/popo/news/rock/rap/r&b)
dev_brradio = m.Device(name='Bathroom Radio')
dev_brradio.save()
dev_brradio.caps.add(cap_power,cap_volume,cap_genre)
dev_brradio.save()

for val in ['On','Off']:
    m.State(cap=cap_power,dev=dev_brradio,value=val,bi=True).save()
for val in ['1 (Min)','2','3','4','5 (Max)']:
    m.State(cap=cap_volume,dev=dev_brradio,value=val).save()
for val in ['Jazz','Pop','News','Rock','Rap','R&B']:
    m.State(cap=cap_genre,dev=dev_brradio,value=val).save()

# Amazon Echo in Bedroom
dev_echo = m.Device(name='Amazon Echo')
dev_echo.save()
dev_echo.caps.add(cap_power,cap_volume,cap_genre,cap_order) #add more
dev_echo.save()

for val in ['On','Off']:
    m.State(cap=cap_power,dev=dev_echo,value=val,bi=True).save()
for val in ['Low','Medium','High']:
    m.State(cap=cap_volume,dev=dev_echo,value=val).save()
for val in ['Jazz','Pop','News','Rock','Rap','R&B']:
    m.State(cap=cap_genre,dev=dev_echo,value=val).save()
for val in ['Nothing','Pizza','Groceries','Toilet Paper']:
    m.State(cap=cap_order,dev=dev_echo,value=val).save()


# Oven
dev_oven = m.Device(name='Oven')
dev_oven.save()
dev_oven.caps.add(cap_power,cap_oventemp)
dev_oven.save()

for val in ['On','Off']:
    m.State(cap=cap_power,dev=dev_oven,value=val,bi=True).save()
for val in ['250','275','300','325','350','375','400','425','450','475','500']:
    m.State(cap=cap_oventemp,dev=dev_oven,value=val).save()

# Weather Sensor
dev_weather = m.Device(name='Weather Sensor')
dev_weather.save()
dev_weather.caps.add(cap_rain,cap_rain_bin,cap_wind,cap_cur_weather)
dev_weather.save()

for val in ['Not Raining','Raining']:
    m.State(cap=cap_rain_bin,dev=dev_weather,value=val,bi=True).save()
for val in ['No Rain','Light Rain','Moderate Rain','Heavy Rain']:
    m.State(cap=cap_rain,dev=dev_weather,value=val).save()
for val in ['No Wind','Light Wind','Some Wind','Strong Wind']:
    m.State(cap=cap_wind,dev=dev_weather,value=val).save()
for val in ['Sunny','Partly Sunny','Partly Cloudy','Cloudy','Lightly Raining','Thunderstorms','Blizzard']:
    m.State(cap=cap_cur_weather,dev=dev_weather,value=val).save()
