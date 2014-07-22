From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 22 Jul 2014 02:15:22 +0000
Subject: [lm-sensors] [RFT][PATCH] hwmon: (max197) Convert to devm_hwmon_device_register_with_groups
Message-Id: <1405995322.2859.1.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/max197.c | 73 +++++++++++++-------------------------------------
 1 file changed, 18 insertions(+), 55 deletions(-)

diff --git a/drivers/hwmon/max197.c b/drivers/hwmon/max197.c
index 82128ad..155b742 100644
--- a/drivers/hwmon/max197.c
+++ b/drivers/hwmon/max197.c
@@ -49,7 +49,6 @@ enum max197_chips { max197, max199 };
  */
 struct max197_data {
 	struct max197_platform_data *pdata;
-	struct device *hwmon_dev;
 	struct mutex lock;
 	int limit;
 	bool scale;
@@ -207,13 +206,6 @@ unlock:
 	return ret;
 }
 
-static ssize_t max197_show_name(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-	return sprintf(buf, "%s\n", pdev->name);
-}
-
 #define MAX197_SENSOR_DEVICE_ATTR_CH(chan)				\
 	static SENSOR_DEVICE_ATTR(in##chan##_input, S_IRUGO,		\
 				  max197_show_input, NULL, chan);	\
@@ -231,8 +223,6 @@ static ssize_t max197_show_name(struct device *dev,
 	&sensor_dev_attr_in##chan##_max.dev_attr.attr,			\
 	&sensor_dev_attr_in##chan##_min.dev_attr.attr
 
-static DEVICE_ATTR(name, S_IRUGO, max197_show_name, NULL);
-
 MAX197_SENSOR_DEVICE_ATTR_CH(0);
 MAX197_SENSOR_DEVICE_ATTR_CH(1);
 MAX197_SENSOR_DEVICE_ATTR_CH(2);
@@ -242,27 +232,27 @@ MAX197_SENSOR_DEVICE_ATTR_CH(5);
 MAX197_SENSOR_DEVICE_ATTR_CH(6);
 MAX197_SENSOR_DEVICE_ATTR_CH(7);
 
-static const struct attribute_group max197_sysfs_group = {
-	.attrs = (struct attribute *[]) {
-		&dev_attr_name.attr,
-		MAX197_SENSOR_DEV_ATTR_IN(0),
-		MAX197_SENSOR_DEV_ATTR_IN(1),
-		MAX197_SENSOR_DEV_ATTR_IN(2),
-		MAX197_SENSOR_DEV_ATTR_IN(3),
-		MAX197_SENSOR_DEV_ATTR_IN(4),
-		MAX197_SENSOR_DEV_ATTR_IN(5),
-		MAX197_SENSOR_DEV_ATTR_IN(6),
-		MAX197_SENSOR_DEV_ATTR_IN(7),
-		NULL
-	},
+static struct attribute *max197_attrs[] = {
+	MAX197_SENSOR_DEV_ATTR_IN(0),
+	MAX197_SENSOR_DEV_ATTR_IN(1),
+	MAX197_SENSOR_DEV_ATTR_IN(2),
+	MAX197_SENSOR_DEV_ATTR_IN(3),
+	MAX197_SENSOR_DEV_ATTR_IN(4),
+	MAX197_SENSOR_DEV_ATTR_IN(5),
+	MAX197_SENSOR_DEV_ATTR_IN(6),
+	MAX197_SENSOR_DEV_ATTR_IN(7),
+	NULL
 };
 
+ATTRIBUTE_GROUPS(max197);
+
 static int max197_probe(struct platform_device *pdev)
 {
-	int ch, ret;
 	struct max197_data *data;
+	struct device *hwmon_dev;
 	struct max197_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	enum max197_chips chip = platform_get_device_id(pdev)->driver_data;
+	int ch;
 
 	if (pdata = NULL) {
 		dev_err(&pdev->dev, "no platform data supplied\n");
@@ -292,36 +282,10 @@ static int max197_probe(struct platform_device *pdev)
 	for (ch = 0; ch < MAX197_NUM_CH; ch++)
 		data->ctrl_bytes[ch] = (u8) ch;
 
-	platform_set_drvdata(pdev, data);
-
-	ret = sysfs_create_group(&pdev->dev.kobj, &max197_sysfs_group);
-	if (ret) {
-		dev_err(&pdev->dev, "sysfs create group failed\n");
-		return ret;
-	}
-
-	data->hwmon_dev = hwmon_device_register(&pdev->dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		ret = PTR_ERR(data->hwmon_dev);
-		dev_err(&pdev->dev, "hwmon device register failed\n");
-		goto error;
-	}
-
-	return 0;
-
-error:
-	sysfs_remove_group(&pdev->dev.kobj, &max197_sysfs_group);
-	return ret;
-}
-
-static int max197_remove(struct platform_device *pdev)
-{
-	struct max197_data *data = platform_get_drvdata(pdev);
-
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&pdev->dev.kobj, &max197_sysfs_group);
-
-	return 0;
+	hwmon_dev = devm_hwmon_device_register_with_groups(&pdev->dev,
+							   pdev->name, data,
+							   max197_groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 static struct platform_device_id max197_device_ids[] = {
@@ -337,7 +301,6 @@ static struct platform_driver max197_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = max197_probe,
-	.remove = max197_remove,
 	.id_table = max197_device_ids,
 };
 module_platform_driver(max197_driver);
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
