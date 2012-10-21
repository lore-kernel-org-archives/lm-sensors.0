From: camden lindsay <camden.lindsay+lmsensors@gmail.com>
Date: Sun, 21 Oct 2012 20:41:26 +0000
Subject: Re: [lm-sensors] Asus P7F-X w/ W83667HG-B pwm control problem
Message-Id: <CABkW7JPVpTob=TCBQCyhe8A1ZtQCY+oqvSy2=fiON2RBCNZRUg@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2498712969559508465=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CABkW7JOH6quu8kc56=Qm4+3ewqvtcpo7RsQKyYDyFtLd3_1pkw@mail.gmail.com>
In-Reply-To: <CABkW7JOH6quu8kc56=Qm4+3ewqvtcpo7RsQKyYDyFtLd3_1pkw@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============2498712969559508465==
Content-Type: multipart/alternative; boundary=f46d0446317cf493fd04cc97c381

--f46d0446317cf493fd04cc97c381
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks for the reply, Guenter--
Does not work in 1, either. I had tested before, I was simply showing that
i could write to all of those locations.  Just in case, let me re-do tho to
double check and provide more information.

In BIOS the available fan control options are
"Full speed mode"
"High Density Mode"
"Generic Mode"
"Whisper Mode"

I have them set to 'Full speed mode"
Here is what the pwm info looks like by default after changing to this
setting (from whatever to "Full speed mode"
BigBox device # for i in pwm1 pwm2 pwm3; do echo $i; cat ${i} ${i}_enable
${i}_mode; done
pwm1
255
1
0
pwm2
255
2
1
pwm3
255
1
1


I change them to be 1:
BigBox device # for i in $(seq 3); do echo 1 >pwm${i}_enable; done
BigBox device # for i in $(seq 3); do echo 1 >pwm${i}_mode; done

BigBox device # for i in pwm1 pwm2 pwm3; do echo $i; cat ${i} ${i}_enable
${i}_mode; done
pwm1
255
1
1
pwm2
255
1
1
pwm3
255
1
1


I try to echo 200 into pwm1:
BigBox device # echo 200 >pwm1

But it doesn't stick..
BigBox device # cat pwm1
255


Additionally, all of these settings get wiped across reboot.
(reboot)
BigBox device # for i in pwm1 pwm2 pwm3; do echo $i; cat ${i} ${i}_enable
${i}_mode; done
pwm1
255
1
0
pwm2
255
2
1
pwm3
255
1
1


I assume that bios sets them at boot time, and there is not 'off' for the
fan control settings for bios :(.
I figure i could set up a startup script to fix the _enable and _mode to
begin with if only pwm{1..3} worked.

take care..





On Sun, Oct 21, 2012 at 1:09 PM, Guenter Roeck <linux@roeck-us.net> wrote:

> On Sun, Oct 21, 2012 at 11:18:56AM -0700, camden lindsay wrote:
> > Hello-
> > I've had this motherboard since January 2011 had never gotten fan contr=
ol
> > to work.  It seems to be either a driver or hardware implementation
> issue.
> >  It doesn't appear to have the atk0110 acpi methods of hardware control=
.
> >  When i try to echo any numbers into pwm_{1..3} they do not actually
> write
> > to the ?file?/?register?
> >
> > I hadn't looked too deeply into it, so as to understand the ACPI/ATK011=
0
> vs
> > legacy W83667HG-B  control until recently.  About as far as i had gotte=
n
> > previously was to read http://www.lm-sensors.org/wiki/AsusFormulaHackin=
g
> .
> > Recently started looking further into it for a variety of reasons;  I a=
m
> > now sure that my board does not have any ATK0110 devices on it:
> >
> >
> > Details:
> > Kernel information
> > Linux BigBox 3.4.9-gentoo #1 SMP Sat Oct 20 21:41:06 PDT 2012 x86_64
> > Intel(R) Core(TM) i3 CPU 540 @ 3.07GHz GenuineIntel GNU/Linux
> >
> > Modprobe of atk shows nothing in dmesg
> > BigBox w83627ehf.656 # modprobe asus-atk0110
> >
> > dylan@BigBox ~/My_Utils/acpi $ lsmod | grep asus
> > asus_atk0110            8614  0
> >
> > BigBox w83627ehf.656 # dmesg | tail -3
> > [   51.000276] w83627ehf: Found W83667HG-B chip at 0x290
> > [   57.806564] eth0: no IPv6 routers present
> > [   69.009033] netlink: 12 bytes leftover after parsing attributes.
> >
> >
> > dsdt.dsl does not have any of the 'key' atk stuff in it from the above
> > mentioned webpage:
> > dylan@BigBox ~/My_Utils/acpi $ grep -i -e asoc -e vbuf -e v500 -e v12v
> > dsdt.dsl
> > dylan@BigBox ~/My_Utils/acpi $
> >
> >
> > I don't have no-apci on my kernel command line, there are no conflicts
> > listed for acpi in dmesg, and the drivers for the sensor chip load
> happily
> > dylan@BigBox ~/My_Utils/acpi $ cat /proc/cmdline
> > root=3D/dev/md3
> >
> > dylan@BigBox ~/My_Utils/acpi $ dmesg | grep w83627ehf
> > [   51.000276] w83627ehf: Found W83667HG-B chip at 0x290
> > dylan@BigBox ~/My_Utils/acpi $
> >
> > dylan@BigBox ~/My_Utils/acpi $ dmesg | grep conflict
> > dylan@BigBox ~/My_Utils/acpi $
> >
> >
> > dylan@BigBox ~/My_Utils/acpi $ sensors w83667hg-isa-0290
> > w83667hg-isa-0290
> > Adapter: ISA adapter
> > Vcore:         +0.89 V  (min =3D  +0.60 V, max =3D  +1.50 V)
> > in1:           +1.73 V  (min =3D  +1.50 V, max =3D  +1.88 V)
> > AVCC:          +3.38 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> > +3.3V:         +3.38 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> > in4:           +1.67 V  (min =3D  +1.50 V, max =3D  +1.83 V)
> > in5:           +1.69 V  (min =3D  +1.76 V, max =3D  +2.04 V)  ALARM
> > in6:           +1.49 V  (min =3D  +1.34 V, max =3D  +1.65 V)
> > 3VSB:          +3.38 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> > Vbat:          +3.31 V  (min =3D  +2.70 V, max =3D  +3.30 V)  ALARM
> > Rear_Fan:     3590 RPM  (min =3D  888 RPM, div =3D 8)
> > CPU_Fan:      1854 RPM  (min =3D 2678 RPM, div =3D 8)  ALARM
> > HD_Fan0:      3590 RPM  (min =3D 1298 RPM, div =3D 8)
> > HD_Fan1:      3668 RPM  (min =3D  865 RPM, div =3D 8)
> > fan5:            0 RPM  (min =3D 10546 RPM, div =3D 128)  ALARM
> > PECI Agent 1:   +6.0=B0C  (high =3D +60.0=B0C, hyst =3D +58.0=B0C)  sen=
sor =3D Intel
> > PECI
> > PECI Agent 1:   +6.0=B0C  (high =3D +89.0=B0C, hyst =3D +88.0=B0C)  sen=
sor =3D Intel
> > PECI
> > SYSTIN:        +22.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sen=
sor =3D
> > thermistor
> > CPUTIN:        -54.0=B0C
> > cpu0_vid:     +0.000 V
> > intrusion0:   OK
> >
> >
> > In Bios the fans are set to 'no control / full speed' (i've tried in
> other
> > modes too)
> >
> > Now, as root.. i can change the settings in  pwm_enable (following doc
> for
> > kernel driver for values)
> > BigBox w83627ehf.656 # head *_enable
> > =3D=3D> pwm1_enable <=3D=3D
> > 1
> > =3D=3D> pwm2_enable <=3D=3D
> > 1
> > =3D=3D> pwm3_enable <=3D=3D
> > 1
> > BigBox w83627ehf.656 # for i in $(seq 3); do echo 2 >pwm${i}_enable; do=
ne
> > BigBox w83627ehf.656 # head *_enable
> > =3D=3D> pwm1_enable <=3D=3D
> > 2
> > =3D=3D> pwm2_enable <=3D=3D
> > 2
> > =3D=3D> pwm3_enable <=3D=3D
> > 2
> >
> Should be 1 for manual mode. Supposedly this is the only mode where you c=
an
> write into the pwm attribute.
>
> > As root I can also change the values for pwm_mode
> > BigBox w83627ehf.656 # head *_mode
> > =3D=3D> pwm1_mode <=3D=3D
> > 1
> > =3D=3D> pwm2_mode <=3D=3D
> > 1
> > =3D=3D> pwm3_mode <=3D=3D
> > 1
> > BigBox w83627ehf.656 # for i in $(seq 3); do echo 0 >pwm${i}_mode; done
> > BigBox w83627ehf.656 # head *_mode
> > =3D=3D> pwm1_mode <=3D=3D
> > 0
> > =3D=3D> pwm2_mode <=3D=3D
> > 0
> > =3D=3D> pwm3_mode <=3D=3D
> > 0
> >
> In general you don't want to change pwmX_mode, since it changes the mode
> from
> pwm output (1) to DC output (0).
>
> >
> > But i cannot change the pwm{1..3} values themselves..
> > BigBox w83627ehf.656 # head pwm{1..3}
> > =3D=3D> pwm1 <=3D=3D
> > 255
> > =3D=3D> pwm2 <=3D=3D
> > 255
> > =3D=3D> pwm3 <=3D=3D
> > 255
> > BigBox w83627ehf.656 # for i in $(seq 3); do echo 0 >pwm${i}; done
> > BigBox w83627ehf.656 # head pwm{1..3}
> > =3D=3D> pwm1 <=3D=3D
> > 255
> > =3D=3D> pwm2 <=3D=3D
> > 255
> > =3D=3D> pwm3 <=3D=3D
> > 255
> >
> >
> > There don't appear to be any errors, etc.
> >
> > According to some threads in a bug on speedfan, there are some major
> > problem with the W83667HG-B datasheet -- but i can't figure out how to
> > contact/ask for what the bugs were...
> > http://www.bugtrack.almico.com/view.php?id=3D1528#c5586
> >
> Unfortunately, the datasheet problem is not explained in detail.
>
> Guenter
>

--f46d0446317cf493fd04cc97c381
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Thanks for the reply, Guenter--</div>Does not work in 1, either. I had=
 tested before, I was simply showing that i could write to all of those loc=
ations. =A0Just in case, let me re-do tho to double check and provide more =
information.<div>

<br></div><div>In BIOS the available fan control options are=A0</div><div>&=
quot;Full speed mode&quot;</div><div>&quot;High Density Mode&quot;</div><di=
v>&quot;Generic Mode&quot;</div><div>&quot;Whisper Mode&quot;</div><div>
<br>
</div><div>I have them set to &#39;Full speed mode&quot;</div><div>Here is =
what the pwm info looks like by default after changing to this setting (fro=
m whatever to &quot;Full speed mode&quot;</div><div><div>BigBox device # fo=
r i in pwm1 pwm2 pwm3; do echo $i; cat ${i} ${i}_enable ${i}_mode; done</di=
v>

<div>pwm1</div><div>255</div><div>1</div><div>0</div><div>pwm2</div><div>25=
5</div><div>2</div><div>1</div><div>pwm3</div><div>255</div><div>1</div><di=
v>1</div><div><br></div><div><br></div><div>I change them to be 1:</div>

<div><div>BigBox device # for i in $(seq 3); do echo 1 &gt;pwm${i}_enable; =
done</div><div>BigBox device # for i in $(seq 3); do echo 1 &gt;pwm${i}_mod=
e; done</div></div><div><br></div><div><div>BigBox device # for i in pwm1 p=
wm2 pwm3; do echo $i; cat ${i} ${i}_enable ${i}_mode; done</div>

<div>pwm1</div><div>255</div><div>1</div><div>1</div><div>pwm2</div><div>25=
5</div><div>1</div><div>1</div><div>pwm3</div><div>255</div><div>1</div><di=
v>1</div></div><div><br></div><div><br></div><div>I try to echo 200 into pw=
m1:</div>

<div><div>BigBox device # echo 200 &gt;pwm1</div><div><br></div><div>But it=
 doesn&#39;t stick..</div><div>BigBox device # cat pwm1</div><div>255</div>=
</div><div><br></div><div><br></div><div>Additionally, all of these setting=
s get wiped across reboot. =A0</div>

<div>(reboot)</div><div><div>BigBox device # for i in pwm1 pwm2 pwm3; do ec=
ho $i; cat ${i} ${i}_enable ${i}_mode; done</div><div>pwm1</div><div>255</d=
iv><div>1</div><div>0</div><div>pwm2</div><div>255</div><div>2</div><div>

1</div><div>pwm3</div><div>255</div><div>1</div><div>1</div></div><div><br>=
</div><div><br></div><div>I assume that bios sets them at boot time, and th=
ere is not &#39;off&#39; for the fan control settings for bios :(.</div>

<div>I figure i could set up a startup script to fix the _enable and _mode =
to begin with if only pwm{1..3} worked.</div><div><br></div><div>take care.=
.</div><div><br></div><div><br></div><div><div><br></div><div><br><br>
<div class=3D"gmail_quote">
On Sun, Oct 21, 2012 at 1:09 PM, Guenter Roeck <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:linux@roeck-us.net" target=3D"_blank">linux@roeck-us.net</a>&gt=
;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div><div>On Sun, Oct 21, 2012 at 11:18:56AM=
 -0700, camden lindsay wrote:<br>
&gt; Hello-<br>
&gt; I&#39;ve had this motherboard since January 2011 had never gotten fan =
control<br>
&gt; to work. =A0It seems to be either a driver or hardware implementation =
issue.<br>
&gt; =A0It doesn&#39;t appear to have the atk0110 acpi methods of hardware =
control.<br>
&gt; =A0When i try to echo any numbers into pwm_{1..3} they do not actually=
 write<br>
&gt; to the ?file?/?register?<br>
&gt;<br>
&gt; I hadn&#39;t looked too deeply into it, so as to understand the ACPI/A=
TK0110 vs<br>
&gt; legacy W83667HG-B =A0control until recently. =A0About as far as i had =
gotten<br>
&gt; previously was to read <a href=3D"http://www.lm-sensors.org/wiki/AsusF=
ormulaHacking" target=3D"_blank">http://www.lm-sensors.org/wiki/AsusFormula=
Hacking</a>.<br>
&gt; Recently started looking further into it for a variety of reasons; =A0=
I am<br>
&gt; now sure that my board does not have any ATK0110 devices on it:<br>
&gt;<br>
&gt;<br>
&gt; Details:<br>
&gt; Kernel information<br>
&gt; Linux BigBox 3.4.9-gentoo #1 SMP Sat Oct 20 21:41:06 PDT 2012 x86_64<b=
r>
&gt; Intel(R) Core(TM) i3 CPU 540 @ 3.07GHz GenuineIntel GNU/Linux<br>
&gt;<br>
&gt; Modprobe of atk shows nothing in dmesg<br>
&gt; BigBox w83627ehf.656 # modprobe asus-atk0110<br>
&gt;<br>
&gt; dylan@BigBox ~/My_Utils/acpi $ lsmod | grep asus<br>
&gt; asus_atk0110 =A0 =A0 =A0 =A0 =A0 =A08614 =A00<br>
&gt;<br>
&gt; BigBox w83627ehf.656 # dmesg | tail -3<br>
&gt; [ =A0 51.000276] w83627ehf: Found W83667HG-B chip at 0x290<br>
&gt; [ =A0 57.806564] eth0: no IPv6 routers present<br>
&gt; [ =A0 69.009033] netlink: 12 bytes leftover after parsing attributes.<=
br>
&gt;<br>
&gt;<br>
&gt; dsdt.dsl does not have any of the &#39;key&#39; atk stuff in it from t=
he above<br>
&gt; mentioned webpage:<br>
&gt; dylan@BigBox ~/My_Utils/acpi $ grep -i -e asoc -e vbuf -e v500 -e v12v=
<br>
&gt; dsdt.dsl<br>
&gt; dylan@BigBox ~/My_Utils/acpi $<br>
&gt;<br>
&gt;<br>
&gt; I don&#39;t have no-apci on my kernel command line, there are no confl=
icts<br>
&gt; listed for acpi in dmesg, and the drivers for the sensor chip load hap=
pily<br>
&gt; dylan@BigBox ~/My_Utils/acpi $ cat /proc/cmdline<br>
&gt; root=3D/dev/md3<br>
&gt;<br>
&gt; dylan@BigBox ~/My_Utils/acpi $ dmesg | grep w83627ehf<br>
&gt; [ =A0 51.000276] w83627ehf: Found W83667HG-B chip at 0x290<br>
&gt; dylan@BigBox ~/My_Utils/acpi $<br>
&gt;<br>
&gt; dylan@BigBox ~/My_Utils/acpi $ dmesg | grep conflict<br>
&gt; dylan@BigBox ~/My_Utils/acpi $<br>
&gt;<br>
&gt;<br>
&gt; dylan@BigBox ~/My_Utils/acpi $ sensors w83667hg-isa-0290<br>
&gt; w83667hg-isa-0290<br>
&gt; Adapter: ISA adapter<br>
&gt; Vcore: =A0 =A0 =A0 =A0 +0.89 V =A0(min =3D =A0+0.60 V, max =3D =A0+1.5=
0 V)<br>
&gt; in1: =A0 =A0 =A0 =A0 =A0 +1.73 V =A0(min =3D =A0+1.50 V, max =3D =A0+1=
.88 V)<br>
&gt; AVCC: =A0 =A0 =A0 =A0 =A0+3.38 V =A0(min =3D =A0+2.98 V, max =3D =A0+3=
.63 V)<br>
&gt; +3.3V: =A0 =A0 =A0 =A0 +3.38 V =A0(min =3D =A0+2.98 V, max =3D =A0+3.6=
3 V)<br>
&gt; in4: =A0 =A0 =A0 =A0 =A0 +1.67 V =A0(min =3D =A0+1.50 V, max =3D =A0+1=
.83 V)<br>
&gt; in5: =A0 =A0 =A0 =A0 =A0 +1.69 V =A0(min =3D =A0+1.76 V, max =3D =A0+2=
.04 V) =A0ALARM<br>
&gt; in6: =A0 =A0 =A0 =A0 =A0 +1.49 V =A0(min =3D =A0+1.34 V, max =3D =A0+1=
.65 V)<br>
&gt; 3VSB: =A0 =A0 =A0 =A0 =A0+3.38 V =A0(min =3D =A0+2.98 V, max =3D =A0+3=
.63 V)<br>
&gt; Vbat: =A0 =A0 =A0 =A0 =A0+3.31 V =A0(min =3D =A0+2.70 V, max =3D =A0+3=
.30 V) =A0ALARM<br>
&gt; Rear_Fan: =A0 =A0 3590 RPM =A0(min =3D =A0888 RPM, div =3D 8)<br>
&gt; CPU_Fan: =A0 =A0 =A01854 RPM =A0(min =3D 2678 RPM, div =3D 8) =A0ALARM=
<br>
&gt; HD_Fan0: =A0 =A0 =A03590 RPM =A0(min =3D 1298 RPM, div =3D 8)<br>
&gt; HD_Fan1: =A0 =A0 =A03668 RPM =A0(min =3D =A0865 RPM, div =3D 8)<br>
&gt; fan5: =A0 =A0 =A0 =A0 =A0 =A00 RPM =A0(min =3D 10546 RPM, div =3D 128)=
 =A0ALARM<br>
&gt; PECI Agent 1: =A0 +6.0=B0C =A0(high =3D +60.0=B0C, hyst =3D +58.0=B0C)=
 =A0sensor =3D Intel<br>
&gt; PECI<br>
&gt; PECI Agent 1: =A0 +6.0=B0C =A0(high =3D +89.0=B0C, hyst =3D +88.0=B0C)=
 =A0sensor =3D Intel<br>
&gt; PECI<br>
&gt; SYSTIN: =A0 =A0 =A0 =A0+22.5=B0C =A0(high =3D +80.0=B0C, hyst =3D +75.=
0=B0C) =A0sensor =3D<br>
&gt; thermistor<br>
&gt; CPUTIN: =A0 =A0 =A0 =A0-54.0=B0C<br>
&gt; cpu0_vid: =A0 =A0 +0.000 V<br>
&gt; intrusion0: =A0 OK<br>
&gt;<br>
&gt;<br>
&gt; In Bios the fans are set to &#39;no control / full speed&#39; (i&#39;v=
e tried in other<br>
&gt; modes too)<br>
&gt;<br>
&gt; Now, as root.. i can change the settings in =A0pwm_enable (following d=
oc for<br>
&gt; kernel driver for values)<br>
&gt; BigBox w83627ehf.656 # head *_enable<br>
&gt; =3D=3D&gt; pwm1_enable &lt;=3D=3D<br>
&gt; 1<br>
&gt; =3D=3D&gt; pwm2_enable &lt;=3D=3D<br>
&gt; 1<br>
&gt; =3D=3D&gt; pwm3_enable &lt;=3D=3D<br>
&gt; 1<br>
&gt; BigBox w83627ehf.656 # for i in $(seq 3); do echo 2 &gt;pwm${i}_enable=
; done<br>
&gt; BigBox w83627ehf.656 # head *_enable<br>
&gt; =3D=3D&gt; pwm1_enable &lt;=3D=3D<br>
&gt; 2<br>
&gt; =3D=3D&gt; pwm2_enable &lt;=3D=3D<br>
&gt; 2<br>
&gt; =3D=3D&gt; pwm3_enable &lt;=3D=3D<br>
&gt; 2<br>
&gt;<br>
</div></div>Should be 1 for manual mode. Supposedly this is the only mode w=
here you can<br>
write into the pwm attribute.<br>
<div><br>
&gt; As root I can also change the values for pwm_mode<br>
&gt; BigBox w83627ehf.656 # head *_mode<br>
&gt; =3D=3D&gt; pwm1_mode &lt;=3D=3D<br>
&gt; 1<br>
&gt; =3D=3D&gt; pwm2_mode &lt;=3D=3D<br>
&gt; 1<br>
&gt; =3D=3D&gt; pwm3_mode &lt;=3D=3D<br>
&gt; 1<br>
&gt; BigBox w83627ehf.656 # for i in $(seq 3); do echo 0 &gt;pwm${i}_mode; =
done<br>
&gt; BigBox w83627ehf.656 # head *_mode<br>
&gt; =3D=3D&gt; pwm1_mode &lt;=3D=3D<br>
&gt; 0<br>
&gt; =3D=3D&gt; pwm2_mode &lt;=3D=3D<br>
&gt; 0<br>
&gt; =3D=3D&gt; pwm3_mode &lt;=3D=3D<br>
&gt; 0<br>
&gt;<br>
</div>In general you don&#39;t want to change pwmX_mode, since it changes t=
he mode from<br>
pwm output (1) to DC output (0).<br>
<div><br>
&gt;<br>
&gt; But i cannot change the pwm{1..3} values themselves..<br>
&gt; BigBox w83627ehf.656 # head pwm{1..3}<br>
&gt; =3D=3D&gt; pwm1 &lt;=3D=3D<br>
&gt; 255<br>
&gt; =3D=3D&gt; pwm2 &lt;=3D=3D<br>
&gt; 255<br>
&gt; =3D=3D&gt; pwm3 &lt;=3D=3D<br>
&gt; 255<br>
&gt; BigBox w83627ehf.656 # for i in $(seq 3); do echo 0 &gt;pwm${i}; done<=
br>
&gt; BigBox w83627ehf.656 # head pwm{1..3}<br>
&gt; =3D=3D&gt; pwm1 &lt;=3D=3D<br>
&gt; 255<br>
&gt; =3D=3D&gt; pwm2 &lt;=3D=3D<br>
&gt; 255<br>
&gt; =3D=3D&gt; pwm3 &lt;=3D=3D<br>
&gt; 255<br>
&gt;<br>
&gt;<br>
&gt; There don&#39;t appear to be any errors, etc.<br>
&gt;<br>
&gt; According to some threads in a bug on speedfan, there are some major<b=
r>
&gt; problem with the W83667HG-B datasheet -- but i can&#39;t figure out ho=
w to<br>
&gt; contact/ask for what the bugs were...<br>
&gt; <a href=3D"http://www.bugtrack.almico.com/view.php?id=3D1528#c5586" ta=
rget=3D"_blank">http://www.bugtrack.almico.com/view.php?id=3D1528#c5586</a>=
<br>
&gt;<br>
</div>Unfortunately, the datasheet problem is not explained in detail.<br>
<span><font color=3D"#888888"><br>
Guenter<br>
</font></span></blockquote></div><br></div></div>
</div>

--f46d0446317cf493fd04cc97c381--


--===============2498712969559508465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2498712969559508465==--
