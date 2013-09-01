From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 01 Sep 2013 02:48:58 +0000
Subject: [lm-sensors] [PATCH v2 5/9] hwmon: (pmbus) Convert to use hwmon_device_register_with_groups
Message-Id: <1378003742-18685-6-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1378003742-18685-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1378003742-18685-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pmbus/pmbus_core.c |   20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 9319fcf..e2c34a5 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -97,6 +97,7 @@ struct pmbus_data {
 	int max_attributes;
 	int num_attributes;
 	struct attribute_group group;
+	const struct attribute_group *groups[2];
 
 	struct pmbus_sensor *sensors;
 
@@ -348,7 +349,7 @@ static struct _pmbus_status {
 
 static struct pmbus_data *pmbus_update_device(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
+	struct i2c_client *client = to_i2c_client(dev->parent);
 	struct pmbus_data *data = i2c_get_clientdata(client);
 	const struct pmbus_driver_info *info = data->info;
 	struct pmbus_sensor *sensor;
@@ -733,7 +734,7 @@ static ssize_t pmbus_set_sensor(struct device *dev,
 				struct device_attribute *devattr,
 				const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
+	struct i2c_client *client = to_i2c_client(dev->parent);
 	struct pmbus_data *data = i2c_get_clientdata(client);
 	struct pmbus_sensor *sensor = to_pmbus_sensor(devattr);
 	ssize_t rv = count;
@@ -1768,22 +1769,16 @@ int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
 		goto out_kfree;
 	}
 
-	/* Register sysfs hooks */
-	ret = sysfs_create_group(&dev->kobj, &data->group);
-	if (ret) {
-		dev_err(dev, "Failed to create sysfs entries\n");
-		goto out_kfree;
-	}
-	data->hwmon_dev = hwmon_device_register(dev);
+	data->groups[0] = &data->group;
+	data->hwmon_dev = hwmon_device_register_with_groups(dev, client->name,
+							    data, data->groups);
 	if (IS_ERR(data->hwmon_dev)) {
 		ret = PTR_ERR(data->hwmon_dev);
 		dev_err(dev, "Failed to register hwmon device\n");
-		goto out_hwmon_device_register;
+		goto out_kfree;
 	}
 	return 0;
 
-out_hwmon_device_register:
-	sysfs_remove_group(&dev->kobj, &data->group);
 out_kfree:
 	kfree(data->group.attrs);
 	return ret;
@@ -1794,7 +1789,6 @@ int pmbus_do_remove(struct i2c_client *client)
 {
 	struct pmbus_data *data = i2c_get_clientdata(client);
 	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &data->group);
 	kfree(data->group.attrs);
 	return 0;
 }
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
