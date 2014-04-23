From: Pawel Moll <pawel.moll@arm.com>
Date: Wed, 23 Apr 2014 17:27:05 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: vexpress: Avoid creating non-existing attributes
Message-Id: <1398274025-13618-3-git-send-email-pawel.moll@arm.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The 'label' attribute was always created but returned -ENOENT
if there is no label and such behaviour is undefined from
libsensors' point of view.

Fixed by providing is_visible method in the attributes group,
so the attribute is not created at all when unnecessary.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/hwmon/vexpress.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/vexpress.c b/drivers/hwmon/vexpress.c
index 7f96905..8242b75 100644
--- a/drivers/hwmon/vexpress.c
+++ b/drivers/hwmon/vexpress.c
@@ -43,9 +43,6 @@ static ssize_t vexpress_hwmon_label_show(struct device *dev,
 {
 	const char *label = of_get_property(dev->of_node, "label", NULL);
 
-	if (!label)
-		return -ENOENT;
-
 	return snprintf(buffer, PAGE_SIZE, "%s\n", label);
 }
 
@@ -84,6 +81,20 @@ static ssize_t vexpress_hwmon_u64_show(struct device *dev,
 			to_sensor_dev_attr(dev_attr)->index));
 }
 
+static umode_t vexpress_hwmon_attr_is_visible(struct kobject *kobj,
+		struct attribute *attr, int index)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct device_attribute *dev_attr = container_of(attr,
+				struct device_attribute, attr);
+
+	if (dev_attr->show = vexpress_hwmon_label_show &&
+			!of_get_property(dev->of_node, "label", NULL))
+		return 0;
+
+	return attr->mode;
+}
+
 static DEVICE_ATTR(name, S_IRUGO, vexpress_hwmon_name_show, NULL);
 
 #define VEXPRESS_HWMON_ATTRS(_name, _label_attr, _input_attr)	\
@@ -105,6 +116,7 @@ static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, vexpress_hwmon_u32_show,
 		NULL, 1000);
 static VEXPRESS_HWMON_ATTRS(volt, in1_label, in1_input);
 static struct attribute_group vexpress_hwmon_group_volt = {
+	.is_visible = vexpress_hwmon_attr_is_visible,
 	.attrs = vexpress_hwmon_attrs_volt,
 };
 static struct vexpress_hwmon_type vexpress_hwmon_volt = {
@@ -121,6 +133,7 @@ static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO, vexpress_hwmon_u32_show,
 		NULL, 1000);
 static VEXPRESS_HWMON_ATTRS(amp, curr1_label, curr1_input);
 static struct attribute_group vexpress_hwmon_group_amp = {
+	.is_visible = vexpress_hwmon_attr_is_visible,
 	.attrs = vexpress_hwmon_attrs_amp,
 };
 static struct vexpress_hwmon_type vexpress_hwmon_amp = {
@@ -136,6 +149,7 @@ static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, vexpress_hwmon_u32_show,
 		NULL, 1000);
 static VEXPRESS_HWMON_ATTRS(temp, temp1_label, temp1_input);
 static struct attribute_group vexpress_hwmon_group_temp = {
+	.is_visible = vexpress_hwmon_attr_is_visible,
 	.attrs = vexpress_hwmon_attrs_temp,
 };
 static struct vexpress_hwmon_type vexpress_hwmon_temp = {
@@ -151,6 +165,7 @@ static SENSOR_DEVICE_ATTR(power1_input, S_IRUGO, vexpress_hwmon_u32_show,
 		NULL, 1);
 static VEXPRESS_HWMON_ATTRS(power, power1_label, power1_input);
 static struct attribute_group vexpress_hwmon_group_power = {
+	.is_visible = vexpress_hwmon_attr_is_visible,
 	.attrs = vexpress_hwmon_attrs_power,
 };
 static struct vexpress_hwmon_type vexpress_hwmon_power = {
@@ -166,6 +181,7 @@ static SENSOR_DEVICE_ATTR(energy1_input, S_IRUGO, vexpress_hwmon_u64_show,
 		NULL, 1);
 static VEXPRESS_HWMON_ATTRS(energy, energy1_label, energy1_input);
 static struct attribute_group vexpress_hwmon_group_energy = {
+	.is_visible = vexpress_hwmon_attr_is_visible,
 	.attrs = vexpress_hwmon_attrs_energy,
 };
 static struct vexpress_hwmon_type vexpress_hwmon_energy = {
-- 
1.8.3.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
