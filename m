From: Sebastian Werner <Sebastian.Werner@shd-online.de>
Date: Mon, 06 May 2013 12:31:11 +0000
Subject: [lm-sensors] Getting correct temperature information from Intel 945GSE/ICH7M
Message-Id: <CE0521C9E8FCC646A7D4D5C05886A095604FFD4A@SHDEXMBX1.shd-online.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="_000_CE0521C9E8FCC646A7D4D5C05886A095604FFD4ASHDEXMBX1shdonl_"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============6196183615875891639==
Content-Language: de-DE
Content-Type: multipart/alternative;
	boundary="_000_CE0521C9E8FCC646A7D4D5C05886A095604FFD4ASHDEXMBX1shdonl_"

--_000_CE0521C9E8FCC646A7D4D5C05886A095604FFD4ASHDEXMBX1shdonl_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

I am trying to get the right temperature from two different pieces of hardw=
are.
The first, newest piece (http://www.jetwaycomputer.com/ITX-JBC362F36.html) =
works right out of the box. Got lm-sensor on the debian system, sensors-det=
ect tells me to modprobe lm78 and the temperature is roughly the same as th=
e one shown in the bios.

Acpitz-virtual-0
Adapter: Virtual device
Temp1:              +40.0=B0C  (crit =3D +127.0=B0C)
Temp2:              +26.8=B0C  (crit =3D +127.0=B0C)
Temp3:              +26.8=B0C  (crit =3D +100.0=B0C)

Not temp2 and temp3 though. Both temperatures never change and they have no=
 connection to anything I can read in the bios.
I presumed that those are 'dead wires' and I am at the moment ignoring thos=
e, since temp1 is good enough for me.

The second, the older piece (http://www.jetwaycomputer.com/ITX-JBC360F33-B.=
html) does not seem to work. Sensors-detect tells me to load coretemp, usin=
g the latest version of sensors-detect from the site wants to also me to lo=
ad the f71882fg driver. That doesn't work out with a 'No such device' error=
.

Acpitz-virtual-0
Adapter: Virtual device
Temp1:              +30.0=B0C  (crit =3D +100.0=B0C)
Coretemp-iso-0000
Core 0:               +30.0=B0C  (crit =3D +90.0=B0C)

Both are no realistic values. Temp1 never changes. The Core 0 temperature s=
eems too low (both systems feel roughly the same to the touch from the outs=
ide), it does change if I put a ventilator beside it.

I feel quite out of my field in this, could someone give me a pointer or tw=
o what might be going on or where I could read up to understand this weird =
situation?
Thanks in advance

Best regards,
Sebastian


***************************************************=0AAutomatisch angehangener Disclaimer von SHD=0Aaufgrund der aktuellen Rechtslage=0A***************************************************=0ASHD System-Haus-Dresden GmbH - Computerloesungen =0AGeschaeftsfuehrer: Dr. Frank Karow, Dr. Falk Ambos=0ASitz der Gesellschaft ist Dresden=0AHandelsregister: HRB Nr. 329 Amtsgericht Dresden=0AUmsatzsteueridentifikationsnummer: DE140131570=0A***************************************************=0A


--_000_CE0521C9E8FCC646A7D4D5C05886A095604FFD4ASHDEXMBX1shdonl_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<style><!--
/* Font Definitions */
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
span.E-MailFormatvorlage17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 2.0cm 70.85pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"DE" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hello,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I am trying to get the right te=
mperature from two different pieces of hardware.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">The first, newest piece (http:/=
/www.jetwaycomputer.com/ITX-JBC362F36.html) works right out of the box. Got=
 lm-sensor on the debian system, sensors-detect tells me to modprobe lm78 a=
nd the temperature is roughly the same
 as the one shown in the bios.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Acpitz-virtual-0<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Adapter: Virtual device<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Temp1:&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &#43;40.0</span>=B0<s=
pan lang=3D"EN-US">C&nbsp; (crit =3D &#43;127.0</span>=B0<span lang=3D"EN-U=
S">C)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Temp2:&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &#43;26.8=B0C&nbsp; (=
crit =3D &#43;127.0=B0C)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Temp3:&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &#43;26.8=B0C&nbsp; (=
crit =3D &#43;100.0=B0C)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Not temp2 and temp3 though. Bot=
h temperatures never change and they have no connection to anything I can r=
ead in the bios.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I presumed that those are &#821=
6;dead wires&#8217; and I am at the moment ignoring those, since temp1 is g=
ood enough for me.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">The second, the older piece (ht=
tp://www.jetwaycomputer.com/ITX-JBC360F33-B.html) does not seem to work. Se=
nsors-detect tells me to load coretemp, using the latest version of sensors=
-detect from the site wants to also
 me to load the f71882fg driver. That doesn&#8217;t work out with a &#8216;=
No such device&#8217; error.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Acpitz-virtual-0<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Adapter: Virtual device<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Temp1:&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &#43;30.0=B0C&nbsp; (=
crit =3D &#43;100.0=B0C)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Coretemp-iso-0000<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Core 0:&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &#43;30.0=B0C&=
nbsp; (crit =3D &#43;90.0=B0C)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Both are no realistic values. T=
emp1 never changes. The Core 0 temperature seems too low (both systems feel=
 roughly the same to the touch from the outside), it does change if I put a=
 ventilator beside it.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I feel quite out of my field in=
 this, could someone give me a pointer or two what might be going on or whe=
re I could read up to understand this weird situation?<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Thanks in advance<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Best regards,<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Sebastian<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
</div>

<br>=
<div style=3D"font-family: Arial, Helvetica, sans-serif; font-size: 11px;">=0A*******************************************************************<br />=0AAutomatisch angehangener Disclaimer von SHD an alle ausgehenden<br />=0AMails aufgrund der aktuellen Rechtslage<br />=0A*******************************************************************<br />=0ASHD System-Haus-Dresden GmbH - Computerloesungen<br />=0AGeschaeftsfuehrer: Dr. Frank Karow, Dr. Falk Ambos<br />=0ASitz der  Gesellschaft ist Dresden<br />=0AHandelsregister: HRB Nr. 329 Amtsgericht Dresden<br />=0AUmsatzsteueridentifikationsnummer: DE140131570<br />=0A*******************************************************************<br />=0A</div>=0A
<br>=
</body>
</html>

--_000_CE0521C9E8FCC646A7D4D5C05886A095604FFD4ASHDEXMBX1shdonl_--


--===============6196183615875891639==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6196183615875891639==--
