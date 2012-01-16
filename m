From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 16 Jan 2012 08:49:36 +0000
Subject: [lm-sensors] [PATCH 34/39] hwmon: (w83781d) Fix checkpatch issues
Message-Id: <1326703781-14272-35-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fixed:
ERROR: code indent should use tabs where possible
ERROR: do not use assignment in if condition
ERROR: "foo* bar" should be "foo *bar"
ERROR: space prohibited after that open parenthesis '('
ERROR: space required after that ',' (ctx:VxV)
ERROR: spaces required around that '=' (ctx:VxV)
WARNING: line over 80 characters
WARNING: simple_strtol is obsolete, use kstrtol instead
WARNING: simple_strtoul is obsolete, use kstrtoul instead
WARNING: space prohibited between function name and open parenthesis '('

Not fixed (false positive):
ERROR: Macros with multiple statements should be enclosed in a do - while loop
ERROR: Macros with complex values should be enclosed in parenthesis

Not all fixed (code complexity):
ERROR: do not use assignment in if condition

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/w83781d.c |  146 +++++++++++++++++++++++++++++-----------------
 1 files changed, 92 insertions(+), 54 deletions(-)

diff --git a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
index 65b685e..816cc16 100644
--- a/drivers/hwmon/w83781d.c
+++ b/drivers/hwmon/w83781d.c
@@ -1,9 +1,9 @@
 /*
     w83781d.c - Part of lm_sensors, Linux kernel modules for hardware
-                monitoring
+		monitoring
     Copyright (c) 1998 - 2001  Frodo Looijaard <frodol@dds.nl>,
-                               Philip Edelbrock <phil@netroedge.com>,
-                               and Mark Studebaker <mdsxyz123@yahoo.com>
+			       Philip Edelbrock <phil@netroedge.com>,
+			       and Mark Studebaker <mdsxyz123@yahoo.com>
     Copyright (c) 2007 - 2008  Jean Delvare <khali@linux-fr.org>
 
     This program is free software; you can redistribute it and/or modify
@@ -182,9 +182,9 @@ FAN_FROM_REG(u8 val, int div)
 #define TEMP_TO_REG(val)		SENSORS_LIMIT((val) / 1000, -127, 128)
 #define TEMP_FROM_REG(val)		((val) * 1000)
 
-#define BEEP_MASK_FROM_REG(val,type)	((type) = as99127f ? \
+#define BEEP_MASK_FROM_REG(val, type)	((type) = as99127f ? \
 					 (~(val)) & 0x7fff : (val) & 0xff7fff)
-#define BEEP_MASK_TO_REG(val,type)	((type) = as99127f ? \
+#define BEEP_MASK_TO_REG(val, type)	((type) = as99127f ? \
 					 (~(val)) & 0x7fff : (val) & 0xff7fff)
 
 #define DIV_FROM_REG(val)		(1 << (val))
@@ -254,7 +254,7 @@ static void w83781d_init_device(struct device *dev);
 
 /* following are the sysfs callback functions */
 #define show_in_reg(reg) \
-static ssize_t show_##reg (struct device *dev, struct device_attribute *da, \
+static ssize_t show_##reg(struct device *dev, struct device_attribute *da, \
 		char *buf) \
 { \
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da); \
@@ -267,20 +267,21 @@ show_in_reg(in_min);
 show_in_reg(in_max);
 
 #define store_in_reg(REG, reg) \
-static ssize_t store_in_##reg (struct device *dev, struct device_attribute \
+static ssize_t store_in_##reg(struct device *dev, struct device_attribute \
 		*da, const char *buf, size_t count) \
 { \
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da); \
 	struct w83781d_data *data = dev_get_drvdata(dev); \
 	int nr = attr->index; \
-	u32 val; \
-	 \
-	val = simple_strtoul(buf, NULL, 10); \
-	 \
+	unsigned long val; \
+	int err = kstrtoul(buf, 10, &val); \
+	if (err) \
+		return err; \
 	mutex_lock(&data->update_lock); \
 	data->in_##reg[nr] = IN_TO_REG(val); \
-	w83781d_write_value(data, W83781D_REG_IN_##REG(nr), data->in_##reg[nr]); \
-	 \
+	w83781d_write_value(data, W83781D_REG_IN_##REG(nr), \
+			    data->in_##reg[nr]); \
+	\
 	mutex_unlock(&data->update_lock); \
 	return count; \
 }
@@ -306,12 +307,12 @@ sysfs_in_offsets(7);
 sysfs_in_offsets(8);
 
 #define show_fan_reg(reg) \
-static ssize_t show_##reg (struct device *dev, struct device_attribute *da, \
+static ssize_t show_##reg(struct device *dev, struct device_attribute *da, \
 		char *buf) \
 { \
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da); \
 	struct w83781d_data *data = w83781d_update_device(dev); \
-	return sprintf(buf,"%ld\n", \
+	return sprintf(buf, "%ld\n", \
 		FAN_FROM_REG(data->reg[attr->index], \
 			DIV_FROM_REG(data->fan_div[attr->index]))); \
 }
@@ -325,9 +326,12 @@ store_fan_min(struct device *dev, struct device_attribute *da,
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct w83781d_data *data = dev_get_drvdata(dev);
 	int nr = attr->index;
-	u32 val;
+	unsigned long val;
+	int err;
 
-	val = simple_strtoul(buf, NULL, 10);
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->fan_min[nr] @@ -350,17 +354,17 @@ static SENSOR_DEVICE_ATTR(fan3_min, S_IRUGO | S_IWUSR,
 		show_fan_min, store_fan_min, 2);
 
 #define show_temp_reg(reg) \
-static ssize_t show_##reg (struct device *dev, struct device_attribute *da, \
+static ssize_t show_##reg(struct device *dev, struct device_attribute *da, \
 		char *buf) \
 { \
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da); \
 	struct w83781d_data *data = w83781d_update_device(dev); \
 	int nr = attr->index; \
 	if (nr >= 2) {	/* TEMP2 and TEMP3 */ \
-		return sprintf(buf,"%d\n", \
+		return sprintf(buf, "%d\n", \
 			LM75_TEMP_FROM_REG(data->reg##_add[nr-2])); \
 	} else {	/* TEMP1 */ \
-		return sprintf(buf,"%ld\n", (long)TEMP_FROM_REG(data->reg)); \
+		return sprintf(buf, "%ld\n", (long)TEMP_FROM_REG(data->reg)); \
 	} \
 }
 show_temp_reg(temp);
@@ -368,16 +372,16 @@ show_temp_reg(temp_max);
 show_temp_reg(temp_max_hyst);
 
 #define store_temp_reg(REG, reg) \
-static ssize_t store_temp_##reg (struct device *dev, \
+static ssize_t store_temp_##reg(struct device *dev, \
 		struct device_attribute *da, const char *buf, size_t count) \
 { \
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da); \
 	struct w83781d_data *data = dev_get_drvdata(dev); \
 	int nr = attr->index; \
 	long val; \
-	 \
-	val = simple_strtol(buf, NULL, 10); \
-	 \
+	int err = kstrtol(buf, 10, &val); \
+	if (err) \
+		return err; \
 	mutex_lock(&data->update_lock); \
 	 \
 	if (nr >= 2) {	/* TEMP2 and TEMP3 */ \
@@ -425,13 +429,17 @@ show_vrm_reg(struct device *dev, struct device_attribute *attr, char *buf)
 }
 
 static ssize_t
-store_vrm_reg(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+store_vrm_reg(struct device *dev, struct device_attribute *attr,
+	      const char *buf, size_t count)
 {
 	struct w83781d_data *data = dev_get_drvdata(dev);
-	u32 val;
+	unsigned long val;
+	int err;
 
-	val = simple_strtoul(buf, NULL, 10);
-	data->vrm = val;
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+	data->vrm = SENSORS_LIMIT(val, 0, 255);
 
 	return count;
 }
@@ -480,7 +488,8 @@ static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 4);
 static SENSOR_DEVICE_ATTR(temp2_alarm, S_IRUGO, show_alarm, NULL, 5);
 static SENSOR_DEVICE_ATTR(temp3_alarm, S_IRUGO, show_temp3_alarm, NULL, 0);
 
-static ssize_t show_beep_mask (struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_beep_mask(struct device *dev,
+			       struct device_attribute *attr, char *buf)
 {
 	struct w83781d_data *data = w83781d_update_device(dev);
 	return sprintf(buf, "%ld\n",
@@ -492,9 +501,12 @@ store_beep_mask(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
 	struct w83781d_data *data = dev_get_drvdata(dev);
-	u32 val;
+	unsigned long val;
+	int err;
 
-	val = simple_strtoul(buf, NULL, 10);
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->beep_mask &= 0x8000; /* preserve beep enable */
@@ -529,10 +541,14 @@ store_beep(struct device *dev, struct device_attribute *attr,
 {
 	struct w83781d_data *data = dev_get_drvdata(dev);
 	int bitnr = to_sensor_dev_attr(attr)->index;
-	unsigned long bit;
 	u8 reg;
+	unsigned long bit;
+	int err;
+
+	err = kstrtoul(buf, 10, &bit);
+	if (err)
+		return err;
 
-	bit = simple_strtoul(buf, NULL, 10);
 	if (bit & ~1)
 		return -EINVAL;
 
@@ -633,7 +649,12 @@ store_fan_div(struct device *dev, struct device_attribute *da,
 	unsigned long min;
 	int nr = attr->index;
 	u8 reg;
-	unsigned long val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 
@@ -643,10 +664,12 @@ store_fan_div(struct device *dev, struct device_attribute *da,
 
 	data->fan_div[nr] = DIV_TO_REG(val, data->type);
 
-	reg = (w83781d_read_value(data, nr=2 ? W83781D_REG_PIN : W83781D_REG_VID_FANDIV)
-	       & (nr=0 ? 0xcf : 0x3f))
-	    | ((data->fan_div[nr] & 0x03) << (nr=0 ? 4 : 6));
-	w83781d_write_value(data, nr=2 ? W83781D_REG_PIN : W83781D_REG_VID_FANDIV, reg);
+	reg = (w83781d_read_value(data, nr = 2 ?
+				  W83781D_REG_PIN : W83781D_REG_VID_FANDIV)
+		& (nr = 0 ? 0xcf : 0x3f))
+	      | ((data->fan_div[nr] & 0x03) << (nr = 0 ? 4 : 6));
+	w83781d_write_value(data, nr = 2 ?
+			    W83781D_REG_PIN : W83781D_REG_VID_FANDIV, reg);
 
 	/* w83781d and as99127f don't have extended divisor bits */
 	if (data->type != w83781d && data->type != as99127f) {
@@ -693,9 +716,12 @@ store_pwm(struct device *dev, struct device_attribute *da, const char *buf,
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct w83781d_data *data = dev_get_drvdata(dev);
 	int nr = attr->index;
-	u32 val;
+	unsigned long val;
+	int err;
 
-	val = simple_strtoul(buf, NULL, 10);
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->pwm[nr] = SENSORS_LIMIT(val, 0, 255);
@@ -709,9 +735,13 @@ store_pwm2_enable(struct device *dev, struct device_attribute *da,
 		const char *buf, size_t count)
 {
 	struct w83781d_data *data = dev_get_drvdata(dev);
-	u32 val, reg;
+	unsigned long val;
+	u32 reg;
+	int err;
 
-	val = simple_strtoul(buf, NULL, 10);
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 
@@ -761,9 +791,13 @@ store_sensor(struct device *dev, struct device_attribute *da,
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct w83781d_data *data = dev_get_drvdata(dev);
 	int nr = attr->index;
-	u32 val, tmp;
+	unsigned long val;
+	u32 tmp;
+	int err;
 
-	val = simple_strtoul(buf, NULL, 10);
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 
@@ -911,7 +945,7 @@ ERROR_SC_1:
 	&sensor_dev_attr_temp##X##_alarm.dev_attr.attr,		\
 	&sensor_dev_attr_temp##X##_beep.dev_attr.attr
 
-static struct attribute* w83781d_attributes[] = {
+static struct attribute *w83781d_attributes[] = {
 	IN_UNIT_ATTRS(0),
 	IN_UNIT_ATTRS(2),
 	IN_UNIT_ATTRS(3),
@@ -959,7 +993,8 @@ w83781d_create_files(struct device *dev, int kind, int is_isa)
 {
 	int err;
 
-	if ((err = sysfs_create_group(&dev->kobj, &w83781d_group)))
+	err = sysfs_create_group(&dev->kobj, &w83781d_group);
+	if (err)
 		return err;
 
 	if (kind != w83783s) {
@@ -1043,8 +1078,9 @@ w83781d_create_files(struct device *dev, int kind, int is_isa)
 				&sensor_dev_attr_temp2_type.dev_attr)))
 			return err;
 		if (kind != w83783s) {
-			if ((err = device_create_file(dev,
-					&sensor_dev_attr_temp3_type.dev_attr)))
+			err = device_create_file(dev,
+				&sensor_dev_attr_temp3_type.dev_attr);
+			if (err)
 				return err;
 		}
 	}
@@ -1083,7 +1119,7 @@ w83781d_detect(struct i2c_client *client, struct i2c_board_info *info)
 	/* Check for Winbond or Asus ID if in bank 0 */
 	if (!(val1 & 0x07) &&
 	    ((!(val1 & 0x80) && val2 != 0xa3 && val2 != 0xc3) ||
-	     ( (val1 & 0x80) && val2 != 0x5c && val2 != 0x12))) {
+	     ((val1 & 0x80) && val2 != 0x5c && val2 != 0x12))) {
 		dev_dbg(&adapter->dev,
 			"Detection of w83781d chip failed at step 4\n");
 		goto err_nodev;
@@ -1091,7 +1127,7 @@ w83781d_detect(struct i2c_client *client, struct i2c_board_info *info)
 	/* If Winbond SMBus, check address at 0x48.
 	   Asus doesn't support, except for as99127f rev.2 */
 	if ((!(val1 & 0x80) && val2 = 0xa3) ||
-	    ( (val1 & 0x80) && val2 = 0x5c)) {
+	    ((val1 & 0x80) && val2 = 0x5c)) {
 		if (i2c_smbus_read_byte_data(client, W83781D_REG_I2C_ADDR)
 		    != address) {
 			dev_dbg(&adapter->dev,
@@ -1331,9 +1367,11 @@ w83781d_init_device(struct device *dev)
 		   This saves FAN 1/2/3 input/output values set by BIOS. */
 		w83781d_write_value(data, W83781D_REG_BEEP_CONFIG, i | 0x80);
 		w83781d_write_value(data, W83781D_REG_PWMCLK12, p);
-		/* Disable master beep-enable (reset turns it on).
-		   Individual beep_mask should be reset to off but for some reason
-		   disabling this bit helps some people not get beeped */
+		/*
+		 * Disable master beep-enable (reset turns it on).
+		 * Individual beep_mask should be reset to off but for some
+		 * reason disabling this bit helps some people not get beeped
+		 */
 		w83781d_write_value(data, W83781D_REG_BEEP_INTS2, 0);
 	}
 
@@ -1444,7 +1482,7 @@ static struct w83781d_data *w83781d_update_device(struct device *dev)
 			}
 			/* Only PWM2 can be disabled */
 			data->pwm2_enable = (w83781d_read_value(data,
-					      W83781D_REG_PWMCLK12) & 0x08) >> 3;
+					     W83781D_REG_PWMCLK12) & 0x08) >> 3;
 		}
 
 		data->temp = w83781d_read_value(data, W83781D_REG_TEMP(1));
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
