From: "Justin Piszcz" <jpiszcz@lucidpixels.com>
Date: Wed, 03 Jul 2013 20:59:37 +0000
Subject: Re: [lm-sensors] 3.10: NCT6776F sensor question with Supermicro X9SRL-F motherboard
Message-Id: <00ad01ce7830$3b135890$b13a09b0$@lucidpixels.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8580252658023592817=="
List-Id: <lm-sensors.vger.kernel.org>
References: <002901ce77e9$dfac4f20$9f04ed60$@lucidpixels.com>
In-Reply-To: <002901ce77e9$dfac4f20$9f04ed60$@lucidpixels.com>
To: lm-sensors@vger.kernel.org

This is a multipart message in MIME format.

--===============8580252658023592817==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_00AE_01CE780E.B402A2F0"
Content-language: en-us

This is a multipart message in MIME format.

------=_NextPart_000_00AE_01CE780E.B402A2F0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

 

 

-----Original Message-----
From: Guenter Roeck [mailto:linux@roeck-us.net] 
Sent: Wednesday, July 03, 2013 4:57 PM
To: Justin Piszcz
Cc: linux-kernel@vger.kernel.org; lm-sensors@lm-sensors.org
Subject: Re: [lm-sensors] 3.10: NCT6776F sensor question with Supermicro
X9SRL-F motherboard

 

[ .. ]

 

> 09: 0a 00 00 00 00 0a 0a 0a 0a aa ef 80 ff 40 46 c4 

> 0a: 0e 01 00 00 ff 00 00 ff 00 00 80 66 66 06 01 01 

                                                ^^

This shows that PECI Agent 0 is supposed to be enabled.

 

> Bank 2:

>     00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 

> 00: 8c 32 00 01 01 33 01 3c ff 33 ff ff 00 ff ff ff 

      ^^

This value suggests that the second temperature sensor (the one creating

the alarm) is supposed to be the PECI source (which reports the CPU
temperature

to the NCT6776), and that it is supposed to be used to control the speed

of the CPU fan.

            ^^

Fan control is in manual mode. Did you set this ?

It is quite unusual.

 

Setting:                

Current FAN Mode is Optimal.

Set Fan to Standard Speed

Set Fan to Full Speed

Set Fan to Optimal Speed

 

> Bank 7:

>     00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 

> 00: ff 95 02 10 00 00 00 00 00 64 00 00 00 00 00 00 

> 01: 00 00 00 00 00 00 00 f8 80 f8 80 f8 80 f8 80 00 

                                                   ^^

00 here shows that the PECI source is not active, ie the CPU does not
deliver

PECI data to the NCT6776. This explains the alarm.

 

Practical impact is probably limited as fan control is configured to be
manual

anyway, but I wonder why PECI doesn't work on your board. PECI configuration

is identical to my Supermicro board.

 

Guenter


------=_NextPart_000_00AE_01CE780E.B402A2F0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><META =
HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word 14 =
(filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Balloon Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif";}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri","sans-serif";}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-priority:99;
	mso-style-link:"Balloon Text";
	font-family:"Tahoma","sans-serif";}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US =
link=3D"#0563C1" vlink=3D"#954F72"><div class=3DWordSection1><p =
class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>-----Original Message-----<br>From: Guenter Roeck =
[mailto:linux@roeck-us.net] <br>Sent: Wednesday, July 03, 2013 4:57 =
PM<br>To: Justin Piszcz<br>Cc: linux-kernel@vger.kernel.org; =
lm-sensors@lm-sensors.org<br>Subject: Re: [lm-sensors] 3.10: NCT6776F =
sensor question with Supermicro X9SRL-F motherboard</p><p =
class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p class=3DMsoPlainText>[ .. =
]<o:p></o:p></p><p class=3DMsoPlainText><span =
style=3D'color:black'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoPlainText>&gt; 09: 0a 00 00 00 00 0a 0a 0a 0a aa ef 80 ff 40 =
46 c4 <o:p></o:p></p><p class=3DMsoPlainText>&gt; 0a: 0e 01 00 00 ff 00 =
00 ff 00 00 80 66 66 06 01 01 <o:p></o:p></p><p =
class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;^^<o:p></o:p></p><p class=3DMsoPlainText>This shows =
that PECI Agent 0 is supposed to be enabled.<o:p></o:p></p><p =
class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p class=3DMsoPlainText>&gt; =
Bank 2:<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;&nbsp;&nbsp;&nbsp;&nbsp; 00 01 02 03 04 05 06 =
07 08 09 0a 0b 0c 0d 0e 0f <o:p></o:p></p><p class=3DMsoPlainText>&gt; =
00: 8c 32 00 01 01 33 01 3c ff 33 ff ff 00 ff ff ff <o:p></o:p></p><p =
class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;^^<o:p></o:p></p=
><p class=3DMsoPlainText>This value suggests that the second temperature =
sensor (the one creating<o:p></o:p></p><p class=3DMsoPlainText>the =
alarm) is supposed to be the PECI source (which reports the CPU =
temperature<o:p></o:p></p><p class=3DMsoPlainText>to the NCT6776), and =
that it is supposed to be used to control the speed<o:p></o:p></p><p =
class=3DMsoPlainText>of the CPU fan.<o:p></o:p></p><p =
class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ^^<o:p></o:p></p><p class=3DMsoPlainText>Fan control is =
in manual mode. Did you set this ?<o:p></o:p></p><p =
class=3DMsoPlainText>It is quite unusual.<o:p></o:p></p><p =
class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p class=3DMsoPlainText><span =
style=3D'color:black'>Setting:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <o:p></o:p></span></p><p =
class=3DMsoPlainText><span style=3D'color:black'>Current FAN Mode is =
Optimal.<o:p></o:p></span></p><p class=3DMsoPlainText><span =
style=3D'color:black'>Set Fan to Standard Speed<o:p></o:p></span></p><p =
class=3DMsoPlainText><span style=3D'color:black'>Set Fan to Full =
Speed<o:p></o:p></span></p><p class=3DMsoPlainText><span =
style=3D'color:black'>Set Fan to Optimal Speed<o:p></o:p></span></p><p =
class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p class=3DMsoPlainText>&gt; =
Bank 7:<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;&nbsp;&nbsp;&nbsp;&nbsp; 00 01 02 03 04 05 06 =
07 08 09 0a 0b 0c 0d 0e 0f <o:p></o:p></p><p class=3DMsoPlainText>&gt; =
00: ff 95 02 10 00 00 00 00 00 64 00 00 00 00 00 00 <o:p></o:p></p><p =
class=3DMsoPlainText>&gt; 01: 00 00 00 00 00 00 00 f8 80 f8 80 f8 80 f8 =
80 00 <o:p></o:p></p><p =
class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;^^<o:p></o:p></p><p =
class=3DMsoPlainText>00 here shows that the PECI source is not active, =
ie the CPU does not deliver<o:p></o:p></p><p class=3DMsoPlainText>PECI =
data to the NCT6776. This explains the alarm.<o:p></o:p></p><p =
class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>Practical impact is probably limited as fan control =
is configured to be manual<o:p></o:p></p><p class=3DMsoPlainText>anyway, =
but I wonder why PECI doesn't work on your board. PECI =
configuration<o:p></o:p></p><p class=3DMsoPlainText>is identical to my =
Supermicro board.<o:p></o:p></p><p =
class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>Guenter<o:p></o:p></p><p class=3DMsoPlainText> =
<o:p></o:p></p></div></body></html>
------=_NextPart_000_00AE_01CE780E.B402A2F0--



--===============8580252658023592817==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8580252658023592817==--

