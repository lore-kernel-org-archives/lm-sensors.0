From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 16 Jan 2012 08:49:24 +0000
Subject: [lm-sensors] [PATCH 22/39] hwmon: (max1619): Fix checkpatch issues
Message-Id: <1326703781-14272-23-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fixed:
ERROR: do not use assignment in if condition
ERROR: trailing whitespace
WARNING: line over 80 characters
WARNING: please, no spaces at the start of a line
WARNING: simple_strtol is obsolete, use kstrtol instead

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/max1619.c |   21 ++++++++++++++-------
 1 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/max1619.c b/drivers/hwmon/max1619.c
index 022ded0..f19599f 100644
--- a/drivers/hwmon/max1619.c
+++ b/drivers/hwmon/max1619.c
@@ -125,7 +125,7 @@ struct max1619_data {
 	u8 temp_input2, temp_low2, temp_high2; /* remote */
 	u8 temp_crit2;
 	u8 temp_hyst2;
-	u8 alarms; 
+	u8 alarms;
 };
 
 /*
@@ -133,7 +133,8 @@ struct max1619_data {
  */
 
 #define show_temp(value) \
-static ssize_t show_##value(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_##value(struct device *dev, struct device_attribute *attr, \
+			    char *buf) \
 { \
 	struct max1619_data *data = max1619_update_device(dev); \
 	return sprintf(buf, "%d\n", temp_from_reg(data->value)); \
@@ -146,13 +147,17 @@ show_temp(temp_crit2);
 show_temp(temp_hyst2);
 
 #define set_temp2(value, reg) \
-static ssize_t set_##value(struct device *dev, struct device_attribute *attr, const char *buf, \
+static ssize_t set_##value(struct device *dev, struct device_attribute *attr, \
+			   const char *buf, \
 	size_t count) \
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct max1619_data *data = i2c_get_clientdata(client); \
-	long val = simple_strtol(buf, NULL, 10); \
- \
+	long val; \
+	int err = kstrtol(buf, 10, &val); \
+	if (err) \
+		return err; \
+\
 	mutex_lock(&data->update_lock); \
 	data->value = temp_to_reg(val); \
 	i2c_smbus_write_byte_data(client, reg, data->value); \
@@ -165,7 +170,8 @@ set_temp2(temp_high2, MAX1619_REG_W_REMOTE_HIGH);
 set_temp2(temp_crit2, MAX1619_REG_W_REMOTE_CRIT);
 set_temp2(temp_hyst2, MAX1619_REG_W_TCRIT_HYST);
 
-static ssize_t show_alarms(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_alarms(struct device *dev, struct device_attribute *attr,
+			   char *buf)
 {
 	struct max1619_data *data = max1619_update_device(dev);
 	return sprintf(buf, "%d\n", data->alarms);
@@ -275,7 +281,8 @@ static int max1619_probe(struct i2c_client *new_client,
 	max1619_init_client(new_client);
 
 	/* Register sysfs hooks */
-	if ((err = sysfs_create_group(&new_client->dev.kobj, &max1619_group)))
+	err = sysfs_create_group(&new_client->dev.kobj, &max1619_group);
+	if (err)
 		goto exit_free;
 
 	data->hwmon_dev = hwmon_device_register(&new_client->dev);
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
