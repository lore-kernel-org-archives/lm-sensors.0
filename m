From: martind@noxam.com
Date: Thu, 11 Jun 2009 23:28:27 +0000
Subject: [lm-sensors] ASUS M3A78-CM
Message-Id: <56834.1244762907@noxam.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4830265329427472375=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--===============4830265329427472375==
Content-type: multipart/alternative;
	boundary="Boundary_(ID_Z/ScvS22X7cFWOzCgwWLSQ)"


--Boundary_(ID_Z/ScvS22X7cFWOzCgwWLSQ)
Content-type: text/plain; charset=utf-8
Content-transfer-encoding: 7BIT

 
	Hi all! 
 After couple hours... figured out the config for an ASUS M3A78-CM
 motherboard
 Here you go!
 chip "it87-*" "it8712-*"
 # The values below have been tested on Asus M3A78-CM motherboards.
     label in0 "VCore 1"
     ignore in1
     label in2 "+3.3V"
     ignore in3
     label in4 "+12V"
     label in5 "+5V"
     ignore in6
     ignore in7
     label in8 "VBat"
     compute in4 ((28/10) +1)*@  , @/((28/10) +1)
     compute in5 @*(1+(22/10)),  @/(1+(22/10))
     set in0_min  1.30 * 0.95
     set in0_max  1.30 * 1.05
     set in2_min  3.3 * 0.95
     set in2_max  3.3 * 1.05
     set in4_min   12 * 0.95
     set in4_max   12 * 1.05
     set in5_min    5 * 0.95
     set in5_max    5 * 1.05
     set temp1_type 2
     set temp2_type 2
     set temp3_type 3
     ignore temp3
     label temp1       "CPU Temp"
     label temp2       "M/B Temp"
 _____________________________________
 remove everything else!
 here is the output from sensors:
 frodo:/sys/class/hwmon/hwmon1/device # sensors
 atk0110-acpi-0
 Adapter: ACPI interface
 Vcore Voltage:     +1.30 V  (min =  +0.85 V, max =  +1.60 V)
  +3.3 Voltage:     +3.28 V  (min =  +2.97 V, max =  +3.63 V)
  +5 Voltage:       +4.97 V  (min =  +4.50 V, max =  +5.50 V)
  +12 Voltage:     +12.22 V  (min = +10.20 V, max = +13.80 V)
 CPU FAN Speed:    2295 RPM  (min =  600 RPM)
 CHASSIS FAN Speed:   0 RPM  (min =  600 RPM)
 POWER FAN Speed:  1313 RPM  (min =  600 RPM)
 CPU Temperature:   +48.0&deg;C  (high = +60.0&deg;C, crit =
 +95.0&deg;C)
 MB Temperature:    +35.0&deg;C  (high = +45.0&deg;C, crit =
 +95.0&deg;C)
 it8712-isa-0290
 Adapter: ISA adapter
 VCore 1:     +1.30 V  (min =  +1.23 V, max =  +1.36 V)
 +3.3V:       +3.28 V  (min =  +3.14 V, max =  +3.47 V)
 +12V:       +12.22 V  (min = +11.37 V, max = +12.59 V)
 +5V:         +4.97 V  (min =  +4.76 V, max =  +5.27 V)
 VBat:        +3.20 V
 fan1:       2295 RPM  (min =    0 RPM)
 fan2:          0 RPM  (min =    0 RPM)
 fan3:       1313 RPM  (min =    0 RPM)
 CPU Temp:    +48.0&deg;C  (low  =  -1.0&deg;C, high =  -5.0&deg;C) 
 sensor = thermistor
 M/B Temp:    +35.0&deg;C  (low  =  -1.0&deg;C, high = +127.0&deg;C) 
 sensor = thermistor
 cpu0_vid:   +1.550 V
 frodo:/sys/class/hwmon/hwmon1/device #
 Best Regards
 Martin Desormeaux
 a.k.a Neo2048

--Boundary_(ID_Z/ScvS22X7cFWOzCgwWLSQ)
Content-type: text/html; charset=utf-8
Content-transfer-encoding: quoted-printable

<HTML>
<p>&nbsp;</p><p>Hi all! <br /> <br /> After couple hours... figured out the=
 config for an ASUS M3A78-CM<br /> motherboard<br /> Here you go!<br /> chi=
p &quot;it87-*&quot; &quot;it8712-*&quot;<br /> <br /> # The values below h=
ave been tested on Asus M3A78-CM motherboards.<br /> <br />     label in0 &=
quot;VCore 1&quot;<br />     ignore in1<br />     label in2 &quot;+3.3V&quo=
t;<br />     ignore in3<br />     label in4 &quot;+12V&quot;<br />     labe=
l in5 &quot;+5V&quot;<br />     ignore in6<br />     ignore in7<br />     l=
abel in8 &quot;VBat&quot;<br /> <br />     compute in4 ((28/10) +1)*@  , @/=
((28/10) +1)<br />     compute in5 @*(1+(22/10)),  @/(1+(22/10))<br /> <br =
/>     set in0_min  1.30 * 0.95<br />     set in0_max  1.30 * 1.05<br />   =
  set in2_min  3.3 * 0.95<br />     set in2_max  3.3 * 1.05<br />     set i=
n4_min   12 * 0.95<br />     set in4_max   12 * 1.05<br />     set in5_min =
   5 * 0.95<br />     set in5_max    5 * 1.05<br /> <br />     set temp1_ty=
pe 2<br />     set temp2_type 2<br />     set temp3_type 3<br />     ignore=
 temp3<br /> <br />     label temp1       &quot;CPU Temp&quot;<br />     la=
bel temp2       &quot;M/B Temp&quot;<br /> <br /> _________________________=
____________<br /> <br /> remove everything else!<br /> <br /> here is the =
output from sensors:<br /> frodo:/sys/class/hwmon/hwmon1/device # sensors<b=
r /> atk0110-acpi-0<br /> Adapter: ACPI interface<br /> Vcore Voltage:     =
+1.30 V  (min =3D  +0.85 V, max =3D  +1.60 V)<br />  +3.3 Voltage:     +3.2=
8 V  (min =3D  +2.97 V, max =3D  +3.63 V)<br />  +5 Voltage:       +4.97 V =
 (min =3D  +4.50 V, max =3D  +5.50 V)<br />  +12 Voltage:     +12.22 V  (mi=
n =3D +10.20 V, max =3D +13.80 V)<br /> CPU FAN Speed:    2295 RPM  (min =
=3D  600 RPM)<br /> CHASSIS FAN Speed:   0 RPM  (min =3D  600 RPM)<br /> PO=
WER FAN Speed:  1313 RPM  (min =3D  600 RPM)<br /> CPU Temperature:   +48.0=
&amp;deg;C  (high =3D +60.0&amp;deg;C, crit =3D<br /> +95.0&amp;deg;C)<br /=
> MB Temperature:    +35.0&amp;deg;C  (high =3D +45.0&amp;deg;C, crit =3D<b=
r /> +95.0&amp;deg;C)<br /> <br /> it8712-isa-0290<br /> Adapter: ISA adapt=
er<br /> VCore 1:     +1.30 V  (min =3D  +1.23 V, max =3D  +1.36 V)<br /> +=
3.3V:       +3.28 V  (min =3D  +3.14 V, max =3D  +3.47 V)<br /> +12V:      =
 +12.22 V  (min =3D +11.37 V, max =3D +12.59 V)<br /> +5V:         +4.97 V =
 (min =3D  +4.76 V, max =3D  +5.27 V)<br /> VBat:        +3.20 V<br /> fan1=
:       2295 RPM  (min =3D    0 RPM)<br /> fan2:          0 RPM  (min =3D  =
  0 RPM)<br /> fan3:       1313 RPM  (min =3D    0 RPM)<br /> CPU Temp:    =
+48.0&amp;deg;C  (low  =3D  -1.0&amp;deg;C, high =3D  -5.0&amp;deg;C) <br /=
> sensor =3D thermistor<br /> M/B Temp:    +35.0&amp;deg;C  (low  =3D  -1.0=
&amp;deg;C, high =3D +127.0&amp;deg;C) <br /> sensor =3D thermistor<br /> c=
pu0_vid:   +1.550 V<br /> <br /> frodo:/sys/class/hwmon/hwmon1/device #<br =
/> Best Regards<br /> Martin Desormeaux<br /> <br /> a.k.a Neo2048</p></HTM=
L>=

--Boundary_(ID_Z/ScvS22X7cFWOzCgwWLSQ)--


--===============4830265329427472375==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4830265329427472375==--
