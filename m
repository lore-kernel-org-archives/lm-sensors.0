From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 31 Mar 2013 18:09:39 +0000
Subject: [lm-sensors] [PATCH 5/5] hwmon: (it87) Use single group for miscellaneous attributes
Message-Id: <1364753379-20222-6-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use is_visible to determine if attributes should be generated or not.
This simplifies the code and reduces object size by about 120 bytes
on x86_64.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/it87.c |   75 +++++++++++++++++++-------------------------------
 1 file changed, 28 insertions(+), 47 deletions(-)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index a6cc41d..44559c5 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -1556,15 +1556,36 @@ static const struct attribute_group it87_group_temp = {
 	.is_visible = it87_temp_is_visible,
 };
 
+static umode_t it87_is_visible(struct kobject *kobj,
+			       struct attribute *attr, int index)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct it87_sio_data *sio_data = dev->platform_data;
+
+	if ((index = 3 || index = 4) && sio_data->skip_vid)
+		return 0;
+
+	if (index > 4 && !(sio_data->internal & (1 << (index - 5))))
+		return 0;
+
+	return attr->mode;
+}
+
 static struct attribute *it87_attributes[] = {
 	&dev_attr_alarms.attr,
 	&sensor_dev_attr_intrusion0_alarm.dev_attr.attr,
 	&dev_attr_name.attr,
+	&dev_attr_vrm.attr,				/* 3 */
+	&dev_attr_cpu0_vid.attr,			/* 4 */
+	&sensor_dev_attr_in3_label.dev_attr.attr,	/* 5 .. 7 */
+	&sensor_dev_attr_in7_label.dev_attr.attr,
+	&sensor_dev_attr_in8_label.dev_attr.attr,
 	NULL
 };
 
 static const struct attribute_group it87_group = {
 	.attrs = it87_attributes,
+	.is_visible = it87_is_visible,
 };
 
 static umode_t it87_fan_is_visible(struct kobject *kobj,
@@ -1699,27 +1720,6 @@ static const struct attribute_group it87_group_pwm = {
 	.is_visible = it87_pwm_is_visible,
 };
 
-static struct attribute *it87_attributes_vid[] = {
-	&dev_attr_vrm.attr,
-	&dev_attr_cpu0_vid.attr,
-	NULL
-};
-
-static const struct attribute_group it87_group_vid = {
-	.attrs = it87_attributes_vid,
-};
-
-static struct attribute *it87_attributes_label[] = {
-	&sensor_dev_attr_in3_label.dev_attr.attr,
-	&sensor_dev_attr_in7_label.dev_attr.attr,
-	&sensor_dev_attr_in8_label.dev_attr.attr,
-	NULL
-};
-
-static const struct attribute_group it87_group_label = {
-	.attrs = it87_attributes_label,
-};
-
 /* SuperIO detection - will change isa_address if a chip is found */
 static int __init it87_find(unsigned short *address,
 	struct it87_sio_data *sio_data)
@@ -1989,17 +1989,11 @@ exit:
 
 static void it87_remove_files(struct device *dev)
 {
-	struct it87_sio_data *sio_data = dev->platform_data;
-
 	sysfs_remove_group(&dev->kobj, &it87_group);
 	sysfs_remove_group(&dev->kobj, &it87_group_in);
 	sysfs_remove_group(&dev->kobj, &it87_group_temp);
 	sysfs_remove_group(&dev->kobj, &it87_group_fan);
 	sysfs_remove_group(&dev->kobj, &it87_group_pwm);
-
-	if (!sio_data->skip_vid)
-		sysfs_remove_group(&dev->kobj, &it87_group_vid);
-	sysfs_remove_group(&dev->kobj, &it87_group_label);
 }
 
 static int it87_probe(struct platform_device *pdev)
@@ -2008,7 +2002,7 @@ static int it87_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct device *dev = &pdev->dev;
 	struct it87_sio_data *sio_data = dev->platform_data;
-	int err = 0, i;
+	int err;
 	int enable_pwm_interface;
 
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
@@ -2089,6 +2083,12 @@ static int it87_probe(struct platform_device *pdev)
 	/* Initialize the IT87 chip */
 	it87_init_device(pdev);
 
+	if (!sio_data->skip_vid) {
+		data->vrm = vid_which_vrm();
+		/* VID reading from Super-I/O config space if available */
+		data->vid = sio_data->vid_value;
+	}
+
 	/* Register sysfs hooks */
 	err = sysfs_create_group(&dev->kobj, &it87_group);
 	if (err)
@@ -2112,25 +2112,6 @@ static int it87_probe(struct platform_device *pdev)
 			goto error;
 	}
 
-	if (!sio_data->skip_vid) {
-		data->vrm = vid_which_vrm();
-		/* VID reading from Super-I/O config space if available */
-		data->vid = sio_data->vid_value;
-		err = sysfs_create_group(&dev->kobj, &it87_group_vid);
-		if (err)
-			goto error;
-	}
-
-	/* Export labels for internal sensors */
-	for (i = 0; i < 3; i++) {
-		if (!(sio_data->internal & (1 << i)))
-			continue;
-		err = sysfs_create_file(&dev->kobj,
-					it87_attributes_label[i]);
-		if (err)
-			goto error;
-	}
-
 	data->hwmon_dev = hwmon_device_register(dev);
 	if (IS_ERR(data->hwmon_dev)) {
 		err = PTR_ERR(data->hwmon_dev);
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
