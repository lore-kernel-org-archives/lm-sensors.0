From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 21 Oct 2013 15:16:16 +0000
Subject: Re: [lm-sensors] [REGRESSION?] sensors and fancontrol not seeing armada_thermal on 3.12-rc series
Message-Id: <20131021151616.GA17598@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <87ppqzolsu.fsf@natisbad.org>
 <20131021091739.739142e8@endymion.delvare>
In-Reply-To: <20131021091739.739142e8@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jean Delvare <khali@linux-fr.org>
Cc: Arnaud Ebalard <arno@natisbad.org>, Eduardo Valentin <eduardo.valentin@ti.com>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, lm-sensors@lm-sensors.org, linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jason Cooper <jason@lakedaemon.net>

On Mon, Oct 21, 2013 at 09:17:39AM +0200, Jean Delvare wrote:
> Hi Arnaud,
>=20
> On Sun, 20 Oct 2013 20:10:41 +0200, Arnaud Ebalard wrote:
> > With 3.12-rc series, sysfs support for thermal susbsytem (and/or hwmon
> > one) was modified in such a way that sensors utility (current 3.3.4
> > version with 3.3.4 version of libsensors from lm-sensors package on
> > Debian unstable) does not see the temperature sensor anymore on armada
> > 370 platforms (not tested on others). Additionally, the changes break
> > existing configurations of fancontrol utility, which prevents the=20
> > fan to be regulated correctly w/o recreating an /etc/fancontrol w/
> > pwmconfig.
> >=20
> > Here is what I have on my Armada 370-based system on a 3.11.5:
> >=20
> > # sensors
> > g762-i2c-0-3e
> > Adapter: mv64xxx_i2c adapter
> > fan1:        2457 RPM  (div =3D 1)
> >=20
> > armada_thermal-virtual-0
> > Adapter: Virtual device
> > temp1:        +45.7=B0C =20
> >=20
> > And what I get on 3.12-rc6:
> >=20
> > # sensors
> > g762-i2c-0-3e
> > Adapter: mv64xxx_i2c adapter
> > fan1:        1350 RPM  (div =3D 1)
> >=20
> >=20
> > Monitoring what sensors does w/ strace, I started looking at the changes
> > to /sys/class/hwmon/hwmon1/:
> >=20
> > On 3.11.5:
> >=20
> > # find /sys/class/hwmon/hwmon1/
> > /sys/class/hwmon/hwmon1/
> > /sys/class/hwmon/hwmon1/name
> > /sys/class/hwmon/hwmon1/subsystem
> > /sys/class/hwmon/hwmon1/uevent
> > /sys/class/hwmon/hwmon1/temp1_input
> >=20
> > On 3.12-rc6:
> >=20
> > # find /sys/class/hwmon/hwmon1/
> > /sys/class/hwmon/hwmon1/
> > /sys/class/hwmon/hwmon1/name
> > /sys/class/hwmon/hwmon1/device
> > /sys/class/hwmon/hwmon1/subsystem
> > /sys/class/hwmon/hwmon1/uevent
> > /sys/class/hwmon/hwmon1/temp1_input
> >=20
> > # find /sys/class/hwmon/hwmon1/device/
> > /sys/class/hwmon/hwmon1/device/
> > /sys/class/hwmon/hwmon1/device/temp
> > /sys/class/hwmon/hwmon1/device/type
> > /sys/class/hwmon/hwmon1/device/hwmon1
> > /sys/class/hwmon/hwmon1/device/hwmon1/name
> > /sys/class/hwmon/hwmon1/device/hwmon1/device
> > /sys/class/hwmon/hwmon1/device/hwmon1/subsystem
> > /sys/class/hwmon/hwmon1/device/hwmon1/uevent
> > /sys/class/hwmon/hwmon1/device/hwmon1/temp1_input
> > /sys/class/hwmon/hwmon1/device/subsystem
> > /sys/class/hwmon/hwmon1/device/policy
> > /sys/class/hwmon/hwmon1/device/uevent
> > /sys/class/hwmon/hwmon1/device/passive
>=20
> Can you please share the full output of "strace sensors"? This will
> help me understand which exact code paths are taken in libsensors.
>=20
> > Is that expected? As for sensors, it *seems* to be bothered to find a
> > device/ folder in /sys/class/hwmon/hwmon1/ w/o no name entry in it.
>=20
> It should be able to cope with this just fine. The radeon driver does
> exactly this and libsensors has no problem with it.=20
>=20
Hi Jean,

I think it is more likely that the problem is related to parsing the 'subsy=
stem'
link. If I understand the code in lib/sysfs.c correctly, it doesn't recogni=
ze
'thermal' (which I think is the subsystem name, but I may be wrong) and ign=
ores
the device as unknown.

Question is if we can come up with some more generic code to handle that ca=
se.
Define SENSORS_BUS_TYPE_OTHER and treat it similar to virtual, maybe ?
But then there can be more than one of those, so you would need some means
for enumerating bus and chip numbers, so I don't know if that is feasible.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
