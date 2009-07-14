From: he liang <billpeace@gmail.com>
Date: Tue, 14 Jul 2009 15:02:21 +0000
Subject: Re: [lm-sensors] Can someone give me some help? thanks
Message-Id: <c98b13f80907140802s63d977c8ybc69ae2240a8b0fe@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3464314582184570820=="
List-Id: <lm-sensors.vger.kernel.org>
References: <c98b13f80907101313g76b337batfe028da5046fcd00@mail.gmail.com>
In-Reply-To: <c98b13f80907101313g76b337batfe028da5046fcd00@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============3464314582184570820==
Content-Type: multipart/alternative; boundary=0016e645ab9602a6de046eabbaa2

--0016e645ab9602a6de046eabbaa2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

ok,I know.
This time  I send my question to  the  lm-sensors mailing address
 thanks for your advice.

my result is as follow,so why it has so many ALARM?
need I to modify or check something?

Processor 4x Intel(R) Core(TM)2 Quad CPU @ 2.40GHz
Operating System Ubuntu 8.04.3 LTS
Kernel Linux 2.6.24-24-generic (i686)
mainboard: asus p5b plus

Adapter: ISA adapter
VCore:       +1.12 V  (min =3D  +0.00 V, max =3D  +1.74 V)
in1:        +12.20 V  (min =3D  +9.03 V, max =3D  +5.17 V)   ALARM
AVCC:        +3.17 V  (min =3D  +3.14 V, max =3D  +2.98 V)   ALARM
3VCC:        +3.17 V  (min =3D  +2.66 V, max =3D  +2.82 V)   ALARM
in4:         +0.00 V  (min =3D  +0.13 V, max =3D  +1.39 V)   ALARM
in5:         +1.58 V  (min =3D  +1.18 V, max =3D  +0.22 V)   ALARM
in6:         +0.13 V  (min =3D  +4.35 V, max =3D  +6.35 V)   ALARM
VSB:         +3.17 V  (min =3D  +1.14 V, max =3D  +2.61 V)   ALARM
VBAT:        +3.17 V  (min =3D  +2.40 V, max =3D  +2.53 V)   ALARM
Case Fan:      0 RPM  (min =3D 21093 RPM, div =3D 64)  ALARM
CPU Fan:    1394 RPM  (min =3D 2678 RPM, div =3D 8)  ALARM
Aux Fan:       0 RPM  (min =3D 21093 RPM, div =3D 64)  ALARM
fan4:          0 RPM  (min =3D 42187 RPM, div =3D 32)  ALARM
fan5:          0 RPM  (min =3D 10546 RPM, div =3D 128)  ALARM
Sys Temp:    +37.0=B0C  (high =3D +15.0=B0C, hyst =3D +68.0=B0C)  sensor =
=3D thermistor
CPU Temp:    +14.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D diode
AUX Temp:   +111.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  ALARM  se=
nsor =3D
thermistor
cpu0_vid:   +1.550 V
coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +36.0=B0C  (crit =3D +100.0=B0C)
coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +36.0=B0C  (crit =3D +100.0=B0C)
coretemp-isa-0002
Adapter: ISA adapter
Core 2:      +34.0=B0C  (crit =3D +100.0=B0C)
coretemp-isa-0003
Adapter: ISA adapter
Core 3:      +34.0=B0C  (crit =3D +100.0=B0C)

2009/7/14 Mark E. Hansen <meh@winfirst.com>

> On 07/13/09 20:53, he liang wrote:
> > it can works
> > THanks very much!
> > the result as follows
> > I want to ask why so many ALARM?
> > need i to check something?
>
> First, you should make sure you always include the lm-sensors mailing
> list on all messages, so the entire list can participate.
>
> You're getting the alarms because your configuration, for in1 for
> example, shows a min voltage of +9.03 and a max voltage of +5.17,
> while the sensed voltage is +12.20 - well above the defined max:
>
> > in1:        +12.20 V  (min =3D  +9.03 V, max =3D  +5.17 V)   ALARM
>
>
> Note that although the sensors-detect script can detect which sensor
> chips are used by your motherboard and install the proper drivers,
> it can't really set up the configuration file, as each motherboard
> manufacturer "wires-up" the chips differently.
>
> I'm not an expert at setting up a configuration file, so I'll let
> someone else answer here.
>
> Best Regards,
>
>
> >
> -------------------------------------------------------------------------=
------------------
> > Adapter: ISA adapter
> > VCore:       +1.12 V  (min =3D  +0.00 V, max =3D  +1.74 V)
> > in1:        +12.20 V  (min =3D  +9.03 V, max =3D  +5.17 V)   ALARM
> > AVCC:        +3.17 V  (min =3D  +3.14 V, max =3D  +2.98 V)   ALARM
> > 3VCC:        +3.17 V  (min =3D  +2.66 V, max =3D  +2.82 V)   ALARM
> > in4:         +0.00 V  (min =3D  +0.13 V, max =3D  +1.39 V)   ALARM
> > in5:         +1.58 V  (min =3D  +1.18 V, max =3D  +0.22 V)   ALARM
> > in6:         +0.13 V  (min =3D  +4.35 V, max =3D  +6.35 V)   ALARM
> > VSB:         +3.17 V  (min =3D  +1.14 V, max =3D  +2.61 V)   ALARM
> > VBAT:        +3.17 V  (min =3D  +2.40 V, max =3D  +2.53 V)   ALARM
> > Case Fan:      0 RPM  (min =3D 21093 RPM, div =3D 64)  ALARM
> > CPU Fan:    1394 RPM  (min =3D 2678 RPM, div =3D 8)  ALARM
> > Aux Fan:       0 RPM  (min =3D 21093 RPM, div =3D 64)  ALARM
> > fan4:          0 RPM  (min =3D 42187 RPM, div =3D 32)  ALARM
> > fan5:          0 RPM  (min =3D 10546 RPM, div =3D 128)  ALARM
> > Sys Temp:    +37.0=B0C  (high =3D +15.0=B0C, hyst =3D +68.0=B0C)  senso=
r =3D
> thermistor
> > CPU Temp:    +14.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  senso=
r =3D diode
> > AUX Temp:   +111.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  ALARM=
  sensor =3D
> > thermistor
> > cpu0_vid:   +1.550 V
> > coretemp-isa-0000
> > Adapter: ISA adapter
> > Core 0:      +36.0=B0C  (crit =3D +100.0=B0C)
> > coretemp-isa-0001
> > Adapter: ISA adapter
> > Core 1:      +36.0=B0C  (crit =3D +100.0=B0C)
> > coretemp-isa-0002
> > Adapter: ISA adapter
> > Core 2:      +34.0=B0C  (crit =3D +100.0=B0C)
> > coretemp-isa-0003
> > Adapter: ISA adapter
> > Core 3:      +34.0=B0C  (crit =3D +100.0=B0C)
> > 2009/7/13 Mark E. Hansen <meh@winfirst.com>
> >
> >> On 07/13/09 03:52, Martyn Welch wrote:
> >> > he liang wrote:
> >> >>
> >> >> Just press ENTER to continue:
> >> >>
> >> >> I will now generate the commands needed to load the required module=
s.
> >> >>
> >> >> To load everything that is needed, add this to /etc/modules:
> >> >>
> >> >> #----cut here----
> >> >> # Chip drivers
> >> >> w83627ehf
> >> >> coretemp
> >> >> #----cut here----
> >> >>
> >> >> Do you want to add these lines automatically? (yes/NO)yes
> >> >> psy@psy-desktop:~$ <mailto:psy@psy-desktop:%7E$> sudo sensors
> >> >> No sensors found!
> >> >> Make sure you loaded all the kernel drivers you need.
> >> >> Try sensors-detect to find out which these are.
> >> >>
> >> > Have you tried rebooting? Adding those lines to "/etc/modules" shoul=
d
> >> > take effect after a reboot.
> >> >
> >> > Try rebooting or issuing the following commands to load the modules:
> >> >
> >> >   sudo modprobe w83627ehf
> >> >   sudo modprobe coretemp
> >> >
> >> > Hope that helps,
> >> >
> >> > Martyn
> >> >
> >>
> >> Also, the OP should try 'sensors -s' as root (in /etc/rc.local) to
> >> upload the sensors configuration to the sensors chips.
> >>
> >>
> >> _______________________________________________
> >> lm-sensors mailing list
> >> lm-sensors@lm-sensors.org
> >> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> >>
> >
>
>

--0016e645ab9602a6de046eabbaa2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>ok,I know.=A0</div>
<div>This time =A0I=A0send my question=A0to=A0=A0the=A0 lm-sensors mailing =
address=A0</div>
<div>=A0thanks for your advice.</div>
<div>=A0</div>
<div>my result is as follow,so why it has so many ALARM?</div>
<div>need I to modify or check something?</div>
<div>=A0</div>
<div>Processor=A04x Intel(R) Core(TM)2 Quad CPU @ 2.40GHz<br>Operating Syst=
em=A0Ubuntu 8.04.3 LTS</div>
<div>Kernel=A0Linux 2.6.24-24-generic (i686)</div>
<div>mainboard: asus p5b plus</div>
<div>=A0</div>
<div>Adapter: ISA adapter<br>VCore:=A0=A0=A0=A0=A0=A0 +1.12 V=A0 (min =3D=
=A0 +0.00 V, max =3D=A0 +1.74 V)=A0=A0 <br>in1:=A0=A0=A0=A0=A0=A0=A0 +12.20=
 V=A0 (min =3D=A0 +9.03 V, max =3D=A0 +5.17 V)=A0=A0 ALARM<br>AVCC:=A0=A0=
=A0=A0=A0=A0=A0 +3.17 V=A0 (min =3D=A0 +3.14 V, max =3D=A0 +2.98 V)=A0=A0 A=
LARM<br>
3VCC:=A0=A0=A0=A0=A0=A0=A0 +3.17 V=A0 (min =3D=A0 +2.66 V, max =3D=A0 +2.82=
 V)=A0=A0 ALARM<br>in4:=A0=A0=A0=A0=A0=A0=A0=A0 +0.00 V=A0 (min =3D=A0 +0.1=
3 V, max =3D=A0 +1.39 V)=A0=A0 ALARM<br>in5:=A0=A0=A0=A0=A0=A0=A0=A0 +1.58 =
V=A0 (min =3D=A0 +1.18 V, max =3D=A0 +0.22 V)=A0=A0 ALARM<br>in6:=A0=A0=A0=
=A0=A0=A0=A0=A0 +0.13 V=A0 (min =3D=A0 +4.35 V, max =3D=A0 +6.35 V)=A0=A0 A=
LARM<br>
VSB:=A0=A0=A0=A0=A0=A0=A0=A0 +3.17 V=A0 (min =3D=A0 +1.14 V, max =3D=A0 +2.=
61 V)=A0=A0 ALARM<br>VBAT:=A0=A0=A0=A0=A0=A0=A0 +3.17 V=A0 (min =3D=A0 +2.4=
0 V, max =3D=A0 +2.53 V)=A0=A0 ALARM<br>Case Fan:=A0=A0=A0=A0=A0 0 RPM=A0 (=
min =3D 21093 RPM, div =3D 64)=A0 ALARM<br>CPU Fan:=A0=A0=A0 1394 RPM=A0 (m=
in =3D 2678 RPM, div =3D 8)=A0 ALARM<br>
Aux Fan:=A0=A0=A0=A0=A0=A0 0 RPM=A0 (min =3D 21093 RPM, div =3D 64)=A0 ALAR=
M<br>fan4:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0 (min =3D 42187 RPM, div =3D =
32)=A0 ALARM<br>fan5:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0 (min =3D 10546 RP=
M, div =3D 128)=A0 ALARM<br>Sys Temp:=A0=A0=A0 +37.0=B0C=A0 (high =3D +15.0=
=B0C, hyst =3D +68.0=B0C)=A0 sensor =3D thermistor<br>
CPU Temp:=A0=A0=A0 +14.0=B0C=A0 (high =3D +80.0=B0C, hyst =3D +75.0=B0C)=A0=
 sensor =3D diode<br>AUX Temp:=A0=A0 +111.5=B0C=A0 (high =3D +80.0=B0C, hys=
t =3D +75.0=B0C)=A0 ALARM=A0 sensor =3D thermistor<br>cpu0_vid:=A0=A0 +1.55=
0 V<br>coretemp-isa-0000<br>Adapter: ISA adapter<br>
Core 0:=A0=A0=A0=A0=A0 +36.0=B0C=A0 (crit =3D +100.0=B0C)=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>coretemp-isa-0001<br>Adapter: ISA ada=
pter<br>Core 1:=A0=A0=A0=A0=A0 +36.0=B0C=A0 (crit =3D +100.0=B0C)=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>coretemp-isa-0002<br>Adapter=
: ISA adapter<br>Core 2:=A0=A0=A0=A0=A0 +34.0=B0C=A0 (crit =3D +100.0=B0C)=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>
coretemp-isa-0003<br>Adapter: ISA adapter<br>Core 3:=A0=A0=A0=A0=A0 +34.0=
=B0C=A0 (crit =3D +100.0=B0C) <br><br></div>
<div class=3D"gmail_quote">2009/7/14 Mark E. Hansen <span dir=3D"ltr">&lt;<=
a href=3D"mailto:meh@winfirst.com">meh@winfirst.com</a>&gt;</span><br>
<blockquote style=3D"BORDER-LEFT: #ccc 1px solid; MARGIN: 0px 0px 0px 0.8ex=
; PADDING-LEFT: 1ex" class=3D"gmail_quote">
<div class=3D"im">On 07/13/09 20:53, he liang wrote:<br>&gt; it can works<b=
r>&gt; THanks very much!<br>&gt; the result as follows<br>&gt; I want to as=
k why so many ALARM?<br>&gt; need i to check something?<br><br></div>First,=
 you should make sure you always include the lm-sensors mailing<br>
list on all messages, so the entire list can participate.<br><br>You&#39;re=
 getting the alarms because your configuration, for in1 for<br>example, sho=
ws a min voltage of +9.03 and a max voltage of +5.17,<br>while the sensed v=
oltage is +12.20 - well above the defined max:<br>

<div class=3D"im"><br>&gt; in1: =A0 =A0 =A0 =A0+12.20 V =A0(min =3D =A0+9.0=
3 V, max =3D =A0+5.17 V) =A0 ALARM<br><br><br></div>Note that although the =
sensors-detect script can detect which sensor<br>chips are used by your mot=
herboard and install the proper drivers,<br>
it can&#39;t really set up the configuration file, as each motherboard<br>m=
anufacturer &quot;wires-up&quot; the chips differently.<br><br>I&#39;m not =
an expert at setting up a configuration file, so I&#39;ll let<br>someone el=
se answer here.<br>
<br>Best Regards,<br>
<div>
<div></div>
<div class=3D"h5"><br><br>&gt; --------------------------------------------=
-----------------------------------------------<br>&gt; Adapter: ISA adapte=
r<br>&gt; VCore: =A0 =A0 =A0 +1.12 V =A0(min =3D =A0+0.00 V, max =3D =A0+1.=
74 V)<br>&gt; in1: =A0 =A0 =A0 =A0+12.20 V =A0(min =3D =A0+9.03 V, max =3D =
=A0+5.17 V) =A0 ALARM<br>
&gt; AVCC: =A0 =A0 =A0 =A0+3.17 V =A0(min =3D =A0+3.14 V, max =3D =A0+2.98 =
V) =A0 ALARM<br>&gt; 3VCC: =A0 =A0 =A0 =A0+3.17 V =A0(min =3D =A0+2.66 V, m=
ax =3D =A0+2.82 V) =A0 ALARM<br>&gt; in4: =A0 =A0 =A0 =A0 +0.00 V =A0(min =
=3D =A0+0.13 V, max =3D =A0+1.39 V) =A0 ALARM<br>&gt; in5: =A0 =A0 =A0 =A0 =
+1.58 V =A0(min =3D =A0+1.18 V, max =3D =A0+0.22 V) =A0 ALARM<br>
&gt; in6: =A0 =A0 =A0 =A0 +0.13 V =A0(min =3D =A0+4.35 V, max =3D =A0+6.35 =
V) =A0 ALARM<br>&gt; VSB: =A0 =A0 =A0 =A0 +3.17 V =A0(min =3D =A0+1.14 V, m=
ax =3D =A0+2.61 V) =A0 ALARM<br>&gt; VBAT: =A0 =A0 =A0 =A0+3.17 V =A0(min =
=3D =A0+2.40 V, max =3D =A0+2.53 V) =A0 ALARM<br>&gt; Case Fan: =A0 =A0 =A0=
0 RPM =A0(min =3D 21093 RPM, div =3D 64) =A0ALARM<br>
&gt; CPU Fan: =A0 =A01394 RPM =A0(min =3D 2678 RPM, div =3D 8) =A0ALARM<br>=
&gt; Aux Fan: =A0 =A0 =A0 0 RPM =A0(min =3D 21093 RPM, div =3D 64) =A0ALARM=
<br>&gt; fan4: =A0 =A0 =A0 =A0 =A00 RPM =A0(min =3D 42187 RPM, div =3D 32) =
=A0ALARM<br>&gt; fan5: =A0 =A0 =A0 =A0 =A00 RPM =A0(min =3D 10546 RPM, div =
=3D 128) =A0ALARM<br>
&gt; Sys Temp: =A0 =A0+37.0=B0C =A0(high =3D +15.0=B0C, hyst =3D +68.0=B0C)=
 =A0sensor =3D thermistor<br>&gt; CPU Temp: =A0 =A0+14.0=B0C =A0(high =3D +=
80.0=B0C, hyst =3D +75.0=B0C) =A0sensor =3D diode<br>&gt; AUX Temp: =A0 +11=
1.5=B0C =A0(high =3D +80.0=B0C, hyst =3D +75.0=B0C) =A0ALARM =A0sensor =3D<=
br>
&gt; thermistor<br>&gt; cpu0_vid: =A0 +1.550 V<br>&gt; coretemp-isa-0000<br=
>&gt; Adapter: ISA adapter<br>&gt; Core 0: =A0 =A0 =A0+36.0=B0C =A0(crit =
=3D +100.0=B0C)<br>&gt; coretemp-isa-0001<br>&gt; Adapter: ISA adapter<br>&=
gt; Core 1: =A0 =A0 =A0+36.0=B0C =A0(crit =3D +100.0=B0C)<br>
&gt; coretemp-isa-0002<br>&gt; Adapter: ISA adapter<br>&gt; Core 2: =A0 =A0=
 =A0+34.0=B0C =A0(crit =3D +100.0=B0C)<br>&gt; coretemp-isa-0003<br>&gt; Ad=
apter: ISA adapter<br>&gt; Core 3: =A0 =A0 =A0+34.0=B0C =A0(crit =3D +100.0=
=B0C)<br>&gt; 2009/7/13 Mark E. Hansen &lt;<a href=3D"mailto:meh@winfirst.c=
om">meh@winfirst.com</a>&gt;<br>
&gt;<br>&gt;&gt; On 07/13/09 03:52, Martyn Welch wrote:<br>&gt;&gt; &gt; he=
 liang wrote:<br>&gt;&gt; &gt;&gt;<br>&gt;&gt; &gt;&gt; Just press ENTER to=
 continue:<br>&gt;&gt; &gt;&gt;<br>&gt;&gt; &gt;&gt; I will now generate th=
e commands needed to load the required modules.<br>
&gt;&gt; &gt;&gt;<br>&gt;&gt; &gt;&gt; To load everything that is needed, a=
dd this to /etc/modules:<br>&gt;&gt; &gt;&gt;<br>&gt;&gt; &gt;&gt; #----cut=
 here----<br>&gt;&gt; &gt;&gt; # Chip drivers<br>&gt;&gt; &gt;&gt; w83627eh=
f<br>
&gt;&gt; &gt;&gt; coretemp<br>&gt;&gt; &gt;&gt; #----cut here----<br>&gt;&g=
t; &gt;&gt;<br>&gt;&gt; &gt;&gt; Do you want to add these lines automatical=
ly? (yes/NO)yes<br>&gt;&gt; &gt;&gt; psy@psy-desktop:~$ &lt;mailto:<a href=
=3D"mailto:psy@psy-desktop">psy@psy-desktop</a>:%7E$&gt; sudo sensors<br>
&gt;&gt; &gt;&gt; No sensors found!<br>&gt;&gt; &gt;&gt; Make sure you load=
ed all the kernel drivers you need.<br>&gt;&gt; &gt;&gt; Try sensors-detect=
 to find out which these are.<br>&gt;&gt; &gt;&gt;<br>&gt;&gt; &gt; Have yo=
u tried rebooting? Adding those lines to &quot;/etc/modules&quot; should<br=
>
&gt;&gt; &gt; take effect after a reboot.<br>&gt;&gt; &gt;<br>&gt;&gt; &gt;=
 Try rebooting or issuing the following commands to load the modules:<br>&g=
t;&gt; &gt;<br>&gt;&gt; &gt; =A0 sudo modprobe w83627ehf<br>&gt;&gt; &gt; =
=A0 sudo modprobe coretemp<br>
&gt;&gt; &gt;<br>&gt;&gt; &gt; Hope that helps,<br>&gt;&gt; &gt;<br>&gt;&gt=
; &gt; Martyn<br>&gt;&gt; &gt;<br>&gt;&gt;<br>&gt;&gt; Also, the OP should =
try &#39;sensors -s&#39; as root (in /etc/rc.local) to<br>&gt;&gt; upload t=
he sensors configuration to the sensors chips.<br>
&gt;&gt;<br>&gt;&gt;<br>&gt;&gt; __________________________________________=
_____<br>&gt;&gt; lm-sensors mailing list<br>&gt;&gt; <a href=3D"mailto:lm-=
sensors@lm-sensors.org">lm-sensors@lm-sensors.org</a><br>&gt;&gt; <a href=
=3D"http://lists.lm-sensors.org/mailman/listinfo/lm-sensors" target=3D"_bla=
nk">http://lists.lm-sensors.org/mailman/listinfo/lm-sensors</a><br>
&gt;&gt;<br>&gt;<br><br></div></div></blockquote></div><br>

--0016e645ab9602a6de046eabbaa2--


--===============3464314582184570820==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3464314582184570820==--
