From: "Jake Solid" <richardsolid@gmail.com>
Date: Mon, 11 Aug 2008 17:24:35 +0000
Subject: [lm-sensors] Incorrect Voltage Representation
Message-Id: <ad68da050808111024g7d25a650l2d0b5204d5ac01c@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2008682589680162995=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============2008682589680162995==
Content-Type: multipart/alternative; 
	boundary="----=_Part_31665_13113217.1218475475900"

------=_Part_31665_13113217.1218475475900
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I ran sensors-detect and after the commands were generated to load the I2C
modules I add the respective lines to /etc/modprobe.conf and to
/etc/rc.d/rc.sysinit

After following the instructions I ran sensors and got the following output=
:

Some of the voltage output looks incorrect because in reality is not
representing what in reality is suppose to represent. the issue shows on th=
e
following lines:

-12V:      +1.13 V  (min =3D -13.18 V, max =3D -10.80 V)       ALARM
-5V:       +2.29 V  (min =3D  -5.25 V, max =3D  -4.75 V)       ALARM

*How can i workaround this issue?*

[root@ etc]#    sensors
w83627hf-isa-0290
Adapter: ISA adapter
VCore 1:   +4.08 V  (min =3D  +1.34 V, max =3D  +1.49 V)       ALARM
VCore 2:   +4.08 V  (min =3D  +1.34 V, max =3D  +1.49 V)       ALARM
+3.3V:     +4.08 V  (min =3D  +3.14 V, max =3D  +3.47 V)       ALARM
+5V:       +5.08 V  (min =3D  +4.76 V, max =3D  +5.24 V)
+12V:     +11.67 V  (min =3D +10.82 V, max =3D +13.19 V)
-12V:      +1.13 V  (min =3D -13.18 V, max =3D -10.80 V)       ALARM
-5V:       +2.29 V  (min =3D  -5.25 V, max =3D  -4.75 V)       ALARM
V5SB:      +5.64 V  (min =3D  +4.76 V, max =3D  +5.24 V)       ALARM
VBat:      +1.68 V  (min =3D  +2.40 V, max =3D  +3.60 V)       ALARM
fan1:        0 RPM  (min =3D 4530 RPM, div =3D 2)              ALARM
fan2:        0 RPM  (min =3D 2657 RPM, div =3D 2)              ALARM
fan3:        0 RPM  (min =3D 15697 RPM, div =3D 2)              ALARM
temp1:       -48=C2=B0C  (high =3D   -17=C2=B0C, hyst =3D  +104=C2=B0C)   s=
ensor =3D
thermistor
temp2:     -48.0=C2=B0C  (high =3D   +80=C2=B0C, hyst =3D   +75=C2=B0C)   s=
ensor =3D
thermistor
temp3:     -48.0=C2=B0C  (high =3D   +80=C2=B0C, hyst =3D   +75=C2=B0C)   s=
ensor =3D
thermistor
vid:      +1.419 V  (VRM Version 11.0)
alarms:
beep_enable:
          Sound alarm enabled

------=_Part_31665_13113217.1218475475900
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div dir=3D"ltr">I ran sensors-detect and after the commands were generated=
 to load the I2C modules I add the respective lines to /etc/modprobe.conf a=
nd to /etc/rc.d/rc.sysinit<br><br>After following the instructions I ran se=
nsors and got the following output:<br>
<br>Some of the voltage output looks incorrect because in reality is not re=
presenting what in reality is suppose to represent. the issue shows on the =
following lines:<br><br>-12V:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +1.13 V&nbsp; (=
min =3D -13.18 V, max =3D -10.80 V)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALA=
RM<br>

-5V:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +2.29 V&nbsp; (min =3D&nbsp; -5.25=
 V, max =3D&nbsp; -4.75 V)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALARM<br><br=
><b>How can i workaround this issue?</b><br><br>[root@ etc]#&nbsp;&nbsp;&nb=
sp; sensors<br>w83627hf-isa-0290<br>Adapter: ISA adapter<br>VCore 1:&nbsp;&=
nbsp; +4.08 V&nbsp; (min =3D&nbsp; +1.34 V, max =3D&nbsp; +1.49 V)&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; ALARM<br>
VCore 2:&nbsp;&nbsp; +4.08 V&nbsp; (min =3D&nbsp; +1.34 V, max =3D&nbsp; +1=
.49 V)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALARM<br>+3.3V:&nbsp;&nbsp;&nbsp=
;&nbsp; +4.08 V&nbsp; (min =3D&nbsp; +3.14 V, max =3D&nbsp; +3.47 V)&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALARM<br>+5V:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; +5.08 V&nbsp; (min =3D&nbsp; +4.76 V, max =3D&nbsp; +5.24 V)<br>+12V:&=
nbsp;&nbsp;&nbsp;&nbsp; +11.67 V&nbsp; (min =3D +10.82 V, max =3D +13.19 V)=
<br>
-12V:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +1.13 V&nbsp; (min =3D -13.18 V, max =
=3D -10.80 V)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALARM<br>-5V:&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; +2.29 V&nbsp; (min =3D&nbsp; -5.25 V, max =3D&nbsp=
; -4.75 V)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALARM<br>V5SB:&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; +5.64 V&nbsp; (min =3D&nbsp; +4.76 V, max =3D&nbsp; +5.24 =
V)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALARM<br>VBat:&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; +1.68 V&nbsp; (min =3D&nbsp; +2.40 V, max =3D&nbsp; +3.60 V)&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALARM<br>
fan1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 RPM&nbsp; (min =3D 4530 R=
PM, div =3D 2)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; ALARM<br>fan2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0 RPM&nbsp; (min =3D 2657 RPM, div =3D 2)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALARM<br>fan3:&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; 0 RPM&nbsp; (min =3D 15697 RPM, div =3D 2)&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AL=
ARM<br>temp1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -48=C2=B0C&nbsp; (high =
=3D&nbsp;&nbsp; -17=C2=B0C, hyst =3D&nbsp; +104=C2=B0C)&nbsp;&nbsp; sensor =
=3D thermistor<br>
temp2:&nbsp;&nbsp;&nbsp;&nbsp; -48.0=C2=B0C&nbsp; (high =3D&nbsp;&nbsp; +80=
=C2=B0C, hyst =3D&nbsp;&nbsp; +75=C2=B0C)&nbsp;&nbsp; sensor =3D thermistor=
<br>temp3:&nbsp;&nbsp;&nbsp;&nbsp; -48.0=C2=B0C&nbsp; (high =3D&nbsp;&nbsp;=
 +80=C2=B0C, hyst =3D&nbsp;&nbsp; +75=C2=B0C)&nbsp;&nbsp; sensor =3D thermi=
stor<br>vid:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +1.419 V&nbsp; (VRM Version 11.0=
)<br>alarms:<br>beep_enable:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sound alarm enabled<=
br><br></div>

------=_Part_31665_13113217.1218475475900--


--===============2008682589680162995==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2008682589680162995==--
