From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 Jan 2012 02:49:54 +0000
Subject: [lm-sensors] [PATCH 75/79] hwmon: (w83l786ng) Fix multi-line comments
Message-Id: <1327373398-997-76-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/w83l786ng.c |   68 +++++++++++++++++++++++---------------------
 1 files changed, 36 insertions(+), 32 deletions(-)

diff --git a/drivers/hwmon/w83l786ng.c b/drivers/hwmon/w83l786ng.c
index a6310b8..5850b77 100644
--- a/drivers/hwmon/w83l786ng.c
+++ b/drivers/hwmon/w83l786ng.c
@@ -1,28 +1,28 @@
 /*
-    w83l786ng.c - Linux kernel driver for hardware monitoring
-    Copyright (c) 2007 Kevin Lo <kevlo@kevlo.org>
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation - version 2.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
-    02110-1301 USA.
-*/
+ * w83l786ng.c - Linux kernel driver for hardware monitoring
+ * Copyright (c) 2007 Kevin Lo <kevlo@kevlo.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation - version 2.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301 USA.
+ */
 
 /*
-    Supports following chips:
-
-    Chip	#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA
-    w83l786ng	3	2	2	2	0x7b	0x5ca3	yes	no
-*/
+ * Supports following chips:
+ *
+ * Chip	#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA
+ * w83l786ng	3	2	2	2	0x7b	0x5ca3	yes	no
+ */
 
 #include <linux/module.h>
 #include <linux/init.h>
@@ -100,9 +100,11 @@ FAN_TO_REG(long rpm, int div)
 #define TEMP_FROM_REG(val)	(((val) & 0x80 ? \
 				  (val) - 0x100 : (val)) * 1000)
 
-/* The analog voltage inputs have 8mV LSB. Since the sysfs output is
-   in mV as would be measured on the chip input pin, need to just
-   multiply/divide by 8 to translate from/to register values. */
+/*
+ * The analog voltage inputs have 8mV LSB. Since the sysfs output is
+ * in mV as would be measured on the chip input pin, need to just
+ * multiply/divide by 8 to translate from/to register values.
+ */
 #define IN_TO_REG(val)		(SENSORS_LIMIT((((val) + 4) / 8), 0, 255))
 #define IN_FROM_REG(val)	((val) * 8)
 
@@ -127,7 +129,7 @@ struct w83l786ng_data {
 	char valid;			/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
 	unsigned long last_nonvolatile;	/* In jiffies, last time we update the
-					   nonvolatile registers */
+					 * nonvolatile registers */
 
 	u8 in[3];
 	u8 in_max[3];
@@ -139,10 +141,10 @@ struct w83l786ng_data {
 	u8 temp[2][3];
 	u8 pwm[2];
 	u8 pwm_mode[2];	/* 0->DC variable voltage
-			   1->PWM variable duty cycle */
+			 * 1->PWM variable duty cycle */
 
 	u8 pwm_enable[2]; /* 1->manual
-			     2->thermal cruise (also called SmartFan I) */
+			   * 2->thermal cruise (also called SmartFan I) */
 	u8 tolerance[2];
 };
 
@@ -285,10 +287,12 @@ show_fan_div(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "%u\n", DIV_FROM_REG(data->fan_div[nr]));
 }
 
-/* Note: we save and restore the fan minimum here, because its value is
-   determined in part by the fan divisor.  This follows the principle of
-   least surprise; the user doesn't expect the fan minimum to change just
-   because the divisor changed. */
+/*
+ * Note: we save and restore the fan minimum here, because its value is
+ * determined in part by the fan divisor.  This follows the principle of
+ * least surprise; the user doesn't expect the fan minimum to change just
+ * because the divisor changed.
+ */
 static ssize_t
 store_fan_div(struct device *dev, struct device_attribute *attr,
 	      const char *buf, size_t count)
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
