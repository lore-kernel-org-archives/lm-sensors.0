From: Arun Raghavan <arraghav@gmail.com>
Date: Sun, 24 Oct 2010 21:27:05 +0000
Subject: Re: [lm-sensors] Discrepancy between reported readings from
Message-Id: <AANLkTik5tV2tor71xT-mBYBU8yrbwCqG+ePSezFC95Lc@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTik8hx=ej8V7ti_=izz0u+daOxxy5PmBjX0ZQv8W@mail.gmail.com>
In-Reply-To: <AANLkTik8hx=ej8V7ti_=izz0u+daOxxy5PmBjX0ZQv8W@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

Thanks for the quick response and the links. I'm not sure I understand
exactly how to proceed or how to interpret your point about coretemp
being relative to Tjmax. I see the coretemp value increasing with
activity, implying the reading is greater the hotter it gets. If it
were a delta from Tjmax, I would expect it to decrease?
I also have thermometers probing across the heat sink and they seem to
match the coretemp readings at idle (of course, when the CPU heats up,
the package temperature is hotter than the heatsink probe detects).
Should I just trust the coretemp readings to a reasonable
approximation?

thanks!


On Sat, Oct 23, 2010 at 9:02 AM, Luca Tettamanti <kronos.it@gmail.com> wrot=
e:
> Hello,
>
> On Sat, Oct 23, 2010 at 12:56 AM, Arun Raghavan <arraghav@gmail.com> wrot=
e:
>> Hi,
>>
>> I'm running a core-i7 980x on ASUS Rampage III Extreme. I find that
>> the temperatures reported by the atk0110-acpi-0 and coretemp
>> interfaces to be quite different:
>>
>> atk0110-acpi-0
>> Adapter: ACPI interface
>> CPU Temperature: =A0 =A0 =A0 +56.5=B0C =A0(high =3D +60.0=B0C, crit =3D =
+65.0=B0C)
>>
>> coretemp-isa-0000
>> Adapter: ISA adapter
>> Core 0: =A0 =A0 =A0+52.0=B0C =A0(high =3D +81.0=B0C, crit =3D +101.0=B0C)
> [cut]
>> Apart from the 5 degree difference between the reported CPU
>> temperature from the ACPI interface and the max. reported coretemp,
>> the high and critical temperatures are drastically different. 65
>> degrees C seems to small for junction critical temperature 32nm Si.
>> Could you please advise as to what the differences represent. Are they
>> indeed very different things or do I need to calibrate the ACPI
>> (Winbond?) interface to be close to the coretemp readings?
>
> The readings most probably come from different sources: an internal
> sensor for coretemp, an external probe usually under the socket for
> ATK0110 (the hwmon chip might by using PECI though). ACPI code may
> also contain additional calibration code (e.g. I've seen a board that
> tries to calibrate the CPU reading using the board temperature), see
> also [1].
> coretemp actually reads the delta between the current temperature and
> TjMax (i.e. the core is X=B0 below TjMax) not an actual absolute
> temperature; the digital sensor is more accurate near TjMax and -
> according to Intel[2] - the reading "deteriorates to +-10C at 50C": in
> your case you should be reading the output as: you're far from the
> safety limit, everything is cool (literally :D).
> As for the limits: the driver just displays whatever the BIOS reports,
> it might not be the actual limit (especially if it's not
> configurable).
>
> Luca
> [1] http://article.gmane.org/gmane.linux.drivers.sensors/21304
> [2] http://article.gmane.org/gmane.linux.kernel/998038
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
