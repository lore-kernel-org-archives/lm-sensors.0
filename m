From: Toerless Eckert <tte@cs.fau.de>
Date: Wed, 16 Jul 2014 05:40:59 +0000
Subject: Re: [lm-sensors] lm-sensors: which temperature sensor is lying ?
Message-Id: <20140716054058.GA23583@faui40p.informatik.uni-erlangen.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140712145751.GA14562@faui40p.informatik.uni-erlangen.de>
In-Reply-To: <20140712145751.GA14562@faui40p.informatik.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Thanks, Guenther,

So, wrt to coretemp:=20

1. /usr/src/linux/Documentation/hwmon/coretemp isn't too shabby,
   but i wish there was coretemp(8) with a user facing version of it.
   Lots of linux systems without source tree loaded.

   Salient information: driver for intel CPU, reads temperatures
   from CPU, independent of chipset, reported value by CPU is delta to
   TJmax temperature, depending on CPU, TJmax may be guessed by driver
   and/or known from CPU, if guessed, it can be fixed by module parameter.

2. This brings me to the problem: coretemp does not expose whether or
   not TJmax is guessed or known "authoritatively" (from CPU, from
   table in coretemp.c). If you know its not authoritative from CPU,
   you've got some incentive trying to hunt down what might be a
   correct tjmax value to load the module with. Maybe the status
   of tjmax should be exported via some appropriate /sys object and
   that displayed by sensors().

   There was for example no info in Documentation/hwmon/coretemp for
   my Conree E6400, and TJmax was just guessed by the driver with the
   default of 100C. When i set it to 70C, then the temp values
   become pretty much like what the w83627dhg shows me. And Tcase
   is spec'ed by intel at 61C, so maybe 70C is quite right (or 75C,
   somewhere in the neighborhood)..

3. To me it looks wrong that coretemp.c reads out MSR 1A2H 15:8
   and uses that to calculate ttarget - when tjmax is just guessed
   because MSR 1A2H 23:16 is zero - as is on my E6400 Core2 duo.

   And coretemp.c already has the code to not expose ttarget, it
   should just invoke it whenever it can't determine tjmax either
   from MSR.

   Just saying ;-)

Cheers
    Toerless
On Sun, Jul 13, 2014 at 12:08:38PM -0700, Guenter Roeck wrote:
> On 07/13/2014 11:34 AM, Toerless Eckert wrote:
> >Is there a way to figure out whether the temperatures
> >from "coretemp-isa-0000, Adapter: ISA adapter" are coming from PECI
> >or not ?
> >
> >Eg: Is there a way to ask the CPU itself for these temperature sensor
> >data without using those PECI pins ?
> >
>=20
> That is exactly what coretemp is doing; it reads the temperature directly
> from CPU registers. The SuperIO chip gets the data through PECI. It is
> exactly the same data, though, ie the underlying sensor in the CPU is the=
 same.
> See [1] and [2] for some more details.
>=20
> Neither PECI nor the internal sensor provide absolute temperatures,
> but only a difference to the maximum permitted temperature or TjMax.
>=20
> Both coretemp and the SuperIO chip driver have to be configured for the
> maximum temperature in order to be able to calculate and report the tempe=
rature
> in degrees C. On top of that, the reported value is known to be inaccurate
> for lower temperatures. This means it can only really be relied on for hi=
gh
> temperatures, and the value reported for low temperatures can be highly
> inaccurate (it can easily be 30 degrees C off for Atom CPUs, for example).
> More recent Intel CPUs have a register to read Tjmax, but older CPUs
> like yours don't, and there is always a guessing game what the correct
> TjMax value for a given CPU may be. This becomes even more complicated
> if different CPU revisions have different values for TjMax, as seems to be
> the case for your dual core CPU. All one can hope for is that the BIOS pr=
ograms
> the SuperIO chip correctly, though it is quite common that this is not th=
e case,
> especially with older CPUs where the value of TjMax can not be read from =
the CPU
> itself. Since SuperIO chips depend on the absolute temperature for automa=
tic
> fan speed control, this can cause problems with fan control, especially i=
f the
> CPU runs hotter than the SuperIO chip believes. I _suspect_ this may be w=
hat is
> happening in your case with the quad core CPU, but obviously that is diff=
icult
> to confirm since we don't know any details about it.
>=20
> Guenter
>=20
> ---
> [1] http://en.wikipedia.org/wiki/Platform_Environment_Control_Interface
> [2] http://www.intel.com/content/dam/www/public/us/en/documents/white-pap=
ers/cpu-monitoring-dts-peci-paper.pdf

--=20
---
Toerless.Eckert@informatik.uni-erlangen.de
/C=DE/A=D400/P=3Duni-erlangen/OU=3Dinformatik/S=ECkert/G=3DToerless/

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
