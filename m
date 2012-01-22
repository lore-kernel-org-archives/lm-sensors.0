From: "Mike Gorchak" <lestat@i.com.ua>
Date: Sun, 22 Jan 2012 18:43:08 +0000
Subject: [lm-sensors] Support for SMBus based GMT G781 and G7811 temperature sensors.
Message-Id: <EC359208AB4F4249B8EA5A0018A7B178@ISLA>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3947660060762313545=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

--===============3947660060762313545==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0000_01CCD946.7FEB0AB0"

This is a multi-part message in MIME format.

------=_NextPart_000_0000_01CCD946.7FEB0AB0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi All,
 
I've recently found that lm-sensors doesn't have support for Global
Mixed-mode Technology Inc. (GMT) G781 and G7811 temperature sensors.
 
Overview datasheets are available on manufacturer's site:
http://www.gmt.com.tw/ , registers datasheet is available here:
www.datasheetcatalog.org/datasheets2/35/350422_1.pdf
 
It seems that this device is registers compatible with ADM1032. SMBus
manufacturer id 0x47, device ids 0x01 and 0x03.
 
Thanks!
 

------=_NextPart_000_0000_01CCD946.7FEB0AB0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Dus-ascii" =
http-equiv=3DContent-Type>
<META name=3DGENERATOR content=3D"MSHTML 9.00.8112.16440"></HEAD>
<BODY>
<DIV><SPAN class=3D885132318-22012012><FONT size=3D2 face=3DArial>Hi=20
All,</FONT></SPAN></DIV>
<DIV><SPAN class=3D885132318-22012012><FONT size=3D2=20
face=3DArial></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D885132318-22012012><FONT size=3D2 face=3DArial>I've =
recently found=20
that lm-sensors doesn't have support for Global Mixed-mode Technology =
Inc. (GMT)=20
G781 and G7811 temperature sensors.</FONT></SPAN></DIV>
<DIV><SPAN class=3D885132318-22012012><FONT size=3D2=20
face=3DArial></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D885132318-22012012><FONT size=3D2 =
face=3DArial>Overview datasheets=20
are available&nbsp;on manufacturer's site: <A=20
href=3D"http://www.gmt.com.tw/">http://www.gmt.com.tw/</A>&nbsp;, =
registers=20
datasheet is available here: <A=20
href=3D"http://www.datasheetcatalog.org/datasheets2/35/350422_1.pdf">www.=
datasheetcatalog.org/datasheets2/35/350422_1.pdf</A></FONT></SPAN></DIV>
<DIV><SPAN class=3D885132318-22012012><FONT size=3D2=20
face=3DArial></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D885132318-22012012><FONT size=3D2 face=3DArial>It =
seems that this=20
device is registers compatible with ADM1032. </FONT></SPAN><SPAN=20
class=3D885132318-22012012><FONT size=3D2 face=3DArial>SMBus =
manufacturer&nbsp;id=20
0x47, device&nbsp;ids 0x01 and 0x03.</FONT></SPAN></DIV>
<DIV><SPAN class=3D885132318-22012012><FONT size=3D2=20
face=3DArial></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D885132318-22012012><FONT size=3D2=20
face=3DArial>Thanks!</FONT></SPAN></DIV>
<DIV><SPAN class=3D885132318-22012012><FONT size=3D2=20
face=3DArial></FONT></SPAN>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_0000_01CCD946.7FEB0AB0--



--===============3947660060762313545==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3947660060762313545==--

