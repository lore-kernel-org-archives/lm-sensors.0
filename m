From: Scott Lipcon <slipcon@gmail.com>
Date: Wed, 15 Jun 2011 13:01:20 +0000
Subject: [lm-sensors] NCT6775F driver
Message-Id: <BANLkTimDkWRZ53GL5erkDaFqqj3kJBOj9A@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3915904832292512972=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============3915904832292512972==
Content-Type: multipart/alternative; boundary=bcaec53f9539b0551504a5bfbf59

--bcaec53f9539b0551504a5bfbf59
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,

I've got a new machine - Intel DP67DE motherboard, Core i5 CPU.

sensors-detect shows that it has a NCT6775F chip, so I've compiled the
driver from http://roeck-us.net/linux/drivers/w83627ehf/  and it
successfully detects and provides output, although I'm doubting some of the
values, and wanted to see if I could help debug/test driver updates.

Here's the current output:



 nct6775-isa-0290
Adapter: ISA adapter
VCore:         +0.89 V  (min =3D  +0.50 V, max =3D  +1.74 V)
+12V:         +17.54 V  (min =3D +10.75 V, max =3D +13.18 V)   ALARM
AVCC:          +3.41 V  (min =3D  +2.98 V, max =3D  +3.63 V)
+3.3V:         +3.41 V  (min =3D  +3.14 V, max =3D  +3.47 V)
+5V:           +4.19 V  (min =3D  +4.74 V, max =3D  +5.25 V)   ALARM
+1.3V:         +1.06 V  (min =3D  +1.17 V, max =3D  +1.43 V)   ALARM
VSB:           +3.42 V  (min =3D  +2.98 V, max =3D  +3.63 V)
VBAT:          +3.38 V  (min =3D  +2.40 V, max =3D  +3.60 V)
fan1:          620 RPM  (min =3D    0 RPM, div =3D 32)  ALARM
fan2:         1054 RPM  (min =3D    0 RPM, div =3D 32)  ALARM
fan3:          620 RPM  (min =3D    0 RPM, div =3D 32)  ALARM
fan4:            0 RPM  (div =3D 128)
SYSTIN:        +28.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALARM  =
sensor =3D
diode
CPUTIN:        +27.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D diode
PECI Agent 0:  +32.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D diode
PCH_CHIP_TEMP: +45.0=B0C
PECI Agent 1:   +0.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)
cpu0_vid:     +2.050 V



The voltages are a bit surprising - obviously the three with ALARM are out
of range.  I'm not sure if I can validate these in the BIOS but I'll try
tonight when I'm home, but somehow I really doubt my +12V is putting out
+17.5.

I'm not sure why the first 3 fans are showing ALARM, but the values seem
reasonable.  The motherboard only has 3 fan connectors, so fan4 =3D 0 makes
sense.

The coretemp module reports 4 temperatures (for each of my 4 cpu cores?)
between 36C and 42C.

Thanks,
Scott

--bcaec53f9539b0551504a5bfbf59
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,<div><br></div><div>I&#39;ve got a new machine - Intel DP67DE motherb=
oard, Core i5 CPU.</div><div><br></div><div>sensors-detect shows that it ha=
s a NCT6775F chip, so I&#39;ve compiled the driver from=A0<a href=3D"http:/=
/roeck-us.net/linux/drivers/w83627ehf/">http://roeck-us.net/linux/drivers/w=
83627ehf/</a> =A0and it successfully detects and provides output, although =
I&#39;m doubting some of the values, and wanted to see if I could help debu=
g/test driver updates. =A0=A0</div>
<div><br></div><div>Here&#39;s the current output:</div><div><br></div><div=
><br></div><div><br></div><div>=A0nct6775-isa-0290</div><div>Adapter: ISA a=
dapter</div><div>VCore: =A0 =A0 =A0 =A0 +0.89 V =A0(min =3D =A0+0.50 V, max=
 =3D =A0+1.74 V) =A0=A0</div>
<div>+12V: =A0 =A0 =A0 =A0 +17.54 V =A0(min =3D +10.75 V, max =3D +13.18 V)=
 =A0 ALARM</div><div>AVCC: =A0 =A0 =A0 =A0 =A0+3.41 V =A0(min =3D =A0+2.98 =
V, max =3D =A0+3.63 V) =A0=A0</div><div>+3.3V: =A0 =A0 =A0 =A0 +3.41 V =A0(=
min =3D =A0+3.14 V, max =3D =A0+3.47 V) =A0=A0</div><div>+5V: =A0 =A0 =A0 =
=A0 =A0 +4.19 V =A0(min =3D =A0+4.74 V, max =3D =A0+5.25 V) =A0 ALARM</div>
<div>+1.3V: =A0 =A0 =A0 =A0 +1.06 V =A0(min =3D =A0+1.17 V, max =3D =A0+1.4=
3 V) =A0 ALARM</div><div>VSB: =A0 =A0 =A0 =A0 =A0 +3.42 V =A0(min =3D =A0+2=
.98 V, max =3D =A0+3.63 V) =A0=A0</div><div>VBAT: =A0 =A0 =A0 =A0 =A0+3.38 =
V =A0(min =3D =A0+2.40 V, max =3D =A0+3.60 V) =A0=A0</div><div>fan1: =A0 =
=A0 =A0 =A0 =A0620 RPM =A0(min =3D =A0 =A00 RPM, div =3D 32) =A0ALARM</div>
<div>fan2: =A0 =A0 =A0 =A0 1054 RPM =A0(min =3D =A0 =A00 RPM, div =3D 32) =
=A0ALARM</div><div>fan3: =A0 =A0 =A0 =A0 =A0620 RPM =A0(min =3D =A0 =A00 RP=
M, div =3D 32) =A0ALARM</div><div>fan4: =A0 =A0 =A0 =A0 =A0 =A00 RPM =A0(di=
v =3D 128)</div><div>SYSTIN: =A0 =A0 =A0 =A0+28.0=B0C =A0(high =3D =A0+0.0=
=B0C, hyst =3D =A0+0.0=B0C) =A0ALARM =A0sensor =3D diode</div>
<div>CPUTIN: =A0 =A0 =A0 =A0+27.0=B0C =A0(high =3D +80.0=B0C, hyst =3D +75.=
0=B0C) =A0sensor =3D diode</div><div>PECI Agent 0: =A0+32.0=B0C =A0(high =
=3D +80.0=B0C, hyst =3D +75.0=B0C) =A0sensor =3D diode</div><div>PCH_CHIP_T=
EMP: +45.0=B0C =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0</div>
<div>PECI Agent 1: =A0 +0.0=B0C =A0(high =3D +80.0=B0C, hyst =3D +75.0=B0C)=
 =A0</div><div>cpu0_vid: =A0 =A0 +2.050 V</div><div><br></div><div><br></di=
v><div><br></div><div>The voltages are a bit surprising - obviously the thr=
ee with ALARM are out of range. =A0I&#39;m not sure if I can validate these=
 in the BIOS but I&#39;ll try tonight when I&#39;m home, but somehow I real=
ly doubt my +12V is putting out +17.5. =A0=A0</div>
<div><br></div><div>I&#39;m not sure why the first 3 fans are showing ALARM=
, but the values seem reasonable. =A0The motherboard only has 3 fan connect=
ors, so fan4 =3D 0 makes sense. =A0=A0</div><div><br></div><div>The coretem=
p module reports 4 temperatures (for each of my 4 cpu cores?) between 36C a=
nd 42C.</div>
<div><br></div><div>Thanks,</div><div>Scott</div>

--bcaec53f9539b0551504a5bfbf59--


--===============3915904832292512972==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3915904832292512972==--
