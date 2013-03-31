From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 31 Mar 2013 18:09:36 +0000
Subject: [lm-sensors] [PATCH 2/5] hwmon: (it87) Use is_visible for temperature sensors
Message-Id: <1364753379-20222-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Simplify code and reduce object size by more than 200 bytes on x86_64.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/it87.c |   88 +++++++++++++++++++++-----------------------------
 1 file changed, 37 insertions(+), 51 deletions(-)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index bbf2a34..5066439 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -1502,40 +1502,58 @@ static const struct attribute_group it87_group_in = {
 	.is_visible = it87_in_is_visible,
 };
 
-static struct attribute *it87_attributes_temp[3][6] = {
+static umode_t it87_temp_is_visible(struct kobject *kobj,
+				    struct attribute *attr, int index)
 {
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct it87_data *data = dev_get_drvdata(dev);
+	struct it87_sio_data *sio_data = dev->platform_data;
+	int i = index / 7;	/* temperature index */
+	int a = index % 7;	/* attribute index */
+
+	if (!(data->has_temp & (1 << i)))
+		return 0;
+
+	if (a = 5 && !has_temp_offset(data))
+		return 0;
+
+	if (a = 6 && !sio_data->beep_pin)
+		return 0;
+
+	return attr->mode;
+}
+
+static struct attribute *it87_attributes_temp[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	&sensor_dev_attr_temp1_max.dev_attr.attr,
 	&sensor_dev_attr_temp1_min.dev_attr.attr,
 	&sensor_dev_attr_temp1_type.dev_attr.attr,
 	&sensor_dev_attr_temp1_alarm.dev_attr.attr,
-	NULL
-} , {
+	&sensor_dev_attr_temp1_offset.dev_attr.attr,	/* 5 */
+	&sensor_dev_attr_temp1_beep.dev_attr.attr,	/* 6 */
+
 	&sensor_dev_attr_temp2_input.dev_attr.attr,
 	&sensor_dev_attr_temp2_max.dev_attr.attr,
 	&sensor_dev_attr_temp2_min.dev_attr.attr,
 	&sensor_dev_attr_temp2_type.dev_attr.attr,
 	&sensor_dev_attr_temp2_alarm.dev_attr.attr,
-	NULL
-} , {
+	&sensor_dev_attr_temp2_offset.dev_attr.attr,
+	&sensor_dev_attr_temp2_beep.dev_attr.attr,
+
 	&sensor_dev_attr_temp3_input.dev_attr.attr,
 	&sensor_dev_attr_temp3_max.dev_attr.attr,
 	&sensor_dev_attr_temp3_min.dev_attr.attr,
 	&sensor_dev_attr_temp3_type.dev_attr.attr,
 	&sensor_dev_attr_temp3_alarm.dev_attr.attr,
-	NULL
-} };
+	&sensor_dev_attr_temp3_offset.dev_attr.attr,
+	&sensor_dev_attr_temp3_beep.dev_attr.attr,
 
-static const struct attribute_group it87_group_temp[3] = {
-	{ .attrs = it87_attributes_temp[0] },
-	{ .attrs = it87_attributes_temp[1] },
-	{ .attrs = it87_attributes_temp[2] },
+	NULL
 };
 
-static struct attribute *it87_attributes_temp_offset[] = {
-	&sensor_dev_attr_temp1_offset.dev_attr.attr,
-	&sensor_dev_attr_temp2_offset.dev_attr.attr,
-	&sensor_dev_attr_temp3_offset.dev_attr.attr,
+static const struct attribute_group it87_group_temp = {
+	.attrs = it87_attributes_temp,
+	.is_visible = it87_temp_is_visible,
 };
 
 static struct attribute *it87_attributes[] = {
@@ -1549,12 +1567,6 @@ static const struct attribute_group it87_group = {
 	.attrs = it87_attributes,
 };
 
-static struct attribute *it87_attributes_temp_beep[] = {
-	&sensor_dev_attr_temp1_beep.dev_attr.attr,
-	&sensor_dev_attr_temp2_beep.dev_attr.attr,
-	&sensor_dev_attr_temp3_beep.dev_attr.attr,
-};
-
 static struct attribute *it87_attributes_fan[5][3+1] = { {
 	&sensor_dev_attr_fan1_input.dev_attr.attr,
 	&sensor_dev_attr_fan1_min.dev_attr.attr,
@@ -1967,18 +1979,8 @@ static void it87_remove_files(struct device *dev)
 
 	sysfs_remove_group(&dev->kobj, &it87_group);
 	sysfs_remove_group(&dev->kobj, &it87_group_in);
+	sysfs_remove_group(&dev->kobj, &it87_group_temp);
 
-	for (i = 0; i < 3; i++) {
-		if (!(data->has_temp & (1 << i)))
-			continue;
-		sysfs_remove_group(&dev->kobj, &it87_group_temp[i]);
-		if (has_temp_offset(data))
-			sysfs_remove_file(&dev->kobj,
-					  it87_attributes_temp_offset[i]);
-		if (sio_data->beep_pin)
-			sysfs_remove_file(&dev->kobj,
-					  it87_attributes_temp_beep[i]);
-	}
 	for (i = 0; i < 5; i++) {
 		if (!(data->has_fan & (1 << i)))
 			continue;
@@ -2100,25 +2102,9 @@ static int it87_probe(struct platform_device *pdev)
 	if (err)
 		goto error;
 
-	for (i = 0; i < 3; i++) {
-		if (!(data->has_temp & (1 << i)))
-			continue;
-		err = sysfs_create_group(&dev->kobj, &it87_group_temp[i]);
-		if (err)
-			goto error;
-		if (has_temp_offset(data)) {
-			err = sysfs_create_file(&dev->kobj,
-						it87_attributes_temp_offset[i]);
-			if (err)
-				goto error;
-		}
-		if (sio_data->beep_pin) {
-			err = sysfs_create_file(&dev->kobj,
-						it87_attributes_temp_beep[i]);
-			if (err)
-				goto error;
-		}
-	}
+	err = sysfs_create_group(&dev->kobj, &it87_group_temp);
+	if (err)
+		goto error;
 
 	/* Do not create fan files for disabled fans */
 	fan_beep_need_rw = 1;
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
