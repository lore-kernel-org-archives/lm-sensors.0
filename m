From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 12 Jul 2014 17:29:45 +0000
Subject: Re: [lm-sensors] lm-sensors: which temperature sensor is lying ?
Message-Id: <53C17089.3000101@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140712145751.GA14562@faui40p.informatik.uni-erlangen.de>
In-Reply-To: <20140712145751.GA14562@faui40p.informatik.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On 07/12/2014 07:57 AM, Toerless Eckert wrote:
> ECS GF7100-M3 MOBO (ca. 2008'ish).  Core2 CPU 6400@2.13GHz (60W),
> never tried to bother with sensors. Now i tried to upgrade the
> CPU to a quad core (90W), and that one crashes, but only after
>> =3D 24 hours under full CPU. Tried various better CPU heatsinks,
> but still crashes, so i start wondering what the real temperatures are.
> And thats when i am getting confused by the sensors output because
> it seems to be contradictory and i can not find good explanations:
>
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:       +68.0=B0C  (high =3D +84.0=B0C, crit =3D +100.0=B0C)
> Core 1:       +69.0=B0C  (high =3D +84.0=B0C, crit =3D +100.0=B0C)
>
The CPU reports the difference to the critical temperature as integer value,
where a difference of '1' roughly means 1 degree C. coretemp translates that
into an absolute temperature. The value can be highly inaccurate at low
temperatures, but gets more accurate when it gets close to the critical
temperature limit.

What is the exact CPU model ? It might be useful to know if coretemp reads
the critical limit from the CPU or estimates it. Older CPUs don't provide
the register to read it from the CPU so coretemp needs to guess it.
Output of /proc/cpuinfo would help.

> w83627dhg-isa-0a10
> Adapter: ISA adapter
> ...
> fan1:           0 RPM  (min =3D 10546 RPM, div =3D 128)  ALARM
> fan2:         888 RPM  (min =3D 1562 RPM, div =3D 8)  ALARM
> fan3:           0 RPM  (min =3D  878 RPM, div =3D 128)  ALARM
> fan5:           0 RPM  (min =3D 1757 RPM, div =3D 128)  ALARM
> temp1:        +40.0=B0C  (high =3D +31.0=B0C, hyst =3D +93.0=B0C)  sensor=
 =3D thermistor
> temp2:        +38.0=B0C  (high =3D  -0.5=B0C, hyst =3D  -1.0=B0C)  ALARM =
 sensor =3D diode
> temp3:         +2.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor=
 =3D thermistor
>
> fan2 is the CPU fan. I can tune it from ca. 850 to ca 2800, but
> the increase does have astounding little impact on the temperature
> readings.
>
> temp1 never changes, i guess this is on some other chip - northbridge ?
>
> temp2 must be CPU. With Core2 CPU its 28C idle and goes up to 38C full CP=
U.
> Core 0/1 with Core2 CPU are ~55C idle and 68C full CPU.
>

Unlikely. One would need to see the datasheet / schematics of the board
to get an idea what is connected. W83627DHG supports direct temperature
measurement from the CPU through PECI. Either that is not connected
on your board, or the chip is not configured correctly.

> With Quad core CPU, Core0/1/2/3 are about 50C idle and go up to
> 77C under full CPU load (CPU 0 always highest, the other 5C lower).
> temp2 with Quad core CPU is 30C idle and 40C under full load.
> With worse CPU cooler i had Core 0 go above 84C and then i started to
> actually see more mcelog errors (even shorter than 24 hours).
>
That doesn't look that bad. Sure, 84C is a bit high, but 77C is ok.
MCE log even at that temperature is a bit odd, though - the CPU
should only start complaining if it gets close to the critical limit.

Just to give you a reference point, this is what I see right now
with an i7-4790K running at full load @ 4.2GHz:

coretemp-isa-0000
Adapter: ISA adapter
Physical id 0:  +82.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)
Core 0:         +78.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)
Core 1:         +82.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)
Core 2:         +78.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)
Core 3:         +76.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)

As you can see, some of the temperatures are above 'high', but
not even close to the critical limit.

Problem though is that fan control is driven from the W83627DHG,
and it looks like this chip is not aware that the CPU is running hot,
meaning it does not increase fan speed as it should.

What temperatures do you see in the BIOS ?

> So, now i wonder if both Core 0/1/2/3 and temp2 can be correct, or if
> maybe one is wrong - or in general: whats the bloody temperature of
> my CPUs really.
>
> And i can not find a good web page that explains what coretemp-isa
> vs w83627dhg-* are and how to validate that their readings are correct.
>
> I am guessing, the coretemp-isa-000 sensor is actually IN the
> CPU, but whether or not that means that the temperate values are
> read correctly, i can not say. And temp2 is a temperature sensor

That is correct. For information about accuracy, I would recommend
the Intel CPU datasheet. It usually has a chapter describing the
temperature sensors.

> on the Mobo below the CPU, but whether or not that sensor reading
> is configured correctly.. i can not say either.
>
> If thats right, i still can't believe both sensors are correctly
> set up. In steady state full CPU load i can not see how the under-the-CPU
> temperature could be 30C lower than the in-CPU ones.
>
> So ... what temperature does my CPU have and/or how can i make
> sure both sensors are set up correctly ?
>
coretemp is the best you can get as long as you read the reported temperatu=
re
not as face value but as "difference to maximum".

The W83627DHG settings are  more critical, really, as it should control
fan speed based on CPU temperature. Something seems to be wrong there.
Unfortunately, you'll need support from the board vendor. Anything wrong
there is wrong because the BIOS programs it that way. Messing with it
from Linux would technically be possible by writing directly into chip
registers, but I would not recommend it because you _might_ fry the board
if you write a bad value into the wrong location.

Do you run the latest BIOS ? It might make sense to ensure that the board
and the BIOS actually support the CPU you are using.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
