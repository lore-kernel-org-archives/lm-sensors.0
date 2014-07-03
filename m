From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 03 Jul 2014 14:01:48 +0000
Subject: [lm-sensors] [RFT][PATCH 2/2] hwmon: (adm9240) Convert to devm_hwmon_device_register_with_groups
Message-Id: <1404396108.4895.13.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/adm9240.c | 74 +++++++++++++++++--------------------------------
 1 file changed, 26 insertions(+), 48 deletions(-)

diff --git a/drivers/hwmon/adm9240.c b/drivers/hwmon/adm9240.c
index 8235ae4..98114ce 100644
--- a/drivers/hwmon/adm9240.c
+++ b/drivers/hwmon/adm9240.c
@@ -132,7 +132,7 @@ static inline unsigned int AOUT_FROM_REG(u8 reg)
 
 /* per client data */
 struct adm9240_data {
-	struct device *hwmon_dev;
+	struct i2c_client *client;
 	struct mutex update_lock;
 	char valid;
 	unsigned long last_updated_measure;
@@ -170,8 +170,8 @@ static void adm9240_write_fan_div(struct i2c_client *client, int nr,
 
 static struct adm9240_data *adm9240_update_device(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm9240_data *data = i2c_get_clientdata(client);
+	struct adm9240_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int i;
 
 	mutex_lock(&data->update_lock);
@@ -278,8 +278,8 @@ static ssize_t set_max(struct device *dev, struct device_attribute *devattr,
 		const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm9240_data *data = i2c_get_clientdata(client);
+	struct adm9240_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long val;
 	int err;
 
@@ -334,8 +334,8 @@ static ssize_t set_in_min(struct device *dev,
 		const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm9240_data *data = i2c_get_clientdata(client);
+	struct adm9240_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	unsigned long val;
 	int err;
 
@@ -356,8 +356,8 @@ static ssize_t set_in_max(struct device *dev,
 		const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm9240_data *data = i2c_get_clientdata(client);
+	struct adm9240_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	unsigned long val;
 	int err;
 
@@ -431,8 +431,8 @@ static ssize_t set_fan_min(struct device *dev,
 		const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm9240_data *data = i2c_get_clientdata(client);
+	struct adm9240_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int nr = attr->index;
 	u8 new_div;
 	unsigned long val;
@@ -544,8 +544,8 @@ static ssize_t set_aout(struct device *dev,
 		struct device_attribute *attr,
 		const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm9240_data *data = i2c_get_clientdata(client);
+	struct adm9240_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long val;
 	int err;
 
@@ -565,8 +565,8 @@ static ssize_t chassis_clear(struct device *dev,
 		struct device_attribute *attr,
 		const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm9240_data *data = i2c_get_clientdata(client);
+	struct adm9240_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	unsigned long val;
 
 	if (kstrtoul(buf, 10, &val) || val != 0)
@@ -583,7 +583,7 @@ static ssize_t chassis_clear(struct device *dev,
 static SENSOR_DEVICE_ATTR(intrusion0_alarm, S_IRUGO | S_IWUSR, show_alarm,
 		chassis_clear, 12);
 
-static struct attribute *adm9240_attributes[] = {
+static struct attribute *adm9240_attrs[] = {
 	&sensor_dev_attr_in0_input.dev_attr.attr,
 	&sensor_dev_attr_in0_min.dev_attr.attr,
 	&sensor_dev_attr_in0_max.dev_attr.attr,
@@ -627,9 +627,7 @@ static struct attribute *adm9240_attributes[] = {
 	NULL
 };
 
-static const struct attribute_group adm9240_group = {
-	.attrs = adm9240_attributes,
-};
+ATTRIBUTE_GROUPS(adm9240);
 
 
 /*** sensor chip detect and driver install ***/
@@ -724,44 +722,25 @@ static void adm9240_init_client(struct i2c_client *client)
 static int adm9240_probe(struct i2c_client *new_client,
 			 const struct i2c_device_id *id)
 {
+	struct device *dev = &new_client->dev;
+	struct device *hwmon_dev;
 	struct adm9240_data *data;
-	int err;
 
-	data = devm_kzalloc(&new_client->dev, sizeof(*data), GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
 	i2c_set_clientdata(new_client, data);
+	data->client = new_client;
 	mutex_init(&data->update_lock);
 
 	adm9240_init_client(new_client);
 
-	/* populate sysfs filesystem */
-	err = sysfs_create_group(&new_client->dev.kobj, &adm9240_group);
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
-	sysfs_remove_group(&new_client->dev.kobj, &adm9240_group);
-	return err;
-}
-
-static int adm9240_remove(struct i2c_client *client)
-{
-	struct adm9240_data *data = i2c_get_clientdata(client);
-
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &adm9240_group);
-
-	return 0;
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev,
+							   new_client->name,
+							   data,
+							   adm9240_groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 static const struct i2c_device_id adm9240_id[] = {
@@ -778,7 +757,6 @@ static struct i2c_driver adm9240_driver = {
 		.name	= "adm9240",
 	},
 	.probe		= adm9240_probe,
-	.remove		= adm9240_remove,
 	.id_table	= adm9240_id,
 	.detect		= adm9240_detect,
 	.address_list	= normal_i2c,
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
