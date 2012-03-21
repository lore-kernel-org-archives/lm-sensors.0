From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 21 Mar 2012 03:06:34 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (gpio-fan) Fix Kconfig dependencies
Message-Id: <1332299195-23898-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

gpio-fan depends on GPIOLIB, not on GENERIC_GPIO.

This fixes the following build error, seen if GPIOLIB is not defined:

src/drivers/hwmon/gpio-fan.c: error: implicit declaration of function 'gpio_direction_output': => 372:3
src/drivers/hwmon/gpio-fan.c: error: implicit declaration of function 'gpio_free': => 130:2
src/drivers/hwmon/gpio-fan.c: error: implicit declaration of function 'gpio_get_value': => 79:2
src/drivers/hwmon/gpio-fan.c: error: implicit declaration of function 'gpio_request': => 98:2
src/drivers/hwmon/gpio-fan.c: error: implicit declaration of function 'gpio_set_value': => 156:3
src/drivers/hwmon/gpio-fan.c: error: implicit declaration of function 'gpio_to_irq': => 114:2

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 811e6c4..93b442d 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -425,7 +425,7 @@ config SENSORS_GL520SM
 
 config SENSORS_GPIO_FAN
 	tristate "GPIO fan"
-	depends on GENERIC_GPIO
+	depends on GPIOLIB
 	help
 	  If you say yes here you get support for fans connected to GPIO lines.
 
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
