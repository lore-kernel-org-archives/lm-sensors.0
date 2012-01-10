From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Tue, 10 Jan 2012 14:49:35 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (lm80) fixed checkpatch errors
Message-Id: <1326206976-7846-1-git-send-email-fransmeulenbroeks@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

fixed:
WARNING: simple_strtol is obsolete, use kstrtol instead
WARNING: simple_strtoul is obsolete, use kstrtoul instead

Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
---
 drivers/hwmon/lm80.c |   20 ++++++++++++++++----
 1 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
index 616f470..18e5ea4 100644
--- a/drivers/hwmon/lm80.c
+++ b/drivers/hwmon/lm80.c
@@ -185,7 +185,10 @@ static ssize_t set_in_##suffix(struct device *dev, \
 	int nr = to_sensor_dev_attr(attr)->index; \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct lm80_data *data = i2c_get_clientdata(client); \
-	long val = simple_strtol(buf, NULL, 10); \
+	long val; \
+	int err = kstrtol(buf, 10, &val); \
+	if (err < 0) \
+		return err; \
 \
 	mutex_lock(&data->update_lock);\
 	data->value[nr] = IN_TO_REG(val); \
@@ -226,7 +229,10 @@ static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm80_data *data = i2c_get_clientdata(client);
-	long val = simple_strtoul(buf, NULL, 10);
+	long val;
+	int err = kstrtol(buf, 10, &val);
+	if (err < 0)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
@@ -245,8 +251,11 @@ static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm80_data *data = i2c_get_clientdata(client);
-	unsigned long min, val = simple_strtoul(buf, NULL, 10);
+	unsigned long min, val;
 	u8 reg;
+	int err = kstrtoul(buf, 10, &val);
+	if (err < 0)
+		return err;
 
 	/* Save fan_min */
 	mutex_lock(&data->update_lock);
@@ -314,7 +323,10 @@ static ssize_t set_temp_##suffix(struct device *dev, \
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct lm80_data *data = i2c_get_clientdata(client); \
-	long val = simple_strtoul(buf, NULL, 10); \
+	long val; \
+	int err = kstrtol(buf, 10, &val); \
+	if (err < 0) \
+		return err; \
 \
 	mutex_lock(&data->update_lock); \
 	data->value = TEMP_LIMIT_TO_REG(val); \
-- 
1.7.0.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
