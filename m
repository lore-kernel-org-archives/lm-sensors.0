From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 16 Jan 2012 08:49:29 +0000
Subject: [lm-sensors] [PATCH 27/39] hwmon: (smsc47m1) Fix checkpatch issues
Message-Id: <1326703781-14272-28-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

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

Not fixed (false positive):
ERROR: Macros with multiple statements should be enclosed in a do - while loop

Not all fixed (code complexity):
ERROR: do not use assignment in if condition

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/smsc47m1.c |   74 +++++++++++++++++++++++++++++++++------------
 1 files changed, 54 insertions(+), 20 deletions(-)

diff --git a/drivers/hwmon/smsc47m1.c b/drivers/hwmon/smsc47m1.c
index f44a89a..43a0032 100644
--- a/drivers/hwmon/smsc47m1.c
+++ b/drivers/hwmon/smsc47m1.c
@@ -1,6 +1,6 @@
 /*
     smsc47m1.c - Part of lm_sensors, Linux kernel modules
-                 for hardware monitoring
+		for hardware monitoring
 
     Supports the SMSC LPC47B27x, LPC47M10x, LPC47M112, LPC47M13x,
     LPC47M14x, LPC47M15x, LPC47M192, LPC47M292 and LPC47M997
@@ -9,7 +9,7 @@
     Copyright (C) 2002 Mark D. Studebaker <mdsxyz123@yahoo.com>
     Copyright (C) 2004-2007 Jean Delvare <khali@linux-fr.org>
     Ported to Linux 2.6 by Gabriele Gorla <gorlik@yahoo.com>
-                        and Jean Delvare
+			and Jean Delvare
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
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
@@ -238,7 +239,13 @@ static ssize_t set_fan_min(struct device *dev, struct device_attribute
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
@@ -266,18 +273,32 @@ static ssize_t set_fan_div(struct device *dev, struct device_attribute
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
@@ -315,7 +336,12 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute
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
@@ -336,9 +362,14 @@ static ssize_t set_pwm_en(struct device *dev, struct device_attribute
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
@@ -592,7 +623,7 @@ static int __init smsc47m1_probe(struct platform_device *pdev)
 	int err;
 	int fan1, fan2, fan3, pwm1, pwm2, pwm3;
 
-	static const char *names[] = {
+	static const char * const names[] = {
 		"smsc47m1",
 		"smsc47m2",
 	};
@@ -603,7 +634,8 @@ static int __init smsc47m1_probe(struct platform_device *pdev)
 	if (err < 0)
 		return err;
 
-	if (!(data = kzalloc(sizeof(struct smsc47m1_data), GFP_KERNEL))) {
+	data = kzalloc(sizeof(struct smsc47m1_data), GFP_KERNEL);
+	if (!data) {
 		err = -ENOMEM;
 		goto error_release;
 	}
@@ -718,9 +750,11 @@ static int __init smsc47m1_probe(struct platform_device *pdev)
 	} else if (data->type = smsc47m2)
 		dev_dbg(dev, "PWM 3 not enabled by hardware, skipping\n");
 
-	if ((err = device_create_file(dev, &dev_attr_alarms)))
+	err = device_create_file(dev, &dev_attr_alarms);
+	if (err)
 		goto error_remove_files;
-	if ((err = device_create_file(dev, &dev_attr_name)))
+	err = device_create_file(dev, &dev_attr_name);
+	if (err)
 		goto error_remove_files;
 
 	data->hwmon_dev = hwmon_device_register(dev);
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
