From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 09 Jan 2012 01:59:16 +0000
Subject: [lm-sensors] [PATCH] hwmon: (lm63) Fix checkpatch errors and
Message-Id: <1326074356-2033-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Guenter Roeck <guenter.roeck@ericsson.com>

Fix the following checkpatch errors and warnings:

WARNING: simple_strtoul is obsolete, use kstrtoul instead
ERROR: trailing whitespace
WARNING: line over 80 characters
ERROR: do not use assignment in if condition

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/lm63.c |   74 +++++++++++++++++++++++++++++++++++--------------
 1 files changed, 53 insertions(+), 21 deletions(-)

diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
index 508cb29..e02d7f0 100644
--- a/drivers/hwmon/lm63.c
+++ b/drivers/hwmon/lm63.c
@@ -204,7 +204,12 @@ static ssize_t set_fan(struct device *dev, struct device_attribute *dummy,
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm63_data *data = i2c_get_clientdata(client);
-	unsigned long val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->fan[1] = FAN_TO_REG(val);
@@ -231,11 +236,15 @@ static ssize_t set_pwm1(struct device *dev, struct device_attribute *dummy,
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm63_data *data = i2c_get_clientdata(client);
 	unsigned long val;
-	
+	int err;
+
 	if (!(data->config_fan & 0x20)) /* register is read-only */
 		return -EPERM;
 
-	val = simple_strtoul(buf, NULL, 10);
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+
 	mutex_lock(&data->update_lock);
 	data->pwm1_value = val <= 0 ? 0 :
 			   val >= 255 ? 2 * data->pwm1_freq :
@@ -245,8 +254,8 @@ static ssize_t set_pwm1(struct device *dev, struct device_attribute *dummy,
 	return count;
 }
 
-static ssize_t show_pwm1_enable(struct device *dev, struct device_attribute *dummy,
-				char *buf)
+static ssize_t show_pwm1_enable(struct device *dev,
+				struct device_attribute *dummy, char *buf)
 {
 	struct lm63_data *data = lm63_update_device(dev);
 	return sprintf(buf, "%d\n", data->config_fan & 0x20 ? 1 : 2);
@@ -283,7 +292,12 @@ static ssize_t set_local_temp8(struct device *dev,
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm63_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->temp8[1] = TEMP8_TO_REG(val);
@@ -314,9 +328,14 @@ static ssize_t set_temp11(struct device *dev, struct device_attribute *devattr,
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm63_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
 	int nr = attr->index;
 
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
+
 	mutex_lock(&data->update_lock);
 	data->temp11[nr] = TEMP11_TO_REG(val - data->temp2_offset);
 	i2c_smbus_write_byte_data(client, reg[(nr - 1) * 2],
@@ -327,10 +346,12 @@ static ssize_t set_temp11(struct device *dev, struct device_attribute *devattr,
 	return count;
 }
 
-/* Hysteresis register holds a relative value, while we want to present
-   an absolute to user-space */
-static ssize_t show_temp2_crit_hyst(struct device *dev, struct device_attribute *dummy,
-				    char *buf)
+/*
+ * Hysteresis register holds a relative value, while we want to present
+ * an absolute to user-space
+ */
+static ssize_t show_temp2_crit_hyst(struct device *dev,
+				    struct device_attribute *dummy, char *buf)
 {
 	struct lm63_data *data = lm63_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP8_FROM_REG(data->temp8[2])
@@ -338,16 +359,24 @@ static ssize_t show_temp2_crit_hyst(struct device *dev, struct device_attribute
 		       - TEMP8_FROM_REG(data->temp2_crit_hyst));
 }
 
-/* And now the other way around, user-space provides an absolute
-   hysteresis value and we have to store a relative one */
-static ssize_t set_temp2_crit_hyst(struct device *dev, struct device_attribute *dummy,
+/*
+ * And now the other way around, user-space provides an absolute
+ * hysteresis value and we have to store a relative one
+ */
+static ssize_t set_temp2_crit_hyst(struct device *dev,
+				   struct device_attribute *dummy,
 				   const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm63_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
 	long hyst;
 
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
+
 	mutex_lock(&data->update_lock);
 	hyst = TEMP8_FROM_REG(data->temp8[2]) + data->temp2_offset - val;
 	i2c_smbus_write_byte_data(client, LM63_REG_REMOTE_TCRIT_HYST,
@@ -518,12 +547,13 @@ static int lm63_probe(struct i2c_client *new_client,
 	lm63_init_client(new_client);
 
 	/* Register sysfs hooks */
-	if ((err = sysfs_create_group(&new_client->dev.kobj,
-				      &lm63_group)))
+	err = sysfs_create_group(&new_client->dev.kobj, &lm63_group);
+	if (err)
 		goto exit_free;
 	if (data->config & 0x04) { /* tachometer enabled */
-		if ((err = sysfs_create_group(&new_client->dev.kobj,
-					      &lm63_group_fan1)))
+		err = sysfs_create_group(&new_client->dev.kobj,
+					 &lm63_group_fan1);
+		if (err)
 			goto exit_remove_files;
 	}
 
@@ -544,8 +574,10 @@ exit:
 	return err;
 }
 
-/* Idealy we shouldn't have to initialize anything, since the BIOS
-   should have taken care of everything */
+/*
+ * Ideally we shouldn't have to initialize anything, since the BIOS
+ * should have taken care of everything
+ */
 static void lm63_init_client(struct i2c_client *client)
 {
 	struct lm63_data *data = i2c_get_clientdata(client);
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
