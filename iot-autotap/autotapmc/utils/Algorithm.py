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


import itertools
import copy
import qm


def hittingSet(universe, set_list):
    """
    greedy algorithm that find minimum hitting set (approximate algorithm)
    :param universe: the universe set
    :param set_list: a list of all set to be hit
    :return: a hitting set
    """
    result = list()
    while set_list and universe:
        hit_num_list = [sum([entry in s for s in set_list]) for entry in universe]
        index, max_hit_num = max(enumerate(hit_num_list), key=lambda x: x[1])
        result.append(universe[index])
        set_list = [s for s in set_list if universe[index] not in s]
        del universe[index]
    return result


def qmPreProcess(one_list, zero_list):
    """
    delete all variables that shows as the same in every condition
    :param one_list:
    :param zero_list:
    :return:
    """
    var_list = list()
    one_list_l = [clause.split(' & ') for clause in one_list]
    zero_list_l = [clause.split(' & ') for clause in zero_list]
    for clause in one_list_l:
        var_list = var_list + clause
    for clause in zero_list_l:
        var_list = var_list + clause
    var_list = list(set([item for item in var_list]))
    delete_list = []
    for var in var_list:
        mark_one = [var in clause for clause in one_list_l]
        mark_zero = [var in clause for clause in zero_list_l]
        if all([entry == 1 for entry in mark_one + mark_zero]):
            delete_list.append(var)
    result_one = list()
    result_zero = list()
    for clause in one_list_l:
        new_clause = [entry for entry in clause if entry not in delete_list]
        result_one.append(' & '.join(new_clause))
    for clause in zero_list_l:
        new_clause = [entry for entry in clause if entry not in delete_list]
        result_zero.append(' & '.join(new_clause))

    return result_one, result_zero


def qmAlgorithm(one_list, zero_list):
    """
    perform qm algoithm to reduce the complexibility of a condition list
    :param xxx_list: the condition list should be (.. & ..) | (.. & .. & ..) | .., each cluase is a string item in
            xxx_list
    :return: a simplified condition_list
    """
    def fillInStar(fill_list, mask_list):
        new_mask = copy.deepcopy(mask_list)
        index_fill = 0
        for index_mask in range(len(mask_list)):
            if mask_list[index_mask] == '*':
                new_mask[index_mask] = fill_list[index_fill]
                index_fill = index_fill + 1
        return new_mask

    var_list = list()
    for clause in one_list:
        var_list = var_list + clause.split(' & ')
    for clause in zero_list:
        var_list = var_list + clause.split(' & ')
    var_list = list(set([item[1:] if item.startswith('!') else item for item in var_list]))
    var_num = len(var_list)

    one = list()
    zero = list()

    for condition in one_list:
        condition_list = condition.split(' & ')
        mask = ['*'] * var_num
        for cond in condition_list:
            if cond.startswith('!'):
                mask[var_list.index(cond[1:])] = '0'
            else:
                mask[var_list.index(cond)] = '1'
        num_star = sum([int(entry == '*') for entry in mask])
        for fill_list in itertools.product(['0', '1'], repeat=num_star):
            boolean_list = fillInStar(fill_list, mask)
            one_index = int(''.join(boolean_list), 2)
            one.append(one_index)
    for condition in zero_list:
        condition_list = condition.split(' & ')
        mask = ['*'] * var_num
        for cond in condition_list:
            if cond.startswith('!'):
                mask[var_list.index(cond[1:])] = '0'
            else:
                mask[var_list.index(cond)] = '1'
        num_star = sum([int(entry == '*') for entry in mask])
        for fill_list in itertools.product(['0', '1'], repeat=num_star):
            boolean_list = fillInStar(fill_list, mask)
            zero_index = int(''.join(boolean_list), 2)
            zero.append(zero_index)
    dc = [dc_index for dc_index in range(2 ** var_num) if dc_index not in one and dc_index not in zero]

    one = sorted(one)
    zero = sorted(zero)
    dc = sorted(dc)
    mask_list = qm.qm(ones=one, zeros=zero, dc=dc)

    result = list()
    for mask in mask_list:
        cond_list = list()
        for index, value in zip(range(len(mask)), mask):
            if value == '1':
                cond_list.append(var_list[index])
            elif value == '0':
                cond_list.append('!'+var_list[index])
        cond = ' & '.join(cond_list)
        result.append(cond)

    return result
