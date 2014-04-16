From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 16 Apr 2014 02:28:53 +0000
Subject: [lm-sensors] [PATCH 5/6] hwmon: (lm80) Convert fan display function macros into functions
Message-Id: <1397615334-30317-5-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert fan display function macros into functions to reduce
code size and improve code readability.

Code size reduction is about 200 bytes on x86_64.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm80.c |   75 +++++++++++++++++++++++++++-----------------------
 1 file changed, 41 insertions(+), 34 deletions(-)

diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
index ed062ad..debaec3 100644
--- a/drivers/hwmon/lm80.c
+++ b/drivers/hwmon/lm80.c
@@ -116,6 +116,12 @@ enum in_index {
 	i_num_in
 };
 
+enum fan_index {
+	f_input,
+	f_min,
+	f_num_fan
+};
+
 /*
  * Client data (each client gets its own)
  */
@@ -128,8 +134,7 @@ struct lm80_data {
 	unsigned long last_updated;	/* In jiffies */
 
 	u8 in[i_num_in][7];	/* Register value, 1st index is enum in_index */
-	u8 fan[2];		/* Register value */
-	u8 fan_min[2];		/* Register value */
+	u8 fan[f_num_fan][2];	/* Register value, 1st index enum fan_index */
 	u8 fan_div[2];		/* Register encoding, shifted right */
 	s16 temp[t_num_temp];	/* Register values, normalized to 16 bit */
 	u16 alarms;		/* Register encoding, combined */
@@ -207,19 +212,17 @@ static ssize_t set_in(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-#define show_fan(suffix, value) \
-static ssize_t show_fan_##suffix(struct device *dev, \
-	struct device_attribute *attr, char *buf) \
-{ \
-	int nr = to_sensor_dev_attr(attr)->index; \
-	struct lm80_data *data = lm80_update_device(dev); \
-	if (IS_ERR(data)) \
-		return PTR_ERR(data); \
-	return sprintf(buf, "%d\n", FAN_FROM_REG(data->value[nr], \
-		       DIV_FROM_REG(data->fan_div[nr]))); \
+static ssize_t show_fan(struct device *dev, struct device_attribute *attr,
+			char *buf)
+{
+	int index = to_sensor_dev_attr_2(attr)->index;
+	int nr = to_sensor_dev_attr_2(attr)->nr;
+	struct lm80_data *data = lm80_update_device(dev);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[nr][index],
+		       DIV_FROM_REG(data->fan_div[index])));
 }
-show_fan(min, fan_min)
-show_fan(input, fan)
 
 static ssize_t show_fan_div(struct device *dev, struct device_attribute *attr,
 	char *buf)
@@ -234,7 +237,8 @@ static ssize_t show_fan_div(struct device *dev, struct device_attribute *attr,
 static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
 	const char *buf, size_t count)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
+	int index = to_sensor_dev_attr_2(attr)->index;
+	int nr = to_sensor_dev_attr_2(attr)->nr;
 	struct lm80_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
 	unsigned long val;
@@ -243,8 +247,10 @@ static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
 		return err;
 
 	mutex_lock(&data->update_lock);
-	data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
-	lm80_write_value(client, LM80_REG_FAN_MIN(nr + 1), data->fan_min[nr]);
+	data->fan[nr][index] = FAN_TO_REG(val,
+					  DIV_FROM_REG(data->fan_div[index]));
+	lm80_write_value(client, LM80_REG_FAN_MIN(index + 1),
+			 data->fan[nr][index]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -269,7 +275,7 @@ static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
 
 	/* Save fan_min */
 	mutex_lock(&data->update_lock);
-	min = FAN_FROM_REG(data->fan_min[nr],
+	min = FAN_FROM_REG(data->fan[f_min][nr],
 			   DIV_FROM_REG(data->fan_div[nr]));
 
 	switch (val) {
@@ -293,13 +299,14 @@ static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
 		return -EINVAL;
 	}
 
-	reg = (lm80_read_value(client, LM80_REG_FANDIV) & ~(3 << (2 * (nr + 1))))
-	    | (data->fan_div[nr] << (2 * (nr + 1)));
+	reg = (lm80_read_value(client, LM80_REG_FANDIV) &
+	       ~(3 << (2 * (nr + 1)))) | (data->fan_div[nr] << (2 * (nr + 1)));
 	lm80_write_value(client, LM80_REG_FANDIV, reg);
 
 	/* Restore fan_min */
-	data->fan_min[nr] = FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
-	lm80_write_value(client, LM80_REG_FAN_MIN(nr + 1), data->fan_min[nr]);
+	data->fan[f_min][nr] = FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
+	lm80_write_value(client, LM80_REG_FAN_MIN(nr + 1),
+			 data->fan[f_min][nr]);
 	mutex_unlock(&data->update_lock);
 
 	return count;
@@ -388,12 +395,12 @@ static SENSOR_DEVICE_ATTR_2(in3_input, S_IRUGO, show_in, NULL, i_input, 3);
 static SENSOR_DEVICE_ATTR_2(in4_input, S_IRUGO, show_in, NULL, i_input, 4);
 static SENSOR_DEVICE_ATTR_2(in5_input, S_IRUGO, show_in, NULL, i_input, 5);
 static SENSOR_DEVICE_ATTR_2(in6_input, S_IRUGO, show_in, NULL, i_input, 6);
-static SENSOR_DEVICE_ATTR(fan1_min, S_IWUSR | S_IRUGO,
-		show_fan_min, set_fan_min, 0);
-static SENSOR_DEVICE_ATTR(fan2_min, S_IWUSR | S_IRUGO,
-		show_fan_min, set_fan_min, 1);
-static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, show_fan_input, NULL, 0);
-static SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, show_fan_input, NULL, 1);
+static SENSOR_DEVICE_ATTR_2(fan1_min, S_IWUSR | S_IRUGO,
+		show_fan, set_fan_min, f_min, 0);
+static SENSOR_DEVICE_ATTR_2(fan2_min, S_IWUSR | S_IRUGO,
+		show_fan, set_fan_min, f_min, 1);
+static SENSOR_DEVICE_ATTR_2(fan1_input, S_IRUGO, show_fan, NULL, f_input, 0);
+static SENSOR_DEVICE_ATTR_2(fan2_input, S_IRUGO, show_fan, NULL, f_input, 1);
 static SENSOR_DEVICE_ATTR(fan1_div, S_IWUSR | S_IRUGO,
 		show_fan_div, set_fan_div, 0);
 static SENSOR_DEVICE_ATTR(fan2_div, S_IWUSR | S_IRUGO,
@@ -537,8 +544,8 @@ static int lm80_probe(struct i2c_client *client,
 	lm80_init_client(client);
 
 	/* A few vars need to be filled upon startup */
-	data->fan_min[0] = lm80_read_value(client, LM80_REG_FAN_MIN(1));
-	data->fan_min[1] = lm80_read_value(client, LM80_REG_FAN_MIN(2));
+	data->fan[f_min][0] = lm80_read_value(client, LM80_REG_FAN_MIN(1));
+	data->fan[f_min][1] = lm80_read_value(client, LM80_REG_FAN_MIN(2));
 
 	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
 							   data, lm80_groups);
@@ -608,22 +615,22 @@ static struct lm80_data *lm80_update_device(struct device *dev)
 		rv = lm80_read_value(client, LM80_REG_FAN1);
 		if (rv < 0)
 			goto abort;
-		data->fan[0] = rv;
+		data->fan[f_input][0] = rv;
 
 		rv = lm80_read_value(client, LM80_REG_FAN_MIN(1));
 		if (rv < 0)
 			goto abort;
-		data->fan_min[0] = rv;
+		data->fan[f_min][0] = rv;
 
 		rv = lm80_read_value(client, LM80_REG_FAN2);
 		if (rv < 0)
 			goto abort;
-		data->fan[1] = rv;
+		data->fan[f_input][1] = rv;
 
 		rv = lm80_read_value(client, LM80_REG_FAN_MIN(2));
 		if (rv < 0)
 			goto abort;
-		data->fan_min[1] = rv;
+		data->fan[f_min][1] = rv;
 
 		prev_rv = rv = lm80_read_value(client, LM80_REG_TEMP);
 		if (rv < 0)
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
