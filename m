From: shubhada pugaonkar <shubhp2k@yahoo.com>
Date: Sat, 15 Oct 2011 00:25:06 +0000
Subject: Re: [lm-sensors] smbus-arp module
Message-Id: <1318638306.72360.YahooMailNeo@web36407.mail.mud.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8633508968538821253=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20111014230322.39baf9f0@endymion.delvare>
In-Reply-To: <20111014230322.39baf9f0@endymion.delvare>
To: lm-sensors@vger.kernel.org

--===============8633508968538821253==
Content-Type: multipart/alternative; boundary="-2114655128-1038814743-1318638306=:72360"

---2114655128-1038814743-1318638306=:72360
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

It would be great if I=C2=A0could use that code for testing. =0A=C2=A0=0AOn=
e=C2=A0question:=0AI=C2=A0dont see any of the drivers having ARP support,=
=C2=A0=C2=A0does that=C2=A0mean all the smbus controllers have ARP implemen=
ted in HW? =0AI looked at intel 82801 smbus controller (thats what I have)=
=C2=A0datasheet but the ARP support is nowhere to be seen. Does anyone =0Ak=
now any smbus host controllers chip (or specific server) with HW smbus ARP?=
=0A=C2=A0=0A>BTW, note that the linux-i2c list would be more suitable for d=
iscussing=0Athis as SMBus ARP is not limited to hardware monitoring devices=
, it's a=0Ageneric SMBus feature.=0A=C2=A0=0ASure, I will also post this qu=
ery in linux-i2c list.=0A=C2=A0=0AThanks=0ASP=0A=0A________________________=
________=0AFrom: Jean Delvare <khali@linux-fr.org>=0ATo: shubhada pugaonkar=
 <shubhp2k@yahoo.com>=0ACc: lm-sensors@lm-sensors.org; corentin.labbe <core=
ntin.labbe@geomatys.fr>=0ASent: Friday, October 14, 2011 2:03 PM=0ASubject:=
 Re: [lm-sensors] smbus-arp module=0A=0AOn Fri, 14 Oct 2011 12:19:52 -0700 =
(PDT), shubhada pugaonkar wrote:=0A> I have been looking for smbus-arp modu=
le but unable to find it in latest lm-sensors package=C2=A0and the kernel(2=
.6.27-x). But I did see it in lm-sensors-2.XX version. Has this been ported=
 to 2.6.x kernels? =0A=0AIt has never been ported. It was more of a hack th=
an anything else, to=0Atest the feature. It never reached a usable state.=
=0A=0A> I am trying to test=C2=A0smbus slave device=E2=80=99s ARP functiona=
lity. If smbus-arp module is not available, does anyone have ideas as to ho=
w this can be tested using user level tools and/or kernel modules?=0A=0ACor=
entin (Cc'd) has been working on this for quite some time, but his=0Acode h=
as some issues remaining if I remember correctly. I was supposed=0Ato revie=
w it but could never find the time. Corentin, maybe you can=0Apost your cod=
e or send it in private to SP?=0A=0ABTW, note that the linux-i2c list would=
 be more suitable for discussing=0Athis as SMBus ARP is not limited to hard=
ware monitoring devices, it's a=0Ageneric SMBus feature.=0A=0A-- =0AJean De=
lvare
---2114655128-1038814743-1318638306=:72360
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:ar=
ial, helvetica, sans-serif;font-size:10pt"><SPAN style=3D"RIGHT: auto">
<div style=3D"RIGHT: auto"><SPAN style=3D"FONT-FAMILY: 'Arial','sans-serif'=
; COLOR: black; FONT-SIZE: 10pt">It would be great if I&nbsp;could use that=
 code for testing. </SPAN></div>
<div style=3D"RIGHT: auto"><SPAN style=3D"FONT-FAMILY: 'Arial','sans-serif'=
; COLOR: black; FONT-SIZE: 10pt">&nbsp;<?xml:namespace prefix =3D o ns =3D =
"urn:schemas-microsoft-com:office:office" /><o:p></o:p></SPAN></div>
<div style=3D"RIGHT: auto"><SPAN style=3D"RIGHT: auto"><SPAN style=3D"FONT-=
FAMILY: 'Arial','sans-serif'; COLOR: black; FONT-SIZE: 10pt">One&nbsp;quest=
ion:</SPAN><o:p></o:p></SPAN></div>
<div style=3D"RIGHT: auto"><SPAN style=3D"RIGHT: auto"></SPAN><SPAN style=
=3D"FONT-FAMILY: 'Arial','sans-serif'; COLOR: black; FONT-SIZE: 10pt">I&nbs=
p;dont see any of the drivers having ARP support,&nbsp;<SPAN style=3D"RIGHT=
: auto; mso-spacerun: yes">&nbsp;<VAR id=3Dyui-ie-cursor></VAR></SPAN>does =
that&nbsp;mean all the smbus controllers have ARP implemented in HW? </SPAN=
></div>
<div style=3D"RIGHT: auto"><SPAN style=3D"FONT-FAMILY: 'Arial','sans-serif'=
; COLOR: black; FONT-SIZE: 10pt">I looked at intel 82801 smbus controller (=
thats what I have)&nbsp;</SPAN><SPAN style=3D"FONT-FAMILY: 'Arial','sans-se=
rif'; COLOR: black; FONT-SIZE: 10pt">datasheet but the ARP support is nowhe=
re to be seen. <SPAN style=3D"FONT-FAMILY: 'Arial','sans-serif'; COLOR: bla=
ck; FONT-SIZE: 10pt">Does anyone </SPAN></SPAN></div>
<div style=3D"RIGHT: auto"><SPAN style=3D"FONT-FAMILY: 'Arial','sans-serif'=
; COLOR: black; FONT-SIZE: 10pt"><SPAN style=3D"FONT-FAMILY: 'Arial','sans-=
serif'; COLOR: black; FONT-SIZE: 10pt">know any smbus host controllers chip=
 (or specific server) with HW smbus ARP?</SPAN><o:p></o:p></SPAN></div>
<div style=3D"RIGHT: auto"><SPAN style=3D"FONT-FAMILY: 'Arial','sans-serif'=
; COLOR: black; FONT-SIZE: 10pt"><o:p style=3D"RIGHT: auto">&nbsp;</o:p></S=
PAN></div>
<div style=3D"RIGHT: auto"><SPAN style=3D"FONT-FAMILY: 'Arial','sans-serif'=
; COLOR: black; FONT-SIZE: 10pt"><o:p style=3D"RIGHT: auto">&gt;BTW, note t=
hat the linux-i2c list would be more suitable for discussing<BR>this as SMB=
us ARP is not limited to hardware monitoring devices, it's a<BR>generic SMB=
us feature.</o:p></SPAN></div>
<div style=3D"RIGHT: auto"><SPAN style=3D"FONT-FAMILY: 'Arial','sans-serif'=
; COLOR: black; FONT-SIZE: 10pt"><o:p style=3D"RIGHT: auto"></o:p></SPAN>&n=
bsp;</div>
<div style=3D"RIGHT: auto"><SPAN style=3D"FONT-FAMILY: 'Arial','sans-serif'=
; COLOR: black; FONT-SIZE: 10pt">Sure, I will also post this query in linux=
-i2c list.</SPAN><o:p></o:p></SPAN></div>
<div style=3D"RIGHT: auto"><SPAN style=3D"RIGHT: auto"></SPAN><SPAN style=
=3D"FONT-FAMILY: 'Arial','sans-serif'; COLOR: black; FONT-SIZE: 10pt">&nbsp=
;<o:p></o:p></SPAN></div>
<div style=3D"RIGHT: auto"><SPAN style=3D"FONT-FAMILY: 'Arial','sans-serif'=
; COLOR: black; FONT-SIZE: 10pt">Thanks<o:p></o:p></SPAN></div>
<div style=3D"RIGHT: auto"><SPAN style=3D"FONT-FAMILY: 'Arial','sans-serif'=
; COLOR: black; FONT-SIZE: 10pt">SP</SPAN></SPAN></div>
<DIV style=3D"FONT-FAMILY: arial, helvetica, sans-serif; FONT-SIZE: 10pt">
<DIV style=3D"FONT-FAMILY: times new roman, new york, times, serif; FONT-SI=
ZE: 12pt"><FONT size=3D2 face=3DArial>
<DIV style=3D"BORDER-BOTTOM: #ccc 1px solid; BORDER-LEFT: #ccc 1px solid; P=
ADDING-BOTTOM: 0px; LINE-HEIGHT: 0; MARGIN: 5px 0px; PADDING-LEFT: 0px; PAD=
DING-RIGHT: 0px; HEIGHT: 0px; FONT-SIZE: 0px; BORDER-TOP: #ccc 1px solid; B=
ORDER-RIGHT: #ccc 1px solid; PADDING-TOP: 0px" class=3Dhr contentEditable=
=3Dfalse readonly=3D"true"></DIV><B><SPAN style=3D"FONT-WEIGHT: bold">From:=
</SPAN></B> Jean Delvare &lt;khali@linux-fr.org&gt;<BR><B><SPAN style=3D"FO=
NT-WEIGHT: bold">To:</SPAN></B> shubhada pugaonkar &lt;shubhp2k@yahoo.com&g=
t;<BR><B><SPAN style=3D"FONT-WEIGHT: bold">Cc:</SPAN></B> lm-sensors@lm-sen=
sors.org; corentin.labbe &lt;corentin.labbe@geomatys.fr&gt;<BR><B><SPAN sty=
le=3D"FONT-WEIGHT: bold">Sent:</SPAN></B> Friday, October 14, 2011 2:03 PM<=
BR><B><SPAN style=3D"FONT-WEIGHT: bold">Subject:</SPAN></B> Re: [lm-sensors=
] smbus-arp module<BR></FONT><BR>On Fri, 14 Oct 2011 12:19:52 -0700 (PDT), =
shubhada pugaonkar wrote:<BR>&gt; I have been looking for smbus-arp module =
but unable to
 find it in latest lm-sensors package&nbsp;and the kernel(2.6.27-x). But I =
did see it in lm-sensors-2.XX version. Has this been ported to 2.6.x kernel=
s? <BR><BR>It has never been ported. It was more of a hack than anything el=
se, to<BR>test the feature. It never reached a usable state.<BR><BR>&gt; I =
am trying to test&nbsp;smbus slave device=E2=80=99s ARP functionality. If s=
mbus-arp module is not available, does anyone have ideas as to how this can=
 be tested using user level tools and/or kernel modules?<BR><BR>Corentin (C=
c'd) has been working on this for quite some time, but his<BR>code has some=
 issues remaining if I remember correctly. I was supposed<BR>to review it b=
ut could never find the time. Corentin, maybe you can<BR>post your code or =
send it in private to SP?<BR><BR>BTW, note that the linux-i2c list would be=
 more suitable for discussing<BR>this as SMBus ARP is not limited to hardwa=
re monitoring devices, it's a<BR>generic SMBus feature.<BR><BR>-- <BR>Jean
 Delvare<BR><BR><BR></DIV></DIV></div></body></html>
---2114655128-1038814743-1318638306=:72360--


--===============8633508968538821253==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8633508968538821253==--

