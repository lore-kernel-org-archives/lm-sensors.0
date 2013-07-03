From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 03 Jul 2013 16:40:14 +0000
Subject: [lm-sensors] [GIT PULL (resend)] hwmon updates for 3.11
Message-Id: <20130703164014.GC12506@roeck-us.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0384558347670889140=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20130701140925.GA30297@roeck-us.net>
In-Reply-To: <20130701140925.GA30297@roeck-us.net>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org


--===============0384558347670889140==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Resending through a different e-mail provider, just in case
it got Lost In Spam again.

If it didn't, sorry for the noise.

---=20

Hi Linus,

Please pull hwmon updates for Linux 3.11 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git =
hwmon-for-linus

Thanks,
Guenter
------

The following changes since commit 7d132055814ef17a6c7b69f342244c410a5e000f:

  Linux 3.10-rc6 (2013-06-15 11:51:07 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git ta=
gs/hwmon-for-linus

for you to fetch changes up to a50d9a4d9ad3c71341788099d733e4151b8a511b:

  hwmon: (ds1621) Fix temperature rounding operations (2013-06-28 06:43:55 =
-0700)

----------------------------------------------------------------
New driver to support GMT G762/G763 pwm fan controllers
Add support for DS1631, DS1721, and DS1731 to ds1621 driver
Remove detect function from ds1621 driver as unreliable
Bug fixes in nct6775, iio_hwmon, and adm1021 drivers
Remove redundant platform_set_drvdata in various drivers
Add device tree support to ina2xx driver

----------------------------------------------------------------
Arnaud Ebalard (1):
      Add support for GMT G762/G763 PWM fan controllers

Guenter Roeck (4):
      hwmon: (adm1021) Do not create min sysfs attributes for LM84
      hwmon: (nct6775) Fix temperature alarm attributes
      hwmon: (nct6775) Drop unsupported fan alarm attributes for NCT6775
      hwmon: (ds1621) Fix temperature rounding operations

Robert Coulson (6):
      hwmon: (ds1621) Add ds1721 chip support
      hwmon: (ds1621) Add ds1721 update interval sysfs attribute
      hwmon: (ds1621) Add ds1631 chip support to ds1621 driver and document=
ation
      hwmon: (ds1621) Remove detect function
      hwmon: (ds1621) Add DS1731 chip support to ds1621 driver
      hwmon: (ds1621) Update documentation

Sachin Kamat (5):
      hwmon: (abituguru3) Remove redundant platform_set_drvdata()
      hwmon: (coretemp) Remove redundant platform_set_drvdata()
      hwmon: (i5k_amb) Remove redundant platform_set_drvdata()
      hwmon: (ntc_thermistor) Remove redundant platform_set_drvdata()
      hwmon: (w83627ehf) Remove redundant platform_set_drvdata()

Sebastian Andrzej Siewior (1):
      hwmon: (iio_hwmon) add alias table

Tang Yuantian (1):
      hwmon: (ina2xx) Add device tree support to pass the shunt resistor

 Documentation/devicetree/bindings/hwmon/g762.txt |   47 +
 Documentation/devicetree/bindings/i2c/ina2xx.txt |   22 +
 Documentation/hwmon/ds1621                       |  144 ++-
 Documentation/hwmon/g762                         |   65 ++
 Documentation/hwmon/ina2xx                       |    4 +-
 drivers/hwmon/Kconfig                            |   21 +-
 drivers/hwmon/Makefile                           |    1 +
 drivers/hwmon/abituguru3.c                       |    1 -
 drivers/hwmon/adm1021.c                          |   32 +-
 drivers/hwmon/coretemp.c                         |    2 -
 drivers/hwmon/ds1621.c                           |  226 ++++-
 drivers/hwmon/g762.c                             | 1149 ++++++++++++++++++=
++++
 drivers/hwmon/i5k_amb.c                          |    2 -
 drivers/hwmon/iio_hwmon.c                        |    1 +
 drivers/hwmon/ina2xx.c                           |    5 +
 drivers/hwmon/nct6775.c                          |   92 +-
 drivers/hwmon/ntc_thermistor.c                   |    1 -
 drivers/hwmon/w83627ehf.c                        |    2 -
 include/linux/platform_data/g762.h               |   37 +
 19 files changed, 1743 insertions(+), 111 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/g762.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/ina2xx.txt
 create mode 100644 Documentation/hwmon/g762
 create mode 100644 drivers/hwmon/g762.c
 create mode 100644 include/linux/platform_data/g762.h

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR1FPuAAoJEMsfJm/On5mBfboP/1mppR6SOWrr+Tt1CMDP0fEw
xf97lRrfWeH2XzSX6VY7W/2yxcihTCi1DEZAmkIvC9Am3A3XXQCs5rHNB+rZijbG
NAW1Dtg7cnHfKGHt8BqM7hRGR5wHjSUyx8oqI4RItlH/3PxofpK59ly6W+aPT7g0
nx+kwJUY89RxCba2aKGD+irlZVtrmu6DteNapzerM0bi1Osq4wTxLEHx6RiVgXSy
yDd0FG6QvRpNyNTTOqDUROMcv4DdbUs4kuLemNjb8VziEfXXNYZSNV8wrdvym8kB
V5dI3FhVwWnR79dMVInCMtOo/GlxZPX/345fd10CM0Bg8qB8f9ZfXFITQnISytWk
zpnGauz13zB1YRjWcsnrqMZvgnMTH72XA8uEIp8ZcYzfXfveOErmExZ+BNBOf2vF
x7tj8igQ9IcWaE5pm6W1OvXm4U5c0efqokp9bHrF0rSTekWDLi9sj3ENTuxquczZ
RgEBu8kWhh3ZVcdHyq6I/hy0JwOmhUriIEQUvuUquxQFK67onr8g4SJYop1+yGPp
4nycL/vQrRDM7tqYWXnFALBstoqMdsjcogJgDyZbhpGT2+3SIAmnZ9Z0/Xg8TSbv
xsCHQV9EHdOfdp8P7Jf/5mAoTSqgz49+q9vXUtYEH6hhz/ItOz/WXYAM2z4HmIr/
Dpg75S0UoMumRDg0pxE7
=ebVo
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--


--===============0384558347670889140==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0384558347670889140==--
