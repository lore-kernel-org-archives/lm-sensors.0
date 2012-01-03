From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Tue, 03 Jan 2012 11:02:40 +0000
Subject: [lm-sensors] [PATCH 1/2] drivers/hwmon/lm75.c: added error handling
Message-Id: <1325588561-31073-1-git-send-email-fransmeulenbroeks@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

added error handling so if lm75_update_device fails
an error is returned when reading the value through sysfs
This is closely modeled after the way this is handled in ltc4261

Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
---
 drivers/hwmon/lm75.c |   23 ++++++++++++++++-------
 1 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index 1888dd0..903f229 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -93,6 +93,10 @@ static ssize_t show_temp(struct device *dev, struct device_attribute *da,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct lm75_data *data = lm75_update_device(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	return sprintf(buf, "%d\n",
 		       LM75_TEMP_FROM_REG(data->temp[attr->index]));
 }
@@ -402,6 +406,7 @@ static struct lm75_data *lm75_update_device(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm75_data *data = i2c_get_clientdata(client);
+	struct lm75_data *ret = data;
 
 	mutex_lock(&data->update_lock);
 
@@ -414,19 +419,23 @@ static struct lm75_data *lm75_update_device(struct device *dev)
 			int status;
 
 			status = lm75_read_value(client, LM75_REG_TEMP[i]);
-			if (status < 0)
-				dev_dbg(&client->dev, "reg %d, err %d\n",
-						LM75_REG_TEMP[i], status);
-			else
-				data->temp[i] = status;
+			if (unlikely(status < 0)) {
+				dev_dbg(dev,
+					"LM75: Failed to read value: reg %d, error %d\n",
+					LM75_REG_TEMP[i], status);
+				ret = ERR_PTR(status);
+				data->valid = 0;
+				goto abort;
+			}
+			data->temp[i] = status;
 		}
 		data->last_updated = jiffies;
 		data->valid = 1;
 	}
 
+abort:
 	mutex_unlock(&data->update_lock);
-
-	return data;
+	return ret;
 }
 
 /*-----------------------------------------------------------------------*/
-- 
1.7.0.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
