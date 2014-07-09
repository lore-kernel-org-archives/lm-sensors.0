From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 09 Jul 2014 01:25:12 +0000
Subject: [lm-sensors] [RFT][PATCH v2 2/2] hwmon: (da9055) Convert to devm_hwmon_device_register_with_groups
Message-Id: <1404869112.12195.6.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/da9055-hwmon.c | 52 ++++++++------------------------------------
 1 file changed, 9 insertions(+), 43 deletions(-)

diff --git a/drivers/hwmon/da9055-hwmon.c b/drivers/hwmon/da9055-hwmon.c
index 35eb773..9916a3f 100644
--- a/drivers/hwmon/da9055-hwmon.c
+++ b/drivers/hwmon/da9055-hwmon.c
@@ -36,7 +36,6 @@
 
 struct da9055_hwmon {
 	struct da9055	*da9055;
-	struct device	*class_device;
 	struct mutex	hwmon_lock;
 	struct mutex	irq_lock;
 	struct completion done;
@@ -200,13 +199,6 @@ static ssize_t da9055_read_tjunc(struct device *dev,
 							+ 3076332, 10000));
 }
 
-static ssize_t da9055_hwmon_show_name(struct device *dev,
-				      struct device_attribute *devattr,
-				      char *buf)
-{
-	return sprintf(buf, "da9055\n");
-}
-
 static ssize_t show_label(struct device *dev,
 			  struct device_attribute *devattr, char *buf)
 {
@@ -236,10 +228,7 @@ static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, da9055_read_tjunc, NULL,
 static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, show_label, NULL,
 			  DA9055_ADC_TJUNC);
 
-static DEVICE_ATTR(name, S_IRUGO, da9055_hwmon_show_name, NULL);
-
-static struct attribute *da9055_attr[] = {
-	&dev_attr_name.attr,
+static struct attribute *da9055_attrs[] = {
 	&sensor_dev_attr_in0_input.dev_attr.attr,
 	&sensor_dev_attr_in0_label.dev_attr.attr,
 	&sensor_dev_attr_in1_input.dev_attr.attr,
@@ -254,15 +243,16 @@ static struct attribute *da9055_attr[] = {
 	NULL
 };
 
-static const struct attribute_group da9055_attr_group = {.attrs = da9055_attr};
+ATTRIBUTE_GROUPS(da9055);
 
 static int da9055_hwmon_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct da9055_hwmon *hwmon;
+	struct device *hwmon_dev;
 	int hwmon_irq, ret;
 
-	hwmon = devm_kzalloc(&pdev->dev, sizeof(struct da9055_hwmon),
-			     GFP_KERNEL);
+	hwmon = devm_kzalloc(dev, sizeof(struct da9055_hwmon), GFP_KERNEL);
 	if (!hwmon)
 		return -ENOMEM;
 
@@ -272,8 +262,6 @@ static int da9055_hwmon_probe(struct platform_device *pdev)
 	init_completion(&hwmon->done);
 	hwmon->da9055 = dev_get_drvdata(pdev->dev.parent);
 
-	platform_set_drvdata(pdev, hwmon);
-
 	hwmon_irq = platform_get_irq_byname(pdev, "HWMON");
 	if (hwmon_irq < 0)
 		return hwmon_irq;
@@ -288,36 +276,14 @@ static int da9055_hwmon_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = sysfs_create_group(&pdev->dev.kobj, &da9055_attr_group);
-	if (ret)
-		return ret;
-
-	hwmon->class_device = hwmon_device_register(&pdev->dev);
-	if (IS_ERR(hwmon->class_device)) {
-		ret = PTR_ERR(hwmon->class_device);
-		goto err;
-	}
-
-	return 0;
-
-err:
-	sysfs_remove_group(&pdev->dev.kobj, &da9055_attr_group);
-	return ret;
-}
-
-static int da9055_hwmon_remove(struct platform_device *pdev)
-{
-	struct da9055_hwmon *hwmon = platform_get_drvdata(pdev);
-
-	sysfs_remove_group(&pdev->dev.kobj, &da9055_attr_group);
-	hwmon_device_unregister(hwmon->class_device);
-
-	return 0;
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, "da9055",
+							   hwmon,
+							   da9055_groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 static struct platform_driver da9055_hwmon_driver = {
 	.probe = da9055_hwmon_probe,
-	.remove = da9055_hwmon_remove,
 	.driver = {
 		.name = "da9055-hwmon",
 		.owner = THIS_MODULE,
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
