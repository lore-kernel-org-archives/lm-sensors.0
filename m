From: martind@noxam.com
Date: Thu, 11 Jun 2009 04:55:06 +0000
Subject: [lm-sensors] Asus M3A78-C< - here is the RIGHT sensors3.conf lines
Message-Id: <43301.1244696106@noxam.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6299702356874107464=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--===============6299702356874107464==
Content-type: multipart/alternative;
	boundary="Boundary_(ID_wErvJoxh1P/nk10RUXy5Wg)"


--Boundary_(ID_wErvJoxh1P/nk10RUXy5Wg)
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

--Boundary_(ID_wErvJoxh1P/nk10RUXy5Wg)
Content-type: text/html; charset=utf-8
Content-transfer-encoding: quoted-printable

<HTML>
<p>&nbsp;</p><p>Hi all! </p><p>After couple hours... figured out the config=
 for an ASUS M3A78-CM motherboard</p><p>&nbsp;</p><p>Here you go!</p><p>&nb=
sp;</p><p>chip &quot;it87-*&quot; &quot;it8712-*&quot;<br /><br /># The val=
ues below have been tested on Asus M3A78-CM motherboards.<br /><br />&nbsp;=
&nbsp;&nbsp; label in0 &quot;VCore 1&quot;<br />&nbsp;&nbsp;&nbsp; ignore i=
n1<br />&nbsp;&nbsp;&nbsp; label in2 &quot;+3.3V&quot;<br />&nbsp;&nbsp;&nb=
sp; ignore in3<br />&nbsp;&nbsp;&nbsp; label in4 &quot;+12V&quot;<br />&nbs=
p;&nbsp;&nbsp; label in5 &quot;+5V&quot;<br />&nbsp;&nbsp;&nbsp; ignore in6=
<br />&nbsp;&nbsp;&nbsp; ignore in7<br />&nbsp;&nbsp;&nbsp; label in8 &quot=
;VBat&quot;</p><p>&nbsp;&nbsp;&nbsp; compute in4 ((28/10) +1)*@&nbsp; , @/(=
(28/10) +1)<br />&nbsp;&nbsp;&nbsp; compute in5 @*(1+(22/10)),&nbsp; @/(1+(=
22/10))</p><p>&nbsp;&nbsp;&nbsp; set in0_min&nbsp; 1.30 * 0.95<br />&nbsp;&=
nbsp;&nbsp; set in0_max&nbsp; 1.30 * 1.05<br />&nbsp;&nbsp;&nbsp; set in2_m=
in&nbsp; 3.3 * 0.95<br />&nbsp;&nbsp;&nbsp; set in2_max&nbsp; 3.3 * 1.05<br=
 />&nbsp;&nbsp;&nbsp; set in4_min&nbsp;&nbsp; 12 * 0.95<br />&nbsp;&nbsp;&n=
bsp; set in4_max&nbsp;&nbsp; 12 * 1.05<br />&nbsp;&nbsp;&nbsp; set in5_min&=
nbsp;&nbsp;&nbsp; 5 * 0.95<br />&nbsp;&nbsp;&nbsp; set in5_max&nbsp;&nbsp;&=
nbsp; 5 * 1.05</p><p>&nbsp;&nbsp;&nbsp; set temp1_type 2<br />&nbsp; &nbsp;=
 set temp2_type 2<br />&nbsp; &nbsp; set temp3_type 3<br />&nbsp; &nbsp; ig=
nore temp3</p><p>&nbsp; &nbsp; label temp1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; &quot;CPU Temp&quot;<br />&nbsp; &nbsp; label temp2&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; &quot;M/B Temp&quot;<br /><br />__________________________=
___________</p><p>remove everything else!</p><p>here is the output from sen=
sors:</p><p>&nbsp;</p><p>frodo:/sys/class/hwmon/hwmon1/device # sensors<br =
/>atk0110-acpi-0<br />Adapter: ACPI interface<br />Vcore Voltage:&nbsp;&nbs=
p;&nbsp;&nbsp; +1.30 V&nbsp; (min =3D&nbsp; +0.85 V, max =3D&nbsp; +1.60 V)=
<br />&nbsp;+3.3 Voltage:&nbsp;&nbsp;&nbsp;&nbsp; +3.28 V&nbsp; (min =3D&nb=
sp; +2.97 V, max =3D&nbsp; +3.63 V)<br />&nbsp;+5 Voltage:&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; +4.97 V&nbsp; (min =3D&nbsp; +4.50 V, max =3D&nbsp; +5.=
50 V)<br />&nbsp;+12 Voltage:&nbsp;&nbsp;&nbsp;&nbsp; +12.22 V&nbsp; (min =
=3D +10.20 V, max =3D +13.80 V)<br />CPU FAN Speed:&nbsp;&nbsp;&nbsp; 2295 =
RPM&nbsp; (min =3D&nbsp; 600 RPM)<br />CHASSIS FAN Speed:&nbsp;&nbsp; 0 RPM=
&nbsp; (min =3D&nbsp; 600 RPM)<br />POWER FAN Speed:&nbsp; 1313 RPM&nbsp; (=
min =3D&nbsp; 600 RPM)<br />CPU Temperature:&nbsp;&nbsp; +48.0&deg;C&nbsp; =
(high =3D +60.0&deg;C, crit =3D +95.0&deg;C)<br />MB Temperature:&nbsp;&nbs=
p;&nbsp; +35.0&deg;C&nbsp; (high =3D +45.0&deg;C, crit =3D +95.0&deg;C)<br =
/><br />it8712-isa-0290<br />Adapter: ISA adapter<br />VCore 1:&nbsp;&nbsp;=
&nbsp;&nbsp; +1.30 V&nbsp; (min =3D&nbsp; +1.23 V, max =3D&nbsp; +1.36 V)<b=
r />+3.3V:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +3.28 V&nbsp; (min =3D&nbsp;=
 +3.14 V, max =3D&nbsp; +3.47 V)<br />+12V:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; +12.22 V&nbsp; (min =3D +11.37 V, max =3D +12.59 V)<br />+5V:&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +4.97 V&nbsp; (min =3D&nbsp; +4.76 =
V, max =3D&nbsp; +5.27 V)<br />VBat:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; +3.20 V<br />fan1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2295 RPM&nbsp; (=
min =3D&nbsp;&nbsp;&nbsp; 0 RPM)<br />fan2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; 0 RPM&nbsp; (min =3D&nbsp;&nbsp;&nbsp; 0 RPM)<br />f=
an3:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1313 RPM&nbsp; (min =3D&nbsp;&nbsp=
;&nbsp; 0 RPM)<br />CPU Temp:&nbsp;&nbsp;&nbsp; +48.0&deg;C&nbsp; (low&nbsp=
; =3D&nbsp; -1.0&deg;C, high =3D&nbsp; -5.0&deg;C)&nbsp; sensor =3D thermis=
tor<br />M/B Temp:&nbsp;&nbsp;&nbsp; +35.0&deg;C&nbsp; (low&nbsp; =3D&nbsp;=
 -1.0&deg;C, high =3D +127.0&deg;C)&nbsp; sensor =3D thermistor<br />cpu0_v=
id:&nbsp;&nbsp; +1.550 V<br /><br />frodo:/sys/class/hwmon/hwmon1/device #<=
br />&nbsp;</p><p>&nbsp;</p><p>Best Regards</p><p>&nbsp;</p><p>Martin Desor=
meaux</p><p>a.k.a Neo2048</p></HTML>=

--Boundary_(ID_wErvJoxh1P/nk10RUXy5Wg)--


--===============6299702356874107464==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6299702356874107464==--
