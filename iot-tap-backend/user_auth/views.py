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

from django.shortcuts import render
from django.contrib.auth.models import User
from django.contrib.auth import authenticate

# Create your views here.
def new_user(request,**kwargs):
    user = User.objects.create_user(
            username=kwargs['username'],
            email=kwargs['email'],
            password=kwargs['password'],
            first_name=kwargs['fname'] if kwargs['fname'] else "",
            last_name=kwargs['lname'] if kwargs['lname'] else "")
    user.save()
    html = "<html><body><h1>Welcome, %s!</h1></body></html>" % kwargs['username']
    return HttpResponse(html)

def try_login(request,**kwargs):
    user = authenticate(username=kwargs['username'],password=kwargs['password'])
    if user is not None:
        html = "<html><body><p>Login Successful</p></body></html>"
        return HttpResponse(html)
    else:
        html = "<html><body><p>Login Failed</p></body></html>"
        return HttpResponse(html)
