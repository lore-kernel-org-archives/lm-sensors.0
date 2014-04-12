From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 12 Apr 2014 04:36:16 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (tmp102) Convert to use hwmon_device_register_with_groups
Message-Id: <1397277376-27502-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Simplify code, reduce code size, and attach sysfs attributes to hwmon device.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/tmp102.c |   46 ++++++++++++++++++++--------------------------
 1 file changed, 20 insertions(+), 26 deletions(-)

diff --git a/drivers/hwmon/tmp102.c b/drivers/hwmon/tmp102.c
index 5ea99a2..5171995 100644
--- a/drivers/hwmon/tmp102.c
+++ b/drivers/hwmon/tmp102.c
@@ -51,6 +51,7 @@
 #define	TMP102_THIGH_REG		0x03
 
 struct tmp102 {
+	struct i2c_client *client;
 	struct device *hwmon_dev;
 	struct thermal_zone_device *tz;
 	struct mutex lock;
@@ -77,9 +78,10 @@ static const u8 tmp102_reg[] = {
 	TMP102_THIGH_REG,
 };
 
-static struct tmp102 *tmp102_update_device(struct i2c_client *client)
+static struct tmp102 *tmp102_update_device(struct device *dev)
 {
-	struct tmp102 *tmp102 = i2c_get_clientdata(client);
+	struct tmp102 *tmp102 = dev_get_drvdata(dev);
+	struct i2c_client *client = tmp102->client;
 
 	mutex_lock(&tmp102->lock);
 	if (time_after(jiffies, tmp102->last_update + HZ / 3)) {
@@ -98,7 +100,7 @@ static struct tmp102 *tmp102_update_device(struct i2c_client *client)
 
 static int tmp102_read_temp(void *dev, long *temp)
 {
-	struct tmp102 *tmp102 = tmp102_update_device(to_i2c_client(dev));
+	struct tmp102 *tmp102 = tmp102_update_device(dev);
 
 	*temp = tmp102->temp[0];
 
@@ -110,7 +112,7 @@ static ssize_t tmp102_show_temp(struct device *dev,
 				char *buf)
 {
 	struct sensor_device_attribute *sda = to_sensor_dev_attr(attr);
-	struct tmp102 *tmp102 = tmp102_update_device(to_i2c_client(dev));
+	struct tmp102 *tmp102 = tmp102_update_device(dev);
 
 	return sprintf(buf, "%d\n", tmp102->temp[sda->index]);
 }
@@ -120,8 +122,8 @@ static ssize_t tmp102_set_temp(struct device *dev,
 			       const char *buf, size_t count)
 {
 	struct sensor_device_attribute *sda = to_sensor_dev_attr(attr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct tmp102 *tmp102 = i2c_get_clientdata(client);
+	struct tmp102 *tmp102 = dev_get_drvdata(dev);
+	struct i2c_client *client = tmp102->client;
 	long val;
 	int status;
 
@@ -145,16 +147,13 @@ static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO, tmp102_show_temp,
 static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, tmp102_show_temp,
 			  tmp102_set_temp, 2);
 
-static struct attribute *tmp102_attributes[] = {
+static struct attribute *tmp102_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
 	&sensor_dev_attr_temp1_max.dev_attr.attr,
 	NULL
 };
-
-static const struct attribute_group tmp102_attr_group = {
-	.attrs = tmp102_attributes,
-};
+ATTRIBUTE_GROUPS(tmp102);
 
 #define TMP102_CONFIG  (TMP102_CONF_TM | TMP102_CONF_EM | TMP102_CONF_CR1)
 #define TMP102_CONFIG_RD_ONLY (TMP102_CONF_R0 | TMP102_CONF_R1 | TMP102_CONF_AL)
@@ -163,6 +162,7 @@ static int tmp102_probe(struct i2c_client *client,
 				  const struct i2c_device_id *id)
 {
 	struct device *dev = &client->dev;
+	struct device *hwmon_dev;
 	struct tmp102 *tmp102;
 	int status;
 
@@ -178,6 +178,7 @@ static int tmp102_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	i2c_set_clientdata(client, tmp102);
+	tmp102->client = client;
 
 	status = i2c_smbus_read_word_swapped(client, TMP102_CONF_REG);
 	if (status < 0) {
@@ -205,19 +206,15 @@ static int tmp102_probe(struct i2c_client *client,
 	tmp102->last_update = jiffies - HZ;
 	mutex_init(&tmp102->lock);
 
-	status = sysfs_create_group(&dev->kobj, &tmp102_attr_group);
-	if (status) {
-		dev_dbg(dev, "could not create sysfs files\n");
-		goto fail_restore_config;
-	}
-	tmp102->hwmon_dev = hwmon_device_register(dev);
-	if (IS_ERR(tmp102->hwmon_dev)) {
+	hwmon_dev = hwmon_device_register_with_groups(dev, client->name,
+						      tmp102, tmp102_groups);
+	if (IS_ERR(hwmon_dev)) {
 		dev_dbg(dev, "unable to register hwmon device\n");
-		status = PTR_ERR(tmp102->hwmon_dev);
-		goto fail_remove_sysfs;
+		status = PTR_ERR(hwmon_dev);
+		goto fail_restore_config;
 	}
-
-	tmp102->tz = thermal_zone_of_sensor_register(dev, 0, dev,
+	tmp102->hwmon_dev = hwmon_dev;
+	tmp102->tz = thermal_zone_of_sensor_register(hwmon_dev, 0, hwmon_dev,
 						     tmp102_read_temp, NULL);
 	if (IS_ERR(tmp102->tz))
 		tmp102->tz = NULL;
@@ -226,8 +223,6 @@ static int tmp102_probe(struct i2c_client *client,
 
 	return 0;
 
-fail_remove_sysfs:
-	sysfs_remove_group(&dev->kobj, &tmp102_attr_group);
 fail_restore_config:
 	i2c_smbus_write_word_swapped(client, TMP102_CONF_REG,
 				     tmp102->config_orig);
@@ -238,9 +233,8 @@ static int tmp102_remove(struct i2c_client *client)
 {
 	struct tmp102 *tmp102 = i2c_get_clientdata(client);
 
-	thermal_zone_of_sensor_unregister(&client->dev, tmp102->tz);
+	thermal_zone_of_sensor_unregister(tmp102->hwmon_dev, tmp102->tz);
 	hwmon_device_unregister(tmp102->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &tmp102_attr_group);
 
 	/* Stop monitoring if device was stopped originally */
 	if (tmp102->config_orig & TMP102_CONF_SD) {
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
