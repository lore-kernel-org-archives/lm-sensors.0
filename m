From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 19 Jul 2014 14:52:40 +0000
Subject: [lm-sensors] [RFT][PATCH] hwmon: (emc2103) Convert to devm_hwmon_device_register_with_groups
Message-Id: <1405781560.15902.9.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use devm_hwmon_device_register_with_groups() to simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/emc2103.c | 89 +++++++++++++++----------------------------------
 1 file changed, 26 insertions(+), 63 deletions(-)

diff --git a/drivers/hwmon/emc2103.c b/drivers/hwmon/emc2103.c
index 78002de..952fe69 100644
--- a/drivers/hwmon/emc2103.c
+++ b/drivers/hwmon/emc2103.c
@@ -66,7 +66,8 @@ struct temperature {
 };
 
 struct emc2103_data {
-	struct device		*hwmon_dev;
+	struct i2c_client	*client;
+	const struct		attribute_group *groups[4];
 	struct mutex		update_lock;
 	bool			valid;		/* registers are valid */
 	bool			fan_rpm_control;
@@ -146,8 +147,8 @@ static void read_fan_config_from_i2c(struct i2c_client *client)
 
 static struct emc2103_data *emc2103_update_device(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct emc2103_data *data = i2c_get_clientdata(client);
+	struct emc2103_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 
 	mutex_lock(&data->update_lock);
 
@@ -242,8 +243,8 @@ static ssize_t set_temp_min(struct device *dev, struct device_attribute *da,
 			    const char *buf, size_t count)
 {
 	int nr = to_sensor_dev_attr(da)->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct emc2103_data *data = i2c_get_clientdata(client);
+	struct emc2103_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long val;
 
 	int result = kstrtol(buf, 10, &val);
@@ -264,8 +265,8 @@ static ssize_t set_temp_max(struct device *dev, struct device_attribute *da,
 			    const char *buf, size_t count)
 {
 	int nr = to_sensor_dev_attr(da)->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct emc2103_data *data = i2c_get_clientdata(client);
+	struct emc2103_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long val;
 
 	int result = kstrtol(buf, 10, &val);
@@ -310,7 +311,7 @@ static ssize_t set_fan_div(struct device *dev, struct device_attribute *da,
 			   const char *buf, size_t count)
 {
 	struct emc2103_data *data = emc2103_update_device(dev);
-	struct i2c_client *client = to_i2c_client(dev);
+	struct i2c_client *client = data->client;
 	int new_range_bits, old_div = 8 / data->fan_multiplier;
 	long new_div;
 
@@ -385,7 +386,7 @@ static ssize_t set_fan_target(struct device *dev, struct device_attribute *da,
 			      const char *buf, size_t count)
 {
 	struct emc2103_data *data = emc2103_update_device(dev);
-	struct i2c_client *client = to_i2c_client(dev);
+	struct i2c_client *client = data->client;
 	unsigned long rpm_target;
 
 	int result = kstrtoul(buf, 10, &rpm_target);
@@ -428,8 +429,8 @@ show_pwm_enable(struct device *dev, struct device_attribute *da, char *buf)
 static ssize_t set_pwm_enable(struct device *dev, struct device_attribute *da,
 			      const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct emc2103_data *data = i2c_get_clientdata(client);
+	struct emc2103_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long new_value;
 	u8 conf_reg;
 
@@ -580,7 +581,8 @@ static int
 emc2103_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
 	struct emc2103_data *data;
-	int status;
+	struct device *hwmon_dev;
+	int status, idx = 0;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -EIO;
@@ -591,6 +593,7 @@ emc2103_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		return -ENOMEM;
 
 	i2c_set_clientdata(client, data);
+	data->client = client;
 	mutex_init(&data->update_lock);
 
 	/* 2103-2 and 2103-4 have 3 external diodes, 2103-1 has 1 */
@@ -624,60 +627,21 @@ emc2103_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		}
 	}
 
-	/* Register sysfs hooks */
-	status = sysfs_create_group(&client->dev.kobj, &emc2103_group);
-	if (status)
-		return status;
-
-	if (data->temp_count >= 3) {
-		status = sysfs_create_group(&client->dev.kobj,
-			&emc2103_temp3_group);
-		if (status)
-			goto exit_remove;
-	}
-
-	if (data->temp_count = 4) {
-		status = sysfs_create_group(&client->dev.kobj,
-			&emc2103_temp4_group);
-		if (status)
-			goto exit_remove_temp3;
-	}
-
-	data->hwmon_dev = hwmon_device_register(&client->dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		status = PTR_ERR(data->hwmon_dev);
-		goto exit_remove_temp4;
-	}
-
-	dev_info(&client->dev, "%s: sensor '%s'\n",
-		 dev_name(data->hwmon_dev), client->name);
-
-	return 0;
-
-exit_remove_temp4:
-	if (data->temp_count = 4)
-		sysfs_remove_group(&client->dev.kobj, &emc2103_temp4_group);
-exit_remove_temp3:
+	/* sysfs hooks */
+	data->groups[idx++] = &emc2103_group;
 	if (data->temp_count >= 3)
-		sysfs_remove_group(&client->dev.kobj, &emc2103_temp3_group);
-exit_remove:
-	sysfs_remove_group(&client->dev.kobj, &emc2103_group);
-	return status;
-}
-
-static int emc2103_remove(struct i2c_client *client)
-{
-	struct emc2103_data *data = i2c_get_clientdata(client);
-
-	hwmon_device_unregister(data->hwmon_dev);
-
+		data->groups[idx++] = &emc2103_temp3_group;
 	if (data->temp_count = 4)
-		sysfs_remove_group(&client->dev.kobj, &emc2103_temp4_group);
+		data->groups[idx++] = &emc2103_temp4_group;
 
-	if (data->temp_count >= 3)
-		sysfs_remove_group(&client->dev.kobj, &emc2103_temp3_group);
+	hwmon_dev = devm_hwmon_device_register_with_groups(&client->dev,
+							   client->name, data,
+							   data->groups);
+	if (IS_ERR(hwmon_dev))
+		return PTR_ERR(hwmon_dev);
 
-	sysfs_remove_group(&client->dev.kobj, &emc2103_group);
+	dev_info(&client->dev, "%s: sensor '%s'\n",
+		 dev_name(hwmon_dev), client->name);
 
 	return 0;
 }
@@ -717,7 +681,6 @@ static struct i2c_driver emc2103_driver = {
 		.name	= "emc2103",
 	},
 	.probe		= emc2103_probe,
-	.remove		= emc2103_remove,
 	.id_table	= emc2103_ids,
 	.detect		= emc2103_detect,
 	.address_list	= normal_i2c,
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
