From: "Javier Andres Caceres Alvis" <javier.caceres@arandasoft.com>
Date: Mon, 24 Aug 2009 21:59:50 +0000
Subject: [lm-sensors] How to Communicate with chips on the ISA bus/SMBus?
Message-Id: <000701ca2506$3599bde0$a0cd39a0$@caceres@arandasoft.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8995796760778777709=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

--===============8995796760778777709==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0008_01CA24DC.4CC3B5E0"
Content-Language: es-co

This is a multi-part message in MIME format.

------=_NextPart_000_0008_01CA24DC.4CC3B5E0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi there,


This is a low level (native development) question. A motherboard can contain
sensors to read many values (voltage, fan speed, etc).
I understand that many manufactures place this information at ISA-SM I/O
ports.
I have a Fintek F71882 "Super Hardware Monitor" datasheet which tells the
memory addresses where bit registers are located, but I don't know how to
access to such as memory blocks under Windows.

Here a list of some hw monitor/sensor manufacturers:
http://www.almico.com/forumsensors.php
Here an explanation on ISA/SMBus funtionality:
http://www.lm-sensors.org/wiki/FAQ/Chapter1

Thanks a lot. unfortunally these topics lack of documentation under windows.

Javier Andres


------=_NextPart_000_0008_01CA24DC.4CC3B5E0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Verdana;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
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
span.EstiloCorreo17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:612.0pt 792.0pt;
	margin:70.85pt 3.0cm 70.85pt 3.0cm;}
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

<body lang=3DES link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><span =
style=3D'font-size:8.0pt;font-family:"Verdana","sans-serif";
color:black'>Hi there,<br>
<br>
<br>
This is a low level (native development)&nbsp;question. A motherboard =
can
contain sensors to read many values (voltage, fan speed, etc).<br>
I understand that many manufactures place this information =
at&nbsp;ISA-SM I/O&nbsp;ports.<br>
I have a Fintek&nbsp;F71882 &quot;Super Hardware Monitor&quot; datasheet =
which
tells the memory addresses where bit registers are located, but I don't =
know
how to access to such as memory blocks under Windows.<br>
<br>
Here a list of some hw monitor/sensor manufacturers: <a
href=3D"http://www.almico.com/forumsensors.php">http://www.almico.com/for=
umsensors.php</a><br>
Here an explanation on ISA/SMBus funtionality:&nbsp;<a
href=3D"http://www.lm-sensors.org/wiki/FAQ/Chapter1">http://www.lm-sensor=
s.org/wiki/FAQ/Chapter1</a><br>
<br>
Thanks a lot. unfortunally these topics lack of documentation under =
windows.<br>
<br>
Javier Andres</span><o:p></o:p></p>

</div>

</body>

</html>

------=_NextPart_000_0008_01CA24DC.4CC3B5E0--



--===============8995796760778777709==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8995796760778777709==--

