From: Pawel Moll <pawel.moll@arm.com>
Date: Wed, 23 Apr 2014 17:27:04 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: vexpress: Use legal hwmon device names
Message-Id: <1398274025-13618-2-git-send-email-pawel.moll@arm.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The driver used to directly us a DT 'compatible' property for
the 'name' attribute of the hwmon devices. Unfortunately it
contains '-' which is illegal in this context. It messes up
libsensors and thus every application using it.

Fixed by providing equivalent (and simpler) name strings.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/hwmon/vexpress.c | 61 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 52 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/vexpress.c b/drivers/hwmon/vexpress.c
index d867e6b..7f96905 100644
--- a/drivers/hwmon/vexpress.c
+++ b/drivers/hwmon/vexpress.c
@@ -27,15 +27,15 @@
 struct vexpress_hwmon_data {
 	struct device *hwmon_dev;
 	struct vexpress_config_func *func;
+	const char *name;
 };
 
 static ssize_t vexpress_hwmon_name_show(struct device *dev,
 		struct device_attribute *dev_attr, char *buffer)
 {
-	const char *compatible = of_get_property(dev->of_node, "compatible",
-			NULL);
+	struct vexpress_hwmon_data *data = dev_get_drvdata(dev);
 
-	return sprintf(buffer, "%s\n", compatible);
+	return sprintf(buffer, "%s\n", data->name);
 }
 
 static ssize_t vexpress_hwmon_label_show(struct device *dev,
@@ -94,6 +94,11 @@ struct attribute *vexpress_hwmon_attrs_##_name[] = {		\
 	NULL							\
 }
 
+struct vexpress_hwmon_type {
+	const char *name;
+	const struct attribute_group **attr_groups;
+};
+
 #if !defined(CONFIG_REGULATOR_VEXPRESS)
 static DEVICE_ATTR(in1_label, S_IRUGO, vexpress_hwmon_label_show, NULL);
 static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, vexpress_hwmon_u32_show,
@@ -102,6 +107,13 @@ static VEXPRESS_HWMON_ATTRS(volt, in1_label, in1_input);
 static struct attribute_group vexpress_hwmon_group_volt = {
 	.attrs = vexpress_hwmon_attrs_volt,
 };
+static struct vexpress_hwmon_type vexpress_hwmon_volt = {
+	.name = "vexpress_volt",
+	.attr_groups = (const struct attribute_group *[]) {
+		&vexpress_hwmon_group_volt,
+		NULL,
+	},
+};
 #endif
 
 static DEVICE_ATTR(curr1_label, S_IRUGO, vexpress_hwmon_label_show, NULL);
@@ -111,6 +123,13 @@ static VEXPRESS_HWMON_ATTRS(amp, curr1_label, curr1_input);
 static struct attribute_group vexpress_hwmon_group_amp = {
 	.attrs = vexpress_hwmon_attrs_amp,
 };
+static struct vexpress_hwmon_type vexpress_hwmon_amp = {
+	.name = "vexpress_amp",
+	.attr_groups = (const struct attribute_group *[]) {
+		&vexpress_hwmon_group_amp,
+		NULL
+	},
+};
 
 static DEVICE_ATTR(temp1_label, S_IRUGO, vexpress_hwmon_label_show, NULL);
 static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, vexpress_hwmon_u32_show,
@@ -119,6 +138,13 @@ static VEXPRESS_HWMON_ATTRS(temp, temp1_label, temp1_input);
 static struct attribute_group vexpress_hwmon_group_temp = {
 	.attrs = vexpress_hwmon_attrs_temp,
 };
+static struct vexpress_hwmon_type vexpress_hwmon_temp = {
+	.name = "vexpress_temp",
+	.attr_groups = (const struct attribute_group *[]) {
+		&vexpress_hwmon_group_temp,
+		NULL
+	},
+};
 
 static DEVICE_ATTR(power1_label, S_IRUGO, vexpress_hwmon_label_show, NULL);
 static SENSOR_DEVICE_ATTR(power1_input, S_IRUGO, vexpress_hwmon_u32_show,
@@ -127,6 +153,13 @@ static VEXPRESS_HWMON_ATTRS(power, power1_label, power1_input);
 static struct attribute_group vexpress_hwmon_group_power = {
 	.attrs = vexpress_hwmon_attrs_power,
 };
+static struct vexpress_hwmon_type vexpress_hwmon_power = {
+	.name = "vexpress_power",
+	.attr_groups = (const struct attribute_group *[]) {
+		&vexpress_hwmon_group_power,
+		NULL
+	},
+};
 
 static DEVICE_ATTR(energy1_label, S_IRUGO, vexpress_hwmon_label_show, NULL);
 static SENSOR_DEVICE_ATTR(energy1_input, S_IRUGO, vexpress_hwmon_u64_show,
@@ -135,26 +168,33 @@ static VEXPRESS_HWMON_ATTRS(energy, energy1_label, energy1_input);
 static struct attribute_group vexpress_hwmon_group_energy = {
 	.attrs = vexpress_hwmon_attrs_energy,
 };
+static struct vexpress_hwmon_type vexpress_hwmon_energy = {
+	.name = "vexpress_energy",
+	.attr_groups = (const struct attribute_group *[]) {
+		&vexpress_hwmon_group_energy,
+		NULL
+	},
+};
 
 static struct of_device_id vexpress_hwmon_of_match[] = {
 #if !defined(CONFIG_REGULATOR_VEXPRESS)
 	{
 		.compatible = "arm,vexpress-volt",
-		.data = &vexpress_hwmon_group_volt,
+		.data = &vexpress_hwmon_volt,
 	},
 #endif
 	{
 		.compatible = "arm,vexpress-amp",
-		.data = &vexpress_hwmon_group_amp,
+		.data = &vexpress_hwmon_amp,
 	}, {
 		.compatible = "arm,vexpress-temp",
-		.data = &vexpress_hwmon_group_temp,
+		.data = &vexpress_hwmon_temp,
 	}, {
 		.compatible = "arm,vexpress-power",
-		.data = &vexpress_hwmon_group_power,
+		.data = &vexpress_hwmon_power,
 	}, {
 		.compatible = "arm,vexpress-energy",
-		.data = &vexpress_hwmon_group_energy,
+		.data = &vexpress_hwmon_energy,
 	},
 	{}
 };
@@ -165,6 +205,7 @@ static int vexpress_hwmon_probe(struct platform_device *pdev)
 	int err;
 	const struct of_device_id *match;
 	struct vexpress_hwmon_data *data;
+	const struct vexpress_hwmon_type *type;
 
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -174,12 +215,14 @@ static int vexpress_hwmon_probe(struct platform_device *pdev)
 	match = of_match_device(vexpress_hwmon_of_match, &pdev->dev);
 	if (!match)
 		return -ENODEV;
+	type = match->data;
+	data->name = type->name;
 
 	data->func = vexpress_config_func_get_by_dev(&pdev->dev);
 	if (!data->func)
 		return -ENODEV;
 
-	err = sysfs_create_group(&pdev->dev.kobj, match->data);
+	err = sysfs_create_groups(&pdev->dev.kobj, type->attr_groups);
 	if (err)
 		goto error;
 
-- 
1.8.3.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
