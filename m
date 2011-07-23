From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 23 Jul 2011 16:07:35 +0000
Subject: [lm-sensors] [PATCH 1/3] hwmon: (lm78) Avoid forward declarations
Message-Id: <20110723180735.2743321a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Move code around to avoid several forward declarations. Also group
ISA-related functions together, to make future changes easier.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Dean Nelson <dnelson@redhat.com>
---
 drivers/hwmon/lm78.c |  205 +++++++++++++++++++++++---------------------------
 1 file changed, 98 insertions(+), 107 deletions(-)

--- linux-3.0-rc7.orig/drivers/hwmon/lm78.c	2011-07-22 22:49:24.000000000 +0200
+++ linux-3.0-rc7/drivers/hwmon/lm78.c	2011-07-22 22:55:39.000000000 +0200
@@ -143,50 +143,12 @@ struct lm78_data {
 };
 
 
-static int lm78_i2c_detect(struct i2c_client *client,
-			   struct i2c_board_info *info);
-static int lm78_i2c_probe(struct i2c_client *client,
-			  const struct i2c_device_id *id);
-static int lm78_i2c_remove(struct i2c_client *client);
-
-static int __devinit lm78_isa_probe(struct platform_device *pdev);
-static int __devexit lm78_isa_remove(struct platform_device *pdev);
-
 static int lm78_read_value(struct lm78_data *data, u8 reg);
 static int lm78_write_value(struct lm78_data *data, u8 reg, u8 value);
 static struct lm78_data *lm78_update_device(struct device *dev);
 static void lm78_init_device(struct lm78_data *data);
 
 
-static const struct i2c_device_id lm78_i2c_id[] = {
-	{ "lm78", lm78 },
-	{ "lm79", lm79 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, lm78_i2c_id);
-
-static struct i2c_driver lm78_driver = {
-	.class		= I2C_CLASS_HWMON,
-	.driver = {
-		.name	= "lm78",
-	},
-	.probe		= lm78_i2c_probe,
-	.remove		= lm78_i2c_remove,
-	.id_table	= lm78_i2c_id,
-	.detect		= lm78_i2c_detect,
-	.address_list	= normal_i2c,
-};
-
-static struct platform_driver lm78_isa_driver = {
-	.driver = {
-		.owner	= THIS_MODULE,
-		.name	= "lm78",
-	},
-	.probe		= lm78_isa_probe,
-	.remove		= __devexit_p(lm78_isa_remove),
-};
-
-
 /* 7 Voltages */
 static ssize_t show_in(struct device *dev, struct device_attribute *da,
 		       char *buf)
@@ -663,76 +625,24 @@ static int lm78_i2c_remove(struct i2c_cl
 	return 0;
 }
 
-static int __devinit lm78_isa_probe(struct platform_device *pdev)
-{
-	int err;
-	struct lm78_data *data;
-	struct resource *res;
-
-	/* Reserve the ISA region */
-	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
-	if (!request_region(res->start + LM78_ADDR_REG_OFFSET, 2, "lm78")) {
-		err = -EBUSY;
-		goto exit;
-	}
-
-	if (!(data = kzalloc(sizeof(struct lm78_data), GFP_KERNEL))) {
-		err = -ENOMEM;
-		goto exit_release_region;
-	}
-	mutex_init(&data->lock);
-	data->isa_addr = res->start;
-	platform_set_drvdata(pdev, data);
-
-	if (lm78_read_value(data, LM78_REG_CHIPID) & 0x80) {
-		data->type = lm79;
-		data->name = "lm79";
-	} else {
-		data->type = lm78;
-		data->name = "lm78";
-	}
-
-	/* Initialize the LM78 chip */
-	lm78_init_device(data);
-
-	/* Register sysfs hooks */
-	if ((err = sysfs_create_group(&pdev->dev.kobj, &lm78_group))
-	 || (err = device_create_file(&pdev->dev, &dev_attr_name)))
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
-	kfree(data);
- exit_release_region:
-	release_region(res->start + LM78_ADDR_REG_OFFSET, 2);
- exit:
-	return err;
-}
-
-static int __devexit lm78_isa_remove(struct platform_device *pdev)
-{
-	struct lm78_data *data = platform_get_drvdata(pdev);
-	struct resource *res;
-
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&pdev->dev.kobj, &lm78_group);
-	device_remove_file(&pdev->dev, &dev_attr_name);
-	kfree(data);
-
-	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
-	release_region(res->start + LM78_ADDR_REG_OFFSET, 2);
+static const struct i2c_device_id lm78_i2c_id[] = {
+	{ "lm78", lm78 },
+	{ "lm79", lm79 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, lm78_i2c_id);
 
-	return 0;
-}
+static struct i2c_driver lm78_driver = {
+	.class		= I2C_CLASS_HWMON,
+	.driver = {
+		.name	= "lm78",
+	},
+	.probe		= lm78_i2c_probe,
+	.remove		= lm78_i2c_remove,
+	.id_table	= lm78_i2c_id,
+	.detect		= lm78_i2c_detect,
+	.address_list	= normal_i2c,
+};
 
 /* The SMBus locks itself, but ISA access must be locked explicitly! 
    We don't want to lock the whole ISA bus, so we lock each client
@@ -849,6 +759,87 @@ static struct lm78_data *lm78_update_dev
 	return data;
 }
 
+static int __devinit lm78_isa_probe(struct platform_device *pdev)
+{
+	int err;
+	struct lm78_data *data;
+	struct resource *res;
+
+	/* Reserve the ISA region */
+	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	if (!request_region(res->start + LM78_ADDR_REG_OFFSET, 2, "lm78")) {
+		err = -EBUSY;
+		goto exit;
+	}
+
+	data = kzalloc(sizeof(struct lm78_data), GFP_KERNEL);
+	if (!data) {
+		err = -ENOMEM;
+		goto exit_release_region;
+	}
+	mutex_init(&data->lock);
+	data->isa_addr = res->start;
+	platform_set_drvdata(pdev, data);
+
+	if (lm78_read_value(data, LM78_REG_CHIPID) & 0x80) {
+		data->type = lm79;
+		data->name = "lm79";
+	} else {
+		data->type = lm78;
+		data->name = "lm78";
+	}
+
+	/* Initialize the LM78 chip */
+	lm78_init_device(data);
+
+	/* Register sysfs hooks */
+	if ((err = sysfs_create_group(&pdev->dev.kobj, &lm78_group))
+	 || (err = device_create_file(&pdev->dev, &dev_attr_name)))
+		goto exit_remove_files;
+
+	data->hwmon_dev = hwmon_device_register(&pdev->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
+		goto exit_remove_files;
+	}
+
+	return 0;
+
+ exit_remove_files:
+	sysfs_remove_group(&pdev->dev.kobj, &lm78_group);
+	device_remove_file(&pdev->dev, &dev_attr_name);
+	kfree(data);
+ exit_release_region:
+	release_region(res->start + LM78_ADDR_REG_OFFSET, 2);
+ exit:
+	return err;
+}
+
+static int __devexit lm78_isa_remove(struct platform_device *pdev)
+{
+	struct lm78_data *data = platform_get_drvdata(pdev);
+	struct resource *res;
+
+	hwmon_device_unregister(data->hwmon_dev);
+	sysfs_remove_group(&pdev->dev.kobj, &lm78_group);
+	device_remove_file(&pdev->dev, &dev_attr_name);
+	kfree(data);
+
+	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	release_region(res->start + LM78_ADDR_REG_OFFSET, 2);
+
+	return 0;
+}
+
+static struct platform_driver lm78_isa_driver = {
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "lm78",
+	},
+	.probe		= lm78_isa_probe,
+	.remove		= __devexit_p(lm78_isa_remove),
+};
+
 /* return 1 if a supported chip is found, 0 otherwise */
 static int __init lm78_isa_found(unsigned short address)
 {


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
