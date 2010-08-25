From: Nold Danny-R59715 <R59715@freescale.com>
Date: Wed, 25 Aug 2010 17:42:11 +0000
Subject: [lm-sensors] Ambient temperature sensor driver
Message-Id: <A39D6EE762981A42A5E83744F71F8460087E0581@az33exm20>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01CB447C.DC3AAE55"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============2810338116583003616==
Content-Class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CB447C.DC3AAE55"

------_=_NextPart_001_01CB447C.DC3AAE55
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello lm-sensors group,

I'm developing a Linux driver for a PMIC that includes an ambient
temperature sensor.  In trying to determine where the temperature sensor
driver piece should belong in the Linux driver hierarchy, I discovered
this group and the temperature sensor drivers in the /hwmon directory.

My question: Does a driver for an ambient temperature sensor belong in
hwmon, and is it consistent with the lm-sensors project?  I ask because
the purpose of this driver is not "monitoring the hardware health of
Linux systems containing hardware health monitoring hardware".

If this driver does not belong in hwmon, is there an obvious home for
it?

Thanks,
Danny Nold

------_=_NextPart_001_01CB447C.DC3AAE55
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7655.10">
<TITLE>Ambient temperature sensor driver</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Calibri">Hello =
lm-sensors group,</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">I</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">&#8217;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">m developing a Linux driver for a</FONT></SPAN><SPAN =
LANG=3D"en-us"><FONT FACE=3D"Calibri"></FONT></SPAN><SPAN =
LANG=3D"en-us"> <FONT FACE=3D"Calibri">PMIC that includes an ambient =
temperature sensor.</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">&nbsp; In trying to determine where the temperature =
sensor driver piece should belong in the Linux driver hierarchy, I =
discovered</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Calibri">this group and the</FONT></SPAN><SPAN LANG=3D"en-us"> =
<FONT FACE=3D"Calibri">temperature sensor</FONT></SPAN><SPAN =
LANG=3D"en-us"> <FONT FACE=3D"Calibri">drivers in the /hwmon =
directory.</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Calibri">My question: =
Does a driver for an ambient temperature sensor</FONT></SPAN><SPAN =
LANG=3D"en-us"> <FONT FACE=3D"Calibri">belong in hwmon, and is it =
consistent with the lm-sensors</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri"> project?&nbsp; I ask because the purpose of this =
driver is not</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Calibri">&#8220;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">monitoring the hardware health of Linux systems =
containing hardware health monitoring hardware</FONT></SPAN><SPAN =
LANG=3D"en-us"><FONT FACE=3D"Calibri">&#8221;</FONT></SPAN><SPAN =
LANG=3D"en-us"><FONT FACE=3D"Calibri">.</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Calibri">If this driver =
does not belong in hwmon, is there an obvious home for =
it?</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">Thanks,</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Calibri">Danny =
Nold</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

</BODY>
</HTML>
------_=_NextPart_001_01CB447C.DC3AAE55--


--===============2810338116583003616==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2810338116583003616==--
