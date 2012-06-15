From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:24:12 +0000
Subject: [lm-sensors] [PATCH 91/95] hwmon: (smsc47b397) Convert to use devm_ functions
Message-Id: <1339773856-3443-92-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Cc: Mark M. Hoffman <mhoffman@lightlink.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/smsc47b397.c |   22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/hwmon/smsc47b397.c b/drivers/hwmon/smsc47b397.c
index c5f6be4..65b07de 100644
--- a/drivers/hwmon/smsc47b397.c
+++ b/drivers/hwmon/smsc47b397.c
@@ -231,13 +231,9 @@ static const struct attribute_group smsc47b397_group = {
 static int __devexit smsc47b397_remove(struct platform_device *pdev)
 {
 	struct smsc47b397_data *data = platform_get_drvdata(pdev);
-	struct resource *res;
 
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&pdev->dev.kobj, &smsc47b397_group);
-	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
-	release_region(res->start, SMSC_EXTENT);
-	kfree(data);
 
 	return 0;
 }
@@ -261,19 +257,17 @@ static int __devinit smsc47b397_probe(struct platform_device *pdev)
 	int err = 0;
 
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
-	if (!request_region(res->start, SMSC_EXTENT,
-			    smsc47b397_driver.driver.name)) {
+	if (!devm_request_region(dev, res->start, SMSC_EXTENT,
+				 smsc47b397_driver.driver.name)) {
 		dev_err(dev, "Region 0x%lx-0x%lx already in use!\n",
 			(unsigned long)res->start,
 			(unsigned long)res->start + SMSC_EXTENT - 1);
 		return -EBUSY;
 	}
 
-	data = kzalloc(sizeof(struct smsc47b397_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto error_release;
-	}
+	data = devm_kzalloc(dev, sizeof(struct smsc47b397_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
 	data->addr = res->start;
 	data->name = "smsc47b397";
@@ -283,7 +277,7 @@ static int __devinit smsc47b397_probe(struct platform_device *pdev)
 
 	err = sysfs_create_group(&dev->kobj, &smsc47b397_group);
 	if (err)
-		goto error_free;
+		return err;
 
 	data->hwmon_dev = hwmon_device_register(dev);
 	if (IS_ERR(data->hwmon_dev)) {
@@ -295,10 +289,6 @@ static int __devinit smsc47b397_probe(struct platform_device *pdev)
 
 error_remove:
 	sysfs_remove_group(&dev->kobj, &smsc47b397_group);
-error_free:
-	kfree(data);
-error_release:
-	release_region(res->start, SMSC_EXTENT);
 	return err;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
