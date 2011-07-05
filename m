From: Kazuya <kazuya25@hotmail.fr>
Date: Tue, 05 Jul 2011 12:01:50 +0000
Subject: Re: [lm-sensors] [?? Probable Spam]  Re:  IT8772E info and reports
Message-Id: <BLU0-SMTP1630A490FB86AA6DEFF7543A05F0@phx.gbl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============9114529325599816136=="
List-Id: <lm-sensors.vger.kernel.org>
References: <BLU0-SMTP101E548161D713BF62CDDC1A05F0@phx.gbl>
In-Reply-To: <BLU0-SMTP101E548161D713BF62CDDC1A05F0@phx.gbl>
To: lm-sensors@vger.kernel.org

--===============9114529325599816136==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_000E_01CC3B13.B786BD60"
Content-Language: fr

------=_NextPart_000_000E_01CC3B13.B786BD60
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

=20

-----Message d'origine-----
De : Jean Delvare [mailto:khali@linux-fr.org]=20
Envoy=E9 : mardi 5 juillet 2011 09:50
=C0 : Kazuya
Cc : lm-sensors@lm-sensors.org
Objet : [?? Probable Spam] Re: [lm-sensors] IT8772E info and reports

=20

On Mon, 4 Jul 2011 15:33:52 +0100, Kazuya wrote:

> My system :

>=20

> root@teddy:~# uname -a

>=20

> Linux teddy 2.6.32-5-amd64 #1 SMP Tue Jun 14 09:42:28 UTC 2011 x86_64=20

> GNU/Linux

> (...)

> root@teddy:~# modprobe it87 force_id=3D0x8721

>=20

> FATAL: Error inserting it87

> (/lib/modules/2.6.32-5-amd64/kernel/drivers/hwmon/it87.ko): No such=20

> device

>=20

> =20

>=20

> As you told me I tried modprobe it87 force_id=3D0x8721

=20

Support for the IT8721F was only added in kernel 2.6.37 according to
<http://www.lm-sensors.org/wiki/Devices>
http://www.lm-sensors.org/wiki/Devices

Your kernel is too old so you'd have to use the standalone it87 driver:

 <http://khali.linux-fr.org/devel/misc/it87/>
http://khali.linux-fr.org/devel/misc/it87/

Instructions at:

 <http://khali.linux-fr.org/devel/misc/INSTALL>
http://khali.linux-fr.org/devel/misc/INSTALL

=E8 It doesn=92t work, that is what I did :

root@teddy:~/driver# make

make[1]: Entering directory `/usr/src/linux-headers-2.6.32-5-amd64'

  Building modules, stage 2.

  MODPOST 1 modules

make[1]: Leaving directory `/usr/src/linux-headers-2.6.32-5-amd64'

root@teddy:~/driver# make install

test -d /lib/modules/2.6.32-5-amd64/kernel/drivers/hwmon || mkdir
/lib/modules/2.6.32-5-amd64/kernel/drivers/hwmon

cp it87.ko /lib/modules/2.6.32-5-amd64/kernel/drivers/hwmon

depmod -a -F /boot/System.map-2.6.32-5-amd64 2.6.32-5-amd64

root@teddy:~/driver# modprobe it87

FATAL: Error inserting it87
(/lib/modules/2.6.32-5-amd64/kernel/drivers/hwmon/it87.ko): No such =
device

root@teddy:~/driver# rmmod it87

ERROR: Module it87 does not exist in /proc/modules

root@teddy:~/driver# insmod it87.ko

insmod: error inserting 'it87.ko': -1 No such device

root@teddy:~/driver# rmmod it87

ERROR: Module it87 does not exist in /proc/modules

=20

=20

If the coretemp driver in your kernel doesn't work for you, it also =
exists
as a standalone driver:

 <http://khali.linux-fr.org/devel/misc/coretemp/>
http://khali.linux-fr.org/devel/misc/coretemp/

=20

=E8    For coretemp, it seems to work perfectly !

=20

Thank you !!!!!

=20

I don=92t know what to do for it87=85 How can I get a driver?  Can you =
help me
or there is no driver at all=85

=20

Thank you


------=_NextPart_000_000E_01CC3B13.B786BD60
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta name=3DGenerator =
content=3D"Microsoft Word 14 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
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
/* List Definitions */
@list l0
	{mso-list-id:1534465190;
	mso-list-type:hybrid;
	mso-list-template-ids:-725295792 846074454 67895299 67895301 67895297 =
67895299 67895301 67895297 67895299 67895301;}
@list l0:level1
	{mso-level-start-at:6;
	mso-level-number-format:bullet;
	mso-level-text:\F0E8;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;
	mso-fareast-font-family:Calibri;
	mso-bidi-font-family:"Times New Roman";}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Symbol;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Symbol;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DFR link=3Dblue =
vlink=3Dpurple><div class=3DWordSection1><p =
class=3DMsoPlainText>Hello,<o:p></o:p></p><p =
class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p class=3DMsoPlainText><span =
style=3D'mso-fareast-language:FR'>-----Message =
d'origine-----<br>De&nbsp;: Jean Delvare [mailto:khali@linux-fr.org] =
<br>Envoy=E9&nbsp;: mardi 5 juillet 2011 09:50<br>=C0&nbsp;: =
Kazuya<br>Cc&nbsp;: lm-sensors@lm-sensors.org<br>Objet&nbsp;: [?? =
Probable Spam] Re: [lm-sensors] IT8772E info and reports</span></p><p =
class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p class=3DMsoPlainText>On =
Mon, 4 Jul 2011 15:33:52 +0100, Kazuya wrote:<o:p></o:p></p><p =
class=3DMsoPlainText>&gt; My system :<o:p></o:p></p><p =
class=3DMsoPlainText>&gt; <o:p></o:p></p><p class=3DMsoPlainText>&gt; =
root@teddy:~# uname -a<o:p></o:p></p><p class=3DMsoPlainText>&gt; =
<o:p></o:p></p><p class=3DMsoPlainText>&gt; Linux teddy 2.6.32-5-amd64 =
#1 SMP Tue Jun 14 09:42:28 UTC 2011 x86_64 <o:p></o:p></p><p =
class=3DMsoPlainText>&gt; GNU/Linux<o:p></o:p></p><p =
class=3DMsoPlainText>&gt; (...)<o:p></o:p></p><p =
class=3DMsoPlainText><span lang=3DEN-US>&gt; root@teddy:~# modprobe it87 =
force_id=3D0x8721<o:p></o:p></span></p><p class=3DMsoPlainText>&gt; =
<o:p></o:p></p><p class=3DMsoPlainText>&gt; FATAL: Error inserting =
it87<o:p></o:p></p><p class=3DMsoPlainText>&gt; =
(/lib/modules/2.6.32-5-amd64/kernel/drivers/hwmon/it87.ko): No such =
<o:p></o:p></p><p class=3DMsoPlainText>&gt; device<o:p></o:p></p><p =
class=3DMsoPlainText>&gt; <o:p></o:p></p><p class=3DMsoPlainText>&gt;=A0 =
<o:p></o:p></p><p class=3DMsoPlainText>&gt; <o:p></o:p></p><p =
class=3DMsoPlainText>&gt; As you told me I tried modprobe it87 =
force_id=3D0x8721<o:p></o:p></p><p =
class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText><b><span lang=3DEN-US =
style=3D'font-size:12.0pt'>Support for the IT8721F was only added in =
kernel 2.6.37 according to </span></b><b><span =
style=3D'font-size:12.0pt'><a =
href=3D"http://www.lm-sensors.org/wiki/Devices"><span lang=3DEN-US =
style=3D'color:windowtext;text-decoration:none'>http://www.lm-sensors.org=
/wiki/Devices</span></a></span></b><b><span lang=3DEN-US =
style=3D'font-size:12.0pt'><o:p></o:p></span></b></p><p =
class=3DMsoPlainText><b><span style=3D'font-size:12.0pt'>Your kernel is =
too old so you'd have to use the standalone it87 =
driver:<o:p></o:p></span></b></p><p class=3DMsoPlainText><b><span =
style=3D'font-size:12.0pt'><a =
href=3D"http://khali.linux-fr.org/devel/misc/it87/"><span =
style=3D'color:windowtext;text-decoration:none'>http://khali.linux-fr.org=
/devel/misc/it87/</span></a><o:p></o:p></span></b></p><p =
class=3DMsoPlainText><b><span style=3D'font-size:12.0pt'>Instructions =
at:<o:p></o:p></span></b></p><p class=3DMsoPlainText><b><span =
style=3D'font-size:12.0pt'><a =
href=3D"http://khali.linux-fr.org/devel/misc/INSTALL"><span =
style=3D'color:windowtext;text-decoration:none'>http://khali.linux-fr.org=
/devel/misc/INSTALL</span></a><o:p></o:p></span></b></p><p =
class=3DMsoPlainText =
style=3D'margin-left:36.0pt;text-indent:-18.0pt;mso-list:l0 level1 =
lfo1'><![if !supportLists]><span lang=3DEN-US =
style=3D'font-family:Wingdings;color:red'><span =
style=3D'mso-list:Ignore'>=E8<span style=3D'font:7.0pt "Times New =
Roman"'> </span></span></span><![endif]><span lang=3DEN-US =
style=3D'color:red'>It doesn&#8217;t work, that is what I did =
:<o:p></o:p></span></p><p class=3DMsoNormal>root@teddy:~/driver# =
make<o:p></o:p></p><p class=3DMsoPlainText><span lang=3DEN-US =
style=3D'color:red'>make[1]: Entering directory =
`/usr/src/linux-headers-2.6.32-5-amd64'<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US style=3D'color:red'>=A0 Building =
modules, stage 2.<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US style=3D'color:red'>=A0 MODPOST 1 =
modules<o:p></o:p></span></p><p class=3DMsoPlainText><span lang=3DEN-US =
style=3D'color:red'>make[1]: Leaving directory =
`/usr/src/linux-headers-2.6.32-5-amd64'<o:p></o:p></span></p><p =
class=3DMsoNormal>root@teddy:~/driver# make install<o:p></o:p></p><p =
class=3DMsoPlainText><span lang=3DEN-US style=3D'color:red'>test -d =
/lib/modules/2.6.32-5-amd64/kernel/drivers/hwmon || mkdir =
/lib/modules/2.6.32-5-amd64/kernel/drivers/hwmon<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US style=3D'color:red'>cp it87.ko =
/lib/modules/2.6.32-5-amd64/kernel/drivers/hwmon<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US style=3D'color:red'>depmod -a -F =
/boot/System.map-2.6.32-5-amd64 2.6.32-5-amd64<o:p></o:p></span></p><p =
class=3DMsoNormal>root@teddy:~/driver# modprobe it87<o:p></o:p></p><p =
class=3DMsoPlainText><span lang=3DEN-US style=3D'color:red'>FATAL: Error =
inserting it87 =
(/lib/modules/2.6.32-5-amd64/kernel/drivers/hwmon/it87.ko): No such =
device<o:p></o:p></span></p><p class=3DMsoNormal>root@teddy:~/driver# =
rmmod it87<o:p></o:p></p><p class=3DMsoPlainText><span lang=3DEN-US =
style=3D'color:red'>ERROR: Module it87 does not exist in =
/proc/modules<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>root@teddy:~/driver# insmod it87.ko<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US style=3D'color:red'>insmod: =
error inserting 'it87.ko': -1 No such device<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>root@teddy:~/driver# rmmod =
it87<o:p></o:p></span></p><p class=3DMsoPlainText><span lang=3DEN-US =
style=3D'color:red'>ERROR: Module it87 does not exist in =
/proc/modules<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US style=3D'color:red'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoPlainText><b><span lang=3DEN-US style=3D'font-size:12.0pt'>If =
the coretemp driver in your kernel doesn't work for you, it also exists =
as a standalone driver:<o:p></o:p></span></b></p><p =
class=3DMsoPlainText><b><span style=3D'font-size:12.0pt'><a =
href=3D"http://khali.linux-fr.org/devel/misc/coretemp/"><span =
style=3D'color:windowtext;text-decoration:none'>http://khali.linux-fr.org=
/devel/misc/coretemp/</span></a><o:p></o:p></span></b></p><p =
class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p class=3DMsoPlainText =
style=3D'margin-left:0cm;text-indent:0cm;mso-list:l0 level1 lfo1'><![if =
!supportLists]><span lang=3DEN-US =
style=3D'font-family:Wingdings;color:black'><span =
style=3D'mso-list:Ignore'>=E8<span style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp; </span></span></span><![endif]><span =
lang=3DEN-US style=3D'color:black'>For coretemp, it seems to work =
perfectly&nbsp;!<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US style=3D'color:black'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoPlainText><b><span lang=3DEN-US =
style=3D'font-size:20.0pt;color:black'>Thank you =
!!!!!<o:p></o:p></span></b></p><p class=3DMsoPlainText><span =
lang=3DEN-US =
style=3D'font-size:12.0pt;color:black'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US =
style=3D'font-size:12.0pt;color:black'>I don&#8217;t know what to do for =
it87&#8230;&nbsp;How can I get a driver? =A0Can you help me or there is =
no driver at all&#8230;<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US =
style=3D'font-size:12.0pt;color:black'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US =
style=3D'font-size:12.0pt;color:black'>Thank =
you<o:p></o:p></span></p></div></body></html>
------=_NextPart_000_000E_01CC3B13.B786BD60--


--===============9114529325599816136==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============9114529325599816136==--
