From: Axel Lin <axel.lin@ingics.com>
Date: Sun, 29 Jun 2014 03:32:01 +0000
Subject: [lm-sensors] [RFT][PATCH] hwmon: (emc6w201) Convert to devm_hwmon_device_register_with_groups
Message-Id: <1404012721.27831.1.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/emc6w201.c | 64 ++++++++++++++----------------------------------
 1 file changed, 19 insertions(+), 45 deletions(-)

diff --git a/drivers/hwmon/emc6w201.c b/drivers/hwmon/emc6w201.c
index f76a74c..e87da90 100644
--- a/drivers/hwmon/emc6w201.c
+++ b/drivers/hwmon/emc6w201.c
@@ -56,7 +56,7 @@ enum subfeature { input, min, max };
  */
 
 struct emc6w201_data {
-	struct device *hwmon_dev;
+	struct i2c_client *client;
 	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
@@ -134,8 +134,8 @@ static int emc6w201_write8(struct i2c_client *client, u8 reg, u8 val)
 
 static struct emc6w201_data *emc6w201_update_device(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct emc6w201_data *data = i2c_get_clientdata(client);
+	struct emc6w201_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int nr;
 
 	mutex_lock(&data->update_lock);
@@ -203,8 +203,8 @@ static ssize_t show_in(struct device *dev, struct device_attribute *devattr,
 static ssize_t set_in(struct device *dev, struct device_attribute *devattr,
 		      const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct emc6w201_data *data = i2c_get_clientdata(client);
+	struct emc6w201_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int sf = to_sensor_dev_attr_2(devattr)->index;
 	int nr = to_sensor_dev_attr_2(devattr)->nr;
 	int err;
@@ -240,8 +240,8 @@ static ssize_t show_temp(struct device *dev, struct device_attribute *devattr,
 static ssize_t set_temp(struct device *dev, struct device_attribute *devattr,
 			const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct emc6w201_data *data = i2c_get_clientdata(client);
+	struct emc6w201_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int sf = to_sensor_dev_attr_2(devattr)->index;
 	int nr = to_sensor_dev_attr_2(devattr)->nr;
 	int err;
@@ -283,8 +283,8 @@ static ssize_t show_fan(struct device *dev, struct device_attribute *devattr,
 static ssize_t set_fan(struct device *dev, struct device_attribute *devattr,
 		       const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct emc6w201_data *data = i2c_get_clientdata(client);
+	struct emc6w201_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int sf = to_sensor_dev_attr_2(devattr)->index;
 	int nr = to_sensor_dev_attr_2(devattr)->nr;
 	int err;
@@ -388,7 +388,7 @@ static SENSOR_DEVICE_ATTR_2(fan5_input, S_IRUGO, show_fan, NULL, 4, input);
 static SENSOR_DEVICE_ATTR_2(fan5_min, S_IRUGO | S_IWUSR, show_fan, set_fan,
 			    4, min);
 
-static struct attribute *emc6w201_attributes[] = {
+static struct attribute *emc6w201_attrs[] = {
 	&sensor_dev_attr_in0_input.dev_attr.attr,
 	&sensor_dev_attr_in0_min.dev_attr.attr,
 	&sensor_dev_attr_in0_max.dev_attr.attr,
@@ -440,9 +440,7 @@ static struct attribute *emc6w201_attributes[] = {
 	NULL
 };
 
-static const struct attribute_group emc6w201_group = {
-	.attrs = emc6w201_attributes,
-};
+ATTRIBUTE_GROUPS(emc6w201);
 
 /*
  * Driver interface
@@ -488,44 +486,21 @@ static int emc6w201_detect(struct i2c_client *client,
 static int emc6w201_probe(struct i2c_client *client,
 			  const struct i2c_device_id *id)
 {
+	struct device *dev = &client->dev;
 	struct emc6w201_data *data;
-	int err;
+	struct device *hwmon_dev;
 
-	data = devm_kzalloc(&client->dev, sizeof(struct emc6w201_data),
-			    GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(struct emc6w201_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	i2c_set_clientdata(client, data);
+	data->client = client;
 	mutex_init(&data->update_lock);
 
-	/* Create sysfs attribute */
-	err = sysfs_create_group(&client->dev.kobj, &emc6w201_group);
-	if (err)
-		return err;
-
-	/* Expose as a hwmon device */
-	data->hwmon_dev = hwmon_device_register(&client->dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		err = PTR_ERR(data->hwmon_dev);
-		goto exit_remove;
-	}
-
-	return 0;
-
- exit_remove:
-	sysfs_remove_group(&client->dev.kobj, &emc6w201_group);
-	return err;
-}
-
-static int emc6w201_remove(struct i2c_client *client)
-{
-	struct emc6w201_data *data = i2c_get_clientdata(client);
-
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &emc6w201_group);
-
-	return 0;
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
+							   data,
+							   emc6w201_groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 static const struct i2c_device_id emc6w201_id[] = {
@@ -540,7 +515,6 @@ static struct i2c_driver emc6w201_driver = {
 		.name	= "emc6w201",
 	},
 	.probe		= emc6w201_probe,
-	.remove		= emc6w201_remove,
 	.id_table	= emc6w201_id,
 	.detect		= emc6w201_detect,
 	.address_list	= normal_i2c,
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
