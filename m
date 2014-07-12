From: Toerless Eckert <tte@cs.fau.de>
Date: Sat, 12 Jul 2014 18:17:54 +0000
Subject: Re: [lm-sensors] lm-sensors: which temperature sensor is lying ?
Message-Id: <20140712181754.GA18251@faui40p.informatik.uni-erlangen.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140712145751.GA14562@faui40p.informatik.uni-erlangen.de>
In-Reply-To: <20140712145751.GA14562@faui40p.informatik.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

inline

On Sat, Jul 12, 2014 at 10:29:45AM -0700, Guenter Roeck wrote:
> The CPU reports the difference to the critical temperature as integer val=
ue,
> where a difference of '1' roughly means 1 degree C. coretemp translates t=
hat
> into an absolute temperature. The value can be highly inaccurate at low
> temperatures, but gets more accurate when it gets close to the critical
> temperature limit.
>=20
> What is the exact CPU model ? It might be useful to know if coretemp reads
> the critical limit from the CPU or estimates it. Older CPUs don't provide
> the register to read it from the CPU so coretemp needs to guess it.
> Output of /proc/cpuinfo would help.

As i said, Core2Duo 6400, see cpuinfo at the end.

> >w83627dhg-isa-0a10
> >Adapter: ISA adapter
> >...
> >fan1:           0 RPM  (min =3D 10546 RPM, div =3D 128)  ALARM
> >fan2:         888 RPM  (min =3D 1562 RPM, div =3D 8)  ALARM
> >fan3:           0 RPM  (min =3D  878 RPM, div =3D 128)  ALARM
> >fan5:           0 RPM  (min =3D 1757 RPM, div =3D 128)  ALARM
> >temp1:        +40.0=B0C  (high =3D +31.0=B0C, hyst =3D +93.0=B0C)  senso=
r =3D thermistor
> >temp2:        +38.0=B0C  (high =3D  -0.5=B0C, hyst =3D  -1.0=B0C)  ALARM=
  sensor =3D diode
> >temp3:         +2.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  senso=
r =3D thermistor
> >
> >fan2 is the CPU fan. I can tune it from ca. 850 to ca 2800, but
> >the increase does have astounding little impact on the temperature
> >readings.
> >
> >temp1 never changes, i guess this is on some other chip - northbridge ?
> >
> >temp2 must be CPU. With Core2 CPU its 28C idle and goes up to 38C full C=
PU.
> >Core 0/1 with Core2 CPU are ~55C idle and 68C full CPU.
> >
>=20
> Unlikely. One would need to see the datasheet / schematics of the board
> to get an idea what is connected. W83627DHG supports direct temperature
> measurement from the CPU through PECI. Either that is not connected
> on your board, or the chip is not configured correctly.

So PECI are pins on the CPU into a temperature sensor on the CPU ?

But why do you say that is not connected or incorrectly configured ?

> >With Quad core CPU, Core0/1/2/3 are about 50C idle and go up to
> >77C under full CPU load (CPU 0 always highest, the other 5C lower).
> >temp2 with Quad core CPU is 30C idle and 40C under full load.
> >With worse CPU cooler i had Core 0 go above 84C and then i started to
> >actually see more mcelog errors (even shorter than 24 hours).
> >
> That doesn't look that bad. Sure, 84C is a bit high, but 77C is ok.
> MCE log even at that temperature is a bit odd, though - the CPU
> should only start complaining if it gets close to the critical limit.

I just tested on the dual-core CPU, stopping the CPU fan manually.
The CPU started to emit mcelog throttle messages when  the Core 0
sensor reached 100C - which took a few minutes, at that time temp2 sensor w=
as
at 68C.

How much of this error generation is really hard-coded by the CPU
vs. potentially wrong linux driver/config ? If it is known that
this has nothing to do with anyhing linux could do wrong, but its purely the
CPU and its known to have 100 degree trippoint when it throttles ... that
would make me start beliving those high Cpu 0 readings, but otherwise
i rather doubt them.

> Just to give you a reference point, this is what I see right now
> with an i7-4790K running at full load @ 4.2GHz:
>=20
> coretemp-isa-0000
> Adapter: ISA adapter
> Physical id 0:  +82.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)
> Core 0:         +78.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)
> Core 1:         +82.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)
> Core 2:         +78.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)
> Core 3:         +76.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)

Ok, but what do you see on full idle ? I just can't believe that
a Core 0 sensor temperature of now 58C and a temp2 value of 31C is
both correct.

Alas, i only have another linux with quad-core AMD, and that shows nicely i=
dling
at 32C and full load not above 42 and the CPU and temp sensors look
comparable.

> As you can see, some of the temperatures are above 'high', but
> not even close to the critical limit.
>=20
> Problem though is that fan control is driven from the W83627DHG,
> and it looks like this chip is not aware that the CPU is running hot,
> meaning it does not increase fan speed as it should.

I am not using fancontrol, its just the boards automatic PWM
control. when i manually stopped the fan, and then later restarted
it, i could see that the board PWM control works fine, but its
definitely based on temp2 reading: it went full spead as long as it
was above 50C on temp2, and then throttled down.

>=20
> What temperatures do you see in the BIOS ?

Between 30C and 40C.

> >So, now i wonder if both Core 0/1/2/3 and temp2 can be correct, or if
> >maybe one is wrong - or in general: whats the bloody temperature of
> >my CPUs really.
> >
> >And i can not find a good web page that explains what coretemp-isa
> >vs w83627dhg-* are and how to validate that their readings are correct.
> >
> >I am guessing, the coretemp-isa-000 sensor is actually IN the
> >CPU, but whether or not that means that the temperate values are
> >read correctly, i can not say. And temp2 is a temperature sensor
>=20
> That is correct. For information about accuracy, I would recommend
> the Intel CPU datasheet. It usually has a chapter describing the
> temperature sensors.
>=20
> >on the Mobo below the CPU, but whether or not that sensor reading
> >is configured correctly.. i can not say either.
> >
> >If thats right, i still can't believe both sensors are correctly
> >set up. In steady state full CPU load i can not see how the under-the-CPU
> >temperature could be 30C lower than the in-CPU ones.
> >
> >So ... what temperature does my CPU have and/or how can i make
> >sure both sensors are set up correctly ?
> >
> coretemp is the best you can get as long as you read the reported tempera=
ture
> not as face value but as "difference to maximum".
>=20
> The W83627DHG settings are  more critical, really, as it should control
> fan speed based on CPU temperature. Something seems to be wrong there.
> Unfortunately, you'll need support from the board vendor. Anything wrong
> there is wrong because the BIOS programs it that way. Messing with it
> from Linux would technically be possible by writing directly into chip
> registers, but I would not recommend it because you _might_ fry the board
> if you write a bad value into the wrong location.
>=20
> Do you run the latest BIOS ? It might make sense to ensure that the board
> and the BIOS actually support the CPU you are using.

Yeah, its a 2008 board, but runs latest BIOS.

Cheers
   Toerless

> Guenter

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 15
model name      : Intel(R) Core(TM)2 CPU          6400  @ 2.13GHz
stepping        : 6
microcode       : 0xcb
cpu MHz         : 2133.411
cache size      : 2048 KB
physical id     : 0
siblings        : 2
core id         : 1
cpu cores       : 2
apicid          : 1
initial apicid  : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 10
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca =
cmov=20
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm constant_ts=
c arc
h_perfmon pebs bts aperfmperf pni dtes64 monitor ds_cpl vmx est tm2 ssse3 c=
x16 xtpr pdcm lahf_lm dtherm tpr_shadow
bogomips        : 4266.82
clflush size    : 64
cache_alignment : 64
address sizes   : 36 bits physical, 48 bits virtual
power management:


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
