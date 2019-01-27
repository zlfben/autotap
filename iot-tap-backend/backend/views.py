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

from django.http import HttpResponse, JsonResponse
from django.template import loader
from . import models as m
from django.db.models import Q
import datetime, random
import operator as op
from django.views.decorators.csrf import csrf_exempt, ensure_csrf_cookie
import json
import re

######################################
######################################
## INDEX                            ##
## FES :: FRONTEND / SELECTORS      ##
## STV :: ST-END VIEWS              ##
## RC  :: RULE CREATION             ##
## SPC :: SAFETY PROPERTY CREATION  ##
## SLM :: STATELOG MANAGEMENT       ##
######################################
######################################


################################################################################
## [FES] FRONTEND / SELECTORS
################################################################################

# NOT IN USE
def fe_all_ruletext(request,**kwargs):
    json_resp = {'rules' : []}
    for rule in m.Rule.objects.filter(owner_id=kwargs['userid']):
        json_resp['rules'].append({'id' : rule.id,'text' : rule.text})
    return JsonResponse(json_resp)

def get_or_make_user(code,mode):
    try:
        user = m.User.objects.get(code=code, mode=mode)
    except m.User.DoesNotExist:
        user = m.User(code=code, mode=mode)
        user.save()

    return user

def fe_get_user(request):
    kwargs = json.loads(request.body.decode('utf-8'))
    u = get_or_make_user(kwargs['code'],kwargs['mode'])
    json_resp = {'userid' : u.id}
    return JsonResponse(json_resp)


# FRONTEND VIEW
def fe_all_rules(request):
    kwargs = json.loads(request.body.decode('utf-8'))
    json_resp = {'rules' : []}
    
    try:
        user = m.User.objects.get(id=kwargs['userid'])
    except KeyError:
        user = get_or_make_user(kwargs['code'],'rules')
        json_resp['userid'] = user.id

    task = kwargs['taskid']

    for rule in m.Rule.objects.filter(owner=user,task=task).order_by('id'):
        if rule.type == 'es':
            ifclause = []
            t = rule.esrule.Etrigger
            ifclause.append({'channel' : {'icon' : t.chan.icon},
                             'text' : t.text})
            for t in sorted(rule.esrule.Striggers.all(),key=lambda x: x.pos):
                ifclause.append({'channel' : {'icon' : t.chan.icon},
                                 'text' : t.text})
            a = rule.esrule.action
            thenclause = [{'channel' : {'icon' : a.chan.icon if not (a.chan == None) else ''},
                           'text' : a.text}]

            json_resp['rules'].append({'id' : rule.id,
                                       'ifClause' : ifclause,
                                       'thenClause' : thenclause,
                                       'temporality' : 'event-state'})

    return JsonResponse(json_resp)

def fe_get_full_rule(request):
    kwargs = json.loads(request.body.decode('utf-8'))
    json_resp = {}
    rule = m.Rule.objects.get(id=kwargs['ruleid'])

    if rule.type == 'es':
        rule = rule.esrule
        ifclause = []
        t = rule.Etrigger
        ifclause.append(trigger_to_clause(t,True))
        for t in sorted(rule.Striggers.all(),key=lambda x: x.pos):
            ifclause.append(trigger_to_clause(t,False))

        a = rule.action
        thenclause = state_to_clause(a)

        json_resp['rule'] = {'id' : rule.id,
                             'ifClause' : ifclause,
                             'thenClause' : [thenclause],
                             'temporality' : 'event-state'}

    return JsonResponse(json_resp)


# return id:name dict of all devices
def all_devs(user):
    json_resp = {}
    for dev in m.Device.objects.filter(owner=user):
        json_resp[dev.id] = dev.name
    return json_resp

def user_devs(user):
    mydevs = m.Device.objects.filter(owner=user)
    pubdevs = m.Device.objects.filter(public=True)
    return mydevs.union(pubdevs)

# return id:name dict of all channels
def valid_chans(user,is_trigger):
    json_resp = {'chans' : []}
    chans = m.Channel.objects.filter(Q(capability__device__owner=user) | Q(capability__device__public=True)).distinct().order_by('name')
    devs = m.Device.objects.filter(Q(owner=user) | Q(public=True))
    chans = filter(lambda x : chan_has_valid_cap(x,devs,is_trigger),chans)
    for chan in chans:
        json_resp['chans'].append({'id' : chan.id, 'name' : chan.name, 'icon' : chan.icon})
    return json_resp

# combined call of all_devs and all_chans
# NOT IN USE
def fe_all_devs_and_chans(request):
    kwargs = request.POST
    user = m.User.objects.get(id=kwargs['userid'])
    json_resp = {}
    json_resp['devs'] = all_devs(user)
    json_resp['chans'] = all_chans(user)
    return JsonResponse(json_resp)

# FRONTEND VIEW
# let frontend get csrf cookie
@ensure_csrf_cookie
def fe_get_cookie(request):
    return JsonResponse({})

# FRONTEND VIEW
# gets all of a user's channels
def fe_all_chans(request):
    kwargs = json.loads(request.body.decode('utf-8'))
    user = m.User.objects.get(id=kwargs['userid'])
    json_resp = valid_chans(user,kwargs['is_trigger'])
    return JsonResponse(json_resp)

def dev_has_valid_cap(dev,channel,is_trigger):
    poss_caps = dev.caps.all().intersection(m.Capability.objects.filter(channels=channel))
    if is_trigger:
        return any(map(lambda x : x.readable,poss_caps))
    else:
        return any(map(lambda x : x.writeable,poss_caps))

def chan_has_valid_cap(chan,devs,is_trigger):
    dev_caps = m.Capability.objects.none()
    for dev in devs:
        dev_caps = dev_caps.union(dev.caps.all())
    poss_caps = m.Capability.objects.filter(channels=chan).intersection(dev_caps)
    if is_trigger:
        return any(map(lambda x : x.readable,poss_caps))
    else:
        return any(map(lambda x : x.writeable,poss_caps))

# FRONTEND VIEW
# return id:name dict of all devices with a given channel
def fe_devs_with_chan(request):
    kwargs = json.loads(request.body.decode('utf-8'))
    devs = m.Device.objects.filter(Q(owner_id=kwargs['userid']) | Q(public=True),
                                   chans__id=kwargs['channelid']).distinct().order_by('name')
    chan = m.Channel.objects.get(id=kwargs['channelid'])
    devs = filter(lambda x : dev_has_valid_cap(x,chan,kwargs['is_trigger']),devs)
    json_resp = {'devs' : []}
    for dev in devs:
        json_resp['devs'].append({'id' : dev.id,'name' : dev.name})
    return JsonResponse(json_resp)

# return id:name dict of all channels with a given device
# NOT IN USE
def fe_chans_with_dev(request,**kwargs):
    chans = m.Channel.objects.filter(capability__device__id=kwargs['deviceid'])
    json_resp = {}
    for chan in chans:
        json_resp[chan.id] = chan.name

    return JsonResponse(json_resp)

def rwfilter_caps(caps,is_trigger):
    if is_trigger:
        return filter((lambda x : x.readable),caps)
    else:
        return filter((lambda x : x.writeable),caps)


def map_labels(caps,is_trigger,is_event):
    if is_trigger:
        if is_event:
            return list(map((lambda x : (x.id,x.name,x.eventlabel)),caps))
        else:
            return list(map((lambda x : (x.id,x.name,x.statelabel)),caps))
    else:
        return list(map((lambda x : (x.id,x.name,x.commandlabel)),caps))

def filtermap_caps(caps,is_trigger,is_event):
    return map_labels(rwfilter_caps(caps,is_trigger),is_trigger,is_event)

# return id:name dict of all capabilities for a given dev/chan pair
# NOT IN USE
def fe_get_all_caps(request,**kwargs):
    caps = m.Capability.objects.filter(channels__id=kwargs['channelid'],device__id=kwargs['deviceid'])
    json_resp = {}
    for cap in caps:
        json_resp[cap.id] = cap.name
    return JsonResponse({'caps' : json_resp})

# FRONTEND VIEW
# return id:name dict of contextually valid capabilities for a given dev/chan pair
def fe_get_valid_caps(request):
    kwargs = json.loads(request.body.decode('utf-8'))
    caps = m.Capability.objects.filter(channels__id=kwargs['channelid'],device__id=kwargs['deviceid']).order_by('name')

    json_resp = {'caps' : []}
    for id,name,label in filtermap_caps(caps,kwargs['is_trigger'],kwargs['is_event']):
        json_resp['caps'].append({'id' : id, 'name' : name, 'label' : label})
    return JsonResponse(json_resp)

# return id:(type,val constraints) dict of parameters for a given cap
def fe_get_params(request):
    kwargs = json.loads(request.body.decode('utf-8'))
    cap = m.Capability.objects.get(id=kwargs['capid'])
    json_resp = {'params' : []}
    for param in m.Parameter.objects.filter(cap_id=kwargs['capid']).order_by('id'):
        if param.type == 'set':
            json_resp['params'].append({'id' : param.id,
                                        'name' : param.name,
                                        'type' : "set",
                                        'values' : [opt.value for opt in m.SetParamOpt.objects.filter(param_id=param.id)]})
        elif param.type == 'range':
            json_resp['params'].append({'id' : param.id,
                                        'name' : param.name,
                                        'type' : 'range',
                                        'values' : [param.rangeparam.min,param.rangeparam.max,param.rangeparam.interval]})
        elif param.type == 'bin':
            json_resp['params'].append({'id' : param.id,
                                        'name' : param.name,
                                        'type' : 'bin',
                                        'values' : [param.binparam.tval,param.binparam.fval]})
        elif param.type == 'input':
            json_resp['params'].append({'id' : param.id,
                                        'name' : param.name,
                                        'type' : 'input',
                                        'values' : [param.inputparam.inputtype]})
        elif param.type == 'time':
            json_resp['params'].append({'id' : param.id,
                                        'name' : param.name,
                                        'type' : 'time',
                                        'values' : [param.timeparam.mode]})
        elif param.type == 'duration':
            json_resp['params'].append({'id' : param.id,
                                        'name' : param.name,
                                        'type' : 'duration',
                                        'values' : [param.durationparam.maxhours,param.durationparam.maxmins,param.durationparam.maxsecs]})
        elif param.type == 'color':
            json_resp['params'].append({'id' : param.id,
                                        'name' : param.name,
                                        'type' : 'color',
                                        'values' : [param.colorparam.mode]})
        elif param.type == 'meta':
            json_resp['params'].append({'id' : param.id,
                                        'name' : param.name,
                                        'type' : 'meta',
                                        'values' : [param.metaparam.is_event]})
    return JsonResponse(json_resp)



###############################################################################
## [STV] ST-END VIEWS
###############################################################################

def is_valid_value(param,val):
    if param.type == 'set':
        try:
            m.SetParamOpt.objects.get(param_id=param.id,value=val)
            return True
        except m.SetParamOpt.DoesNotExist:
            return False
    elif param.type == 'range':
        try:
            floval = float(val)
        except ValueError:
            return False
        return (param.rangeparam.min <= floval <= param.rangeparam.max)
    elif param.type == 'bin':
        return (param.binparam.tval == val or param.binparam.fval == val)
    elif param.type == 'input':
        if param.inputparam.inputtype == 'int':
            try:
                intval = int(val)
            except ValueError:
                return False
            else:
                return True
        else:
            return True
    else:
        #this shouldn't happen
        return False

def update_log(cap,dev,parvals):
    # determine if we care about this state
    try:
        state = m.State.objects.get(cap=cap,dev=dev,action=False)
    except m.State.DoesNotExist:
        return

    # if so, mark old log inactive (if one exists), and create new log
    for parval in parvals:
        try:
            entry = m.StateLog.objects.get(is_current=True,cap=cap,dev=dev,param=parval.par)
            if entry.value == parval.val:
                pass
            else:
                entry.is_current = False
                entry.save()
                newentry = m.StateLog(is_current=True,cap=cap,dev=dev,param=param,value=val)
                newentry.save()
        except m.StateLog.DoesNotExist:
            newentry = m.StateLog(is_current=True,cap=cap,dev=dev,param=param,value=val)
            newentry.save()
            pass

    return


# test if a value satisfies a given Condition
def test_cond(cond,value):
    if cond.comp == 'eq':
        f = op.eq
    elif cond.comp == 'neq':
        f = op.neq
    elif cond.comp == 'lt':
        f = op.lt
    elif cond.comp == 'lte':
        f = op.lte
    elif cond.comp == 'gt':
        f = op.gt
    elif cond.comp == 'gte':
        f = op.gte

    if cond.param.type != 'range':
        return f(value,cond.val)
    else:
        return f(float(value),float(cond.val))

# determine if all Conditions of a Trigger are currently satisfied
def check_trigger(trigger):
    state = m.State.objects.get(cap=trigger_cap,dev=trigger_dev)
    for cond in m.Condition.objects.filter(trigger=trigger):
        try:
            pv = m.ParVal.objects.get(state=state,par=cond_par)
            if not test_cond(cond,pv.val):
                return False
        except m.ParVal.DoesNotExist:
            return False

    return True

# update/create PV corresponding to state of a given cap/dev pair
def update_state(cap,dev,param,val):
    state = get_or_make_state(cap,dev)
    try:
        pv = m.ParVal.objects.get(state=state,par=param)
        pv.val = val
    except m.ParVal.DoesNotExist:
        pv = m.ParVal(state=state,par=param,val=val)

    pv.save()

# do,,, everything?
def st_process_update(request,**kwargs):
    cap = m.Capability.objects.get(id=kwargs['capid'])
    dev = m.Device.objects.get(id=kwargs['deviceid'])
    pvdict = kwargs['values'] #{paramid : value}
    pvs = [(m.Parameter.objects.get(id=pv_id),pvdict[pv_id]) for pv_id in pvdict]

    json = {}

    curstate = get_or_make_state(cap=cap,dev=dev)

    for param,val in pvs:
        update_state(cap,dev,param,val)
        update_log(cap,dev,param,val)

        # determine if we care about this state
        conds = m.Condition.objects.filter(trigger_cap=cap,trigger_dev=dev,par=param)

        if conds:
            if is_valid_value(param,val):
                json['esrules'] = []

                for cond in conds:
                    if test_cond(cond,val):
                        t = cond.trigger

                        # determine if any ESrules are triggered
                        esrules = m.ESRule.objects.filter(Etrigger=t)
                    
                        for rule in esrules:
                            if ((curval == None or not test_cond(cond,curval)) 
                                    and all(map(check_trigger,rule.Striggers.all()))):
                                action = rule.action
                                json[rule.id] = {'capid' : action.cap.id,
                                                'devid' : action.dev.id,
                                                'values' : {}}
                                ac_pvs = m.ParVal.objects.filter(state=action)
                                for ac_pv in ac_pvs:
                                    json[rule.id]['values'][ac_pv.par.id] = ac_pv.val

                                json['esrules'].append(rule.id)

                        # determine if any SSrules are triggered
                        # (TBCompleted)

            else:
                json['error'] = "invalid value"

        # return ids & actionstates of all rules triggered
    return JsonResponse(json)

###############################################################################
## [RC] RULE CREATION
###############################################################################

# get the state of a cap/dev pair, or create one if none exists
def get_or_make_state(cap,dev,is_action=False):
    try:
        state = m.State.objects.get(cap=cap,dev=dev,action=is_action)
    except m.State.DoesNotExist:
        state = m.State(cap=cap,dev=dev,action=is_action)
        state.save()

    return state


def update_pv(state,par_id,val):
    try:
        pv = m.ParVal.objects.get(state=state,par_id=par_id)
        pv.val = val
        pv.save()
    except m.ParVal.DoesNotExist:
        pv = m.ParVal(state=state,par_id=par_id,val=val)
        pv.save()

# create (OR EDIT) Event State Rule
def fe_create_esrule(request,forcecreate=False):
    kwargs = json.loads(request.body.decode('utf-8'))
    ruleargs = kwargs['rule']
    ifclause = ruleargs['ifClause']
    
    event = ifclause[0]

    e_trig = clause_to_trigger(event)

    action = ruleargs['thenClause'].pop()
    a_state = m.State(cap=m.Capability.objects.get(id=action['capability']['id']),
                      dev=m.Device.objects.get(id=action['device']['id']),
                      chan=m.Channel.objects.get(id=action['channel']['id']),
                      action=True,
                      text=action['text'])
    a_state.save()

    if kwargs['mode'] == "create" or forcecreate==True:
        rule = m.ESRule(owner=m.User.objects.get(id=kwargs['userid']),
                        type='es',
                        task = kwargs['taskid'],
                        Etrigger=e_trig,
                        action=a_state)
        rule.save()
    else: #edit existing rule
        try:
            rule = m.ESRule.objects.get(id=kwargs['ruleid'])
        except m.ESRule.DoesNotExist:
            return fe_create_esrule(request,forcecreate=True)

        rule.Etrigger=e_trig
        rule.action=a_state
        rule.save()
        for st in rule.Striggers.all():
            rule.Striggers.remove(st)

    try:
        for state in ifclause[1:]:
            s_trig = clause_to_trigger(state)
            rule.Striggers.add(s_trig)
    except IndexError:
        pass

    return fe_all_rules(request)

def fe_delete_rule(request):
    kwargs = json.loads(request.body.decode('utf-8'))
    try:
        rule = m.Rule.objects.get(id=kwargs['ruleid'])
    except m.Rule.DoesNotExist:
        return fe_all_rules(request)

    if rule.owner.id == kwargs['userid']:
        if rule.type == 'es':
            rule.esrule.Etrigger.delete()
            for st in rule.esrule.Striggers.all():
                st.delete()
            rule.esrule.action.delete()
        rule.delete()

    return fe_all_rules(request)

## not functional
def fe_create_ssrule(request,**kwargs):
    priority = kwargs['priority']
    action = m.State.objects.get(id=kwargs['actionid'])
    rule = m.SSRule(action=action,priority=priority)
    rule.save()

    for val in kwargs['triggerids']:
        rule.triggers.add(m.State.objects.get(id=val))

    return JsonResponse({'ssruleid' : rule.id})

def fe_create_rule(request,**kwargs):
    if kwargs['temp'] == 'es':
        return fe_create_esrule(request,kwargs)
    else:
        return fe_create_ssrule(request,kwargs)

###############################################################################
## [SPC] SAFETY PROPERTY CREATION
###############################################################################

def time_to_int(time):
    return time['seconds'] + time['minutes']*60 + time['hours']*3600

def int_to_time(secs):
    time = {}
    time['hours'] = secs // 3600
    time['minutes'] = (secs // 60) % 60
    time['seconds'] = secs % 60
    return time


def clause_to_trigger(clause):
    t = m.Trigger(chan=m.Channel.objects.get(id=clause['channel']['id']),
                  dev=m.Device.objects.get(id=clause['device']['id']),
                  cap=m.Capability.objects.get(id=clause['capability']['id']),
                  pos=clause['id'],
                  text=clause['text'])
    t.save()

    try:
        pars = clause['parameters']
        vals = clause['parameterVals']
        for par,val in zip(pars,vals):
            cond = m.Condition(par=m.Parameter.objects.get(id=par['id']),
                               val=val['value'],
                               comp=val['comparator'],
                               trigger=t)
            cond.save()
    except KeyError:
        pass

    return t


def trigger_to_clause(trigger,is_event):
    c = {'channel' : {'id' : trigger.chan.id,
                      'name' : trigger.chan.name,
                      'icon' : trigger.chan.icon},
         'device' : {'id' : trigger.dev.id,
                     'name' : trigger.dev.name},
         'capability' : {'id' : trigger.cap.id,
                         'name' : trigger.cap.name,
                         'label' : (trigger.cap.eventlabel if is_event else trigger.cap.statelabel)},
         'text' : trigger.text,
         'id' : trigger.pos}
    conds = m.Condition.objects.filter(trigger=trigger).order_by('id')
    if conds != []:
        c['parameters'] = []
        c['parameterVals'] = []

        for cond in conds:
            c['parameters'].append({'id' : cond.par.id,
                                    'name' : cond.par.name,
                                    'type' : cond.par.type})
            c['parameterVals'].append({'comparator' : cond.comp,
                                       'value' : cond.val})
    return c

def state_to_clause(state):
    c = {'channel' : {'id' : state.chan.id,
                      'name' : state.chan.name,
                      'icon' : state.chan.icon},
         'device' : {'id' : state.dev.id,
                     'name' : state.dev.name},
         'capability' : {'id' : state.cap.id,
                         'name' : state.cap.name,
                         'label' : state.cap.commandlabel},
         'text' : state.text}

    # pvs = m.ParVal.objects.filter(state=state).order_by('id')
    # if pvs != []:
    #     c['parameters'] = []
    #     c['parameterVals'] = []
    #
    #     for pv in pvs:
    #         c['parameters'].append({'id' : pv.par.id,
    #                                 'name' : pv.par.name,
    #                                 'type' : pv.par.type})
    #         c['parameterVals'].append({'comparator' : '=',
    #                                    'value' : pv.val})
    # escapeFunc = lambda x:re.sub(r'([\.\\\+\*\?\[\^\]\$\(\)\{\}\!\<\>\|\:\-])', r'\\\1', x)
    cap = m.Capability.objects.get(id=state.cap.id)
    par_list = m.Parameter.objects.filter(cap_id=cap.id)
    par_dict = dict()
    for par in par_list:
        par_c = dict()
        par_c['id'] = par.id
        par_c['type'] = par.type
        par_c['name'] = par.name
        if par.type == 'bin':
            bin_par = m.BinParam.objects.get(id=par.id)
            par_c['value_list'] = [bin_par.fval, bin_par.tval]
            t_template = r'\{%s/T\|(?P<value>[\w &\-]+)\}' % par.name
            f_template = r'\{%s/F\|(?P<value>[\w &\-]+)\}' % par.name
            t_val = re.search(t_template, cap.commandlabel)
            f_val = re.search(f_template, cap.commandlabel)
            if t_val and f_val:
                par_c['value_list_in_statement'] = [f_val.group('value'), t_val.group('value')]
            else:
                par_c['value_list_in_statement'] = par_c['value_list'] = [bin_par.fval, bin_par.tval]
        elif par.type == 'range':
            par_c['value_list'] = []
        elif par.type == 'set':
            par_c['value_list'] = [opt.value for opt in m.SetParamOpt.objects.filter(param_id=par.id)]
        else:
            raise Exception('var type %s not supported' % par.type)

        par_dict[par.name] = par_c

    template_text = re.sub(r'\{DEVICE\}', state.dev.name, cap.commandlabel)
    template_text = re.sub(r'\{(\w+)/(T|F)\|[\w &\-]+\}\{\1/(T|F)\|[\w &\-]+\}', r'(?P<\1>[\w &\-]+)', template_text)
    template_text = re.sub(r'\{(\w+)\}', r'(?P<\1>[\w &\-]+)', template_text)
    re_mat = re.match(template_text, state.text)

    for par, par_c in par_dict.items():
        par_dict[par_c['name']]['value'] = re_mat.group(par_c['name'])

    c['parameters'] = [{'type': par_c['type'], 'name': par_c['name'], 'id': par_c['id']}
                       for par, par_c in sorted(par_dict.items())]
    c['parameterVals'] = list()
    for par, par_c in sorted(par_dict.items()):
        if par_c['type'] == 'bin':
            value = par_c['value_list'][par_c['value_list_in_statement'].index(par_c['value'])]
        else:
            value = par_c['value']
        c['parameterVals'].append({'comparator': '=', 'value': value})

    return c


def display_trigger(trigger):
    return {'channel' : {'icon' : trigger.chan.icon}, 'text' : trigger.text}


def fe_all_sps(request):
    kwargs = json.loads(request.body.decode('utf-8'))
    json_resp = {'sps' : []}

    try:
        user = m.User.objects.get(id=kwargs['userid'])
    except KeyError:
        user = get_or_make_user(kwargs['code'],'sp')
        json_resp['userid'] = user.id

    sps = m.SafetyProp.objects.filter(owner=user,task=kwargs['taskid']).order_by('id')
    for sp in sps:
        if sp.type == 1:
            sp1 = sp.sp1
            triggers = sp1.triggers.all().order_by('pos')
            thisstate = triggers[0]
            try:
                thatstate = list(map(display_trigger,triggers[1:]))
            except IndexError:
                thatstate = []

            json_resp['sps'].append({'id' : sp.id,
                                     'thisState' : [display_trigger(thisstate)],
                                     'thatState' : thatstate,
                                     'compatibility' : sp1.always})
        elif sp.type == 2:
            sp2 = sp.sp2
            
            json2 = {'id' : sp.id,
                     'stateClause' : [display_trigger(sp2.state)],
                     'compatibility' : sp2.always}
            if sp2.comp:
                json2['comparator'] = sp2.comp
            if sp2.time != None:
                json2['time'] = int_to_time(sp2.time)
            
            clauses = sp2.conds.all().order_by('pos')
            if clauses != []:
                json2['alsoClauses'] = list(map(display_trigger,clauses))

            json_resp['sps'].append(json2)
        elif sp.type == 3:
            sp3 = sp.sp3
            json3 = {'id' : sp.id,
                     'triggerClause' : [display_trigger(sp3.event)],
                     'compatibility' : sp3.always}
            
            if sp3.comp:
                json3['comparator'] = sp3.comp
            if sp3.occurrences != None:
                json3['times'] = sp3.occurrences
            
            clauses = sp3.conds.all().order_by('pos')
            if clauses != []:
                json3['otherClauses'] = list(map(display_trigger,clauses))

            if sp3.time != None:
                if sp3.timecomp != None:
                    json3['afterTime'] = int_to_time(sp3.time)
                    json3['timeComparator'] = sp3.timecomp
                else:
                    json3['withinTime'] = int_to_time(sp3.time)

            json_resp['sps'].append(json3)

    return JsonResponse(json_resp)

def fe_get_full_sp(request):
    kwargs = json.loads(request.body.decode('utf-8'))
    sp = m.SafetyProp.objects.get(id=kwargs['spid'])
    if sp.type == 1:
        return fe_get_full_sp1(request)
    elif sp.type == 2:
        return fe_get_full_sp2(request)
    elif sp.type == 3:
        return fe_get_full_sp3(request)

def fe_get_full_sp1(request):
    kwargs = json.loads(request.body.decode('utf-8'))
    sp = m.SP1.objects.get(safetyprop_ptr_id=kwargs['spid'])
    ts = sp.triggers.all()
    thisstate = trigger_to_clause(ts[0],False)
    thatstate = []
    for t in ts[1:]:
        thatstate.append(trigger_to_clause(t,False))
    
    json_resp = {}
    json_resp['sp'] = {'thisState' : [thisstate],
                       'thatState' : thatstate,
                       'compatibility' : sp.always}

    return JsonResponse(json_resp)

def fe_get_full_sp2(request):
    kwargs = json.loads(request.body.decode('utf-8'))
    sp = m.SP2.objects.get(safetyprop_ptr_id=kwargs['spid'])

    state = trigger_to_clause(sp.state,False)
    json_resp = {'sp' : {'stateClause' : [state],
                         'compatibility' : sp.always}}
    if sp.comp != None:
        json_resp['sp']['comparator'] = sp.comp

    if sp.time != None:
        json_resp['sp']['time'] = int_to_time(sp.time)

    conds = sp.conds.all()
    if conds != []:
        json_resp['sp']['alsoClauses'] = []
        for c in conds:
            json_resp['sp']['alsoClauses'].append(trigger_to_clause(c,False))

    return JsonResponse(json_resp)

def fe_get_full_sp3(request):
    kwargs = json.loads(request.body.decode('utf-8'))
    sp = m.SP3.objects.get(safetyprop_ptr_id=kwargs['spid'])

    event = trigger_to_clause(sp.event,True)
    json_resp = {'sp' : {'triggerClause' : [event],
                         'compatibility' : sp.always}}

    if sp.occurrences != None and sp.comp != None:
        json_resp['sp']['comparator'] = sp.comp
        json_resp['sp']['times'] = sp.occurrences

    if sp.time != None:
        if sp.comp != None:
            json_resp['sp']['withinTime'] = int_to_time(sp.time)
        elif sp.timecomp != None:
            json_resp['sp']['afterTime'] = int_to_time(sp.time)
            json_resp['sp']['timeComparator'] = sp.timecomp

    conds = sp.conds.all()
    if conds != []:
        json_resp['sp']['otherClauses'] = []
        for c in conds:
            json_resp['sp']['otherClauses'].append(trigger_to_clause(c,False))

    return JsonResponse(json_resp)



def fe_delete_sp(request):
    kwargs = json.loads(request.body.decode('utf-8'))
    sp = m.SafetyProp.objects.get(id=kwargs['spid'])

    if sp.type == 1:
        sp = sp.sp1
        for t in sp.triggers.all():
            t.delete()
    elif sp.type == 2:
        sp = sp.sp2
        sp.state.delete()
        for c in sp.conds.all():
            c.delete()
    elif sp.type == 3:
        sp = sp.sp3
        sp.event.delete()
        for c in sp.conds.all():
            c.delete()

    sp.delete()

    return fe_all_sps(request)


def fe_create_sp1(request,forcecreate=False):
    kwargs = json.loads(request.body.decode('utf-8'))
    spargs = kwargs['sp']

    if kwargs['mode'] == 'create' or forcecreate == True:
        sp = m.SP1(owner=m.User.objects.get(id=kwargs['userid']),
                   task=kwargs['taskid'],
                   type=1,
                   always=spargs['compatibility'])
        sp.save()
    else: #edit sp
        try:
            sp = m.SafetyProp.objects.get(id=kwargs['spid'])
        except m.SafetyProp.DoesNotExist: # catch non-existent SP error
            return fe_create_sp1(request,forcecreate=True)

        sp = sp.sp1

        sp.always = spargs['compatibility']
        sp.save()
        for trig in sp.triggers.all():
            sp.triggers.remove(trig)

    for clause in ([spargs['thisState'][0]] + spargs['thatState']):
        t = clause_to_trigger(clause)
        sp.triggers.add(t)

    sp.save()
    return JsonResponse({})

def fe_create_sp2(request,forcecreate=False):
    kwargs = json.loads(request.body.decode('utf-8'))
    spargs = kwargs['sp']

    clause = spargs['stateClause'][0]
    t = clause_to_trigger(clause)

    if kwargs['mode'] == 'create' or forcecreate==True:
        sp = m.SP2(owner=m.User.objects.get(id=kwargs['userid']),
                          task=kwargs['taskid'],
                          type=2,
                          always=spargs['compatibility'],
                          state = t)
        sp.save()
    else:
        try:
            sp = m.SafetyProp.objects.get(id=kwargs['spid'])
        except m.SafetyProp.DoesNotExist:
            return fe_create_sp2(request,forcecreate=True)

        sp = sp.sp2

        sp.always = spargs['compatibility']
        sp.state = t
        sp.save()

        # null out remaining fields
        for cond in sp.conds.all():
            sp.conds.remove(cond)
        sp.comp = None
        sp.time = None
        sp.save()

    try:
        comp = spargs['comparator']
        time = spargs['time']
        time = time_to_int(time)
        if time > 0:
            sp.comp = comp
            sp.time = time
            sp.save()
        else:
            pass
    except KeyError:
        pass

    try:
        clauses = spargs['alsoClauses']
        for clause in clauses:
            t = clause_to_trigger(clause)
            sp.conds.add(t)
    except KeyError:
        pass

    sp.save()
    
    return JsonResponse({})

def fe_create_sp3(request,forcecreate=False):
    kwargs = json.loads(request.body.decode('utf-8'))
    spargs = kwargs['sp']

    event = spargs['triggerClause'][0]
    t = clause_to_trigger(event)

    if kwargs['mode'] == 'create' or forcecreate==True:
        sp = m.SP3(owner=m.User.objects.get(id=kwargs['userid']),
                   task=kwargs['taskid'],
                   type=3,
                   always=spargs['compatibility'],
                   event = t)
        sp.save()
    else:
        try:
            sp = m.SafetyProp.objects.get(id=kwargs['spid'])
        except m.SafetyProp.DoesNotExist:
            return fe_create_sp3(request,forcecreate=True)

        sp = sp.sp3

        sp.always = spargs['compatibility']
        sp.event = t
        sp.save()

        # null out other fields
        for cond in sp.conds.all():
            sp.conds.remove(cond)
        sp.comp = None
        sp.occurrences = None
        sp.time = None
        sp.timecomp = None
        sp.save()

    try:
        comp = spargs['comparator']
        times = spargs['times']
        if times > 0:
            sp.comp = comp
            sp.occurrences = times
            try:
                within = spargs['withinTime']
                sp.time = time_to_int(within)
            except KeyError:
                pass
        else:
            pass
    except KeyError:
        pass

    try:
        clauses = spargs['otherClauses']
        for clause in clauses:
            t = clause_to_trigger(clause)
            sp.conds.add(t)
    except KeyError:
        pass

    try:
        time = spargs['afterTime']
        timecomp = spargs['timeComparator']
        sp.time=time_to_int(time)
        sp.timecomp=timecomp
    except KeyError:
        pass

    sp.save()
    return JsonResponse({})


###############################################################################
## [SLM] STATE & LOG MANAGEMENT
###############################################################################

# create and save new StateLog entry in database
def log_state(newstate):
    pvs = m.ParVal.objects.filter(state=newstate)
    for pv in pvs:
        try:
            oldlog = m.StateLog.objects.get(
                    is_current=True,
                    cap=newstate.cap,
                    dev=newstate.dev,
                    param=pv.par
                    )
            # if no update, continue
            if oldlog.val == pv.val:
                continue

            oldlog.is_current=False
            oldlog.save()
        except m.StateLog.DoesNotExist:
            pass

        newlog = m.StateLog(
                is_current=True,
                cap=newstate.cap,
                dev=newstate.dev,
                param=pv.par,
                val=pv.val
                )


# get current state of dev/cap pair
def current_state(dev,cap):
    try:
        curstate = m.State.objects.get(cap=cap,dev=dev,action=False)
        return curstate
    except m.State.DoesNotExist:
        return None

# get current state of all caps of a device
def fe_current_device_status(request,**kwargs):
    dev = m.Device.objects.get(id=kwargs['deviceid'])
    json = {}
    for cap in dev.caps.all():
        state = current_state(dev,cap)
        if state != None:
            json[cap.id] = []
            for pv in m.ParVal.objects.filter(state=state):
                json[cap.id].append((pv.par.id,pv.val))
        else:
            json[cap.id] = "N/A"

    return JsonResponse(json)

# get value of state of dev/cap pair at a given time
def historical_state(dev,cap,targettime):
    state = m.State.objects.get(dev=dev,cap=cap,action=False)
    out = []
    for pv in m.ParVal.objects.filter(state=state):
        try:
            logs = m.StateLog.objects.filter(
                    cap=state.cap,
                    dev=state.dev,
                    param=pv.par,
                    timestamp__lte=targettime
                    )
            if logs:
                lastlog = max(logs,key=lambda log : log.timestamp)
                out.append((lastlog.param,lastlog.value))
            else:
                out.append((pv.par.id,"N/A"))
        except m.StateLog.DoesNotExist:
            out.append((pv.par.id,"N/A"))

    return out


# get state of all caps of a device [timedelta] minutes ago
def fe_historical_device_status(request,**kwargs):
    dev = m.Device.objects.get(id=kwargs['deviceid'])
    targettime = datetime.datetime.now(datetime.timezone.utc) - datetime.timedelta(minutes=kwargs['timedelta'])

    json = {
        "device_name" : dev.name
        }

    for cap in dev.caps.all():
        capstate = historical_state(dev,cap,targettime)
        json[cap.id] = capstate

    return JsonResponse(json)

# get record of all logged changes to a dev/cap pair
def device_cap_history(dev,cap):
    qset = m.StateLog.objects.filter(dev=dev,cap=cap)
    states = []
    for entry in sorted(qset,key=lambda entry : entry.timestamp,reverse=True):
        states.append((entry.timestamp.ctime(),entry.param.id,entry.value))
    return states


# get record of all logged changes to a device
def fe_device_history(request,**kwargs):
    dev = m.Device.objects.get(id=kwargs['deviceid'])
    qset = m.StateLog.objects.filter(state__dev_id=dev.id)
    json = {"history" : []}
    for entry in sorted(qset,key=lambda entry : entry.timestamp,reverse=True):
        json["history"].append((entry.timestamp.ctime(),entry.param.id,entry.value))

    return JsonResponse(json)


# delete user data
@csrf_exempt
def manage_user(request, **kwargs):
    if request.method == 'GET':
        user_list = m.User.objects.all()
        user_code_list = sorted([user.code for user in user_list])
        template = loader.get_template('manage.html')
        return HttpResponse(template.render({'user_code_list': user_code_list}))

    elif request.method == 'POST':
        if request.POST.get('action') == 'manage':
            user_list = request.POST.getlist('userdel')
            # user_list = str(request.POST.get('userdel'))
            # user_list = user_list.split('\n')
            user_list = [user.strip() for user in user_list if user.strip()]
            users = m.User.objects.all()
            for user in users:
                if user.code in user_list and user.id != 1:  # should not remove "Jesse", might be some hard code issue
                    rules = list(m.Rule.objects.filter(owner=user))
                    sps = list(m.SafetyProp.objects.filter(owner=user))
                    for rule in rules:
                        if rule.type == 'es':
                            rule.esrule.Etrigger.delete()
                            for st in rule.esrule.Striggers.all():
                                st.delete()
                            rule.esrule.action.delete()
                        rule.delete()
                    for sp in sps:
                        if sp.type == 1:
                            sp = sp.sp1
                            for t in sp.triggers.all():
                                t.delete()
                        elif sp.type == 2:
                            sp = sp.sp2
                            sp.state.delete()
                            for c in sp.conds.all():
                                c.delete()
                        elif sp.type == 3:
                            sp = sp.sp3
                            sp.event.delete()
                            for c in sp.conds.all():
                                c.delete()
                        sp.delete()
                    user.delete()

            user_list = m.User.objects.all()
            user_code_list = sorted([user.code for user in user_list])
            http_content = '<br>'.join(user_code_list)
        elif request.POST.get('action') == 'anonymize':
            new_name_str = ''
            users = m.User.objects.all().exclude(id=1)  # should not remove "Jesse"
            users = sorted(users, key=lambda u: u.code)
            for user, index in zip(users, range(1, len(users)+1)):
                new_code = 'p' + str(index)
                new_name_str = new_name_str + '%s -> %s<br>' % (user.code, new_code)
                user.code = new_code
                user.save()
            http_content = new_name_str
        else:
            http_content = ''
        return HttpResponse(http_content)
