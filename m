From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 11 May 2012 21:42:32 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: (it87) Convert to use devm_kzalloc and devm_request_region
Message-Id: <1336772553-12823-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

This makes the code a bit simpler and smaller.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Also convert devm_request_region for further simplification

 drivers/hwmon/it87.c |   32 +++++++++-----------------------
 1 files changed, 9 insertions(+), 23 deletions(-)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index e2e68eb..5f65fef 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -1968,19 +1968,17 @@ static int __devinit it87_probe(struct platform_device *pdev)
 	};
 
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
-	if (!request_region(res->start, IT87_EC_EXTENT, DRVNAME)) {
+	if (!devm_request_region(&pdev->dev, res->start, IT87_EC_EXTENT,
+				 DRVNAME)) {
 		dev_err(dev, "Failed to request region 0x%lx-0x%lx\n",
 			(unsigned long)res->start,
 			(unsigned long)(res->start + IT87_EC_EXTENT - 1));
-		err = -EBUSY;
-		goto ERROR0;
+		return -EBUSY;
 	}
 
-	data = kzalloc(sizeof(struct it87_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto ERROR1;
-	}
+	data = devm_kzalloc(&pdev->dev, sizeof(struct it87_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
 	data->addr = res->start;
 	data->type = sio_data->type;
@@ -1989,10 +1987,8 @@ static int __devinit it87_probe(struct platform_device *pdev)
 
 	/* Now, we do the remaining detection. */
 	if ((it87_read_value(data, IT87_REG_CONFIG) & 0x80)
-	 || it87_read_value(data, IT87_REG_CHIPID) != 0x90) {
-		err = -ENODEV;
-		goto ERROR2;
-	}
+	 || it87_read_value(data, IT87_REG_CHIPID) != 0x90)
+		return -ENODEV;
 
 	platform_set_drvdata(pdev, data);
 
@@ -2022,7 +2018,7 @@ static int __devinit it87_probe(struct platform_device *pdev)
 	/* Register sysfs hooks */
 	err = sysfs_create_group(&dev->kobj, &it87_group);
 	if (err)
-		goto ERROR2;
+		return err;
 
 	for (i = 0; i < 9; i++) {
 		if (sio_data->skip_in & (1 << i))
@@ -2123,12 +2119,6 @@ static int __devinit it87_probe(struct platform_device *pdev)
 
 ERROR4:
 	it87_remove_files(dev);
-ERROR2:
-	platform_set_drvdata(pdev, NULL);
-	kfree(data);
-ERROR1:
-	release_region(res->start, IT87_EC_EXTENT);
-ERROR0:
 	return err;
 }
 
@@ -2139,10 +2129,6 @@ static int __devexit it87_remove(struct platform_device *pdev)
 	hwmon_device_unregister(data->hwmon_dev);
 	it87_remove_files(&pdev->dev);
 
-	release_region(data->addr, IT87_EC_EXTENT);
-	platform_set_drvdata(pdev, NULL);
-	kfree(data);
-
 	return 0;
 }
 
-- 
1.7.9.48.g85da4d


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
