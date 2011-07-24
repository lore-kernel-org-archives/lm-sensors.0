From: Suyu Zhang <coolbeet@gmail.com>
Date: Sun, 24 Jul 2011 04:57:27 +0000
Subject: Re: [lm-sensors] want memory temperature(i5k_amb),
Message-Id: <CAOfki7BCn1En4g4csRZzmUAYyvRB+e7yDd7HJeVA1k7i6y2dOg@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4235466514800151134=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAOfki7BChsVD09-EKKKG+tkmjAysXqQTO98XDZqxjmdRPh=sag@mail.gmail.com>
In-Reply-To: <CAOfki7BChsVD09-EKKKG+tkmjAysXqQTO98XDZqxjmdRPh=sag@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============4235466514800151134==
Content-Type: multipart/alternative; boundary=0015174a058a07bca804a8c989c1

--0015174a058a07bca804a8c989c1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

my chipset is intel 5000 and I got error info from dmesg=EF=BC=9A
i5k_amb: probe of i5k_amb.0 failed with error -16

Thanks.



On Sat, Jul 23, 2011 at 2:10 PM, Suyu Zhang <coolbeet@gmail.com> wrote:

> Hi, I have a Xserve server with 64bit 10.04 ubuntu and Mac os X server.
>
> I want to know the temperature of memory module (FB-DIMM) under ubuntu, s=
o
> I use 'sensors-detect' with following modules find:
>
> Intel Core family thermal sensor...                         Success!
>     (driver `coretemp')
> Intel AMB FB-DIMM thermal sensor...                         Success!
>     (driver `i5k_amb')
>
> then I 'modprobe' coretemp and i5k_amb, but when I use 'sensors', I can
> only get cpu temperature, and no memory temperature:
>
> root@lake:/home/szhang# sensors
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +51.0=C3=82=C2=B0C  (high =3D +86.0=C3=82=C2=B0C, crit =3D +=
100.0=C3=82=C2=B0C)
>
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 1:      +51.0=C3=82=C2=B0C  (high =3D +86.0=C3=82=C2=B0C, crit =3D +=
100.0=C3=82=C2=B0C)
>
> coretemp-isa-0002
> Adapter: ISA adapter
> Core 1:      +52.0=C3=82=C2=B0C  (high =3D +86.0=C3=82=C2=B0C, crit =3D +=
100.0=C3=82=C2=B0C)
>
> coretemp-isa-0003
> Adapter: ISA adapter
> Core 0:      +50.0=C3=82=C2=B0C  (high =3D +86.0=C3=82=C2=B0C, crit =3D +=
100.0=C3=82=C2=B0C)
>
> and I check mods and i5k_amb is loaded:
>
> root@lake:/home/szhang# lsmod | grep i5k_amb
> i5k_amb                 5536  0
>
> more interesting, I use a temperature monitor tool on Mac os, which is
> http://www.bresink.de/osx/TemperatureMonitor.html
>
> I was surprised find that it provide a lot of sensors reading, including
> memory modules:
>
> CPU Core 1: 39 C
> CPU Core 2: 41 C
> CPU Core 3: 39 C
> CPU Core 4: 42 C
> SMART Disk ST3750640NS P (3QD0H1Q0): 34 C
> SMC AMBIENT AIR: 27 C
> SMC AMBIENT AIR POSITION 2: 24 C
> SMC CPU A HEAT SINK: 36 C
> SMC CPU A PROXIMITY: 27 C
> SMC CPU B HEAT SINK: 35 C
> SMC CPU B PROXIMITY: 27 C
> SMC CPU C PROXIMITY: 27 C
> SMC CPU D PROXIMITY: 28 C
> SMC DRIVE BAY 1: 32 C
> SMC DRIVE BAY 2: 37 C
> SMC EXPANSION SLOTS: 38 C
> SMC GPU 1 CHIP: 45 C
> SMC MEMORY BANK A POS 0: 45 C
> SMC MEMORY BANK A POS 1: 26 C
> SMC MEMORY BANK A POS 2: 27 C
> SMC MEMORY BANK A POS 3: 27 C
> SMC MEMORY MODULE A1: 58 C
> SMC MEMORY MODULE A2: 63 C
> SMC MEMORY MODULE A3: 60 C
> SMC MEMORY MODULE A4: 56 C
> SMC MEMORY MODULE A5: 57 C
> SMC MEMORY MODULE A6: 55 C
> SMC MEMORY MODULE A7: 51 C
> SMC MEMORY MODULE B0: 54 C
> SMC NORTHBRIDGE CORE: 118 C
> SMC NORTHBRIDGE HEAT SINK: 79 C
> SMC PCI SLOT 1 POS 1: 44 C
> SMC PCI SLOT 1 POS 2: 46 C
> SMC PCI SLOT 2 POS 1: 44 C
> SMC PCI SLOT 2 POS 2: 47 C
> SMC POWER SUPPLY POSITION 1: 33 C
> SMC POWER SUPPLY POSITION 2: 49 C
> SMC POWER SUPPLY POSITION 3: 36 C
>
> but with Mac os I can't do anything about my project...
>
> so how can I get the memory temperature in ubuntu?
>
> Any help is greatly appreciated. Thanks.
>



--=20
Suyu Zhang
Electrical and Computer Engineering
University of Illinois at Chicago
phone: (+1) 312-810-6072
google voice: (+1) 773-SUYU-214
website: http://suyu.us
szhang33@uic.edu

--0015174a058a07bca804a8c989c1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

my chipset is intel 5000 and I got error info from dmesg=EF=BC=9A<div>i5k_a=
mb: probe of i5k_amb.0 failed with error -16</div><div><br></div><div>Thank=
s.<br><div><br></div><div><br><br><div class=3D"gmail_quote">On Sat, Jul 23=
, 2011 at 2:10 PM, Suyu Zhang <span dir=3D"ltr">&lt;<a href=3D"mailto:coolb=
eet@gmail.com">coolbeet@gmail.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><span style=3D"border-collapse:collapse;fon=
t-family:arial, sans-serif;font-size:13px"><div>Hi, I have a Xserve server =
with 64bit 10.04 ubuntu and Mac os X server.</div>
<div><br></div><div>I want to know the temperature of memory module (FB-DIM=
M) under ubuntu, so I use &#39;sensors-detect&#39; with following modules f=
ind:</div>
<div><br></div><div>Intel Core family thermal sensor... =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Success!=
</div><div>=C2=A0 =C2=A0 (driver `coretemp&#39;)</div><div>Intel AMB FB-DIM=
M thermal sensor... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Success!</div><div>=C2=A0 =C2=A0 (driver `i5k_=
amb&#39;)</div>

<div><br></div><div>then I &#39;modprobe&#39; coretemp and i5k_amb, but whe=
n I use &#39;sensors&#39;, I can only get cpu temperature, and no memory te=
mperature:</div><div><br></div><div>root@lake:/home/szhang# sensors</div>

<div>coretemp-isa-0000</div><div>Adapter: ISA adapter</div><div>Core 0: =C2=
=A0 =C2=A0 =C2=A0+51.0=C3=82=C2=B0C =C2=A0(high =3D +86.0=C3=82=C2=B0C, cri=
t =3D +100.0=C3=82=C2=B0C) =C2=A0</div><div><br></div><div>coretemp-isa-000=
1</div><div>Adapter: ISA adapter</div><div>Core 1: =C2=A0 =C2=A0 =C2=A0+51.=
0=C3=82=C2=B0C =C2=A0(high =3D +86.0=C3=82=C2=B0C, crit =3D +100.0=C3=82=C2=
=B0C) =C2=A0</div>

<div><br></div><div>coretemp-isa-0002</div><div>Adapter: ISA adapter</div><=
div>Core 1: =C2=A0 =C2=A0 =C2=A0+52.0=C3=82=C2=B0C =C2=A0(high =3D +86.0=C3=
=82=C2=B0C, crit =3D +100.0=C3=82=C2=B0C) =C2=A0</div><div><br></div><div>c=
oretemp-isa-0003</div><div>Adapter: ISA adapter</div><div>

Core 0: =C2=A0 =C2=A0 =C2=A0+50.0=C3=82=C2=B0C =C2=A0(high =3D +86.0=C3=82=
=C2=B0C, crit =3D +100.0=C3=82=C2=B0C) =C2=A0</div><div><br></div><div>and =
I check mods and i5k_amb is loaded:</div><div><br></div><div>root@lake:/hom=
e/szhang# lsmod | grep i5k_amb</div><div>i5k_amb =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 5536 =C2=A00=C2=A0</div>

<div><br></div><div>more interesting, I use a temperature monitor tool on M=
ac os, which is=C2=A0<a href=3D"http://www.bresink.de/osx/TemperatureMonito=
r.html" style=3D"color:rgb(17, 65, 112)" target=3D"_blank">http://www.bresi=
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

<br></div><div>so how can I get the memory temperature in ubuntu?=C2=A0</di=
v><div><br></div><div>Any help is greatly appreciated. Thanks.</div></span>
</blockquote></div><br><br clear=3D"all"><br>-- <br><span style=3D"font-fam=
ily:arial, sans-serif;font-size:13px;border-collapse:collapse">Suyu Zhang<b=
r>Electrical and Computer Engineering<br>University of Illinois at Chicago=
=C2=A0=C2=A0</span><div>
<span style=3D"font-family:arial, sans-serif;font-size:13px;border-collapse=
:collapse">phone: (+1) 312-810-6072</span></div><div><span style=3D"font-fa=
mily:arial, sans-serif;font-size:13px;border-collapse:collapse">google voic=
e: (+1) 773-SUYU-214</span></div>
<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><span style=3D"border-collapse:separate;font-family:arial"><span style=
=3D"font-family:arial, sans-serif;font-size:13px;border-collapse:collapse">=
website:=C2=A0</span><a href=3D"http://suyu.us/" target=3D"_blank">http://s=
uyu.us</a></span></span></font></div>
<div><span style=3D"font-family:arial, sans-serif;font-size:13px;border-col=
lapse:collapse"><a href=3D"mailto:szhang33@uic.edu" target=3D"_blank">szhan=
g33@uic.edu</a></span></div><br>
</div></div>

--0015174a058a07bca804a8c989c1--


--===============4235466514800151134==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4235466514800151134==--
