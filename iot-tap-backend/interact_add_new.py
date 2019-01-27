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

from backend import models as m

def create_user():
    while True:
        name = input("Username: ")
        try:
            m.User.objects.get(name=name)
            print('Username already taken. Please use a new one')
            continue
        except m.User.DoesNotExist:
            m.User(name=name).save()
            break
    print("User successfully created.")
    return



def create_channel():
    name = input("Channel Name: ")
    while len(name) > 30 or len(name) < 1:
        print("Channel name must be between 1 and 30 characters.")
        name = input("Channel Name: ")

    has_icon = input("Does this channel have an icon? (y/n) ").lower()
    while has_icon not in ['y','n']:
        print("Invalid input.")
        has_icon = input("Does this channel have an icon? (y/n) ").lower()

    if has_icon == 'y':
        icon_name = input("Icon Name: ")
    else:
        icon_name = None

    add_caps = input("Would you like to add any existing capabilities to this channel? (y/n) ").lower()
    while add_caps not in ['y','n']:
        print("Invalid input.")
        add_caps = input("Would you like to add any existing capabilities to this channel? (y/n) ").lower()
    caps = []
    if add_caps == 'y':
        for cap in m.Capability.objects.all():
            print(cap.id,":",cap.name)
        while True:
            inp = input("Please list the ID #'s of all the capabilities you would like to add,\nseparated by spaces.\n")
            if inp:
                try:
                    ids = map(int,inp.split(' '))
                    caps = caps + [val for val in ids]
                except:
                    print("Invalid input.")


                cont = input("Would you like to add any other capabilities to this channel? (y/n) ").lower()
                while cont not in ['y','n']:
                    cont = input("Would you like to add any other capabilities to this channel? (y/n) ").lower()
                if cont == 'n':
                    break
                else:
                    continue

            else:
                break

    chan = m.Channel(name=name,icon=icon_name)
    chan.save()
    for capid in set(caps):
        cap = m.Capability.objects.get(id=capid)
        cap.channels.add(chan)

    print("Channel successfully created.")
    return

def create_device():
    name = input("Device Name: ")
    while name == '':
        name = input("Device Name: ")

    while True:
        username = input("Who owns this device? ")
        try:
            owner = m.User.objects.get(name=username)
            break
        except m.User.DoesNotExist:
            print("User '%s' not found." % username)

    for cap in m.Capability.objects.all().order_by('id'):
        print(cap.id,":",cap.name)

    caps = []
    while True:
        inp = input("Please list the ID #'s of all the capabilities you would like to add,\nseparated by spaces\n")
        if inp:
            try:
                caps_to_add = map(int,inp.split(' '))
                caps = caps + [val for val in caps_to_add]
                cont = input("Would you like to add any other capabilities? (y/n) ").lower()
                while cont not in ['y','n']:
                    cont = input("Would you like to add any other capabilities? (y/n) ").lower()

                if cont == 'n':
                    break
                else:
                    continue
                
            except:
                print("Invalid input.")
        else:
            break

    for chan in m.Channel.objects.all().order_by('id'):
        print(chan.id,":",chan.name)

    chans = []
    while True:
        inp = input("Please list the ID #'s of all the channels this device should belong in,\nseparated by spaces\n")
        if inp:
            try:
                chans_to_add = map(int,inp.split(' '))
                chans = chans + [val for val in chans_to_add]
                cont = input("Would you like to add any other channels? (y/n) ").lower()
                while cont not in ['y','n']:
                    cont = input("Would you like to add any other channels? (y/n) ").lower()

                if cont == 'n':
                    break
                else:
                    continue

            except:
                print("Invalid input.")
        else:
            break

    dev = m.Device(owner=owner,name=name)
    dev.save()
    for capid in set(caps):
        try:
            cap = m.Capability.objects.get(id=capid)
            dev.caps.add(cap)
        except m.Capability.DoesNotExist:
            pass
    for chanid in set(chans):
        try:
            chan = m.Channel.objects.get(id=chanid)
            dev.chans.add(chan)
        except m.Channel.DoesNotExist:
            pass

    print("Device successfully created.")


def create_parameter(cap=None):
    name = input("Parameter Name: ")
    while name == '':
        name = input("Parameter Name: ")
    
    if cap == None:
        for cap in m.Capability.objects.all().order_by('id'):
            print(cap.id,":",cap.name)
        while True:
            capid = input("Please input the capability # this is a parameter for: ")
            try:
                cap = m.Capability.objects.get(id=capid)
                break
            except m.Capability.DoesNotExist:
                print("Capability not found.")


    typeopts = ['set','range','bin','input','color','time','duration','meta']
    ty = input("Parameter Type: ").lower()
    while ty not in typeopts:
        print("Invalid input. Options: " + ", ".join(typeopts))
        ty = input("Parameter Type: ").lower()

    if ty == 'set':
        opts = []
        print("Please list each option on a separate line. Leave a blank line when finished.")
        while True:
            opt = input()
            if opt != "":
                opts.append(opt)
            else:
                break

        setpar = m.SetParam(name=name,type='set',cap=cap,numopts=len(opts))
        setpar.save()
        for opt in opts:
            m.SetParamOpt(value=opt,param=setpar).save()

        print("Fixed-Set Parameter Successfully Created.")
    elif ty == 'range':
        while True:
            rmin = input("Min: ")
            try:
                rmin = float(rmin)
                break
            except ValueError:
                print("Please input a valid number")

        while True:
            rmax = input("Max: ")
            try:
                rmax = float(rmax)
                break
            except ValueError:
                print("Please input a valid number")

        while True:
            scale = input("Scale: ")
            if scale:
                try:
                    scale = float(scale)
                    break
                except ValueError:
                    print("Please input a valid number")
            else:
                scale = 1
                break

        rangepar = m.RangeParam(name=name,type='range',cap=cap,min=rmin,max=rmax,interval=scale)
        rangepar.save()

        print("Range-Based Parameter Successfully Created.")
    elif ty == 'bin':
        tval = input("T val: ")
        fval = input("F val: ")

        binpar = m.BinParam(name=name,type='bin',cap=cap,tval=tval,fval=fval)
        binpar.save()
    elif ty == 'input':
        inputty = input("stxt, ltxt, or int? ").lower()
        while inputty not in ['stxt','ltxt','int']:
            inputty = input("stxt, ltxt, or int? ").lower()

        inputpar = m.InputParam(name=name,type='input',cap=cap,inputtype=inputty)
        inputpar.save()
    elif ty == 'color':
        colorty = input('hex, rgb, or hsv? ').lower()
        while colorty not in ['hex']:
            print('not supported.')
            colorty = input('hex, rgb, or hsv? ').lower()

        colorpar = m.ColorParam(name=name,type='color',cap=cap,mode=colorty)
        colorpar.save()
    elif ty == 'time':
        mode = input('12 or 24 hour time? ')
        while mode not in ['12','24']:
            mode = input('12 or 24 hour time? ')

        timepar = m.TimeParam(name=name,type='time',cap=cap,mode=mode)
        timepar.save()
    elif ty == 'duration':
        h = input('Hours? (y/n) ').lower()
        while h not in ['y','n']:
            h = input('Hours? (y/n) ').lower()
        if h == 'y':
            while True:
                try:
                    hmax = int(input('Max Hours: '))
                    break
                except ValueError:
                    pass
        else:
            hmax = None

        mins = input("Minutes? (y/n) ").lower()
        while mins not in ['y','n']:
            mins = input("Minutes? (y/n) ").lower()
        if mins == 'y':
            while True:
                try:
                    mmax = int(input("Max Minutes: "))
                    break
                except ValueError:
                    pass
        else:
            mmax = None

        s = input("Seconds? (y/n) ").lower()
        while s not in ['y','n']:
            s = input("Seconds? (y/n) ").lower()
        if s == 'y':
            while True:
                try:
                    smax = int(input("Max Seconds: "))
                    break
                except ValueError:
                    pass
        else:
            smax = None
        
        durpar = m.DurationParam(name=name,type='duration',cap=cap,maxhours=hmax,maxmins=mmax,maxsecs=smax)
        durpar.save()
    elif ty == 'meta':
        inp = input("Is Event? (y/n) ").lower()
        while inp not in ['y','n']:
            inp = input("Is Event? (y/n) ").lower()

        if inp == 'y':
            is_event = True
        else:
            is_event = False

        metapar = m.MetaParam(name=name,type='meta',cap=cap,is_event=is_event)
        metapar.save()

    else:
        print("Could not create parameter.")

def create_capability():
    name = input("Capability Name: ")
    while name == '':
        name = input("Capability Name: ")

    chans = []
    for chan in m.Channel.objects.all().order_by('id'):
        print(chan.id,":",chan.name)
    while True:
        inp = input("Please list the ID #'s of all existing channels this capability belongs in,\nseparated by spaces.\n")
        if inp:
            try:
                chans_to_add = map(int,inp.split(' '))
                chans = chans + [val for val in chans_to_add]
                cont = input("Would you like to add this to any other channels? (y/n)").lower()
                while cont not in ['y','n']:
                    cont = input("Would you like to add this to any other channels? (y/n)").lower()
                if cont == 'n':
                    break
                else:
                    continue
            except:
                print("Invalid input.")
        else:
            break

    devs = []
    for dev in m.Device.objects.all().order_by('id'):
        print(dev.id,":",dev.name)
    while True:
        inp = input("Please list the ID #'s of any existing devices that should have this capability,\nseparated by spaces.\n")
        if inp:
            try:
                devs_to_add = map(int,inp.split(' '))
                devs = devs + [val for val in devs_to_add]
                cont = input("Would you like to add this to any other devices? (y/n)".lower())
                while cont not in ['y','n']:
                    cont = input("Would you like to add this to any other devices? (y/n)".lower())
                if cont == 'n':
                    break
                else:
                    continue
            except:
                print("Invalid input.")
        else:
            break
                    

    cap = m.Capability(name=name)
    cap.save()

    add_params = input("Does this capability have any parameters? (y/n)").lower()
    while add_params not in ['y','n']:
        add_params = input("Does this capability have any parameters? (y/n)").lower()

    if add_params == 'y':
        while True:
            create_parameter(cap)
            cont = input("Does this capability have any additional parameters? (y/n)".lower())
            while cont not in ['y','n']:
                cont = input("Does this capability have any additional parameters? (y/n)".lower())

            if cont == 'n':
                break
            else:
                continue


    inp = input("Is this capability readable? (y/n) ").lower()
    while inp not in ['y','n']:
        inp = input("Is this capability readable? (y/n) ").lower()

    readable = True if inp == 'y' else False
    
    if readable:
        statelabel=input("State Label:\nUse {DEVICE} as a stand-in for the device name, or a parameter name in curly braces\n as a stand-in for its value.\n")
        eventlabel=input("Event Label:\nUse {DEVICE} as a stand-in for the device name, or a parameter name in curly braces\n as a stand-in for its value.\n")
    else:
        statelabel=None
        eventlabel=None

    inp = input("Is this capability writeable? (y/n) ").lower()
    while inp not in ['y','n']:
        inp = input("Is this capability writeable? (y/n) ").lower()

    writeable = True if inp == 'y' else False

    if writeable:
        commandlabel=input("Command Label:\nUse {DEVICE} as a stand-in for the device name, or a parameter name in curly braces\n as a stand-in for its value.\n")
    else:
        commandlabel=None

    cap.readable=readable
    cap.writeable=writeable
    cap.statelabel=statelabel
    cap.eventlabel=eventlabel
    cap.commandlabel=commandlabel
    cap.save()

    for chanid in set(chans):
        try:
            chan = m.Channel.objects.get(id=chanid)
            cap.channels.add(chan)
        except m.Channel.DoesNotExist:
            pass

    for devid in set(devs):
        try:
            dev = m.Device.objects.get(id=devid)
            dev.caps.add(cap)
        except m.Device.DoesNotExist:
            pass

    print("Capability successfully created.")
    return



def main():
    while True:
        type = input("What would you like to create?\n").lower()
        typeopts = ['channel','user','device','dev','capability','cap']
        while type not in typeopts:
            type = input("Please select one of the following:\n" + ", ".join(typeopts) + "\n")

        print("")
        if type == 'channel':
            create_channel()
        elif type in ['cap','capability']:
            create_capability()
        elif type in ['dev','device']:
            create_device()
        elif type == 'user':
            create_user()
        
        print("")

        cont = input("Would you like to create anything else? (y/n) ").lower()
        while cont not in ['y','n']:
            cont = input("Would you like to create anything else? (y/n) ").lower()
            
        if cont == 'n':
            print("Bye!")
            break
        else:
            continue

if __name__ == "__main__":
    main()
