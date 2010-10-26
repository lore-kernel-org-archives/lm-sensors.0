From: Mahmood Naderan <nt_mahmood@yahoo.com>
Date: Tue, 26 Oct 2010 15:33:35 +0000
Subject: Re: [lm-sensors] k10temp is detected but not shown
Message-Id: <91832.24982.qm@web111718.mail.gq1.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0279570507581538240=="
List-Id: <lm-sensors.vger.kernel.org>
References: <578838.74607.qm@web111714.mail.gq1.yahoo.com>
In-Reply-To: <578838.74607.qm@web111714.mail.gq1.yahoo.com>
To: lm-sensors@vger.kernel.org

--===============0279570507581538240==
Content-Type: multipart/alternative; boundary="0-288797836-1288107215=:24982"

--0-288797836-1288107215=:24982
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

>I suspect he has Magny Cours processors. They are multi-chip modules with =
two =0A>CPU chips per >package. /proc/cpuinfo will >tell you which cores ar=
e in which =0A>sockets=0AYes. I think "physical id"=A0shows the socket numb=
er=0A=A0=0A>$ numactl --cpunodebind=3D0 mprime -b4 -t=0A>You should see the=
 temperatures diverge for the sensors in the same socket.=0AYes I saw that=
=A0the first two temperature are the same but different from other =0Atwo=
=A0 =0A=0A=0A// Naderan *Mahmood;=0A=0A=0A=0A=0A___________________________=
_____=0AFrom: Philip Pokorny <ppokorny@penguincomputing.com>=0ATo: Jean Del=
vare <khali@linux-fr.org>=0ACc: Clemens Ladisch <clemens@ladisch.de>; lm-se=
nsors <lm-sensors@lm-sensors.org>=0ASent: Tue, October 26, 2010 6:34:22 PM=
=0ASubject: Re: [lm-sensors] k10temp is detected but not shown=0A=0A=0A=0AO=
n Oct 26, 2010, at 7:15 AM, Jean Delvare <khali@linux-fr.org> wrote:=0A=0A>=
 Hi Clemens,=0A> =0A> On Tue, 26 Oct 2010 15:53:29 +0200, Clemens Ladisch w=
rote:=0A>> Jean Delvare wrote:=0A>>>>> Doh. You are aware that Core i7 CPUs=
 are made by Intel and Family 10h=0A>>>>> (aka K10) CPUs are made by AMD, a=
ren't you? They are different CPU=0A>>>>> models, they don't have to be des=
igned the same way.=0A>>>> =0A>>>> I know that :)=0A>>>> I thought maybe th=
at is a standard and each cpu temperature must be show=0A>>>> separetly.=0A=
>>> =0A>>> There is no such standard.=0A>> =0A>> And on the newest CPUs, In=
tel has switched to one temperature sensor per=0A>> package.=0A> =0A> Reall=
y? Starting with which CPU model?=0A> =0A>>> On Tue, 26 Oct 2010 06:06:53 -=
0700 (PDT), Mahmood Naderan wrote:=0A>>>> One more question, Is it possible=
 to find out which two modules are tied to =0A>>>one=0A>>>> processor?=0A>>=
> =0A>>> Modules?=0A=0AI suspect he has Magny Cours processors. They are mu=
lti-chip modules with two =0ACPU chips per package. /proc/cpuinfo will tell=
 you which cores are in which =0Asockets.=0A=0A=0A=0A>>>> Is it true that [=
00c3 and 00cb] are for one physical cpu and [00d3 and 00db] =0A>>>>are=0A>>=
>> for the other cpu?=0A>> =0A>> I conclude from this question that you hav=
e two CPUs, and that each CPU=0A>> has two temperature sensors.=0A>> =0A>> =
The temperature sensor is part of the PCI device that associated with=0A>> =
the CPU's internal northbridge.=A0 IIRC the six-core CPUs have two=0A>> nor=
thbridges, for whatever technical reason, so they present two=0A>> temparat=
ure sensors to the OS.=0A>> =0A>> It looks as if the two sensors in each CP=
U have the same value.=A0 Is this=0A>> always the case?=0A>> =0A>> (I don't=
 know where the c3/cb/d3/db names come from.)=0A> =0A> This is the PCI bus =
number in compact hexadecimal form:=0A> =0A> 00:18.3 -> 00c3=0A> 00:19.3 ->=
 00cb=0A> 00:1a.3 -> 00d3=0A> 00:1b.3 -> 00db=0A> =0A> We had to find a uni=
que ID to differentiate between them, and that ID=0A> had to fit in an int =
to make libsensors happy.=0A> =0A>>> All entries in cpuinfo look the same, =
so I can't explain why some have=0A>>> the critical limit and some don't.=
=0A>> =0A>> The limit is set by the BIOS.=A0 I'd guess the BIOS knows that =
two sensors=0A>> are actually the same, an so doesn't bother to set the lim=
it on the=0A>> superfluous ones.=0A>> =0A>> I'll look into the datasheet to=
 see if this situation (two northbridges=0A>> per CPU) is documented and ca=
n be detected so that the driver can ignore=0A>> these superfluous sensors.=
=0A> =0A> If these sensors exist, I see no valid reason to ignore them. Two=
=0A> sensors can be useful, to slightly increase the resolution by combinin=
g=0A> them, or simply in case one of them get unreliable for whatever reaso=
n.=0A> =0A=0AIf these are Magny Cours, then they are definitely different s=
ensors and they =0Acome from the different CPU chips in the package. If you=
 ran a load on only one =0ACPU chip:=0A=0A$ numactl --cpunodebind=3D0 mprim=
e -b4 -t=0A=0AYou should see the temperatures diverge for the sensors in th=
e same socket.=0A=0APhil P.=0A_____________________________________________=
__=0Alm-sensors mailing list=0Alm-sensors@lm-sensors.org=0Ahttp://lists.lm-=
sensors.org/mailman/listinfo/lm-sensors=0A=0A=0A=0A      
--0-288797836-1288107215=:24982
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:Courier New, courier, monaco, monospace,=
 sans-serif;font-size:10pt"><DIV></DIV>=0A<DIV><FONT size=3D3 face=3D"tahom=
a, new york, times, serif">&gt;I suspect he has Magny Cours processors. The=
y are multi-chip modules with two CPU chips per &gt;package. /proc/cpuinfo =
will &gt;tell you which cores are in which sockets</FONT></DIV>=0A<DIV><FON=
T size=3D3 face=3D"tahoma, new york, times, serif">Yes. I think "physical i=
d"&nbsp;shows the socket number</FONT></DIV>=0A<DIV><FONT size=3D3 face=3D"=
tahoma, new york, times, serif"></FONT>&nbsp;</DIV>=0A<DIV><FONT size=3D3 f=
ace=3D"tahoma, new york, times, serif">&gt;$ numactl --cpunodebind=3D0 mpri=
me -b4 -t<BR>&gt;You should see the temperatures diverge for the sensors in=
 the same socket.</FONT></DIV>=0A<DIV><FONT size=3D3 face=3D"tahoma, new yo=
rk, times, serif">Yes I saw that&nbsp;the first two temperature are the sam=
e but different from other two&nbsp; </FONT></DIV>=0A<DIV>&nbsp;</DIV>=0A<D=
IV>=0A<DIV><FONT style=3D"BACKGROUND-COLOR: #ffffff" color=3D#0080ff size=
=3D2 face=3D"arial, helvetica, sans-serif"><STRONG>// Naderan *Mahmood;</ST=
RONG></FONT></DIV></DIV>=0A<DIV><BR></DIV>=0A<DIV style=3D"FONT-FAMILY: Cou=
rier New, courier, monaco, monospace, sans-serif; FONT-SIZE: 10pt"><BR>=0A<=
DIV style=3D"FONT-FAMILY: tahoma, new york, times, serif; FONT-SIZE: 12pt">=
<FONT size=3D2 face=3DTahoma>=0A<HR SIZE=3D1>=0A<B><SPAN style=3D"FONT-WEIG=
HT: bold">From:</SPAN></B> Philip Pokorny &lt;ppokorny@penguincomputing.com=
&gt;<BR><B><SPAN style=3D"FONT-WEIGHT: bold">To:</SPAN></B> Jean Delvare &l=
t;khali@linux-fr.org&gt;<BR><B><SPAN style=3D"FONT-WEIGHT: bold">Cc:</SPAN>=
</B> Clemens Ladisch &lt;clemens@ladisch.de&gt;; lm-sensors &lt;lm-sensors@=
lm-sensors.org&gt;<BR><B><SPAN style=3D"FONT-WEIGHT: bold">Sent:</SPAN></B>=
 Tue, October 26, 2010 6:34:22 PM<BR><B><SPAN style=3D"FONT-WEIGHT: bold">S=
ubject:</SPAN></B> Re: [lm-sensors] k10temp is detected but not shown<BR></=
FONT><BR><BR><BR>On Oct 26, 2010, at 7:15 AM, Jean Delvare &lt;<A href=3D"m=
ailto:khali@linux-fr.org" ymailto=3D"mailto:khali@linux-fr.org">khali@linux=
-fr.org</A>&gt; wrote:<BR><BR>&gt; Hi Clemens,<BR>&gt; <BR>&gt; On Tue, 26 =
Oct 2010 15:53:29 +0200, Clemens Ladisch wrote:<BR>&gt;&gt; Jean Delvare wr=
ote:<BR>&gt;&gt;&gt;&gt;&gt; Doh. You are aware that Core i7 CPUs are made =
by Intel and Family 10h<BR>&gt;&gt;&gt;&gt;&gt; (aka
 K10) CPUs are made by AMD, aren't you? They are different CPU<BR>&gt;&gt;&=
gt;&gt;&gt; models, they don't have to be designed the same way.<BR>&gt;&gt=
;&gt;&gt; <BR>&gt;&gt;&gt;&gt; I know that :)<BR>&gt;&gt;&gt;&gt; I thought=
 maybe that is a standard and each cpu temperature must be show<BR>&gt;&gt;=
&gt;&gt; separetly.<BR>&gt;&gt;&gt; <BR>&gt;&gt;&gt; There is no such stand=
ard.<BR>&gt;&gt; <BR>&gt;&gt; And on the newest CPUs, Intel has switched to=
 one temperature sensor per<BR>&gt;&gt; package.<BR>&gt; <BR>&gt; Really? S=
tarting with which CPU model?<BR>&gt; <BR>&gt;&gt;&gt; On Tue, 26 Oct 2010 =
06:06:53 -0700 (PDT), Mahmood Naderan wrote:<BR>&gt;&gt;&gt;&gt; One more q=
uestion, Is it possible to find out which two modules are tied to one<BR>&g=
t;&gt;&gt;&gt; processor?<BR>&gt;&gt;&gt; <BR>&gt;&gt;&gt; Modules?<BR><BR>=
I suspect he has Magny Cours processors. They are multi-chip modules with t=
wo CPU chips per package. /proc/cpuinfo will tell you which cores
 are in which sockets.<BR><BR><BR><BR>&gt;&gt;&gt;&gt; Is it true that [00c=
3 and 00cb] are for one physical cpu and [00d3 and 00db] are<BR>&gt;&gt;&gt=
;&gt; for the other cpu?<BR>&gt;&gt; <BR>&gt;&gt; I conclude from this ques=
tion that you have two CPUs, and that each CPU<BR>&gt;&gt; has two temperat=
ure sensors.<BR>&gt;&gt; <BR>&gt;&gt; The temperature sensor is part of the=
 PCI device that associated with<BR>&gt;&gt; the CPU's internal northbridge=
.&nbsp; IIRC the six-core CPUs have two<BR>&gt;&gt; northbridges, for whate=
ver technical reason, so they present two<BR>&gt;&gt; temparature sensors t=
o the OS.<BR>&gt;&gt; <BR>&gt;&gt; It looks as if the two sensors in each C=
PU have the same value.&nbsp; Is this<BR>&gt;&gt; always the case?<BR>&gt;&=
gt; <BR>&gt;&gt; (I don't know where the c3/cb/d3/db names come from.)<BR>&=
gt; <BR>&gt; This is the PCI bus number in compact hexadecimal form:<BR>&gt=
; <BR>&gt; 00:18.3 -&gt; 00c3<BR>&gt; 00:19.3 -&gt; 00cb<BR>&gt;
 00:1a.3 -&gt; 00d3<BR>&gt; 00:1b.3 -&gt; 00db<BR>&gt; <BR>&gt; We had to f=
ind a unique ID to differentiate between them, and that ID<BR>&gt; had to f=
it in an int to make libsensors happy.<BR>&gt; <BR>&gt;&gt;&gt; All entries=
 in cpuinfo look the same, so I can't explain why some have<BR>&gt;&gt;&gt;=
 the critical limit and some don't.<BR>&gt;&gt; <BR>&gt;&gt; The limit is s=
et by the BIOS.&nbsp; I'd guess the BIOS knows that two sensors<BR>&gt;&gt;=
 are actually the same, an so doesn't bother to set the limit on the<BR>&gt=
;&gt; superfluous ones.<BR>&gt;&gt; <BR>&gt;&gt; I'll look into the datashe=
et to see if this situation (two northbridges<BR>&gt;&gt; per CPU) is docum=
ented and can be detected so that the driver can ignore<BR>&gt;&gt; these s=
uperfluous sensors.<BR>&gt; <BR>&gt; If these sensors exist, I see no valid=
 reason to ignore them. Two<BR>&gt; sensors can be useful, to slightly incr=
ease the resolution by combining<BR>&gt; them, or simply in case one
 of them get unreliable for whatever reason.<BR>&gt; <BR><BR>If these are M=
agny Cours, then they are definitely different sensors and they come from t=
he different CPU chips in the package. If you ran a load on only one CPU ch=
ip:<BR><BR>$ numactl --cpunodebind=3D0 mprime -b4 -t<BR><BR>You should see =
the temperatures diverge for the sensors in the same socket.<BR><BR>Phil P.=
<BR>_______________________________________________<BR>lm-sensors mailing l=
ist<BR><A href=3D"mailto:lm-sensors@lm-sensors.org" ymailto=3D"mailto:lm-se=
nsors@lm-sensors.org">lm-sensors@lm-sensors.org</A><BR>http://lists.lm-sens=
ors.org/mailman/listinfo/lm-sensors<BR></DIV></DIV></div><br>=0A=0A      </=
body></html>
--0-288797836-1288107215=:24982--


--===============0279570507581538240==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0279570507581538240==--
