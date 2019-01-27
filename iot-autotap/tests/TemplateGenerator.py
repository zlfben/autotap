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


from autotapmc.channels.devgen.AirConditioner import generateAirConditionerChannel
from autotapmc.model.Channel import generateChannelFromTemplate
from autotapmc.model.IoTSystem import IoTSystem
from autotapmc.analyze.Fix import generateFixForSafety
from autotapmc.analyze.Draw import generateGraph
import autotapmc.buchi.Buchi as Buchi
import re
from time import sleep
import importlib

name = 'AirConditioner'
template_list = generateAirConditionerChannel([70, 75, 80], 72.5)
generateChannelFromTemplate(template_list, name)

sleep(1)

pak = importlib.import_module('channels.autogen.' + name)
AirConditioner = getattr(pak, name)

class S(IoTSystem):
    ac = AirConditioner()

ac = S()
ltl = '!G(ac.thermostatGreaterThan70 & ac.thermostatLessThan75)'
result = generateFixForSafety(ac, ltl)
print(result)
for edge_result in result:
    print(edge_result[0][0].log())

field_list = [state.field for state in ac.transition_system.state_list]

ts = ac.transition_system
buchi_ts = Buchi.tsToGenBuchi(ts)
buchi_ltl = Buchi.ltlToBuchi(ltl)
(buchi_final, pairs) = Buchi.product(buchi_ts, buchi_ltl)


def generateStatement(crit_value_list, event_list, template):
    """
    return a set of statements that will cover all edges from a set of events for numeric variable in channel
    :param crit_value_list: list of numeric
    :param event_list: list of string
    :param template: string
    :return:
    """
    crit_value_list = sorted(crit_value_list)
    prefix_crit = crit_value_list[:-1]
    suffix_crit = crit_value_list[1:]
    mid_crit = [(v1+v2)/2 for v1, v2 in zip(suffix_crit, prefix_crit)]
    enhanced_crit_value_list = sorted(mid_crit + [crit_value_list[0]-1, crit_value_list[-1]+1] + crit_value_list)
    enhanced_crit_value_str_list = [str(v).replace('.', '_') for v in enhanced_crit_value_list]
    event_set_str_list = [event[len(template) + len('SetTo'):] for event in event_list]
    hit_pattern = ''.join([str(int(value in event_set_str_list)) for value in enhanced_crit_value_str_list])
    hit_pattern_list = [m.group(0) for m in re.finditer(r'(\d)\1*', hit_pattern)]

    cover_list = list()
    start_index = 0
    for pattern in hit_pattern_list:
        if '1' in pattern:
            cover_list.append((start_index, start_index + len(pattern)))
        start_index = start_index + len(pattern)

    statement_list = list()
    for cover in cover_list:
        if cover[0] != 0 and cover[1] != len(hit_pattern):
            pass
        elif cover[0] == 0 and cover[1] != len(hit_pattern):
            pass
        elif cover[0] != 0 and cover[1] == len(hit_pattern):
            pass
        elif cover[0] == 0 and cover[1] == len(hit_pattern):
            pass
    print(enhanced_crit_value_str_list)
    print(hit_pattern_list)
    print(cover_list)




##### The following part is to test getting a statement from a set of events
crit_value_list = [70, 75, 80]
edge_dict_by_src = dict()
numeric_template_list = ['ac.thermostat']

for edge in buchi_final.edge_list:
    if not buchi_final.getStateAcc(edge.src) and buchi_final.getStateAcc(edge.dst):
        src_index_ts = pairs[edge.src][0]
        if src_index_ts == ts.num_state:
            continue
        src_field_ts = field_list[src_index_ts]

        if src_index_ts not in edge_dict_by_src:
            edge_dict_by_src[src_index_ts] = [edge]
        else:
            edge_dict_by_src[src_index_ts].append(edge)

edge_dict = dict()

for src_index, edge_list in edge_dict_by_src.items():
    edge_dict_by_template = dict()

    for template in numeric_template_list:
        for edge in edge_list:
            src_index_ts = pairs[edge.src][0]

            if src_index_ts == ts.num_state:
                continue
            event = '@' + edge.description
            if event.startswith('@%s' % template):
                if template not in edge_dict_by_template:
                    edge_dict_by_template[template] = [edge]
                else:
                    edge_dict_by_template[template].append(edge)

    edge_dict[src_index] = edge_dict_by_template


for src_index, dt in edge_dict.items():
    for template, el in dt.items():
        getEvent = lambda ap: [entry for entry in ap.split(' & ') if entry.startswith('@')][0][1:]
        event_list = [getEvent(edge.ap) for edge in el]
        generateStatement(crit_value_list, event_list, template)

generateGraph(ac, ltl, 'temp/template', only_action=True)
