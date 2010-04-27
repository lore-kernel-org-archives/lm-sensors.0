From: Dmitry Gromov <gromovd@gmail.com>
Date: Tue, 27 Apr 2010 19:47:49 +0000
Subject: [lm-sensors] Intel Atom thermal sensors
Message-Id: <u2oe21d97a51004271247n7f5d4fbcn2a3de7429c738a08@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3073684760254759389=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============3073684760254759389==
Content-Type: multipart/alternative; boundary=0016367f99f6497f7904853d2ce8

--0016367f99f6497f7904853d2ce8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello.

Thank you for such great tool as lm_sensors package!

I'm a bit new to it and recently bought MSI Wind Nettop PC - small barebone
on intel Atom N330.
I'm using it with Ubuntu server 9.10 64 bit, trying to make a small home
NAS.

When I first installed lm_sensors package it was version 3.0.2 - it had
problem loading lm85 module despite correctly identifying adt7468 chip. Thi=
s
was fixed quickly after I searched list archives.
At the same time I've learned that recent versions of lm_sensors are able t=
o
detect Intel Atom thermal sensors.
I installed version 3.1.2 - now sensors-detect correctly identifies Atom
CPU, but I still do not see probes in sensors output.

Question - is this because Atom CPU support in coretemp is only in kernel
2.6.32 and my Ubunty is only  2.6.31?

Next, I'll try to create configuration for this motherboard, but I might
need some help here as well.
For example, I see output like this:
temp1:       +46.8=B0C  (low  =3D  +1.0=B0C, high =3D  -1.0=B0C)  ALARM
temp2:       +45.5=B0C  (low  =3D  +1.0=B0C, high =3D  -1.0=B0C)  ALARM
Which shows wrong min/max values, but browsing /sys/devices I found some
additional ranges in those files:
temp1_auto_temp_crit =3D 80000
temp1_auto_temp_max =3D 52000
temp1_auto_temp_min =3D 50000
temp1_auto_temp_off =3D 46000
What are those values (I understand that its Celsius * 1000)?  My guess
would be the values for fan control?
Also, temp1_max, temp1_min and temp1_fault are all "bad" - is this
because adt7468
does not report those values?
Is there detailed documentation on files in /sys/devices? Or reading
lib/sysfs.c is my best bet?

Thank you very much for your help!

--=20
DG
NJ

--0016367f99f6497f7904853d2ce8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<font color=3D"#3333ff"><font size=3D"2"><font face=3D"georgia,serif">Hello=
.<br><br>Thank you for such great tool as lm_sensors package!<br><br>I&#39;=
m a bit new to it and recently bought MSI Wind Nettop PC - small barebone o=
n intel Atom N330.<br>

I&#39;m using it with Ubuntu server 9.10 64 bit, trying to make a small hom=
e NAS.<br><br>When I first installed lm_sensors package it was version 3.0.=
2 - it had problem loading lm85 module despite correctly identifying adt746=
8 chip. This was fixed quickly after I searched list archives.<br>

At the same time I&#39;ve learned that recent versions of lm_sensors are ab=
le to detect Intel Atom thermal sensors.<br>I installed version 3.1.2 - now=
 sensors-detect correctly identifies Atom CPU, but I still do not see probe=
s in sensors output.<br>

<br>Question - is this because Atom CPU support in coretemp is only in kern=
el 2.6.32 and my Ubunty is only=A0 2.6.31?<br><br>Next, I&#39;ll try to cre=
ate configuration for this motherboard, but I might need some help here as =
well.<br>

For example, I see output like this:<br>temp1:=A0=A0=A0=A0=A0=A0 +46.8=B0C=
=A0 (low=A0 =3D=A0 +1.0=B0C, high =3D=A0 -1.0=B0C)=A0 ALARM<br>temp2:=A0=A0=
=A0=A0=A0=A0 +45.5=B0C=A0 (low=A0 =3D=A0 +1.0=B0C, high =3D=A0 -1.0=B0C)=A0=
 ALARM<br>Which shows wrong min/max values, but browsing /sys/devices I fou=
nd some additional ranges in those files:<br>

temp1_auto_temp_crit =3D 80000<br>temp1_auto_temp_max =3D 52000<br>temp1_au=
to_temp_min =3D 50000<br>temp1_auto_temp_off =3D 46000<br>What are those va=
lues (I understand that its Celsius * 1000)?=A0 My guess would be the value=
s for fan control?<br>

Also, temp1_max, temp1_min and temp1_fault are all &quot;bad&quot; - is thi=
s because </font></font></font><font color=3D"#3333ff"><font size=3D"2"><fo=
nt face=3D"georgia,serif">adt7468 does not report those values?</font></fon=
t></font><br>

<font color=3D"#3333ff"><font size=3D"2"><font face=3D"georgia,serif">Is th=
ere detailed documentation on files in /sys/devices? Or reading lib/sysfs.c=
 is my best bet?<br><br>Thank you very much for your help!<br clear=3D"all"=
></font></font></font><br>

-- <br>DG<br>NJ<br><br>

--0016367f99f6497f7904853d2ce8--


--===============3073684760254759389==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3073684760254759389==--
