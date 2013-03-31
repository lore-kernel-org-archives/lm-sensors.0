From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 31 Mar 2013 18:09:35 +0000
Subject: [lm-sensors] [PATCH 1/5] hwmon: (it87) Use is_visible for voltage sensors
Message-Id: <1364753379-20222-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Simplify code and reduce object size by more than 300 bytes on x86_64.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/it87.c |  106 +++++++++++++++++++++-----------------------------
 1 file changed, 45 insertions(+), 61 deletions(-)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index 72b21d5..bbf2a34 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -1424,70 +1424,82 @@ static ssize_t show_name(struct device *dev, struct device_attribute
 }
 static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
 
-static struct attribute *it87_attributes_in[9][5] = {
+static umode_t it87_in_is_visible(struct kobject *kobj,
+				  struct attribute *attr, int index)
 {
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct it87_sio_data *sio_data = dev->platform_data;
+	int i = index / 5;	/* voltage index */
+	int a = index % 5;	/* attribute index */
+
+	if (sio_data->skip_in & (1 << i))
+		return 0;
+
+	if (i = 8 && a != 0)
+		return 0;
+
+	if (a = 4 && !sio_data->beep_pin)
+		return 0;
+
+	return attr->mode;
+}
+
+static struct attribute *it87_attributes_in[] = {
 	&sensor_dev_attr_in0_input.dev_attr.attr,
 	&sensor_dev_attr_in0_min.dev_attr.attr,
 	&sensor_dev_attr_in0_max.dev_attr.attr,
 	&sensor_dev_attr_in0_alarm.dev_attr.attr,
-	NULL
-}, {
+	&sensor_dev_attr_in0_beep.dev_attr.attr,	/* 4 */
+
 	&sensor_dev_attr_in1_input.dev_attr.attr,
 	&sensor_dev_attr_in1_min.dev_attr.attr,
 	&sensor_dev_attr_in1_max.dev_attr.attr,
 	&sensor_dev_attr_in1_alarm.dev_attr.attr,
-	NULL
-}, {
+	&sensor_dev_attr_in1_beep.dev_attr.attr,
+
 	&sensor_dev_attr_in2_input.dev_attr.attr,
 	&sensor_dev_attr_in2_min.dev_attr.attr,
 	&sensor_dev_attr_in2_max.dev_attr.attr,
 	&sensor_dev_attr_in2_alarm.dev_attr.attr,
-	NULL
-}, {
+	&sensor_dev_attr_in2_beep.dev_attr.attr,
+
 	&sensor_dev_attr_in3_input.dev_attr.attr,
 	&sensor_dev_attr_in3_min.dev_attr.attr,
 	&sensor_dev_attr_in3_max.dev_attr.attr,
 	&sensor_dev_attr_in3_alarm.dev_attr.attr,
-	NULL
-}, {
+	&sensor_dev_attr_in3_beep.dev_attr.attr,
+
 	&sensor_dev_attr_in4_input.dev_attr.attr,
 	&sensor_dev_attr_in4_min.dev_attr.attr,
 	&sensor_dev_attr_in4_max.dev_attr.attr,
 	&sensor_dev_attr_in4_alarm.dev_attr.attr,
-	NULL
-}, {
+	&sensor_dev_attr_in4_beep.dev_attr.attr,
+
 	&sensor_dev_attr_in5_input.dev_attr.attr,
 	&sensor_dev_attr_in5_min.dev_attr.attr,
 	&sensor_dev_attr_in5_max.dev_attr.attr,
 	&sensor_dev_attr_in5_alarm.dev_attr.attr,
-	NULL
-}, {
+	&sensor_dev_attr_in5_beep.dev_attr.attr,
+
 	&sensor_dev_attr_in6_input.dev_attr.attr,
 	&sensor_dev_attr_in6_min.dev_attr.attr,
 	&sensor_dev_attr_in6_max.dev_attr.attr,
 	&sensor_dev_attr_in6_alarm.dev_attr.attr,
-	NULL
-}, {
+	&sensor_dev_attr_in6_beep.dev_attr.attr,
+
 	&sensor_dev_attr_in7_input.dev_attr.attr,
 	&sensor_dev_attr_in7_min.dev_attr.attr,
 	&sensor_dev_attr_in7_max.dev_attr.attr,
 	&sensor_dev_attr_in7_alarm.dev_attr.attr,
-	NULL
-}, {
+	&sensor_dev_attr_in7_beep.dev_attr.attr,
+
 	&sensor_dev_attr_in8_input.dev_attr.attr,
 	NULL
-} };
+};
 
-static const struct attribute_group it87_group_in[9] = {
-	{ .attrs = it87_attributes_in[0] },
-	{ .attrs = it87_attributes_in[1] },
-	{ .attrs = it87_attributes_in[2] },
-	{ .attrs = it87_attributes_in[3] },
-	{ .attrs = it87_attributes_in[4] },
-	{ .attrs = it87_attributes_in[5] },
-	{ .attrs = it87_attributes_in[6] },
-	{ .attrs = it87_attributes_in[7] },
-	{ .attrs = it87_attributes_in[8] },
+static const struct attribute_group it87_group_in = {
+	.attrs = it87_attributes_in,
+	.is_visible = it87_in_is_visible,
 };
 
 static struct attribute *it87_attributes_temp[3][6] = {
@@ -1537,18 +1549,6 @@ static const struct attribute_group it87_group = {
 	.attrs = it87_attributes,
 };
 
-static struct attribute *it87_attributes_in_beep[] = {
-	&sensor_dev_attr_in0_beep.dev_attr.attr,
-	&sensor_dev_attr_in1_beep.dev_attr.attr,
-	&sensor_dev_attr_in2_beep.dev_attr.attr,
-	&sensor_dev_attr_in3_beep.dev_attr.attr,
-	&sensor_dev_attr_in4_beep.dev_attr.attr,
-	&sensor_dev_attr_in5_beep.dev_attr.attr,
-	&sensor_dev_attr_in6_beep.dev_attr.attr,
-	&sensor_dev_attr_in7_beep.dev_attr.attr,
-	NULL
-};
-
 static struct attribute *it87_attributes_temp_beep[] = {
 	&sensor_dev_attr_temp1_beep.dev_attr.attr,
 	&sensor_dev_attr_temp2_beep.dev_attr.attr,
@@ -1966,14 +1966,8 @@ static void it87_remove_files(struct device *dev)
 	int i;
 
 	sysfs_remove_group(&dev->kobj, &it87_group);
-	for (i = 0; i < 9; i++) {
-		if (sio_data->skip_in & (1 << i))
-			continue;
-		sysfs_remove_group(&dev->kobj, &it87_group_in[i]);
-		if (it87_attributes_in_beep[i])
-			sysfs_remove_file(&dev->kobj,
-					  it87_attributes_in_beep[i]);
-	}
+	sysfs_remove_group(&dev->kobj, &it87_group_in);
+
 	for (i = 0; i < 3; i++) {
 		if (!(data->has_temp & (1 << i)))
 			continue;
@@ -2102,19 +2096,9 @@ static int it87_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	for (i = 0; i < 9; i++) {
-		if (sio_data->skip_in & (1 << i))
-			continue;
-		err = sysfs_create_group(&dev->kobj, &it87_group_in[i]);
-		if (err)
-			goto error;
-		if (sio_data->beep_pin && it87_attributes_in_beep[i]) {
-			err = sysfs_create_file(&dev->kobj,
-						it87_attributes_in_beep[i]);
-			if (err)
-				goto error;
-		}
-	}
+	err = sysfs_create_group(&dev->kobj, &it87_group_in);
+	if (err)
+		goto error;
 
 	for (i = 0; i < 3; i++) {
 		if (!(data->has_temp & (1 << i)))
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
