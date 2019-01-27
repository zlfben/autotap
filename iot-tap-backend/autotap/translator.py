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
from backend.views import trigger_to_clause, state_to_clause, time_to_int
import re
import ast
import itertools
import sys
import os
import collections
from autotapmc.model.Tap import Tap


def split_autotap_formula(formula):
    # should not be location/music
    if '<=' in formula:
        st_list = formula.split('<=')
        if len(st_list) == 2:
            dev_cap_par = formula.split('<=')[0].strip()
            val = formula.split('<=')[1].strip()
            comp = '<='
        else:
            # ugly handler of interval, which the interface doesn't support
            val1 = st_list[0]
            dev_cap_par = st_list[1].strip()
            val2 = st_list[2]
            if val1 == val2:
                comp = '='
                val = val1
            else:
                raise Exception('unsupported AutoTap statement %s' % formula)
    elif '>=' in formula:
        dev_cap_par = formula.split('>=')[0].strip()
        val = formula.split('>=')[1].strip()
        comp = '>='
    elif '<' in formula:
        dev_cap_par = formula.split('<')[0].strip()
        val = formula.split('<')[1].strip()
        comp = '<'
    elif '>' in formula:
        dev_cap_par = formula.split('>')[0].strip()
        val = formula.split('>')[1].strip()
        comp = '>'
    elif '=' in formula:
        dev_cap_par = formula.split('=')[0].strip()
        val = formula.split('=')[1].strip()
        comp = '='
    else:
        raise Exception('formula %s could not be splited' % formula)
    dev = dev_cap_par.split('.')[0].strip()
    cap_par = dev_cap_par.split('.')[1].strip()
    cap = '_'.join(cap_par.split('_')[:-1])
    par = cap_par.split('_')[-1]
    return dev, cap, par, comp, val


def _dev_name_to_autotap(name):
    name = name.replace(' ', '_').lower()
    name = ''.join([ch for ch in name if ch.isalnum() or ch == '_'])
    return name


def _cap_name_to_autotap(name):
    name = name.replace(' ', '_')
    name = ''.join([ch for ch in name if ch.isalnum() or ch == '_'])
    name = name.lower()
    return name

def _var_name_to_autotap(name):
    name = name.replace(' ', '_')
    return name

def _set_opt_to_autotap(opt):
    opt = opt.replace(' ', '').replace('&', 'n').replace('-', '').capitalize()
    return opt


def _regular_statement_clause_generator(dev_autotap, cap_autotap, par_autotap, comp, val, neg):
    """
    handle non-special case (not location, not music)
    :param dev_autotap:
    :param cap_autotap:
    :param par_autotap:
    :param comp:
    :param val:
    :param neg:
    :return: parameters, parameter_vals
    """
    dev_list_backend = list(m.Device.objects.all().order_by('id'))
    dev_name_list = [_dev_name_to_autotap(dev.name) for dev in dev_list_backend]
    device = dev_list_backend[dev_name_list.index(dev_autotap)]
    if par_autotap == 'bpm':
        par_autotap = par_autotap.upper()
    # Step 1: find the device

    # Step 2: find the capability
    cap_list_backend = list(device.caps.all().order_by('id'))
    cap_name_list = [_cap_name_to_autotap(cap.name) for cap in cap_list_backend]
    capability = cap_list_backend[cap_name_list.index(cap_autotap)]

    # Step 3: fill in the parameters and values
    parameters = list()
    parameter_vals = list()

    par_list_backend = list(capability.parameter_set.all().order_by('id'))
    if len(par_list_backend) != 1:
        raise Exception('par-val num is not 1 for capability: %s (%d)' % (capability.name, capability.id))
    parameter = par_list_backend[0]
    parameters.append({'id': parameter.id, 'name': parameter.name, 'type': parameter.type})
    if parameter.type == 'bin':
        if (val == 'true') == (not neg):
            value = m.BinParam.objects.get(id=parameter.id).tval
        else:
            value = m.BinParam.objects.get(id=parameter.id).fval
        parameter_vals.append({'comparator': '=', 'value': value})
    elif parameter.type == 'range':
        if (comp == '<' and (not neg)) or (comp == '>=' and neg):
            comparator = '<'
        elif (comp == '>' and (not neg)) or (comp == '<=' and neg):
            comparator = '>'
        elif (comp == '<=' and (not neg)) or (comp == '>' and neg):
            # comparator = '<='
            comparator = '<'  # current interface don't support "<=", so we use "<" instead.
        elif (comp == '>=' and (not neg)) or (comp == '<' and neg):
            # comparator = '>='
            comparator = '>'  # current interface don't support "<=", so we use "<" instead.
        elif comp == '=' and not neg:
            comparator = '='
        elif comp == '=' and neg:
            comparator = '!='
        else:
            raise Exception('Failed to translate with comparator %s' % comp)
        parameter_vals.append({'comparator': comparator, 'value': float(val)})
    elif parameter.type == 'set':
        # get all set options
        option_list = list(m.SetParamOpt.objects.filter(param_id=parameter.id).order_by('id'))
        option_autotap_list = [_set_opt_to_autotap(opt) for opt in option_list]
        # find the correct option
        option = option_list[option_autotap_list.index(val)]
        parameter_vals.append({'comparator': '=' if not neg else '!=', 'value': option.value})
    else:
        raise Exception('unknown parameter type %s' % parameter.type)

    return parameters, parameter_vals


def _location_statement_clause_generator(dev_autotap, cap_autotap, par_autotap, comp, val, neg):
    """
    handle special case: it is a location sensor statement
    :param dev_autotap:
    :param cap_autotap:
    :param par_autotap:
    :param comp:
    :param val:
    :param neg:
    :return:
    """
    dev_list_backend = list(m.Device.objects.all().order_by('id'))
    dev_name_list = [_dev_name_to_autotap(dev.name) for dev in dev_list_backend]
    device = dev_list_backend[dev_name_list.index(dev_autotap)]

    param_location = m.Parameter.objects.get(id=70)
    param_person = m.Parameter.objects.get(id=71)
    location_list = list(m.SetParamOpt.objects.filter(param_id=70).order_by('id'))
    person_list = list(m.SetParamOpt.objects.filter(param_id=71).order_by('id'))
    location_autotap_list = [_cap_name_to_autotap(loc.value) for loc in location_list]
    person_autotap_list = [_cap_name_to_autotap(per.value) for per in person_list]
    location_person_list = list(itertools.product(location_list, person_list))
    location_person_autotap_list = [loc+'_'+per for loc, per in
                                    list(itertools.product(location_autotap_list, person_autotap_list))]

    cap_par_autotap = cap_autotap + '_' + par_autotap
    location, person = location_person_list[location_person_autotap_list.index(cap_par_autotap)]

    parameters = []
    parameter_vals = []

    parameters.append({'id': 70, 'name': param_location.name, 'type': param_location.type})
    parameters.append({'id': 71, 'name': param_person.name, 'type': param_person.type})

    if (val == 'true') == (not neg):
        parameter_vals.append({'comparator': '=', 'value': location.value})
        parameter_vals.append({'comparator': '=', 'value': person.value})
    else:
        parameter_vals.append({'comparator': '!=', 'value': location.value})
        parameter_vals.append({'comparator': '=', 'value': person.value})

    return parameters, parameter_vals


def _music_statement_clause_generator(val, comp, neg):
    if val == 'Stop':
        return list(), list()
    else:
        genre_list = list(m.SetParamOpt.objects.filter(param_id=8))
        genre_autotap_list = [_set_opt_to_autotap(opt.value) for opt in genre_list]
        genre = genre_list[genre_autotap_list.index(val)]

        param = m.Parameter.objects.get(id=8)

        parameters = list()
        parameter_vals = list()

        parameters.append({'id': param.id, 'name': param.name, 'type': param.type})
        if (comp == '=') == (not neg):
            parameter_vals.append({'comparator': '=', 'value': genre.value})
        else:
            parameter_vals.append({'comparator': '!=', 'value': genre.value})
        return parameters, parameter_vals


def _guess_channel(device, capability):
    dev_chans = set(device.chans.all())
    cap_chans = set(capability.channels.all())
    chans = dev_chans.intersection(cap_chans)
    return chans.pop()


def _fetch_capability(cap_autotap):
    cap_list = list(m.Capability.objects.all().order_by('id'))
    cap_autotap_list = [_cap_name_to_autotap(cap.name) for cap in cap_list]
    return cap_list[cap_autotap_list.index(cap_autotap)]


def _update_clause_text(clause):
    parameters = clause['parameters']
    parameter_vals = clause['parameterVals']
    text = clause['capability']['label']

    text = re.sub(r'{DEVICE}', clause['device']['name'], text)

    for p_dct, p_val_dct in zip(parameters, parameter_vals):
        # substitute the text here
        if p_dct['type'] == 'bin':
            # substitute {name/T|xxx} and {name/F|xxx}
            t_val = m.BinParam.objects.get(id=p_dct['id']).tval
            t_temp = r'{%s/T|([\w &\-]+)}'.replace('|', r'\|') % p_dct['name']
            f_temp = r'{%s/F|([\w &\-]+)}'.replace('|', r'\|') % p_dct['name']
            t_sub = r'\1' if (p_val_dct['value'] == t_val) == (p_val_dct['comparator'] == '=') else r''
            f_sub = r'' if (p_val_dct['value'] == t_val) == (p_val_dct['comparator'] == '=') else r'\1'
            text = re.sub(t_temp, t_sub, text)
            text = re.sub(f_temp, f_sub, text)
        if p_dct['type'] == 'meta':
            # substitute {$trigger$}
            temp = r'{\$%s\$}' % p_dct['name']
            if 'text' not in p_val_dct['value']:
                p_val_dct['value'] = _update_clause_text(p_val_dct['value'])
            sub = p_val_dct['value']['text']
            text = re.sub(temp, sub, text)

        # substitute comp {name/<|xxx}, ...
        eq_temp = r'{%s/=|([\w &\-]+)}'.replace('|', r'\|') % p_dct['name']
        neq_temp = r'{%s/!=|([\w &\-]+)}'.replace('|', r'\|') % p_dct['name']
        geq_temp = r'{%s/>=|([\w &\-]+)}'.replace('|', r'\|') % p_dct['name']
        leq_temp = r'{%s/<=|([\w &\-]+)}'.replace('|', r'\|') % p_dct['name']
        gt_temp = r'{%s/>|([\w &\-]+)}'.replace('|', r'\|') % p_dct['name']
        lt_temp = r'{%s/<|([\w &\-]+)}'.replace('|', r'\|') % p_dct['name']

        eq_sub = r'\1' if p_val_dct['comparator'] == '=' else r''
        neq_sub = r'\1' if p_val_dct['comparator'] == '!=' else r''
        geq_sub = r'\1' if p_val_dct['comparator'] == '>=' else r''
        leq_sub = r'\1' if p_val_dct['comparator'] == '<=' else r''
        gt_sub = r'\1' if p_val_dct['comparator'] == '>' else r''
        lt_sub = r'\1' if p_val_dct['comparator'] == '<' else r''

        text = re.sub(eq_temp, eq_sub, text)
        text = re.sub(neq_temp, neq_sub, text)
        text = re.sub(geq_temp, geq_sub, text)
        text = re.sub(leq_temp, leq_sub, text)
        text = re.sub(gt_temp, gt_sub, text)
        text = re.sub(lt_temp, lt_sub, text)

        # substitute value {name}
        temp = r'{%s}' % p_dct['name']
        sub = r'%s' % str(p_val_dct['value'])
        text = re.sub(temp, sub, text)

    clause['text'] = text
    return clause


def _negate_clause(clause):
    parameters = clause['parameters']
    parameter_vals = clause['parameterVals']
    if len(parameters) == 0:
        # 0-param cap: don't know how to negate
        pass
    elif len(parameters) == 1:
        # 1-param cap: bin - reverse, range - reverse comparator, set - reverse comparator
        for par, par_val in zip(parameters, parameter_vals):
            if par['type'] == 'bin':
                t_val = m.BinParam.objects.get(id=par['id']).tval
                f_val = m.BinParam.objects.get(id=par['id']).fval
                if par_val['value'] == t_val:
                    par_val['value'] = f_val
                else:
                    par_val['value'] = t_val
            elif par['type'] in ['range', 'set']:
                if par_val['comparator'] == '=':
                    par_val['comparator'] = '!='
                elif par_val['comparator'] == '!=':
                    par_val['comparator'] = '='
                elif par_val['comparator'] == '>=':
                    par_val['comparator'] = '<'
                elif par_val['comparator'] == '<=':
                    par_val['comparator'] = '>'
                elif par_val['comparator'] == '>':
                    par_val['comparator'] = '<='
                elif par_val['comparator'] == '<':
                    par_val['comparator'] = '>='
                else:
                    raise Exception('unexpected comparator %s' % par_val['comparator'])
            else:
                raise Exception('unable to negate clause: %s' % clause('text'))
    elif len(parameters) == 2:
        # 2-param cap: location - reverse comparator of location, history - reverse comparator of time
        # check if it is location or history
        if clause['capability']['id'] in [49, 50, 51, 52]:
            # history channel
            for par, par_val in zip(parameters, parameter_vals):
                if par['type'] == 'duration':
                    if par_val['comparator'] == '=':
                        par_val['comparator'] = '!='
                    elif par_val['comparator'] == '!=':
                        par_val['comparator'] = '='
                    elif par_val['comparator'] == '>=':
                        par_val['comparator'] = '<'
                    elif par_val['comparator'] == '<=':
                        par_val['comparator'] = '>'
                    elif par_val['comparator'] == '>':
                        par_val['comparator'] = '<='
                    elif par_val['comparator'] == '<':
                        par_val['comparator'] = '>='
                    else:
                        raise Exception('unexpected comparator %s' % par_val['comparator'])
        elif clause['capability']['id'] in [63]:
            # location sensor
            for par, par_val in zip(parameters, parameter_vals):
                if par['id'] == 70:
                    if par_val['comparator'] == '=':
                        par_val['comparator'] = '!='
                    elif par_val['comparator'] == '!=':
                        par_val['comparator'] = '='
                    else:
                        raise Exception('unexpected comparator %s' % par_val['comparator'])

    clause = _update_clause_text(clause)
    return clause


def autotap_simple_formula_to_clause(formula, flag=0):
    dev_list_backend = list(m.Device.objects.all().order_by('id'))
    dev_name_list = [_dev_name_to_autotap(dev.name) for dev in dev_list_backend]

    clause = dict()

    # extract "neg" out
    if formula.startswith('!'):
        neg = True
        formula = formula[1:]
    else:
        neg = False

    # split the formula statement
    dev_autotap, cap_autotap, par_autotap, comp, val = split_autotap_formula(formula)
    device = dev_list_backend[dev_name_list.index(dev_autotap)]

    # interprete dev, cap and par
    if dev_autotap == 'location_sensor':
        # special case 1: location sensor
        parameters, parameter_vals = _location_statement_clause_generator(
            dev_autotap, cap_autotap, par_autotap, comp, val, neg)
        capability = m.Capability.objects.get(id=63)
    elif cap_autotap == 'genre' and par_autotap == 'genre':
        # special case 2: music
        if val == 'Stop':
            capability = m.Capability.objects.get(id=56)
        else:
            capability = m.Capability.objects.get(id=9)
        parameters, parameter_vals = _music_statement_clause_generator(val, comp, neg)
    else:
        # non-special case
        parameters, parameter_vals = _regular_statement_clause_generator(
            dev_autotap, cap_autotap, par_autotap, comp, val, neg)
        capability = _fetch_capability(cap_autotap)

    label = capability.statelabel if flag == 0 else (capability.eventlabel if flag == 1 else capability.commandlabel)
    channel = _guess_channel(device, capability)
    clause['device'] = {'id': device.id, 'name': device.name}
    clause['capability'] = {'id': capability.id, 'name': capability.name, 'label': label}
    clause['channel'] = {'id': channel.id, 'name': channel.name, 'icon': channel.icon}
    clause['parameters'] = parameters
    clause['parameterVals'] = parameter_vals

    # also should send back text
    clause = _update_clause_text(clause)
    return clause


def autotap_formula_to_clause(formula, flag=0):
    """

    :param formula: the tap formula such as 'ac.power=false'
    :param flag: 0 - state, 1 - event, 2 - command
    :return:
    """
    if formula.startswith('tick'):
        formula = formula[5:-1]
        if '*' in formula:
            # it becomes true that negative was last in effect more than time ago
            time = formula.split('*')[0]
            statement = formula.split('*')[1]
            statement_clause = autotap_simple_formula_to_clause(statement, 0)
            statement_clause = _negate_clause(statement_clause)
            device = m.Device.objects.get(id=11)
            capability = m.Capability.objects.get(id=51)
            channel = _guess_channel(device, capability)
            parameters = [{'id': 55, 'name': 'trigger', 'type': 'meta'}, {'id': 56, 'name': 'time', 'type': 'duration'}]
            parameter_vals = [{'comparator': '=', 'value': statement_clause}, {'comparator': '>', 'value': int(time)}]
            clause = {
                'device': {'id': device.id, 'name': device.name},
                'capability': {'id': capability.id, 'name': capability.name, 'label': capability.eventlabel},
                'channel': {'id': channel.id, 'name': channel.name, 'icon': channel.icon},
                'parameters': parameters,
                'parameterVals': parameter_vals}
            return _update_clause_text(clause)
        elif '#' in formula:
            # it becomes true that event last happened more than time ago
            time = formula.split('#')[0]
            statement = formula.split('#')[1]
            statement_clause = autotap_simple_formula_to_clause(statement, 1)
            statement_clause = _negate_clause(statement_clause)
            device = m.Device.objects.get(id=11)
            capability = m.Capability.objects.get(id=52)
            channel = _guess_channel(device, capability)
            parameters = [{'id': 57, 'name': 'trigger', 'type': 'meta'}, {'id': 58, 'name': 'time', 'type': 'duration'}]
            parameter_vals = [{'comparator': '=', 'value': statement_clause}, {'comparator': '>', 'value': int(time)}]
            clause = {
                'device': {'id': device.id, 'name': device.name},
                'capability': {'id': capability.id, 'name': capability.name, 'label': capability.eventlabel},
                'channel': {'id': channel.id, 'name': channel.name, 'icon': channel.icon},
                'parameters': parameters,
                'parameterVals': parameter_vals}
            return _update_clause_text(clause)
        else:
            raise Exception('unknown tick formula %s' % formula)
    elif '*' in formula:
        # negative was last in effect more than time ago
        time = formula.split('*')[0]
        if time.startswith('!'):
            neg = True
            time = time[1:]
        else:
            neg = False
        statement = formula.split('*')[1]
        statement_clause = autotap_simple_formula_to_clause(statement, 0)
        statement_clause = _negate_clause(statement_clause)
        device = m.Device.objects.get(id=11)
        capability = m.Capability.objects.get(id=51)
        channel = _guess_channel(device, capability)
        parameters = [{'id': 55, 'name': 'trigger', 'type': 'meta'}, {'id': 56, 'name': 'time', 'type': 'duration'}]
        parameter_vals = [{'comparator': '=', 'value': statement_clause},
                          {'comparator': '>' if not neg else '<', 'value': int(time)}]
        clause = {
            'device': {'id': device.id, 'name': device.name},
            'capability': {'id': capability.id, 'name': capability.name, 'label': capability.statelabel},
            'channel': {'id': channel.id, 'name': channel.name, 'icon': channel.icon},
            'parameters': parameters,
            'parameterVals': parameter_vals}
        return _update_clause_text(clause)
    elif '#' in formula:
        # happen less than time ago
        time = formula.split('#')[0]
        if time.startswith('!'):
            neg = True
            time = time[1:]
        else:
            neg = False
        statement = formula.split('#')[1]
        statement_clause = autotap_simple_formula_to_clause(statement, 1)
        statement_clause = _negate_clause(statement_clause)
        device = m.Device.objects.get(id=11)
        capability = m.Capability.objects.get(id=52)
        channel = _guess_channel(device, capability)
        parameters = [{'id': 57, 'name': 'trigger', 'type': 'meta'}, {'id': 58, 'name': 'time', 'type': 'duration'}]
        parameter_vals = [{'comparator': '=', 'value': statement_clause},
                          {'comparator': '<' if not neg else '>', 'value': int(time)}]
        clause = {
            'device': {'id': device.id, 'name': device.name},
            'capability': {'id': capability.id, 'name': capability.name, 'label': capability.statelabel},
            'channel': {'id': channel.id, 'name': channel.name, 'icon': channel.icon},
            'parameters': parameters,
            'parameterVals': parameter_vals}
        return _update_clause_text(clause)
    else:
        return autotap_simple_formula_to_clause(formula, flag)


def tap_to_frontend_view(tap):
    # tap should be in formula format, need translation from autotap
    trigger_clause = autotap_formula_to_clause(tap.trigger, 1)
    channel_clause_list = [autotap_formula_to_clause(cond, 0) for cond in tap.condition]
    if not isinstance(tap.action, list):
        tap_action = [tap.action]
    else:
        tap_action = tap.action
    action_clause_list = [autotap_formula_to_clause(action, 2) for action in tap_action]

    clause = dict()
    clause['ifClause'] = [trigger_clause] + channel_clause_list
    clause['thenClause'] = action_clause_list
    clause['temporality'] = 'event-state'

    return clause


def backend_to_frontend_view(rule):
    # translate m.Rule into frontend json format
    rule = rule.esrule
    ifclause = []
    t = rule.Etrigger
    ifclause.append(trigger_to_clause(t,True))
    for t in sorted(rule.Striggers.all(),key=lambda x: x.pos):
        ifclause.append(trigger_to_clause(t,False))

    a = rule.action
    thenclause = state_to_clause(a)

    json_resp = {'id' : rule.id,
                 'ifClause' : ifclause,
                 'thenClause' : [thenclause],
                 'temporality' : 'event-state'}

    return json_resp


def generate_all_device_templates():
    """

    :return: a complete list of device templates for AutoTap
    """
    template_dict = dict()
    irregular_cap_list = [9, 25, 26, 56, 35, 30, 31, 33, 32, 52, 51, 49, 50, 29, 63, 37]
    device_list = m.Device.objects.all()
    for dev in device_list:
        dev_template = dict()

        dev_name = _dev_name_to_autotap(dev.name)
        dev_name = ''.join([ch for ch in dev_name if ch.isalnum() or ch == '_'])

        cap_list = dev.caps.all()
        for cap in cap_list:
            if cap.id not in irregular_cap_list:
                # this is a zero/single-parameter capability
                param_list = list(m.Parameter.objects.filter(cap_id=cap.id))
                if len(param_list) == 1:
                    # this is a single-parameter capability
                    param = param_list[0]
                    var_name = cap.name + ' ' + param.name
                    var_name = _var_name_to_autotap(var_name)
                    var_name = ''.join([ch for ch in var_name if ch.isalnum() or ch == '_'])
                    var_name = var_name.lower()

                    if param.type == 'bin':
                        var_type = 'bool'
                        if not cap.writeable:
                            var_type = var_type + ', external'
                        dev_template[var_name] = var_type
                    elif param.type == 'range':
                        var_type = 'numeric'
                        if not cap.writeable:
                            var_type = var_type + ', external'
                        dev_template[var_name] = var_type
                    elif param.type == 'set':
                        var_type = 'set'
                        if not cap.writeable:
                            var_type = var_type + ', external'
                        # need to write down all options into the template
                        value_list = [_set_opt_to_autotap(opt.value)
                                      for opt in m.SetParamOpt.objects.filter(param_id=param.id)]
                        value_list = ', '.join(value_list)
                        value_list = ', [' + value_list + ']'
                        var_type = var_type + value_list
                        dev_template[var_name] = var_type
                    else:
                        print('[[[%d, %s]]]' % (cap.id, cap.name))
            elif cap.id == 63:
                # this is location cap
                location_list = m.SetParamOpt.objects.filter(param_id=70)
                person_list = m.SetParamOpt.objects.filter(param_id=71)

                for location, person in itertools.product(location_list, person_list):
                    var_name = location.value + ' ' + person.value
                    var_name = _var_name_to_autotap(var_name)
                    var_name = ''.join([ch for ch in var_name if ch.isalnum() or ch == '_'])
                    var_name = var_name.lower()

                    var_type = 'bool, external'

                    dev_template[var_name] = var_type
            elif cap.id in [49, 50, 51, 52]:
                # this is history channel
                # probably don't need to have it as a real device in AutoTap
                # should be handled by '#' and '*'
                pass
            elif cap.id in [9, 35, 56]:
                # music caps
                # 9: start playing genre, 35: start playing some music (not supported), 56: stop
                if cap.id == 9:
                    param = m.Parameter.objects.get(cap_id=cap.id)
                    var_name = cap.name + ' ' + param.name
                    var_name = _var_name_to_autotap(var_name)
                    var_name = ''.join([ch for ch in var_name if ch.isalnum() or ch == '_'])
                    var_name = var_name.lower()
                    var_type = 'set'
                    genre_list = [genre.value for genre in m.SetParamOpt.objects.filter(param_id=8)]
                    genre_list.append('Stop')
                    value_list = [_set_opt_to_autotap(genre) for genre in genre_list]
                    value_list = ', '.join(value_list)
                    value_list = ', [' + value_list + ']'
                    var_type = var_type + value_list
                    dev_template[var_name] = var_type
                else:
                    # no need to handle
                    pass
        if dev_template:
            template_dict[dev_name] = dev_template

    return template_dict


def trigger_to_autotap_statement(clause, if_event=False):
    irregular_cap_list = [9, 25, 26, 56, 35, 30, 31, 33, 32, 52, 51, 49, 50, 29, 63, 37]
    if clause['capability']['id'] not in irregular_cap_list:
        # should be only one parameter
        param = clause['parameters'][0]
        param_val = clause['parameterVals'][0]
        if param['type'] == 'bin':
            var_name = clause['capability']['name'] + ' ' + param['name']
            var_name = _var_name_to_autotap(var_name)
            var_name = ''.join([ch for ch in var_name if ch.isalnum() or ch == '_'])
            var_name = var_name.lower()

            dev_name = _dev_name_to_autotap(clause['device']['name'])
            dev_name = ''.join([ch for ch in dev_name if ch.isalnum() or ch == '_'])

            var_name = dev_name + '.' + var_name
            if param_val['comparator'] == '=':
                value = 'false' if param_val['value'] == m.BinParam.objects.get(id=param['id']).fval else 'true'
            else:
                value = 'true' if param_val['value'] == m.BinParam.objects.get(id=param['id']).fval else 'false'
            clause_statement = var_name + param_val['comparator'] + value

        elif param['type'] in ('range', 'set'):
            var_name = clause['capability']['name'] + ' ' + param['name']
            var_name = _var_name_to_autotap(var_name)
            var_name = ''.join([ch for ch in var_name if ch.isalnum() or ch == '_'])
            var_name = var_name.lower()

            dev_name = _dev_name_to_autotap(clause['device']['name'])
            dev_name = ''.join([ch for ch in dev_name if ch.isalnum() or ch == '_'])

            var_name = dev_name + '.' + var_name
            clause_statement = var_name + param_val['comparator'] + _set_opt_to_autotap(str(param_val['value']))

        else:
            raise Exception('not supported type: %s' % param['type'])
    else:
        if clause['capability']['id'] == 63:
            # this is location sensor
            param_list = clause['parameters']
            param_val_list = clause['parameterVals']

            location_val = param_val_list[0] if param_list[0]['name'] == 'location' else param_val_list[1]
            who_val = param_val_list[0] if param_list[0]['name'] == 'who' else param_val_list[1]

            var_name = location_val['value'] + ' ' + who_val['value']
            var_name = _var_name_to_autotap(var_name)
            var_name = ''.join([ch for ch in var_name if ch.isalnum() or ch == '_'])
            var_name = var_name.lower()

            dev_name = _dev_name_to_autotap(clause['device']['name'])
            dev_name = ''.join([ch for ch in dev_name if ch.isalnum() or ch == '_'])

            var_name = dev_name + '.' + var_name

            if location_val['comparator'] != '!=' and who_val['comparator'] != '!=':
                clause_statement = var_name + '=' + 'true'
            else:
                clause_statement = var_name + '=' + 'false'
        elif clause['capability']['id'] in [9, 35, 56]:
            # start/stop playing music
            # stop is 0-parameter cap
            # start is 1-parameter cap
            # 9: start playing genre, 35: start playing some music (not supported), 56: stop
            var_name = 'genre_genre'
            dev_name = _dev_name_to_autotap(clause['device']['name'])
            dev_name = ''.join([ch for ch in dev_name if ch.isalnum() or ch == '_'])
            var_name = dev_name + '.' + var_name
            if clause['capability']['id'] == 9:
                param_list = clause['parameters']
                param_val_list = clause['parameterVals']
                genre_val = param_val_list[0]
                if not genre_val['comparator'].strip():
                    genre_val['comparator'] = '='  # ugly fix for bug
                clause_statement = var_name + genre_val['comparator'] + \
                                   _set_opt_to_autotap(genre_val['value'])
            elif clause['capability']['id'] == 56:
                clause_statement = var_name + '=' + 'Stop'
            else:
                raise Exception('Playing specific music not supported by AutoTap yet')
        elif clause['capability']['id'] in [49, 50, 51, 52]:
            # handle history channel
            if clause['capability']['id'] == 52:
                param_list = clause['parameters']
                param_val_list = clause['parameterVals']

                trigger_val = param_val_list[0] if param_list[0]['name'] == 'trigger' else param_val_list[1]
                time_val = param_val_list[0] if param_list[0]['name'] == 'time' else param_val_list[1]
                time = time_to_int(ast.literal_eval(time_val['value']))
                trigger = trigger_to_autotap_statement(ast.literal_eval(trigger_val['value']), True)
                if not if_event:
                    if time_val['comparator'] == '<':
                        clause_statement = '%d#%s' % (time, trigger)
                    elif time_val['comparator'] == '>':
                        clause_statement = '!%d#%s' % (time, trigger)
                    elif time_val['comparator'] == '=':
                        # this is a wrong condition
                        # there shouldn't be a state saying "something happened exactly xxx time ago"
                        raise Exception('something happened exactly xxx time ago cannot be a state')
                    else:
                        raise Exception('Unknown comparator %s' % time_val['comparator'])
                else:
                    if time_val['comparator'] == '<':
                        clause_statement = trigger
                    elif time_val['comparator'] == '>' or time_val['comparator'] == '=':
                        clause_statement = 'tick[%d#%s]' % (time, trigger)
                    else:
                        raise Exception('Unknown comparator %s' % time_val['comparator'])
            elif clause['capability']['id'] == 51:
                # a condition was last in effect xxx time ago
                # could only be an event
                # now only binary variable supported because of AutoTap's limitation
                param_list = clause['parameters']
                param_val_list = clause['parameterVals']

                trigger_val = param_val_list[0] if param_list[0]['name'] == 'trigger' else param_val_list[1]
                time_val = param_val_list[0] if param_list[0]['name'] == 'time' else param_val_list[1]
                time = time_to_int(ast.literal_eval(time_val['value']))
                trigger = trigger_to_autotap_statement(ast.literal_eval(trigger_val['value']), False)
                if 'false' in trigger:
                    trigger.replace('false', 'true')
                elif 'true' in trigger:
                    trigger.replace('true', 'false')
                else:
                    raise Exception('Only binary variable supported for capability %d' % clause['capability']['id'])

                if if_event:
                    clause_statement = 'tick[%d*%s]' % (time, trigger)
                else:
                    raise Exception('Capability %d doesn\'t have a state form' % clause['capability']['id'])
            elif clause['capability']['id'] == 49:
                # state was active some time ago
                # state version not supported by AutoTap,
                # but the rules in the user study is equivalent to AutoTap's format
                param_list = clause['parameters']
                param_val_list = clause['parameterVals']

                trigger_val = param_val_list[0] if param_list[0]['name'] == 'trigger' else param_val_list[1]
                time_val = param_val_list[0] if param_list[0]['name'] == 'time' else param_val_list[1]
                time = time_to_int(ast.literal_eval(time_val['value']))
                trigger = trigger_to_autotap_statement(ast.literal_eval(trigger_val['value']), True)

                if if_event:
                    # this is equivalent to "event that activated the state happened some time ago"
                    clause_statement = 'tick[%d#%s]' % (time, trigger)
                else:
                    raise Exception('Capability %d not supported in state form' % clause['capability']['id'])
            elif clause['capability']['id'] == 50:
                param_list = clause['parameters']
                param_val_list = clause['parameterVals']
                trigger_val = None
                time_val = None
                occurrence_val = None
                for index, p, pv in zip(range(len(param_list)), param_list, param_val_list):
                    if p['name'] == 'trigger':
                        trigger_val = pv
                    elif p['name'] == 'time':
                        time_val = pv
                    elif p['name'] == 'occurrences':
                        occurrence_val = pv

                trigger = trigger_to_autotap_statement(ast.literal_eval(trigger_val['value']), True)
                time = time_to_int(ast.literal_eval(time_val['value']))

                if occurrence_val['comparator'] == '<':
                    if occurrence_val['value'] == 1:
                        # never happen
                        if if_event:
                            raise Exception('Event frequency not supported by AutoTap')
                        else:
                            clause_statement = '!%d#%s' % (time, trigger)
                    else:
                        raise Exception('Event frequency not supported by AutoTap')
                elif occurrence_val['comparator'] == '>':
                    if occurrence_val['value'] == 0:
                        # happen
                        if if_event:
                            clause_statement = '%s' % trigger
                        else:
                            clause_statement = '%d#%s' % (time, trigger)
                    else:
                        raise Exception('Event frequency not supported by AutoTap')
                elif occurrence_val['comparator'] == '=':
                    if occurrence_val['value'] == 0:
                        # never happen
                        if if_event:
                            raise Exception('Event frequency not supported by AutoTap')
                        else:
                            clause_statement = '!%d#%s' % (time, trigger)
                    elif occurrence_val['value'] == 1:
                        # happen (not perfect interpretation, multiple time is okay)
                        if if_event:
                            clause_statement = '%s' % trigger
                        else:
                            clause_statement = '%d#%s' % (time, trigger)
                    else:
                        raise Exception('Event frequency not supported by AutoTap')
                else:
                    raise Exception('Unknown comparator %s' % occurrence_val['comparator'])
            else:
                raise Exception('Capability %d not supported yet' % clause['capability']['id'])
        else:
            # print(clause['capability']['id'], clause['capability']['name'])
            raise Exception('something goes wrong when translating into autotap: %s' % clause['capability']['id'])
    if '!=' in clause_statement:
        clause_statement = '!' + clause_statement.replace('!=', '=') if not clause_statement.startswith('!') \
            else clause_statement.replace('!=', '=')[1:]
    return clause_statement


def _actionize(statement, time=None):
    if time:
        pass
    else:
        if not statement.startswith('!'):
            return '@' + statement
        else:
            statement = statement[1:]
            clause = autotap_formula_to_clause(statement, flag=1)
            if clause['parameters'][0]['type'] == 'bin':
                if 'false' in statement:
                    return '@' + statement.replace('false', 'true')
                else:
                    return '@' + statement.replace('true', 'false')
            elif clause['parameters'][0]['type'] == 'range':
                s_1 = '@' + statement.replace('=', '<')
                s_2 = '@' + statement.replace('=', '>')
                return '(%s | %s)' % (s_1, s_2)
            elif clause['parameters'][0]['type'] == 'set':
                value_list = list(m.SetParamOpt.objects.filter(param_id=clause['parameters'][0]['id']))
                value_autotap_list = [_set_opt_to_autotap(opt.value) for opt in value_list]
                if clause['parameters'][0]['id'] == 8:
                    value_autotap_list.append('Stop')
                orig_value = _set_opt_to_autotap(clause['parameterVals'][0]['value'])
                dev_cap = statement.split('=')[0]
                s_list = ['@%s=%s' % (dev_cap, value) for value in value_autotap_list if value != orig_value]
                return '(' + ' | '.join(s_list) + ')'


def translate_sp_to_autotap_ltl(sp):
    if sp.type == 1:
        sp1 = sp.sp1
        if_always = sp1.always
        triggers = sp1.triggers.all().order_by('pos')
        state_list = list(triggers)

        statement_list = [trigger_to_autotap_statement(trigger_to_clause(trigger, False), False)
                          for trigger in state_list]
        if if_always:
            neg_statement_list = ['!' + statement for statement in statement_list]
            return 'G((%s) | (%s))' % (' & '.join(statement_list), ' & '.join(neg_statement_list))
        else:
            return '!F(%s)' % (' & '.join(statement_list))

    elif sp.type == 2:
        sp2 = sp.sp2
        if_always = sp2.always
        clause = sp2.state
        also_clauses = list(sp2.conds.all().order_by('pos'))

        state = trigger_to_autotap_statement(trigger_to_clause(clause, False), False)
        also_states = [trigger_to_autotap_statement(trigger_to_clause(ac, False), False) for ac in also_clauses]

        if sp2.time:
            comparator = sp2.comp  # always translate into same: this is unused now
            time = sp2.time
            if also_states:
                if if_always:
                    return 'G(!(%s) | (%s W %s*%s))' % (' & '.join([state]+also_states), state, time, state)
                else:
                    return '!F(%s*%s & (%s))' % (time, state, ' & '.join(also_states))
            else:
                if if_always:
                    return 'G(!%s | (%s W %s*%s))' % (state, state, time, state)
                else:
                    return '!F(%s*%s)' % (time, state)
        else:
            if also_states:
                if if_always:
                    return 'G(!(%s) | %s)' % (' & '.join(also_states), state)
                else:
                    return '!F(%s)' % (' & '.join(also_states + [state]))
            else:
                if if_always:
                    return 'G(%s)' % state
                else:
                    return '!F(%s)' % state
    elif sp.type == 3:
        sp3 = sp.sp3
        if_always = sp3.always
        clause = sp3.event
        also_clauses = list(sp3.conds.all().order_by('pos'))

        event = trigger_to_autotap_statement(trigger_to_clause(clause, True), True)
        event_state = trigger_to_autotap_statement(trigger_to_clause(clause, False), False)
        also_states = [trigger_to_autotap_statement(trigger_to_clause(ac, False), False) for ac in also_clauses]

        if sp3.time:
            comparator = sp3.comp  # always translate into same: this is unused now
            time = sp3.time
            if if_always:
                return 'G(!(%s & !%s) | (%s#%s W %s))' % \
                       (_actionize(also_states[0]), event_state, time, also_states[0], _actionize(event))
            else:
                return '!F(%s#%s & X%s)' % (time, also_states[0], _actionize(event))
        else:
            if also_states:
                if if_always:
                    return 'G(!X%s | (%s))' % (_actionize(event), ' & '.join(also_states))
                else:
                    return '!F(%s & X%s)' % (' % '.join(also_states), _actionize(event))
            else:
                if if_always:
                    return 'G(%s)' % _actionize(event)
                else:
                    return '!F(%s)' % _actionize(event)


def translate_rule_into_autotap_tap(rule):
    """

    :param rule:
    :return:
    """
    try:
        esrule = m.ESRule.objects.get(id=rule.id)

        trigger = trigger_to_clause(esrule.Etrigger, True)
        trigger_statement = trigger_to_autotap_statement(trigger, True)

        # conditions of the rule
        condition_list = [trigger_to_clause(cond, False) for cond in esrule.Striggers.all()]
        condition_statement_list = [trigger_to_autotap_statement(cond, False) for cond in condition_list]

        # action of the rule
        action = state_to_clause(esrule.action)
        action_statement = trigger_to_autotap_statement(action, True)

        return Tap(action_statement, trigger_statement, condition_statement_list)
    except Exception as exc:
        raise exc