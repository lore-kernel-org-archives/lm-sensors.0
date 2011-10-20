From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Thu, 20 Oct 2011 09:33:07 +0000
Subject: [lm-sensors] [PATCH 6/6] stargate2: example of map configuration
Message-Id: <1319103187-27791-7-git-send-email-jic23@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1319103187-27791-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1319103187-27791-1-git-send-email-jic23@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: linus.ml.walleij@gmail.com, zdevai@gmail.com, linux@arm.linux.org.uk, arnd@arndb.de, broonie@opensource.wolfsonmicro.com, gregkh@suse.de, lm-sensors@lm-sensors.org, guenter.roeck@ericsson.com, khali@linux-fr.org, thomas.petazzoni@free-electrons.com, maxime.ripard@free-electrons.com, Jonathan Cameron <jic23@cam.ac.uk>

Do not commit.
---
 arch/arm/mach-pxa/stargate2.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/stargate2.c b/arch/arm/mach-pxa/stargate2.c
index 3f8d0af..48dcbb7 100644
--- a/arch/arm/mach-pxa/stargate2.c
+++ b/arch/arm/mach-pxa/stargate2.c
@@ -54,6 +54,8 @@
 #include <linux/mfd/da903x.h>
 #include <linux/sht15.h>
 
+#include <linux/iio/inkern.h>
+
 #include "devices.h"
 #include "generic.h"
 
@@ -406,6 +408,24 @@ static struct i2c_pxa_platform_data i2c_pdata = {
 	.fast_mode = 1,
 };
 
+static struct platform_device iio_hwmon_test = {
+	.name = "iio_hwmon",
+};
+
+static struct iio_map adc_map[] = {
+	{
+		.adc_dev_name = "0-0035",
+		.adc_channel_label = "AIN1",
+		.consumer_dev = &iio_hwmon_test.dev,
+		.consumer_channel = "testchan1",
+	}, {
+		.adc_dev_name = "0-0035",
+		.adc_channel_label = "AIN2",
+		.consumer_dev = &iio_hwmon_test.dev,
+		.consumer_channel = "testchan2",
+	},
+};
+
 static void __init imote2_stargate2_init(void)
 {
 
@@ -423,6 +443,8 @@ static void __init imote2_stargate2_init(void)
 
 	pxa27x_set_i2c_power_info(&i2c_pwr_pdata);
 	pxa_set_i2c_info(&i2c_pdata);
+
+	iio_map_array_register(adc_map, ARRAY_SIZE(adc_map));
 }
 
 #ifdef CONFIG_MACH_INTELMOTE2
@@ -971,6 +993,7 @@ static struct platform_device *stargate2_devices[] = {
 	&stargate2_sram,
 	&smc91x_device,
 	&sht15,
+	&iio_hwmon_test,
 };
 
 static void __init stargate2_init(void)
-- 
1.7.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
