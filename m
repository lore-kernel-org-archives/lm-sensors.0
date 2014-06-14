From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 14 Jun 2014 06:33:24 +0000
Subject: [lm-sensors] [RFT][PATCH v2] hwmon: (twl4030-madc-hwmon) Convert to devm_hwmon_device_register_with_
Message-Id: <1402727604.13807.1.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/twl4030-madc-hwmon.c | 38 ++++++--------------------------------
 1 file changed, 6 insertions(+), 32 deletions(-)

diff --git a/drivers/hwmon/twl4030-madc-hwmon.c b/drivers/hwmon/twl4030-madc-hwmon.c
index 6c6d440..9a0e2b8 100644
--- a/drivers/hwmon/twl4030-madc-hwmon.c
+++ b/drivers/hwmon/twl4030-madc-hwmon.c
@@ -74,7 +74,7 @@ static SENSOR_DEVICE_ATTR(in11_input, S_IRUGO, madc_read, NULL, 11);
 static SENSOR_DEVICE_ATTR(in12_input, S_IRUGO, madc_read, NULL, 12);
 static SENSOR_DEVICE_ATTR(in15_input, S_IRUGO, madc_read, NULL, 15);
 
-static struct attribute *twl4030_madc_attributes[] = {
+static struct attribute *twl4030_madc_attrs[] = {
 	&sensor_dev_attr_in0_input.dev_attr.attr,
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	&sensor_dev_attr_in2_input.dev_attr.attr,
@@ -91,46 +91,20 @@ static struct attribute *twl4030_madc_attributes[] = {
 	&sensor_dev_attr_in15_input.dev_attr.attr,
 	NULL
 };
-
-static const struct attribute_group twl4030_madc_group = {
-	.attrs = twl4030_madc_attributes,
-};
+ATTRIBUTE_GROUPS(twl4030_madc);
 
 static int twl4030_madc_hwmon_probe(struct platform_device *pdev)
 {
-	int ret;
 	struct device *hwmon;
 
-	ret = sysfs_create_group(&pdev->dev.kobj, &twl4030_madc_group);
-	if (ret)
-		goto err_sysfs;
-	hwmon = hwmon_device_register(&pdev->dev);
-	if (IS_ERR(hwmon)) {
-		dev_err(&pdev->dev, "hwmon_device_register failed.\n");
-		ret = PTR_ERR(hwmon);
-		goto err_reg;
-	}
-
-	return 0;
-
-err_reg:
-	sysfs_remove_group(&pdev->dev.kobj, &twl4030_madc_group);
-err_sysfs:
-
-	return ret;
-}
-
-static int twl4030_madc_hwmon_remove(struct platform_device *pdev)
-{
-	hwmon_device_unregister(&pdev->dev);
-	sysfs_remove_group(&pdev->dev.kobj, &twl4030_madc_group);
-
-	return 0;
+	hwmon = devm_hwmon_device_register_with_groups(&pdev->dev,
+						       "twl4030_madc", NULL,
+						       twl4030_madc_groups);
+	return PTR_ERR_OR_ZERO(hwmon);
 }
 
 static struct platform_driver twl4030_madc_hwmon_driver = {
 	.probe = twl4030_madc_hwmon_probe,
-	.remove = twl4030_madc_hwmon_remove,
 	.driver = {
 		   .name = "twl4030_madc_hwmon",
 		   .owner = THIS_MODULE,
-- 
1.8.3.2




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
