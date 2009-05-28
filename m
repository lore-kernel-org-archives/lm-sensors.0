From: "Rob Bloom" <Rob.Bloom@ca.flextronics.com>
Date: Thu, 28 May 2009 14:00:17 +0000
Subject: [lm-sensors] lm-sensors benefits
Message-Id: <0331509C72A4CE4F925973DC8EC98E1B0165F5E4@AMSACEX2.americas.ad.flextronics.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C9DF9C.A266F387"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

--===============1508790979849647179==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C9DF9C.A266F387"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C9DF9C.A266F387
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Many thanks to Hans, Mark and Jonathan for answering my previous email
on specific hwmon chips (turns out 3 of the 4 I questioned are not (yet)
supported by lm-sensors).  I'd like to back-up a bit and ensure I
understand what lm-sensors will do for us in our project:

 

Essentially, we want to be able to read our temp and power monitor chips
every 10 seconds and evaluate the values read (pass them for review to
our own customized health monitoring system).  I've been tasked with
explaining the benefits of using lm-sensors package vs. not using it.
Hopefully my questions do not seem too naive but I'm asking them from
the perspective of having to write drivers (or, at least, assisting) for
unsupported chips:

 

-          As I understand it, the drivers for these chips are not part
of lm-sensors; one must develop the code for the chip in the kernel, if
not already supported by the kernel.  This driver work, if needed, is
done whether or not one chooses to use lm-sensors, correct?

 

-          The libsensors library makes things easier by offering an
interface for apps to access chip readings, configure them and convert
them to real-world values.  It works in conjunction with the
/etc/sensors.conf file.  

o        Is libsensors part of lm-sensors or are they developed and
retrieved independently?  

o        Is lm-sensors considered one of the "apps" mentioned above that
opt to use libsensors to make things easier?

o        Can I choose to write my own app to interface with libsensors
and the hwmon chips?  One of my colleagues asked "why can't we simply
read the chip registers with simple i2c calls over the bus?".

 

-          I skimmed over the lm-sensors source code.  I know that it
was made generic.  So, how does it know what chips it needs to monitor?
I assume this is through the sensors.conf file.  I'm looking for the:

o        lm-sensors source code that discovers the chips that it has
(does it read the sensors.conf file?  Where is the lm-sensors code that
does this?)

o        lm-sensors source code that utilizes the kernel drivers that
sit in /drivers/hwmon directory.  Could you point me to this code?  

 

If the info I am looking for is already in some doc'n somewhere, feel
free to point me to it.  I have perused a good bit of doc'n by now but
maybe I've missed it.

 

Thanks for your helpful comments and tips.

 

Rob Bloom
Software Design Engineer
Flextronics Canada Design Services




Legal Disclaimer:=0A=
The information contained in this message may be privileged and confidential=
. It is intended to be read only by the individual or entity to whom it is a=
ddressed or by their designee. If the reader of this message is not the inte=
nded recipient, you are on notice that any distribution of this message, in=
 any form, is strictly prohibited. If you have received this message in erro=
r, please immediately notify the sender and delete or destroy any copy of th=
is message

------_=_NextPart_001_01C9DF9C.A266F387
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sch=
emas-microsoft-com:office:word" xmlns:st1=3D"urn:schemas-microsoft-com:offic=
e:smarttags" xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"country-region"/>
<o:SmartTagType namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"place"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:"Trebuchet MS";
	panose-1:2 11 6 3 2 2 2 2 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
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
	font-family:"Trebuchet MS";
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
 /* List Definitions */
 @list l0
	{mso-list-id:956061968;
	mso-list-type:hybrid;
	mso-list-template-ids:-980674638 -726516646 67698691 67698693 67698689 6769=
8691 67698693 67698689 67698691 67698693;}
@list l0:level1
	{mso-level-start-at:16;
	mso-level-number-format:bullet;
	mso-level-text:-;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Trebuchet MS";
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:Arial;}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3D"Trebuchet MS"><span style=3D'fon=
t-size:
10.0pt;font-family:"Trebuchet MS"'>Many thanks to Hans, Mark and Jonathan fo=
r answering
my previous email on specific hwmon chips (turns out 3 of the 4 I questioned
are not (yet) supported by lm-sensors).&nbsp; I&#8217;d like to back-up a bi=
t
and ensure I understand what lm-sensors will do for us in our project:<o:p><=
/o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Trebuchet MS"><span style=3D'fon=
t-size:
10.0pt;font-family:"Trebuchet MS"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Trebuchet MS"><span style=3D'fon=
t-size:
10.0pt;font-family:"Trebuchet MS"'>Essentially, we want to be able to read o=
ur
temp and power monitor chips every 10 seconds and evaluate the values read
(pass them for review to our own customized health monitoring system).&nbsp;=
 I&#8217;ve
been tasked with explaining the benefits of using lm-sensors package vs. not
using it.&nbsp; Hopefully my questions do not seem too naive but I&#8217;m
asking them from the perspective of having to write drivers (or, at least,
assisting) for unsupported chips:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Trebuchet MS"><span style=3D'fon=
t-size:
10.0pt;font-family:"Trebuchet MS"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-indent:-.25in;mso-list:l=
0 level1 lfo1'><![if !supportLists]><font
size=3D2 face=3D"Trebuchet MS"><span style=3D'font-size:10.0pt;font-family:"=
Trebuchet MS"'><span
style=3D'mso-list:Ignore'>-<font size=3D1 face=3D"Times New Roman"><span
style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;
</span></font></span></span></font><![endif]><font size=3D2 face=3D"Trebuche=
t MS"><span
style=3D'font-size:10.0pt;font-family:"Trebuchet MS"'>As I understand it, th=
e
drivers for these chips are not part of lm-sensors; one must develop the cod=
e
for the chip in the kernel, if not already supported by the kernel.&nbsp; Th=
is
driver work, if needed, is done whether or not one chooses to use lm-sensors=
,
correct?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Trebuchet MS"><span style=3D'fon=
t-size:
10.0pt;font-family:"Trebuchet MS"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-indent:-.25in;mso-list:l=
0 level1 lfo1'><![if !supportLists]><font
size=3D2 face=3D"Trebuchet MS"><span style=3D'font-size:10.0pt;font-family:"=
Trebuchet MS"'><span
style=3D'mso-list:Ignore'>-<font size=3D1 face=3D"Times New Roman"><span
style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;
</span></font></span></span></font><![endif]><font size=3D2 face=3D"Trebuche=
t MS"><span
style=3D'font-size:10.0pt;font-family:"Trebuchet MS"'>The libsensors library=
 makes
things easier by offering an interface for apps to access chip readings, con=
figure
them and convert them to real-world values.&nbsp; It works in conjunction wi=
th the
/etc/sensors.conf file.&nbsp; <o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:1.0in;text-indent:-.25in;mso-list:=
l0 level2 lfo1'><![if !supportLists]><font
size=3D2 face=3D"Courier New"><span style=3D'font-size:10.0pt;font-family:"C=
ourier New"'><span
style=3D'mso-list:Ignore'>o<font size=3D1 face=3D"Times New Roman"><span
style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;
</span></font></span></span></font><![endif]><font size=3D2 face=3D"Trebuche=
t MS"><span
style=3D'font-size:10.0pt;font-family:"Trebuchet MS"'>Is libsensors part of
lm-sensors or are they developed and retrieved independently?&nbsp; <o:p></o=
:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:1.0in;text-indent:-.25in;mso-list:=
l0 level2 lfo1'><![if !supportLists]><font
size=3D2 face=3D"Courier New"><span style=3D'font-size:10.0pt;font-family:"C=
ourier New"'><span
style=3D'mso-list:Ignore'>o<font size=3D1 face=3D"Times New Roman"><span
style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;
</span></font></span></span></font><![endif]><font size=3D2 face=3D"Trebuche=
t MS"><span
style=3D'font-size:10.0pt;font-family:"Trebuchet MS"'>Is lm-sensors consider=
ed
one of the &#8220;apps&#8221; mentioned above that opt to use libsensors to
make things easier?<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:1.0in;text-indent:-.25in;mso-list:=
l0 level2 lfo1'><![if !supportLists]><font
size=3D2 face=3D"Courier New"><span style=3D'font-size:10.0pt;font-family:"C=
ourier New"'><span
style=3D'mso-list:Ignore'>o<font size=3D1 face=3D"Times New Roman"><span
style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;
</span></font></span></span></font><![endif]><font size=3D2 face=3D"Trebuche=
t MS"><span
style=3D'font-size:10.0pt;font-family:"Trebuchet MS"'>Can I choose to write=
 my
own app to interface with libsensors and the hwmon chips?&nbsp; One of my
colleagues asked &#8220;why can&#8217;t we simply read the chip registers wi=
th
simple i2c calls over the bus?&#8221;.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Trebuchet MS"><span style=3D'fon=
t-size:
10.0pt;font-family:"Trebuchet MS"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-indent:-.25in;mso-list:l=
0 level1 lfo1'><![if !supportLists]><font
size=3D2 face=3D"Trebuchet MS"><span style=3D'font-size:10.0pt;font-family:"=
Trebuchet MS"'><span
style=3D'mso-list:Ignore'>-<font size=3D1 face=3D"Times New Roman"><span
style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;
</span></font></span></span></font><![endif]><font size=3D2 face=3D"Trebuche=
t MS"><span
style=3D'font-size:10.0pt;font-family:"Trebuchet MS"'>I skimmed over the lm-=
sensors
source code.&nbsp; I know that it was made generic.&nbsp; So, how does it kn=
ow
what chips it needs to monitor?&nbsp; I assume this is through the sensors.c=
onf
file.&nbsp; I&#8217;m looking for the:<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:1.0in;text-indent:-.25in;mso-list:=
l0 level2 lfo1'><![if !supportLists]><font
size=3D2 face=3D"Courier New"><span style=3D'font-size:10.0pt;font-family:"C=
ourier New"'><span
style=3D'mso-list:Ignore'>o<font size=3D1 face=3D"Times New Roman"><span
style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;
</span></font></span></span></font><![endif]><font size=3D2 face=3D"Trebuche=
t MS"><span
style=3D'font-size:10.0pt;font-family:"Trebuchet MS"'>lm-sensors source code=
 that
discovers the chips that it has (does it read the sensors.conf file?&nbsp;
Where is the lm-sensors code that does this?)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:1.0in;text-indent:-.25in;mso-list:=
l0 level2 lfo1'><![if !supportLists]><font
size=3D2 face=3D"Courier New"><span style=3D'font-size:10.0pt;font-family:"C=
ourier New"'><span
style=3D'mso-list:Ignore'>o<font size=3D1 face=3D"Times New Roman"><span
style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;
</span></font></span></span></font><![endif]><font size=3D2 face=3D"Trebuche=
t MS"><span
style=3D'font-size:10.0pt;font-family:"Trebuchet MS"'>lm-sensors source code=
 that
utilizes the kernel drivers that sit in /drivers/hwmon directory.&nbsp; Coul=
d
you point me to this code?&nbsp; <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Trebuchet MS"><span style=3D'fon=
t-size:
10.0pt;font-family:"Trebuchet MS"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Trebuchet MS"><span style=3D'fon=
t-size:
10.0pt;font-family:"Trebuchet MS"'>If the info I am looking for is already i=
n
some doc&#8217;n somewhere, feel free to point me to it.&nbsp; I have peruse=
d a
good bit of doc&#8217;n by now but maybe I&#8217;ve missed it.<o:p></o:p></s=
pan></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Trebuchet MS"><span style=3D'fon=
t-size:
10.0pt;font-family:"Trebuchet MS"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Trebuchet MS"><span style=3D'fon=
t-size:
10.0pt;font-family:"Trebuchet MS"'>Thanks for your helpful comments and tips=
.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Trebuchet MS"><span style=3D'fon=
t-size:
10.0pt;font-family:"Trebuchet MS"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dnavy face=3DTahoma><span lang=
=3DEN-CA
style=3D'font-size:10.0pt;font-family:Tahoma;color:navy;font-weight:bold'>Ro=
b&nbsp;Bloom</span></font></b><font
size=3D2 color=3Dnavy face=3DTahoma><span lang=3DEN-CA style=3D'font-size:10=
.0pt;
font-family:Tahoma;color:navy'><br>
Software Design Engineer<br>
Flextronics <st1:country-region w:st=3D"on"><st1:place w:st=3D"on">Canada</s=
t1:place></st1:country-region>
Design Services<br>
<br>
<o:p></o:p></span></font></p>

</div>

Legal Disclaimer:=0A=
The information contained in this message may be privileged and confidential=
. It is intended to be read only by the individual or entity to whom it is a=
ddressed or by their designee. If the reader of this message is not the inte=
nded recipient, you are on notice that any distribution of this message, in=
 any form, is strictly prohibited. If you have received this message in erro=
r, please immediately notify the sender and delete or destroy any copy of th=
is message
</body>

</html>

------_=_NextPart_001_01C9DF9C.A266F387--


--===============1508790979849647179==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1508790979849647179==--
