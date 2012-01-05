From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Thu, 05 Jan 2012 13:41:53 +0000
Subject: [lm-sensors] [PATCH v2 1/2] lm80.c: add error handling
Message-Id: <1325770914-23620-1-git-send-email-fransmeulenbroeks@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
---

Tested with actual system

 drivers/hwmon/lm80.c |  132 ++++++++++++++++++++++++++++++++++++++------------
 1 files changed, 101 insertions(+), 31 deletions(-)

diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
index 0891b38..616f470 100644
--- a/drivers/hwmon/lm80.c
+++ b/drivers/hwmon/lm80.c
@@ -170,6 +170,8 @@ static ssize_t show_in_##suffix(struct device *dev, \
 { \
 	int nr = to_sensor_dev_attr(attr)->index; \
 	struct lm80_data *data = lm80_update_device(dev); \
+	if (IS_ERR(data)) \
+		return PTR_ERR(data); \
 	return sprintf(buf, "%d\n", IN_FROM_REG(data->value[nr])); \
 }
 show_in(min, in_min)
@@ -200,6 +202,8 @@ static ssize_t show_fan_##suffix(struct device *dev, \
 { \
 	int nr = to_sensor_dev_attr(attr)->index; \
 	struct lm80_data *data = lm80_update_device(dev); \
+	if (IS_ERR(data)) \
+		return PTR_ERR(data); \
 	return sprintf(buf, "%d\n", FAN_FROM_REG(data->value[nr], \
 		       DIV_FROM_REG(data->fan_div[nr]))); \
 }
@@ -211,6 +215,8 @@ static ssize_t show_fan_div(struct device *dev, struct device_attribute *attr,
 {
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm80_data *data = lm80_update_device(dev);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
 	return sprintf(buf, "%d\n", DIV_FROM_REG(data->fan_div[nr]));
 }
 
@@ -283,6 +289,8 @@ static ssize_t show_temp_input1(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	struct lm80_data *data = lm80_update_device(dev);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
 	return sprintf(buf, "%ld\n", TEMP_FROM_REG(data->temp));
 }
 
@@ -291,6 +299,8 @@ static ssize_t show_temp_##suffix(struct device *dev, \
 	struct device_attribute *attr, char *buf) \
 { \
 	struct lm80_data *data = lm80_update_device(dev); \
+	if (IS_ERR(data)) \
+		return PTR_ERR(data); \
 	return sprintf(buf, "%d\n", TEMP_LIMIT_FROM_REG(data->value)); \
 }
 show_temp(hot_max, temp_hot_max);
@@ -321,6 +331,8 @@ static ssize_t show_alarms(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
 	struct lm80_data *data = lm80_update_device(dev);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
 	return sprintf(buf, "%u\n", data->alarms);
 }
 
@@ -329,6 +341,8 @@ static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
 {
 	int bitnr = to_sensor_dev_attr(attr)->index;
 	struct lm80_data *data = lm80_update_device(dev);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
 	return sprintf(buf, "%u\n", (data->alarms >> bitnr) & 1);
 }
 
@@ -563,50 +577,106 @@ static struct lm80_data *lm80_update_device(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm80_data *data = i2c_get_clientdata(client);
 	int i;
+	int rv;
+	int prev_rv;
+	struct lm80_data *ret = data;
 
 	mutex_lock(&data->update_lock);
 
 	if (time_after(jiffies, data->last_updated + 2 * HZ) || !data->valid) {
 		dev_dbg(&client->dev, "Starting lm80 update\n");
 		for (i = 0; i <= 6; i++) {
-			data->in[i] -			    lm80_read_value(client, LM80_REG_IN(i));
-			data->in_min[i] -			    lm80_read_value(client, LM80_REG_IN_MIN(i));
-			data->in_max[i] -			    lm80_read_value(client, LM80_REG_IN_MAX(i));
+			rv = lm80_read_value(client, LM80_REG_IN(i));
+			if (rv < 0)
+				goto abort;
+			data->in[i] = rv;
+
+			rv = lm80_read_value(client, LM80_REG_IN_MIN(i));
+			if (rv < 0)
+				goto abort;
+			data->in_min[i] = rv;
+
+			rv = lm80_read_value(client, LM80_REG_IN_MAX(i));
+			if (rv < 0)
+				goto abort;
+			data->in_max[i] = rv;
 		}
-		data->fan[0] = lm80_read_value(client, LM80_REG_FAN1);
-		data->fan_min[0] -		    lm80_read_value(client, LM80_REG_FAN_MIN(1));
-		data->fan[1] = lm80_read_value(client, LM80_REG_FAN2);
-		data->fan_min[1] -		    lm80_read_value(client, LM80_REG_FAN_MIN(2));
-
-		data->temp -		    (lm80_read_value(client, LM80_REG_TEMP) << 8) |
-		    (lm80_read_value(client, LM80_REG_RES) & 0xf0);
-		data->temp_os_max -		    lm80_read_value(client, LM80_REG_TEMP_OS_MAX);
-		data->temp_os_hyst -		    lm80_read_value(client, LM80_REG_TEMP_OS_HYST);
-		data->temp_hot_max -		    lm80_read_value(client, LM80_REG_TEMP_HOT_MAX);
-		data->temp_hot_hyst -		    lm80_read_value(client, LM80_REG_TEMP_HOT_HYST);
-
-		i = lm80_read_value(client, LM80_REG_FANDIV);
-		data->fan_div[0] = (i >> 2) & 0x03;
-		data->fan_div[1] = (i >> 4) & 0x03;
-		data->alarms = lm80_read_value(client, LM80_REG_ALARM1) +
-		    (lm80_read_value(client, LM80_REG_ALARM2) << 8);
+
+		rv = lm80_read_value(client, LM80_REG_FAN1);
+		if (rv < 0)
+			goto abort;
+		data->fan[0] = rv;
+
+		rv = lm80_read_value(client, LM80_REG_FAN_MIN(1));
+		if (rv < 0)
+			goto abort;
+		data->fan_min[0] = rv;
+
+		rv = lm80_read_value(client, LM80_REG_FAN2);
+		if (rv < 0)
+			goto abort;
+		data->fan[1] = rv;
+
+		rv = lm80_read_value(client, LM80_REG_FAN_MIN(2));
+		if (rv < 0)
+			goto abort;
+		data->fan_min[1] = rv;
+
+		prev_rv = rv = lm80_read_value(client, LM80_REG_TEMP);
+		if (rv < 0)
+			goto abort;
+		rv = lm80_read_value(client, LM80_REG_RES);
+		if (rv < 0)
+			goto abort;
+		data->temp = (prev_rv << 8) | (rv & 0xf0);
+
+		rv = lm80_read_value(client, LM80_REG_TEMP_OS_MAX);
+		if (rv < 0)
+			goto abort;
+		data->temp_os_max = rv;
+
+		rv = lm80_read_value(client, LM80_REG_TEMP_OS_HYST);
+		if (rv < 0)
+			goto abort;
+		data->temp_os_hyst = rv;
+
+		rv = lm80_read_value(client, LM80_REG_TEMP_HOT_MAX);
+		if (rv < 0)
+			goto abort;
+		data->temp_hot_max = rv;
+
+		rv = lm80_read_value(client, LM80_REG_TEMP_HOT_HYST);
+		if (rv < 0)
+			goto abort;
+		data->temp_hot_hyst = rv;
+
+		rv = lm80_read_value(client, LM80_REG_FANDIV);
+		if (rv < 0)
+			goto abort;
+		data->fan_div[0] = (rv >> 2) & 0x03;
+		data->fan_div[1] = (rv >> 4) & 0x03;
+
+		prev_rv = rv = lm80_read_value(client, LM80_REG_ALARM1);
+		if (rv < 0)
+			goto abort;
+		rv = lm80_read_value(client, LM80_REG_ALARM2);
+		if (rv < 0)
+			goto abort;
+		data->alarms = prev_rv + (rv << 8);
+
 		data->last_updated = jiffies;
 		data->valid = 1;
 	}
+	goto done;
+
+abort:
+	ret = ERR_PTR(rv);
+	data->valid = 0;
 
+done:
 	mutex_unlock(&data->update_lock);
 
-	return data;
+	return ret;
 }
 
 static int __init sensors_lm80_init(void)
-- 
1.7.0.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
