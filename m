From: Randy Dunlap <rdunlap@infradead.org>
Date: Tue, 10 Mar 2015 23:42:41 +0000
Subject: [lm-sensors] [PATCH -next] hwmon: fix gpio-fan.c build
Message-Id: <54FF8171.9080101@infradead.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org
Cc: Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Simon Guinot <sguinot@lacie.com>

From: Randy Dunlap <rdunlap@infradead.org>

Fix build error when CONFIG_THERMAL=m and SENSORS_GPIO_FAN=y
by preventing that combination.

Fixes these build errors:

drivers/built-in.o: In function `gpio_fan_remove':
gpio-fan.c:(.text+0x21e97e): undefined reference to `thermal_cooling_device_unregister'
drivers/built-in.o: In function `gpio_fan_probe':
gpio-fan.c:(.text+0x21efbc): undefined reference to `thermal_cooling_device_register'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc:	Jean Delvare <jdelvare@suse.de>
Cc:	Guenter Roeck <linux@roeck-us.net>
Cc:	lm-sensors@lm-sensors.org
Cc:	Simon Guinot <sguinot@lacie.com>
---
 drivers/hwmon/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20150310.orig/drivers/hwmon/Kconfig
+++ linux-next-20150310/drivers/hwmon/Kconfig
@@ -510,6 +510,7 @@ config SENSORS_G762
 config SENSORS_GPIO_FAN
 	tristate "GPIO fan"
 	depends on GPIOLIB
+	depends on THERMAL || THERMAL=n
 	help
 	  If you say yes here you get support for fans connected to GPIO lines.
 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
