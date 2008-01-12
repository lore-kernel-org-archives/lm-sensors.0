From: "Andrew Voznytsa" <andrew.voznytsa@gmail.com>
Date: Sat, 12 Jan 2008 22:28:08 +0000
Subject: [lm-sensors] lm85 in Intel S3000AH case
Message-Id: <00d601c8556a$69d1ca70$0204a8c0@IT>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4588238267069576364=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

--===============4588238267069576364==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_00D7_01C8557B.2D5A9A70"

This is a multi-part message in MIME format.

------=_NextPart_000_00D7_01C8557B.2D5A9A70
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi guys,

 

Just installed lm-sensors (2.10.4 and 3.0.0) on S3000AH-based system (Linux
version 2.6.23-gentoo-r3 (root@farm) (gcc version 4.1.2 (Gentoo 4.1.2 p1.0

.2)), x86_64) - works fine except lm-sensors does not show fans 5 and 6. Is
it fixable? (I'd leave my chassis fan connected to 5th socket and do not
reconnect it to 2-4)

 

Here is part of sensors-detect output

 

  Detects correctly:

  * Bus `SMBus I801 adapter at 3000'

    Busdriver `i2c-i801', I2C address 0x2e

    Chip `SMSC EMC6D100, EMC6D101 or EMC6D102' (confidence: 7)

 

And sensors output:

 

lm85-i2c-0-2e

Adapter: SMBus I801 adapter at 3000

V1.5:        +2.29 V  (min =  +0.00 V, max =  +3.32 V)

VCore:       +1.14 V  (min =  +0.00 V, max =  +2.99 V)

V3.3:        +3.35 V  (min =  +0.00 V, max =  +4.38 V)

V5:          +1.51 V  (min =  +0.00 V, max =  +6.64 V)

V12:        +12.81 V  (min =  +0.00 V, max = +15.94 V)

CPU_Fan:    1769 RPM  (min =  720 RPM)

fan2:          0 RPM  (min =  720 RPM)

fan3:          0 RPM  (min =  720 RPM)

fan4:          0 RPM  (min =  720 RPM)

CPU Temp:    -63.0 C  (low  = -127.0 C, high = +127.0 C)

Board Temp:  +39.0 C  (low  = -127.0 C, high = +127.0 C)

DIMM Temp:   +29.0 C  (low  = -127.0 C, high = +127.0 C)

cpu0_vid:   +0.000 V

Best regards,
Andrew Voznytsa

 


------=_NextPart_000_00D7_01C8557B.2D5A9A70
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
p
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:12.0pt;
	font-family:"Times New Roman";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hi guys,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Just installed lm-sensors (2.10.4 and 3.0.0) on =
S3000AH-based
system (Linux version 2.6.23-gentoo-r3 (root@farm) (gcc version 4.1.2 =
(Gentoo
4.1.2 p1.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>.2)), x86_64) &#8211; works fine except lm-sensors =
does not
show fans 5 and 6. Is it fixable? (I&#8217;d leave my chassis fan =
connected to 5<sup>th</sup>
socket and do not reconnect it to 2-4)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Here is part of sensors-detect =
output<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp; Detects =
correctly:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp; * Bus `SMBus I801 adapter at =
3000'<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp; Busdriver `i2c-i801', I2C address =
0x2e<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp; Chip `SMSC EMC6D100, EMC6D101 or
EMC6D102' (confidence: 7)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>And sensors output:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>lm85-i2c-0-2e<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Adapter: SMBus I801 adapter at =
3000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>V1.5:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +2.29
V&nbsp; (min =3D&nbsp; +0.00 V, max =3D&nbsp; +3.32 =
V)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>VCore:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +1.14 =
V&nbsp;
(min =3D&nbsp; +0.00 V, max =3D&nbsp; +2.99 =
V)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>V3.3:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +3.35
V&nbsp; (min =3D&nbsp; +0.00 V, max =3D&nbsp; +4.38 =
V)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>V5:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;
+1.51 V&nbsp; (min =3D&nbsp; +0.00 V, max =3D&nbsp; +6.64 =
V)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>V12:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +12.81
V&nbsp; (min =3D&nbsp; +0.00 V, max =3D +15.94 =
V)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>CPU_Fan:&nbsp;&nbsp;&nbsp; 1769 RPM&nbsp; (min =
=3D&nbsp; 720
RPM)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>fan2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;
0 RPM&nbsp; (min =3D&nbsp; 720 RPM)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>fan3:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;
0 RPM&nbsp; (min =3D&nbsp; 720 RPM)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>fan4:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;
0 RPM&nbsp; (min =3D&nbsp; 720 RPM)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>CPU Temp:&nbsp;&nbsp;&nbsp; -63.0 C&nbsp; (low&nbsp; =
=3D
-127.0 C, high =3D +127.0 C)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Board Temp:&nbsp; +39.0 C&nbsp; (low&nbsp; =3D -127.0 =
C, high
=3D +127.0 C)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>DIMM Temp:&nbsp;&nbsp; +29.0 C&nbsp; (low&nbsp; =3D =
-127.0 C,
high =3D +127.0 C)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>cpu0_vid:&nbsp;&nbsp; +0.000 =
V<o:p></o:p></span></font></p>

<p><font size=3D2 face=3D"Times New Roman"><span =
style=3D'font-size:10.0pt'>Best
regards,<br>
Andrew Voznytsa</span></font><o:p></o:p></p>

<p><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_00D7_01C8557B.2D5A9A70--



--===============4588238267069576364==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4588238267069576364==--

