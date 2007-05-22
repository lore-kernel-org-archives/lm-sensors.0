From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 22 May 2007 13:03:29 +0000
Subject: [lm-sensors] [PATCH] hwmon/applesmc: Simplify dependencies
Message-Id: <20070522150329.01bf36f1@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The dependency upon HWMON is now handled at menu level.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Nicolas Boichat <nicolas@boichat.ch>
---
 drivers/hwmon/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.22-rc2.orig/drivers/hwmon/Kconfig	2007-05-22 14:33:41.000000000 +0200
+++ linux-2.6.22-rc2/drivers/hwmon/Kconfig	2007-05-22 14:34:27.000000000 +0200
@@ -630,7 +630,7 @@ config SENSORS_HDAPS
 
 config SENSORS_APPLESMC
 	tristate "Apple SMC (Motion sensor, light sensor, keyboard backlight)"
-	depends on HWMON && INPUT && X86
+	depends on INPUT && X86
 	select NEW_LEDS
 	select LEDS_CLASS
 	default n


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
