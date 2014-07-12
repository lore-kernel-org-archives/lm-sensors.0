From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 12 Jul 2014 08:55:13 +0000
Subject: [lm-sensors] [PATCH] hwmon: (ds620): Check data pointer before dereference it
Message-Id: <1405155313.7852.1.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

data can be an ERR_PTR, so the client assignment must only happen after the
ERR_PTR check.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/ds620.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/ds620.c b/drivers/hwmon/ds620.c
index 1bdb6246..65e01a8 100644
--- a/drivers/hwmon/ds620.c
+++ b/drivers/hwmon/ds620.c
@@ -159,7 +159,12 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *da,
 
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct ds620_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
+	struct i2c_client *client;
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	client = data->client;
 
 	res = kstrtol(buf, 10, &val);
 
@@ -181,13 +186,15 @@ static ssize_t show_alarm(struct device *dev, struct device_attribute *da,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct ds620_data *data = ds620_update_client(dev);
-	struct i2c_client *client = data->client;
+	struct i2c_client *client;
 	u16 conf, new_conf;
 	int res;
 
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
+	client = data->client;
+
 	/* reset alarms if necessary */
 	res = i2c_smbus_read_word_swapped(client, DS620_REG_CONF);
 	if (res < 0)
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
