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


from autotapmc.channels.Weather import Weather
from autotapmc.channels.GarageDoor import GarageDoor
# from channels.Pizzashop import SimplePizzaShop
from autotapmc.channels.Location import Location
from autotapmc.channels.CoffeeMachine import SimpleCoffeeMachine
from autotapmc.model.IoTSystem import IoTSystem
from autotapmc.model.Tap import ESERule, SSERule, EERule
from autotapmc.analyze.Draw import generateGraph
import os


class RainGarage(IoTSystem):
    weather = Weather()
    door = GarageDoor()
    rule1 = ESERule('weather.startsRaining', 'door.open', 'door.close')
    rule2 = EERule('door.open', 'door.close')


class RainGarage2(IoTSystem):
    weather = Weather()
    door = GarageDoor()
    rule1 = ESERule('weather.startsRaining', 'door.open', 'door.close')
    # rule2 = ESERule('door', 'open', 'weather', 'ifRaining', 'door', 'close')


# class PizzaOrder(System):
#     pizzashop = SimplePizzaShop()
#     loc = Location()
#     # rule = SSERule('loc', 'within', 'pizzashop', 'onsale', 'pizzashop', 'order')
#     # rule = ESERule('loc', 'walkin', 'pizzashop', 'onsale', 'pizzashop', 'order')
#     # rule = ESERule('pizzashop', 'startsale', 'loc', 'within', 'pizzashop', 'order')
#     rule = EERule('pizzashop', 'startsale', 'pizzashop', 'order')


class CoffeeBrewing(IoTSystem):
    coffee_machine = SimpleCoffeeMachine()
    loc = Location()
    # rule = ESERule('loc', 'walkin', 'coffee_machine', '!brewing', 'coffee_machine', 'brew')
    rule = EERule('loc.walkin', 'coffee_machine.brew')


class ComplexHome(IoTSystem):
    coffee_machine = SimpleCoffeeMachine()
    loc = Location()
    weather = Weather()
    door = GarageDoor()
    rule1 = ESERule('weather.startsRaining', 'door.open', 'door.close')
    rule2 = EERule('loc.walkin', 'coffee_machine.brew')


try:
    os.stat('temp')
except FileNotFoundError:
    os.mkdir('temp')

rg = RainGarage()
rg_ltl = 'F (weather.raining & door.open)'
rg2 = RainGarage2()
rg2_ltl = 'F (weather.raining & door.open)'
# rg_ltl = 'F ((!rule1 & rule2) | (rule1 & !rule2))'

generateGraph(rg, rg_ltl, 'temp/test_rg')
generateGraph(rg2, rg2_ltl, 'temp/test_rg2')

# po = PizzaOrder()
# po_ltl = 'F G (rule)'
#
# generateGraph(po, po_ltl, 'temp/test_po')

cb = CoffeeBrewing()
cb_ltl = 'F (coffee_machine.wrong)'

generateGraph(cb, cb_ltl, 'temp/test_cb')

cplx = ComplexHome()
cplx_ltl = 'F (coffee_machine.wrong) | F (weather.raining & door.open)'

generateGraph(cplx, cplx_ltl, 'temp/test_cplx')
