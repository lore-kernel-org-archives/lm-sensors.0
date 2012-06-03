From: <geve001@casema.nl>
Date: Sun, 03 Jun 2012 17:50:14 +0000
Subject: [lm-sensors] System: "Point of View ION-MB330-1" produces wrong values with lm-sensors 3.3.2
Message-Id: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAOB5NSGJmSkyng5C4YDACgcKAAAAQAAAARsa0Leonh0i8VcwkGa2IBgEAAAAA@casema.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============9105393236256419333=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

--===============9105393236256419333==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_000F_01CD41C2.182214C0"

This is a multi-part message in MIME format.

------=_NextPart_000_000F_01CD41C2.182214C0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On slackware, sensors produce a wrong value for CPU temperature for the =
MB
"Point of View ION-MB330-1"

=20

It is off at least 20 degrees.

CPU-0 and CPU-1 differ 10 degrees which is odd. CPU-0 has more load and
lower temp (see mpstat)

Critical temperature should be 125 according to datasheets

=20

Some Google topics suggest to add 20 degrees, but in those cases the =
cpu=92s
have the same low temp.

=20

=3D=3D> How to tackle this problem??

=20

------------- Linux kernel 2.6.37.6

root@atom:~# uname -a

Linux atom 2.6.37.6-smp #2 SMP Sat Apr 9 23:39:07 CDT 2011 i686 Intel(R)
Atom(TM) CPU  330   @ 1.60GHz GenuineIntel GNU/Linux

=20

=20

------------- lm-sensors version 3.3.2

root@atom:/etc# sensors -v

sensors version 3.3.2 with libsensors version 3.3.2

=20

=20

------------- detect coretemp

root@atom:~# sensors-detect

# sensors-detect revision 6057 (2012-06-01 17:47:27 +0200)

# System: Point of View ION-MB330-1 [Ver. 1.0]

=85

Intel digital thermal sensor...                             Success!

    (driver `coretemp')

=85

Now follows a summary of the probes I have just done.

Just press ENTER to continue:

=20

Driver `coretemp':

  * Chip `Intel digital thermal sensor' (confidence: 9)

=20

=20

------------- sensor values

root@atom:~# sensors

coretemp-isa-0000

Adapter: ISA adapter

Core0:         +2.0=B0C  (crit =3D +90.0=B0C)

=20

coretemp-isa-0001

Adapter: ISA adapter

Core1:        +12.0=B0C  (crit =3D +90.0=B0C)

=20

------------ CPU load

root@atom:/usr/local/gvs_cron# mpstat  -P 0,1 3 3

Linux 2.6.37.6-smp (atom)       06/03/2012      _i686_  (2 CPU)

=20

05:56:11 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal
%guest   %idle

05:56:14 PM    0    5.02    0.00    1.00    0.00    0.00    0.00    0.00
0.00   93.98

05:56:14 PM    1    0.33    0.00    0.00    0.00    0.00    0.00    0.00
0.00   99.67

05:56:17 PM    0    5.33    0.00    1.33    0.00    0.00    0.00    0.00
0.00   93.33

05:56:17 PM    1    0.00    0.00    0.00    0.00    0.00    0.00    0.00
0.00  100.00

05:56:20 PM    0    4.68    0.00    1.34    0.00    0.00    0.00    0.00
0.00   93.98

05:56:20 PM    1    0.00    0.00    0.00    0.00    0.00    0.00    0.00
0.00  100.00

Average:       0    5.01    0.00    1.22    0.00    0.00    0.00    0.00
0.00   93.76

Average:       1    0.11    0.00    0.00    0.00    0.00    0.00    0.00
0.00   99.89


------=_NextPart_000_000F_01CD41C2.182214C0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:Arial;}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt'>On
slackware, sensors produce a wrong value for CPU temperature for the MB =
&quot;Point
of View ION-MB330-1&quot;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt'>It is
off at least 20 degrees.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt'>CPU-0
and CPU-1 differ 10 degrees which is odd. CPU-0 has more load and lower =
temp
(see mpstat)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt'>Critical
temperature should be 125 according to =
datasheets<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt'>Some Google
topics suggest to add 20 degrees, but in those cases the cpu&#8217;s =
have the
same low temp.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt'>=3D=3D&gt;
How to tackle this problem??<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt'>-------------
Linux kernel 2.6.37.6<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>root@atom:~# uname =
-a<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Linux atom 2.6.37.6-smp #2 SMP Sat Apr 9 =
23:39:07
CDT 2011 i686 Intel(R) Atom(TM) CPU=A0 330=A0=A0 @ 1.60GHz GenuineIntel =
GNU/Linux<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>------------- lm-sensors version =
3.3.2<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>root@atom:/etc# sensors =
-v<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>sensors version 3.3.2 with libsensors version =
3.3.2<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>------------- detect =
coretemp<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>root@atom:~# =
sensors-detect<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'># sensors-detect revision 6057 (2012-06-01 =
17:47:27
+0200)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'># System: Point of View ION-MB330-1 [Ver. =
1.0]<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&#8230;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Intel digital thermal
sensor...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 Success!<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>=A0=A0=A0 (driver =
`coretemp')<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&#8230;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Now follows a summary of the probes I have =
just
done.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Just press ENTER to =
continue:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Driver =
`coretemp':<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>=A0 * Chip `Intel digital thermal sensor' =
(confidence:
9)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>------------- sensor =
values<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>root@atom:~# =
sensors<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New"'>coretemp-isa-0000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Adapter: ISA =
adapter<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Core0:=A0=A0=A0=A0=A0=A0=A0=A0 +2.0=B0C=A0 =
(crit =3D +90.0=B0C)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New"'>coretemp-isa-0001<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Adapter: ISA =
adapter<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Core1:=A0=A0=A0=A0=A0=A0=A0 +12.0=B0C=A0 =
(crit =3D +90.0=B0C)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>------------ CPU =
load<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>root@atom:/usr/local/gvs_cron# mpstat=A0 -P =
0,1 3 3<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Linux 2.6.37.6-smp (atom)=A0=A0=A0=A0=A0=A0 =
06/03/2012=A0=A0=A0=A0=A0
_i686_=A0 (2 CPU)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>05:56:11 PM=A0 CPU=A0=A0=A0 %usr=A0=A0 =
%nice=A0=A0=A0 %sys %iowait=A0=A0=A0
%irq=A0=A0 %soft=A0 %steal=A0 %guest=A0=A0 =
%idle<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>05:56:14 PM=A0=A0=A0 0=A0=A0=A0 5.02=A0=A0=A0 =
0.00=A0=A0=A0 1.00=A0=A0=A0 0.00=A0=A0=A0
0.00=A0=A0=A0 0.00=A0=A0=A0 0.00=A0=A0=A0 0.00=A0=A0 =
93.98<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>05:56:14 PM=A0=A0=A0 1=A0=A0=A0 0.33=A0=A0=A0 =
0.00=A0=A0=A0 0.00=A0=A0=A0 0.00=A0=A0=A0
0.00=A0=A0=A0 0.00=A0=A0=A0 0.00=A0=A0=A0 0.00=A0=A0 =
99.67<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>05:56:17 PM=A0=A0=A0 0=A0=A0=A0 5.33=A0=A0=A0 =
0.00 =A0=A0=A01.33=A0=A0=A0 0.00=A0=A0=A0
0.00=A0=A0=A0 0.00=A0=A0=A0 0.00=A0=A0=A0 0.00=A0=A0 =
93.33<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>05:56:17 PM=A0=A0=A0 1=A0=A0=A0 0.00=A0=A0=A0 =
0.00=A0=A0=A0 0.00=A0=A0=A0 0.00=A0=A0=A0
0.00=A0=A0=A0 0.00=A0=A0=A0 0.00=A0=A0=A0 0.00=A0 =
100.00<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>05:56:20 PM=A0=A0=A0 0=A0=A0=A0 4.68=A0=A0=A0 =
0.00=A0=A0=A0 1.34=A0=A0=A0 0.00=A0=A0=A0
0.00=A0=A0=A0 0.00=A0=A0=A0 0.00=A0=A0=A0 0.00=A0=A0 =
93.98<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>05:56:20 PM=A0=A0=A0 1=A0=A0=A0 0.00=A0=A0=A0 =
0.00=A0=A0=A0 0.00=A0=A0=A0 0.00=A0=A0=A0
0.00=A0=A0=A0 0.00=A0=A0=A0 0.00=A0=A0=A0 0.00=A0 =
100.00<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Average:=A0=A0=A0=A0=A0=A0 0=A0=A0=A0 =
5.01=A0=A0=A0 0.00=A0=A0=A0 1.22=A0=A0=A0 0.00=A0=A0=A0
0.00=A0=A0=A0 0.00=A0=A0=A0 0.00=A0=A0=A0 0.00=A0=A0 =
93.76<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Average:=A0=A0=A0=A0=A0=A0 1=A0=A0=A0 =
0.11=A0=A0=A0 0.00=A0=A0=A0 0.00=A0=A0=A0 0.00=A0=A0=A0
0.00=A0=A0=A0 0.00=A0=A0=A0 0.00=A0=A0=A0 0.00=A0=A0 =
99.89<o:p></o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_000F_01CD41C2.182214C0--



--===============9105393236256419333==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============9105393236256419333==--

