From: "Ivo Manca" <pinkel@gmail.com>
Date: Sat, 09 Jun 2007 11:56:43 +0000
Subject: Re: [lm-sensors] sis5595
Message-Id: <058701c7aa8d$40b56990$0601a8c0@pinkeltje>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307161427.08403.linux@1g6.biz>
In-Reply-To: <200307161427.08403.linux@1g6.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hey Jean,

I'm currently not home, so I do not have local acces yet.

> It seems that your SiS5595 is wired for 1 temperature and 4 voltages,
> rather than 5 voltages as the driver detects. I guess that your BIOS
> doesn't properly set up the relevant configuration bit when the setup
> screen isn't entered. Please look for a BIOS update. If there is none,
> or if it doesn't solve the problem, we'll have to add a module
> parameter to allow the user to force one of the modes when
> autodetection fails.

I already flashed my bios to the latest version, a week or so ago. This did=
=20
sadly not fix anything .
I've read the docs concerning this chips, and I also figured out this had t=
o=20
be a BIOS error.
I wrote a mail to AMI two weeks ago, concerning their " AMI Desktop client =

manager"  for windows, which is supposed to expose me some more information=
=20
about the hardware. I've lost the CD, and can't find it anywhere on the net=
.=20
However, they've not yet responded.

The manual states:

Hardware Monitoring
=A8       Built-in hardware monitoring for CPU temperature and fan speeds
=A8       Supports AMI's  Desktop Client Manager (ADCM)

> For now, you can try changing the configuration manually. First, do:
> lspci -d 1039:0008 -xxx
> This will dump the PCI configuration space of your device. I guess that
> bit 7 of register 0x7a will be 0, while it should be 1. You can change

[root@localhost ~]# lspci -d 1039:0008 -xxx
00:01.0 ISA bridge: Silicon Integrated Systems [SiS] SiS85C503/5513 (LPC=20
Bridge) (rev b1)
00: 39 10 08 00 0f 00 00 02 b1 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: f8 0a 0b 80 80 60 90 40 f7 ff 10 0f 11 20 04 01
50: 11 28 02 01 60 00 62 00 a5 12 12 00 d3 8b 00 00
60: 0c 80 43 00 34 c1 40 04 90 02 8c 00 20 1b 00 00
70: 1a 00 00 00 80 00 00 00 ff 00 00 80 00 00 80 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 04 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


> it with:
> setpci -d 1039:0008 7a.b=80:80
> Check with lspci that the write worked, then reload the sis5595 driver,
> it should list 4 voltages and one temperature. Please provide the
> output then.

[root@localhost ~]# setpci -d 1039:0008 7a.b=80:80
[root@localhost ~]# lspci -d 1039:0008 -xxx
00:01.0 ISA bridge: Silicon Integrated Systems [SiS] SiS85C503/5513 (LPC=20
Bridge) (rev b1)
00: 39 10 08 00 0f 00 00 02 b1 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: f8 0a 0b 80 80 60 90 40 f7 ff 10 0f 11 20 04 01
50: 11 28 02 01 62 00 62 00 a5 12 12 00 d3 8b 00 00
60: 0c 80 43 00 34 c1 40 04 90 02 8c 00 20 1b 00 00
70: 1a 00 00 00 80 00 00 00 ff 00 80 80 00 00 80 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 04 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Sensors gives a temprature after removing & loading the module:

[root@localhost ~]# sensors -c /dev/null
sis5595-isa-0290
Adapter: ISA adapter
in0:       +2.96 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
in1:       +3.41 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
in2:       +2.74 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
in3:       +2.05 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
fan1:        0 RPM  (min =3D   -1 RPM, div =3D 2)          ALARM
fan2:        0 RPM  (min =3D   -1 RPM, div =3D 2)          ALARM
temp:       +158=C2=B0C  (high =3D   +52=C2=B0C, hyst =3D   +52=C2=B0C)
alarms:   Board temperature input (usually LM75 chips) ALARM

> For voltages, the SiS5595 uses a DAC sampling from 0 to 4.08 V. This
> means that voltage values of 3.3 V and below are probably connected
> directly. This seems to match. in0 would be "Vcc 2.5V" (which BTW, is
> way too high!)
I'm not really suprised by that. This system has been around the family for=
=20
almost a decade now, and the same powersupply is still used. Untill a year =

or two ago, it was actually used quite frequently (1hour/day, minumum),=20
after which I adopted it as a linux server (4 hours/day, or so). Now it jus=
t=20
remains alive for testing and fooling around.
However, there have been troubles with the system since the beginning (CPU =

fried within a month) and the motherboard has gave me quite some headaches =

before. It is actually quite stable now, just very slow.

> , in1 would be "Vcc 3.3V", and in3 would be "Vcore". This
> leaves in2 for "Vcc 5.0V", with a scaling factor we'll have to guess.
> The standard +5V formula doesn't appear to work.

> For fans, do you have 3-wire fans? Are they connected to headers on
> the motherboard? If they are relatively slow, maybe we need to increase
> the divider to get a reading.
As far as I can remember (I'll have to look into it tomorrow), my fan is=20
connected directly to the PSU, bypassing the motherboard.

> Lastly, alarms, given that you don't have any other hardware monitoring
> chip on this board, I guess this alarm isn't meaningful and should be
> ignored.

> I attached a preliminary configuration file for your motherboard.
> Please give it a try. You can tell "sensors" to use it with the "-c"
> flag. Use "-s" to write the limit values to the chip.
Thanks!

[root@localhost ivo]# sensors -c sensors-PCChips -s
[root@localhost ivo]# sensors -c sensors-PCChips
sis5595-isa-0290
Adapter: ISA adapter
+2.5V:     +2.96 V  (min =3D  +2.26 V, max =3D  +2.75 V)   ALARM
+3.3V:     +3.41 V  (min =3D  +3.14 V, max =3D  +3.47 V)
+5.0V:     +5.09 V  (min =3D  +4.76 V, max =3D  +5.24 V)
Vcore:     +2.05 V  (min =3D  +1.90 V, max =3D  +2.10 V)
fan1:        0 RPM  (min =3D  998 RPM, div =3D 8)          ALARM
fan2:        0 RPM  (min =3D  998 RPM, div =3D 8)          ALARM
CPU Temp:   +158=C2=B0C  (high =3D   +52=C2=B0C, hyst =3D   +52=C2=B0C)

It seems like the +5,0V actually makes complete sense now!  However, what's=
=20
up with the Temp? The default sensors.conf speaks about a vendor.ini. I=20
suppose this should be coming with AMI's utility?
I''m not really sure if I understand what's ment with all the computing=20
stuff standing there ;)

> What's your CPU? Do you happen to know its nominal vcore?
It's an Intel Celeron 366. According to this page=20
(http://www.intel.com/support/processors/celeron/sb/CS-007435.htm#Voltage%2=
0Requirements),=20
it is 2,00V.

--=20
Jean Delvare=20


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
