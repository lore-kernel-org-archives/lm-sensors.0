From: "Andrew Voznytsa" <andrew.voznytsa@gmail.com>
Date: Mon, 14 Jan 2008 14:47:48 +0000
Subject: [lm-sensors] SMSC Super I/O: unknown chip with ID 0x8902 (was: lm85
Message-Id: <004e01c856bc$6f975c10$0204a8c0@IT>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0537592981242268593=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

--===============0537592981242268593==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_004F_01C856CD.33202C10"

This is a multi-part message in MIME format.

------=_NextPart_000_004F_01C856CD.33202C10
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

More information on topic:

 

I found http://www.lm-sensors.org/ticket/2195 which is related to my problem
- looked over sensors-detect output and found

 

Some Super I/O chips may also contain sensors. We have to write to

standard I/O ports to probe them. This is usually safe.

Do you want to scan for Super I/O sensors? (YES/no):

Probing for Super-I/O at 0x2e/0x2f

Trying family `National Semiconductor'...                   No

Trying family `SMSC'...                                     Yes

Found unknown chip with ID 0x8902

Probing for Super-I/O at 0x4e/0x4f

Trying family `National Semiconductor'...                   No

Trying family `SMSC'...                                     No

Trying family `VIA/Winbond/Fintek'...                       No

Trying family `ITE'...                                      No

 

So is not this unknown chip with ID 0x8902 what is missing to support fans
5/6/etc?  If yes - could someone drop some light on topic when to expect it
supported?

Thanks,
Andrew Voznytsa

 

  _____  

From: Andrew Voznytsa [mailto:andrew.voznytsa@gmail.com] 
Sent: Sunday, January 13, 2008 12:28 AM
To: 'lm-sensors@lm-sensors.org'
Subject: lm85 in Intel S3000AH case

 

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

 


------=_NextPart_000_004F_01C856CD.33202C10
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><o:SmartTagType
 namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags" =
name=3D"PersonName"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
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
span.EmailStyle18
	{mso-style-type:personal;
	font-family:Arial;
	color:windowtext;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
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

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>More information on =
topic:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>I found <a
href=3D"http://www.lm-sensors.org/ticket/2195">http://www.lm-sensors.org/=
ticket/2195</a>
which is related to my problem &#8211; looked over sensors-detect output =
and
found<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Some Super I/O chips may also =
contain
sensors. We have to write to<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>standard I/O ports to probe them. =
This is
usually safe.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Do you want to scan for Super I/O =
sensors?
(YES/no):<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Probing for Super-I/O at =
0x2e/0x2f<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Trying family `National
Semiconductor'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
No<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Trying family
`SMSC'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;
Yes<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Found unknown chip with ID =
0x8902<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Probing for Super-I/O at =
0x4e/0x4f<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Trying family `National
Semiconductor'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
No<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Trying family
`SMSC'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;
No<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Trying family
`VIA/Winbond/Fintek'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;
No<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Trying family
`ITE'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;
No<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>So is not this unknown chip with ID =
0x8902
what is missing to support fans 5/6/etc? &nbsp;If yes &#8211; could =
someone
drop some light on topic when to expect it =
supported?<o:p></o:p></span></font></p>

<div>

<p><font size=3D2 color=3Dnavy face=3D"Times New Roman"><span =
style=3D'font-size:10.0pt;
color:navy'>Thanks,<br>
Andrew Voznytsa</span></font><font color=3Dnavy><span =
style=3D'color:navy'><o:p></o:p></span></font></p>

<p><font size=3D2 color=3Dnavy face=3D"Times New Roman"><span =
style=3D'font-size:10.0pt;
color:navy'>&nbsp;</span></font><font size=3D2><span =
style=3D'font-size:10.0pt'><o:p></o:p></span></font></p>

</div>

<div style=3D'border:none;border-left:solid blue 1.5pt;padding:0cm 0cm =
0cm 4.0pt'>

<div>

<div class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><font =
size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>

<hr size=3D2 width=3D"100%" align=3Dcenter tabindex=3D-1>

</span></font></div>

<p class=3DMsoNormal><b><font size=3D2 face=3DTahoma><span =
style=3D'font-size:10.0pt;
font-family:Tahoma;font-weight:bold'>From:</span></font></b><font =
size=3D2
face=3DTahoma><span style=3D'font-size:10.0pt;font-family:Tahoma'> =
Andrew Voznytsa
[mailto:andrew.voznytsa@gmail.com] <br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> Sunday, January 13, =
2008
12:28 AM<br>
<b><span style=3D'font-weight:bold'>To:</span></b> '<st1:PersonName =
w:st=3D"on">lm-sensors@lm-sensors.org</st1:PersonName>'<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> lm85 in Intel =
S3000AH
case</span></font><o:p></o:p></p>

</div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hi guys,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Just installed lm-sensors (2.10.4 and 3.0.0) on
S3000AH-based system (Linux version 2.6.23-gentoo-r3 (root@farm) (gcc =
version
4.1.2 (Gentoo 4.1.2 p1.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>.2)), x86_64) &#8211; works fine except lm-sensors =
does not
show fans 5 and 6. Is it fixable? (I&#8217;d leave my chassis fan =
connected to
5<sup>th</sup> socket and do not reconnect it to =
2-4)<o:p></o:p></span></font></p>

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

</div>

</body>

</html>

------=_NextPart_000_004F_01C856CD.33202C10--



--===============0537592981242268593==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0537592981242268593==--

