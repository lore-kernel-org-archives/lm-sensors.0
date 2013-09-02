From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 02 Sep 2013 23:19:03 +0000
Subject: [lm-sensors] [GIT PULL] hwmon updates for 3.12
Message-Id: <20130902231903.GA20838@roeck-us.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4415642114051408546=="
List-Id: <lm-sensors.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org


--===============4415642114051408546==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull hwmon updates for Linux 3.12 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus

Thanks,
Guenter

------

The following changes since commit d4e4ab86bcba5a72779c43dc1459f71fea3d89c8:

  Linux 3.11-rc5 (2013-08-11 18:04:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-linus

for you to fetch changes up to f060c658b820141f18abd7b71586d628464a03ea:

  hwmon: (htu21) Add Measurement Specialties HTU21D support (2013-08-29 09:09:12 -0700)

----------------------------------------------------------------
New driver for HTU21D (humidity sensor)
Add support for Fam16h (Kabini) to k10temp
Add support for NCT6102D/6106D and NCT6791D to nct6775 driver
Add support for ADS1115 to ads1015 driver
Add support for hibernate to w83627ehf and nct6775 drivers
Some minor cleanups

----------------------------------------------------------------
Dan Carpenter (2):
      hwmon: (nct6775) Fix size of data->temp array
      hwmon: (adt7462) ADT7462_REG_VOLT_MAX() should return 0

Darrick J. Wong (1):
      hwmon: Change my email address.

David Bartley (1):
      hwmon: (nct6775) Add support for NCT6791D

Evgeniy Dushistov (1):
      hwmon: (ads1015) Add support for ADS1115

Guenter Roeck (7):
      hwmon: (coretemp) Atom CPUs don't support TjMax; no warning needed
      hwmon: (nct6775) Allocate attributes dynamically from templates
      hwmon: (nct6775) Support two SuperIO chips in the same system
      hwmon: (nct6775) Add support for NCT6102D/6106D
      hwmon: (nct6775) Add support for critical low/high temperature limits on NCT6106
      hwmon: (nct6775) Add support for beep attributes
      hwmon: (nct6775) Avoid using device platform data outside probe function

Harald Judt (2):
      hwmon: (nct6775) Add support for hibernate
      hwmon: (w83627ehf) Add support for hibernate

Jingoo Han (1):
      hwmon: use dev_get_platdata()

Wei Hu (1):
      hwmon: (k10temp) Add support for Fam16h (Kabini)

William Markezana (1):
      hwmon: (htu21) Add Measurement Specialties HTU21D support

 Documentation/hwmon/ads1015      |    8 +-
 Documentation/hwmon/htu21        |   46 +
 Documentation/hwmon/k10temp      |    1 +
 drivers/hwmon/Kconfig            |   18 +-
 drivers/hwmon/Makefile           |    1 +
 drivers/hwmon/acpi_power_meter.c |    4 +-
 drivers/hwmon/ads1015.c          |   27 +-
 drivers/hwmon/ads7828.c          |    2 +-
 drivers/hwmon/adt7462.c          |    8 +-
 drivers/hwmon/adt7470.c          |    4 +-
 drivers/hwmon/coretemp.c         |   14 +-
 drivers/hwmon/ds620.c            |    2 +-
 drivers/hwmon/f71805f.c          |    2 +-
 drivers/hwmon/f71882fg.c         |    2 +-
 drivers/hwmon/f75375s.c          |    3 +-
 drivers/hwmon/g762.c             |    2 +-
 drivers/hwmon/gpio-fan.c         |    2 +-
 drivers/hwmon/htu21.c            |  199 +++
 drivers/hwmon/i5k_amb.c          |    4 +-
 drivers/hwmon/ibmaem.c           |    4 +-
 drivers/hwmon/ibmpex.c           |    4 +-
 drivers/hwmon/ina2xx.c           |    4 +-
 drivers/hwmon/it87.c             |    6 +-
 drivers/hwmon/k10temp.c          |    3 +-
 drivers/hwmon/lm87.c             |    4 +-
 drivers/hwmon/max197.c           |    2 +-
 drivers/hwmon/max6639.c          |    2 +-
 drivers/hwmon/mcp3021.c          |    7 +-
 drivers/hwmon/nct6775.c          | 2531 +++++++++++++++++++-------------------
 drivers/hwmon/ntc_thermistor.c   |    2 +-
 drivers/hwmon/pc87427.c          |    4 +-
 drivers/hwmon/pmbus/pmbus_core.c |    2 +-
 drivers/hwmon/s3c-hwmon.c        |    6 +-
 drivers/hwmon/sht15.c            |    4 +-
 drivers/hwmon/smsc47m1.c         |    4 +-
 drivers/hwmon/w83627ehf.c        |   22 +-
 drivers/hwmon/w83627hf.c         |    6 +-
 drivers/misc/ics932s401.c        |    4 +-
 38 files changed, 1618 insertions(+), 1352 deletions(-)
 create mode 100644 Documentation/hwmon/htu21
 create mode 100644 drivers/hwmon/htu21.c

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSJRznAAoJEMsfJm/On5mBCrkP+wVNyG8Ab7nf9pWamyfqflaF
mmQAvYVlqP9NHdUZjCwI87cWihGpYMPHuDeBbwFtzhxBtjYstzha6GpkgtEJTjnH
CszYgaLBc7OGoOBw4PPloe2+IEFZcSWIPhnI/jJp1bbjD//zFS+3Wzr8wTu94Zv2
8HrsIw4JqRkuMBPAKHRcKycKDOqLBko3EpVx/h1eosZUSbrpEOiWutJvsSLw+2EP
22wvjaIZVDGHpVykRF9kOOt2XVGGD298YW9DpmEIfmPwv2Utm8NN50dOjNO8TT/l
ukn0SC295acaIklkjJ+YScnc4keTZuK3gJ6ndlfmAWXnMwOSN60tBWNXG50IYMLt
e15DGsQxNiM0OzSO84+NHGqinSTaW2NVHH9ZkLkIskGM0ALVoydjfKYLBoYxmQqV
g0P2oNkwiljBRe3lood+eA3OOoKGTayKMUvEsZvaTUdroGHxJCJzYAToMrZSWyHb
hXIchkuGL7JapdoChSw/wGGv7lb3UXZG3lprilTylbwPjsTynnoJm8fJBwJXZAyt
cNhbj/YBNUzdzyF1PxWPnftVHtwwWKnRJ6L11WzWTtg+BPFPm3NGNAC9ce0p2R6L
QvkxyvnsV5ZLSZCtRnDhQc7lGJ+vnbOvf3tZrtgegH9iAXnK1XhyJ4UNb2Jk5bv5
9LEEieYBBZib5m5BVf1I
=48w7
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--


--===============4415642114051408546==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4415642114051408546==--
