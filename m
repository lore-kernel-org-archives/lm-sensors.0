From: Axel Lin <axel.lin@ingics.com>
Date: Sun, 29 Jun 2014 01:42:17 +0000
Subject: [lm-sensors] [RFT][PATCH 2/2] hwmon: (adm1029) Convert to devm_hwmon_device_register_with_groups
Message-Id: <1404006137.19191.2.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/adm1029.c | 55 ++++++++++++++-----------------------------------
 1 file changed, 15 insertions(+), 40 deletions(-)

diff --git a/drivers/hwmon/adm1029.c b/drivers/hwmon/adm1029.c
index 7782de9..1cd11b3 100644
--- a/drivers/hwmon/adm1029.c
+++ b/drivers/hwmon/adm1029.c
@@ -110,7 +110,7 @@ static const u8 ADM1029_REG_FAN_DIV[] = {
  */
 
 struct adm1029_data {
-	struct device *hwmon_dev;
+	struct i2c_client *client;
 	struct mutex update_lock;
 	char valid;		/* zero until following fields are valid */
 	unsigned long last_updated;	/* in jiffies */
@@ -126,8 +126,8 @@ struct adm1029_data {
  */
 static struct adm1029_data *adm1029_update_device(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1029_data *data = i2c_get_clientdata(client);
+	struct adm1029_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 
 	mutex_lock(&data->update_lock);
 	/*
@@ -207,8 +207,8 @@ show_fan_div(struct device *dev, struct device_attribute *devattr, char *buf)
 static ssize_t set_fan_div(struct device *dev,
 	    struct device_attribute *devattr, const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1029_data *data = i2c_get_clientdata(client);
+	struct adm1029_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	u8 reg;
 	long val;
@@ -277,7 +277,7 @@ static SENSOR_DEVICE_ATTR(fan1_div, S_IRUGO | S_IWUSR,
 static SENSOR_DEVICE_ATTR(fan2_div, S_IRUGO | S_IWUSR,
 			  show_fan_div, set_fan_div, 1);
 
-static struct attribute *adm1029_attributes[] = {
+static struct attribute *adm1029_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	&sensor_dev_attr_temp1_min.dev_attr.attr,
 	&sensor_dev_attr_temp1_max.dev_attr.attr,
@@ -296,9 +296,7 @@ static struct attribute *adm1029_attributes[] = {
 	NULL
 };
 
-static const struct attribute_group adm1029_group = {
-	.attrs = adm1029_attributes,
-};
+ATTRIBUTE_GROUPS(adm1029);
 
 /*
  * Real code
@@ -368,15 +366,15 @@ static int adm1029_init_client(struct i2c_client *client)
 static int adm1029_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
+	struct device *dev = &client->dev;
 	struct adm1029_data *data;
-	int err;
+	struct device *hwmon_dev;
 
-	data = devm_kzalloc(&client->dev, sizeof(struct adm1029_data),
-			    GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(struct adm1029_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	i2c_set_clientdata(client, data);
+	data->client = client;
 	mutex_init(&data->update_lock);
 
 	/*
@@ -386,32 +384,10 @@ static int adm1029_probe(struct i2c_client *client,
 	if (adm1029_init_client(client) = 0)
 		return -ENODEV;
 
-	/* Register sysfs hooks */
-	err = sysfs_create_group(&client->dev.kobj, &adm1029_group);
-	if (err)
-		return err;
-
-	data->hwmon_dev = hwmon_device_register(&client->dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		err = PTR_ERR(data->hwmon_dev);
-		goto exit_remove_files;
-	}
-
-	return 0;
-
- exit_remove_files:
-	sysfs_remove_group(&client->dev.kobj, &adm1029_group);
-	return err;
-}
-
-static int adm1029_remove(struct i2c_client *client)
-{
-	struct adm1029_data *data = i2c_get_clientdata(client);
-
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &adm1029_group);
-
-	return 0;
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
+							   data,
+							   adm1029_groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 static const struct i2c_device_id adm1029_id[] = {
@@ -426,7 +402,6 @@ static struct i2c_driver adm1029_driver = {
 		.name = "adm1029",
 	},
 	.probe		= adm1029_probe,
-	.remove		= adm1029_remove,
 	.id_table	= adm1029_id,
 	.detect		= adm1029_detect,
 	.address_list	= normal_i2c,
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
