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


import psycopg2

class DB(object):
    def __init__(self, db_name='db', username='user', password='password', host='localhost'):
        self.db_name = db_name
        self.username = username
        self.password = password
        self.host = host

        try:
            self.conn = psycopg2.connect(
                dbname=self.db_name, user=self.username, password=self.password, host=self.host)
        except Exception:
            raise Exception('unable to connect to database %s:%s' % (self.host, self.db_name))

        self.cur = self.conn.cursor()

    def fetchCapability(self, cap_id):
        self.cur.execute("""SELECT * FROM backend_capability WHERE id=%s""" % cap_id)
        return self.cur.fetchall()

    def fetchRule(self, rule_id):
        self.cur.execute("""SELECT * FROM backend_rule WHERE id=%s""" % rule_id)
        return self.cur.fetchall()

    def fetchRuleList(self, user_id, task_id):
        self.cur.execute("""SELECT id FROM backend_rule WHERE owner_id=%d AND task=%d""" % (user_id, task_id))
        raw_data_list = self.cur.fetchall()

        rule_list = list()
        for raw_rule in raw_data_list:
            # fetch esrule information
            rule_dict = dict()
            rule_dict['rule_id'] = raw_rule[0]
            self.cur.execute(
                """SELECT action_id, "Etrigger_id" FROM backend_esrule WHERE rule_ptr_id=%d""" % rule_dict['rule_id']
            )
            raw_esrule = self.cur.fetchall()[0]  # should be only one
            rule_dict['action_id'] = raw_esrule[0]
            rule_dict['trigger_id'] = raw_esrule[1]

            # fetch action information
            self.cur.execute("""SELECT cap_id, dev_id, text FROM backend_state WHERE id=%d""" % rule_dict['action_id'])
            raw_action = self.cur.fetchall()[0]  # should be only one
            rule_dict['action_cap_id'] = raw_action[0]
            rule_dict['action_dev_id'] = raw_action[1]
            rule_dict['action_text'] = raw_action[2]

            # fetch trigger information
            self.cur.execute(
                """SELECT cap_id, dev_id, text FROM backend_trigger WHERE id=%d""" % rule_dict['trigger_id']
            )
            raw_trigger = self.cur.fetchall()[0]  # should be only one
            rule_dict['trigger_cap_id'] = raw_trigger[0]
            rule_dict['trigger_dev_id'] = raw_trigger[1]
            rule_dict['trigger_text'] = raw_trigger[2]

            # fetch condition
            self.cur.execute(
                """SELECT trigger_id FROM "backend_esrule_Striggers" WHERE esrule_id=%d""" % rule_dict['rule_id']
            )
            raw_condition_id_list = self.cur.fetchall()
            condition_list = list()
            for raw_condition_id in raw_condition_id_list:
                condition_dict = dict()
                condition_dict['condition_id'] = raw_condition_id[0]
                self.cur.execute(
                    """SELECT cap_id, dev_id, text FROM backend_trigger WHERE id=%d""" % condition_dict['condition_id']
                )
                raw_condition = self.cur.fetchall()[0]  # should be only one
                condition_dict['condition_cap_id'] = raw_condition[0]
                condition_dict['condition_dev_id'] = raw_condition[1]
                condition_dict['condition_text'] = raw_condition[2]
                condition_list.append(condition_dict)

            rule_dict['condition_list'] = condition_list
            rule_list.append(rule_dict)

            print(rule_dict)
        # TODO: should modify the format into a list of TAP rule
        return rule_list
