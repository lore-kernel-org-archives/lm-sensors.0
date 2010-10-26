From: Mahmood Naderan <nt_mahmood@yahoo.com>
Date: Tue, 26 Oct 2010 13:06:53 +0000
Subject: Re: [lm-sensors] k10temp is detected but not shown
Message-Id: <550656.84141.qm@web111712.mail.gq1.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6326604098643200632=="
List-Id: <lm-sensors.vger.kernel.org>
References: <578838.74607.qm@web111714.mail.gq1.yahoo.com>
In-Reply-To: <578838.74607.qm@web111714.mail.gq1.yahoo.com>
To: lm-sensors@vger.kernel.org

--===============6326604098643200632==
Content-Type: multipart/alternative; boundary="0-1910675281-1288098413=:84141"

--0-1910675281-1288098413=:84141
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

>Please provide the output of:=0A>lspci -xxx -d 1022:1203=0A=0Amahmood@loca=
lhost:~$ lspci -xxx -d 1022:1203=0A00:18.3 Host bridge: Advanced Micro Devi=
ces [AMD] K10 [Opteron, Athlon64, =0ASempron] Miscellaneous Control=0A00: 2=
2 10 03 12 00 00 10 00 00 00 00 06 00 00 80 00=0A10: 00 00 00 00 00 00 00 0=
0 00 00 00 00 00 00 00 00=0A20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0 00=0A30: 00 00 00 00 f0 00 00 00 00 00 00 00 00 00 00 00=0A00:19.3 Host b=
ridge: Advanced Micro Devices [AMD] K10 [Opteron, Athlon64, =0ASempron] Mis=
cellaneous Control=0A00: 22 10 03 12 00 00 10 00 00 00 00 06 00 00 80 00=0A=
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A20: 00 00 00 00 00 00=
 00 00 00 00 00 00 00 00 00 00=0A30: 00 00 00 00 f0 00 00 00 00 00 00 00 00=
 00 00 00=0A00:1a.3 Host bridge: Advanced Micro Devices [AMD] K10 [Opteron,=
 Athlon64, =0ASempron] Miscellaneous Control=0A00: 22 10 03 12 00 00 10 00 =
00 00 00 06 00 00 80 00=0A10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00=0A20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A30: 00 00 00 00 =
f0 00 00 00 00 00 00 00 00 00 00 00=0A00:1b.3 Host bridge: Advanced Micro D=
evices [AMD] K10 [Opteron, Athlon64, =0ASempron] Miscellaneous Control=0A00=
: 22 10 03 12 00 00 10 00 00 00 00 06 00 00 80 00=0A10: 00 00 00 00 00 00 0=
0 00 00 00 00 00 00 00 00 00=0A20: 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0 00 00=0A30: 00 00 00 00 f0 00 00 00 00 00 00 00 00 00 00 00=0A=0A=A0=0AOn=
e more question, Is it possible to find out which two modules are tied to o=
ne =0Aprocessor?=0ACurrently there are:=0Ak10temp-pci-00c3=0AAdapter: PCI a=
dapter=0Atemp1:=A0=A0=A0=A0=A0=A0 +27.0=C2=B0C=A0 (high =3D +70.0=C2=B0C, c=
rit =3D +70.0=C2=B0C)=0Ak10temp-pci-00cb=0AAdapter: PCI adapter=0Atemp1:=A0=
=A0=A0=A0=A0=A0 +27.0=C2=B0C=A0 (high =3D +70.0=C2=B0C)=0Ak10temp-pci-00d3=
=0AAdapter: PCI adapter=0Atemp1:=A0=A0=A0=A0=A0=A0 +26.0=C2=B0C=A0 (high =
=3D +70.0=C2=B0C)=0Ak10temp-pci-00db=0AAdapter: PCI adapter=0Atemp1:=A0=A0=
=A0=A0=A0=A0 +26.0=C2=B0C=A0 (high =3D +70.0=C2=B0C, crit =3D +70.0=C2=B0C)=
=0A=A0=0AIs it true that [00c3 and 00cb] are for one physical cpu and [00d3=
 and=A000db] are =0Afor the other cpu?=0AThanks,=0A// Naderan *Mahmood;=0A=
=0A=0A=0A----- Original Message ----=0AFrom: Jean Delvare <khali@linux-fr.o=
rg>=0ATo: Mahmood Naderan <nt_mahmood@yahoo.com>=0ACc: lm-sensors <lm-senso=
rs@lm-sensors.org>; Clemens Ladisch <clemens@ladisch.de>=0ASent: Tue, Octob=
er 26, 2010 4:08:01 PM=0ASubject: Re: [lm-sensors] k10temp is detected but =
not shown=0A=0AOn Tue, 26 Oct 2010 04:57:25 -0700 (PDT), Mahmood Naderan wr=
ote:=0A> > Please attach the contents of /proc/cpuinfo and the output of ls=
pci.=0A> I have attached them=0A=0APlease use plain text, uncompressed atta=
chments next time. It's easier=0Ato watch directly in my e-mail client.=0A=
=0AFrom lspci:=0A=0A00:18.3 Host bridge: Advanced Micro Devices [AMD] K10 [=
Opteron, Athlon64, =0ASempron] Miscellaneous Control=0A00:19.3 Host bridge:=
 Advanced Micro Devices [AMD] K10 [Opteron, Athlon64, =0ASempron] Miscellan=
eous Control=0A00:1a.3 Host bridge: Advanced Micro Devices [AMD] K10 [Opter=
on, Athlon64, =0ASempron] Miscellaneous Control=0A00:1b.3 Host bridge: Adva=
nced Micro Devices [AMD] K10 [Opteron, Athlon64, =0ASempron] Miscellaneous =
Control=0A=0AThese are the PCI devices which provide temperature readings. =
4 devices=0A-> 4 entries in "sensors", everything is as expected.=0A=0AAll =
entries in cpuinfo look the same, so I can't explain why some have=0Athe cr=
itical limit and some don't. Please provide the output of:=0A=0Alspci -xxx =
-d 1022:1203=0A=0A> >Doh. You are aware that Core i7 CPUs are made by Intel=
 and Family 10h=0A> >(aka K10) CPUs are made by AMD, aren't you? They are d=
ifferent CPU=0A> >models, they don't have to be designed the same way.=0A> =
I know that :)=0A> I thought maybe that is a standard and each cpu temperat=
ure must be shown =0A> separetly.=0A=0AThere is no such standard.=0A=0A-- =
=0AJean Delvare=0A=0A=0A=0A      
--0-1910675281-1288098413=:84141
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><DIV></DIV>=0A<DIV>&gt;Please provide the output of:<BR>&gt=
;lspci -xxx -d 1022:1203<BR></DIV>=0A<DIV><FONT size=3D2 face=3D"Courier Ne=
w, courier, monaco, monospace, sans-serif">mahmood@localhost:~$ lspci -xxx =
-d 1022:1203<BR>00:18.3 Host bridge: Advanced Micro Devices [AMD] K10 [Opte=
ron, Athlon64, Sempron] Miscellaneous Control<BR>00: 22 10 03 12 00 00 10 0=
0 00 00 00 06 00 00 80 00<BR>10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00<BR>20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<BR>30: 00 00 0=
0 00 f0 00 00 00 00 00 00 00 00 00 00 00</FONT></DIV>=0A<DIV><FONT size=3D2=
 face=3D"Courier New, courier, monaco, monospace, sans-serif">00:19.3 Host =
bridge: Advanced Micro Devices [AMD] K10 [Opteron, Athlon64, Sempron] Misce=
llaneous Control<BR>00: 22 10 03 12 00 00 10 00 00 00 00 06 00 00 80 00<BR>=
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<BR>20: 00 00 00 00 00 0=
0 00 00 00 00 00 00 00 00 00 00<BR>30: 00 00 00 00 f0 00 00 00 00 00 00 00 =
00 00 00 00</FONT></DIV>=0A<DIV><FONT size=3D2 face=3D"Courier New, courier=
, monaco, monospace, sans-serif">00:1a.3 Host bridge: Advanced Micro Device=
s [AMD] K10 [Opteron, Athlon64, Sempron] Miscellaneous Control<BR>00: 22 10=
 03 12 00 00 10 00 00 00 00 06 00 00 80 00<BR>10: 00 00 00 00 00 00 00 00 0=
0 00 00 00 00 00 00 00<BR>20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00<BR>30: 00 00 00 00 f0 00 00 00 00 00 00 00 00 00 00 00</FONT></DIV>=0A<D=
IV><FONT size=3D2 face=3D"Courier New, courier, monaco, monospace, sans-ser=
if">00:1b.3 Host bridge: Advanced Micro Devices [AMD] K10 [Opteron, Athlon6=
4, Sempron] Miscellaneous Control<BR>00: 22 10 03 12 00 00 10 00 00 00 00 0=
6 00 00 80 00<BR>10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<BR>20:=
 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<BR>30: 00 00 00 00 f0 00 0=
0 00 00 00 00 00 00 00 00 00</FONT></DIV>=0A<DIV><BR>&nbsp;</DIV>=0A<DIV>On=
e more question, Is it possible to find out which two modules are tied to o=
ne processor?</DIV>=0A<DIV>Currently there are:</DIV>=0A<P><FONT size=3D2 f=
ace=3D"Courier New, courier, monaco, monospace, sans-serif">k10temp-pci-00c=
3<BR>Adapter: PCI adapter<BR>temp1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +27=
.0=C2=B0C&nbsp; (high =3D +70.0=C2=B0C, crit =3D +70.0=C2=B0C)</FONT></P>=
=0A<P><FONT size=3D2 face=3D"Courier New, courier, monaco, monospace, sans-=
serif">k10temp-pci-00cb<BR>Adapter: PCI adapter<BR>temp1:&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; +27.0=C2=B0C&nbsp; (high =3D +70.0=C2=B0C)</FONT></P>=0A=
<P><FONT size=3D2 face=3D"Courier New, courier, monaco, monospace, sans-ser=
if">k10temp-pci-00d3<BR>Adapter: PCI adapter<BR>temp1:&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; +26.0=C2=B0C&nbsp; (high =3D +70.0=C2=B0C)</FONT></P>=0A<P>=
<FONT size=3D2 face=3D"Courier New, courier, monaco, monospace, sans-serif"=
>k10temp-pci-00db<BR>Adapter: PCI adapter<BR>temp1:&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; +26.0=C2=B0C&nbsp; (high =3D +70.0=C2=B0C, crit =3D +70.0=C2=
=B0C)</FONT></P>=0A<P>&nbsp;</P>=0A<P>Is it true that [00c3 and 00cb] are f=
or one physical cpu and [00d3 and&nbsp;00db] are for the other cpu?</P>=0A<=
DIV>Thanks,</DIV>=0A<DIV>// Naderan *Mahmood;</DIV>=0A<DIV><BR></DIV>=0A<DI=
V><BR>=0A<DIV>----- Original Message ----<BR>From: Jean Delvare &lt;khali@l=
inux-fr.org&gt;<BR>To: Mahmood Naderan &lt;nt_mahmood@yahoo.com&gt;<BR>Cc: =
lm-sensors &lt;lm-sensors@lm-sensors.org&gt;; Clemens Ladisch &lt;clemens@l=
adisch.de&gt;<BR>Sent: Tue, October 26, 2010 4:08:01 PM<BR>Subject: Re: [lm=
-sensors] k10temp is detected but not shown<BR><BR>On Tue, 26 Oct 2010 04:5=
7:25 -0700 (PDT), Mahmood Naderan wrote:<BR>&gt; &gt; Please attach the con=
tents of /proc/cpuinfo and the output of lspci.<BR>&gt; I have attached the=
m<BR><BR>Please use plain text, uncompressed attachments next time. It's ea=
sier<BR>to watch directly in my e-mail client.<BR><BR>From lspci:<BR><BR>00=
:18.3 Host bridge: Advanced Micro Devices [AMD] K10 [Opteron, Athlon64, Sem=
pron] Miscellaneous Control<BR>00:19.3 Host bridge: Advanced Micro Devices =
[AMD] K10 [Opteron, Athlon64, Sempron] Miscellaneous Control<BR>00:1a.3 Hos=
t bridge: Advanced Micro Devices [AMD] K10 [Opteron, Athlon64, Sempron]
 Miscellaneous Control<BR>00:1b.3 Host bridge: Advanced Micro Devices [AMD]=
 K10 [Opteron, Athlon64, Sempron] Miscellaneous Control<BR><BR>These are th=
e PCI devices which provide temperature readings. 4 devices<BR>-&gt; 4 entr=
ies in "sensors", everything is as expected.<BR><BR>All entries in cpuinfo =
look the same, so I can't explain why some have<BR>the critical limit and s=
ome don't. Please provide the output of:<BR><BR>lspci -xxx -d 1022:1203<BR>=
<BR>&gt; &gt;Doh. You are aware that Core i7 CPUs are made by Intel and Fam=
ily 10h<BR>&gt; &gt;(aka K10) CPUs are made by AMD, aren't you? They are di=
fferent CPU<BR>&gt; &gt;models, they don't have to be designed the same way=
.<BR>&gt; I know that :)<BR>&gt; I thought maybe that is a standard and eac=
h cpu temperature must be shown <BR>&gt; separetly.<BR><BR>There is no such=
 standard.<BR><BR>-- <BR>Jean Delvare<BR></DIV></DIV></div><br>=0A=0A      =
</body></html>
--0-1910675281-1288098413=:84141--


--===============6326604098643200632==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6326604098643200632==--
