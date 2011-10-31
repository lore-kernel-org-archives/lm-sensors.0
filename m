From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 31 Oct 2011 05:07:45 +0000
Subject: Re: [lm-sensors] Something wrong with support for NCT6776F in
Message-Id: <20111031050745.GA15235@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4EA9CECA.4050007@gmx.de>
In-Reply-To: <4EA9CECA.4050007@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, Oct 31, 2011 at 12:57:36AM -0400, Guenter Roeck wrote:
> Hi Soeren,
>=20
> sorry for the late reply. Busy ...
>=20
> On Thu, Oct 27, 2011 at 05:36:10PM -0400, Soeren D. Schulze wrote:
> > I have an ASRock H67M-ITX motherboard.
> >=20
> > The w83626ehf driver detects:
> >=20
> > [ 3904.608693] w83627ehf: Found NCT6776F chip at 0x290
> >=20
> > "sensors" shows me:
> >=20
> > coretemp-isa-0000
> > Adapter: ISA adapter
> > Physical id 0:  +46.0=B0C  (high =3D +80.0=B0C, crit =3D +98.0=B0C)
> > Core 0:         +46.0=B0C  (high =3D +80.0=B0C, crit =3D +98.0=B0C)
> > Core 1:         +45.0=B0C  (high =3D +80.0=B0C, crit =3D +98.0=B0C)
> > Core 2:         +46.0=B0C  (high =3D +80.0=B0C, crit =3D +98.0=B0C)
> > Core 3:         +46.0=B0C  (high =3D +80.0=B0C, crit =3D +98.0=B0C)
> >=20
> > nct6776-isa-0290
> > Adapter: ISA adapter
> > Vcore:         +0.96 V  (min =3D  +0.00 V, max =3D  +1.74 V)
> > in1:           +0.18 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> > AVCC:          +3.39 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> > +3.3V:         +3.39 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> > in4:           +0.54 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> > in5:           +1.69 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> > 3VSB:          +3.41 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> > Vbat:          +3.31 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> > fan1:            0 RPM  (min =3D    0 RPM)  ALARM
> > fan2:         2180 RPM  (min =3D    0 RPM)  ALARM
> > SYSTIN:        +42.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALA=
RM  sensor=20
> > =3D thermistor
> > CPUTIN:       +127.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  ALA=
RM  sensor=20
> > =3D thermistor

Followup: In my system, the CPU sensor type is reported to be a diode.
Wonder if that is relevant.

Guenter

> > AUXTIN:        -24.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sen=
sor =3D=20
> > thermistor
> > PECI Agent 0:  +46.5=B0C
> > cpu0_vid:     +2.050 V
> > intrusion0:   ALARM
> > intrusion1:   ALARM
> >=20
> >=20
> > Here, CPUTIN and AUXTIN (whatever it is) are obviously wrong.  CPUTIN=20
> > *decreases* towards 17=B0C when the CPU gets hot (non-linearly, though).
> >=20
> Odd. No idea what is going on, though. The registers are quite straightfo=
rward,
> and the same for NCT6775F and NCT6776F. And it works on my system with NC=
T6775F.
>=20
> > This was the first problem.  The second problem occurs when I try to=20
> > control fan2 manually.  The "pwm2" file in sysfs is 255 for anything=20
> > above 2000 RPM, but as you can see above, the fan can do more (I've bee=
n=20
> > at 2600 RPM -- maybe it can do even more), but pwm2 stays at 255.
> >=20
> Looking through the datasheet, I did not find anything obvious. It might
> be possible that the PWM output frequency (register 2 bank 0) somehow aff=
ects
> the fan speed as well. What causes the fan speed to go higher in your sys=
tem ?
>=20
> Guenter
>=20
> >=20
> > I'm using the Debian Linux kernel 3.0.0-3, but the same problem occurs =

> > when I pull the latest w83626ehf.c file from git.
> >=20
> >=20
> > Hope this was a tiny bit helpful.  If I can help you finding the source=
=20
> > of this problem, please tell me.
> >=20
> > S=F6ren
> >=20
> > _______________________________________________
> > lm-sensors mailing list
> > lm-sensors@lm-sensors.org
> > http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>=20
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
