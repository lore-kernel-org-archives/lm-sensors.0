From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 18 Apr 2014 22:51:25 +0000
Subject: [lm-sensors] [PATCH 4/4] hwmon: (lm92) Convert to use devm_hwmon_device_register_with_groups
Message-Id: <1397861485-31740-4-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use devm_hwmon_device_register_with_groups API to attach attributes
to hwmon device, simplify code, and reduce code size.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm92.c |   56 ++++++++++++++------------------------------------
 1 file changed, 15 insertions(+), 41 deletions(-)

diff --git a/drivers/hwmon/lm92.c b/drivers/hwmon/lm92.c
index faa9a65..64238a3 100644
--- a/drivers/hwmon/lm92.c
+++ b/drivers/hwmon/lm92.c
@@ -108,7 +108,7 @@ static u8 regs[] = {
 
 /* Client data (each client gets its own) */
 struct lm92_data {
-	struct device *hwmon_dev;
+	struct i2c_client *client;
 	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
@@ -123,8 +123,8 @@ struct lm92_data {
 
 static struct lm92_data *lm92_update_device(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm92_data *data = i2c_get_clientdata(client);
+	struct lm92_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int i;
 
 	mutex_lock(&data->update_lock);
@@ -158,8 +158,8 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *devattr,
 			   const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm92_data *data = i2c_get_clientdata(client);
+	struct lm92_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int nr = attr->index;
 	long val;
 	int err = kstrtol(buf, 10, &val);
@@ -195,8 +195,8 @@ static ssize_t set_temp_hyst(struct device *dev,
 			     const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm92_data *data = i2c_get_clientdata(client);
+	struct lm92_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long val;
 	int err;
 
@@ -314,7 +314,7 @@ static int max6635_check(struct i2c_client *client)
 	return 1;
 }
 
-static struct attribute *lm92_attributes[] = {
+static struct attribute *lm92_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	&sensor_dev_attr_temp1_crit.dev_attr.attr,
 	&sensor_dev_attr_temp1_crit_hyst.dev_attr.attr,
@@ -328,10 +328,7 @@ static struct attribute *lm92_attributes[] = {
 	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
 	NULL
 };
-
-static const struct attribute_group lm92_group = {
-	.attrs = lm92_attributes,
-};
+ATTRIBUTE_GROUPS(lm92);
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
 static int lm92_detect(struct i2c_client *new_client,
@@ -363,46 +360,24 @@ static int lm92_detect(struct i2c_client *new_client,
 static int lm92_probe(struct i2c_client *new_client,
 		      const struct i2c_device_id *id)
 {
+	struct device *hwmon_dev;
 	struct lm92_data *data;
-	int err;
 
 	data = devm_kzalloc(&new_client->dev, sizeof(struct lm92_data),
 			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	i2c_set_clientdata(new_client, data);
+	data->client = new_client;
 	mutex_init(&data->update_lock);
 
 	/* Initialize the chipset */
 	lm92_init_client(new_client);
 
-	/* Register sysfs hooks */
-	err = sysfs_create_group(&new_client->dev.kobj, &lm92_group);
-	if (err)
-		return err;
-
-	data->hwmon_dev = hwmon_device_register(&new_client->dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		err = PTR_ERR(data->hwmon_dev);
-		goto exit_remove;
-	}
-
-	return 0;
-
-exit_remove:
-	sysfs_remove_group(&new_client->dev.kobj, &lm92_group);
-	return err;
-}
-
-static int lm92_remove(struct i2c_client *client)
-{
-	struct lm92_data *data = i2c_get_clientdata(client);
-
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &lm92_group);
-
-	return 0;
+	hwmon_dev = devm_hwmon_device_register_with_groups(&new_client->dev,
+							   new_client->name,
+							   data, lm92_groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 
@@ -423,7 +398,6 @@ static struct i2c_driver lm92_driver = {
 		.name	= "lm92",
 	},
 	.probe		= lm92_probe,
-	.remove		= lm92_remove,
 	.id_table	= lm92_id,
 	.detect		= lm92_detect,
 	.address_list	= normal_i2c,
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
