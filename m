From: "Bernd Bausch" <berndbausch@gmail.com>
Date: Wed, 16 Apr 2014 03:44:54 +0000
Subject: Re: [lm-sensors] Asus M5A88-M motherboard, "no pwm-capable sensor modules"
Message-Id: <001c01cf5926$3c69a6e0$b53cf4a0$@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <534B5355.5090102@gmail.com>
In-Reply-To: <534B5355.5090102@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Thanks Jean. Is it OK to continue this conversation out in the open, i.e. on
the mailing list?

Executive summary: you are right about my kernel being too old, and in
addition I have a driver conflict
(http://hansdegoede.livejournal.com/7932.html) that comes up with a 3.x
kernel.=20
Since I want to stay with Centos and 2.6.32, is there anything I can do?

Details:

My kernel is 2.6.32, not quite the 2.6.37 you mention, but I do have k10temp
and it67 drivers:

/lib/modules/2.6.32-431.el6.x86_64/kernel/drivers/hwmon/it87.ko
/lib/modules/2.6.32-431.el6.x86_64/kernel/drivers/hwmon/k10temp.ko

I downloaded the elrepo version of the two modules. Hard to say how they
differ from my installed version; find modinfo output for it87 further
below.

Also, the sensors output (also below) looks sensible, with the exception of
the 16.8 degrees value, which is less than the ambient temperature. It seems
that monitoring works and it's just fan control that doesn't.=20

Next, I tested this with a LiveCD that uses a 3.9 kernel (Debian-based
Kanotix, in case you wonder). By default, I am not able to modprobe it87
because the BIOS ACPI code and it87 access the same hardware device (see
http://hansdegoede.livejournal.com/7932.html). After booting with
acpi_enforce_resources=3Dlax, I can insert the it87 module, and now pwmconf=
ig
does detect a controllable fan. So, I could make it to work if I moved to a
newer kernel, but this is not an option for me, as I need to stay with
Centos/Redhat. Is there anything I can do, perhaps trying to port the newest
it87 driver to my kernel (would be a steep learning curve)?

Cheers,

Bernd

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  s=
ensors output  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
$ sensors
k10temp-pci-00c3
Adapter: PCI adapter
temp1:       +16.8=B0C  (high =3D +70.0=B0C, crit =3D +70.0=B0C)

fam15h_power-pci-00c4
Adapter: PCI adapter
power1:     117.23 W

atk0110-acpi-0
Adapter: ACPI interface
Vcore Voltage:     +0.95 V  (min =3D  +0.80 V, max =3D  +1.60 V)
+3.3V Voltage:     +3.26 V  (min =3D  +2.97 V, max =3D  +3.63 V)
+5V Voltage:       +4.96 V  (min =3D  +4.50 V, max =3D  +5.50 V)
+12V Voltage:     +12.13 V  (min =3D +10.20 V, max =3D +13.80 V)
CPU Fan Speed:    2002 RPM  (min =3D  600 RPM)
Chassis Fan Speed:1506 RPM  (min =3D  600 RPM)
CPU Temperature:   +33.0=B0C  (high =3D +60.0=B0C, crit =3D +95.0=B0C)
MB Temperature:    +34.0=B0C  (high =3D +45.0=B0C, crit =3D +75.0=B0C)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  m=
odinfo output  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

$ modinfo it87.ko  # this is the one from elrepo
filename:       it87.ko
license:        GPL
description:    IT8705F/IT871xF/IT872xF hardware monitoring driver
author:         Chris Gauthron, Jean Delvare <khali@linux-fr.org>
srcversion:     883CCDF9B8356FBE80D52EE
depends:        hwmon-vid
vermagic:       2.6.32-358.el6.x86_64 SMP mod_unload modversions
parm:           force_id:Override the detected device ID (ushort)
parm:           update_vbat:Update vbat if set else return powerup value
(bool)
parm:           fix_pwm_polarity:Force PWM polarity to active high
(DANGEROUS) (bool)

$ modinfo /lib/modules/2.6.32-431.el6.x86_64/kernel/drivers/hwmon/it87.ko
filename:
/lib/modules/2.6.32-431.el6.x86_64/kernel/drivers/hwmon/it87.ko
license:        GPL
description:    IT8705F/8712F/8716F/8718F/8720F/8726F, SiS950 driver
author:         Chris Gauthron, Jean Delvare <khali@linux-fr.org>
srcversion:     839FF779560750484F6FA04
depends:        hwmon-vid
vermagic:       2.6.32-431.el6.x86_64 SMP mod_unload modversions
parm:           force_id:Override the detected device ID (ushort)
parm:           update_vbat:Update vbat if set else return powerup value
(bool)
parm:           fix_pwm_polarity:Force PWM polarity to active high
(DANGEROUS) (bool)


-----Original Message-----
From: Jean Delvare [mailto:jdelvare@suse.de]=20
Sent: Monday, April 14, 2014 4:21 PM
To: Bernd Bausch
Cc: lm-sensors@lm-sensors.org; Phil Perry
Subject: Re: [lm-sensors] Asus M5A88-M motherboard, "no pwm-capable sensor
modules"

Hi Bernd,

On Mon, 14 Apr 2014 12:17:41 +0900, Bernd Bausch wrote:
> I would like to run my PC as silently under Linux as I can under=20
> Windows. Unfortunately I am pretty ignorant about hardware monitoring=20
> and control.
>=20
> Asus provides a fan control utility that allows me to throttle the CPU=20
> fan (not the case fan unfortunately), but I have been unable to do the=20
> same using lm_sensors. pwmconfig reports that there are no pwm-capable=20
> sensors.
>=20
> So I wonder, does pwmconfig tell the truth? If yes, how can the CPU=20
> fan be controlled (it obviously can)? What are my options apart from=20
> leaving things as they are?

What does "sensors" say? Before you go with fan control, you must ensure
that hardware monitoring itself is properly setup.

> This is on Centos 6.5 with an unchanged kernel (2.6.32-431, 64 bit). I=20
> use the standard lm_sensors packages but the newest version of=20
> sensors-detect. I also tried the newest version of pwmconfig.
> sensors-detect and pwmconfig output below.
>=20
> Thanks for listening, and more thanks for replying :)
>=20
> Bernd
>=20
> --------------------------------------------
>=20
> sudo /tmp/sensors-detect
> Stopping lm_sensors:                                       [  OK  ]
> # sensors-detect revision 6243 (2014-03-20 11:23:35 +0100) # Board:=20
> ASUSTeK Computer INC. M5A88-M
> (...)
> Now follows a summary of the probes I have just done.
> Just press ENTER to continue:
>=20
> Driver `it87':
>   * ISA bus, address 0x290
>     Chip `ITE IT8721F/IT8758E Super IO Sensors' (confidence: 9)

Support for this chip was added in kernel 2.6.37.

> Driver `fam15h_power' (autoloaded):
>   * Chip `AMD Family 15h power sensors' (confidence: 9)
>=20
> Driver `k10temp' (autoloaded):
>   * Chip `AMD Family 15h thermal sensors' (confidence: 9)

Support was added in kernel 3.0.

I'm afraid your kernel is simply too old for your hardware, unless Centos
backported support for newer hwmon devices.

Actually for Centos you may be lucky and be able to use Phil Perry's kmods.
Check out at:
  http://elrepo.org/tiki/Packages#K

I see kmod-k10temp and kmod-it87, which are what your board needs. Give it a
try. I've added Phil in Cc, hopefully he can drive from here if things don't
work out of the box.

Thanks,
--
Jean Delvare
SUSE L3 Support


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
