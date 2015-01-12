From: Pavel Machek <pavel@ucw.cz>
Date: Mon, 12 Jan 2015 08:36:25 +0000
Subject: Re: [lm-sensors] hwmon strangeness, no fan control on w83627dhg
Message-Id: <20150112083625.GC27501@amd>
List-Id: <lm-sensors.vger.kernel.org>
References: <20150108202919.GA25118@amd>
In-Reply-To: <20150108202919.GA25118@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon 2015-01-12 08:22:38, Jean Delvare wrote:
> Hi Pavel,
>=20
> On Thu, 8 Jan 2015 23:58:25 +0100, Pavel Machek wrote:
> > > Le Thursday 08 January 2015 =E0 21:29 +0100, Pavel Machek a =E9crit :
> > > > hwmon is quite incosistent on my machine: in hwmon0 case, temperatu=
re
> > > > files are in directly in hwmon0 subdirectory, but in hwmon1 case, t=
hey
> > > > are in hwmon1/device/ . Is that expected? Why is it so?
> > >=20
> > > This is for historical reasons. We are in the process of cleaning it =
all
> > > up (attributes should always be in the hwmon class device) but there =
are
> > > many drivers left to convert.
> >=20
> > So my "hwmon0" is correct and "hwmon1" needs conversion, right?
>=20
> Correct. Or to put it in more concrete words: the coretemp driver was
> already converted (since kernel v3.15) but the w83627ehf driver was
> not.

I assume that is this commit?

commit d72d19c26c417d514787ae85b197af34de286c0a
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Sun Feb 16 15:49:04 2014 -0800

    hwmon: (coretemp) Convert to use
    devm_hwmon_device_register_with_groups

    Simplify code, reduce code size, and attach sysfs attributes to
    hwmon device.

    For this driver, the only attribute created is the name attribute.
        Other attributes are still created and removed dynamically as
        cores
	    are added or removed.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
Tested-by: Jean Delvare <jdelvare@suse.de>
	   =20

> > > Check the value of pwm2_enable. If automatic mode is set (pwm2_enable=
 >=3D
> > > 2), you can't control the output value directly. Same if control is
> > > disabled altogether (pwm2_enable =3D 0) but I'm not sure if the w8362=
7ehf
> > > driver supports that. You can only control if in manual mode
> > > (pwm2_enable =3D 1.)
> >=20
> > It is in manual mode after boot... (but I think there's some fan
> > control going on, weird; I may be imagining it, was not able to
> > trigger it on purpose).
>=20
> Some fans are self regulating, independent of what the motherboard
> does. Maybe you have one of these?

Dunno. When I switch the mode from PWM to voltage control, fan does
speed up a lot. So there is _some_ control from the w83627ehf.

> >=20
> > root@amd:/sys/class/hwmon/hwmon1/device# cat pwm2_enable
> > 1
> > root@amd:/sys/class/hwmon/hwmon1/device# cat pwm2
> > 80
> > root@amd:/sys/class/hwmon/hwmon1/device# echo 0 > pwm2
> > root@amd:/sys/class/hwmon/hwmon1/device# cat pwm2
> > 80
> > root@amd:/sys/class/hwmon/hwmon1/device#
> >=20
> > I even tried to set it to 1, but no luck:
> >=20
> > root@amd:/sys/class/hwmon/hwmon1/device# echo 1 > pwm2_enable
> > root@amd:/sys/class/hwmon/hwmon1/device# echo 0 > pwm2
> > root@amd:/sys/class/hwmon/hwmon1/device# cat pwm2
> > 80
> > root@amd:/sys/class/hwmon/hwmon1/device# echo 2 > pwm2
> > root@amd:/sys/class/hwmon/hwmon1/device# cat pwm2
> > 80
> > root@amd:/sys/class/hwmon/hwmon1/device#
> >=20
> > ...and set it there and back:
> >=20
> > root@amd:/sys/class/hwmon/hwmon1/device# echo 2 > pwm2_enable
> > root@amd:/sys/class/hwmon/hwmon1/device# echo 1 > pwm2_enable
> > root@amd:/sys/class/hwmon/hwmon1/device# cat pwm2
> > 80
> > root@amd:/sys/class/hwmon/hwmon1/device# echo 40 > pwm2
> > root@amd:/sys/class/hwmon/hwmon1/device# cat pwm2
> > 80
> > root@amd:/sys/class/hwmon/hwmon1/device#
> >=20
> > Any other ideas?
>=20
> That would be a bug. Which kernel version are you running? Your chip is
> the "P" flavor of the W83627DHG, it is more recent and less popular so
> it is entirely possible that it wasn't properly tested and some
> differences with the original W83627DHG are not handled by the driver.
> Right now the driver handles both chips as equivalent.

This was 3.18 or 3.19-rc. Probably latter.

> I don't have much time to spend on this right now but you should start
> by comparing the datasheets of the W83627DHG and the W83627DHG-P
> looking for differences.

Ok, let me take a look...
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
