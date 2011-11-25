From: Eddi De Pieri <eddi@depieri.net>
Date: Fri, 25 Nov 2011 10:22:41 +0000
Subject: Re: [lm-sensors] looking for help with W83795ADG
Message-Id: <CAKdnbx7uEXBcwLaiktSt6sHu5kDP5N5sPNyMHZziiM3RAZ6O5g@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101022135607.6996731s0m2gcr48@webmail.mnet-online.de>
In-Reply-To: <20101022135607.6996731s0m2gcr48@webmail.mnet-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Karsten,

about the complete power cycle issue:

While testing I had same problem like you... I had to remove power
cord to get my server back...

Now I tried a soft "reboot" and I get any issue..

So my patch seems to be fully working and I'd like to know how to
commit into mainstream.

I think may be useful for other pc based on same chipset like ours.

Regards,

Eddi

On Mon, Nov 21, 2011 at 12:03 AM, Karsten de Freese <karsten@maxi-dsl.de> w=
rote:
> hello Eddi,
>
> a less-than-welcome update:
>
> at least when the three modules i2c-piix4.ko, i2c-piix4-n36l.ko, w83795.ko
> are loaded, =A0a restart (sudo shutdown -r now) of my N36L fails, the sys=
tem
> does not come up until I do a complete power cycle. I'll have to look more
> closely at this, once I have physical access to the box again.
>
> regards -
>
> Karsten
>
> Am 20.11.2011 14:38, schrieb Karsten de Freese:
>>
>> hello Eddi,
>>
>> Success!
>>
>> Thanks for the detailed steps. This all works as described, at least as
>> far as the 'sensors' output is concerned. With the respective modules, I=
 get
>> all the measurements you're listing! (See attached.)
>>
>> 'i2cdetect -l' will however not produce any output for whatsoever reason.
>>
>> The next thing I'd like to find out is how to load the modules
>> automatically in a clean / kernel-upgrade-proof way..
>>
>> thanks and regards -
>>
>> Karsten
>>
>>
>> Am 18.11.2011 11:09, schrieb Eddi De Pieri:
>>>
>>> I suggest you:
>>>
>>>
>>> mkdir ~/piix4-n36l
>>> cp
>>> [yourlinuxtree]/usr/src/linux-source-2.6.32/drivers/i2c/busses/i2c-piix=
4.c
>>> ~/piix4-n36l/
>>> cp ~/Downloads/Makefile ~/piix4-n36l/
>>> cd =A0~/piix4-n36l/
>>>
>>> patch -p1< =A0proliant-microserver-n36l.diff
>>> make
>>> you will have your new module inside ~/piix4-n36l/
>>>
>>> rmmod i2c-piix4
>>> insmod ./i2c-piix4.ko
>>> insmod ./i2c-piix4-n36l.ko
>>>
>>> insmod w83795 (you should already build separately)
>>>
>>> sensors
>>>
>>> regards Eddi.
>>>
>>> I hope an answer from Jean... I'd like if this patch may be inserted
>>> in mainstream linux with the necessary adjustment..
>>>
>>> On Thu, Nov 17, 2011 at 11:39 PM, Karsten de Freese<karsten@maxi-dsl.de>
>>> =A0wrote:
>>>>
>>>> hello Eddi,
>>>>
>>>> I'm ready for two questions ;-)
>>>>
>>>> .diff / patch looks simple, and I also found i2c-amd756-s4882.c -
>>>> however:
>>>> - the diff file actually describes the patch to be on top of
>>>> i2c-piix4.c?
>>>> - if I'd compile the patched file, would that give me a standalone
>>>> driver?
>>>>
>>>> thanks for your help -
>>>>
>>>> Karsten
>>>>
>>>> On 17.11.2011 22:25, Karsten de Freese wrote:
>>>>>
>>>>> hi Eddi,
>>>>>
>>>>> thanks very much - I had almost forgotten about the topic, but stumbl=
ed
>>>>> across it again a few days ago, so that's very interesting.
>>>>> I'm not yet familiar with .diff patches, and may welcome a little hel=
p.
>>>>> However, let me try to find out on my own first..
>>>>>
>>>>> thanks& =A0regards -
>>>>>
>>>>> Karsten
>>>>>
>>>>> On 16.11.2011 17:18, Eddi De Pieri wrote:
>>>>>>
>>>>>> Finally I get W83795ADG working on my proliant microserver
>>>>>>
>>>>>> The patch is based on i2c-amd756-s4882.c and adapted for sb800
>>>>>> southbus.
>>>>>>
>>>>>> Karsten, please try it too...
>>>>>>
>>>>>> root@proliant:/usr/src/lm-sensors/eddi# i2cdetect -l
>>>>>> i2c-0 =A0 smbus =A0 =A0 =A0 =A0 =A0 SMBus piix4 adapter (SDA0) =A0 =
=A0 =A0 =A0 =A0 =A0 =A0SMBus
>>>>>> adapter
>>>>>> i2c-1 =A0 smbus =A0 =A0 =A0 =A0 =A0 SMBus piix4 adapter (SDA2) =A0 =
=A0 =A0 =A0 =A0 =A0 =A0SMBus
>>>>>> adapter
>>>>>> i2c-2 =A0 smbus =A0 =A0 =A0 =A0 =A0 SMBus piix4 adapter (SDA3) =A0 =
=A0 =A0 =A0 =A0 =A0 =A0SMBus
>>>>>> adapter
>>>>>> i2c-3 =A0 smbus =A0 =A0 =A0 =A0 =A0 SMBus piix4 adapter (SDA4) =A0 =
=A0 =A0 =A0 =A0 =A0 =A0SMBus
>>>>>> adapter
>>>>>> root@proliant:/usr/src/lm-sensors/eddi#
>>>>>>
>>>>>> yes SDA1 is reserved... so i can't multiplex it
>>>>>>
>>>>>> root@proliant:/usr/src/lm-sensors/eddi# sensors
>>>>>> k10temp-pci-00c3
>>>>>> Adapter: PCI adapter
>>>>>> temp1: =A0 =A0 =A0 +24.5=B0C =A0(high =3D +70.0=B0C, crit =3D +100.0=
=B0C)
>>>>>>
>>>>>> w83795adg-i2c-1-2f
>>>>>> Adapter: SMBus piix4 adapter (SDA2)
>>>>>> in0: =A0 =A0 =A0 =A0 +1.02 V =A0(min =3D =A0+0.00 V, max =3D =A0+2.0=
5 V)
>>>>>> in1: =A0 =A0 =A0 =A0 +1.52 V =A0(min =3D =A0+0.00 V, max =3D =A0+2.0=
5 V)
>>>>>> in2: =A0 =A0 =A0 =A0 +1.10 V =A0(min =3D =A0+0.00 V, max =3D =A0+2.0=
5 V)
>>>>>> in3: =A0 =A0 =A0 =A0 +0.89 V =A0(min =3D =A0+0.00 V, max =3D =A0+2.0=
5 V)
>>>>>> in12: =A0 =A0 =A0 =A0+3.35 V =A0(min =3D =A0+0.00 V, max =3D =A0+6.1=
4 V)
>>>>>> in13: =A0 =A0 =A0 =A0+3.28 V =A0(min =3D =A0+0.00 V, max =3D =A0+6.1=
4 V)
>>>>>> fan1: =A0 =A0 =A0 =A0703 RPM =A0(min =3D =A0329 RPM)
>>>>>> temp1: =A0 =A0 =A0 +23.0=B0C =A0(high =3D +109.0=B0C, hyst =3D +109.=
0=B0C)
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (crit =3D +109.0=B0C, hy=
st =3D +109.0=B0C) =A0sensor =3D
>>>>>> thermal diode
>>>>>> temp2: =A0 =A0 =A0 +33.2=B0C =A0(high =3D +105.0=B0C, hyst =3D +105.=
0=B0C)
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (crit =3D +105.0=B0C, hy=
st =3D +105.0=B0C) =A0sensor =3D
>>>>>> thermal diode
>>>>>> temp5: =A0 =A0 =A0 +14.0=B0C =A0(high =3D +39.0=B0C, hyst =3D +39.0=
=B0C)
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (crit =3D +44.0=B0C, hys=
t =3D +44.0=B0C) =A0sensor =3D
>>>>>> thermistor
>>>>>> beep_enable:disabled
>>>>>>
>>>>>> jc42-i2c-0-18
>>>>>> Adapter: SMBus piix4 adapter (SDA0)
>>>>>> temp1: =A0 =A0 =A0 +20.5=B0C =A0(low =A0=3D =A0+0.0=B0C, high =3D =
=A0+0.0=B0C) =A0ALARM
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (crit =3D =A0+0.0=B0C, h=
yst =3D =A0+0.0=B0C) =A0ALARM
>>>>>>
>>>>>>
>>>>>> root@proliant:/usr/src/lm-sensors/eddi# i2cdetect -y 0
>>>>>> =A0 =A0 =A00 =A01 =A02 =A03 =A04 =A05 =A06 =A07 =A08 =A09 =A0a =A0b =
=A0c =A0d =A0e =A0f
>>>>>> 00: =A0 =A0 =A0 =A0 =A0-- -- -- -- -- -- -- -- -- -- -- -- --
>>>>>> 10: -- -- -- -- -- -- -- -- UU -- -- -- -- -- -- --
>>>>>> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>>> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>>> 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>>> 50: 50 -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>>> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>>> 70: -- -- -- -- -- -- -- --
>>>>>>
>>>>>> root@proliant:/usr/src/lm-sensors/eddi# i2cdetect -y 1
>>>>>> =A0 =A0 =A00 =A01 =A02 =A03 =A04 =A05 =A06 =A07 =A08 =A09 =A0a =A0b =
=A0c =A0d =A0e =A0f
>>>>>> 00: =A0 =A0 =A0 =A0 =A0-- -- -- -- -- -- -- -- -- -- -- -- --
>>>>>> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>>> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- UU
>>>>>> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>>> 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>>> 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>>> 60: -- 61 -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>>> 70: -- -- -- -- -- -- -- --
>>>>>>
>>>>>> root@proliant:/usr/src/lm-sensors/eddi# i2cdetect -y 2
>>>>>> =A0 =A0 =A00 =A01 =A02 =A03 =A04 =A05 =A06 =A07 =A08 =A09 =A0a =A0b =
=A0c =A0d =A0e =A0f
>>>>>> 00: =A0 =A0 =A0 =A0 =A0-- -- -- -- -- -- -- -- -- -- -- -- --
>>>>>> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>>> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>>> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>>> 40: -- -- -- -- -- -- -- -- -- -- -- -- 4c -- -- --
>>>>>> 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>>> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>>> 70: -- -- -- -- -- -- -- --
>>>>>>
>>>>>> root@proliant:/usr/src/lm-sensors/eddi# i2cdetect -y 3
>>>>>> =A0 =A0 =A00 =A01 =A02 =A03 =A04 =A05 =A06 =A07 =A08 =A09 =A0a =A0b =
=A0c =A0d =A0e =A0f
>>>>>> 00: =A0 =A0 =A0 =A0 =A0-- -- -- -- -- -- -- -- -- -- -- -- --
>>>>>> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>>> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>>> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>>> 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>>> 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>>> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>>> 70: -- -- -- -- -- -- -- --
>>>>>>
>>>>>> pay attention that the msleep seems to be really needed...
>>>>>>
>>>>>> Regards, Eddi
>>>>>>
>>>>>> On Tue, Aug 16, 2011 at 9:26 AM, Eddi De Pieri<eddi@depieri.net>
>>>>>> =A0wrote:
>>>>>>>
>>>>>>> Hi Jean...
>>>>>>>
>>>>>>> The bios show fan rpm and temperature. Since my own proliant
>>>>>>> microserver
>>>>>>> lacks of ipmi card, I doubt the bios give me the results using ipmi
>>>>>>> call.
>>>>>>>
>>>>>>> The HP Proliant Microserver chipset (SB820M) have a multiplexed smb=
us
>>>>>>> like your.
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> http://support.amd.com/it/Embedded_TechDocs/47283_sb820m_ds_pub_2.0=
0.pdf
>>>>>>>
>>>>>>> Here is technical document from amd...
>>>>>>>
>>>>>>>
>>>>>>> at p52/53 they say:
>>>>>>>
>>>>>>> (1) The SDA1 and SCL1 SMBus interface is dedicated for ASF devices
>>>>>>> only.
>>>>>>> It should not be used to
>>>>>>> connect to any other devices.
>>>>>>> (2) There are only two SMBus controllers. The SCL1/SDA1 pair is
>>>>>>> controlled by SMBus controller 1.
>>>>>>>
>>>>>>>
>>>>>>> SCL0/SDA0, SCL2/SDA2, SCL3/SDA3 and SCL4/SDA4 are multiplexed pins
>>>>>>> that
>>>>>>> are all controlled by
>>>>>>> SMBus controller 0, and only 1 pair of those pins can be active at
>>>>>>> any
>>>>>>> time.
>>>>>>>
>>>>>>> I can't understand how to enable 2, 3 and 4 muxed bus..
>>>>>>>
>>>>>>>
>>>>>>> If you consolidate a solution for i2c-i801.c I hope we can be
>>>>>>> replicated
>>>>>>> for i2c-piix4.c too..
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Hi Karsten,
>>>>>>>
>>>>>>> On Fri, 22 Oct 2010 16:04:10 +0200, karsten at maxi-dsl.de wrote:
>>>>>>>>
>>>>>>>> hi Jean,
>>>>>>>>>
>>>>>>>>> The w83795 driver uses the same detection mechanism used in
>>>>>>>>> sensors-detect. So if sensors-detect doesn't see your chip, I am
>>>>>>>>> not
>>>>>>>>> surprised that the driver didn't either.
>>>>>>>>> The full output of sensors-detect is needed to diagnose your
>>>>>>>>> problem
>>>>>>>>> further. It could be that your SMBus controller isn't supported, =
or
>>>>>>>>> maybe you are supposed to access the chip through IPMI.
>>>>>>>>
>>>>>>>> IPMI is probably the key..
>>>>>>>> =A0 From the sensors-detect output:
>>>>>>>> "Warning: the required module ipmisensors is not currently install=
ed
>>>>>>>> on your system. If it is built into the kernel then it's OK.
>>>>>>>> Otherwise, checkhttp://www.lm-sensors.org/wiki/Devices =A0for
>>>>>>>> driver availability" (full ouput attached)
>>>>>>>>
>>>>>>>> I did see the output before, but didn't really understand the
>>>>>>>> implications (IPMI seems to be an alternative way of accessing the
>>>>>>>> monitoring chips?)
>>>>>>>
>>>>>>> Yes. The strength of IPMI access is that it can be used remotely to=
o,
>>>>>>> for example from a BMC plugged into your system.
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>> The suggested ipmisensors driver however does not seem to be
>>>>>>>> available,
>>>>>>>> right?
>>>>>>>> (http://lm-sensors.org/wiki/Devices =A0says "(2004-12-12) =A0Port =
to
>>>>>>>> Linux
>>>>>>>> 2.6 in progress by Yani Ioannou")
>>>>>>>
>>>>>>> That project is essentially dead. At the time being, the best way to
>>>>>>> retrieve IPMI-based sensor values is using "ipmitool sensor". The
>>>>>>> drawback is that this isn't integrated with libsensors, so the
>>>>>>> usually
>>>>>>>
>>>>>>>
>>>>>>> monitoring applications won't work.
>>>>>>>
>>>>>>> If you have a BMC or are otherwise already using IPMI on your
>>>>>>> machine,
>>>>>>> just use ipmitool and you're done.
>>>>>>>
>>>>>>> If not, then it might be worth trying ipmitool once, and then try
>>>>>>>
>>>>>>>
>>>>>>> sensors-detect again. There is a small chance that, once ipmitool
>>>>>>> managed to access the monitoring device, sensors-detect will see it.
>>>>>>> My
>>>>>>> own mainboard which has a W83795ADG chip has a multiplexed SMBus, a=
nd
>>>>>>> I
>>>>>>> can only see the W83795ADG in sensors-detect when the multiplexer is
>>>>>>>
>>>>>>>
>>>>>>> set properly. Otherwise I would see the memory modules, which _do_
>>>>>>> appear in your sensors-detect output. So maybe your board has a
>>>>>>> multiplexed SMBus too.
>>>>>>>
>>>>>>> If the trick doesn't work, you may want to try the new jc42 driver
>>>>>>>
>>>>>>>
>>>>>>> which can monitor the temperature of some DDR3 memory modules. I
>>>>>>> suspect your memory modules have such sensors. A more recent version
>>>>>>> of
>>>>>>> sensors-detect would confirm that:
>>>>>>> =A0 http://dl.lm-sensors.org/lm-sensors/files/sensors-detect
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> I also see that sensors-detect suggested to use the k10temp driver,
>>>>>>> which your kernel doesn't have. You can try the standalone flavor of
>>>>>>> the drivers which I maintain at:
>>>>>>> =A0 http://khali.linux-fr.org/devel/misc/k10temp/
>>>>>>>
>>>>>>>
>>>>>>> The accuracy of the CPU internal sensors is limited, but that's sti=
ll
>>>>>>> better than nothing.
>>>>>>>
>>>>>>> --
>>>>>>> Jean Delvare
>>>>>>> http://khali.linux-fr.org/wishlist.html
>>>>>>>
>>>>>>>
>>>>>
>>>>
>>
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
