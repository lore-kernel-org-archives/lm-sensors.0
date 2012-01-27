From: CC <ccomren@gmail.com>
Date: Fri, 27 Jan 2012 17:34:15 +0000
Subject: Re: [lm-sensors] [reply+i-2970830-11e203ec4162e4680a3e2c999f2bba9b513a1927-1030448@reply.github.com:
Message-Id: <CAH4eiUifKaYYD4DvxXSiiNgy+kJDSw8hceq-g74BX4NgNUpPBw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120127145437.GB29746@ericsson.com>
In-Reply-To: <20120127145437.GB29746@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, Jan 27, 2012 at 5:54 PM, CC <ccomren@gmail.com> wrote:
> On Fri, Jan 27, 2012 at 3:54 PM, Guenter Roeck
> <guenter.roeck@ericsson.com> wrote:
>> Forwarding to lm-sensors to keep the group in the loop.
>>
>> ----- Forwarded message from ccom <reply+i-2970830-11e203ec4162e4680a3e2=
c999f2bba9b513a1927-1030448@reply.github.com> -----
>>
>> Date: Fri, 27 Jan 2012 09:29:45 -0500
>> From: ccom <reply+i-2970830-11e203ec4162e4680a3e2c999f2bba9b513a1927-103=
0448@reply.github.com>
>> To: Guenter Roeck <guenter.roeck@ericsson.com>
>> Subject: Re: [w83627ehf] Not all fans are shown (#3)
>>
>> Note that I adapted /etc/sensors3.conf. The output is:
>>
>> nct6776-isa-0290
>> Adapter: ISA adapter
>> VCore: =A0 =A0 =A0 =A0 +0.76 V =A0(min =3D =A0+0.00 V, max =3D =A0+1.74 =
V)
>> +12V: =A0 =A0 =A0 =A0 +12.36 V =A0(min =3D =A0+0.00 V, max =3D =A0+0.00 =
V) =A0ALARM
>> AVCC: =A0 =A0 =A0 =A0 =A0+3.38 V =A0(min =3D =A0+0.00 V, max =3D =A0+0.0=
0 V) =A0ALARM
>> +3.3V: =A0 =A0 =A0 =A0 +3.36 V =A0(min =3D =A0+0.00 V, max =3D =A0+0.00 =
V) =A0ALARM
>> in4: =A0 =A0 =A0 =A0 =A0 +0.02 V =A0(min =3D =A0+0.00 V, max =3D =A0+0.0=
0 V) =A0ALARM
>> +5V: =A0 =A0 =A0 =A0 =A0 +5.04 V =A0(min =3D =A0+0.00 V, max =3D =A0+0.0=
0 V) =A0ALARM
>> 3VSB: =A0 =A0 =A0 =A0 =A0+3.46 V =A0(min =3D =A0+0.00 V, max =3D =A0+0.0=
0 V) =A0ALARM
>> VBat: =A0 =A0 =A0 =A0 =A0+3.30 V =A0(min =3D =A0+0.00 V, max =3D =A0+0.0=
0 V) =A0ALARM
>> fan1: =A0 =A0 =A0 =A0 =A0 =A00 RPM =A0(min =3D =A0 =A00 RPM) =A0ALARM
>> fan2: =A0 =A0 =A0 =A0 =A0570 RPM =A0(min =3D =A0 =A00 RPM) =A0ALARM
>> fan3: =A0 =A0 =A0 =A0 =A0 =A00 RPM =A0(min =3D =A0 =A00 RPM) =A0ALARM
>> fan4: =A0 =A0 =A0 =A0 1867 RPM =A0(min =3D =A0 =A00 RPM) =A0ALARM
>> fan5: =A0 =A0 =A0 =A0 =A0 =A00 RPM =A0(min =3D =A0 =A00 RPM) =A0ALARM
>> SYSTIN: =A0 =A0 =A0 =A0+35.0=B0C =A0(high =3D =A0+0.0=B0C, hyst =3D =A0+=
0.0=B0C) =A0ALARM =A0sensor =3D thermistor
>> CPUTIN: =A0 =A0 =A0 =A0+33.0=B0C =A0(high =3D +80.0=B0C, hyst =3D +75.0=
=B0C) =A0sensor =3D thermistor
>> AUXTIN: =A0 =A0 =A0 =A0+35.5=B0C =A0(high =3D +80.0=B0C, hyst =3D +75.0=
=B0C) =A0sensor =3D thermistor
>> PECI Agent 0: =A0+36.0=B0C
>> cpu0_vid: =A0 =A0 +2.050 V
>> intrusion0: =A0 ALARM
>> intrusion1: =A0 ALARM
>>
>> There's one more thing missing, though. I cannot find a way to set the f=
an speed in the sys-dir.
>>
>> ---
>>
>> You might also want to set min-max values to get rid of the warnings. Fa=
n speeds are set through pwm[1-3].
>> Did you try to set those ? Chances are that one controls fan2 and anothe=
r fan4; there does not
>> have to be a direct mapping.
>>
>> Thanks,
>> Guenter
>
> Oh, I forgot to start the daemon since trying out the patch. I did set
> the min and max values.
>
> The correct mapping (triple-checked with the BIOS) for the AsRock Z68
> Pro3-M mainboard, and quite possibly for others -- the +12V
> calculation is done as an example in the manual of the chip -- is
> given by
>
> =A0 =A0 =A0 label in1 "+12V"
> =A0 =A0 =A0 compute in1 @*6.6,@/6.6
>
> =A0 =A0 =A0 label in5 "+5V"
> =A0 =A0 =A0 compute in5 @*3,@/3
>
> Best, =A0CC

I tested all three fan outputs. Another thing is weird: pwm1_mode has
its meaning reversed (it's a 3-pin connector and the value 1 is DC
mode, in contrast to pwm2 and the documentation).

fan1 is controlled by pwm1, which is labelled as CHA_FAN (3-pin connector)
fan2 is controlled by pwm2, which is labelled as CPU_FAN (4-pin connector)
fan3 does not exist
fan4 is not yet controlled, but is labelled PWR_FAN (3-pin connector)
fan5 does not exist

Best,  CC

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
