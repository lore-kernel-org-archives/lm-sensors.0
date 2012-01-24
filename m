From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 Jan 2012 02:48:53 +0000
Subject: [lm-sensors] [PATCH 14/79] hwmon: (smsc47m1) Fix checkpatch issues
Message-Id: <1327373398-997-15-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

Fixed:
ERROR: code indent should use tabs where possible
ERROR: do not use assignment in if condition
ERROR: space required after that ',' (ctx:VxV)
ERROR: spaces required around that '<=' (ctx:VxV)
ERROR: spaces required around that '=' (ctx:VxV)
ERROR: spaces required around that '>=' (ctx:VxV)
ERROR: trailing statements should be on next line
ERROR: trailing whitespace
WARNING: simple_strtol is obsolete, use kstrtol instead
WARNING: static const char * array should probably be static const char * const

Modify multi-line comments to follow Documentation/CodingStyle.

Also: s/#define^I/#define /

Not fixed (false positive):
ERROR: Macros with multiple statements should be enclosed in a do - while loop

Cc: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/smsc47m1.c |  166 +++++++++++++++++++++++++++++-----------------
 1 files changed, 104 insertions(+), 62 deletions(-)

diff --git a/drivers/hwmon/smsc47m1.c b/drivers/hwmon/smsc47m1.c
index aba11e5..c590c14 100644
--- a/drivers/hwmon/smsc47m1.c
+++ b/drivers/hwmon/smsc47m1.c
@@ -1,30 +1,30 @@
 /*
-    smsc47m1.c - Part of lm_sensors, Linux kernel modules
-                 for hardware monitoring
-
-    Supports the SMSC LPC47B27x, LPC47M10x, LPC47M112, LPC47M13x,
-    LPC47M14x, LPC47M15x, LPC47M192, LPC47M292 and LPC47M997
-    Super-I/O chips.
-
-    Copyright (C) 2002 Mark D. Studebaker <mdsxyz123@yahoo.com>
-    Copyright (C) 2004-2007 Jean Delvare <khali@linux-fr.org>
-    Ported to Linux 2.6 by Gabriele Gorla <gorlik@yahoo.com>
-                        and Jean Delvare
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
 
@@ -53,8 +53,8 @@ enum chips { smsc47m1, smsc47m2 };
 
 /* Super-I/0 registers and commands */
 
-#define	REG	0x2e	/* The register to read/write */
-#define	VAL	0x2f	/* The value to read/write */
+#define REG	0x2e	/* The register to read/write */
+#define VAL	0x2f	/* The value to read/write */
 
 static inline void
 superio_outb(int reg, int val)
@@ -111,10 +111,11 @@ static const u8 SMSC47M1_REG_PWM[3]		= { 0x56, 0x57, 0x69 };
 #define SMSC47M2_REG_PPIN3		0x2c
 #define SMSC47M2_REG_FANDIV3		0x6a
 
-#define MIN_FROM_REG(reg,div)		((reg)>2 ? 0 : \
-					 983040/((192-(reg))*(div)))
-#define FAN_FROM_REG(reg,div,preload)	((reg)<=(preload) || (reg)=255 ? 0 : \
-					 983040/(((reg)-(preload))*(div)))
+#define MIN_FROM_REG(reg, div)		((reg) >= 192 ? 0 : \
+					 983040 / ((192 - (reg)) * (div)))
+#define FAN_FROM_REG(reg, div, preload)	((reg) <= (preload) || (reg) = 255 ? \
+					 0 : \
+					 983040 / (((reg) - (preload)) * (div)))
 #define DIV_FROM_REG(reg)		(1 << (reg))
 #define PWM_FROM_REG(reg)		(((reg) & 0x7E) << 1)
 #define PWM_EN_FROM_REG(reg)		((~(reg)) & 0x01)
@@ -171,10 +172,12 @@ static ssize_t get_fan(struct device *dev, struct device_attribute
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
@@ -238,7 +241,13 @@ static ssize_t set_fan_min(struct device *dev, struct device_attribute
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct smsc47m1_data *data = dev_get_drvdata(dev);
 	int nr = attr->index;
-	long rpmdiv, val = simple_strtol(buf, NULL, 10);
+	long rpmdiv;
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	rpmdiv = val * DIV_FROM_REG(data->fan_div[nr]);
@@ -256,28 +265,44 @@ static ssize_t set_fan_min(struct device *dev, struct device_attribute
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
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct smsc47m1_data *data = dev_get_drvdata(dev);
 	int nr = attr->index;
-	long new_div = simple_strtol(buf, NULL, 10), tmp;
+	long new_div;
+	int err;
+	long tmp;
 	u8 old_div = DIV_FROM_REG(data->fan_div[nr]);
 
+	err = kstrtol(buf, 10, &new_div);
+	if (err)
+		return err;
+
 	if (new_div = old_div) /* No change */
 		return count;
 
 	mutex_lock(&data->update_lock);
 	switch (new_div) {
-	case 1: data->fan_div[nr] = 0; break;
-	case 2: data->fan_div[nr] = 1; break;
-	case 4: data->fan_div[nr] = 2; break;
-	case 8: data->fan_div[nr] = 3; break;
+	case 1:
+		data->fan_div[nr] = 0;
+		break;
+	case 2:
+		data->fan_div[nr] = 1;
+		break;
+	case 4:
+		data->fan_div[nr] = 2;
+		break;
+	case 8:
+		data->fan_div[nr] = 3;
+		break;
 	default:
 		mutex_unlock(&data->update_lock);
 		return -EINVAL;
@@ -315,7 +340,12 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct smsc47m1_data *data = dev_get_drvdata(dev);
 	int nr = attr->index;
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	if (val < 0 || val > 255)
 		return -EINVAL;
@@ -336,9 +366,14 @@ static ssize_t set_pwm_en(struct device *dev, struct device_attribute
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct smsc47m1_data *data = dev_get_drvdata(dev);
 	int nr = attr->index;
-	long val = simple_strtol(buf, NULL, 10);
-	
-	if (val != 0 && val != 1)
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+
+	if (val > 1)
 		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
@@ -519,8 +554,10 @@ static int __init smsc47m1_find(unsigned short *addr,
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
@@ -646,7 +683,7 @@ static int __init smsc47m1_probe(struct platform_device *pdev)
 	int err;
 	int fan1, fan2, fan3, pwm1, pwm2, pwm3;
 
-	static const char *names[] = {
+	static const char * const names[] = {
 		"smsc47m1",
 		"smsc47m2",
 	};
@@ -657,7 +694,8 @@ static int __init smsc47m1_probe(struct platform_device *pdev)
 	if (err < 0)
 		return err;
 
-	if (!(data = kzalloc(sizeof(struct smsc47m1_data), GFP_KERNEL))) {
+	data = kzalloc(sizeof(struct smsc47m1_data), GFP_KERNEL);
+	if (!data) {
 		err = -ENOMEM;
 		goto error_release;
 	}
@@ -668,8 +706,10 @@ static int __init smsc47m1_probe(struct platform_device *pdev)
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
@@ -697,12 +737,14 @@ static int __init smsc47m1_probe(struct platform_device *pdev)
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
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
