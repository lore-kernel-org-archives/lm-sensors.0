From: Karsten de Freese <karsten@maxi-dsl.de>
Date: Sun, 20 Nov 2011 23:03:36 +0000
Subject: Re: [lm-sensors] looking for help with W83795ADG
Message-Id: <4EC98748.4030805@maxi-dsl.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101022135607.6996731s0m2gcr48@webmail.mnet-online.de>
In-Reply-To: <20101022135607.6996731s0m2gcr48@webmail.mnet-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

hello Eddi,

a less-than-welcome update:

at least when the three modules i2c-piix4.ko, i2c-piix4-n36l.ko,=20
w83795.ko are loaded,  a restart (sudo shutdown -r now) of my N36L=20
fails, the system does not come up until I do a complete power cycle.=20
I'll have to look more closely at this, once I have physical access to=20
the box again.

regards -

Karsten

Am 20.11.2011 14:38, schrieb Karsten de Freese:
> hello Eddi,
>
> Success!
>
> Thanks for the detailed steps. This all works as described, at least=20
> as far as the 'sensors' output is concerned. With the respective=20
> modules, I get all the measurements you're listing! (See attached.)
>
> 'i2cdetect -l' will however not produce any output for whatsoever reason.
>
> The next thing I'd like to find out is how to load the modules=20
> automatically in a clean / kernel-upgrade-proof way..
>
> thanks and regards -
>
> Karsten
>
>
> Am 18.11.2011 11:09, schrieb Eddi De Pieri:
>> I suggest you:
>>
>>
>> mkdir ~/piix4-n36l
>> cp=20
>> [yourlinuxtree]/usr/src/linux-source-2.6.32/drivers/i2c/busses/i2c-piix4=
.c
>> ~/piix4-n36l/
>> cp ~/Downloads/Makefile ~/piix4-n36l/
>> cd  ~/piix4-n36l/
>>
>> patch -p1<  proliant-microserver-n36l.diff
>> make
>> you will have your new module inside ~/piix4-n36l/
>>
>> rmmod i2c-piix4
>> insmod ./i2c-piix4.ko
>> insmod ./i2c-piix4-n36l.ko
>>
>> insmod w83795 (you should already build separately)
>>
>> sensors
>>
>> regards Eddi.
>>
>> I hope an answer from Jean... I'd like if this patch may be inserted
>> in mainstream linux with the necessary adjustment..
>>
>> On Thu, Nov 17, 2011 at 11:39 PM, Karsten de=20
>> Freese<karsten@maxi-dsl.de>  wrote:
>>> hello Eddi,
>>>
>>> I'm ready for two questions ;-)
>>>
>>> .diff / patch looks simple, and I also found i2c-amd756-s4882.c -=20
>>> however:
>>> - the diff file actually describes the patch to be on top of=20
>>> i2c-piix4.c?
>>> - if I'd compile the patched file, would that give me a standalone=20
>>> driver?
>>>
>>> thanks for your help -
>>>
>>> Karsten
>>>
>>> On 17.11.2011 22:25, Karsten de Freese wrote:
>>>> hi Eddi,
>>>>
>>>> thanks very much - I had almost forgotten about the topic, but=20
>>>> stumbled
>>>> across it again a few days ago, so that's very interesting.
>>>> I'm not yet familiar with .diff patches, and may welcome a little=20
>>>> help.
>>>> However, let me try to find out on my own first..
>>>>
>>>> thanks&  regards -
>>>>
>>>> Karsten
>>>>
>>>> On 16.11.2011 17:18, Eddi De Pieri wrote:
>>>>> Finally I get W83795ADG working on my proliant microserver
>>>>>
>>>>> The patch is based on i2c-amd756-s4882.c and adapted for sb800=20
>>>>> southbus.
>>>>>
>>>>> Karsten, please try it too...
>>>>>
>>>>> root@proliant:/usr/src/lm-sensors/eddi# i2cdetect -l
>>>>> i2c-0   smbus           SMBus piix4 adapter (SDA0)              SMBus
>>>>> adapter
>>>>> i2c-1   smbus           SMBus piix4 adapter (SDA2)              SMBus
>>>>> adapter
>>>>> i2c-2   smbus           SMBus piix4 adapter (SDA3)              SMBus
>>>>> adapter
>>>>> i2c-3   smbus           SMBus piix4 adapter (SDA4)              SMBus
>>>>> adapter
>>>>> root@proliant:/usr/src/lm-sensors/eddi#
>>>>>
>>>>> yes SDA1 is reserved... so i can't multiplex it
>>>>>
>>>>> root@proliant:/usr/src/lm-sensors/eddi# sensors
>>>>> k10temp-pci-00c3
>>>>> Adapter: PCI adapter
>>>>> temp1:       +24.5=B0C  (high =3D +70.0=B0C, crit =3D +100.0=B0C)
>>>>>
>>>>> w83795adg-i2c-1-2f
>>>>> Adapter: SMBus piix4 adapter (SDA2)
>>>>> in0:         +1.02 V  (min =3D  +0.00 V, max =3D  +2.05 V)
>>>>> in1:         +1.52 V  (min =3D  +0.00 V, max =3D  +2.05 V)
>>>>> in2:         +1.10 V  (min =3D  +0.00 V, max =3D  +2.05 V)
>>>>> in3:         +0.89 V  (min =3D  +0.00 V, max =3D  +2.05 V)
>>>>> in12:        +3.35 V  (min =3D  +0.00 V, max =3D  +6.14 V)
>>>>> in13:        +3.28 V  (min =3D  +0.00 V, max =3D  +6.14 V)
>>>>> fan1:        703 RPM  (min =3D  329 RPM)
>>>>> temp1:       +23.0=B0C  (high =3D +109.0=B0C, hyst =3D +109.0=B0C)
>>>>>                        (crit =3D +109.0=B0C, hyst =3D +109.0=B0C)  se=
nsor =3D
>>>>> thermal diode
>>>>> temp2:       +33.2=B0C  (high =3D +105.0=B0C, hyst =3D +105.0=B0C)
>>>>>                        (crit =3D +105.0=B0C, hyst =3D +105.0=B0C)  se=
nsor =3D
>>>>> thermal diode
>>>>> temp5:       +14.0=B0C  (high =3D +39.0=B0C, hyst =3D +39.0=B0C)
>>>>>                        (crit =3D +44.0=B0C, hyst =3D +44.0=B0C)  sens=
or =3D
>>>>> thermistor
>>>>> beep_enable:disabled
>>>>>
>>>>> jc42-i2c-0-18
>>>>> Adapter: SMBus piix4 adapter (SDA0)
>>>>> temp1:       +20.5=B0C  (low  =3D  +0.0=B0C, high =3D  +0.0=B0C)  ALA=
RM
>>>>>                        (crit =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALARM
>>>>>
>>>>>
>>>>> root@proliant:/usr/src/lm-sensors/eddi# i2cdetect -y 0
>>>>>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>>>>> 00:          -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>> 10: -- -- -- -- -- -- -- -- UU -- -- -- -- -- -- --
>>>>> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>> 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>> 50: 50 -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>> 70: -- -- -- -- -- -- -- --
>>>>>
>>>>> root@proliant:/usr/src/lm-sensors/eddi# i2cdetect -y 1
>>>>>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>>>>> 00:          -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- UU
>>>>> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>> 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>> 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>> 60: -- 61 -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>> 70: -- -- -- -- -- -- -- --
>>>>>
>>>>> root@proliant:/usr/src/lm-sensors/eddi# i2cdetect -y 2
>>>>>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>>>>> 00:          -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>> 40: -- -- -- -- -- -- -- -- -- -- -- -- 4c -- -- --
>>>>> 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>> 70: -- -- -- -- -- -- -- --
>>>>>
>>>>> root@proliant:/usr/src/lm-sensors/eddi# i2cdetect -y 3
>>>>>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>>>>> 00:          -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>> 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>> 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>> 70: -- -- -- -- -- -- -- --
>>>>>
>>>>> pay attention that the msleep seems to be really needed...
>>>>>
>>>>> Regards, Eddi
>>>>>
>>>>> On Tue, Aug 16, 2011 at 9:26 AM, Eddi De=20
>>>>> Pieri<eddi@depieri.net>    wrote:
>>>>>> Hi Jean...
>>>>>>
>>>>>> The bios show fan rpm and temperature. Since my own proliant=20
>>>>>> microserver
>>>>>> lacks of ipmi card, I doubt the bios give me the results using=20
>>>>>> ipmi call.
>>>>>>
>>>>>> The HP Proliant Microserver chipset (SB820M) have a multiplexed=20
>>>>>> smbus
>>>>>> like your.
>>>>>>
>>>>>>
>>>>>> http://support.amd.com/it/Embedded_TechDocs/47283_sb820m_ds_pub_2.00=
.pdf=20
>>>>>>
>>>>>>
>>>>>> Here is technical document from amd...
>>>>>>
>>>>>>
>>>>>> at p52/53 they say:
>>>>>>
>>>>>> (1) The SDA1 and SCL1 SMBus interface is dedicated for ASF=20
>>>>>> devices only.
>>>>>> It should not be used to
>>>>>> connect to any other devices.
>>>>>> (2) There are only two SMBus controllers. The SCL1/SDA1 pair is
>>>>>> controlled by SMBus controller 1.
>>>>>>
>>>>>>
>>>>>> SCL0/SDA0, SCL2/SDA2, SCL3/SDA3 and SCL4/SDA4 are multiplexed=20
>>>>>> pins that
>>>>>> are all controlled by
>>>>>> SMBus controller 0, and only 1 pair of those pins can be active=20
>>>>>> at any
>>>>>> time.
>>>>>>
>>>>>> I can't understand how to enable 2, 3 and 4 muxed bus..
>>>>>>
>>>>>>
>>>>>> If you consolidate a solution for i2c-i801.c I hope we can be=20
>>>>>> replicated
>>>>>> for i2c-piix4.c too..
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> Hi Karsten,
>>>>>>
>>>>>> On Fri, 22 Oct 2010 16:04:10 +0200, karsten at maxi-dsl.de wrote:
>>>>>>> hi Jean,
>>>>>>>> The w83795 driver uses the same detection mechanism used in
>>>>>>>> sensors-detect. So if sensors-detect doesn't see your chip, I=20
>>>>>>>> am not
>>>>>>>> surprised that the driver didn't either.
>>>>>>>> The full output of sensors-detect is needed to diagnose your=20
>>>>>>>> problem
>>>>>>>> further. It could be that your SMBus controller isn't=20
>>>>>>>> supported, or
>>>>>>>> maybe you are supposed to access the chip through IPMI.
>>>>>>> IPMI is probably the key..
>>>>>>>    From the sensors-detect output:
>>>>>>> "Warning: the required module ipmisensors is not currently=20
>>>>>>> installed
>>>>>>> on your system. If it is built into the kernel then it's OK.
>>>>>>> Otherwise, checkhttp://www.lm-sensors.org/wiki/Devices  for
>>>>>>> driver availability" (full ouput attached)
>>>>>>>
>>>>>>> I did see the output before, but didn't really understand the
>>>>>>> implications (IPMI seems to be an alternative way of accessing the
>>>>>>> monitoring chips?)
>>>>>> Yes. The strength of IPMI access is that it can be used remotely=20
>>>>>> too,
>>>>>> for example from a BMC plugged into your system.
>>>>>>
>>>>>>
>>>>>>
>>>>>>> The suggested ipmisensors driver however does not seem to be=20
>>>>>>> available,
>>>>>>> right?
>>>>>>> (http://lm-sensors.org/wiki/Devices  says "(2004-12-12)  Port to=20
>>>>>>> Linux
>>>>>>> 2.6 in progress by Yani Ioannou")
>>>>>> That project is essentially dead. At the time being, the best way to
>>>>>> retrieve IPMI-based sensor values is using "ipmitool sensor". The
>>>>>> drawback is that this isn't integrated with libsensors, so the=20
>>>>>> usually
>>>>>>
>>>>>>
>>>>>> monitoring applications won't work.
>>>>>>
>>>>>> If you have a BMC or are otherwise already using IPMI on your=20
>>>>>> machine,
>>>>>> just use ipmitool and you're done.
>>>>>>
>>>>>> If not, then it might be worth trying ipmitool once, and then try
>>>>>>
>>>>>>
>>>>>> sensors-detect again. There is a small chance that, once ipmitool
>>>>>> managed to access the monitoring device, sensors-detect will see=20
>>>>>> it. My
>>>>>> own mainboard which has a W83795ADG chip has a multiplexed SMBus,=20
>>>>>> and I
>>>>>> can only see the W83795ADG in sensors-detect when the multiplexer is
>>>>>>
>>>>>>
>>>>>> set properly. Otherwise I would see the memory modules, which _do_
>>>>>> appear in your sensors-detect output. So maybe your board has a
>>>>>> multiplexed SMBus too.
>>>>>>
>>>>>> If the trick doesn't work, you may want to try the new jc42 driver
>>>>>>
>>>>>>
>>>>>> which can monitor the temperature of some DDR3 memory modules. I
>>>>>> suspect your memory modules have such sensors. A more recent=20
>>>>>> version of
>>>>>> sensors-detect would confirm that:
>>>>>>    http://dl.lm-sensors.org/lm-sensors/files/sensors-detect
>>>>>>
>>>>>>
>>>>>>
>>>>>> I also see that sensors-detect suggested to use the k10temp driver,
>>>>>> which your kernel doesn't have. You can try the standalone flavor of
>>>>>> the drivers which I maintain at:
>>>>>>    http://khali.linux-fr.org/devel/misc/k10temp/
>>>>>>
>>>>>>
>>>>>> The accuracy of the CPU internal sensors is limited, but that's=20
>>>>>> still
>>>>>> better than nothing.
>>>>>>
>>>>>> --=20
>>>>>> Jean Delvare
>>>>>> http://khali.linux-fr.org/wishlist.html
>>>>>>
>>>>>>
>>>>
>>>
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
