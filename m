From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 10 Jan 2012 19:23:50 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: (lm63) Add support for writing the
Message-Id: <1326223430-3297-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On LM64, the external critical temperature limit is always writable. On LM96163,
it is writable if the chip is configured for it. Add conditional support for
writing the register dependent on chip type and configuration.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm63.c |   55 ++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
index 24a96f8..a9e6212 100644
--- a/drivers/hwmon/lm63.c
+++ b/drivers/hwmon/lm63.c
@@ -117,6 +117,9 @@ static const unsigned short normal_i2c[] = { 0x18, 0x4c, 0x4e, I2C_CLIENT_END };
 				 (val) >= 127000 ? 127 : \
 				 (val) < 0 ? ((val) - 500) / 1000 : \
 				 ((val) + 500) / 1000)
+#define TEMP8U_TO_REG(val)	((val) <= 0 ? 0 : \
+				 (val) >= 255000 ? 255 : \
+				 ((val) + 500) / 1000)
 #define TEMP11_FROM_REG(reg)	((reg) / 32 * 125)
 #define TEMP11_TO_REG(val)	((val) <= -128000 ? 0x8000 : \
 				 (val) >= 127875 ? 0x7FE0 : \
@@ -313,22 +316,33 @@ static ssize_t show_remote_temp8(struct device *dev,
 		       + data->temp2_offset);
 }
 
-static ssize_t set_local_temp8(struct device *dev,
-			       struct device_attribute *dummy,
-			       const char *buf, size_t count)
+static ssize_t set_temp8(struct device *dev, struct device_attribute *devattr,
+			 const char *buf, size_t count)
 {
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm63_data *data = i2c_get_clientdata(client);
+	int nr = attr->index;
+	int reg = nr = 2 ? LM63_REG_REMOTE_TCRIT : LM63_REG_LOCAL_HIGH;
 	long val;
 	int err;
+	int temp;
 
 	err = kstrtol(buf, 10, &val);
 	if (err)
 		return err;
 
 	mutex_lock(&data->update_lock);
-	data->temp8[1] = TEMP8_TO_REG(val);
-	i2c_smbus_write_byte_data(client, LM63_REG_LOCAL_HIGH, data->temp8[1]);
+	if (nr = 2) {
+		if (data->remote_unsigned)
+			temp = TEMP8U_TO_REG(val - data->temp2_offset);
+		else
+			temp = TEMP8_TO_REG(val - data->temp2_offset);
+	} else {
+		temp = TEMP8_TO_REG(val);
+	}
+	data->temp8[nr] = temp;
+	i2c_smbus_write_byte_data(client, reg, temp);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -461,7 +475,7 @@ static DEVICE_ATTR(pwm1_enable, S_IRUGO, show_pwm1_enable, NULL);
 
 static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_local_temp8, NULL, 0);
 static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_local_temp8,
-	set_local_temp8, 1);
+	set_temp8, 1);
 
 static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp11, NULL, 0);
 static SENSOR_DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_temp11,
@@ -470,12 +484,8 @@ static SENSOR_DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_temp11,
 	set_temp11, 2);
 static SENSOR_DEVICE_ATTR(temp2_offset, S_IWUSR | S_IRUGO, show_temp11,
 	set_temp11, 3);
-/*
- * On LM63, temp2_crit can be set only once, which should be job
- * of the bootloader.
- */
 static SENSOR_DEVICE_ATTR(temp2_crit, S_IRUGO, show_remote_temp8,
-	NULL, 2);
+	set_temp8, 2);
 static DEVICE_ATTR(temp2_crit_hyst, S_IWUSR | S_IRUGO, show_temp2_crit_hyst,
 	set_temp2_crit_hyst);
 
@@ -510,7 +520,30 @@ static struct attribute *lm63_attributes[] = {
 	NULL
 };
 
+/*
+ * On LM63, temp2_crit can be set only once, which should be job
+ * of the bootloader.
+ * On LM64, temp2_crit can always be set.
+ * On LM96163, temp2_crit can be set if bit 1 of the configuration
+ * register is true.
+ */
+static umode_t lm63_attribute_mode(struct kobject *kobj,
+				   struct attribute *attr, int index)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm63_data *data = i2c_get_clientdata(client);
+
+	if (attr = &sensor_dev_attr_temp2_crit.dev_attr.attr
+	    && (data->kind = lm64 ||
+		(data->kind = lm96163 && (data->config & 0x02))))
+		return attr->mode | S_IWUSR;
+
+	return attr->mode;
+}
+
 static const struct attribute_group lm63_group = {
+	.is_visible = lm63_attribute_mode,
 	.attrs = lm63_attributes,
 };
 
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
