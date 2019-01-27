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

"""backend URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include
from . import views as v


urlpatterns = [
    path('admin/',admin.site.urls),
    path('st_end/', include('st_end.urls')),
    path('user/get/',v.fe_get_user),
    path('user/rules/',v.fe_all_rules),
    path('user/chans/',v.fe_all_chans),
    path('user/chans/devs/',v.fe_devs_with_chan),
    path('user/chans/devs/caps/',v.fe_get_valid_caps),
    path('user/chans/devs/caps/params/',v.fe_get_params),
    path('user/rules/new/',v.fe_create_esrule),
    path('user/rules/delete/',v.fe_delete_rule),
    path('user/rules/get/',v.fe_get_full_rule),
    path('user/sps/',v.fe_all_sps),
    path('user/sp1/new/',v.fe_create_sp1),
    path('user/sp2/new/',v.fe_create_sp2),
    path('user/sp3/new/',v.fe_create_sp3),
    path('user/sps/delete/',v.fe_delete_sp),
    path('user/sps/get/',v.fe_get_full_sp),
    path('user/sp1/get/',v.fe_get_full_sp1),
    path('user/sp2/get/',v.fe_get_full_sp2),
    path('user/sp3/get/',v.fe_get_full_sp3),
    path('user/get_cookie/', v.fe_get_cookie),
    path('manage/', v.manage_user),
    path('autotap/', include('autotap.urls'))
    ]
'''
    #path('user/new/<str:username>/<str:pass>/',views.new_user),
    path('ch<int:channelid>/devices/',views.devs_with_chan),
    path('dev<int:deviceid>/channels/',views.chans_with_dev),
    #path('user/login/<str:username>/<str:pass>/',views.try_login),
    path('rule/<str:temp>/<int:ruleid>/',views.view_rule),
    #path('rule/new/<str:temp>/<str:field1>/<str:field2>/',views.create_rule),
    path('rule/<str:temp>/<int:field2>/<str:triggerids>/<int:actionid>/',views.create_rule),
    path('dev<int:deviceid>/ch<int:channelid>/',views.get_all_caps),
    path('ch<int:channelid>/dev<int:deviceid>/',views.get_all_caps),
    path('dev<int:deviceid>/cap<int:capid>/<str:value>/log/',views.update_state),
    path('dev<int:deviceid>/status/',views.current_device_status),
    path('dev<int:deviceid>/history/',views.device_history),
    path('dev<int:deviceid>/history/<int:timedelta>/',views.historical_device_status),
    path('rule/es/<int:triggerid>/triggers/',views.es_rules_triggered),
    path('update/<int:capid>/<int:deviceid>/<int:paramid>/<str:value>/',views.process_st_update)
]
'''
