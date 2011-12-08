From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 08 Dec 2011 18:31:06 +0000
Subject: [lm-sensors] [PATCH 1/4] hwmon: (f75375s) Fix checkpatch errors and
Message-Id: <1323369069-26203-2-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Clean up driver to follow current coding style.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/f75375s.c |   86 +++++++++++++++++++++++++++++++++++++----------
 1 files changed, 68 insertions(+), 18 deletions(-)

diff --git a/drivers/hwmon/f75375s.c b/drivers/hwmon/f75375s.c
index 95cbfb3..92b939b 100644
--- a/drivers/hwmon/f75375s.c
+++ b/drivers/hwmon/f75375s.c
@@ -6,7 +6,7 @@
  * Datasheets available at:
  *
  * f75375:
- * http://www.fintek.com.tw/files/productfiles/F75375_V026P.pdf 
+ * http://www.fintek.com.tw/files/productfiles/F75375_V026P.pdf
  *
  * f75373:
  * http://www.fintek.com.tw/files/productfiles/F75373_V025P.pdf
@@ -146,8 +146,8 @@ static inline int f75375_read8(struct i2c_client *client, u8 reg)
 /* in most cases, should be called while holding update_lock */
 static inline u16 f75375_read16(struct i2c_client *client, u8 reg)
 {
-	return ((i2c_smbus_read_byte_data(client, reg) << 8)
-		| i2c_smbus_read_byte_data(client, reg + 1));
+	return (i2c_smbus_read_byte_data(client, reg) << 8)
+		| i2c_smbus_read_byte_data(client, reg + 1);
 }
 
 static inline void f75375_write8(struct i2c_client *client, u8 reg,
@@ -226,14 +226,14 @@ static inline u16 rpm_from_reg(u16 reg)
 {
 	if (reg = 0 || reg = 0xffff)
 		return 0;
-	return (1500000 / reg);
+	return 1500000 / reg;
 }
 
 static inline u16 rpm_to_reg(int rpm)
 {
 	if (rpm < 367 || rpm > 0xffff)
 		return 0xffff;
-	return (1500000 / rpm);
+	return 1500000 / rpm;
 }
 
 static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
@@ -242,7 +242,12 @@ static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct f75375_data *data = i2c_get_clientdata(client);
-	int val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err < 0)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->fan_min[nr] = rpm_to_reg(val);
@@ -257,7 +262,12 @@ static ssize_t set_fan_exp(struct device *dev, struct device_attribute *attr,
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct f75375_data *data = i2c_get_clientdata(client);
-	int val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err < 0)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->fan_exp[nr] = rpm_to_reg(val);
@@ -272,7 +282,12 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct f75375_data *data = i2c_get_clientdata(client);
-	int val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err < 0)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->pwm[nr] = SENSORS_LIMIT(val, 0, 255);
@@ -327,8 +342,12 @@ static ssize_t set_pwm_enable(struct device *dev, struct device_attribute *attr,
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct f75375_data *data = i2c_get_clientdata(client);
-	int val = simple_strtoul(buf, NULL, 10);
-	int err = 0;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err < 0)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	err = set_pwm_enable_direct(client, nr, val);
@@ -342,8 +361,13 @@ static ssize_t set_pwm_mode(struct device *dev, struct device_attribute *attr,
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct f75375_data *data = i2c_get_clientdata(client);
-	int val = simple_strtoul(buf, NULL, 10);
-	u8 conf = 0;
+	unsigned long val;
+	int err;
+	u8 conf;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err < 0)
+		return err;
 
 	if (!(val = 0 || val = 1))
 		return -EINVAL;
@@ -410,7 +434,13 @@ static ssize_t set_in_max(struct device *dev, struct device_attribute *attr,
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct f75375_data *data = i2c_get_clientdata(client);
-	int val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err < 0)
+		return err;
+
 	val = SENSORS_LIMIT(VOLT_TO_REG(val), 0, 0xff);
 	mutex_lock(&data->update_lock);
 	data->in_max[nr] = val;
@@ -425,7 +455,13 @@ static ssize_t set_in_min(struct device *dev, struct device_attribute *attr,
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct f75375_data *data = i2c_get_clientdata(client);
-	int val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err < 0)
+		return err;
+
 	val = SENSORS_LIMIT(VOLT_TO_REG(val), 0, 0xff);
 	mutex_lock(&data->update_lock);
 	data->in_min[nr] = val;
@@ -466,7 +502,13 @@ static ssize_t set_temp_max(struct device *dev, struct device_attribute *attr,
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct f75375_data *data = i2c_get_clientdata(client);
-	int val = simple_strtol(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err < 0)
+		return err;
+
 	val = SENSORS_LIMIT(TEMP_TO_REG(val), 0, 127);
 	mutex_lock(&data->update_lock);
 	data->temp_high[nr] = val;
@@ -481,7 +523,13 @@ static ssize_t set_temp_max_hyst(struct device *dev,
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct f75375_data *data = i2c_get_clientdata(client);
-	int val = simple_strtol(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err < 0)
+		return err;
+
 	val = SENSORS_LIMIT(TEMP_TO_REG(val), 0, 127);
 	mutex_lock(&data->update_lock);
 	data->temp_max_hyst[nr] = val;
@@ -624,14 +672,16 @@ static int f75375_probe(struct i2c_client *client,
 	if (!i2c_check_functionality(client->adapter,
 				I2C_FUNC_SMBUS_BYTE_DATA))
 		return -EIO;
-	if (!(data = kzalloc(sizeof(struct f75375_data), GFP_KERNEL)))
+	data = kzalloc(sizeof(struct f75375_data), GFP_KERNEL);
+	if (!data)
 		return -ENOMEM;
 
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
 	data->kind = id->driver_data;
 
-	if ((err = sysfs_create_group(&client->dev.kobj, &f75375_group)))
+	err = sysfs_create_group(&client->dev.kobj, &f75375_group);
+	if (err)
 		goto exit_free;
 
 	if (data->kind = f75375) {
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
