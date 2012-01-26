From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 26 Jan 2012 20:54:36 +0000
Subject: [lm-sensors] [PATCH 2/3] hwmon: (lm63) Make fan speed control strategy changeable
Message-Id: <20120126215436.515a0e67@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Let the user switch between automatic and manual fan speed control.
Before switching to automatic fan speed control, we always check that
the lookup table looks sane.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/lm63.c |  105 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 89 insertions(+), 16 deletions(-)

--- linux-3.3-rc1.orig/drivers/hwmon/lm63.c	2012-01-26 15:48:42.000000000 +0100
+++ linux-3.3-rc1/drivers/hwmon/lm63.c	2012-01-26 21:19:29.830162982 +0100
@@ -205,12 +205,36 @@ static inline int lut_temp_from_reg(stru
 	return data->temp8[nr] * (data->lut_temp_highres ? 500 : 1000);
 }
 
+/*
+ * Update the lookup table register cache.
+ * client->update_lock must be held when calling this function.
+ */
+static void lm63_update_lut(struct i2c_client *client)
+{
+	struct lm63_data *data = i2c_get_clientdata(client);
+	int i;
+
+	if (time_after(jiffies, data->lut_last_updated + 5 * HZ) ||
+	    !data->lut_valid) {
+		for (i = 0; i < data->lut_size; i++) {
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
+}
+
 static struct lm63_data *lm63_update_device(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm63_data *data = i2c_get_clientdata(client);
 	unsigned long next_update;
-	int i;
 
 	mutex_lock(&data->update_lock);
 
@@ -278,20 +302,7 @@ static struct lm63_data *lm63_update_dev
 		data->valid = 1;
 	}
 
-	if (time_after(jiffies, data->lut_last_updated + 5 * HZ) ||
-	    !data->lut_valid) {
-		for (i = 0; i < data->lut_size; i++) {
-			data->pwm1[1 + i] = i2c_smbus_read_byte_data(client,
-					    LM63_REG_LUT_PWM(i));
-			data->temp8[3 + i] = i2c_smbus_read_byte_data(client,
-					     LM63_REG_LUT_TEMP(i));
-		}
-		data->lut_temp_hyst = i2c_smbus_read_byte_data(client,
-				      LM63_REG_LUT_TEMP_HYST);
-
-		data->lut_last_updated = jiffies;
-		data->lut_valid = 1;
-	}
+	lm63_update_lut(client);
 
 	mutex_unlock(&data->update_lock);
 
@@ -299,6 +310,32 @@ static struct lm63_data *lm63_update_dev
 }
 
 /*
+ * Trip points in the lookup table should be in ascending order for both
+ * temperatures and PWM output values.
+ */
+static int lm63_lut_looks_bad(struct i2c_client *client)
+{
+	struct lm63_data *data = i2c_get_clientdata(client);
+	int i;
+
+	mutex_lock(&data->update_lock);
+	lm63_update_lut(client);
+
+	for (i = 1; i < data->lut_size; i++) {
+		if (data->pwm1[1 + i - 1] > data->pwm1[1 + i]
+		 || data->temp8[3 + i - 1] > data->temp8[3 + i]) {
+			dev_warn(&client->dev,
+				 "Lookup table doesn't look sane (check entries %d and %d)\n",
+				 i, i + 1);
+			break;
+		}
+	}
+	mutex_unlock(&data->update_lock);
+
+	return i = data->lut_size ? 0 : 1;
+}
+
+/*
  * Sysfs callback functions and files
  */
 
@@ -381,6 +418,41 @@ static ssize_t show_pwm1_enable(struct d
 	return sprintf(buf, "%d\n", data->config_fan & 0x20 ? 1 : 2);
 }
 
+static ssize_t set_pwm1_enable(struct device *dev,
+			       struct device_attribute *dummy,
+			       const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm63_data *data = i2c_get_clientdata(client);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+	if (val < 1 || val > 2)
+		return -EINVAL;
+
+	/*
+	 * Only let the user switch to automatic mode if the lookup table
+	 * looks sane.
+	 */
+	if (val = 2 && lm63_lut_looks_bad(client))
+		return -EPERM;
+
+	mutex_lock(&data->update_lock);
+	data->config_fan = i2c_smbus_read_byte_data(client,
+						    LM63_REG_CONFIG_FAN);
+	if (val = 1)
+		data->config_fan |= 0x20;
+	else
+		data->config_fan &= ~0x20;
+	i2c_smbus_write_byte_data(client, LM63_REG_CONFIG_FAN,
+	data->config_fan);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
 /*
  * There are 8bit registers for both local(temp1) and remote(temp2) sensor.
  * For remote sensor registers temp2_offset has to be considered,
@@ -669,7 +741,8 @@ static SENSOR_DEVICE_ATTR(fan1_min, S_IW
 	set_fan, 1);
 
 static SENSOR_DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, show_pwm1, set_pwm1, 0);
-static DEVICE_ATTR(pwm1_enable, S_IRUGO, show_pwm1_enable, NULL);
+static DEVICE_ATTR(pwm1_enable, S_IWUSR | S_IRUGO,
+	show_pwm1_enable, set_pwm1_enable);
 static SENSOR_DEVICE_ATTR(pwm1_auto_point1_pwm, S_IRUGO, show_pwm1, NULL, 1);
 static SENSOR_DEVICE_ATTR(pwm1_auto_point1_temp, S_IRUGO,
 	show_lut_temp, NULL, 3);

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
