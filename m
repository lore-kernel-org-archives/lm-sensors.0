From: Axel Lin <axel.lin@ingics.com>
Date: Sun, 29 Jun 2014 07:00:59 +0000
Subject: [lm-sensors] [PATCH RFT] hwmon: (htu21) Convert to devm_hwmon_device_register_with_groups
Message-Id: <1404025259.18179.1.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/htu21.c | 69 ++++++++++++++++-----------------------------------
 1 file changed, 22 insertions(+), 47 deletions(-)

diff --git a/drivers/hwmon/htu21.c b/drivers/hwmon/htu21.c
index 839086e..4c3bbb7 100644
--- a/drivers/hwmon/htu21.c
+++ b/drivers/hwmon/htu21.c
@@ -31,7 +31,7 @@
 #define HTU21_RH_MEASUREMENT_HM	0xE5
 
 struct htu21 {
-	struct device *hwmon_dev;
+	struct i2c_client *client;
 	struct mutex lock;
 	bool valid;
 	unsigned long last_update;
@@ -59,10 +59,11 @@ static inline int htu21_rh_ticks_to_per_cent_mille(int ticks)
 	return ((15625 * ticks) >> 13) - 6000;
 }
 
-static int htu21_update_measurements(struct i2c_client *client)
+static int htu21_update_measurements(struct device *dev)
 {
+	struct htu21 *htu21 = dev_get_drvdata(dev);
+	struct i2c_client *client = htu21->client;
 	int ret = 0;
-	struct htu21 *htu21 = i2c_get_clientdata(client);
 
 	mutex_lock(&htu21->lock);
 
@@ -90,9 +91,10 @@ out:
 static ssize_t htu21_show_temperature(struct device *dev,
 				      struct device_attribute *attr, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct htu21 *htu21 = i2c_get_clientdata(client);
-	int ret = htu21_update_measurements(client);
+	struct htu21 *htu21 = dev_get_drvdata(dev);
+	int ret;
+
+	ret = htu21_update_measurements(dev);
 	if (ret < 0)
 		return ret;
 	return sprintf(buf, "%d\n", htu21->temperature);
@@ -101,9 +103,10 @@ static ssize_t htu21_show_temperature(struct device *dev,
 static ssize_t htu21_show_humidity(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct htu21 *htu21 = i2c_get_clientdata(client);
-	int ret = htu21_update_measurements(client);
+	struct htu21 *htu21 = dev_get_drvdata(dev);
+	int ret;
+
+	ret = htu21_update_measurements(dev);
 	if (ret < 0)
 		return ret;
 	return sprintf(buf, "%d\n", htu21->humidity);
@@ -114,21 +117,20 @@ static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO,
 static SENSOR_DEVICE_ATTR(humidity1_input, S_IRUGO,
 			  htu21_show_humidity, NULL, 0);
 
-static struct attribute *htu21_attributes[] = {
+static struct attribute *htu21_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	&sensor_dev_attr_humidity1_input.dev_attr.attr,
 	NULL
 };
 
-static const struct attribute_group htu21_group = {
-	.attrs = htu21_attributes,
-};
+ATTRIBUTE_GROUPS(htu21);
 
 static int htu21_probe(struct i2c_client *client,
 		       const struct i2c_device_id *id)
 {
+	struct device *dev = &client->dev;
 	struct htu21 *htu21;
-	int err;
+	struct device *hwmon_dev;
 
 	if (!i2c_check_functionality(client->adapter,
 				     I2C_FUNC_SMBUS_READ_WORD_DATA)) {
@@ -137,43 +139,17 @@ static int htu21_probe(struct i2c_client *client,
 		return -ENODEV;
 	}
 
-	htu21 = devm_kzalloc(&client->dev, sizeof(*htu21), GFP_KERNEL);
+	htu21 = devm_kzalloc(dev, sizeof(*htu21), GFP_KERNEL);
 	if (!htu21)
 		return -ENOMEM;
 
-	i2c_set_clientdata(client, htu21);
-
+	htu21->client = client;
 	mutex_init(&htu21->lock);
 
-	err = sysfs_create_group(&client->dev.kobj, &htu21_group);
-	if (err) {
-		dev_dbg(&client->dev, "could not create sysfs files\n");
-		return err;
-	}
-	htu21->hwmon_dev = hwmon_device_register(&client->dev);
-	if (IS_ERR(htu21->hwmon_dev)) {
-		dev_dbg(&client->dev, "unable to register hwmon device\n");
-		err = PTR_ERR(htu21->hwmon_dev);
-		goto error;
-	}
-
-	dev_info(&client->dev, "initialized\n");
-
-	return 0;
-
-error:
-	sysfs_remove_group(&client->dev.kobj, &htu21_group);
-	return err;
-}
-
-static int htu21_remove(struct i2c_client *client)
-{
-	struct htu21 *htu21 = i2c_get_clientdata(client);
-
-	hwmon_device_unregister(htu21->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &htu21_group);
-
-	return 0;
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
+							   htu21,
+							   htu21_groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 static const struct i2c_device_id htu21_id[] = {
@@ -188,7 +164,6 @@ static struct i2c_driver htu21_driver = {
 		.name	= "htu21",
 	},
 	.probe       = htu21_probe,
-	.remove      = htu21_remove,
 	.id_table    = htu21_id,
 };
 
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
