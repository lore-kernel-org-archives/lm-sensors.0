From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 17 Jun 2014 15:12:08 +0000
Subject: [lm-sensors] [RFT][PATCH 2/2] hwmon: (wm8350) Convert to devm_hwmon_device_register_with_groups
Message-Id: <1403017928.5292.3.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/wm8350-hwmon.c | 50 +++++++-------------------------------------
 1 file changed, 7 insertions(+), 43 deletions(-)

diff --git a/drivers/hwmon/wm8350-hwmon.c b/drivers/hwmon/wm8350-hwmon.c
index 64bf75c..90e3d91 100644
--- a/drivers/hwmon/wm8350-hwmon.c
+++ b/drivers/hwmon/wm8350-hwmon.c
@@ -28,19 +28,12 @@
 #include <linux/mfd/wm8350/core.h>
 #include <linux/mfd/wm8350/comparator.h>
 
-static ssize_t show_name(struct device *dev,
-			 struct device_attribute *attr, char *buf)
-{
-	return sprintf(buf, "wm8350\n");
-}
-
 static const char * const input_names[] = {
 	[WM8350_AUXADC_USB]  = "USB",
 	[WM8350_AUXADC_LINE] = "Line",
 	[WM8350_AUXADC_BATT] = "Battery",
 };
 
-
 static ssize_t show_voltage(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
@@ -68,15 +61,11 @@ static ssize_t show_label(struct device *dev,
 	static SENSOR_DEVICE_ATTR(in##id##_label, S_IRUGO, show_label,	\
 				  NULL, name)
 
-static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
-
 WM8350_NAMED_VOLTAGE(0, WM8350_AUXADC_USB);
 WM8350_NAMED_VOLTAGE(1, WM8350_AUXADC_BATT);
 WM8350_NAMED_VOLTAGE(2, WM8350_AUXADC_LINE);
 
-static struct attribute *wm8350_attributes[] = {
-	&dev_attr_name.attr,
-
+static struct attribute *wm8350_attrs[] = {
 	&sensor_dev_attr_in0_input.dev_attr.attr,
 	&sensor_dev_attr_in0_label.dev_attr.attr,
 	&sensor_dev_attr_in1_input.dev_attr.attr,
@@ -87,46 +76,21 @@ static struct attribute *wm8350_attributes[] = {
 	NULL,
 };
 
-static const struct attribute_group wm8350_attr_group = {
-	.attrs	= wm8350_attributes,
-};
+ATTRIBUTE_GROUPS(wm8350);
 
 static int wm8350_hwmon_probe(struct platform_device *pdev)
 {
 	struct wm8350 *wm8350 = platform_get_drvdata(pdev);
-	int ret;
-
-	ret = sysfs_create_group(&pdev->dev.kobj, &wm8350_attr_group);
-	if (ret)
-		goto err;
-
-	wm8350->hwmon.classdev = hwmon_device_register(&pdev->dev);
-	if (IS_ERR(wm8350->hwmon.classdev)) {
-		ret = PTR_ERR(wm8350->hwmon.classdev);
-		goto err_group;
-	}
-
-	return 0;
-
-err_group:
-	sysfs_remove_group(&pdev->dev.kobj, &wm8350_attr_group);
-err:
-	return ret;
-}
-
-static int wm8350_hwmon_remove(struct platform_device *pdev)
-{
-	struct wm8350 *wm8350 = platform_get_drvdata(pdev);
-
-	hwmon_device_unregister(wm8350->hwmon.classdev);
-	sysfs_remove_group(&pdev->dev.kobj, &wm8350_attr_group);
+	struct device *hwmon_dev;
 
-	return 0;
+	hwmon_dev = devm_hwmon_device_register_with_groups(&pdev->dev, "wm8350",
+							   wm8350,
+							   wm8350_groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 static struct platform_driver wm8350_hwmon_driver = {
 	.probe = wm8350_hwmon_probe,
-	.remove = wm8350_hwmon_remove,
 	.driver = {
 		.name = "wm8350-hwmon",
 		.owner = THIS_MODULE,
-- 
1.8.3.2




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
