From: Todd Nine <todd@spidertracks.co.nz>
Date: Wed, 13 May 2009 05:11:57 +0000
Subject: [lm-sensors] Help with new supermicro fan control
Message-Id: <302AA348-F401-4C33-A1C8-393BB4A40791@spidertracks.co.nz>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6579521677043737414=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--===============6579521677043737414==
Content-Type: multipart/alternative; boundary=Apple-Mail-5--256170962


--Apple-Mail-5--256170962
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: quoted-printable

Hi all,
   I'm attempting to install lm_sensors in to CentOs 5.3 x86_64 on a =20
Super Micro

http://www.supermicro.com/products/motherboard/Xeon1333/5400/X7DWN+.cfm

I've tried both the latest source 3.1, as well as the rpm from yum =20
which is v 2.10.7 with libsensors v 2.10.7.  I'd prefer to use the RPM =20=

version that comes from yum if possible.  Whenever I run the sensors =20
command, I always receive the following output.

w83627hf-isa-0290
Adapter: ISA adapter
VCore 1:   +3.36 V  (min =3D  +0.00 V, max =3D  +4.08 V)
VCore 2:   +3.31 V  (min =3D  +0.00 V, max =3D  +4.08 V)
+3.3V:     +3.30 V  (min =3D  +2.82 V, max =3D  +3.79 V)
+5V:       +5.16 V  (min =3D  +0.46 V, max =3D  +0.08 V)       ALARM
+12V:     +11.73 V  (min =3D  +6.69 V, max =3D  +7.30 V)       ALARM
-12V:      +0.96 V  (min =3D -14.50 V, max =3D -10.63 V)       ALARM
-5V:       +1.99 V  (min =3D  -5.20 V, max =3D  +1.99 V)
V5SB:      +5.64 V  (min =3D  +5.16 V, max =3D  +5.00 V)       ALARM
VBat:      +0.00 V  (min =3D  +0.35 V, max =3D  +0.16 V)       ALARM
fan1:        0 RPM  (min =3D 5273 RPM, div =3D 128)              ALARM
fan2:        0 RPM  (min =3D 6250 RPM, div =3D 2)              ALARM
fan3:        0 RPM  (min =3D 5672 RPM, div =3D 2)              ALARM
temp1:       -30=B0C  (high =3D   +33=B0C, hyst =3D    +8=B0C)   sensor =
=3D =20
thermistor
temp2:     -34.0=B0C  (high =3D   +80=B0C, hyst =3D   +75=B0C)   sensor =
=3D =20
thermistor
temp3:     -34.0=B0C  (high =3D   +80=B0C, hyst =3D   +75=B0C)   sensor =
=3D =20
thermistor
vid:      +0.000 V  (VRM Version 8.2)
alarms:
beep_enable:
           Sound alarm enabled


As you can see none of my fans are working.  I've read the wiki on fan =20=

control and divisors, but I don't seem to have any config options.  =20
Here is the config I have in etc/sensors.conf for my board.  I know =20
that my fans must report data, as windows detects the rpms and I have =20=

4 pins on my fan connectors.  I'm also able to detect my temperature =20
and fan speed in BIOS.  I'm sure it's a simple config I've missed, but =20=

I'm new to lm-sensors so any help would be appreciated.

Thanks,
Todd

chip "w83782d-*" "w83627hf-*"

# Same as above for w83781d except that in5 and in6 are computed =20
differently.
# Rather than an internal inverting op amp, the 82d/83s use standard =20
positive
# inputs and the negative voltages are level shifted by a 3.6V =20
reference.
# The math is convoluted, so we hope that your motherboard
# uses the recommended resistor values.

     label in0 "VCore 1"
     label in1 "VCore 2"
     label in2 "+3.3V"
     label in3 "+5V"
     label in4 "+12V"
     label in5 "-12V"
     label in6 "-5V"
     label in7 "V5SB"
     label in8 "VBat"

# Abit BP6 motherboard has a few differences. VCore1 and VCore2 are =20
the core
# voltages of the two processors. Vtt is memory bus termination =20
resistors
# voltage.
#    label in1 "Vtt"
#    label in8 "VCore2"

     compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
     compute in4 ((28/10)+1)*@  ,  @/((28/10)+1)
     compute in5 (5.14 * @) - 14.91  ,  (@ + 14.91) / 5.14
     compute in6 (3.14 * @) -  7.71  ,  (@ +  7.71) / 3.14
     compute in7 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)

# adjust this if your vid is wrong; see doc/vid



todd
SENIOR SOFTWARE ENGINEER

todd nine | spidertracks ltd |  117a the square
po box 5203 | palmerston north 4441 | new zealand
P: +64 6 353 3395 | M: +64 21
E: todd@spidertracks.co.nz W: www.spidertracks.com


--Apple-Mail-5--256170962
Content-Type: text/html;
	charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<html><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space; ">Hi all,<div>&nbsp;&nbsp;I'm =
attempting to install lm_sensors in to CentOs 5.3 x86_64 on a Super =
Micro</div><div><br></div><div><a =
href=3D"http://www.supermicro.com/products/motherboard/Xeon1333/5400/X7DWN=
+.cfm">http://www.supermicro.com/products/motherboard/Xeon1333/5400/X7DWN+=
.cfm</a></div><div><br></div><div>I've tried both the latest source 3.1, =
as well as the rpm from yum which is&nbsp;v 2.10.7 with libsensors v =
2.10.7. &nbsp;I'd prefer to use the RPM version that comes from yum if =
possible. &nbsp;Whenever I run the sensors command, I always receive the =
following =
output.</div><div><br></div><div><div>w83627hf-isa-0290</div><div>Adapter:=
 ISA adapter</div><div>VCore 1: &nbsp; +3.36 V &nbsp;(min =3D =
&nbsp;+0.00 V, max =3D &nbsp;+4.08 V) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;</div><div>VCore 2: &nbsp; +3.31 V &nbsp;(min =3D =
&nbsp;+0.00 V, max =3D &nbsp;+4.08 V) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;</div><div>+3.3V: &nbsp; &nbsp; +3.30 V &nbsp;(min =3D =
&nbsp;+2.82 V, max =3D &nbsp;+3.79 V) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;</div><div>+5V: &nbsp; &nbsp; &nbsp; +5.16 V &nbsp;(min =3D =
&nbsp;+0.46 V, max =3D &nbsp;+0.08 V) &nbsp; &nbsp; &nbsp; ALARM =
&nbsp;</div><div>+12V: &nbsp; &nbsp; +11.73 V &nbsp;(min =3D &nbsp;+6.69 =
V, max =3D &nbsp;+7.30 V) &nbsp; &nbsp; &nbsp; ALARM =
&nbsp;</div><div>-12V: &nbsp; &nbsp; &nbsp;+0.96 V &nbsp;(min =3D -14.50 =
V, max =3D -10.63 V) &nbsp; &nbsp; &nbsp; ALARM &nbsp;</div><div>-5V: =
&nbsp; &nbsp; &nbsp; +1.99 V &nbsp;(min =3D &nbsp;-5.20 V, max =3D =
&nbsp;+1.99 V) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;</div><div>V5SB: &nbsp; &nbsp; &nbsp;+5.64 V &nbsp;(min =3D =
&nbsp;+5.16 V, max =3D &nbsp;+5.00 V) &nbsp; &nbsp; &nbsp; ALARM =
&nbsp;</div><div>VBat: &nbsp; &nbsp; &nbsp;+0.00 V &nbsp;(min =3D =
&nbsp;+0.35 V, max =3D &nbsp;+0.16 V) &nbsp; &nbsp; &nbsp; ALARM =
&nbsp;</div><div>fan1: &nbsp; &nbsp; &nbsp; &nbsp;0 RPM &nbsp;(min =3D =
5273 RPM, div =3D 128) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;ALARM &nbsp;</div><div>fan2: &nbsp; &nbsp; &nbsp; &nbsp;0 RPM =
&nbsp;(min =3D 6250 RPM, div =3D 2) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;ALARM &nbsp;</div><div>fan3: &nbsp; &nbsp; &nbsp; &nbsp;0 =
RPM &nbsp;(min =3D 5672 RPM, div =3D 2) &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp;ALARM &nbsp;</div><div>temp1: &nbsp; &nbsp; &nbsp; =
-30=B0C &nbsp;(high =3D &nbsp; +33=B0C, hyst =3D &nbsp; &nbsp;+8=B0C) =
&nbsp; sensor =3D thermistor &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;&nbsp;</div><div>temp2: &nbsp; &nbsp; -34.0=B0C &nbsp;(high =3D =
&nbsp; +80=B0C, hyst =3D &nbsp; +75=B0C) &nbsp; sensor =3D thermistor =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</div><div>temp3: &nbsp; &nbsp; =
-34.0=B0C &nbsp;(high =3D &nbsp; +80=B0C, hyst =3D &nbsp; +75=B0C) =
&nbsp; sensor =3D thermistor &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;&nbsp;</div><div>vid: &nbsp; &nbsp; &nbsp;+0.000 V &nbsp;(VRM =
Version 8.2)</div><div>alarms: =
&nbsp;&nbsp;</div><div>beep_enable:</div><div>&nbsp;&nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;Sound alarm =
enabled</div><div><br></div><div><br></div><div>As you can see none of =
my fans are working. &nbsp;I've read the wiki on fan control and =
divisors, but I don't seem to have any config options. &nbsp;Here is the =
config I have in&nbsp;etc/sensors.conf for my board. &nbsp;I know that =
my fans must report data, as windows detects the rpms and I have 4 pins =
on my fan connectors. &nbsp;I'm also able to detect my temperature and =
fan speed in BIOS. &nbsp;I'm sure it's a simple config I've missed, but =
I'm new to lm-sensors so any help would be =
appreciated.</div><div><br></div><div>Thanks,</div><div>Todd</div><div><br=
></div><div><div>chip "w83782d-*" =
"w83627hf-*"</div><div><br></div><div># Same as above for w83781d except =
that in5 and in6 are computed differently.</div><div># Rather than an =
internal inverting op amp, the 82d/83s use standard positive</div><div># =
inputs and the negative voltages are level shifted by a 3.6V =
reference.</div><div># The math is convoluted, so we hope that your =
motherboard</div><div># uses the recommended resistor =
values.</div><div><br></div><div>&nbsp;&nbsp; &nbsp;label in0 "VCore =
1"</div><div>&nbsp;&nbsp; &nbsp;label in1 "VCore =
2"</div><div>&nbsp;&nbsp; &nbsp;label in2 "+3.3V"</div><div>&nbsp;&nbsp; =
&nbsp;label in3 "+5V"</div><div>&nbsp;&nbsp; &nbsp;label in4 =
"+12V"</div><div>&nbsp;&nbsp; &nbsp;label in5 =
"-12V"</div><div>&nbsp;&nbsp; &nbsp;label in6 =
"-5V"</div><div>&nbsp;&nbsp; &nbsp;label in7 =
"V5SB"</div><div>&nbsp;&nbsp; &nbsp;label in8 =
"VBat"</div><div><br></div><div># Abit BP6 motherboard has a few =
differences. VCore1 and VCore2 are the core</div><div># voltages of the =
two processors. Vtt is memory bus termination resistors</div><div># =
voltage.</div><div># &nbsp; &nbsp;label in1 "Vtt"</div><div># &nbsp; =
&nbsp;label in8 "VCore2"</div><div><br></div><div>&nbsp;&nbsp; =
&nbsp;compute in3 ((6.8/10)+1)*@ , =
&nbsp;@/((6.8/10)+1)</div><div>&nbsp;&nbsp; &nbsp;compute in4 =
((28/10)+1)*@ &nbsp;, &nbsp;@/((28/10)+1)</div><div>&nbsp;&nbsp; =
&nbsp;compute in5 (5.14 * @) - 14.91 &nbsp;, &nbsp;(@ + 14.91) / =
5.14</div><div>&nbsp;&nbsp; &nbsp;compute in6 (3.14 * @) - &nbsp;7.71 =
&nbsp;, &nbsp;(@ + &nbsp;7.71) / 3.14</div><div>&nbsp;&nbsp; =
&nbsp;compute in7 ((6.8/10)+1)*@ , =
&nbsp;@/((6.8/10)+1)</div><div><br></div><div># adjust this if your vid =
is wrong; see =
doc/vid</div><div><br></div></div><div><br></div></div><div><br><div =
apple-content-edited=3D"true"> <span class=3D"Apple-style-span" =
style=3D"border-collapse: separate; color: rgb(0, 0, 0); font-family: =
'Lucida Grande'; font-size: 11px; font-style: normal; font-variant: =
normal; font-weight: normal; letter-spacing: normal; line-height: =
normal; orphans: 2; text-align: auto; text-indent: 0px; text-transform: =
none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-border-horizontal-spacing: 0px; -webkit-border-vertical-spacing: =
0px; -webkit-text-decorations-in-effect: none; -webkit-text-size-adjust: =
auto; -webkit-text-stroke-width: 0; "><div style=3D"word-wrap: =
break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space; "><span class=3D"Apple-style-span" =
style=3D"border-collapse: separate; color: rgb(0, 0, 0); font-family: =
'Lucida Grande'; font-size: 11px; font-style: normal; font-variant: =
normal; font-weight: normal; letter-spacing: normal; line-height: =
normal; orphans: 2; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-border-horizontal-spacing: =
0px; -webkit-border-vertical-spacing: 0px; =
-webkit-text-decorations-in-effect: none; -webkit-text-size-adjust: =
auto; -webkit-text-stroke-width: 0px; "><div style=3D"word-wrap: =
break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space; "><span class=3D"Apple-style-span" =
style=3D"border-collapse: separate; color: rgb(0, 0, 0); font-family: =
'Lucida Grande'; font-size: 11px; font-style: normal; font-variant: =
normal; font-weight: normal; letter-spacing: normal; line-height: =
normal; orphans: 2; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-border-horizontal-spacing: =
0px; -webkit-border-vertical-spacing: 0px; =
-webkit-text-decorations-in-effect: none; -webkit-text-size-adjust: =
auto; -webkit-text-stroke-width: 0px; "><div style=3D"word-wrap: =
break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space; "><span class=3D"Apple-style-span" =
style=3D"border-collapse: separate; color: rgb(0, 0, 0); font-family: =
'Lucida Grande'; font-size: 11px; font-style: normal; font-variant: =
normal; font-weight: normal; letter-spacing: normal; line-height: =
normal; orphans: 2; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-border-horizontal-spacing: =
0px; -webkit-border-vertical-spacing: 0px; =
-webkit-text-decorations-in-effect: none; -webkit-text-size-adjust: =
auto; -webkit-text-stroke-width: 0px; "><div style=3D"word-wrap: =
break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space; "><span class=3D"Apple-style-span" =
style=3D"border-collapse: separate; color: rgb(193, 216, 47); =
font-family: 'Lucida Grande'; font-size: 16px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
line-height: normal; orphans: 2; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-border-horizontal-spacing: 0px; -webkit-border-vertical-spacing: =
0px; -webkit-text-decorations-in-effect: none; -webkit-text-size-adjust: =
auto; -webkit-text-stroke-width: 0px; "><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; font: normal =
normal normal 16px/normal 'Lucida Grande'; color: rgb(193, 216, 47); =
"><span class=3D"Apple-style-span" style=3D"font-family: 'Lucida Sans =
Unicode'; "><font class=3D"Apple-style-span" color=3D"#000000" =
face=3D"'Lucida Grande'" size=3D"3"><span class=3D"Apple-style-span" =
style=3D"font-size: 11px;">todd</span></font></span></div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; font: normal normal normal 16px/normal 'Lucida =
Grande'; color: rgb(193, 216, 47); "><font class=3D"Apple-style-span" =
face=3D"'Lucida Sans Unicode'"><span class=3D"Apple-style-span" =
style=3D"color: rgb(0, 0, 0); font-family: 'Lucida Grande'; font-size: =
11px; "><div style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space; "><div =
apple-content-edited=3D"true"><div style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space; "><span =
class=3D"Apple-style-span" style=3D"color: rgb(193, 216, 47); font-size: =
16px; "><div style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: =
0px; margin-left: 0px; font: normal normal normal 16px/normal 'Lucida =
Grande'; color: rgb(193, 216, 47); "><font class=3D"Apple-style-span" =
color=3D"#808080" face=3D"'Lucida Sans Unicode'" size=3D"2"><span =
class=3D"Apple-style-span" style=3D"font-size: 10px; ">SENIOR SOFTWARE =
ENGINEER</span></font></div><div style=3D"margin-top: 0px; margin-right: =
0px; margin-bottom: 0px; margin-left: 0px; font: normal normal normal =
12px/normal 'Lucida Grande'; min-height: 15px; "><font =
class=3D"Apple-style-span" face=3D"'Lucida Sans =
Unicode'"><br></font></div><div style=3D"margin-top: 0px; margin-right: =
0px; margin-bottom: 0px; margin-left: 0px; font: normal normal normal =
12px/normal 'Lucida Grande'; min-height: 15px; "><span =
class=3D"Apple-style-span" style=3D"color: rgb(128, 128, 128); "><span =
style=3D"color: rgb(0, 0, 0); "><font class=3D"Apple-style-span" =
face=3D"'Lucida Sans Unicode'">todd nine&nbsp;</font></span><font =
class=3D"Apple-style-span" face=3D"'Lucida Sans Unicode'">| spidertracks =
ltd |&nbsp;&nbsp;117a the square</font></span></div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; font: normal normal normal 12px/normal 'Lucida =
Grande'; color: rgb(128, 128, 128); "><font class=3D"Apple-style-span" =
face=3D"'Lucida Sans Unicode'">po box 5203 | palmerston north 4441 | new =
zealand</font></div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; font: normal normal normal =
12px/normal 'Lucida Grande'; color: rgb(128, 128, 128); "><span =
style=3D"font: normal normal normal 9px/normal 'Lucida Grande'; "><font =
class=3D"Apple-style-span" face=3D"'Lucida Sans =
Unicode'">P</font></span><font class=3D"Apple-style-span" face=3D"'Lucida =
Sans Unicode'">: +64 6 353 3395 |</font><font class=3D"Apple-style-span" =
face=3D"'Lucida Sans Unicode'">&nbsp;</font><span style=3D"font: normal =
normal normal 9px/normal 'Lucida Grande'; "><font =
class=3D"Apple-style-span" face=3D"'Lucida Sans =
Unicode'">M</font></span><font class=3D"Apple-style-span" face=3D"'Lucida =
Sans Unicode'">: +64 21&nbsp;</font></div><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; font: normal =
normal normal 12px/normal 'Lucida Grande'; color: rgb(128, 128, 128); =
"><span style=3D"font: normal normal normal 9px/normal 'Lucida Grande'; =
"><font class=3D"Apple-style-span" face=3D"'Lucida Sans =
Unicode'">E</font></span><font class=3D"Apple-style-span" face=3D"'Lucida =
Sans Unicode'">:&nbsp;<font class=3D"Apple-style-span" color=3D"#C1D82F" =
size=3D"4"><font class=3D"Apple-style-span" face=3D"'Lucida Grande'" =
size=3D"3"><span class=3D"Apple-style-span" style=3D"font-size: 12px; =
"><a =
href=3D"mailto:todd@spidertracks.co.nz">todd@spidertracks.co.nz</a></span>=
</font><span class=3D"Apple-style-span" style=3D"font-size: 16px; =
">&nbsp;<span class=3D"Apple-style-span" style=3D"color: rgb(128, 128, =
128); font-family: 'Lucida Grande'; font-size: 12px; "><span =
style=3D"font: normal normal normal 9px/normal 'Lucida Grande'; "><font =
class=3D"Apple-style-span" face=3D"'Lucida Sans =
Unicode'">W</font></span><font class=3D"Apple-style-span" face=3D"'Lucida =
Sans Unicode'">:&nbsp;<span class=3D"Apple-style-span" style=3D"color: =
rgb(193, 216, 47); "><font class=3D"Apple-style-span" face=3D"'Lucida =
Grande'"><a =
href=3D"http://www.spidertracks.com">www.spidertracks.com</a></font></span=
></font></span></span></font></font></div></span></div></div></div></span>=
</font></div></span></div></span></div></span></div></span></div></span> =
</div><br></div></body></html>=

--Apple-Mail-5--256170962--


--===============6579521677043737414==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6579521677043737414==--
