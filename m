From: "Michael D Powell" <mdpowell@nyx.net>
Date: Wed, 06 Apr 2011 00:33:52 +0000
Subject: Re: [lm-sensors] [PATCH v5 00/11] hwmon: (w83627ehf) Add support
Message-Id: <1302050032.4007.1437895361@webmail.messagingengine.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1299261486-15190-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1299261486-15190-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


Perhaps I'm missing something obvious or simple, but I always get fan
RPM of zero from lm sensors and can't seem to debug it.  Thanks in
advance for developing support for the
nct6775f.

Here's my setup:

Intel DH57DD board with core i5-750 cpu
bios JGIBX10J.86A 1219.2132 (bios date 12/19/2010)
3 4-pin fans plugged into the motherboard
bios setup reports positive fan rpm values that seem reasonable
at least one of the fans runs very fast after a reset for a second or
so, then they all slow down to < 1000 rpm.  Even under heavy CPU load,
the fans don't seem to speed up much if at all, but the system is pretty
well vented and doesn't overheat.

Kernel module installed from http://roeck-us.net/linux/drivers/w83627ehf
on 2011/04/04 and manually built and installed using that Makefile.
kernel 2.6.32-5-amd64 (Debian 2.6.32-31)
Debian squeeze
sensors version 3.1.2 with libsensors version 3.1.2

No overrides set when loading the module (just "modprobe w83627ehf").=20
No overrides for nct6775 in /etc/sensors3.conf.  On previous
versions of the driver which did not support nct6775f, I used
force_id=3D0xa510 to get some temperature value output.  But all fan RPMs
were zero using that module and id value too.

Since the fan divisor is read-only now, I have not been able to change
it.  It is already 128 anyway--see below. =20

output of "sensors"

$ sensors
coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +32.0=B0C  (high =3D +84.0=B0C, crit =3D +100.0=B0C) =20

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +29.0=B0C  (high =3D +84.0=B0C, crit =3D +100.0=B0C) =20

coretemp-isa-0002
Adapter: ISA adapter
Core 2:      +33.0=B0C  (high =3D +84.0=B0C, crit =3D +100.0=B0C) =20

coretemp-isa-0003
Adapter: ISA adapter
Core 3:      +30.0=B0C  (high =3D +84.0=B0C, crit =3D +100.0=B0C) =20

nct6775-isa-0680
Adapter: ISA adapter
in0:         +0.87 V  (min =3D  +0.00 V, max =3D  +1.74 V)  =20
in1:         +0.77 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
in2:         +3.34 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
in3:         +3.34 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
in4:         +1.26 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
in5:         +0.75 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
in6:         +1.06 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
in7:         +3.30 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
in8:         +3.26 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
fan1:          0 RPM  (min =3D    0 RPM, div =3D 128)  ALARM
fan2:          0 RPM  (min =3D    0 RPM, div =3D 128)  ALARM
fan3:          0 RPM  (min =3D    0 RPM, div =3D 128)  ALARM
fan4:          0 RPM  (div =3D 128)  ALARM
SYSTIN:      +31.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALARM  se=
nsor diode
CPUTIN:      +45.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D diode
AUXTIN:      +23.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor th=
ermistor
cpu0_vid:   +1.500 V

Output of pwmconfig:# pwmconfig=20
# pwmconfig revision 5770 (2009-09-16)
This program will search your sensors for pulse width modulation (pwm)
controls, and test each one to see if it controls a fan on
your motherboard. Note that many motherboards do not have pwm
circuitry installed, even if your sensor chip supports pwm.

We will attempt to briefly stop each fan using the pwm controls.
The program will attempt to restore each fan to full speed
after testing. However, it is ** very important ** that you
physically verify that the fans have been to full speed
after the program has completed.

Found the following devices:
   hwmon0/device is coretemp
   hwmon1/device is coretemp
   hwmon2/device is coretemp
   hwmon3/device is coretemp
   hwmon4/device is nct6775

Found the following PWM controls:
   hwmon4/device/pwm1
   hwmon4/device/pwm2
   hwmon4/device/pwm3

Giving the fans some time to reach full speed...
Found the following fan sensors:
   hwmon4/device/fan1_input     current speed: 0 ... skipping!
   hwmon4/device/fan2_input     current speed: 0 ... skipping!
   hwmon4/device/fan3_input     current speed: 0 ... skipping!
   hwmon4/device/fan4_input     current speed: 0 ... skipping!

I can manually write "0" or "1" to
/sys/devices/platform/w83627ehf.1664/pwm1_mode, but it has no effect on
anything. pwm[1-3] all have value 255.

Any thoughts or other info I can provide?  Thanks.

__________________________________________________________________
Michael D. Powell

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
