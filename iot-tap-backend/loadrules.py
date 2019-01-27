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

# if Bedroom Lights are On and Echo is Playing Pop then Bedroom Lights are Purple (P5)
bedlights = m.Device.objects.get(name='Bedroom Lights')
echo = m.Device.objects.get(name='Amazon Echo')
weather = m.Device.objects.get(name='Weather Sensor')
lock = m.Device.objects.get(name='Front Door Lock')
window = m.Device.objects.get(name='Living Room Window')

t1 = m.State.objects.get(value='On',dev_id=bedlights.id)
t2 = m.State.objects.get(value='Pop',dev_id=echo.id)
astate = m.State.objects.get(value='Violet',dev_id=bedlights.id)

rule1 = m.SSRule(priority=5,actionstate=astate)
rule1.save()
rule1.triggers.add(t1,t2)
rule1.save()


t3 = m.State.objects.get(value='Nothing',dev_id=echo.id)
t4 = m.State.objects.get(value='Raining',dev_id=weather.id)
astate2 = m.State.objects.get(value='Pizza',dev_id=echo.id)

# if Nothing has been ordered and It is Raining then Order a Pizza (P6)
rule2 = m.SSRule(priority=6,actionstate=astate2)
rule2.save()
rule2.triggers.add(t3,t4)
rule2.save()

# if Nothing has been ordered and It starts Raining then Order a Pizza
rule3 = m.ESRule(triggerE=t4,actionstate=astate2)
rule3.save()
rule3.triggersS.add(t3)
rule3.save()

t5 = m.State.objects.get(value='Locked',dev_id=lock.id)
#cap_windowopen = m.Capability.objects.get(name='Open/Close Window')
astate3 = m.State.objects.get(value='Closed',dev_id=window.id)

# if It starts Raining and the Front Door is Locked within 60min then Close the Windows
rule4 = m.EERule(window=60,actionstate=astate3)
rule4.save()
rule4.triggers.add(t4,t5)
rule4.save()
