From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 23 Nov 2013 05:52:00 +0000
Subject: [lm-sensors] [PATCH 1/2] drm/radeon/dpm: Convert to use devm_hwmon_register_with_groups
Message-Id: <1385185921-17220-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Airlie <airlied@linux.ie>
Cc: lm-sensors@lm-sensors.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

Simplify the code and fix race condition seen because
attribute files were created after hwmon device registration.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Compile tested only; unfortunately I don't have the the necessary hardware.

 drivers/gpu/drm/radeon/radeon_pm.c |   49 +++++++++---------------------------
 1 file changed, 12 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_pm.c b/drivers/gpu/drm/radeon/radeon_pm.c
index d1385cc..dc75bb6 100644
--- a/drivers/gpu/drm/radeon/radeon_pm.c
+++ b/drivers/gpu/drm/radeon/radeon_pm.c
@@ -537,8 +537,7 @@ static ssize_t radeon_hwmon_show_temp(struct device *dev,
 				      struct device_attribute *attr,
 				      char *buf)
 {
-	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct radeon_device *rdev = ddev->dev_private;
+	struct radeon_device *rdev = dev_get_drvdata(dev);
 	int temp;
 
 	if (rdev->asic->pm.get_temperature)
@@ -566,23 +565,14 @@ static ssize_t radeon_hwmon_show_temp_thresh(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%d\n", temp);
 }
 
-static ssize_t radeon_hwmon_show_name(struct device *dev,
-				      struct device_attribute *attr,
-				      char *buf)
-{
-	return sprintf(buf, "radeon\n");
-}
-
 static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, radeon_hwmon_show_temp, NULL, 0);
 static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO, radeon_hwmon_show_temp_thresh, NULL, 0);
 static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IRUGO, radeon_hwmon_show_temp_thresh, NULL, 1);
-static SENSOR_DEVICE_ATTR(name, S_IRUGO, radeon_hwmon_show_name, NULL, 0);
 
 static struct attribute *hwmon_attributes[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	&sensor_dev_attr_temp1_crit.dev_attr.attr,
 	&sensor_dev_attr_temp1_crit_hyst.dev_attr.attr,
-	&sensor_dev_attr_name.dev_attr.attr,
 	NULL
 };
 
@@ -607,11 +597,15 @@ static const struct attribute_group hwmon_attrgroup = {
 	.is_visible = hwmon_attributes_visible,
 };
 
+static const struct attribute_group *hwmon_groups[] = {
+	&hwmon_attrgroup,
+	NULL
+};
+
 static int radeon_hwmon_init(struct radeon_device *rdev)
 {
 	int err = 0;
-
-	rdev->pm.int_hwmon_dev = NULL;
+	struct device *hwmon_dev;
 
 	switch (rdev->pm.int_thermal_type) {
 	case THERMAL_TYPE_RV6XX:
@@ -624,20 +618,13 @@ static int radeon_hwmon_init(struct radeon_device *rdev)
 	case THERMAL_TYPE_KV:
 		if (rdev->asic->pm.get_temperature = NULL)
 			return err;
-		rdev->pm.int_hwmon_dev = hwmon_device_register(rdev->dev);
-		if (IS_ERR(rdev->pm.int_hwmon_dev)) {
-			err = PTR_ERR(rdev->pm.int_hwmon_dev);
+		hwmon_dev = hwmon_device_register_with_groups(rdev->dev,
+							      "radeon", rdev,
+							      hwmon_groups);
+		if (IS_ERR(hwmon_dev)) {
+			err = PTR_ERR(hwmon_dev);
 			dev_err(rdev->dev,
 				"Unable to register hwmon device: %d\n", err);
-			break;
-		}
-		dev_set_drvdata(rdev->pm.int_hwmon_dev, rdev->ddev);
-		err = sysfs_create_group(&rdev->pm.int_hwmon_dev->kobj,
-					 &hwmon_attrgroup);
-		if (err) {
-			dev_err(rdev->dev,
-				"Unable to create hwmon sysfs file: %d\n", err);
-			hwmon_device_unregister(rdev->dev);
 		}
 		break;
 	default:
@@ -647,14 +634,6 @@ static int radeon_hwmon_init(struct radeon_device *rdev)
 	return err;
 }
 
-static void radeon_hwmon_fini(struct radeon_device *rdev)
-{
-	if (rdev->pm.int_hwmon_dev) {
-		sysfs_remove_group(&rdev->pm.int_hwmon_dev->kobj, &hwmon_attrgroup);
-		hwmon_device_unregister(rdev->pm.int_hwmon_dev);
-	}
-}
-
 static void radeon_dpm_thermal_work_handler(struct work_struct *work)
 {
 	struct radeon_device *rdev @@ -1337,8 +1316,6 @@ static void radeon_pm_fini_old(struct radeon_device *rdev)
 
 	if (rdev->pm.power_state)
 		kfree(rdev->pm.power_state);
-
-	radeon_hwmon_fini(rdev);
 }
 
 static void radeon_pm_fini_dpm(struct radeon_device *rdev)
@@ -1358,8 +1335,6 @@ static void radeon_pm_fini_dpm(struct radeon_device *rdev)
 
 	if (rdev->pm.power_state)
 		kfree(rdev->pm.power_state);
-
-	radeon_hwmon_fini(rdev);
 }
 
 void radeon_pm_fini(struct radeon_device *rdev)
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
