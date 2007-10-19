From: JAMES SCOTT <skoona@verizon.net>
Date: Fri, 19 Oct 2007 19:25:24 +0000
Subject: Re: [lm-sensors] ABIT IP35 Pro mainboard wrong values from 'sensors'
Message-Id: <102258.59280.qm@web84105.mail.mud.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6831958483429244181=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1192816904.8203.11.camel@homedev.skoona.net>
In-Reply-To: <1192816904.8203.11.camel@homedev.skoona.net>
To: lm-sensors@vger.kernel.org

--===============6831958483429244181==
Content-Type: multipart/alternative; boundary="0-1085944855-1192821924=:59280"

--0-1085944855-1192821924=:59280
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hans,=0A=0AI got your mail - we were a little out of sync.   Around 7:00pm =
EDT I should have completed your suggestions - with great expectations I mi=
ght add.=0A=0AThanks,=0A=0AJames,=0ANote: I saw the patch messages too.  I =
may try both if needed.  I don't have DDR3 memory, so I'm thinking I may no=
t benefit from the patch - but I have it if needed.=0A=0A----- Original Mes=
sage ----=0AFrom: Hans de Goede <j.w.r.degoede@hhs.nl>=0ATo: JAMES SCOTT <s=
koona@verizon.net>=0ACc: David Hubbard <david.c.hubbard@gmail.com>; lm-sens=
ors@lm-sensors.org=0ASent: Friday, October 19, 2007 2:54:16 PM=0ASubject: R=
e: [lm-sensors] ABIT IP35 Pro mainboard wrong values from 'sensors'=0A=0AJa=
mes,=0A=0ADidn't you get my mail? I really believe you are on a dead trail =
here and that =0Ayour efforts will be in vane. Repeating myself:=0A=0AAbit =
usually does not use the sensors of the super io chip (which the w83627dhg =
=0Ais), instead they use their own solution called uguru. There is a driver=
 for =0Athis, but the uguru isn't detected by sensors-detect.=0A=0ATry modp=
robe abituguru3, and then try running sensors again.=0A=0AThe abituguru3 dr=
iver is only available in kernel 2.6.23 and higher, to install =0Athis kern=
el for F-7 do:=0Ayum update --enable-repo=3Dupdates-testing kernel=0A=0AAft=
er rebooting into the new kernel do=0Amodprobe abituguru3=0Asensors=0A=0A=
=0ARegards,=0A=0AHans (the author of the abituguru and abituguru3 drivers)=
=0A=0A=0A=0A=0AJAMES SCOTT wrote:=0A> See inline comments=0A> =0A> ----- Or=
iginal Message ----=0A> From: David Hubbard <david.c.hubbard@gmail.com>=0A>=
 To: James Scott Jr <skoona@verizon.net>; lm-sensors@lm-sensors.org=0A> Sen=
t: Friday, October 19, 2007 2:34:54 PM=0A> Subject: Re: [lm-sensors] ABIT I=
P35 Pro mainboard wrong values from 'sensors'=0A> =0A> Hi James,=0A> =0A>> =
 I have a system with an Intel Q6600 quad core on a ABit IP35 Pro mainboard=
,=0A>> using Fedora 7 x64, and lm_sensors-2.10.4-1.fc7.  The output from se=
nsors is=0A>> wrong.  Is there a preformatted config file for these mainboa=
rd somewhere=0A>> that I can find?  Or can you give me a hit on what I need=
 to know in order=0A>> to create/adjust one?=0A> =0A> I think you'll need t=
o create one. I haven't seen any emails on the=0A> lm-sensors list about yo=
ur motherboard.=0A> =0A> Creating a new config file isn't too hard. Look at=
 the man page for=0A> sensors.conf: http://www.lm-sensors.org/wiki/man/sens=
ors.conf=0A> =0A> You should also have one already (maybe in /etc/sensors.c=
onf) and=0A> reading it is very helpful.=0A> =0A> yes, I have a /etc/sensor=
s.conf with an entry for w83627dhg-isa-*, but not coretemp-isa-*=0A> =0A>> =
 The cpu cores are really in the high 30's, cpu  & case fans are not=0A>> p=
resent, ....=0A> =0A> I'm looking at the IP32 pro manual, page 11, and I se=
e six fans=0A> (CPUfan1, SYSfan1, AUXfan1-4). The w83627dhg only reads the =
RPM from 5=0A> fans, which makes me wonder if your southbridge (possibly an=
 Intel=0A> ICH9) is controlling one fan. Do you have zero fans connected? O=
r just=0A> one (a CPU fan?). Page 22 of the manual mentions "abit's exclusi=
ve=0A> Guru Panel." Do you have a uguru on the motherboard? (I'm not really=
=0A> familiar with abit's uguru, but there are some other people here on=0A=
> lm-sensors who know a lot more about it.)=0A> =0A> I have a cpu fan, and =
case fan in their labeled position.   I will be adding a memory cooler fan =
later in the aux1 fan position.  all other positions are empty.  No uguru a=
s uguru is  a windows app.=0A> =0A> The sensors.conf file we figure out her=
e, for the sake of all IP32 pro=0A> users, should probably not disable the =
fan input readings and alarms.=0A> But if you want, you can set "ignore" st=
atements for all the fans, so=0A> they don't show up in the sensors output,=
 since you don't have fans=0A> connected to the motherboard.=0A> =0A>>  [js=
cott@vserv ~]$ sensors=0A>>  w83627dhg-isa-0290=0A>>  Adapter: ISA adapter=
=0A> =0A> OK, the above lines are fine.=0A> =0A>>  VCore:     +1.46 V  (min=
 =3D  +1.03 V, max =3D  +1.74 V)=0A>>  in1:       +8.76 V  (min =3D +11.30 =
V, max =3D  +2.80 V) ALARM=0A>>  AVCC:      +3.20 V  (min =3D  +2.06 V, max=
 =3D  +0.88 V) ALARM=0A>>  3VCC:      +3.20 V  (min =3D  +1.87 V, max =3D  =
+0.58 V) ALARM=0A>>  in4:       +1.48 V  (min =3D  +0.34 V, max =3D  +1.20 =
V) ALARM=0A>>  in5:       +1.34 V  (min =3D  +1.03 V, max =3D  +1.03 V) ALA=
RM=0A>>  in6:       +4.28 V  (min =3D  +5.99 V, max =3D  +3.30 V) ALARM=0A>=
>  VSB:       +3.10 V  (min =3D  +3.47 V, max =3D  +2.02 V) ALARM=0A>>  VBA=
T:      +0.51 V  (min =3D  +0.99 V, max =3D  +2.06 V) ALARM=0A> =0A> It wou=
ld be really helpful to match these voltages against voltages in=0A> your B=
IOS. Also, try to find information on what the min and max for=0A> each sho=
uld be. The most important ones, of course, are VCore, 3VCC,=0A> VBAT, and =
12V (which I don't see there).=0A> =0A> I will get those data points later =
tonight when I get home.  I remember VCore being 1.33V though.=0A> =0A> Thi=
s means that the voltages are not being calculated correctly. This=0A> isn'=
t a surprise. The w83627dhg chip reads voltages, but each=0A> motherboard i=
s wired differently, so the voltage arriving at the 'dhg=0A> pins is never =
the same.=0A> =0A>>  Case Fan:    0 RPM  (min =3D 10546 RPM, div =3D 128) A=
LARM=0A>>  CPU Fan:     0 RPM  (min =3D 10546 RPM, div =3D 128) ALARM=0A>> =
 Aux Fan:     0 RPM  (min =3D 10546 RPM, div =3D 128) ALARM=0A>>  fan4:    =
    0 RPM  (min =3D  439 RPM, div =3D 128) ALARM=0A>>  fan5:        0 RPM  =
(min =3D   81 RPM, div =3D 128) ALARM=0A> =0A> So it looks like nothing's c=
onnected to your fans. We'll just leave=0A> them there for now.=0A> =0A> CP=
U fan is a 100mm and case fan is a 80mm fan.=0A> =0A>>  Sys Temp:    +21=B0=
C  (high =3D   +58=B0C, hyst =3D   +78=B0C)=0A>>  CPU Temp:  +30.0=B0C  (hi=
gh =3D -126.0=B0C, hyst =3D +75.5=B0C)=0A>>  AUX Temp:  -23.0=B0C  (high =
=3D +80.0=B0C, hyst =3D +75.0=B0C)=0A> =0A> The temps don't look right. I t=
hink coretemp is reporting the right=0A> temperature, and sensors.conf will=
 need to scale the temps it gets=0A> (which are just voltages) to match cor=
etemp.=0A> =0A>>  coretemp-isa-0000=0A>>  Adapter: ISA adapter=0A>>  Core 0=
:      +54=B0C  (high =3D  +100=B0C)=0A>>=0A>>  coretemp-isa-0001=0A>>  Ada=
pter: ISA adapter=0A>>  Core 1:      +51=B0C  (high =3D  +100=B0C)=0A>>=0A>=
>  coretemp-isa-0002=0A>>  Adapter: ISA adapter=0A>>  Core 2:      +49=B0C =
 (high =3D  +100=B0C)=0A>>=0A>>  coretemp-isa-0003=0A>>  Adapter: ISA adapt=
er=0A>>  Core 3:      +52=B0C  (high =3D  +100=B0C)=0A>>=0A>>  [jscott@vser=
v ~]$=0A>>=0A>>=0A>>=0A>>  [jscott@vserv ~]$ cat /etc/sysconfig/lm_sensors=
=0A>>  ...=0A>>  #=0A>>  # Generated by sensors-detect on Fri Oct 19 00:26:=
53 2007=0A>>  MODULE_0=3Dw83627ehf=0A>>  MODULE_1=3Dcoretemp=0A>>  [jscott@=
vserv ~]$=0A> =0A> Well, that's a start. Please reply with information abou=
t what chips=0A> you have (you can run 'lspci -n' for that) and look at you=
r BIOS setup=0A> screen for voltages and temperatures. The numbers reported=
 by BIOS=0A> will be the most accurate. We'll try to match those numbers in=
=0A> sensors.=0A> =0A> HTH,=0A> David=0A> =0A> Ok, thanks.=0A> =0A> I will =
post the bios temps, speeds, and voltage values, along with my sensors.conf=
 file.  I should mention I am planning to use gkrellm; but I need sensors t=
o read right before adjusting it.  Question: As I think about the list of p=
orts 'in1, in2, etc' that are contained in the sensors.conf file.  How do I=
 determine all the ports available as a starting template - is their a tool=
 that can enum what's available from the chip? before I verify that the cor=
rect labels and computes are applied?  =0A> =0A> James,=0A> =0A> =0A> =0A> =
=0A> =0A> =0A> =0A> -------------------------------------------------------=
-----------------=0A> =0A> _______________________________________________=
=0A> lm-sensors mailing list=0A> lm-sensors@lm-sensors.org=0A> http://lists=
.lm-sensors.org/mailman/listinfo/lm-sensors=0A=0A=0A=0A=0A=0A
--0-1085944855-1192821924=:59280
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:10pt"><div style=3D"font-family: times new roman,new york,times,s=
erif; font-size: 10pt;">Hans,<br><br>I got your mail - we were a little out=
 of sync.&nbsp;&nbsp; Around 7:00pm EDT I should have completed your sugges=
tions - with great expectations I might add.<br><br>Thanks,<br><br>James,<b=
r>Note: I saw the patch messages too.&nbsp; I may try both if needed.&nbsp;=
 I don't have DDR3 memory, so I'm thinking I may not benefit from the patch=
 - but I have it if needed.<br><br><div style=3D"font-family: times new rom=
an,new york,times,serif; font-size: 12pt;">----- Original Message ----<br>F=
rom: Hans de Goede &lt;j.w.r.degoede@hhs.nl&gt;<br>To: JAMES SCOTT &lt;skoo=
na@verizon.net&gt;<br>Cc: David Hubbard &lt;david.c.hubbard@gmail.com&gt;; =
lm-sensors@lm-sensors.org<br>Sent: Friday, October 19, 2007 2:54:16
 PM<br>Subject: Re: [lm-sensors] ABIT IP35 Pro mainboard wrong values from =
'sensors'<br><br><div>James,<br><br>Didn't you get my mail? I really believ=
e you are on a dead trail here and that <br>your efforts will be in vane. R=
epeating myself:<br><br>Abit usually does not use the sensors of the super =
io chip (which the w83627dhg <br>is), instead they use their own solution c=
alled uguru. There is a driver for <br>this, but the uguru isn't detected b=
y sensors-detect.<br><br>Try modprobe abituguru3, and then try running sens=
ors again.<br><br>The abituguru3 driver is only available in kernel 2.6.23 =
and higher, to install <br>this kernel for F-7 do:<br>yum update --enable-r=
epo=3Dupdates-testing kernel<br><br>After rebooting into the new kernel do<=
br>modprobe abituguru3<br>sensors<br><br><br>Regards,<br><br>Hans (the auth=
or of the abituguru and abituguru3 drivers)<br><br><br><br><br>JAMES SCOTT =
wrote:<br>&gt; See inline comments<br>&gt; <br>&gt; ----- Original
 Message ----<br>&gt; From: David Hubbard &lt;david.c.hubbard@gmail.com&gt;=
<br>&gt; To: James Scott Jr &lt;skoona@verizon.net&gt;; lm-sensors@lm-senso=
rs.org<br>&gt; Sent: Friday, October 19, 2007 2:34:54 PM<br>&gt; Subject: R=
e: [lm-sensors] ABIT IP35 Pro mainboard wrong values from 'sensors'<br>&gt;=
 <br>&gt; Hi James,<br>&gt; <br>&gt;&gt;&nbsp;&nbsp;I have a system with an=
 Intel Q6600 quad core on a ABit IP35 Pro mainboard,<br>&gt;&gt; using Fedo=
ra 7 x64, and lm_sensors-2.10.4-1.fc7.&nbsp;&nbsp;The output from sensors i=
s<br>&gt;&gt; wrong.&nbsp;&nbsp;Is there a preformatted config file for the=
se mainboard somewhere<br>&gt;&gt; that I can find?&nbsp;&nbsp;Or can you g=
ive me a hit on what I need to know in order<br>&gt;&gt; to create/adjust o=
ne?<br>&gt; <br>&gt; I think you'll need to create one. I haven't seen any =
emails on the<br>&gt; lm-sensors list about your motherboard.<br>&gt; <br>&=
gt; Creating a new config file isn't too hard. Look at the man page
 for<br>&gt; sensors.conf: <a target=3D"_blank" href=3D"http://www.lm-senso=
rs.org/wiki/man/sensors.conf">http://www.lm-sensors.org/wiki/man/sensors.co=
nf</a><br>&gt; <br>&gt; You should also have one already (maybe in /etc/sen=
sors.conf) and<br>&gt; reading it is very helpful.<br>&gt; <br>&gt; yes, I =
have a /etc/sensors.conf with an entry for w83627dhg-isa-*, but not coretem=
p-isa-*<br>&gt; <br>&gt;&gt;&nbsp;&nbsp;The cpu cores are really in the hig=
h 30's, cpu&nbsp;&nbsp;&amp; case fans are not<br>&gt;&gt; present, ....<br=
>&gt; <br>&gt; I'm looking at the IP32 pro manual, page 11, and I see six f=
ans<br>&gt; (CPUfan1, SYSfan1, AUXfan1-4). The w83627dhg only reads the RPM=
 from 5<br>&gt; fans, which makes me wonder if your southbridge (possibly a=
n Intel<br>&gt; ICH9) is controlling one fan. Do you have zero fans connect=
ed? Or just<br>&gt; one (a CPU fan?). Page 22 of the manual mentions "abit'=
s exclusive<br>&gt; Guru Panel." Do you have a uguru on the motherboard?
 (I'm not really<br>&gt; familiar with abit's uguru, but there are some oth=
er people here on<br>&gt; lm-sensors who know a lot more about it.)<br>&gt;=
 <br>&gt; I have a cpu fan, and case fan in their labeled position.&nbsp;&n=
bsp; I will be adding a memory cooler fan later in the aux1 fan position.&n=
bsp;&nbsp;all other positions are empty.&nbsp;&nbsp;No uguru as uguru is&nb=
sp;&nbsp;a windows app.<br>&gt; <br>&gt; The sensors.conf file we figure ou=
t here, for the sake of all IP32 pro<br>&gt; users, should probably not dis=
able the fan input readings and alarms.<br>&gt; But if you want, you can se=
t "ignore" statements for all the fans, so<br>&gt; they don't show up in th=
e sensors output, since you don't have fans<br>&gt; connected to the mother=
board.<br>&gt; <br>&gt;&gt;&nbsp;&nbsp;[jscott@vserv ~]$ sensors<br>&gt;&gt=
;&nbsp;&nbsp;w83627dhg-isa-0290<br>&gt;&gt;&nbsp;&nbsp;Adapter: ISA adapter=
<br>&gt; <br>&gt; OK, the above lines are fine.<br>&gt;
 <br>&gt;&gt;&nbsp;&nbsp;VCore:&nbsp;&nbsp;&nbsp;&nbsp; +1.46 V&nbsp;&nbsp;=
(min =3D&nbsp;&nbsp;+1.03 V, max =3D&nbsp;&nbsp;+1.74 V)<br>&gt;&gt;&nbsp;&=
nbsp;in1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +8.76 V&nbsp;&nbsp;(min =3D +=
11.30 V, max =3D&nbsp;&nbsp;+2.80 V) ALARM<br>&gt;&gt;&nbsp;&nbsp;AVCC:&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;+3.20 V&nbsp;&nbsp;(min =3D&nbsp;&nbsp;+2.0=
6 V, max =3D&nbsp;&nbsp;+0.88 V) ALARM<br>&gt;&gt;&nbsp;&nbsp;3VCC:&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;+3.20 V&nbsp;&nbsp;(min =3D&nbsp;&nbsp;+1.87 V,=
 max =3D&nbsp;&nbsp;+0.58 V) ALARM<br>&gt;&gt;&nbsp;&nbsp;in4:&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; +1.48 V&nbsp;&nbsp;(min =3D&nbsp;&nbsp;+0.34 V, max=
 =3D&nbsp;&nbsp;+1.20 V) ALARM<br>&gt;&gt;&nbsp;&nbsp;in5:&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; +1.34 V&nbsp;&nbsp;(min =3D&nbsp;&nbsp;+1.03 V, max =3D=
&nbsp;&nbsp;+1.03 V) ALARM<br>&gt;&gt;&nbsp;&nbsp;in6:&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; +4.28 V&nbsp;&nbsp;(min =3D&nbsp;&nbsp;+5.99 V, max =3D&nbs=
p;&nbsp;+3.30 V)
 ALARM<br>&gt;&gt;&nbsp;&nbsp;VSB:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +3.1=
0 V&nbsp;&nbsp;(min =3D&nbsp;&nbsp;+3.47 V, max =3D&nbsp;&nbsp;+2.02 V) ALA=
RM<br>&gt;&gt;&nbsp;&nbsp;VBAT:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;+0.51 V&=
nbsp;&nbsp;(min =3D&nbsp;&nbsp;+0.99 V, max =3D&nbsp;&nbsp;+2.06 V) ALARM<b=
r>&gt; <br>&gt; It would be really helpful to match these voltages against =
voltages in<br>&gt; your BIOS. Also, try to find information on what the mi=
n and max for<br>&gt; each should be. The most important ones, of course, a=
re VCore, 3VCC,<br>&gt; VBAT, and 12V (which I don't see there).<br>&gt; <b=
r>&gt; I will get those data points later tonight when I get home.&nbsp;&nb=
sp;I remember VCore being 1.33V though.<br>&gt; <br>&gt; This means that th=
e voltages are not being calculated correctly. This<br>&gt; isn't a surpris=
e. The w83627dhg chip reads voltages, but each<br>&gt; motherboard is wired=
 differently, so the voltage arriving at the 'dhg<br>&gt; pins is never the
 same.<br>&gt; <br>&gt;&gt;&nbsp;&nbsp;Case Fan:&nbsp;&nbsp;&nbsp;&nbsp;0 R=
PM&nbsp;&nbsp;(min =3D 10546 RPM, div =3D 128) ALARM<br>&gt;&gt;&nbsp;&nbsp=
;CPU Fan:&nbsp;&nbsp;&nbsp;&nbsp; 0 RPM&nbsp;&nbsp;(min =3D 10546 RPM, div =
=3D 128) ALARM<br>&gt;&gt;&nbsp;&nbsp;Aux Fan:&nbsp;&nbsp;&nbsp;&nbsp; 0 RP=
M&nbsp;&nbsp;(min =3D 10546 RPM, div =3D 128) ALARM<br>&gt;&gt;&nbsp;&nbsp;=
fan4:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0 RPM&nbsp;&nbsp;(min =
=3D&nbsp;&nbsp;439 RPM, div =3D 128) ALARM<br>&gt;&gt;&nbsp;&nbsp;fan5:&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0 RPM&nbsp;&nbsp;(min =3D&nbsp;=
&nbsp; 81 RPM, div =3D 128) ALARM<br>&gt; <br>&gt; So it looks like nothing=
's connected to your fans. We'll just leave<br>&gt; them there for now.<br>=
&gt; <br>&gt; CPU fan is a 100mm and case fan is a 80mm fan.<br>&gt; <br>&g=
t;&gt;&nbsp;&nbsp;Sys Temp:&nbsp;&nbsp;&nbsp;&nbsp;+21=B0C&nbsp;&nbsp;(high=
 =3D&nbsp;&nbsp; +58=B0C, hyst =3D&nbsp;&nbsp; +78=B0C)<br>&gt;&gt;&nbsp;&n=
bsp;CPU
 Temp:&nbsp;&nbsp;+30.0=B0C&nbsp;&nbsp;(high =3D -126.0=B0C, hyst =3D +75.5=
=B0C)<br>&gt;&gt;&nbsp;&nbsp;AUX Temp:&nbsp;&nbsp;-23.0=B0C&nbsp;&nbsp;(hig=
h =3D +80.0=B0C, hyst =3D +75.0=B0C)<br>&gt; <br>&gt; The temps don't look =
right. I think coretemp is reporting the right<br>&gt; temperature, and sen=
sors.conf will need to scale the temps it gets<br>&gt; (which are just volt=
ages) to match coretemp.<br>&gt; <br>&gt;&gt;&nbsp;&nbsp;coretemp-isa-0000<=
br>&gt;&gt;&nbsp;&nbsp;Adapter: ISA adapter<br>&gt;&gt;&nbsp;&nbsp;Core 0:&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;+54=B0C&nbsp;&nbsp;(high =3D&nbsp;&nbsp;=
+100=B0C)<br>&gt;&gt;<br>&gt;&gt;&nbsp;&nbsp;coretemp-isa-0001<br>&gt;&gt;&=
nbsp;&nbsp;Adapter: ISA adapter<br>&gt;&gt;&nbsp;&nbsp;Core 1:&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;+51=B0C&nbsp;&nbsp;(high =3D&nbsp;&nbsp;+100=B0C)<br=
>&gt;&gt;<br>&gt;&gt;&nbsp;&nbsp;coretemp-isa-0002<br>&gt;&gt;&nbsp;&nbsp;A=
dapter: ISA adapter<br>&gt;&gt;&nbsp;&nbsp;Core
 2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;+49=B0C&nbsp;&nbsp;(high =3D&nbsp;&n=
bsp;+100=B0C)<br>&gt;&gt;<br>&gt;&gt;&nbsp;&nbsp;coretemp-isa-0003<br>&gt;&=
gt;&nbsp;&nbsp;Adapter: ISA adapter<br>&gt;&gt;&nbsp;&nbsp;Core 3:&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;+52=B0C&nbsp;&nbsp;(high =3D&nbsp;&nbsp;+100=B0C=
)<br>&gt;&gt;<br>&gt;&gt;&nbsp;&nbsp;[jscott@vserv ~]$<br>&gt;&gt;<br>&gt;&=
gt;<br>&gt;&gt;<br>&gt;&gt;&nbsp;&nbsp;[jscott@vserv ~]$ cat /etc/sysconfig=
/lm_sensors<br>&gt;&gt;&nbsp;&nbsp;...<br>&gt;&gt;&nbsp;&nbsp;#<br>&gt;&gt;=
&nbsp;&nbsp;# Generated by sensors-detect on Fri Oct 19 00:26:53 2007<br>&g=
t;&gt;&nbsp;&nbsp;MODULE_0=3Dw83627ehf<br>&gt;&gt;&nbsp;&nbsp;MODULE_1=3Dco=
retemp<br>&gt;&gt;&nbsp;&nbsp;[jscott@vserv ~]$<br>&gt; <br>&gt; Well, that=
's a start. Please reply with information about what chips<br>&gt; you have=
 (you can run 'lspci -n' for that) and look at your BIOS setup<br>&gt; scre=
en for voltages and temperatures. The numbers reported by BIOS<br>&gt; will=
 be
 the most accurate. We'll try to match those numbers in<br>&gt; sensors.<br=
>&gt; <br>&gt; HTH,<br>&gt; David<br>&gt; <br>&gt; Ok, thanks.<br>&gt; <br>=
&gt; I will post the bios temps, speeds, and voltage values, along with my =
sensors.conf file.&nbsp;&nbsp;I should mention I am planning to use gkrellm=
; but I need sensors to read right before adjusting it.&nbsp;&nbsp;Question=
: As I think about the list of ports 'in1, in2, etc' that are contained in =
the sensors.conf file.&nbsp;&nbsp;How do I determine all the ports availabl=
e as a starting template - is their a tool that can enum what's available f=
rom the chip? before I verify that the correct labels and computes are appl=
ied?&nbsp;&nbsp;<br>&gt; <br>&gt; James,<br>&gt; <br>&gt; <br>&gt; <br>&gt;=
 <br>&gt; <br>&gt; <br>&gt; <br>&gt; --------------------------------------=
----------------------------------<br>&gt; <br>&gt; _______________________=
________________________<br>&gt; lm-sensors mailing list<br>&gt;
 lm-sensors@lm-sensors.org<br>&gt; <a target=3D"_blank" href=3D"http://list=
s.lm-sensors.org/mailman/listinfo/lm-sensors">http://lists.lm-sensors.org/m=
ailman/listinfo/lm-sensors</a><br><br></div></div><br></div></div></body></=
html>
--0-1085944855-1192821924=:59280--


--===============6831958483429244181==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6831958483429244181==--
