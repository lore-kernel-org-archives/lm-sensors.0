From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:24:01 +0000
Subject: [lm-sensors] [PATCH 80/95] hwmon: (vt1211) Convert to use devm_ functions
Message-Id: <1339773856-3443-81-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Cc: Juerg Haefliger <juergh@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/vt1211.c |   22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/hwmon/vt1211.c b/drivers/hwmon/vt1211.c
index c2c5c72..f2c6115 100644
--- a/drivers/hwmon/vt1211.c
+++ b/drivers/hwmon/vt1211.c
@@ -1148,19 +1148,18 @@ static int __devinit vt1211_probe(struct platform_device *pdev)
 	struct resource *res;
 	int i, err;
 
-	data = kzalloc(sizeof(struct vt1211_data), GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(struct vt1211_data), GFP_KERNEL);
 	if (!data) {
-		err = -ENOMEM;
 		dev_err(dev, "Out of memory\n");
-		goto EXIT;
+		return -ENOMEM;
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
-	if (!request_region(res->start, resource_size(res), DRVNAME)) {
-		err = -EBUSY;
+	if (!devm_request_region(dev, res->start, resource_size(res),
+				 DRVNAME)) {
 		dev_err(dev, "Failed to request region 0x%lx-0x%lx\n",
 			(unsigned long)res->start, (unsigned long)res->end);
-		goto EXIT_KFREE;
+		return -EBUSY;
 	}
 	data->addr = res->start;
 	data->name = DRVNAME;
@@ -1215,26 +1214,15 @@ EXIT_DEV_REMOVE:
 	dev_err(dev, "Sysfs interface creation failed (%d)\n", err);
 EXIT_DEV_REMOVE_SILENT:
 	vt1211_remove_sysfs(pdev);
-	release_region(res->start, resource_size(res));
-EXIT_KFREE:
-	platform_set_drvdata(pdev, NULL);
-	kfree(data);
-EXIT:
 	return err;
 }
 
 static int __devexit vt1211_remove(struct platform_device *pdev)
 {
 	struct vt1211_data *data = platform_get_drvdata(pdev);
-	struct resource *res;
 
 	hwmon_device_unregister(data->hwmon_dev);
 	vt1211_remove_sysfs(pdev);
-	platform_set_drvdata(pdev, NULL);
-	kfree(data);
-
-	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
-	release_region(res->start, resource_size(res));
 
 	return 0;
 }
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
