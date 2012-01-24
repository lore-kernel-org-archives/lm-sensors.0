From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 Jan 2012 02:48:56 +0000
Subject: [lm-sensors] [PATCH 17/79] hwmon: (w83791d) Fix checkpatch issues
Message-Id: <1327373398-997-18-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

Fixed:
ERROR: code indent should use tabs where possible
ERROR: do not use assignment in if condition
ERROR: space prohibited after that open parenthesis '('
ERROR: space required after that ',' (ctx:VxV)
WARNING: braces {} are not necessary for single statement blocks
WARNING: simple_strtol is obsolete, use kstrtol instead
WARNING: simple_strtoul is obsolete, use kstrtoul instead

Modify multi-line comments to follow Documentation/CodingStyle.

Not fixed (false positive):
ERROR: Macros with complex values should be enclosed in parenthesis

Cc: Charles Spirakis <bezaur@gmail.com>
Cc: Marc Hulsman <m.hulsman@tudelft.nl>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/w83791d.c |  318 +++++++++++++++++++++++++++++------------------
 1 files changed, 196 insertions(+), 122 deletions(-)

diff --git a/drivers/hwmon/w83791d.c b/drivers/hwmon/w83791d.c
index 1ff97b0..2f446f9 100644
--- a/drivers/hwmon/w83791d.c
+++ b/drivers/hwmon/w83791d.c
@@ -1,36 +1,36 @@
 /*
-    w83791d.c - Part of lm_sensors, Linux kernel modules for hardware
-                monitoring
-
-    Copyright (C) 2006-2007 Charles Spirakis <bezaur@gmail.com>
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
+ * w83791d.c - Part of lm_sensors, Linux kernel modules for hardware
+ *	       monitoring
+ *
+ * Copyright (C) 2006-2007 Charles Spirakis <bezaur@gmail.com>
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
 
 /*
-    Supports following chips:
-
-    Chip	#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA
-    w83791d	10	5	5	3	0x71	0x5ca3	yes	no
-
-    The w83791d chip appears to be part way between the 83781d and the
-    83792d. Thus, this file is derived from both the w83792d.c and
-    w83781d.c files.
-
-    The w83791g chip is the same as the w83791d but lead-free.
-*/
+ * Supports following chips:
+ *
+ * Chip	#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA
+ * w83791d	10	5	5	3	0x71	0x5ca3	yes	no
+ *
+ * The w83791d chip appears to be part way between the 83781d and the
+ * 83792d. Thus, this file is derived from both the w83792d.c and
+ * w83781d.c files.
+ *
+ * The w83791g chip is the same as the w83791d but lead-free.
+ */
 
 #include <linux/module.h>
 #include <linux/init.h>
@@ -198,10 +198,12 @@ static const u8 W83791D_REG_BEEP_CTRL[3] = {
 #define W83791D_REG_VBAT		0x5D
 #define W83791D_REG_I2C_ADDR		0x48
 
-/* The SMBus locks itself. The Winbond W83791D has a bank select register
-   (index 0x4e), but the driver only accesses registers in bank 0. Since
-   we don't switch banks, we don't need any special code to handle
-   locking access between bank switches */
+/*
+ * The SMBus locks itself. The Winbond W83791D has a bank select register
+ * (index 0x4e), but the driver only accesses registers in bank 0. Since
+ * we don't switch banks, we don't need any special code to handle
+ * locking access between bank switches
+ */
 static inline int w83791d_read(struct i2c_client *client, u8 reg)
 {
 	return i2c_smbus_read_byte_data(client, reg);
@@ -212,9 +214,11 @@ static inline int w83791d_write(struct i2c_client *client, u8 reg, u8 value)
 	return i2c_smbus_write_byte_data(client, reg, value);
 }
 
-/* The analog voltage inputs have 16mV LSB. Since the sysfs output is
-   in mV as would be measured on the chip input pin, need to just
-   multiply/divide by 16 to translate from/to register values. */
+/*
+ * The analog voltage inputs have 16mV LSB. Since the sysfs output is
+ * in mV as would be measured on the chip input pin, need to just
+ * multiply/divide by 16 to translate from/to register values.
+ */
 #define IN_TO_REG(val)		(SENSORS_LIMIT((((val) + 8) / 16), 0, 255))
 #define IN_FROM_REG(val)	((val) * 16)
 
@@ -226,7 +230,7 @@ static u8 fan_to_reg(long rpm, int div)
 	return SENSORS_LIMIT((1350000 + rpm * div / 2) / (rpm * div), 1, 254);
 }
 
-#define FAN_FROM_REG(val,div)	((val) = 0   ? -1 : \
+#define FAN_FROM_REG(val, div)	((val) = 0 ? -1 : \
 				((val) = 255 ? 0 : \
 					1350000 / ((val) * (div))))
 
@@ -237,10 +241,12 @@ static u8 fan_to_reg(long rpm, int div)
 				 (val) < 0 ? ((val) - 500) / 1000 : \
 				 ((val) + 500) / 1000)
 
-/* for temp2 and temp3 which are 9-bit resolution, LSB = 0.5 degree Celsius
-   Assumes the top 8 bits are the integral amount and the bottom 8 bits
-   are the fractional amount. Since we only have 0.5 degree resolution,
-   the bottom 7 bits will always be zero */
+/*
+ * for temp2 and temp3 which are 9-bit resolution, LSB = 0.5 degree Celsius
+ * Assumes the top 8 bits are the integral amount and the bottom 8 bits
+ * are the fractional amount. Since we only have 0.5 degree resolution,
+ * the bottom 7 bits will always be zero
+ */
 #define TEMP23_FROM_REG(val)	((val) / 128 * 500)
 #define TEMP23_TO_REG(val)	((val) <= -128000 ? 0x8000 : \
 				 (val) >= 127500 ? 0x7F80 : \
@@ -300,17 +306,19 @@ struct w83791d_data {
 
 	s8 temp1[3];		/* current, over, thyst */
 	s16 temp_add[2][3];	/* fixed point value. Top 8 bits are the
-				   integral part, bottom 8 bits are the
-				   fractional part. We only use the top
-				   9 bits as the resolution is only
-				   to the 0.5 degree C...
-				   two sensors with three values
-				   (cur, over, hyst)  */
+				 * integral part, bottom 8 bits are the
+				 * fractional part. We only use the top
+				 * 9 bits as the resolution is only
+				 * to the 0.5 degree C...
+				 * two sensors with three values
+				 * (cur, over, hyst)
+				 */
 
 	/* PWMs */
 	u8 pwm[5];		/* pwm duty cycle */
 	u8 pwm_enable[3];	/* pwm enable status for fan 1-3
-					(fan 4-5 only support manual mode) */
+				 * (fan 4-5 only support manual mode)
+				 */
 
 	u8 temp_target[3];	/* pwm 1-3 target temperature */
 	u8 temp_tolerance[3];	/* pwm 1-3 temperature tolerance */
@@ -366,7 +374,7 @@ static ssize_t show_##reg(struct device *dev, struct device_attribute *attr, \
 						to_sensor_dev_attr(attr); \
 	struct w83791d_data *data = w83791d_update_device(dev); \
 	int nr = sensor_attr->index; \
-	return sprintf(buf,"%d\n", IN_FROM_REG(data->reg[nr])); \
+	return sprintf(buf, "%d\n", IN_FROM_REG(data->reg[nr])); \
 }
 
 show_in_reg(in);
@@ -382,9 +390,11 @@ static ssize_t store_in_##reg(struct device *dev, \
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
@@ -455,7 +465,14 @@ static ssize_t store_beep(struct device *dev, struct device_attribute *attr,
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
 
@@ -485,8 +502,10 @@ static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "%d\n", (data->alarms >> bitnr) & 1);
 }
 
-/* Note: The bitmask for the beep enable/disable is different than
-   the bitmask for the alarm. */
+/*
+ * Note: The bitmask for the beep enable/disable is different than
+ * the bitmask for the alarm.
+ */
 static struct sensor_device_attribute sda_in_beep[] = {
 	SENSOR_ATTR(in0_beep, S_IWUSR | S_IRUGO, show_beep, store_beep, 0),
 	SENSOR_ATTR(in1_beep, S_IWUSR | S_IRUGO, show_beep, store_beep, 13),
@@ -521,7 +540,7 @@ static ssize_t show_##reg(struct device *dev, struct device_attribute *attr, \
 						to_sensor_dev_attr(attr); \
 	struct w83791d_data *data = w83791d_update_device(dev); \
 	int nr = sensor_attr->index; \
-	return sprintf(buf,"%d\n", \
+	return sprintf(buf, "%d\n", \
 		FAN_FROM_REG(data->reg[nr], DIV_FROM_REG(data->fan_div[nr]))); \
 }
 
@@ -534,8 +553,13 @@ static ssize_t store_fan_min(struct device *dev, struct device_attribute *attr,
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
@@ -554,10 +578,12 @@ static ssize_t show_fan_div(struct device *dev, struct device_attribute *attr,
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
 static ssize_t store_fan_div(struct device *dev, struct device_attribute *attr,
 				const char *buf, size_t count)
 {
@@ -572,12 +598,18 @@ static ssize_t store_fan_div(struct device *dev, struct device_attribute *attr,
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
@@ -918,8 +950,13 @@ static ssize_t store_temp1(struct device *dev, struct device_attribute *devattr,
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
@@ -946,10 +983,15 @@ static ssize_t store_temp23(struct device *dev,
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
@@ -985,8 +1027,10 @@ static struct sensor_device_attribute_2 sda_temp_max_hyst[] = {
 			show_temp23, store_temp23, 1, 2),
 };
 
-/* Note: The bitmask for the beep enable/disable is different than
-   the bitmask for the alarm. */
+/*
+ * Note: The bitmask for the beep enable/disable is different than
+ * the bitmask for the alarm.
+ */
 static struct sensor_device_attribute sda_temp_beep[] = {
 	SENSOR_ATTR(temp1_beep, S_IWUSR | S_IRUGO, show_beep, store_beep, 4),
 	SENSOR_ATTR(temp2_beep, S_IWUSR | S_IRUGO, show_beep, store_beep, 5),
@@ -1035,13 +1079,20 @@ static ssize_t store_beep_mask(struct device *dev,
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
 
-	/* The beep_enable state overrides any enabling request from
-	   the masks */
+	/*
+	 * The beep_enable state overrides any enabling request from
+	 * the masks
+	 */
 	data->beep_mask = BEEP_MASK_TO_REG(val) & ~GLOBAL_BEEP_ENABLE_MASK;
 	data->beep_mask |= (data->beep_enable << GLOBAL_BEEP_ENABLE_SHIFT);
 
@@ -1063,7 +1114,12 @@ static ssize_t store_beep_enable(struct device *dev,
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
 
@@ -1073,8 +1129,10 @@ static ssize_t store_beep_enable(struct device *dev,
 	data->beep_mask &= ~GLOBAL_BEEP_ENABLE_MASK;
 	data->beep_mask |= (data->beep_enable << GLOBAL_BEEP_ENABLE_SHIFT);
 
-	/* The global control is in the second beep control register
-	   so only need to update that register */
+	/*
+	 * The global control is in the second beep control register
+	 * so only need to update that register
+	 */
 	val = (data->beep_mask >> 8) & 0xff;
 
 	w83791d_write(client, W83791D_REG_BEEP_CTRL[1], val);
@@ -1113,36 +1171,44 @@ static ssize_t store_vrm_reg(struct device *dev,
 				const char *buf, size_t count)
 {
 	struct w83791d_data *data = dev_get_drvdata(dev);
+	unsigned long val;
+	int err;
 
-	/* No lock needed as vrm is internal to the driver
-	   (not read from a chip register) and so is not
-	   updated in w83791d_update_device() */
-	data->vrm = simple_strtoul(buf, NULL, 10);
+	/*
+	 * No lock needed as vrm is internal to the driver
+	 * (not read from a chip register) and so is not
+	 * updated in w83791d_update_device()
+	 */
 
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+
+	data->vrm = val;
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
@@ -1186,9 +1252,11 @@ static const struct attribute_group w83791d_group = {
 	.attrs = w83791d_attributes,
 };
 
-/* Separate group of attributes for fan/pwm 4-5. Their pins can also be
-   in use for GPIO in which case their sysfs-interface should not be made
-   available */
+/*
+ * Separate group of attributes for fan/pwm 4-5. Their pins can also be
+ * in use for GPIO in which case their sysfs-interface should not be made
+ * available
+ */
 static struct attribute *w83791d_attributes_fanpwm45[] = {
 	FAN_UNIT_ATTRS(3),
 	FAN_UNIT_ATTRS(4),
@@ -1228,9 +1296,8 @@ static int w83791d_detect_subclients(struct i2c_client *client)
 	}
 
 	val = w83791d_read(client, W83791D_REG_I2C_SUBADDR);
-	if (!(val & 0x08)) {
+	if (!(val & 0x08))
 		data->lm75[0] = i2c_new_dummy(adapter, 0x48 + (val & 0x7));
-	}
 	if (!(val & 0x80)) {
 		if ((data->lm75[0] != NULL) &&
 				((val & 0x7) = ((val >> 4) & 0x7))) {
@@ -1265,9 +1332,8 @@ static int w83791d_detect(struct i2c_client *client,
 	int val1, val2;
 	unsigned short address = client->addr;
 
-	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
-	}
 
 	if (w83791d_read(client, W83791D_REG_CONFIG) & 0x80)
 		return -ENODEV;
@@ -1277,12 +1343,14 @@ static int w83791d_detect(struct i2c_client *client,
 	/* Check for Winbond ID if in bank 0 */
 	if (!(val1 & 0x07)) {
 		if ((!(val1 & 0x80) && val2 != 0xa3) ||
-		    ( (val1 & 0x80) && val2 != 0x5c)) {
+		    ((val1 & 0x80) && val2 != 0x5c)) {
 			return -ENODEV;
 		}
 	}
-	/* If Winbond chip, address of chip and W83791D_REG_I2C_ADDR
-	   should match */
+	/*
+	 * If Winbond chip, address of chip and W83791D_REG_I2C_ADDR
+	 * should match
+	 */
 	if (w83791d_read(client, W83791D_REG_I2C_ADDR) != address)
 		return -ENODEV;
 
@@ -1332,14 +1400,16 @@ static int w83791d_probe(struct i2c_client *client,
 	/* Initialize the chip */
 	w83791d_init_client(client);
 
-	/* If the fan_div is changed, make sure there is a rational
-	   fan_min in place */
-	for (i = 0; i < NUMBER_OF_FANIN; i++) {
+	/*
+	 * If the fan_div is changed, make sure there is a rational
+	 * fan_min in place
+	 */
+	for (i = 0; i < NUMBER_OF_FANIN; i++)
 		data->fan_min[i] = w83791d_read(client, W83791D_REG_FAN_MIN[i]);
-	}
 
 	/* Register sysfs hooks */
-	if ((err = sysfs_create_group(&client->dev.kobj, &w83791d_group)))
+	err = sysfs_create_group(&client->dev.kobj, &w83791d_group);
+	if (err)
 		goto error3;
 
 	/* Check if pins of fan/pwm 4-5 are in use as GPIO */
@@ -1398,19 +1468,20 @@ static void w83791d_init_client(struct i2c_client *client)
 	u8 tmp;
 	u8 old_beep;
 
-	/* The difference between reset and init is that reset
-	   does a hard reset of the chip via index 0x40, bit 7,
-	   but init simply forces certain registers to have "sane"
-	   values. The hope is that the BIOS has done the right
-	   thing (which is why the default is reset=0, init=0),
-	   but if not, reset is the hard hammer and init
-	   is the soft mallet both of which are trying to whack
-	   things into place...
-	   NOTE: The data sheet makes a distinction between
-	   "power on defaults" and "reset by MR". As far as I can tell,
-	   the hard reset puts everything into a power-on state so I'm
-	   not sure what "reset by MR" means or how it can happen.
-	   */
+	/*
+	 * The difference between reset and init is that reset
+	 * does a hard reset of the chip via index 0x40, bit 7,
+	 * but init simply forces certain registers to have "sane"
+	 * values. The hope is that the BIOS has done the right
+	 * thing (which is why the default is reset=0, init=0),
+	 * but if not, reset is the hard hammer and init
+	 * is the soft mallet both of which are trying to whack
+	 * things into place...
+	 * NOTE: The data sheet makes a distinction between
+	 * "power on defaults" and "reset by MR". As far as I can tell,
+	 * the hard reset puts everything into a power-on state so I'm
+	 * not sure what "reset by MR" means or how it can happen.
+	 */
 	if (reset || init) {
 		/* keep some BIOS settings when we... */
 		old_beep = w83791d_read(client, W83791D_REG_BEEP_CONFIG);
@@ -1494,8 +1565,10 @@ static struct w83791d_data *w83791d_update_device(struct device *dev)
 		data->fan_div[3] = reg_array_tmp[2] & 0x07;
 		data->fan_div[4] = (reg_array_tmp[2] >> 4) & 0x07;
 
-		/* The fan divisor for fans 0-2 get bit 2 from
-		   bits 5-7 respectively of vbat register */
+		/*
+		 * The fan divisor for fans 0-2 get bit 2 from
+		 * bits 5-7 respectively of vbat register
+		 */
 		vbat_reg = w83791d_read(client, W83791D_REG_VBAT);
 		for (i = 0; i < 3; i++)
 			data->fan_div[i] |= (vbat_reg >> (3 + i)) & 0x04;
@@ -1601,12 +1674,13 @@ static void w83791d_print_debug(struct w83791d_data *data, struct device *dev)
 		dev_dbg(dev, "fan_div[%d] is: 0x%02x\n", i, data->fan_div[i]);
 	}
 
-	/* temperature math is signed, but only print out the
-	   bits that matter */
+	/*
+	 * temperature math is signed, but only print out the
+	 * bits that matter
+	 */
 	dev_dbg(dev, "%d set of Temperatures: ==>\n", NUMBER_OF_TEMPIN);
-	for (i = 0; i < 3; i++) {
+	for (i = 0; i < 3; i++)
 		dev_dbg(dev, "temp1[%d] is: 0x%02x\n", i, (u8) data->temp1[i]);
-	}
 	for (i = 0; i < 2; i++) {
 		for (j = 0; j < 3; j++) {
 			dev_dbg(dev, "temp_add[%d][%d] is: 0x%04x\n", i, j,
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
