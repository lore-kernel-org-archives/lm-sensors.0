From: Amul Shah <amul.shah@unisys.com>
Date: Mon, 16 Apr 2007 15:14:01 +0000
Subject: [lm-sensors] [PATCH] k8temp - Add the diode offset to reported
Message-Id: <1176736441.14094.31.camel@ustr-shaha1-linux2.na.uis.unisys.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch adds support to include the CPU diode sensor offset when
reporting CPU temperature.

Please see http://www.lm-sensors.org/ticket/2200 for the full problem
description.

Signed-off-by: Amul Shah <amul.shah@unisys.com>
---
diff -uprN kernel.orig/drivers/hwmon/k8temp.c kernel/drivers/hwmon/k8temp.c
--- kernel.orig/drivers/hwmon/k8temp.c	2007-04-12 23:15:02.000000000 -0400
+++ kernel/drivers/hwmon/k8temp.c	2007-04-16 14:15:06.000000000 -0400
@@ -33,6 +33,8 @@
 #include <linux/mutex.h>
 
 #define TEMP_FROM_REG(val)	(((((val) >> 16) & 0xff) - 49) * 1000)
+#define OFFSET_FROM_REG(val)	((((val) >> 8) & 0x3f)? \
+				((11 - (((val) >> 8) & 0x3f)) * 1000):0)
 #define REG_TEMP	0xe4
 #define SEL_PLACE	0x40
 #define SEL_CORE	0x04
@@ -117,7 +119,8 @@ static ssize_t show_temp(struct device *
 	struct k8temp_data *data = k8temp_update_device(dev);
 
 	return sprintf(buf, "%d\n",
-		       TEMP_FROM_REG(data->temp[core][place]));
+		       TEMP_FROM_REG(data->temp[core][place]) +
+		       OFFSET_FROM_REG(data->temp[core][place]));
 }
 
 /* core, place */



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
