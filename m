From: Arun Raghavan <arraghav@gmail.com>
Date: Wed, 27 Jun 2012 22:18:09 +0000
Subject: Re: [lm-sensors] Reducing fan speed for w83627ehf
Message-Id: <CAP3RjSeM4TQ77a4KkrTayps8pmTsedzKnGpYErQhhBjvoPMvJA@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2665763160574277092=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAP3RjSfZQevwuBONgEbA0XaE_aiUik6sDdYY6ZJA+bWmZW1MQw@mail.gmail.com>
In-Reply-To: <CAP3RjSfZQevwuBONgEbA0XaE_aiUik6sDdYY6ZJA+bWmZW1MQw@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============2665763160574277092==
Content-Type: multipart/alternative; boundary=f46d044788171261d304c37b9773

--f46d044788171261d304c37b9773
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

> I need to get fairly fine grain control on my CPU fan speed for some

> > experiments, but I am currently unable to set the fan speed below 1054
> RPM.
> > pwmconfig confirms the same across the divisor range. Processor is
> i7-2600,
> > motherboard
> >
> > I tried setting pwm2_enable to 1 and pwm2 to 1 manually and I see that
> the
> > fan speed varies but the min RPM remains 1054.  Info below.
> >
> What happens if you write 0 into pwmX ? Also, did you select manual fan
> speed
> control ?
>
>
Writing 0 to pwm2 also keeps it at 1054 RPM. I'm setting pwm2_enable to 1,
isn't that supposed to make it manual? Also, I do see a variation between
1054 RM and 2109 RPM (and some steps in between), when I change pwm2. I
can't get it to spin lower than 1054 RPM though.

thanks,
-arun


> > so how would be very helpful.
> >
> > thanks,
> > -arun
> >
> > root@sandy:/sys/devices/platform/w83627ehf.656# echo 255 > pwm2
> > root@sandy:/sys/devices/platform/w83627ehf.656# sensors
> > coretemp-isa-0000
> > Adapter: ISA adapter
> > Any pointers on whether it is possible to reduce fan speed further, and
> if
> > Physical id 0:  +46.0=B0C  (high =3D +78.0=B0C, crit =3D +98.0=B0C)  AL=
ARM (CRIT)
> > Core 0:         +46.0=B0C  (high =3D +78.0=B0C, crit =3D +98.0=B0C)  AL=
ARM (CRIT)
> >
> > nct6775-isa-0290
> > Adapter: ISA adapter
> > Vcore:         +0.82 V  (min =3D  +0.00 V, max =3D  +1.74 V)
> > in1:           +1.12 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> > AVCC:          +3.46 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> > +3.3V:         +3.46 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> > in4:           +1.06 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> > in5:           +1.05 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> > in6:           +1.08 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> > 3VSB:          +3.41 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> > Vbat:          +3.34 V  (min =3D  +2.70 V, max =3D  +3.30 V)  ALARM
> > fan1:            0 RPM  (min =3D    0 RPM, div =3D 128)
> > fan2:         2109 RPM  (min =3D    0 RPM, div =3D 128)  ALARM <----
> > fan3:            0 RPM  (min =3D    0 RPM, div =3D 128)
> > fan4:            0 RPM  (div =3D 128)
> > SYSTIN:        +31.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALA=
RM  sensor
> > =3D CPU diode
> > CPUTIN:        +29.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sen=
sor =3D CPU
> > diode
> > AUXTIN:        +22.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sen=
sor =3D
> > thermistor
> > PECI Agent 0:  +45.5=B0C
> > cpu0_vid:     +2.050 V
> > intrusion0:   OK
> >
> > root@sandy:/sys/devices/platform/w83627ehf.656# echo 1 > pwm2
> > root@sandy:/sys/devices/platform/w83627ehf.656# sensors
> > coretemp-isa-0000
> > Adapter: ISA adapter
> > Physical id 0:  +46.0=B0C  (high =3D +78.0=B0C, crit =3D +98.0=B0C)  AL=
ARM (CRIT)
> > Core 0:         +46.0=B0C  (high =3D +78.0=B0C, crit =3D +98.0=B0C)  AL=
ARM (CRIT)
> >
> > nct6775-isa-0290
> > Adapter: ISA adapter
> > Vcore:         +0.85 V  (min =3D  +0.00 V, max =3D  +1.74 V)
> > in1:           +1.12 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> > AVCC:          +3.46 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> > +3.3V:         +3.46 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> > in4:           +1.06 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> > in5:           +1.05 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> > in6:           +1.08 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> > 3VSB:          +3.41 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> > Vbat:          +3.34 V  (min =3D  +2.70 V, max =3D  +3.30 V)  ALARM
> > fan1:            0 RPM  (min =3D    0 RPM, div =3D 128)
> > fan2:         1054 RPM  (min =3D    0 RPM, div =3D 128)  ALARM
> > fan3:            0 RPM  (min =3D    0 RPM, div =3D 128)
> > fan4:            0 RPM  (div =3D 128)
> > SYSTIN:        +30.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALA=
RM  sensor
> > =3D CPU diode
> > CPUTIN:        +29.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sen=
sor =3D CPU
> > diode
> > AUXTIN:        +22.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sen=
sor =3D
> > thermistor
> > PECI Agent 0:  +44.5=B0C
> > cpu0_vid:     +2.050 V
> > intrusion0:   OK
>
> > _______________________________________________
> > lm-sensors mailing list
> > lm-sensors@lm-sensors.org
> > http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>
>

--f46d044788171261d304c37b9773
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>&gt; I need to get fairly fine grain control on my CPU fan speed=
 for some<br><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div=
 class=3D"im">

&gt; experiments, but I am currently unable to set the fan speed below 1054=
 RPM.<br>
&gt; pwmconfig confirms the same across the divisor range. Processor is i7-=
2600,<br>
&gt; motherboard<br>
&gt;<br>
&gt; I tried setting pwm2_enable to 1 and pwm2 to 1 manually and I see that=
 the<br>
&gt; fan speed varies but the min RPM remains 1054. =A0Info below.<br>
&gt;<br>
</div>What happens if you write 0 into pwmX ? Also, did you select manual f=
an speed<br>
control ?<br>
<br></blockquote><div><br>Writing 0 to pwm2 also keeps it at 1054 RPM. I&#3=
9;m setting pwm2_enable to 1, isn&#39;t that supposed to make it manual? Al=
so, I do see a variation between 1054 RM and 2109 RPM (and some steps in be=
tween), when I change pwm2. I can&#39;t get it to spin lower than 1054 RPM =
though.<br>
<br>thanks,<br>-arun<br>=A0<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex"><div class=3D"im">
&gt; so how would be very helpful.<br>
&gt;<br>
&gt; thanks,<br>
&gt; -arun<br>
&gt;<br>
&gt; root@sandy:/sys/devices/platform/w83627ehf.656# echo 255 &gt; pwm2<br>
&gt; root@sandy:/sys/devices/platform/w83627ehf.656# sensors<br>
&gt; coretemp-isa-0000<br>
&gt; Adapter: ISA adapter<br>
</div>&gt; Any pointers on whether it is possible to reduce fan speed furth=
er, and if<br>&gt; Physical id 0: =A0+46.0=B0C =A0(high =3D +78.0=B0C, crit=
 =3D +98.0=B0C) =A0ALARM (CRIT)<br>
&gt; Core 0: =A0 =A0 =A0 =A0 +46.0=B0C =A0(high =3D +78.0=B0C, crit =3D +98=
.0=B0C) =A0ALARM (CRIT)<br>
<div class=3D"im">&gt;<br>
&gt; nct6775-isa-0290<br>
&gt; Adapter: ISA adapter<br>
&gt; Vcore: =A0 =A0 =A0 =A0 +0.82 V =A0(min =3D =A0+0.00 V, max =3D =A0+1.7=
4 V)<br>
&gt; in1: =A0 =A0 =A0 =A0 =A0 +1.12 V =A0(min =3D =A0+0.00 V, max =3D =A0+0=
.00 V) =A0ALARM<br>
&gt; AVCC: =A0 =A0 =A0 =A0 =A0+3.46 V =A0(min =3D =A0+2.98 V, max =3D =A0+3=
.63 V)<br>
&gt; +3.3V: =A0 =A0 =A0 =A0 +3.46 V =A0(min =3D =A0+2.98 V, max =3D =A0+3.6=
3 V)<br>
&gt; in4: =A0 =A0 =A0 =A0 =A0 +1.06 V =A0(min =3D =A0+0.00 V, max =3D =A0+0=
.00 V) =A0ALARM<br>
&gt; in5: =A0 =A0 =A0 =A0 =A0 +1.05 V =A0(min =3D =A0+0.00 V, max =3D =A0+0=
.00 V) =A0ALARM<br>
&gt; in6: =A0 =A0 =A0 =A0 =A0 +1.08 V =A0(min =3D =A0+0.00 V, max =3D =A0+0=
.00 V) =A0ALARM<br>
&gt; 3VSB: =A0 =A0 =A0 =A0 =A0+3.41 V =A0(min =3D =A0+2.98 V, max =3D =A0+3=
.63 V)<br>
&gt; Vbat: =A0 =A0 =A0 =A0 =A0+3.34 V =A0(min =3D =A0+2.70 V, max =3D =A0+3=
.30 V) =A0ALARM<br>
&gt; fan1: =A0 =A0 =A0 =A0 =A0 =A00 RPM =A0(min =3D =A0 =A00 RPM, div =3D 1=
28)<br>
&gt; fan2: =A0 =A0 =A0 =A0 2109 RPM =A0(min =3D =A0 =A00 RPM, div =3D 128) =
=A0ALARM &lt;----<br>
&gt; fan3: =A0 =A0 =A0 =A0 =A0 =A00 RPM =A0(min =3D =A0 =A00 RPM, div =3D 1=
28)<br>
&gt; fan4: =A0 =A0 =A0 =A0 =A0 =A00 RPM =A0(div =3D 128)<br>
</div>&gt; SYSTIN: =A0 =A0 =A0 =A0+31.0=B0C =A0(high =3D =A0+0.0=B0C, hyst =
=3D =A0+0.0=B0C) =A0ALARM =A0sensor<br>
&gt; =3D CPU diode<br>
&gt; CPUTIN: =A0 =A0 =A0 =A0+29.5=B0C =A0(high =3D +80.0=B0C, hyst =3D +75.=
0=B0C) =A0sensor =3D CPU<br>
&gt; diode<br>
&gt; AUXTIN: =A0 =A0 =A0 =A0+22.0=B0C =A0(high =3D +80.0=B0C, hyst =3D +75.=
0=B0C) =A0sensor =3D<br>
&gt; thermistor<br>
&gt; PECI Agent 0: =A0+45.5=B0C<br>
<div class=3D"im">&gt; cpu0_vid: =A0 =A0 +2.050 V<br>
&gt; intrusion0: =A0 OK<br>
&gt;<br>
&gt; root@sandy:/sys/devices/platform/w83627ehf.656# echo 1 &gt; pwm2<br>
&gt; root@sandy:/sys/devices/platform/w83627ehf.656# sensors<br>
&gt; coretemp-isa-0000<br>
&gt; Adapter: ISA adapter<br>
</div>&gt; Physical id 0: =A0+46.0=B0C =A0(high =3D +78.0=B0C, crit =3D +98=
.0=B0C) =A0ALARM (CRIT)<br>
&gt; Core 0: =A0 =A0 =A0 =A0 +46.0=B0C =A0(high =3D +78.0=B0C, crit =3D +98=
.0=B0C) =A0ALARM (CRIT)<br>
<div class=3D"im">&gt;<br>
&gt; nct6775-isa-0290<br>
&gt; Adapter: ISA adapter<br>
&gt; Vcore: =A0 =A0 =A0 =A0 +0.85 V =A0(min =3D =A0+0.00 V, max =3D =A0+1.7=
4 V)<br>
&gt; in1: =A0 =A0 =A0 =A0 =A0 +1.12 V =A0(min =3D =A0+0.00 V, max =3D =A0+0=
.00 V) =A0ALARM<br>
&gt; AVCC: =A0 =A0 =A0 =A0 =A0+3.46 V =A0(min =3D =A0+2.98 V, max =3D =A0+3=
.63 V)<br>
&gt; +3.3V: =A0 =A0 =A0 =A0 +3.46 V =A0(min =3D =A0+2.98 V, max =3D =A0+3.6=
3 V)<br>
&gt; in4: =A0 =A0 =A0 =A0 =A0 +1.06 V =A0(min =3D =A0+0.00 V, max =3D =A0+0=
.00 V) =A0ALARM<br>
&gt; in5: =A0 =A0 =A0 =A0 =A0 +1.05 V =A0(min =3D =A0+0.00 V, max =3D =A0+0=
.00 V) =A0ALARM<br>
&gt; in6: =A0 =A0 =A0 =A0 =A0 +1.08 V =A0(min =3D =A0+0.00 V, max =3D =A0+0=
.00 V) =A0ALARM<br>
&gt; 3VSB: =A0 =A0 =A0 =A0 =A0+3.41 V =A0(min =3D =A0+2.98 V, max =3D =A0+3=
.63 V)<br>
&gt; Vbat: =A0 =A0 =A0 =A0 =A0+3.34 V =A0(min =3D =A0+2.70 V, max =3D =A0+3=
.30 V) =A0ALARM<br>
&gt; fan1: =A0 =A0 =A0 =A0 =A0 =A00 RPM =A0(min =3D =A0 =A00 RPM, div =3D 1=
28)<br>
&gt; fan2: =A0 =A0 =A0 =A0 1054 RPM =A0(min =3D =A0 =A00 RPM, div =3D 128) =
=A0ALARM<br>
&gt; fan3: =A0 =A0 =A0 =A0 =A0 =A00 RPM =A0(min =3D =A0 =A00 RPM, div =3D 1=
28)<br>
&gt; fan4: =A0 =A0 =A0 =A0 =A0 =A00 RPM =A0(div =3D 128)<br>
</div>&gt; SYSTIN: =A0 =A0 =A0 =A0+30.0=B0C =A0(high =3D =A0+0.0=B0C, hyst =
=3D =A0+0.0=B0C) =A0ALARM =A0sensor<br>
&gt; =3D CPU diode<br>
&gt; CPUTIN: =A0 =A0 =A0 =A0+29.5=B0C =A0(high =3D +80.0=B0C, hyst =3D +75.=
0=B0C) =A0sensor =3D CPU<br>
&gt; diode<br>
&gt; AUXTIN: =A0 =A0 =A0 =A0+22.0=B0C =A0(high =3D +80.0=B0C, hyst =3D +75.=
0=B0C) =A0sensor =3D<br>
&gt; thermistor<br>
&gt; PECI Agent 0: =A0+44.5=B0C<br>
<div class=3D"im">&gt; cpu0_vid: =A0 =A0 +2.050 V<br>
&gt; intrusion0: =A0 OK<br>
<br>
</div>&gt; _______________________________________________<br>
&gt; lm-sensors mailing list<br>
&gt; <a href=3D"mailto:lm-sensors@lm-sensors.org">lm-sensors@lm-sensors.org=
</a><br>
&gt; <a href=3D"http://lists.lm-sensors.org/mailman/listinfo/lm-sensors" ta=
rget=3D"_blank">http://lists.lm-sensors.org/mailman/listinfo/lm-sensors</a>=
<br>
<br>
</blockquote></div><br>

--f46d044788171261d304c37b9773--


--===============2665763160574277092==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2665763160574277092==--
