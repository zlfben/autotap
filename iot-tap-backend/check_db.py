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

from backend import models as m
from backend import views as v

# check that there is an intersection between dev channels
# and cap channels for all dev caps
def no_hidden_caps():
    for d in m.Device.objects.all():
        for c in d.caps.all():
            x = c.channels.all().intersection(d.chans.all())
            if not x:
                return False
            else:
                print(d.name,c.name,[y.name for y in x])
    return True

# check that all users have at least one device with a readable
# cap and one device with a writeable cap
def users_can_create():
    for u in m.User.objects.all():
        userdevs = v.user_devs(u)
        if (any(map(lambda x : any(map(lambda y : y.readable,x.caps.all())),userdevs)) and
                any(map(lambda x : any(map(lambda y : y.writeable,x.caps.all())),userdevs))):
            return True
        else:
            return False


def main():
    r = {}
    r['no hidden caps'] = no_hidden_caps()
    r['users can create'] = users_can_create()
    if all(r.values()):
        print('all tests passed!')
    else:
        for val in r:
            if not r[val]:
                print(val,'failed')

    return

if __name__ == "__main__":
    main()
