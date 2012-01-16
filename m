From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 16 Jan 2012 08:49:40 +0000
Subject: [lm-sensors] [PATCH 38/39] hwmon: (w83l786ng) Fix checkpatch issues
Message-Id: <1326703781-14272-39-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fixed:
ERROR: code indent should use tabs where possible
ERROR: do not use assignment in if condition
ERROR: space required after that ',' (ctx:VxV)
WARNING: braces {} are not necessary for single statement blocks
WARNING: please, no space before tabs
WARNING: please, no spaces at the start of a line
WARNING: simple_strtol is obsolete, use kstrtol instead
WARNING: simple_strtoul is obsolete, use kstrtoul instead
WARNING: space prohibited between function name and open parenthesis '('

Not fixed (false positive):
ERROR: Macros with complex values should be enclosed in parenthesis

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/w83l786ng.c |  105 ++++++++++++++++++++++++++++++--------------
 1 files changed, 71 insertions(+), 34 deletions(-)

diff --git a/drivers/hwmon/w83l786ng.c b/drivers/hwmon/w83l786ng.c
index 0254e18..5a6712a 100644
--- a/drivers/hwmon/w83l786ng.c
+++ b/drivers/hwmon/w83l786ng.c
@@ -52,7 +52,7 @@ MODULE_PARM_DESC(reset, "Set to 1 to reset chip, not recommended");
 
 #define W83L786NG_REG_CONFIG		0x40
 #define W83L786NG_REG_ALARM1		0x41
-#define W83L786NG_REG_ALARM2 		0x42
+#define W83L786NG_REG_ALARM2		0x42
 #define W83L786NG_REG_GPIO_EN		0x47
 #define W83L786NG_REG_MAN_ID2		0x4C
 #define W83L786NG_REG_MAN_ID1		0x4D
@@ -89,19 +89,21 @@ FAN_TO_REG(long rpm, int div)
 	return SENSORS_LIMIT((1350000 + rpm * div / 2) / (rpm * div), 1, 254);
 }
 
-#define FAN_FROM_REG(val,div)	((val) = 0   ? -1 : \
+#define FAN_FROM_REG(val, div)	((val) = 0   ? -1 : \
 				((val) = 255 ? 0 : \
 				1350000 / ((val) * (div))))
 
 /* for temp */
-#define TEMP_TO_REG(val)	(SENSORS_LIMIT(((val) < 0 ? (val)+0x100*1000 \
-				    : (val)) / 1000, 0, 0xff))
-#define TEMP_FROM_REG(val)	(((val) & 0x80 ? (val)-0x100 : (val)) * 1000)
+#define TEMP_TO_REG(val)	(SENSORS_LIMIT(((val) < 0 ? \
+						(val) + 0x100 * 1000 \
+						: (val)) / 1000, 0, 0xff))
+#define TEMP_FROM_REG(val)	(((val) & 0x80 ? \
+				  (val) - 0x100 : (val)) * 1000)
 
 /* The analog voltage inputs have 8mV LSB. Since the sysfs output is
    in mV as would be measured on the chip input pin, need to just
    multiply/divide by 8 to translate from/to register values. */
-#define IN_TO_REG(val)          (SENSORS_LIMIT((((val) + 4) / 8), 0, 255))
+#define IN_TO_REG(val)		(SENSORS_LIMIT((((val) + 4) / 8), 0, 255))
 #define IN_FROM_REG(val)	((val) * 8)
 
 #define DIV_FROM_REG(val)	(1 << (val))
@@ -116,7 +118,7 @@ DIV_TO_REG(long val)
 			break;
 		val >>= 1;
 	}
-	return ((u8) i);
+	return (u8)i;
 }
 
 struct w83l786ng_data {
@@ -186,11 +188,11 @@ w83l786ng_write_value(struct i2c_client *client, u8 reg, u8 value)
 #define show_in_reg(reg) \
 static ssize_t \
 show_##reg(struct device *dev, struct device_attribute *attr, \
-           char *buf) \
+	   char *buf) \
 { \
 	int nr = to_sensor_dev_attr(attr)->index; \
 	struct w83l786ng_data *data = w83l786ng_update_device(dev); \
-	return sprintf(buf,"%d\n", IN_FROM_REG(data->reg[nr])); \
+	return sprintf(buf, "%d\n", IN_FROM_REG(data->reg[nr])); \
 }
 
 show_in_reg(in)
@@ -199,13 +201,16 @@ show_in_reg(in_max)
 
 #define store_in_reg(REG, reg) \
 static ssize_t \
-store_in_##reg (struct device *dev, struct device_attribute *attr, \
-		const char *buf, size_t count) \
+store_in_##reg(struct device *dev, struct device_attribute *attr, \
+	       const char *buf, size_t count) \
 { \
 	int nr = to_sensor_dev_attr(attr)->index; \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct w83l786ng_data *data = i2c_get_clientdata(client); \
-	unsigned long val = simple_strtoul(buf, NULL, 10); \
+	unsigned long val; \
+	int err = kstrtoul(buf, 10, &val); \
+	if (err) \
+		return err; \
 	mutex_lock(&data->update_lock); \
 	data->in_##reg[nr] = IN_TO_REG(val); \
 	w83l786ng_write_value(client, W83L786NG_REG_IN_##REG(nr), \
@@ -241,8 +246,8 @@ static ssize_t show_##reg(struct device *dev, struct device_attribute *attr, \
 { \
 	int nr = to_sensor_dev_attr(attr)->index; \
 	struct w83l786ng_data *data = w83l786ng_update_device(dev); \
-        return sprintf(buf,"%d\n", \
-                FAN_FROM_REG(data->fan[nr], DIV_FROM_REG(data->fan_div[nr]))); \
+	return sprintf(buf, "%d\n", \
+		FAN_FROM_REG(data->fan[nr], DIV_FROM_REG(data->fan_div[nr]))); \
 }
 
 show_fan_reg(fan);
@@ -255,9 +260,13 @@ store_fan_min(struct device *dev, struct device_attribute *attr,
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83l786ng_data *data = i2c_get_clientdata(client);
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
 	w83l786ng_write_value(client, W83L786NG_REG_FAN_MIN(nr),
@@ -294,11 +303,18 @@ store_fan_div(struct device *dev, struct device_attribute *attr,
 	u8 keep_mask = 0;
 	u8 new_shift = 0;
 
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+
 	/* Save fan_min */
 	mutex_lock(&data->update_lock);
 	min = FAN_FROM_REG(data->fan_min[nr], DIV_FROM_REG(data->fan_div[nr]));
 
-	data->fan_div[nr] = DIV_TO_REG(simple_strtoul(buf, NULL, 10));
+	data->fan_div[nr] = DIV_TO_REG(val);
 
 	switch (nr) {
 	case 0:
@@ -371,16 +387,20 @@ store_temp(struct device *dev, struct device_attribute *attr,
 	int index = sensor_attr->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83l786ng_data *data = i2c_get_clientdata(client);
-	s32 val;
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
-	val = simple_strtol(buf, NULL, 10);
 	mutex_lock(&data->update_lock);
 	data->temp[nr][index] = TEMP_TO_REG(val);
 	w83l786ng_write_value(client, W83L786NG_REG_TEMP[nr][index],
 			      data->temp[nr][index]);
 	mutex_unlock(&data->update_lock);
 
-        return count;
+	return count;
 }
 
 static struct sensor_device_attribute_2 sda_temp_input[] = {
@@ -403,8 +423,8 @@ static struct sensor_device_attribute_2 sda_temp_max_hyst[] = {
 };
 
 #define show_pwm_reg(reg) \
-static ssize_t show_##reg (struct device *dev, struct device_attribute *attr, \
-			   char *buf) \
+static ssize_t show_##reg(struct device *dev, struct device_attribute *attr, \
+			  char *buf) \
 { \
 	struct w83l786ng_data *data = w83l786ng_update_device(dev); \
 	int nr = to_sensor_dev_attr(attr)->index; \
@@ -422,8 +442,13 @@ store_pwm_mode(struct device *dev, struct device_attribute *attr,
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83l786ng_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
 	u8 reg;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	if (val > 1)
 		return -EINVAL;
@@ -445,7 +470,13 @@ store_pwm(struct device *dev, struct device_attribute *attr,
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83l786ng_data *data = i2c_get_clientdata(client);
-	u32 val = SENSORS_LIMIT(simple_strtoul(buf, NULL, 10), 0, 255);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+	val = SENSORS_LIMIT(val, 0, 255);
 
 	mutex_lock(&data->update_lock);
 	data->pwm[nr] = val;
@@ -461,11 +492,15 @@ store_pwm_enable(struct device *dev, struct device_attribute *attr,
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83l786ng_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
-
 	u8 reg;
+	unsigned long val;
+	int err;
 
-	if (!val || (val > 2))  /* only modes 1 and 2 are supported */
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+
+	if (!val || val > 2)  /* only modes 1 and 2 are supported */
 		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
@@ -513,10 +548,13 @@ store_tolerance(struct device *dev, struct device_attribute *attr,
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83l786ng_data *data = i2c_get_clientdata(client);
-	u32 val;
 	u8 tol_tmp, tol_mask;
+	unsigned long val;
+	int err;
 
-	val = simple_strtoul(buf, NULL, 10);
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	tol_mask = w83l786ng_read_value(client,
@@ -524,9 +562,8 @@ store_tolerance(struct device *dev, struct device_attribute *attr,
 	tol_tmp = SENSORS_LIMIT(val, 0, 15);
 	tol_tmp &= 0x0f;
 	data->tolerance[nr] = tol_tmp;
-	if (nr = 1) {
+	if (nr = 1)
 		tol_tmp <<= 4;
-	}
 
 	w83l786ng_write_value(client, W83L786NG_REG_TOLERANCE,
 			      tol_mask | tol_tmp);
@@ -591,9 +628,8 @@ w83l786ng_detect(struct i2c_client *client, struct i2c_board_info *info)
 	u16 man_id;
 	u8 chip_id;
 
-	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
-	}
 
 	/* Detection */
 	if ((w83l786ng_read_value(client, W83L786NG_REG_CONFIG) & 0x80)) {
@@ -652,7 +688,8 @@ w83l786ng_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	data->fan_div[1] = (reg_tmp >> 4) & 0x07;
 
 	/* Register sysfs hooks */
-	if ((err = sysfs_create_group(&client->dev.kobj, &w83l786ng_group)))
+	err = sysfs_create_group(&client->dev.kobj, &w83l786ng_group);
+	if (err)
 		goto exit_remove;
 
 	data->hwmon_dev = hwmon_device_register(dev);
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
