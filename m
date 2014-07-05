From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 05 Jul 2014 03:22:44 +0000
Subject: [lm-sensors] [RFT][PATCH] hwmon: (lineage-pem) Convert to devm_hwmon_device_register_with_groups
Message-Id: <1404530564.19630.6.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/lineage-pem.c | 66 +++++++++++++--------------------------------
 1 file changed, 19 insertions(+), 47 deletions(-)

diff --git a/drivers/hwmon/lineage-pem.c b/drivers/hwmon/lineage-pem.c
index ebbb9f4..84d791b 100644
--- a/drivers/hwmon/lineage-pem.c
+++ b/drivers/hwmon/lineage-pem.c
@@ -125,7 +125,8 @@
 #define FAN_SPEED_LEN		5
 
 struct pem_data {
-	struct device *hwmon_dev;
+	struct i2c_client *client;
+	const struct attribute_group *groups[4];
 
 	struct mutex update_lock;
 	bool valid;
@@ -160,8 +161,8 @@ abort:
 
 static struct pem_data *pem_update_device(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct pem_data *data = i2c_get_clientdata(client);
+	struct pem_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	struct pem_data *ret = data;
 
 	mutex_lock(&data->update_lock);
@@ -444,18 +445,20 @@ static int pem_probe(struct i2c_client *client,
 		     const struct i2c_device_id *id)
 {
 	struct i2c_adapter *adapter = client->adapter;
+	struct device *dev = &client->dev;
+	struct device *hwmon_dev;
 	struct pem_data *data;
-	int ret;
+	int ret, idx = 0;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BLOCK_DATA
 				     | I2C_FUNC_SMBUS_WRITE_BYTE))
 		return -ENODEV;
 
-	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	i2c_set_clientdata(client, data);
+	data->client = client;
 	mutex_init(&data->update_lock);
 
 	/*
@@ -471,14 +474,12 @@ static int pem_probe(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
 
-	dev_info(&client->dev, "Firmware revision %d.%d.%d\n",
+	dev_info(dev, "Firmware revision %d.%d.%d\n",
 		 data->firmware_rev[0], data->firmware_rev[1],
 		 data->firmware_rev[2]);
 
-	/* Register sysfs hooks */
-	ret = sysfs_create_group(&client->dev.kobj, &pem_group);
-	if (ret)
-		return ret;
+	/* sysfs hooks */
+	data->groups[idx++] = &pem_group;
 
 	/*
 	 * Check if input readings are supported.
@@ -501,12 +502,9 @@ static int pem_probe(struct i2c_client *client,
 			    data->input_string[2] || data->input_string[3]))
 			data->input_length = sizeof(data->input_string);
 	}
-	ret = 0;
-	if (data->input_length) {
-		ret = sysfs_create_group(&client->dev.kobj, &pem_input_group);
-		if (ret)
-			goto out_remove_groups;
-	}
+
+	if (data->input_length)
+		data->groups[idx++] = &pem_input_group;
 
 	/*
 	 * Check if fan speed readings are supported.
@@ -520,37 +518,12 @@ static int pem_probe(struct i2c_client *client,
 	if (!ret && (data->fan_speed[0] || data->fan_speed[1] ||
 		     data->fan_speed[2] || data->fan_speed[3])) {
 		data->fans_supported = true;
-		ret = sysfs_create_group(&client->dev.kobj, &pem_fan_group);
-		if (ret)
-			goto out_remove_groups;
-	}
-
-	data->hwmon_dev = hwmon_device_register(&client->dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		ret = PTR_ERR(data->hwmon_dev);
-		goto out_remove_groups;
+		data->groups[idx++] = &pem_fan_group;
 	}
 
-	return 0;
-
-out_remove_groups:
-	sysfs_remove_group(&client->dev.kobj, &pem_input_group);
-	sysfs_remove_group(&client->dev.kobj, &pem_fan_group);
-	sysfs_remove_group(&client->dev.kobj, &pem_group);
-	return ret;
-}
-
-static int pem_remove(struct i2c_client *client)
-{
-	struct pem_data *data = i2c_get_clientdata(client);
-
-	hwmon_device_unregister(data->hwmon_dev);
-
-	sysfs_remove_group(&client->dev.kobj, &pem_input_group);
-	sysfs_remove_group(&client->dev.kobj, &pem_fan_group);
-	sysfs_remove_group(&client->dev.kobj, &pem_group);
-
-	return 0;
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
+							   data, data->groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 static const struct i2c_device_id pem_id[] = {
@@ -564,7 +537,6 @@ static struct i2c_driver pem_driver = {
 		   .name = "lineage_pem",
 		   },
 	.probe = pem_probe,
-	.remove = pem_remove,
 	.id_table = pem_id,
 };
 
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
