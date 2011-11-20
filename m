From: Karsten de Freese <karsten@maxi-dsl.de>
Date: Sun, 20 Nov 2011 13:38:23 +0000
Subject: Re: [lm-sensors] looking for help with W83795ADG
Message-Id: <4EC902CF.8080602@maxi-dsl.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------030502080902020609060102"
List-Id: <lm-sensors.vger.kernel.org>
References: <20101022135607.6996731s0m2gcr48@webmail.mnet-online.de>
In-Reply-To: <20101022135607.6996731s0m2gcr48@webmail.mnet-online.de>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------030502080902020609060102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

hello Eddi,

Success!

Thanks for the detailed steps. This all works as described, at least as=20
far as the 'sensors' output is concerned. With the respective modules, I=20
get all the measurements you're listing! (See attached.)

'i2cdetect -l' will however not produce any output for whatsoever reason.

The next thing I'd like to find out is how to load the modules=20
automatically in a clean / kernel-upgrade-proof way..

thanks and regards -

Karsten


Am 18.11.2011 11:09, schrieb Eddi De Pieri:
> I suggest you:
>
>
> mkdir ~/piix4-n36l
> cp [yourlinuxtree]/usr/src/linux-source-2.6.32/drivers/i2c/busses/i2c-p=
iix4.c
> ~/piix4-n36l/
> cp ~/Downloads/Makefile ~/piix4-n36l/
> cd  ~/piix4-n36l/
>
> patch -p1<  proliant-microserver-n36l.diff
> make
> you will have your new module inside ~/piix4-n36l/
>
> rmmod i2c-piix4
> insmod ./i2c-piix4.ko
> insmod ./i2c-piix4-n36l.ko
>
> insmod w83795 (you should already build separately)
>
> sensors
>
> regards Eddi.
>
> I hope an answer from Jean... I'd like if this patch may be inserted
> in mainstream linux with the necessary adjustment..
>
> On Thu, Nov 17, 2011 at 11:39 PM, Karsten de Freese<karsten@maxi-dsl.de=
>  wrote:
>> hello Eddi,
>>
>> I'm ready for two questions ;-)
>>
>> .diff / patch looks simple, and I also found i2c-amd756-s4882.c - howe=
ver:
>> - the diff file actually describes the patch to be on top of i2c-piix4=
.c?
>> - if I'd compile the patched file, would that give me a standalone dri=
ver?
>>
>> thanks for your help -
>>
>> Karsten
>>
>> On 17.11.2011 22:25, Karsten de Freese wrote:
>>> hi Eddi,
>>>
>>> thanks very much - I had almost forgotten about the topic, but stumbl=
ed
>>> across it again a few days ago, so that's very interesting.
>>> I'm not yet familiar with .diff patches, and may welcome a little hel=
p.
>>> However, let me try to find out on my own first..
>>>
>>> thanks&  regards -
>>>
>>> Karsten
>>>
>>> On 16.11.2011 17:18, Eddi De Pieri wrote:
>>>> Finally I get W83795ADG working on my proliant microserver
>>>>
>>>> The patch is based on i2c-amd756-s4882.c and adapted for sb800 south=
bus.
>>>>
>>>> Karsten, please try it too...
>>>>
>>>> root@proliant:/usr/src/lm-sensors/eddi# i2cdetect -l
>>>> i2c-0   smbus           SMBus piix4 adapter (SDA0)              SMBu=
s
>>>> adapter
>>>> i2c-1   smbus           SMBus piix4 adapter (SDA2)              SMBu=
s
>>>> adapter
>>>> i2c-2   smbus           SMBus piix4 adapter (SDA3)              SMBu=
s
>>>> adapter
>>>> i2c-3   smbus           SMBus piix4 adapter (SDA4)              SMBu=
s
>>>> adapter
>>>> root@proliant:/usr/src/lm-sensors/eddi#
>>>>
>>>> yes SDA1 is reserved... so i can't multiplex it
>>>>
>>>> root@proliant:/usr/src/lm-sensors/eddi# sensors
>>>> k10temp-pci-00c3
>>>> Adapter: PCI adapter
>>>> temp1:       +24.5=B0C  (high =3D +70.0=B0C, crit =3D +100.0=B0C)
>>>>
>>>> w83795adg-i2c-1-2f
>>>> Adapter: SMBus piix4 adapter (SDA2)
>>>> in0:         +1.02 V  (min =3D  +0.00 V, max =3D  +2.05 V)
>>>> in1:         +1.52 V  (min =3D  +0.00 V, max =3D  +2.05 V)
>>>> in2:         +1.10 V  (min =3D  +0.00 V, max =3D  +2.05 V)
>>>> in3:         +0.89 V  (min =3D  +0.00 V, max =3D  +2.05 V)
>>>> in12:        +3.35 V  (min =3D  +0.00 V, max =3D  +6.14 V)
>>>> in13:        +3.28 V  (min =3D  +0.00 V, max =3D  +6.14 V)
>>>> fan1:        703 RPM  (min =3D  329 RPM)
>>>> temp1:       +23.0=B0C  (high =3D +109.0=B0C, hyst =3D +109.0=B0C)
>>>>                        (crit =3D +109.0=B0C, hyst =3D +109.0=B0C)  s=
ensor =3D
>>>> thermal diode
>>>> temp2:       +33.2=B0C  (high =3D +105.0=B0C, hyst =3D +105.0=B0C)
>>>>                        (crit =3D +105.0=B0C, hyst =3D +105.0=B0C)  s=
ensor =3D
>>>> thermal diode
>>>> temp5:       +14.0=B0C  (high =3D +39.0=B0C, hyst =3D +39.0=B0C)
>>>>                        (crit =3D +44.0=B0C, hyst =3D +44.0=B0C)  sen=
sor =3D
>>>> thermistor
>>>> beep_enable:disabled
>>>>
>>>> jc42-i2c-0-18
>>>> Adapter: SMBus piix4 adapter (SDA0)
>>>> temp1:       +20.5=B0C  (low  =3D  +0.0=B0C, high =3D  +0.0=B0C)  AL=
ARM
>>>>                        (crit =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALA=
RM
>>>>
>>>>
>>>> root@proliant:/usr/src/lm-sensors/eddi# i2cdetect -y 0
>>>>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>>>> 00:          -- -- -- -- -- -- -- -- -- -- -- -- --
>>>> 10: -- -- -- -- -- -- -- -- UU -- -- -- -- -- -- --
>>>> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>> 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>> 50: 50 -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>> 70: -- -- -- -- -- -- -- --
>>>>
>>>> root@proliant:/usr/src/lm-sensors/eddi# i2cdetect -y 1
>>>>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>>>> 00:          -- -- -- -- -- -- -- -- -- -- -- -- --
>>>> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- UU
>>>> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>> 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>> 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>> 60: -- 61 -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>> 70: -- -- -- -- -- -- -- --
>>>>
>>>> root@proliant:/usr/src/lm-sensors/eddi# i2cdetect -y 2
>>>>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>>>> 00:          -- -- -- -- -- -- -- -- -- -- -- -- --
>>>> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>> 40: -- -- -- -- -- -- -- -- -- -- -- -- 4c -- -- --
>>>> 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>> 70: -- -- -- -- -- -- -- --
>>>>
>>>> root@proliant:/usr/src/lm-sensors/eddi# i2cdetect -y 3
>>>>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>>>> 00:          -- -- -- -- -- -- -- -- -- -- -- -- --
>>>> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>> 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>> 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>> 70: -- -- -- -- -- -- -- --
>>>>
>>>> pay attention that the msleep seems to be really needed...
>>>>
>>>> Regards, Eddi
>>>>
>>>> On Tue, Aug 16, 2011 at 9:26 AM, Eddi De Pieri<eddi@depieri.net>    =
wrote:
>>>>> Hi Jean...
>>>>>
>>>>> The bios show fan rpm and temperature. Since my own proliant micros=
erver
>>>>> lacks of ipmi card, I doubt the bios give me the results using ipmi=
 call.
>>>>>
>>>>> The HP Proliant Microserver chipset (SB820M) have a multiplexed smb=
us
>>>>> like your.
>>>>>
>>>>>
>>>>> http://support.amd.com/it/Embedded_TechDocs/47283_sb820m_ds_pub_2.0=
0.pdf
>>>>>
>>>>> Here is technical document from amd...
>>>>>
>>>>>
>>>>> at p52/53 they say:
>>>>>
>>>>> (1) The SDA1 and SCL1 SMBus interface is dedicated for ASF devices =
only.
>>>>> It should not be used to
>>>>> connect to any other devices.
>>>>> (2) There are only two SMBus controllers. The SCL1/SDA1 pair is
>>>>> controlled by SMBus controller 1.
>>>>>
>>>>>
>>>>> SCL0/SDA0, SCL2/SDA2, SCL3/SDA3 and SCL4/SDA4 are multiplexed pins =
that
>>>>> are all controlled by
>>>>> SMBus controller 0, and only 1 pair of those pins can be active at =
any
>>>>> time.
>>>>>
>>>>> I can't understand how to enable 2, 3 and 4 muxed bus..
>>>>>
>>>>>
>>>>> If you consolidate a solution for i2c-i801.c I hope we can be repli=
cated
>>>>> for i2c-piix4.c too..
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> Hi Karsten,
>>>>>
>>>>> On Fri, 22 Oct 2010 16:04:10 +0200, karsten at maxi-dsl.de wrote:
>>>>>> hi Jean,
>>>>>>> The w83795 driver uses the same detection mechanism used in
>>>>>>> sensors-detect. So if sensors-detect doesn't see your chip, I am =
not
>>>>>>> surprised that the driver didn't either.
>>>>>>> The full output of sensors-detect is needed to diagnose your prob=
lem
>>>>>>> further. It could be that your SMBus controller isn't supported, =
or
>>>>>>> maybe you are supposed to access the chip through IPMI.
>>>>>> IPMI is probably the key..
>>>>>>    From the sensors-detect output:
>>>>>> "Warning: the required module ipmisensors is not currently install=
ed
>>>>>> on your system. If it is built into the kernel then it's OK.
>>>>>> Otherwise, checkhttp://www.lm-sensors.org/wiki/Devices  for
>>>>>> driver availability" (full ouput attached)
>>>>>>
>>>>>> I did see the output before, but didn't really understand the
>>>>>> implications (IPMI seems to be an alternative way of accessing the
>>>>>> monitoring chips?)
>>>>> Yes. The strength of IPMI access is that it can be used remotely to=
o,
>>>>> for example from a BMC plugged into your system.
>>>>>
>>>>>
>>>>>
>>>>>> The suggested ipmisensors driver however does not seem to be avail=
able,
>>>>>> right?
>>>>>> (http://lm-sensors.org/wiki/Devices  says "(2004-12-12)  Port to L=
inux
>>>>>> 2.6 in progress by Yani Ioannou")
>>>>> That project is essentially dead. At the time being, the best way t=
o
>>>>> retrieve IPMI-based sensor values is using "ipmitool sensor". The
>>>>> drawback is that this isn't integrated with libsensors, so the usua=
lly
>>>>>
>>>>>
>>>>> monitoring applications won't work.
>>>>>
>>>>> If you have a BMC or are otherwise already using IPMI on your machi=
ne,
>>>>> just use ipmitool and you're done.
>>>>>
>>>>> If not, then it might be worth trying ipmitool once, and then try
>>>>>
>>>>>
>>>>> sensors-detect again. There is a small chance that, once ipmitool
>>>>> managed to access the monitoring device, sensors-detect will see it=
. My
>>>>> own mainboard which has a W83795ADG chip has a multiplexed SMBus, a=
nd I
>>>>> can only see the W83795ADG in sensors-detect when the multiplexer i=
s
>>>>>
>>>>>
>>>>> set properly. Otherwise I would see the memory modules, which _do_
>>>>> appear in your sensors-detect output. So maybe your board has a
>>>>> multiplexed SMBus too.
>>>>>
>>>>> If the trick doesn't work, you may want to try the new jc42 driver
>>>>>
>>>>>
>>>>> which can monitor the temperature of some DDR3 memory modules. I
>>>>> suspect your memory modules have such sensors. A more recent versio=
n of
>>>>> sensors-detect would confirm that:
>>>>>    http://dl.lm-sensors.org/lm-sensors/files/sensors-detect
>>>>>
>>>>>
>>>>>
>>>>> I also see that sensors-detect suggested to use the k10temp driver,
>>>>> which your kernel doesn't have. You can try the standalone flavor o=
f
>>>>> the drivers which I maintain at:
>>>>>    http://khali.linux-fr.org/devel/misc/k10temp/
>>>>>
>>>>>
>>>>> The accuracy of the CPU internal sensors is limited, but that's sti=
ll
>>>>> better than nothing.
>>>>>
>>>>> --
>>>>> Jean Delvare
>>>>> http://khali.linux-fr.org/wishlist.html
>>>>>
>>>>>
>>>
>>


--------------030502080902020609060102
Content-Type: text/plain;
 name="sensors_out"
Content-Disposition: attachment;
 filename="sensors_out"
Content-Transfer-Encoding: quoted-printable

karsten@ubuserv2:~$ sensors
k10temp-pci-00c3
Adapter: PCI adapter
CPU Temp (internal): +25.0=C2=B0C  (high =3D +70.0=C2=B0C, crit =3D +100.=
0=C2=B0C) =20

jc42-i2c-0-18
Adapter: SMBus piix4 adapter (SDA0)
temp1:       +21.2=C2=B0C  (low  =3D  +0.0=C2=B0C, high =3D  +0.0=C2=B0C)=
  ALARM =20
                      (crit =3D  +0.0=C2=B0C, hyst =3D  +0.0=C2=B0C)  ALA=
RM =20

jc42-i2c-0-19
Adapter: SMBus piix4 adapter (SDA0)
temp1:       +21.2=C2=B0C  (low  =3D  +0.0=C2=B0C, high =3D  +0.0=C2=B0C)=
  ALARM =20
                      (crit =3D  +0.0=C2=B0C, hyst =3D  +0.0=C2=B0C)  ALA=
RM =20

w83795adg-i2c-2-2f
Adapter: SMBus piix4 adapter (SDA2)
in0:         +0.89 V  (min =3D  +0.00 V, max =3D  +2.05 V)  =20
in1:         +1.50 V  (min =3D  +0.00 V, max =3D  +2.05 V)  =20
in2:         +1.10 V  (min =3D  +0.00 V, max =3D  +2.05 V)  =20
in3:         +0.87 V  (min =3D  +0.00 V, max =3D  +2.05 V)  =20
in12:        +3.29 V  (min =3D  +0.00 V, max =3D  +6.14 V)  =20
in13:        +3.23 V  (min =3D  +0.00 V, max =3D  +6.14 V)  =20
fan1:        699 RPM  (min =3D  329 RPM)
temp1:       +20.5=C2=B0C  (high =3D +109.0=C2=B0C, hyst =3D +109.0=C2=B0=
C) =20
                      (crit =3D +109.0=C2=B0C, hyst =3D +109.0=C2=B0C)  s=
ensor =3D thermal diode
temp2:       +31.8=C2=B0C  (high =3D +105.0=C2=B0C, hyst =3D +105.0=C2=B0=
C) =20
                      (crit =3D +105.0=C2=B0C, hyst =3D +105.0=C2=B0C)  s=
ensor =3D thermal diode
temp5:       +16.2=C2=B0C  (high =3D +39.0=C2=B0C, hyst =3D +39.0=C2=B0C)=
 =20
                      (crit =3D +44.0=C2=B0C, hyst =3D +44.0=C2=B0C)  sen=
sor =3D thermistor
beep_enable:disabled

karsten@ubuserv2:~$ sudo i2cdetect -l
[sudo] password for karsten:=20
karsten@ubuserv2:~$ sudo i2cdetect -y 0
Error: Could not open file `/dev/i2c-0' or `/dev/i2c/0': No such file or =
directory
karsten@ubuserv2:~$

--------------030502080902020609060102
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------030502080902020609060102--
