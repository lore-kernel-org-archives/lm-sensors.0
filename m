From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 12 Feb 2014 17:41:03 +0000
Subject: [lm-sensors] [PATCH 1/4] hwmon: (max6650) Rearrange code to no longer require forward declarations
Message-Id: <1392226866-25968-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Cleanup only; no functional change.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/max6650.c |  228 ++++++++++++++++++++++-------------------------
 1 file changed, 109 insertions(+), 119 deletions(-)

diff --git a/drivers/hwmon/max6650.c b/drivers/hwmon/max6650.c
index 0cafc39..26b24f7 100644
--- a/drivers/hwmon/max6650.c
+++ b/drivers/hwmon/max6650.c
@@ -105,32 +105,6 @@ module_param(clock, int, S_IRUGO);
 
 #define DIV_FROM_REG(reg) (1 << (reg & 7))
 
-static int max6650_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id);
-static int max6650_init_client(struct i2c_client *client);
-static int max6650_remove(struct i2c_client *client);
-static struct max6650_data *max6650_update_device(struct device *dev);
-
-/*
- * Driver data (common to all clients)
- */
-
-static const struct i2c_device_id max6650_id[] = {
-	{ "max6650", 1 },
-	{ "max6651", 4 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, max6650_id);
-
-static struct i2c_driver max6650_driver = {
-	.driver = {
-		.name	= "max6650",
-	},
-	.probe		= max6650_probe,
-	.remove		= max6650_remove,
-	.id_table	= max6650_id,
-};
-
 /*
  * Client data (each client gets its own)
  */
@@ -151,6 +125,51 @@ struct max6650_data {
 	u8 alarm;
 };
 
+static const u8 tach_reg[] = {
+	MAX6650_REG_TACH0,
+	MAX6650_REG_TACH1,
+	MAX6650_REG_TACH2,
+	MAX6650_REG_TACH3,
+};
+
+static struct max6650_data *max6650_update_device(struct device *dev)
+{
+	int i;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct max6650_data *data = i2c_get_clientdata(client);
+
+	mutex_lock(&data->update_lock);
+
+	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
+		data->speed = i2c_smbus_read_byte_data(client,
+						       MAX6650_REG_SPEED);
+		data->config = i2c_smbus_read_byte_data(client,
+							MAX6650_REG_CONFIG);
+		for (i = 0; i < data->nr_fans; i++) {
+			data->tach[i] = i2c_smbus_read_byte_data(client,
+								 tach_reg[i]);
+		}
+		data->count = i2c_smbus_read_byte_data(client,
+							MAX6650_REG_COUNT);
+		data->dac = i2c_smbus_read_byte_data(client, MAX6650_REG_DAC);
+
+		/*
+		 * Alarms are cleared on read in case the condition that
+		 * caused the alarm is removed. Keep the value latched here
+		 * for providing the register through different alarm files.
+		 */
+		data->alarm |= i2c_smbus_read_byte_data(client,
+							MAX6650_REG_ALARM);
+
+		data->last_updated = jiffies;
+		data->valid = 1;
+	}
+
+	mutex_unlock(&data->update_lock);
+
+	return data;
+}
+
 static ssize_t get_fan(struct device *dev, struct device_attribute *devattr,
 		       char *buf)
 {
@@ -539,64 +558,6 @@ static const struct attribute_group max6651_attr_grp = {
  * Real code
  */
 
-static int max6650_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
-{
-	struct max6650_data *data;
-	int err;
-
-	data = devm_kzalloc(&client->dev, sizeof(struct max6650_data),
-			    GFP_KERNEL);
-	if (!data) {
-		dev_err(&client->dev, "out of memory.\n");
-		return -ENOMEM;
-	}
-
-	i2c_set_clientdata(client, data);
-	mutex_init(&data->update_lock);
-	data->nr_fans = id->driver_data;
-
-	/*
-	 * Initialize the max6650 chip
-	 */
-	err = max6650_init_client(client);
-	if (err)
-		return err;
-
-	err = sysfs_create_group(&client->dev.kobj, &max6650_attr_grp);
-	if (err)
-		return err;
-	/* 3 additional fan inputs for the MAX6651 */
-	if (data->nr_fans = 4) {
-		err = sysfs_create_group(&client->dev.kobj, &max6651_attr_grp);
-		if (err)
-			goto err_remove;
-	}
-
-	data->hwmon_dev = hwmon_device_register(&client->dev);
-	if (!IS_ERR(data->hwmon_dev))
-		return 0;
-
-	err = PTR_ERR(data->hwmon_dev);
-	dev_err(&client->dev, "error registering hwmon device.\n");
-	if (data->nr_fans = 4)
-		sysfs_remove_group(&client->dev.kobj, &max6651_attr_grp);
-err_remove:
-	sysfs_remove_group(&client->dev.kobj, &max6650_attr_grp);
-	return err;
-}
-
-static int max6650_remove(struct i2c_client *client)
-{
-	struct max6650_data *data = i2c_get_clientdata(client);
-
-	hwmon_device_unregister(data->hwmon_dev);
-	if (data->nr_fans = 4)
-		sysfs_remove_group(&client->dev.kobj, &max6651_attr_grp);
-	sysfs_remove_group(&client->dev.kobj, &max6650_attr_grp);
-	return 0;
-}
-
 static int max6650_init_client(struct i2c_client *client)
 {
 	struct max6650_data *data = i2c_get_clientdata(client);
@@ -684,51 +645,80 @@ static int max6650_init_client(struct i2c_client *client)
 	return 0;
 }
 
-static const u8 tach_reg[] = {
-	MAX6650_REG_TACH0,
-	MAX6650_REG_TACH1,
-	MAX6650_REG_TACH2,
-	MAX6650_REG_TACH3,
-};
-
-static struct max6650_data *max6650_update_device(struct device *dev)
+static int max6650_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
 {
-	int i;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct max6650_data *data = i2c_get_clientdata(client);
+	struct max6650_data *data;
+	int err;
 
-	mutex_lock(&data->update_lock);
+	data = devm_kzalloc(&client->dev, sizeof(struct max6650_data),
+			    GFP_KERNEL);
+	if (!data) {
+		dev_err(&client->dev, "out of memory.\n");
+		return -ENOMEM;
+	}
 
-	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
-		data->speed = i2c_smbus_read_byte_data(client,
-						       MAX6650_REG_SPEED);
-		data->config = i2c_smbus_read_byte_data(client,
-							MAX6650_REG_CONFIG);
-		for (i = 0; i < data->nr_fans; i++) {
-			data->tach[i] = i2c_smbus_read_byte_data(client,
-								 tach_reg[i]);
-		}
-		data->count = i2c_smbus_read_byte_data(client,
-							MAX6650_REG_COUNT);
-		data->dac = i2c_smbus_read_byte_data(client, MAX6650_REG_DAC);
+	i2c_set_clientdata(client, data);
+	mutex_init(&data->update_lock);
+	data->nr_fans = id->driver_data;
 
-		/*
-		 * Alarms are cleared on read in case the condition that
-		 * caused the alarm is removed. Keep the value latched here
-		 * for providing the register through different alarm files.
-		 */
-		data->alarm |= i2c_smbus_read_byte_data(client,
-							MAX6650_REG_ALARM);
+	/*
+	 * Initialize the max6650 chip
+	 */
+	err = max6650_init_client(client);
+	if (err)
+		return err;
 
-		data->last_updated = jiffies;
-		data->valid = 1;
+	err = sysfs_create_group(&client->dev.kobj, &max6650_attr_grp);
+	if (err)
+		return err;
+	/* 3 additional fan inputs for the MAX6651 */
+	if (data->nr_fans = 4) {
+		err = sysfs_create_group(&client->dev.kobj, &max6651_attr_grp);
+		if (err)
+			goto err_remove;
 	}
 
-	mutex_unlock(&data->update_lock);
+	data->hwmon_dev = hwmon_device_register(&client->dev);
+	if (!IS_ERR(data->hwmon_dev))
+		return 0;
 
-	return data;
+	err = PTR_ERR(data->hwmon_dev);
+	dev_err(&client->dev, "error registering hwmon device.\n");
+	if (data->nr_fans = 4)
+		sysfs_remove_group(&client->dev.kobj, &max6651_attr_grp);
+err_remove:
+	sysfs_remove_group(&client->dev.kobj, &max6650_attr_grp);
+	return err;
 }
 
+static int max6650_remove(struct i2c_client *client)
+{
+	struct max6650_data *data = i2c_get_clientdata(client);
+
+	hwmon_device_unregister(data->hwmon_dev);
+	if (data->nr_fans = 4)
+		sysfs_remove_group(&client->dev.kobj, &max6651_attr_grp);
+	sysfs_remove_group(&client->dev.kobj, &max6650_attr_grp);
+	return 0;
+}
+
+static const struct i2c_device_id max6650_id[] = {
+	{ "max6650", 1 },
+	{ "max6651", 4 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, max6650_id);
+
+static struct i2c_driver max6650_driver = {
+	.driver = {
+		.name	= "max6650",
+	},
+	.probe		= max6650_probe,
+	.remove		= max6650_remove,
+	.id_table	= max6650_id,
+};
+
 module_i2c_driver(max6650_driver);
 
 MODULE_AUTHOR("Hans J. Koch");
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
