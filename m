From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:55:57 +0000
Subject: [lm-sensors] [PATCH 63/82] hwmon: (smsc47m1) Fix multi-line comments
Message-Id: <1327017376-20466-64-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/smsc47m1.c |  106 +++++++++++++++++++++++++--------------------
 1 files changed, 59 insertions(+), 47 deletions(-)

diff --git a/drivers/hwmon/smsc47m1.c b/drivers/hwmon/smsc47m1.c
index 43a0032..b2da582 100644
--- a/drivers/hwmon/smsc47m1.c
+++ b/drivers/hwmon/smsc47m1.c
@@ -1,30 +1,30 @@
 /*
-    smsc47m1.c - Part of lm_sensors, Linux kernel modules
-		for hardware monitoring
-
-    Supports the SMSC LPC47B27x, LPC47M10x, LPC47M112, LPC47M13x,
-    LPC47M14x, LPC47M15x, LPC47M192, LPC47M292 and LPC47M997
-    Super-I/O chips.
-
-    Copyright (C) 2002 Mark D. Studebaker <mdsxyz123@yahoo.com>
-    Copyright (C) 2004-2007 Jean Delvare <khali@linux-fr.org>
-    Ported to Linux 2.6 by Gabriele Gorla <gorlik@yahoo.com>
-			and Jean Delvare
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-*/
+ * smsc47m1.c - Part of lm_sensors, Linux kernel modules
+ *		for hardware monitoring
+ *
+ * Supports the SMSC LPC47B27x, LPC47M10x, LPC47M112, LPC47M13x,
+ * LPC47M14x, LPC47M15x, LPC47M192, LPC47M292 and LPC47M997
+ * Super-I/O chips.
+ *
+ * Copyright (C) 2002 Mark D. Studebaker <mdsxyz123@yahoo.com>
+ * Copyright (C) 2004-2007 Jean Delvare <khali@linux-fr.org>
+ * Ported to Linux 2.6 by Gabriele Gorla <gorlik@yahoo.com>
+ *			and Jean Delvare
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
@@ -172,10 +172,12 @@ static ssize_t get_fan(struct device *dev, struct device_attribute
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct smsc47m1_data *data = smsc47m1_update_device(dev, 0);
 	int nr = attr->index;
-	/* This chip (stupidly) stops monitoring fan speed if PWM is
-	   enabled and duty cycle is 0%. This is fine if the monitoring
-	   and control concern the same fan, but troublesome if they are
-	   not (which could as well happen). */
+	/*
+	 * This chip (stupidly) stops monitoring fan speed if PWM is
+	 * enabled and duty cycle is 0%. This is fine if the monitoring
+	 * and control concern the same fan, but troublesome if they are
+	 * not (which could as well happen).
+	 */
 	int rpm = (data->pwm[nr] & 0x7F) = 0x00 ? 0 :
 		  FAN_FROM_REG(data->fan[nr],
 			       DIV_FROM_REG(data->fan_div[nr]),
@@ -263,10 +265,12 @@ static ssize_t set_fan_min(struct device *dev, struct device_attribute
 	return count;
 }
 
-/* Note: we save and restore the fan minimum here, because its value is
-   determined in part by the fan clock divider.  This follows the principle
-   of least surprise; the user doesn't expect the fan minimum to change just
-   because the divider changed. */
+/*
+ * Note: we save and restore the fan minimum here, because its value is
+ * determined in part by the fan clock divider.  This follows the principle
+ * of least surprise; the user doesn't expect the fan minimum to change just
+ * because the divider changed.
+ */
 static ssize_t set_fan_div(struct device *dev, struct device_attribute
 			   *devattr, const char *buf, size_t count)
 {
@@ -411,9 +415,11 @@ static ssize_t show_name(struct device *dev, struct device_attribute
 }
 static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
 
-/* Almost all sysfs files may or may not be created depending on the chip
-   setup so we create them individually. It is still convenient to define a
-   group to remove them all at once. */
+/*
+ * Almost all sysfs files may or may not be created depending on the chip
+ * setup so we create them individually. It is still convenient to define a
+ * group to remove them all at once.
+ */
 static struct attribute *smsc47m1_attributes[] = {
 	&sensor_dev_attr_fan1_input.dev_attr.attr,
 	&sensor_dev_attr_fan1_min.dev_attr.attr,
@@ -507,8 +513,10 @@ static int __init smsc47m1_find(unsigned short *addr,
 		return -ENODEV;
 	}
 
-	/* Enable only if address is set (needed at least on the
-	 * Compaq Presario S4000NX) */
+	/*
+	 * Enable only if address is set (needed at least on the
+	 * Compaq Presario S4000NX)
+	 */
 	sio_data->activate = superio_inb(SUPERIO_REG_ACT);
 	if ((sio_data->activate & 0x01) = 0) {
 		pr_info("Enabling device\n");
@@ -646,8 +654,10 @@ static int __init smsc47m1_probe(struct platform_device *pdev)
 	mutex_init(&data->update_lock);
 	platform_set_drvdata(pdev, data);
 
-	/* If no function is properly configured, there's no point in
-	   actually registering the chip. */
+	/*
+	 * If no function is properly configured, there's no point in
+	 * actually registering the chip.
+	 */
 	pwm1 = (smsc47m1_read_value(data, SMSC47M1_REG_PPIN(0)) & 0x05)
 	       = 0x04;
 	pwm2 = (smsc47m1_read_value(data, SMSC47M1_REG_PPIN(1)) & 0x05)
@@ -675,12 +685,14 @@ static int __init smsc47m1_probe(struct platform_device *pdev)
 		goto error_free;
 	}
 
-	/* Some values (fan min, clock dividers, pwm registers) may be
-	   needed before any update is triggered, so we better read them
-	   at least once here. We don't usually do it that way, but in
-	   this particular case, manually reading 5 registers out of 8
-	   doesn't make much sense and we're better using the existing
-	   function. */
+	/*
+	 * Some values (fan min, clock dividers, pwm registers) may be
+	 * needed before any update is triggered, so we better read them
+	 * at least once here. We don't usually do it that way, but in
+	 * this particular case, manually reading 5 registers out of 8
+	 * doesn't make much sense and we're better using the existing
+	 * function.
+	 */
 	smsc47m1_update_device(dev, 1);
 
 	/* Register sysfs hooks */
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
