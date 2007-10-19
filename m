From: JAMES SCOTT <skoona@verizon.net>
Date: Fri, 19 Oct 2007 18:50:03 +0000
Subject: Re: [lm-sensors] ABIT IP35 Pro mainboard wrong values from 'sensors'
Message-Id: <155449.85449.qm@web84109.mail.mud.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7479440379170303782=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1192816904.8203.11.camel@homedev.skoona.net>
In-Reply-To: <1192816904.8203.11.camel@homedev.skoona.net>
To: lm-sensors@vger.kernel.org

--===============7479440379170303782==
Content-Type: multipart/alternative; boundary="0-1725034136-1192819803=:85449"

--0-1725034136-1192819803=:85449
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

See inline comments=0A=0A----- Original Message ----=0AFrom: David Hubbard =
<david.c.hubbard@gmail.com>=0ATo: James Scott Jr <skoona@verizon.net>; lm-s=
ensors@lm-sensors.org=0ASent: Friday, October 19, 2007 2:34:54 PM=0ASubject=
: Re: [lm-sensors] ABIT IP35 Pro mainboard wrong values from 'sensors'=0A=
=0AHi James,=0A=0A>  I have a system with an Intel Q6600 quad core on a ABi=
t IP35 Pro mainboard,=0A> using Fedora 7 x64, and lm_sensors-2.10.4-1.fc7. =
 The output from sensors is=0A> wrong.  Is there a preformatted config file=
 for these mainboard somewhere=0A> that I can find?  Or can you give me a h=
it on what I need to know in order=0A> to create/adjust one?=0A=0AI think y=
ou'll need to create one. I haven't seen any emails on the=0Alm-sensors lis=
t about your motherboard.=0A=0ACreating a new config file isn't too hard. L=
ook at the man page for=0Asensors.conf: http://www.lm-sensors.org/wiki/man/=
sensors.conf=0A=0AYou should also have one already (maybe in /etc/sensors.c=
onf) and=0Areading it is very helpful.=0A=0Ayes, I have a /etc/sensors.conf=
 with an entry for w83627dhg-isa-*, but not coretemp-isa-*=0A=0A>  The cpu =
cores are really in the high 30's, cpu  & case fans are not=0A> present, ..=
..=0A=0AI'm looking at the IP32 pro manual, page 11, and I see six fans=0A(=
CPUfan1, SYSfan1, AUXfan1-4). The w83627dhg only reads the RPM from 5=0Afan=
s, which makes me wonder if your southbridge (possibly an Intel=0AICH9) is =
controlling one fan. Do you have zero fans connected? Or just=0Aone (a CPU =
fan?). Page 22 of the manual mentions "abit's exclusive=0AGuru Panel." Do y=
ou have a uguru on the motherboard? (I'm not really=0Afamiliar with abit's =
uguru, but there are some other people here on=0Alm-sensors who know a lot =
more about it.)=0A=0AI have a cpu fan, and case fan in their labeled positi=
on.   I will be adding a memory cooler fan later in the aux1 fan position. =
 all other positions are empty.  No uguru as uguru is  a windows app.=0A=0A=
The sensors.conf file we figure out here, for the sake of all IP32 pro=0Aus=
ers, should probably not disable the fan input readings and alarms.=0ABut i=
f you want, you can set "ignore" statements for all the fans, so=0Athey don=
't show up in the sensors output, since you don't have fans=0Aconnected to =
the motherboard.=0A=0A>  [jscott@vserv ~]$ sensors=0A>  w83627dhg-isa-0290=
=0A>  Adapter: ISA adapter=0A=0AOK, the above lines are fine.=0A=0A>  VCore=
:     +1.46 V  (min =3D  +1.03 V, max =3D  +1.74 V)=0A>  in1:       +8.76 V=
  (min =3D +11.30 V, max =3D  +2.80 V) ALARM=0A>  AVCC:      +3.20 V  (min =
=3D  +2.06 V, max =3D  +0.88 V) ALARM=0A>  3VCC:      +3.20 V  (min =3D  +1=
.87 V, max =3D  +0.58 V) ALARM=0A>  in4:       +1.48 V  (min =3D  +0.34 V, =
max =3D  +1.20 V) ALARM=0A>  in5:       +1.34 V  (min =3D  +1.03 V, max =3D=
  +1.03 V) ALARM=0A>  in6:       +4.28 V  (min =3D  +5.99 V, max =3D  +3.30=
 V) ALARM=0A>  VSB:       +3.10 V  (min =3D  +3.47 V, max =3D  +2.02 V) ALA=
RM=0A>  VBAT:      +0.51 V  (min =3D  +0.99 V, max =3D  +2.06 V) ALARM=0A=
=0AIt would be really helpful to match these voltages against voltages in=
=0Ayour BIOS. Also, try to find information on what the min and max for=0Ae=
ach should be. The most important ones, of course, are VCore, 3VCC,=0AVBAT,=
 and 12V (which I don't see there).=0A=0AI will get those data points later=
 tonight when I get home.  I remember VCore being 1.33V though.=0A=0AThis m=
eans that the voltages are not being calculated correctly. This=0Aisn't a s=
urprise. The w83627dhg chip reads voltages, but each=0Amotherboard is wired=
 differently, so the voltage arriving at the 'dhg=0Apins is never the same.=
=0A=0A>  Case Fan:    0 RPM  (min =3D 10546 RPM, div =3D 128) ALARM=0A>  CP=
U Fan:     0 RPM  (min =3D 10546 RPM, div =3D 128) ALARM=0A>  Aux Fan:     =
0 RPM  (min =3D 10546 RPM, div =3D 128) ALARM=0A>  fan4:        0 RPM  (min=
 =3D  439 RPM, div =3D 128) ALARM=0A>  fan5:        0 RPM  (min =3D   81 RP=
M, div =3D 128) ALARM=0A=0ASo it looks like nothing's connected to your fan=
s. We'll just leave=0Athem there for now.=0A=0ACPU fan is a 100mm and case =
fan is a 80mm fan.=0A=0A>  Sys Temp:    +21=B0C  (high =3D   +58=B0C, hyst =
=3D   +78=B0C)=0A>  CPU Temp:  +30.0=B0C  (high =3D -126.0=B0C, hyst =3D +7=
5.5=B0C)=0A>  AUX Temp:  -23.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C=
)=0A=0AThe temps don't look right. I think coretemp is reporting the right=
=0Atemperature, and sensors.conf will need to scale the temps it gets=0A(wh=
ich are just voltages) to match coretemp.=0A=0A>  coretemp-isa-0000=0A>  Ad=
apter: ISA adapter=0A>  Core 0:      +54=B0C  (high =3D  +100=B0C)=0A>=0A> =
 coretemp-isa-0001=0A>  Adapter: ISA adapter=0A>  Core 1:      +51=B0C  (hi=
gh =3D  +100=B0C)=0A>=0A>  coretemp-isa-0002=0A>  Adapter: ISA adapter=0A> =
 Core 2:      +49=B0C  (high =3D  +100=B0C)=0A>=0A>  coretemp-isa-0003=0A> =
 Adapter: ISA adapter=0A>  Core 3:      +52=B0C  (high =3D  +100=B0C)=0A>=
=0A>  [jscott@vserv ~]$=0A>=0A>=0A>=0A>  [jscott@vserv ~]$ cat /etc/sysconf=
ig/lm_sensors=0A>  ...=0A>  #=0A>  # Generated by sensors-detect on Fri Oct=
 19 00:26:53 2007=0A>  MODULE_0=3Dw83627ehf=0A>  MODULE_1=3Dcoretemp=0A>  [=
jscott@vserv ~]$=0A=0AWell, that's a start. Please reply with information a=
bout what chips=0Ayou have (you can run 'lspci -n' for that) and look at yo=
ur BIOS setup=0Ascreen for voltages and temperatures. The numbers reported =
by BIOS=0Awill be the most accurate. We'll try to match those numbers in=0A=
sensors.=0A=0AHTH,=0ADavid=0A=0AOk, thanks.=0A=0AI will post the bios temps=
, speeds, and voltage values, along with my sensors.conf file.  I should me=
ntion I am planning to use gkrellm; but I need sensors to read right before=
 adjusting it.  Question: As I think about the list of ports 'in1, in2, etc=
' that are contained in the sensors.conf file.  How do I determine all the =
ports available as a starting template - is their a tool that can enum what=
's available from the chip? before I verify that the correct labels and com=
putes are applied?  =0A=0AJames,=0A=0A=0A=0A=0A
--0-1725034136-1192819803=:85449
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:10pt"><div style=3D"font-family: times new roman,new york,times,s=
erif; font-size: 10pt;">See inline comments<br><br><div style=3D"font-famil=
y: times new roman,new york,times,serif; font-size: 12pt;">----- Original M=
essage ----<br>From: David Hubbard &lt;david.c.hubbard@gmail.com&gt;<br>To:=
 James Scott Jr &lt;skoona@verizon.net&gt;; lm-sensors@lm-sensors.org<br>Se=
nt: Friday, October 19, 2007 2:34:54 PM<br>Subject: Re: [lm-sensors] ABIT I=
P35 Pro mainboard wrong values from 'sensors'<br><br><div>Hi James,<br><br>=
&gt;&nbsp;&nbsp;I have a system with an Intel Q6600 quad core on a ABit IP3=
5 Pro mainboard,<br>&gt; using Fedora 7 x64, and lm_sensors-2.10.4-1.fc7.&n=
bsp;&nbsp;The output from sensors is<br>&gt; wrong.&nbsp;&nbsp;Is there a p=
reformatted config file for these mainboard somewhere<br>&gt; that I can
 find?&nbsp;&nbsp;Or can you give me a hit on what I need to know in order<=
br>&gt; to create/adjust one?<br><br>I think you'll need to create one. I h=
aven't seen any emails on the<br>lm-sensors list about your motherboard.<br=
><br>Creating a new config file isn't too hard. Look at the man page for<br=
>sensors.conf: <a target=3D"_blank" href=3D"http://www.lm-sensors.org/wiki/=
man/sensors.conf">http://www.lm-sensors.org/wiki/man/sensors.conf</a><br><b=
r>You should also have one already (maybe in /etc/sensors.conf) and<br>read=
ing it is very helpful.<br><br><span style=3D"font-weight: bold;">yes, I ha=
ve a /etc/sensors.conf with an entry for w83627dhg-isa-*, but not coretemp-=
isa-*</span><br><br>&gt;&nbsp;&nbsp;The cpu cores are really in the high 30=
's, cpu&nbsp;&nbsp;&amp; case fans are not<br>&gt; present, ....<br><br>I'm=
 looking at the IP32 pro manual, page 11, and I see six fans<br>(CPUfan1, S=
YSfan1, AUXfan1-4). The w83627dhg only reads the RPM from 5<br>fans, which
 makes me wonder if your southbridge (possibly an Intel<br>ICH9) is control=
ling one fan. Do you have zero fans connected? Or just<br>one (a CPU fan?).=
 Page 22 of the manual mentions "abit's exclusive<br>Guru Panel." Do you ha=
ve a uguru on the motherboard? (I'm not really<br>familiar with abit's ugur=
u, but there are some other people here on<br>lm-sensors who know a lot mor=
e about it.)<br><br><span style=3D"font-weight: bold;">I have a cpu fan, an=
d case fan in their labeled position.&nbsp;&nbsp; I will be adding a memory=
 cooler fan later in the aux1 fan position.&nbsp; all other positions are e=
mpty.&nbsp; No uguru as uguru is&nbsp; a windows app.</span><br><br>The sen=
sors.conf file we figure out here, for the sake of all IP32 pro<br>users, s=
hould probably not disable the fan input readings and alarms.<br>But if you=
 want, you can set "ignore" statements for all the fans, so<br>they don't s=
how up in the sensors output, since you don't have fans<br>connected
 to the motherboard.<br><br>&gt;&nbsp;&nbsp;[jscott@vserv ~]$ sensors<br>&g=
t;&nbsp;&nbsp;w83627dhg-isa-0290<br>&gt;&nbsp;&nbsp;Adapter: ISA adapter<br=
><br>OK, the above lines are fine.<br><br>&gt;&nbsp;&nbsp;VCore:&nbsp;&nbsp=
;&nbsp;&nbsp; +1.46 V&nbsp;&nbsp;(min =3D&nbsp;&nbsp;+1.03 V, max =3D&nbsp;=
&nbsp;+1.74 V)<br>&gt;&nbsp;&nbsp;in1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
+8.76 V&nbsp;&nbsp;(min =3D +11.30 V, max =3D&nbsp;&nbsp;+2.80 V) ALARM<br>=
&gt;&nbsp;&nbsp;AVCC:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;+3.20 V&nbsp;&nbsp=
;(min =3D&nbsp;&nbsp;+2.06 V, max =3D&nbsp;&nbsp;+0.88 V) ALARM<br>&gt;&nbs=
p;&nbsp;3VCC:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;+3.20 V&nbsp;&nbsp;(min =
=3D&nbsp;&nbsp;+1.87 V, max =3D&nbsp;&nbsp;+0.58 V) ALARM<br>&gt;&nbsp;&nbs=
p;in4:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +1.48 V&nbsp;&nbsp;(min =3D&nbsp=
;&nbsp;+0.34 V, max =3D&nbsp;&nbsp;+1.20 V) ALARM<br>&gt;&nbsp;&nbsp;in5:&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +1.34 V&nbsp;&nbsp;(min =3D&nbsp;&nbsp;+=
1.03 V, max
 =3D&nbsp;&nbsp;+1.03 V) ALARM<br>&gt;&nbsp;&nbsp;in6:&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; +4.28 V&nbsp;&nbsp;(min =3D&nbsp;&nbsp;+5.99 V, max =3D&nbs=
p;&nbsp;+3.30 V) ALARM<br>&gt;&nbsp;&nbsp;VSB:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; +3.10 V&nbsp;&nbsp;(min =3D&nbsp;&nbsp;+3.47 V, max =3D&nbsp;&nbsp;=
+2.02 V) ALARM<br>&gt;&nbsp;&nbsp;VBAT:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
+0.51 V&nbsp;&nbsp;(min =3D&nbsp;&nbsp;+0.99 V, max =3D&nbsp;&nbsp;+2.06 V)=
 ALARM<br><br>It would be really helpful to match these voltages against vo=
ltages in<br>your BIOS. Also, try to find information on what the min and m=
ax for<br>each should be. The most important ones, of course, are VCore, 3V=
CC,<br>VBAT, and 12V (which I don't see there).<br><br><span style=3D"font-=
weight: bold;">I will get those data points later tonight when I get home.&=
nbsp; I remember VCore being 1.33V though.</span><br><br>This means that th=
e voltages are not being calculated correctly. This<br>isn't a surprise. Th=
e
 w83627dhg chip reads voltages, but each<br>motherboard is wired differentl=
y, so the voltage arriving at the 'dhg<br>pins is never the same.<br><br>&g=
t;&nbsp;&nbsp;Case Fan:&nbsp;&nbsp;&nbsp;&nbsp;0 RPM&nbsp;&nbsp;(min =3D 10=
546 RPM, div =3D 128) ALARM<br>&gt;&nbsp;&nbsp;CPU Fan:&nbsp;&nbsp;&nbsp;&n=
bsp; 0 RPM&nbsp;&nbsp;(min =3D 10546 RPM, div =3D 128) ALARM<br>&gt;&nbsp;&=
nbsp;Aux Fan:&nbsp;&nbsp;&nbsp;&nbsp; 0 RPM&nbsp;&nbsp;(min =3D 10546 RPM, =
div =3D 128) ALARM<br>&gt;&nbsp;&nbsp;fan4:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;0 RPM&nbsp;&nbsp;(min =3D&nbsp;&nbsp;439 RPM, div =3D 128) =
ALARM<br>&gt;&nbsp;&nbsp;fan5:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;0 RPM&nbsp;&nbsp;(min =3D&nbsp;&nbsp; 81 RPM, div =3D 128) ALARM<br><br>=
So it looks like nothing's connected to your fans. We'll just leave<br>them=
 there for now.<br><br><span style=3D"font-weight: bold;">CPU fan is a 100m=
m and case fan is a 80mm fan.</span><br><br>&gt;&nbsp;&nbsp;Sys
 Temp:&nbsp;&nbsp;&nbsp;&nbsp;+21=B0C&nbsp;&nbsp;(high =3D&nbsp;&nbsp; +58=
=B0C, hyst =3D&nbsp;&nbsp; +78=B0C)<br>&gt;&nbsp;&nbsp;CPU Temp:&nbsp;&nbsp=
;+30.0=B0C&nbsp;&nbsp;(high =3D -126.0=B0C, hyst =3D +75.5=B0C)<br>&gt;&nbs=
p;&nbsp;AUX Temp:&nbsp;&nbsp;-23.0=B0C&nbsp;&nbsp;(high =3D +80.0=B0C, hyst=
 =3D +75.0=B0C)<br><br>The temps don't look right. I think coretemp is repo=
rting the right<br>temperature, and sensors.conf will need to scale the tem=
ps it gets<br>(which are just voltages) to match coretemp.<br><br>&gt;&nbsp=
;&nbsp;coretemp-isa-0000<br>&gt;&nbsp;&nbsp;Adapter: ISA adapter<br>&gt;&nb=
sp;&nbsp;Core 0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;+54=B0C&nbsp;&nbsp;(hig=
h =3D&nbsp;&nbsp;+100=B0C)<br>&gt;<br>&gt;&nbsp;&nbsp;coretemp-isa-0001<br>=
&gt;&nbsp;&nbsp;Adapter: ISA adapter<br>&gt;&nbsp;&nbsp;Core 1:&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;+51=B0C&nbsp;&nbsp;(high =3D&nbsp;&nbsp;+100=B0C)<b=
r>&gt;<br>&gt;&nbsp;&nbsp;coretemp-isa-0002<br>&gt;&nbsp;&nbsp;Adapter: ISA
 adapter<br>&gt;&nbsp;&nbsp;Core 2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;+49=
=B0C&nbsp;&nbsp;(high =3D&nbsp;&nbsp;+100=B0C)<br>&gt;<br>&gt;&nbsp;&nbsp;c=
oretemp-isa-0003<br>&gt;&nbsp;&nbsp;Adapter: ISA adapter<br>&gt;&nbsp;&nbsp=
;Core 3:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;+52=B0C&nbsp;&nbsp;(high =3D&nb=
sp;&nbsp;+100=B0C)<br>&gt;<br>&gt;&nbsp;&nbsp;[jscott@vserv ~]$<br>&gt;<br>=
&gt;<br>&gt;<br>&gt;&nbsp;&nbsp;[jscott@vserv ~]$ cat /etc/sysconfig/lm_sen=
sors<br>&gt;&nbsp;&nbsp;...<br>&gt;&nbsp;&nbsp;#<br>&gt;&nbsp;&nbsp;# Gener=
ated by sensors-detect on Fri Oct 19 00:26:53 2007<br>&gt;&nbsp;&nbsp;MODUL=
E_0=3Dw83627ehf<br>&gt;&nbsp;&nbsp;MODULE_1=3Dcoretemp<br>&gt;&nbsp;&nbsp;[=
jscott@vserv ~]$<br><br>Well, that's a start. Please reply with information=
 about what chips<br>you have (you can run 'lspci -n' for that) and look at=
 your BIOS setup<br>screen for voltages and temperatures. The numbers repor=
ted by BIOS<br>will be the most accurate. We'll try to match those numbers
 in<br>sensors.<br><br>HTH,<br>David<br><br>Ok, thanks.<br><br>I will post =
the bios temps, speeds, and voltage values, along with my sensors.conf file=
.&nbsp; I should mention I am planning to use gkrellm; but I need sensors t=
o read right before adjusting it.&nbsp; Question: As I think about the list=
 of ports 'in1, in2, etc' that are contained in the sensors.conf file.&nbsp=
; How do I determine all the ports available as a starting template - is th=
eir a tool that can enum what's available from the chip? before I verify th=
at the correct labels and computes are applied?&nbsp; <br><br>James,<br></d=
iv></div><br></div></div></body></html>
--0-1725034136-1192819803=:85449--


--===============7479440379170303782==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7479440379170303782==--
