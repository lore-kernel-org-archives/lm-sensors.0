From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 08 Jul 2014 01:32:41 +0000
Subject: [lm-sensors] [RFT][PATCH] hwmon: (mc13783-adc) Convert to devm_hwmon_device_register_with_groups
Message-Id: <1404783161.10553.3.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/mc13783-adc.c | 100 +++++++++-----------------------------------
 1 file changed, 19 insertions(+), 81 deletions(-)

diff --git a/drivers/hwmon/mc13783-adc.c b/drivers/hwmon/mc13783-adc.c
index ae00e60..9eea237 100644
--- a/drivers/hwmon/mc13783-adc.c
+++ b/drivers/hwmon/mc13783-adc.c
@@ -36,18 +36,11 @@
 
 struct mc13783_adc_priv {
 	struct mc13xxx *mc13xxx;
-	struct device *hwmon_dev;
+	const struct attribute_group *groups[4];
+	struct platform_device *pdev;
 	char name[PLATFORM_NAME_SIZE];
 };
 
-static ssize_t mc13783_adc_show_name(struct device *dev, struct device_attribute
-			      *devattr, char *buf)
-{
-	struct mc13783_adc_priv *priv = dev_get_drvdata(dev);
-
-	return sprintf(buf, "%s\n", priv->name);
-}
-
 static int mc13783_adc_read(struct device *dev,
 		struct device_attribute *devattr, unsigned int *val)
 {
@@ -74,10 +67,12 @@ static ssize_t mc13783_adc_read_bp(struct device *dev,
 		struct device_attribute *devattr, char *buf)
 {
 	unsigned val;
-	struct platform_device *pdev = to_platform_device(dev);
-	kernel_ulong_t driver_data = platform_get_device_id(pdev)->driver_data;
-	int ret = mc13783_adc_read(dev, devattr, &val);
+	struct mc13783_adc_priv *priv = dev_get_drvdata(dev);
+	kernel_ulong_t driver_data;
+	int ret;
 
+	driver_data = platform_get_device_id(priv->pdev)->driver_data;
+	ret = mc13783_adc_read(dev, devattr, &val);
 	if (ret)
 		return ret;
 
@@ -111,7 +106,6 @@ static ssize_t mc13783_adc_read_gp(struct device *dev,
 	return sprintf(buf, "%u\n", val);
 }
 
-static DEVICE_ATTR(name, S_IRUGO, mc13783_adc_show_name, NULL);
 static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, mc13783_adc_read_bp, NULL, 2);
 static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO, mc13783_adc_read_gp, NULL, 5);
 static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO, mc13783_adc_read_gp, NULL, 6);
@@ -126,7 +120,6 @@ static SENSOR_DEVICE_ATTR(in14_input, S_IRUGO, mc13783_adc_read_gp, NULL, 14);
 static SENSOR_DEVICE_ATTR(in15_input, S_IRUGO, mc13783_adc_read_gp, NULL, 15);
 
 static struct attribute *mc13783_attr_base[] = {
-	&dev_attr_name.attr,
 	&sensor_dev_attr_in2_input.dev_attr.attr,
 	&sensor_dev_attr_in5_input.dev_attr.attr,
 	&sensor_dev_attr_in6_input.dev_attr.attr,
@@ -164,91 +157,37 @@ static const struct attribute_group mc13783_group_ts = {
 	.attrs = mc13783_attr_ts,
 };
 
-static int mc13783_adc_use_touchscreen(struct platform_device *pdev)
-{
-	struct mc13783_adc_priv *priv = platform_get_drvdata(pdev);
-	unsigned flags = mc13xxx_get_flags(priv->mc13xxx);
-
-	return flags & MC13XXX_USE_TOUCHSCREEN;
-}
-
 static int __init mc13783_adc_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct mc13783_adc_priv *priv;
-	int ret;
+	struct device *hwmon_dev;
 	const struct platform_device_id *id = platform_get_device_id(pdev);
 	char *dash;
+	int idx = 0;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
+	priv->pdev = pdev;
 	priv->mc13xxx = dev_get_drvdata(pdev->dev.parent);
 	snprintf(priv->name, ARRAY_SIZE(priv->name), "%s", id->name);
 	dash = strchr(priv->name, '-');
 	if (dash)
 		*dash = '\0';
 
-	platform_set_drvdata(pdev, priv);
-
-	/* Register sysfs hooks */
-	ret = sysfs_create_group(&pdev->dev.kobj, &mc13783_group_base);
-	if (ret)
-		return ret;
-
-	if (id->driver_data & MC13783_ADC_16CHANS) {
-		ret = sysfs_create_group(&pdev->dev.kobj,
-				&mc13783_group_16chans);
-		if (ret)
-			goto out_err_create_16chans;
-	}
-
-	if (!mc13783_adc_use_touchscreen(pdev)) {
-		ret = sysfs_create_group(&pdev->dev.kobj, &mc13783_group_ts);
-		if (ret)
-			goto out_err_create_ts;
-	}
-
-	priv->hwmon_dev = hwmon_device_register(&pdev->dev);
-	if (IS_ERR(priv->hwmon_dev)) {
-		ret = PTR_ERR(priv->hwmon_dev);
-		dev_err(&pdev->dev,
-				"hwmon_device_register failed with %d.\n", ret);
-		goto out_err_register;
-	}
-
-	return 0;
-
-out_err_register:
-
-	if (!mc13783_adc_use_touchscreen(pdev))
-		sysfs_remove_group(&pdev->dev.kobj, &mc13783_group_ts);
-out_err_create_ts:
-
+	/* sysfs hooks */
+	priv->groups[idx++] = &mc13783_group_base;
 	if (id->driver_data & MC13783_ADC_16CHANS)
-		sysfs_remove_group(&pdev->dev.kobj, &mc13783_group_16chans);
-out_err_create_16chans:
-
-	sysfs_remove_group(&pdev->dev.kobj, &mc13783_group_base);
-	return ret;
-}
-
-static int mc13783_adc_remove(struct platform_device *pdev)
-{
-	struct mc13783_adc_priv *priv = platform_get_drvdata(pdev);
-	kernel_ulong_t driver_data = platform_get_device_id(pdev)->driver_data;
+		priv->groups[idx++] = &mc13783_group_16chans;
 
-	hwmon_device_unregister(priv->hwmon_dev);
+	if (mc13xxx_get_flags(priv->mc13xxx) & MC13XXX_USE_TOUCHSCREEN)
+		priv->groups[idx++] = &mc13783_group_ts;
 
-	if (!mc13783_adc_use_touchscreen(pdev))
-		sysfs_remove_group(&pdev->dev.kobj, &mc13783_group_ts);
-
-	if (driver_data & MC13783_ADC_16CHANS)
-		sysfs_remove_group(&pdev->dev.kobj, &mc13783_group_16chans);
-
-	sysfs_remove_group(&pdev->dev.kobj, &mc13783_group_base);
-
-	return 0;
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, priv->name,
+							   priv, priv->groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 static const struct platform_device_id mc13783_adc_idtable[] = {
@@ -265,7 +204,6 @@ static const struct platform_device_id mc13783_adc_idtable[] = {
 MODULE_DEVICE_TABLE(platform, mc13783_adc_idtable);
 
 static struct platform_driver mc13783_adc_driver = {
-	.remove		= mc13783_adc_remove,
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= DRIVER_NAME,
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
