From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 26 Feb 2007 16:27:16 +0000
Subject: [lm-sensors] RFC: conversion of ibm-acpi to hwmon sysfs
Message-Id: <20070226172716.b2e956b7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070224182024.GA23865@khazad-dum.debian.net>
In-Reply-To: <20070224182024.GA23865@khazad-dum.debian.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: lm-sensors@lm-sensors.org, ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

Hi Henrique,

On Sat, 24 Feb 2007 16:20:24 -0200, Henrique de Moraes Holschuh wrote:
> I am working on a conversion of ibm-acpi to sysfs, and in the process I am
> trying to do away with every non-generic interface I can.  At least two
> ibm-acpi interfaces map directly to hwmon/lm-sensors style: fan and therm=
al.
> I'd like to expose them as hwmon attributes, using the hwmon generic
> interfaces for fan control and thermal sensor readings.

This would be really great. I was thinking about doing the same for the
standard ACPI "fan" and "thermal" modules too, but I happen to be too
busy for that :( Making these drivers compatible with the hwmon
interface is one way to solve the ACPI vs. hwmon issues which have been
reported and discussed lately.

> I would really appreciate feedback from the lm-sensors/hwmon group on how=
 to
> best achieve that.
>=20
> Thermal is relatively easy.  A thinkpad has either 8 or up to 16 thermal
> sensors (typically, 12 sensors), and I can simply export them as
> temp##_input, already converted to milidegree Celcius.
>=20
> However, some thinkpad thermal sensors are hotswappable (they're inside
> battery packs, for example).  What is the recommended way to deal with th=
at?
>=20
> I was planning to return -ENXIO for sensors thare are currently unavailab=
le,
> and I could also try to make their sysfs attributes go away (and come back
> again) when the driver detects such a change -- note that I don't get eve=
nts
> from the thinkpad firmware when a sensor gets disconnected or reconnected=
, I
> need to poll them to know that).  Is that the recommended way to go about
> it?  Or should I just leave all entries there and return -ENXIO on the
> invalid ones (the firmware returns -128 for invalid sensors).

Had you been able to detect disconnections and reconnections as they
happen, removing and creating the files on the file would have been
nice. But as you can't do that, returning -ENXIO on disconnected
sensors sounds sensible. I don't think any other driver does this at
the moment though, so maybe libsensors will need to be updated to
handle this behavior properly.

> fan control is a bit more hard to map to the hwmon interface, as the
> thinkpad firmware exports a higher level interface than your regular
> thermal-and-fan-monitor chip (and it is far less documented and far more
> buggy than regular chips :p):
>=20
> Most thinkpads have a tachometer that returns data in RPM, and that gets
> mapped to fan##_input.  The tachometer can get stale in fan control
> disengaged mode (see below), how should I export that information to
> userspace?  There is nothing in the standard hwmon sysfs for that, and it
> *is* useful to userspace to know the last measured speed, so I don't want=
 to
> return -ENXIO or somesuch on fan##_input...   What do you guys suggest I =
do?
> Add an ibm-acpi specific fan##_input_valid attribute that reads 0/1?  Or =
not
> export that information in the first place?  Should I propose such an
> attribute to the generic interface?

I'm surprised that the fan speed reading goes stale when a fan runs at
max speed, it doesn't make much physical sense and it's quite the
opposite of what happens usually: tachometers start failing when PWM
modulation distorts the signal to much.

Either way, I do not think that knowing the last measured speed is that
useful. Given that it may be completely unrelated with the current
value, I'd rather return -ENXIO or -ERETRY if there is a reasonable
chance to get a valid reading soon after. If applications wants to
cache the last read value instead of reporting an error, it's up to
them, not the driver's decision.

I don't want to see *_valid files being created, it doesn't add any
value. Just try to read the data from the file, and check for errors.

> The thinkpad EC has three modes of fan operation: manual, where there are
> seven fan speed levels (0=3Doff, 1=3Dslowest, 7=FAstest) that map to diff=
erent
> speeds (usually fan stopped plus three different speeds, so it is not a 1=
:1
> mapping).  auto, where it selects one of the levels by itself, and
> disengaged, where it kicks the fan to its highest speed (which usually is
> quite higher than level 7).  The levels are closed-loop-controlled, and
> track a model-specific desired RPM value.  That allows for consistent
> hardware behaviour with fans that are going old or are somewhat dirty.
>=20
> I was thinking of using pwm##_enable to: force manual mode, level 0 (fan
> off) when pwm##_enable is 0, force manual mode when it is 1, and force au=
to
> mode when it is 2+.  I can query what mode the firmware is in, so reading
> pwm##_enable is not a problem.

pwm#_enable =3D 0 means fan# at full speed, _not_ fan# stopped. Fan# stopped
is pwm#_enable =3D 1 and pwm# =3D 0.

> The level for manual mode would be set by pwm##: if it is 0, force level =
0.
> If it is between 1..90, I'd select one of the six non-stopped fan speed
> levels.  If it is above 90, I'd select disengaged mode.

According to your description, the disengaged mode corresponds to
pwm_enable =3D 0 (full speed), so I don't want it to be set automatically
when the user writes a high value to pwm.

> Reading pwm## is not easy.  It is indeterminate if pwm##_enable is set to=
 2+
> (auto mode)... what should I return, then?   For manual mode, I was plann=
ing
> to return the quantized value (i.e. if 1..26 select fan level 1, a read w=
ill
> return 26).  For disengaged value (a write of 90..100 with pwm##_enable s=
et
> to 1), I'd always return 100.  Is that a good way to implement it?

Note that the "native" PWM scale is from 0 to 255, not 0 to 100 (I know
it's somewhat confusing, but it's historical and makes drivers more
simple.)

You do not have to return the actual PWM value in automatic mode. Most
chips don't report it and as a result most drivers don't. In automatic
mode, pwm usually holds the value which would be set if manual mode was
to be enabled. Only a few drivers report the current PWM value in
automatic mode there.

> Note that this interface does not map exacly what the hardware is doing.
> When one sets the fan to disengaged mode, the firmware slowly increases f=
an
> speed until it hits max, for example.  There is no way to get any feedback
> on what the firmware is *really* doing to the fan, other than the tachome=
ter
> readings.

No big deal.

> I was going to place all fan attributes in a sysfs group (subdirectory)
> named "fan", and all thermal attributes in a sysfs group named "thermal".=
 Is
> that acceptable?

No, it's not, as it wouldn't be compatible with what all the other
drivers do and what libsensors expects.

Thanks,
--=20
Jean Delvare

