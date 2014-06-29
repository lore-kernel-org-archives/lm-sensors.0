From: Axel Lin <axel.lin@ingics.com>
Date: Sun, 29 Jun 2014 06:45:54 +0000
Subject: [lm-sensors] [RFT][PATCH] hwmon: (hih6130) Convert to devm_hwmon_device_register_with_groups
Message-Id: <1404024354.10911.1.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/hih6130.c | 88 +++++++++++++------------------------------------
 1 file changed, 23 insertions(+), 65 deletions(-)

diff --git a/drivers/hwmon/hih6130.c b/drivers/hwmon/hih6130.c
index 7d68a08..0e01c4e 100644
--- a/drivers/hwmon/hih6130.c
+++ b/drivers/hwmon/hih6130.c
@@ -46,7 +46,7 @@
  * @write_length: length for I2C measurement request
  */
 struct hih6130 {
-	struct device *hwmon_dev;
+	struct i2c_client *client;
 	struct mutex lock;
 	bool valid;
 	unsigned long last_update;
@@ -62,7 +62,6 @@ struct hih6130 {
  */
 static inline int hih6130_temp_ticks_to_millicelsius(int ticks)
 {
-
 	ticks = ticks >> 2;
 	/*
 	 * from data sheet section 5.0
@@ -78,7 +77,6 @@ static inline int hih6130_temp_ticks_to_millicelsius(int ticks)
  */
 static inline int hih6130_rh_ticks_to_per_cent_mille(int ticks)
 {
-
 	ticks &= ~0xC000; /* clear status bits */
 	/*
 	 * from data sheet section 4.0
@@ -89,15 +87,16 @@ static inline int hih6130_rh_ticks_to_per_cent_mille(int ticks)
 
 /**
  * hih6130_update_measurements() - get updated measurements from device
- * @client: I2C client device
+ * @dev: device
  *
  * Returns 0 on success, else negative errno.
  */
-static int hih6130_update_measurements(struct i2c_client *client)
+static int hih6130_update_measurements(struct device *dev)
 {
+	struct hih6130 *hih6130 = dev_get_drvdata(dev);
+	struct i2c_client *client = hih6130->client;
 	int ret = 0;
 	int t;
-	struct hih6130 *hih6130 = i2c_get_clientdata(client);
 	unsigned char tmp[4];
 	struct i2c_msg msgs[1] = {
 		{
@@ -176,9 +175,10 @@ static ssize_t hih6130_show_temperature(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct hih6130 *hih6130 = i2c_get_clientdata(client);
-	int ret = hih6130_update_measurements(client);
+	struct hih6130 *hih6130 = dev_get_drvdata(dev);
+	int ret;
+
+	ret = hih6130_update_measurements(dev);
 	if (ret < 0)
 		return ret;
 	return sprintf(buf, "%d\n", hih6130->temperature);
@@ -196,9 +196,10 @@ static ssize_t hih6130_show_temperature(struct device *dev,
 static ssize_t hih6130_show_humidity(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct hih6130 *hih6130 = i2c_get_clientdata(client);
-	int ret = hih6130_update_measurements(client);
+	struct hih6130 *hih6130 = dev_get_drvdata(dev);
+	int ret;
+
+	ret = hih6130_update_measurements(dev);
 	if (ret < 0)
 		return ret;
 	return sprintf(buf, "%d\n", hih6130->humidity);
@@ -210,79 +211,37 @@ static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, hih6130_show_temperature,
 static SENSOR_DEVICE_ATTR(humidity1_input, S_IRUGO, hih6130_show_humidity,
 	NULL, 0);
 
-static struct attribute *hih6130_attributes[] = {
+static struct attribute *hih6130_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	&sensor_dev_attr_humidity1_input.dev_attr.attr,
 	NULL
 };
 
-static const struct attribute_group hih6130_attr_group = {
-	.attrs = hih6130_attributes,
-};
+ATTRIBUTE_GROUPS(hih6130);
 
-/**
- * hih6130_probe() - probe device
- * @client: I2C client device
- * @id: device ID
- *
- * Called by the I2C core when an entry in the ID table matches a
- * device's name.
- * Returns 0 on success.
- */
 static int hih6130_probe(struct i2c_client *client,
 				   const struct i2c_device_id *id)
 {
+	struct device *dev = &client->dev;
 	struct hih6130 *hih6130;
-	int err;
+	struct device *hwmon_dev;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		dev_err(&client->dev, "adapter does not support true I2C\n");
 		return -ENODEV;
 	}
 
-	hih6130 = devm_kzalloc(&client->dev, sizeof(*hih6130), GFP_KERNEL);
+	hih6130 = devm_kzalloc(dev, sizeof(*hih6130), GFP_KERNEL);
 	if (!hih6130)
 		return -ENOMEM;
 
-	i2c_set_clientdata(client, hih6130);
-
+	hih6130->client = client;
 	mutex_init(&hih6130->lock);
 
-	err = sysfs_create_group(&client->dev.kobj, &hih6130_attr_group);
-	if (err) {
-		dev_dbg(&client->dev, "could not create sysfs files\n");
-		return err;
-	}
-
-	hih6130->hwmon_dev = hwmon_device_register(&client->dev);
-	if (IS_ERR(hih6130->hwmon_dev)) {
-		dev_dbg(&client->dev, "unable to register hwmon device\n");
-		err = PTR_ERR(hih6130->hwmon_dev);
-		goto fail_remove_sysfs;
-	}
-
-	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_QUICK))
-		hih6130->write_length = 1;
-
-	return 0;
-
-fail_remove_sysfs:
-	sysfs_remove_group(&client->dev.kobj, &hih6130_attr_group);
-	return err;
-}
-
-/**
- * hih6130_remove() - remove device
- * @client: I2C client device
- */
-static int hih6130_remove(struct i2c_client *client)
-{
-	struct hih6130 *hih6130 = i2c_get_clientdata(client);
-
-	hwmon_device_unregister(hih6130->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &hih6130_attr_group);
-
-	return 0;
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
+							   hih6130,
+							   hih6130_groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 /* Device ID table */
@@ -295,7 +254,6 @@ MODULE_DEVICE_TABLE(i2c, hih6130_id);
 static struct i2c_driver hih6130_driver = {
 	.driver.name = "hih6130",
 	.probe       = hih6130_probe,
-	.remove      = hih6130_remove,
 	.id_table    = hih6130_id,
 };
 
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
