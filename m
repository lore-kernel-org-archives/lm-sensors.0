From: <Wsong@nuvoton.com>
Date: Tue, 03 Mar 2009 08:20:15 +0000
Subject: [lm-sensors] NEW Nuvoton w83795 hw chip driver
Message-Id: <29CFBC9A3FDC81418F5FACEEC8970E003069F4@ntshml01.nuvoton.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C99BD8.D3B5CB8B"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C99BD8.D3B5CB8B
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C99BD8.D3B5CB8B"


------_=_NextPart_002_01C99BD8.D3B5CB8B
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Dear lm-sensor group,

=20

I am glad to submit to you the driver for Nuvoton W83795G/ADG hw monitor =
chip.=20

=20

The W83795G/ADG chip information are show at here:

http://www.nuvoton.com/hq/enu/ProductAndSales/ProductLines/ComputerIC/Har=
dwareMonitor/HWMonitorforDesktopAndServer/

=20

Driver files list:

The attach file "wb83795.c" is the main driver file. This driver passed =
test on kernel 2.6.28.7.

The attach file "Makefile" is used for compile the driver.

=20

Patch files for lm-sensors 3.0.3:

The attach file "795_sensor3.conf" is the 795 related lines for =
sensor3.conf. But the exact names and settings may be changed for the =
motherboards.

The attach file "DESC" is the list of sys files which 795 driver would =
create.

The attach file "sensors-detect.3.0.3.patch" add detect 795 chip for =
"sensor-detect" tool in lm-sensors 3.0.3 package.

=20

=20

Until now, it seems there is not a motherboard based on W83795G/ADG in =
the market, and I am sure not the 795 SPEC could be share to you or not.

=20

Please contact me if you need any help, want to know any information or =
have some other questions.

=20

=20

Thank you.

=20

=20

Best Regards,

wsong



=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
The privileged confidential information contained in this email is =
intended for use only by the addressees as indicated by the original =
sender of this email. If you are not the addressee indicated in this =
email or are not responsible for delivery of the email to such  a =
person, please kindly reply to the sender indicating this fact and =
delete all copies of it from your computer and network server =
immediately. Your cooperation is highly appreciated. It is advised that =
any unauthorized use of confidential information of Nuvoton is strictly =
prohibited; and any information in this email irrelevant to the official =
business of Nuvoton shall be deemed as neither given nor endorsed by =
Nuvoton.

------_=_NextPart_002_01C99BD8.D3B5CB8B
Content-Type: text/html;
	charset="US-ASCII"
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
 /* Font Definitions */
 @font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:SimSun;
	color:windowtext;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
 /* Page Definitions */
 @page Section1
	{size:595.3pt 841.9pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;
	layout-grid:15.6pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DZH-CN link=3Dblue vlink=3Dpurple =
style=3D'text-justify-trim:punctuation'>

<div class=3DSection1 style=3D'layout-grid:15.6pt'>

<p class=3DMsoNormal><font size=3D3 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:12.0pt;font-family:SimSun'>Dear lm-sensor =
group,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:12.0pt;font-family:SimSun'><o:p>&nbsp;</o:p></span></f=
ont></p>

<p class=3DMsoNormal><font size=3D3 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:12.0pt;font-family:SimSun'>I am glad to submit to you =
the
driver for Nuvoton W83795G/ADG hw monitor chip. =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:12.0pt;font-family:SimSun'><o:p>&nbsp;</o:p></span></f=
ont></p>

<p class=3DMsoNormal><font size=3D3 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:12.0pt;font-family:SimSun'>The W83795G/ADG chip =
information
are show at here:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:12.0pt;font-family:SimSun'>http://www.nuvoton.com/hq/e=
nu/ProductAndSales/ProductLines/ComputerIC/HardwareMonitor/HWMonitorforDe=
sktopAndServer/<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:12.0pt;font-family:SimSun'><o:p>&nbsp;</o:p></span></f=
ont></p>

<p class=3DMsoNormal><font size=3D3 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:12.0pt;font-family:SimSun'>Driver files =
list:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:12.0pt;font-family:SimSun'>The attach file =
</span></font><font
size=3D3><span lang=3DEN-US =
style=3D'font-size:12.0pt'>&#8220;</span></font><font
size=3D3 face=3D&#23435;&#20307;><span lang=3DEN-US =
style=3D'font-size:12.0pt;
font-family:SimSun'>wb83795.c</span></font><font size=3D3><span =
lang=3DEN-US
style=3D'font-size:12.0pt'>&#8221;</span></font><font size=3D3 =
face=3D&#23435;&#20307;><span
lang=3DEN-US style=3D'font-size:12.0pt;font-family:SimSun'> is the main =
driver
file. This driver passed test on kernel =
2.6.28.7.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:12.0pt;font-family:SimSun'>The attach file =
</span></font><font
size=3D3><span lang=3DEN-US =
style=3D'font-size:12.0pt'>&#8220;</span></font><font
size=3D3 face=3D&#23435;&#20307;><span lang=3DEN-US =
style=3D'font-size:12.0pt;
font-family:SimSun'>Makefile</span></font><font size=3D3><span =
lang=3DEN-US
style=3D'font-size:12.0pt'>&#8221;</span></font><font size=3D3 =
face=3D&#23435;&#20307;><span
lang=3DEN-US style=3D'font-size:12.0pt;font-family:SimSun'> is used for =
compile the
driver.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:12.0pt;font-family:SimSun'><o:p>&nbsp;</o:p></span></f=
ont></p>

<p class=3DMsoNormal><font size=3D3 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:12.0pt;font-family:SimSun'>Patch files for lm-sensors =
3.0.3:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:12.0pt;font-family:SimSun'>The attach file =
</span></font><font
size=3D3><span lang=3DEN-US =
style=3D'font-size:12.0pt'>&#8220;</span></font><font
size=3D3 face=3D&#23435;&#20307;><span lang=3DEN-US =
style=3D'font-size:12.0pt;
font-family:SimSun'>795_sensor3.conf</span></font><font size=3D3><span
lang=3DEN-US style=3D'font-size:12.0pt'>&#8221;</span></font><font =
size=3D3 face=3D&#23435;&#20307;><span
lang=3DEN-US style=3D'font-size:12.0pt;font-family:SimSun'> is the 795 =
related
lines for sensor3.conf. But the exact names and settings may be changed =
for the
motherboards.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:12.0pt;font-family:SimSun'>The attach file =
</span></font><font
size=3D3><span lang=3DEN-US =
style=3D'font-size:12.0pt'>&#8220;</span></font><font
size=3D3 face=3D&#23435;&#20307;><span lang=3DEN-US =
style=3D'font-size:12.0pt;
font-family:SimSun'>DESC</span></font><font size=3D3><span lang=3DEN-US
style=3D'font-size:12.0pt'>&#8221;</span></font><font size=3D3 =
face=3D&#23435;&#20307;><span
lang=3DEN-US style=3D'font-size:12.0pt;font-family:SimSun'> is the list =
of sys
files which 795 driver would create.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:12.0pt;font-family:SimSun'>The attach file =
</span></font><font
size=3D3><span lang=3DEN-US =
style=3D'font-size:12.0pt'>&#8220;</span></font><font
size=3D3 face=3D&#23435;&#20307;><span lang=3DEN-US =
style=3D'font-size:12.0pt;
font-family:SimSun'>sensors-detect.3.0.3.patch</span></font><font =
size=3D3><span
lang=3DEN-US style=3D'font-size:12.0pt'>&#8221;</span></font><font =
size=3D3 face=3D&#23435;&#20307;><span
lang=3DEN-US style=3D'font-size:12.0pt;font-family:SimSun'> add detect =
795 chip for
</span></font><font size=3D3><span lang=3DEN-US =
style=3D'font-size:12.0pt'>&#8220;</span></font><font
size=3D3 face=3D&#23435;&#20307;><span lang=3DEN-US =
style=3D'font-size:12.0pt;
font-family:SimSun'>sensor-detect</span></font><font size=3D3><span =
lang=3DEN-US
style=3D'font-size:12.0pt'>&#8221;</span></font><font size=3D3 =
face=3D&#23435;&#20307;><span
lang=3DEN-US style=3D'font-size:12.0pt;font-family:SimSun'> tool in =
lm-sensors
3.0.3 package.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:12.0pt;font-family:SimSun'><o:p>&nbsp;</o:p></span></f=
ont></p>

<p class=3DMsoNormal><font size=3D3 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:12.0pt;font-family:SimSun'><o:p>&nbsp;</o:p></span></f=
ont></p>

<p class=3DMsoNormal><font size=3D3 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:12.0pt;font-family:SimSun'>Until now, it seems there =
is not a
motherboard based on W83795G/ADG in the market, and I am sure not the =
795 SPEC
could be share to you or not.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:12.0pt;font-family:SimSun'><o:p>&nbsp;</o:p></span></f=
ont></p>

<p class=3DMsoNormal><font size=3D3 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:12.0pt;font-family:SimSun'>Please contact me if you =
need any
help, want to know any information or have some other =
questions.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:12.0pt;font-family:SimSun'><o:p>&nbsp;</o:p></span></f=
ont></p>

<p class=3DMsoNormal><font size=3D3 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:12.0pt;font-family:SimSun'><o:p>&nbsp;</o:p></span></f=
ont></p>

<p class=3DMsoNormal><font size=3D3 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:12.0pt;font-family:SimSun'>Thank =
you.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:12.0pt;font-family:SimSun'><o:p>&nbsp;</o:p></span></f=
ont></p>

<p class=3DMsoNormal><font size=3D3 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:12.0pt;font-family:SimSun'><o:p>&nbsp;</o:p></span></f=
ont></p>

<p class=3DMsoNormal><font size=3D3 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:12.0pt;font-family:SimSun'>Best =
Regards,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:12.0pt;font-family:SimSun'>wsong<o:p></o:p></span></fo=
nt></p>

</div>

<BR>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<BR>The privileged =
confidential information contained in this email is intended for use =
only by the addressees as indicated by the original sender of this =
email. If you are not the addressee indicated in this email or are not =
responsible for delivery of the email to such  a person, please kindly =
reply to the sender indicating this fact and delete all copies of it =
from your computer and network server immediately. Your cooperation is =
highly appreciated. It is advised that any unauthorized use of =
confidential information of Nuvoton is strictly prohibited; and any =
information in this email irrelevant to the official business of Nuvoton =
shall be deemed as neither given nor endorsed by Nuvoton.</body>

</html>

------_=_NextPart_002_01C99BD8.D3B5CB8B--

------_=_NextPart_001_01C99BD8.D3B5CB8B
Content-Type: application/octet-stream;
	name="795_sensors3.conf"
Content-Transfer-Encoding: base64
Content-Description: 795_sensors3.conf
Content-Disposition: attachment;
	filename="795_sensors3.conf"

IyBIZXJlIGFyZSBjb25maWd1cmF0aW9ucyBmb3IgTnV2b3RvbiBXODM3OTUgY2hpcC4KY2hpcCAi
dzgzNzk1LSoiCgogICAgbGFiZWwgaW4wICJWU0VOMSIKICAgIGxhYmVsIGluMSAiVlNFTjIiCiAg
ICBsYWJlbCBpbjIgIlZTRU4zIgogICAgbGFiZWwgaW4zICJWU0VONCIKICAgIGxhYmVsIGluNCAi
VlNFTjUiCiAgICBsYWJlbCBpbjUgIlZTRU42IgogICAgbGFiZWwgaW42ICJWU0VONyIKICAgIGxh
YmVsIGluNyAiVlNFTjgiCiAgICBsYWJlbCBpbjggIlZTRU45IgogICAgbGFiZWwgaW45ICJWU0VO
MTAiCiAgICBsYWJlbCBpbjEwICJWU0VOMTEiCiAgICBsYWJlbCBpbjExICJWdHQiCiAgICBsYWJl
bCBpbjEyICIzVkREIgogICAgbGFiZWwgaW4xMyAiM1ZTQiIKICAgIGxhYmVsIGluMTQgIlZCQVQi
CiAgICBsYWJlbCBpbjE1ICJWU0VOMTIiCiAgICBsYWJlbCBpbjE2ICJWU0VOMTMiCiAgICBsYWJl
bCBpbjE3ICJWU0VOMTQiCiAgICBsYWJlbCBpbjE4ICJWU0VOMTUiCiAgICBsYWJlbCBpbjE5ICJW
U0VOMTYiCiAgICBsYWJlbCBpbjIwICJWU0VOMTciCiAgICBsYWJlbCB0ZW1wMSAiVGVtcDEiCiAg
ICBsYWJlbCB0ZW1wMiAiVGVtcDIiCiAgICBsYWJlbCB0ZW1wMyAiVGVtcDMiCiAgICBsYWJlbCB0
ZW1wNCAiVGVtcDQiCiAgICBsYWJlbCB0ZW1wNSAiVGVtcDUiCiAgICBsYWJlbCB0ZW1wNiAiVGVt
cDYiCiAgICBsYWJlbCB0ZW1wNyAgIkRUUzEiCiAgICBsYWJlbCB0ZW1wOCAgIkRUUzIiCiAgICBs
YWJlbCB0ZW1wOSAgIkRUUzMiCiAgICBsYWJlbCB0ZW1wMTAgIkRUUzQiCiAgICBsYWJlbCB0ZW1w
MTEgIkRUUzUiCiAgICBsYWJlbCB0ZW1wMTIgIkRUUzYiCiAgICBsYWJlbCB0ZW1wMTMgIkRUUzci
CiAgICBsYWJlbCB0ZW1wMTQgIkRUUzgiCgogICAgY29tcHV0ZSBpbjE3IEAvKDguMCkgLCAoOC4w
KSpACiAgICBjb21wdXRlIGluMTggQC8oOC4wKSAsICg4LjApKkAKICAgIGNvbXB1dGUgaW4xOSBA
Lyg4LjApICwgKDguMCkqQAogICAgY29tcHV0ZSBpbjIwIEAvKDguMCkgLCAoOC4wKSpACgoKIyBm
YW4xIGFkanVzdG1lbnRzIGV4YW1wbGVzCgojICAgc2V0IGZhbjFfbWluIDE1MDAKCiMgdGVtcDIg
bGltaXRzIGV4YW1wbGVzCgojICAgc2V0IHRlbXAyX21heCAgICAgICA0NQojICAgc2V0IHRlbXAy
X21heF9oeXN0ICA0MAoKIyBpZ25vcmUgZXhhbXBsZXMKCiMgICAgaWdub3JlIGZhbjcKIyAgICBp
Z25vcmUgdGVtcDMKCgo=

------_=_NextPart_001_01C99BD8.D3B5CB8B
Content-Type: application/octet-stream;
	name="DESC"
Content-Transfer-Encoding: base64
Content-Description: DESC
Content-Disposition: attachment;
	filename="DESC"

VGhlIGRlc2NyaXB0aW9uIGZpbGUgb2YgdzgzNzk1Zy9hZGcgaHcgZHJpdmVyLgoKSW5kZXgKCkku
ICAgR2VuZXJhbCBTeXNmcyBJbnRlcmZhY2UKSUkuICBTbWFydEZhbiBTeXNmcyBJbnRlcmZhY2UK
IAotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCgpJLiBHZW5lcmFsIFN5c2ZzIElu
dGVyZmFjZQoKMSkgVm9sdGFnZSBzeXMgZmlsZXMKaW5bMC0yMF1faW5wdXQgICAgICAgVGhlIGlu
cHV0IHZhbHVlcyBvZiBjdXJyZW50IHZvbHRhZ2UuICAKICAgICAgICAgICAgICAgICAgICAgUk8K
CmluWzAtMjBdX21heAppblswLTIwXV9taW4KICAgICAgICAgICAgICAgICAgICAgVGhlIG1heC9t
aW4gdm9sdGFnZSB2YWx1ZS4KICAgICAgICAgICAgICAgICAgICAgUlcKCjIpIEZhbiBzcGVlZCBz
eXMgZmlsZXMKZmFuWzEtMTRdX2lucHV0ICAgICAgVGhlIGlucHV0IHZhbHVlcyBvZiBmYW4gc3Bl
ZWQuICAKICAgICAgICAgICAgICAgICAgICAgUk8KCmZhblsxLTE0XV9taW4KICAgICAgICAgICAg
ICAgICAgICAgVGhlIG1pbiBmYW4gc3BlZWQgdmFsdWUuCiAgICAgICAgICAgICAgICAgICAgIFJX
CgpmYW5bMS04XV9kaXYgICAgICAgICBUaGUgZGl2aXNvciBvZiBjdXJyZW50IGZhbi4KICAgICAg
ICAgICAgICAgICAgICAgVmFsaWQgdmFsdWUgcmFuZ2UgaXMgMSwgMiwgMywgNCwgNSwgNiwgNywg
OCwgMTIsIDE2LCAzMiwgNjQsIDEyOC4KCjMpIFRlbXBlcmF0dXJlIHN5cyBmaWxlcwp0ZW1wWzEt
Nl1faW5wdXQgICAgICBUaGUgaW5wdXQgdmFsdWVzIG9mIHRlbXBlcmF0dXJlLiAgCiAgICAgICAg
ICAgICAgICAgICAgIFJPCgp0ZW1wWzEtNl1fY3JpdAp0ZW1wWzEtNl1fY3JpdF9oeXN0CiAgICAg
ICAgICAgICAgICAgICAgIFRoZSBjcml0aWNhbCBhbmQgaHlzdCBvZiBjcml0aWNhbCB0ZW1wZXJh
dHVyZSB2YWx1ZS4KICAgICAgICAgICAgICAgICAgICAgSWYgdGVtcGVyYXR1cmUgZXhjZWVkIHRo
ZSBjcml0aWNhbCB2YWx1ZXMsIHJlbGF0ZWQgRkFOQ1RMIHdpbGwgYmUgc2V0IHRvIG91cHV0IDEw
MCUuCiAgICAgICAgICAgICAgICAgICAgIFJXCgp0ZW1wWzEtNl1fbWF4CnRlbXBbMS02XV9tYXhf
aHlzdAogICAgICAgICAgICAgICAgICAgICBUaGUgbWF4IGFuZCBoeXN0IG9mIG1heCB0ZW1wZXJh
dHVyZSB2YWx1ZS4KICAgICAgICAgICAgICAgICAgICAgVGhlc2UgcmVnaXN0ZXJzIG9uIDc5NSBT
UEVDIGFyZSBuYW1lZCBhcyAiQ3JpdGljYWwiIGFuZCAiQ3JpdGljYWwgSHlzdGVyc2lzIi4KICAg
ICAgICAgICAgICAgICAgICAgUlcKCnRlbXBbMS02XV93YXJuCnRlbXBbMS02XV93YXJuX2h5c3QK
ICAgICAgICAgICAgICAgICAgICAgVGhlIHdhcm5pbmcgYW5kIGh5c3Qgb2Ygd2FybmluZyB0ZW1w
ZXJhdHVyZSAgdmFsdWUuCiAgICAgICAgICAgICAgICAgICAgIFJXCgp0ZW1wWzEtNl1fdHlwZSAg
ICAgICAzOiBUaGVybWFsIERpb2RlLCA0OiBUaGVybWlzdG9yCiAgICAgICAgICAgICAgICAgICAg
IHRlbXA1IGFuZCB0ZW1wNiBvbmx5IHN1cHBvcnQgVGhlcm1pc3RvciB0eXBlLgogICAgICAgICAg
ICAgICAgICAgICBSVwoKCjQpIERUUyBzeXMgZmlsZXMKdGVtcFs3LTE0XV9pbnB1dCAgICAgVGhl
IGlucHV0IHZhbHVlcyBvZiBEVFMgdGVtcGVyYXR1cmUuICAKICAgICAgICAgICAgICAgICAgICAg
Uk8KCnRlbXBbNy0xNF1fbWF4CnRlbXBbNy0xNF1fbWF4X2h5c3QKICAgICAgICAgICAgICAgICAg
ICAgVGhlIG1heCBhbmQgaHlzdCBvZiBtYXggRFRTIHRlbXBlcmF0dXJlIHZhbHVlLgogICAgICAg
ICAgICAgICAgICAgICBUaGVzZSByZWdpc3RlcnMgb24gNzk1IFNQRUMgYXJlIG5hbWVkIGFzICJD
cml0aWNhbCIgYW5kICJDcml0aWNhbCBIeXN0ZXJzaXMiLgogICAgICAgICAgICAgICAgICAgICBS
VwoKdGVtcFs3LTE0XV93YXJuCnRlbXBbNy0xNF1fd2Fybl9oeXN0CiAgICAgICAgICAgICAgICAg
ICAgIFRoZSB3YXJuaW5nIGFuZCBoeXN0IG9mIHdhcm5pbmcgRFRTIHRlbXBlcmF0dXJlICB2YWx1
ZS4KICAgICAgICAgICAgICAgICAgICAgUlcKCnRlbXBbNy0xNF1fdHlwZSAgICAgIDU6IEFNRCBT
Qi1UU0ksIDY6IFBFQ0kKICAgICAgICAgICAgICAgICAgICAgVGhlc2UgYXJndW1lbnRzIGFyZSBz
ZWxlY3RlZCBieSBCSU9TLiBEbyBub3QgYWxsb3cgdXNlciBjaGFuZ2UgaXQuCiAgICAgICAgICAg
ICAgICAgICAgIFJPCgoKNSkgQWxhcm0gYW5kIEJlZXAgcmVsYXRlZCBzeXMgZmlsZXMKaW5bMC0y
MF1fYWxhcm0KZmFuWzEtMTRdX2FsYXJtCnRlbXBbMS02XV9hbGFybQogICAgICAgICAgICAgICAg
ICAgICAwOiBubyBhbGFybSwgMTogYWxhcm0uCiAgICAgICAgICAgICAgICAgICAgIFJPIAoKY2hh
c3NpcwogICAgICAgICAgICAgICAgICAgICBSZWFkIDA6IG5vIGNoYXNzaXMgYWxhcm0sIFJlYWQg
MTogY2hhc3NpcyBhbGFybS4KICAgICAgICAgICAgICAgICAgICAgV3JpdGUgQU5ZIHZhbHVlOiBj
bGVhciBhbGFybSBzdGF0dXMuCiAgICAgICAgICAgICAgICAgICAgIFJXCgpiZWVwX2VuYWJsZSAg
ICAgICAgICAwOiBubyBiZWVwcy4gMTogYmVlcHMuCiAgICAgICAgICAgICAgICAgICAgIFJXCgpp
blswLTIwXV9iZWVwCmZhblsxLTE0XV9iZWVwCnRlbXBbMS02XV9iZWVwCiAgICAgICAgICAgICAg
ICAgICAgIDA6IGRpYWJsZSwgMTogZW5hYmxlLgogICAgICAgICAgICAgICAgICAgICBSVwoKNikg
RmF1bHQgcmVsYXRlZCBzeXMgZmlsZXMKaW5bMC0yMF1faW5wdXRfZmF1bHQKZmFuWzEtMTRdX2lu
cHV0X2ZhdWx0CiAgICAgICAgICAgICAgICAgICAgIDA6IG5vIGZhdWx0LiAgMTogZmF1bHQuCiAg
ICAgICAgICAgICAgICAgICAgIFJXCgppbl9mYXVsdF9lbmFibGUgICAgICAwOiBlbmFibGUgZmF1
bHQuICAxOiBkaXNhYmxlLgogICAgICAgICAgICAgICAgICAgICBSVwoKZmFuX2ZhdWx0X2VuYWJs
ZSAgICAgMDogZW5hYmxlIGZhdWx0LiAgMTogZGlzYWJsZS4KICAgICAgICAgICAgICAgICAgICAg
UlcKCjcpIE90aGVyCmNwdVswLTJdX3ZpZCAgICAgICAgIENQVSBjb3JlIHJlZmVyZW5jZSB2b2x0
YWdlLgogICAgICAgICAgICAgICAgICAgICBSTwogICAgICAgICAgICAgICAgICAgICBOb3QgYWx3
YXlzIGNvcnJlY3QuCgp2cm0gICAgICAgICAgICAgICAgICBWb2x0YWdlIFJlZ3VsYXRvciBNb2R1
bGUgdmVyc2lvbiBudW1iZXIuCiAgICAgICAgICAgICAgICAgICAgIFJXCiAgICAgICAgICAgICAg
ICAgICAgIERvIG5vdCBjaGFuZ2UuCgoKCklJLiBTbWFydEZhbiBTeXNmcyBJbnRlcmZhY2UKCjEu
IFBXTSByZWxhdGVkIHN5cyBmaWxlcwpwd21bMS04XSAgICAgICAgICAgICBGQU5DVEwxIC0gRkFO
Q1RMOCBmYW4gb3V0cHV0IHZhbHVlLgogICAgICAgICAgICAgICAgICAgICBPbmx5IGluIFBXTSBt
b2RlLCB3cml0ZSB2YWx1ZSBjYW4gY29udHJvbCBmYW4gb3V0cHV0IHNwZWVkLgogICAgICAgICAg
ICAgICAgICAgICBSVwoKcHdtWzEtOF1fbm9uc3RvcAogICAgICAgICAgICAgICAgICAgICBGQU5D
VEwxIC0gRkFOQ1RMOCBmYW4gb3V0cHV0IE5vbnN0b3AgdmFsdWUuCiAgICAgICAgICAgICAgICAg
ICAgIFJXCgpwd21bMS04XV9zdGFydAogICAgICAgICAgICAgICAgICAgICBGQU5DVEwxIC0gRkFO
Q1RMOCBmYW4gb3V0cHV0IFN0YXJ0LXVwIHZhbHVlLgogICAgICAgICAgICAgICAgICAgICBSVwoK
cHdtWzEtOF1fc3RvcF90aW1lCiAgICAgICAgICAgICAgICAgICAgIEZBTkNUTDEgLSBGQU5DVEw4
IGZhbiBvdXRwdXQgU3RvcCBUaW1lLgogICAgICAgICAgICAgICAgICAgICBSVwoKcHdtX2RlZmF1
bHQgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgIFRoZSBpbml0aWFsIHNwZWVkIG9mIGV2
ZXJ5IGZhbi4gT25seSBhZmZlY3QgYWZ0ZXIgbmV4dCB0aW1lIHN5c3RlbSBwb3dlciBvbi4KICAg
ICAgICAgICAgICAgICAgICAgUlcKCnB3bV91cHRpbWUKcHdtX2Rvd250aW1lCiAgICAgICAgICAg
ICAgICAgICAgIFRoZSB0aW1lIGludGVydmFsIG9mIGZhbiBzcGVlZCBjaGFuZ2UgdGltZSBmb3Ig
c21hcnQgZmFuIG9yIG90aGVyIHJlYXNvbnMuCiAgICAgICAgICAgICAgICAgICAgIE5ldmVyIGFj
Y2VwdCB2YWx1ZXMgbGVzcyB0aGFuIDUwLgogICAgICAgICAgICAgICAgICAgICBSVwoKMi4gUFdN
IG1vZGUgYW5kIFNtYXJ0IEZhbiBNb2RlIFNlbGVjdApwd21bMS04XV9lbmFibGUKICAgICAgICAg
ICAgICAgICAgICAgTW9kaWZ5IHZhbHVlcyBvZiB0ZW1wKl9hdXRvX2NoYW5uZWxzX3B3bSwgdGhl
IFRlbXBlcmF0dXJlIHRvIEZhbiBNYXBwaW5nIFJlbGF0aW9uc2hpcHMgUmVnaXN0ZXJzLgogICAg
ICAgICAgICAgICAgICAgICB2YWx1ZSA9IDA6IERDIG1vZGUuIEZBTkNUTCBvdXRwdXRzIGZ1bGwg
ZmFuIHNwZWVkIGFuZCBpZ25vcmUgdGhlIHZhbHVlcyBvZiBwd21bMS04XS4KICAgICAgICAgICAg
ICAgICAgICAgdmFsdWUgPSAxOiBQV00gbW9kZS4gRkFOQ1RMIG91dHB1dCB2YWx1ZXMgYXJlIGNv
bnRyb2xsZWQgYnkgcHdtWzEtOF0uCiAgICAgICAgICAgICAgICAgICAgIHZhbHVlID0gMjogU3Bl
ZWQgQ3J1aXNlIG1vZGUuIEZBTkNUTCBvdXRwdXQgdmFsdWUgaW5jcmVhc2VzIHVudGlsIHJlbGF0
ZWQgZmFuWzEtOF1faW5wdXQgdmFsdWUgZXhjZWVkcyB0aGUgZmFuWzEtOF1fdGFyZ2V0X3NwZWVk
LgogICAgICAgICAgICAgICAgICAgICB2YWx1ZSA9IDM6IEN1cnJlbnQgRkFOQ1RMIG91dHB1dCBp
cyBub3QgY29udHJvbGxlZCBieSBwd21bMS04XV9lbmFibGUuIFJlZmVyIHRlbXBbMS02XV9hdXRv
X2NoYW5uZWxzX3B3bSBhbmQgdGVtcFsxLTZdX3B3bV9lbmFibGUgdG8gc2V0IGl0cyBtb2RlLiAK
ICAgICAgICAgICAgICAgICAgICAgUlcKCgoKW0NBVVRJT05dCU5ldmVyIGFsbG93IHNldCBwd21b
MS04XV9lbmFibGUgYXMgJzMnIQoKdGVtcFsxLTZdX3NvdXJjZV9zZWwKICAgICAgICAgICAgICAg
ICAgICAgU2VsY3Rpb24gb2YgVGVtcGVyYXR1cmUgU291cmNlLiBWYWxpZCB2YWx1ZSByYW5nZSBp
cyAwLTE1LiAKICAgICAgICAgICAgICAgICAgICAgUmVmZXIgTnV2b3RvbiBXODM3OTVHL0FERyBI
L1cgTW9uaXRvciBjaGlwIFNQRUMgZm9yIG1vcmUgZGV0YWlscy4KICAgICAgICAgICAgICAgICAg
ICAgUlcKCnRlbXBbMS02XV9hdXRvX2NoYW5uZWxzX3B3bQogICAgICAgICAgICAgICAgICAgICBU
ZW1wZXJhdHVyZSB0byBGYW4gbWFwcGluZyBSZWxhdGlvbnNoaXBzLgogICAgICAgICAgICAgICAg
ICAgICBSVwoKdGVtcFsxLTZdX3B3bV9lbmFibGUKICAgICAgICAgICAgICAgICAgICAgU2V0IFRl
bXAxIC0gVGVtcDYgZm9yIFRoZXJtYWwgQ3J1aXNlIG1vZGUgKDMpIG9yIFNtYXJ0IEZhbiBJViBt
b2RlICg0KS4KICAgICAgICAgICAgICAgICAgICAgdmFsdWUgPSAzOiBUaGVybWFsIENydWlzZSBt
b2RlLgogICAgICAgICAgICAgICAgICAgICB2YWx1ZSA9IDQ6IFNtYXJ0IEZhbiBJViBtb2RlLgog
ICAgICAgICAgICAgICAgICAgICBSVwoKVGhlcm1hbCBDcnVpc2Ugb3IgU21hcnQgRmFuIElWIG1v
ZGUgU2V0dGluZyBzdGVwczoKKDEpIFNldCBwd21bMS04XV9lbmFibGUgdG8gMCBvciAxLiAKKDIp
IFNldCB0ZW1wWzEtNl1fYXV0b19jaGFubmVsc19wd20gZm9yIHRlbXBlcmF0dXJlIHRvIGZhbiBt
YXBwaW5nLgooMykgU2V0IHRlbXBbMS02XV9wd21fZW5hYmxlIGZvciBUaGVybWFsIENydWlzZSBv
ciBTbWFydCBGYW4gbW9kZS4KTm93IHNlbGVjdGVkIEZBTkNUTCBpcyBydW5uaW5nIHVuZGVyIFRo
ZXJtYWwgQ3J1aXNlLgoKUFdNIG1vZGUgY2hlY2sgc3RlcHM6CigxKSBDaGVjayBmaWxlIHB3bVsx
LThdX2VuYWJsZS4gVGhlIHZhbHVlIDAsIDEsIDIgaXMgZm9yIERDIE91dHB1dCwgUFdNIGFuZCBT
cGVlZCBDcnVpc2UgbW9kZS4KKDIpIElmIHRoZSB2YWx1ZSBpcyAzLCBjaGVjayB0ZW1wWzEtNl1f
YXV0b19jaGFubmVsc19wd20gYW5kIHRlbXBbMS02XV9wd21fZW5hYmxlLgooMykgdGVtcFsxLTZd
X2F1dG9fY2hhbm5lbHMgbWF5IG1ha2UgMSBURU1QIGNvbnRyb2xzIHNldmVyYWwgRkFOT1VULCBv
ciBtYWtlIEZBTkNUTCBhZmZlY3RlZCBieSBtdWx0aSBURU1QLiBSZWZlciB0aGUgU1BFQyBmb3Ig
bW9yZSBkZXRhaWxzLgooNCkgQ2hlY2sgdGVtcFsxLTZdX3B3bV9lbmFibGUuIFRoZSB2YWx1ZSAz
LCA0IGlzIGZvciBUaGVybWFsIENydWlzZSBhbmQgU21hcnQgRmFuIElWIG1vZGUuCgpbQ0FVVElP
Tl0gU2V0IHB3bVsxLThdX2VuYWJsZSB3b3VsZCBtYWtlIHRoZSBQV00gcmVsYXRlZCBiaXRzIGlu
IHRlbXBbMS02XV9hdXRvX2NoYW5uZWxzX3B3bSBiZWNvbWUgJzAnLgoJRm9yIGV4YW1wbGUsIHNl
dCBwd20xX2VuYWJsZSBhcyAwIHdpbGwgbWFrZSBhbGwgYml0IDAgaW4gdGVtcFsxLTZdX2F1dG9f
Y2hhbm5lbHNfcHdtIGJlY29tZSAnMCcuCglPbmx5IHdoZW4gYWxsIHJlbGF0ZWQgYml0cyBpbiB0
Zm1yIHNldCBhcyAnMCcsIHRoZSBGQU5DVEwgd2lsbCBiZSBzZXQgYXMgbWFudWFsIG1vZGUuCgpb
Q0FVVElPTl0gVGhlIHJlZ2lzdGVyIHZhbHVlcyBvZiBUaGVybWFsIENydWlzZSBvciBTbWFydCBG
YW4gSVYgc2hvdWxkIGJlIHNldCBiZWZvcmUgc3RhcnQgdGhlc2UgYXV0b21hdGljIG1vZGUuCiAg
U28gaWYgeW91IHdhbnQgdG8gY2hhbmdlIHRoZXNlIHZhbHVlcywgc2V0IHJlbGF0ZWQgRkFOQ1RM
IG1vZGUgdG8gUFdNLiBBbmQgcmVzdW1lIHRoZSBhdXRvbWF0aWMgbW9kZSBhZnRlciBtb2RpZmll
ZCB0aGUgc2V0dGluZyByZWdpc3RlciB2YWx1ZXMuCgozLiBTcGVlZCBDcnVpc2UKc3BlZWRfY3J1
aXNlWzEtOF1fdGFyZ2V0CiAgICAgICAgICAgICAgICAgICAgIFRhcmdldCBmYW4gc3BlZWQgaW4g
U3BlZWQgQ3J1aXNlIE1vZGUuIAogICAgICAgICAgICAgICAgICAgICBSVwoKc3BlZWRfY3J1aXNl
X3RvbGVyYW5jZQogICAgICAgICAgICAgICAgICAgICBUb2xlcmFuY2Ugb2YgdGFyZ2V0IGZhbiBz
cGVlZC4KICAgICAgICAgICAgICAgICAgICAgUlcKCjQuIFRoZXJtYWwgQ3J1aXNlCnRoZXJtYWxf
Y3J1aXNlWzEtNl0KICAgICAgICAgICAgICAgICAgICAgVGFyZ2V0IHRlbXBlcmF0dXJlIGluIFRo
ZXJtYWwgQ3J1aXNlIE1vZGUuCiAgICAgICAgICAgICAgICAgICAgIFJXCgp0ZW1wWzEtNl1fb3Bl
cmF0aW9uX2h5c3QKICAgICAgICAgICAgICAgICAgICAgSHlzdGVyc2lzIG9mIG9wZXJhdGlvbiB0
ZW1wZXJhdHVyZSBmb3IgVGhlcm1hbCBDcnVpc2UgTW9kZSBhbmQgU21hcnQgRmFuIElWIE1vZGUu
CiAgICAgICAgICAgICAgICAgICAgIFJXCgo1LiBTbWFydCBGYW4gSVYKdGVtcFsxLTZdX2F1dG9f
cG9pbnRzWzEtN11fcHdtCiAgICAgICAgICAgICAgICAgICAgIFBXTSBmYW4gb3V0cHV0IHZhbHVl
cy4KICAgICAgICAgICAgICAgICAgICAgUlcKCnRlbXBbMS02XV9hdXRvX3BvaW50c1sxLTddX3Rl
bXAKICAgICAgICAgICAgICAgICAgICAgU21hcnQgRmFuIElWIHRhcmdldCB0ZW1wZXJhdHVyZSB2
YWx1ZXMuCiAgICAgICAgICAgICAgICAgICAgIFJXCgp0ZW1wWzEtNl1fb3BlcmF0aW9uX2h5c3QK
ICAgICAgICAgICAgICAgICAgICAgSHlzdGVyc2lzIG9mIG9wZXJhdGlvbiB0ZW1wZXJhdHVyZSBm
b3IgVGhlcm1hbCBDcnVpc2UgTW9kZSBhbmQgU21hcnQgRmFuIElWIE1vZGUuCiAgICAgICAgICAg
ICAgICAgICAgIFJXCgoK

------_=_NextPart_001_01C99BD8.D3B5CB8B
Content-Type: application/octet-stream;
	name="sensors-detect.3.0.3.patch"
Content-Transfer-Encoding: base64
Content-Description: sensors-detect.3.0.3.patch
Content-Disposition: attachment;
	filename="sensors-detect.3.0.3.patch"

LS0tIHNlbnNvcnMtZGV0ZWN0LmJhawkyMDA4LTExLTI3IDE0OjM5OjI1LjAwMDAwMDAwMCAtMDUw
MAorKysgc2Vuc29ycy1kZXRlY3QJMjAwOC0xMS0yNyAxNjozNjowNS4wMDAwMDAwMDAgLTA1MDAK
QEAgLTgyOCw2ICs4MjgsMTIgQEAKICAgICAgICBpMmNfZGV0ZWN0ID0+IHN1YiB7IHc4Mzc5M19k
ZXRlY3QoMCwgQF8pOyB9LAogICAgICB9LAogICAgICB7CisgICAgICAgbmFtZSA9PiAiTnV2b3Rv
biBXODM3OTVHL0FERyIsCisgICAgICAgZHJpdmVyID0+ICJ3ODM3OTUiLAorICAgICAgIGkyY19h
ZGRycyA9PiBbMHgyYy4uMHgyZl0sCisgICAgICAgaTJjX2RldGVjdCA9PiBzdWIgeyB3ODM3OTVf
ZGV0ZWN0KDAsIEBfKTsgfSwKKyAgICAgfSwKKyAgICAgewogICAgICAgIG5hbWUgPT4gIldpbmJv
bmQgVzgzNzkxU0QiLAogICAgICAgIGRyaXZlciA9PiAibm90LWEtc2Vuc29yIiwKICAgICAgICBp
MmNfYWRkcnMgPT4gWzB4MmMuLjB4MmZdLApAQCAtNDY2NSw2ICs0NjcxLDQwIEBACiAgIHJldHVy
biBAcmVzOwogfQogCisjICRfWzBdOiBDaGlwIHRvIGRldGVjdCAoMCA9IFc4Mzc5NSkKKyMgJF9b
MV06IEEgcmVmZXJlbmNlIHRvIHRoZSBmaWxlIGRlc2NyaXB0b3IgdG8gYWNjZXNzIHRoaXMgY2hp
cC4KKyMgJF9bMl06IEFkZHJlc3MKKyMgUmV0dXJuczogdW5kZWYgaWYgbm90IGRldGVjdGVkCisj
ICAgICAgICAgIDYgaWYgZGV0ZWN0ZWQgYW5kIGJhbmsgZGlmZmVyZW50IGZyb20gMAorIyAgICAg
ICAgICA4IGlmIGRldGVjdGVkLCBiYW5rIGlzIDAgCisjIFJlZ2lzdGVycyB1c2VkOgorIyAgIDB4
ZmM6IEZ1bGwgSTJDIEFkZHJlc3MKKyMgICAweDAwOiBWZW5kb3IgSUQgYnl0ZSBzZWxlY3Rpb24s
IGFuZCBiYW5rIHNlbGVjdGlvbihCYW5rIDAsIDEsIDIpCisjICAgMHhmZDogVmVuZG9yIElEKEJh
bmsgMCwgMSwgMikKKyMgICAweGZlOiBEZXZpY2UgSUQoQmFuayAwLCAxLCAyKQorc3ViIHc4Mzc5
NV9kZXRlY3QKK3sKKyAgbXkgKCRiYW5rLCAkcmVnLCBAcmVzKTsKKyAgbXkgKCRjaGlwLCAkZmls
ZSwgJGFkZHIpID0gQF87CisKKyAgJGJhbmsgPSBpMmNfc21idXNfcmVhZF9ieXRlX2RhdGEoJGZp
bGUsIDB4MDApOworICAkcmVnID0gaTJjX3NtYnVzX3JlYWRfYnl0ZV9kYXRhKCRmaWxlLCAweGZk
KTsKKworICByZXR1cm4gdW5sZXNzICgoJGJhbmsgJiAweDgwKSA9PSAweDAwIGFuZCAkcmVnID09
IDB4YTMpIG9yCisgICAgICAgICAgICAgICAgKCgkYmFuayAmIDB4ODApID09IDB4ODAgYW5kICRy
ZWcgPT0gMHg1Yyk7CisKKyAgJHJlZyA9IGkyY19zbWJ1c19yZWFkX2J5dGVfZGF0YSgkZmlsZSwg
MHhmZSk7CisgIHJldHVybiBpZiAkY2hpcCA9PSAwIGFuZCAkcmVnICE9IDB4Nzk7CisKKyMgSWYg
YmFuayAwIGlzIHNlbGVjdGVkLCB3ZSBjYW4gZG8gbW9yZSBjaGVja3MKKyAgcmV0dXJuIDYgdW5s
ZXNzICgkYmFuayAmIDB4MDcpID09IDA7CisgICRyZWcgPSBpMmNfc21idXNfcmVhZF9ieXRlX2Rh
dGEoJGZpbGUsIDB4ZmMpICYgMHg3ZjsKKyAgcmV0dXJuIHVubGVzcyAoJHJlZyA9PSAkYWRkcik7
CisKKwlAcmVzID0gKDgpOworICByZXR1cm4gQHJlczsKK30KKwogIyAkX1swXTogQSByZWZlcmVu
Y2UgdG8gdGhlIGZpbGUgZGVzY3JpcHRvciB0byBhY2Nlc3MgdGhpcyBjaGlwLgogIyAkX1sxXTog
QWRkcmVzcwogIyBSZXR1cm5zOiB1bmRlZiBpZiBub3QgZGV0ZWN0ZWQsIDMgaWYgZGV0ZWN0ZWQK

------_=_NextPart_001_01C99BD8.D3B5CB8B
Content-Type: application/octet-stream;
	name="wb83795.c"
Content-Transfer-Encoding: base64
Content-Description: wb83795.c
Content-Disposition: attachment;
	filename="wb83795.c"

LyoKICAgIHc4Mzc5NS5jIC0gTGludXgga2VybmVsIGRyaXZlciBmb3IgaGFyZHdhcmUgbW9uaXRv
cmluZwogICAgQ29weXJpZ2h0IChDKSAyMDA4IE51dm90b24gVGVjaG5vbG9neSBDb3JwLgogICAg
ICAgICAgICAgICAgICBXZWkgU29uZwoKICAgIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJl
OyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CiAgICBpdCB1bmRlciB0aGUg
dGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieQog
ICAgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbiAtIHZlcnNpb24gMi4KCiAgICBUaGlzIHBy
b2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwK
ICAgIGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdh
cnJhbnR5IG9mCiAgICBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFS
IFBVUlBPU0UuICBTZWUgdGhlCiAgICBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9y
ZSBkZXRhaWxzLgoKICAgIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdO
VSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCiAgICBhbG9uZyB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYg
bm90LCB3cml0ZSB0byB0aGUgRnJlZSBTb2Z0d2FyZQogICAgRm91bmRhdGlvbiwgSW5jLiwgNTEg
RnJhbmtsaW4gU3RyZWV0LCBGaWZ0aCBGbG9vciwgQm9zdG9uLCBNQQogICAgMDIxMTAtMTMwMSBV
U0EuCgoKICAgIFN1cHBvcnRzIGZvbGxvd2luZyBjaGlwczoKCiAgICBDaGlwICAgICAgICN2aW4g
ICAjZmFuaW4gI3B3bSAjdGVtcCAjZHRzIHdjaGlwaWQgIHZlbmRpZCAgaTJjICBJU0EKICAgIHc4
Mzc5NWcgICAgIDIxICAgICAxNCAgICAgOCAgICAgNiAgICAgOCAgICAweDc5ICAgMHg1Y2EzICB5
ZXMgICBubwogICAgdzgzNzk1YWRnICAgMTggICAgIDE0ICAgICAyICAgICA2ICAgICA4ICAgIDB4
NzkgICAweDVjYTMgIHllcyAgIG5vCiovCgojaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+CiNpbmNs
dWRlIDxsaW51eC9pbml0Lmg+CiNpbmNsdWRlIDxsaW51eC9zbGFiLmg+CiNpbmNsdWRlIDxsaW51
eC9pMmMuaD4KI2luY2x1ZGUgPGxpbnV4L2h3bW9uLmg+CiNpbmNsdWRlIDxsaW51eC9od21vbi12
aWQuaD4KI2luY2x1ZGUgPGxpbnV4L2h3bW9uLXN5c2ZzLmg+CiNpbmNsdWRlIDxsaW51eC9lcnIu
aD4KI2luY2x1ZGUgPGxpbnV4L211dGV4Lmg+CiNpbmNsdWRlIDxsaW51eC9kZWxheS5oPgoKLyog
QWRkcmVzc2VzIHRvIHNjYW4gKi8Kc3RhdGljIHVuc2lnbmVkIHNob3J0IG5vcm1hbF9pMmNbXSA9
IHsgMHgyYywgMHgyZCwgMHgyZSwgMHgyZiwgSTJDX0NMSUVOVF9FTkQgfTsKCi8qIEluc21vZCBw
YXJhbWV0ZXJzICovCkkyQ19DTElFTlRfSU5TTU9EXzEodzgzNzk1KTsKCgpzdGF0aWMgaW50IHJl
c2V0Owptb2R1bGVfcGFyYW0ocmVzZXQsIGJvb2wsIDApOwpNT0RVTEVfUEFSTV9ERVNDKHJlc2V0
LCAiU2V0IHRvIDEgdG8gcmVzZXQgY2hpcCwgbm90IHJlY29tbWVuZGVkIik7CgoKI2RlZmluZSBX
ODM3OTVfUkVHX0JBTktTRUwgICAgMHgwMAojZGVmaW5lIFc4Mzc5NV9SRUdfVkVORE9SSUQgICAw
eGZkCiNkZWZpbmUgVzgzNzk1X1JFR19DSElQSUQgICAgIDB4ZmUKI2RlZmluZSBXODM3OTVfUkVH
X0RFVklDRUlEICAgMHhmYgoKI2RlZmluZSBXODM3OTVfUkVHX0kyQ19BRERSICAgICAgICAgIDB4
ZmMKI2RlZmluZSBXODM3OTVfUkVHX0NPTkZJRyAgICAgICAgICAgIDB4MDEKI2RlZmluZSBXODM3
OTVfUkVHX0NPTkZJR19DT05GSUc0OCAgICAgMHgwNAoKLyogTXVsdGktRnVuY3Rpb24gUGluIEN0
cmwgUmVnaXN0ZXJzICovCiNkZWZpbmUgVzgzNzk1X1JFR19WT0xUX0NUUkwxICAgMHgwMgojZGVm
aW5lIFc4Mzc5NV9SRUdfVk9MVF9DVFJMMiAgIDB4MDMKI2RlZmluZSBXODM3OTVfUkVHX1RFTVBf
Q1RSTDEgICAweDA0CiNkZWZpbmUgVzgzNzk1X1JFR19URU1QX0NUUkwyICAgMHgwNQojZGVmaW5l
IFc4Mzc5NV9SRUdfRkFOSU5fQ1RSTDEgIDB4MDYKI2RlZmluZSBXODM3OTVfUkVHX0ZBTklOX0NU
UkwyICAweDA3CiNkZWZpbmUgVzgzNzk1X1JFR19WTUlHQl9DVFJMICAgMHgwOAoKI2RlZmluZSBU
RU1QX0NUUkxfRElTQUJMRSAgICAgICAgIDAKI2RlZmluZSBURU1QX0NUUkxfVEQgICAgICAgICAg
ICAgIDEKI2RlZmluZSBURU1QX0NUUkxfVlNFTiAgICAgICAgICAgIDIKI2RlZmluZSBURU1QX0NU
UkxfVFIgICAgICAgICAgICAgIDMKI2RlZmluZSBURU1QX0NUUkxfU0hJRlQJICAgICAgICAgIDQK
I2RlZmluZSBURU1QX0NUUkxfSEFTSU5fU0hJRlQgICAgIDUKLyogdGVtcCBtb2RlIG1heSBlZmZl
Y3QgVlNFTjE3LTEyIChpbjIwLTE1KSAgKi8Kc3RhdGljIHUxNiBXODM3OTVfUkVHX1RFTVBfQ1RS
TFtdWzZdID0gewoJLyogRGlzYWJsZSwgVEQsIFZTRU4sIFRSLCByZWdpc3RlciBzaGlmdCB2YWx1
ZSwgaGFzX2luIHNoaWZ0IG51bSAqLwoJezB4MDAsIDB4MDEsIDB4MDIsIDB4MDMsIDAsIDE3fSwg
ICAgLy8gVFIxCgl7MHgwMCwgMHgwNCwgMHgwOCwgMHgwQywgMiwgMTh9LCAgICAvLyBUUjIKCXsw
eDAwLCAweDEwLCAweDIwLCAweDMwLCA0LCAxOX0sICAgIC8vIFRSMwoJezB4MDAsIDB4NDAsIDB4
ODAsIDB4QzAsIDYsIDIwfSwgICAgLy8gVFI0Cgl7MHgwMCwgMHgwMCwgMHgwMiwgMHgwMywgMCwg
MTV9LCAgICAvLyBUUjUKCXsweDAwLCAweDAwLCAweDA4LCAweDBDLCAyLCAxNn0sICAgIC8vIFRS
Ngp9OwoKI2RlZmluZSBURU1QX1JFQUQgICAgICAgMAojZGVmaW5lIFRFTVBfQ1JJVCAgICAgICAx
CiNkZWZpbmUgVEVNUF9DUklUX0hZU1QgIDIKI2RlZmluZSBURU1QX1dBUk4gICAgICAgMwojZGVm
aW5lIFRFTVBfV0FSTl9IWVNUICA0Ci8qIG9ubHkgY3JpdCBhbmQgY3JpdF9oeXN0IGFmZmVjdCBy
ZWFsLXRpbWUgYWxhcm0gc3RhdHVzCiAgIGN1cnJlbnQgY3JpdCBjcml0X2h5c3Qgd2FybiB3YXJu
X2h5c3QgKi8Kc3RhdGljIHUxNiBXODM3OTVfUkVHX1RFTVBbXVs1XSA9IHsKCXsweDIxLCAweDk2
LCAweDk3LCAweDk4LCAweDk5fSwgLy8gVEQxL1RSMQoJezB4MjIsIDB4OWEsIDB4OWIsIDB4OWMs
IDB4OWR9LCAvLyBURDIvVFIyCgl7MHgyMywgMHg5ZSwgMHg5ZiwgMHhhMCwgMHhhMX0sIC8vIFRE
My9UUjMKCXsweDI0LCAweGEyLCAweGEzLCAweGE0LCAweGE1fSwgLy8gVEQ0L1RSNAoJezB4MWYs
IDB4YTYsIDB4YTcsIDB4YTgsIDB4YTl9LCAvLyBUUjUKCXsweDIwLCAweGFhLCAweGFiLCAweGFj
LCAweGFkfSwgLy8gVFI2Cn07CgojZGVmaW5lIElOX1JFQUQJCQkJMAojZGVmaW5lIElOX01BWAkJ
CQkxCiNkZWZpbmUgSU5fTE9XCQkJCTIKc3RhdGljIGNvbnN0IHUxNiBXODM3OTVfUkVHX0lOW11b
M10gPSB7CgkvKiBDdXJyZW50LCBITCwgTEwgKi8KCXsweDEwLCAweDcwLCAweDcxfSwJLyogVlNF
TjEJKi8KCXsweDExLCAweDcyLCAweDczfSwJLyogVlNFTjIJKi8KCXsweDEyLCAweDc0LCAweDc1
fSwJLyogVlNFTjMJKi8KCXsweDEzLCAweDc2LCAweDc3fSwJLyogVlNFTjQJKi8KCXsweDE0LCAw
eDc4LCAweDc5fSwJLyogVlNFTjUJKi8KCXsweDE1LCAweDdhLCAweDdifSwJLyogVlNFTjYJKi8K
CXsweDE2LCAweDdjLCAweDdkfSwJLyogVlNFTjcJKi8KCXsweDE3LCAweDdlLCAweDdmfSwJLyog
VlNFTjgJKi8KCXsweDE4LCAweDgwLCAweDgxfSwJLyogVlNFTjkJKi8KCXsweDE5LCAweDgyLCAw
eDgzfSwJLyogVlNFTjEwCSovCgl7MHgxQSwgMHg4NCwgMHg4NX0sCS8qIFZTRU4xMQkqLwoJezB4
MUIsIDB4ODYsIDB4ODd9LAkvKiBWVFQJCSovCgl7MHgxQywgMHg4OCwgMHg4OX0sCS8qIDNWREQJ
CSovCgl7MHgxRCwgMHg4YSwgMHg4Yn0sCS8qIDNWU0IJCSovCgl7MHgxRSwgMHg4YywgMHg4ZH0s
CS8qIFZCQVQJCSovCgl7MHgxRiwgMHhhNiwgMHhhN30sCS8qIFZTRU4xMgkqLwoJezB4MjAsIDB4
YWEsIDB4YWJ9LAkvKiBWU0VOMTMJKi8KCXsweDIxLCAweDk2LCAweDk3fSwJLyogVlNFTjE0CSov
Cgl7MHgyMiwgMHg5YSwgMHg5Yn0sCS8qIFZTRU4xNQkqLwoJezB4MjMsIDB4OWUsIDB4OWZ9LAkv
KiBWU0VOMTYJKi8KCXsweDI0LCAweGEyLCAweGEzfSwJLyogVlNFTjE3CSovCn07CiNkZWZpbmUg
VzgzNzk1X1JFR19WUkxTQiAgICAgIDB4M0MKI2RlZmluZSBWUkxTQl9TSElGVCAgICAgICAgNgoK
c3RhdGljIGNvbnN0IHU4IFc4Mzc5NV9SRUdfSU5fSExfTFNCW10gPSB7CgkweDhlLAkvKiBWU0VO
MS00CSovCgkweDkwLAkvKiBWU0VONS04CSovCgkweDkyLAkvKiBWU0VOOS0xMQkqLwoJMHg5NCwJ
LyogVlRULCAzVkRELCAzVlNCLCAzVkJBVAkqLwoJMHhhOCwJLyogVlNFTjEyCSovCgkweGFjLAkv
KiBWU0VOMTMJKi8KCTB4OTgsCS8qIFZTRU4xNAkqLwoJMHg5YywJLyogVlNFTjE1CSovCgkweGEw
LAkvKiBWU0VOMTYJKi8KCTB4YTQsCS8qIFZTRU4xNwkqLwp9OwoKI2RlZmluZSBJTl9MU0JfUkVH
KGluZGV4LCB0eXBlKSBcCgkoKCh0eXBlKSA9PSAxKSA/IFc4Mzc5NV9SRUdfSU5fSExfTFNCWyhp
bmRleCldIFwKCTogKFc4Mzc5NV9SRUdfSU5fSExfTFNCWyhpbmRleCldICsgMSkpCgojZGVmaW5l
IElOX0xTQl9SRUdfTlVNICAxMAoKI2RlZmluZSBJTl9MU0JfU0hJRlQgIDAKI2RlZmluZSBJTl9M
U0JfSURYICAgIDEKc3RhdGljIGNvbnN0IHU4IElOX0xTQl9TSElGVF9JRFhbXVsyXSA9IHsKCS8q
IEhpZ2gvTG93IExTQiBzaGlmdCwgTFNCIE5vLiAqLwoJezB4MDAsIDB4MDB9LAkvKiBWU0VOMQkq
LwoJezB4MDIsIDB4MDB9LAkvKiBWU0VOMgkqLwoJezB4MDQsIDB4MDB9LAkvKiBWU0VOMwkqLwoJ
ezB4MDYsIDB4MDB9LAkvKiBWU0VONAkqLwoJezB4MDAsIDB4MDF9LAkvKiBWU0VONQkqLwoJezB4
MDIsIDB4MDF9LAkvKiBWU0VONgkqLwoJezB4MDQsIDB4MDF9LAkvKiBWU0VONwkqLwoJezB4MDYs
IDB4MDF9LAkvKiBWU0VOOAkqLwoJezB4MDAsIDB4MDJ9LAkvKiBWU0VOOQkqLwoJezB4MDIsIDB4
MDJ9LAkvKiBWU0VOMTAJKi8KCXsweDA0LCAweDAyfSwJLyogVlNFTjExCSovCgl7MHgwMCwgMHgw
M30sCS8qIFZUVAkJKi8KCXsweDAyLCAweDAzfSwJLyogM1ZERAkJKi8KCXsweDA0LCAweDAzfSwJ
LyogM1ZTQgkJKi8KCXsweDA2LCAweDAzfSwJLyogVkJBVAkJKi8KCXsweDA2LCAweDA0fSwJLyog
VlNFTjEyCSovCgl7MHgwNiwgMHgwNX0sCS8qIFZTRU4xMwkqLwoJezB4MDYsIDB4MDZ9LAkvKiBW
U0VOMTQJKi8KCXsweDA2LCAweDA3fSwJLyogVlNFTjE1CSovCgl7MHgwNiwgMHgwOH0sCS8qIFZT
RU4xNgkqLwoJezB4MDYsIDB4MDl9LAkvKiBWU0VOMTcJKi8KfTsKCgovKjNWREQsIDNWU0IsIFZC
QVQgKiAwLjAwNiAqLwojZGVmaW5lIFJFU1RfVkxUX0JFR0lOICAxMiAgLyogdGhlIDEzdGggdm9s
dCB0byAxNXRoICovCiNkZWZpbmUgUkVTVF9WTFRfRU5EICAgIDE0ICAvKiB0aGUgMTN0aCB2b2x0
IHRvIDE1dGggKi8KCiNkZWZpbmUgVzgzNzk1X1JFR19GQU4oaW5kZXgpICAgICgweDJFICsgKGlu
ZGV4KSkKI2RlZmluZSBXODM3OTVfUkVHX0ZBTl9NSU5fSEwoaW5kZXgpICAgICAoMHhCNiArIChp
bmRleCkpCiNkZWZpbmUgVzgzNzk1X1JFR19GQU5fTUlOX0xTQihpbmRleCkgICAgKDB4QzQgKyAo
aW5kZXgpIC8gMikKI2RlZmluZSBXODM3OTVfUkVHX0ZBTl9NSU5fTFNCX1NISUZUKGluZGV4KSAg
ICBcCgkoKChpbmRleCkgJSAxKSA/IDQgOiAwKQojZGVmaW5lIFc4Mzc5NV9SRUdfRkFOX0NUUkxf
U0hJRlQoaW5kZXgpICAgXAoJKCgoaW5kZXgpID4gNykgPyAoKGluZGV4KSAtIDgpIDogKGluZGV4
KSkKCiNkZWZpbmUgVzgzNzk1X1JFR19WSURfQ1RSTCAgICAgICAgIDB4NkEKI2RlZmluZSBXODM3
OTVfUkVHX0RWSURfTElNSEkgICAgICAgMHg2QgojZGVmaW5lIFc4Mzc5NV9SRUdfRFZJRF9MSU1M
TyAgICAgICAweDZDCiNkZWZpbmUgVzgzNzk1X1JFR19WU0VOX1ZJRElOKGluZGV4KSAgICAgICgw
eDZEICsgKGluZGV4KSkKCiNkZWZpbmUgQUxBUk1fQkVFUF9SRUdfTlVNICAgICAgICA2IAojZGVm
aW5lIFc4Mzc5NV9SRUdfQUxBUk0oaW5kZXgpICAgKDB4NDEgKyAoaW5kZXgpKQojZGVmaW5lIFc4
Mzc5NV9SRUdfQkVFUChpbmRleCkgICAoMHg1MCArIChpbmRleCkpCgojZGVmaW5lIFc4Mzc5NV9S
RUdfQ0xSX0NIQVNTSVMgICAweDRECgoKI2RlZmluZSBJTl9GQVVMVCAgICAgIDAKI2RlZmluZSBG
QU5fRkFVTFQgICAgIDEKI2RlZmluZSBXODM3OTVfUkVHX0ZBVUxUKGluZGV4LCBucikJXAoJKCgo
KG5yKSA9PSAwKSA/IDB4NjUgOiAweDY4KSArIChpbmRleCkpCiNkZWZpbmUgRkFVTFRfTlVNKGlu
ZGV4KSAgICAgXAoJKCgoaW5kZXgpIDw9IDcpID8gMCA6CVwKCSAoKGluZGV4KSA8PSAxNCkgPyAx
IDogMikKI2RlZmluZSBGQVVMVF9TSElGVChpbmRleCkgICAgIFwKCSgoKGluZGV4KSA8PSA3KSA/
IChpbmRleCkgOglcCgkgKChpbmRleCkgPD0gMTQpID8gKGluZGV4IC0gOCkgOiAoaW5kZXggLSAx
NSkpCiNkZWZpbmUgVzgzNzk1X1JFR19GQVVMVF9FTkFCTEUoaW5kZXgpICAgICAgXAoJKChpbmRl
eCA9PSAwKSA/IDB4NjcgOiAweDY5KQoKCiNkZWZpbmUgVzgzNzk1X1JFR19URU1QX05VTSAgICAg
NgojZGVmaW5lIFc4Mzc5NV9SRUdfRkNNUzEgICAgICAweDIwMQojZGVmaW5lIFc4Mzc5NV9SRUdf
RkNNUzIgICAgICAweDIwOAojZGVmaW5lIFc4Mzc5NV9SRUdfVEZNUihpbmRleCkgICAgICAoMHgy
MDIgKyAoaW5kZXgpKQojZGVmaW5lIFc4Mzc5NV9SRUdfRk9NQyAgICAgICAweDIwRgojZGVmaW5l
IFc4Mzc5NV9SRUdfRk9QRlAoaW5kZXgpICAgICAoMHgyMTggKyAoaW5kZXgpKQoKI2RlZmluZSBX
ODM3OTVfUkVHX1RTUyhpbmRleCkJICAgICAgKChpbmRleCkgKyAweDIwOSkKCiNkZWZpbmUgUFdN
X09VVFBVVCAgICAgICAwCiNkZWZpbmUgUFdNX1NUQVJUICAgICAgICAxCiNkZWZpbmUgUFdNX05P
TlNUT1AgICAgICAyCiNkZWZpbmUgUFdNX1NUT1BfVElNRSAgICAzCiNkZWZpbmUgUFdNX0RJViAg
ICAgICAgICA0CiNkZWZpbmUgVzgzNzk1X1JFR19QV00oaW5kZXgsIG5yKQlcCgkoKChucikgPT0g
MCA/IDB4MjEwIDogXAoJICAobnIpID09IDEgPyAweDIyMCA6IFwKCSAgKG5yKSA9PSAyID8gMHgy
MjggOiBcCgkgIChucikgPT0gMyA/IDB4MjMwIDogMHgyMTgpICsgKGluZGV4KSkKCiNkZWZpbmUg
VzgzNzk1X1JFR19GT1BGUF9ESVYoaW5kZXgpCVwKCSgoKGluZGV4KSA8IDgpID8gKChpbmRleCkg
KyAxKSA6IAlcCgkgKChpbmRleCkgPT0gOCkgPyAxMiA6CVwKCSAoMTYgPDwgKChpbmRleCkgLSA5
KSkpCgojZGVmaW5lIFc4Mzc5NV9SRUdfRlRTSChpbmRleCkgICAgKDB4MjQwICsgKGluZGV4KSAq
IDIpCiNkZWZpbmUgVzgzNzk1X1JFR19GVFNMKGluZGV4KSAgICAoMHgyNDEgKyAoaW5kZXgpICog
MikKI2RlZmluZSBXODM3OTVfUkVHX1RGVFMgICAgICAgICAgMHgyNTAKCiNkZWZpbmUgVEVNUF9Q
V01fVFRUSSAgICAgICAwCiNkZWZpbmUgVEVNUF9QV01fQ1RGUyAgICAgICAxCiNkZWZpbmUgVEVN
UF9QV01fSENUICAgICAgICAyCiNkZWZpbmUgVEVNUF9QV01fSE9UICAgICAgICAzCiNkZWZpbmUg
VzgzNzk1X1JFR19UVFRJKGluZGV4KSAgICAgKDB4MjYwICsgKGluZGV4KSkKI2RlZmluZSBXODM3
OTVfUkVHX0NURlMoaW5kZXgpICAgICAoMHgyNjggKyAoaW5kZXgpKQojZGVmaW5lIFc4Mzc5NV9S
RUdfSFQoaW5kZXgpICAgICAgICgweDI3MCArIChpbmRleCkpCgojZGVmaW5lIFNGNF9URU1QICAg
ICAgIDAKI2RlZmluZSBTRjRfUFdNICAgICAgICAxCiNkZWZpbmUgVzgzNzk1X1JFR19TRjRfVEVN
UCh0ZW1wX251bSwgaW5kZXgpCVwKCSgweDI4MCArIDB4MTAgKiAodGVtcF9udW0pICsgKGluZGV4
KSkKI2RlZmluZSBXODM3OTVfUkVHX1NGNF9QV00odGVtcF9udW0sIGluZGV4KQlcCgkoMHgyODgg
KyAweDEwICogKHRlbXBfbnVtKSArIChpbmRleCkpCgojZGVmaW5lIFc4Mzc5NV9SRUdfRFRTQyAg
ICAgICAgICAgICAgICAweDMwMQojZGVmaW5lIFc4Mzc5NV9SRUdfRFRTRSAgICAgICAgICAgICAg
ICAweDMwMgojZGVmaW5lIFc4Mzc5NV9SRUdfRFRTKGluZGV4KSAgICAgICAgICAoMHgyNiArIChp
bmRleCkpCgojZGVmaW5lIERUU19DUklUICAgICAgICAwCiNkZWZpbmUgRFRTX0NSSVRfSFlTVCAg
IDEKI2RlZmluZSBEVFNfV0FSTiAgICAgICAgMgojZGVmaW5lIERUU19XQVJOX0hZU1QgICAzCiNk
ZWZpbmUgVzgzNzk1X1JFR19EVFNfRVhUKGluZGV4KSAgICAgICgweEIyICsgKGluZGV4KSkKCiNk
ZWZpbmUgU0VUVVBfUFdNX0RFRkFVTFQgICAgMAojZGVmaW5lIFNFVFVQX1BXTV9VUFRJTUUgICAg
IDEKI2RlZmluZSBTRVRVUF9QV01fRE9XTlRJTUUgICAyCiNkZWZpbmUgVzgzNzk1X1JFR19TRVRV
UF9QV00oaW5kZXgpICAgICgweDIwQyArIChpbmRleCkpCgpzdGF0aWMgaW5saW5lIHUxNiBJTl9G
Uk9NX1JFRyh1OCBpbmRleCwgdTE2IHZhbCkKewoJaWYgKChpbmRleCA+PSBSRVNUX1ZMVF9CRUdJ
TikgJiYgKGluZGV4IDw9IFJFU1RfVkxUX0VORCkpCgkJcmV0dXJuICh2YWwgKiA2KTsKCWVsc2UK
CQlyZXR1cm4gKHZhbCAqIDIpOwp9CgpzdGF0aWMgaW5saW5lIHUxNiBJTl9UT19SRUcodTggaW5k
ZXgsIHUxNiB2YWwpCnsKCWlmICgoaW5kZXggPj0gUkVTVF9WTFRfQkVHSU4pICYmIChpbmRleCA8
PSBSRVNUX1ZMVF9FTkQpKQoJCXJldHVybiAodmFsIC8gNik7CgllbHNlCgkJcmV0dXJuICh2YWwg
LyAyKTsKfQoKc3RhdGljIGlubGluZSB1bnNpZ25lZCBsb25nIEZBTl9GUk9NX1JFRyh1MTYgdmFs
KQp7CglpZiAoKHZhbCA+PSAweGZmMCkgfHwgKHZhbCA9PSAwKSkKCQlyZXR1cm4JMDsKCXJldHVy
biAoMTM1MDAwMFVMIC8gdmFsKTsKfQoKc3RhdGljIGlubGluZSB1MTYgRkFOX1RPX1JFRyhsb25n
IHJwbSkKewoJaWYgKHJwbSA8PSAwKQoJCXJldHVybiAweDBmZmY7CglyZXR1cm4gU0VOU09SU19M
SU1JVCgoMTM1MDAwMCArIChycG0gPj4gMSkpIC8gcnBtLCAxLCAweGZmZSk7Cn0KCnN0YXRpYyBp
bmxpbmUgdW5zaWduZWQgbG9uZyBUSU1FX0ZST01fUkVHKHU4IHJlZykKewoJcmV0dXJuIChyZWcg
KiAxMDApOwp9CgpzdGF0aWMgaW5saW5lIHU4IFRJTUVfVE9fUkVHKHVuc2lnbmVkIGxvbmcgdmFs
KQp7CglyZXR1cm4gU0VOU09SU19MSU1JVCgodmFsICsgNTApIC8gMTAwLCAwLCAweGZmKTsKfQoK
c3RhdGljIGlubGluZSBsb25nIFRFTVBfRlJPTV9SRUcoczggcmVnKQp7CglyZXR1cm4gKHJlZyAq
IDEwMDApOwp9CgpzdGF0aWMgaW5saW5lIHM4IFRFTVBfVE9fUkVHKGxvbmcgdmFsLCBzOCBtaW4s
IHM4IG1heCkKewoJcmV0dXJuIFNFTlNPUlNfTElNSVQoKHZhbCA8IDAgPyAtdmFsIDogdmFsKSAv
IDEwMDAsIG1pbiwgbWF4KTsKfQoKCmVudW0gY2hpcF90eXBlcyB7dzgzNzk1ZywgdzgzNzk1YWRn
fTsKCnN0cnVjdCB3ODM3OTVfZGF0YSB7CglzdHJ1Y3QgZGV2aWNlICpod21vbl9kZXY7CglzdHJ1
Y3QgbXV0ZXggdXBkYXRlX2xvY2s7Cgl1bnNpZ25lZCBsb25nIGxhc3RfdXBkYXRlZDsJLyogSW4g
amlmZmllcyAqLwoJZW51bSBjaGlwX3R5cGVzIGNoaXBfdHlwZTsKCgl1OCBiYW5rOwoJdTggdnJt
OwoJdTggdmlkWzNdOwoJdTggaGFzX3ZpZDsgICAgLyogRW5hYmxlIG1vbml0b3IgVklEIG9yIG5v
dCwgYWZmZWN0ZWQgYnkgQ1IgMHg2QSAqLwoKCXUzMiBoYXNfaW47ICAgIC8qIEVuYWJsZSBtb25p
dG9yIFZJTiBvciBub3QsIGFmZmVjdGVkIGJ5IENSIDB4MDIsIDB4MDMgKi8KCXUxNiBpblsyMV1b
M107CQkvKiBSZWdpc3RlciB2YWx1ZSwgcmVhZC9oaWdoL2xvdyAqLwoJdTggaW5fbHNiWzEwXVsz
XTsJCS8qIExTQiBSZWdpc3RlciB2YWx1ZSwgaGlnaC9sb3cgKi8KCXU4IGhhc19nYWluOyAgICAg
ICAgLyogaGFzIGdhaW46IGluMTcgLWluMjAgKiA4ICovCgoJdTE2IGhhc19mYW47CQkvKiBFbmFi
bGUgZmFuMTQtMSBvciBub3QsIGFmZmVjdGVkIGJ5IENSIDB4MDYsIDB4MDcgKi8KCXUxNiBmYW5b
MTRdOwkJLyogUmVnaXN0ZXIgdmFsdWUgY29tYmluZSAqLwoJdTE2IGZhbl9taW5bMTRdOwkvKiBS
ZWdpc3RlciB2YWx1ZSBjb21iaW5lICovCgoJdTggaGFzX3RlbXA7ICAgICAgLyogRW5hYmxlIG1v
bml0b3IgdGVtcDYtMSBvciBub3QsIGFmZmVjdGVkIGJ5IENSIDB4MDQsIDB4MDUgKi8KCXU4IHRl
bXBbNl1bNV07CQkvKiBjdXJyZW50LCBjcml0LCBjcml0X2h5c3QsIHdhcm4sIHdhcm5faHlzdCAq
LwoJdTggdGVtcF9yZWFkX3ZybHNiWzZdOwoJdTggdGVtcF9tb2RlOwkvKiBiaXQgMDogVFIgbW9k
ZSwgYml0IDE6IFREIG1vZGUgKi8KCXU4IHRlbXBfc3JjWzNdOyAgIC8qIFJlZ2lzdGVyIHZhbHVl
ICovCgoJdTggZW5hYmxlX2R0czsgICAgLyogRW5hYmxlIFBFQ0kgYW5kIFNCLVRTSSwgCgkqIGJp
dCAwOiA9MSBlbmFibGUsID0wIGRpc2FibGUgLCAKCSogYml0IDE6ID0xIEFNRCBTQi1UU0ksID0w
IEludGVsIFBFQ0kgKi8KCXU4IGhhc19kdHM7ICAgICAgLyogRW5hYmxlIG1vbml0b3IgRFRTIHRl
bXAgKi8KCXU4IGR0c1s4XTsgICAgICAgLyogUmVnaXN0ZXIgdmFsdWUgKi8KCXU4IGR0c19yZWFk
X3ZybHNiWzhdOyAgLyogUmVnaXN0ZXIgdmFsdWUgKi8KCXU4IGR0c19leHRbNF07ICAgLyogUmVn
aXN0ZXIgdmFsdWUgKi8KCgl1MzIgaW5fZmF1bHQ7ICAgCgl1MTYgZmFuX2ZhdWx0OyAgCgl1OCAg
ZmF1bHRfZW5hYmxlOyAgIC8qIGJpdCAwOiBpbiwgYml0IDE6IGZhbiAqLwoKCXU4IGhhc19wd207
ICAgIC8qIDc5NWcgc3VwcG9ydHMgOCBwd20sIDc5NWFkZyBvbmx5IHN1cHBvcnRzIDIsIG5vIGNv
bmZpZyByZWdpc3Rlciwgb25seSBhZmZlY3RlZCBieSBjaGlwIHR5cGUgKi8KCXU4IHB3bVs4XVs1
XTsJCS8qIFJlZ2lzdGVyIHZhbHVlLCBvdXRwdXQsIHN0YXJ0LCBub24gc3RvcCwgc3RvcCB0aW1l
LCBkaXYgKi8KCXU4IHB3bV9mY21zWzJdOyAgIC8qIFJlZ2lzdGVyIHZhbHVlICovCgl1OCBwd21f
dGZtcls2XTsgICAvKiBSZWdpc3RlciB2YWx1ZSAqLwoJdTggcHdtX2ZvbWM7ICAgICAgLyogUmVn
aXN0ZXIgdmFsdWUgKi8KCgl1MTYgdGFyZ2V0X3NwZWVkWzhdOyAvKiBSZWdpc3RlciB2YWx1ZSwg
dGFyZ2V0IHNwZWVkIGZvciBzcGVlZCBjcnVpc2UgKi8KCXU4IHRvbF9zcGVlZDsgICAgICAgLyog
dG9sZXJhbmNlIG9mIHRhcmdldCBzcGVlZCAqLwoJdTggcHdtX3RlbXBbNl1bNF07ICAvKiBUVFRJ
LCBDVEZTLCBIQ1QsIEhPVCAqLwoJdTggc2Y0X3JlZ1s2XVsyXVs3XTsgICAvKiA2IHRlbXAsIHRl
bXAvZGNwd20sIDcgcmVnaXN0ZXJzICovCgoJdTggc2V0dXBfcHdtWzNdOyAgLyogUmVnaXN0ZXIg
dmFsdWUgKi8KCgl1OCBhbGFybXNbNl07ICAgICAvKiBSZWdpc3RlciB2YWx1ZSAqLwoJdTggYmVl
cHNbNl07ICAgICAgLyogUmVnaXN0ZXIgdmFsdWUgKi8KCXU4IGJlZXBfZW5hYmxlOwoKCWNoYXIg
dmFsaWQ7Cn07CgpzdGF0aWMgdTggdzgzNzk1X3JlYWRfdmFsdWUoc3RydWN0IGkyY19jbGllbnQg
KmNsaWVudCwgdTE2IHJlZyk7CnN0YXRpYyBpbnQgdzgzNzk1X3dyaXRlX3ZhbHVlKHN0cnVjdCBp
MmNfY2xpZW50ICpjbGllbnQsIHUxNiByZWcsIHU4IHZhbHVlKTsKc3RhdGljIGludCB3ODM3OTVf
cHJvYmUoc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCwKCQkJY29uc3Qgc3RydWN0IGkyY19kZXZp
Y2VfaWQgKmlkKTsKc3RhdGljIGludCB3ODM3OTVfZGV0ZWN0KHN0cnVjdCBpMmNfY2xpZW50ICpj
bGllbnQsIGludCBraW5kLAoJCQkgc3RydWN0IGkyY19ib2FyZF9pbmZvICppbmZvKTsKc3RhdGlj
IGludCB3ODM3OTVfcmVtb3ZlKHN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQpOwoKc3RhdGljIHZv
aWQgdzgzNzk1X2luaXRfY2xpZW50KHN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQpOwpzdGF0aWMg
c3RydWN0IHc4Mzc5NV9kYXRhICp3ODM3OTVfdXBkYXRlX2RldmljZShzdHJ1Y3QgZGV2aWNlICpk
ZXYpOwoKc3RhdGljIGNvbnN0IHN0cnVjdCBpMmNfZGV2aWNlX2lkIHc4Mzc5NV9pZFtdID0gewoJ
eyAidzgzNzk1IiwgdzgzNzk1IH0sCgl7IH0KfTsKTU9EVUxFX0RFVklDRV9UQUJMRShpMmMsIHc4
Mzc5NV9pZCk7CgpzdGF0aWMgc3RydWN0IGkyY19kcml2ZXIgdzgzNzk1X2RyaXZlciA9IHsKCS5j
bGFzcwkJPSBJMkNfQ0xBU1NfSFdNT04sCgkuZHJpdmVyID0gewoJCSAgIC5uYW1lID0gInc4Mzc5
NSIsCgl9LAoJLnByb2JlCQk9IHc4Mzc5NV9wcm9iZSwKCS5yZW1vdmUJCT0gdzgzNzk1X3JlbW92
ZSwKCS5pZF90YWJsZQk9IHc4Mzc5NV9pZCwKCS5kZXRlY3QJCT0gdzgzNzk1X2RldGVjdCwKCS5h
ZGRyZXNzX2RhdGEJPSAmYWRkcl9kYXRhLAp9OwoKCnN0YXRpYyBzc2l6ZV90CnNob3dfdnJtKHN0
cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsIGNoYXIgKmJ1
ZikKewoJc3RydWN0IHc4Mzc5NV9kYXRhICpkYXRhID0gZGV2X2dldF9kcnZkYXRhKGRldik7Cgly
ZXR1cm4gc3ByaW50ZihidWYsICIlZFxuIiwgZGF0YS0+dnJtKTsKfQoKc3RhdGljIHNzaXplX3QK
c2hvd192aWQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0
ciwgY2hhciAqYnVmKQp7CglzdHJ1Y3QgdzgzNzk1X2RhdGEgKmRhdGEgPSB3ODM3OTVfdXBkYXRl
X2RldmljZShkZXYpOwoJc3RydWN0IHNlbnNvcl9kZXZpY2VfYXR0cmlidXRlXzIgKnNlbnNvcl9h
dHRyID0KCSAgICB0b19zZW5zb3JfZGV2X2F0dHJfMihhdHRyKTsKCWludCBuciA9IHNlbnNvcl9h
dHRyLT5ucjsKCglyZXR1cm4gc3ByaW50ZihidWYsICIlZFxuIiwgdmlkX2Zyb21fcmVnKGRhdGEt
PnZpZFtucl0sIGRhdGEtPnZybSkpOwp9CgpzdGF0aWMgc3NpemVfdApzdG9yZV92cm0oc3RydWN0
IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwKCSAgY29uc3QgY2hh
ciAqYnVmLCBzaXplX3QgY291bnQpCnsKCXN0cnVjdCB3ODM3OTVfZGF0YSAqZGF0YSA9IGRldl9n
ZXRfZHJ2ZGF0YShkZXYpOwoJZGF0YS0+dnJtID0gc2ltcGxlX3N0cnRvdWwoYnVmLCBOVUxMLCAx
MCk7CglyZXR1cm4gY291bnQ7Cn0KCiNkZWZpbmUgQUxBUk1fU1RBVFVTICAgICAgMAojZGVmaW5l
IEJFRVBfRU5BQkxFICAgICAgIDEKc3RhdGljIHNzaXplX3QKc2hvd19hbGFybV9iZWVwKHN0cnVj
dCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsIGNoYXIgKmJ1ZikK
ewoJc3RydWN0IHc4Mzc5NV9kYXRhICpkYXRhID0gdzgzNzk1X3VwZGF0ZV9kZXZpY2UoZGV2KTsK
CXN0cnVjdCBzZW5zb3JfZGV2aWNlX2F0dHJpYnV0ZV8yICpzZW5zb3JfYXR0ciA9CgkgICAgdG9f
c2Vuc29yX2Rldl9hdHRyXzIoYXR0cik7CglpbnQgbnIgPSBzZW5zb3JfYXR0ci0+bnI7CglpbnQg
aW5kZXggPSBzZW5zb3JfYXR0ci0+aW5kZXggPj4gMzsKCWludCBiaXQgPSBzZW5zb3JfYXR0ci0+
aW5kZXggJiAweDA3OwoJdTggdmFsOwoKCWlmIChBTEFSTV9TVEFUVVMgPT0gbnIpIHsKCQl2YWwg
PSAoZGF0YS0+YWxhcm1zW2luZGV4XSA+PiAoYml0KSkgJiAxOwoJfSBlbHNlIHsJCS8qIEJFRVBf
RU5BQkxFICovCgkJdmFsID0gKGRhdGEtPmJlZXBzW2luZGV4XSA+PiAoYml0KSkgJiAxOwoJfQoK
CXJldHVybiBzcHJpbnRmKGJ1ZiwgIiV1XG4iLCB2YWwpOwp9CgpzdGF0aWMgc3NpemVfdApzdG9y
ZV9iZWVwKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIs
CgkgICBjb25zdCBjaGFyICpidWYsIHNpemVfdCBjb3VudCkKewoJc3RydWN0IGkyY19jbGllbnQg
KmNsaWVudCA9IHRvX2kyY19jbGllbnQoZGV2KTsKCXN0cnVjdCB3ODM3OTVfZGF0YSAqZGF0YSA9
IGkyY19nZXRfY2xpZW50ZGF0YShjbGllbnQpOwoJc3RydWN0IHNlbnNvcl9kZXZpY2VfYXR0cmli
dXRlXzIgKnNlbnNvcl9hdHRyID0KCSAgICB0b19zZW5zb3JfZGV2X2F0dHJfMihhdHRyKTsKCWlu
dCBpbmRleCA9IHNlbnNvcl9hdHRyLT5pbmRleCA+PiAzOwoJaW50IHNoaWZ0ID0gc2Vuc29yX2F0
dHItPmluZGV4ICYgMHgwNzsKCXU4IGJlZXBfYml0ID0gMSA8PCBzaGlmdDsKCXU4IHZhbDsKCgl2
YWwgPSBzaW1wbGVfc3RydG91bChidWYsIE5VTEwsIDEwKTsKCWlmICh2YWwgIT0gMCAmJiB2YWwg
IT0gMSkKCQlyZXR1cm4gLUVJTlZBTDsKCgltdXRleF9sb2NrKCZkYXRhLT51cGRhdGVfbG9jayk7
CglkYXRhLT5iZWVwc1tpbmRleF0gPSB3ODM3OTVfcmVhZF92YWx1ZShjbGllbnQsIFc4Mzc5NV9S
RUdfQkVFUChpbmRleCkpOwoJZGF0YS0+YmVlcHNbaW5kZXhdICY9IH5iZWVwX2JpdDsKCWRhdGEt
PmJlZXBzW2luZGV4XSB8PSB2YWwgPDwgc2hpZnQ7Cgl3ODM3OTVfd3JpdGVfdmFsdWUoY2xpZW50
LCBXODM3OTVfUkVHX0JFRVAoaW5kZXgpLCBkYXRhLT5iZWVwc1tpbmRleF0pOwoJbXV0ZXhfdW5s
b2NrKCZkYXRhLT51cGRhdGVfbG9jayk7CgoJcmV0dXJuIGNvdW50Owp9CgpzdGF0aWMgc3NpemVf
dApzaG93X2JlZXBfZW5hYmxlKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9hdHRy
aWJ1dGUgKmF0dHIsIGNoYXIgKmJ1ZikKewoJc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCA9IHRv
X2kyY19jbGllbnQoZGV2KTsKCXN0cnVjdCB3ODM3OTVfZGF0YSAqZGF0YSA9IGkyY19nZXRfY2xp
ZW50ZGF0YShjbGllbnQpOwoJcmV0dXJuIHNwcmludGYoYnVmLCAiJXVcbiIsIGRhdGEtPmJlZXBf
ZW5hYmxlKTsKfQoKc3RhdGljIHNzaXplX3QKc3RvcmVfYmVlcF9lbmFibGUoc3RydWN0IGRldmlj
ZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwKCQkgIGNvbnN0IGNoYXIgKmJ1
Ziwgc2l6ZV90IGNvdW50KQp7CglzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50ID0gdG9faTJjX2Ns
aWVudChkZXYpOwoJc3RydWN0IHc4Mzc5NV9kYXRhICpkYXRhID0gaTJjX2dldF9jbGllbnRkYXRh
KGNsaWVudCk7Cgl1OCB2YWwgPSBzaW1wbGVfc3RydG91bChidWYsIE5VTEwsIDEwKTsKCXU4IHRt
cDsKCglpZiAodmFsICE9IDAgJiYgdmFsICE9IDEpCgkJcmV0dXJuIC1FSU5WQUw7CgoJbXV0ZXhf
bG9jaygmZGF0YS0+dXBkYXRlX2xvY2spOwoJZGF0YS0+YmVlcF9lbmFibGUgPSB2YWw7Cgl0bXAg
PSB3ODM3OTVfcmVhZF92YWx1ZShjbGllbnQsIFc4Mzc5NV9SRUdfQkVFUCg1KSk7Cgl0bXAgJj0g
MHg3ZjsKCXRtcCB8PSB2YWwgPDwgNzsKCXc4Mzc5NV93cml0ZV92YWx1ZShjbGllbnQsIFc4Mzc5
NV9SRUdfQkVFUCg1KSwgdG1wKTsKCW11dGV4X3VubG9jaygmZGF0YS0+dXBkYXRlX2xvY2spOwoK
CXJldHVybiBjb3VudDsKfQoKLyogV3JpdGUgYW55IHZhbHVlIHRvIGNsZWFyIGNoYXNzaXMgYWxh
cm0gKi8Kc3RhdGljIHNzaXplX3QKc3RvcmVfY2hhc3Npc19jbGVhcihzdHJ1Y3QgZGV2aWNlICpk
ZXYsCgkJICAgIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLCBjb25zdCBjaGFyICpidWYs
CgkJICAgIHNpemVfdCBjb3VudCkKewoJc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCA9IHRvX2ky
Y19jbGllbnQoZGV2KTsKCXN0cnVjdCB3ODM3OTVfZGF0YSAqZGF0YSA9IGkyY19nZXRfY2xpZW50
ZGF0YShjbGllbnQpOwoJdTggdmFsOwoKCW11dGV4X2xvY2soJmRhdGEtPnVwZGF0ZV9sb2NrKTsK
CXZhbCA9IHc4Mzc5NV9yZWFkX3ZhbHVlKGNsaWVudCwgVzgzNzk1X1JFR19DTFJfQ0hBU1NJUyk7
Cgl2YWwgfD0gMHg4MDsKCXc4Mzc5NV93cml0ZV92YWx1ZShjbGllbnQsIFc4Mzc5NV9SRUdfQ0xS
X0NIQVNTSVMsIHZhbCk7CgltdXRleF91bmxvY2soJmRhdGEtPnVwZGF0ZV9sb2NrKTsKCXJldHVy
biBjb3VudDsKfQoKI2RlZmluZSBGQU5fSU5QVVQgICAgIDAKI2RlZmluZSBGQU5fTUlOICAgICAg
IDEKc3RhdGljIHNzaXplX3QKc2hvd19mYW4oc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2
aWNlX2F0dHJpYnV0ZSAqYXR0ciwgY2hhciAqYnVmKQp7CglzdHJ1Y3Qgc2Vuc29yX2RldmljZV9h
dHRyaWJ1dGVfMiAqc2Vuc29yX2F0dHIgPQoJICAgIHRvX3NlbnNvcl9kZXZfYXR0cl8yKGF0dHIp
OwoJaW50IG5yID0gc2Vuc29yX2F0dHItPm5yOwoJaW50IGluZGV4ID0gc2Vuc29yX2F0dHItPmlu
ZGV4OwoJc3RydWN0IHc4Mzc5NV9kYXRhICpkYXRhID0gdzgzNzk1X3VwZGF0ZV9kZXZpY2UoZGV2
KTsKCXUxNiB2YWw7CgoJaWYgKEZBTl9JTlBVVCA9PSBucikgewoJCXZhbCA9IGRhdGEtPmZhbltp
bmRleF0gJiAweDBmZmY7Cgl9IGVsc2UgewoJCXZhbCA9IGRhdGEtPmZhbl9taW5baW5kZXhdICYg
MHgwZmZmOwoJfQoKCXJldHVybiBzcHJpbnRmKGJ1ZiwgIiVsdVxuIiwgRkFOX0ZST01fUkVHKHZh
bCkpOwp9CgpzdGF0aWMgc3NpemVfdApzdG9yZV9mYW5fbWluKHN0cnVjdCBkZXZpY2UgKmRldiwg
c3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsCgkgICAgICBjb25zdCBjaGFyICpidWYsIHNp
emVfdCBjb3VudCkKewoJc3RydWN0IHNlbnNvcl9kZXZpY2VfYXR0cmlidXRlXzIgKnNlbnNvcl9h
dHRyID0KCSAgICB0b19zZW5zb3JfZGV2X2F0dHJfMihhdHRyKTsKCWludCBpbmRleCA9IHNlbnNv
cl9hdHRyLT5pbmRleDsKCXN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQgPSB0b19pMmNfY2xpZW50
KGRldik7CglzdHJ1Y3QgdzgzNzk1X2RhdGEgKmRhdGEgPSBpMmNfZ2V0X2NsaWVudGRhdGEoY2xp
ZW50KTsKCXUxNiB2YWwgPSBGQU5fVE9fUkVHKHNpbXBsZV9zdHJ0b3VsKGJ1ZiwgTlVMTCwgMTAp
KTsKCgltdXRleF9sb2NrKCZkYXRhLT51cGRhdGVfbG9jayk7CglkYXRhLT5mYW5fbWluW2luZGV4
XSA9IHZhbDsKCXc4Mzc5NV93cml0ZV92YWx1ZShjbGllbnQsIFc4Mzc5NV9SRUdfRkFOX01JTl9I
TChpbmRleCksCgkJCSAgICh2YWwgPj4gNCkgJiAweGZmKTsKCXZhbCAmPSAweDBmOwoJaWYgKGlu
ZGV4ICUgMSkgewoJCXZhbCA8PD0gNDsKCQl2YWwgfD0gdzgzNzk1X3JlYWRfdmFsdWUoY2xpZW50
LCBXODM3OTVfUkVHX0ZBTl9NSU5fTFNCKGluZGV4KSkgJiAweDBmOwoJfSBlbHNlIHsKCQl2YWwg
fD0gdzgzNzk1X3JlYWRfdmFsdWUoY2xpZW50LCBXODM3OTVfUkVHX0ZBTl9NSU5fTFNCKGluZGV4
KSkgJiAweGYwOwoJfQoJdzgzNzk1X3dyaXRlX3ZhbHVlKGNsaWVudCwgVzgzNzk1X1JFR19GQU5f
TUlOX0xTQihpbmRleCksIHZhbCAmIDB4ZmYpOwoJbXV0ZXhfdW5sb2NrKCZkYXRhLT51cGRhdGVf
bG9jayk7CgoJcmV0dXJuIGNvdW50Owp9CgpzdGF0aWMgc3NpemVfdApzaG93X3B3bShzdHJ1Y3Qg
ZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLCBjaGFyICpidWYpCnsK
CXN0cnVjdCB3ODM3OTVfZGF0YSAqZGF0YSA9IHc4Mzc5NV91cGRhdGVfZGV2aWNlKGRldik7Cglz
dHJ1Y3Qgc2Vuc29yX2RldmljZV9hdHRyaWJ1dGVfMiAqc2Vuc29yX2F0dHIgPQoJICAgIHRvX3Nl
bnNvcl9kZXZfYXR0cl8yKGF0dHIpOwoJaW50IG5yID0gc2Vuc29yX2F0dHItPm5yOwoJaW50IGlu
ZGV4ID0gc2Vuc29yX2F0dHItPmluZGV4OwoJdTE2IHZhbDsKCglzd2l0Y2ggKG5yKSB7CgljYXNl
IFBXTV9TVE9QX1RJTUU6CgkJdmFsID0gVElNRV9GUk9NX1JFRyhkYXRhLT5wd21baW5kZXhdW25y
XSk7CgkJYnJlYWs7CgljYXNlIFBXTV9ESVY6CgkJdmFsID0gVzgzNzk1X1JFR19GT1BGUF9ESVYo
ZGF0YS0+cHdtW2luZGV4XVtucl0gJiAweDBmKTsKCQlicmVhazsKCWRlZmF1bHQ6CgkJdmFsID0g
ZGF0YS0+cHdtW2luZGV4XVtucl07CgkJYnJlYWs7Cgl9CgoJcmV0dXJuIHNwcmludGYoYnVmLCAi
JXVcbiIsIHZhbCk7Cn0KCnN0YXRpYyBzc2l6ZV90CnN0b3JlX3B3bShzdHJ1Y3QgZGV2aWNlICpk
ZXYsIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLAoJICBjb25zdCBjaGFyICpidWYsIHNp
emVfdCBjb3VudCkKewoJc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCA9IHRvX2kyY19jbGllbnQo
ZGV2KTsKCXN0cnVjdCB3ODM3OTVfZGF0YSAqZGF0YSA9IGkyY19nZXRfY2xpZW50ZGF0YShjbGll
bnQpOwoJc3RydWN0IHNlbnNvcl9kZXZpY2VfYXR0cmlidXRlXzIgKnNlbnNvcl9hdHRyID0KCSAg
ICB0b19zZW5zb3JfZGV2X2F0dHJfMihhdHRyKTsKCWludCBuciA9IHNlbnNvcl9hdHRyLT5ucjsK
CWludCBpbmRleCA9IHNlbnNvcl9hdHRyLT5pbmRleDsKCXUxNiB2YWw7CglpbnQgaTsKCgltdXRl
eF9sb2NrKCZkYXRhLT51cGRhdGVfbG9jayk7Cglzd2l0Y2ggKG5yKSB7CgljYXNlIFBXTV9TVE9Q
X1RJTUU6CgkJdmFsID0gVElNRV9UT19SRUcoc2ltcGxlX3N0cnRvdWwoYnVmLCBOVUxMLCAxMCkp
OwoJCWJyZWFrOwoJY2FzZSBQV01fRElWOgoJCXZhbCA9IHNpbXBsZV9zdHJ0b3VsKGJ1ZiwgTlVM
TCwgMTApOwoJCWZvciAoaSA9IDA7IGkgPCAxNjsgaSArKykgewoJCQlpZiAoVzgzNzk1X1JFR19G
T1BGUF9ESVYoaSkgPT0gdmFsKSB7CgkJCQl2YWwgPSBpOwoJCQkJYnJlYWs7CgkJCX0KCQl9CgkJ
aWYgKGkgPj0gMTYpCgkJCWdvdG8gZXJyX2VuZDsKCQl2YWwgfD0gdzgzNzk1X3JlYWRfdmFsdWUo
Y2xpZW50LCBXODM3OTVfUkVHX1BXTShpbmRleCwgbnIpKSAmIDB4ODA7CgkJYnJlYWs7CglkZWZh
dWx0OgoJCXZhbCA9IFNFTlNPUlNfTElNSVQoc2ltcGxlX3N0cnRvdWwoYnVmLCBOVUxMLCAxMCks
IDAsIDB4ZmYpOwoJCWJyZWFrOwoJfQoJdzgzNzk1X3dyaXRlX3ZhbHVlKGNsaWVudCwgVzgzNzk1
X1JFR19QV00oaW5kZXgsIG5yKSwgdmFsKTsKCWRhdGEtPnB3bVtpbmRleF1bbnJdID0gdmFsICYg
MHhmZjsKCW11dGV4X3VubG9jaygmZGF0YS0+dXBkYXRlX2xvY2spOwoJcmV0dXJuIGNvdW50Owpl
cnJfZW5kOgoJbXV0ZXhfdW5sb2NrKCZkYXRhLT51cGRhdGVfbG9jayk7CglyZXR1cm4gLUVJTlZB
TDsKfQoKc3RhdGljIHNzaXplX3QKc2hvd19wd21fZW5hYmxlKHN0cnVjdCBkZXZpY2UgKmRldiwg
c3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsIGNoYXIgKmJ1ZikKewoJc3RydWN0IHNlbnNv
cl9kZXZpY2VfYXR0cmlidXRlXzIgKnNlbnNvcl9hdHRyID0KCSAgICB0b19zZW5zb3JfZGV2X2F0
dHJfMihhdHRyKTsKCXN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQgPSB0b19pMmNfY2xpZW50KGRl
dik7CglzdHJ1Y3QgdzgzNzk1X2RhdGEgKmRhdGEgPSBpMmNfZ2V0X2NsaWVudGRhdGEoY2xpZW50
KTsKCWludCBpbmRleCA9IHNlbnNvcl9hdHRyLT5pbmRleDsKCXU4IHRtcDsKCglpZiAoMSA9PSAo
ZGF0YS0+cHdtX2ZjbXNbMF0gJiAoMSA8PCBpbmRleCkpKSB7CgkJdG1wID0gMjsKCQlnb3RvIG91
dDsKCX0KCWZvciAodG1wID0gMDsgdG1wIDwgNjsgdG1wICsrKSB7CgkJaWYgKGRhdGEtPnB3bV90
Zm1yW3RtcF0gJiAoMSA8PCBpbmRleCkpIHsKCQkJdG1wID0gMzsKCQkJZ290byBvdXQ7CgkJfQoJ
fQoJaWYgKGRhdGEtPnB3bV9mb21jICYgKDEgPDwgaW5kZXgpKQoJCXRtcCA9IDA7CgllbHNlCgkJ
dG1wID0gMTsKCm91dDoKCXJldHVybiBzcHJpbnRmKGJ1ZiwgIiV1XG4iLCB0bXApOwp9CgpzdGF0
aWMgc3NpemVfdApzdG9yZV9wd21fZW5hYmxlKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRl
dmljZV9hdHRyaWJ1dGUgKmF0dHIsCgkgIGNvbnN0IGNoYXIgKmJ1Ziwgc2l6ZV90IGNvdW50KQp7
CglzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50ID0gdG9faTJjX2NsaWVudChkZXYpOwoJc3RydWN0
IHc4Mzc5NV9kYXRhICpkYXRhID0gaTJjX2dldF9jbGllbnRkYXRhKGNsaWVudCk7CglzdHJ1Y3Qg
c2Vuc29yX2RldmljZV9hdHRyaWJ1dGVfMiAqc2Vuc29yX2F0dHIgPQoJICAgIHRvX3NlbnNvcl9k
ZXZfYXR0cl8yKGF0dHIpOwoJaW50IGluZGV4ID0gc2Vuc29yX2F0dHItPmluZGV4OwoJdTggdmFs
ID0gc2ltcGxlX3N0cnRvdWwoYnVmLCBOVUxMLCAxMCk7CglpbnQgaTsKCglpZiAodmFsID4gMikK
CQlyZXR1cm4gLUVJTlZBTDsKCgltdXRleF9sb2NrKCZkYXRhLT51cGRhdGVfbG9jayk7Cglzd2l0
Y2ggKHZhbCkgewoJY2FzZSAwOgoJY2FzZSAxOgoJCWRhdGEtPnB3bV9mY21zWzBdICY9IH4oMSA8
PCBpbmRleCk7CgkJdzgzNzk1X3dyaXRlX3ZhbHVlKGNsaWVudCwgVzgzNzk1X1JFR19GQ01TMSwg
CgkJCWRhdGEtPnB3bV9mY21zWzBdKTsKCQlmb3IgKGkgPSAwOyBpIDwgNjsgaSArKykgewoJCQlk
YXRhLT5wd21fdGZtcltpXSAmPSB+KDEgPDwgaW5kZXgpOwoJCQl3ODM3OTVfd3JpdGVfdmFsdWUo
Y2xpZW50LCBXODM3OTVfUkVHX1RGTVIoaSksCgkJCQlkYXRhLT5wd21fdGZtcltpXSk7CgkJfQoJ
CWRhdGEtPnB3bV9mb21jIHw9IDEgPDwgaW5kZXg7CgkJZGF0YS0+cHdtX2ZvbWMgXj0gdmFsIDw8
IGluZGV4OwoJCXc4Mzc5NV93cml0ZV92YWx1ZShjbGllbnQsIFc4Mzc5NV9SRUdfRk9NQywKCQkJ
ZGF0YS0+cHdtX2ZvbWMpOwoJCWJyZWFrOwoJY2FzZSAyOgoJCWRhdGEtPnB3bV9mY21zWzBdIHw9
ICgxIDw8IGluZGV4KTsKCQl3ODM3OTVfd3JpdGVfdmFsdWUoY2xpZW50LCBXODM3OTVfUkVHX0ZD
TVMxLCAKCQkJZGF0YS0+cHdtX2ZjbXNbMF0pOwoJCWJyZWFrOwoJfQoJbXV0ZXhfdW5sb2NrKCZk
YXRhLT51cGRhdGVfbG9jayk7CglyZXR1cm4gY291bnQ7CgoJbXV0ZXhfdW5sb2NrKCZkYXRhLT51
cGRhdGVfbG9jayk7CglyZXR1cm4gLUVJTlZBTDsKfQoKc3RhdGljIHNzaXplX3QKc2hvd190ZW1w
X3NyYyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLCBj
aGFyICpidWYpCnsKCXN0cnVjdCBzZW5zb3JfZGV2aWNlX2F0dHJpYnV0ZV8yICpzZW5zb3JfYXR0
ciA9CgkgICAgdG9fc2Vuc29yX2Rldl9hdHRyXzIoYXR0cik7CglzdHJ1Y3QgaTJjX2NsaWVudCAq
Y2xpZW50ID0gdG9faTJjX2NsaWVudChkZXYpOwoJc3RydWN0IHc4Mzc5NV9kYXRhICpkYXRhID0g
aTJjX2dldF9jbGllbnRkYXRhKGNsaWVudCk7CglpbnQgaW5kZXggPSBzZW5zb3JfYXR0ci0+aW5k
ZXg7Cgl1OCB2YWwgPSBpbmRleCAvIDI7Cgl1OCB0bXAgPSBkYXRhLT50ZW1wX3NyY1t2YWxdOwoK
CWlmIChpbmRleCAlIDEpCgkJdmFsID0gNDsKCWVsc2UKCQl2YWwgPSAwOwoJdG1wID4+PSB2YWw7
Cgl0bXAgJj0gMHgwZjsKCglyZXR1cm4gc3ByaW50ZihidWYsICIldVxuIiwgdG1wKTsKfQoKc3Rh
dGljIHNzaXplX3QKc3RvcmVfdGVtcF9zcmMoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2
aWNlX2F0dHJpYnV0ZSAqYXR0ciwKCSAgY29uc3QgY2hhciAqYnVmLCBzaXplX3QgY291bnQpCnsK
CXN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQgPSB0b19pMmNfY2xpZW50KGRldik7CglzdHJ1Y3Qg
dzgzNzk1X2RhdGEgKmRhdGEgPSBpMmNfZ2V0X2NsaWVudGRhdGEoY2xpZW50KTsKCXN0cnVjdCBz
ZW5zb3JfZGV2aWNlX2F0dHJpYnV0ZV8yICpzZW5zb3JfYXR0ciA9CgkgICAgdG9fc2Vuc29yX2Rl
dl9hdHRyXzIoYXR0cik7CglpbnQgaW5kZXggPSBzZW5zb3JfYXR0ci0+aW5kZXg7Cgl1OCB0bXAg
PSBTRU5TT1JTX0xJTUlUKHNpbXBsZV9zdHJ0b3VsKGJ1ZiwgTlVMTCwgMTApLCAwLCAxNSk7Cgl1
OCB2YWwgPSBpbmRleCAvIDI7CgoJbXV0ZXhfbG9jaygmZGF0YS0+dXBkYXRlX2xvY2spOwoJaWYg
KGluZGV4ICUgMSkgewoJCXRtcCA8PD0gNDsKCQlkYXRhLT50ZW1wX3NyY1t2YWxdICY9IDB4MGY7
Cgl9IGVsc2UgewoJCWRhdGEtPnRlbXBfc3JjW3ZhbF0gJj0gMHhmMDsKCX0KCWRhdGEtPnRlbXBf
c3JjW3ZhbF0gfD0gdG1wOwoJdzgzNzk1X3dyaXRlX3ZhbHVlKGNsaWVudCwgVzgzNzk1X1JFR19U
U1ModmFsKSwgZGF0YS0+dGVtcF9zcmNbdmFsXSk7CgltdXRleF91bmxvY2soJmRhdGEtPnVwZGF0
ZV9sb2NrKTsKCglyZXR1cm4gY291bnQ7Cn0KCiNkZWZpbmUgVEVNUF9QV01fRU5BQkxFICAgMAoj
ZGVmaW5lIFRFTVBfUFdNX0ZBTl9NQVAgIDEKc3RhdGljIHNzaXplX3QKc2hvd190ZW1wX3B3bV9l
bmFibGUoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwg
Y2hhciAqYnVmKQp7CglzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50ID0gdG9faTJjX2NsaWVudChk
ZXYpOwoJc3RydWN0IHc4Mzc5NV9kYXRhICpkYXRhID0gaTJjX2dldF9jbGllbnRkYXRhKGNsaWVu
dCk7CglzdHJ1Y3Qgc2Vuc29yX2RldmljZV9hdHRyaWJ1dGVfMiAqc2Vuc29yX2F0dHIgPQoJICAg
IHRvX3NlbnNvcl9kZXZfYXR0cl8yKGF0dHIpOwoJaW50IG5yID0gc2Vuc29yX2F0dHItPm5yOwoJ
aW50IGluZGV4ID0gc2Vuc29yX2F0dHItPmluZGV4OwoJdTggdG1wID0gMHhmZjsKCglzd2l0Y2gg
KG5yKSB7CgljYXNlIFRFTVBfUFdNX0VOQUJMRToKCQl0bXAgPSAoZGF0YS0+cHdtX2ZjbXNbMV0g
Pj4gaW5kZXgpICYgMTsKCQlpZiAodG1wKQoJCQl0bXAgPSA0OwoJCWVsc2UKCQkJdG1wID0gMzsK
CQlicmVhazsKCWNhc2UgVEVNUF9QV01fRkFOX01BUDoKCQl0bXAgPSBkYXRhLT5wd21fdGZtcltp
bmRleF07CgkJYnJlYWs7Cgl9CgoJcmV0dXJuIHNwcmludGYoYnVmLCAiJXVcbiIsIHRtcCk7Cn0K
CnN0YXRpYyBzc2l6ZV90CnN0b3JlX3RlbXBfcHdtX2VuYWJsZShzdHJ1Y3QgZGV2aWNlICpkZXYs
IHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLAoJICBjb25zdCBjaGFyICpidWYsIHNpemVf
dCBjb3VudCkKewoJc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCA9IHRvX2kyY19jbGllbnQoZGV2
KTsKCXN0cnVjdCB3ODM3OTVfZGF0YSAqZGF0YSA9IGkyY19nZXRfY2xpZW50ZGF0YShjbGllbnQp
OwoJc3RydWN0IHNlbnNvcl9kZXZpY2VfYXR0cmlidXRlXzIgKnNlbnNvcl9hdHRyID0KCSAgICB0
b19zZW5zb3JfZGV2X2F0dHJfMihhdHRyKTsKCWludCBuciA9IHNlbnNvcl9hdHRyLT5ucjsKCWlu
dCBpbmRleCA9IHNlbnNvcl9hdHRyLT5pbmRleDsKCXU4IHRtcCA9IHNpbXBsZV9zdHJ0b3VsKGJ1
ZiwgTlVMTCwgMTApOwoKCXN3aXRjaCAobnIpIHsKCWNhc2UgVEVNUF9QV01fRU5BQkxFOgoJCWlm
ICgodG1wICE9IDMpICYmICh0bXAgIT0gNCkpCgkJCXJldHVybiAtRUlOVkFMOwoJCXRtcCAtPSAz
OwoJCW11dGV4X2xvY2soJmRhdGEtPnVwZGF0ZV9sb2NrKTsKCQlkYXRhLT5wd21fZmNtc1sxXSAm
PSB+KDEgPDwgaW5kZXgpOwoJCWRhdGEtPnB3bV9mY21zWzFdIHw9IHRtcCA8PCBpbmRleDsKCQl3
ODM3OTVfd3JpdGVfdmFsdWUoY2xpZW50LCBXODM3OTVfUkVHX0ZDTVMyLCAKCQkJZGF0YS0+cHdt
X2ZjbXNbMV0pOwoJCW11dGV4X3VubG9jaygmZGF0YS0+dXBkYXRlX2xvY2spOwoJCWJyZWFrOwoJ
Y2FzZSBURU1QX1BXTV9GQU5fTUFQOgoJCW11dGV4X2xvY2soJmRhdGEtPnVwZGF0ZV9sb2NrKTsK
CQl0bXAgPSBTRU5TT1JTX0xJTUlUKHRtcCwgMCwgMHhmZik7CgkJdzgzNzk1X3dyaXRlX3ZhbHVl
KGNsaWVudCwgVzgzNzk1X1JFR19URk1SKGluZGV4KSwgdG1wKTsKCQlkYXRhLT5wd21fdGZtcltp
bmRleF0gPSB0bXA7CgkJbXV0ZXhfdW5sb2NrKCZkYXRhLT51cGRhdGVfbG9jayk7CgkJYnJlYWs7
Cgl9CglyZXR1cm4gY291bnQ7Cn0KCiNkZWZpbmUgRkFOSU5fVEFSR0VUICAgMAojZGVmaW5lIEZB
TklOX1RPTCAgICAgIDEKc3RhdGljIHNzaXplX3QKc2hvd19mYW5pbihzdHJ1Y3QgZGV2aWNlICpk
ZXYsIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLCBjaGFyICpidWYpCnsKCXN0cnVjdCBp
MmNfY2xpZW50ICpjbGllbnQgPSB0b19pMmNfY2xpZW50KGRldik7CglzdHJ1Y3QgdzgzNzk1X2Rh
dGEgKmRhdGEgPSBpMmNfZ2V0X2NsaWVudGRhdGEoY2xpZW50KTsKCXN0cnVjdCBzZW5zb3JfZGV2
aWNlX2F0dHJpYnV0ZV8yICpzZW5zb3JfYXR0ciA9CgkgICAgdG9fc2Vuc29yX2Rldl9hdHRyXzIo
YXR0cik7CglpbnQgbnIgPSBzZW5zb3JfYXR0ci0+bnI7CglpbnQgaW5kZXggPSBzZW5zb3JfYXR0
ci0+aW5kZXg7Cgl1MTYgdG1wID0gMDsKCglzd2l0Y2ggKG5yKSB7CgljYXNlIEZBTklOX1RBUkdF
VDoKCQl0bXAgPSBGQU5fRlJPTV9SRUcoZGF0YS0+dGFyZ2V0X3NwZWVkW2luZGV4XSk7CgkJYnJl
YWs7CgljYXNlIEZBTklOX1RPTDoKCQl0bXAgPSBkYXRhLT50b2xfc3BlZWQ7CgkJYnJlYWs7Cgl9
CgoJcmV0dXJuIHNwcmludGYoYnVmLCAiJXVcbiIsIHRtcCk7Cn0KCnN0YXRpYyBzc2l6ZV90CnN0
b3JlX2ZhbmluKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0
dHIsCgkgIGNvbnN0IGNoYXIgKmJ1Ziwgc2l6ZV90IGNvdW50KQp7CglzdHJ1Y3QgaTJjX2NsaWVu
dCAqY2xpZW50ID0gdG9faTJjX2NsaWVudChkZXYpOwoJc3RydWN0IHc4Mzc5NV9kYXRhICpkYXRh
ID0gaTJjX2dldF9jbGllbnRkYXRhKGNsaWVudCk7CglzdHJ1Y3Qgc2Vuc29yX2RldmljZV9hdHRy
aWJ1dGVfMiAqc2Vuc29yX2F0dHIgPQoJICAgIHRvX3NlbnNvcl9kZXZfYXR0cl8yKGF0dHIpOwoJ
aW50IG5yID0gc2Vuc29yX2F0dHItPm5yOwoJaW50IGluZGV4ID0gc2Vuc29yX2F0dHItPmluZGV4
OwoJdTE2IHZhbCA9IHNpbXBsZV9zdHJ0b3VsKGJ1ZiwgTlVMTCwgMTApOwoKCW11dGV4X2xvY2so
JmRhdGEtPnVwZGF0ZV9sb2NrKTsKCXN3aXRjaCAobnIpIHsKCWNhc2UgRkFOSU5fVEFSR0VUOgoJ
CXZhbCA9IEZBTl9UT19SRUcoU0VOU09SU19MSU1JVCh2YWwsIDAsIDB4ZmZmKSk7CgkJdzgzNzk1
X3dyaXRlX3ZhbHVlKGNsaWVudCwgVzgzNzk1X1JFR19GVFNIKGluZGV4KSwgKHZhbCA+PiA0KSAm
IDB4ZmYpOwoJCXc4Mzc5NV93cml0ZV92YWx1ZShjbGllbnQsIFc4Mzc5NV9SRUdfRlRTTChpbmRl
eCksICh2YWwgPDwgNCkgJiAweGYwKTsKCQlkYXRhLT50YXJnZXRfc3BlZWRbaW5kZXhdID0gdmFs
OwoJCWJyZWFrOwoJY2FzZSBGQU5JTl9UT0w6CgkJdmFsID0gU0VOU09SU19MSU1JVCh2YWwsIDAs
IDB4M2YpOwoJCXc4Mzc5NV93cml0ZV92YWx1ZShjbGllbnQsIFc4Mzc5NV9SRUdfVEZUUywgdmFs
KTsKCQlkYXRhLT50b2xfc3BlZWQgPSB2YWw7CgkJYnJlYWs7Cgl9CgltdXRleF91bmxvY2soJmRh
dGEtPnVwZGF0ZV9sb2NrKTsKCglyZXR1cm4gY291bnQ7Cn0KCgpzdGF0aWMgc3NpemVfdApzaG93
X3RlbXBfcHdtKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0
dHIsIGNoYXIgKmJ1ZikKewoJc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCA9IHRvX2kyY19jbGll
bnQoZGV2KTsKCXN0cnVjdCB3ODM3OTVfZGF0YSAqZGF0YSA9IGkyY19nZXRfY2xpZW50ZGF0YShj
bGllbnQpOwoJc3RydWN0IHNlbnNvcl9kZXZpY2VfYXR0cmlidXRlXzIgKnNlbnNvcl9hdHRyID0K
CSAgICB0b19zZW5zb3JfZGV2X2F0dHJfMihhdHRyKTsKCWludCBuciA9IHNlbnNvcl9hdHRyLT5u
cjsKCWludCBpbmRleCA9IHNlbnNvcl9hdHRyLT5pbmRleDsKCWxvbmcgdG1wID0gVEVNUF9GUk9N
X1JFRyhkYXRhLT5wd21fdGVtcFtpbmRleF1bbnJdKTsKCglyZXR1cm4gc3ByaW50ZihidWYsICIl
bGRcbiIsIHRtcCk7Cn0KCnN0YXRpYyBzc2l6ZV90CnN0b3JlX3RlbXBfcHdtKHN0cnVjdCBkZXZp
Y2UgKmRldiwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsCgkgIGNvbnN0IGNoYXIgKmJ1
Ziwgc2l6ZV90IGNvdW50KQp7CglzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50ID0gdG9faTJjX2Ns
aWVudChkZXYpOwoJc3RydWN0IHc4Mzc5NV9kYXRhICpkYXRhID0gaTJjX2dldF9jbGllbnRkYXRh
KGNsaWVudCk7CglzdHJ1Y3Qgc2Vuc29yX2RldmljZV9hdHRyaWJ1dGVfMiAqc2Vuc29yX2F0dHIg
PQoJICAgIHRvX3NlbnNvcl9kZXZfYXR0cl8yKGF0dHIpOwoJaW50IG5yID0gc2Vuc29yX2F0dHIt
Pm5yOwoJaW50IGluZGV4ID0gc2Vuc29yX2F0dHItPmluZGV4OwoJdTggdmFsID0gc2ltcGxlX3N0
cnRvdWwoYnVmLCBOVUxMLCAxMCkgLyAxMDAwOwoJdTggdG1wOwoKCW11dGV4X2xvY2soJmRhdGEt
PnVwZGF0ZV9sb2NrKTsKCXN3aXRjaCAobnIpIHsKCWNhc2UgVEVNUF9QV01fVFRUSToKCQl2YWwg
PSBTRU5TT1JTX0xJTUlUKHZhbCwgMCwgMHg3Zik7CgkJdzgzNzk1X3dyaXRlX3ZhbHVlKGNsaWVu
dCwgVzgzNzk1X1JFR19UVFRJKGluZGV4KSwgdmFsKTsKCQlicmVhazsKCWNhc2UgVEVNUF9QV01f
Q1RGUzoKCQl2YWwgPSBTRU5TT1JTX0xJTUlUKHZhbCwgMCwgMHg3Zik7CgkJdzgzNzk1X3dyaXRl
X3ZhbHVlKGNsaWVudCwgVzgzNzk1X1JFR19DVEZTKGluZGV4KSwgdmFsKTsKCQlicmVhazsKCWNh
c2UgVEVNUF9QV01fSENUOgoJCXZhbCA9IFNFTlNPUlNfTElNSVQodmFsLCAwLCAweDBmKTsKCQl0
bXAgPSB3ODM3OTVfcmVhZF92YWx1ZShjbGllbnQsIFc4Mzc5NV9SRUdfSFQoaW5kZXgpKTsKCQl0
bXAgJj0gMHgwZjsKCQl0bXAgfD0gKHZhbCA8PCA0KSAmIDB4ZjA7CgkJdzgzNzk1X3dyaXRlX3Zh
bHVlKGNsaWVudCwgVzgzNzk1X1JFR19IVChpbmRleCksIHRtcCk7CgkJYnJlYWs7CgljYXNlIFRF
TVBfUFdNX0hPVDoKCQl2YWwgPSBTRU5TT1JTX0xJTUlUKHZhbCwgMCwgMHgwZik7CgkJdG1wID0g
dzgzNzk1X3JlYWRfdmFsdWUoY2xpZW50LCBXODM3OTVfUkVHX0hUKGluZGV4KSk7CgkJdG1wICY9
IDB4ZjA7CgkJdG1wIHw9IHZhbCAmIDB4MGY7CgkJdzgzNzk1X3dyaXRlX3ZhbHVlKGNsaWVudCwg
VzgzNzk1X1JFR19IVChpbmRleCksIHRtcCk7CgkJYnJlYWs7Cgl9CglkYXRhLT5wd21fdGVtcFtp
bmRleF1bbnJdID0gdmFsOwoJbXV0ZXhfdW5sb2NrKCZkYXRhLT51cGRhdGVfbG9jayk7CgoJcmV0
dXJuIGNvdW50Owp9CgpzdGF0aWMgc3NpemVfdApzaG93X3NmNF9wd20oc3RydWN0IGRldmljZSAq
ZGV2LCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwgY2hhciAqYnVmKQp7CglzdHJ1Y3Qg
aTJjX2NsaWVudCAqY2xpZW50ID0gdG9faTJjX2NsaWVudChkZXYpOwoJc3RydWN0IHc4Mzc5NV9k
YXRhICpkYXRhID0gaTJjX2dldF9jbGllbnRkYXRhKGNsaWVudCk7CglzdHJ1Y3Qgc2Vuc29yX2Rl
dmljZV9hdHRyaWJ1dGVfMiAqc2Vuc29yX2F0dHIgPQoJICAgIHRvX3NlbnNvcl9kZXZfYXR0cl8y
KGF0dHIpOwoJaW50IG5yID0gc2Vuc29yX2F0dHItPm5yOwoJaW50IGluZGV4ID0gc2Vuc29yX2F0
dHItPmluZGV4OwoKCXJldHVybiBzcHJpbnRmKGJ1ZiwgIiV1XG4iLCBkYXRhLT5zZjRfcmVnW2lu
ZGV4XVtTRjRfUFdNXVtucl0pOwp9CgpzdGF0aWMgc3NpemVfdApzdG9yZV9zZjRfcHdtKHN0cnVj
dCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsCgkgIGNvbnN0IGNo
YXIgKmJ1Ziwgc2l6ZV90IGNvdW50KQp7CglzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50ID0gdG9f
aTJjX2NsaWVudChkZXYpOwoJc3RydWN0IHc4Mzc5NV9kYXRhICpkYXRhID0gaTJjX2dldF9jbGll
bnRkYXRhKGNsaWVudCk7CglzdHJ1Y3Qgc2Vuc29yX2RldmljZV9hdHRyaWJ1dGVfMiAqc2Vuc29y
X2F0dHIgPQoJICAgIHRvX3NlbnNvcl9kZXZfYXR0cl8yKGF0dHIpOwoJaW50IG5yID0gc2Vuc29y
X2F0dHItPm5yOwoJaW50IGluZGV4ID0gc2Vuc29yX2F0dHItPmluZGV4OwoJdTggdmFsID0gc2lt
cGxlX3N0cnRvdWwoYnVmLCBOVUxMLCAxMCk7CgoJbXV0ZXhfbG9jaygmZGF0YS0+dXBkYXRlX2xv
Y2spOwoJdzgzNzk1X3dyaXRlX3ZhbHVlKGNsaWVudCwgVzgzNzk1X1JFR19TRjRfUFdNKGluZGV4
LCBuciksIHZhbCk7CglkYXRhLT5zZjRfcmVnW2luZGV4XVtTRjRfUFdNXVtucl0gPSB2YWw7Cglt
dXRleF91bmxvY2soJmRhdGEtPnVwZGF0ZV9sb2NrKTsKCglyZXR1cm4gY291bnQ7Cn0KCnN0YXRp
YyBzc2l6ZV90CnNob3dfc2Y0X3RlbXAoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNl
X2F0dHJpYnV0ZSAqYXR0ciwgY2hhciAqYnVmKQp7CglzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50
ID0gdG9faTJjX2NsaWVudChkZXYpOwoJc3RydWN0IHc4Mzc5NV9kYXRhICpkYXRhID0gaTJjX2dl
dF9jbGllbnRkYXRhKGNsaWVudCk7CglzdHJ1Y3Qgc2Vuc29yX2RldmljZV9hdHRyaWJ1dGVfMiAq
c2Vuc29yX2F0dHIgPQoJICAgIHRvX3NlbnNvcl9kZXZfYXR0cl8yKGF0dHIpOwoJaW50IG5yID0g
c2Vuc29yX2F0dHItPm5yOwoJaW50IGluZGV4ID0gc2Vuc29yX2F0dHItPmluZGV4OwoKCXJldHVy
biBzcHJpbnRmKGJ1ZiwgIiV1XG4iLCAKCQkoZGF0YS0+c2Y0X3JlZ1tpbmRleF1bU0Y0X1RFTVBd
W25yXSkgKiAxMDAwKTsKfQoKc3RhdGljIHNzaXplX3QKc3RvcmVfc2Y0X3RlbXAoc3RydWN0IGRl
dmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwKCSAgY29uc3QgY2hhciAq
YnVmLCBzaXplX3QgY291bnQpCnsKCXN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQgPSB0b19pMmNf
Y2xpZW50KGRldik7CglzdHJ1Y3QgdzgzNzk1X2RhdGEgKmRhdGEgPSBpMmNfZ2V0X2NsaWVudGRh
dGEoY2xpZW50KTsKCXN0cnVjdCBzZW5zb3JfZGV2aWNlX2F0dHJpYnV0ZV8yICpzZW5zb3JfYXR0
ciA9CgkgICAgdG9fc2Vuc29yX2Rldl9hdHRyXzIoYXR0cik7CglpbnQgbnIgPSBzZW5zb3JfYXR0
ci0+bnI7CglpbnQgaW5kZXggPSBzZW5zb3JfYXR0ci0+aW5kZXg7Cgl1OCB2YWwgPSBzaW1wbGVf
c3RydG91bChidWYsIE5VTEwsIDEwKSAvIDEwMDA7CgoJbXV0ZXhfbG9jaygmZGF0YS0+dXBkYXRl
X2xvY2spOwoJdzgzNzk1X3dyaXRlX3ZhbHVlKGNsaWVudCwgVzgzNzk1X1JFR19TRjRfVEVNUChp
bmRleCwgbnIpLCB2YWwpOwoJZGF0YS0+c2Y0X3JlZ1tpbmRleF1bU0Y0X1RFTVBdW25yXSA9IHZh
bDsKCW11dGV4X3VubG9jaygmZGF0YS0+dXBkYXRlX2xvY2spOwoKCXJldHVybiBjb3VudDsKfQoK
CgpzdGF0aWMgc3NpemVfdApzaG93X3RlbXAoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2
aWNlX2F0dHJpYnV0ZSAqYXR0ciwgY2hhciAqYnVmKQp7CglzdHJ1Y3Qgc2Vuc29yX2RldmljZV9h
dHRyaWJ1dGVfMiAqc2Vuc29yX2F0dHIgPQoJICAgIHRvX3NlbnNvcl9kZXZfYXR0cl8yKGF0dHIp
OwoJaW50IG5yID0gc2Vuc29yX2F0dHItPm5yOwoJaW50IGluZGV4ID0gc2Vuc29yX2F0dHItPmlu
ZGV4OwoJc3RydWN0IHc4Mzc5NV9kYXRhICpkYXRhID0gdzgzNzk1X3VwZGF0ZV9kZXZpY2UoZGV2
KTsKCWxvbmcgdGVtcCA9IFRFTVBfRlJPTV9SRUcoZGF0YS0+dGVtcFtpbmRleF1bbnJdICYgMHg3
Zik7CgoJaWYgKFRFTVBfUkVBRCA9PSBucikgCQoJCXRlbXAgKz0gKChkYXRhLT50ZW1wX3JlYWRf
dnJsc2JbaW5kZXhdID4+IFZSTFNCX1NISUZUKSAmIDB4MDMpICogMjUwOwoJaWYgKGRhdGEtPnRl
bXBbaW5kZXhdW25yXSAmIDB4ODApCgkJdGVtcCA9IC10ZW1wOwoJcmV0dXJuIHNwcmludGYoYnVm
LCAiJWxkXG4iLCB0ZW1wKTsKfQoKc3RhdGljIHNzaXplX3QKc3RvcmVfdGVtcChzdHJ1Y3QgZGV2
aWNlICpkZXYsIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLAoJICAgY29uc3QgY2hhciAq
YnVmLCBzaXplX3QgY291bnQpCnsKCXN0cnVjdCBzZW5zb3JfZGV2aWNlX2F0dHJpYnV0ZV8yICpz
ZW5zb3JfYXR0ciA9CgkgICAgdG9fc2Vuc29yX2Rldl9hdHRyXzIoYXR0cik7CglpbnQgbnIgPSBz
ZW5zb3JfYXR0ci0+bnI7CglpbnQgaW5kZXggPSBzZW5zb3JfYXR0ci0+aW5kZXg7CglzdHJ1Y3Qg
aTJjX2NsaWVudCAqY2xpZW50ID0gdG9faTJjX2NsaWVudChkZXYpOwoJc3RydWN0IHc4Mzc5NV9k
YXRhICpkYXRhID0gaTJjX2dldF9jbGllbnRkYXRhKGNsaWVudCk7Cglsb25nIHRtcCA9IHNpbXBs
ZV9zdHJ0b2woYnVmLCBOVUxMLCAxMCk7CgoJbXV0ZXhfbG9jaygmZGF0YS0+dXBkYXRlX2xvY2sp
OwoJZGF0YS0+dGVtcFtpbmRleF1bbnJdID0gVEVNUF9UT19SRUcodG1wLCAtMTI4LCAxMjcpOwoJ
dzgzNzk1X3dyaXRlX3ZhbHVlKGNsaWVudCwgVzgzNzk1X1JFR19URU1QW2luZGV4XVtucl0sCgkJ
CSAgIGRhdGEtPnRlbXBbaW5kZXhdW25yXSk7CgltdXRleF91bmxvY2soJmRhdGEtPnVwZGF0ZV9s
b2NrKTsKCXJldHVybiBjb3VudDsKfQoKCnN0YXRpYyBzc2l6ZV90CnNob3dfZHRzX21vZGUoc3Ry
dWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwgY2hhciAqYnVm
KQp7CglzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50ID0gdG9faTJjX2NsaWVudChkZXYpOwoJc3Ry
dWN0IHc4Mzc5NV9kYXRhICpkYXRhID0gaTJjX2dldF9jbGllbnRkYXRhKGNsaWVudCk7CglzdHJ1
Y3Qgc2Vuc29yX2RldmljZV9hdHRyaWJ1dGVfMiAqc2Vuc29yX2F0dHIgPQoJICAgIHRvX3NlbnNv
cl9kZXZfYXR0cl8yKGF0dHIpOwoJaW50IGluZGV4ID0gc2Vuc29yX2F0dHItPmluZGV4OwoJdTgg
dG1wOwoKCWlmIChkYXRhLT5lbmFibGVfZHRzID09IDApCgkJcmV0dXJuIHNwcmludGYoYnVmLCAi
JWRcbiIsIDApOwoJCglpZiAoKGRhdGEtPmhhc19kdHMgPj4gaW5kZXgpICYgMHgwMSkgewoJCWlm
IChkYXRhLT5lbmFibGVfZHRzICYgMikKCQkJdG1wID0gNTsKCQllbHNlCgkJCXRtcCA9IDY7Cgl9
IGVsc2UgewoJCXRtcCA9IDA7Cgl9CgoJcmV0dXJuIHNwcmludGYoYnVmLCAiJWRcbiIsIHRtcCk7
Cn0KCnN0YXRpYyBzc2l6ZV90CnNob3dfZHRzKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRl
dmljZV9hdHRyaWJ1dGUgKmF0dHIsIGNoYXIgKmJ1ZikKewoJc3RydWN0IHNlbnNvcl9kZXZpY2Vf
YXR0cmlidXRlXzIgKnNlbnNvcl9hdHRyID0KCSAgICB0b19zZW5zb3JfZGV2X2F0dHJfMihhdHRy
KTsKCWludCBpbmRleCA9IHNlbnNvcl9hdHRyLT5pbmRleDsKCXN0cnVjdCB3ODM3OTVfZGF0YSAq
ZGF0YSA9IHc4Mzc5NV91cGRhdGVfZGV2aWNlKGRldik7Cglsb25nIHRlbXAgPSBURU1QX0ZST01f
UkVHKGRhdGEtPmR0c1tpbmRleF0gJiAweDdmKTsKCgl0ZW1wICs9ICgoZGF0YS0+ZHRzX3JlYWRf
dnJsc2JbaW5kZXhdID4+IFZSTFNCX1NISUZUKSAmIDB4MDMpICogMjUwOwoJaWYgKGRhdGEtPmR0
c1tpbmRleF0gJiAweDgwKQoJCXRlbXAgPSAtdGVtcDsKCXJldHVybiBzcHJpbnRmKGJ1ZiwgIiVs
ZFxuIiwgdGVtcCk7Cn0KCnN0YXRpYyBzc2l6ZV90CnNob3dfZHRzX2V4dChzdHJ1Y3QgZGV2aWNl
ICpkZXYsIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLCBjaGFyICpidWYpCnsKCXN0cnVj
dCBzZW5zb3JfZGV2aWNlX2F0dHJpYnV0ZV8yICpzZW5zb3JfYXR0ciA9CgkgICAgdG9fc2Vuc29y
X2Rldl9hdHRyXzIoYXR0cik7CglpbnQgbnIgPSBzZW5zb3JfYXR0ci0+bnI7CglzdHJ1Y3QgaTJj
X2NsaWVudCAqY2xpZW50ID0gdG9faTJjX2NsaWVudChkZXYpOwoJc3RydWN0IHc4Mzc5NV9kYXRh
ICpkYXRhID0gaTJjX2dldF9jbGllbnRkYXRhKGNsaWVudCk7Cglsb25nIHRlbXAgPSBURU1QX0ZS
T01fUkVHKGRhdGEtPmR0c19leHRbbnJdICYgMHg3Zik7CgoJaWYgKGRhdGEtPmR0c19leHRbbnJd
ICYgMHg4MCkKCQl0ZW1wID0gLXRlbXA7CglyZXR1cm4gc3ByaW50ZihidWYsICIlbGRcbiIsIHRl
bXApOwp9CgpzdGF0aWMgc3NpemVfdApzdG9yZV9kdHNfZXh0KHN0cnVjdCBkZXZpY2UgKmRldiwg
c3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsCgkgICBjb25zdCBjaGFyICpidWYsIHNpemVf
dCBjb3VudCkKewoJc3RydWN0IHNlbnNvcl9kZXZpY2VfYXR0cmlidXRlXzIgKnNlbnNvcl9hdHRy
ID0KCSAgICB0b19zZW5zb3JfZGV2X2F0dHJfMihhdHRyKTsKCWludCBuciA9IHNlbnNvcl9hdHRy
LT5ucjsKCXN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQgPSB0b19pMmNfY2xpZW50KGRldik7Cglz
dHJ1Y3QgdzgzNzk1X2RhdGEgKmRhdGEgPSBpMmNfZ2V0X2NsaWVudGRhdGEoY2xpZW50KTsKCWxv
bmcgdG1wID0gc2ltcGxlX3N0cnRvbChidWYsIE5VTEwsIDEwKTsKCgltdXRleF9sb2NrKCZkYXRh
LT51cGRhdGVfbG9jayk7CglkYXRhLT5kdHNfZXh0W25yXSA9IFRFTVBfVE9fUkVHKHRtcCwgLTEy
OCwgMTI3KTsKCXc4Mzc5NV93cml0ZV92YWx1ZShjbGllbnQsIFc4Mzc5NV9SRUdfRFRTX0VYVChu
ciksCgkJCSAgIGRhdGEtPmR0c19leHRbbnJdKTsKCW11dGV4X3VubG9jaygmZGF0YS0+dXBkYXRl
X2xvY2spOwoJcmV0dXJuIGNvdW50Owp9CgoKLyoKCVR5cGUgMzogIFRoZXJtYWwgZGlvZGUKICBU
eXBlIDQ6ICBUaGVybWlzdG9yCiAgCglUZW1wNS02LCBkZWZhdWx0IFRSCglUZW1wMS00LCBkZWZh
dWx0IFRECiovCgpzdGF0aWMgc3NpemVfdApzaG93X3RlbXBfbW9kZShzdHJ1Y3QgZGV2aWNlICpk
ZXYsIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLCBjaGFyICpidWYpCnsKCXN0cnVjdCBp
MmNfY2xpZW50ICpjbGllbnQgPSB0b19pMmNfY2xpZW50KGRldik7CglzdHJ1Y3QgdzgzNzk1X2Rh
dGEgKmRhdGEgPSBpMmNfZ2V0X2NsaWVudGRhdGEoY2xpZW50KTsKCXN0cnVjdCBzZW5zb3JfZGV2
aWNlX2F0dHJpYnV0ZV8yICpzZW5zb3JfYXR0ciA9CgkgICAgdG9fc2Vuc29yX2Rldl9hdHRyXzIo
YXR0cik7CglpbnQgaW5kZXggPSBzZW5zb3JfYXR0ci0+aW5kZXg7Cgl1OCB0bXA7CgoJaWYgKGRh
dGEtPmhhc190ZW1wID4+IGluZGV4ICYgMHgwMSkgewoJCWlmIChkYXRhLT50ZW1wX21vZGUgPj4g
aW5kZXggJiAweDAxKSB7CgkJCXRtcCA9IDM7CgkJfSBlbHNlIHsKCQkJdG1wID0gNDsKCQl9Cgl9
IGVsc2UgewoJCXRtcCA9IDA7Cgl9CgoJcmV0dXJuIHNwcmludGYoYnVmLCAiJWRcbiIsIHRtcCk7
Cn0KCnN0YXRpYyBzc2l6ZV90CnN0b3JlX3RlbXBfbW9kZShzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0
cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLAoJCWNvbnN0IGNoYXIgKmJ1Ziwgc2l6ZV90IGNv
dW50KQp7CglzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50ID0gdG9faTJjX2NsaWVudChkZXYpOwoJ
c3RydWN0IHc4Mzc5NV9kYXRhICpkYXRhID0gaTJjX2dldF9jbGllbnRkYXRhKGNsaWVudCk7Cglz
dHJ1Y3Qgc2Vuc29yX2RldmljZV9hdHRyaWJ1dGVfMiAqc2Vuc29yX2F0dHIgPQoJICAgIHRvX3Nl
bnNvcl9kZXZfYXR0cl8yKGF0dHIpOwoJaW50IGluZGV4ID0gc2Vuc29yX2F0dHItPmluZGV4OwoJ
dTggdmFsID0gc2ltcGxlX3N0cnRvdWwoYnVmLCBOVUxMLCAxMCk7Cgl1OCB0bXA7Cgl1MzIgbWFz
azsKCglpZiAoKHZhbCAhPSA0KSAmJiAodmFsICE9IDMpKQoJCXJldHVybiAtRUlOVkFMOwoJaWYg
KChpbmRleCA+IDMpICYmICh2YWwgPT0gMykpCgkJcmV0dXJuIC1FSU5WQUw7CgkKCW11dGV4X2xv
Y2soJmRhdGEtPnVwZGF0ZV9sb2NrKTsKCWlmICh2YWwgPT0gMykgewoJCXZhbCA9IFRFTVBfQ1RS
TF9URDsKCQlkYXRhLT5oYXNfdGVtcCB8PSAxIDw8IGluZGV4OwoJCWRhdGEtPnRlbXBfbW9kZSB8
PSAxIDw8IGluZGV4OwoJfSBlbHNlIGlmICh2YWwgPT0gNCkgewoJCXZhbCA9IFRFTVBfQ1RSTF9U
UjsKCQlkYXRhLT5oYXNfdGVtcCB8PSAxIDw8IGluZGV4OwoJCXRtcCA9IDEgPDwgaW5kZXg7CgkJ
ZGF0YS0+dGVtcF9tb2RlICY9IH50bXA7Cgl9CgoJaWYgKGluZGV4ID4gMykgCgkJdG1wID0gdzgz
Nzk1X3JlYWRfdmFsdWUoY2xpZW50LCBXODM3OTVfUkVHX1RFTVBfQ1RSTDEpOwoJZWxzZSAKCQl0
bXAgPSB3ODM3OTVfcmVhZF92YWx1ZShjbGllbnQsIFc4Mzc5NV9SRUdfVEVNUF9DVFJMMik7CgoJ
bWFzayA9IDB4MDMgPDwgVzgzNzk1X1JFR19URU1QX0NUUkxbaW5kZXhdW1RFTVBfQ1RSTF9TSElG
VF07Cgl0bXAgJj0gfm1hc2s7Cgl0bXAgfD0gVzgzNzk1X1JFR19URU1QX0NUUkxbaW5kZXhdW3Zh
bF07CgoJbWFzayA9IDEgPDwgVzgzNzk1X1JFR19URU1QX0NUUkxbaW5kZXhdW1RFTVBfQ1RSTF9I
QVNJTl9TSElGVF07CglkYXRhLT5oYXNfaW4gJj0gfm1hc2s7CgkKCWlmIChpbmRleCA+IDMpIAoJ
CXc4Mzc5NV93cml0ZV92YWx1ZShjbGllbnQsIFc4Mzc5NV9SRUdfVEVNUF9DVFJMMSwgdG1wKTsK
CWVsc2UKCQl3ODM3OTVfd3JpdGVfdmFsdWUoY2xpZW50LCBXODM3OTVfUkVHX1RFTVBfQ1RSTDIs
IHRtcCk7CgoJbXV0ZXhfdW5sb2NrKCZkYXRhLT51cGRhdGVfbG9jayk7CglyZXR1cm4gY291bnQ7
Cn0KCgovKiBzaG93L3N0b3JlIFZJTiAqLwpzdGF0aWMgc3NpemVfdApzaG93X2luKHN0cnVjdCBk
ZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsIGNoYXIgKmJ1ZikKewoJ
c3RydWN0IHNlbnNvcl9kZXZpY2VfYXR0cmlidXRlXzIgKnNlbnNvcl9hdHRyID0KCSAgICB0b19z
ZW5zb3JfZGV2X2F0dHJfMihhdHRyKTsKCWludCBuciA9IHNlbnNvcl9hdHRyLT5ucjsKCWludCBp
bmRleCA9IHNlbnNvcl9hdHRyLT5pbmRleDsKCXN0cnVjdCB3ODM3OTVfZGF0YSAqZGF0YSA9IHc4
Mzc5NV91cGRhdGVfZGV2aWNlKGRldik7Cgl1MTYgdmFsID0gZGF0YS0+aW5baW5kZXhdW25yXTsK
CXU4IGxzYl9pZHg7CgoJc3dpdGNoIChucikgewoJY2FzZSBJTl9SRUFEOgoJCS8qIGNhbGN1bGF0
ZSB0aGlzIHZhbHVlIGFnYWluIGJ5IHNlbnNvcnMgYXMgc2Vuc29yczMuY29uZiAqLwoJCWlmICgo
aW5kZXggPj0gMTcpICYmCgkJICAgICgoZGF0YS0+aGFzX2dhaW4gPj4gKGluZGV4IC0gMTcpKSAm
IDEpKQoJCQl2YWwgKj0gODsKCQlicmVhazsKCWNhc2UgSU5fTUFYOgoJY2FzZSBJTl9MT1c6CgkJ
bHNiX2lkeCA9IElOX0xTQl9TSElGVF9JRFhbaW5kZXhdW0lOX0xTQl9JRFhdOwoJCXZhbCA8PD0g
MjsKCQl2YWwgfD0gKGRhdGEtPmluX2xzYltsc2JfaWR4XVtucl0gPj4gCgkJCUlOX0xTQl9TSElG
VF9JRFhbbHNiX2lkeF1bSU5fTFNCX1NISUZUXSkgJiAweDAzOwoJCWlmICgoaW5kZXggPj0gMTcp
ICYmCgkJICAgICgoZGF0YS0+aGFzX2dhaW4gPj4gKGluZGV4IC0gMTcpKSAmIDEpKQoJCQl2YWwg
Kj0gODsKCQlicmVhazsKCX0KCXZhbCA9IElOX0ZST01fUkVHKGluZGV4LCB2YWwpOwoKCXJldHVy
biBzcHJpbnRmKGJ1ZiwgIiVkXG4iLCB2YWwpOwp9CgpzdGF0aWMgc3NpemVfdApzdG9yZV9pbihz
dHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLAoJIGNvbnN0
IGNoYXIgKmJ1Ziwgc2l6ZV90IGNvdW50KQp7CglzdHJ1Y3Qgc2Vuc29yX2RldmljZV9hdHRyaWJ1
dGVfMiAqc2Vuc29yX2F0dHIgPQoJICAgIHRvX3NlbnNvcl9kZXZfYXR0cl8yKGF0dHIpOwoJaW50
IG5yID0gc2Vuc29yX2F0dHItPm5yOwoJaW50IGluZGV4ID0gc2Vuc29yX2F0dHItPmluZGV4OwoJ
c3RydWN0IGkyY19jbGllbnQgKmNsaWVudCA9IHRvX2kyY19jbGllbnQoZGV2KTsKCXN0cnVjdCB3
ODM3OTVfZGF0YSAqZGF0YSA9IGkyY19nZXRfY2xpZW50ZGF0YShjbGllbnQpOwoJdTE2IHZhbCA9
IElOX1RPX1JFRyhpbmRleCwgc2ltcGxlX3N0cnRvdWwoYnVmLCBOVUxMLCAxMCkpOwoJdTggdG1w
OwoJdTggbHNiX2lkeDsKCglpZiAoKGluZGV4ID49IDE3KSAmJgoJICAgICgoZGF0YS0+aGFzX2dh
aW4gPj4gKGluZGV4IC0gMTcpKSAmIDEpKQoJCXZhbCAvPSA4OwoJdmFsID0gU0VOU09SU19MSU1J
VCh2YWwsIDAsIDB4M0ZGKTsKCW11dGV4X2xvY2soJmRhdGEtPnVwZGF0ZV9sb2NrKTsKCglsc2Jf
aWR4ID0gSU5fTFNCX1NISUZUX0lEWFtpbmRleF1bSU5fTFNCX0lEWF07Cgl0bXAgPSB3ODM3OTVf
cmVhZF92YWx1ZShjbGllbnQsIElOX0xTQl9SRUcobHNiX2lkeCwgbnIpKTsKCXRtcCAmPSB+KDB4
MDMgPDwgSU5fTFNCX1NISUZUX0lEWFtpbmRleF1bSU5fTFNCX1NISUZUXSk7Cgl0bXAgfD0gKHZh
bCAmIDB4MDMpIDw8IElOX0xTQl9TSElGVF9JRFhbaW5kZXhdW0lOX0xTQl9TSElGVF07Cgl3ODM3
OTVfd3JpdGVfdmFsdWUoY2xpZW50LCBJTl9MU0JfUkVHKGxzYl9pZHgsIG5yKSwgdG1wKTsKCWRh
dGEtPmluX2xzYltsc2JfaWR4XVtucl0gPSB0bXA7CgoJdG1wID0gKHZhbCA+PiAyKSAmIDB4ZmY7
Cgl3ODM3OTVfd3JpdGVfdmFsdWUoY2xpZW50LCBXODM3OTVfUkVHX0lOW2luZGV4XVtucl0sIHRt
cCk7CglkYXRhLT5pbltpbmRleF1bbnJdID0gdG1wOwoKCW11dGV4X3VubG9jaygmZGF0YS0+dXBk
YXRlX2xvY2spOwoJcmV0dXJuIGNvdW50Owp9CgoKc3RhdGljIHNzaXplX3QKc2hvd19lbmFibGUo
c3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwgY2hhciAq
YnVmKQp7CglzdHJ1Y3Qgc2Vuc29yX2RldmljZV9hdHRyaWJ1dGVfMiAqc2Vuc29yX2F0dHIgPQoJ
ICAgIHRvX3NlbnNvcl9kZXZfYXR0cl8yKGF0dHIpOwoJaW50IG5yID0gc2Vuc29yX2F0dHItPm5y
OwoJc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCA9IHRvX2kyY19jbGllbnQoZGV2KTsKCXN0cnVj
dCB3ODM3OTVfZGF0YSAqZGF0YSA9IGkyY19nZXRfY2xpZW50ZGF0YShjbGllbnQpOwoJdTggdmFs
ID0gKGRhdGEtPmZhdWx0X2VuYWJsZSA+PiBucikgJiAxOwoJcmV0dXJuIHNwcmludGYoYnVmLCAi
JXVcbiIsIHZhbCk7Cn0KCgpzdGF0aWMgc3NpemVfdApzdG9yZV9mYXVsdF9lbmFibGUoc3RydWN0
IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwKCSAgICAgIGNvbnN0
IGNoYXIgKmJ1Ziwgc2l6ZV90IGNvdW50KQp7CglzdHJ1Y3Qgc2Vuc29yX2RldmljZV9hdHRyaWJ1
dGVfMiAqc2Vuc29yX2F0dHIgPQoJICAgIHRvX3NlbnNvcl9kZXZfYXR0cl8yKGF0dHIpOwoJc3Ry
dWN0IGkyY19jbGllbnQgKmNsaWVudCA9IHRvX2kyY19jbGllbnQoZGV2KTsKCXN0cnVjdCB3ODM3
OTVfZGF0YSAqZGF0YSA9IGkyY19nZXRfY2xpZW50ZGF0YShjbGllbnQpOwoJaW50IG5yID0gc2Vu
c29yX2F0dHItPm5yOwoJdTggdmFsID0gc2ltcGxlX3N0cnRvdWwoYnVmLCBOVUxMLCAxMCk7Cgl1
MzIgdG1wOwoKCWlmICgodmFsICE9IDEpICYmICh2YWwgIT0gMCkpCgkJcmV0dXJuIC1FSU5WQUw7
CglpZiAoKChkYXRhLT5mYXVsdF9lbmFibGUgPj4gbnIpICYgMSkgPT0gdmFsKQoJCXJldHVybiBj
b3VudDsKCgltdXRleF9sb2NrKCZkYXRhLT51cGRhdGVfbG9jayk7CglkYXRhLT5mYXVsdF9lbmFi
bGUgJj0gfigxIDw8IG5yKTsKCWRhdGEtPmZhdWx0X2VuYWJsZSB8PSB2YWwgPDwgbnI7Cgl0bXAg
PQl3ODM3OTVfcmVhZF92YWx1ZShjbGllbnQsIFc4Mzc5NV9SRUdfRkFVTFRfRU5BQkxFKG5yKSk7
Cgl0bXAgJj0gMHg3ZjsKCXRtcCB8PSB2YWwgPDwgNzsKCXc4Mzc5NV93cml0ZV92YWx1ZShjbGll
bnQsIFc4Mzc5NV9SRUdfRkFVTFRfRU5BQkxFKG5yKSwgdG1wKTsKCW11dGV4X3VubG9jaygmZGF0
YS0+dXBkYXRlX2xvY2spOwoKCXJldHVybiBjb3VudDsKfQoKLyogc2hvdy9zdG9yZSBGQVVMVCAq
LwpzdGF0aWMgc3NpemVfdApzaG93X2ZhdWx0KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRl
dmljZV9hdHRyaWJ1dGUgKmF0dHIsIGNoYXIgKmJ1ZikKewoJc3RydWN0IHNlbnNvcl9kZXZpY2Vf
YXR0cmlidXRlXzIgKnNlbnNvcl9hdHRyID0KCSAgICB0b19zZW5zb3JfZGV2X2F0dHJfMihhdHRy
KTsKCWludCBuciA9IHNlbnNvcl9hdHRyLT5ucjsKCWludCBpbmRleCA9IHNlbnNvcl9hdHRyLT5p
bmRleDsKCXN0cnVjdCB3ODM3OTVfZGF0YSAqZGF0YSA9IHc4Mzc5NV91cGRhdGVfZGV2aWNlKGRl
dik7Cgl1OCB2YWw7CgoJaWYgKG5yID09IElOX0ZBVUxUKQoJCXZhbCA9IChkYXRhLT5pbl9mYXVs
dCA+PiBpbmRleCkgJiAxOwoJZWxzZQoJCXZhbCA9IChkYXRhLT5mYW5fZmF1bHQgPj4gaW5kZXgp
ICYgMTsKCXJldHVybiBzcHJpbnRmKGJ1ZiwgIiVkXG4iLCB2YWwpOwp9CgpzdGF0aWMgc3NpemVf
dApzdG9yZV9mYXVsdChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRl
ICphdHRyLAoJIGNvbnN0IGNoYXIgKmJ1Ziwgc2l6ZV90IGNvdW50KQp7CglzdHJ1Y3Qgc2Vuc29y
X2RldmljZV9hdHRyaWJ1dGVfMiAqc2Vuc29yX2F0dHIgPQoJICAgIHRvX3NlbnNvcl9kZXZfYXR0
cl8yKGF0dHIpOwoJaW50IG5yID0gc2Vuc29yX2F0dHItPm5yOwoJaW50IGluZGV4ID0gc2Vuc29y
X2F0dHItPmluZGV4OwoJc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCA9IHRvX2kyY19jbGllbnQo
ZGV2KTsKCXN0cnVjdCB3ODM3OTVfZGF0YSAqZGF0YSA9IGkyY19nZXRfY2xpZW50ZGF0YShjbGll
bnQpOwoJdTggdmFsID0gc2ltcGxlX3N0cnRvdWwoYnVmLCBOVUxMLCAxMCk7Cgl1OCB0bXA7CgoJ
aWYgKCh2YWwgIT0gMSkgJiYgKHZhbCAhPSAwKSkKCQlyZXR1cm4gLUVJTlZBTDsKCgltdXRleF9s
b2NrKCZkYXRhLT51cGRhdGVfbG9jayk7Cgl0bXAgPSB3ODM3OTVfcmVhZF92YWx1ZShjbGllbnQs
IAoJCVc4Mzc5NV9SRUdfRkFVTFQoRkFVTFRfTlVNKGluZGV4KSwgbnIpKTsKCXRtcCAmPSB+KDEg
PDwgRkFVTFRfU0hJRlQoaW5kZXgpKTsKCXRtcCB8PSB2YWwgPDwgRkFVTFRfU0hJRlQoaW5kZXgp
OwoJdzgzNzk1X3dyaXRlX3ZhbHVlKGNsaWVudCwgCgkJVzgzNzk1X1JFR19GQVVMVChGQVVMVF9O
VU0oaW5kZXgpLCBuciksIHRtcCk7Cglzd2l0Y2ggKG5yKSB7CgljYXNlIElOX0ZBVUxUOgoJCWRh
dGEtPmluX2ZhdWx0IHw9IH4oMSA8PCBpbmRleCk7CgkJZGF0YS0+aW5fZmF1bHQgJj0gdmFsIDw8
IGluZGV4OwoJCWJyZWFrOwoJY2FzZSBGQU5fRkFVTFQ6CgkJZGF0YS0+ZmFuX2ZhdWx0IHw9IH4o
MSA8PCBpbmRleCk7CgkJZGF0YS0+ZmFuX2ZhdWx0ICY9IHZhbCA8PCBpbmRleDsKCQlicmVhazsK
CX0KCW11dGV4X3VubG9jaygmZGF0YS0+dXBkYXRlX2xvY2spOwoJcmV0dXJuIGNvdW50Owp9Cgpz
dGF0aWMgc3NpemVfdApzaG93X3NmX3NldHVwKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRl
dmljZV9hdHRyaWJ1dGUgKmF0dHIsIGNoYXIgKmJ1ZikKewoJc3RydWN0IHNlbnNvcl9kZXZpY2Vf
YXR0cmlidXRlXzIgKnNlbnNvcl9hdHRyID0KCSAgICB0b19zZW5zb3JfZGV2X2F0dHJfMihhdHRy
KTsKCWludCBuciA9IHNlbnNvcl9hdHRyLT5ucjsKCXN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQg
PSB0b19pMmNfY2xpZW50KGRldik7CglzdHJ1Y3QgdzgzNzk1X2RhdGEgKmRhdGEgPSBpMmNfZ2V0
X2NsaWVudGRhdGEoY2xpZW50KTsKCXUxNiB2YWwgPSBkYXRhLT5zZXR1cF9wd21bbnJdOwoKCXN3
aXRjaCAobnIpIHsKCWNhc2UgU0VUVVBfUFdNX1VQVElNRToKCWNhc2UgU0VUVVBfUFdNX0RPV05U
SU1FOgoJCXZhbCA9IFRJTUVfRlJPTV9SRUcodmFsKTsKCQlicmVhazsKCX0KCglyZXR1cm4gc3By
aW50ZihidWYsICIlZFxuIiwgdmFsKTsKfQoKc3RhdGljIHNzaXplX3QKc3RvcmVfc2Zfc2V0dXAo
c3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwKCSBjb25z
dCBjaGFyICpidWYsIHNpemVfdCBjb3VudCkKewoJc3RydWN0IHNlbnNvcl9kZXZpY2VfYXR0cmli
dXRlXzIgKnNlbnNvcl9hdHRyID0KCSAgICB0b19zZW5zb3JfZGV2X2F0dHJfMihhdHRyKTsKCWlu
dCBuciA9IHNlbnNvcl9hdHRyLT5ucjsKCXN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQgPSB0b19p
MmNfY2xpZW50KGRldik7CglzdHJ1Y3QgdzgzNzk1X2RhdGEgKmRhdGEgPSBpMmNfZ2V0X2NsaWVu
dGRhdGEoY2xpZW50KTsKCXU4IHZhbCA9IDA7CgoJc3dpdGNoIChucikgewoJY2FzZSBTRVRVUF9Q
V01fREVGQVVMVDoKCQl2YWwgPSBTRU5TT1JTX0xJTUlUKHNpbXBsZV9zdHJ0b3VsKGJ1ZiwgTlVM
TCwgMTApLCAwLCAweGZmKTsKCQlicmVhazsKCWNhc2UgU0VUVVBfUFdNX1VQVElNRToKCWNhc2Ug
U0VUVVBfUFdNX0RPV05USU1FOgoJCXZhbCA9IFRJTUVfVE9fUkVHKHNpbXBsZV9zdHJ0b3VsKGJ1
ZiwgTlVMTCwgMTApKTsKCQlpZiAodmFsID09IDApCgkJCXJldHVybiAtRUlOVkFMOwoJCWJyZWFr
OwoJfQoKCW11dGV4X2xvY2soJmRhdGEtPnVwZGF0ZV9sb2NrKTsKCWRhdGEtPnNldHVwX3B3bVtu
cl0gPSB2YWw7Cgl3ODM3OTVfd3JpdGVfdmFsdWUoY2xpZW50LCBXODM3OTVfUkVHX1NFVFVQX1BX
TShuciksIHZhbCk7CgltdXRleF91bmxvY2soJmRhdGEtPnVwZGF0ZV9sb2NrKTsKCXJldHVybiBj
b3VudDsKfQoKCiNkZWZpbmUgTk9UX1VTRUQJCQktMQoKI2RlZmluZSBTRU5TT1JfQVRUUl9JTihp
bmRleCkJCVwKCVNFTlNPUl9BVFRSXzIoaW4jI2luZGV4IyNfaW5wdXQsIFNfSVJVR08sIHNob3df
aW4sIE5VTEwsCVwKCQlJTl9SRUFELCBpbmRleCksIFwKCVNFTlNPUl9BVFRSXzIoaW4jI2luZGV4
IyNfaW5wdXRfZmF1bHQsIFNfSVJVR08sCVwKCQlzaG93X2ZhdWx0LCBzdG9yZV9mYXVsdCwgSU5f
RkFVTFQsIGluZGV4KSwgXAoJU0VOU09SX0FUVFJfMihpbiMjaW5kZXgjI19tYXgsIFNfSVJVR08g
fCBTX0lXVVNSLCBzaG93X2luLAlcCgkJc3RvcmVfaW4sIElOX01BWCwgaW5kZXgpLAkJCQlcCglT
RU5TT1JfQVRUUl8yKGluIyNpbmRleCMjX21pbiwgU19JUlVHTyB8IFNfSVdVU1IsIHNob3dfaW4s
CVwKCQlzdG9yZV9pbiwgSU5fTE9XLCBpbmRleCksCQkJCVwKCVNFTlNPUl9BVFRSXzIoaW4jI2lu
ZGV4IyNfYWxhcm0sIFNfSVJVR08sIHNob3dfYWxhcm1fYmVlcCwJXAoJCU5VTEwsIEFMQVJNX1NU
QVRVUywJaW5kZXggKyAoKGluZGV4ID4gMTQpID8gMSA6IDApKSwgXAoJU0VOU09SX0FUVFJfMihp
biMjaW5kZXgjI19iZWVwLCBTX0lXVVNSIHwgU19JUlVHTywJCVwKCQlzaG93X2FsYXJtX2JlZXAs
IHN0b3JlX2JlZXAsIEJFRVBfRU5BQkxFLAkJXAoJCWluZGV4ICsgKChpbmRleCA+IDE0KSA/IDEg
OiAwKSkJCgojZGVmaW5lIFNFTlNPUl9BVFRSX0ZBTihpbmRleCkJCQkJCQlcCglTRU5TT1JfQVRU
Ul8yKGZhbiMjaW5kZXgjI19pbnB1dCwgU19JUlVHTywgc2hvd19mYW4sCQlcCgkJTlVMTCwgRkFO
X0lOUFVULCBpbmRleCAtIDEpLCBcCglTRU5TT1JfQVRUUl8yKGZhbiMjaW5kZXgjI19pbnB1dF9m
YXVsdCwgU19JUlVHTywJCVwKCQlzaG93X2ZhdWx0LCBzdG9yZV9mYXVsdCwgRkFOX0ZBVUxULCBp
bmRleCAtIDEpLCBcCglTRU5TT1JfQVRUUl8yKGZhbiMjaW5kZXgjI19taW4sIFNfSVdVU1IgfCBT
X0lSVUdPLAkJXAoJCXNob3dfZmFuLCBzdG9yZV9mYW5fbWluLCBGQU5fTUlOLCBpbmRleCAtIDEp
LAlcCglTRU5TT1JfQVRUUl8yKGZhbiMjaW5kZXgjI19hbGFybSwgU19JUlVHTywgc2hvd19hbGFy
bV9iZWVwLAlcCgkJTlVMTCwgQUxBUk1fU1RBVFVTLCBpbmRleCArIDMxKSwJCQlcCglTRU5TT1Jf
QVRUUl8yKGZhbiMjaW5kZXgjI19iZWVwLCBTX0lXVVNSIHwgU19JUlVHTywJCVwKCQlzaG93X2Fs
YXJtX2JlZXAsIHN0b3JlX2JlZXAsIEJFRVBfRU5BQkxFLCBpbmRleCArIDMxKQkKCgojZGVmaW5l
IFNFTlNPUl9BVFRSX1BXTShpbmRleCkJCQkJCQlcCglTRU5TT1JfQVRUUl8yKHB3bSMjaW5kZXgs
IFNfSVdVU1IgfCBTX0lSVUdPLCBzaG93X3B3bSwJCVwKCQlzdG9yZV9wd20sIFBXTV9PVVRQVVQs
IGluZGV4IC0gMSksCQkJXAoJU0VOU09SX0FUVFJfMihwd20jI2luZGV4IyNfbm9uc3RvcCwgU19J
V1VTUiB8IFNfSVJVR08sCQlcCgkJc2hvd19wd20sIHN0b3JlX3B3bSwgUFdNX05PTlNUT1AsIGlu
ZGV4IC0gMSksCQlcCglTRU5TT1JfQVRUUl8yKHB3bSMjaW5kZXgjI19zdGFydCwgU19JV1VTUiB8
IFNfSVJVR08sCQlcCgkJc2hvd19wd20sIHN0b3JlX3B3bSwgUFdNX1NUQVJULCBpbmRleCAtIDEp
LAkJXAoJU0VOU09SX0FUVFJfMihwd20jI2luZGV4IyNfc3RvcF90aW1lLCBTX0lXVVNSIHwgU19J
UlVHTywJXAoJCXNob3dfcHdtLCBzdG9yZV9wd20sIFBXTV9TVE9QX1RJTUUsIGluZGV4IC0gMSks
CSBcCglTRU5TT1JfQVRUUl8yKGZhbiMjaW5kZXgjI19kaXYsIFNfSVdVU1IgfCBTX0lSVUdPLAlc
CgkJc2hvd19wd20sIHN0b3JlX3B3bSwgUFdNX0RJViwgaW5kZXggLSAxKSwJIFwKCVNFTlNPUl9B
VFRSXzIocHdtIyNpbmRleCMjX2VuYWJsZSwgU19JV1VTUiB8IFNfSVJVR08sCQlcCgkJc2hvd19w
d21fZW5hYmxlLCBzdG9yZV9wd21fZW5hYmxlLCBOT1RfVVNFRCwgaW5kZXggLSAxKQkJCgojZGVm
aW5lIFNFTlNPUl9BVFRSX0ZBTklOX1RBUkdFVChpbmRleCkJCQkJCQlcCglTRU5TT1JfQVRUUl8y
KHNwZWVkX2NydWlzZSMjaW5kZXgjI190YXJnZXQsIFNfSVdVU1IgfCBTX0lSVUdPLCBcCgkJc2hv
d19mYW5pbiwJc3RvcmVfZmFuaW4sIEZBTklOX1RBUkdFVCwgaW5kZXggLSAxKQkJCgojZGVmaW5l
IFNFTlNPUl9BVFRSX0RUUyhpbmRleCkJCQkJCQlcCglTRU5TT1JfQVRUUl8yKHRlbXAjI2luZGV4
IyNfdHlwZSwgU19JUlVHTyAsCQlcCgkJc2hvd19kdHNfbW9kZSwgTlVMTCwgTk9UX1VTRUQsIGlu
ZGV4IC0gNyksCVwKCVNFTlNPUl9BVFRSXzIodGVtcCMjaW5kZXgjI19pbnB1dCwgU19JUlVHTywg
c2hvd19kdHMsCQlcCgkJTlVMTCwgTk9UX1VTRUQsIGluZGV4IC0gNyksCQkJCVwKCVNFTlNPUl9B
VFRSXzIodGVtcCMjaW5kZXgjI19tYXgsIFNfSVJVR08gfCBTX0lXVVNSLCBzaG93X2R0c19leHQs
CVwKCQlzdG9yZV9kdHNfZXh0LCBEVFNfQ1JJVCwgTk9UX1VTRUQpLAkJCVwKCVNFTlNPUl9BVFRS
XzIodGVtcCMjaW5kZXgjI19tYXhfaHlzdCwgU19JUlVHTyB8IFNfSVdVU1IsCVwKCQlzaG93X2R0
c19leHQsIHN0b3JlX2R0c19leHQsIERUU19DUklUX0hZU1QsIE5PVF9VU0VEKSwJXAoJU0VOU09S
X0FUVFJfMih0ZW1wIyNpbmRleCMjX3dhcm4sIFNfSVJVR08gfCBTX0lXVVNSLCBzaG93X2R0c19l
eHQsCVwKCQlzdG9yZV9kdHNfZXh0LCBEVFNfV0FSTiwgTk9UX1VTRUQpLAkJCVwKCVNFTlNPUl9B
VFRSXzIodGVtcCMjaW5kZXgjI193YXJuX2h5c3QsIFNfSVJVR08gfCBTX0lXVVNSLAlcCgkJc2hv
d19kdHNfZXh0LCBzdG9yZV9kdHNfZXh0LCBEVFNfV0FSTl9IWVNULCBOT1RfVVNFRCksCVwKCVNF
TlNPUl9BVFRSXzIodGVtcCMjaW5kZXgjI19hbGFybSwgU19JUlVHTywJCQlcCgkJc2hvd19hbGFy
bV9iZWVwLCBOVUxMLCBBTEFSTV9TVEFUVVMsIGluZGV4ICsgMTcpLAlcCglTRU5TT1JfQVRUUl8y
KHRlbXAjI2luZGV4IyNfYmVlcCwgU19JV1VTUiB8IFNfSVJVR08sCQlcCgkJc2hvd19hbGFybV9i
ZWVwLCBzdG9yZV9iZWVwLCBCRUVQX0VOQUJMRSwgaW5kZXggKyAxNykKCiNkZWZpbmUgU0VOU09S
X0FUVFJfVEVNUChpbmRleCkJCQkJCQlcCglTRU5TT1JfQVRUUl8yKHRlbXAjI2luZGV4IyNfdHlw
ZSwgU19JUlVHTyB8IFNfSVdVU1IsCQlcCgkJc2hvd190ZW1wX21vZGUsIHN0b3JlX3RlbXBfbW9k
ZSwgTk9UX1VTRUQsIGluZGV4IC0gMSksCVwKCVNFTlNPUl9BVFRSXzIodGVtcCMjaW5kZXgjI19p
bnB1dCwgU19JUlVHTywgc2hvd190ZW1wLAkJXAoJCU5VTEwsIFRFTVBfUkVBRCwgaW5kZXggLSAx
KSwJCQkJXAoJU0VOU09SX0FUVFJfMih0ZW1wIyNpbmRleCMjX21heCwgU19JUlVHTyB8IFNfSVdV
U1IsIHNob3dfdGVtcCwJXAoJCXN0b3JlX3RlbXAsIFRFTVBfQ1JJVCwgaW5kZXggLSAxKSwJCQlc
CglTRU5TT1JfQVRUUl8yKHRlbXAjI2luZGV4IyNfbWF4X2h5c3QsIFNfSVJVR08gfCBTX0lXVVNS
LAlcCgkJc2hvd190ZW1wLCBzdG9yZV90ZW1wLCBURU1QX0NSSVRfSFlTVCwgaW5kZXggLSAxKSwJ
XAoJU0VOU09SX0FUVFJfMih0ZW1wIyNpbmRleCMjX3dhcm4sIFNfSVJVR08gfCBTX0lXVVNSLCBz
aG93X3RlbXAsCVwKCQlzdG9yZV90ZW1wLCBURU1QX1dBUk4sIGluZGV4IC0gMSksCQkJXAoJU0VO
U09SX0FUVFJfMih0ZW1wIyNpbmRleCMjX3dhcm5faHlzdCwgU19JUlVHTyB8IFNfSVdVU1IsCVwK
CQlzaG93X3RlbXAsIHN0b3JlX3RlbXAsIFRFTVBfV0FSTl9IWVNULCBpbmRleCAtIDEpLAlcCglT
RU5TT1JfQVRUUl8yKHRlbXAjI2luZGV4IyNfYWxhcm0sIFNfSVJVR08sCQkJXAoJCXNob3dfYWxh
cm1fYmVlcCwgTlVMTCwgQUxBUk1fU1RBVFVTLCBpbmRleCArIChpbmRleCA+IDQgPyAxMSA6IDE3
KSksCVwKCVNFTlNPUl9BVFRSXzIodGVtcCMjaW5kZXgjI19iZWVwLCBTX0lXVVNSIHwgU19JUlVH
TywJCVwKCQlzaG93X2FsYXJtX2JlZXAsIHN0b3JlX2JlZXAsIEJFRVBfRU5BQkxFLCBpbmRleCAr
IChpbmRleCA+IDQgPyAxMSA6IDE3KSksCVwKCVNFTlNPUl9BVFRSXzIodGVtcCMjaW5kZXgjI19z
b3VyY2Vfc2VsLCBTX0lXVVNSIHwgU19JUlVHTywJCVwKCQlzaG93X3RlbXBfc3JjLCBzdG9yZV90
ZW1wX3NyYywgTk9UX1VTRUQsIGluZGV4IC0gMSksCVwKCVNFTlNPUl9BVFRSXzIodGVtcCMjaW5k
ZXgjI19wd21fZW5hYmxlLCBTX0lXVVNSIHwgU19JUlVHTywJCVwKCQlzaG93X3RlbXBfcHdtX2Vu
YWJsZSwgc3RvcmVfdGVtcF9wd21fZW5hYmxlLCBURU1QX1BXTV9FTkFCTEUsIGluZGV4IC0gMSks
CVwKCVNFTlNPUl9BVFRSXzIodGVtcCMjaW5kZXgjI19hdXRvX2NoYW5uZWxzX3B3bSwgU19JV1VT
UiB8IFNfSVJVR08sCQlcCgkJc2hvd190ZW1wX3B3bV9lbmFibGUsIHN0b3JlX3RlbXBfcHdtX2Vu
YWJsZSwgVEVNUF9QV01fRkFOX01BUCwgaW5kZXggLSAxKSwJXAoJU0VOU09SX0FUVFJfMih0aGVy
bWFsX2NydWlzZSMjaW5kZXgsIFNfSVdVU1IgfCBTX0lSVUdPLAkJXAoJCXNob3dfdGVtcF9wd20s
IHN0b3JlX3RlbXBfcHdtLCBURU1QX1BXTV9UVFRJLCBpbmRleCAtIDEpLAlcCglTRU5TT1JfQVRU
Ul8yKHRlbXAjI2luZGV4IyNfY3JpdCwgU19JV1VTUiB8IFNfSVJVR08sCQlcCgkJc2hvd190ZW1w
X3B3bSwgc3RvcmVfdGVtcF9wd20sIFRFTVBfUFdNX0NURlMsIGluZGV4IC0gMSksCVwKCVNFTlNP
Ul9BVFRSXzIodGVtcCMjaW5kZXgjI19jcml0X2h5c3QsIFNfSVdVU1IgfCBTX0lSVUdPLAkJXAoJ
CXNob3dfdGVtcF9wd20sIHN0b3JlX3RlbXBfcHdtLCBURU1QX1BXTV9IQ1QsIGluZGV4IC0gMSks
CVwKCVNFTlNPUl9BVFRSXzIodGVtcCMjaW5kZXgjI19vcGVyYXRpb25faHlzdCwgU19JV1VTUiB8
IFNfSVJVR08sCQlcCgkJc2hvd190ZW1wX3B3bSwgc3RvcmVfdGVtcF9wd20sIFRFTVBfUFdNX0hP
VCwgaW5kZXggLSAxKSwJXAoJU0VOU09SX0FUVFJfMih0ZW1wIyNpbmRleCMjX2F1dG9fcG9pbnQx
X3B3bSwgU19JUlVHTyB8IFNfSVdVU1IsIFwKCQlzaG93X3NmNF9wd20sIHN0b3JlX3NmNF9wd20s
IDAsIGluZGV4IC0gMSksCQlcCglTRU5TT1JfQVRUUl8yKHRlbXAjI2luZGV4IyNfYXV0b19wb2lu
dDJfcHdtLCBTX0lSVUdPIHwgU19JV1VTUiwgXAoJCXNob3dfc2Y0X3B3bSwgc3RvcmVfc2Y0X3B3
bSwgMSwgaW5kZXggLSAxKSwJCVwKCVNFTlNPUl9BVFRSXzIodGVtcCMjaW5kZXgjI19hdXRvX3Bv
aW50M19wd20sIFNfSVJVR08gfCBTX0lXVVNSLCBcCgkJc2hvd19zZjRfcHdtLCBzdG9yZV9zZjRf
cHdtLCAyLCBpbmRleCAtIDEpLAkJXAoJU0VOU09SX0FUVFJfMih0ZW1wIyNpbmRleCMjX2F1dG9f
cG9pbnQ0X3B3bSwgU19JUlVHTyB8IFNfSVdVU1IsIFwKCQlzaG93X3NmNF9wd20sIHN0b3JlX3Nm
NF9wd20sIDMsIGluZGV4IC0gMSksCQlcCglTRU5TT1JfQVRUUl8yKHRlbXAjI2luZGV4IyNfYXV0
b19wb2ludDVfcHdtLCBTX0lSVUdPIHwgU19JV1VTUiwgXAoJCXNob3dfc2Y0X3B3bSwgc3RvcmVf
c2Y0X3B3bSwgNCwgaW5kZXggLSAxKSwJCVwKCVNFTlNPUl9BVFRSXzIodGVtcCMjaW5kZXgjI19h
dXRvX3BvaW50Nl9wd20sIFNfSVJVR08gfCBTX0lXVVNSLCBcCgkJc2hvd19zZjRfcHdtLCBzdG9y
ZV9zZjRfcHdtLCA1LCBpbmRleCAtIDEpLAkJXAoJU0VOU09SX0FUVFJfMih0ZW1wIyNpbmRleCMj
X2F1dG9fcG9pbnQ3X3B3bSwgU19JUlVHTyB8IFNfSVdVU1IsIFwKCQlzaG93X3NmNF9wd20sIHN0
b3JlX3NmNF9wd20sIDYsIGluZGV4IC0gMSksCQlcCglTRU5TT1JfQVRUUl8yKHRlbXAjI2luZGV4
IyNfYXV0b19wb2ludDFfdGVtcCwgU19JUlVHTyB8IFNfSVdVU1IsXAoJCXNob3dfc2Y0X3RlbXAs
IHN0b3JlX3NmNF90ZW1wLCAwLCBpbmRleCAtIDEpLAkJXAoJU0VOU09SX0FUVFJfMih0ZW1wIyNp
bmRleCMjX2F1dG9fcG9pbnQyX3RlbXAsIFNfSVJVR08gfCBTX0lXVVNSLFwKCQlzaG93X3NmNF90
ZW1wLCBzdG9yZV9zZjRfdGVtcCwgMSwgaW5kZXggLSAxKSwJCVwKCVNFTlNPUl9BVFRSXzIodGVt
cCMjaW5kZXgjI19hdXRvX3BvaW50M190ZW1wLCBTX0lSVUdPIHwgU19JV1VTUixcCgkJc2hvd19z
ZjRfdGVtcCwgc3RvcmVfc2Y0X3RlbXAsIDIsIGluZGV4IC0gMSksCQlcCglTRU5TT1JfQVRUUl8y
KHRlbXAjI2luZGV4IyNfYXV0b19wb2ludDRfdGVtcCwgU19JUlVHTyB8IFNfSVdVU1IsXAoJCXNo
b3dfc2Y0X3RlbXAsIHN0b3JlX3NmNF90ZW1wLCAzLCBpbmRleCAtIDEpLAkJXAoJU0VOU09SX0FU
VFJfMih0ZW1wIyNpbmRleCMjX2F1dG9fcG9pbnQ1X3RlbXAsIFNfSVJVR08gfCBTX0lXVVNSLFwK
CQlzaG93X3NmNF90ZW1wLCBzdG9yZV9zZjRfdGVtcCwgNCwgaW5kZXggLSAxKSwJCVwKCVNFTlNP
Ul9BVFRSXzIodGVtcCMjaW5kZXgjI19hdXRvX3BvaW50Nl90ZW1wLCBTX0lSVUdPIHwgU19JV1VT
UixcCgkJc2hvd19zZjRfdGVtcCwgc3RvcmVfc2Y0X3RlbXAsIDUsIGluZGV4IC0gMSksCQlcCglT
RU5TT1JfQVRUUl8yKHRlbXAjI2luZGV4IyNfYXV0b19wb2ludDdfdGVtcCwgU19JUlVHTyB8IFNf
SVdVU1IsXAoJCXNob3dfc2Y0X3RlbXAsIHN0b3JlX3NmNF90ZW1wLCA2LCBpbmRleCAtIDEpCgoK
CnN0YXRpYyBzdHJ1Y3Qgc2Vuc29yX2RldmljZV9hdHRyaWJ1dGVfMiB3ODM3OTVfaW5bXSA9IHsK
CVNFTlNPUl9BVFRSX0lOKDApLAoJU0VOU09SX0FUVFJfSU4oMSksCglTRU5TT1JfQVRUUl9JTigy
KSwKCVNFTlNPUl9BVFRSX0lOKDMpLAoJU0VOU09SX0FUVFJfSU4oNCksCglTRU5TT1JfQVRUUl9J
Tig1KSwKCVNFTlNPUl9BVFRSX0lOKDYpLAoJU0VOU09SX0FUVFJfSU4oNyksCglTRU5TT1JfQVRU
Ul9JTig4KSwKCVNFTlNPUl9BVFRSX0lOKDkpLAoJU0VOU09SX0FUVFJfSU4oMTApLAoJU0VOU09S
X0FUVFJfSU4oMTEpLAoJU0VOU09SX0FUVFJfSU4oMTIpLAoJU0VOU09SX0FUVFJfSU4oMTMpLAoJ
U0VOU09SX0FUVFJfSU4oMTQpLAoJU0VOU09SX0FUVFJfSU4oMTUpLAoJU0VOU09SX0FUVFJfSU4o
MTYpLAoJU0VOU09SX0FUVFJfSU4oMTcpLAoJU0VOU09SX0FUVFJfSU4oMTgpLAoJU0VOU09SX0FU
VFJfSU4oMTkpLAoJU0VOU09SX0FUVFJfSU4oMjApLAp9OwoKc3RhdGljIHN0cnVjdCBzZW5zb3Jf
ZGV2aWNlX2F0dHJpYnV0ZV8yIHc4Mzc5NV9mYW5bXSA9IHsKCVNFTlNPUl9BVFRSX0ZBTigxKSwK
CVNFTlNPUl9BVFRSX0ZBTigyKSwKCVNFTlNPUl9BVFRSX0ZBTigzKSwKCVNFTlNPUl9BVFRSX0ZB
Tig0KSwKCVNFTlNPUl9BVFRSX0ZBTig1KSwKCVNFTlNPUl9BVFRSX0ZBTig2KSwKCVNFTlNPUl9B
VFRSX0ZBTig3KSwKCVNFTlNPUl9BVFRSX0ZBTig4KSwKCVNFTlNPUl9BVFRSX0ZBTig5KSwKCVNF
TlNPUl9BVFRSX0ZBTigxMCksCglTRU5TT1JfQVRUUl9GQU4oMTEpLAoJU0VOU09SX0FUVFJfRkFO
KDEyKSwKCVNFTlNPUl9BVFRSX0ZBTigxMyksCglTRU5TT1JfQVRUUl9GQU4oMTQpLAp9OwoKc3Rh
dGljIHN0cnVjdCBzZW5zb3JfZGV2aWNlX2F0dHJpYnV0ZV8yIHc4Mzc5NV90ZW1wW10gPSB7CglT
RU5TT1JfQVRUUl9URU1QKDEpLAoJU0VOU09SX0FUVFJfVEVNUCgyKSwKCVNFTlNPUl9BVFRSX1RF
TVAoMyksCglTRU5TT1JfQVRUUl9URU1QKDQpLAoJU0VOU09SX0FUVFJfVEVNUCg1KSwKCVNFTlNP
Ul9BVFRSX1RFTVAoNiksCn07CgpzdGF0aWMgc3RydWN0IHNlbnNvcl9kZXZpY2VfYXR0cmlidXRl
XzIgdzgzNzk1X2R0c1tdID0gewoJU0VOU09SX0FUVFJfRFRTKDcpLAoJU0VOU09SX0FUVFJfRFRT
KDgpLAoJU0VOU09SX0FUVFJfRFRTKDkpLAoJU0VOU09SX0FUVFJfRFRTKDEwKSwKCVNFTlNPUl9B
VFRSX0RUUygxMSksCglTRU5TT1JfQVRUUl9EVFMoMTIpLAoJU0VOU09SX0FUVFJfRFRTKDEzKSwK
CVNFTlNPUl9BVFRSX0RUUygxNCksCn07CgpzdGF0aWMgc3RydWN0IHNlbnNvcl9kZXZpY2VfYXR0
cmlidXRlXzIgdzgzNzk1X3N0YXRpY1tdID0gewoJU0VOU09SX0FUVFJfRkFOSU5fVEFSR0VUKDEp
LAoJU0VOU09SX0FUVFJfRkFOSU5fVEFSR0VUKDIpLAoJU0VOU09SX0FUVFJfRkFOSU5fVEFSR0VU
KDMpLAoJU0VOU09SX0FUVFJfRkFOSU5fVEFSR0VUKDQpLAoJU0VOU09SX0FUVFJfRkFOSU5fVEFS
R0VUKDUpLAoJU0VOU09SX0FUVFJfRkFOSU5fVEFSR0VUKDYpLAoJU0VOU09SX0FUVFJfRkFOSU5f
VEFSR0VUKDcpLAoJU0VOU09SX0FUVFJfRkFOSU5fVEFSR0VUKDgpLAoJU0VOU09SX0FUVFJfUFdN
KDEpLAoJU0VOU09SX0FUVFJfUFdNKDIpLAp9OwoKLyogYWxsIHJlZ2lzdGVycyBleGlzdGVkIGlu
IDc5NWcgdGhhbiA3OTVhZGcsICAgCiAqIGxpa2UgUFdNMyAtIFBXTTggKi8Kc3RhdGljIHN0cnVj
dCBzZW5zb3JfZGV2aWNlX2F0dHJpYnV0ZV8yIHc4Mzc5NV9sZWZ0X3JlZ1tdID0gewoJU0VOU09S
X0FUVFJfUFdNKDMpLAoJU0VOU09SX0FUVFJfUFdNKDQpLAoJU0VOU09SX0FUVFJfUFdNKDUpLAoJ
U0VOU09SX0FUVFJfUFdNKDYpLAoJU0VOU09SX0FUVFJfUFdNKDcpLAoJU0VOU09SX0FUVFJfUFdN
KDgpLAp9OwoKc3RhdGljIHN0cnVjdCBzZW5zb3JfZGV2aWNlX2F0dHJpYnV0ZV8yIHc4Mzc5NV92
aWRbXSA9IHsKCVNFTlNPUl9BVFRSXzIoY3B1MF92aWQsIFNfSVJVR08sIHNob3dfdmlkLCBOVUxM
LCBOT1RfVVNFRCwgMCksCglTRU5TT1JfQVRUUl8yKGNwdTFfdmlkLCBTX0lSVUdPLCBzaG93X3Zp
ZCwgTlVMTCwgTk9UX1VTRUQsIDEpLAoJU0VOU09SX0FUVFJfMihjcHUyX3ZpZCwgU19JUlVHTywg
c2hvd192aWQsIE5VTEwsIE5PVF9VU0VELCAyKSwKfTsKCgpzdGF0aWMgc3RydWN0IHNlbnNvcl9k
ZXZpY2VfYXR0cmlidXRlXzIgc2RhX3NpbmdsZV9maWxlc1tdID0gewoJU0VOU09SX0FUVFJfMih2
cm0sIFNfSVdVU1IgfCBTX0lSVUdPLCBzaG93X3ZybSwgc3RvcmVfdnJtLAoJICAgICAgIE5PVF9V
U0VELCBOT1RfVVNFRCksCglTRU5TT1JfQVRUUl8yKGNoYXNzaXMsIFNfSVdVU1IgfCBTX0lSVUdP
LCBzaG93X2FsYXJtX2JlZXAsCgkJICAgICAgc3RvcmVfY2hhc3Npc19jbGVhciwgQUxBUk1fU1RB
VFVTLCA0NiksCglTRU5TT1JfQVRUUl8yKGJlZXBfZW5hYmxlLCBTX0lXVVNSIHwgU19JUlVHTywg
c2hvd19iZWVwX2VuYWJsZSwKCQkgICAgICBzdG9yZV9iZWVwX2VuYWJsZSwgTk9UX1VTRUQsIE5P
VF9VU0VEKSwKCVNFTlNPUl9BVFRSXzIoc3BlZWRfY3J1aXNlX3RvbGVyYW5jZSwgU19JV1VTUiB8
IFNfSVJVR08sIHNob3dfZmFuaW4sCQoJCXN0b3JlX2ZhbmluLCBGQU5JTl9UT0wsIE5PVF9VU0VE
KSwJCQoJU0VOU09SX0FUVFJfMihpbl9mYXVsdF9lbmFibGUsIFNfSVdVU1IgfCBTX0lSVUdPLCAK
CXNob3dfZW5hYmxlLCBzdG9yZV9mYXVsdF9lbmFibGUsIElOX0ZBVUxULCBOT1RfVVNFRCksCQkK
CVNFTlNPUl9BVFRSXzIoZmFuX2ZhdWx0X2VuYWJsZSwgU19JV1VTUiB8IFNfSVJVR08sIAoJc2hv
d19lbmFibGUsIHN0b3JlX2ZhdWx0X2VuYWJsZSwgRkFOX0ZBVUxULCBOT1RfVVNFRCksCQkKCVNF
TlNPUl9BVFRSXzIocHdtX2RlZmF1bHQsIFNfSVdVU1IgfCBTX0lSVUdPLCBzaG93X3NmX3NldHVw
LAoJCSAgICAgIHN0b3JlX3NmX3NldHVwLCBTRVRVUF9QV01fREVGQVVMVCwgTk9UX1VTRUQpLAoJ
U0VOU09SX0FUVFJfMihwd21fdXB0aW1lLCBTX0lXVVNSIHwgU19JUlVHTywgc2hvd19zZl9zZXR1
cCwKCQkgICAgICBzdG9yZV9zZl9zZXR1cCwgU0VUVVBfUFdNX1VQVElNRSwgTk9UX1VTRUQpLAoJ
U0VOU09SX0FUVFJfMihwd21fZG93bnRpbWUsIFNfSVdVU1IgfCBTX0lSVUdPLCBzaG93X3NmX3Nl
dHVwLAoJCSAgICAgIHN0b3JlX3NmX3NldHVwLCBTRVRVUF9QV01fRE9XTlRJTUUsIE5PVF9VU0VE
KSwKfTsKCgpzdGF0aWMgdm9pZCB3ODM3OTVfaW5pdF9jbGllbnQoc3RydWN0IGkyY19jbGllbnQg
KmNsaWVudCkKewoJaWYgKHJlc2V0KSB7CgkJdzgzNzk1X3dyaXRlX3ZhbHVlKGNsaWVudCwgVzgz
Nzk1X1JFR19DT05GSUcsIDB4ODApOwoJfQoKCS8qIFN0YXJ0IG1vbml0b3JpbmcgKi8KCXc4Mzc5
NV93cml0ZV92YWx1ZShjbGllbnQsIFc4Mzc5NV9SRUdfQ09ORklHLAoJCQkgICB3ODM3OTVfcmVh
ZF92YWx1ZShjbGllbnQsIFc4Mzc5NV9SRUdfQ09ORklHKSB8IDB4MDEpOwp9CgovKiBSZXR1cm4g
MCBpZiBkZXRlY3Rpb24gaXMgc3VjY2Vzc2Z1bCwgLUVOT0RFViBvdGhlcndpc2UgKi8Kc3RhdGlj
IGludCB3ODM3OTVfZGV0ZWN0KHN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQsIGludCBraW5kLAoJ
CQkgc3RydWN0IGkyY19ib2FyZF9pbmZvICppbmZvKQp7Cgl1OCB0bXAsIGJhbms7CglzdHJ1Y3Qg
aTJjX2FkYXB0ZXIgKmFkYXB0ZXIgPSBjbGllbnQtPmFkYXB0ZXI7Cgl1bnNpZ25lZCBzaG9ydCBh
ZGRyZXNzID0gY2xpZW50LT5hZGRyOwoKCWlmICghaTJjX2NoZWNrX2Z1bmN0aW9uYWxpdHkoYWRh
cHRlciwgSTJDX0ZVTkNfU01CVVNfQllURV9EQVRBKSkgewoJCXJldHVybiAtRU5PREVWOwoJfQoJ
YmFuayA9IGkyY19zbWJ1c19yZWFkX2J5dGVfZGF0YShjbGllbnQsIFc4Mzc5NV9SRUdfQkFOS1NF
TCk7CgoJaWYgKGtpbmQgPCAwKSB7CgkJdG1wID0gYmFuayAmIDB4ODAgPyAweDVjIDogMHhhMzsK
CQkvKiBDaGVjayBOdXZvdG9uIHZlbmRvciBJRCAqLwoJCWlmICh0bXAgIT0gaTJjX3NtYnVzX3Jl
YWRfYnl0ZV9kYXRhKGNsaWVudCwKCQkJCQkJCVc4Mzc5NV9SRUdfVkVORE9SSUQpKSB7CgkJCXBy
X2RlYnVnKCJ3ODM3OTU6IERldGVjdGlvbiBmYWlsZWQgYXQgY2hlY2sgIgoJCQkJICJ2ZW5kb3Ig
aWRcbiIpOwoJCQlyZXR1cm4gLUVOT0RFVjsKCQl9CgoJCS8qIElmIE51dm90b24gY2hpcCwgYWRk
cmVzcyBvZiBjaGlwIGFuZCBXODM3OTVfUkVHX0kyQ19BRERSCgkJICAgc2hvdWxkIG1hdGNoICov
CgkJaWYgKChiYW5rICYgMHgwNykgPT0gMAoJCSAmJiAoaTJjX3NtYnVzX3JlYWRfYnl0ZV9kYXRh
KGNsaWVudCwgVzgzNzk1X1JFR19JMkNfQUREUikgJiAweDdmKSAhPQoJCSAgICBhZGRyZXNzKSB7
CgkJCXByX2RlYnVnKCJ3ODM3OTU6IERldGVjdGlvbiBmYWlsZWQgYXQgY2hlY2sgIgoJCQkJICJp
MmMgYWRkclxuIik7CgkJCXJldHVybiAtRU5PREVWOwoJCX0KCX0KCgkvKiBXZSBoYXZlIGVpdGhl
ciBoYWQgYSBmb3JjZSBwYXJhbWV0ZXIsIG9yIHdlIGhhdmUgYWxyZWFkeSBkZXRlY3RlZCB0aGUK
CSAgIE51dm90b24uIERldGVybWluZSB0aGUgY2hpcCB0eXBlIG5vdyAqLwoKCWlmIChraW5kIDw9
IDApIHsKCQlpZiAoMHg3OSA9PSBpMmNfc21idXNfcmVhZF9ieXRlX2RhdGEoY2xpZW50LAoJCSAg
ICAgICAgVzgzNzk1X1JFR19DSElQSUQpKSB7CgkJCWtpbmQgPSB3ODM3OTU7CgkJfSBlbHNlIHsK
CQkJaWYgKGtpbmQgPT0gMCkKCQkJCWRldl93YXJuKCZhZGFwdGVyLT5kZXYsICJ3ODM3OTU6IEln
bm9yaW5nICIKCQkJCQkgIidmb3JjZScgcGFyYW1ldGVyIGZvciB1bmtub3duIGNoaXAgIgoJCQkJ
CSAiYXQgYWRkcmVzcyAweCUwMnhcbiIsIGFkZHJlc3MpOwoJCQlyZXR1cm4gLUVOT0RFVjsKCQl9
Cgl9CgojaWYgMAoJLyogQ2hlY2sgNzk1IGNoaXAgdHlwZTogNzk1RyBvciA3OTVBREcgKi8KCWlm
IChXODM3OTVfUkVHX0NPTkZJR19DT05GSUc0OCAmIAoJCSAgdzgzNzk1X3JlYWRfdmFsdWUoY2xp
ZW50LCBXODM3OTVfUkVHX0NPTkZJRykpIHsKCQlkYXRhLT5jaGlwX3R5cGUgPSB3ODM3OTVhZGc7
Cgl9IGVsc2UgewoJCWRhdGEtPmNoaXBfdHlwZSA9IHc4Mzc5NWc7Cgl9CiNlbmRpZgoKCS8qIEZp
bGwgaW4gdGhlIHJlbWFpbmluZyBjbGllbnQgZmllbGRzIGFuZCBwdXQgaW50byB0aGUgZ2xvYmFs
IGxpc3QgKi8KCXN0cmxjcHkoaW5mby0+dHlwZSwgInc4Mzc5NSIsIEkyQ19OQU1FX1NJWkUpOwoK
CXJldHVybiAwOwp9CgpzdGF0aWMgaW50IHc4Mzc5NV9wcm9iZShzdHJ1Y3QgaTJjX2NsaWVudCAq
Y2xpZW50LCAKCQkJY29uc3Qgc3RydWN0IGkyY19kZXZpY2VfaWQgKmlkKQp7CglpbnQgaTsKCXU4
IHRtcDsKCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZjbGllbnQtPmRldjsKCXN0cnVjdCB3ODM3OTVf
ZGF0YSAqZGF0YTsKCWludCBlcnIgPSAwOwoKCWlmICghKGRhdGEgPSBremFsbG9jKHNpemVvZihz
dHJ1Y3QgdzgzNzk1X2RhdGEpLCBHRlBfS0VSTkVMKSkpIHsKCQllcnIgPSAtRU5PTUVNOwoJCWdv
dG8gZXhpdDsKCX0KCglpMmNfc2V0X2NsaWVudGRhdGEoY2xpZW50LCBkYXRhKTsKCWRhdGEtPmJh
bmsgPSBpMmNfc21idXNfcmVhZF9ieXRlX2RhdGEoY2xpZW50LCBXODM3OTVfUkVHX0JBTktTRUwp
OwoJbXV0ZXhfaW5pdCgmZGF0YS0+dXBkYXRlX2xvY2spOwoKCS8qIEluaXRpYWxpemUgdGhlIGNo
aXAgKi8KCXc4Mzc5NV9pbml0X2NsaWVudChjbGllbnQpOwoKCS8qIENoZWNrIDc5NSBjaGlwIHR5
cGU6IDc5NUcgb3IgNzk1QURHICovCglpZiAoVzgzNzk1X1JFR19DT05GSUdfQ09ORklHNDggJiAK
CQkgIHc4Mzc5NV9yZWFkX3ZhbHVlKGNsaWVudCwgVzgzNzk1X1JFR19DT05GSUcpKSB7CgkJZGF0
YS0+Y2hpcF90eXBlID0gdzgzNzk1YWRnOwoJfSBlbHNlIHsKCQlkYXRhLT5jaGlwX3R5cGUgPSB3
ODM3OTVnOwoJfQoKCWRhdGEtPmhhc19pbiA9IHc4Mzc5NV9yZWFkX3ZhbHVlKGNsaWVudCwgVzgz
Nzk1X1JFR19WT0xUX0NUUkwxKTsKCWRhdGEtPmhhc19pbiB8PSB3ODM3OTVfcmVhZF92YWx1ZShj
bGllbnQsIFc4Mzc5NV9SRUdfVk9MVF9DVFJMMikgPDwgODsKCS8qIFZTRU4xMS05IG5vdCBmb3Ig
Nzk1YWRnICovCglpZiAoZGF0YS0+Y2hpcF90eXBlID09IHc4Mzc5NWFkZykgewoJCWRhdGEtPmhh
c19pbiAmPSAweGY4ZmY7Cgl9CglkYXRhLT5oYXNfZmFuID0gdzgzNzk1X3JlYWRfdmFsdWUoY2xp
ZW50LCBXODM3OTVfUkVHX0ZBTklOX0NUUkwxKTsKCWRhdGEtPmhhc19mYW4gfD0gdzgzNzk1X3Jl
YWRfdmFsdWUoY2xpZW50LCBXODM3OTVfUkVHX0ZBTklOX0NUUkwyKSA8PCA4OwoKCgkvKiBWRFNF
TjEyLTE3IGFuZCBUUjEtNiwgVEQxLTQgdXNlIHNhbWUgcmVnaXN0ZXIgKi8KCXRtcCA9IHc4Mzc5
NV9yZWFkX3ZhbHVlKGNsaWVudCwgVzgzNzk1X1JFR19URU1QX0NUUkwxKTsKCWlmICh0bXAgJiAw
eDIwKSB7CgkJZGF0YS0+ZW5hYmxlX2R0cyA9IDE7Cgl9IGVsc2UgewoJCWRhdGEtPmVuYWJsZV9k
dHMgPSAwOwoJfQoJZGF0YS0+aGFzX3RlbXAgPSAwOwoJZGF0YS0+dGVtcF9tb2RlID0gMDsKCWlm
ICh0bXAgJiAweDA4KSB7CgkJaWYgKHRtcCAmIDB4MDQpIHsKCQkJZGF0YS0+aGFzX3RlbXAgfD0g
MHgyMDsKCQl9IGVsc2UgewoJCQlkYXRhLT5oYXNfaW4gfD0gMHgxMDAwMDsKCQl9Cgl9CglpZiAo
dG1wICYgMHgwMikgewoJCWlmICh0bXAgJiAweDAxKSB7CgkJCWRhdGEtPmhhc190ZW1wIHw9IDB4
MTA7CgkJfSBlbHNlIHsKCQkJZGF0YS0+aGFzX2luIHw9IDB4ODAwMDsKCQl9Cgl9Cgl0bXAgPSB3
ODM3OTVfcmVhZF92YWx1ZShjbGllbnQsIFc4Mzc5NV9SRUdfVEVNUF9DVFJMMik7CglpZiAodG1w
ICYgMHg0MCkgewoJCWRhdGEtPmhhc190ZW1wIHw9IDB4MDg7CgkJaWYgKCEodG1wICYgMHg4MCkp
IHsKCQkJZGF0YS0+dGVtcF9tb2RlIHw9IDB4MDg7CgkJfQoJfSBlbHNlIGlmICh0bXAgJiAweDgw
KSB7CgkJZGF0YS0+aGFzX2luIHw9IDB4MTAwMDAwOwoJfQoJaWYgKHRtcCAmIDB4MTApIHsKCQlk
YXRhLT5oYXNfdGVtcCB8PSAweDA0OwoJCWlmICghKHRtcCAmIDB4MjApKSB7CgkJCWRhdGEtPnRl
bXBfbW9kZSB8PSAweDA0OwoJCX0KCX0gZWxzZSBpZiAodG1wICYgMHgyMCkgewoJCWRhdGEtPmhh
c19pbiB8PSAweDgwMDAwOwoJfQoJaWYgKHRtcCAmIDB4MDQpIHsKCQlkYXRhLT5oYXNfdGVtcCB8
PSAweDAyOwoJCWlmICghKHRtcCAmIDB4MDgpKSB7CgkJCWRhdGEtPnRlbXBfbW9kZSB8PSAweDAy
OwoJCX0KCX0gZWxzZSBpZiAodG1wICYgMHgwOCkgewoJCWRhdGEtPmhhc19pbiB8PSAweDQwMDAw
OwoJfQoJaWYgKHRtcCAmIDB4MDEpIHsKCQlkYXRhLT5oYXNfdGVtcCB8PSAweDAxOwoJCWlmICgh
KHRtcCAmIDB4MDIpKSB7CgkJCWRhdGEtPnRlbXBfbW9kZSB8PSAweDAxOwoJCX0KCX0gZWxzZSBp
ZiAodG1wICYgMHgwMikgewoJCWRhdGEtPmhhc19pbiB8PSAweDIwMDAwOwoJfQoKCS8qIENoZWNr
IERUUyBlbmFibGUgc3RhdHVzICovCglpZiAoZGF0YS0+ZW5hYmxlX2R0cyA9PSAwKSB7CgkJZGF0
YS0+aGFzX2R0cyA9IDA7Cgl9IGVsc2UgewoJCWlmICgxICYgdzgzNzk1X3JlYWRfdmFsdWUoY2xp
ZW50LCBXODM3OTVfUkVHX0RUU0MpKQoJCQlkYXRhLT5lbmFibGVfZHRzIHw9IDI7CgkJZGF0YS0+
aGFzX2R0cyA9CgkJCXc4Mzc5NV9yZWFkX3ZhbHVlKGNsaWVudCwgVzgzNzk1X1JFR19EVFNFKTsK
CX0KCgoJLyogRmlyc3QgdXBkYXRlIHRoZSB2b2x0YWdlcyBtZWFzdXJlZCB2YWx1ZSBhbmQgbGlt
aXRzICovCglmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShkYXRhLT5pbik7IGkrKykgewoJCWlm
ICghKGRhdGEtPmhhc19pbiAmICgxIDw8IGkpKSkgewoJCQljb250aW51ZTsKCQl9CgkJZGF0YS0+
aW5baV1bSU5fTUFYXSA9IAoJCQl3ODM3OTVfcmVhZF92YWx1ZShjbGllbnQsIFc4Mzc5NV9SRUdf
SU5baV1bSU5fTUFYXSk7CgkJZGF0YS0+aW5baV1bSU5fTE9XXSA9IAoJCQl3ODM3OTVfcmVhZF92
YWx1ZShjbGllbnQsIFc4Mzc5NV9SRUdfSU5baV1bSU5fTE9XXSk7CgkJdG1wID0gdzgzNzk1X3Jl
YWRfdmFsdWUoY2xpZW50LCBXODM3OTVfUkVHX0lOW2ldW0lOX1JFQURdKSA8PCAyOwoJCXRtcCB8
PSAodzgzNzk1X3JlYWRfdmFsdWUoY2xpZW50LCBXODM3OTVfUkVHX1ZSTFNCKSA+PiBWUkxTQl9T
SElGVCkgJiAweDAzOwoJCWRhdGEtPmluW2ldW0lOX1JFQURdID0gdG1wOwoJfQoJZm9yIChpID0g
MDsgaSA8IElOX0xTQl9SRUdfTlVNOyBpKyspIHsKCQlkYXRhLT5pbl9sc2JbaV1bSU5fTUFYXSA9
IAoJCQl3ODM3OTVfcmVhZF92YWx1ZShjbGllbnQsIElOX0xTQl9SRUcoaSwgSU5fTUFYKSk7CgkJ
ZGF0YS0+aW5fbHNiW2ldW0lOX0xPV10gPSAKCQkJdzgzNzk1X3JlYWRfdmFsdWUoY2xpZW50LCBJ
Tl9MU0JfUkVHKGksIElOX0xPVykpOwoJfQoJZGF0YS0+aGFzX2dhaW4gPQoJCXc4Mzc5NV9yZWFk
X3ZhbHVlKGNsaWVudCwgVzgzNzk1X1JFR19WTUlHQl9DVFJMKSAmIDB4MGY7CgoJLyogRmlyc3Qg
dXBkYXRlIGZhbiBhbmQgbGltaXRzICovCglmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShkYXRh
LT5mYW4pOyBpKyspIHsKCQlpZiAoIShkYXRhLT5oYXNfZmFuICYgKDEgPDwgaSkpKSB7CgkJCWNv
bnRpbnVlOwoJCX0KCQlkYXRhLT5mYW5fbWluW2ldID0KCQkJdzgzNzk1X3JlYWRfdmFsdWUoY2xp
ZW50LCBXODM3OTVfUkVHX0ZBTl9NSU5fSEwoaSkpIDw8IDQ7CgkJZGF0YS0+ZmFuX21pbltpXSB8
PQoJCSAgKHc4Mzc5NV9yZWFkX3ZhbHVlKGNsaWVudCwgVzgzNzk1X1JFR19GQU5fTUlOX0xTQihp
KSA+PiAKCQkJVzgzNzk1X1JFR19GQU5fTUlOX0xTQl9TSElGVChpKSkpICYgMHgwRjsKCQlkYXRh
LT5mYW5baV0gPQoJCQl3ODM3OTVfcmVhZF92YWx1ZShjbGllbnQsIFc4Mzc5NV9SRUdfRkFOKGkp
KSA8PCA0OwoJCWRhdGEtPmZhbltpXSB8PQoJCSAgKHc4Mzc5NV9yZWFkX3ZhbHVlKGNsaWVudCwg
VzgzNzk1X1JFR19WUkxTQiA+PiA0KSkgJiAweDBGOwoJfQoKCS8qIHRlbXBlcmF0dXJlIGFuZCBs
aW1pdHMgKi8KCWZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKGRhdGEtPnRlbXApOyBpKyspIHsK
CQlpZiAoIShkYXRhLT5oYXNfdGVtcCAmICgxIDw8IGkpKSkKCQkJY29udGludWU7CgkJZGF0YS0+
dGVtcFtpXVtURU1QX0NSSVRdID0gCgkJCXc4Mzc5NV9yZWFkX3ZhbHVlKGNsaWVudCwgVzgzNzk1
X1JFR19URU1QW2ldW1RFTVBfQ1JJVF0pOwoJCWRhdGEtPnRlbXBbaV1bVEVNUF9DUklUX0hZU1Rd
ID0gCgkJCXc4Mzc5NV9yZWFkX3ZhbHVlKGNsaWVudCwgVzgzNzk1X1JFR19URU1QW2ldW1RFTVBf
Q1JJVF9IWVNUXSk7CgkJZGF0YS0+dGVtcFtpXVtURU1QX1dBUk5dID0gCgkJCXc4Mzc5NV9yZWFk
X3ZhbHVlKGNsaWVudCwgVzgzNzk1X1JFR19URU1QW2ldW1RFTVBfV0FSTl0pOwoJCWRhdGEtPnRl
bXBbaV1bVEVNUF9XQVJOX0hZU1RdID0gCgkJCXc4Mzc5NV9yZWFkX3ZhbHVlKGNsaWVudCwgVzgz
Nzk1X1JFR19URU1QW2ldW1RFTVBfV0FSTl9IWVNUXSk7CgkJZGF0YS0+dGVtcFtpXVtURU1QX1JF
QURdID0gCgkJCXc4Mzc5NV9yZWFkX3ZhbHVlKGNsaWVudCwgVzgzNzk1X1JFR19URU1QW2ldW1RF
TVBfUkVBRF0pOwoJCWRhdGEtPnRlbXBfcmVhZF92cmxzYltpXSA9CgkJCXc4Mzc5NV9yZWFkX3Zh
bHVlKGNsaWVudCwgVzgzNzk1X1JFR19WUkxTQik7Cgl9CgoJLyogZHRzIHRlbXBlcmF0dXJlIGFu
ZCBsaW1pdHMgKi8KCWlmIChkYXRhLT5lbmFibGVfZHRzICE9IDApIHsKCQlkYXRhLT5kdHNfZXh0
W0RUU19DUklUXSA9IAoJCQl3ODM3OTVfcmVhZF92YWx1ZShjbGllbnQsIFc4Mzc5NV9SRUdfRFRT
X0VYVChEVFNfQ1JJVCkpOwoJCWRhdGEtPmR0c19leHRbRFRTX0NSSVRfSFlTVF0gPSAKCQkJdzgz
Nzk1X3JlYWRfdmFsdWUoY2xpZW50LCBXODM3OTVfUkVHX0RUU19FWFQoRFRTX0NSSVRfSFlTVCkp
OwoJCWRhdGEtPmR0c19leHRbRFRTX1dBUk5dID0gCgkJCXc4Mzc5NV9yZWFkX3ZhbHVlKGNsaWVu
dCwgVzgzNzk1X1JFR19EVFNfRVhUKERUU19XQVJOKSk7CgkJZGF0YS0+ZHRzX2V4dFtEVFNfV0FS
Tl9IWVNUXSA9IAoJCQl3ODM3OTVfcmVhZF92YWx1ZShjbGllbnQsIFc4Mzc5NV9SRUdfRFRTX0VY
VChEVFNfV0FSTl9IWVNUKSk7CgkJZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUoZGF0YS0+ZHRz
KTsgaSsrKSB7CgkJCWlmICghKGRhdGEtPmhhc19kdHMgJiAoMSA8PCBpKSkpCgkJCQljb250aW51
ZTsKCQkJZGF0YS0+ZHRzW2ldID0gCgkJCQl3ODM3OTVfcmVhZF92YWx1ZShjbGllbnQsIFc4Mzc5
NV9SRUdfRFRTKGkpKTsKCQkJZGF0YS0+ZHRzX3JlYWRfdnJsc2JbaV0gPQoJCQkJdzgzNzk1X3Jl
YWRfdmFsdWUoY2xpZW50LCBXODM3OTVfUkVHX1ZSTFNCKTsKCQl9Cgl9CgoJLyogRmlyc3QgdXBk
YXRlIHRlbXAgc291cmNlIHNlbGN0aW9uICovCglmb3IgKGkgPSAwOyBpIDwgMzsgaSArKykgewoJ
CWRhdGEtPnRlbXBfc3JjW2ldID0gCgkJCXc4Mzc5NV9yZWFkX3ZhbHVlKGNsaWVudCwgVzgzNzk1
X1JFR19UU1MoaSkpOwoJfQoKCS8qIEZpcnN0IHVwZGF0ZSB2b2x0YWdlICYgZmFuIGZhdWx0ICov
CglkYXRhLT5pbl9mYXVsdCA9IHc4Mzc5NV9yZWFkX3ZhbHVlKGNsaWVudCwgCgkJVzgzNzk1X1JF
R19GQVVMVCgwLCBJTl9GQVVMVCkpOwoJZGF0YS0+aW5fZmF1bHQgfD0gdzgzNzk1X3JlYWRfdmFs
dWUoY2xpZW50LCAKCQlXODM3OTVfUkVHX0ZBVUxUKDEsIElOX0ZBVUxUKSkgPDwgODsKCWRhdGEt
PmluX2ZhdWx0IHw9ICh3ODM3OTVfcmVhZF92YWx1ZShjbGllbnQsIAoJCVc4Mzc5NV9SRUdfRkFV
TFQoMiwgSU5fRkFVTFQpKSAmIDB4M2YpIDw8IDE1OwoJZGF0YS0+aW5fZmF1bHQgJj0gZGF0YS0+
aGFzX2luOwoKCWRhdGEtPmZhbl9mYXVsdCA9IHc4Mzc5NV9yZWFkX3ZhbHVlKGNsaWVudCwgCgkJ
VzgzNzk1X1JFR19GQVVMVCgwLCBGQU5fRkFVTFQpKTsKCWRhdGEtPmZhbl9mYXVsdCB8PSAodzgz
Nzk1X3JlYWRfdmFsdWUoY2xpZW50LCAKCQlXODM3OTVfUkVHX0ZBVUxUKDEsIEZBTl9GQVVMVCkp
ICYgMHgzZikgPDwgODsKCWRhdGEtPmZhbl9mYXVsdCAmPSBkYXRhLT5oYXNfZmFuOwoKCXRtcCA9
CXc4Mzc5NV9yZWFkX3ZhbHVlKGNsaWVudCwgCgkJVzgzNzk1X1JFR19GQVVMVF9FTkFCTEUoSU5f
RkFVTFQpKTsKCWlmICh0bXAgJiAweDgwKQoJCWRhdGEtPmZhdWx0X2VuYWJsZSA9IDE7CgllbHNl
CgkJZGF0YS0+ZmF1bHRfZW5hYmxlID0gMDsKCXRtcCA9CXc4Mzc5NV9yZWFkX3ZhbHVlKGNsaWVu
dCwgCgkJVzgzNzk1X1JFR19GQVVMVF9FTkFCTEUoRkFOX0ZBVUxUKSk7CglpZiAodG1wICYgMHg4
MCkKCQlkYXRhLT5mYXVsdF9lbmFibGUgfD0gMHgwMjsKCQoJLyogcHdtIGFuZCBzbWFydCBmYW4g
Ki8KCWlmIChkYXRhLT5jaGlwX3R5cGUgPT0gdzgzNzk1ZykKCQlkYXRhLT5oYXNfcHdtID0gODsK
CWVsc2UKCQlkYXRhLT5oYXNfcHdtID0gMjsKCWRhdGEtPnB3bV9mY21zWzBdID0JdzgzNzk1X3Jl
YWRfdmFsdWUoY2xpZW50LCBXODM3OTVfUkVHX0ZDTVMxKTsKCWRhdGEtPnB3bV9mY21zWzFdID0J
dzgzNzk1X3JlYWRfdmFsdWUoY2xpZW50LCBXODM3OTVfUkVHX0ZDTVMyKTsKCS8qIHc4Mzc5NWFk
ZyBvbmx5IHN1cHBvcnQgcHdtMi0wICovCglmb3IgKGkgPSAwOyBpIDwgVzgzNzk1X1JFR19URU1Q
X05VTTsgaSArKykgewoJCWRhdGEtPnB3bV90Zm1yW2ldID0gCgkJCXc4Mzc5NV9yZWFkX3ZhbHVl
KGNsaWVudCwgVzgzNzk1X1JFR19URk1SKGkpKTsKCX0KCWRhdGEtPnB3bV9mb21jID0gCgkJdzgz
Nzk1X3JlYWRfdmFsdWUoY2xpZW50LCBXODM3OTVfUkVHX0ZPTUMpOwoJZm9yIChpID0gMDsgaSA8
IGRhdGEtPmhhc19wd207IGkgKyspIHsKCQlmb3IgKHRtcCA9IDA7IHRtcCA8IDU7IHRtcCArKykg
ewoJCQlkYXRhLT5wd21baV1bdG1wXSA9CgkJCQl3ODM3OTVfcmVhZF92YWx1ZShjbGllbnQsIFc4
Mzc5NV9SRUdfUFdNKGksIHRtcCkpOwoJCX0KCX0KCWZvciAoaSA9IDA7IGkgPCA4OyBpICsrKSB7
CgkJZGF0YS0+dGFyZ2V0X3NwZWVkW2ldID0gCgkJCXc4Mzc5NV9yZWFkX3ZhbHVlKGNsaWVudCwg
VzgzNzk1X1JFR19GVFNIKGkpKSA8PCA0OwoJCWRhdGEtPnRhcmdldF9zcGVlZFtpXSB8PSAKCQkJ
dzgzNzk1X3JlYWRfdmFsdWUoY2xpZW50LCBXODM3OTVfUkVHX0ZUU0woaSkpID4+IDQ7Cgl9Cglk
YXRhLT50b2xfc3BlZWQgPSAKCQl3ODM3OTVfcmVhZF92YWx1ZShjbGllbnQsIFc4Mzc5NV9SRUdf
VEZUUykgJiAweDNmOwoKCWZvciAoaSA9IDA7IGkgPCBXODM3OTVfUkVHX1RFTVBfTlVNOyBpICsr
KSB7CgkJZGF0YS0+cHdtX3RlbXBbaV1bVEVNUF9QV01fVFRUSV0gPSAKCQkJdzgzNzk1X3JlYWRf
dmFsdWUoY2xpZW50LCBXODM3OTVfUkVHX1RUVEkoaSkpICYgMHg3ZjsKCQlkYXRhLT5wd21fdGVt
cFtpXVtURU1QX1BXTV9DVEZTXSA9IAoJCQl3ODM3OTVfcmVhZF92YWx1ZShjbGllbnQsIFc4Mzc5
NV9SRUdfQ1RGUyhpKSk7CgkJdG1wID0JdzgzNzk1X3JlYWRfdmFsdWUoY2xpZW50LCBXODM3OTVf
UkVHX0hUKGkpKTsKCQlkYXRhLT5wd21fdGVtcFtpXVtURU1QX1BXTV9IQ1RdID0gKHRtcCA+PiA0
KSAmIDB4MGY7IAoJCWRhdGEtPnB3bV90ZW1wW2ldW1RFTVBfUFdNX0hPVF0gPSB0bXAgJiAweDBm
OwoJfQoJZm9yIChpID0gMDsgaSA8IFc4Mzc5NV9SRUdfVEVNUF9OVU07IGkgKyspIHsKCQlmb3Ig
KHRtcCA9IDA7IHRtcCA8IDc7IHRtcCArKykgewoJCQlkYXRhLT5zZjRfcmVnW2ldW1NGNF9URU1Q
XVt0bXBdID0gCgkJCQl3ODM3OTVfcmVhZF92YWx1ZShjbGllbnQsIFc4Mzc5NV9SRUdfU0Y0X1RF
TVAoaSwgdG1wKSk7CgkJCWRhdGEtPnNmNF9yZWdbaV1bU0Y0X1BXTV1bdG1wXSA9IAoJCQkJdzgz
Nzk1X3JlYWRfdmFsdWUoY2xpZW50LCBXODM3OTVfUkVHX1NGNF9QV00oaSwgdG1wKSk7CgkJfQoJ
fQoKCS8qIFNldHVwIFBXTSBSZWdpc3RlciAqLwoJZm9yIChpID0gMDsgaSA8IDM7IGkgKyspIHsK
CQlkYXRhLT5zZXR1cF9wd21baV0gPQoJCQl3ODM3OTVfcmVhZF92YWx1ZShjbGllbnQsIFc4Mzc5
NV9SRUdfU0VUVVBfUFdNKGkpKTsKCX0KCgkvKiB2aWQgKi8KCWRhdGEtPnZybSA9IHZpZF93aGlj
aF92cm0oKTsKCWlmIChkYXRhLT5jaGlwX3R5cGUgPT0gdzgzNzk1YWRnKSB7CgkJZGF0YS0+aGFz
X3ZpZCA9IDA7Cgl9IGVsc2UgewoJCWRhdGEtPmhhc192aWQgPSAKCQkJKHc4Mzc5NV9yZWFkX3Zh
bHVlKGNsaWVudCwgVzgzNzk1X1JFR19WSURfQ1RSTCkgPj4gMykgJiAweDA3OwoJfQoJCgkvKiBh
bGFybSBhbmQgYmVlcCAqLwoJZm9yIChpID0gMDsgaSA8IEFMQVJNX0JFRVBfUkVHX05VTTsgaSAr
KykgewoJCWRhdGEtPmFsYXJtc1tpXSA9IAoJCQl3ODM3OTVfcmVhZF92YWx1ZShjbGllbnQsIFc4
Mzc5NV9SRUdfQUxBUk0oaSkpOwoJCWRhdGEtPmJlZXBzW2ldID0gCgkJCXc4Mzc5NV9yZWFkX3Zh
bHVlKGNsaWVudCwgVzgzNzk1X1JFR19CRUVQKGkpKTsKCX0KCWRhdGEtPmJlZXBfZW5hYmxlID0g
CgkJKHc4Mzc5NV9yZWFkX3ZhbHVlKGNsaWVudCwgVzgzNzk1X1JFR19CRUVQKDUpKSA+PiA3KSAm
IDB4MDE7CgoKCS8qIFJlZ2lzdGVyIHN5c2ZzIGhvb2tzICovCglmb3IgKGkgPSAwOyBpIDwgQVJS
QVlfU0laRSh3ODM3OTVfaW4pOyBpKyspIHsKCQlpZiAoIShkYXRhLT5oYXNfaW4gJiAoMSA8PCAo
aSAvIDYpKSkpIAoJCQljb250aW51ZTsKCQllcnIgPSBkZXZpY2VfY3JlYXRlX2ZpbGUoZGV2LCAm
dzgzNzk1X2luW2ldLmRldl9hdHRyKTsKCQlpZiAoZXJyKQoJCQlnb3RvIGV4aXRfcmVtb3ZlOwoJ
fQoKCWZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKHc4Mzc5NV9mYW4pOyBpKyspIHsKCQlpZiAo
IShkYXRhLT5oYXNfZmFuICYgKDEgPDwgKGkgLyA1KSkpKQoJCQljb250aW51ZTsKCQllcnIgPSBk
ZXZpY2VfY3JlYXRlX2ZpbGUoZGV2LCAmdzgzNzk1X2ZhbltpXS5kZXZfYXR0cik7CgkJaWYgKGVy
cikKCQkJZ290byBleGl0X3JlbW92ZTsKCX0KCglmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRSh3
ODM3OTVfdmlkKTsgaSsrKSB7CgkJaWYgKCEoKGRhdGEtPmhhc192aWQgPj4gaSkgJiAxKSkKCQkJ
Y29udGludWU7CgkJZXJyID0gZGV2aWNlX2NyZWF0ZV9maWxlKGRldiwgJnc4Mzc5NV92aWRbaV0u
ZGV2X2F0dHIpOwoJCWlmIChlcnIpCgkJCWdvdG8gZXhpdF9yZW1vdmU7Cgl9CgoJZm9yIChpID0g
MDsgaSA8IEFSUkFZX1NJWkUoc2RhX3NpbmdsZV9maWxlcyk7IGkrKykgewoJCWVyciA9IGRldmlj
ZV9jcmVhdGVfZmlsZShkZXYsICZzZGFfc2luZ2xlX2ZpbGVzW2ldLmRldl9hdHRyKTsKCQlpZiAo
ZXJyKQoJCQlnb3RvIGV4aXRfcmVtb3ZlOwoJfQoKCWZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpF
KHc4Mzc5NV90ZW1wKTsgaSsrKSB7CgkJaWYgKCEoZGF0YS0+aGFzX3RlbXAgJiAoMSA8PCAoaSAv
IDI5KSkpKQoJCQljb250aW51ZTsKCQllcnIgPSBkZXZpY2VfY3JlYXRlX2ZpbGUoZGV2LCAmdzgz
Nzk1X3RlbXBbaV0uZGV2X2F0dHIpOwoJCWlmIChlcnIpCgkJCWdvdG8gZXhpdF9yZW1vdmU7Cgl9
CgoJaWYgKGRhdGEtPmVuYWJsZV9kdHMgIT0gMCkgewoJCWZvciAoaSA9IDA7IGkgPCBBUlJBWV9T
SVpFKHc4Mzc5NV9kdHMpOyBpKyspIHsKCQkJaWYgKCEoZGF0YS0+aGFzX2R0cyAmICgxIDw8IChp
IC8gOCkpKSkKCQkJCWNvbnRpbnVlOwoJCQllcnIgPSBkZXZpY2VfY3JlYXRlX2ZpbGUoZGV2LCAm
dzgzNzk1X2R0c1tpXS5kZXZfYXR0cik7CgkJCWlmIChlcnIpCgkJCQlnb3RvIGV4aXRfcmVtb3Zl
OwoJCX0KCX0KCglpZiAoZGF0YS0+Y2hpcF90eXBlID09IHc4Mzc5NWcpIHsKCQlmb3IgKGkgPSAw
OyBpIDwgQVJSQVlfU0laRSh3ODM3OTVfbGVmdF9yZWcpOyBpKyspIHsKCQkJZXJyID0gZGV2aWNl
X2NyZWF0ZV9maWxlKGRldiwgJnc4Mzc5NV9sZWZ0X3JlZ1tpXS5kZXZfYXR0cik7CgkJCWlmIChl
cnIpCgkJCQlnb3RvIGV4aXRfcmVtb3ZlOwoJCX0KCX0KCglmb3IgKGkgPSAwOyBpIDwgQVJSQVlf
U0laRSh3ODM3OTVfc3RhdGljKTsgaSsrKSB7CgkJZXJyID0gZGV2aWNlX2NyZWF0ZV9maWxlKGRl
diwgJnc4Mzc5NV9zdGF0aWNbaV0uZGV2X2F0dHIpOwoJCWlmIChlcnIpCgkJCWdvdG8gZXhpdF9y
ZW1vdmU7Cgl9CgoKCWRhdGEtPmh3bW9uX2RldiA9IGh3bW9uX2RldmljZV9yZWdpc3RlcihkZXYp
OwoJaWYgKElTX0VSUihkYXRhLT5od21vbl9kZXYpKSB7CgkJZXJyID0gUFRSX0VSUihkYXRhLT5o
d21vbl9kZXYpOwoJCWdvdG8gZXhpdF9yZW1vdmU7Cgl9CgoJcmV0dXJuIDA7CgoJLyogVW5yZWdp
c3RlciBzeXNmcyBob29rcyAqLwpleGl0X3JlbW92ZToKCWZvciAoaSA9IDA7IGkgPCBBUlJBWV9T
SVpFKHc4Mzc5NV9pbik7IGkrKykKCQlkZXZpY2VfcmVtb3ZlX2ZpbGUoZGV2LCAmdzgzNzk1X2lu
W2ldLmRldl9hdHRyKTsKCglmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRSh3ODM3OTVfZmFuKTsg
aSsrKQoJCWRldmljZV9yZW1vdmVfZmlsZShkZXYsICZ3ODM3OTVfZmFuW2ldLmRldl9hdHRyKTsK
Cglmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShzZGFfc2luZ2xlX2ZpbGVzKTsgaSsrKQoJCWRl
dmljZV9yZW1vdmVfZmlsZShkZXYsICZzZGFfc2luZ2xlX2ZpbGVzW2ldLmRldl9hdHRyKTsKCglm
b3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRSh3ODM3OTVfdmlkKTsgaSsrKSB7CgkJaWYgKCEoKGRh
dGEtPmhhc192aWQgPj4gaSkgJiAxKSkKCQkJY29udGludWU7CgkJZGV2aWNlX3JlbW92ZV9maWxl
KGRldiwgJnc4Mzc5NV92aWRbaV0uZGV2X2F0dHIpOwoJfQoKCWlmIChkYXRhLT5jaGlwX3R5cGUg
PT0gdzgzNzk1ZykgewoJCWZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKHc4Mzc5NV9sZWZ0X3Jl
Zyk7IGkrKykKCQkJZGV2aWNlX3JlbW92ZV9maWxlKGRldiwgJnc4Mzc5NV9sZWZ0X3JlZ1tpXS5k
ZXZfYXR0cik7Cgl9CgoJZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUodzgzNzk1X3RlbXApOyBp
KyspCgkJZGV2aWNlX3JlbW92ZV9maWxlKGRldiwgJnc4Mzc5NV90ZW1wW2ldLmRldl9hdHRyKTsK
Cglmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRSh3ODM3OTVfZHRzKTsgaSsrKQoJCWRldmljZV9y
ZW1vdmVfZmlsZShkZXYsICZ3ODM3OTVfZHRzW2ldLmRldl9hdHRyKTsKCglmb3IgKGkgPSAwOyBp
IDwgQVJSQVlfU0laRSh3ODM3OTVfc3RhdGljKTsgaSsrKQoJCWRldmljZV9yZW1vdmVfZmlsZShk
ZXYsICZ3ODM3OTVfc3RhdGljW2ldLmRldl9hdHRyKTsKCglrZnJlZShkYXRhKTsKZXhpdDoKCXJl
dHVybiBlcnI7Cn0KCnN0YXRpYyBzdHJ1Y3QgdzgzNzk1X2RhdGEgKnc4Mzc5NV91cGRhdGVfZGV2
aWNlKHN0cnVjdCBkZXZpY2UgKmRldikKewoJc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCA9IHRv
X2kyY19jbGllbnQoZGV2KTsKCXN0cnVjdCB3ODM3OTVfZGF0YSAqZGF0YSA9IGkyY19nZXRfY2xp
ZW50ZGF0YShjbGllbnQpOwoJdTE2IHRtcDsKCWludCBpOwoKCW11dGV4X2xvY2soJmRhdGEtPnVw
ZGF0ZV9sb2NrKTsKCglpZiAoISh0aW1lX2FmdGVyKGppZmZpZXMsIGRhdGEtPmxhc3RfdXBkYXRl
ZCArIEhaICogMikKCSAgICAgIHx8ICFkYXRhLT52YWxpZCkpCgkJZ290byBFTkQ7CgoJLyogVXBk
YXRlIHRoZSB2b2x0YWdlcyB2YWx1ZSAqLwoJZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUoZGF0
YS0+aW4pOyBpKyspIHsKCQlpZiAoIShkYXRhLT5oYXNfaW4gJiAoMSA8PCBpKSkpIHsKCQkJY29u
dGludWU7CgkJfQoJCXRtcCA9IHc4Mzc5NV9yZWFkX3ZhbHVlKGNsaWVudCwgVzgzNzk1X1JFR19J
TltpXVtJTl9SRUFEXSkgPDwgMjsKCQl0bXAgfD0gKHc4Mzc5NV9yZWFkX3ZhbHVlKGNsaWVudCwg
VzgzNzk1X1JFR19WUkxTQikgPj4gVlJMU0JfU0hJRlQpICYgMHgwMzsKCQlkYXRhLT5pbltpXVtJ
Tl9SRUFEXSA9IHRtcDsKCX0KCgkvKiBVcGRhdGUgZmFuICovCglmb3IgKGkgPSAwOyBpIDwgQVJS
QVlfU0laRShkYXRhLT5mYW4pOyBpKyspIHsKCQlpZiAoIShkYXRhLT5oYXNfZmFuICYgKDEgPDwg
aSkpKSB7CgkJCWNvbnRpbnVlOwoJCX0KCQlkYXRhLT5mYW5baV0gPQoJCQl3ODM3OTVfcmVhZF92
YWx1ZShjbGllbnQsIFc4Mzc5NV9SRUdfRkFOKGkpKSA8PCA0OwoJCWRhdGEtPmZhbltpXSB8PQoJ
CSAgKHc4Mzc5NV9yZWFkX3ZhbHVlKGNsaWVudCwgVzgzNzk1X1JFR19WUkxTQiA+PiA0KSkgJiAw
eDBGOwoJfQoKCS8qIFVwZGF0ZSB0ZW1wZXJhdHVyZSAqLwoJZm9yIChpID0gMDsgaSA8IEFSUkFZ
X1NJWkUoZGF0YS0+dGVtcCk7IGkrKykgewoJCS8qIGV2ZW4gc3RvcCBtb25pdG9yLCByZWdpc3Rl
ciBzdGlsbCBrZWVwIHZhbHVlLCBqdXN0IHJlYWQgb3V0IGl0ICovCgkJaWYgKCEoZGF0YS0+aGFz
X3RlbXAgJiAoMSA8PCBpKSkpIHsKCQkJZGF0YS0+dGVtcFtpXVtURU1QX1JFQURdID0gMDsKCQkJ
ZGF0YS0+dGVtcF9yZWFkX3ZybHNiW2ldID0gMDsKCQkJY29udGludWU7CgkJfQoJCWRhdGEtPnRl
bXBbaV1bVEVNUF9SRUFEXSA9IAoJCQl3ODM3OTVfcmVhZF92YWx1ZShjbGllbnQsIFc4Mzc5NV9S
RUdfVEVNUFtpXVtURU1QX1JFQURdKTsKCQlkYXRhLT50ZW1wX3JlYWRfdnJsc2JbaV0gPQoJCQl3
ODM3OTVfcmVhZF92YWx1ZShjbGllbnQsIFc4Mzc5NV9SRUdfVlJMU0IpOwoJfQoKCS8qIFVwZGF0
ZSBkdHMgdGVtcGVyYXR1cmUgKi8KCWlmIChkYXRhLT5lbmFibGVfZHRzICE9IDApIHsKCQlmb3Ig
KGkgPSAwOyBpIDwgQVJSQVlfU0laRShkYXRhLT5kdHMpOyBpKyspIHsKCQkJaWYgKCEoZGF0YS0+
aGFzX2R0cyAmICgxIDw8IGkpKSkKCQkJCWNvbnRpbnVlOwoJCQlkYXRhLT5kdHNbaV0gPSAKCQkJ
CXc4Mzc5NV9yZWFkX3ZhbHVlKGNsaWVudCwgVzgzNzk1X1JFR19EVFMoaSkpOwoJCQlkYXRhLT5k
dHNfcmVhZF92cmxzYltpXSA9CgkJCQl3ODM3OTVfcmVhZF92YWx1ZShjbGllbnQsIFc4Mzc5NV9S
RUdfVlJMU0IpOwoJCX0KCX0KCgkvKiBVcGRhdGUgcHdtIG91dHB1dCAqLwoJZm9yIChpID0gMDsg
aSA8IGRhdGEtPmhhc19wd207IGkrKykgewoJCWRhdGEtPnB3bVtpXVtQV01fT1VUUFVUXSA9CgkJ
ICAgIHc4Mzc5NV9yZWFkX3ZhbHVlKGNsaWVudCwgVzgzNzk1X1JFR19QV00oaSwgUFdNX09VVFBV
VCkpOwoJfQoKCS8qIHJldHJpZXZlIHZpZCAgKi8KCWlmICgwICE9IGRhdGEtPmhhc192aWQpIHsK
CQl0bXAgPSB3ODM3OTVfcmVhZF92YWx1ZShjbGllbnQsIFc4Mzc5NV9SRUdfVklEX0NUUkwpOwoJ
CXc4Mzc5NV93cml0ZV92YWx1ZShjbGllbnQsIFc4Mzc5NV9SRUdfVklEX0NUUkwsIHRtcCB8IDB4
ODApOwoJCWZvciAoaSA9IDA7IGkgPCAzOyBpICsrKSB7CgkJCWRhdGEtPnZpZFtpXSA9IAoJCQkJ
dzgzNzk1X3JlYWRfdmFsdWUoY2xpZW50LCBXODM3OTVfUkVHX1ZTRU5fVklESU4oaSkpOwoJCX0K
CX0KCQoJLyogdXBkYXRlIGFsYXJtIGFuZCBiZWVwICovCglmb3IgKGkgPSAwOyBpIDwgQUxBUk1f
QkVFUF9SRUdfTlVNOyBpICsrKSB7CgkJZGF0YS0+YWxhcm1zW2ldID0gCgkJCXc4Mzc5NV9yZWFk
X3ZhbHVlKGNsaWVudCwgVzgzNzk1X1JFR19BTEFSTShpKSk7Cgl9CgoJZGF0YS0+bGFzdF91cGRh
dGVkID0gamlmZmllczsKCWRhdGEtPnZhbGlkID0gMTsKCkVORDoKCW11dGV4X3VubG9jaygmZGF0
YS0+dXBkYXRlX2xvY2spOwoJcmV0dXJuIGRhdGE7Cn0KCnN0YXRpYyBpbnQgdzgzNzk1X3JlbW92
ZShzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50KQp7CglzdHJ1Y3QgdzgzNzk1X2RhdGEgKmRhdGEg
PSBpMmNfZ2V0X2NsaWVudGRhdGEoY2xpZW50KTsKCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZjbGll
bnQtPmRldjsKCWludCBpOwoKCWh3bW9uX2RldmljZV91bnJlZ2lzdGVyKGRhdGEtPmh3bW9uX2Rl
dik7CgoJZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUodzgzNzk1X2luKTsgaSsrKQoJCWRldmlj
ZV9yZW1vdmVfZmlsZShkZXYsICZ3ODM3OTVfaW5baV0uZGV2X2F0dHIpOwoKCWZvciAoaSA9IDA7
IGkgPCBBUlJBWV9TSVpFKHc4Mzc5NV9mYW4pOyBpKyspCgkJZGV2aWNlX3JlbW92ZV9maWxlKGRl
diwgJnc4Mzc5NV9mYW5baV0uZGV2X2F0dHIpOwoKCWZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpF
KHNkYV9zaW5nbGVfZmlsZXMpOyBpKyspCgkJZGV2aWNlX3JlbW92ZV9maWxlKGRldiwgJnNkYV9z
aW5nbGVfZmlsZXNbaV0uZGV2X2F0dHIpOwoKCWZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKHc4
Mzc5NV92aWQpOyBpKyspIHsKCQlpZiAoISgoZGF0YS0+aGFzX3ZpZCA+PiBpKSAmIDEpKQoJCQlj
b250aW51ZTsKCQlkZXZpY2VfcmVtb3ZlX2ZpbGUoZGV2LCAmdzgzNzk1X3ZpZFtpXS5kZXZfYXR0
cik7Cgl9CgoJaWYgKGRhdGEtPmNoaXBfdHlwZSA9PSB3ODM3OTVnKSB7CgkJZm9yIChpID0gMDsg
aSA8IEFSUkFZX1NJWkUodzgzNzk1X2xlZnRfcmVnKTsgaSsrKQoJCQlkZXZpY2VfcmVtb3ZlX2Zp
bGUoZGV2LCAmdzgzNzk1X2xlZnRfcmVnW2ldLmRldl9hdHRyKTsKCX0KCglmb3IgKGkgPSAwOyBp
IDwgQVJSQVlfU0laRSh3ODM3OTVfdGVtcCk7IGkrKykKCQlkZXZpY2VfcmVtb3ZlX2ZpbGUoZGV2
LCAmdzgzNzk1X3RlbXBbaV0uZGV2X2F0dHIpOwoKCWZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpF
KHc4Mzc5NV9kdHMpOyBpKyspCgkJZGV2aWNlX3JlbW92ZV9maWxlKGRldiwgJnc4Mzc5NV9kdHNb
aV0uZGV2X2F0dHIpOwoKCWZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKHc4Mzc5NV9zdGF0aWMp
OyBpKyspCgkJZGV2aWNlX3JlbW92ZV9maWxlKGRldiwgJnc4Mzc5NV9zdGF0aWNbaV0uZGV2X2F0
dHIpOwoKCWtmcmVlKGRhdGEpOwoKCXJldHVybiAwOwp9CgoKCi8qIElnbm9yZSB0aGUgcG9zc2li
aWxpdHkgdGhhdCBzb21lYm9keSBjaGFuZ2UgYmFuayBvdXRzaWRlIHRoZSBkcml2ZXIKICAgTXVz
dCBiZSBjYWxsZWQgd2l0aCBkYXRhLT51cGRhdGVfbG9jayBoZWxkLCBleGNlcHQgZHVyaW5nIGlu
aXRpYWxpemF0aW9uICovCnN0YXRpYyB1OCB3ODM3OTVfcmVhZF92YWx1ZShzdHJ1Y3QgaTJjX2Ns
aWVudCAqY2xpZW50LCB1MTYgcmVnKQp7CglzdHJ1Y3QgdzgzNzk1X2RhdGEgKmRhdGEgPSBpMmNf
Z2V0X2NsaWVudGRhdGEoY2xpZW50KTsKCXU4IHJlcyA9IDB4ZmY7Cgl1OCBuZXdfYmFuayA9IHJl
ZyA+PiA4OwoKCW5ld19iYW5rIHw9IGRhdGEtPmJhbmsgJiAweGZjOwoJaWYgKGRhdGEtPmJhbmsg
IT0gbmV3X2JhbmspIHsKCQlpZiAoaTJjX3NtYnVzX3dyaXRlX2J5dGVfZGF0YQoJCSAgICAoY2xp
ZW50LCBXODM3OTVfUkVHX0JBTktTRUwsIG5ld19iYW5rKSA+PSAwKQoJCQlkYXRhLT5iYW5rID0g
bmV3X2Jhbms7CgkJZWxzZSB7CgkJCWRldl9lcnIoJmNsaWVudC0+ZGV2LAoJCQkJInNldCBiYW5r
IHRvICVkIGZhaWxlZCwgZmFsbCBiYWNrICIKCQkJCSJ0byBiYW5rICVkLCByZWFkIHJlZyAweCV4
IGVycm9yXG4iLAoJCQkJbmV3X2JhbmssIGRhdGEtPmJhbmssIHJlZyk7CgkJCXJlcyA9IDB4MDsJ
LyogcmVhZCAweDAgZnJvbSB0aGUgY2hpcCAqLwoJCQlnb3RvIEVORDsKCQl9Cgl9CglyZXMgPSBp
MmNfc21idXNfcmVhZF9ieXRlX2RhdGEoY2xpZW50LCByZWcgJiAweGZmKTsKRU5EOgoJcmV0dXJu
IHJlczsKfQoKLyogTXVzdCBiZSBjYWxsZWQgd2l0aCBkYXRhLT51cGRhdGVfbG9jayBoZWxkLCBl
eGNlcHQgZHVyaW5nIGluaXRpYWxpemF0aW9uICovCnN0YXRpYyBpbnQgdzgzNzk1X3dyaXRlX3Zh
bHVlKHN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQsIHUxNiByZWcsIHU4IHZhbHVlKQp7CglzdHJ1
Y3QgdzgzNzk1X2RhdGEgKmRhdGEgPSBpMmNfZ2V0X2NsaWVudGRhdGEoY2xpZW50KTsKCWludCBy
ZXM7Cgl1OCBuZXdfYmFuayA9IHJlZyA+PiA4OwoKCW5ld19iYW5rIHw9IGRhdGEtPmJhbmsgJiAw
eGZjOwoJaWYgKGRhdGEtPmJhbmsgIT0gbmV3X2JhbmspIHsKCQlpZiAoKHJlcyA9IGkyY19zbWJ1
c193cml0ZV9ieXRlX2RhdGEKCQkgICAgKGNsaWVudCwgVzgzNzk1X1JFR19CQU5LU0VMLCBuZXdf
YmFuaykpID49IDApCgkJCWRhdGEtPmJhbmsgPSBuZXdfYmFuazsKCQllbHNlIHsKCQkJZGV2X2Vy
cigmY2xpZW50LT5kZXYsCgkJCQkic2V0IGJhbmsgdG8gJWQgZmFpbGVkLCBmYWxsIGJhY2sgIgoJ
CQkJInRvIGJhbmsgJWQsIHdyaXRlIHJlZyAweCV4IGVycm9yXG4iLAoJCQkJbmV3X2JhbmssIGRh
dGEtPmJhbmssIHJlZyk7CgkJCWdvdG8gRU5EOwoJCX0KCX0KCglyZXMgPSBpMmNfc21idXNfd3Jp
dGVfYnl0ZV9kYXRhKGNsaWVudCwgcmVnICYgMHhmZiwgdmFsdWUpOwpFTkQ6CglyZXR1cm4gcmVz
Owp9CgpzdGF0aWMgaW50IF9faW5pdCBzZW5zb3JzX3c4Mzc5NV9pbml0KHZvaWQpCnsKCXJldHVy
biBpMmNfYWRkX2RyaXZlcigmdzgzNzk1X2RyaXZlcik7Cn0KCnN0YXRpYyB2b2lkIF9fZXhpdCBz
ZW5zb3JzX3c4Mzc5NV9leGl0KHZvaWQpCnsKCWkyY19kZWxfZHJpdmVyKCZ3ODM3OTVfZHJpdmVy
KTsKfQoKTU9EVUxFX0FVVEhPUigiV2VpIFNvbmciKTsKTU9EVUxFX0RFU0NSSVBUSU9OKCJ3ODM3
OTUgZHJpdmVyIik7Ck1PRFVMRV9MSUNFTlNFKCJHUEwiKTsKCm1vZHVsZV9pbml0KHNlbnNvcnNf
dzgzNzk1X2luaXQpOwptb2R1bGVfZXhpdChzZW5zb3JzX3c4Mzc5NV9leGl0KTsKCg==

------_=_NextPart_001_01C99BD8.D3B5CB8B
Content-Type: application/octet-stream;
	name="Makefile"
Content-Transfer-Encoding: base64
Content-Description: Makefile
Content-Disposition: attachment;
	filename="Makefile"

IyBvbiBMaW51eCAyLjYga2VybmVsCiMgSWYgS0VSTkVMUkVMRUFTRSBpcyBkZWZpbmVkLCB3ZSd2
ZSBiZWVuIGludm9rZWQgZnJvbSB0aGUKIyBrZXJuZWwgYnVpbGQgc3lzdGVtIGFuZCBjYW4gdXNl
IGl0cyBsYW5ndWFnZS4KaWZuZXEgKCQoS0VSTkVMUkVMRUFTRSksKQoJb2JqLW0gOj0gdzgzNzk1
Lm8KCXc4Mzc5NS1vYmpzIDo9IHdiODM3OTUubwojIE90aGVyd2lzZSB3ZSB3ZXJlIGNhbGxlZCBk
aXJlY3RseSBmcm9tIHRoZSBjb21tYW5kCiMgbGluZTsgaW52b2tlIHRoZSBrZXJuZWwgYnVpbGQg
c3lzdGVtLgplbHNlCglLRVJORUxESVIgPz0gL2xpYi9tb2R1bGVzLyQoc2hlbGwgdW5hbWUgLXIp
L2J1aWxkCiMJS0VSTkVMRElSID89IC90bXAvZG93bi9saW51eC0yLjYuMjcuNy8KCVBXRCA6PSAk
KHNoZWxsIHB3ZCkKMi42OgoJJChNQUtFKSAtQyAkKEtFUk5FTERJUikgTT0kKFBXRCkgbW9kdWxl
cyAtV2FsbCAKCmNsZWFuOgoJcm0gLXJmICoubyAqLmtvICoubW9kLmMgTW9kdWxlLnN5bXZlcnMg
Lnc4Mzc5NS4qIC53YjgzNzk1LiogLnRtcF92ZXJzaW9ucwplbmRpZgo=

------_=_NextPart_001_01C99BD8.D3B5CB8B
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
------_=_NextPart_001_01C99BD8.D3B5CB8B--
