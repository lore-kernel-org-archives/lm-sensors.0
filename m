From: "Peter Eser" <Peter.Eser@heuft.com>
Date: Thu, 31 Jan 2008 15:32:10 +0000
Subject: [lm-sensors] failed to load it87 module on IT8712F
Message-Id: <002001c8641e$71d8f6e0$180411ac@EDVW14>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3475932318848385398=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

--===============3475932318848385398==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_001D_01C86426.D3943720"

This is a multi-part message in MIME format.

------=_NextPart_000_001D_01C86426.D3943720
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

I have a Aeeon PCM8120 board with VIA CX700M.
On the VIA homepage its equipped with VT1211.
But on board I find a (additional?) IT8712F and=20
sensors detect finds only this one and says: (but not activated).
modprobe vt1211 and it87 both say no such device.

Bus module i2c-viapro has no problem.
All is standard kernel 2.6.24.

The sad thing is I have the it87 module running under=20
kernel 2.2 (because the board is a replacement for an older
one running on this old kernel, by the way this kernel is=20
running fine on the new board). Can modprobe it87 with i2c-isa=20
on the old kernel and get fan,temperatures,voltages.

Any help would be great,

Thanks,    Peter


------=_NextPart_000_001D_01C86426.D3943720
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1589" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hello,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I have a Aeeon PCM8120 board with VIA=20
CX700M.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>On the VIA homepage its equipped with=20
VT1211.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>But&nbsp;on board </FONT><FONT =
face=3DArial size=3D2>I=20
find a </FONT><FONT face=3DArial size=3D2>(additional?) IT8712F and =
</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>sensors detect </FONT><FONT =
face=3DArial size=3D2>finds=20
only this one and says: (but not activated).</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>modprobe vt1211 and it87 both say no =
such=20
device.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Bus module i2c-viapro has no =
problem.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>All is standard kernel =
2.6.24.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>The sad thing is I have the it87 module =
running=20
under </FONT></DIV>
<DIV><FONT face=3DArial size=3D2>kernel 2.2 (because the board is a =
replacement for=20
an older</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>one running on this old kernel, by the =
way this=20
kernel is&nbsp;</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>running fine on the new board). Can =
modprobe it87=20
with i2c-isa </FONT></DIV>
<DIV><FONT face=3DArial size=3D2>on the old kernel and get=20
fan,temperatures,voltages.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Any help would be great,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thanks,&nbsp;&nbsp;&nbsp; =
Peter</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_001D_01C86426.D3943720--



--===============3475932318848385398==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3475932318848385398==--

