From: shubhada pugaonkar <shubhp2k@yahoo.com>
Date: Mon, 17 Oct 2011 20:30:34 +0000
Subject: Re: [lm-sensors] smbus-arp module
Message-Id: <1318883434.75717.YahooMailNeo@web36408.mail.mud.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3813758379150780998=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20111014230322.39baf9f0@endymion.delvare>
In-Reply-To: <20111014230322.39baf9f0@endymion.delvare>
To: lm-sensors@vger.kernel.org

--===============3813758379150780998==
Content-Type: multipart/alternative; boundary="-2114655128-1944451035-1318883434=:75717"

---2114655128-1944451035-1318883434=:75717
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

=0A=0A=0A=0A________________________________=0A=0AFrom: Jean Delvare <khali=
@linux-fr.org>=0ATo: shubhada pugaonkar <shubhp2k@yahoo.com>=0ACc: lm-senso=
rs@lm-sensors.org; corentin.labbe <corentin.labbe@geomatys.fr>=0ASent: Satu=
rday, October 15, 2011 12:51 AM=0ASubject: Re: [lm-sensors] smbus-arp modul=
e=0A=0AIf I interpreted this correctly this means I have to rely on OS supp=
ort.=A0=A0I can=A0try this in Windows machine=A0and see if my slave respond=
s to enumeration.=0A=0AMeanwhile Corentin, can you also give me the Linux c=
ode which I can try?=0A=0AThanks=0ASP=0A=0A-- =0AJean Delvare=0A=0A=0A=0APl=
ease don't top-post.=0A=0AOn Fri, 14 Oct 2011 17:25:06 -0700 (PDT), shubhad=
a pugaonkar wrote:=0A> It would be great if I=A0could use that code for tes=
ting. =0A> =A0=0A> One=A0question:=0A> I=A0dont see any of the drivers havi=
ng ARP support,=A0=A0does that=A0mean all the smbus controllers have ARP im=
plemented in HW? =0A> I looked at intel 82801 smbus controller (thats what =
I have)=A0datasheet but the ARP support is nowhere to be seen. Does anyone =
=0A> know any smbus host controllers chip (or specific server) with HW smbu=
s ARP?=0A=0A>>I did not dig the matter too much yet but my understanding is=
 that bus=0A>>controllers (and thus their drivers) don't have to care about=
 ARP at=0A>>all. It is implemented in hardware on the slave side but in sof=
tware on=0A>>the host side, as there is nothing the bus controller can do w=
ith the=0A>>information anyway.=0A
---2114655128-1944451035-1318883434=:75717
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:ar=
ial, helvetica, sans-serif;font-size:10pt"><div style=3D"RIGHT: auto"><SPAN=
 style=3D"RIGHT: auto"><BR style=3D"RIGHT: auto" class=3Dyui-cursor></SPAN>=
</div>
<div><BR></div>
<DIV style=3D"FONT-FAMILY: arial, helvetica, sans-serif; FONT-SIZE: 10pt"><=
FONT size=3D2 face=3DArial>
<DIV style=3D"FONT-FAMILY: times new roman, new york, times, serif; FONT-SI=
ZE: 12pt" class=3Dms__id1342>
<DIV style=3D"BORDER-BOTTOM: #ccc 1px solid; BORDER-LEFT: #ccc 1px solid; P=
ADDING-BOTTOM: 0px; LINE-HEIGHT: 0; MARGIN: 5px 0px; PADDING-LEFT: 0px; PAD=
DING-RIGHT: 0px; HEIGHT: 0px; FONT-SIZE: 0px; BORDER-TOP: #ccc 1px solid; B=
ORDER-RIGHT: #ccc 1px solid; PADDING-TOP: 0px" class=3Dhr contentEditable=
=3Dfalse readonly=3D"true"></DIV></DIV>
<DIV style=3D"FONT-FAMILY: times new roman, new york, times, serif; FONT-SI=
ZE: 12pt" class=3Dms__id1342><B style=3D"RIGHT: auto"><SPAN style=3D"RIGHT:=
 auto; FONT-WEIGHT: bold">From:</SPAN></B> Jean Delvare &lt;khali@linux-fr.=
org&gt;<BR><B><SPAN style=3D"FONT-WEIGHT: bold">To:</SPAN></B> shubhada pug=
aonkar &lt;shubhp2k@yahoo.com&gt;<BR><B><SPAN style=3D"FONT-WEIGHT: bold">C=
c:</SPAN></B> lm-sensors@lm-sensors.org; corentin.labbe &lt;corentin.labbe@=
geomatys.fr&gt;<BR><B><SPAN style=3D"FONT-WEIGHT: bold">Sent:</SPAN></B> Sa=
turday, October 15, 2011 12:51 AM<BR><B><SPAN style=3D"FONT-WEIGHT: bold">S=
ubject:</SPAN></B> Re: [lm-sensors] smbus-arp module<BR></FONT><BR>Please d=
on't top-post.<BR><BR>On Fri, 14 Oct 2011 17:25:06 -0700 (PDT), shubhada pu=
gaonkar wrote:<BR>&gt; It would be great if I&nbsp;could use that code for =
testing. <BR>&gt; &nbsp;<BR>&gt; One&nbsp;question:<BR>&gt; I&nbsp;dont see=
 any of the drivers having ARP support,&nbsp;&nbsp;does that&nbsp;mean all =
the smbus
 controllers have ARP implemented in HW? <BR>&gt; I looked at intel 82801 s=
mbus controller (thats what I have)&nbsp;datasheet but the ARP support is n=
owhere to be seen. Does anyone <BR>&gt; know any smbus host controllers chi=
p (or specific server) with HW smbus ARP?<BR><BR>&gt;&gt;I did not dig the =
matter too much yet but my understanding is that bus<BR>&gt;&gt;controllers=
 (and thus their drivers) don't have to care about ARP at<BR>&gt;&gt;all. I=
t is implemented in hardware on the slave side but in software on<BR>&gt;&g=
t;the host side, as there is nothing the bus controller can do with the<BR>=
&gt;&gt;information anyway.<BR></DIV>
<DIV style=3D"FONT-FAMILY: times new roman, new york, times, serif; FONT-SI=
ZE: 12pt" class=3Dms__id1342>If I interpreted this correctly this means I h=
ave to rely on OS support.&nbsp;&nbsp;I can&nbsp;try this in Windows machin=
e&nbsp;and see if my slave responds to enumeration.</DIV>
<DIV style=3D"FONT-FAMILY: times new roman, new york, times, serif; FONT-SI=
ZE: 12pt" class=3Dms__id1342>&nbsp;</DIV>
<DIV style=3D"FONT-FAMILY: times new roman, new york, times, serif; FONT-SI=
ZE: 12pt" class=3Dms__id1342>Meanwhile Corentin, can you also give me the L=
inux code which I can t<VAR id=3Dyui-ie-cursor></VAR>ry?</DIV>
<DIV style=3D"FONT-FAMILY: times new roman, new york, times, serif; FONT-SI=
ZE: 12pt" class=3Dms__id1342>&nbsp;</DIV>
<DIV style=3D"FONT-FAMILY: times new roman, new york, times, serif; FONT-SI=
ZE: 12pt" class=3Dms__id1342>Thanks</DIV>
<DIV style=3D"FONT-FAMILY: times new roman, new york, times, serif; FONT-SI=
ZE: 12pt" class=3Dms__id1342>SP</DIV>
<DIV style=3D"FONT-FAMILY: times new roman, new york, times, serif; FONT-SI=
ZE: 12pt" class=3Dms__id1342>&nbsp;</DIV>
<DIV style=3D"FONT-FAMILY: times new roman, new york, times, serif; FONT-SI=
ZE: 12pt" class=3Dms__id1342>-- <BR>Jean Delvare<BR><BR><BR></DIV></DIV></d=
iv></body></html>
---2114655128-1944451035-1318883434=:75717--


--===============3813758379150780998==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3813758379150780998==--

