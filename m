From: Simon Wilson <simon@simonandkate.net>
Date: Fri, 30 Sep 2011 03:14:18 +0000
Subject: [lm-sensors] it8721-isa-0290 - report
Message-Id: <20110930131418.Horde.F4EcatJO7vlOhTQKZAfERNA@mail.simonandkate.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2349589076708979428=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This message is in MIME format.

--===============2349589076708979428==
Content-Type: multipart/alternative; boundary="=_vOXSX9JO7vlOhTQKYeRkRNA"

This message is in MIME format.

--=_vOXSX9JO7vlOhTQKYeRkRNA
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; DelSp=Yes
Content-Description: Plaintext Message
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

   IT8721F, IT8758E 	yes 	it87 	LPC 	2.6.37 or =A0standalone driver[1]
	(2010-10-12) We have a datasheet for the IT8721F. Different from previous
IT87xxF chips (12 mV ADC instead of 16 mV, amongst other.) Two requests
(=A0Jae Sammy[2], =A0Virgil Gheorghiu[3].) The IT8758E was reported to have=
 the
same device ID, so hopefully they are fully compatible. Support added by
Jean Delvare, please test the standalone driver and report.

   Devices page notes above -

   Motherboard is an Asus M5A99X Evo. Running CentOS 6.

   Installed lm_sensors from CentOS, had to grab the latest sensors-detect
script, and then installed the stand-alone driver for it87 noted above.

   Works fine.

   Output is:

   it8721-isa-0290
   Adapter: ISA adapter
   in0:=A0=A0=A0=A0=A0=A0=A0=A0 +2.81 V=A0 (min =3D=A0 +2.94 V, max =3D=A0 =
+2.20 V)=A0=A0 ALARM
   in1:=A0=A0=A0=A0=A0=A0=A0=A0 +2.78 V=A0 (min =3D=A0 +3.01 V, max =3D=A0 =
+2.08 V)=A0=A0 ALARM
   in2:=A0=A0=A0=A0=A0=A0=A0=A0 +1.42 V=A0 (min =3D=A0 +1.48 V, max =3D=A0 =
+1.48 V)=A0=A0 ALARM
   +3.3V:=A0=A0=A0=A0=A0=A0 +3.36 V=A0 (min =3D=A0 +4.56 V, max =3D=A0 +2.1=
1 V)=A0=A0 ALARM
   in4:=A0=A0=A0=A0=A0=A0=A0=A0 +0.56 V=A0 (min =3D=A0 +0.00 V, max =3D=A0 =
+2.24 V)
   in5:=A0=A0=A0=A0=A0=A0=A0=A0 +2.51 V=A0 (min =3D=A0 +2.62 V, max =3D=A0 =
+2.24 V)=A0=A0 ALARM
   in6:=A0=A0=A0=A0=A0=A0=A0=A0 +0.74 V=A0 (min =3D=A0 +2.27 V, max =3D=A0 =
+2.92 V)=A0=A0 ALARM
   3VSB:=A0=A0=A0=A0=A0=A0=A0 +5.26 V=A0 (min =3D=A0 +4.18 V, max =3D=A0 +6=
.10 V)
   Vbat:=A0=A0=A0=A0=A0=A0=A0 +3.36 V
   fan1:=A0=A0=A0=A0=A0=A0 2205 RPM=A0 (min =3D=A0=A0 10 RPM)
   fan2:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0 (min =3D=A0=A0 13 RPM)=A0 ALAR=
M
   fan3:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0 (min =3D=A0=A0 10 RPM)=A0 ALAR=
M
   temp1:=A0=A0=A0=A0=A0=A0 +42.0=C3=82=C2=B0C=A0 (low=A0 =3D -34.0=C3=82=
=C2=B0C, high =3D -73.0=C3=82=C2=B0C)=A0 sensor
=3D thermistor
   temp2:=A0=A0=A0=A0=A0=A0 +30.0=C3=82=C2=B0C=A0 (low=A0 =3D +79.0=C3=82=
=C2=B0C, high =3D -22.0=C3=82=C2=B0C)=A0 ALARM=A0
sensor =3D thermistor
   temp3:=A0=A0=A0=A0=A0 -128.0=C3=82=C2=B0C=A0 (low=A0 =3D +127.0=C3=82=C2=
=B0C, high =3D -41.0=C3=82=C2=B0C)=A0 sensor
=3D disabled

   Would appreciate any help anyone can give in configuring sensors.conf
though - a lot of the readings are a bit skewed.

   Simon.
   ___________
   Simon Wilson
   M: 0400 12 11 16


Links:
------
[1] http://khali.linux-fr.org/devel/misc/it87/
[2]  
http://lists.lm-sensors.org/pipermail/lm-sensors/2010-September/029393.html
[3]  
http://lists.lm-sensors.org/pipermail/lm-sensors/2010-September/029448.html

--=_vOXSX9JO7vlOhTQKYeRkRNA
Content-Type: text/html; charset=ISO-8859-1
Content-Description: HTML Message
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">
<html>
<head>
<title></title>
</head>
<body style=3D"font-family:Arial;font-size:14px">
<div class=3D"impComposeSignature">
<table class=3D"wiki">
<tbody>
<tr>
<td>IT8721F, IT8758E</td>
<td>yes</td>
<td>it87</td>
<td>LPC</td>
<td>2.6.37 or <a class=3D"ext-link" href=3D"http://khali.linux-fr.org/devel=
/misc/it87/"><span class=3D"icon">&nbsp;</span>standalone driver</a></td>
<td>(2010-10-12) We have a datasheet for the IT8721F. Different from previo=
us IT87xxF chips (12 mV ADC instead of 16 mV, amongst other.) Two requests =
(<a class=3D"ext-link" href=3D"http://lists.lm-sensors.org/pipermail/lm-sen=
sors/2010-September/029393.html"><span class=3D"icon">&nbsp;</span>Jae Samm=
y</a>, <a class=3D"ext-link" href=3D"http://lists.lm-sensors.org/pipermail/=
lm-sensors/2010-September/029448.html"><span class=3D"icon">&nbsp;</span>Vi=
rgil Gheorghiu</a>.) The IT8758E was reported to have the same device ID, s=
o hopefully they are fully compatible. Support added by Jean Delvare, pleas=
e test the standalone driver and report.</td>
</tr>
</tbody>
</table>
<br>
Devices page notes above -<br>
<br>
Motherboard is an Asus M5A99X Evo. Running CentOS 6.<br>
<br>
Installed lm_sensors from CentOS, had to grab the latest sensors-detect scr=
ipt, and then installed the stand-alone driver for it87 noted above.<br>
<br>
Works fine.<br>
<br>
Output is:<br>
<br>
it8721-isa-0290<br>
Adapter: ISA adapter<br>
in0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +2.81 V&nbsp; (min =3D=
&nbsp; +2.94 V, max =3D&nbsp; +2.20 V)&nbsp;&nbsp; ALARM<br>
in1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +2.78 V&nbsp; (min =3D=
&nbsp; +3.01 V, max =3D&nbsp; +2.08 V)&nbsp;&nbsp; ALARM<br>
in2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +1.42 V&nbsp; (min =3D=
&nbsp; +1.48 V, max =3D&nbsp; +1.48 V)&nbsp;&nbsp; ALARM<br>
+3.3V:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +3.36 V&nbsp; (min =3D&nbsp; +4.=
56 V, max =3D&nbsp; +2.11 V)&nbsp;&nbsp; ALARM<br>
in4:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +0.56 V&nbsp; (min =3D=
&nbsp; +0.00 V, max =3D&nbsp; +2.24 V)<br>
in5:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +2.51 V&nbsp; (min =3D=
&nbsp; +2.62 V, max =3D&nbsp; +2.24 V)&nbsp;&nbsp; ALARM<br>
in6:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +0.74 V&nbsp; (min =3D=
&nbsp; +2.27 V, max =3D&nbsp; +2.92 V)&nbsp;&nbsp; ALARM<br>
3VSB:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +5.26 V&nbsp; (min =3D&nbsp=
; +4.18 V, max =3D&nbsp; +6.10 V)<br>
Vbat:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +3.36 V<br>
fan1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2205 RPM&nbsp; (min =3D&nbsp;&nbs=
p; 10 RPM)<br>
fan2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 RPM&nbsp; (mi=
n =3D&nbsp;&nbsp; 13 RPM)&nbsp; ALARM<br>
fan3:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 RPM&nbsp; (mi=
n =3D&nbsp;&nbsp; 10 RPM)&nbsp; ALARM<br>
temp1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +42.0=C2=B0C&nbsp; (low&nbsp; =
=3D -34.0=C2=B0C, high =3D -73.0=C2=B0C)&nbsp; sensor =3D thermistor<br>
temp2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +30.0=C2=B0C&nbsp; (low&nbsp; =
=3D +79.0=C2=B0C, high =3D -22.0=C2=B0C)&nbsp; ALARM&nbsp; sensor =3D therm=
istor<br>
temp3:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -128.0=C2=B0C&nbsp; (low&nbsp; =3D +12=
7.0=C2=B0C, high =3D -41.0=C2=B0C)&nbsp; sensor =3D disabled<br>
<br>
Would appreciate any help anyone can give in configuring sensors.conf thoug=
h - a lot of the readings are a bit skewed.<br>
<br>
Simon.<br>
___________<br>
Simon Wilson<br>
M: 0400 12 11 16</div>
</body>
</html>
--=_vOXSX9JO7vlOhTQKYeRkRNA--



--===============2349589076708979428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2349589076708979428==--

