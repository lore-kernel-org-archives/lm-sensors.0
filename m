From: "Hu Mingkai-B21284" <B21284@freescale.com>
Date: Tue, 21 Oct 2008 11:23:58 +0000
Subject: [lm-sensors] How the lm-sensors communicate with the device driver
Message-Id: <CF6163088BDE8747873ADAA4AF922BF258D530@zmy16exm21.fsl.freescale.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C9336F.8B15836A"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

--===============7256121693677183935==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C9336F.8B15836A"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C9336F.8B15836A
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi All,
=20
I wrote a MCP3021's driver using the new I2C device model under Linux
2.6.26.
The chip MCP3021 is connected to Freescale's I2C controller.
Now it works well, the following is the log info:
=20
-sh-2.05b# ls /sys/bus/i2c/drivers/mcp3021/
0-004d  1-004d  bind  module  uevent  unbind
-sh-2.05b#
=20
-sh-2.05b# cat /sys/bus/i2c/drivers/mcp3021/0-004d/name
mcp3021
-sh-2.05b# cat /sys/bus/i2c/drivers/mcp3021/0-004d/in0_input
213
-sh-2.05b# cat /sys/bus/i2c/drivers/mcp3021/0-004d/in0_max
213
-sh-2.05b# cat /sys/bus/i2c/drivers/mcp3021/0-004d/in0_min
192=20
-sh-2.05b# cat /sys/bus/i2c/drivers/mcp3021/0-004d/curr1_input
960
-sh-2.05b# cat /sys/bus/i2c/drivers/mcp3021/0-004d/curr1_max
1065
-sh-2.05b# cat /sys/bus/i2c/drivers/mcp3021/0-004d/curr1_min
945
=20
-sh-2.05b# sensors
mcp3021-i2c-0-4d

Adapter: MPC adapter
in0:         +0.21 V  (min =3D  +0.19 V, max =3D  +0.22 V)
=20
mcp3021-i2c-1-4d
Adapter: MPC adapter
in0:         +0.41 V  (min =3D  +0.41 V, max =3D  +0.41 V)

Q:
1. How the lm-sensors communicate with the device driver?=20
2. How the lm-sensors get the attribute info?
2. Why the current info, i.e. curr1_x, doesn't list ?
=20
Thanks,
Vincent

------_=_NextPart_001_01C9336F.8B15836A
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3395" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D217551310-21102008>Hi=20
All,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D217551310-21102008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D217551310-21102008>I&nbsp;wrote a=20
MCP3021's driver using the new I2C device model under Linux=20
2.6.26.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D217551310-21102008>The&nbsp;chip=20
MCP3021 is&nbsp;</SPAN></FONT><FONT face=3DArial size=3D2><SPAN=20
class=3D217551310-21102008>connected to Freescale's I2C=20
controller.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D217551310-21102008>Now it =
works well,=20
the following is the log info:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D217551310-21102008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D217551310-21102008>-sh-2.05b# ls=20
/sys/bus/i2c/drivers/mcp3021/<BR>0-004d&nbsp; 1-004d&nbsp; bind&nbsp;=20
module&nbsp; uevent&nbsp; unbind<BR>-sh-2.05b#</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D217551310-21102008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D217551310-21102008>-sh-2.05b# cat=20
/sys/bus/i2c/drivers/mcp3021/0-004d/name<BR>mcp3021<BR>-sh-2.05b# cat=20
/sys/bus/i2c/drivers/mcp3021/0-004d/in0_input</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D217551310-21102008>213<BR>-sh-2.05b#=20
cat /sys/bus/i2c/drivers/mcp3021/0-004d/in0_max</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D217551310-21102008>213<BR>-sh-2.05b#=20
cat /sys/bus/i2c/drivers/mcp3021/0-004d/in0_min</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D217551310-21102008>192</SPAN></FONT><FONT face=3DArial =
size=3D2><SPAN=20
class=3D217551310-21102008>&nbsp;</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D217551310-21102008>-sh-2.05b# cat=20
/sys/bus/i2c/drivers/mcp3021/0-004d/curr1_input</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D217551310-21102008>960<BR>-sh-2.05b#=20
cat /sys/bus/i2c/drivers/mcp3021/0-004d/curr1_max</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D217551310-21102008>1065<BR>-sh-2.05b#=20
cat /sys/bus/i2c/drivers/mcp3021/0-004d/curr1_min</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D217551310-21102008>945</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D217551310-21102008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D217551310-21102008>-sh-2.05b#=20
sensors<BR>mcp3021-i2c-0-4d<BR></SPAN></FONT><FONT face=3DArial=20
size=3D2></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D217551310-21102008>Adapter: MPC=20
adapter</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D217551310-21102008>in0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;=20
+0.21 V&nbsp; (min =3D&nbsp; +0.19 V, max =3D&nbsp; +0.22 =
V)</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D217551310-21102008>mcp3021-i2c-1-4d<BR>Adapter: MPC=20
adapter<BR>in0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +0.41 =
V&nbsp;=20
(min =3D&nbsp; +0.41 V, max =3D&nbsp; +0.41 V)</SPAN></FONT></DIV><SPAN=20
class=3D217551310-21102008>
<DIV><FONT face=3DArial size=3D2></FONT><FONT face=3DArial =
size=3D2></FONT><FONT=20
face=3DArial size=3D2></FONT><FONT face=3DArial size=3D2></FONT><FONT =
face=3DArial=20
size=3D2></FONT><FONT face=3DArial size=3D2></FONT><FONT face=3DArial=20
size=3D2></FONT><BR><SPAN class=3D217551310-21102008><FONT face=3DArial=20
size=3D2>Q:</FONT></SPAN></DIV>
<DIV><SPAN class=3D217551310-21102008><FONT face=3DArial size=3D2>1. How =
the=20
lm-sensors communicate with the device driver? </FONT></SPAN></DIV>
<DIV><SPAN class=3D217551310-21102008><FONT face=3DArial size=3D2>2. How =
the=20
lm-sensors get the attribute info?</FONT></SPAN></DIV>
<DIV><SPAN class=3D217551310-21102008><FONT face=3DArial size=3D2>2. Why =
the current=20
info, i.e. curr1_x, doesn't list ?</FONT></SPAN></DIV>
<DIV><SPAN class=3D217551310-21102008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D217551310-21102008><FONT face=3DArial=20
size=3D2>Thanks,</FONT></SPAN></DIV>
<DIV><SPAN class=3D217551310-21102008><FONT face=3DArial=20
size=3D2>Vincent</FONT></SPAN></DIV></SPAN></FONT></DIV></BODY></HTML>

------_=_NextPart_001_01C9336F.8B15836A--


--===============7256121693677183935==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7256121693677183935==--
