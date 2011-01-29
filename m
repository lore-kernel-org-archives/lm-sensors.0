From: Dylan <dylan.parker@gmail.com>
Date: Sat, 29 Jan 2011 19:54:47 +0000
Subject: [lm-sensors] Fluctuating min/max/div causing alarms
Message-Id: <AANLkTik+SWY4Ka8oCH+rcApNsd6DufNriKR2f6hFYCkJ@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4209197261053416084=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============4209197261053416084==
Content-Type: multipart/alternative; boundary=001517479648445280049b018f88

--001517479648445280049b018f88
Content-Type: text/plain; charset=ISO-8859-1

Hello all.

I've done my best so far to solve my problems with information available but
I've hit a rut and I'm hoping I can get help here.

I have a SuperMicro X8SIL-F motherboard with a WinBond W8367DHG sensor chip.
The CPU is an Intel Xeon X3440 running stock at 2.53GHz.
I am running UNRAID v4.7 which is based on Slackware kernel 2.6.32
This came with sensors v3.0.3 and libsensors v3.0.3.

I have tweaked my sensors3.conf based on comparable systems as well as the
thresholds specified via the boards IPMI interface.

PROBLEM: Upon booting the sensors readout displays reasonable values and all
the min/max values are as I set them. No ALARMs visible.
Within hours (minutes?) various min/max values change causing the reasonable
voltage/rpm/temp to now be out of range... resulting in ALARMs being raised.

QUESTION: What is causing, say, the VBAT min value to suddenly change from
my setting of +2.82V to 0V? Or the min RPM for HD FAN 2 to change from
400RPM to 0RPM?

Simply executing "sensors -s" again changes the values back and clears the
ALARMs, but this is not feasible to do this multiple times per day after
confirming the ALARMs are false.

On a slight aside, I am unable to set the div values on my fans and the
associated /sys/class/hwmon4/device/fanX_div files are read-only.

As these values change causing ALARMs to be thrown in the sensors output,
there is no related events in the IPMI sensor logs.

Any help appreciated!

Find below the relevant section from my sensors3.conf file.

Dylan


# Winbond W83627EHF configuration originally contributed by Leon Moonen
# This is for an Asus P5P800, voltages for A8V-E SE.
chip "w83627ehf-*" "w83627dhg-*"

    label in0 "VCore"
    label in1 "+12V"
    label in2 "AVCC"
    label in3 "+3.3VCC"
    label in4 "CPU DIMM"
    label in5 "-12V"
    label in6 "+5V"
    label in7 "+3.3VSB"
    label in8 "VBAT"

# +12V is in1 and +5V is in6 as recommended by datasheet
# -12V is in5 by process of elimination

    compute in1 @*(1+(56/10)),  @/(1+(56/10))
    compute in5 -@*(1+(90/10)), -@/(1+(90/10))
    compute in6 @*(1+(25/10)),  @/(1+(25/10))

# Thresholds based on LowCT and HighCT values from IPMI interface

    set in0_min   1.1*0.6
    set in0_max   1.1*1.27
    set in1_min   12.24*0.86
    set in1_max   12.24*1.08
    set in4_min   1.52*0.8
    set in4_max   1.52*1.17
    set in5_min   -12.68*0.85
    set in5_max   -12.68*1.08
    set in6_min   5.1*0.85
    set in6_max   5.1*1.1

# Set the 3.3V
    set in2_min   3.3*0.87
    set in2_max   3.3*1.1
    set in3_min   3.3*0.87
    set in3_max   3.3*1.1
    set in7_min   3.3*0.87
    set in7_max   3.3*1.1
    set in8_min   3.1*0.91
    set in8_max   3.1*1.16

# Fans
   ignore fan1
   label fan2      "CPU Fan"
   set fan2_min    400
   label fan3      "HD Fan 1"
   set fan3_min    400
   label fan4      "Aux Fan"
   set fan4_min    400
   label fan5      "HD Fan 2"
   set fan5_min    400

# Temperatures
   label temp1     "Sys Temp"
   label temp2     "CPU Temp"
   label temp3     "AUX Temp"

   set temp1_max       60
   set temp1_max_hyst  55
   set temp2_max       85
   set temp2_max_hyst  80
   set temp3_max       55
   set temp3_max_hyst  50

Dylan

--001517479648445280049b018f88
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello all.<div><br></div><div>I&#39;ve done my best so far to solve my prob=
lems with information available but I&#39;ve hit a rut and I&#39;m hoping I=
 can get help here.</div><div><br></div><div>I have a SuperMicro X8SIL-F mo=
therboard with a WinBond W8367DHG sensor chip.</div>

<div>The CPU is an Intel Xeon X3440 running stock at 2.53GHz.</div><div>I a=
m running UNRAID v4.7 which is based on Slackware kernel 2.6.32</div><div>T=
his came with sensors v3.0.3 and libsensors v3.0.3.</div><div><br></div>

<div>I have tweaked my sensors3.conf based on comparable systems as well as=
 the thresholds specified via the boards IPMI interface.</div><div><br></di=
v><div>PROBLEM: Upon booting the sensors readout displays reasonable values=
 and all the min/max values are as I set them. No ALARMs visible.</div>

<div>Within hours (minutes?) various min/max values change causing the reas=
onable voltage/rpm/temp to now be out of range... resulting in ALARMs being=
 raised.</div><div><br></div><div>QUESTION: What is causing, say, the VBAT =
min value to suddenly change from my setting of +2.82V to 0V? Or the min RP=
M for HD FAN 2 to change from 400RPM to 0RPM?</div>

<div><br></div><div>Simply executing &quot;sensors -s&quot; again changes t=
he values back and clears the ALARMs, but this is not feasible to do this m=
ultiple times per day after confirming the ALARMs are false.</div><div>

<br></div><div>On a slight aside, I am unable to set the div values on my f=
ans and the associated /sys/class/hwmon4/device/fanX_div files are read-onl=
y.</div><div><br></div><div>As these values change causing ALARMs to be thr=
own in the sensors output, there is no related events in the IPMI sensor lo=
gs.</div>

<div><br></div><div>Any help appreciated!</div><div><br></div><div>Find bel=
ow the relevant section from my sensors3.conf file.</div><div><br></div><di=
v>Dylan</div><div><br></div><div><font class=3D"Apple-style-span" face=3D"&=
#39;courier new&#39;, monospace"><br>

</font></div><div><div><font class=3D"Apple-style-span" face=3D"&#39;courie=
r new&#39;, monospace"># Winbond W83627EHF configuration originally contrib=
uted by Leon Moonen</font></div><div><font class=3D"Apple-style-span" face=
=3D"&#39;courier new&#39;, monospace"># This is for an Asus P5P800, voltage=
s for A8V-E SE.</font></div>

<div><font class=3D"Apple-style-span" face=3D"&#39;courier new&#39;, monosp=
ace">chip &quot;w83627ehf-*&quot; &quot;w83627dhg-*&quot;</font></div><div>=
<font class=3D"Apple-style-span" face=3D"&#39;courier new&#39;, monospace">=
<br>

</font></div><div><font class=3D"Apple-style-span" face=3D"&#39;courier new=
&#39;, monospace">=A0=A0 =A0label in0 &quot;VCore&quot;</font></div><div><f=
ont class=3D"Apple-style-span" face=3D"&#39;courier new&#39;, monospace">=
=A0=A0 =A0label in1 &quot;+12V&quot;</font></div>

<div><font class=3D"Apple-style-span" face=3D"&#39;courier new&#39;, monosp=
ace">=A0=A0 =A0label in2 &quot;AVCC&quot;</font></div><div><font class=3D"A=
pple-style-span" face=3D"&#39;courier new&#39;, monospace">=A0=A0 =A0label =
in3 &quot;+3.3VCC&quot;</font></div>

<div><font class=3D"Apple-style-span" face=3D"&#39;courier new&#39;, monosp=
ace">=A0=A0 =A0label in4 &quot;CPU DIMM&quot;</font></div><div><font class=
=3D"Apple-style-span" face=3D"&#39;courier new&#39;, monospace">=A0=A0 =A0l=
abel in5 &quot;-12V&quot;</font></div>

<div><font class=3D"Apple-style-span" face=3D"&#39;courier new&#39;, monosp=
ace">=A0=A0 =A0label in6 &quot;+5V&quot;</font></div><div><font class=3D"Ap=
ple-style-span" face=3D"&#39;courier new&#39;, monospace">=A0=A0 =A0label i=
n7 &quot;+3.3VSB&quot;</font></div>

<div><font class=3D"Apple-style-span" face=3D"&#39;courier new&#39;, monosp=
ace">=A0=A0 =A0label in8 &quot;VBAT&quot;</font></div><div><font class=3D"A=
pple-style-span" face=3D"&#39;courier new&#39;, monospace"><br></font></div=
><div><font class=3D"Apple-style-span" face=3D"&#39;courier new&#39;, monos=
pace"># +12V is in1 and +5V is in6 as recommended by datasheet</font></div>

<div><font class=3D"Apple-style-span" face=3D"&#39;courier new&#39;, monosp=
ace"># -12V is in5 by process of elimination</font></div><div><font class=
=3D"Apple-style-span" face=3D"&#39;courier new&#39;, monospace"><br></font>=
</div>

<div><font class=3D"Apple-style-span" face=3D"&#39;courier new&#39;, monosp=
ace">=A0=A0 =A0compute in1 @*(1+(56/10)), =A0@/(1+(56/10))</font></div><div=
><font class=3D"Apple-style-span" face=3D"&#39;courier new&#39;, monospace"=
>=A0=A0 =A0compute in5 -@*(1+(90/10)), -@/(1+(90/10))</font></div>

<div><font class=3D"Apple-style-span" face=3D"&#39;courier new&#39;, monosp=
ace">=A0=A0 =A0compute in6 @*(1+(25/10)), =A0@/(1+(25/10))</font></div><div=
><font class=3D"Apple-style-span" face=3D"&#39;courier new&#39;, monospace"=
><br></font></div>

<div><font class=3D"Apple-style-span" face=3D"&#39;courier new&#39;, monosp=
ace"># Thresholds based on LowCT and HighCT values from IPMI interface</fon=
t></div><div><font class=3D"Apple-style-span" face=3D"&#39;courier new&#39;=
, monospace"><br>

</font></div><div><font class=3D"Apple-style-span" face=3D"&#39;courier new=
&#39;, monospace">=A0=A0 =A0set in0_min =A0 1.1*0.6</font></div><div><font =
class=3D"Apple-style-span" face=3D"&#39;courier new&#39;, monospace">=A0=A0=
 =A0set in0_max =A0 1.1*1.27</font></div>

<div><font class=3D"Apple-style-span" face=3D"&#39;courier new&#39;, monosp=
ace">=A0=A0 =A0set in1_min =A0 12.24*0.86</font></div><div><font class=3D"A=
pple-style-span" face=3D"&#39;courier new&#39;, monospace">=A0=A0 =A0set in=
1_max =A0 12.24*1.08</font></div>

<div><font class=3D"Apple-style-span" face=3D"&#39;courier new&#39;, monosp=
ace">=A0=A0 =A0set in4_min =A0 1.52*0.8</font></div><div><font class=3D"App=
le-style-span" face=3D"&#39;courier new&#39;, monospace">=A0=A0 =A0set in4_=
max =A0 1.52*1.17</font></div>

<div><font class=3D"Apple-style-span" face=3D"&#39;courier new&#39;, monosp=
ace">=A0=A0 =A0set in5_min =A0 -12.68*0.85</font></div><div><font class=3D"=
Apple-style-span" face=3D"&#39;courier new&#39;, monospace">=A0=A0 =A0set i=
n5_max =A0 -12.68*1.08</font></div>

<div><font class=3D"Apple-style-span" face=3D"&#39;courier new&#39;, monosp=
ace">=A0=A0 =A0set in6_min =A0 5.1*0.85</font></div><div><font class=3D"App=
le-style-span" face=3D"&#39;courier new&#39;, monospace">=A0=A0 =A0set in6_=
max =A0 5.1*1.1</font></div>

<div><font class=3D"Apple-style-span" face=3D"&#39;courier new&#39;, monosp=
ace"><br></font></div><div><font class=3D"Apple-style-span" face=3D"&#39;co=
urier new&#39;, monospace"># Set the 3.3V</font></div><div><font class=3D"A=
pple-style-span" face=3D"&#39;courier new&#39;, monospace">=A0=A0 =A0set in=
2_min =A0 3.3*0.87</font></div>

<div><font class=3D"Apple-style-span" face=3D"&#39;courier new&#39;, monosp=
ace">=A0=A0 =A0set in2_max =A0 3.3*1.1</font></div><div><font class=3D"Appl=
e-style-span" face=3D"&#39;courier new&#39;, monospace">=A0=A0 =A0set in3_m=
in =A0 3.3*0.87</font></div>

<div><font class=3D"Apple-style-span" face=3D"&#39;courier new&#39;, monosp=
ace">=A0=A0 =A0set in3_max =A0 3.3*1.1</font></div><div><font class=3D"Appl=
e-style-span" face=3D"&#39;courier new&#39;, monospace">=A0=A0 =A0set in7_m=
in =A0 3.3*0.87</font></div>

<div><font class=3D"Apple-style-span" face=3D"&#39;courier new&#39;, monosp=
ace">=A0=A0 =A0set in7_max =A0 3.3*1.1</font></div><div><font class=3D"Appl=
e-style-span" face=3D"&#39;courier new&#39;, monospace">=A0=A0 =A0set in8_m=
in =A0 3.1*0.91</font></div>

<div><font class=3D"Apple-style-span" face=3D"&#39;courier new&#39;, monosp=
ace">=A0=A0 =A0set in8_max =A0 3.1*1.16</font></div></div><div><font class=
=3D"Apple-style-span" face=3D"&#39;courier new&#39;, monospace"><br></font>=
</div><div><div>

<font class=3D"Apple-style-span" face=3D"&#39;courier new&#39;, monospace">=
# Fans</font></div><div><font class=3D"Apple-style-span" face=3D"&#39;couri=
er new&#39;, monospace">=A0=A0 ignore fan1</font></div><div><font class=3D"=
Apple-style-span" face=3D"&#39;courier new&#39;, monospace">=A0=A0 label fa=
n2 =A0 =A0 =A0&quot;CPU Fan&quot;</font></div>

<div><font class=3D"Apple-style-span" face=3D"&#39;courier new&#39;, monosp=
ace">=A0=A0 set fan2_min =A0 =A0400</font></div><div><font class=3D"Apple-s=
tyle-span" face=3D"&#39;courier new&#39;, monospace">=A0=A0 label fan3 =A0 =
=A0 =A0&quot;HD Fan 1&quot;</font></div>

<div><font class=3D"Apple-style-span" face=3D"&#39;courier new&#39;, monosp=
ace">=A0=A0 set fan3_min =A0 =A0400</font></div><div><font class=3D"Apple-s=
tyle-span" face=3D"&#39;courier new&#39;, monospace">=A0=A0 label fan4 =A0 =
=A0 =A0&quot;Aux Fan&quot;</font></div>

<div><font class=3D"Apple-style-span" face=3D"&#39;courier new&#39;, monosp=
ace">=A0=A0 set fan4_min =A0 =A0400</font></div><div><font class=3D"Apple-s=
tyle-span" face=3D"&#39;courier new&#39;, monospace">=A0=A0 label fan5 =A0 =
=A0 =A0&quot;HD Fan 2&quot;</font></div>

<div><font class=3D"Apple-style-span" face=3D"&#39;courier new&#39;, monosp=
ace">=A0=A0 set fan5_min =A0 =A0400</font></div><div><font class=3D"Apple-s=
tyle-span" face=3D"&#39;courier new&#39;, monospace"><br></font></div><div>=
<font class=3D"Apple-style-span" face=3D"&#39;courier new&#39;, monospace">=
# Temperatures</font></div>

<div><font class=3D"Apple-style-span" face=3D"&#39;courier new&#39;, monosp=
ace">=A0=A0 label temp1 =A0 =A0 &quot;Sys Temp&quot;</font></div><div><font=
 class=3D"Apple-style-span" face=3D"&#39;courier new&#39;, monospace">=A0=
=A0 label temp2 =A0 =A0 &quot;CPU Temp&quot;</font></div>

<div><font class=3D"Apple-style-span" face=3D"&#39;courier new&#39;, monosp=
ace">=A0=A0 label temp3 =A0 =A0 &quot;AUX Temp&quot;</font></div><div><font=
 class=3D"Apple-style-span" face=3D"&#39;courier new&#39;, monospace"><br><=
/font></div>

<div><font class=3D"Apple-style-span" face=3D"&#39;courier new&#39;, monosp=
ace">=A0=A0 set temp1_max =A0 =A0 =A0 60</font></div><div><font class=3D"Ap=
ple-style-span" face=3D"&#39;courier new&#39;, monospace">=A0=A0 set temp1_=
max_hyst =A055</font></div>

<div><font class=3D"Apple-style-span" face=3D"&#39;courier new&#39;, monosp=
ace">=A0=A0 set temp2_max =A0 =A0 =A0 85</font></div><div><font class=3D"Ap=
ple-style-span" face=3D"&#39;courier new&#39;, monospace">=A0=A0 set temp2_=
max_hyst =A080</font></div>

<div><font class=3D"Apple-style-span" face=3D"&#39;courier new&#39;, monosp=
ace">=A0=A0 set temp3_max =A0 =A0 =A0 55</font></div><div><font class=3D"Ap=
ple-style-span" face=3D"&#39;courier new&#39;, monospace">=A0=A0 set temp3_=
max_hyst =A050</font></div>

</div><div><br></div><div>Dylan</div>

--001517479648445280049b018f88--


--===============4209197261053416084==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4209197261053416084==--
