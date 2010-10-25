From: Arun Raghavan <arraghav@gmail.com>
Date: Mon, 25 Oct 2010 01:40:38 +0000
Subject: Re: [lm-sensors] Discrepancy between reported readings from
Message-Id: <AANLkTimOz9z8OJ4RBr=vu__GvfnZUy=5kPnVYVy6oTH1@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTik8hx=ej8V7ti_=izz0u+daOxxy5PmBjX0ZQv8W@mail.gmail.com>
In-Reply-To: <AANLkTik8hx=ej8V7ti_=izz0u+daOxxy5PmBjX0ZQv8W@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Thanks again for the prompt response. One more question regarding
coretemp: any idea how I can probe the sensor in my own source code?
I'm hoping to be able to probe a few times a second, while the
lm-sensors usage guide says max. probing frequency should be at most
0.3-0.5 Hz. I'm trying to measure thermal response and hence
transients. Temperature rises rather too rapidly for this once every
2-3 seconds restriction; there's no intermediate reading between idle
temperature (~28C) and loaded (~55C). Even when I overclock to
deliberately induce more dissipation, I don't get an intermediate
reading between the same base temperature and 70C!
Please let me know if the 2-3s resolution is a limitation of the
sensors API or the kernel module itself. Any tips on how I might be
able to measure with greater frequency (apart from hooking up an
external probe and thermometer)?

thanks!

On Sun, Oct 24, 2010 at 5:42 PM, Luca Tettamanti <kronos.it@gmail.com> wrot=
e:
> On Sun, Oct 24, 2010 at 11:27 PM, Arun Raghavan <arraghav@gmail.com> wrot=
e:
>> Hi,
>>
>> Thanks for the quick response and the links. I'm not sure I understand
>> exactly how to proceed or how to interpret your point about coretemp
>> being relative to Tjmax. I see the coretemp value increasing with
>> activity, implying the reading is greater the hotter it gets. If it
>> were a delta from Tjmax, I would expect it to decrease?
>
> Tjmax is the upper limit at which the CPU forces the throttling
> (AFAIK). The exact value varies between CPUs, in you case it should be
> 101=B0C; the DTS reports a negative value (or rather a positive margin)
> relative to TjMax, the driver converts it to an absolute temperature.
> Tabs =3D TjMax - Tdts
>
>> I also have thermometers probing across the heat sink and they seem to
>> match the coretemp readings at idle (of course, when the CPU heats up,
>> the package temperature is hotter than the heatsink probe detects).
>> Should I just trust the coretemp readings to a reasonable
>> approximation?
>
> I should be :) For some desktop CPU the exact value for TjMax is not
> known and is assumed to be 100=B0C; in this case the driver emits a
> warning in the log.
>
> Luca
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
