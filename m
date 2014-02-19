From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 19 Feb 2014 01:01:19 +0000
Subject: [lm-sensors] [PATCH v2 4/4] hwmon: (lm90) Convert to use hwmon_device_register_with_groups
Message-Id: <1392771679-14666-4-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Simplify code, reduce code size, and attach hwmon attributes to hwmon device.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: The 'pec' attribute is still attached to the i2c device.
    Reversed parameter order for lm90_init_client()

TBD: Should log messages be attached to the hwmon device ?
     If so I'd probably submit a separate patch for it.

I tested this with MAX6695. Given that the pec attribute is now handled
differently, it might make sense to test this chip explicitly.
Jean, do you have one available, at least in simulation ?

 drivers/hwmon/lm90.c |   39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 9ad7401..c9ff08d 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -365,6 +365,7 @@ enum lm90_temp11_reg_index {
  */
 
 struct lm90_data {
+	struct i2c_client *client;
 	struct device *hwmon_dev;
 	const struct attribute_group *groups[6];
 	struct mutex update_lock;
@@ -514,8 +515,8 @@ static void lm90_set_convrate(struct i2c_client *client, struct lm90_data *data,
 
 static struct lm90_data *lm90_update_device(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm90_data *data = i2c_get_clientdata(client);
+	struct lm90_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	unsigned long next_update;
 
 	mutex_lock(&data->update_lock);
@@ -794,8 +795,8 @@ static ssize_t set_temp8(struct device *dev, struct device_attribute *devattr,
 	};
 
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm90_data *data = i2c_get_clientdata(client);
+	struct lm90_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int nr = attr->index;
 	long val;
 	int err;
@@ -861,8 +862,8 @@ static ssize_t set_temp11(struct device *dev, struct device_attribute *devattr,
 	};
 
 	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm90_data *data = i2c_get_clientdata(client);
+	struct lm90_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int nr = attr->nr;
 	int index = attr->index;
 	long val;
@@ -923,8 +924,8 @@ static ssize_t show_temphyst(struct device *dev,
 static ssize_t set_temphyst(struct device *dev, struct device_attribute *dummy,
 			    const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm90_data *data = i2c_get_clientdata(client);
+	struct lm90_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long val;
 	int err;
 	int temp;
@@ -977,8 +978,8 @@ static ssize_t set_update_interval(struct device *dev,
 				   struct device_attribute *attr,
 				   const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm90_data *data = i2c_get_clientdata(client);
+	struct lm90_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	unsigned long val;
 	int err;
 
@@ -1412,10 +1413,9 @@ static void lm90_restore_conf(struct i2c_client *client, struct lm90_data *data)
 				  data->config_orig);
 }
 
-static void lm90_init_client(struct i2c_client *client)
+static void lm90_init_client(struct i2c_client *client, struct lm90_data *data)
 {
 	u8 config, convrate;
-	struct lm90_data *data = i2c_get_clientdata(client);
 
 	if (lm90_read_reg(client, LM90_REG_R_CONVRATE, &convrate) < 0) {
 		dev_warn(&client->dev, "Failed to read convrate register!\n");
@@ -1530,6 +1530,7 @@ static int lm90_probe(struct i2c_client *client,
 	if (!data)
 		return -ENOMEM;
 
+	data->client = client;
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
 
@@ -1556,7 +1557,7 @@ static int lm90_probe(struct i2c_client *client,
 	data->max_convrate = lm90_params[data->kind].max_convrate;
 
 	/* Initialize the LM90 chip */
-	lm90_init_client(client);
+	lm90_init_client(client, data);
 
 	/* Register sysfs hooks */
 	data->groups[groups++] = &lm90_group;
@@ -1579,14 +1580,11 @@ static int lm90_probe(struct i2c_client *client,
 			goto exit_restore;
 	}
 
-	err = sysfs_create_groups(&dev->kobj, data->groups);
-	if (err)
-		goto exit_remove_pec;
-
-	data->hwmon_dev = hwmon_device_register(dev);
+	data->hwmon_dev = hwmon_device_register_with_groups(dev, client->name,
+							    data, data->groups);
 	if (IS_ERR(data->hwmon_dev)) {
 		err = PTR_ERR(data->hwmon_dev);
-		goto exit_remove_files;
+		goto exit_remove_pec;
 	}
 
 	if (client->irq) {
@@ -1605,8 +1603,6 @@ static int lm90_probe(struct i2c_client *client,
 
 exit_unregister:
 	hwmon_device_unregister(data->hwmon_dev);
-exit_remove_files:
-	sysfs_remove_groups(&dev->kobj, data->groups);
 exit_remove_pec:
 	device_remove_file(dev, &dev_attr_pec);
 exit_restore:
@@ -1621,7 +1617,6 @@ static int lm90_remove(struct i2c_client *client)
 	struct lm90_data *data = i2c_get_clientdata(client);
 
 	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_groups(&client->dev.kobj, data->groups);
 	device_remove_file(&client->dev, &dev_attr_pec);
 	lm90_restore_conf(client, data);
 	regulator_disable(data->regulator);
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
