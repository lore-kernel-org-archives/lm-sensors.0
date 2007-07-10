From: Christian Emmerich <christian_emmerich@yahoo.de>
Date: Tue, 10 Jul 2007 19:08:39 +0000
Subject: Re: [lm-sensors] [PATCH] Add f75375s driver
Message-Id: <86964.93262.qm@web25108.mail.ukl.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2352998862216373815=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20070628230725.GA29698@kos.to>
In-Reply-To: <20070628230725.GA29698@kos.to>
To: lm-sensors@vger.kernel.org

--===============2352998862216373815==
Content-Type: multipart/alternative; boundary="0-1793519341-1184094519=:93262"
Content-Transfer-Encoding: 8bit

--0-1793519341-1184094519=:93262
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Riku,

Thanks for your reply & the new version of the driver.

> > OK, this was my fault if i set the value by hand i could also see the
> > value using 'cat temp1_max_hyst' and sensors, i thought there would be
> > an automatic entry i can read out.
> > What does this value exactly stand for, is it usefull for sensors or
> > just a value i can read out using sensors?
>
> It has a default value, 60 degrees, but your bios might overwrite it.
It seems that the bios overwrites it, the value is always zero until i chan=
ge it. If i set it by hand, i can see a value using cat and also using sens=
ors.

> Which reminds me: if you don't mind, please verify that values reported
> by sensors match the ones reported
> by bios. Often bios's come with a screen that shows of hwmon
> information.
I can see following values:
             bios-hwmon             sensors
CPU Temp:       51=B0C                 +50=B0C
SYS Temp:       43=B0C                 +44=B0C
CPU Fan         1800                 1777
SYS Fan           not connected in my pc
VCC:            n.a.                 +1.72 V
V1:             n.a.                 +1.34 V
V2:             n.a.                 +1.01 V
V3:             n.a.                 +0.81 V
Values i can also see in my bios seems to be ok. The voltage values of the =
fintek chip are not shown in the bios. I have a second chip ( w83627hf ), t=
he voltage values of this chip are displayed in the bios.

> > Another problem i forget in my last mail. I don't know what's the
> > reason, but if i do the following:
> > root at pc:/sys/devices/pci0000:00/0000:00:01.1/i2c-1/1-002d# cat fan1_=
min
> > i got following output:
> > <output>
> > root at pc:/sys/devices/pci0000:00/0000:00:01.1/i2c-1/1-002d# cat fan1_=
min
> > Segmentation fault
> > root at pc:/sys/devices/pci0000:00/0000:00:01.1/i2c-1/1-002d#
> Oops. the new REG_TO_RPM code did not take in account if the rpm count
> is zero.. should be fixed with the attached version..
OK, now i can make a cat fan1_min. The value is zero until i set it by hand=
. But if i set it to zero it leads to an segmentation fault again.
<output>
root@pc:/sys/devices/pci0000:00/0000:00:01.1/i2c-1/1-002d# echo 0 > fan1_min
Segmentation fault
mythtv@pc:~$
Message from syslogd@pc at Tue Jul 10 20:44:47 2007 ...
pc kernel: [17190005.040000] divide error: 0000 [#1]

Message from syslogd@pc at Tue Jul 10 20:44:47 2007 ...
pc kernel: [17190005.040000] CPU:    0

Message from syslogd@pc at Tue Jul 10 20:44:47 2007 ...
pc kernel: [17190005.040000] EIP is at set_fan_min+0x4b/0xa0 [f75375s]

Message from syslogd@pc at Tue Jul 10 20:44:47 2007 ...
pc kernel: [17190005.040000] eax: 0016e360   ebx: 00000000   ecx: 00000000 =
  edx: 00000000

Message from syslogd@pc at Tue Jul 10 20:44:47 2007 ...
pc kernel: [17190005.040000] esi: dd9d2e00   edi: 00000000   ebp: dd9d2e04 =
  esp: d927df34

Message from syslogd@pc at Tue Jul 10 20:44:47 2007 ...
pc kernel: [17190005.040000] ds: 007b   es: 007b   ss: 0068

Message from syslogd@pc at Tue Jul 10 20:44:47 2007 ...
pc kernel: [17190005.040000] Process bash (pid: 18265, threadinfo=3Dd927c00=
0 task=3Ddba575c0)

Message from syslogd@pc at Tue Jul 10 20:44:47 2007 ...
pc kernel: [17190005.040000] Stack: dd9d2f94 000280d0 e0b777e0 e0b7a1c0 dd9=
d2e80 00000002 c0228ebd 00000002

Message from syslogd@pc at Tue Jul 10 20:44:47 2007 ...
pc kernel: [17190005.040000]        deead0d4 c0367514 d66401a0 c0195e87 000=
00002 d09356e0 d66401b4 d09356e0

Message from syslogd@pc at Tue Jul 10 20:44:47 2007 ...
pc kernel: [17190005.040000]        080fc808 d927dfa4 00000002 c0158b0e d92=
7dfa4 c0195e00 d09356e0 fffffff7

Message from syslogd@pc at Tue Jul 10 20:44:47 2007 ...
pc kernel: [17190005.040000] Call Trace:

Message from syslogd@pc at Tue Jul 10 20:44:47 2007 ...
pc kernel: [17190005.040000]  <e0b777e0> set_fan_min+0x0/0xa0 [f75375s]  <c=
0228ebd> dev_attr_store+0x2d/0x40

Message from syslogd@pc at Tue Jul 10 20:44:47 2007 ...
pc kernel: [17190005.040000]  <c0195e87> sysfs_write_file+0x87/0xf0  <c0158=
b0e> vfs_write+0xbe/0x190

Message from syslogd@pc at Tue Jul 10 20:44:47 2007 ...
pc kernel: [17190005.040000]  <c0195e00> sysfs_write_file+0x0/0xf0  <c01591=
71> sys_write+0x41/0x70

Message from syslogd@pc at Tue Jul 10 20:44:47 2007 ...
pc kernel: [17190005.040000]  <c0102dbb> sysenter_past_esp+0x54/0x79

Message from syslogd@pc at Tue Jul 10 20:44:47 2007 ...
pc kernel: [17190005.040000] Code: 7a 14 31 d2 8b b5 f8 00 00 00 e8 01 40 6=
5 df 89 c3 8d 86 94 01 00 00 89 04 24 e8 01 ea 74 df ba 60 e3 16 00 31 c9 8=
9 d0 c1 fa 1f <f7> fb 8d 5c 3f 2c 0f b6 d3 66 89 44 24 06 66 89 84 7e bc 01=
 00

Message from syslogd@pc at Tue Jul 10 20:44:47 2007 ...
pc kernel: [17190005.040000] EIP: [pg0+544229419/1069069312] set_fan_min+0x=
4b/0xa0 [f75375s] SS:ESP 0068:d927df34
</output>

best regards
christian.

      =20
---------------------------------
 Die etwas anderen Infos rund um das Thema Reisen. BE A BETTER WELTENBUMMLE=
R!
--0-1793519341-1184094519=:93262
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<span style=3D"font-family: courier;">Hi Riku,</span><br style=3D"font-fami=
ly: courier;"><br style=3D"font-family: courier;"><span style=3D"font-famil=
y: courier;">Thanks for your reply &amp; the new version of the driver.</sp=
an><br style=3D"font-family: courier;"><br style=3D"font-family: courier;">=
<span style=3D"font-family: courier;">&gt; &gt; OK, this was my fault if i =
set the value by hand i could also see the</span><br style=3D"font-family: =
courier;"><span style=3D"font-family: courier;">&gt; &gt; value using 'cat =
temp1_max_hyst' and sensors, i thought there would be</span><br style=3D"fo=
nt-family: courier;"><span style=3D"font-family: courier;">&gt; &gt; an aut=
omatic entry i can read out.</span><br style=3D"font-family: courier;"><spa=
n style=3D"font-family: courier;">&gt; &gt; What does this value exactly st=
and for, is it usefull for sensors or</span><br style=3D"font-family: couri=
er;"><span style=3D"font-family: courier;">&gt; &gt; just a value i can rea=
d out using sensors?</span><br
 style=3D"font-family: courier;"><span style=3D"font-family: courier;">&gt;=
</span><br style=3D"font-family: courier;"><span style=3D"font-family: cour=
ier;">&gt; It has a default value, 60 degrees, but your bios might overwrit=
e it.</span><br style=3D"font-family: courier;"><span style=3D"font-family:=
 courier;">It seems that the bios overwrites it, the value is always zero u=
ntil i change it. If i set it by hand, i can see a value using cat and also=
 using sensors.</span><br style=3D"font-family: courier;"><br style=3D"font=
-family: courier;"><span style=3D"font-family: courier;">&gt; Which reminds=
 me: if you don't mind, please verify that values reported</span><br style=
=3D"font-family: courier;"><span style=3D"font-family: courier;">&gt; by se=
nsors match the ones reported</span><br style=3D"font-family: courier;"><sp=
an style=3D"font-family: courier;">&gt; by bios. Often bios's come with a s=
creen that shows of hwmon</span><br style=3D"font-family: courier;"><span s=
tyle=3D"font-family: courier;">&gt;
 information.</span><br style=3D"font-family: courier;"><span style=3D"font=
-family: courier;">I can see following values:</span><br style=3D"font-fami=
ly: courier;"><span style=3D"font-family: courier;">&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bios-hwmon&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sensors</span><br=
 style=3D"font-family: courier;"><span style=3D"font-family: courier;">CPU =
Temp:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 51=B0C&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +50=
=B0C</span><br style=3D"font-family: courier;"><span style=3D"font-family: =
courier;">SYS Temp:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 43=B0C&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; +44=B0C</span><br style=3D"font-family: courier;"><span style=3D"f=
ont-family: courier;">CPU Fan&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;
 1800&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; 1777</span><br style=3D"font-family: courier;"><=
span style=3D"font-family: courier;">SYS Fan&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; not connected in my pc</span><br style=3D"fon=
t-family: courier;"><span style=3D"font-family: courier;">VCC:&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; n.a.&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; +1.72 V</span><br style=3D"font-family: courier;"><span style=3D"font-=
family: courier;">V1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; n.a.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +1.34 V</span><br style=3D"fon=
t-family: courier;"><span style=3D"font-family: courier;">V2:&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 n.a.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; +1.01 V</span><br style=3D"font-family: courier;=
"><span style=3D"font-family: courier;">V3:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; n.a.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +0.81 V<=
/span><br style=3D"font-family: courier;"><span style=3D"font-family: couri=
er;">Values i can also see in my bios seems to be ok. The voltage values of=
 the fintek chip are not shown in the bios. I have a second chip ( w83627hf=
 ), the voltage values of this chip are displayed in the bios.</span><br st=
yle=3D"font-family: courier;"><br style=3D"font-family: courier;"><span sty=
le=3D"font-family: courier;">&gt; &gt; Another problem i forget in my last =
mail. I don't know what's the</span><br style=3D"font-family: courier;"><sp=
an style=3D"font-family: courier;">&gt; &gt; reason, but if i do the follow=
ing:</span><br
 style=3D"font-family: courier;"><span style=3D"font-family: courier;">&gt;=
 &gt; root at pc:/sys/devices/pci0000:00/0000:00:01.1/i2c-1/1-002d# cat fan=
1_min</span><br style=3D"font-family: courier;"><span style=3D"font-family:=
 courier;">&gt; &gt; i got following output:</span><br style=3D"font-family=
: courier;"><span style=3D"font-family: courier;">&gt; &gt; &lt;output&gt;<=
/span><br style=3D"font-family: courier;"><span style=3D"font-family: couri=
er;">&gt; &gt; root at pc:/sys/devices/pci0000:00/0000:00:01.1/i2c-1/1-002d=
# cat fan1_min</span><br style=3D"font-family: courier;"><span style=3D"fon=
t-family: courier;">&gt; &gt; Segmentation fault</span><br style=3D"font-fa=
mily: courier;"><span style=3D"font-family: courier;">&gt; &gt; root at pc:=
/sys/devices/pci0000:00/0000:00:01.1/i2c-1/1-002d#</span><br style=3D"font-=
family: courier;"><span style=3D"font-family: courier;">&gt; Oops. the new =
REG_TO_RPM code did not take in account if the rpm count</span><br style=3D=
"font-family: courier;"><span
 style=3D"font-family: courier;">&gt; is zero.. should be fixed with the at=
tached version..</span><br style=3D"font-family: courier;"><span style=3D"f=
ont-family: courier;">OK, now i can make a cat fan1_min. The value is zero =
until i set it by hand. But if i set it to zero it leads to an segmentation=
 fault again.</span><br style=3D"font-family: courier;"><span style=3D"font=
-family: courier;">&lt;output&gt;</span><br style=3D"font-family: courier;"=
><span style=3D"font-family: courier;">root@pc:/sys/devices/pci0000:00/0000=
:00:01.1/i2c-1/1-002d# echo 0 &gt; fan1_min</span><br style=3D"font-family:=
 courier;"><span style=3D"font-family: courier;">Segmentation fault</span><=
br style=3D"font-family: courier;"><span style=3D"font-family: courier;">my=
thtv@pc:~$</span><br style=3D"font-family: courier;"><span style=3D"font-fa=
mily: courier;">Message from syslogd@pc at Tue Jul 10 20:44:47 2007 ...</sp=
an><br style=3D"font-family: courier;"><span style=3D"font-family: courier;=
">pc kernel: [17190005.040000] divide
 error: 0000 [#1]</span><br style=3D"font-family: courier;"><br style=3D"fo=
nt-family: courier;"><span style=3D"font-family: courier;">Message from sys=
logd@pc at Tue Jul 10 20:44:47 2007 ...</span><br style=3D"font-family: cou=
rier;"><span style=3D"font-family: courier;">pc kernel: [17190005.040000] C=
PU:&nbsp;&nbsp;&nbsp; 0</span><br style=3D"font-family: courier;"><br style=
=3D"font-family: courier;"><span style=3D"font-family: courier;">Message fr=
om syslogd@pc at Tue Jul 10 20:44:47 2007 ...</span><br style=3D"font-famil=
y: courier;"><span style=3D"font-family: courier;">pc kernel: [17190005.040=
000] EIP is at set_fan_min+0x4b/0xa0 [f75375s]</span><br style=3D"font-fami=
ly: courier;"><br style=3D"font-family: courier;"><span style=3D"font-famil=
y: courier;">Message from syslogd@pc at Tue Jul 10 20:44:47 2007 ...</span>=
<br style=3D"font-family: courier;"><span style=3D"font-family: courier;">p=
c kernel: [17190005.040000] eax: 0016e360&nbsp;&nbsp; ebx: 00000000&nbsp;&n=
bsp; ecx: 00000000&nbsp;&nbsp; edx:
 00000000</span><br style=3D"font-family: courier;"><br style=3D"font-famil=
y: courier;"><span style=3D"font-family: courier;">Message from syslogd@pc =
at Tue Jul 10 20:44:47 2007 ...</span><br style=3D"font-family: courier;"><=
span style=3D"font-family: courier;">pc kernel: [17190005.040000] esi: dd9d=
2e00&nbsp;&nbsp; edi: 00000000&nbsp;&nbsp; ebp: dd9d2e04&nbsp;&nbsp; esp: d=
927df34</span><br style=3D"font-family: courier;"><br style=3D"font-family:=
 courier;"><span style=3D"font-family: courier;">Message from syslogd@pc at=
 Tue Jul 10 20:44:47 2007 ...</span><br style=3D"font-family: courier;"><sp=
an style=3D"font-family: courier;">pc kernel: [17190005.040000] ds: 007b&nb=
sp;&nbsp; es: 007b&nbsp;&nbsp; ss: 0068</span><br style=3D"font-family: cou=
rier;"><br style=3D"font-family: courier;"><span style=3D"font-family: cour=
ier;">Message from syslogd@pc at Tue Jul 10 20:44:47 2007 ...</span><br sty=
le=3D"font-family: courier;"><span style=3D"font-family: courier;">pc kerne=
l: [17190005.040000] Process bash (pid:
 18265, threadinfo=3Dd927c000 task=3Ddba575c0)</span><br style=3D"font-fami=
ly: courier;"><br style=3D"font-family: courier;"><span style=3D"font-famil=
y: courier;">Message from syslogd@pc at Tue Jul 10 20:44:47 2007 ...</span>=
<br style=3D"font-family: courier;"><span style=3D"font-family: courier;">p=
c kernel: [17190005.040000] Stack: dd9d2f94 000280d0 e0b777e0 e0b7a1c0 dd9d=
2e80 00000002 c0228ebd 00000002</span><br style=3D"font-family: courier;"><=
br style=3D"font-family: courier;"><span style=3D"font-family: courier;">Me=
ssage from syslogd@pc at Tue Jul 10 20:44:47 2007 ...</span><br style=3D"fo=
nt-family: courier;"><span style=3D"font-family: courier;">pc kernel: [1719=
0005.040000]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; deead0d4 c0367514 d6=
6401a0 c0195e87 00000002 d09356e0 d66401b4 d09356e0</span><br style=3D"font=
-family: courier;"><br style=3D"font-family: courier;"><span style=3D"font-=
family: courier;">Message from syslogd@pc at Tue Jul 10 20:44:47 2007 ...</=
span><br style=3D"font-family:
 courier;"><span style=3D"font-family: courier;">pc kernel: [17190005.04000=
0]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 080fc808 d927dfa4 00000002 c01=
58b0e d927dfa4 c0195e00 d09356e0 fffffff7</span><br style=3D"font-family: c=
ourier;"><br style=3D"font-family: courier;"><span style=3D"font-family: co=
urier;">Message from syslogd@pc at Tue Jul 10 20:44:47 2007 ...</span><br s=
tyle=3D"font-family: courier;"><span style=3D"font-family: courier;">pc ker=
nel: [17190005.040000] Call Trace:</span><br style=3D"font-family: courier;=
"><br style=3D"font-family: courier;"><span style=3D"font-family: courier;"=
>Message from syslogd@pc at Tue Jul 10 20:44:47 2007 ...</span><br style=3D=
"font-family: courier;"><span style=3D"font-family: courier;">pc kernel: [1=
7190005.040000]&nbsp; &lt;e0b777e0&gt; set_fan_min+0x0/0xa0 [f75375s]&nbsp;=
 &lt;c0228ebd&gt; dev_attr_store+0x2d/0x40</span><br style=3D"font-family: =
courier;"><br style=3D"font-family: courier;"><span style=3D"font-family: c=
ourier;">Message from syslogd@pc at Tue
 Jul 10 20:44:47 2007 ...</span><br style=3D"font-family: courier;"><span s=
tyle=3D"font-family: courier;">pc kernel: [17190005.040000]&nbsp; &lt;c0195=
e87&gt; sysfs_write_file+0x87/0xf0&nbsp; &lt;c0158b0e&gt; vfs_write+0xbe/0x=
190</span><br style=3D"font-family: courier;"><br style=3D"font-family: cou=
rier;"><span style=3D"font-family: courier;">Message from syslogd@pc at Tue=
 Jul 10 20:44:47 2007 ...</span><br style=3D"font-family: courier;"><span s=
tyle=3D"font-family: courier;">pc kernel: [17190005.040000]&nbsp; &lt;c0195=
e00&gt; sysfs_write_file+0x0/0xf0&nbsp; &lt;c0159171&gt; sys_write+0x41/0x7=
0</span><br style=3D"font-family: courier;"><br style=3D"font-family: couri=
er;"><span style=3D"font-family: courier;">Message from syslogd@pc at Tue J=
ul 10 20:44:47 2007 ...</span><br style=3D"font-family: courier;"><span sty=
le=3D"font-family: courier;">pc kernel: [17190005.040000]&nbsp; &lt;c0102db=
b&gt; sysenter_past_esp+0x54/0x79</span><br style=3D"font-family: courier;"=
><br style=3D"font-family:
 courier;"><span style=3D"font-family: courier;">Message from syslogd@pc at=
 Tue Jul 10 20:44:47 2007 ...</span><br style=3D"font-family: courier;"><sp=
an style=3D"font-family: courier;">pc kernel: [17190005.040000] Code: 7a 14=
 31 d2 8b b5 f8 00 00 00 e8 01 40 65 df 89 c3 8d 86 94 01 00 00 89 04 24 e8=
 01 ea 74 df ba 60 e3 16 00 31 c9 89 d0 c1 fa 1f &lt;f7&gt; fb 8d 5c 3f 2c =
0f b6 d3 66 89 44 24 06 66 89 84 7e bc 01 00</span><br style=3D"font-family=
: courier;"><br style=3D"font-family: courier;"><span style=3D"font-family:=
 courier;">Message from syslogd@pc at Tue Jul 10 20:44:47 2007 ...</span><b=
r style=3D"font-family: courier;"><span style=3D"font-family: courier;">pc =
kernel: [17190005.040000] EIP: [pg0+544229419/1069069312] set_fan_min+0x4b/=
0xa0 [f75375s] SS:ESP 0068:d927df34</span><br style=3D"font-family: courier=
;"><span style=3D"font-family: courier;">&lt;/output&gt;</span><br style=3D=
"font-family: courier;"><br style=3D"font-family: courier;"><span style=3D"=
font-family: courier;">best
 regards</span><br style=3D"font-family: courier;"><span style=3D"font-fami=
ly: courier;">christian.</span><br style=3D"font-family: courier;"><p>&#32;
      <hr size=3D1> Die etwas anderen Infos rund um das Thema Reisen.=20
<a href=3D"http://de.rd.yahoo.com/evt=3D48734/*http://de.promotions.yahoo.c=
om/clever/be-a-better/weltenbummler.html" target=3D_new >
<b>BE A BETTER WELTENBUMMLER!</b></a>
--0-1793519341-1184094519=:93262--


--===============2352998862216373815==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2352998862216373815==--
