From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 16 Feb 2014 23:59:34 +0000
Subject: [lm-sensors] [PATCH 2/3] hwmon: (coretemp) Allocate platform data with devm_kzalloc
Message-Id: <1392595175-7589-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This simplifies error handling.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/coretemp.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 3f87db2..944f850 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -582,22 +582,23 @@ static void coretemp_remove_core(struct platform_data *pdata,
 
 static int coretemp_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct platform_data *pdata;
 	int err;
 
 	/* Initialize the per-package data structures */
-	pdata = kzalloc(sizeof(struct platform_data), GFP_KERNEL);
+	pdata = devm_kzalloc(dev, sizeof(struct platform_data), GFP_KERNEL);
 	if (!pdata)
 		return -ENOMEM;
 
-	err = create_name_attr(pdata, &pdev->dev);
+	err = create_name_attr(pdata, dev);
 	if (err)
-		goto exit_free;
+		return err;
 
 	pdata->phys_proc_id = pdev->id;
 	platform_set_drvdata(pdev, pdata);
 
-	pdata->hwmon_dev = hwmon_device_register(&pdev->dev);
+	pdata->hwmon_dev = hwmon_device_register(dev);
 	if (IS_ERR(pdata->hwmon_dev)) {
 		err = PTR_ERR(pdata->hwmon_dev);
 		dev_err(&pdev->dev, "Class registration failed (%d)\n", err);
@@ -607,8 +608,6 @@ static int coretemp_probe(struct platform_device *pdev)
 
 exit_name:
 	device_remove_file(&pdev->dev, &pdata->name_attr);
-exit_free:
-	kfree(pdata);
 	return err;
 }
 
@@ -623,7 +622,6 @@ static int coretemp_remove(struct platform_device *pdev)
 
 	device_remove_file(&pdev->dev, &pdata->name_attr);
 	hwmon_device_unregister(pdata->hwmon_dev);
-	kfree(pdata);
 	return 0;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
