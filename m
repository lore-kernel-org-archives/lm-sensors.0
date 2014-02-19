From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 19 Feb 2014 06:16:42 +0000
Subject: Re: [lm-sensors] W83627DHG-P sensor shows a single voltage monitor for +5V and +12V on in4?
Message-Id: <53044C4A.2090906@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392773023.4498.YahooMailNeo@web160503.mail.bf1.yahoo.com>
In-Reply-To: <1392773023.4498.YahooMailNeo@web160503.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On 02/18/2014 09:38 PM, ianp wrote:
>> On Wednesday, February 19, 2014 12:21 PM, Guenter Roeck <linux@roeck-us.=
net> wrote:
>
>>
>> Theoretically yes, but I am quite sure that it is PBKC
>> (Problem Between Keyboard And Chair ;-).
>>
>
> I do know about PEBKAC, and it would be unfortunate if that were to be th=
e case.
>
> Also,
>   I am not using the fact, whether directly or indirectly stated, that
> "both in3 and in4 happen to report the same physical value," because
> they do not report the same physical value. Forgive me if I wasn't clear
>   with my words, because English is not my native language.
>
Actually, they do. Register values are 0xcf for both (bank 0,
registers 0x23 and 0x24).

> For
>   the record, what I have been stating since the start is that,
> apparently, I can scale the +5V and +12V monitors _only_ in in4. And
> they are not out of pure luck, because apart from researching the
> correct formula to use for the compute statements and a number of
> trial-and-error runs, the +5V and +12V values that I scaled from my
> formula just doesn't _happen_ to be correct -- they are corroborated as
> the same values that hwmonitor "sees" in Windows. I cannot scale +5V nor
>   +12V from all the other inputs the kernel module provides, only in in4.
>
Not sure if I I can follow that logic; see below.

>> Try sensors -u for raw values. That should help us determine
>> the correct compute statements.
>>
>> As far as I can see from the driver, in3 has an automatic
>> built-in scaling factor of 2 for this chip, meaning it already
>> reports twice the voltage you would expect for other inputs,
>> and thus should not need scaling in the first place.
>> In other words, sensors -u should already report
>> the correct value for in3.
>>
>> Guenter
>>
>
> I will defer to your understanding, because you know the code much better=
 than I could hopefully ever understand.
>
> For
>   the sake of simplicity, I have disabled my custom configuration and
> deferred to the default values provided by lm-sensors, and here are the
> results:
>
> $ sensors
> w83627dhg-isa-0290
> Adapter: ISA adapter
> Vcore:        +1.11 V  (min =3D  +1.07 V, max =3D  +1.18 V)
> in1:          +0.98 V  (min =3D  +0.91 V, max =3D  +1.44 V)
> AVCC:         +3.30 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> +3.3V:        +3.30 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> in4:          +1.66 V  (min =3D  +1.63 V, max =3D  +1.80 V)
> in5:          +1.69 V  (min =3D  +0.09 V, max =3D  +0.34 V)  ALARM
> in6:          +1.90 V  (min =3D  +1.80 V, max =3D  +1.90 V)
> 3VSB:         +3.50 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> Vbat:         +3.34 V  (min =3D  +2.70 V, max =3D  +3.30 V)  ALARM
> fan1:           0 RPM  (min =3D    0 RPM, div =3D 128)
> fan2:        1854 RPM  (min =3D  902 RPM, div =3D 8)
> fan3:           0 RPM  (min =3D    0 RPM, div =3D 128)
> fan4:           0 RPM  (min =3D 2109 RPM, div =3D 128)  ALARM
> fan5:           0 RPM  (min =3D  811 RPM, div =3D 128)  ALARM
> temp1:        +41.0=B0C  (high =3D +60.0=B0C, hyst =3D +55.0=B0C)  sensor=
 =3D thermistor
> temp2:        +38.5=B0C  (high =3D +60.0=B0C, hyst =3D +55.0=B0C)  sensor=
 =3D thermistor
> temp3:        +45.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor=
 =3D thermistor
> cpu0_vid:    +0.000 V
> intrusion0:  ALARM
>
> $ sensors -u
> w83627dhg-isa-0290
> Adapter: ISA adapter
> Vcore:
>    in0_input: 1.112
>    in0_min: 1.072
>    in0_max: 1.184
>    in0_alarm: 0.000
> in1:
>    in1_input: 0.992
>    in1_min: 0.912
>    in1_max: 1.440
>    in1_alarm: 0.000
> AVCC:
>    in2_input: 3.296
>    in2_min: 2.976
>    in2_max: 3.632
>    in2_alarm: 0.000
> +3.3V:
>    in3_input: 3.296
>    in3_min: 2.976
>    in3_max: 3.632
>    in3_alarm: 0.000

If we assume that hwmonitor is correct, this needs
to scale up 50%, which would make the value
3.296 * 1.5 =3D 4.944V.

The raw value reported by the driver in the hwmonitor dump
is 0xcf =3D 207, which is multiplied by the driver with 16,
resulting in 3.312V as originally seen, or scaled to 4.968V,
which is exactly the value that was reported by hwmonitor.

So your compute statement would be something like

compute  in3  @*(15/10), @/(15/10)

> in4:
>    in4_input: 1.656
>    in4_min: 1.632
>    in4_max: 1.800
>    in4_alarm: 0.000
>    in5_input: 1.688
>    in5_min: 0.088
>    in5_max: 0.344
>    in5_alarm: 1.000

The raw value reported by the driver is 0xcf =3D 207.
This is multiplied by the driver with 8, resulting
in a reported voltage of 1.656V. A scaling factor
of 7 (as you have) gets you to 11.592V, which
matches the voltage reported by hwmonitor quite closely.

compute in4 @*7, @/7

might be a bit simpler, though.

Hope this helps,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
