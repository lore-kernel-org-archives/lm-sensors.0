From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 21 Mar 2012 03:06:35 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (sht15) Fix Kconfig dependencies
Message-Id: <1332299195-23898-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

sht15 depends on GPIOLIB, not on GENERIC_GPIO.

This fixes the following build error, seen if GPIOLIB is not defined:

src/drivers/hwmon/sht15.c: error: implicit declaration of function 'gpio_direction_input': => 293:2
src/drivers/hwmon/sht15.c: error: implicit declaration of function 'gpio_direction_output': => 216:2
src/drivers/hwmon/sht15.c: error: implicit declaration of function 'gpio_free': => 1000:2
src/drivers/hwmon/sht15.c: error: implicit declaration of function 'gpio_get_value': => 296:2
src/drivers/hwmon/sht15.c: error: implicit declaration of function 'gpio_request': => 946:2
src/drivers/hwmon/sht15.c: error: implicit declaration of function 'gpio_set_value': => 218:2
src/drivers/hwmon/sht15.c: error: implicit declaration of function 'gpio_to_irq': => 514:2

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 93b442d..be6eb21 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -872,7 +872,7 @@ source drivers/hwmon/pmbus/Kconfig
 
 config SENSORS_SHT15
 	tristate "Sensiron humidity and temperature sensors. SHT15 and compat."
-	depends on GENERIC_GPIO
+	depends on GPIOLIB
 	help
 	  If you say yes here you get support for the Sensiron SHT10, SHT11,
 	  SHT15, SHT71, SHT75 humidity and temperature sensors.
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
