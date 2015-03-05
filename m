From: Randy Dunlap <rdunlap@infradead.org>
Date: Thu, 05 Mar 2015 23:27:34 +0000
Subject: [lm-sensors] [PATCH -next] sensors: fix build of pwm-fan.c when THERMAL=m
Message-Id: <54F8E666.9090403@infradead.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org, LKML <linux-kernel@vger.kernel.org>
Cc: Kamil Debski <k.debski@samsung.com>, Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.de>

From: Randy Dunlap <rdunlap@infradead.org>

Fix build errors when CONFIG_THERMAL=m and SENSORS_PWM_FAN=y
by restricting SENSORS_PWM_FAN to 'm' when THERMAL=m.

drivers/built-in.o: In function `pwm_fan_remove':
pwm-fan.c:(.text+0x22ba58): undefined reference to `thermal_cooling_device_unregister'
drivers/built-in.o: In function `pwm_fan_probe':
pwm-fan.c:(.text+0x22bebb): undefined reference to `thermal_of_cooling_device_register'
pwm-fan.c:(.text+0x22bf11): undefined reference to `thermal_cdev_update'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Kamil Debski <k.debski@samsung.com>
---
 drivers/hwmon/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20150305.orig/drivers/hwmon/Kconfig
+++ linux-next-20150305/drivers/hwmon/Kconfig
@@ -1174,6 +1174,7 @@ source drivers/hwmon/pmbus/Kconfig
 config SENSORS_PWM_FAN
 	tristate "PWM fan"
 	depends on (PWM && OF) || COMPILE_TEST
+	depends on THERMAL || THERMAL=n
 	help
 	  If you say yes here you get support for fans connected to PWM lines.
 	  The driver uses the generic PWM interface, thus it will work on a

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
