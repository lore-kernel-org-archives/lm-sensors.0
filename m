From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:24:09 +0000
Subject: [lm-sensors] [PATCH 88/95] hwmon: (wm831x-hwmon) Convert to use devm_ functions
Message-Id: <1339773856-3443-89-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/wm831x-hwmon.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/wm831x-hwmon.c b/drivers/hwmon/wm831x-hwmon.c
index 07cb25a..d0db1f2 100644
--- a/drivers/hwmon/wm831x-hwmon.c
+++ b/drivers/hwmon/wm831x-hwmon.c
@@ -163,7 +163,8 @@ static int __devinit wm831x_hwmon_probe(struct platform_device *pdev)
 	struct wm831x_hwmon *hwmon;
 	int ret;
 
-	hwmon = kzalloc(sizeof(struct wm831x_hwmon), GFP_KERNEL);
+	hwmon = devm_kzalloc(&pdev->dev, sizeof(struct wm831x_hwmon),
+			     GFP_KERNEL);
 	if (!hwmon)
 		return -ENOMEM;
 
@@ -171,7 +172,7 @@ static int __devinit wm831x_hwmon_probe(struct platform_device *pdev)
 
 	ret = sysfs_create_group(&pdev->dev.kobj, &wm831x_attr_group);
 	if (ret)
-		goto err;
+		return ret;
 
 	hwmon->classdev = hwmon_device_register(&pdev->dev);
 	if (IS_ERR(hwmon->classdev)) {
@@ -185,8 +186,6 @@ static int __devinit wm831x_hwmon_probe(struct platform_device *pdev)
 
 err_sysfs:
 	sysfs_remove_group(&pdev->dev.kobj, &wm831x_attr_group);
-err:
-	kfree(hwmon);
 	return ret;
 }
 
@@ -196,8 +195,6 @@ static int __devexit wm831x_hwmon_remove(struct platform_device *pdev)
 
 	hwmon_device_unregister(hwmon->classdev);
 	sysfs_remove_group(&pdev->dev.kobj, &wm831x_attr_group);
-	platform_set_drvdata(pdev, NULL);
-	kfree(hwmon);
 
 	return 0;
 }
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
