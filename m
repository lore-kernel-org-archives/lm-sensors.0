From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 17 Jul 2014 11:17:31 +0000
Subject: [lm-sensors] [RFT][PATCH 2/2] hwmon: (smsc47m1) Convert to devm_hwmon_device_register_with_groups
Message-Id: <1405595851.13586.8.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use devm_hwmon_device_register_with_groups() to simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/smsc47m1.c | 112 ++++++++++++-----------------------------------
 1 file changed, 27 insertions(+), 85 deletions(-)

diff --git a/drivers/hwmon/smsc47m1.c b/drivers/hwmon/smsc47m1.c
index d748565..f8922fb 100644
--- a/drivers/hwmon/smsc47m1.c
+++ b/drivers/hwmon/smsc47m1.c
@@ -125,7 +125,7 @@ struct smsc47m1_data {
 	unsigned short addr;
 	const char *name;
 	enum chips type;
-	struct device *hwmon_dev;
+	const struct attribute_group *groups[8];
 
 	struct mutex update_lock;
 	unsigned long last_updated;	/* In jiffies */
@@ -442,15 +442,6 @@ fan_present(3);
 
 static DEVICE_ATTR(alarms, S_IRUGO, get_alarms, NULL);
 
-static ssize_t show_name(struct device *dev, struct device_attribute
-			 *devattr, char *buf)
-{
-	struct smsc47m1_data *data = dev_get_drvdata(dev);
-
-	return sprintf(buf, "%s\n", data->name);
-}
-static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
-
 static struct attribute *smsc47m1_attributes_fan1[] = {
 	&sensor_dev_attr_fan1_input.dev_attr.attr,
 	&sensor_dev_attr_fan1_min.dev_attr.attr,
@@ -519,7 +510,6 @@ static const struct attribute_group smsc47m1_group_pwm3 = {
 
 static struct attribute *smsc47m1_attributes[] = {
 	&dev_attr_alarms.attr,
-	&dev_attr_name.attr,
 	NULL
 };
 
@@ -690,25 +680,16 @@ static int __init smsc47m1_handle_resources(unsigned short address,
 	return 0;
 }
 
-static void smsc47m1_remove_files(struct device *dev)
-{
-	sysfs_remove_group(&dev->kobj, &smsc47m1_group);
-	sysfs_remove_group(&dev->kobj, &smsc47m1_group_fan1);
-	sysfs_remove_group(&dev->kobj, &smsc47m1_group_fan2);
-	sysfs_remove_group(&dev->kobj, &smsc47m1_group_fan3);
-	sysfs_remove_group(&dev->kobj, &smsc47m1_group_pwm1);
-	sysfs_remove_group(&dev->kobj, &smsc47m1_group_pwm2);
-	sysfs_remove_group(&dev->kobj, &smsc47m1_group_pwm3);
-}
-
 static int __init smsc47m1_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct device *hwmon_dev;
 	struct smsc47m1_sio_data *sio_data = dev_get_platdata(dev);
 	struct smsc47m1_data *data;
 	struct resource *res;
 	int err;
 	int fan1, fan2, fan3, pwm1, pwm2, pwm3;
+	int idx = 0;
 
 	static const char * const names[] = {
 		"smsc47m1",
@@ -771,80 +752,42 @@ static int __init smsc47m1_probe(struct platform_device *pdev)
 	 */
 	smsc47m1_update_device(dev, 1);
 
-	/* Register sysfs hooks */
-	if (fan1) {
-		err = sysfs_create_group(&dev->kobj,
-					 &smsc47m1_group_fan1);
-		if (err)
-			goto error_remove_files;
-	} else
+	/* sysfs hooks */
+	data->groups[idx++] = &smsc47m1_group;
+
+	if (fan1)
+		data->groups[idx++] = &smsc47m1_group_fan1;
+	else
 		dev_dbg(dev, "Fan 1 not enabled by hardware, skipping\n");
 
-	if (fan2) {
-		err = sysfs_create_group(&dev->kobj,
-					 &smsc47m1_group_fan2);
-		if (err)
-			goto error_remove_files;
-	} else
+	if (fan2)
+		data->groups[idx++] = &smsc47m1_group_fan2;
+	else
 		dev_dbg(dev, "Fan 2 not enabled by hardware, skipping\n");
 
-	if (fan3) {
-		err = sysfs_create_group(&dev->kobj,
-					 &smsc47m1_group_fan3);
-		if (err)
-			goto error_remove_files;
-	} else if (data->type = smsc47m2)
+	if (fan3)
+		data->groups[idx++] = &smsc47m1_group_fan3;
+	else
 		dev_dbg(dev, "Fan 3 not enabled by hardware, skipping\n");
 
-	if (pwm1) {
-		err = sysfs_create_group(&dev->kobj,
-					 &smsc47m1_group_pwm1);
-		if (err)
-			goto error_remove_files;
-	} else
+	if (pwm1)
+		data->groups[idx++] = &smsc47m1_group_pwm1;
+	else
 		dev_dbg(dev, "PWM 1 not enabled by hardware, skipping\n");
 
-	if (pwm2) {
-		err = sysfs_create_group(&dev->kobj,
-					 &smsc47m1_group_pwm2);
-		if (err)
-			goto error_remove_files;
-	} else
+	if (pwm2)
+		data->groups[idx++] = &smsc47m1_group_pwm2;
+	else
 		dev_dbg(dev, "PWM 2 not enabled by hardware, skipping\n");
 
-	if (pwm3) {
-		err = sysfs_create_group(&dev->kobj,
-					 &smsc47m1_group_pwm3);
-		if (err)
-			goto error_remove_files;
-	} else if (data->type = smsc47m2)
+	if (pwm3)
+		data->groups[idx++] = &smsc47m1_group_pwm3;
+	else
 		dev_dbg(dev, "PWM 3 not enabled by hardware, skipping\n");
 
-	err = sysfs_create_group(&dev->kobj, &smsc47m1_group);
-	if (err)
-		goto error_remove_files;
-
-	data->hwmon_dev = hwmon_device_register(dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		err = PTR_ERR(data->hwmon_dev);
-		goto error_remove_files;
-	}
-
-	return 0;
-
-error_remove_files:
-	smsc47m1_remove_files(dev);
-	return err;
-}
-
-static int __exit smsc47m1_remove(struct platform_device *pdev)
-{
-	struct smsc47m1_data *data = platform_get_drvdata(pdev);
-
-	hwmon_device_unregister(data->hwmon_dev);
-	smsc47m1_remove_files(&pdev->dev);
-
-	return 0;
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, data->name,
+							   data, data->groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 static struct platform_driver smsc47m1_driver = {
@@ -852,7 +795,6 @@ static struct platform_driver smsc47m1_driver = {
 		.owner	= THIS_MODULE,
 		.name	= DRVNAME,
 	},
-	.remove		= __exit_p(smsc47m1_remove),
 };
 
 static int __init smsc47m1_device_add(unsigned short address,
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
