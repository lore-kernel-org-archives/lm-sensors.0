From: John Mcgrath <john.mcgrath@xilinx.com>
Date: Thu, 19 Mar 2009 00:17:11 +0000
Subject: [lm-sensors] Adding driver for embedded sensors in an FPGA
Message-Id: <20090319001714.28D68818054@mail202-wa4.bigfish.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C9A828.0D1BE23D"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============8796560768818033892==
Content-Class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C9A828.0D1BE23D"

------_=_NextPart_001_01C9A828.0D1BE23D
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi All,

 =


I have two very much newbie questions regarding adding support/a driver
for temperature/voltage sensors in an FPGA.

The Xilinx Virtex-5 FPGAs support embedded linux, and also have an
in-built hardware module that can monitor temperature and 2 system
voltages, so lm_sensors seem like a perfect fit!

 =


I would be very interested in adding support for these sensors to the
embedded linux.

 =


So my two questions are:

1)       These sensors are internal to the FPGA, and can be accessed via
a system bus, which is not I2C or PCI, etc. How should this driver be
written to fit in with the other drivers that are supported by
lm_sensors?

a.       My guess is to 'fake' being a PCI/I2C device, by simply calling
it PCI, while the actual HW access will not use these interfaces, but
the driver would take care of talking to the sensors via the system bus.

b.       How would this affect the sensor detection scripts, any
suggestions for this?

2)       Is there a guide somewhere that shows how to start writing a
driver? I've briefly looked at a few under the drivers/hwmon location,
but if there was a template/tutorial on what exactly was required, that
would be excellent!

 =


 =


Any advice at all is greatly appreciated!

 =


Cheers,

John

 =




This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.


------_=_NextPart_001_01C9A828.0D1BE23D
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns=3D"http://www.w3.org/TR/REC-html40">=


<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
 /* List Definitions */
 @list l0
	{mso-list-id:5400552;
	mso-list-type:hybrid;
	mso-list-template-ids:-305222874 2138609598 67698713 67698715 67698703 676=
98713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-text:"%1\)";
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ascii-font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";
	mso-hansi-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1
	{mso-list-id:1162309868;
	mso-list-type:hybrid;
	mso-list-template-ids:-673549122 405279794 67698713 67698715 67698703 6769=
8713 67698715 67698703 67698713 67698715;}
@list l1:level1
	{mso-level-text:"%1\)";
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ascii-font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";
	mso-hansi-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";}
@list l1:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>Hi All,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>I have two very much newbie questions regarding adding s=
upport/a
driver for temperature/voltage sensors in an FPGA.<o:p></o:p></span></font>=
</p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>The Xilinx Virtex-5 FPGAs support embedded linux, and al=
so
have an in-built hardware module that can monitor temperature and 2 system =
voltages,
so lm_sensors seem like a perfect fit!<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>I would be very interested in adding support for these
sensors to the embedded linux.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>So my two questions are:<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-indent:-.25in;mso-list:=
l0 level1 lfo2'><![if !supportLists]><font
size=3D2 face=3D"Times New Roman"><span style=3D'font-size:10.0pt'><span
style=3D'mso-list:Ignore'>1)<font size=3D1 face=3D"Times New Roman"><span
style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 </span></font></span></span></font><![endif]><font
size=3D2 face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'>Th=
ese
sensors are internal to the FPGA, and can be accessed via a system bus, whi=
ch
is not I2C or PCI, etc. How should this driver be written to fit in with th=
e
other drivers that are supported by lm_sensors?<o:p></o:p></span></font></p=
>

<p class=3DMsoNormal style=3D'margin-left:1.0in;text-indent:-.25in;mso-list=
:l1 level2 lfo1'><![if !supportLists]><font
size=3D2 face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'><s=
pan
style=3D'mso-list:Ignore'>a.<font size=3D1 face=3D"Times New Roman"><span
style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 </span></font></span></span></font><![endif]><font
size=3D2 face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'>My=
 guess is
to &#8216;fake&#8217; being a PCI/I2C device, by simply calling it PCI, whi=
le the
actual HW access will not use these interfaces, but the driver would take c=
are
of talking to the sensors via the system bus.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:1.0in;text-indent:-.25in;mso-list=
:l1 level2 lfo1'><![if !supportLists]><font
size=3D2 face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'><s=
pan
style=3D'mso-list:Ignore'>b.<font size=3D1 face=3D"Times New Roman"><span
style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 </span></font></span></span></font><![endif]><font
size=3D2 face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'>Ho=
w would
this affect the sensor detection scripts, any suggestions for this?<o:p></o=
:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-indent:-.25in;mso-list:=
l1 level1 lfo1'><![if !supportLists]><font
size=3D2 face=3D"Times New Roman"><span style=3D'font-size:10.0pt'><span
style=3D'mso-list:Ignore'>2)<font size=3D1 face=3D"Times New Roman"><span
style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 </span></font></span></span></font><![endif]><font
size=3D2 face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'>Is=
 there a
guide somewhere that shows how to start writing a driver? I&#8217;ve briefl=
y looked
at a few under the drivers/hwmon location, but if there was a template/tuto=
rial
on what exactly was required, that would be excellent!<o:p></o:p></span></f=
ont></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>Any advice at all is greatly appreciated!<o:p></o:p></sp=
an></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>Cheers,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>John<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

<br clear=3Dall> This email and any attachments are intended for the sole u=
se of the named recipient(s) and contain(s) confidential information that m=
ay be proprietary, privileged or copyrighted under applicable law. If you a=
re not the intended recipient, do not read, copy, or forward this email mes=
sage or any attachments. Delete this email message and any attachments imme=
diately.
</body>

</html>


------_=_NextPart_001_01C9A828.0D1BE23D--


--===============8796560768818033892==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8796560768818033892==--
