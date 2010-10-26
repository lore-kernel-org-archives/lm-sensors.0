From: Mahmood Naderan <nt_mahmood@yahoo.com>
Date: Tue, 26 Oct 2010 14:00:31 +0000
Subject: Re: [lm-sensors] k10temp is detected but not shown
Message-Id: <214578.81860.qm@web111702.mail.gq1.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0019158391596536538=="
List-Id: <lm-sensors.vger.kernel.org>
References: <578838.74607.qm@web111714.mail.gq1.yahoo.com>
In-Reply-To: <578838.74607.qm@web111714.mail.gq1.yahoo.com>
To: lm-sensors@vger.kernel.org

--===============0019158391596536538==
Content-Type: multipart/alternative; boundary="0-795968659-1288101631=:81860"

--0-795968659-1288101631=:81860
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

>It looks as if the two sensors in each CPU have the same value.=A0 Is this=
=0A>always the case?=0AI think so, with one core set to high, I see these v=
alues=0A=0Amahmood@localhost:bin$=A0sensors=0Ak10temp-pci-00c3=0AAdapter: P=
CI adapter=0Atemp1:=A0=A0=A0=A0=A0=A0 +32.5=C2=B0C=A0 (high =3D +70.0=C2=B0=
C, crit =3D +70.0=C2=B0C)=A0 =0Ak10temp-pci-00cb=0AAdapter: PCI adapter=0At=
emp1:=A0=A0=A0=A0=A0=A0 +32.0=C2=B0C=A0 (high =3D +70.0=C2=B0C)=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =0Ak10temp-pci-00d3=0AAdapter: PCI =
adapter=0Atemp1:=A0=A0=A0=A0=A0=A0 +34.0=C2=B0C=A0 (high =3D +70.0=C2=B0C)=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =0Ak10temp-pci-00db=0AA=
dapter: PCI adapter=0Atemp1:=A0=A0=A0=A0=A0=A0 +34.0=C2=B0C=A0 (high =3D +7=
0.0=C2=B0C, crit =3D +70.0=C2=B0C)=A0 =0A=0A>The limit is set by the BIOS.=
=A0 I'd guess the BIOS knows that two sensors=0A>are actually the same, an =
so doesn't bother to set the limit on the=0A>superfluous ones.=0AAgree with=
 that. So [00c3 and 00cb] are for one cpu and [00d3 and 00db] are=A0for =0A=
the other.=0A=0AThank you=A0all for the quick help=A0=0A// Naderan *Mahmood=
;=0A=0A=0A=0A=0A________________________________=0AFrom: Clemens Ladisch <c=
lemens@ladisch.de>=0ATo: Jean Delvare <khali@linux-fr.org>=0ACc: Mahmood Na=
deran <nt_mahmood@yahoo.com>; lm-sensors =0A<lm-sensors@lm-sensors.org>=0AS=
ent: Tue, October 26, 2010 5:23:29 PM=0ASubject: Re: [lm-sensors] k10temp i=
s detected but not shown=0A=0AJean Delvare wrote:=0A> > > Doh. You are awar=
e that Core i7 CPUs are made by Intel and Family 10h=0A> > > (aka K10) CPUs=
 are made by AMD, aren't you? They are different CPU=0A> > > models, they d=
on't have to be designed the same way.=0A> > =0A> > I know that :)=0A> > I =
thought maybe that is a standard and each cpu temperature must be show=0A> =
> separetly.=0A> =0A> There is no such standard.=0A=0AAnd on the newest CPU=
s, Intel has switched to one temperature sensor per=0Apackage.=0A=0A> On Tu=
e, 26 Oct 2010 06:06:53 -0700 (PDT), Mahmood Naderan wrote:=0A> > One more =
question, Is it possible to find out which two modules are tied to =0A>one =
=0A>=0A> > processor?=0A> =0A> Modules?=0A> =0A> > Currently there are:=0A>=
 > k10temp-pci-00c3=0A> > temp1:=A0 =A0 =A0 +27.0=B0C=A0 (high =3D +70.0=B0=
C, crit =3D +70.0=B0C)=0A> > k10temp-pci-00cb=0A> > temp1:=A0 =A0 =A0 +27.0=
=B0C=A0 (high =3D +70.0=B0C)=0A> > k10temp-pci-00d3=0A> > temp1:=A0 =A0 =A0=
 +26.0=B0C=A0 (high =3D +70.0=B0C)=0A> > k10temp-pci-00db=0A> > temp1:=A0 =
=A0 =A0 +26.0=B0C=A0 (high =3D +70.0=B0C, crit =3D +70.0=B0C)=0A> >=A0 =0A>=
 > Is it true that [00c3 and 00cb] are for one physical cpu and [00d3 and 0=
0db] =0A>are =0A>=0A> > for the other cpu?=0A=0AI conclude from this questi=
on that you have two CPUs, and that each CPU=0Ahas two temperature sensors.=
=0A=0AThe temperature sensor is part of the PCI device that associated with=
=0Athe CPU's internal northbridge.=A0 IIRC the six-core CPUs have two=0Anor=
thbridges, for whatever technical reason, so they present two=0Atemparature=
 sensors to the OS.=0A=0AIt looks as if the two sensors in each CPU have th=
e same value.=A0 Is this=0Aalways the case?=0A=0A(I don't know where the c3=
/cb/d3/db names come from.)=0A=0A> All entries in cpuinfo look the same, so=
 I can't explain why some have=0A> the critical limit and some don't.=0A=0A=
The limit is set by the BIOS.=A0 I'd guess the BIOS knows that two sensors=
=0Aare actually the same, an so doesn't bother to set the limit on the=0Asu=
perfluous ones.=0A=0AI'll look into the datasheet to see if this situation =
(two northbridges=0Aper CPU) is documented and can be detected so that the =
driver can ignore=0Athese superfluous sensors.=0A=0A=0ARegards,=0AClemens=
=0A=0A=0A=0A      
--0-795968659-1288101631=:81860
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:tahoma, new york, times, serif;font-size=
:12pt"><DIV></DIV>=0A<DIV>&gt;It looks as if the two sensors in each CPU ha=
ve the same value.&nbsp; Is this<BR>&gt;always the case?<BR>I think so, wit=
h one core set to high, I see these values<BR></DIV>=0A<DIV><FONT size=3D2 =
face=3D"Courier New, courier, monaco, monospace, sans-serif">mahmood@localh=
ost:bin$&nbsp;sensors<BR>k10temp-pci-00c3<BR>Adapter: PCI adapter<BR>temp1:=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +32.5=C2=B0C&nbsp; (high =3D +70.0=C2=
=B0C, crit =3D +70.0=C2=B0C)&nbsp; </FONT></DIV>=0A<DIV><FONT size=3D2 face=
=3D"Courier New, courier, monaco, monospace, sans-serif">k10temp-pci-00cb<B=
R>Adapter: PCI adapter<BR>temp1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +32.0=
=C2=B0C&nbsp; (high =3D +70.0=C2=B0C)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT></D=
IV>=0A<DIV><FONT size=3D2 face=3D"Courier New, courier, monaco, monospace, =
sans-serif">k10temp-pci-00d3<BR>Adapter: PCI adapter<BR>temp1:&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; +34.0=C2=B0C&nbsp; (high =3D +70.0=C2=B0C)&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; </FONT></DIV>=0A<DIV><FONT size=3D2 face=3D"Courier New,=
 courier, monaco, monospace, sans-serif">k10temp-pci-00db<BR>Adapter: PCI a=
dapter<BR>temp1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +34.0=C2=B0C&nbsp; (hi=
gh =3D +70.0=C2=B0C, crit =3D +70.0=C2=B0C)&nbsp; </FONT></DIV>=0A<DIV>&nbs=
p;</DIV>=0A<DIV>&gt;The limit is set by the BIOS.&nbsp; I'd guess the BIOS =
knows that two sensors<BR>&gt;are actually the same, an so doesn't bother t=
o set the limit on the<BR>&gt;superfluous ones.</DIV>=0A<DIV>Agree with tha=
t. So [00c3 and 00cb] are for one cpu and [00d3 and 00db] are&nbsp;for the =
other.</DIV>=0A<DIV>&nbsp;</DIV>=0A<DIV>Thank you&nbsp;all for the quick he=
lp&nbsp;</DIV>=0A<DIV>=0A<DIV><FONT style=3D"BACKGROUND-COLOR: #ffffff" col=
or=3D#0080ff size=3D2 face=3D"arial, helvetica, sans-serif"><STRONG>// Nade=
ran *Mahmood;</STRONG></FONT></DIV></DIV>=0A<DIV><BR></DIV>=0A<DIV style=3D=
"FONT-FAMILY: tahoma, new york, times, serif; FONT-SIZE: 12pt"><BR>=0A<DIV =
style=3D"FONT-FAMILY: tahoma, new york, times, serif; FONT-SIZE: 12pt"><FON=
T size=3D2 face=3DTahoma>=0A<HR SIZE=3D1>=0A<B><SPAN style=3D"FONT-WEIGHT: =
bold">From:</SPAN></B> Clemens Ladisch &lt;clemens@ladisch.de&gt;<BR><B><SP=
AN style=3D"FONT-WEIGHT: bold">To:</SPAN></B> Jean Delvare &lt;khali@linux-=
fr.org&gt;<BR><B><SPAN style=3D"FONT-WEIGHT: bold">Cc:</SPAN></B> Mahmood N=
aderan &lt;nt_mahmood@yahoo.com&gt;; lm-sensors &lt;lm-sensors@lm-sensors.o=
rg&gt;<BR><B><SPAN style=3D"FONT-WEIGHT: bold">Sent:</SPAN></B> Tue, Octobe=
r 26, 2010 5:23:29 PM<BR><B><SPAN style=3D"FONT-WEIGHT: bold">Subject:</SPA=
N></B> Re: [lm-sensors] k10temp is detected but not shown<BR></FONT><BR>Jea=
n Delvare wrote:<BR>&gt; &gt; &gt; Doh. You are aware that Core i7 CPUs are=
 made by Intel and Family 10h<BR>&gt; &gt; &gt; (aka K10) CPUs are made by =
AMD, aren't you? They are different CPU<BR>&gt; &gt; &gt; models, they don'=
t have to be designed the same way.<BR>&gt; &gt; <BR>&gt; &gt; I know that =
:)<BR>&gt; &gt; I thought maybe that is a standard and each cpu temperature=
 must be show<BR>&gt; &gt; separetly.<BR>&gt;
 <BR>&gt; There is no such standard.<BR><BR>And on the newest CPUs, Intel h=
as switched to one temperature sensor per<BR>package.<BR><BR>&gt; On Tue, 2=
6 Oct 2010 06:06:53 -0700 (PDT), Mahmood Naderan wrote:<BR>&gt; &gt; One mo=
re question, Is it possible to find out which two modules are tied to one <=
BR>&gt; &gt; processor?<BR>&gt; <BR>&gt; Modules?<BR>&gt; <BR>&gt; &gt; Cur=
rently there are:<BR>&gt; &gt; k10temp-pci-00c3<BR>&gt; &gt; temp1:&nbsp; &=
nbsp; &nbsp; +27.0=B0C&nbsp; (high =3D +70.0=B0C, crit =3D +70.0=B0C)<BR>&g=
t; &gt; k10temp-pci-00cb<BR>&gt; &gt; temp1:&nbsp; &nbsp; &nbsp; +27.0=B0C&=
nbsp; (high =3D +70.0=B0C)<BR>&gt; &gt; k10temp-pci-00d3<BR>&gt; &gt; temp1=
:&nbsp; &nbsp; &nbsp; +26.0=B0C&nbsp; (high =3D +70.0=B0C)<BR>&gt; &gt; k10=
temp-pci-00db<BR>&gt; &gt; temp1:&nbsp; &nbsp; &nbsp; +26.0=B0C&nbsp; (high=
 =3D +70.0=B0C, crit =3D +70.0=B0C)<BR>&gt; &gt;&nbsp; <BR>&gt; &gt; Is it =
true that [00c3 and 00cb] are for one physical cpu and [00d3 and 00db] are =
<BR>&gt; &gt;
 for the other cpu?<BR><BR>I conclude from this question that you have two =
CPUs, and that each CPU<BR>has two temperature sensors.<BR><BR>The temperat=
ure sensor is part of the PCI device that associated with<BR>the CPU's inte=
rnal northbridge.&nbsp; IIRC the six-core CPUs have two<BR>northbridges, fo=
r whatever technical reason, so they present two<BR>temparature sensors to =
the OS.<BR><BR>It looks as if the two sensors in each CPU have the same val=
ue.&nbsp; Is this<BR>always the case?<BR><BR>(I don't know where the c3/cb/=
d3/db names come from.)<BR><BR>&gt; All entries in cpuinfo look the same, s=
o I can't explain why some have<BR>&gt; the critical limit and some don't.<=
BR><BR>The limit is set by the BIOS.&nbsp; I'd guess the BIOS knows that tw=
o sensors<BR>are actually the same, an so doesn't bother to set the limit o=
n the<BR>superfluous ones.<BR><BR>I'll look into the datasheet to see if th=
is situation (two northbridges<BR>per CPU) is documented and can be
 detected so that the driver can ignore<BR>these superfluous sensors.<BR><B=
R><BR>Regards,<BR>Clemens<BR></DIV></DIV></div><br>=0A=0A      </body></htm=
l>
--0-795968659-1288101631=:81860--


--===============0019158391596536538==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0019158391596536538==--
