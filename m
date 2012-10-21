From: camden lindsay <camden.lindsay+lmsensors@gmail.com>
Date: Sun, 21 Oct 2012 18:18:56 +0000
Subject: [lm-sensors] Asus P7F-X w/ W83667HG-B pwm control problem
Message-Id: <CABkW7JOH6quu8kc56=Qm4+3ewqvtcpo7RsQKyYDyFtLd3_1pkw@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3669927131409472362=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============3669927131409472362==
Content-Type: multipart/alternative; boundary=f46d044630785fabdf04cc95c60b

--f46d044630785fabdf04cc95c60b
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello-
I've had this motherboard since January 2011 had never gotten fan control
to work.  It seems to be either a driver or hardware implementation issue.
 It doesn't appear to have the atk0110 acpi methods of hardware control.
 When i try to echo any numbers into pwm_{1..3} they do not actually write
to the ?file?/?register?

I hadn't looked too deeply into it, so as to understand the ACPI/ATK0110 vs
legacy W83667HG-B  control until recently.  About as far as i had gotten
previously was to read http://www.lm-sensors.org/wiki/AsusFormulaHacking.
Recently started looking further into it for a variety of reasons;  I am
now sure that my board does not have any ATK0110 devices on it:


Details:
Kernel information
Linux BigBox 3.4.9-gentoo #1 SMP Sat Oct 20 21:41:06 PDT 2012 x86_64
Intel(R) Core(TM) i3 CPU 540 @ 3.07GHz GenuineIntel GNU/Linux

Modprobe of atk shows nothing in dmesg
BigBox w83627ehf.656 # modprobe asus-atk0110

dylan@BigBox ~/My_Utils/acpi $ lsmod | grep asus
asus_atk0110            8614  0

BigBox w83627ehf.656 # dmesg | tail -3
[   51.000276] w83627ehf: Found W83667HG-B chip at 0x290
[   57.806564] eth0: no IPv6 routers present
[   69.009033] netlink: 12 bytes leftover after parsing attributes.


dsdt.dsl does not have any of the 'key' atk stuff in it from the above
mentioned webpage:
dylan@BigBox ~/My_Utils/acpi $ grep -i -e asoc -e vbuf -e v500 -e v12v
dsdt.dsl
dylan@BigBox ~/My_Utils/acpi $


I don't have no-apci on my kernel command line, there are no conflicts
listed for acpi in dmesg, and the drivers for the sensor chip load happily
dylan@BigBox ~/My_Utils/acpi $ cat /proc/cmdline
root=3D/dev/md3

dylan@BigBox ~/My_Utils/acpi $ dmesg | grep w83627ehf
[   51.000276] w83627ehf: Found W83667HG-B chip at 0x290
dylan@BigBox ~/My_Utils/acpi $

dylan@BigBox ~/My_Utils/acpi $ dmesg | grep conflict
dylan@BigBox ~/My_Utils/acpi $


dylan@BigBox ~/My_Utils/acpi $ sensors w83667hg-isa-0290
w83667hg-isa-0290
Adapter: ISA adapter
Vcore:         +0.89 V  (min =3D  +0.60 V, max =3D  +1.50 V)
in1:           +1.73 V  (min =3D  +1.50 V, max =3D  +1.88 V)
AVCC:          +3.38 V  (min =3D  +2.98 V, max =3D  +3.63 V)
+3.3V:         +3.38 V  (min =3D  +2.98 V, max =3D  +3.63 V)
in4:           +1.67 V  (min =3D  +1.50 V, max =3D  +1.83 V)
in5:           +1.69 V  (min =3D  +1.76 V, max =3D  +2.04 V)  ALARM
in6:           +1.49 V  (min =3D  +1.34 V, max =3D  +1.65 V)
3VSB:          +3.38 V  (min =3D  +2.98 V, max =3D  +3.63 V)
Vbat:          +3.31 V  (min =3D  +2.70 V, max =3D  +3.30 V)  ALARM
Rear_Fan:     3590 RPM  (min =3D  888 RPM, div =3D 8)
CPU_Fan:      1854 RPM  (min =3D 2678 RPM, div =3D 8)  ALARM
HD_Fan0:      3590 RPM  (min =3D 1298 RPM, div =3D 8)
HD_Fan1:      3668 RPM  (min =3D  865 RPM, div =3D 8)
fan5:            0 RPM  (min =3D 10546 RPM, div =3D 128)  ALARM
PECI Agent 1:   +6.0=B0C  (high =3D +60.0=B0C, hyst =3D +58.0=B0C)  sensor =
=3D Intel
PECI
PECI Agent 1:   +6.0=B0C  (high =3D +89.0=B0C, hyst =3D +88.0=B0C)  sensor =
=3D Intel
PECI
SYSTIN:        +22.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D
thermistor
CPUTIN:        -54.0=B0C
cpu0_vid:     +0.000 V
intrusion0:   OK


In Bios the fans are set to 'no control / full speed' (i've tried in other
modes too)

Now, as root.. i can change the settings in  pwm_enable (following doc for
kernel driver for values)
BigBox w83627ehf.656 # head *_enable
=3D=3D> pwm1_enable <=3D=3D
1
=3D=3D> pwm2_enable <=3D=3D
1
=3D=3D> pwm3_enable <=3D=3D
1
BigBox w83627ehf.656 # for i in $(seq 3); do echo 2 >pwm${i}_enable; done
BigBox w83627ehf.656 # head *_enable
=3D=3D> pwm1_enable <=3D=3D
2
=3D=3D> pwm2_enable <=3D=3D
2
=3D=3D> pwm3_enable <=3D=3D
2

As root I can also change the values for pwm_mode
BigBox w83627ehf.656 # head *_mode
=3D=3D> pwm1_mode <=3D=3D
1
=3D=3D> pwm2_mode <=3D=3D
1
=3D=3D> pwm3_mode <=3D=3D
1
BigBox w83627ehf.656 # for i in $(seq 3); do echo 0 >pwm${i}_mode; done
BigBox w83627ehf.656 # head *_mode
=3D=3D> pwm1_mode <=3D=3D
0
=3D=3D> pwm2_mode <=3D=3D
0
=3D=3D> pwm3_mode <=3D=3D
0


But i cannot change the pwm{1..3} values themselves..
BigBox w83627ehf.656 # head pwm{1..3}
=3D=3D> pwm1 <=3D=3D
255
=3D=3D> pwm2 <=3D=3D
255
=3D=3D> pwm3 <=3D=3D
255
BigBox w83627ehf.656 # for i in $(seq 3); do echo 0 >pwm${i}; done
BigBox w83627ehf.656 # head pwm{1..3}
=3D=3D> pwm1 <=3D=3D
255
=3D=3D> pwm2 <=3D=3D
255
=3D=3D> pwm3 <=3D=3D
255


There don't appear to be any errors, etc.

According to some threads in a bug on speedfan, there are some major
problem with the W83667HG-B datasheet -- but i can't figure out how to
contact/ask for what the bugs were...
http://www.bugtrack.almico.com/view.php?id=3D1528#c5586

I saw some other bug with lm-sensors developers helping debug a similar
issue with isadump.  Is that a possibility in this situation?

Help or thoughts or suggestions?
Thanks!!

--f46d044630785fabdf04cc95c60b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello-<div>I&#39;ve had this motherboard since January 2011 had never gotte=
n fan control to work. =A0It seems to be either a driver or hardware implem=
entation issue. =A0It doesn&#39;t appear to have the atk0110 acpi methods o=
f hardware control. =A0When i try to echo any numbers into pwm_{1..3} they =
do not actually write to the ?file?/?register?</div>

<div><br></div><div><div>I hadn&#39;t looked too deeply into it, so as to u=
nderstand the ACPI/ATK0110 vs legacy=A0W83667HG-B =A0control until recently=
. =A0About as far as i had gotten previously was to read=A0<a href=3D"http:=
//www.lm-sensors.org/wiki/AsusFormulaHacking">http://www.lm-sensors.org/wik=
i/AsusFormulaHacking</a>.=A0</div>

</div><div><div>Recently started looking further into it for a variety of r=
easons; =A0I am now sure that my board does not have any ATK0110 devices on=
 it:</div></div><div><br></div><div><br></div><div>Details:</div><div>Kerne=
l information</div>

<div>Linux BigBox 3.4.9-gentoo #1 SMP Sat Oct 20 21:41:06 PDT 2012 x86_64 I=
ntel(R) Core(TM) i3 CPU 540 @ 3.07GHz GenuineIntel GNU/Linux</div><div><br>=
</div><div>Modprobe of atk shows nothing in dmesg</div><div><div>BigBox w83=
627ehf.656 # modprobe asus-atk0110</div>

</div><div><div><div><br></div><div>dylan@BigBox ~/My_Utils/acpi $ lsmod | =
grep asus</div><div>asus_atk0110 =A0 =A0 =A0 =A0 =A0 =A08614 =A00=A0</div><=
/div><div><br></div><div>BigBox w83627ehf.656 # dmesg | tail -3</div><div>[=
 =A0 51.000276] w83627ehf: Found W83667HG-B chip at 0x290</div>

<div>[ =A0 57.806564] eth0: no IPv6 routers present</div><div>[ =A0 69.0090=
33] netlink: 12 bytes leftover after parsing attributes.</div></div><div><b=
r></div><div><br></div><div>dsdt.dsl does not have any of the &#39;key&#39;=
 atk stuff in it from the above mentioned webpage:</div>

<div><div>dylan@BigBox ~/My_Utils/acpi $ grep -i -e asoc -e vbuf -e v500 -e=
 v12v dsdt.dsl=A0</div><div>dylan@BigBox ~/My_Utils/acpi $=A0</div></div><d=
iv><br></div><div><br></div><div>I don&#39;t have no-apci on my kernel comm=
and line, there are no conflicts listed for acpi in dmesg, and the drivers =
for the sensor chip load happily</div>

<div><div>dylan@BigBox ~/My_Utils/acpi $ cat /proc/cmdline=A0</div><div>roo=
t=3D/dev/md3</div></div><div><br></div><div><div>dylan@BigBox ~/My_Utils/ac=
pi $ dmesg | grep w83627ehf</div><div>[ =A0 51.000276] w83627ehf: Found W83=
667HG-B chip at 0x290</div>

<div>dylan@BigBox ~/My_Utils/acpi $=A0</div></div><div><br></div><div>dylan=
@BigBox ~/My_Utils/acpi $ dmesg | grep conflict</div><div><div>dylan@BigBox=
 ~/My_Utils/acpi $=A0</div></div><div><br></div><div><br></div><div><div>dy=
lan@BigBox ~/My_Utils/acpi $ sensors w83667hg-isa-0290</div>

<div>w83667hg-isa-0290</div><div>Adapter: ISA adapter</div><div>Vcore: =A0 =
=A0 =A0 =A0 +0.89 V =A0(min =3D =A0+0.60 V, max =3D =A0+1.50 V)</div><div>i=
n1: =A0 =A0 =A0 =A0 =A0 +1.73 V =A0(min =3D =A0+1.50 V, max =3D =A0+1.88 V)=
</div><div>AVCC: =A0 =A0 =A0 =A0 =A0+3.38 V =A0(min =3D =A0+2.98 V, max =3D=
 =A0+3.63 V)</div>

<div>+3.3V: =A0 =A0 =A0 =A0 +3.38 V =A0(min =3D =A0+2.98 V, max =3D =A0+3.6=
3 V)</div><div>in4: =A0 =A0 =A0 =A0 =A0 +1.67 V =A0(min =3D =A0+1.50 V, max=
 =3D =A0+1.83 V)</div><div>in5: =A0 =A0 =A0 =A0 =A0 +1.69 V =A0(min =3D =A0=
+1.76 V, max =3D =A0+2.04 V) =A0ALARM</div><div>in6: =A0 =A0 =A0 =A0 =A0 +1=
.49 V =A0(min =3D =A0+1.34 V, max =3D =A0+1.65 V)</div>

<div>3VSB: =A0 =A0 =A0 =A0 =A0+3.38 V =A0(min =3D =A0+2.98 V, max =3D =A0+3=
.63 V)</div><div>Vbat: =A0 =A0 =A0 =A0 =A0+3.31 V =A0(min =3D =A0+2.70 V, m=
ax =3D =A0+3.30 V) =A0ALARM</div><div>Rear_Fan: =A0 =A0 3590 RPM =A0(min =
=3D =A0888 RPM, div =3D 8)</div><div>CPU_Fan: =A0 =A0 =A01854 RPM =A0(min =
=3D 2678 RPM, div =3D 8) =A0ALARM</div>

<div>HD_Fan0: =A0 =A0 =A03590 RPM =A0(min =3D 1298 RPM, div =3D 8)</div><di=
v>HD_Fan1: =A0 =A0 =A03668 RPM =A0(min =3D =A0865 RPM, div =3D 8)</div><div=
>fan5: =A0 =A0 =A0 =A0 =A0 =A00 RPM =A0(min =3D 10546 RPM, div =3D 128) =A0=
ALARM</div><div>PECI Agent 1: =A0 +6.0=B0C =A0(high =3D +60.0=B0C, hyst =3D=
 +58.0=B0C) =A0sensor =3D Intel PECI</div>

<div>PECI Agent 1: =A0 +6.0=B0C =A0(high =3D +89.0=B0C, hyst =3D +88.0=B0C)=
 =A0sensor =3D Intel PECI</div><div>SYSTIN: =A0 =A0 =A0 =A0+22.5=B0C =A0(hi=
gh =3D +80.0=B0C, hyst =3D +75.0=B0C) =A0sensor =3D thermistor</div><div>CP=
UTIN: =A0 =A0 =A0 =A0-54.0=B0C =A0</div><div>cpu0_vid: =A0 =A0 +0.000 V</di=
v>

<div>intrusion0: =A0 OK</div></div><div><br></div><div><br></div><div>In Bi=
os the fans are set to &#39;no control / full speed&#39; (i&#39;ve tried in=
 other modes too)</div><div><br></div><div>Now, as root.. i can change the =
settings in =A0pwm_enable (following doc for kernel driver for values)</div=
>

<div><div>BigBox w83627ehf.656 # head *_enable</div><div>=3D=3D&gt; pwm1_en=
able &lt;=3D=3D</div><div>1</div><div>=3D=3D&gt; pwm2_enable &lt;=3D=3D</di=
v><div>1</div><div>=3D=3D&gt; pwm3_enable &lt;=3D=3D</div><div>1</div><div>=
BigBox w83627ehf.656 # for i in $(seq 3); do echo 2 &gt;pwm${i}_enable; don=
e</div>

<div>BigBox w83627ehf.656 # head *_enable</div><div>=3D=3D&gt; pwm1_enable =
&lt;=3D=3D</div><div>2</div><div>=3D=3D&gt; pwm2_enable &lt;=3D=3D</div><di=
v>2</div><div>=3D=3D&gt; pwm3_enable &lt;=3D=3D</div><div>2</div></div><div=
><br></div><div>As root I can also change the values for pwm_mode</div>

<div><div>BigBox w83627ehf.656 # head *_mode</div><div>=3D=3D&gt; pwm1_mode=
 &lt;=3D=3D</div><div>1</div><div>=3D=3D&gt; pwm2_mode &lt;=3D=3D</div><div=
>1</div><div>=3D=3D&gt; pwm3_mode &lt;=3D=3D</div><div>1</div><div>BigBox w=
83627ehf.656 # for i in $(seq 3); do echo 0 &gt;pwm${i}_mode; done</div>

<div>BigBox w83627ehf.656 # head *_mode</div><div>=3D=3D&gt; pwm1_mode &lt;=
=3D=3D</div><div>0</div><div>=3D=3D&gt; pwm2_mode &lt;=3D=3D</div><div>0</d=
iv><div>=3D=3D&gt; pwm3_mode &lt;=3D=3D</div><div>0</div></div><div><br></d=
iv><div><br></div><div>

But i cannot change the pwm{1..3} values themselves..</div><div><div>BigBox=
 w83627ehf.656 # head pwm{1..3}</div><div>=3D=3D&gt; pwm1 &lt;=3D=3D</div><=
div>255</div><div>=3D=3D&gt; pwm2 &lt;=3D=3D</div><div>255</div><div>=3D=3D=
&gt; pwm3 &lt;=3D=3D</div>

<div>255</div><div>BigBox w83627ehf.656 # for i in $(seq 3); do echo 0 &gt;=
pwm${i}; done</div><div>BigBox w83627ehf.656 # head pwm{1..3}</div><div>=3D=
=3D&gt; pwm1 &lt;=3D=3D</div><div>255</div><div>=3D=3D&gt; pwm2 &lt;=3D=3D<=
/div><div>255</div>

<div>=3D=3D&gt; pwm3 &lt;=3D=3D</div><div>255</div></div><div><br></div><di=
v><br></div><div>There don&#39;t appear to be any errors, etc.</div><div><b=
r></div><div>According to some threads in a bug on speedfan, there are some=
 major problem with the=A0W83667HG-B datasheet -- but i can&#39;t figure ou=
t how to contact/ask for what the bugs were...</div>

<div><a href=3D"http://www.bugtrack.almico.com/view.php?id=3D1528#c5586">ht=
tp://www.bugtrack.almico.com/view.php?id=3D1528#c5586</a></div><div><br></d=
iv><div>I saw some other bug with lm-sensors developers helping debug a sim=
ilar issue with isadump. =A0Is that a possibility in this situation?</div>

<div><br></div><div>Help or thoughts or suggestions?</div><div>Thanks!!</di=
v>

--f46d044630785fabdf04cc95c60b--


--===============3669927131409472362==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3669927131409472362==--
