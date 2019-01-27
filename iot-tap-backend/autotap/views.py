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

# Create your views here.
from django.http import HttpResponse, JsonResponse
from django.template import loader
import backend.models as m
import os, sys
from autotapmc.analyze.Fix import generateCompactFix, generateNamedFix
from autotapmc.model.Tap import Tap
from django.views.decorators.csrf import csrf_exempt
from autotap.translator import tap_to_frontend_view, translate_sp_to_autotap_ltl, \
    translate_rule_into_autotap_tap, generate_all_device_templates, backend_to_frontend_view
from autotap.testdata import property_user_task_list, rule_user_task_list, task_ltl_dict, \
    correct_property_user_task_list, mutated_rule_user_task_list, multiple_property_user_task_list
import itertools
import json


def get_or_make_user(code,mode):
    try:
        user = m.User.objects.get(code=code, mode=mode)
    except m.User.DoesNotExist:
        user = m.User(code=code, mode=mode)
        user.save()

    return user


def get_user_id(user_id):
    n_code = False
    n_id = False
    try:
        user_id = m.User.objects.get(code=user_id).id
        return user_id
    except m.User.DoesNotExist:
        n_code = True
    try:
        user_id = m.User.objects.get(id=user_id).id
        return user_id
    except (m.User.DoesNotExist, ValueError):
        n_id = True

    if n_code and n_id:
        raise Exception("User %s does not exist." % str(user_id))


def generate_text_for_single_user(code, task_id, ltl):
    try:
        user_id_rule = m.User.objects.get(code=code, mode="rules")
        rule_list = m.Rule.objects.filter(owner=user_id_rule, task=int(task_id))
    except m.User.DoesNotExist:
        rule_list = list()

    rule_text = ""
    tap_list = list()
    for rule in rule_list:
        tap = translate_rule_into_autotap_tap(rule)
        # print(tap.__dict__)
        tap_list.append(tap)
        rule_text = rule_text + '[] IF %s WHILE %s, THEN %s<br>' % (tap.trigger, str(tap.condition), tap.action)

    template_dict = generate_all_device_templates()
    new_rule_patch = generateCompactFix(ltl, tap_list,
                                        init_value_dict={}, template_dict=template_dict)
    new_rule_patch_text_list = ['[] IF %s WHILE %s, THEN %s' %
                                (patch.trigger, ' & '.join(patch.condition), str(patch.action))
                                for patch in new_rule_patch]
    new_rule_patch_text = '<br>'.join(new_rule_patch_text_list)
    rule_id_list = [rule.id for rule in rule_list]

    action_num_list = [len(patch.action)>0 for patch in new_rule_patch]
    if all(action_num_list):
        success_flag = True
    else:
        success_flag = False

    http_content = "==========user=%s, task=%s==========<br>" \
                   "The property being checked is %s<br> " \
                   "Rule IDs: %s <br> %s <br> Fixing Patch: <br>%s <br>" \
                   "Visit <a href=\"localhost:4200/%s/%s\">localhost:4200/%s/%s</a> " \
                   "to see the user-written properties/rules<br>" \
                   "====================================<br>" % \
                   (
                       code,
                       str(task_id),
                       ltl,
                       str(rule_id_list),
                       rule_text,
                       new_rule_patch_text,
                       code,
                       task_id,
                       code,
                       task_id
                   )

    if not success_flag:
        http_content = "<font color=\"red\">failed</font>" + http_content
    return http_content


def expand_autotap_result_into_patches_named(patch_list, label_list, is_compact=False):
    if not is_compact:
        action_list = [tap.action for tap in patch_list]
        result_list = list()
        for selected_action in itertools.product(*action_list):
            patch = {k: tap_to_frontend_view(Tap(action=[s_a], condition=tap.condition, trigger=tap.trigger))
                     for k, s_a, tap in zip(label_list, selected_action, patch_list)}
            result_list.append(patch)
    else:
        result_list = {k: tap_to_frontend_view(tap) for k, tap in zip(label_list, patch_list)}
    return result_list


def expand_autotap_result_into_patches_unnamed(patch_list, is_compact=False):
    if not is_compact:
        action_list = [tap.action for tap in patch_list]
        result_list = list()
        for selected_action in itertools.product(*action_list):
            patch = [tap_to_frontend_view(Tap(action=[s_a], condition=tap.condition, trigger=tap.trigger))
                     for s_a, tap in zip(selected_action, patch_list)]
            result_list.append(patch)
    else:
        result_list = [tap_to_frontend_view(tap) for tap in patch_list]

    return result_list


def parse_fix_request(request):
    if request.method == 'GET':
        kwargs = request.GET
    elif request.method == 'POST':
        kwargs = json.loads(request.body.decode('utf-8'))
    else:
        raise Exception('The request is neither a POST or a GET.')

    try:
        user_rules = m.User.objects.get(id=kwargs['userid'], mode="rules")
        user_id_rules = user_rules.id
    except KeyError:
        user_id_rules = get_or_make_user(kwargs['code'], 'rules')

    try:
        user_sp = m.User.objects.get(id=kwargs['userid'], mode="sp")
        user_id_sp = user_sp.id
    except KeyError:
        user_id_sp = get_or_make_user(kwargs['code'], 'sp')

    task_id = kwargs['taskid']
    try:
        is_compact = int(kwargs['compact'])
    except KeyError:
        is_compact = 0

    try:
        is_named = int(kwargs['named'])
    except KeyError:
        is_named = 1

    return {'user_id_rules': user_id_rules, 'user_id_sp': user_id_sp,
            'task_id': task_id, 'is_compact': is_compact, 'is_named': is_named}


@csrf_exempt
def test(request):
    if request.method == 'GET':
        template = loader.get_template('autotap.html')
        return HttpResponse(template.render())

    elif request.method == 'POST':
        user_id = request.POST.get('user', '')
        task_id = request.POST.get('task', '')
        ltl = '!(%s)' % request.POST.get('ltl', '1')

        if user_id:
            http_content = generate_text_for_single_user(user_id, task_id, ltl)
        else:
            rule_list = m.Rule.objects.filter(task=task_id)
            owner_id_list = list(set([rule.owner_id for rule in rule_list]))
            http_content = ''
            num_instance = 0
            num_succeed = 0
            for user_id in owner_id_list:
                num_instance = num_instance + 1
                print('checking user=%s, task=%s' % (user_id, task_id))
                try:
                    single_http_content = generate_text_for_single_user(user_id, task_id, ltl)
                    num_succeed = num_succeed + 1
                except Exception as exc:
                    code = m.User.objects.get(id=user_id).code
                    single_http_content = '==========user=%s, task=%s==========<br>' \
                                          'failed<br>' \
                                          'please visit super.cs.uchicago.edu/superifttt/%s/%s/rules<br>%s<br>' \
                                          '====================================<br>' % \
                                          (user_id, task_id, code, task_id, exc)
                # print(single_http_content)
                http_content = http_content + single_http_content
            http_content = http_content + 'total: %d, succeeded: %d, failed: %d' % \
                           (num_instance, num_succeed, num_instance - num_succeed)

        return HttpResponse(http_content)


@csrf_exempt
def synthesize(request):
    if request.method == 'GET':
        template = loader.get_template('synthesize.html')
        user_task_list = ['%s %s' % (code, str(task)) for code, task, score in property_user_task_list]
        return HttpResponse(template.render(context={'user_task_list': user_task_list}))

    elif request.method == 'POST':
        action = request.POST.get('action')
        http_content = ''
        if action == "Submit":
            user_code, task_id = request.POST.get('user_task').split(' ')
            task_id = int(task_id)
            user_id_sp = m.User.objects.get(code=user_code, mode="sp").id
            sp_list = m.SafetyProp.objects.filter(owner=user_id_sp, task=task_id)
            ltl_list = ['(%s)' % translate_sp_to_autotap_ltl(sp) for sp in sp_list]
            ltl = '!(%s)' % ' & '.join(ltl_list)
            http_content = generate_text_for_single_user(user_code, task_id, ltl)
        elif action == 'Test All' or action == 'Reproduce':
            user_task_list = [(code, task) for code, task, score in correct_property_user_task_list]
            for code, task_id in user_task_list:
                user_id_property = m.User.objects.get(code=code, mode="sp").id
                sp_list = m.SafetyProp.objects.filter(owner=user_id_property, task=task_id)
                print('synthesizing rules with user-written properties code=%s, task_id=%s...' %
                      (code, task_id))
                try:
                    ltl_list = ['(%s)' % translate_sp_to_autotap_ltl(sp) for sp in sp_list]
                    ltl = '!(%s)' % ' & '.join(ltl_list)
                    http_content = http_content + generate_text_for_single_user(code, task_id, ltl)
                except Exception as exc:
                    http_content = http_content + '==========user=%s, task=%s==========<br>' \
                                          'failed<br>' \
                                          'please visit localhost:4200/%s/%s<br>%s<br>' \
                                          '====================================<br>' % \
                                          (code, task_id, code, task_id, exc)

        return HttpResponse(http_content)


@csrf_exempt
def multisp(request):
    if request.method == 'GET':
        template = loader.get_template('multisp.html')
        user_task_list = ['%s %s' % (code, str(task)) for code, task in multiple_property_user_task_list]
        return HttpResponse(template.render(context={'user_task_list': user_task_list}))

    elif request.method == 'POST':
        action = request.POST.get('action')
        http_content = ''
        if action == "Submit":
            user_code, task_id = request.POST.get('user_task').split(' ')
            task_id = int(task_id)
            user_id_sp = m.User.objects.get(code=user_code, mode="sp").id
            sp_list = m.SafetyProp.objects.filter(owner=user_id_sp, task=task_id)
            ltl_list = ['(%s)' % translate_sp_to_autotap_ltl(sp) for sp in sp_list]
            ltl = '!(%s)' % ' & '.join(ltl_list)
            http_content = generate_text_for_single_user(user_code, task_id, ltl)
        elif action == 'Test All' or action == 'Reproduce':
            user_task_list = [(code, task) for code, task in multiple_property_user_task_list]
            for code, task_id in user_task_list:
                user_id_property = m.User.objects.get(code=code, mode="sp").id
                sp_list = m.SafetyProp.objects.filter(owner=user_id_property, task=task_id)
                print('synthesizing rules from multiple properties code=%s, task_id=%s...' %
                      (code, task_id))
                try:
                    ltl_list = ['(%s)' % translate_sp_to_autotap_ltl(sp) for sp in sp_list]
                    ltl = '!(%s)' % ' & '.join(ltl_list)
                    http_content = http_content + generate_text_for_single_user(code, task_id, ltl)
                except Exception as exc:
                    http_content = http_content + '==========user=%s, task=%s==========<br>' \
                                          'failed<br>' \
                                          'please visit localhost:4200/%s/%s<br>%s<br>' \
                                          '====================================<br>' % \
                                          (code, task_id, code, task_id, exc)

        return HttpResponse(http_content)


@csrf_exempt
def debug(request):
    if request.method == 'GET':
        template = loader.get_template('debug.html')
        user_task_list = ['%s %s' % (code, str(task)) for code, task in mutated_rule_user_task_list]
        return HttpResponse(template.render(context={'user_task_list': user_task_list}))

    elif request.method == 'POST':
        action = request.POST.get('action')
        http_content = ''
        if action == "Submit":
            user_code, task_id = request.POST.get('user_task').split(' ')
            task_id = int(task_id)
            user_id = m.User.objects.get(code=user_code).id
            ltl = task_ltl_dict[task_id]
            http_content = generate_text_for_single_user(user_id, task_id, ltl)
        elif action == 'Test All' or action == 'Reproduce':
            user_task_list = [(code, task) for code, task in mutated_rule_user_task_list]
            for code, task_id in user_task_list:
                user_id_property = m.User.objects.get(code=code, mode="sp").id
                sp_list = m.SafetyProp.objects.filter(owner=user_id_property, task=task_id)
                print('debug rules with code=%s, task_id=%s...' %
                      (code, task_id))
                try:
                    ltl_list = ['(%s)' % translate_sp_to_autotap_ltl(sp) for sp in sp_list]
                    ltl = '!(%s)' % ' & '.join(ltl_list)
                    http_content = http_content + generate_text_for_single_user(code, task_id, ltl)
                except Exception as exc:
                    http_content = http_content + '==========user=%s, task=%s==========<br>' \
                                                  'failed<br>' \
                                                  'please visit localhost:4200/%s/%s<br>%s<br>' \
                                                  '====================================<br>' % \
                                   (code, task_id, code, task_id, exc)

        return HttpResponse(http_content)


@csrf_exempt
def reproduce(request):
    template = loader.get_template('reproduce.html')
    return HttpResponse(template.render())


@csrf_exempt
def fix(request):
    json_resp = dict()
    try:
        req_dict = parse_fix_request(request)
        user_id_rules = req_dict['user_id_rules']
        user_id_sp = req_dict['user_id_sp']
        task_id = req_dict['task_id']
        is_named = req_dict['is_named']
        is_compact = req_dict['is_compact']

        rule_list = m.Rule.objects.filter(task=task_id, owner=user_id_rules)
        sp_list = m.SafetyProp.objects.filter(task=task_id, owner=user_id_sp)

        ltl_list = [translate_sp_to_autotap_ltl(sp) for sp in sp_list]
        if ltl_list:
            ltl = '!(%s)' % ' & '.join(ltl_list)
        else:
            ltl = '!(1)'

        template_dict = generate_all_device_templates()
        if is_named:
            tap_dict = {str(k): translate_rule_into_autotap_tap(v) for k, v in zip(range(len(rule_list)), rule_list)}
            tap_patch, tap_label = generateNamedFix(ltl, tap_dict, {}, template_dict)
            result_list = expand_autotap_result_into_patches_named(tap_patch, tap_label, is_compact)
            orig_rule_dict = {str(k): backend_to_frontend_view(v) for k, v in zip(range(len(rule_list)), rule_list)}

            json_resp['original'] = orig_rule_dict
            json_resp['patches'] = result_list
        else:
            tap_list = [translate_rule_into_autotap_tap(v) for v in rule_list]
            tap_patch = generateCompactFix(ltl, tap_list, {}, template_dict)
            result_list = expand_autotap_result_into_patches_unnamed(tap_patch, is_compact)
            orig_rule_list = [backend_to_frontend_view(v) for v in rule_list]

            json_resp['original'] = orig_rule_list
            json_resp['patches'] = result_list
        json_resp['succeed'] = True

    except Exception as exc:
        json_resp['patches'] = []
        json_resp['succeed'] = False
        json_resp['fail_exc'] = str(exc)
    return JsonResponse(json_resp)
