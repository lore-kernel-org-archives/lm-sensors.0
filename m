From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 23 Jul 2014 04:39:21 +0000
Subject: [lm-sensors] [RFT][PATCH] hwmon: (lm78) Convert to devm_hwmon_device_register_with_groups
Message-Id: <1406090361.15290.7.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/lm78.c | 98 ++++++++--------------------------------------------
 1 file changed, 15 insertions(+), 83 deletions(-)

diff --git a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
index 9efadfc..668bcdf 100644
--- a/drivers/hwmon/lm78.c
+++ b/drivers/hwmon/lm78.c
@@ -123,7 +123,6 @@ static inline int TEMP_FROM_REG(s8 val)
 
 struct lm78_data {
 	struct i2c_client *client;
-	struct device *hwmon_dev;
 	struct mutex lock;
 	enum chips type;
 
@@ -468,7 +467,7 @@ static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_alarm, NULL, 7);
 static SENSOR_DEVICE_ATTR(fan3_alarm, S_IRUGO, show_alarm, NULL, 11);
 static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 4);
 
-static struct attribute *lm78_attributes[] = {
+static struct attribute *lm78_attrs[] = {
 	&sensor_dev_attr_in0_input.dev_attr.attr,
 	&sensor_dev_attr_in0_min.dev_attr.attr,
 	&sensor_dev_attr_in0_max.dev_attr.attr,
@@ -519,9 +518,7 @@ static struct attribute *lm78_attributes[] = {
 	NULL
 };
 
-static const struct attribute_group lm78_group = {
-	.attrs = lm78_attributes,
-};
+ATTRIBUTE_GROUPS(lm78);
 
 /*
  * ISA related code
@@ -533,19 +530,6 @@ static struct platform_device *pdev;
 
 static unsigned short isa_address = 0x290;
 
-/*
- * I2C devices get this name attribute automatically, but for ISA devices
- * we must create it by ourselves.
- */
-static ssize_t show_name(struct device *dev, struct device_attribute
-			 *devattr, char *buf)
-{
-	struct lm78_data *data = dev_get_drvdata(dev);
-
-	return sprintf(buf, "%s\n", data->name);
-}
-static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
-
 static struct lm78_data *lm78_data_if_isa(void)
 {
 	return pdev ? platform_get_drvdata(pdev) : NULL;
@@ -661,46 +645,23 @@ static int lm78_i2c_detect(struct i2c_client *client,
 static int lm78_i2c_probe(struct i2c_client *client,
 			  const struct i2c_device_id *id)
 {
+	struct device *dev = &client->dev;
+	struct device *hwmon_dev;
 	struct lm78_data *data;
-	int err;
 
-	data = devm_kzalloc(&client->dev, sizeof(struct lm78_data), GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(struct lm78_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	i2c_set_clientdata(client, data);
 	data->client = client;
 	data->type = id->driver_data;
 
 	/* Initialize the LM78 chip */
 	lm78_init_device(data);
 
-	/* Register sysfs hooks */
-	err = sysfs_create_group(&client->dev.kobj, &lm78_group);
-	if (err)
-		return err;
-
-	data->hwmon_dev = hwmon_device_register(&client->dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		err = PTR_ERR(data->hwmon_dev);
-		goto error;
-	}
-
-	return 0;
-
-error:
-	sysfs_remove_group(&client->dev.kobj, &lm78_group);
-	return err;
-}
-
-static int lm78_i2c_remove(struct i2c_client *client)
-{
-	struct lm78_data *data = i2c_get_clientdata(client);
-
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &lm78_group);
-
-	return 0;
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
+							   data, lm78_groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 static const struct i2c_device_id lm78_i2c_id[] = {
@@ -716,7 +677,6 @@ static struct i2c_driver lm78_driver = {
 		.name	= "lm78",
 	},
 	.probe		= lm78_i2c_probe,
-	.remove		= lm78_i2c_remove,
 	.id_table	= lm78_i2c_id,
 	.detect		= lm78_i2c_detect,
 	.address_list	= normal_i2c,
@@ -839,17 +799,18 @@ static struct lm78_data *lm78_update_device(struct device *dev)
 #ifdef CONFIG_ISA
 static int lm78_isa_probe(struct platform_device *pdev)
 {
-	int err;
+	struct device *dev = &pdev->dev;
+	struct device *hwmon_dev;
 	struct lm78_data *data;
 	struct resource *res;
 
 	/* Reserve the ISA region */
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
-	if (!devm_request_region(&pdev->dev, res->start + LM78_ADDR_REG_OFFSET,
+	if (!devm_request_region(dev, res->start + LM78_ADDR_REG_OFFSET,
 				 2, "lm78"))
 		return -EBUSY;
 
-	data = devm_kzalloc(&pdev->dev, sizeof(struct lm78_data), GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(struct lm78_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -868,37 +829,9 @@ static int lm78_isa_probe(struct platform_device *pdev)
 	/* Initialize the LM78 chip */
 	lm78_init_device(data);
 
-	/* Register sysfs hooks */
-	err = sysfs_create_group(&pdev->dev.kobj, &lm78_group);
-	if (err)
-		goto exit_remove_files;
-	err = device_create_file(&pdev->dev, &dev_attr_name);
-	if (err)
-		goto exit_remove_files;
-
-	data->hwmon_dev = hwmon_device_register(&pdev->dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		err = PTR_ERR(data->hwmon_dev);
-		goto exit_remove_files;
-	}
-
-	return 0;
-
- exit_remove_files:
-	sysfs_remove_group(&pdev->dev.kobj, &lm78_group);
-	device_remove_file(&pdev->dev, &dev_attr_name);
-	return err;
-}
-
-static int lm78_isa_remove(struct platform_device *pdev)
-{
-	struct lm78_data *data = platform_get_drvdata(pdev);
-
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&pdev->dev.kobj, &lm78_group);
-	device_remove_file(&pdev->dev, &dev_attr_name);
-
-	return 0;
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, data->name,
+							   data, lm78_groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 static struct platform_driver lm78_isa_driver = {
@@ -907,7 +840,6 @@ static struct platform_driver lm78_isa_driver = {
 		.name	= "lm78",
 	},
 	.probe		= lm78_isa_probe,
-	.remove		= lm78_isa_remove,
 };
 
 /* return 1 if a supported chip is found, 0 otherwise */
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
