From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:23:48 +0000
Subject: [lm-sensors] [PATCH 67/95] hwmon: (pc87427) Convert to use devm_ functions
Message-Id: <1339773856-3443-68-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Cc: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pc87427.c |   41 +++++++----------------------------------
 1 file changed, 7 insertions(+), 34 deletions(-)

diff --git a/drivers/hwmon/pc87427.c b/drivers/hwmon/pc87427.c
index 37059a3..75f67a8 100644
--- a/drivers/hwmon/pc87427.c
+++ b/drivers/hwmon/pc87427.c
@@ -956,17 +956,6 @@ static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
  * Device detection, attach and detach
  */
 
-static void pc87427_release_regions(struct platform_device *pdev, int count)
-{
-	struct resource *res;
-	int i;
-
-	for (i = 0; i < count; i++) {
-		res = platform_get_resource(pdev, IORESOURCE_IO, i);
-		release_region(res->start, resource_size(res));
-	}
-}
-
 static int __devinit pc87427_request_regions(struct platform_device *pdev,
 					     int count)
 {
@@ -980,7 +969,8 @@ static int __devinit pc87427_request_regions(struct platform_device *pdev,
 			dev_err(&pdev->dev, "Missing resource #%d\n", i);
 			break;
 		}
-		if (!request_region(res->start, resource_size(res), DRVNAME)) {
+		if (!devm_request_region(&pdev->dev, res->start,
+					 resource_size(res), DRVNAME)) {
 			err = -EBUSY;
 			dev_err(&pdev->dev,
 				"Failed to request region 0x%lx-0x%lx\n",
@@ -989,10 +979,6 @@ static int __devinit pc87427_request_regions(struct platform_device *pdev,
 			break;
 		}
 	}
-
-	if (err && i)
-		pc87427_release_regions(pdev, i);
-
 	return err;
 }
 
@@ -1094,11 +1080,11 @@ static int __devinit pc87427_probe(struct platform_device *pdev)
 	struct pc87427_data *data;
 	int i, err, res_count;
 
-	data = kzalloc(sizeof(struct pc87427_data), GFP_KERNEL);
+	data = devm_kzalloc(&pdev->dev, sizeof(struct pc87427_data),
+			    GFP_KERNEL);
 	if (!data) {
-		err = -ENOMEM;
 		pr_err("Out of memory\n");
-		goto exit;
+		return -ENOMEM;
 	}
 
 	data->address[0] = sio_data->address[0];
@@ -1107,7 +1093,7 @@ static int __devinit pc87427_probe(struct platform_device *pdev)
 
 	err = pc87427_request_regions(pdev, res_count);
 	if (err)
-		goto exit_kfree;
+		return err;
 
 	mutex_init(&data->lock);
 	data->name = "pc87427";
@@ -1117,7 +1103,7 @@ static int __devinit pc87427_probe(struct platform_device *pdev)
 	/* Register sysfs hooks */
 	err = device_create_file(&pdev->dev, &dev_attr_name);
 	if (err)
-		goto exit_release_region;
+		return err;
 	for (i = 0; i < 8; i++) {
 		if (!(data->fan_enabled & (1 << i)))
 			continue;
@@ -1154,28 +1140,15 @@ static int __devinit pc87427_probe(struct platform_device *pdev)
 
 exit_remove_files:
 	pc87427_remove_files(&pdev->dev);
-exit_release_region:
-	pc87427_release_regions(pdev, res_count);
-exit_kfree:
-	platform_set_drvdata(pdev, NULL);
-	kfree(data);
-exit:
 	return err;
 }
 
 static int __devexit pc87427_remove(struct platform_device *pdev)
 {
 	struct pc87427_data *data = platform_get_drvdata(pdev);
-	int res_count;
-
-	res_count = (data->address[0] != 0) + (data->address[1] != 0);
 
 	hwmon_device_unregister(data->hwmon_dev);
 	pc87427_remove_files(&pdev->dev);
-	platform_set_drvdata(pdev, NULL);
-	kfree(data);
-
-	pc87427_release_regions(pdev, res_count);
 
 	return 0;
 }
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
