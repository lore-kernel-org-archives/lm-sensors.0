From: "John Gumb" <john.gumb@tandberg.com>
Date: Mon, 15 Sep 2008 11:03:19 +0000
Subject: [lm-sensors] it8712 rev 7; fan speeds reported incorrectly.
Message-Id: <9F6ACAE02B6DD040A1E259977622CFDB03E26A54@oslexcp1.eu.tandberg.int>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C91722.A99363B6"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

--===============0042831586264455650==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C91722.A99363B6"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C91722.A99363B6
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi

=20

I've just picked up linux-2.6.27-rc5 and it would appear fan speeds are
reported incorrectly now. We have it8712  rev7 on our systems. We see
speeds of around 40K RPM (!!).

=20

The following hack fixes it - it just punts 16 bit fan support out to
rev8. It would appear our it8172 does not have 16 bit tacho support. Or
if it does, the driver isn't enabling it properly.

=20

--- drivers/hwmon/it87.c.orig   2008-09-05 15:51:11.000000000 +0100

+++ drivers/hwmon/it87.c        2008-09-05 15:51:53.000000000 +0100

@@ -283,7 +283,7 @@

           IT8712F Datasheet 0.9.1, section 8.3.5 indicates 7h =3D=3D
Version I.

           These are the first revisions with 16bit tachometer support.
*/

        return (data->type =3D=3D it87 && data->revision >=3D 0x03)

-           || (data->type =3D=3D it8712 && data->revision >=3D 0x07)

+           || (data->type =3D=3D it8712 && data->revision >=3D 0x08)

            || data->type =3D=3D it8716

            || data->type =3D=3D it8718;

=20

Cheers

=20

John


------_=_NextPart_001_01C91722.A99363B6
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
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
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:595.3pt 841.9pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-GB link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hi<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I&#8217;ve just picked up linux-2.6.27-rc5 and it =
would
appear fan speeds are reported incorrectly now. We have it8712 =
&nbsp;rev7 on our
systems. We see speeds of around 40K RPM =
(!!).<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>The following hack fixes it &#8211; it just punts 16 =
bit fan
support out to rev8. It would appear our it8172 does not have 16 bit =
tacho
support. Or if it does, the driver isn&#8217;t enabling it =
properly.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>--- drivers/hwmon/it87.c.orig&nbsp;&nbsp; 2008-09-05
15:51:11.000000000 +0100<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>+++ =
drivers/hwmon/it87.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
2008-09-05
15:51:53.000000000 +0100<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>@@ -283,7 +283,7 @@<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; IT8712F Datasheet 0.9.1, section 8.3.5 indicates
7h =3D=3D Version I.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; These are the first revisions with 16bit
tachometer support. */<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
(data-&gt;type =3D=3D it87 &amp;&amp;
data-&gt;revision &gt;=3D 0x03)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; || (data-&gt;type =3D=3D it8712 &amp;&amp;
data-&gt;revision &gt;=3D 0x07)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; || (data-&gt;type =3D=3D it8712 &amp;&amp;
data-&gt;revision &gt;=3D 0x08)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; || data-&gt;type =3D=3D it8716<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; || data-&gt;type =3D=3D =
it8718;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Cheers<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>John<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C91722.A99363B6--


--===============0042831586264455650==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0042831586264455650==--
