From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 16 Jan 2012 08:49:19 +0000
Subject: [lm-sensors] [PATCH 17/39] hwmon: (lm78) Fix checkpatch issues
Message-Id: <1326703781-14272-18-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fixed:
ERROR: code indent should use tabs where possible
ERROR: do not use assignment in if condition
ERROR: space prohibited before that close parenthesis ')'
ERROR: space required after that ',' (ctx:VxV)
ERROR: spaces required around that '<' (ctx:VxV)
ERROR: spaces required around that '=' (ctx:VxV)
ERROR: trailing statements should be on next line
ERROR: trailing whitespace
WARNING: simple_strtol is obsolete, use kstrtol instead
WARNING: simple_strtoul is obsolete, use kstrtoul instead

Not fixed (false positive):
ERROR: Macros with multiple statements should be enclosed in a do - while loop

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm78.c |  103 ++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 74 insertions(+), 29 deletions(-)

diff --git a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
index 6df0b46..84f99e2 100644
--- a/drivers/hwmon/lm78.c
+++ b/drivers/hwmon/lm78.c
@@ -1,7 +1,7 @@
 /*
     lm78.c - Part of lm_sensors, Linux kernel modules for hardware
-             monitoring
-    Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl> 
+	monitoring
+    Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
     Copyright (c) 2007, 2011  Jean Delvare <khali@linux-fr.org>
 
     This program is free software; you can redistribute it and/or modify
@@ -74,8 +74,10 @@ enum chips { lm78, lm79 };
 #define LM78_REG_I2C_ADDR 0x48
 
 
-/* Conversions. Rounding and limit checking is only done on the TO_REG 
-   variants. */
+/*
+ * Conversions. Rounding and limit checking is only done on the TO_REG
+ * variants.
+ */
 
 /* IN: mV, (0V to 4.08V)
    REG: 16mV/bit */
@@ -95,7 +97,7 @@ static inline u8 FAN_TO_REG(long rpm, int div)
 
 static inline int FAN_FROM_REG(u8 val, int div)
 {
-	return val=0 ? -1 : val=255 ? 0 : 1350000/(val*div);
+	return val = 0 ? -1 : val = 255 ? 0 : 1350000 / (val * div);
 }
 
 /* TEMP: mC (-128C to +127C)
@@ -103,7 +105,7 @@ static inline int FAN_FROM_REG(u8 val, int div)
 static inline s8 TEMP_TO_REG(int val)
 {
 	int nval = SENSORS_LIMIT(val, -128000, 127000) ;
-	return nval<0 ? (nval-500)/1000 : (nval+500)/1000;
+	return nval < 0 ? (nval - 500) / 1000 : (nval + 500) / 1000;
 }
 
 static inline int TEMP_FROM_REG(s8 val)
@@ -177,8 +179,13 @@ static ssize_t set_in_min(struct device *dev, struct device_attribute *da,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct lm78_data *data = dev_get_drvdata(dev);
-	unsigned long val = simple_strtoul(buf, NULL, 10);
 	int nr = attr->index;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->in_min[nr] = IN_TO_REG(val);
@@ -192,8 +199,13 @@ static ssize_t set_in_max(struct device *dev, struct device_attribute *da,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct lm78_data *data = dev_get_drvdata(dev);
-	unsigned long val = simple_strtoul(buf, NULL, 10);
 	int nr = attr->index;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->in_max[nr] = IN_TO_REG(val);
@@ -201,7 +213,7 @@ static ssize_t set_in_max(struct device *dev, struct device_attribute *da,
 	mutex_unlock(&data->update_lock);
 	return count;
 }
-	
+
 #define show_in_offset(offset)					\
 static SENSOR_DEVICE_ATTR(in##offset##_input, S_IRUGO,		\
 		show_in, NULL, offset);				\
@@ -237,7 +249,12 @@ static ssize_t set_temp_over(struct device *dev, struct device_attribute *da,
 			     const char *buf, size_t count)
 {
 	struct lm78_data *data = dev_get_drvdata(dev);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->temp_over = TEMP_TO_REG(val);
@@ -257,7 +274,12 @@ static ssize_t set_temp_hyst(struct device *dev, struct device_attribute *da,
 			     const char *buf, size_t count)
 {
 	struct lm78_data *data = dev_get_drvdata(dev);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->temp_hyst = TEMP_TO_REG(val);
@@ -280,7 +302,7 @@ static ssize_t show_fan(struct device *dev, struct device_attribute *da,
 	struct lm78_data *data = lm78_update_device(dev);
 	int nr = attr->index;
 	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[nr],
-		DIV_FROM_REG(data->fan_div[nr])) );
+		DIV_FROM_REG(data->fan_div[nr])));
 }
 
 static ssize_t show_fan_min(struct device *dev, struct device_attribute *da,
@@ -289,8 +311,8 @@ static ssize_t show_fan_min(struct device *dev, struct device_attribute *da,
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct lm78_data *data = lm78_update_device(dev);
 	int nr = attr->index;
-	return sprintf(buf,"%d\n", FAN_FROM_REG(data->fan_min[nr],
-		DIV_FROM_REG(data->fan_div[nr])) );
+	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan_min[nr],
+		DIV_FROM_REG(data->fan_div[nr])));
 }
 
 static ssize_t set_fan_min(struct device *dev, struct device_attribute *da,
@@ -299,7 +321,12 @@ static ssize_t set_fan_min(struct device *dev, struct device_attribute *da,
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct lm78_data *data = dev_get_drvdata(dev);
 	int nr = attr->index;
-	unsigned long val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
@@ -326,19 +353,32 @@ static ssize_t set_fan_div(struct device *dev, struct device_attribute *da,
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct lm78_data *data = dev_get_drvdata(dev);
 	int nr = attr->index;
-	unsigned long val = simple_strtoul(buf, NULL, 10);
 	unsigned long min;
 	u8 reg;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	min = FAN_FROM_REG(data->fan_min[nr],
 			   DIV_FROM_REG(data->fan_div[nr]));
 
 	switch (val) {
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
 		dev_err(dev, "fan_div value %ld not "
 			"supported. Choose one of 1, 2, 4 or 8!\n", val);
@@ -669,11 +709,13 @@ static struct i2c_driver lm78_driver = {
 	.address_list	= normal_i2c,
 };
 
-/* The SMBus locks itself, but ISA access must be locked explicitly! 
-   We don't want to lock the whole ISA bus, so we lock each client
-   separately.
-   We ignore the LM78 BUSY flag at this moment - it could lead to deadlocks,
-   would slow down the LM78 access and should not be necessary.  */
+/*
+ * The SMBus locks itself, but ISA access must be locked explicitly!
+ * We don't want to lock the whole ISA bus, so we lock each client
+ * separately.
+ * We ignore the LM78 BUSY flag at this moment - it could lead to deadlocks,
+ * would slow down the LM78 access and should not be necessary.
+ */
 static int lm78_read_value(struct lm78_data *data, u8 reg)
 {
 	struct i2c_client *client = data->client;
@@ -691,11 +733,11 @@ static int lm78_read_value(struct lm78_data *data, u8 reg)
 		return i2c_smbus_read_byte_data(client, reg);
 }
 
-/* The SMBus locks itself, but ISA access muse be locked explicitly! 
+/* The SMBus locks itself, but ISA access muse be locked explicitly!
    We don't want to lock the whole ISA bus, so we lock each client
    separately.
    We ignore the LM78 BUSY flag at this moment - it could lead to deadlocks,
-   would slow down the LM78 access and should not be necessary. 
+   would slow down the LM78 access and should not be necessary.
    There are some ugly typecasts here, but the good new is - they should
    nowhere else be necessary! */
 static int lm78_write_value(struct lm78_data *data, u8 reg, u8 value)
@@ -823,8 +865,11 @@ static int __devinit lm78_isa_probe(struct platform_device *pdev)
 	lm78_init_device(data);
 
 	/* Register sysfs hooks */
-	if ((err = sysfs_create_group(&pdev->dev.kobj, &lm78_group))
-	 || (err = device_create_file(&pdev->dev, &dev_attr_name)))
+	err = sysfs_create_group(&pdev->dev.kobj, &lm78_group);
+	if (err)
+		goto exit_remove_files;
+	err = device_create_file(&pdev->dev, &dev_attr_name);
+	if (err)
 		goto exit_remove_files;
 
 	data->hwmon_dev = hwmon_device_register(&pdev->dev);
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
