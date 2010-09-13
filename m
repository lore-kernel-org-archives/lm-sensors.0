From: Shubhrajyoti D <shubhrajyoti@ti.com>
Date: Mon, 13 Sep 2010 14:19:47 +0000
Subject: [lm-sensors] [RFC PATCH] Allow the configuration register to be
Message-Id: <1284386867-21650-1-git-send-email-shubhrajyoti@ti.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The patch intends to allow the configuration of resolution
polarity etc.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/hwmon/lm75.c |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index 2a5b12a..abf3135 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -111,7 +111,41 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *da,
 	mutex_unlock(&data->update_lock);
 	return count;
 }
+static ssize_t set_configuration(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	s32 status;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm75_data *data = i2c_get_clientdata(client);
+	unsigned long temp;
+	int error;
+	error = strict_strtol(buf, 10, &temp);
+	if (error)
+		return error;
+
+	data->orig_conf = (u8)temp;
+	/* I2C write to the configuration register */
+	status = lm75_write_value(client, LM75_REG_CONF,
+			data->orig_conf);
+	return count;
+}
+
+static ssize_t show_configuration(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int status = lm75_read_value(client, LM75_REG_CONF);
+	if (status < 0) {
+		dev_dbg(&client->dev, "Can't read config? %d\n", status);
+		return status;
+	}
+
+	return sprintf(buf, "%u\n", status);
+}
 
+static SENSOR_DEVICE_ATTR(configuration, S_IWUSR | S_IRUGO,
+			show_configuration, set_configuration, 0);
 static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO,
 			show_temp, set_temp, 1);
 static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO,
@@ -122,6 +156,7 @@ static struct attribute *lm75_attributes[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	&sensor_dev_attr_temp1_max.dev_attr.attr,
 	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
+	&sensor_dev_attr_configuration.dev_attr.attr,
 
 	NULL
 };
-- 
1.7.0.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
