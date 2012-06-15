From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:23:27 +0000
Subject: [lm-sensors] [PATCH 46/95] hwmon: (lm78) Convert to use devm_ functions
Message-Id: <1339773856-3443-47-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Cc: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm78.c |   38 ++++++++++++--------------------------
 1 file changed, 12 insertions(+), 26 deletions(-)

diff --git a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
index f6bc414..1eacac9 100644
--- a/drivers/hwmon/lm78.c
+++ b/drivers/hwmon/lm78.c
@@ -660,7 +660,7 @@ static int lm78_i2c_probe(struct i2c_client *client,
 	struct lm78_data *data;
 	int err;
 
-	data = kzalloc(sizeof(struct lm78_data), GFP_KERNEL);
+	data = devm_kzalloc(&client->dev, sizeof(struct lm78_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -674,20 +674,18 @@ static int lm78_i2c_probe(struct i2c_client *client,
 	/* Register sysfs hooks */
 	err = sysfs_create_group(&client->dev.kobj, &lm78_group);
 	if (err)
-		goto ERROR3;
+		return err;
 
 	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
 		err = PTR_ERR(data->hwmon_dev);
-		goto ERROR4;
+		goto error;
 	}
 
 	return 0;
 
-ERROR4:
+error:
 	sysfs_remove_group(&client->dev.kobj, &lm78_group);
-ERROR3:
-	kfree(data);
 	return err;
 }
 
@@ -697,7 +695,6 @@ static int lm78_i2c_remove(struct i2c_client *client)
 
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &lm78_group);
-	kfree(data);
 
 	return 0;
 }
@@ -844,16 +841,14 @@ static int __devinit lm78_isa_probe(struct platform_device *pdev)
 
 	/* Reserve the ISA region */
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
-	if (!request_region(res->start + LM78_ADDR_REG_OFFSET, 2, "lm78")) {
-		err = -EBUSY;
-		goto exit;
-	}
+	if (!devm_request_region(&pdev->dev, res->start + LM78_ADDR_REG_OFFSET,
+				 2, "lm78"))
+		return -EBUSY;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(struct lm78_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
-	data = kzalloc(sizeof(struct lm78_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto exit_release_region;
-	}
 	mutex_init(&data->lock);
 	data->isa_addr = res->start;
 	platform_set_drvdata(pdev, data);
@@ -885,28 +880,19 @@ static int __devinit lm78_isa_probe(struct platform_device *pdev)
 
 	return 0;
 
- exit_remove_files:
+exit_remove_files:
 	sysfs_remove_group(&pdev->dev.kobj, &lm78_group);
 	device_remove_file(&pdev->dev, &dev_attr_name);
-	kfree(data);
- exit_release_region:
-	release_region(res->start + LM78_ADDR_REG_OFFSET, 2);
- exit:
 	return err;
 }
 
 static int __devexit lm78_isa_remove(struct platform_device *pdev)
 {
 	struct lm78_data *data = platform_get_drvdata(pdev);
-	struct resource *res;
 
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&pdev->dev.kobj, &lm78_group);
 	device_remove_file(&pdev->dev, &dev_attr_name);
-	kfree(data);
-
-	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
-	release_region(res->start + LM78_ADDR_REG_OFFSET, 2);
 
 	return 0;
 }
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
