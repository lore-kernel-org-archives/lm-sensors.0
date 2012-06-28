From: Arun Raghavan <arraghav@gmail.com>
Date: Thu, 28 Jun 2012 16:20:08 +0000
Subject: Re: [lm-sensors] Reducing fan speed for w83627ehf
Message-Id: <CAP3RjSeicHLcoTtV-cjUOaJ_jPuxeytg48ymZ59bQXa8GzsrfA@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5081402670312456869=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAP3RjSfZQevwuBONgEbA0XaE_aiUik6sDdYY6ZJA+bWmZW1MQw@mail.gmail.com>
In-Reply-To: <CAP3RjSfZQevwuBONgEbA0XaE_aiUik6sDdYY6ZJA+bWmZW1MQw@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============5081402670312456869==
Content-Type: multipart/alternative; boundary=e89a8fb206788ecbda04c38ab493

--e89a8fb206788ecbda04c38ab493
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

> Can you provide the output of all pwm sysfs attributes ?
> Something like "grep . /sys/class/hwmon/hwmonX/device/pwm*" should do it,
> where
> X is the hwmon index for the NCT6775F driver (probably 1 for your system)=
.
>
> /sys/class/hwmon/hwmon1/device/pwm1:255
/sys/class/hwmon/hwmon1/device/pwm1_enable:1
/sys/class/hwmon/hwmon1/device/pwm1_max_output:255
/sys/class/hwmon/hwmon1/device/pwm1_mode:1
/sys/class/hwmon/hwmon1/device/pwm1_start_output:128
/sys/class/hwmon/hwmon1/device/pwm1_step_output:3
/sys/class/hwmon/hwmon1/device/pwm1_stop_output:128
/sys/class/hwmon/hwmon1/device/pwm1_stop_time:1000
/sys/class/hwmon/hwmon1/device/pwm1_target:41000
/sys/class/hwmon/hwmon1/device/pwm1_tolerance:1000
/sys/class/hwmon/hwmon1/device/pwm2:1
/sys/class/hwmon/hwmon1/device/pwm2_enable:1
/sys/class/hwmon/hwmon1/device/pwm2_max_output:255
/sys/class/hwmon/hwmon1/device/pwm2_mode:1
/sys/class/hwmon/hwmon1/device/pwm2_start_output:128
/sys/class/hwmon/hwmon1/device/pwm2_step_output:4
/sys/class/hwmon/hwmon1/device/pwm2_stop_output:128
/sys/class/hwmon/hwmon1/device/pwm2_stop_time:1000
/sys/class/hwmon/hwmon1/device/pwm2_target:44000
/sys/class/hwmon/hwmon1/device/pwm2_tolerance:1000
/sys/class/hwmon/hwmon1/device/pwm3:1
/sys/class/hwmon/hwmon1/device/pwm3_enable:1
/sys/class/hwmon/hwmon1/device/pwm3_max_output:255
/sys/class/hwmon/hwmon1/device/pwm3_mode:1
/sys/class/hwmon/hwmon1/device/pwm3_start_output:128
/sys/class/hwmon/hwmon1/device/pwm3_step_output:3
/sys/class/hwmon/hwmon1/device/pwm3_stop_output:128
/sys/class/hwmon/hwmon1/device/pwm3_stop_time:1000
/sys/class/hwmon/hwmon1/device/pwm3_target:41000
/sys/class/hwmon/hwmon1/device/pwm3_tolerance:1000

thanks,
-arun


> Thanks,
> Guenter
>
> > On Jun 27, 2012, at 11:53 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > > On Wed, Jun 27, 2012 at 06:18:09PM -0400, Arun Raghavan wrote:
> > >> Hi,
> > >>
> > >>> I need to get fairly fine grain control on my CPU fan speed for som=
e
> > >>
> > >>>> experiments, but I am currently unable to set the fan speed below
> 1054
> > >>> RPM.
> > >>>> pwmconfig confirms the same across the divisor range. Processor is
> > >>> i7-2600,
> > >>>> motherboard
> > >>>>
> > >>>> I tried setting pwm2_enable to 1 and pwm2 to 1 manually and I see
> that
> > >>> the
> > >>>> fan speed varies but the min RPM remains 1054.  Info below.
> > >>>>
> > >>> What happens if you write 0 into pwmX ? Also, did you select manual
> fan
> > >>> speed
> > >>> control ?
> > >>>
> > >>>
> > >> Writing 0 to pwm2 also keeps it at 1054 RPM. I'm setting pwm2_enable
> to 1,
> > >> isn't that supposed to make it manual? Also, I do see a variation
> between
> > >> 1054 RM and 2109 RPM (and some steps in between), when I change pwm2=
.
> I
> > >> can't get it to spin lower than 1054 RPM though.
> > >>
> > > Maybe that is the lowest fan speed supported by this fan ?
> > >
> > > Guenter
> > >
> > >> thanks,
> > >> -arun
> > >>
> > >>
> > >>>> so how would be very helpful.
> > >>>>
> > >>>> thanks,
> > >>>> -arun
> > >>>>
> > >>>> root@sandy:/sys/devices/platform/w83627ehf.656# echo 255 > pwm2
> > >>>> root@sandy:/sys/devices/platform/w83627ehf.656# sensors
> > >>>> coretemp-isa-0000
> > >>>> Adapter: ISA adapter
> > >>>> Any pointers on whether it is possible to reduce fan speed further=
,
> and
> > >>> if
> > >>>> Physical id 0:  +46.0=B0C  (high =3D +78.0=B0C, crit =3D +98.0=B0C=
)  ALARM
> (CRIT)
> > >>>> Core 0:         +46.0=B0C  (high =3D +78.0=B0C, crit =3D +98.0=B0C=
)  ALARM
> (CRIT)
> > >>>>
> > >>>> nct6775-isa-0290
> > >>>> Adapter: ISA adapter
> > >>>> Vcore:         +0.82 V  (min =3D  +0.00 V, max =3D  +1.74 V)
> > >>>> in1:           +1.12 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALAR=
M
> > >>>> AVCC:          +3.46 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> > >>>> +3.3V:         +3.46 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> > >>>> in4:           +1.06 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALAR=
M
> > >>>> in5:           +1.05 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALAR=
M
> > >>>> in6:           +1.08 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALAR=
M
> > >>>> 3VSB:          +3.41 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> > >>>> Vbat:          +3.34 V  (min =3D  +2.70 V, max =3D  +3.30 V)  ALAR=
M
> > >>>> fan1:            0 RPM  (min =3D    0 RPM, div =3D 128)
> > >>>> fan2:         2109 RPM  (min =3D    0 RPM, div =3D 128)  ALARM <--=
--
> > >>>> fan3:            0 RPM  (min =3D    0 RPM, div =3D 128)
> > >>>> fan4:            0 RPM  (div =3D 128)
> > >>>> SYSTIN:        +31.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)=
  ALARM
>  sensor
> > >>>> =3D CPU diode
> > >>>> CPUTIN:        +29.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)=
  sensor =3D
> CPU
> > >>>> diode
> > >>>> AUXTIN:        +22.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)=
  sensor =3D
> > >>>> thermistor
> > >>>> PECI Agent 0:  +45.5=B0C
> > >>>> cpu0_vid:     +2.050 V
> > >>>> intrusion0:   OK
> > >>>>
> > >>>> root@sandy:/sys/devices/platform/w83627ehf.656# echo 1 > pwm2
> > >>>> root@sandy:/sys/devices/platform/w83627ehf.656# sensors
> > >>>> coretemp-isa-0000
> > >>>> Adapter: ISA adapter
> > >>>> Physical id 0:  +46.0=B0C  (high =3D +78.0=B0C, crit =3D +98.0=B0C=
)  ALARM
> (CRIT)
> > >>>> Core 0:         +46.0=B0C  (high =3D +78.0=B0C, crit =3D +98.0=B0C=
)  ALARM
> (CRIT)
> > >>>>
> > >>>> nct6775-isa-0290
> > >>>> Adapter: ISA adapter
> > >>>> Vcore:         +0.85 V  (min =3D  +0.00 V, max =3D  +1.74 V)
> > >>>> in1:           +1.12 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALAR=
M
> > >>>> AVCC:          +3.46 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> > >>>> +3.3V:         +3.46 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> > >>>> in4:           +1.06 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALAR=
M
> > >>>> in5:           +1.05 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALAR=
M
> > >>>> in6:           +1.08 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALAR=
M
> > >>>> 3VSB:          +3.41 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> > >>>> Vbat:          +3.34 V  (min =3D  +2.70 V, max =3D  +3.30 V)  ALAR=
M
> > >>>> fan1:            0 RPM  (min =3D    0 RPM, div =3D 128)
> > >>>> fan2:         1054 RPM  (min =3D    0 RPM, div =3D 128)  ALARM
> > >>>> fan3:            0 RPM  (min =3D    0 RPM, div =3D 128)
> > >>>> fan4:            0 RPM  (div =3D 128)
> > >>>> SYSTIN:        +30.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)=
  ALARM
>  sensor
> > >>>> =3D CPU diode
> > >>>> CPUTIN:        +29.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)=
  sensor =3D
> CPU
> > >>>> diode
> > >>>> AUXTIN:        +22.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)=
  sensor =3D
> > >>>> thermistor
> > >>>> PECI Agent 0:  +44.5=B0C
> > >>>> cpu0_vid:     +2.050 V
> > >>>> intrusion0:   OK
> > >>>
> > >>>> _______________________________________________
> > >>>> lm-sensors mailing list
> > >>>> lm-sensors@lm-sensors.org
> > >>>> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> > >>>
> > >>>
> >
>

--e89a8fb206788ecbda04c38ab493
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Can you provide the output of all pwm sysfs attributes ?<br>
Something like &quot;grep . /sys/class/hwmon/hwmonX/device/pwm*&quot; shoul=
d do it, where<br>
X is the hwmon index for the NCT6775F driver (probably 1 for your system).<=
br>
<br></blockquote><div>/sys/class/hwmon/hwmon1/device/pwm1:255<br>/sys/class=
/hwmon/hwmon1/device/pwm1_enable:1<br>/sys/class/hwmon/hwmon1/device/pwm1_m=
ax_output:255<br>/sys/class/hwmon/hwmon1/device/pwm1_mode:1<br>/sys/class/h=
wmon/hwmon1/device/pwm1_start_output:128<br>
/sys/class/hwmon/hwmon1/device/pwm1_step_output:3<br>/sys/class/hwmon/hwmon=
1/device/pwm1_stop_output:128<br>/sys/class/hwmon/hwmon1/device/pwm1_stop_t=
ime:1000<br>/sys/class/hwmon/hwmon1/device/pwm1_target:41000<br>/sys/class/=
hwmon/hwmon1/device/pwm1_tolerance:1000<br>
/sys/class/hwmon/hwmon1/device/pwm2:1<br>/sys/class/hwmon/hwmon1/device/pwm=
2_enable:1<br>/sys/class/hwmon/hwmon1/device/pwm2_max_output:255<br>/sys/cl=
ass/hwmon/hwmon1/device/pwm2_mode:1<br>/sys/class/hwmon/hwmon1/device/pwm2_=
start_output:128<br>
/sys/class/hwmon/hwmon1/device/pwm2_step_output:4<br>/sys/class/hwmon/hwmon=
1/device/pwm2_stop_output:128<br>/sys/class/hwmon/hwmon1/device/pwm2_stop_t=
ime:1000<br>/sys/class/hwmon/hwmon1/device/pwm2_target:44000<br>/sys/class/=
hwmon/hwmon1/device/pwm2_tolerance:1000<br>
/sys/class/hwmon/hwmon1/device/pwm3:1<br>/sys/class/hwmon/hwmon1/device/pwm=
3_enable:1<br>/sys/class/hwmon/hwmon1/device/pwm3_max_output:255<br>/sys/cl=
ass/hwmon/hwmon1/device/pwm3_mode:1<br>/sys/class/hwmon/hwmon1/device/pwm3_=
start_output:128<br>
/sys/class/hwmon/hwmon1/device/pwm3_step_output:3<br>/sys/class/hwmon/hwmon=
1/device/pwm3_stop_output:128<br>/sys/class/hwmon/hwmon1/device/pwm3_stop_t=
ime:1000<br>/sys/class/hwmon/hwmon1/device/pwm3_target:41000<br>/sys/class/=
hwmon/hwmon1/device/pwm3_tolerance:1000<br>
<br>thanks,<br>-arun<br>=A0<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
Thanks,<br>
Guenter<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; On Jun 27, 2012, at 11:53 PM, Guenter Roeck &lt;<a href=3D"mailto:linu=
x@roeck-us.net">linux@roeck-us.net</a>&gt; wrote:<br>
&gt;<br>
&gt; &gt; On Wed, Jun 27, 2012 at 06:18:09PM -0400, Arun Raghavan wrote:<br=
>
&gt; &gt;&gt; Hi,<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt; I need to get fairly fine grain control on my CPU fan spe=
ed for some<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; experiments, but I am currently unable to set the fan=
 speed below 1054<br>
&gt; &gt;&gt;&gt; RPM.<br>
&gt; &gt;&gt;&gt;&gt; pwmconfig confirms the same across the divisor range.=
 Processor is<br>
&gt; &gt;&gt;&gt; i7-2600,<br>
&gt; &gt;&gt;&gt;&gt; motherboard<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; I tried setting pwm2_enable to 1 and pwm2 to 1 manual=
ly and I see that<br>
&gt; &gt;&gt;&gt; the<br>
&gt; &gt;&gt;&gt;&gt; fan speed varies but the min RPM remains 1054. =A0Inf=
o below.<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; What happens if you write 0 into pwmX ? Also, did you sel=
ect manual fan<br>
&gt; &gt;&gt;&gt; speed<br>
&gt; &gt;&gt;&gt; control ?<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt; Writing 0 to pwm2 also keeps it at 1054 RPM. I&#39;m setting =
pwm2_enable to 1,<br>
&gt; &gt;&gt; isn&#39;t that supposed to make it manual? Also, I do see a v=
ariation between<br>
&gt; &gt;&gt; 1054 RM and 2109 RPM (and some steps in between), when I chan=
ge pwm2. I<br>
&gt; &gt;&gt; can&#39;t get it to spin lower than 1054 RPM though.<br>
&gt; &gt;&gt;<br>
&gt; &gt; Maybe that is the lowest fan speed supported by this fan ?<br>
&gt; &gt;<br>
&gt; &gt; Guenter<br>
&gt; &gt;<br>
&gt; &gt;&gt; thanks,<br>
&gt; &gt;&gt; -arun<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; so how would be very helpful.<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; thanks,<br>
&gt; &gt;&gt;&gt;&gt; -arun<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; root@sandy:/sys/devices/platform/w83627ehf.656# echo =
255 &gt; pwm2<br>
&gt; &gt;&gt;&gt;&gt; root@sandy:/sys/devices/platform/w83627ehf.656# senso=
rs<br>
&gt; &gt;&gt;&gt;&gt; coretemp-isa-0000<br>
&gt; &gt;&gt;&gt;&gt; Adapter: ISA adapter<br>
&gt; &gt;&gt;&gt;&gt; Any pointers on whether it is possible to reduce fan =
speed further, and<br>
&gt; &gt;&gt;&gt; if<br>
&gt; &gt;&gt;&gt;&gt; Physical id 0: =A0+46.0=B0C =A0(high =3D +78.0=B0C, c=
rit =3D +98.0=B0C) =A0ALARM (CRIT)<br>
&gt; &gt;&gt;&gt;&gt; Core 0: =A0 =A0 =A0 =A0 +46.0=B0C =A0(high =3D +78.0=
=B0C, crit =3D +98.0=B0C) =A0ALARM (CRIT)<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; nct6775-isa-0290<br>
&gt; &gt;&gt;&gt;&gt; Adapter: ISA adapter<br>
&gt; &gt;&gt;&gt;&gt; Vcore: =A0 =A0 =A0 =A0 +0.82 V =A0(min =3D =A0+0.00 V=
, max =3D =A0+1.74 V)<br>
&gt; &gt;&gt;&gt;&gt; in1: =A0 =A0 =A0 =A0 =A0 +1.12 V =A0(min =3D =A0+0.00=
 V, max =3D =A0+0.00 V) =A0ALARM<br>
&gt; &gt;&gt;&gt;&gt; AVCC: =A0 =A0 =A0 =A0 =A0+3.46 V =A0(min =3D =A0+2.98=
 V, max =3D =A0+3.63 V)<br>
&gt; &gt;&gt;&gt;&gt; +3.3V: =A0 =A0 =A0 =A0 +3.46 V =A0(min =3D =A0+2.98 V=
, max =3D =A0+3.63 V)<br>
&gt; &gt;&gt;&gt;&gt; in4: =A0 =A0 =A0 =A0 =A0 +1.06 V =A0(min =3D =A0+0.00=
 V, max =3D =A0+0.00 V) =A0ALARM<br>
&gt; &gt;&gt;&gt;&gt; in5: =A0 =A0 =A0 =A0 =A0 +1.05 V =A0(min =3D =A0+0.00=
 V, max =3D =A0+0.00 V) =A0ALARM<br>
&gt; &gt;&gt;&gt;&gt; in6: =A0 =A0 =A0 =A0 =A0 +1.08 V =A0(min =3D =A0+0.00=
 V, max =3D =A0+0.00 V) =A0ALARM<br>
&gt; &gt;&gt;&gt;&gt; 3VSB: =A0 =A0 =A0 =A0 =A0+3.41 V =A0(min =3D =A0+2.98=
 V, max =3D =A0+3.63 V)<br>
&gt; &gt;&gt;&gt;&gt; Vbat: =A0 =A0 =A0 =A0 =A0+3.34 V =A0(min =3D =A0+2.70=
 V, max =3D =A0+3.30 V) =A0ALARM<br>
&gt; &gt;&gt;&gt;&gt; fan1: =A0 =A0 =A0 =A0 =A0 =A00 RPM =A0(min =3D =A0 =
=A00 RPM, div =3D 128)<br>
&gt; &gt;&gt;&gt;&gt; fan2: =A0 =A0 =A0 =A0 2109 RPM =A0(min =3D =A0 =A00 R=
PM, div =3D 128) =A0ALARM &lt;----<br>
&gt; &gt;&gt;&gt;&gt; fan3: =A0 =A0 =A0 =A0 =A0 =A00 RPM =A0(min =3D =A0 =
=A00 RPM, div =3D 128)<br>
&gt; &gt;&gt;&gt;&gt; fan4: =A0 =A0 =A0 =A0 =A0 =A00 RPM =A0(div =3D 128)<b=
r>
&gt; &gt;&gt;&gt;&gt; SYSTIN: =A0 =A0 =A0 =A0+31.0=B0C =A0(high =3D =A0+0.0=
=B0C, hyst =3D =A0+0.0=B0C) =A0ALARM =A0sensor<br>
&gt; &gt;&gt;&gt;&gt; =3D CPU diode<br>
&gt; &gt;&gt;&gt;&gt; CPUTIN: =A0 =A0 =A0 =A0+29.5=B0C =A0(high =3D +80.0=
=B0C, hyst =3D +75.0=B0C) =A0sensor =3D CPU<br>
&gt; &gt;&gt;&gt;&gt; diode<br>
&gt; &gt;&gt;&gt;&gt; AUXTIN: =A0 =A0 =A0 =A0+22.0=B0C =A0(high =3D +80.0=
=B0C, hyst =3D +75.0=B0C) =A0sensor =3D<br>
&gt; &gt;&gt;&gt;&gt; thermistor<br>
&gt; &gt;&gt;&gt;&gt; PECI Agent 0: =A0+45.5=B0C<br>
&gt; &gt;&gt;&gt;&gt; cpu0_vid: =A0 =A0 +2.050 V<br>
&gt; &gt;&gt;&gt;&gt; intrusion0: =A0 OK<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; root@sandy:/sys/devices/platform/w83627ehf.656# echo =
1 &gt; pwm2<br>
&gt; &gt;&gt;&gt;&gt; root@sandy:/sys/devices/platform/w83627ehf.656# senso=
rs<br>
&gt; &gt;&gt;&gt;&gt; coretemp-isa-0000<br>
&gt; &gt;&gt;&gt;&gt; Adapter: ISA adapter<br>
&gt; &gt;&gt;&gt;&gt; Physical id 0: =A0+46.0=B0C =A0(high =3D +78.0=B0C, c=
rit =3D +98.0=B0C) =A0ALARM (CRIT)<br>
&gt; &gt;&gt;&gt;&gt; Core 0: =A0 =A0 =A0 =A0 +46.0=B0C =A0(high =3D +78.0=
=B0C, crit =3D +98.0=B0C) =A0ALARM (CRIT)<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; nct6775-isa-0290<br>
&gt; &gt;&gt;&gt;&gt; Adapter: ISA adapter<br>
&gt; &gt;&gt;&gt;&gt; Vcore: =A0 =A0 =A0 =A0 +0.85 V =A0(min =3D =A0+0.00 V=
, max =3D =A0+1.74 V)<br>
&gt; &gt;&gt;&gt;&gt; in1: =A0 =A0 =A0 =A0 =A0 +1.12 V =A0(min =3D =A0+0.00=
 V, max =3D =A0+0.00 V) =A0ALARM<br>
&gt; &gt;&gt;&gt;&gt; AVCC: =A0 =A0 =A0 =A0 =A0+3.46 V =A0(min =3D =A0+2.98=
 V, max =3D =A0+3.63 V)<br>
&gt; &gt;&gt;&gt;&gt; +3.3V: =A0 =A0 =A0 =A0 +3.46 V =A0(min =3D =A0+2.98 V=
, max =3D =A0+3.63 V)<br>
&gt; &gt;&gt;&gt;&gt; in4: =A0 =A0 =A0 =A0 =A0 +1.06 V =A0(min =3D =A0+0.00=
 V, max =3D =A0+0.00 V) =A0ALARM<br>
&gt; &gt;&gt;&gt;&gt; in5: =A0 =A0 =A0 =A0 =A0 +1.05 V =A0(min =3D =A0+0.00=
 V, max =3D =A0+0.00 V) =A0ALARM<br>
&gt; &gt;&gt;&gt;&gt; in6: =A0 =A0 =A0 =A0 =A0 +1.08 V =A0(min =3D =A0+0.00=
 V, max =3D =A0+0.00 V) =A0ALARM<br>
&gt; &gt;&gt;&gt;&gt; 3VSB: =A0 =A0 =A0 =A0 =A0+3.41 V =A0(min =3D =A0+2.98=
 V, max =3D =A0+3.63 V)<br>
&gt; &gt;&gt;&gt;&gt; Vbat: =A0 =A0 =A0 =A0 =A0+3.34 V =A0(min =3D =A0+2.70=
 V, max =3D =A0+3.30 V) =A0ALARM<br>
&gt; &gt;&gt;&gt;&gt; fan1: =A0 =A0 =A0 =A0 =A0 =A00 RPM =A0(min =3D =A0 =
=A00 RPM, div =3D 128)<br>
&gt; &gt;&gt;&gt;&gt; fan2: =A0 =A0 =A0 =A0 1054 RPM =A0(min =3D =A0 =A00 R=
PM, div =3D 128) =A0ALARM<br>
&gt; &gt;&gt;&gt;&gt; fan3: =A0 =A0 =A0 =A0 =A0 =A00 RPM =A0(min =3D =A0 =
=A00 RPM, div =3D 128)<br>
&gt; &gt;&gt;&gt;&gt; fan4: =A0 =A0 =A0 =A0 =A0 =A00 RPM =A0(div =3D 128)<b=
r>
&gt; &gt;&gt;&gt;&gt; SYSTIN: =A0 =A0 =A0 =A0+30.0=B0C =A0(high =3D =A0+0.0=
=B0C, hyst =3D =A0+0.0=B0C) =A0ALARM =A0sensor<br>
&gt; &gt;&gt;&gt;&gt; =3D CPU diode<br>
&gt; &gt;&gt;&gt;&gt; CPUTIN: =A0 =A0 =A0 =A0+29.5=B0C =A0(high =3D +80.0=
=B0C, hyst =3D +75.0=B0C) =A0sensor =3D CPU<br>
&gt; &gt;&gt;&gt;&gt; diode<br>
&gt; &gt;&gt;&gt;&gt; AUXTIN: =A0 =A0 =A0 =A0+22.0=B0C =A0(high =3D +80.0=
=B0C, hyst =3D +75.0=B0C) =A0sensor =3D<br>
&gt; &gt;&gt;&gt;&gt; thermistor<br>
&gt; &gt;&gt;&gt;&gt; PECI Agent 0: =A0+44.5=B0C<br>
&gt; &gt;&gt;&gt;&gt; cpu0_vid: =A0 =A0 +2.050 V<br>
&gt; &gt;&gt;&gt;&gt; intrusion0: =A0 OK<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; _______________________________________________<br>
&gt; &gt;&gt;&gt;&gt; lm-sensors mailing list<br>
&gt; &gt;&gt;&gt;&gt; <a href=3D"mailto:lm-sensors@lm-sensors.org">lm-senso=
rs@lm-sensors.org</a><br>
&gt; &gt;&gt;&gt;&gt; <a href=3D"http://lists.lm-sensors.org/mailman/listin=
fo/lm-sensors" target=3D"_blank">http://lists.lm-sensors.org/mailman/listin=
fo/lm-sensors</a><br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;<br>
&gt;<br>
</div></div></blockquote></div><br>

--e89a8fb206788ecbda04c38ab493--


--===============5081402670312456869==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5081402670312456869==--
