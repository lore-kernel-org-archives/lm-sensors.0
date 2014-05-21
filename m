From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 21 May 2014 12:01:15 +0000
Subject: [lm-sensors] [PATCH] hwmon: (ntc_thermistor) Fix dependencies
Message-Id: <20140521140115.532fc0b2@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

In commit 9e8269de, support was added for ntc_thermistor devices being
declared in the device tree and implemented on top of IIO. With that
change, a dependency was added to the ntc_thermistor driver:

	depends on (!OF && !IIO) || (OF && IIO)

This construct has the drawback that the driver can no longer be
selected when OF is set and IIO isn't, nor when IIO is set and OF is
not. This is a regression for the original users of the driver.

As the new code depends on IIO and is useless without OF, include it
only if both are enabled, and set the dependencies accordingly. This
is clearer, more simple and more correct.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Fixes: 9e8269de hwmon: (ntc_thermistor) Add DT with IIO support to NTC thermistor driver
Cc: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Doug Anderson <dianders@chromium.org>
---
I've build-tested all option combinations (or so I believe) but
I don't have the hardware for functional testing. If Naveen or Doug
could test to confirm I didn't break anything, that would be great.

This is a regression so the fix is candidate for stable trees. I don't
know if this worries people enough in practice to justify it though.

 drivers/hwmon/Kconfig          |    2 +-
 drivers/hwmon/ntc_thermistor.c |    4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

--- linux-3.15-rc5.orig/drivers/hwmon/Kconfig	2014-05-21 13:27:13.844415316 +0200
+++ linux-3.15-rc5/drivers/hwmon/Kconfig	2014-05-21 13:31:04.780217568 +0200
@@ -1053,7 +1053,7 @@ config SENSORS_PC87427
 
 config SENSORS_NTC_THERMISTOR
 	tristate "NTC thermistor support"
-	depends on (!OF && !IIO) || (OF && IIO)
+	depends on !OF || IIO=n || IIO
 	help
 	  This driver supports NTC thermistors sensor reading and its
 	  interpretation. The driver can also monitor the temperature and
--- linux-3.15-rc5.orig/drivers/hwmon/ntc_thermistor.c	2014-05-21 13:27:13.844415316 +0200
+++ linux-3.15-rc5/drivers/hwmon/ntc_thermistor.c	2014-05-21 13:31:04.781217589 +0200
@@ -141,7 +141,7 @@ struct ntc_data {
 	char name[PLATFORM_NAME_SIZE];
 };
 
-#ifdef CONFIG_OF
+#if defined(CONFIG_OF) && IS_ENABLED(CONFIG_IIO)
 static int ntc_adc_iio_read(struct ntc_thermistor_platform_data *pdata)
 {
 	struct iio_channel *channel = pdata->chan;
@@ -223,6 +223,8 @@ ntc_thermistor_parse_dt(struct platform_
 	return NULL;
 }
 
+#define ntc_match	NULL
+
 static void ntc_iio_channel_release(struct ntc_thermistor_platform_data *pdata)
 { }
 #endif


-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
