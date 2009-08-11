From: "Cory T. Tusar" <ctusar@videon-central.com>
Date: Tue, 11 Aug 2009 13:29:48 +0000
Subject: Re: [lm-sensors] Ambient Light sensor for Intersil-ISL29020 device
Message-Id: <4A81724C.7060702@videon-central.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090811185416.GB32002@intel.com>
In-Reply-To: <20090811185416.GB32002@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Kalhan Trisal wrote:
>>From 2d11a9f666b7477cc8faca0f055f4477f328516f Mon Sep 17 00:00:00 2001
> From: Kalhan Trisal <kalhan.trisal@intel.com>
> Date: Tue, 11 Aug 2009 14:28:32 -0400
> Subject: [PATCH] Intersil ISL29020 ALS driver
> ALS driver will read the latest Lux measurement based on the light brightness and will report the LUX output through sysfs interface.
> 
> Signed-off-by: Kalhan Trisal <kalhan.trisal@intel.com>
> 
> ---
>  drivers/hwmon/Kconfig    |   11 ++
>  drivers/hwmon/Makefile   |    1 +
>  drivers/hwmon/isl29020.c |  237 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 249 insertions(+), 0 deletions(-)
>  create mode 100755 drivers/hwmon/isl29020.c
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 2d50166..c89f1f6 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1017,6 +1017,17 @@ config SENSORS_APPLESMC
>           Say Y here if you have an applicable laptop and want to experience
>           the awesome power of applesmc.
> 
> +config SENSORS_ISL29020
> +       tristate "Intersil ISL29020 ALS"
> +       depends on I2C_MRST

Is there a reason you're hardcoding a Moorestown dependency here?

> +       default n
> +       help
> +         If you say yes here you get support for the ALS Devices
> +         Ambient Light Sensor monitoring chip.
> +         Range values can be configured using sysfs.
> +         Lux Data are  accessible via sysfs.
> +
> +
>  config HWMON_DEBUG_CHIP
>         bool "Hardware Monitoring Chip debugging messages"
>         default n
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index b793dce..3b1e424 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -89,6 +89,7 @@ obj-$(CONFIG_SENSORS_VT8231)  += vt8231.o
>  obj-$(CONFIG_SENSORS_W83627EHF)        += w83627ehf.o
>  obj-$(CONFIG_SENSORS_W83L785TS)        += w83l785ts.o
>  obj-$(CONFIG_SENSORS_W83L786NG)        += w83l786ng.o
> +obj-$(CONFIG_SENSORS_LIS331DL) += lis331dl.o

This appears to be incorrect.

> 
>  ifeq ($(CONFIG_HWMON_DEBUG_CHIP),y)
>  EXTRA_CFLAGS += -DDEBUG
> diff --git a/drivers/hwmon/isl29020.c b/drivers/hwmon/isl29020.c
> new file mode 100755
> index 0000000..162dcb1
> --- /dev/null
> +++ b/drivers/hwmon/isl29020.c

Would this driver be better placed in drivers/misc, alongside the
similar ils29003 driver?

- -Cory


- -- 
Cory T. Tusar
Senior Software Engineer
Videon Central, Inc.
2171 Sandy Drive
State College, PA 16803
(814) 235-1111 x316
(814) 235-1118 fax


"There are two ways of constructing a software design.  One way is to
 make it so simple that there are obviously no deficiencies, and the
 other way is to make it so complicated that there are no obvious
 deficiencies."  --Sir Charles Anthony Richard Hoare

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEARECAAYFAkqBckwACgkQHT1tsfGwHJ/68QCfY9RgbwotuijyABAFacG9ogQi
NvwAoJl2u9cunjoBEJBST4GqKpHiID9a
=ldQN
-----END PGP SIGNATURE-----

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
