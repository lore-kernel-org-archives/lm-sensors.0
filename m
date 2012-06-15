From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:24:04 +0000
Subject: [lm-sensors] [PATCH 83/95] hwmon: (w83781d) Convert to use devm_ functions
Message-Id: <1339773856-3443-84-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/w83781d.c |   46 ++++++++++++++++------------------------------
 1 file changed, 16 insertions(+), 30 deletions(-)

diff --git a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
index a82f508..55422a0 100644
--- a/drivers/hwmon/w83781d.c
+++ b/drivers/hwmon/w83781d.c
@@ -1213,11 +1213,9 @@ w83781d_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	struct w83781d_data *data;
 	int err;
 
-	data = kzalloc(sizeof(struct w83781d_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto ERROR1;
-	}
+	data = devm_kzalloc(dev, sizeof(struct w83781d_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->lock);
@@ -1229,7 +1227,7 @@ w83781d_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	/* attach secondary i2c lm75-like clients */
 	err = w83781d_detect_subclients(client);
 	if (err)
-		goto ERROR3;
+		return err;
 
 	/* Initialize the chip */
 	w83781d_init_device(dev);
@@ -1237,25 +1235,22 @@ w83781d_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	/* Register sysfs hooks */
 	err = w83781d_create_files(dev, data->type, 0);
 	if (err)
-		goto ERROR4;
+		goto remove_files;
 
 	data->hwmon_dev = hwmon_device_register(dev);
 	if (IS_ERR(data->hwmon_dev)) {
 		err = PTR_ERR(data->hwmon_dev);
-		goto ERROR4;
+		goto remove_files;
 	}
 
 	return 0;
 
-ERROR4:
+remove_files:
 	w83781d_remove_files(dev);
 	if (data->lm75[0])
 		i2c_unregister_device(data->lm75[0]);
 	if (data->lm75[1])
 		i2c_unregister_device(data->lm75[1]);
-ERROR3:
-	kfree(data);
-ERROR1:
 	return err;
 }
 
@@ -1273,8 +1268,6 @@ w83781d_remove(struct i2c_client *client)
 	if (data->lm75[1])
 		i2c_unregister_device(data->lm75[1]);
 
-	kfree(data);
-
 	return 0;
 }
 
@@ -1780,17 +1773,16 @@ w83781d_isa_probe(struct platform_device *pdev)
 
 	/* Reserve the ISA region */
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
-	if (!request_region(res->start + W83781D_ADDR_REG_OFFSET, 2,
-			    "w83781d")) {
-		err = -EBUSY;
-		goto exit;
-	}
+	if (!devm_request_region(&pdev->dev,
+				 res->start + W83781D_ADDR_REG_OFFSET, 2,
+				 "w83781d"))
+		return -EBUSY;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(struct w83781d_data),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
-	data = kzalloc(sizeof(struct w83781d_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto exit_release_region;
-	}
 	mutex_init(&data->lock);
 	data->isa_addr = res->start;
 	platform_set_drvdata(pdev, data);
@@ -1829,10 +1821,6 @@ w83781d_isa_probe(struct platform_device *pdev)
  exit_remove_files:
 	w83781d_remove_files(&pdev->dev);
 	device_remove_file(&pdev->dev, &dev_attr_name);
-	kfree(data);
- exit_release_region:
-	release_region(res->start + W83781D_ADDR_REG_OFFSET, 2);
- exit:
 	return err;
 }
 
@@ -1844,8 +1832,6 @@ w83781d_isa_remove(struct platform_device *pdev)
 	hwmon_device_unregister(data->hwmon_dev);
 	w83781d_remove_files(&pdev->dev);
 	device_remove_file(&pdev->dev, &dev_attr_name);
-	release_region(data->isa_addr + W83781D_ADDR_REG_OFFSET, 2);
-	kfree(data);
 
 	return 0;
 }
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
