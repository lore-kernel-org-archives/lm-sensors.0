From: ianp <braveheart_leo@yahoo.com>
Date: Wed, 19 Feb 2014 05:38:58 +0000
Subject: Re: [lm-sensors] W83627DHG-P sensor shows a single voltage monitor for +5V and +12V on in4?
Message-Id: <1392788338.7715.YahooMailNeo@web160505.mail.bf1.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392773023.4498.YahooMailNeo@web160503.mail.bf1.yahoo.com>
In-Reply-To: <1392773023.4498.YahooMailNeo@web160503.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

> On Wednesday, February 19, 2014 12:21 PM, Guenter Roeck <linux@roeck-us.n=
et> wrote:

>
> Theoretically yes, but I am quite sure that it is PBKC
> (Problem Between Keyboard And Chair ;-).
>=20

I do know about PEBKAC, and it would be unfortunate if that were to be the =
case.

Also,
 I am not using the fact, whether directly or indirectly stated, that=20
"both in3 and in4 happen to report the same physical value," because=20
they do not report the same physical value. Forgive me if I wasn't clear
 with my words, because English is not my native language.

For
 the record, what I have been stating since the start is that,=20
apparently, I can scale the +5V and +12V monitors _only_ in in4. And=20
they are not out of pure luck, because apart from researching the=20
correct formula to use for the compute statements and a number of=20
trial-and-error runs, the +5V and +12V values that I scaled from my=20
formula just doesn't _happen_ to be correct -- they are corroborated as=20
the same values that hwmonitor "sees" in Windows. I cannot scale +5V nor
 +12V from all the other inputs the kernel module provides, only in in4.

> Try sensors -u for raw values. That should help us determine
> the correct compute statements.
>=20
> As far as I can see from the driver, in3 has an automatic
> built-in scaling factor of 2 for this chip, meaning it already
> reports twice the voltage you would expect for other inputs,
> and thus should not need scaling in the first place.
> In other words, sensors -u should already report
> the correct value for in3.
>=20
> Guenter
>

I will defer to your understanding, because you know the code much better t=
han I could hopefully ever understand.

For
 the sake of simplicity, I have disabled my custom configuration and=20
deferred to the default values provided by lm-sensors, and here are the=20
results:

$ sensors
w83627dhg-isa-0290
Adapter: ISA adapter
Vcore:=A0=A0=A0=A0=A0=A0=A0 +1.11 V=A0 (min =3D=A0 +1.07 V, max =3D=A0 +1.1=
8 V)
in1:=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.98 V=A0 (min =3D=A0 +0.91 V, max =3D=A0 =
+1.44 V)
AVCC:=A0=A0=A0=A0=A0=A0=A0=A0 +3.30 V=A0 (min =3D=A0 +2.98 V, max =3D=A0 +3=
.63 V)
+3.3V:=A0=A0=A0=A0=A0=A0=A0 +3.30 V=A0 (min =3D=A0 +2.98 V, max =3D=A0 +3.6=
3 V)
in4:=A0=A0=A0=A0=A0=A0=A0=A0=A0 +1.66 V=A0 (min =3D=A0 +1.63 V, max =3D=A0 =
+1.80 V)
in5:=A0=A0=A0=A0=A0=A0=A0=A0=A0 +1.69 V=A0 (min =3D=A0 +0.09 V, max =3D=A0 =
+0.34 V)=A0 ALARM
in6:=A0=A0=A0=A0=A0=A0=A0=A0=A0 +1.90 V=A0 (min =3D=A0 +1.80 V, max =3D=A0 =
+1.90 V)
3VSB:=A0=A0=A0=A0=A0=A0=A0=A0 +3.50 V=A0 (min =3D=A0 +2.98 V, max =3D=A0 +3=
.63 V)
Vbat:=A0=A0=A0=A0=A0=A0=A0=A0 +3.34 V=A0 (min =3D=A0 +2.70 V, max =3D=A0 +3=
.30 V)=A0 ALARM
fan1:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0 (min =3D=A0=A0=A0 0 RPM, div =
=3D 128)
fan2:=A0=A0=A0=A0=A0=A0=A0 1854 RPM=A0 (min =3D=A0 902 RPM, div =3D 8)
fan3:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0 (min =3D=A0=A0=A0 0 RPM, div =
=3D 128)
fan4:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0 (min =3D 2109 RPM, div =3D 128=
)=A0 ALARM
fan5:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0 (min =3D=A0 811 RPM, div =3D 1=
28)=A0 ALARM
temp1:=A0=A0=A0=A0=A0=A0=A0 +41.0=B0C=A0 (high =3D +60.0=B0C, hyst =3D +55.=
0=B0C)=A0 sensor =3D thermistor
temp2:=A0=A0=A0=A0=A0=A0=A0 +38.5=B0C=A0 (high =3D +60.0=B0C, hyst =3D +55.=
0=B0C)=A0 sensor =3D thermistor
temp3:=A0=A0=A0=A0=A0=A0=A0 +45.5=B0C=A0 (high =3D +80.0=B0C, hyst =3D +75.=
0=B0C)=A0 sensor =3D thermistor
cpu0_vid:=A0=A0=A0 +0.000 V
intrusion0:=A0 ALARM

$ sensors -u
w83627dhg-isa-0290
Adapter: ISA adapter
Vcore:
=A0 in0_input: 1.112
=A0 in0_min: 1.072
=A0 in0_max: 1.184
=A0 in0_alarm: 0.000
in1:
=A0 in1_input: 0.992
=A0 in1_min: 0.912
=A0 in1_max: 1.440
=A0 in1_alarm: 0.000
AVCC:
=A0 in2_input: 3.296
=A0 in2_min: 2.976
=A0 in2_max: 3.632
=A0 in2_alarm: 0.000
+3.3V:
=A0 in3_input: 3.296
=A0 in3_min: 2.976
=A0 in3_max: 3.632
=A0 in3_alarm: 0.000
in4:
=A0 in4_input: 1.656
=A0 in4_min: 1.632
=A0 in4_max: 1.800
=A0 in4_alarm: 0.000=20
=A0 in5_input: 1.688
=A0 in5_min: 0.088
=A0 in5_max: 0.344
=A0 in5_alarm: 1.000
in6:
=A0 in6_input: 1.896
=A0 in6_min: 1.800
=A0 in6_max: 1.904
=A0 in6_alarm: 0.000
3VSB:
=A0 in7_input: 3.504
=A0 in7_min: 2.976
=A0 in7_max: 3.632
=A0 in7_alarm: 0.000
Vbat:
=A0 in8_input: 3.344
=A0 in8_min: 2.704
=A0 in8_max: 3.296
=A0 in8_alarm: 1.000
fan1:
=A0 fan1_input: 0.000
=A0 fan1_min: 0.000
=A0 fan1_alarm: 0.000
=A0 fan1_div: 128.000
fan2:
=A0 fan2_input: 2008.000
=A0 fan2_min: 902.000
=A0 fan2_alarm: 0.000
=A0 fan2_div: 8.000
fan3:
=A0 fan3_input: 0.000
=A0 fan3_min: 0.000
=A0 fan3_alarm: 0.000
=A0 fan3_div: 128.000
fan4:
=A0 fan4_input: 0.000
=A0 fan4_min: 2109.000
=A0 fan4_alarm: 1.000
=A0 fan4_div: 128.000
fan5:
=A0 fan5_input: 0.000
=A0 fan5_min: 811.000
=A0 fan5_alarm: 1.000
=A0 fan5_div: 128.000
temp1:
=A0 temp1_input: 41.000
=A0 temp1_max: 60.000
=A0 temp1_max_hyst: 55.000
=A0 temp1_alarm: 0.000
=A0 temp1_type: 4.000
=A0 temp1_offset: 0.000
temp2:
=A0 temp2_input: 39.000
=A0 temp2_max: 60.000
=A0 temp2_max_hyst: 55.000
=A0 temp2_alarm: 0.000
=A0 temp2_type: 4.000
=A0 temp2_offset: 0.000
temp3:
=A0 temp3_input: 46.000
=A0 temp3_max: 80.000
=A0 temp3_max_hyst: 75.000
=A0 temp3_alarm: 0.000
=A0 temp3_type: 4.000
=A0 temp3_offset: 0.000
cpu0_vid:
=A0 cpu0_vid: 0.000
intrusion0:
=A0 intrusion0_alarm: 1.000

I appreciate your inputs regarding this inquiry and please advise on how to=
 proceed from here.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
