From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:23:06 +0000
Subject: [lm-sensors] [PATCH 25/95] hwmon: (dme1737) Convert to use devm_ functions
Message-Id: <1339773856-3443-26-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Cc: Juerg Haefliger <juergh@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/dme1737.c |   45 +++++++++++++--------------------------------
 1 file changed, 13 insertions(+), 32 deletions(-)

diff --git a/drivers/hwmon/dme1737.c b/drivers/hwmon/dme1737.c
index e7c6a19..fe0eeec 100644
--- a/drivers/hwmon/dme1737.c
+++ b/drivers/hwmon/dme1737.c
@@ -2475,11 +2475,9 @@ static int dme1737_i2c_probe(struct i2c_client *client,
 	struct device *dev = &client->dev;
 	int err;
 
-	data = kzalloc(sizeof(struct dme1737_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto exit;
-	}
+	data = devm_kzalloc(dev, sizeof(struct dme1737_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
 	i2c_set_clientdata(client, data);
 	data->type = id->driver_data;
@@ -2491,14 +2489,14 @@ static int dme1737_i2c_probe(struct i2c_client *client,
 	err = dme1737_init_device(dev);
 	if (err) {
 		dev_err(dev, "Failed to initialize device.\n");
-		goto exit_kfree;
+		return err;
 	}
 
 	/* Create sysfs files */
 	err = dme1737_create_files(dev);
 	if (err) {
 		dev_err(dev, "Failed to create sysfs files.\n");
-		goto exit_kfree;
+		return err;
 	}
 
 	/* Register device */
@@ -2513,9 +2511,6 @@ static int dme1737_i2c_probe(struct i2c_client *client,
 
 exit_remove:
 	dme1737_remove_files(dev);
-exit_kfree:
-	kfree(data);
-exit:
 	return err;
 }
 
@@ -2526,7 +2521,6 @@ static int dme1737_i2c_remove(struct i2c_client *client)
 	hwmon_device_unregister(data->hwmon_dev);
 	dme1737_remove_files(&client->dev);
 
-	kfree(data);
 	return 0;
 }
 
@@ -2645,19 +2639,16 @@ static int __devinit dme1737_isa_probe(struct platform_device *pdev)
 	int err;
 
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
-	if (!request_region(res->start, DME1737_EXTENT, "dme1737")) {
+	if (!devm_request_region(dev, res->start, DME1737_EXTENT, "dme1737")) {
 		dev_err(dev, "Failed to request region 0x%04x-0x%04x.\n",
 			(unsigned short)res->start,
 			(unsigned short)res->start + DME1737_EXTENT - 1);
-		err = -EBUSY;
-		goto exit;
+		return -EBUSY;
 	}
 
-	data = kzalloc(sizeof(struct dme1737_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto exit_release_region;
-	}
+	data = devm_kzalloc(dev, sizeof(struct dme1737_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
 	data->addr = res->start;
 	platform_set_drvdata(pdev, data);
@@ -2683,8 +2674,7 @@ static int __devinit dme1737_isa_probe(struct platform_device *pdev)
 			   (device = SCH5127_DEVICE)) {
 			data->type = sch5127;
 		} else {
-			err = -ENODEV;
-			goto exit_kfree;
+			return -ENODEV;
 		}
 	}
 
@@ -2703,14 +2693,14 @@ static int __devinit dme1737_isa_probe(struct platform_device *pdev)
 	err = dme1737_init_device(dev);
 	if (err) {
 		dev_err(dev, "Failed to initialize device.\n");
-		goto exit_kfree;
+		return err;
 	}
 
 	/* Create sysfs files */
 	err = dme1737_create_files(dev);
 	if (err) {
 		dev_err(dev, "Failed to create sysfs files.\n");
-		goto exit_kfree;
+		return err;
 	}
 
 	/* Register device */
@@ -2725,12 +2715,6 @@ static int __devinit dme1737_isa_probe(struct platform_device *pdev)
 
 exit_remove_files:
 	dme1737_remove_files(dev);
-exit_kfree:
-	platform_set_drvdata(pdev, NULL);
-	kfree(data);
-exit_release_region:
-	release_region(res->start, DME1737_EXTENT);
-exit:
 	return err;
 }
 
@@ -2740,9 +2724,6 @@ static int __devexit dme1737_isa_remove(struct platform_device *pdev)
 
 	hwmon_device_unregister(data->hwmon_dev);
 	dme1737_remove_files(&pdev->dev);
-	release_region(data->addr, DME1737_EXTENT);
-	platform_set_drvdata(pdev, NULL);
-	kfree(data);
 
 	return 0;
 }
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
