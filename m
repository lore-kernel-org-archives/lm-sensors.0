From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 05 May 2015 16:32:21 +0000
Subject: [lm-sensors] [PATCH 05/27] hwmon: Allow compile test of GPIO consumers if !GPIOLIB
Message-Id: <1430843563-18615-5-git-send-email-geert@linux-m68k.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1430836404-15513-1-git-send-email-geert@linux-m68k.org>
	<1430843563-18615-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1430843563-18615-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

The GPIO subsystem provides dummy GPIO consumer functions if GPIOLIB is
not enabled. Hence drivers that depend on GPIOLIB, but use GPIO consumer
functionality only, can still be compiled if GPIOLIB is not enabled.

Relax the dependency on GPIOLIB if COMPILE_TEST is enabled, where
appropriate.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jean Delvare <jdelvare@suse.de>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: lm-sensors@lm-sensors.org
---
 drivers/hwmon/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 25d9e72627e9df97..9d29f42db1856747 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -509,7 +509,7 @@ config SENSORS_G762
 
 config SENSORS_GPIO_FAN
 	tristate "GPIO fan"
-	depends on GPIOLIB
+	depends on GPIOLIB || COMPILE_TEST
 	depends on THERMAL || THERMAL=n
 	help
 	  If you say yes here you get support for fans connected to GPIO lines.
@@ -1186,7 +1186,7 @@ config SENSORS_PWM_FAN
 
 config SENSORS_SHT15
 	tristate "Sensiron humidity and temperature sensors. SHT15 and compat."
-	depends on GPIOLIB
+	depends on GPIOLIB || COMPILE_TEST
 	help
 	  If you say yes here you get support for the Sensiron SHT10, SHT11,
 	  SHT15, SHT71, SHT75 humidity and temperature sensors.
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
