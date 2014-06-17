From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 17 Jun 2014 15:10:55 +0000
Subject: [lm-sensors] [RFT][PATCH 1/2] hwmon: (wm831x) Convert to devm_hwmon_device_register_with_groups
Message-Id: <1403017855.5292.1.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/wm831x-hwmon.c | 72 +++++++-------------------------------------
 1 file changed, 11 insertions(+), 61 deletions(-)

diff --git a/drivers/hwmon/wm831x-hwmon.c b/drivers/hwmon/wm831x-hwmon.c
index df6ceaf..3e6a319 100644
--- a/drivers/hwmon/wm831x-hwmon.c
+++ b/drivers/hwmon/wm831x-hwmon.c
@@ -29,17 +29,6 @@
 #include <linux/mfd/wm831x/core.h>
 #include <linux/mfd/wm831x/auxadc.h>
 
-struct wm831x_hwmon {
-	struct wm831x *wm831x;
-	struct device *classdev;
-};
-
-static ssize_t show_name(struct device *dev,
-			 struct device_attribute *attr, char *buf)
-{
-	return sprintf(buf, "wm831x\n");
-}
-
 static const char * const input_names[] = {
 	[WM831X_AUX_SYSVDD]    = "SYSVDD",
 	[WM831X_AUX_USB]       = "USB",
@@ -50,15 +39,14 @@ static const char * const input_names[] = {
 	[WM831X_AUX_BATT_TEMP] = "Battery",
 };
 
-
 static ssize_t show_voltage(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
-	struct wm831x_hwmon *hwmon = dev_get_drvdata(dev);
+	struct wm831x *wm831x = dev_get_drvdata(dev);
 	int channel = to_sensor_dev_attr(attr)->index;
 	int ret;
 
-	ret = wm831x_auxadc_read_uv(hwmon->wm831x, channel);
+	ret = wm831x_auxadc_read_uv(wm831x, channel);
 	if (ret < 0)
 		return ret;
 
@@ -68,11 +56,11 @@ static ssize_t show_voltage(struct device *dev,
 static ssize_t show_chip_temp(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
-	struct wm831x_hwmon *hwmon = dev_get_drvdata(dev);
+	struct wm831x *wm831x = dev_get_drvdata(dev);
 	int channel = to_sensor_dev_attr(attr)->index;
 	int ret;
 
-	ret = wm831x_auxadc_read(hwmon->wm831x, channel);
+	ret = wm831x_auxadc_read(wm831x, channel);
 	if (ret < 0)
 		return ret;
 
@@ -100,8 +88,6 @@ static ssize_t show_label(struct device *dev,
 	static SENSOR_DEVICE_ATTR(in##id##_label, S_IRUGO, show_label,	\
 				  NULL, name)
 
-static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
-
 WM831X_VOLTAGE(0, WM831X_AUX_AUX1);
 WM831X_VOLTAGE(1, WM831X_AUX_AUX2);
 WM831X_VOLTAGE(2, WM831X_AUX_AUX3);
@@ -126,9 +112,7 @@ static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_voltage, NULL,
 static SENSOR_DEVICE_ATTR(temp2_label, S_IRUGO, show_label, NULL,
 			  WM831X_AUX_BATT_TEMP);
 
-static struct attribute *wm831x_attributes[] = {
-	&dev_attr_name.attr,
-
+static struct attribute *wm831x_attrs[] = {
 	&sensor_dev_attr_in0_input.dev_attr.attr,
 	&sensor_dev_attr_in1_input.dev_attr.attr,
 	&sensor_dev_attr_in2_input.dev_attr.attr,
@@ -153,55 +137,21 @@ static struct attribute *wm831x_attributes[] = {
 	NULL
 };
 
-static const struct attribute_group wm831x_attr_group = {
-	.attrs	= wm831x_attributes,
-};
+ATTRIBUTE_GROUPS(wm831x);
 
 static int wm831x_hwmon_probe(struct platform_device *pdev)
 {
 	struct wm831x *wm831x = dev_get_drvdata(pdev->dev.parent);
-	struct wm831x_hwmon *hwmon;
-	int ret;
-
-	hwmon = devm_kzalloc(&pdev->dev, sizeof(struct wm831x_hwmon),
-			     GFP_KERNEL);
-	if (!hwmon)
-		return -ENOMEM;
-
-	hwmon->wm831x = wm831x;
-
-	ret = sysfs_create_group(&pdev->dev.kobj, &wm831x_attr_group);
-	if (ret)
-		return ret;
-
-	hwmon->classdev = hwmon_device_register(&pdev->dev);
-	if (IS_ERR(hwmon->classdev)) {
-		ret = PTR_ERR(hwmon->classdev);
-		goto err_sysfs;
-	}
-
-	platform_set_drvdata(pdev, hwmon);
-
-	return 0;
-
-err_sysfs:
-	sysfs_remove_group(&pdev->dev.kobj, &wm831x_attr_group);
-	return ret;
-}
-
-static int wm831x_hwmon_remove(struct platform_device *pdev)
-{
-	struct wm831x_hwmon *hwmon = platform_get_drvdata(pdev);
-
-	hwmon_device_unregister(hwmon->classdev);
-	sysfs_remove_group(&pdev->dev.kobj, &wm831x_attr_group);
+	struct device *hwmon_dev;
 
-	return 0;
+	hwmon_dev = devm_hwmon_device_register_with_groups(&pdev->dev, "wm831x",
+							   wm831x,
+							   wm831x_groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 static struct platform_driver wm831x_hwmon_driver = {
 	.probe = wm831x_hwmon_probe,
-	.remove = wm831x_hwmon_remove,
 	.driver = {
 		.name = "wm831x-hwmon",
 		.owner = THIS_MODULE,
-- 
1.8.3.2




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
