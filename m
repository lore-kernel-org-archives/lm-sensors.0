From: Pawel Moll <pawel.moll@arm.com>
Date: Thu, 12 Jun 2014 14:14:33 +0000
Subject: [lm-sensors] [PATCH v2 RESENT] hwmon: vexpress: Use devm helper for hwmon device registration
Message-Id: <1402582473-12447-1-git-send-email-pawel.moll@arm.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use devm_hwmon_device_register_with_groups instead of
the old-style manual attributes and hwmon device registration.

Also, unroll the attribute group macros for better code
readability.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/vexpress.c | 82 +++++++++++++++++-------------------------------
 1 file changed, 28 insertions(+), 54 deletions(-)

Now, as the base vexpress changes have been merged, this patch
can be finally queued for next...

diff --git a/drivers/hwmon/vexpress.c b/drivers/hwmon/vexpress.c
index 611f34c..c536190 100644
--- a/drivers/hwmon/vexpress.c
+++ b/drivers/hwmon/vexpress.c
@@ -27,17 +27,8 @@
 struct vexpress_hwmon_data {
 	struct device *hwmon_dev;
 	struct regmap *reg;
-	const char *name;
 };
 
-static ssize_t vexpress_hwmon_name_show(struct device *dev,
-		struct device_attribute *dev_attr, char *buffer)
-{
-	struct vexpress_hwmon_data *data = dev_get_drvdata(dev);
-
-	return sprintf(buffer, "%s\n", data->name);
-}
-
 static ssize_t vexpress_hwmon_label_show(struct device *dev,
 		struct device_attribute *dev_attr, char *buffer)
 {
@@ -95,16 +86,6 @@ static umode_t vexpress_hwmon_attr_is_visible(struct kobject *kobj,
 	return attr->mode;
 }
 
-static DEVICE_ATTR(name, S_IRUGO, vexpress_hwmon_name_show, NULL);
-
-#define VEXPRESS_HWMON_ATTRS(_name, _label_attr, _input_attr)	\
-struct attribute *vexpress_hwmon_attrs_##_name[] = {		\
-	&dev_attr_name.attr,					\
-	&dev_attr_##_label_attr.attr,				\
-	&sensor_dev_attr_##_input_attr.dev_attr.attr,		\
-	NULL							\
-}
-
 struct vexpress_hwmon_type {
 	const char *name;
 	const struct attribute_group **attr_groups;
@@ -114,7 +95,11 @@ struct vexpress_hwmon_type {
 static DEVICE_ATTR(in1_label, S_IRUGO, vexpress_hwmon_label_show, NULL);
 static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, vexpress_hwmon_u32_show,
 		NULL, 1000);
-static VEXPRESS_HWMON_ATTRS(volt, in1_label, in1_input);
+static struct attribute *vexpress_hwmon_attrs_volt[] = {
+	&dev_attr_in1_label.attr,
+	&sensor_dev_attr_in1_input.dev_attr.attr,
+	NULL
+};
 static struct attribute_group vexpress_hwmon_group_volt = {
 	.is_visible = vexpress_hwmon_attr_is_visible,
 	.attrs = vexpress_hwmon_attrs_volt,
@@ -131,7 +116,11 @@ static struct vexpress_hwmon_type vexpress_hwmon_volt = {
 static DEVICE_ATTR(curr1_label, S_IRUGO, vexpress_hwmon_label_show, NULL);
 static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO, vexpress_hwmon_u32_show,
 		NULL, 1000);
-static VEXPRESS_HWMON_ATTRS(amp, curr1_label, curr1_input);
+static struct attribute *vexpress_hwmon_attrs_amp[] = {
+	&dev_attr_curr1_label.attr,
+	&sensor_dev_attr_curr1_input.dev_attr.attr,
+	NULL
+};
 static struct attribute_group vexpress_hwmon_group_amp = {
 	.is_visible = vexpress_hwmon_attr_is_visible,
 	.attrs = vexpress_hwmon_attrs_amp,
@@ -147,7 +136,11 @@ static struct vexpress_hwmon_type vexpress_hwmon_amp = {
 static DEVICE_ATTR(temp1_label, S_IRUGO, vexpress_hwmon_label_show, NULL);
 static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, vexpress_hwmon_u32_show,
 		NULL, 1000);
-static VEXPRESS_HWMON_ATTRS(temp, temp1_label, temp1_input);
+static struct attribute *vexpress_hwmon_attrs_temp[] = {
+	&dev_attr_temp1_label.attr,
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	NULL
+};
 static struct attribute_group vexpress_hwmon_group_temp = {
 	.is_visible = vexpress_hwmon_attr_is_visible,
 	.attrs = vexpress_hwmon_attrs_temp,
@@ -163,7 +156,11 @@ static struct vexpress_hwmon_type vexpress_hwmon_temp = {
 static DEVICE_ATTR(power1_label, S_IRUGO, vexpress_hwmon_label_show, NULL);
 static SENSOR_DEVICE_ATTR(power1_input, S_IRUGO, vexpress_hwmon_u32_show,
 		NULL, 1);
-static VEXPRESS_HWMON_ATTRS(power, power1_label, power1_input);
+static struct attribute *vexpress_hwmon_attrs_power[] = {
+	&dev_attr_power1_label.attr,
+	&sensor_dev_attr_power1_input.dev_attr.attr,
+	NULL
+};
 static struct attribute_group vexpress_hwmon_group_power = {
 	.is_visible = vexpress_hwmon_attr_is_visible,
 	.attrs = vexpress_hwmon_attrs_power,
@@ -179,7 +176,11 @@ static struct vexpress_hwmon_type vexpress_hwmon_power = {
 static DEVICE_ATTR(energy1_label, S_IRUGO, vexpress_hwmon_label_show, NULL);
 static SENSOR_DEVICE_ATTR(energy1_input, S_IRUGO, vexpress_hwmon_u64_show,
 		NULL, 1);
-static VEXPRESS_HWMON_ATTRS(energy, energy1_label, energy1_input);
+static struct attribute *vexpress_hwmon_attrs_energy[] = {
+	&dev_attr_energy1_label.attr,
+	&sensor_dev_attr_energy1_input.dev_attr.attr,
+	NULL
+};
 static struct attribute_group vexpress_hwmon_group_energy = {
 	.is_visible = vexpress_hwmon_attr_is_visible,
 	.attrs = vexpress_hwmon_attrs_energy,
@@ -218,7 +219,6 @@ MODULE_DEVICE_TABLE(of, vexpress_hwmon_of_match);
 
 static int vexpress_hwmon_probe(struct platform_device *pdev)
 {
-	int err;
 	const struct of_device_id *match;
 	struct vexpress_hwmon_data *data;
 	const struct vexpress_hwmon_type *type;
@@ -232,45 +232,19 @@ static int vexpress_hwmon_probe(struct platform_device *pdev)
 	if (!match)
 		return -ENODEV;
 	type = match->data;
-	data->name = type->name;
 
 	data->reg = devm_regmap_init_vexpress_config(&pdev->dev);
 	if (IS_ERR(data->reg))
 		return PTR_ERR(data->reg);
 
-	err = sysfs_create_groups(&pdev->dev.kobj, type->attr_groups);
-	if (err)
-		goto error;
-
-	data->hwmon_dev = hwmon_device_register(&pdev->dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		err = PTR_ERR(data->hwmon_dev);
-		goto error;
-	}
-
-	return 0;
-
-error:
-	sysfs_remove_group(&pdev->dev.kobj, match->data);
-	return err;
-}
-
-static int vexpress_hwmon_remove(struct platform_device *pdev)
-{
-	struct vexpress_hwmon_data *data = platform_get_drvdata(pdev);
-	const struct of_device_id *match;
-
-	hwmon_device_unregister(data->hwmon_dev);
-
-	match = of_match_device(vexpress_hwmon_of_match, &pdev->dev);
-	sysfs_remove_group(&pdev->dev.kobj, match->data);
+	data->hwmon_dev = devm_hwmon_device_register_with_groups(&pdev->dev,
+			type->name, data, type->attr_groups);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(data->hwmon_dev);
 }
 
 static struct platform_driver vexpress_hwmon_driver = {
 	.probe = vexpress_hwmon_probe,
-	.remove = vexpress_hwmon_remove,
 	.driver	= {
 		.name = DRVNAME,
 		.owner = THIS_MODULE,
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
