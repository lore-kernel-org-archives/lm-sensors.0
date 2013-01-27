From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 27 Jan 2013 02:17:37 +0000
Subject: [lm-sensors] [PATCH 03/13] hwmon: (pmbus) Use dev variable to represent client->dev
Message-Id: <1359253067-11644-4-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This simplifies the code and makes it a bit smaller.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pmbus/pmbus_core.c |   37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index b9ba8ce..97eca03 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -1691,7 +1691,8 @@ static int pmbus_identify_common(struct i2c_client *client,
 int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
 		   struct pmbus_driver_info *info)
 {
-	const struct pmbus_platform_data *pdata = client->dev.platform_data;
+	struct device *dev = &client->dev;
+	const struct pmbus_platform_data *pdata = dev->platform_data;
 	struct pmbus_data *data;
 	int ret;
 
@@ -1703,7 +1704,7 @@ int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
 				     | I2C_FUNC_SMBUS_WORD_DATA))
 		return -ENODEV;
 
-	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -1712,7 +1713,7 @@ int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
 
 	/* Bail out if PMBus status register does not exist. */
 	if (i2c_smbus_read_byte_data(client, PMBUS_STATUS_BYTE) < 0) {
-		dev_err(&client->dev, "PMBus status register not found\n");
+		dev_err(dev, "PMBus status register not found\n");
 		return -ENODEV;
 	}
 
@@ -1725,40 +1726,38 @@ int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
 	if (info->identify) {
 		ret = (*info->identify)(client, info);
 		if (ret < 0) {
-			dev_err(&client->dev, "Chip identification failed\n");
+			dev_err(dev, "Chip identification failed\n");
 			return ret;
 		}
 	}
 
 	if (info->pages <= 0 || info->pages > PMBUS_PAGES) {
-		dev_err(&client->dev, "Bad number of PMBus pages: %d\n",
-			info->pages);
+		dev_err(dev, "Bad number of PMBus pages: %d\n", info->pages);
 		return -ENODEV;
 	}
 
 	ret = pmbus_identify_common(client, data);
 	if (ret < 0) {
-		dev_err(&client->dev, "Failed to identify chip capabilities\n");
+		dev_err(dev, "Failed to identify chip capabilities\n");
 		return ret;
 	}
 
-	ret = -ENOMEM;
-	data->sensors = devm_kzalloc(&client->dev, sizeof(struct pmbus_sensor)
+	data->sensors = devm_kzalloc(dev, sizeof(struct pmbus_sensor)
 				     * data->max_sensors, GFP_KERNEL);
 	if (!data->sensors)
 		return -ENOMEM;
 
-	data->booleans = devm_kzalloc(&client->dev, sizeof(struct pmbus_boolean)
-				 * data->max_booleans, GFP_KERNEL);
+	data->booleans = devm_kzalloc(dev, sizeof(struct pmbus_boolean)
+				      * data->max_booleans, GFP_KERNEL);
 	if (!data->booleans)
 		return -ENOMEM;
 
-	data->labels = devm_kzalloc(&client->dev, sizeof(struct pmbus_label)
+	data->labels = devm_kzalloc(dev, sizeof(struct pmbus_label)
 				    * data->max_labels, GFP_KERNEL);
 	if (!data->labels)
 		return -ENOMEM;
 
-	data->attributes = devm_kzalloc(&client->dev, sizeof(struct attribute *)
+	data->attributes = devm_kzalloc(dev, sizeof(struct attribute *)
 					* data->max_attributes, GFP_KERNEL);
 	if (!data->attributes)
 		return -ENOMEM;
@@ -1770,27 +1769,27 @@ int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
 	 * Bail out instead of trying to register nothing.
 	 */
 	if (!data->num_attributes) {
-		dev_err(&client->dev, "No attributes found\n");
+		dev_err(dev, "No attributes found\n");
 		return -ENODEV;
 	}
 
 	/* Register sysfs hooks */
 	data->group.attrs = data->attributes;
-	ret = sysfs_create_group(&client->dev.kobj, &data->group);
+	ret = sysfs_create_group(&dev->kobj, &data->group);
 	if (ret) {
-		dev_err(&client->dev, "Failed to create sysfs entries\n");
+		dev_err(dev, "Failed to create sysfs entries\n");
 		return ret;
 	}
-	data->hwmon_dev = hwmon_device_register(&client->dev);
+	data->hwmon_dev = hwmon_device_register(dev);
 	if (IS_ERR(data->hwmon_dev)) {
 		ret = PTR_ERR(data->hwmon_dev);
-		dev_err(&client->dev, "Failed to register hwmon device\n");
+		dev_err(dev, "Failed to register hwmon device\n");
 		goto out_hwmon_device_register;
 	}
 	return 0;
 
 out_hwmon_device_register:
-	sysfs_remove_group(&client->dev.kobj, &data->group);
+	sysfs_remove_group(&dev->kobj, &data->group);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(pmbus_do_probe);
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
