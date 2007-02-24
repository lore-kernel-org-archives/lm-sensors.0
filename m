From: hmh@hmh.eng.br (Henrique de Moraes Holschuh)
Date: Sat, 24 Feb 2007 18:20:24 +0000
Subject: [lm-sensors] RFC: conversion of ibm-acpi to hwmon sysfs
Message-Id: <20070224182024.GA23865@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

I am working on a conversion of ibm-acpi to sysfs, and in the process I am
trying to do away with every non-generic interface I can.  At least two
ibm-acpi interfaces map directly to hwmon/lm-sensors style: fan and thermal.
I'd like to expose them as hwmon attributes, using the hwmon generic
interfaces for fan control and thermal sensor readings.

I would really appreciate feedback from the lm-sensors/hwmon group on how to
best achieve that.

Thermal is relatively easy.  A thinkpad has either 8 or up to 16 thermal
sensors (typically, 12 sensors), and I can simply export them as
temp##_input, already converted to milidegree Celcius.

However, some thinkpad thermal sensors are hotswappable (they're inside
battery packs, for example).  What is the recommended way to deal with that?

I was planning to return -ENXIO for sensors thare are currently unavailable,
and I could also try to make their sysfs attributes go away (and come back
again) when the driver detects such a change -- note that I don't get events
from the thinkpad firmware when a sensor gets disconnected or reconnected, I
need to poll them to know that).  Is that the recommended way to go about
it?  Or should I just leave all entries there and return -ENXIO on the
invalid ones (the firmware returns -128 for invalid sensors).

fan control is a bit more hard to map to the hwmon interface, as the
thinkpad firmware exports a higher level interface than your regular
thermal-and-fan-monitor chip (and it is far less documented and far more
buggy than regular chips :p):

Most thinkpads have a tachometer that returns data in RPM, and that gets
mapped to fan##_input.  The tachometer can get stale in fan control
disengaged mode (see below), how should I export that information to
userspace?  There is nothing in the standard hwmon sysfs for that, and it
*is* useful to userspace to know the last measured speed, so I don't want to
return -ENXIO or somesuch on fan##_input...   What do you guys suggest I do?
Add an ibm-acpi specific fan##_input_valid attribute that reads 0/1?  Or not
export that information in the first place?  Should I propose such an
attribute to the generic interface?

The thinkpad EC has three modes of fan operation: manual, where there are
seven fan speed levels (0=3Doff, 1=3Dslowest, 7=FAstest) that map to differ=
ent
speeds (usually fan stopped plus three different speeds, so it is not a 1:1
mapping).  auto, where it selects one of the levels by itself, and
disengaged, where it kicks the fan to its highest speed (which usually is
quite higher than level 7).  The levels are closed-loop-controlled, and
track a model-specific desired RPM value.  That allows for consistent
hardware behaviour with fans that are going old or are somewhat dirty.

I was thinking of using pwm##_enable to: force manual mode, level 0 (fan
off) when pwm##_enable is 0, force manual mode when it is 1, and force auto
mode when it is 2+.  I can query what mode the firmware is in, so reading
pwm##_enable is not a problem.

The level for manual mode would be set by pwm##: if it is 0, force level 0.
If it is between 1..90, I'd select one of the six non-stopped fan speed
levels.  If it is above 90, I'd select disengaged mode.

Reading pwm## is not easy.  It is indeterminate if pwm##_enable is set to 2+
(auto mode)... what should I return, then?   For manual mode, I was planning
to return the quantized value (i.e. if 1..26 select fan level 1, a read will
return 26).  For disengaged value (a write of 90..100 with pwm##_enable set
to 1), I'd always return 100.  Is that a good way to implement it?

Note that this interface does not map exacly what the hardware is doing.
When one sets the fan to disengaged mode, the firmware slowly increases fan
speed until it hits max, for example.  There is no way to get any feedback
on what the firmware is *really* doing to the fan, other than the tachometer
readings.

I was going to place all fan attributes in a sysfs group (subdirectory)
named "fan", and all thermal attributes in a sysfs group named "thermal". Is
that acceptable?

--=20
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

