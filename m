From: ianp <braveheart_leo@yahoo.com>
Date: Wed, 19 Feb 2014 07:33:39 +0000
Subject: Re: [lm-sensors] W83627DHG-P sensor shows a single voltage monitor for +5V and +12V on in4?
Message-Id: <1392795219.80291.YahooMailNeo@web160504.mail.bf1.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392773023.4498.YahooMailNeo@web160503.mail.bf1.yahoo.com>
In-Reply-To: <1392773023.4498.YahooMailNeo@web160503.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

> On Wednesday, February 19, 2014 2:16 PM, Guenter Roeck <linux@roeck-us.ne=
t> wrote:
>
> Actually, they do. Register values are 0xcf for both (bank 0,
> registers 0x23 and 0x24).
>

Oh, you meant the raw dump physical value (0xCF). I was pertaining to the v=
alues reported back by sensors, which was an incorrect understanding on my =
part.

>> +3.3V:
>>=A0=A0=A0=A0 in3_input: 3.296
>>=A0=A0=A0=A0 in3_min: 2.976
>>=A0=A0=A0=A0 in3_max: 3.632
>>=A0=A0=A0=A0 in3_alarm: 0.000
>
> If we assume that hwmonitor is correct, this needs
> to scale up 50%, which would make the value
> 3.296 * 1.5 =3D 4.944V.
>
> The raw value reported by the driver in the hwmonitor dump
> is 0xcf =3D 207, which is multiplied by the driver with 16,
> resulting in 3.312V as originally seen, or scaled to 4.968V,
> which is exactly the value that was reported by hwmonitor.
>
> So your compute statement would be something like
>
> compute=A0 in3=A0 @*(15/10), @/(15/10)
>
>> in4:
>>=A0=A0=A0=A0 in4_input: 1.656
>>=A0=A0=A0=A0 in4_min: 1.632
>>=A0=A0=A0=A0 in4_max: 1.800
>>=A0=A0=A0=A0 in4_alarm: 0.000
>>=A0=A0=A0=A0 in5_input: 1.688
>>=A0=A0=A0=A0 in5_min: 0.088
>>=A0=A0=A0=A0 in5_max: 0.344
>>=A0=A0=A0=A0 in5_alarm: 1.000
>
> The raw value reported by the driver is 0xcf =3D 207.
> This is multiplied by the driver with 8, resulting
> in a reported voltage of 1.656V. A scaling factor
> of 7 (as you have) gets you to 11.592V, which
> matches the voltage reported by hwmonitor quite closely.
>
> compute in4 @*7, @/7
>
> might be a bit simpler, though.
>
> Hope this helps,
>
> Guenter
>

You sir have been very helpful, and I must admit that this is both the case=
 of PEBKAC and PDL, but how could you blame me, an ordinary end user, for h=
aving only so limited an undesrtanding and resource at my disposal? ;-)

Committing your compute statements into my configuration:

$ sensors
Vcore:=A0=A0=A0=A0=A0=A0=A0 +1.11 V=A0 (min =3D=A0 +1.07 V, max =3D=A0 +1.1=
8 V)
+3.3V:=A0=A0=A0=A0=A0=A0=A0=A0 +3.30 V=A0 (min =3D=A0 +2.98 V, max =3D=A0 +=
3.63 V)
+5V:=A0=A0=A0=A0=A0=A0=A0=A0=A0 +4.94 V=A0 (min =3D=A0 +2.98 V, max =3D=A0 =
+3.62 V)=A0 ALARM
+12V:=A0=A0=A0=A0=A0=A0=A0 +11.59 V=A0 (min =3D +11.42 V, max =3D +12.60 V)
Vram:=A0=A0=A0=A0=A0=A0=A0=A0 +1.90 V=A0 (min =3D=A0 +1.80 V, max =3D=A0 +1=
.90 V)
3Vsb:=A0=A0=A0=A0=A0=A0=A0=A0 +3.50 V=A0 (min =3D=A0 +2.98 V, max =3D=A0 +3=
.63 V)
Vbat:=A0=A0=A0=A0=A0=A0=A0=A0 +3.34 V=A0 (min =3D=A0 +2.70 V, max =3D=A0 +3=
.30 V)=A0 ALARM
CHA Fan:=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0 (min =3D=A0=A0=A0 0 RPM, div =3D 128)
CPU Fan:=A0=A0=A0=A0 2191 RPM=A0 (min =3D=A0 902 RPM, div =3D 8)
PSU Fan:=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0 (min =3D=A0=A0=A0 0 RPM, div =3D 128)
N/B Temp:=A0=A0=A0=A0 +43.0=B0C=A0 (high =3D +60.0=B0C, hyst =3D +55.0=B0C)=
=A0 sensor =3D thermistor
CPU Temp:=A0=A0=A0=A0 +40.0=B0C=A0 (high =3D +60.0=B0C, hyst =3D +55.0=B0C)=
=A0 sensor =3D thermistor
intrusion0:=A0 ALARM

I will contribute my configuration into the http://lm-sensors.org/wiki/Conf=
igurations page for this board so that others may benefit as well.

There are still some observations I'd like to ask you about:

1. While +5V is now scaled from in3, if you will take notice the min and ma=
x values do not reflect the ones I have set in my configuration:

=A0=A0 set in3_min 5 * 0.95
=A0=A0 set in3_max 5 * 1.05

I do not believe that this is an expected behavior, so perhaps a bug then?

2. I have relied upon http://www.lm-sensors.org/wiki/VoltageLabelsAndScalin=
g for scaling +5V and +12V values. But the way you derived the scaling fact=
ors from your explanation above, which I believe is much easier and faster =
than the one in the wiki that works on samples, does not seem to be covered=
 there. How does one go about figuring out scaling factors like the way you=
 did?

3. Regarding 3VSB, if this is the standby voltage, then shouldn't it be +5V=
SB? I don't think PSUs provide +3VSB, only +5VSB. So does this mean that th=
e value needs to be scaled as well?

4. Same with VBAT, as I recall motherboard internal batteries are rated at =
+3V CR2032 coin-cell batteries.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
