From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 01 Jul 2014 14:40:29 +0000
Subject: [lm-sensors] [RFT][PATCH 2/2] hwmon: (ad7418) Convert to devm_hwmon_device_register_with_groups
Message-Id: <1404225629.17487.8.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/ad7418.c | 65 +++++++++++++++++++-------------------------------
 1 file changed, 24 insertions(+), 41 deletions(-)

diff --git a/drivers/hwmon/ad7418.c b/drivers/hwmon/ad7418.c
index f7bf429..a01b731 100644
--- a/drivers/hwmon/ad7418.c
+++ b/drivers/hwmon/ad7418.c
@@ -44,8 +44,7 @@ static const u8 AD7418_REG_TEMP[] = { AD7418_REG_TEMP_IN,
 					AD7418_REG_TEMP_OS };
 
 struct ad7418_data {
-	struct device		*hwmon_dev;
-	struct attribute_group	attrs;
+	struct i2c_client	*client;
 	enum chips		type;
 	struct mutex		lock;
 	int			adc_max;	/* number of ADC channels */
@@ -57,8 +56,8 @@ struct ad7418_data {
 
 static struct ad7418_data *ad7418_update_device(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct ad7418_data *data = i2c_get_clientdata(client);
+	struct ad7418_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 
 	mutex_lock(&data->lock);
 
@@ -127,8 +126,8 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *devattr,
 			const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct ad7418_data *data = i2c_get_clientdata(client);
+	struct ad7418_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long temp;
 	int ret = kstrtol(buf, 10, &temp);
 
@@ -155,14 +154,15 @@ static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, show_adc, NULL, 1);
 static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO, show_adc, NULL, 2);
 static SENSOR_DEVICE_ATTR(in4_input, S_IRUGO, show_adc, NULL, 3);
 
-static struct attribute *ad7416_attributes[] = {
+static struct attribute *ad7416_attrs[] = {
 	&sensor_dev_attr_temp1_max.dev_attr.attr,
 	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	NULL
 };
+ATTRIBUTE_GROUPS(ad7416);
 
-static struct attribute *ad7417_attributes[] = {
+static struct attribute *ad7417_attrs[] = {
 	&sensor_dev_attr_temp1_max.dev_attr.attr,
 	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
@@ -172,14 +172,16 @@ static struct attribute *ad7417_attributes[] = {
 	&sensor_dev_attr_in4_input.dev_attr.attr,
 	NULL
 };
+ATTRIBUTE_GROUPS(ad7417);
 
-static struct attribute *ad7418_attributes[] = {
+static struct attribute *ad7418_attrs[] = {
 	&sensor_dev_attr_temp1_max.dev_attr.attr,
 	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	&sensor_dev_attr_in1_input.dev_attr.attr,
 	NULL
 };
+ATTRIBUTE_GROUPS(ad7418);
 
 static void ad7418_init_client(struct i2c_client *client)
 {
@@ -201,70 +203,52 @@ static void ad7418_init_client(struct i2c_client *client)
 static int ad7418_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
+	struct device *dev = &client->dev;
 	struct i2c_adapter *adapter = client->adapter;
 	struct ad7418_data *data;
-	int err;
+	struct device *hwmon_dev;
+	const struct attribute_group **attr_groups = NULL;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
 					I2C_FUNC_SMBUS_WORD_DATA))
 		return -EOPNOTSUPP;
 
-	data = devm_kzalloc(&client->dev, sizeof(struct ad7418_data),
-			    GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(struct ad7418_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
 	i2c_set_clientdata(client, data);
 
 	mutex_init(&data->lock);
+	data->client = client;
 	data->type = id->driver_data;
 
 	switch (data->type) {
 	case ad7416:
 		data->adc_max = 0;
-		data->attrs.attrs = ad7416_attributes;
+		attr_groups = ad7416_groups;
 		break;
 
 	case ad7417:
 		data->adc_max = 4;
-		data->attrs.attrs = ad7417_attributes;
+		attr_groups = ad7417_groups;
 		break;
 
 	case ad7418:
 		data->adc_max = 1;
-		data->attrs.attrs = ad7418_attributes;
+		attr_groups = ad7418_groups;
 		break;
 	}
 
-	dev_info(&client->dev, "%s chip found\n", client->name);
+	dev_info(dev, "%s chip found\n", client->name);
 
 	/* Initialize the AD7418 chip */
 	ad7418_init_client(client);
 
-	/* Register sysfs hooks */
-	err = sysfs_create_group(&client->dev.kobj, &data->attrs);
-	if (err)
-		return err;
-
-	data->hwmon_dev = hwmon_device_register(&client->dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		err = PTR_ERR(data->hwmon_dev);
-		goto exit_remove;
-	}
-
-	return 0;
-
-exit_remove:
-	sysfs_remove_group(&client->dev.kobj, &data->attrs);
-	return err;
-}
-
-static int ad7418_remove(struct i2c_client *client)
-{
-	struct ad7418_data *data = i2c_get_clientdata(client);
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &data->attrs);
-	return 0;
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev,
+							   client->name,
+							   data, attr_groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 static const struct i2c_device_id ad7418_id[] = {
@@ -280,7 +264,6 @@ static struct i2c_driver ad7418_driver = {
 		.name	= "ad7418",
 	},
 	.probe		= ad7418_probe,
-	.remove		= ad7418_remove,
 	.id_table	= ad7418_id,
 };
 
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
