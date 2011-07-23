From: Suyu Zhang <coolbeet@gmail.com>
Date: Sat, 23 Jul 2011 19:10:47 +0000
Subject: [lm-sensors] want memory temperature(i5k_amb),
Message-Id: <CAOfki7BChsVD09-EKKKG+tkmjAysXqQTO98XDZqxjmdRPh=sag@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5360422301793252907=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============5360422301793252907==
Content-Type: multipart/alternative; boundary=001517476a70ee375c04a8c15622

--001517476a70ee375c04a8c15622
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi, I have a Xserve server with 64bit 10.04 ubuntu and Mac os X server.

I want to know the temperature of memory module (FB-DIMM) under ubuntu, so =
I
use 'sensors-detect' with following modules find:

Intel Core family thermal sensor...                         Success!
    (driver `coretemp')
Intel AMB FB-DIMM thermal sensor...                         Success!
    (driver `i5k_amb')

then I 'modprobe' coretemp and i5k_amb, but when I use 'sensors', I can onl=
y
get cpu temperature, and no memory temperature:

root@lake:/home/szhang# sensors
coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +51.0=C2=B0C  (high =3D +86.0=C2=B0C, crit =3D +100.0=C2=B0C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +51.0=C2=B0C  (high =3D +86.0=C2=B0C, crit =3D +100.0=C2=B0C)

coretemp-isa-0002
Adapter: ISA adapter
Core 1:      +52.0=C2=B0C  (high =3D +86.0=C2=B0C, crit =3D +100.0=C2=B0C)

coretemp-isa-0003
Adapter: ISA adapter
Core 0:      +50.0=C2=B0C  (high =3D +86.0=C2=B0C, crit =3D +100.0=C2=B0C)

and I check mods and i5k_amb is loaded:

root@lake:/home/szhang# lsmod | grep i5k_amb
i5k_amb                 5536  0

more interesting, I use a temperature monitor tool on Mac os, which is
http://www.bresink.de/osx/TemperatureMonitor.html

I was surprised find that it provide a lot of sensors reading, including
memory modules:

CPU Core 1: 39 C
CPU Core 2: 41 C
CPU Core 3: 39 C
CPU Core 4: 42 C
SMART Disk ST3750640NS P (3QD0H1Q0): 34 C
SMC AMBIENT AIR: 27 C
SMC AMBIENT AIR POSITION 2: 24 C
SMC CPU A HEAT SINK: 36 C
SMC CPU A PROXIMITY: 27 C
SMC CPU B HEAT SINK: 35 C
SMC CPU B PROXIMITY: 27 C
SMC CPU C PROXIMITY: 27 C
SMC CPU D PROXIMITY: 28 C
SMC DRIVE BAY 1: 32 C
SMC DRIVE BAY 2: 37 C
SMC EXPANSION SLOTS: 38 C
SMC GPU 1 CHIP: 45 C
SMC MEMORY BANK A POS 0: 45 C
SMC MEMORY BANK A POS 1: 26 C
SMC MEMORY BANK A POS 2: 27 C
SMC MEMORY BANK A POS 3: 27 C
SMC MEMORY MODULE A1: 58 C
SMC MEMORY MODULE A2: 63 C
SMC MEMORY MODULE A3: 60 C
SMC MEMORY MODULE A4: 56 C
SMC MEMORY MODULE A5: 57 C
SMC MEMORY MODULE A6: 55 C
SMC MEMORY MODULE A7: 51 C
SMC MEMORY MODULE B0: 54 C
SMC NORTHBRIDGE CORE: 118 C
SMC NORTHBRIDGE HEAT SINK: 79 C
SMC PCI SLOT 1 POS 1: 44 C
SMC PCI SLOT 1 POS 2: 46 C
SMC PCI SLOT 2 POS 1: 44 C
SMC PCI SLOT 2 POS 2: 47 C
SMC POWER SUPPLY POSITION 1: 33 C
SMC POWER SUPPLY POSITION 2: 49 C
SMC POWER SUPPLY POSITION 3: 36 C

but with Mac os I can't do anything about my project...

so how can I get the memory temperature in ubuntu?

Any help is greatly appreciated. Thanks.

--001517476a70ee375c04a8c15622
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<span class=3D"Apple-style-span" style=3D"border-collapse: collapse; font-f=
amily: arial, sans-serif; font-size: 13px; "><div>Hi, I have a Xserve serve=
r with 64bit 10.04 ubuntu and Mac os X server.</div><div><br></div><div>I w=
ant to know the temperature of memory module (FB-DIMM) under ubuntu, so I u=
se &#39;sensors-detect&#39; with following modules find:</div>
<div><br></div><div>Intel Core family thermal sensor... =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Success!</div><div>=A0 =A0 (driver `coretemp&#=
39;)</div><div>Intel AMB FB-DIMM thermal sensor... =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 Success!</div><div>=A0 =A0 (driver `i5k_amb&#39;)</=
div>
<div><br></div><div>then I &#39;modprobe&#39; coretemp and i5k_amb, but whe=
n I use &#39;sensors&#39;, I can only get cpu temperature, and no memory te=
mperature:</div><div><br></div><div>root@lake:/home/szhang# sensors</div>
<div>coretemp-isa-0000</div><div>Adapter: ISA adapter</div><div>Core 0: =A0=
 =A0 =A0+51.0=C2=B0C =A0(high =3D +86.0=C2=B0C, crit =3D +100.0=C2=B0C) =A0=
</div><div><br></div><div>coretemp-isa-0001</div><div>Adapter: ISA adapter<=
/div><div>Core 1: =A0 =A0 =A0+51.0=C2=B0C =A0(high =3D +86.0=C2=B0C, crit =
=3D +100.0=C2=B0C) =A0</div>
<div><br></div><div>coretemp-isa-0002</div><div>Adapter: ISA adapter</div><=
div>Core 1: =A0 =A0 =A0+52.0=C2=B0C =A0(high =3D +86.0=C2=B0C, crit =3D +10=
0.0=C2=B0C) =A0</div><div><br></div><div>coretemp-isa-0003</div><div>Adapte=
r: ISA adapter</div><div>
Core 0: =A0 =A0 =A0+50.0=C2=B0C =A0(high =3D +86.0=C2=B0C, crit =3D +100.0=
=C2=B0C) =A0</div><div><br></div><div>and I check mods and i5k_amb is loade=
d:</div><div><br></div><div>root@lake:/home/szhang# lsmod | grep i5k_amb</d=
iv><div>i5k_amb =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 5536 =A00=A0</div>
<div><br></div><div>more interesting, I use a temperature monitor tool on M=
ac os, which is=A0<a href=3D"http://www.bresink.de/osx/TemperatureMonitor.h=
tml" target=3D"_blank" style=3D"color: rgb(17, 65, 112); ">http://www.bresi=
nk.de/osx/TemperatureMonitor.html</a></div>
<div><br></div><div>I was surprised find that it provide a lot of sensors r=
eading, including memory modules:</div><div><br></div><div>CPU Core 1: 39 C=
</div><div>CPU Core 2: 41 C</div><div>CPU Core 3: 39 C</div><div>CPU Core 4=
: 42 C</div>
<div>SMART Disk ST3750640NS P (3QD0H1Q0): 34 C</div><div>SMC AMBIENT AIR: 2=
7 C</div><div>SMC AMBIENT AIR POSITION 2: 24 C</div><div>SMC CPU A HEAT SIN=
K: 36 C</div><div>SMC CPU A PROXIMITY: 27 C</div><div>SMC CPU B HEAT SINK: =
35 C</div>
<div>SMC CPU B PROXIMITY: 27 C</div><div>SMC CPU C PROXIMITY: 27 C</div><di=
v>SMC CPU D PROXIMITY: 28 C</div><div>SMC DRIVE BAY 1: 32 C</div><div>SMC D=
RIVE BAY 2: 37 C</div><div>SMC EXPANSION SLOTS: 38 C</div><div>SMC GPU 1 CH=
IP: 45 C</div>
<div>SMC MEMORY BANK A POS 0: 45 C</div><div>SMC MEMORY BANK A POS 1: 26 C<=
/div><div>SMC MEMORY BANK A POS 2: 27 C</div><div>SMC MEMORY BANK A POS 3: =
27 C</div><div>SMC MEMORY MODULE A1: 58 C</div><div>SMC MEMORY MODULE A2: 6=
3 C</div>
<div>SMC MEMORY MODULE A3: 60 C</div><div>SMC MEMORY MODULE A4: 56 C</div><=
div>SMC MEMORY MODULE A5: 57 C</div><div>SMC MEMORY MODULE A6: 55 C</div><d=
iv>SMC MEMORY MODULE A7: 51 C</div><div>SMC MEMORY MODULE B0: 54 C</div>
<div>SMC NORTHBRIDGE CORE: 118 C</div><div>SMC NORTHBRIDGE HEAT SINK: 79 C<=
/div><div>SMC PCI SLOT 1 POS 1: 44 C</div><div>SMC PCI SLOT 1 POS 2: 46 C</=
div><div>SMC PCI SLOT 2 POS 1: 44 C</div><div>SMC PCI SLOT 2 POS 2: 47 C</d=
iv>
<div>SMC POWER SUPPLY POSITION 1: 33 C</div><div>SMC POWER SUPPLY POSITION =
2: 49 C</div><div>SMC POWER SUPPLY POSITION 3: 36 C</div><div><br></div><di=
v>but with Mac os I can&#39;t do anything about my project...</div><div>
<br></div><div>so how can I get the memory temperature in ubuntu?=A0</div><=
div><br></div><div>Any help is greatly appreciated. Thanks.</div></span>

--001517476a70ee375c04a8c15622--


--===============5360422301793252907==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5360422301793252907==--
