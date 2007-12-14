From: "Eric" <resdrywall@bellsouth.net>
Date: Fri, 14 Dec 2007 02:55:09 +0000
Subject: [lm-sensors] ASM58 Mozart-2 Driver
Message-Id: <000301c83dfc$bdb0e980$3912bc80$@net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5029588324330618272=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multipart message in MIME format.

--===============5029588324330618272==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0004_01C83DD2.D4DAE180"
Content-Language: en-us

This is a multipart message in MIME format.

------=_NextPart_000_0004_01C83DD2.D4DAE180
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

I am using SME version of Linux  www.contribs.org with the following Kernel
version

 

2.6.9-55.0.12.EL

 

My  sensors-detect output looks like this:

 

Driver `eeprom' (should be inserted):

  Detects correctly:

  * Bus `SMBus I801 adapter at e800' (Algorithm unavailable)

    Busdriver `i2c-i801', I2C address 0x50

    Chip `SPD EEPROM' (confidence: 8)

 

Driver `to-be-written' (should be inserted):

  Detects correctly:

  * Bus `SMBus I801 adapter at e800' (Algorithm unavailable)

    Busdriver `i2c-i801', I2C address 0x77

    Chip `Asus ASM58 Mozart-2' (confidence: 5)

 

#----cut here----

# I2C adapter drivers

modprobe i2c-i801

# I2C chip drivers

modprobe eeprom

# no driver for Asus ASM58 Mozart-2 yet

# sleep 2 # optional

/usr/bin/sensors -s # recommended

#----cut here----

 

I found a driver below but I cannot find docs on how to add it or if it is
compatible

 

http://lists.lm-sensors.org/pipermail/lm-sensors/2006-March/015735.html

 

lm sensors version: sensors version 2.8.7 with libsensors version 2.8.7

 

I looked at the later versions readme and did not see reference to this
being supported. Please let me know if this is possible because I have a lot
of interest in the applications that use it.

 

Thanks,

 

Eric

 

Eric Dickie

Residential Drywall, Inc.

Mobile: 770-294-6490

  Office: 770-222-7711

 


------=_NextPart_000_0004_01C83DD2.D4DAE180
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal>I am using SME version of Linux &nbsp;<a
href=3D"http://www.contribs.org">www.contribs.org</a> with the following =
Kernel
version<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>2.6.9-55.0.12.EL<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>My&nbsp; sensors-detect output looks like =
this:<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Driver `eeprom' (should be =
inserted):<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; Detects correctly:<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; * Bus `SMBus I801 adapter at e800' =
(Algorithm
unavailable)<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; Busdriver `i2c-i801', I2C =
address 0x50<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; Chip `SPD EEPROM' (confidence: =
8)<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Driver `to-be-written' (should be =
inserted):<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; Detects correctly:<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; * Bus `SMBus I801 adapter at e800' =
(Algorithm
unavailable)<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; Busdriver `i2c-i801', I2C =
address 0x77<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; Chip `Asus ASM58 Mozart-2' =
(confidence:
5)<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>#----cut here----<o:p></o:p></p>

<p class=3DMsoNormal># I2C adapter drivers<o:p></o:p></p>

<p class=3DMsoNormal>modprobe i2c-i801<o:p></o:p></p>

<p class=3DMsoNormal># I2C chip drivers<o:p></o:p></p>

<p class=3DMsoNormal>modprobe eeprom<o:p></o:p></p>

<p class=3DMsoNormal># no driver for Asus ASM58 Mozart-2 =
yet<o:p></o:p></p>

<p class=3DMsoNormal># sleep 2 # optional<o:p></o:p></p>

<p class=3DMsoNormal>/usr/bin/sensors -s # recommended<o:p></o:p></p>

<p class=3DMsoNormal>#----cut here----<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I found a driver below but I cannot find docs on =
how to add
it or if it is compatible<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><a
href=3D"http://lists.lm-sensors.org/pipermail/lm-sensors/2006-March/01573=
5.html">http://lists.lm-sensors.org/pipermail/lm-sensors/2006-March/01573=
5.html</a><o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>lm sensors version: sensors version 2.8.7 with =
libsensors
version 2.8.7<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I looked at the later versions readme and did not =
see
reference to this being supported. Please let me know if this is =
possible
because I have a lot of interest in the applications that use =
it.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Thanks,<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Eric<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Eric Dickie<o:p></o:p></p>

<p class=3DMsoNormal>Residential Drywall, Inc.<o:p></o:p></p>

<p class=3DMsoNormal>Mobile: 770-294-6490<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; Office: 770-222-7711<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>

------=_NextPart_000_0004_01C83DD2.D4DAE180--



--===============5029588324330618272==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5029588324330618272==--

