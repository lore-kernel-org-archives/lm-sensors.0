From: "Hu Mingkai-B21284" <B21284@freescale.com>
Date: Mon, 27 Oct 2008 08:52:06 +0000
Subject: [lm-sensors] How to pass board specific info to I2C driver module
Message-Id: <CF6163088BDE8747873ADAA4AF922BF258D76E@zmy16exm21.fsl.freescale.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C93811.485A312A"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

--===============6205377234867511088==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C93811.485A312A"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C93811.485A312A
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi All,
=20
I'm working on an ADC chip (MCP3021) driver under Linux 2.6.27.
We used these two chips to monitor the CPU core current and=20
platform current individually, which is converted to voltage as=20
the ADC chip's input.
As you know, the driver shouldn't contain the board specific info,
such as, the chip's work voltage, the ratio of voltage and current.
So how to pass these info to the driver module?
=20
Here is the way I can think of:
1. to use dts file to pass the info to the module.
    This way make the driver is bound to OF implement.
=20
2. to use the module parameter.
    For different chips, the work voltage and the ratio may be
different,
    but the chip uses the same driver.
=20
Any other idea? Please give me some advice. Thanks a lot.
=20
Best Regards,
Vincent
=20

------_=_NextPart_001_01C93811.485A312A
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3429" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D035015108-27102008>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D807221401-27102008>Hi=20
All,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D807221401-27102008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D807221401-27102008>I'm =
working on an=20
ADC chip (MCP3021) driver under Linux 2.6.27.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D807221401-27102008>We =
used these two=20
chips to monitor the CPU core current and </SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D807221401-27102008>platform current=20
individually, which is converted to voltage as </SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D807221401-27102008>the =
ADC=20
</SPAN></FONT><FONT face=3DArial size=3D2><SPAN =
class=3D807221401-27102008>chip's=20
input.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D807221401-27102008>As you =
know, the=20
driver shouldn't </SPAN></FONT><FONT face=3DArial size=3D2><SPAN=20
class=3D807221401-27102008>contain the </SPAN></FONT><FONT face=3DArial =
size=3D2><SPAN=20
class=3D807221401-27102008>board specific info,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D807221401-27102008>such =
as, the chip's=20
work voltage, </SPAN></FONT><FONT face=3DArial size=3D2><SPAN=20
class=3D807221401-27102008>the</SPAN></FONT><FONT face=3DArial =
size=3D2><SPAN=20
class=3D807221401-27102008> ratio&nbsp;of </SPAN></FONT><FONT =
face=3DArial=20
size=3D2><SPAN class=3D807221401-27102008>voltage and =
current.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D807221401-27102008>So how =
to pass these=20
info to the driver module?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D807221401-27102008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D807221401-27102008>Here =
is the way I=20
can think of:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D807221401-27102008>1. to =
use dts=20
file&nbsp;to pass the info to the module.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D807221401-27102008>&nbsp;&nbsp;&nbsp;=20
This way make the driver is bound to OF implement.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D807221401-27102008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D807221401-27102008>2. to =
use the module=20
parameter.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D807221401-27102008>&nbsp;&nbsp;&nbsp;=20
For different chips, the work voltage and the ratio may be=20
different,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D807221401-27102008>&nbsp;&nbsp;&nbsp;=20
but the chip uses the&nbsp;same driver.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D807221401-27102008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D807221401-27102008>Any =
other idea?=20
Please give me some advice. Thanks a lot.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D807221401-27102008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D807221401-27102008>Best=20
Regards,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D807221401-27102008>Vincent</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D807221401-27102008></SPAN></FONT>&nbsp;</DIV></SPAN></FONT></DIV>=
</BODY></HTML>

------_=_NextPart_001_01C93811.485A312A--


--===============6205377234867511088==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6205377234867511088==--
