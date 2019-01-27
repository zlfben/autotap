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

import sys


class State(object):
    def __init__(self, field, description):
        self.field = field
        self.description = description


class Transition(object):
    def __init__(self, src_index, act, dst_index):
        self.src_index = src_index
        self.act = act
        self.dst_index = dst_index


class TS(object):
    # S: set of state (list)
    # ACT: list of actions
    # TRANS: list of transitions
    # AP: list of name of AP
    # L: labeling function
    def __init__(self, ap_list):
        self.state_list = []
        self.act_list = []
        self.trans_list = []
        self.ap_list = ap_list
        self.label_list = []
        self.num_state = 0

    def ifStateExists(self, state):
        match = [s.field for s in self.state_list]
        if state.field in match:
            return 1
        else:
            return 0

    def ifActionExists(self, action):
        return int(action in self.act_list)

    def addState(self, state, label):
        # assert not self.ifStateExists(state)
        assert len(label) == len(self.ap_list)
        self.state_list.append(state)
        self.label_list.append(label)
        self.num_state = self.num_state + 1
        return self.num_state - 1

    def addAction(self, act):
        assert act not in self.act_list
        self.act_list.append(act)

    def addTrans(self, trans):
        assert trans.src_index < self.num_state and trans.dst_index < self.num_state
        self.trans_list.append(trans)

    def findAction(self, src_field, dst_field):
        for trans in self.trans_list:
            if self.state_list[trans.src_index].field == src_field and \
                    self.state_list[trans.dst_index].field == dst_field:
                return trans.act
        return None

    def getField(self, index):
        return self.state_list[index].field

    def getIndex(self, field):
        field_list = [state.field for state in self.state_list]
        return field_list.index(field)

    def getPrevField(self, field):
        """
        Given current field, return one previous state's field
        :param field:
        :return: previous field
        """
        for tran in self.trans_list:
            if self.getField(tran.dst_index) == field:
                return self.getField(tran.src_index)
        return None

    def getPrevIndex(self, index):
        """
        Given current index, return one previous state's index
        :param index:
        :return:
        """
        for tran in self.trans_list:
            if tran.dst_index == index:
                return tran.src_index
        return None

    def writeToFile(self):
        # TODO: save the transition system into file
        pass

    def printToGv(self):
        print('digraph {')
        field_list = [state.field for state in self.state_list]
        for state, index in zip(self.state_list, range(len(self.state_list))):
            print('\tnode [label=\"%s\"] s%d' % (state.description, index))
        for trans in self.trans_list:
            print('\ts%d -> s%d [label = \"%s\"]' % (trans.src_index, trans.dst_index, trans.act))
        print('}')

    def writeToGv(self, filename):
        with open(filename, 'w') as fp:
            stdout = sys.stdout
            sys.stdout = fp
            self.printToGv()
            sys.stdout = stdout

    def printToPml(self):
        field_list = [state.field for state in self.state_list]
        ap_list = [ap.replace('.', '_') for ap in self.ap_list]
        for ap, index in zip(ap_list, range(len(ap_list))):
            print('bool %s = %d;' % (ap, self.label_list[0][index]))
        print('')
        print('')
        print('proctype main()')
        print('{')
        for state, index in zip(self.state_list, range(len(self.state_list))):
            print('state_%d:' % index)
            print('\tprintf(\"state=%s\\n\");' % state.description)
            print('\tatomic {')
            for ap, ap_index in zip(ap_list, range(len(ap_list))):
                print('\t\t%s = %d;' % (ap, self.label_list[index][ap_index]))
            print('\t}')
            print('\tif')
            for trans in self.trans_list:
                if trans.src_field == state.field:
                    print('\t::')
                    print('\t\tprintf(\"action: %s\\n\");' % trans.act)
                    print('\t\tgoto state_%d;' % field_list.index(trans.dest_field))
            print('\tfi')
            print('')
        print('}')
        print('')
        print('')
        print('init')
        print('{')
        print('\trun main()')
        print('}')

    def writeToPml(self, filename):
        with open(filename, 'w') as fp:
            stdout = sys.stdout
            sys.stdout = fp
            self.printToPml()
            sys.stdout = stdout
