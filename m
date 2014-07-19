From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 19 Jul 2014 14:26:12 +0000
Subject: [lm-sensors] [RFT][PATCH] hwmon: (ntc_thermistor) Convert to hwmon_device_register_with_groups
Message-Id: <1405779972.15902.1.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use ATTRIBUTE_GROUPS macro and hwmon_device_register_with_groups() to simplify
the code a bit.

Use hwmon_device_register_with_groups rather than the device managed version to
ensure ntc_iio_channel_release() is called after hwmon_device_unregister(),

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/ntc_thermistor.c | 37 +++++++------------------------------
 1 file changed, 7 insertions(+), 30 deletions(-)

diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
index bd41072..5c96f09 100644
--- a/drivers/hwmon/ntc_thermistor.c
+++ b/drivers/hwmon/ntc_thermistor.c
@@ -428,14 +428,6 @@ static int ntc_thermistor_get_ohm(struct ntc_data *data)
 	return -EINVAL;
 }
 
-static ssize_t ntc_show_name(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct ntc_data *data = dev_get_drvdata(dev);
-
-	return sprintf(buf, "%s\n", data->name);
-}
-
 static ssize_t ntc_show_type(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
@@ -457,18 +449,14 @@ static ssize_t ntc_show_temp(struct device *dev,
 
 static SENSOR_DEVICE_ATTR(temp1_type, S_IRUGO, ntc_show_type, NULL, 0);
 static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, ntc_show_temp, NULL, 0);
-static DEVICE_ATTR(name, S_IRUGO, ntc_show_name, NULL);
 
-static struct attribute *ntc_attributes[] = {
-	&dev_attr_name.attr,
+static struct attribute *ntc_attrs[] = {
 	&sensor_dev_attr_temp1_type.dev_attr.attr,
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	NULL,
 };
 
-static const struct attribute_group ntc_attr_group = {
-	.attrs = ntc_attributes,
-};
+ATTRIBUTE_GROUPS(ntc);
 
 static int ntc_thermistor_probe(struct platform_device *pdev)
 {
@@ -477,7 +465,6 @@ static int ntc_thermistor_probe(struct platform_device *pdev)
 	const struct platform_device_id *pdev_id;
 	struct ntc_thermistor_platform_data *pdata;
 	struct ntc_data *data;
-	int ret;
 
 	pdata = ntc_thermistor_parse_dt(pdev);
 	if (IS_ERR(pdata))
@@ -546,27 +533,18 @@ static int ntc_thermistor_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, data);
 
-	ret = sysfs_create_group(&data->dev->kobj, &ntc_attr_group);
-	if (ret) {
-		dev_err(data->dev, "unable to create sysfs files\n");
-		return ret;
-	}
-
-	data->hwmon_dev = hwmon_device_register(data->dev);
+	data->hwmon_dev = hwmon_device_register_with_groups(data->dev,
+							    data->name, data,
+							    ntc_groups);
 	if (IS_ERR(data->hwmon_dev)) {
 		dev_err(data->dev, "unable to register as hwmon device.\n");
-		ret = PTR_ERR(data->hwmon_dev);
-		goto err_after_sysfs;
+		ntc_iio_channel_release(pdata);
+		return PTR_ERR(data->hwmon_dev);
 	}
 
 	dev_info(&pdev->dev, "Thermistor type: %s successfully probed.\n",
 								pdev_id->name);
-
 	return 0;
-err_after_sysfs:
-	sysfs_remove_group(&data->dev->kobj, &ntc_attr_group);
-	ntc_iio_channel_release(pdata);
-	return ret;
 }
 
 static int ntc_thermistor_remove(struct platform_device *pdev)
@@ -575,7 +553,6 @@ static int ntc_thermistor_remove(struct platform_device *pdev)
 	struct ntc_thermistor_platform_data *pdata = data->pdata;
 
 	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&data->dev->kobj, &ntc_attr_group);
 	ntc_iio_channel_release(pdata);
 
 	return 0;
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
