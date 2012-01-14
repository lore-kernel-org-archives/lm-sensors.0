From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 14 Jan 2012 09:07:04 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (lm63) Expose automatic fan speed control lookup table
Message-Id: <20120114100704.5e22934d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The LM63 and compatible devices have a lookup table to control the fan
speed automatically. Expose it in sysfs. We might make it writable in
the future.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/lm63.c |  148 +++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 134 insertions(+), 14 deletions(-)

--- linux-3.3-rc0.orig/drivers/hwmon/lm63.c	2012-01-14 09:23:20.000000000 +0100
+++ linux-3.3-rc0/drivers/hwmon/lm63.c	2012-01-14 10:05:41.000000000 +0100
@@ -75,6 +75,9 @@ static const unsigned short normal_i2c[]
 
 #define LM63_REG_PWM_VALUE		0x4C
 #define LM63_REG_PWM_FREQ		0x4D
+#define LM63_REG_LUT_TEMP_HYST		0x4F
+#define LM63_REG_LUT_TEMP(nr)		(0x50 + 2 * (nr))
+#define LM63_REG_LUT_PWM(nr)		(0x51 + 2 * (nr))
 
 #define LM63_REG_LOCAL_TEMP		0x00
 #define LM63_REG_LOCAL_HIGH		0x05
@@ -192,7 +195,9 @@ struct lm63_data {
 	struct device *hwmon_dev;
 	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
+	char lut_valid; /* zero until lut fields are valid */
 	unsigned long last_updated; /* in jiffies */
+	unsigned long lut_last_updated; /* in jiffies */
 	enum chips kind;
 	int temp2_offset;
 
@@ -204,18 +209,22 @@ struct lm63_data {
 	u16 fan[2];	/* 0: input
 			   1: low limit */
 	u8 pwm1_freq;
-	u8 pwm1_value;
-	s8 temp8[3];	/* 0: local input
+	u8 pwm1[9];	/* 0: current output
+			   1-8: lookup table */
+	s8 temp8[11];	/* 0: local input
 			   1: local high limit
-			   2: remote critical limit */
+			   2: remote critical limit
+			   3-10: lookup table */
 	s16 temp11[4];	/* 0: remote input
 			   1: remote low limit
 			   2: remote high limit
 			   3: remote offset */
 	u16 temp11u;	/* remote input (unsigned) */
 	u8 temp2_crit_hyst;
+	u8 lut_temp_hyst;
 	u8 alarms;
 	bool pwm_highres;
+	bool lut_temp_highres;
 	bool remote_unsigned; /* true if unsigned remote upper limits */
 	bool trutherm;
 };
@@ -227,6 +236,11 @@ static inline int temp8_from_reg(struct
 	return TEMP8_FROM_REG(data->temp8[nr]);
 }
 
+static inline int lut_temp_from_reg(struct lm63_data *data, int nr)
+{
+	return data->temp8[nr] * (data->lut_temp_highres ? 500 : 1000);
+}
+
 /*
  * Sysfs callback functions and files
  */
@@ -261,17 +275,19 @@ static ssize_t set_fan(struct device *de
 	return count;
 }
 
-static ssize_t show_pwm1(struct device *dev, struct device_attribute *dummy,
+static ssize_t show_pwm1(struct device *dev, struct device_attribute *devattr,
 			 char *buf)
 {
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct lm63_data *data = lm63_update_device(dev);
+	int nr = attr->index;
 	int pwm;
 
 	if (data->pwm_highres)
-		pwm = data->pwm1_value;
+		pwm = data->pwm1[nr];
 	else
-		pwm = data->pwm1_value >= 2 * data->pwm1_freq ?
-		       255 : (data->pwm1_value * 255 + data->pwm1_freq) /
+		pwm = data->pwm1[nr] >= 2 * data->pwm1_freq ?
+		       255 : (data->pwm1[nr] * 255 + data->pwm1_freq) /
 		       (2 * data->pwm1_freq);
 
 	return sprintf(buf, "%d\n", pwm);
@@ -294,9 +310,9 @@ static ssize_t set_pwm1(struct device *d
 
 	val = SENSORS_LIMIT(val, 0, 255);
 	mutex_lock(&data->update_lock);
-	data->pwm1_value = data->pwm_highres ? val :
-			   (val * data->pwm1_freq * 2 + 127) / 255;
-	i2c_smbus_write_byte_data(client, LM63_REG_PWM_VALUE, data->pwm1_value);
+	data->pwm1[0] = data->pwm_highres ? val :
+			(val * data->pwm1_freq * 2 + 127) / 255;
+	i2c_smbus_write_byte_data(client, LM63_REG_PWM_VALUE, data->pwm1[0]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -333,6 +349,16 @@ static ssize_t show_remote_temp8(struct
 		       + data->temp2_offset);
 }
 
+static ssize_t show_lut_temp(struct device *dev,
+			      struct device_attribute *devattr,
+			      char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct lm63_data *data = lm63_update_device(dev);
+	return sprintf(buf, "%d\n", lut_temp_from_reg(data, attr->index)
+		       + data->temp2_offset);
+}
+
 static ssize_t set_temp8(struct device *dev, struct device_attribute *devattr,
 			 const char *buf, size_t count)
 {
@@ -440,6 +466,17 @@ static ssize_t show_temp2_crit_hyst(stru
 		       - TEMP8_FROM_REG(data->temp2_crit_hyst));
 }
 
+static ssize_t show_lut_temp_hyst(struct device *dev,
+				  struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct lm63_data *data = lm63_update_device(dev);
+
+	return sprintf(buf, "%d\n", lut_temp_from_reg(data, attr->index)
+		       + data->temp2_offset
+		       - TEMP8_FROM_REG(data->lut_temp_hyst));
+}
+
 /*
  * And now the other way around, user-space provides an absolute
  * hysteresis value and we have to store a relative one
@@ -574,8 +611,48 @@ static SENSOR_DEVICE_ATTR(fan1_input, S_
 static SENSOR_DEVICE_ATTR(fan1_min, S_IWUSR | S_IRUGO, show_fan,
 	set_fan, 1);
 
-static DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, show_pwm1, set_pwm1);
+static SENSOR_DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, show_pwm1, set_pwm1, 0);
 static DEVICE_ATTR(pwm1_enable, S_IRUGO, show_pwm1_enable, NULL);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point1_pwm, S_IRUGO, show_pwm1, NULL, 1);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point1_temp, S_IRUGO,
+	show_lut_temp, NULL, 3);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point1_temp_hyst, S_IRUGO,
+	show_lut_temp_hyst, NULL, 3);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point2_pwm, S_IRUGO, show_pwm1, NULL, 2);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point2_temp, S_IRUGO,
+	show_lut_temp, NULL, 4);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point2_temp_hyst, S_IRUGO,
+	show_lut_temp_hyst, NULL, 4);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point3_pwm, S_IRUGO, show_pwm1, NULL, 3);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point3_temp, S_IRUGO,
+	show_lut_temp, NULL, 5);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point3_temp_hyst, S_IRUGO,
+	show_lut_temp_hyst, NULL, 5);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point4_pwm, S_IRUGO, show_pwm1, NULL, 4);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point4_temp, S_IRUGO,
+	show_lut_temp, NULL, 6);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point4_temp_hyst, S_IRUGO,
+	show_lut_temp_hyst, NULL, 6);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point5_pwm, S_IRUGO, show_pwm1, NULL, 5);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point5_temp, S_IRUGO,
+	show_lut_temp, NULL, 7);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point5_temp_hyst, S_IRUGO,
+	show_lut_temp_hyst, NULL, 7);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point6_pwm, S_IRUGO, show_pwm1, NULL, 6);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point6_temp, S_IRUGO,
+	show_lut_temp, NULL, 8);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point6_temp_hyst, S_IRUGO,
+	show_lut_temp_hyst, NULL, 8);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point7_pwm, S_IRUGO, show_pwm1, NULL, 7);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point7_temp, S_IRUGO,
+	show_lut_temp, NULL, 9);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point7_temp_hyst, S_IRUGO,
+	show_lut_temp_hyst, NULL, 9);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point8_pwm, S_IRUGO, show_pwm1, NULL, 8);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point8_temp, S_IRUGO,
+	show_lut_temp, NULL, 10);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point8_temp_hyst, S_IRUGO,
+	show_lut_temp_hyst, NULL, 10);
 
 static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_local_temp8, NULL, 0);
 static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_local_temp8,
@@ -609,8 +686,33 @@ static DEVICE_ATTR(update_interval, S_IR
 		   set_update_interval);
 
 static struct attribute *lm63_attributes[] = {
-	&dev_attr_pwm1.attr,
+	&sensor_dev_attr_pwm1.dev_attr.attr,
 	&dev_attr_pwm1_enable.attr,
+	&sensor_dev_attr_pwm1_auto_point1_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point1_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point1_temp_hyst.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point2_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point2_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point2_temp_hyst.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point3_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point3_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point3_temp_hyst.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point4_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point4_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point4_temp_hyst.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point5_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point5_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point5_temp_hyst.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point6_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point6_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point6_temp_hyst.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point7_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point7_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point7_temp_hyst.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point8_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point8_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point8_temp_hyst.dev_attr.attr,
+
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	&sensor_dev_attr_temp2_input.dev_attr.attr,
 	&sensor_dev_attr_temp2_min.dev_attr.attr,
@@ -834,6 +936,8 @@ static void lm63_init_client(struct i2c_
 		u8 config_enhanced
 		  = i2c_smbus_read_byte_data(client,
 					     LM96163_REG_CONFIG_ENHANCED);
+		if (config_enhanced & 0x20)
+			data->lut_temp_highres = true;
 		if ((config_enhanced & 0x10)
 		    && !(data->config_fan & 0x08) && data->pwm1_freq = 8)
 			data->pwm_highres = true;
@@ -872,6 +976,7 @@ static struct lm63_data *lm63_update_dev
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm63_data *data = i2c_get_clientdata(client);
 	unsigned long next_update;
+	int i;
 
 	mutex_lock(&data->update_lock);
 
@@ -895,8 +1000,8 @@ static struct lm63_data *lm63_update_dev
 				  LM63_REG_PWM_FREQ);
 		if (data->pwm1_freq = 0)
 			data->pwm1_freq = 1;
-		data->pwm1_value = i2c_smbus_read_byte_data(client,
-				   LM63_REG_PWM_VALUE);
+		data->pwm1[0] = i2c_smbus_read_byte_data(client,
+				LM63_REG_PWM_VALUE);
 
 		data->temp8[0] = i2c_smbus_read_byte_data(client,
 				 LM63_REG_LOCAL_TEMP);
@@ -939,6 +1044,21 @@ static struct lm63_data *lm63_update_dev
 		data->valid = 1;
 	}
 
+	if (time_after(jiffies, data->lut_last_updated + 5 * HZ) ||
+	    !data->lut_valid) {
+		for (i = 0; i < 8; i++) {
+			data->pwm1[1 + i] = i2c_smbus_read_byte_data(client,
+					    LM63_REG_LUT_PWM(i));
+			data->temp8[3 + i] = i2c_smbus_read_byte_data(client,
+					     LM63_REG_LUT_TEMP(i));
+		}
+		data->lut_temp_hyst = i2c_smbus_read_byte_data(client,
+				      LM63_REG_LUT_TEMP_HYST);
+
+		data->lut_last_updated = jiffies;
+		data->lut_valid = 1;
+	}
+
 	mutex_unlock(&data->update_lock);
 
 	return data;

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
