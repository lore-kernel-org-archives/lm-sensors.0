From: Tom <siggma@trbailey.net>
Date: Sat, 23 May 2009 04:34:14 +0000
Subject: [lm-sensors] Gigabyte GA-945GCMX
Message-Id: <4A177CC6.6060805@trbailey.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

I have a GA-945GCMX-S2 board that apparently uses the it8718F chip. It's=20
running as a web server so I can't dual boot it to any WinX version for=20
validation. The default profile is only vaguely correct. I'm running a=20
P4-HT-550 in this board so it has only one temp reading. Since these=20
CPU's run hot I need to monitor it to prevent internal clock reduction.=20
I already had to purchase a "REAL" heat sink and fan and destroyed an=20
AOPEN I945GM-PILF that came with a stupidly small and anemic 60mm fan=20
and aluminum only heat sink trying to remove the old fan mount. It would=20
run as hot as 90c (using realtemp under Vista). These 90nm CPU's always=20
run hot but 90c is on fire...

I think this is it:
SL7KM 3.40 GHz 04B 800 MHz  LGA775 90 nm D0 0F34h 115W 72.8=B0C 1.4V

It could be this CPU though:
SL7J8 3.40 GHz 04B 800 MHz  LGA775 90 nm D0 0F34h 115W 72.8=B0C 1.4V


It appears, from a basic observation that only the fan1 and temp3 are=20
usable without changes but they need to be interpreted.
CPU voltage should be 1.4
DRAM V is 1.8 (possibly in1)
The remainder are somewhat of a mystery.

in0 jumps as high as 2.2 under heavy load making it a curiosity.
Could this be CPU Voltage?

Fan1 seems correct. It varies between 450 on a slow cold morning and=20
2200 or so under heavy load. It increases instantly under load so it's=20
working correctly.
Fan2 and Fan3 are not connected. I suspect only Fan2 is speed sensing.
Temp1 is ???useless???
Temp2 is meaningless
Temp3 seems a bit low for CPU Case or Die temp but tracks cpu usage as=20
well as the interrupt driven idle loop.

I have no baseline to compare for this CPU and board combination. This=20
board was my desktop board until it failed in service. It ran an Intel=20
E2140 OC to 2.2GHz for over a year just fine and temperatures were shown=20
correctly using realtemp under Vista. It was just RMA'd to gigabyte for=20
repair and they did indeed repair it. They replaced all power components=20
around the CPU and it's now ready to rock again as my new home web server.


Do any of you have any experience or feedback from Gigabyte on this=20
particular board or shall I go ahead and ask them for specifics?

isadump 0x295 0x296
WARNING! Running this program can cause system crashes, data loss and worse!
I will probe address register 0x295 and data register 0x296.
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 11 12 a9 00 ff ff 00 37 ff 87 40 09 07 0b ff ff
10: ff a9 ff 73 d7 82 7f 7f 03 ff ff ff 00 ff ff ff
20: 49 72 cf ff bb 00 52 ff ff ca fe 16 fa f3 f3 f3
30: 4f 3b 76 6b d9 c4 c3 b1 c3 b1 c5 b2 ff 00 c5 b2
40: 2d 00 37 00 7f 7f 00 0d 2d ff ff ff ff ff ff ff
50: ff 1c 7f 7f 7f 50 de de 90 de 13 12 00 00 00 00
60: 00 14 41 23 90 03 ff ff 7f 7f 7f 00 00 7f ff ff
70: 00 14 41 23 90 03 ff ff ff ff ff ff ff ff ff ff
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02 00
90: ff 00 00 00 ff 00 00 00 ff ff ff ff ff ff ff ff
a0: 00 00 00 00 00 00 00 ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[root@moya]


Lightly loaded, near idle, ambient 75F

it8718-isa-0290
Adapter: ISA adapter
in0: +1.17 V (min =3D +0.94 V, max =3D +1.26 V) ALARM
in1: +1.82 V (min =3D +1.71 V, max =3D +1.89 V)
in2: +3.33 V (min =3D +3.14 V, max =3D +3.47 V)
in3: +4.08 V (min =3D +2.83 V, max =3D +3.12 V) ALARM
in4: +2.99 V (min =3D +2.83 V, max =3D +3.12 V)
in5: +0.00 V (min =3D +2.85 V, max =3D +3.15 V) ALARM
in6: +1.33 V (min =3D +0.00 V, max =3D +4.08 V)
in7: +4.08 V (min =3D +2.85 V, max =3D +3.15 V) ALARM
Vbat: +4.08 V
fan1: 985 RPM (min =3D 0 RPM)
fan2: 0 RPM (min =3D 3994 RPM) ALARM
fan3: 0 RPM (min =3D 0 RPM)
temp1: -54.0=B0C (low =3D +0.0=B0C, high =3D +45.0=B0C) sensor =3D transist=
or
temp2: -2.0=B0C (low =3D +0.0=B0C, high =3D +55.0=B0C) sensor =3D transistor
temp3: +23.0=B0C (low =3D +127.0=B0C, high =3D +127.0=B0C) sensor =3D therm=
al diode
cpu0_vid: +1.075 V


Under heavy load (gzip backup) it stabilizes about here. Ambient is=20
around 75F
it8718-isa-0290
Adapter: ISA adapter
in0: +1.26 V (min =3D +0.94 V, max =3D +1.26 V) ALARM
in1: +1.82 V (min =3D +1.71 V, max =3D +1.89 V)
in2: +3.31 V (min =3D +3.14 V, max =3D +3.47 V)
in3: +4.08 V (min =3D +2.83 V, max =3D +3.12 V) ALARM
in4: +2.96 V (min =3D +2.83 V, max =3D +3.12 V)
in5: +0.00 V (min =3D +2.85 V, max =3D +3.15 V) ALARM
in6: +1.33 V (min =3D +0.00 V, max =3D +4.08 V)
in7: +4.08 V (min =3D +2.85 V, max =3D +3.15 V) ALARM
Vbat: +4.08 V
fan1: 2039 RPM (min =3D 0 RPM)
fan2: 0 RPM (min =3D 3994 RPM) ALARM
fan3: 0 RPM (min =3D 0 RPM)
temp1: -54.0=B0C (low =3D +0.0=B0C, high =3D +45.0=B0C) sensor =3D transist=
or
temp2: -2.0=B0C (low =3D +0.0=B0C, high =3D +55.0=B0C) sensor =3D transistor
temp3: +45.0=B0C (low =3D +127.0=B0C, high =3D +127.0=B0C) sensor =3D therm=
al diode
cpu0_vid: +1.075 V

I can install cpufreqd to monitor cpu clock which will help but since=20
there is no working profile for this board I might as well help make one.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
