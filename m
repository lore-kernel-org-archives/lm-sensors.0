From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 23 Nov 2013 19:03:21 +0000
Subject: [lm-sensors] [PATCH 5/5] eeepc-laptop: Convert to use devm_hwmon_device_register_with_groups
Message-Id: <1385233401-21517-6-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1385233401-21517-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1385233401-21517-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Garrett <matthew.garrett@nebula.com>
Cc: Corentin Chary <corentin.chary@gmail.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, acpi4asus-user@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

Simplify the code and avoid race condition caused by creating sysfs attributes
after creating the hwmon device.

Also replace SENSOR_DEVICE_ATTR with DEVICE_ATTR since the extra argument
is not used and SENSOR_DEVICE_ATTR is not needed.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/platform/x86/eeepc-laptop.c |   52 +++++++----------------------------
 1 file changed, 10 insertions(+), 42 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index aefcc32..c15d339 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -166,7 +166,6 @@ struct eeepc_laptop {
 
 	struct platform_device *platform_device;
 	struct acpi_device *device;		/* the device we are in */
-	struct device *hwmon_device;
 	struct backlight_device *backlight_device;
 
 	struct input_dev *inputdev;
@@ -1067,7 +1066,7 @@ static ssize_t show_sys_hwmon(int (*get)(void), char *buf)
 	{								\
 		return store_sys_hwmon(_get, buf, count);		\
 	}								\
-	static SENSOR_DEVICE_ATTR(_name, _mode, show_##_name, store_##_name, 0);
+	static DEVICE_ATTR(_name, _mode, show_##_name, store_##_name);
 
 EEEPC_CREATE_SENSOR_ATTR(fan1_input, S_IRUGO, eeepc_get_fan_rpm, NULL);
 EEEPC_CREATE_SENSOR_ATTR(pwm1, S_IRUGO | S_IWUSR,
@@ -1075,55 +1074,26 @@ EEEPC_CREATE_SENSOR_ATTR(pwm1, S_IRUGO | S_IWUSR,
 EEEPC_CREATE_SENSOR_ATTR(pwm1_enable, S_IRUGO | S_IWUSR,
 			 eeepc_get_fan_ctrl, eeepc_set_fan_ctrl);
 
-static ssize_t
-show_name(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	return sprintf(buf, "eeepc\n");
-}
-static SENSOR_DEVICE_ATTR(name, S_IRUGO, show_name, NULL, 0);
-
-static struct attribute *hwmon_attributes[] = {
-	&sensor_dev_attr_pwm1.dev_attr.attr,
-	&sensor_dev_attr_fan1_input.dev_attr.attr,
-	&sensor_dev_attr_pwm1_enable.dev_attr.attr,
-	&sensor_dev_attr_name.dev_attr.attr,
+static struct attribute *hwmon_attrs[] = {
+	&dev_attr_pwm1.attr,
+	&dev_attr_fan1_input.attr,
+	&dev_attr_pwm1_enable.attr,
 	NULL
 };
-
-static struct attribute_group hwmon_attribute_group = {
-	.attrs = hwmon_attributes
-};
-
-static void eeepc_hwmon_exit(struct eeepc_laptop *eeepc)
-{
-	struct device *hwmon;
-
-	hwmon = eeepc->hwmon_device;
-	if (!hwmon)
-		return;
-	sysfs_remove_group(&hwmon->kobj,
-			   &hwmon_attribute_group);
-	hwmon_device_unregister(hwmon);
-	eeepc->hwmon_device = NULL;
-}
+ATTRIBUTE_GROUPS(hwmon);
 
 static int eeepc_hwmon_init(struct eeepc_laptop *eeepc)
 {
+	struct device *dev = &eeepc->platform_device->dev;
 	struct device *hwmon;
-	int result;
 
-	hwmon = hwmon_device_register(&eeepc->platform_device->dev);
+	hwmon = devm_hwmon_device_register_with_groups(dev, "eeepc", NULL,
+						       hwmon_groups);
 	if (IS_ERR(hwmon)) {
 		pr_err("Could not register eeepc hwmon device\n");
-		eeepc->hwmon_device = NULL;
 		return PTR_ERR(hwmon);
 	}
-	eeepc->hwmon_device = hwmon;
-	result = sysfs_create_group(&hwmon->kobj,
-				    &hwmon_attribute_group);
-	if (result)
-		eeepc_hwmon_exit(eeepc);
-	return result;
+	return 0;
 }
 
 /*
@@ -1481,7 +1451,6 @@ static int eeepc_acpi_add(struct acpi_device *device)
 fail_rfkill:
 	eeepc_led_exit(eeepc);
 fail_led:
-	eeepc_hwmon_exit(eeepc);
 fail_hwmon:
 	eeepc_input_exit(eeepc);
 fail_input:
@@ -1501,7 +1470,6 @@ static int eeepc_acpi_remove(struct acpi_device *device)
 	eeepc_backlight_exit(eeepc);
 	eeepc_rfkill_exit(eeepc);
 	eeepc_input_exit(eeepc);
-	eeepc_hwmon_exit(eeepc);
 	eeepc_led_exit(eeepc);
 	eeepc_platform_exit(eeepc);
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
