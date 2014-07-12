From: Toerless Eckert <tte@cs.fau.de>
Date: Sat, 12 Jul 2014 14:57:52 +0000
Subject: [lm-sensors] lm-sensors: which temperature sensor is lying ?
Message-Id: <20140712145751.GA14562@faui40p.informatik.uni-erlangen.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

ECS GF7100-M3 MOBO (ca. 2008'ish).  Core2 CPU 6400@2.13GHz (60W),
never tried to bother with sensors. Now i tried to upgrade the
CPU to a quad core (90W), and that one crashes, but only after
>=3D 24 hours under full CPU. Tried various better CPU heatsinks,
but still crashes, so i start wondering what the real temperatures are.
And thats when i am getting confused by the sensors output because
it seems to be contradictory and i can not find good explanations:

coretemp-isa-0000
Adapter: ISA adapter
Core 0:       +68.0=B0C  (high =3D +84.0=B0C, crit =3D +100.0=B0C)
Core 1:       +69.0=B0C  (high =3D +84.0=B0C, crit =3D +100.0=B0C)

w83627dhg-isa-0a10
Adapter: ISA adapter
...
fan1:           0 RPM  (min =3D 10546 RPM, div =3D 128)  ALARM
fan2:         888 RPM  (min =3D 1562 RPM, div =3D 8)  ALARM
fan3:           0 RPM  (min =3D  878 RPM, div =3D 128)  ALARM
fan5:           0 RPM  (min =3D 1757 RPM, div =3D 128)  ALARM
temp1:        +40.0=B0C  (high =3D +31.0=B0C, hyst =3D +93.0=B0C)  sensor =
=3D thermistor
temp2:        +38.0=B0C  (high =3D  -0.5=B0C, hyst =3D  -1.0=B0C)  ALARM  s=
ensor =3D diode
temp3:         +2.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D thermistor

fan2 is the CPU fan. I can tune it from ca. 850 to ca 2800, but
the increase does have astounding little impact on the temperature
readings.

temp1 never changes, i guess this is on some other chip - northbridge ?

temp2 must be CPU. With Core2 CPU its 28C idle and goes up to 38C full CPU.
Core 0/1 with Core2 CPU are ~55C idle and 68C full CPU.

With Quad core CPU, Core0/1/2/3 are about 50C idle and go up to
77C under full CPU load (CPU 0 always highest, the other 5C lower).
temp2 with Quad core CPU is 30C idle and 40C under full load.
With worse CPU cooler i had Core 0 go above 84C and then i started to
actually see more mcelog errors (even shorter than 24 hours).

So, now i wonder if both Core 0/1/2/3 and temp2 can be correct, or if
maybe one is wrong - or in general: whats the bloody temperature of
my CPUs really.

And i can not find a good web page that explains what coretemp-isa
vs w83627dhg-* are and how to validate that their readings are correct.

I am guessing, the coretemp-isa-000 sensor is actually IN the
CPU, but whether or not that means that the temperate values are
read correctly, i can not say. And temp2 is a temperature sensor
on the Mobo below the CPU, but whether or not that sensor reading
is configured correctly.. i can not say either.

If thats right, i still can't believe both sensors are correctly
set up. In steady state full CPU load i can not see how the under-the-CPU
temperature could be 30C lower than the in-CPU ones.

So ... what temperature does my CPU have and/or how can i make
sure both sensors are set up correctly ?

Thanks
    Toerless

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
