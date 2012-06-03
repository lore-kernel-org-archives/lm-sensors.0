From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 03 Jun 2012 05:32:59 +0000
Subject: [lm-sensors] [PATCH] MAINTAINERS: Update my e-mail address
Message-Id: <1338701579-13496-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Maintainer activities moved to home server. Update e-mail address to reflect
reality.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 MAINTAINERS |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 55f0fda..5b75b97 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2270,7 +2270,7 @@ F:	include/linux/device-mapper.h
 F:	include/linux/dm-*.h
 
 DIOLAN U2C-12 I2C DRIVER
-M:	Guenter Roeck <guenter.roeck@ericsson.com>
+M:	Guenter Roeck <linux@roeck-us.net>
 L:	linux-i2c@vger.kernel.org
 S:	Maintained
 F:	drivers/i2c/busses/i2c-diolan-u2c.c
@@ -3138,7 +3138,7 @@ F:	drivers/tty/hvc/
 
 HARDWARE MONITORING
 M:	Jean Delvare <khali@linux-fr.org>
-M:	Guenter Roeck <guenter.roeck@ericsson.com>
+M:	Guenter Roeck <linux@roeck-us.net>
 L:	lm-sensors@lm-sensors.org
 W:	http://www.lm-sensors.org/
 T:	quilt kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-hwmon/
@@ -4411,6 +4411,13 @@ S:	Orphan
 F:	drivers/video/matrox/matroxfb_*
 F:	include/linux/matroxfb.h
 
+MAX16065 HARDWARE MONITOR DRIVER
+M:	Guenter Roeck <linux@roeck-us.net>
+L:	lm-sensors@lm-sensors.org
+S:	Maintained
+F:	Documentation/hwmon/max16065
+F:	drivers/hwmon/max16065.c
+
 MAX6650 HARDWARE MONITOR AND FAN CONTROLLER DRIVER
 M:	"Hans J. Koch" <hjk@hansjkoch.de>
 L:	lm-sensors@lm-sensors.org
@@ -5149,7 +5156,7 @@ F:	drivers/leds/leds-pca9532.c
 F:	include/linux/leds-pca9532.h
 
 PCA9541 I2C BUS MASTER SELECTOR DRIVER
-M:	Guenter Roeck <guenter.roeck@ericsson.com>
+M:	Guenter Roeck <linux@roeck-us.net>
 L:	linux-i2c@vger.kernel.org
 S:	Maintained
 F:	drivers/i2c/muxes/i2c-mux-pca9541.c
@@ -5299,7 +5306,7 @@ F:	drivers/video/fb-puv3.c
 F:	drivers/rtc/rtc-puv3.c
 
 PMBUS HARDWARE MONITORING DRIVERS
-M:	Guenter Roeck <guenter.roeck@ericsson.com>
+M:	Guenter Roeck <linux@roeck-us.net>
 L:	lm-sensors@lm-sensors.org
 W:	http://www.lm-sensors.org/
 W:	http://www.roeck-us.net/linux/drivers/
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
