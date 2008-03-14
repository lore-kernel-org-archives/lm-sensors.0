From: "Alek Uritsky" <auritsky@enqii.com>
Date: Fri, 14 Mar 2008 20:24:59 +0000
Subject: [lm-sensors] problems compiling 2.10.5
Message-Id: <001001c88611$79fa1e20$b701010a@ALEK4E31DD5E>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2023892883813571516=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============2023892883813571516==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_000D_01C885EF.F2A5A8C0"

------=_NextPart_000_000D_01C885EF.F2A5A8C0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,

=20

I am trying to compile lm_sensors 2.10.5 on Fedora 6 box with kernel 2.6.=
22

(for some reasons, 2.10.1-1 that comes with the distro does not want to d=
etect sensors)

I have a huge number of compilation errors  (starting with lib/data.c ) w=
hich seems to be a result of the difference in .h files (should I post th=
e errors?).

Is this a known problem? What would be the way to proceed?

=20

Thank in advance

 alek

------=_NextPart_000_000D_01C885EF.F2A5A8C0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Diso-8859-=
1">
<META content=3D"MSHTML 6.00.6000.16525" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT face=3D"Times Ne=
w Roman"=20
size=3D3>Hi all,</FONT></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><?xml:namespace prefix=
 =3D o ns =3D=20
"urn:schemas-microsoft-com:office:office" /><o:p><FONT face=3D"Times New R=
oman"=20
size=3D3>&nbsp;</FONT></o:p></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT face=3D"Times Ne=
w Roman"=20
size=3D3>I am trying to compile lm_sensors 2.10.5 on Fedora 6 box with ke=
rnel=20
2.6.22</FONT></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT face=3D"Times Ne=
w Roman"=20
size=3D3>(for some reasons, 2.10.1-1 that comes with the distro does not w=
ant to=20
detect sensors)</FONT></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT face=3D"Times Ne=
w Roman"=20
size=3D3>I have a huge number of compilation errors&nbsp; (starting with=20
lib/data.c ) which seems to be a result of the difference in .h files (sh=
ould I=20
post the errors?).</FONT></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT face=3D"Times Ne=
w Roman"=20
size=3D3>Is this a known problem? What would be the way to proceed?</FONT=
></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><o:p><FONT face=3D"Tim=
es New Roman"=20
size=3D3>&nbsp;</FONT></o:p></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT face=3D"Times Ne=
w Roman"=20
size=3D3>Thank in advance</FONT></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><o:p><FONT face=3D"Tim=
es New Roman"=20
size=3D3>&nbsp;<FONT face=3DArial=20
size=3D2>alek</FONT></FONT></o:p></P></FONT></DIV></BODY></HTML>

------=_NextPart_000_000D_01C885EF.F2A5A8C0--


--===============2023892883813571516==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2023892883813571516==--
