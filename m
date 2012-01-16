From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 16 Jan 2012 08:49:15 +0000
Subject: [lm-sensors] [PATCH 13/39] hwmon: (fschmd) Fix checkpatch issues
Message-Id: <1326703781-14272-14-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fixed:
ERROR: that open brace { should be on the previous line
ERROR: trailing statements should be on next line
WARNING: line over 80 characters
WARNING: simple_strtol is obsolete, use kstrtol instead
WARNING: simple_strtoul is obsolete, use kstrtoul instead

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/fschmd.c |   57 +++++++++++++++++++++++++++++++++++------------
 1 files changed, 42 insertions(+), 15 deletions(-)

diff --git a/drivers/hwmon/fschmd.c b/drivers/hwmon/fschmd.c
index aa6d8b6..06cbf77 100644
--- a/drivers/hwmon/fschmd.c
+++ b/drivers/hwmon/fschmd.c
@@ -76,12 +76,12 @@ enum chips { fscpos, fscher, fscscy, fschrc, fschmd, fschds, fscsyl };
 #define FSCHMD_CONTROL_ALERT_LED	0x01
 
 /* watchdog */
-static const u8 FSCHMD_REG_WDOG_CONTROL[7] -	{ 0x21, 0x21, 0x21, 0x21, 0x21, 0x28, 0x28 };
-static const u8 FSCHMD_REG_WDOG_STATE[7] -	{ 0x23, 0x23, 0x23, 0x23, 0x23, 0x29, 0x29 };
-static const u8 FSCHMD_REG_WDOG_PRESET[7] -	{ 0x28, 0x28, 0x28, 0x28, 0x28, 0x2a, 0x2a };
+static const u8 FSCHMD_REG_WDOG_CONTROL[7] = {
+	0x21, 0x21, 0x21, 0x21, 0x21, 0x28, 0x28 };
+static const u8 FSCHMD_REG_WDOG_STATE[7] = {
+	0x23, 0x23, 0x23, 0x23, 0x23, 0x29, 0x29 };
+static const u8 FSCHMD_REG_WDOG_PRESET[7] = {
+	0x28, 0x28, 0x28, 0x28, 0x28, 0x2a, 0x2a };
 
 #define FSCHMD_WDOG_CONTROL_TRIGGER	0x10
 #define FSCHMD_WDOG_CONTROL_STARTED	0x10 /* the same as trigger */
@@ -359,9 +359,14 @@ static ssize_t store_temp_max(struct device *dev, struct device_attribute
 {
 	int index = to_sensor_dev_attr(devattr)->index;
 	struct fschmd_data *data = dev_get_drvdata(dev);
-	long v = simple_strtol(buf, NULL, 10) / 1000;
+	long v;
+	int err;
 
-	v = SENSORS_LIMIT(v, -128, 127) + 128;
+	err = kstrtol(buf, 10, &v);
+	if (err)
+		return err;
+
+	v = SENSORS_LIMIT(v / 1000, -128, 127) + 128;
 
 	mutex_lock(&data->update_lock);
 	i2c_smbus_write_byte_data(to_i2c_client(dev),
@@ -427,12 +432,23 @@ static ssize_t store_fan_div(struct device *dev, struct device_attribute
 	int index = to_sensor_dev_attr(devattr)->index;
 	struct fschmd_data *data = dev_get_drvdata(dev);
 	/* supported values: 2, 4, 8 */
-	unsigned long v = simple_strtoul(buf, NULL, 10);
+	unsigned long v;
+	int err;
+
+	err = kstrtoul(buf, 10, &v);
+	if (err)
+		return err;
 
 	switch (v) {
-	case 2: v = 1; break;
-	case 4: v = 2; break;
-	case 8: v = 3; break;
+	case 2:
+		v = 1;
+		break;
+	case 4:
+		v = 2;
+		break;
+	case 8:
+		v = 3;
+		break;
 	default:
 		dev_err(dev, "fan_div value %lu not supported. "
 			"Choose one of 2, 4 or 8!\n", v);
@@ -502,7 +518,12 @@ static ssize_t store_pwm_auto_point1_pwm(struct device *dev,
 {
 	int index = to_sensor_dev_attr(devattr)->index;
 	struct fschmd_data *data = dev_get_drvdata(dev);
-	unsigned long v = simple_strtoul(buf, NULL, 10);
+	unsigned long v;
+	int err;
+
+	err = kstrtoul(buf, 10, &v);
+	if (err)
+		return err;
 
 	/* reg: 0 = allow turning off (except on the syl), 1-255 = 50-100% */
 	if (v || data->kind = fscsyl) {
@@ -540,7 +561,12 @@ static ssize_t store_alert_led(struct device *dev,
 {
 	u8 reg;
 	struct fschmd_data *data = dev_get_drvdata(dev);
-	unsigned long v = simple_strtoul(buf, NULL, 10);
+	unsigned long v;
+	int err;
+
+	err = kstrtoul(buf, 10, &v);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 
@@ -847,7 +873,8 @@ static ssize_t watchdog_write(struct file *filp, const char __user *buf,
 	return count;
 }
 
-static long watchdog_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+static long watchdog_ioctl(struct file *filp, unsigned int cmd,
+			   unsigned long arg)
 {
 	struct watchdog_info ident = {
 		.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT |
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
