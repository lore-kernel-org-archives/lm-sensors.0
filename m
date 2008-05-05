From: "Darth Tumi" <darth.tumi@gmail.com>
Date: Mon, 05 May 2008 17:05:27 +0000
Subject: [lm-sensors]  Backporting coretemp and w83793 to 2.6.18
Message-Id: <481f3e5c.0305560a.100e.ffffd51e@mx.google.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6220690572767895854=="
List-Id: <lm-sensors.vger.kernel.org>
References: <46CB9161.5090408@curl.com>
In-Reply-To: <46CB9161.5090408@curl.com>
To: lm-sensors@vger.kernel.org

Este es un mensaje con varias partes en formato MIME.

--===============6220690572767895854==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_006F_01C8AEE2.FCFAB5B0"
Content-Language: es

Este es un mensaje con varias partes en formato MIME.

------=_NextPart_000_006F_01C8AEE2.FCFAB5B0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

=20

I have the same problema as you reported (the only difference is that my
system is a x64 Cent OS 5.1, board Supermicro X7DBR-3 (Winbond W83793G),
kernel 2.6.18-53.1.14.el5.

=20

We need that kernel version and I=92m blocked because I have absolutly =
no
experience in compiling and installing drivers=85 so can you send me =
those
compiled by you or detailed instructions or references for compiling and
installing them?

=20

Thank you in advance, sorry if my request is too silly.

Regards

=20


------=_NextPart_000_006F_01C8AEE2.FCFAB5B0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:x=3D"urn:schemas-microsoft-com:office:excel" =
xmlns:p=3D"urn:schemas-microsoft-com:office:powerpoint" =
xmlns:a=3D"urn:schemas-microsoft-com:office:access" =
xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" =
xmlns:s=3D"uuid:BDC6E3F0-6DA3-11d1-A2A3-00AA00C14882" =
xmlns:rs=3D"urn:schemas-microsoft-com:rowset" xmlns:z=3D"#RowsetSchema" =
xmlns:b=3D"urn:schemas-microsoft-com:office:publisher" =
xmlns:ss=3D"urn:schemas-microsoft-com:office:spreadsheet" =
xmlns:c=3D"urn:schemas-microsoft-com:office:component:spreadsheet" =
xmlns:oa=3D"urn:schemas-microsoft-com:office:activation" =
xmlns:html=3D"http://www.w3.org/TR/REC-html40" =
xmlns:q=3D"http://schemas.xmlsoap.org/soap/envelope/" xmlns:D=3D"DAV:" =
xmlns:x2=3D"http://schemas.microsoft.com/office/excel/2003/xml" =
xmlns:ois=3D"http://schemas.microsoft.com/sharepoint/soap/ois/" =
xmlns:dir=3D"http://schemas.microsoft.com/sharepoint/soap/directory/" =
xmlns:ds=3D"http://www.w3.org/2000/09/xmldsig#" =
xmlns:dsp=3D"http://schemas.microsoft.com/sharepoint/dsp" =
xmlns:udc=3D"http://schemas.microsoft.com/data/udc" =
xmlns:xsd=3D"http://www.w3.org/2001/XMLSchema" =
xmlns:sub=3D"http://schemas.microsoft.com/sharepoint/soap/2002/1/alerts/"=
 xmlns:ec=3D"http://www.w3.org/2001/04/xmlenc#" =
xmlns:sp=3D"http://schemas.microsoft.com/sharepoint/" =
xmlns:sps=3D"http://schemas.microsoft.com/sharepoint/soap/" =
xmlns:xsi=3D"http://www.w3.org/2001/XMLSchema-instance" =
xmlns:udcxf=3D"http://schemas.microsoft.com/data/udc/xmlfile" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">


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

<p class=3DMsoNormal>Hi,<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I have the same problema as you reported (the only
difference is that my system is a x64 Cent OS 5.1, board Supermicro =
X7DBR-3 (Winbond
W83793G), kernel 2.6.18-53.1.14.el5.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>We need that kernel version and I&#8217;m blocked =
because I
have absolutly no experience in compiling and installing drivers&#8230; =
so can
you send me those compiled by you or detailed instructions or references =
for
compiling and installing them?<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Thank you in advance, sorry if my request is too =
silly.<o:p></o:p></p>

<p class=3DMsoNormal>Regards<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

 <BR><BR>__________ Informaci=F3n de ESET NOD32 Antivirus, versi=F3n de =
la base de firmas de virus 3071 (20080502) __________<BR><BR>ESET NOD32 =
Antivirus ha comprobado este mensaje.<BR><A =
HREF=3D"http://www.eset.com">http://www.eset.com</A><BR> </body>

</html>

------=_NextPart_000_006F_01C8AEE2.FCFAB5B0--



--===============6220690572767895854==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6220690572767895854==--

