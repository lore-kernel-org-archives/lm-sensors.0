From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 21 Apr 2014 03:36:39 +0000
Subject: [lm-sensors] [PATCH v2 4/5] hwmon: (max1619) Drop function macros
Message-Id: <20140421033639.GA16522@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Function macros make the code larger and difficult ro read.
Drop them and reduce code size (on x86_64) by ~1800 bytes.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Remove comma after t_num_regs.
    Declare register arrays as const and with explicit size.

 drivers/hwmon/max1619.c |  141 ++++++++++++++++++++++++-----------------------
 1 file changed, 73 insertions(+), 68 deletions(-)

diff --git a/drivers/hwmon/max1619.c b/drivers/hwmon/max1619.c
index c8a7297..4125128 100644
--- a/drivers/hwmon/max1619.c
+++ b/drivers/hwmon/max1619.c
@@ -71,6 +71,16 @@ static int temp_to_reg(int val)
 	return (val < 0 ? val+0x100*1000 : val) / 1000;
 }
 
+enum temp_index {
+	t_input1 = 0,
+	t_input2,
+	t_low2,
+	t_high2,
+	t_crit2,
+	t_hyst2,
+	t_num_regs
+};
+
 /*
  * Client data (each client gets its own)
  */
@@ -82,35 +92,39 @@ struct max1619_data {
 	unsigned long last_updated; /* in jiffies */
 
 	/* registers values */
-	u8 temp_input1; /* local */
-	u8 temp_input2, temp_low2, temp_high2; /* remote */
-	u8 temp_crit2;
-	u8 temp_hyst2;
+	u8 temp[t_num_regs];	/* index with enum temp_index */
 	u8 alarms;
 };
 
+static const u8 regs_read[t_num_regs] = {
+	[t_input1] = MAX1619_REG_R_LOCAL_TEMP,
+	[t_input2] = MAX1619_REG_R_REMOTE_TEMP,
+	[t_low2] = MAX1619_REG_R_REMOTE_LOW,
+	[t_high2] = MAX1619_REG_R_REMOTE_HIGH,
+	[t_crit2] = MAX1619_REG_R_REMOTE_CRIT,
+	[t_hyst2] = MAX1619_REG_R_TCRIT_HYST,
+};
+
+static const u8 regs_write[t_num_regs] = {
+	[t_low2] = MAX1619_REG_W_REMOTE_LOW,
+	[t_high2] = MAX1619_REG_W_REMOTE_HIGH,
+	[t_crit2] = MAX1619_REG_W_REMOTE_CRIT,
+	[t_hyst2] = MAX1619_REG_W_TCRIT_HYST,
+};
+
 static struct max1619_data *max1619_update_device(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct max1619_data *data = i2c_get_clientdata(client);
-	int config;
+	int config, i;
 
 	mutex_lock(&data->update_lock);
 
 	if (time_after(jiffies, data->last_updated + HZ * 2) || !data->valid) {
 		dev_dbg(&client->dev, "Updating max1619 data.\n");
-		data->temp_input1 = i2c_smbus_read_byte_data(client,
-					MAX1619_REG_R_LOCAL_TEMP);
-		data->temp_input2 = i2c_smbus_read_byte_data(client,
-					MAX1619_REG_R_REMOTE_TEMP);
-		data->temp_high2 = i2c_smbus_read_byte_data(client,
-					MAX1619_REG_R_REMOTE_HIGH);
-		data->temp_low2 = i2c_smbus_read_byte_data(client,
-					MAX1619_REG_R_REMOTE_LOW);
-		data->temp_crit2 = i2c_smbus_read_byte_data(client,
-					MAX1619_REG_R_REMOTE_CRIT);
-		data->temp_hyst2 = i2c_smbus_read_byte_data(client,
-					MAX1619_REG_R_TCRIT_HYST);
+		for (i = 0; i < t_num_regs; i++)
+			data->temp[i] = i2c_smbus_read_byte_data(client,
+					regs_read[i]);
 		data->alarms = i2c_smbus_read_byte_data(client,
 					MAX1619_REG_R_STATUS);
 		/* If OVERT polarity is low, reverse alarm bit */
@@ -131,43 +145,33 @@ static struct max1619_data *max1619_update_device(struct device *dev)
  * Sysfs stuff
  */
 
-#define show_temp(value) \
-static ssize_t show_##value(struct device *dev, struct device_attribute *attr, \
-			    char *buf) \
-{ \
-	struct max1619_data *data = max1619_update_device(dev); \
-	return sprintf(buf, "%d\n", temp_from_reg(data->value)); \
-}
-show_temp(temp_input1);
-show_temp(temp_input2);
-show_temp(temp_low2);
-show_temp(temp_high2);
-show_temp(temp_crit2);
-show_temp(temp_hyst2);
-
-#define set_temp2(value, reg) \
-static ssize_t set_##value(struct device *dev, struct device_attribute *attr, \
-			   const char *buf, \
-	size_t count) \
-{ \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct max1619_data *data = i2c_get_clientdata(client); \
-	long val; \
-	int err = kstrtol(buf, 10, &val); \
-	if (err) \
-		return err; \
-\
-	mutex_lock(&data->update_lock); \
-	data->value = temp_to_reg(val); \
-	i2c_smbus_write_byte_data(client, reg, data->value); \
-	mutex_unlock(&data->update_lock); \
-	return count; \
+static ssize_t show_temp(struct device *dev, struct device_attribute *devattr,
+			 char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct max1619_data *data = max1619_update_device(dev);
+
+	return sprintf(buf, "%d\n", temp_from_reg(data->temp[attr->index]));
 }
 
-set_temp2(temp_low2, MAX1619_REG_W_REMOTE_LOW);
-set_temp2(temp_high2, MAX1619_REG_W_REMOTE_HIGH);
-set_temp2(temp_crit2, MAX1619_REG_W_REMOTE_CRIT);
-set_temp2(temp_hyst2, MAX1619_REG_W_TCRIT_HYST);
+static ssize_t set_temp(struct device *dev, struct device_attribute *devattr,
+			   const char *buf, size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct max1619_data *data = i2c_get_clientdata(client);
+	long val;
+	int err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
+
+	mutex_lock(&data->update_lock);
+	data->temp[attr->index] = temp_to_reg(val);
+	i2c_smbus_write_byte_data(client, regs_write[attr->index],
+				  data->temp[attr->index]);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
 
 static ssize_t show_alarms(struct device *dev, struct device_attribute *attr,
 			   char *buf)
@@ -184,16 +188,17 @@ static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "%d\n", (data->alarms >> bitnr) & 1);
 }
 
-static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input1, NULL);
-static DEVICE_ATTR(temp2_input, S_IRUGO, show_temp_input2, NULL);
-static DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_temp_low2,
-	set_temp_low2);
-static DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_temp_high2,
-	set_temp_high2);
-static DEVICE_ATTR(temp2_crit, S_IWUSR | S_IRUGO, show_temp_crit2,
-	set_temp_crit2);
-static DEVICE_ATTR(temp2_crit_hyst, S_IWUSR | S_IRUGO, show_temp_hyst2,
-	set_temp_hyst2);
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, t_input1);
+static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, t_input2);
+static SENSOR_DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_temp, set_temp,
+			  t_low2);
+static SENSOR_DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_temp, set_temp,
+			  t_high2);
+static SENSOR_DEVICE_ATTR(temp2_crit, S_IWUSR | S_IRUGO, show_temp, set_temp,
+			  t_crit2);
+static SENSOR_DEVICE_ATTR(temp2_crit_hyst, S_IWUSR | S_IRUGO, show_temp,
+			  set_temp, t_hyst2);
+
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 static SENSOR_DEVICE_ATTR(temp2_crit_alarm, S_IRUGO, show_alarm, NULL, 1);
 static SENSOR_DEVICE_ATTR(temp2_fault, S_IRUGO, show_alarm, NULL, 2);
@@ -201,12 +206,12 @@ static SENSOR_DEVICE_ATTR(temp2_min_alarm, S_IRUGO, show_alarm, NULL, 3);
 static SENSOR_DEVICE_ATTR(temp2_max_alarm, S_IRUGO, show_alarm, NULL, 4);
 
 static struct attribute *max1619_attributes[] = {
-	&dev_attr_temp1_input.attr,
-	&dev_attr_temp2_input.attr,
-	&dev_attr_temp2_min.attr,
-	&dev_attr_temp2_max.attr,
-	&dev_attr_temp2_crit.attr,
-	&dev_attr_temp2_crit_hyst.attr,
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp2_input.dev_attr.attr,
+	&sensor_dev_attr_temp2_min.dev_attr.attr,
+	&sensor_dev_attr_temp2_max.dev_attr.attr,
+	&sensor_dev_attr_temp2_crit.dev_attr.attr,
+	&sensor_dev_attr_temp2_crit_hyst.dev_attr.attr,
 
 	&dev_attr_alarms.attr,
 	&sensor_dev_attr_temp2_crit_alarm.dev_attr.attr,
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
