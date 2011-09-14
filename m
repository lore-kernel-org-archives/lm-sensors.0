From: "corradoventu@libero.it" <corradoventu@libero.it>
Date: Wed, 14 Sep 2011 17:56:50 +0000
Subject: [lm-sensors] please help - sensors gives various ALARM but my
Message-Id: <13133530.6959691316023010840.JavaMail.defaultUser@defaultHost>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3839874605779246096=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============3839874605779246096==
Content-Type: multipart/alternative; 
	boundary="----=_Part_510122_15421405.1316023010840"

------=_Part_510122_15421405.1316023010840
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

sensors gives various ALARM but my chipset w83697hf is listed as supported=
=20
in: http://www.lm-sensors.org/wiki/Devices
    W83627HF, W83637HF, W83627THF, W83697HF yes    w83627hf LPC 2.6.5=20
my PC works fine ...
the following messages are from UBUNTU Oneiric but I have similar messages =
from Natty and Maverick

may you help me?
thanks

corrado@corrado-oneiric:~$ uname -r
3.0.0-11-generic
corrado@corrado-oneiric:~$ sensors -v
sensors version 3.3.0 with libsensors version 3.3.0
corrado@corrado-oneiric:~$ sensors
coretemp-isa-0000
Adapter: ISA adapter
Core 0:       +52.0=C2=B0C  (high =3D +78.0=C2=B0C, crit =3D +100.0=C2=B0C)
Core 1:       +52.0=C2=B0C  (high =3D +78.0=C2=B0C, crit =3D +100.0=C2=B0C)

w83697hf-isa-0290
Adapter: ISA adapter
in0:          +1.31 V  (min =3D  +0.74 V, max =3D  +0.06 V)  ALARM
in2:          +3.23 V  (min =3D  +0.70 V, max =3D  +1.22 V)  ALARM
in3:          +3.02 V  (min =3D  +2.69 V, max =3D  +2.13 V)  ALARM
in4:          +2.96 V  (min =3D  +1.62 V, max =3D  +0.38 V)  ALARM
in5:          +3.07 V  (min =3D  +1.60 V, max =3D  +1.18 V)  ALARM
in6:          +3.18 V  (min =3D  +0.35 V, max =3D  +1.79 V)  ALARM
in7:          +3.30 V  (min =3D  +0.13 V, max =3D  +0.51 V)  ALARM
in8:          +3.41 V  (min =3D  +0.32 V, max =3D  +1.09 V)  ALARM
fan1:           0 RPM  (min =3D 3668 RPM, div =3D 8)  ALARM
fan2:        2596 RPM  (min =3D 2343 RPM, div =3D 8)
temp1:        +40.0=C2=B0C  (high =3D +53.0=C2=B0C, hyst =3D +60.0=C2=B0C) =
 sensor =3D thermistor
temp2:        +38.5=C2=B0C  (high =3D +80.0=C2=B0C, hyst =3D +75.0=C2=B0C) =
 sensor =3D thermistor
beep_enable: enabled

nouveau-pci-0200
Adapter: PCI adapter
temp1:        +80.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +110.0=C2=B0C=
)

corrado@corrado-oneiric:~$ 
------=_Part_510122_15421405.1316023010840
Content-Type: text/html;charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p style=3D"margin: 0px; padding: 0px;">sensors gives various ALARM but my =
chipset w83697hf is listed as supported <br></p><p style=3D"margin: 0px; pa=
dding: 0px;">in: http://www.lm-sensors.org/wiki/Devices<br>&nbsp;&nbsp;&nbs=
p; W83627HF, W83637HF, W83627THF, W83697HF yes&nbsp;&nbsp;&nbsp; w83627hf L=
PC 2.6.5 <br>my PC works fine ...<br>the following messages are from UBUNTU=
 Oneiric but I have similar messages from Natty and Maverick<br><br>may you=
 help me?<br>thanks<br><br>corrado@corrado-oneiric:~$ uname -r<br>3.0.0-11-=
generic<br>corrado@corrado-oneiric:~$ sensors -v<br>sensors version 3.3.0 w=
ith libsensors version 3.3.0<br>corrado@corrado-oneiric:~$ sensors<br>coret=
emp-isa-0000<br>Adapter: ISA adapter<br>Core 0:&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; +52.0=C2=B0C&nbsp; (high =3D +78.0=C2=B0C, crit =3D +100.0=C2=B0C)=
<br>Core 1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +52.0=C2=B0C&nbsp; (high =
=3D +78.0=C2=B0C, crit =3D +100.0=C2=B0C)<br><br>w83697hf-isa-0290<br>Adapt=
er: ISA adapter<br>in0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; +1.31 V&nbsp; (min =3D&nbsp; +0.74 V, max =3D&nbsp; +0.06 V)&nbsp; ALARM=
<br>in2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +3.23 V&nbsp=
; (min =3D&nbsp; +0.70 V, max =3D&nbsp; +1.22 V)&nbsp; ALARM<br>in3:&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +3.02 V&nbsp; (min =3D&nbsp=
; +2.69 V, max =3D&nbsp; +2.13 V)&nbsp; ALARM<br>in4:&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +2.96 V&nbsp; (min =3D&nbsp; +1.62 V, max =
=3D&nbsp; +0.38 V)&nbsp; ALARM<br>in5:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; +3.07 V&nbsp; (min =3D&nbsp; +1.60 V, max =3D&nbsp; +1.18=
 V)&nbsp; ALARM<br>in6:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; +3.18 V&nbsp; (min =3D&nbsp; +0.35 V, max =3D&nbsp; +1.79 V)&nbsp; ALARM=
<br>in7:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +3.30 V&nbsp=
; (min =3D&nbsp; +0.13 V, max =3D&nbsp; +0.51 V)&nbsp; ALARM<br>in8:&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +3.41 V&nbsp; (min =3D&nbsp=
; +0.32 V, max =3D&nbsp; +1.09 V)&nbsp; ALARM<br>fan1:&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 RPM&nbsp; (min =3D 3668 RPM, div =
=3D 8)&nbsp; ALARM<br>fan2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2596 =
RPM&nbsp; (min =3D 2343 RPM, div =3D 8)<br>temp1:&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; +40.0=C2=B0C&nbsp; (high =3D +53.0=C2=B0C, hyst =3D +60.0=
=C2=B0C)&nbsp; sensor =3D thermistor<br>temp2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; +38.5=C2=B0C&nbsp; (high =3D +80.0=C2=B0C, hyst =3D +75.0=C2=
=B0C)&nbsp; sensor =3D thermistor<br>beep_enable: enabled<br><br>nouveau-pc=
i-0200<br>Adapter: PCI adapter<br>temp1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; +80.0=C2=B0C&nbsp; (high =3D +100.0=C2=B0C, crit =3D +110.0=C2=B0C)=
<br><br>corrado@corrado-oneiric:~$ <br mce_bogus=3D"1"></p><div style=3D"po=
sition: absolute; left: -10000px; top: 0px; width: 1px; height: 1px; overfl=
ow: hidden;" id=3D"_mcePaste">&nbsp;</div>
------=_Part_510122_15421405.1316023010840--



--===============3839874605779246096==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3839874605779246096==--

