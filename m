From: Alexander Shiyan <shc_work@mail.ru>
Date: Wed, 05 Jun 2013 08:57:07 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: mc13783-adc: Refactor source to indicate various mc13xxx chips
Message-Id: <1370422628-1073-1-git-send-email-shc_work@mail.ru>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch renames structures, variables and functions to indicate support
for various MC13xxx chips.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/hwmon/mc13783-adc.c | 135 +++++++++++++++++++++-----------------------
 1 file changed, 63 insertions(+), 72 deletions(-)

diff --git a/drivers/hwmon/mc13783-adc.c b/drivers/hwmon/mc13783-adc.c
index 982d862..abffdfe 100644
--- a/drivers/hwmon/mc13783-adc.c
+++ b/drivers/hwmon/mc13783-adc.c
@@ -28,30 +28,28 @@
 #include <linux/init.h>
 #include <linux/err.h>
 
-#define DRIVER_NAME	"mc13783-adc"
-
 /* platform device id driver data */
 #define MC13783_ADC_16CHANS	1
-#define MC13783_ADC_BPDIV2	2
+#define MC13892_ADC_BPDIV2	2
 
-struct mc13783_adc_priv {
+struct mc13xxx_adc_priv {
 	struct mc13xxx *mc13xxx;
 	struct device *hwmon_dev;
 	char name[10];
 };
 
-static ssize_t mc13783_adc_show_name(struct device *dev, struct device_attribute
+static ssize_t mc13xxx_adc_show_name(struct device *dev, struct device_attribute
 			      *devattr, char *buf)
 {
-	struct mc13783_adc_priv *priv = dev_get_drvdata(dev);
+	struct mc13xxx_adc_priv *priv = dev_get_drvdata(dev);
 
 	return sprintf(buf, "%s\n", priv->name);
 }
 
-static int mc13783_adc_read(struct device *dev,
+static int mc13xxx_adc_read(struct device *dev,
 		struct device_attribute *devattr, unsigned int *val)
 {
-	struct mc13783_adc_priv *priv = dev_get_drvdata(dev);
+	struct mc13xxx_adc_priv *priv = dev_get_drvdata(dev);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	unsigned int channel = attr->index;
 	unsigned int sample[4];
@@ -70,18 +68,18 @@ static int mc13783_adc_read(struct device *dev,
 	return 0;
 }
 
-static ssize_t mc13783_adc_read_bp(struct device *dev,
+static ssize_t mc13xxx_adc_read_bp(struct device *dev,
 		struct device_attribute *devattr, char *buf)
 {
 	unsigned val;
 	struct platform_device *pdev = to_platform_device(dev);
 	kernel_ulong_t driver_data = platform_get_device_id(pdev)->driver_data;
-	int ret = mc13783_adc_read(dev, devattr, &val);
+	int ret = mc13xxx_adc_read(dev, devattr, &val);
 
 	if (ret)
 		return ret;
 
-	if (driver_data & MC13783_ADC_BPDIV2)
+	if (driver_data & MC13892_ADC_BPDIV2)
 		val = DIV_ROUND_CLOSEST(val * 9, 2);
 	else
 		/*
@@ -93,11 +91,11 @@ static ssize_t mc13783_adc_read_bp(struct device *dev,
 	return sprintf(buf, "%u\n", val);
 }
 
-static ssize_t mc13783_adc_read_gp(struct device *dev,
+static ssize_t mc13xxx_adc_read_gp(struct device *dev,
 		struct device_attribute *devattr, char *buf)
 {
 	unsigned val;
-	int ret = mc13783_adc_read(dev, devattr, &val);
+	int ret = mc13xxx_adc_read(dev, devattr, &val);
 
 	if (ret)
 		return ret;
@@ -111,21 +109,21 @@ static ssize_t mc13783_adc_read_gp(struct device *dev,
 	return sprintf(buf, "%u\n", val);
 }
 
-static DEVICE_ATTR(name, S_IRUGO, mc13783_adc_show_name, NULL);
-static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, mc13783_adc_read_bp, NULL, 2);
-static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO, mc13783_adc_read_gp, NULL, 5);
-static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO, mc13783_adc_read_gp, NULL, 6);
-static SENSOR_DEVICE_ATTR(in7_input, S_IRUGO, mc13783_adc_read_gp, NULL, 7);
-static SENSOR_DEVICE_ATTR(in8_input, S_IRUGO, mc13783_adc_read_gp, NULL, 8);
-static SENSOR_DEVICE_ATTR(in9_input, S_IRUGO, mc13783_adc_read_gp, NULL, 9);
-static SENSOR_DEVICE_ATTR(in10_input, S_IRUGO, mc13783_adc_read_gp, NULL, 10);
-static SENSOR_DEVICE_ATTR(in11_input, S_IRUGO, mc13783_adc_read_gp, NULL, 11);
-static SENSOR_DEVICE_ATTR(in12_input, S_IRUGO, mc13783_adc_read_gp, NULL, 12);
-static SENSOR_DEVICE_ATTR(in13_input, S_IRUGO, mc13783_adc_read_gp, NULL, 13);
-static SENSOR_DEVICE_ATTR(in14_input, S_IRUGO, mc13783_adc_read_gp, NULL, 14);
-static SENSOR_DEVICE_ATTR(in15_input, S_IRUGO, mc13783_adc_read_gp, NULL, 15);
-
-static struct attribute *mc13783_attr_base[] = {
+static DEVICE_ATTR(name, S_IRUGO, mc13xxx_adc_show_name, NULL);
+static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, mc13xxx_adc_read_bp, NULL, 2);
+static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO, mc13xxx_adc_read_gp, NULL, 5);
+static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO, mc13xxx_adc_read_gp, NULL, 6);
+static SENSOR_DEVICE_ATTR(in7_input, S_IRUGO, mc13xxx_adc_read_gp, NULL, 7);
+static SENSOR_DEVICE_ATTR(in8_input, S_IRUGO, mc13xxx_adc_read_gp, NULL, 8);
+static SENSOR_DEVICE_ATTR(in9_input, S_IRUGO, mc13xxx_adc_read_gp, NULL, 9);
+static SENSOR_DEVICE_ATTR(in10_input, S_IRUGO, mc13xxx_adc_read_gp, NULL, 10);
+static SENSOR_DEVICE_ATTR(in11_input, S_IRUGO, mc13xxx_adc_read_gp, NULL, 11);
+static SENSOR_DEVICE_ATTR(in12_input, S_IRUGO, mc13xxx_adc_read_gp, NULL, 12);
+static SENSOR_DEVICE_ATTR(in13_input, S_IRUGO, mc13xxx_adc_read_gp, NULL, 13);
+static SENSOR_DEVICE_ATTR(in14_input, S_IRUGO, mc13xxx_adc_read_gp, NULL, 14);
+static SENSOR_DEVICE_ATTR(in15_input, S_IRUGO, mc13xxx_adc_read_gp, NULL, 15);
+
+static struct attribute *mc13xxx_attr_base[] = {
 	&dev_attr_name.attr,
 	&sensor_dev_attr_in2_input.dev_attr.attr,
 	&sensor_dev_attr_in5_input.dev_attr.attr,
@@ -134,12 +132,12 @@ static struct attribute *mc13783_attr_base[] = {
 	NULL
 };
 
-static const struct attribute_group mc13783_group_base = {
-	.attrs = mc13783_attr_base,
+static const struct attribute_group mc13xxx_group_base = {
+	.attrs = mc13xxx_attr_base,
 };
 
 /* these are only used if MC13783_ADC_16CHANS is provided in driver data */
-static struct attribute *mc13783_attr_16chans[] = {
+static struct attribute *mc13xxx_attr_16chans[] = {
 	&sensor_dev_attr_in8_input.dev_attr.attr,
 	&sensor_dev_attr_in9_input.dev_attr.attr,
 	&sensor_dev_attr_in10_input.dev_attr.attr,
@@ -147,12 +145,12 @@ static struct attribute *mc13783_attr_16chans[] = {
 	NULL
 };
 
-static const struct attribute_group mc13783_group_16chans = {
-	.attrs = mc13783_attr_16chans,
+static const struct attribute_group mc13xxx_group_16chans = {
+	.attrs = mc13xxx_attr_16chans,
 };
 
 /* last four channels may be occupied by the touchscreen */
-static struct attribute *mc13783_attr_ts[] = {
+static struct attribute *mc13xxx_attr_ts[] = {
 	&sensor_dev_attr_in12_input.dev_attr.attr,
 	&sensor_dev_attr_in13_input.dev_attr.attr,
 	&sensor_dev_attr_in14_input.dev_attr.attr,
@@ -160,21 +158,21 @@ static struct attribute *mc13783_attr_ts[] = {
 	NULL
 };
 
-static const struct attribute_group mc13783_group_ts = {
-	.attrs = mc13783_attr_ts,
+static const struct attribute_group mc13xxx_group_ts = {
+	.attrs = mc13xxx_attr_ts,
 };
 
-static int mc13783_adc_use_touchscreen(struct platform_device *pdev)
+static int mc13xxx_adc_use_touchscreen(struct platform_device *pdev)
 {
-	struct mc13783_adc_priv *priv = platform_get_drvdata(pdev);
+	struct mc13xxx_adc_priv *priv = platform_get_drvdata(pdev);
 	unsigned flags = mc13xxx_get_flags(priv->mc13xxx);
 
 	return flags & MC13XXX_USE_TOUCHSCREEN;
 }
 
-static int __init mc13783_adc_probe(struct platform_device *pdev)
+static int __init mc13xxx_adc_probe(struct platform_device *pdev)
 {
-	struct mc13783_adc_priv *priv;
+	struct mc13xxx_adc_priv *priv;
 	int ret;
 	const struct platform_device_id *id = platform_get_device_id(pdev);
 	char *dash;
@@ -192,19 +190,19 @@ static int __init mc13783_adc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, priv);
 
 	/* Register sysfs hooks */
-	ret = sysfs_create_group(&pdev->dev.kobj, &mc13783_group_base);
+	ret = sysfs_create_group(&pdev->dev.kobj, &mc13xxx_group_base);
 	if (ret)
 		return ret;
 
 	if (id->driver_data & MC13783_ADC_16CHANS) {
 		ret = sysfs_create_group(&pdev->dev.kobj,
-				&mc13783_group_16chans);
+				&mc13xxx_group_16chans);
 		if (ret)
 			goto out_err_create_16chans;
 	}
 
-	if (!mc13783_adc_use_touchscreen(pdev)) {
-		ret = sysfs_create_group(&pdev->dev.kobj, &mc13783_group_ts);
+	if (!mc13xxx_adc_use_touchscreen(pdev)) {
+		ret = sysfs_create_group(&pdev->dev.kobj, &mc13xxx_group_ts);
 		if (ret)
 			goto out_err_create_ts;
 	}
@@ -221,60 +219,53 @@ static int __init mc13783_adc_probe(struct platform_device *pdev)
 
 out_err_register:
 
-	if (!mc13783_adc_use_touchscreen(pdev))
-		sysfs_remove_group(&pdev->dev.kobj, &mc13783_group_ts);
+	if (!mc13xxx_adc_use_touchscreen(pdev))
+		sysfs_remove_group(&pdev->dev.kobj, &mc13xxx_group_ts);
 out_err_create_ts:
 
 	if (id->driver_data & MC13783_ADC_16CHANS)
-		sysfs_remove_group(&pdev->dev.kobj, &mc13783_group_16chans);
+		sysfs_remove_group(&pdev->dev.kobj, &mc13xxx_group_16chans);
 out_err_create_16chans:
 
-	sysfs_remove_group(&pdev->dev.kobj, &mc13783_group_base);
+	sysfs_remove_group(&pdev->dev.kobj, &mc13xxx_group_base);
 	return ret;
 }
 
-static int mc13783_adc_remove(struct platform_device *pdev)
+static int mc13xxx_adc_remove(struct platform_device *pdev)
 {
-	struct mc13783_adc_priv *priv = platform_get_drvdata(pdev);
+	struct mc13xxx_adc_priv *priv = platform_get_drvdata(pdev);
 	kernel_ulong_t driver_data = platform_get_device_id(pdev)->driver_data;
 
 	hwmon_device_unregister(priv->hwmon_dev);
 
-	if (!mc13783_adc_use_touchscreen(pdev))
-		sysfs_remove_group(&pdev->dev.kobj, &mc13783_group_ts);
+	if (!mc13xxx_adc_use_touchscreen(pdev))
+		sysfs_remove_group(&pdev->dev.kobj, &mc13xxx_group_ts);
 
 	if (driver_data & MC13783_ADC_16CHANS)
-		sysfs_remove_group(&pdev->dev.kobj, &mc13783_group_16chans);
+		sysfs_remove_group(&pdev->dev.kobj, &mc13xxx_group_16chans);
 
-	sysfs_remove_group(&pdev->dev.kobj, &mc13783_group_base);
+	sysfs_remove_group(&pdev->dev.kobj, &mc13xxx_group_base);
 
 	return 0;
 }
 
-static const struct platform_device_id mc13783_adc_idtable[] = {
-	{
-		.name = "mc13783-adc",
-		.driver_data = MC13783_ADC_16CHANS,
-	}, {
-		.name = "mc13892-adc",
-		.driver_data = MC13783_ADC_BPDIV2,
-	}, {
-		/* sentinel */
-	}
+static const struct platform_device_id mc13xxx_adc_idtable[] = {
+	{ "mc13783-adc", MC13783_ADC_16CHANS, },
+	{ "mc13892-adc", MC13892_ADC_BPDIV2, },
+	{ }
 };
-MODULE_DEVICE_TABLE(platform, mc13783_adc_idtable);
+MODULE_DEVICE_TABLE(platform, mc13xxx_adc_idtable);
 
-static struct platform_driver mc13783_adc_driver = {
-	.remove		= mc13783_adc_remove,
+static struct platform_driver mc13xxx_adc_driver = {
 	.driver		= {
 		.owner	= THIS_MODULE,
-		.name	= DRIVER_NAME,
+		.name	= "mc13xxx-adc",
 	},
-	.id_table	= mc13783_adc_idtable,
+	.remove		= mc13xxx_adc_remove,
+	.id_table	= mc13xxx_adc_idtable,
 };
+module_platform_driver_probe(mc13xxx_adc_driver, mc13xxx_adc_probe);
 
-module_platform_driver_probe(mc13783_adc_driver, mc13783_adc_probe);
-
-MODULE_DESCRIPTION("MC13783 ADC driver");
+MODULE_DESCRIPTION("MC13XXX ADC driver");
 MODULE_AUTHOR("Luotao Fu <l.fu@pengutronix.de>");
 MODULE_LICENSE("GPL");
-- 
1.8.1.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
