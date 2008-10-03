From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 03 Oct 2008 15:32:16 +0000
Subject: [lm-sensors] [PATCH] eeepc-laptop: Fix hwmon interface
Message-Id: <20081003173216.66ce9e5d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Corentin Chary <corentincj@iksaif.net>

Creates a name file in the sysfs directory, that
is needed for the libsensors library to work.
Also rename fan1_pwm to pwm1 and scale its value as needed.

This fixes bug #11520:
http://bugzilla.kernel.org/show_bug.cgi?id520

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
Updated patch from Corentin.

 drivers/misc/eeepc-laptop.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/eeepc-laptop.c b/drivers/misc/eeepc-laptop.c
index facdb98..1ee8501 100644
--- a/drivers/misc/eeepc-laptop.c
+++ b/drivers/misc/eeepc-laptop.c
@@ -450,12 +450,14 @@ static int eeepc_get_fan_pwm(void)
 	int value = 0;
 
 	read_acpi_int(NULL, EEEPC_EC_FAN_PWM, &value);
+	value = value * 255 / 100;
 	return (value);
 }
 
 static void eeepc_set_fan_pwm(int value)
 {
-	value = SENSORS_LIMIT(value, 0, 100);
+	value = SENSORS_LIMIT(value, 0, 255);
+	value = value * 100 / 255;
 	ec_write(EEEPC_EC_SC02, value);
 }
 
@@ -520,15 +522,23 @@ static ssize_t show_sys_hwmon(int (*get)(void), char *buf)
 	static SENSOR_DEVICE_ATTR(_name, _mode, show_##_name, store_##_name, 0);
 
 EEEPC_CREATE_SENSOR_ATTR(fan1_input, S_IRUGO, eeepc_get_fan_rpm, NULL);
-EEEPC_CREATE_SENSOR_ATTR(fan1_pwm, S_IRUGO | S_IWUSR,
+EEEPC_CREATE_SENSOR_ATTR(pwm1, S_IRUGO | S_IWUSR,
 			 eeepc_get_fan_pwm, eeepc_set_fan_pwm);
 EEEPC_CREATE_SENSOR_ATTR(pwm1_enable, S_IRUGO | S_IWUSR,
 			 eeepc_get_fan_ctrl, eeepc_set_fan_ctrl);
 
+static ssize_t
+show_name(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "eeepc\n");
+}
+static SENSOR_DEVICE_ATTR(name, S_IRUGO, show_name, NULL, 0);
+
 static struct attribute *hwmon_attributes[] = {
-	&sensor_dev_attr_fan1_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm1.dev_attr.attr,
 	&sensor_dev_attr_fan1_input.dev_attr.attr,
 	&sensor_dev_attr_pwm1_enable.dev_attr.attr,
+	&sensor_dev_attr_name.dev_attr.attr,
 	NULL
 };
 
-- 
1.5.4.3



-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
