From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 16 Jan 2012 08:49:32 +0000
Subject: [lm-sensors] [PATCH 30/39] hwmon: (ultra45_env) Fix checkpatch issues
Message-Id: <1326703781-14272-31-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fixed:
WARNING: line over 80 characters
WARNING: simple_strtol is obsolete, use kstrtol instead

Not fixed (false positive):
ERROR: Macros with multiple statements should be enclosed in a do - while loop

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/ultra45_env.c |   28 ++++++++++++++++++++--------
 1 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/ultra45_env.c b/drivers/hwmon/ultra45_env.c
index b9a87e8..836de7e 100644
--- a/drivers/hwmon/ultra45_env.c
+++ b/drivers/hwmon/ultra45_env.c
@@ -90,7 +90,8 @@ static void env_write(struct env *p, u8 ireg, u8 val)
 #define FAN_PERIOD_INVALID	(0xff << 8)
 #define FAN_DATA_VALID(x)	((x) && (x) != FAN_PERIOD_INVALID)
 
-static ssize_t show_fan_speed(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_fan_speed(struct device *dev, struct device_attribute *attr,
+			      char *buf)
 {
 	int fan_nr = to_sensor_dev_attr(attr)->index;
 	struct env *p = dev_get_drvdata(dev);
@@ -111,10 +112,15 @@ static ssize_t set_fan_speed(struct device *dev, struct device_attribute *attr,
 			     const char *buf, size_t count)
 {
 	int fan_nr = to_sensor_dev_attr(attr)->index;
-	int rpm = simple_strtol(buf, NULL, 10);
+	unsigned long rpm;
 	struct env *p = dev_get_drvdata(dev);
 	int period;
 	u8 val;
+	int err;
+
+	err = kstrtoul(buf, 10, &rpm);
+	if (err)
+		return err;
 
 	if (!rpm)
 		return -EINVAL;
@@ -126,7 +132,8 @@ static ssize_t set_fan_speed(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-static ssize_t show_fan_fault(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_fan_fault(struct device *dev, struct device_attribute *attr,
+			      char *buf)
 {
 	int fan_nr = to_sensor_dev_attr(attr)->index;
 	struct env *p = dev_get_drvdata(dev);
@@ -148,7 +155,8 @@ fan(4);
 
 static SENSOR_DEVICE_ATTR(psu_fan_fault, S_IRUGO, show_fan_fault, NULL, 6);
 
-static ssize_t show_temp(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_temp(struct device *dev, struct device_attribute *attr,
+			 char *buf)
 {
 	int temp_nr = to_sensor_dev_attr(attr)->index;
 	struct env *p = dev_get_drvdata(dev);
@@ -168,7 +176,8 @@ static SENSOR_DEVICE_ATTR(lsi1064_local_temp, S_IRUGO, show_temp, NULL, 6);
 static SENSOR_DEVICE_ATTR(front_panel_temp, S_IRUGO, show_temp, NULL, 7);
 static SENSOR_DEVICE_ATTR(psu_temp, S_IRUGO, show_temp, NULL, 13);
 
-static ssize_t show_stat_bit(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_stat_bit(struct device *dev, struct device_attribute *attr,
+			     char *buf)
 {
 	int index = to_sensor_dev_attr(attr)->index;
 	struct env *p = dev_get_drvdata(dev);
@@ -181,9 +190,11 @@ static ssize_t show_stat_bit(struct device *dev, struct device_attribute *attr,
 static SENSOR_DEVICE_ATTR(fan_failure, S_IRUGO, show_stat_bit, NULL, 0);
 static SENSOR_DEVICE_ATTR(env_bus_busy, S_IRUGO, show_stat_bit, NULL, 1);
 static SENSOR_DEVICE_ATTR(env_data_stale, S_IRUGO, show_stat_bit, NULL, 2);
-static SENSOR_DEVICE_ATTR(tpm_self_test_passed, S_IRUGO, show_stat_bit, NULL, 3);
+static SENSOR_DEVICE_ATTR(tpm_self_test_passed, S_IRUGO, show_stat_bit, NULL,
+			  3);
 
-static ssize_t show_fwver(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_fwver(struct device *dev, struct device_attribute *attr,
+			  char *buf)
 {
 	struct env *p = dev_get_drvdata(dev);
 	u8 val;
@@ -194,7 +205,8 @@ static ssize_t show_fwver(struct device *dev, struct device_attribute *attr, cha
 
 static SENSOR_DEVICE_ATTR(firmware_version, S_IRUGO, show_fwver, NULL, 0);
 
-static ssize_t show_name(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_name(struct device *dev, struct device_attribute *attr,
+			 char *buf)
 {
 	return sprintf(buf, "ultra45\n");
 }
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
