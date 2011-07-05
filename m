From: Kazuya <kazuya25@hotmail.fr>
Date: Tue, 05 Jul 2011 12:52:13 +0000
Subject: Re: [lm-sensors] IT8772E info and reports
Message-Id: <BLU0-SMTP673BF01D202E0D975C3AE3A05F0@phx.gbl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7101814449665781951=="
List-Id: <lm-sensors.vger.kernel.org>
References: <BLU0-SMTP109A7F3B6369B02834007CAA05C0@phx.gbl>
In-Reply-To: <BLU0-SMTP109A7F3B6369B02834007CAA05C0@phx.gbl>
To: lm-sensors@vger.kernel.org

--===============7101814449665781951==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0017_01CC3B1A.BFECFDF0"
Content-Language: fr

------=_NextPart_000_0017_01CC3B1A.BFECFDF0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

=20

=20

With the force_id=3D0x8721 parameter, the driver should load fine.

However we don't know how compatible the IT8772E chip is with the =
IT8721F, so it may not work perfectly. That's why we were calling for =
testers.

It works however there is still some troubles :

it8721-isa-0a30

Adapter: ISA adapter

in0:         +1.01 V  (min =3D  +0.82 V, max =3D  +0.58 V)   ALARM

in1:         +1.60 V  (min =3D  +0.94 V, max =3D  +1.56 V)   ALARM

in2:         +1.07 V  (min =3D  +2.56 V, max =3D  +1.20 V)   ALARM

in3:         +1.04 V  (min =3D  +2.40 V, max =3D  +2.44 V)   ALARM

in4:         +0.49 V  (min =3D  +1.93 V, max =3D  +1.73 V)   ALARM

in5:         +2.22 V  (min =3D  +0.12 V, max =3D  +2.59 V)

in6:         +2.22 V  (min =3D  +1.02 V, max =3D  +1.93 V)   ALARM

3VSB:        +3.31 V  (min =3D  +5.57 V, max =3D  +0.05 V)   ALARM

Vbat:        +3.26 V

fan1:          0 RPM  (min =3D   57 RPM)  ALARM

fan2:       1397 RPM  (min =3D   19 RPM)

fan3:          0 RPM  (min =3D   79 RPM)  ALARM

temp1:       +42.0=C3=82=C2=B0C  (low  =3D -35.0=C3=82=C2=B0C, high =3D =
+17.0=C3=82=C2=B0C)  ALARM  sensor =3D thermistor

temp2:       +54.0=C3=82=C2=B0C  (low  =3D +64.0=C3=82=C2=B0C, high =3D =
+76.0=C3=82=C2=B0C)  ALARM  sensor =3D thermal diode

temp3:      -128.0=C3=82=C2=B0C  (low  =3D +57.0=C3=82=C2=B0C, high =3D =
+54.0=C3=82=C2=B0C)  sensor =3D disabled

=20

=20

So ideally you'd write down every monitored value in your BIOS, and =
compare with the output of "sensors" under Linux, and we can try to =
write a configuration file for your board, and we see if any problem =
shows up.

How can I write down every monitored value in my bios ?

=20

Thanks (et Merci pour Jean)


------=_NextPart_000_0017_01CC3B1A.BFECFDF0
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta =
http-equiv=3DContent-Type content=3D"text/html; charset=3Dutf-8"><meta =
name=3DGenerator content=3D"Microsoft Word 14 (filtered =
medium)"><style><!--
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
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Texte brut Car";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
span.TextebrutCar
	{mso-style-name:"Texte brut Car";
	mso-style-priority:99;
	mso-style-link:"Texte brut";
	font-family:"Calibri","sans-serif";}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 70.85pt 70.85pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DFR link=3Dblue =
vlink=3Dpurple><div class=3DWordSection1><p =
class=3DMsoPlainText>Hi,<o:p></o:p></p><p =
class=3DMsoPlainText><b><o:p>&nbsp;</o:p></b></p><p =
class=3DMsoPlainText><b><o:p>&nbsp;</o:p></b></p><p =
class=3DMsoPlainText><b><span lang=3DEN-US>With the force_id=3D0x8721 =
parameter, the driver should load fine.<o:p></o:p></span></b></p><p =
class=3DMsoPlainText><b>However we don't know how compatible the IT8772E =
chip is with the IT8721F, so it may not work perfectly. That's why we =
were calling for testers.<o:p></o:p></b></p><p =
class=3DMsoPlainText><span lang=3DEN-US>It works however there is still =
some troubles :<o:p></o:p></span></p><p class=3DMsoPlainText =
style=3D'margin-left:70.8pt'>it8721-isa-0a30<o:p></o:p></p><p =
class=3DMsoPlainText style=3D'margin-left:70.8pt'>Adapter: ISA =
adapter<o:p></o:p></p><p class=3DMsoPlainText =
style=3D'margin-left:70.8pt'><span =
lang=3DEN-US>in0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +1.01 =
V=C2=A0 (min =3D=C2=A0 +0.82 V, max =3D=C2=A0 +0.58 V)=C2=A0=C2=A0 =
ALARM<o:p></o:p></span></p><p class=3DMsoPlainText =
style=3D'margin-left:70.8pt'><span =
lang=3DEN-US>in1:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +1.60 =
V =C2=A0(min =3D=C2=A0 +0.94 V, max =3D=C2=A0 +1.56 V)=C2=A0=C2=A0 =
ALARM<o:p></o:p></span></p><p class=3DMsoPlainText =
style=3D'margin-left:70.8pt'><span =
lang=3DEN-US>in2:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +1.07 =
V=C2=A0 (min =3D=C2=A0 +2.56 V, max =3D=C2=A0 +1.20 V)=C2=A0=C2=A0 =
ALARM<o:p></o:p></span></p><p class=3DMsoPlainText =
style=3D'margin-left:70.8pt'><span =
lang=3DEN-US>in3:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +1.04 =
V=C2=A0 (min =3D=C2=A0 +2.40 V, max =3D=C2=A0 +2.44 V)=C2=A0=C2=A0 =
ALARM<o:p></o:p></span></p><p class=3DMsoPlainText =
style=3D'margin-left:70.8pt'><span =
lang=3DEN-US>in4:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +0.49 =
V=C2=A0 (min =3D=C2=A0 +1.93 V, max =3D=C2=A0 +1.73 V)=C2=A0=C2=A0 =
ALARM<o:p></o:p></span></p><p class=3DMsoPlainText =
style=3D'margin-left:70.8pt'><span =
lang=3DEN-US>in5:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +2.22 =
V=C2=A0 (min =3D=C2=A0 +0.12 V, max =3D=C2=A0 +2.59 =
V)<o:p></o:p></span></p><p class=3DMsoPlainText =
style=3D'margin-left:70.8pt'><span =
lang=3DEN-US>in6:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +2.22 =
V=C2=A0 (min =3D=C2=A0 +1.02 V, max =3D=C2=A0 +1.93 V)=C2=A0=C2=A0 =
ALARM<o:p></o:p></span></p><p class=3DMsoPlainText =
style=3D'margin-left:70.8pt'>3VSB:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 +3.31 V=C2=A0 (min =3D=C2=A0 +5.57 V, max =3D=C2=A0 +0.05 =
V)=C2=A0=C2=A0 ALARM<o:p></o:p></p><p class=3DMsoPlainText =
style=3D'margin-left:70.8pt'>Vbat:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 +3.26 V<o:p></o:p></p><p class=3DMsoPlainText =
style=3D'margin-left:70.8pt'><span =
lang=3DEN-US>fan1:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
0 RPM=C2=A0 (min =3D=C2=A0=C2=A0 57 RPM)=C2=A0 =
ALARM<o:p></o:p></span></p><p class=3DMsoPlainText =
style=3D'margin-left:70.8pt'><span =
lang=3DEN-US>fan2:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1397 RPM=C2=A0 =
(min =3D=C2=A0=C2=A0 19 RPM)<o:p></o:p></span></p><p =
class=3DMsoPlainText style=3D'margin-left:70.8pt'><span =
lang=3DEN-US>fan3:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
0 RPM=C2=A0 (min =3D=C2=A0=C2=A0 79 RPM)=C2=A0 =
ALARM<o:p></o:p></span></p><p class=3DMsoPlainText =
style=3D'margin-left:70.8pt'><span =
lang=3DEN-US>temp1:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
+42.0=C3=82=C2=B0C=C2=A0 (low=C2=A0 =3D -35.0=C3=82=C2=B0C, high =3D =
+17.0=C3=82=C2=B0C)=C2=A0 ALARM=C2=A0 sensor =3D =
thermistor<o:p></o:p></span></p><p class=3DMsoPlainText =
style=3D'margin-left:70.8pt'><span =
lang=3DEN-US>temp2:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
+54.0=C3=82=C2=B0C=C2=A0 (low=C2=A0 =3D +64.0=C3=82=C2=B0C, high =3D =
+76.0=C3=82=C2=B0C)=C2=A0 ALARM=C2=A0 sensor =3D thermal =
diode<o:p></o:p></span></p><p class=3DMsoPlainText =
style=3D'margin-left:70.8pt'><span lang=3DEN-US>temp3<span =
style=3D'color:red'>:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
-128.0=C3=82=C2=B0C=C2=A0 </span>(low=C2=A0 =3D +57.0=C3=82=C2=B0C, high =
=3D +54.0=C3=82=C2=B0C)=C2=A0 sensor =3D =
disabled<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoPlainText><b>So =
ideally you'd write down every monitored value in your BIOS, and compare =
with the output of &quot;sensors&quot; under Linux, and we can try to =
write a configuration file for your board, and we see if any problem =
shows up.<o:p></o:p></b></p><p class=3DMsoNormal>How can I write down =
every monitored value in my bios&nbsp;?<o:p></o:p></p><p =
class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoPlainText>Thanks (et Merci pour =
Jean)<o:p></o:p></p></div></body></html>
------=_NextPart_000_0017_01CC3B1A.BFECFDF0--


--===============7101814449665781951==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7101814449665781951==--
