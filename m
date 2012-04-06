From: "Justin Piszcz" <jpiszcz@lucidpixels.com>
Date: Fri, 06 Apr 2012 20:08:12 +0000
Subject: [lm-sensors] Supermicro X7SPA-HF: in4 ALARM
Message-Id: <01fa01cd1430$fed0b990$fc722cb0$@lucidpixels.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4411141417684173628=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multipart message in MIME format.

--===============4411141417684173628==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_01FB_01CD140F.77BF67B0"
Content-language: en-us

This is a multipart message in MIME format.

------=_NextPart_000_01FB_01CD140F.77BF67B0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

Was curious why the max voltage does not show up properly for in4 =
(VDIMM)
for this X7SPA-HF using lm sensors 3.3.1 or 3.3.2?

On the sensor reading page for IPMI:
VDIMM	Normal	1.84 Volts

This is with lm_sensors:

--

$ sensors
w83627dhg-isa-0ca0
Adapter: ISA adapter
Vcore:        +1.16 V  (min =3D  +0.72 V, max =3D  +1.39 V)
Vnbcore:      +1.04 V  (min =3D  +0.94 V, max =3D  +1.16 V)
AVCC:         +3.34 V  (min =3D  +2.98 V, max =3D  +3.63 V)
+3.3V:        +3.34 V  (min =3D  +2.98 V, max =3D  +3.63 V)
VDIMM:        +1.84 V  (min =3D  +1.62 V, max =3D  +0.00 V)  ALARM
+5V:          +1.25 V  (min =3D  +1.13 V, max =3D  +1.38 V)
+12V:         +0.75 V  (min =3D  +0.67 V, max =3D  +0.83 V)
3VSB:         +3.30 V  (min =3D  +2.98 V, max =3D  +3.63 V)
Vbat:         +3.06 V  (min =3D  +2.70 V, max =3D  +3.30 V)
SYS Temp:     +42.0=B0C  (high =3D +75.0=B0C, hyst =3D +70.0=B0C)  =
sensor =3D thermistor
CPU Temp:     +40.5=B0C  (high =3D +90.0=B0C, hyst =3D +87.0=B0C)  =
sensor =3D diode
Case Temp:    +24.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  =
sensor =3D diode
$ sensors --version
sensors version 3.3.1 with libsensors version 3.3.1

lm_sensors-3.3.2$ prog/sensors/sensors --version
sensors version 3.3.2 with libsensors version 3.3.1

w83627dhg-isa-0ca0
Adapter: ISA adapter
Vcore:        +1.16 V  (min =3D  +0.72 V, max =3D  +1.39 V)
Vnbcore:      +1.04 V  (min =3D  +0.94 V, max =3D  +1.16 V)
AVCC:         +3.34 V  (min =3D  +2.98 V, max =3D  +3.63 V)
+3.3V:        +3.34 V  (min =3D  +2.98 V, max =3D  +3.63 V)
VDIMM:        +1.84 V  (min =3D  +1.62 V, max =3D  +0.00 V)  ALARM
+5V:          +1.25 V  (min =3D  +1.13 V, max =3D  +1.38 V)
+12V:         +0.75 V  (min =3D  +0.67 V, max =3D  +0.83 V)
3VSB:         +3.30 V  (min =3D  +2.98 V, max =3D  +3.63 V)
Vbat:         +3.06 V  (min =3D  +2.70 V, max =3D  +3.30 V)
SYS Temp:     +42.0=B0C  (high =3D +75.0=B0C, hyst =3D +70.0=B0C)  =
sensor =3D thermistor
CPU Temp:     +40.5=B0C  (high =3D +90.0=B0C, hyst =3D +87.0=B0C)  =
sensor =3D CPU diode
Case Temp:    +24.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  =
sensor =3D CPU diode

--

I also tried hardcoding in4_{min,max}:

$ cat /etc/sensors3.conf

chip "w83627ehf-*" "w83627dhg-*" "w83667hg-*" "nct6775-*" "nct6776-*"

    label in0 "Vcore"
    label in1 "Vnbcore"
    label in2 "AVCC"
    label in3 "+3.3V"
    label in4 "VDIMM"
    label in5 "+5V"
    label in6 "+12V"
    label in7 "3VSB"
    label in8 "Vbat"
    label temp1 "SYS Temp"
    label temp2 "CPU Temp"
    label temp3 "Case Temp"

    set in2_min  3.3 * 0.90
    set in2_max  3.3 * 1.10
    set in3_min  3.3 * 0.90
    set in3_max  3.3 * 1.10
# =
http://lists.lm-sensors.org/pipermail/lm-sensors/2010-November/030368.htm=
l
    set in4_min  1.62
    set in4_max  1.98
    set in7_min  3.3 * 0.90
    set in7_max  3.3 * 1.10
    set in8_min  3.0 * 0.90
    set in8_max  3.0 * 1.10

    ignore fan1
    ignore fan2
    ignore fan3
    ignore fan4
    ignore fan5
    ignore cpu0_vid
    ignore intrusion0

Justin.

------=_NextPart_000_01FB_01CD140F.77BF67B0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
14.02.5004.000">
<TITLE>Supermicro X7SPA-HF: in4 ALARM</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">Hello,</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Calibri">Was curious =
why</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Calibri">the</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Calibri">max</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri"> voltage</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri"> does not show up properly</FONT></SPAN><SPAN =
LANG=3D"en-us"> <FONT FACE=3D"Calibri">for in4 =
(VDIMM)</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT FACE=3D"Calibri">for =
this</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Calibri">X7SPA-HF</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri"></FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Calibri">using lm sensors 3.3.1 or 3.3.2?</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Calibri">On the sensor =
reading page for IPMI:</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">VDIMM&nbsp;&nbsp; Normal&nbsp; 1.84 =
Volts</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Calibri">This is with =
lm_sensors:</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">--</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Calibri">$ =
sensors</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">w83627dhg-isa-0ca0</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Calibri">Adapter: ISA =
adapter</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">Vcore:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +1.16 =
V&nbsp; (min =3D&nbsp; +0.72 V, max =3D&nbsp; +1.39 V)</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">Vnbcore:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +1.04 V&nbsp; =
(min =3D&nbsp; +0.94 V, max =3D&nbsp; +1.16 V)</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">AVCC:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
+3.34 V&nbsp; (min =3D&nbsp; +2.98 V, max =3D&nbsp; +3.63 =
V)</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">+3.3V:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +3.34 =
V&nbsp; (min =3D&nbsp; +2.98 V, max =3D&nbsp; +3.63 V)</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">VDIMM:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +1.84 =
V&nbsp; (min =3D&nbsp; +1.62 V, max =3D&nbsp; +0.00 V)&nbsp; =
ALARM</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">+5V:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; +1.25 V&nbsp; (min =3D&nbsp; +1.13 V, max =3D&nbsp; +1.38 =
V)</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">+12V:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
+0.75 V&nbsp; (min =3D&nbsp; +0.67 V, max =3D&nbsp; +0.83 =
V)</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">3VSB:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
+3.30 V&nbsp; (min =3D&nbsp; +2.98 V, max =3D&nbsp; +3.63 =
V)</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">Vbat:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
+3.06 V&nbsp; (min =3D&nbsp; +2.70 V, max =3D&nbsp; +3.30 =
V)</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Calibri">SYS =
Temp:&nbsp;&nbsp;&nbsp;&nbsp; +42.0=B0C&nbsp; (high =3D +75.0=B0C, hyst =
=3D +70.0=B0C)&nbsp; sensor =3D thermistor</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Calibri">CPU =
Temp:&nbsp;&nbsp;&nbsp;&nbsp; +40.5=B0C&nbsp; (high =3D +90.0=B0C, hyst =
=3D +87.0=B0C)&nbsp; sensor =3D diode</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Calibri">Case =
Temp:&nbsp;&nbsp;&nbsp; +24.0=B0C&nbsp; (high =3D +80.0=B0C, hyst =3D =
+75.0=B0C)&nbsp; sensor =3D diode</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Calibri">$ sensors =
--version</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Calibri">sensors version =
3.3.1 with libsensors version 3.3.1</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">lm_sensors-3.3.2$ prog/sensors/sensors =
--version</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Calibri">sensors version =
3.3.2 with libsensors version 3.3.1</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">w83627dhg-isa-0ca0</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Calibri">Adapter: ISA =
adapter</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">Vcore:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +1.16 =
V&nbsp; (min =3D&nbsp; +0.72 V, max =3D&nbsp; +1.39 V)</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">Vnbcore:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +1.04 V&nbsp; =
(min =3D&nbsp; +0.94 V, max =3D&nbsp; +1.16 V)</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">AVCC:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
+3.34 V&nbsp; (min =3D&nbsp; +2.98 V, max =3D&nbsp; +3.63 =
V)</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">+3.3V:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +3.34 =
V&nbsp; (min =3D&nbsp; +2.98 V, max =3D&nbsp; +3.63 V)</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">VDIMM:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +1.84 =
V&nbsp; (min =3D&nbsp; +1.62 V, max =3D&nbsp; +0.00 V)&nbsp; =
ALARM</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">+5V:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; +1.25 V&nbsp; (min =3D&nbsp; +1.13 V, max =3D&nbsp; +1.38 =
V)</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">+12V:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
+0.75 V&nbsp; (min =3D&nbsp; +0.67 V, max =3D&nbsp; +0.83 =
V)</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">3VSB:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
+3.30 V&nbsp; (min =3D&nbsp; +2.98 V, max =3D&nbsp; +3.63 =
V)</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">Vbat:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
+3.06 V&nbsp; (min =3D&nbsp; +2.70 V, max =3D&nbsp; +3.30 =
V)</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Calibri">SYS =
Temp:&nbsp;&nbsp;&nbsp;&nbsp; +42.0=B0C&nbsp; (high =3D +75.0=B0C, hyst =
=3D +70.0=B0C)&nbsp; sensor =3D thermistor</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Calibri">CPU =
Temp:&nbsp;&nbsp;&nbsp;&nbsp; +40.5=B0C&nbsp; (high =3D +90.0=B0C, hyst =
=3D +87.0=B0C)&nbsp; sensor =3D CPU diode</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Calibri">Case =
Temp:&nbsp;&nbsp;&nbsp; +24.5=B0C&nbsp; (high =3D +80.0=B0C, hyst =3D =
+75.0=B0C)&nbsp; sensor =3D CPU diode</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">--</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Calibri">I also tried =
hardcoding in4_{min,max}:</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">$</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Calibri">cat /etc/sensors3.conf</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Calibri">chip =
&quot;w83627ehf-*&quot; &quot;w83627dhg-*&quot; &quot;w83667hg-*&quot; =
&quot;nct6775-*&quot; &quot;nct6776-*&quot;</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">&nbsp;&nbsp;&nbsp; label in0 =
&quot;Vcore&quot;</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">&nbsp;&nbsp;&nbsp; label in1 =
&quot;Vnbcore&quot;</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">&nbsp;&nbsp;&nbsp; label in2 =
&quot;AVCC&quot;</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">&nbsp;&nbsp;&nbsp; label in3 =
&quot;+3.3V&quot;</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">&nbsp;&nbsp;&nbsp; label in4 =
&quot;VDIMM&quot;</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">&nbsp;&nbsp;&nbsp; label in5 =
&quot;+5V&quot;</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">&nbsp;&nbsp;&nbsp; label in6 =
&quot;+12V&quot;</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">&nbsp;&nbsp;&nbsp; label in7 =
&quot;3VSB&quot;</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">&nbsp;&nbsp;&nbsp; label in8 =
&quot;Vbat&quot;</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">&nbsp;&nbsp;&nbsp; label temp1 &quot;SYS =
Temp&quot;</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">&nbsp;&nbsp;&nbsp; label temp2 &quot;CPU =
Temp&quot;</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">&nbsp;&nbsp;&nbsp; label temp3 &quot;Case =
Temp&quot;</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">&nbsp;&nbsp;&nbsp; set in2_min&nbsp; 3.3 * =
0.90</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">&nbsp;&nbsp;&nbsp; set in2_max&nbsp; 3.3 * =
1.10</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">&nbsp;&nbsp;&nbsp; set in3_min&nbsp; 3.3 * =
0.90</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">&nbsp;&nbsp;&nbsp; set in3_max&nbsp; 3.3 * =
1.10</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Calibri"># <A =
HREF=3D"http://lists.lm-sensors.org/pipermail/lm-sensors/2010-November/03=
0368.html">http://lists.lm-sensors.org/pipermail/lm-sensors/2010-November=
/030368.html</A></FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">&nbsp;&nbsp;&nbsp; set in4_min&nbsp; =
1.62</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">&nbsp;&nbsp;&nbsp; set in4_max&nbsp; =
1.98</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">&nbsp;&nbsp;&nbsp; set in7_min&nbsp; 3.3 * =
0.90</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">&nbsp;&nbsp;&nbsp; set in7_max&nbsp; 3.3 * =
1.10</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">&nbsp;&nbsp;&nbsp; set in8_min&nbsp; 3.0 * =
0.90</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">&nbsp;&nbsp;&nbsp; set in8_max&nbsp; 3.0 * =
1.10</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">&nbsp;&nbsp;&nbsp; ignore fan1</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">&nbsp;&nbsp;&nbsp; ignore fan2</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">&nbsp;&nbsp;&nbsp; ignore fan3</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">&nbsp;&nbsp;&nbsp; ignore fan4</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">&nbsp;&nbsp;&nbsp; ignore fan5</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">&nbsp;&nbsp;&nbsp; ignore cpu0_vid</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">&nbsp;&nbsp;&nbsp; ignore intrusion0</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">Justin.</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

</BODY>
</HTML>
------=_NextPart_000_01FB_01CD140F.77BF67B0--



--===============4411141417684173628==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4411141417684173628==--

