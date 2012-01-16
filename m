From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 16 Jan 2012 08:49:37 +0000
Subject: [lm-sensors] [PATCH 35/39] hwmon: (w83791d) Fix checkpatch issues
Message-Id: <1326703781-14272-36-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fixed:
ERROR: code indent should use tabs where possible
ERROR: do not use assignment in if condition
ERROR: space prohibited after that open parenthesis '('
ERROR: space required after that ',' (ctx:VxV)
WARNING: braces {} are not necessary for single statement blocks
WARNING: simple_strtol is obsolete, use kstrtol instead
WARNING: simple_strtoul is obsolete, use kstrtoul instead

Not fixed (false positive):
ERROR: Macros with complex values should be enclosed in parenthesis

Cc: Marc Hulsman <m.hulsman@tudelft.nl>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/w83791d.c |  115 ++++++++++++++++++++++++++++++++---------------
 1 files changed, 79 insertions(+), 36 deletions(-)

diff --git a/drivers/hwmon/w83791d.c b/drivers/hwmon/w83791d.c
index 6e5d0ae..865f5e5 100644
--- a/drivers/hwmon/w83791d.c
+++ b/drivers/hwmon/w83791d.c
@@ -1,6 +1,6 @@
 /*
     w83791d.c - Part of lm_sensors, Linux kernel modules for hardware
-                monitoring
+		monitoring
 
     Copyright (C) 2006-2007 Charles Spirakis <bezaur@gmail.com>
 
@@ -226,7 +226,7 @@ static u8 fan_to_reg(long rpm, int div)
 	return SENSORS_LIMIT((1350000 + rpm * div / 2) / (rpm * div), 1, 254);
 }
 
-#define FAN_FROM_REG(val,div)	((val) = 0   ? -1 : \
+#define FAN_FROM_REG(val, div)	((val) = 0 ? -1 : \
 				((val) = 255 ? 0 : \
 					1350000 / ((val) * (div))))
 
@@ -366,7 +366,7 @@ static ssize_t show_##reg(struct device *dev, struct device_attribute *attr, \
 						to_sensor_dev_attr(attr); \
 	struct w83791d_data *data = w83791d_update_device(dev); \
 	int nr = sensor_attr->index; \
-	return sprintf(buf,"%d\n", IN_FROM_REG(data->reg[nr])); \
+	return sprintf(buf, "%d\n", IN_FROM_REG(data->reg[nr])); \
 }
 
 show_in_reg(in);
@@ -382,9 +382,11 @@ static ssize_t store_in_##reg(struct device *dev, \
 						to_sensor_dev_attr(attr); \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct w83791d_data *data = i2c_get_clientdata(client); \
-	unsigned long val = simple_strtoul(buf, NULL, 10); \
 	int nr = sensor_attr->index; \
-	 \
+	unsigned long val; \
+	int err = kstrtoul(buf, 10, &val); \
+	if (err) \
+		return err; \
 	mutex_lock(&data->update_lock); \
 	data->in_##reg[nr] = IN_TO_REG(val); \
 	w83791d_write(client, W83791D_REG_IN_##REG[nr], data->in_##reg[nr]); \
@@ -455,7 +457,14 @@ static ssize_t store_beep(struct device *dev, struct device_attribute *attr,
 	struct w83791d_data *data = i2c_get_clientdata(client);
 	int bitnr = sensor_attr->index;
 	int bytenr = bitnr / 8;
-	long val = simple_strtol(buf, NULL, 10) ? 1 : 0;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+
+	val = val ? 1 : 0;
 
 	mutex_lock(&data->update_lock);
 
@@ -521,7 +530,7 @@ static ssize_t show_##reg(struct device *dev, struct device_attribute *attr, \
 						to_sensor_dev_attr(attr); \
 	struct w83791d_data *data = w83791d_update_device(dev); \
 	int nr = sensor_attr->index; \
-	return sprintf(buf,"%d\n", \
+	return sprintf(buf, "%d\n", \
 		FAN_FROM_REG(data->reg[nr], DIV_FROM_REG(data->fan_div[nr]))); \
 }
 
@@ -534,8 +543,13 @@ static ssize_t store_fan_min(struct device *dev, struct device_attribute *attr,
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83791d_data *data = i2c_get_clientdata(client);
-	unsigned long val = simple_strtoul(buf, NULL, 10);
 	int nr = sensor_attr->index;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->fan_min[nr] = fan_to_reg(val, DIV_FROM_REG(data->fan_div[nr]));
@@ -572,12 +586,18 @@ static ssize_t store_fan_div(struct device *dev, struct device_attribute *attr,
 	int indx = 0;
 	u8 keep_mask = 0;
 	u8 new_shift = 0;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	/* Save fan_min */
 	min = FAN_FROM_REG(data->fan_min[nr], DIV_FROM_REG(data->fan_div[nr]));
 
 	mutex_lock(&data->update_lock);
-	data->fan_div[nr] = div_to_reg(nr, simple_strtoul(buf, NULL, 10));
+	data->fan_div[nr] = div_to_reg(nr, val);
 
 	switch (nr) {
 	case 0:
@@ -918,8 +938,13 @@ static ssize_t store_temp1(struct device *dev, struct device_attribute *devattr,
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83791d_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
 	int nr = attr->index;
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->temp1[nr] = TEMP1_TO_REG(val);
@@ -946,10 +971,15 @@ static ssize_t store_temp23(struct device *dev,
 	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83791d_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
 	int nr = attr->nr;
 	int index = attr->index;
 
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
+
 	mutex_lock(&data->update_lock);
 	data->temp_add[nr][index] = TEMP23_TO_REG(val);
 	w83791d_write(client, W83791D_REG_TEMP_ADD[nr][index * 2],
@@ -1035,8 +1065,13 @@ static ssize_t store_beep_mask(struct device *dev,
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83791d_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
 	int i;
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 
@@ -1063,7 +1098,12 @@ static ssize_t store_beep_enable(struct device *dev,
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83791d_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 
@@ -1113,36 +1153,42 @@ static ssize_t store_vrm_reg(struct device *dev,
 				const char *buf, size_t count)
 {
 	struct w83791d_data *data = dev_get_drvdata(dev);
+	unsigned long val;
+	int err;
 
 	/* No lock needed as vrm is internal to the driver
 	   (not read from a chip register) and so is not
 	   updated in w83791d_update_device() */
-	data->vrm = simple_strtoul(buf, NULL, 10);
 
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+
+	data->vrm = SENSORS_LIMIT(val, 0, 255);
 	return count;
 }
 
 static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm_reg, store_vrm_reg);
 
 #define IN_UNIT_ATTRS(X) \
-	&sda_in_input[X].dev_attr.attr, \
-	&sda_in_min[X].dev_attr.attr,   \
-	&sda_in_max[X].dev_attr.attr,   \
-	&sda_in_beep[X].dev_attr.attr,  \
+	&sda_in_input[X].dev_attr.attr,	\
+	&sda_in_min[X].dev_attr.attr,	\
+	&sda_in_max[X].dev_attr.attr,	\
+	&sda_in_beep[X].dev_attr.attr,	\
 	&sda_in_alarm[X].dev_attr.attr
 
 #define FAN_UNIT_ATTRS(X) \
-	&sda_fan_input[X].dev_attr.attr,        \
-	&sda_fan_min[X].dev_attr.attr,          \
-	&sda_fan_div[X].dev_attr.attr,          \
-	&sda_fan_beep[X].dev_attr.attr,         \
+	&sda_fan_input[X].dev_attr.attr,	\
+	&sda_fan_min[X].dev_attr.attr,		\
+	&sda_fan_div[X].dev_attr.attr,		\
+	&sda_fan_beep[X].dev_attr.attr,		\
 	&sda_fan_alarm[X].dev_attr.attr
 
 #define TEMP_UNIT_ATTRS(X) \
-	&sda_temp_input[X].dev_attr.attr,       \
-	&sda_temp_max[X].dev_attr.attr,         \
-	&sda_temp_max_hyst[X].dev_attr.attr,    \
-	&sda_temp_beep[X].dev_attr.attr,        \
+	&sda_temp_input[X].dev_attr.attr,	\
+	&sda_temp_max[X].dev_attr.attr,		\
+	&sda_temp_max_hyst[X].dev_attr.attr,	\
+	&sda_temp_beep[X].dev_attr.attr,	\
 	&sda_temp_alarm[X].dev_attr.attr
 
 static struct attribute *w83791d_attributes[] = {
@@ -1228,9 +1274,8 @@ static int w83791d_detect_subclients(struct i2c_client *client)
 	}
 
 	val = w83791d_read(client, W83791D_REG_I2C_SUBADDR);
-	if (!(val & 0x08)) {
+	if (!(val & 0x08))
 		data->lm75[0] = i2c_new_dummy(adapter, 0x48 + (val & 0x7));
-	}
 	if (!(val & 0x80)) {
 		if ((data->lm75[0] != NULL) &&
 				((val & 0x7) = ((val >> 4) & 0x7))) {
@@ -1265,9 +1310,8 @@ static int w83791d_detect(struct i2c_client *client,
 	int val1, val2;
 	unsigned short address = client->addr;
 
-	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
-	}
 
 	if (w83791d_read(client, W83791D_REG_CONFIG) & 0x80)
 		return -ENODEV;
@@ -1277,7 +1321,7 @@ static int w83791d_detect(struct i2c_client *client,
 	/* Check for Winbond ID if in bank 0 */
 	if (!(val1 & 0x07)) {
 		if ((!(val1 & 0x80) && val2 != 0xa3) ||
-		    ( (val1 & 0x80) && val2 != 0x5c)) {
+		    ((val1 & 0x80) && val2 != 0x5c)) {
 			return -ENODEV;
 		}
 	}
@@ -1334,12 +1378,12 @@ static int w83791d_probe(struct i2c_client *client,
 
 	/* If the fan_div is changed, make sure there is a rational
 	   fan_min in place */
-	for (i = 0; i < NUMBER_OF_FANIN; i++) {
+	for (i = 0; i < NUMBER_OF_FANIN; i++)
 		data->fan_min[i] = w83791d_read(client, W83791D_REG_FAN_MIN[i]);
-	}
 
 	/* Register sysfs hooks */
-	if ((err = sysfs_create_group(&client->dev.kobj, &w83791d_group)))
+	err = sysfs_create_group(&client->dev.kobj, &w83791d_group);
+	if (err)
 		goto error3;
 
 	/* Check if pins of fan/pwm 4-5 are in use as GPIO */
@@ -1604,9 +1648,8 @@ static void w83791d_print_debug(struct w83791d_data *data, struct device *dev)
 	/* temperature math is signed, but only print out the
 	   bits that matter */
 	dev_dbg(dev, "%d set of Temperatures: ==>\n", NUMBER_OF_TEMPIN);
-	for (i = 0; i < 3; i++) {
+	for (i = 0; i < 3; i++)
 		dev_dbg(dev, "temp1[%d] is: 0x%02x\n", i, (u8) data->temp1[i]);
-	}
 	for (i = 0; i < 2; i++) {
 		for (j = 0; j < 3; j++) {
 			dev_dbg(dev, "temp_add[%d][%d] is: 0x%04x\n", i, j,
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
