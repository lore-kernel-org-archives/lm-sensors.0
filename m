From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 26 Jan 2012 20:56:04 +0000
Subject: [lm-sensors] [PATCH 3/3] hwmon: (lm63) Let the user adjust the lookup table
Message-Id: <20120126215604.29be0047@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Make the automatic fan speed control lookup table writable. This lets
the user tweak the fan speed / temperature response curve.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/lm63.c |  118 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 76 insertions(+), 42 deletions(-)

--- linux-3.3-rc1.orig/drivers/hwmon/lm63.c	2012-01-26 21:20:59.505007866 +0100
+++ linux-3.3-rc1/drivers/hwmon/lm63.c	2012-01-26 21:32:26.368372150 +0100
@@ -205,6 +205,15 @@ static inline int lut_temp_from_reg(stru
 	return data->temp8[nr] * (data->lut_temp_highres ? 500 : 1000);
 }
 
+static inline int lut_temp_to_reg(struct lm63_data *data, long val)
+{
+	val -= data->temp2_offset;
+	if (data->lut_temp_highres)
+		return DIV_ROUND_CLOSEST(SENSORS_LIMIT(val, 0, 127500), 500);
+	else
+		return DIV_ROUND_CLOSEST(SENSORS_LIMIT(val, 0, 127000), 1000);
+}
+
 /*
  * Update the lookup table register cache.
  * client->update_lock must be held when calling this function.
@@ -387,13 +396,16 @@ static ssize_t show_pwm1(struct device *
 	return sprintf(buf, "%d\n", pwm);
 }
 
-static ssize_t set_pwm1(struct device *dev, struct device_attribute *dummy,
+static ssize_t set_pwm1(struct device *dev, struct device_attribute *devattr,
 			const char *buf, size_t count)
 {
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm63_data *data = i2c_get_clientdata(client);
+	int nr = attr->index;
 	unsigned long val;
 	int err;
+	u8 reg;
 
 	if (!(data->config_fan & 0x20)) /* register is read-only */
 		return -EPERM;
@@ -402,11 +414,13 @@ static ssize_t set_pwm1(struct device *d
 	if (err)
 		return err;
 
+	reg = nr ? LM63_REG_LUT_PWM(nr - 1) : LM63_REG_PWM_VALUE;
 	val = SENSORS_LIMIT(val, 0, 255);
+
 	mutex_lock(&data->update_lock);
-	data->pwm1[0] = data->pwm_highres ? val :
+	data->pwm1[nr] = data->pwm_highres ? val :
 			(val * data->pwm1_freq * 2 + 127) / 255;
-	i2c_smbus_write_byte_data(client, LM63_REG_PWM_VALUE, data->pwm1[0]);
+	i2c_smbus_write_byte_data(client, reg, data->pwm1[nr]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -495,23 +509,31 @@ static ssize_t set_temp8(struct device *
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm63_data *data = i2c_get_clientdata(client);
 	int nr = attr->index;
-	int reg = nr = 2 ? LM63_REG_REMOTE_TCRIT : LM63_REG_LOCAL_HIGH;
 	long val;
 	int err;
 	int temp;
+	u8 reg;
 
 	err = kstrtol(buf, 10, &val);
 	if (err)
 		return err;
 
 	mutex_lock(&data->update_lock);
-	if (nr = 2) {
+	switch (nr) {
+	case 2:
+		reg = LM63_REG_REMOTE_TCRIT;
 		if (data->remote_unsigned)
 			temp = TEMP8U_TO_REG(val - data->temp2_offset);
 		else
 			temp = TEMP8_TO_REG(val - data->temp2_offset);
-	} else {
+		break;
+	case 1:
+		reg = LM63_REG_LOCAL_HIGH;
 		temp = TEMP8_TO_REG(val);
+		break;
+	default:	/* lookup table */
+		reg = LM63_REG_LUT_TEMP(nr - 3);
+		temp = lut_temp_to_reg(data, val);
 	}
 	data->temp8[nr] = temp;
 	i2c_smbus_write_byte_data(client, reg, temp);
@@ -743,64 +765,76 @@ static SENSOR_DEVICE_ATTR(fan1_min, S_IW
 static SENSOR_DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, show_pwm1, set_pwm1, 0);
 static DEVICE_ATTR(pwm1_enable, S_IWUSR | S_IRUGO,
 	show_pwm1_enable, set_pwm1_enable);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point1_pwm, S_IRUGO, show_pwm1, NULL, 1);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point1_temp, S_IRUGO,
-	show_lut_temp, NULL, 3);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point1_pwm, S_IWUSR | S_IRUGO,
+	show_pwm1, set_pwm1, 1);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point1_temp, S_IWUSR | S_IRUGO,
+	show_lut_temp, set_temp8, 3);
 static SENSOR_DEVICE_ATTR(pwm1_auto_point1_temp_hyst, S_IRUGO,
 	show_lut_temp_hyst, NULL, 3);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point2_pwm, S_IRUGO, show_pwm1, NULL, 2);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point2_temp, S_IRUGO,
-	show_lut_temp, NULL, 4);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point2_pwm, S_IWUSR | S_IRUGO,
+	show_pwm1, set_pwm1, 2);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point2_temp, S_IWUSR | S_IRUGO,
+	show_lut_temp, set_temp8, 4);
 static SENSOR_DEVICE_ATTR(pwm1_auto_point2_temp_hyst, S_IRUGO,
 	show_lut_temp_hyst, NULL, 4);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point3_pwm, S_IRUGO, show_pwm1, NULL, 3);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point3_temp, S_IRUGO,
-	show_lut_temp, NULL, 5);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point3_pwm, S_IWUSR | S_IRUGO,
+	show_pwm1, set_pwm1, 3);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point3_temp, S_IWUSR | S_IRUGO,
+	show_lut_temp, set_temp8, 5);
 static SENSOR_DEVICE_ATTR(pwm1_auto_point3_temp_hyst, S_IRUGO,
 	show_lut_temp_hyst, NULL, 5);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point4_pwm, S_IRUGO, show_pwm1, NULL, 4);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point4_temp, S_IRUGO,
-	show_lut_temp, NULL, 6);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point4_pwm, S_IWUSR | S_IRUGO,
+	show_pwm1, set_pwm1, 4);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point4_temp, S_IWUSR | S_IRUGO,
+	show_lut_temp, set_temp8, 6);
 static SENSOR_DEVICE_ATTR(pwm1_auto_point4_temp_hyst, S_IRUGO,
 	show_lut_temp_hyst, NULL, 6);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point5_pwm, S_IRUGO, show_pwm1, NULL, 5);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point5_temp, S_IRUGO,
-	show_lut_temp, NULL, 7);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point5_pwm, S_IWUSR | S_IRUGO,
+	show_pwm1, set_pwm1, 5);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point5_temp, S_IWUSR | S_IRUGO,
+	show_lut_temp, set_temp8, 7);
 static SENSOR_DEVICE_ATTR(pwm1_auto_point5_temp_hyst, S_IRUGO,
 	show_lut_temp_hyst, NULL, 7);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point6_pwm, S_IRUGO, show_pwm1, NULL, 6);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point6_temp, S_IRUGO,
-	show_lut_temp, NULL, 8);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point6_pwm, S_IWUSR | S_IRUGO,
+	show_pwm1, set_pwm1, 6);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point6_temp, S_IWUSR | S_IRUGO,
+	show_lut_temp, set_temp8, 8);
 static SENSOR_DEVICE_ATTR(pwm1_auto_point6_temp_hyst, S_IRUGO,
 	show_lut_temp_hyst, NULL, 8);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point7_pwm, S_IRUGO, show_pwm1, NULL, 7);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point7_temp, S_IRUGO,
-	show_lut_temp, NULL, 9);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point7_pwm, S_IWUSR | S_IRUGO,
+	show_pwm1, set_pwm1, 7);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point7_temp, S_IWUSR | S_IRUGO,
+	show_lut_temp, set_temp8, 9);
 static SENSOR_DEVICE_ATTR(pwm1_auto_point7_temp_hyst, S_IRUGO,
 	show_lut_temp_hyst, NULL, 9);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point8_pwm, S_IRUGO, show_pwm1, NULL, 8);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point8_temp, S_IRUGO,
-	show_lut_temp, NULL, 10);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point8_pwm, S_IWUSR | S_IRUGO,
+	show_pwm1, set_pwm1, 8);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point8_temp, S_IWUSR | S_IRUGO,
+	show_lut_temp, set_temp8, 10);
 static SENSOR_DEVICE_ATTR(pwm1_auto_point8_temp_hyst, S_IRUGO,
 	show_lut_temp_hyst, NULL, 10);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point9_pwm, S_IRUGO, show_pwm1, NULL, 9);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point9_temp, S_IRUGO,
-	show_lut_temp, NULL, 11);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point9_pwm, S_IWUSR | S_IRUGO,
+	show_pwm1, set_pwm1, 9);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point9_temp, S_IWUSR | S_IRUGO,
+	show_lut_temp, set_temp8, 11);
 static SENSOR_DEVICE_ATTR(pwm1_auto_point9_temp_hyst, S_IRUGO,
 	show_lut_temp_hyst, NULL, 11);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point10_pwm, S_IRUGO, show_pwm1, NULL, 10);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point10_temp, S_IRUGO,
-	show_lut_temp, NULL, 12);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point10_pwm, S_IWUSR | S_IRUGO,
+	show_pwm1, set_pwm1, 10);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point10_temp, S_IWUSR | S_IRUGO,
+	show_lut_temp, set_temp8, 12);
 static SENSOR_DEVICE_ATTR(pwm1_auto_point10_temp_hyst, S_IRUGO,
 	show_lut_temp_hyst, NULL, 12);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point11_pwm, S_IRUGO, show_pwm1, NULL, 11);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point11_temp, S_IRUGO,
-	show_lut_temp, NULL, 13);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point11_pwm, S_IWUSR | S_IRUGO,
+	show_pwm1, set_pwm1, 11);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point11_temp, S_IWUSR | S_IRUGO,
+	show_lut_temp, set_temp8, 13);
 static SENSOR_DEVICE_ATTR(pwm1_auto_point11_temp_hyst, S_IRUGO,
 	show_lut_temp_hyst, NULL, 13);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point12_pwm, S_IRUGO, show_pwm1, NULL, 12);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point12_temp, S_IRUGO,
-	show_lut_temp, NULL, 14);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point12_pwm, S_IWUSR | S_IRUGO,
+	show_pwm1, set_pwm1, 12);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point12_temp, S_IWUSR | S_IRUGO,
+	show_lut_temp, set_temp8, 14);
 static SENSOR_DEVICE_ATTR(pwm1_auto_point12_temp_hyst, S_IRUGO,
 	show_lut_temp_hyst, NULL, 14);
 

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
