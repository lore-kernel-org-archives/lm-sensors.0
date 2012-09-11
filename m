From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 11 Sep 2012 03:38:47 +0000
Subject: Re: [lm-sensors] [PATCH 0/1] Add lm-sensors support for it8771 (Asus E350M1-I).
Message-Id: <20120911033847.GA31782@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1347060881-14106-1-git-send-email-kelly@silka.with-linux.com>
In-Reply-To: <1347060881-14106-1-git-send-email-kelly@silka.with-linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean,

On Sat, Sep 08, 2012 at 03:11:53PM -0600, Kelly Anderson wrote:
> On 09/08/2012 08:18 AM, Guenter Roeck wrote:
> >On Sat, Sep 08, 2012 at 01:21:02AM -0600, Kelly Anderson wrote:
> >>On 09/07/2012 06:28 PM, Guenter Roeck wrote:
> >>>On Fri, Sep 07, 2012 at 05:34:40PM -0600, Kelly Anderson wrote:
> >>>>Signed-off-by: Kelly Anderson <kelly@silka.with-linux.com>
> >>>>
> >>>>Kelly Anderson (1):
> >>>>   Add lm-sensors support for it8771 (Asus E350M1-I).
> >>>>
> >>>>  drivers/hwmon/it87.c | 19 ++++++++++++++-----
> >>>>  1 file changed, 14 insertions(+), 5 deletions(-)
> >>>>
> >>>Hi Kelly,
> >>>
> >>>both in one message (Signed-off is part of the commit log), please, and
> >>>
> >>>WARNING: line over 80 characters
> >>>#87: FILE: drivers/hwmon/it87.c:64:
> >>>+enum chips { it87, it8712, it8716, it8718, it8720, it8721, it8728, it=
8771,
> >>>it8782,
> >>>
> >>>Just a note for next time - no need to resend. We'll need to sort out =
what
> >>>to do with the patch, ie if we want to take the risk of applying it wi=
thout
> >>>technical documentation.
> >>>
> >>>In this context - how does the fan output look like in your system ? D=
oes it
> >>>make sense ? Also, can you control the fan speed with the pwm attribut=
es,
> >>>and do the pwmX_auto_point4_XXX attributes report reasonable informati=
on ?
> >>>
> >>>Thanks,
> >>>Guenter
> >>Yes, the fan speed seems appropriate when in auto mode (changes
> >>depending on load).
> >>
> >>Pwm fan control seems to work also, the fan speed changes as
> >>pwmcontrol runs it's check.
> >>
> >Does the number of fans reported match the number of fans in your system=
 ?
> >How many fans are reported ?
> >
> >Thanks,
> >Guenter
>=20
> Yes, the number of fans identified matches the system's
> configuration.  I have one fan connected, with the E350M1-I's
> massive passive heatsink it's not necessary to have more than one.
> Lm-sensors does detect both fan headers.
>=20
> fan1 is the cpu fan.
> fan2 is the chassis fan.
>=20
> It might be useful to relabel fan1 to "CPU Fan" as is done on some
> other sensors.
>=20
> it8771-isa-0290
> Adapter: ISA adapter
> in0:          +0.56 V  (min =3D  +2.78 V, max =3D  +0.23 V)  ALARM
> in1:          +2.22 V  (min =3D  +1.64 V, max =3D  +0.74 V)  ALARM
> in2:          +2.86 V  (min =3D  +1.31 V, max =3D  +2.64 V)  ALARM
> +3.3V:        +3.34 V  (min =3D  +4.20 V, max =3D  +5.40 V)  ALARM
> in4:          +2.22 V  (min =3D  +2.24 V, max =3D  +0.67 V)  ALARM
> in5:          +2.93 V  (min =3D  +2.96 V, max =3D  +0.92 V)  ALARM
> in6:          +2.22 V  (min =3D  +1.50 V, max =3D  +1.98 V)  ALARM
> 3VSB:         +3.38 V  (min =3D  +5.14 V, max =3D  +3.41 V)  ALARM
> Vbat:         +3.26 V
> fan1:        1175 RPM  (min =3D   23 RPM)
> fan2:           0 RPM  (min =3D   12 RPM)  ALARM
> temp1:        +40.0=B0C  (low  =3D -11.0=B0C, high =3D +94.0=B0C)  sensor=
 =3D thermistor
> temp2:        +34.0=B0C  (low  =3D -26.0=B0C, high =3D +10.0=B0C)  ALARM
> sensor =3D thermistor
> temp3:         -8.0=B0C  (low  =3D -28.0=B0C, high =3D +63.0=B0C)  sensor=
 =3D thermistor
> intrusion0:  OK
>=20

I am inclined to accept this patch, and also add support for IT8772E, assum=
ing
it is fully compatible.

We have had a number of requests, it has been tested, OpenHardwareMonitor
supports it, and mosys as well as coreboot have extensive support for IT877=
2E.
So overall, even though we don't have access to data sheets, I think we know
enough and the risk is quite low.

Thoughts / comments / objections ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
