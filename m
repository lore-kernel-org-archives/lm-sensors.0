From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 08 Mar 2013 16:22:02 +0000
Subject: [lm-sensors] [PATCH] MAINTAINERS: Add maintainer for MAX6697, INA209, and INA2XX drivers
Message-Id: <1362759722-8252-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org
Cc: linux-kernel@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>

I actively maintain those drivers and have hardware available
to test changes, so add me as explicit maintainer.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 MAINTAINERS |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9561658..1a5aca7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4005,6 +4005,22 @@ M:	Stanislaw Gruszka <stf_xl@wp.pl>
 S:	Maintained
 F:	drivers/usb/atm/ueagle-atm.c
 
+INA209 HARDWARE MONITOR DRIVER
+M:	Guenter Roeck <linux@roeck-us.net>
+L:	lm-sensors@lm-sensors.org
+S:	Maintained
+F:	Documentation/hwmon/ina209
+F:	Documentation/devicetree/bindings/i2c/ina209.txt
+F:	drivers/hwmon/ina209.c
+
+INA2XX HARDWARE MONITOR DRIVER
+M:	Guenter Roeck <linux@roeck-us.net>
+L:	lm-sensors@lm-sensors.org
+S:	Maintained
+F:	Documentation/hwmon/ina2xx
+F:	drivers/hwmon/ina2xx.c
+F:	include/linux/platform_data/ina2xx.h
+
 INDUSTRY PACK SUBSYSTEM (IPACK)
 M:	Samuel Iglesias Gonsalvez <siglesias@igalia.com>
 M:	Jens Taprogge <jens.taprogge@taprogge.org>
@@ -5098,6 +5114,15 @@ S:	Maintained
 F:	Documentation/hwmon/max6650
 F:	drivers/hwmon/max6650.c
 
+MAX6697 HARDWARE MONITOR DRIVER
+M:	Guenter Roeck <linux@roeck-us.net>
+L:	lm-sensors@lm-sensors.org
+S:	Maintained
+F:	Documentation/hwmon/max6697
+F:	Documentation/devicetree/bindings/i2c/max6697.txt
+F:	drivers/hwmon/max6697.c
+F:	include/linux/platform_data/max6697.h
+
 MAXIRADIO FM RADIO RECEIVER DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
 L:	linux-media@vger.kernel.org
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
