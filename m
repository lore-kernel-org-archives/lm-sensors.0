From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 Jan 2012 02:49:36 +0000
Subject: [lm-sensors] [PATCH 57/79] hwmon: (w83792d) Fix checkpatch issues
Message-Id: <1327373398-997-58-git-send-email-guenter.roeck@ericsson.com>
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
ERROR: space required after that ',' (ctx:WxV)
ERROR: spaces required around that ':' (ctx:VxE)
ERROR: spaces required around that '<=' (ctx:VxV)
ERROR: spaces required around that '<' (ctx:VxV)
ERROR: spaces required around that '=' (ctx:VxV)
ERROR: spaces required around that '=' (ctx:VxV)
ERROR: spaces required around that '||' (ctx:VxV)
ERROR: spaces required around that ':' (ctx:VxV)
ERROR: spaces required around that '?' (ctx:VxV)
WARNING: braces {} are not necessary for any arm of this statement
WARNING: braces {} are not necessary for single statement blocks
WARNING: line over 80 characters
WARNING: simple_strtol is obsolete, use kstrtol instead
WARNING: simple_strtoul is obsolete, use kstrtoul instead
WARNING: space prohibited between function name and open parenthesis '('

Modify multi-line comments to follow Documentation/CodingStyle.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/w83792d.c |  377 ++++++++++++++++++++++++++++------------------
 1 files changed, 229 insertions(+), 148 deletions(-)

diff --git a/drivers/hwmon/w83792d.c b/drivers/hwmon/w83792d.c
index a87c4bd..ffb5fdf 100644
--- a/drivers/hwmon/w83792d.c
+++ b/drivers/hwmon/w83792d.c
@@ -1,39 +1,39 @@
 /*
-    w83792d.c - Part of lm_sensors, Linux kernel modules for hardware
-                monitoring
-    Copyright (C) 2004, 2005 Winbond Electronics Corp.
-                        Chunhao Huang <DZShen@Winbond.com.tw>,
-                        Rudolf Marek <r.marek@assembler.cz>
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
-
-    Note:
-    1. This driver is only for 2.6 kernel, 2.4 kernel need a different driver.
-    2. This driver is only for Winbond W83792D C version device, there
-       are also some motherboards with B version W83792D device. The
-       calculation method to in6-in7(measured value, limits) is a little
-       different between C and B version. C or B version can be identified
-       by CR[0x49h].
-*/
+ * w83792d.c - Part of lm_sensors, Linux kernel modules for hardware
+ *	       monitoring
+ * Copyright (C) 2004, 2005 Winbond Electronics Corp.
+ *			    Chunhao Huang <DZShen@Winbond.com.tw>,
+ *			    Rudolf Marek <r.marek@assembler.cz>
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
+ *
+ * Note:
+ * 1. This driver is only for 2.6 kernel, 2.4 kernel need a different driver.
+ * 2. This driver is only for Winbond W83792D C version device, there
+ *     are also some motherboards with B version W83792D device. The
+ *     calculation method to in6-in7(measured value, limits) is a little
+ *     different between C and B version. C or B version can be identified
+ *     by CR[0x49h].
+ */
 
 /*
-    Supports following chips:
-
-    Chip	#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA
-    w83792d	9	7	7	3	0x7a	0x5ca3	yes	no
-*/
+ * Supports following chips:
+ *
+ * Chip	#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA
+ * w83792d	9	7	7	3	0x7a	0x5ca3	yes	no
+ */
 
 #include <linux/module.h>
 #include <linux/init.h>
@@ -218,14 +218,16 @@ static const u8 W83792D_REG_LEVELS[3][4] = {
 #define W83792D_REG_VBAT		0x5D
 #define W83792D_REG_I2C_ADDR		0x48
 
-/* Conversions. Rounding and limit checking is only done on the TO_REG
-   variants. Note that you should be a bit careful with which arguments
-   these macros are called: arguments may be evaluated more than once.
-   Fixing this is just not worth it. */
-#define IN_FROM_REG(nr,val) (((nr)<=1)?(val*2): \
-				((((nr)=6)||((nr)=7))?(val*6):(val*4)))
-#define IN_TO_REG(nr,val) (((nr)<=1)?(val/2): \
-				((((nr)=6)||((nr)=7))?(val/6):(val/4)))
+/*
+ * Conversions. Rounding and limit checking is only done on the TO_REG
+ * variants. Note that you should be a bit careful with which arguments
+ * these macros are called: arguments may be evaluated more than once.
+ * Fixing this is just not worth it.
+ */
+#define IN_FROM_REG(nr, val) (((nr) <= 1) ? ((val) * 2) : \
+		((((nr) = 6) || ((nr) = 7)) ? ((val) * 6) : ((val) * 4)))
+#define IN_TO_REG(nr, val) (((nr) <= 1) ? ((val) / 2) : \
+		((((nr) = 6) || ((nr) = 7)) ? ((val) / 6) : ((val) / 4)))
 
 static inline u8
 FAN_TO_REG(long rpm, int div)
@@ -236,7 +238,7 @@ FAN_TO_REG(long rpm, int div)
 	return SENSORS_LIMIT((1350000 + rpm * div / 2) / (rpm * div), 1, 254);
 }
 
-#define FAN_FROM_REG(val,div)	((val) = 0   ? -1 : \
+#define FAN_FROM_REG(val, div)	((val) = 0   ? -1 : \
 				((val) = 255 ? 0 : \
 						1350000 / ((val) * (div))))
 
@@ -287,8 +289,10 @@ struct w83792d_data {
 	u8 temp1[3];		/* current, over, thyst */
 	u8 temp_add[2][6];	/* Register value */
 	u8 fan_div[7];		/* Register encoding, shifted right */
-	u8 pwm[7];		/* We only consider the first 3 set of pwm,
-				   although 792 chip has 7 set of pwm. */
+	u8 pwm[7];		/*
+				 * We only consider the first 3 set of pwm,
+				 * although 792 chip has 7 set of pwm.
+				 */
 	u8 pwmenable[3];
 	u32 alarms;		/* realtime status register encoding,combined */
 	u8 chassis;		/* Chassis status */
@@ -336,9 +340,11 @@ static inline long in_count_from_reg(int nr, struct w83792d_data *data)
 	return (data->in[nr] << 2) | ((data->low_bits >> (2 * nr)) & 0x03);
 }
 
-/* The SMBus locks itself. The Winbond W83792D chip has a bank register,
-   but the driver only accesses registers in bank 0, so we don't have
-   to switch banks and lock access between switches. */
+/*
+ * The SMBus locks itself. The Winbond W83792D chip has a bank register,
+ * but the driver only accesses registers in bank 0, so we don't have
+ * to switch banks and lock access between switches.
+ */
 static inline int w83792d_read_value(struct i2c_client *client, u8 reg)
 {
 	return i2c_smbus_read_byte_data(client, reg);
@@ -357,37 +363,43 @@ static ssize_t show_in(struct device *dev, struct device_attribute *attr,
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
 	struct w83792d_data *data = w83792d_update_device(dev);
-	return sprintf(buf,"%ld\n", IN_FROM_REG(nr,(in_count_from_reg(nr, data))));
+	return sprintf(buf, "%ld\n",
+		       IN_FROM_REG(nr, in_count_from_reg(nr, data)));
 }
 
 #define show_in_reg(reg) \
 static ssize_t show_##reg(struct device *dev, struct device_attribute *attr, \
 			char *buf) \
 { \
-	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr); \
+	struct sensor_device_attribute *sensor_attr \
+		= to_sensor_dev_attr(attr); \
 	int nr = sensor_attr->index; \
 	struct w83792d_data *data = w83792d_update_device(dev); \
-	return sprintf(buf,"%ld\n", (long)(IN_FROM_REG(nr, (data->reg[nr])*4))); \
+	return sprintf(buf, "%ld\n", \
+		       (long)(IN_FROM_REG(nr, data->reg[nr]) * 4)); \
 }
 
 show_in_reg(in_min);
 show_in_reg(in_max);
 
 #define store_in_reg(REG, reg) \
-static ssize_t store_in_##reg (struct device *dev, \
+static ssize_t store_in_##reg(struct device *dev, \
 				struct device_attribute *attr, \
 				const char *buf, size_t count) \
 { \
-	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr); \
+	struct sensor_device_attribute *sensor_attr \
+			= to_sensor_dev_attr(attr); \
 	int nr = sensor_attr->index; \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct w83792d_data *data = i2c_get_clientdata(client); \
-	u32 val; \
-	 \
-	val = simple_strtoul(buf, NULL, 10); \
+	unsigned long val; \
+	int err = kstrtoul(buf, 10, &val); \
+	if (err) \
+		return err; \
 	mutex_lock(&data->update_lock); \
-	data->in_##reg[nr] = SENSORS_LIMIT(IN_TO_REG(nr, val)/4, 0, 255); \
-	w83792d_write_value(client, W83792D_REG_IN_##REG[nr], data->in_##reg[nr]); \
+	data->in_##reg[nr] = SENSORS_LIMIT(IN_TO_REG(nr, val) / 4, 0, 255); \
+	w83792d_write_value(client, W83792D_REG_IN_##REG[nr], \
+			    data->in_##reg[nr]); \
 	mutex_unlock(&data->update_lock); \
 	 \
 	return count; \
@@ -396,13 +408,14 @@ store_in_reg(MIN, min);
 store_in_reg(MAX, max);
 
 #define show_fan_reg(reg) \
-static ssize_t show_##reg (struct device *dev, struct device_attribute *attr, \
+static ssize_t show_##reg(struct device *dev, struct device_attribute *attr, \
 			char *buf) \
 { \
-	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr); \
+	struct sensor_device_attribute *sensor_attr \
+			= to_sensor_dev_attr(attr); \
 	int nr = sensor_attr->index - 1; \
 	struct w83792d_data *data = w83792d_update_device(dev); \
-	return sprintf(buf,"%d\n", \
+	return sprintf(buf, "%d\n", \
 		FAN_FROM_REG(data->reg[nr], DIV_FROM_REG(data->fan_div[nr]))); \
 }
 
@@ -417,9 +430,13 @@ store_fan_min(struct device *dev, struct device_attribute *attr,
 	int nr = sensor_attr->index - 1;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83792d_data *data = i2c_get_clientdata(client);
-	u32 val;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
-	val = simple_strtoul(buf, NULL, 10);
 	mutex_lock(&data->update_lock);
 	data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
 	w83792d_write_value(client, W83792D_REG_FAN_MIN[nr],
@@ -439,10 +456,12 @@ show_fan_div(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "%u\n", DIV_FROM_REG(data->fan_div[nr - 1]));
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
@@ -455,13 +474,19 @@ store_fan_div(struct device *dev, struct device_attribute *attr,
 	/*u8 reg;*/
 	u8 fan_div_reg = 0;
 	u8 tmp_fan_div;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	/* Save fan_min */
 	mutex_lock(&data->update_lock);
 	min = FAN_FROM_REG(data->fan_min[nr],
 			   DIV_FROM_REG(data->fan_div[nr]));
 
-	data->fan_div[nr] = DIV_TO_REG(simple_strtoul(buf, NULL, 10));
+	data->fan_div[nr] = DIV_TO_REG(val);
 
 	fan_div_reg = w83792d_read_value(client, W83792D_REG_FAN_DIV[nr >> 1]);
 	fan_div_reg &= (nr & 0x01) ? 0x8f : 0xf8;
@@ -496,9 +521,13 @@ static ssize_t store_temp1(struct device *dev, struct device_attribute *attr,
 	int nr = sensor_attr->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83792d_data *data = i2c_get_clientdata(client);
-	s32 val;
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
-	val = simple_strtol(buf, NULL, 10);
 	mutex_lock(&data->update_lock);
 	data->temp1[nr] = TEMP1_TO_REG(val);
 	w83792d_write_value(client, W83792D_REG_TEMP1[nr],
@@ -513,11 +542,12 @@ static ssize_t store_temp1(struct device *dev, struct device_attribute *attr,
 static ssize_t show_temp23(struct device *dev, struct device_attribute *attr,
 				char *buf)
 {
-	struct sensor_device_attribute_2 *sensor_attr = to_sensor_dev_attr_2(attr);
+	struct sensor_device_attribute_2 *sensor_attr
+	  = to_sensor_dev_attr_2(attr);
 	int nr = sensor_attr->nr;
 	int index = sensor_attr->index;
 	struct w83792d_data *data = w83792d_update_device(dev);
-	return sprintf(buf,"%ld\n",
+	return sprintf(buf, "%ld\n",
 		(long)TEMP_ADD_FROM_REG(data->temp_add[nr][index],
 			data->temp_add[nr][index+1]));
 }
@@ -525,14 +555,19 @@ static ssize_t show_temp23(struct device *dev, struct device_attribute *attr,
 static ssize_t store_temp23(struct device *dev, struct device_attribute *attr,
 				const char *buf, size_t count)
 {
-	struct sensor_device_attribute_2 *sensor_attr = to_sensor_dev_attr_2(attr);
+	struct sensor_device_attribute_2 *sensor_attr
+	  = to_sensor_dev_attr_2(attr);
 	int nr = sensor_attr->nr;
 	int index = sensor_attr->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83792d_data *data = i2c_get_clientdata(client);
-	s32 val;
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
-	val = simple_strtol(buf, NULL, 10);
 	mutex_lock(&data->update_lock);
 	data->temp_add[nr][index] = TEMP_ADD_TO_REG_HIGH(val);
 	data->temp_add[nr][index+1] = TEMP_ADD_TO_REG_LOW(val);
@@ -604,7 +639,13 @@ store_pwm(struct device *dev, struct device_attribute *attr,
 	int nr = sensor_attr->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83792d_data *data = i2c_get_clientdata(client);
-	u8 val = SENSORS_LIMIT(simple_strtoul(buf, NULL, 10), 0, 255) >> 4;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+	val = SENSORS_LIMIT(val, 0, 255) >> 4;
 
 	mutex_lock(&data->update_lock);
 	val |= w83792d_read_value(client, W83792D_REG_PWM[nr]) & 0xf0;
@@ -623,10 +664,14 @@ store_pwmenable(struct device *dev, struct device_attribute *attr,
 	int nr = sensor_attr->index - 1;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83792d_data *data = i2c_get_clientdata(client);
-	u32 val;
 	u8 fan_cfg_tmp, cfg1_tmp, cfg2_tmp, cfg3_tmp, cfg4_tmp;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
-	val = simple_strtoul(buf, NULL, 10);
 	if (val < 1 || val > 3)
 		return -EINVAL;
 
@@ -645,7 +690,7 @@ store_pwmenable(struct device *dev, struct device_attribute *attr,
 	cfg1_tmp = data->pwmenable[0];
 	cfg2_tmp = (data->pwmenable[1]) << 2;
 	cfg3_tmp = (data->pwmenable[2]) << 4;
-	cfg4_tmp = w83792d_read_value(client,W83792D_REG_FAN_CFG) & 0xc0;
+	cfg4_tmp = w83792d_read_value(client, W83792D_REG_FAN_CFG) & 0xc0;
 	fan_cfg_tmp = ((cfg4_tmp | cfg3_tmp) | cfg2_tmp) | cfg1_tmp;
 	w83792d_write_value(client, W83792D_REG_FAN_CFG, fan_cfg_tmp);
 	mutex_unlock(&data->update_lock);
@@ -671,10 +716,13 @@ store_pwm_mode(struct device *dev, struct device_attribute *attr,
 	int nr = sensor_attr->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83792d_data *data = i2c_get_clientdata(client);
-	u32 val;
+	unsigned long val;
+	int err;
 
-	val = simple_strtoul(buf, NULL, 10);
-	if (val != 0 && val != 1)
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+	if (val > 1)
 		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
@@ -721,16 +769,20 @@ store_chassis_clear_legacy(struct device *dev, struct device_attribute *attr,
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83792d_data *data = i2c_get_clientdata(client);
-	u32 val;
+	unsigned long val;
+	int err;
 	u8 temp1 = 0, temp2 = 0;
 
 	dev_warn(dev,
 		 "Attribute %s is deprecated, use intrusion0_alarm instead\n",
 		 "chassis_clear");
 
-	val = simple_strtoul(buf, NULL, 10);
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+
 	mutex_lock(&data->update_lock);
-	data->chassis_clear = SENSORS_LIMIT(val, 0 ,1);
+	data->chassis_clear = SENSORS_LIMIT(val, 0, 1);
 	temp1 = ((data->chassis_clear) << 7) & 0x80;
 	temp2 = w83792d_read_value(client,
 		W83792D_REG_CHASSIS_CLR) & 0x7f;
@@ -780,14 +832,19 @@ store_thermal_cruise(struct device *dev, struct device_attribute *attr,
 	int nr = sensor_attr->index - 1;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83792d_data *data = i2c_get_clientdata(client);
-	u32 val;
-	u8 target_tmp=0, target_mask=0;
+	u8 target_tmp = 0, target_mask = 0;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
-	val = simple_strtoul(buf, NULL, 10);
 	target_tmp = val;
 	target_tmp = target_tmp & 0x7f;
 	mutex_lock(&data->update_lock);
-	target_mask = w83792d_read_value(client, W83792D_REG_THERMAL[nr]) & 0x80;
+	target_mask = w83792d_read_value(client,
+					 W83792D_REG_THERMAL[nr]) & 0x80;
 	data->thermal_cruise[nr] = SENSORS_LIMIT(target_tmp, 0, 255);
 	w83792d_write_value(client, W83792D_REG_THERMAL[nr],
 		(data->thermal_cruise[nr]) | target_mask);
@@ -815,19 +872,22 @@ store_tolerance(struct device *dev, struct device_attribute *attr,
 	int nr = sensor_attr->index - 1;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83792d_data *data = i2c_get_clientdata(client);
-	u32 val;
 	u8 tol_tmp, tol_mask;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
-	val = simple_strtoul(buf, NULL, 10);
 	mutex_lock(&data->update_lock);
 	tol_mask = w83792d_read_value(client,
 		W83792D_REG_TOLERANCE[nr]) & ((nr = 1) ? 0x0f : 0xf0);
 	tol_tmp = SENSORS_LIMIT(val, 0, 15);
 	tol_tmp &= 0x0f;
 	data->tolerance[nr] = tol_tmp;
-	if (nr = 1) {
+	if (nr = 1)
 		tol_tmp <<= 4;
-	}
 	w83792d_write_value(client, W83792D_REG_TOLERANCE[nr],
 		tol_mask | tol_tmp);
 	mutex_unlock(&data->update_lock);
@@ -840,7 +900,8 @@ static ssize_t
 show_sf2_point(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
-	struct sensor_device_attribute_2 *sensor_attr = to_sensor_dev_attr_2(attr);
+	struct sensor_device_attribute_2 *sensor_attr
+	  = to_sensor_dev_attr_2(attr);
 	int nr = sensor_attr->nr;
 	int index = sensor_attr->index;
 	struct w83792d_data *data = w83792d_update_device(dev);
@@ -851,15 +912,20 @@ static ssize_t
 store_sf2_point(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
-	struct sensor_device_attribute_2 *sensor_attr = to_sensor_dev_attr_2(attr);
+	struct sensor_device_attribute_2 *sensor_attr
+	  = to_sensor_dev_attr_2(attr);
 	int nr = sensor_attr->nr - 1;
 	int index = sensor_attr->index - 1;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83792d_data *data = i2c_get_clientdata(client);
-	u32 val;
 	u8 mask_tmp = 0;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
-	val = simple_strtoul(buf, NULL, 10);
 	mutex_lock(&data->update_lock);
 	data->sf2_points[index][nr] = SENSORS_LIMIT(val, 0, 127);
 	mask_tmp = w83792d_read_value(client,
@@ -875,7 +941,8 @@ static ssize_t
 show_sf2_level(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
-	struct sensor_device_attribute_2 *sensor_attr = to_sensor_dev_attr_2(attr);
+	struct sensor_device_attribute_2 *sensor_attr
+	  = to_sensor_dev_attr_2(attr);
 	int nr = sensor_attr->nr;
 	int index = sensor_attr->index;
 	struct w83792d_data *data = w83792d_update_device(dev);
@@ -887,25 +954,30 @@ static ssize_t
 store_sf2_level(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
-	struct sensor_device_attribute_2 *sensor_attr = to_sensor_dev_attr_2(attr);
+	struct sensor_device_attribute_2 *sensor_attr
+	  = to_sensor_dev_attr_2(attr);
 	int nr = sensor_attr->nr;
 	int index = sensor_attr->index - 1;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83792d_data *data = i2c_get_clientdata(client);
-	u32 val;
-	u8 mask_tmp=0, level_tmp=0;
+	u8 mask_tmp = 0, level_tmp = 0;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
-	val = simple_strtoul(buf, NULL, 10);
 	mutex_lock(&data->update_lock);
 	data->sf2_levels[index][nr] = SENSORS_LIMIT((val * 15) / 100, 0, 15);
 	mask_tmp = w83792d_read_value(client, W83792D_REG_LEVELS[index][nr])
-		& ((nr=3) ? 0xf0 : 0x0f);
-	if (nr=3) {
+		& ((nr = 3) ? 0xf0 : 0x0f);
+	if (nr = 3)
 		level_tmp = data->sf2_levels[index][nr];
-	} else {
+	else
 		level_tmp = data->sf2_levels[index][nr] << 4;
-	}
-	w83792d_write_value(client, W83792D_REG_LEVELS[index][nr], level_tmp | mask_tmp);
+	w83792d_write_value(client, W83792D_REG_LEVELS[index][nr],
+			    level_tmp | mask_tmp);
 	mutex_unlock(&data->update_lock);
 
 	return count;
@@ -939,9 +1011,8 @@ w83792d_detect_subclients(struct i2c_client *new_client)
 	}
 
 	val = w83792d_read_value(new_client, W83792D_REG_I2C_SUBADDR);
-	if (!(val & 0x08)) {
+	if (!(val & 0x08))
 		data->lm75[0] = i2c_new_dummy(adapter, 0x48 + (val & 0x7));
-	}
 	if (!(val & 0x80)) {
 		if ((data->lm75[0] != NULL) &&
 			((val & 0x7) = ((val >> 4) & 0x7))) {
@@ -1306,9 +1377,8 @@ w83792d_detect(struct i2c_client *client, struct i2c_board_info *info)
 	int val1, val2;
 	unsigned short address = client->addr;
 
-	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
-	}
 
 	if (w83792d_read_value(client, W83792D_REG_CONFIG) & 0x80)
 		return -ENODEV;
@@ -1318,11 +1388,13 @@ w83792d_detect(struct i2c_client *client, struct i2c_board_info *info)
 	/* Check for Winbond ID if in bank 0 */
 	if (!(val1 & 0x07)) {  /* is Bank0 */
 		if ((!(val1 & 0x80) && val2 != 0xa3) ||
-		    ( (val1 & 0x80) && val2 != 0x5c))
+		    ((val1 & 0x80) && val2 != 0x5c))
 			return -ENODEV;
 	}
-	/* If Winbond chip, address of chip and W83792D_REG_I2C_ADDR
-	   should match */
+	/*
+	 * If Winbond chip, address of chip and W83792D_REG_I2C_ADDR
+	 * should match
+	 */
 	if (w83792d_read_value(client, W83792D_REG_I2C_ADDR) != address)
 		return -ENODEV;
 
@@ -1374,33 +1446,40 @@ w83792d_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	}
 
 	/* Register sysfs hooks */
-	if ((err = sysfs_create_group(&dev->kobj, &w83792d_group)))
+	err = sysfs_create_group(&dev->kobj, &w83792d_group);
+	if (err)
 		goto ERROR3;
 
-	/* Read GPIO enable register to check if pins for fan 4,5 are used as
-	   GPIO */
+	/*
+	 * Read GPIO enable register to check if pins for fan 4,5 are used as
+	 * GPIO
+	 */
 	val1 = w83792d_read_value(client, W83792D_REG_GPIO_EN);
 
-	if (!(val1 & 0x40))
-		if ((err = sysfs_create_group(&dev->kobj,
-					      &w83792d_group_fan[0])))
+	if (!(val1 & 0x40)) {
+		err = sysfs_create_group(&dev->kobj, &w83792d_group_fan[0]);
+		if (err)
 			goto exit_remove_files;
+	}
 
-	if (!(val1 & 0x20))
-		if ((err = sysfs_create_group(&dev->kobj,
-					      &w83792d_group_fan[1])))
+	if (!(val1 & 0x20)) {
+		err = sysfs_create_group(&dev->kobj, &w83792d_group_fan[1]);
+		if (err)
 			goto exit_remove_files;
+	}
 
 	val1 = w83792d_read_value(client, W83792D_REG_PIN);
-	if (val1 & 0x40)
-		if ((err = sysfs_create_group(&dev->kobj,
-					      &w83792d_group_fan[2])))
+	if (val1 & 0x40) {
+		err = sysfs_create_group(&dev->kobj, &w83792d_group_fan[2]);
+		if (err)
 			goto exit_remove_files;
+	}
 
-	if (val1 & 0x04)
-		if ((err = sysfs_create_group(&dev->kobj,
-					      &w83792d_group_fan[3])))
+	if (val1 & 0x04) {
+		err = sysfs_create_group(&dev->kobj, &w83792d_group_fan[3]);
+		if (err)
 			goto exit_remove_files;
+	}
 
 	data->hwmon_dev = hwmon_device_register(dev);
 	if (IS_ERR(data->hwmon_dev)) {
@@ -1451,14 +1530,16 @@ w83792d_init_client(struct i2c_client *client)
 {
 	u8 temp2_cfg, temp3_cfg, vid_in_b;
 
-	if (init) {
+	if (init)
 		w83792d_write_value(client, W83792D_REG_CONFIG, 0x80);
-	}
-	/* Clear the bit6 of W83792D_REG_VID_IN_B(set it into 0):
-	   W83792D_REG_VID_IN_B bit6 = 0: the high/low limit of
-	     vin0/vin1 can be modified by user;
-	   W83792D_REG_VID_IN_B bit6 = 1: the high/low limit of
-	     vin0/vin1 auto-updated, can NOT be modified by user. */
+
+	/*
+	 * Clear the bit6 of W83792D_REG_VID_IN_B(set it into 0):
+	 * W83792D_REG_VID_IN_B bit6 = 0: the high/low limit of
+	 * vin0/vin1 can be modified by user;
+	 * W83792D_REG_VID_IN_B bit6 = 1: the high/low limit of
+	 * vin0/vin1 auto-updated, can NOT be modified by user.
+	 */
 	vid_in_b = w83792d_read_value(client, W83792D_REG_VID_IN_B);
 	w83792d_write_value(client, W83792D_REG_VID_IN_B,
 			    vid_in_b & 0xbf);
@@ -1527,7 +1608,7 @@ static struct w83792d_data *w83792d_update_device(struct device *dev)
 		for (i = 0; i < 2; i++) {
 			for (j = 0; j < 6; j++) {
 				data->temp_add[i][j] = w83792d_read_value(
-					client,W83792D_REG_TEMP_ADD[i][j]);
+					client, W83792D_REG_TEMP_ADD[i][j]);
 			}
 		}
 
@@ -1572,8 +1653,9 @@ static struct w83792d_data *w83792d_update_device(struct device *dev)
 		/* Update Smart Fan II temperature points */
 		for (i = 0; i < 3; i++) {
 			for (j = 0; j < 4; j++) {
-				data->sf2_points[i][j] = w83792d_read_value(
-					client,W83792D_REG_POINTS[i][j]) & 0x7f;
+				data->sf2_points[i][j]
+				  = w83792d_read_value(client,
+					W83792D_REG_POINTS[i][j]) & 0x7f;
 			}
 		}
 
@@ -1605,10 +1687,10 @@ static struct w83792d_data *w83792d_update_device(struct device *dev)
 #ifdef DEBUG
 static void w83792d_print_debug(struct w83792d_data *data, struct device *dev)
 {
-	int i=0, j=0;
+	int i = 0, j = 0;
 	dev_dbg(dev, "=====The following is the debug message...====\n");
 	dev_dbg(dev, "9 set of Voltages: ===>\n");
-	for (i=0; i<9; i++) {
+	for (i = 0; i < 9; i++) {
 		dev_dbg(dev, "vin[%d] is: 0x%x\n", i, data->in[i]);
 		dev_dbg(dev, "vin[%d] max is: 0x%x\n", i, data->in_max[i]);
 		dev_dbg(dev, "vin[%d] min is: 0x%x\n", i, data->in_min[i]);
@@ -1616,27 +1698,26 @@ static void w83792d_print_debug(struct w83792d_data *data, struct device *dev)
 	dev_dbg(dev, "Low Bit1 is: 0x%x\n", data->low_bits & 0xff);
 	dev_dbg(dev, "Low Bit2 is: 0x%x\n", data->low_bits >> 8);
 	dev_dbg(dev, "7 set of Fan Counts and Duty Cycles: ===>\n");
-	for (i=0; i<7; i++) {
+	for (i = 0; i < 7; i++) {
 		dev_dbg(dev, "fan[%d] is: 0x%x\n", i, data->fan[i]);
 		dev_dbg(dev, "fan[%d] min is: 0x%x\n", i, data->fan_min[i]);
 		dev_dbg(dev, "pwm[%d]     is: 0x%x\n", i, data->pwm[i]);
 	}
 	dev_dbg(dev, "3 set of Temperatures: ===>\n");
-	for (i=0; i<3; i++) {
+	for (i = 0; i < 3; i++)
 		dev_dbg(dev, "temp1[%d] is: 0x%x\n", i, data->temp1[i]);
-	}
 
-	for (i=0; i<2; i++) {
-		for (j=0; j<6; j++) {
+	for (i = 0; i < 2; i++) {
+		for (j = 0; j < 6; j++) {
 			dev_dbg(dev, "temp_add[%d][%d] is: 0x%x\n", i, j,
 							data->temp_add[i][j]);
 		}
 	}
 
-	for (i=0; i<7; i++) {
+	for (i = 0; i < 7; i++)
 		dev_dbg(dev, "fan_div[%d] is: 0x%x\n", i, data->fan_div[i]);
-	}
-	dev_dbg(dev, "=====End of the debug message...=========\n");
+
+	dev_dbg(dev, "=====End of the debug message...========\n");
 	dev_dbg(dev, "\n");
 }
 #endif
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
