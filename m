From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 08 Dec 2011 18:31:07 +0000
Subject: [lm-sensors] [PATCH 2/4] hwmon: (f75375s) Use standard sysfs
Message-Id: <1323369069-26203-3-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The driver uses non-standard sysfs attribute names for maximum and target fan
speeds, even though standard attibute names for the same values do exist.
Replace non-standard attribute names with standard attribute names.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/f75375s.c |   38 +++++++++++++++++++-------------------
 1 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/hwmon/f75375s.c b/drivers/hwmon/f75375s.c
index 92b939b..316c29a 100644
--- a/drivers/hwmon/f75375s.c
+++ b/drivers/hwmon/f75375s.c
@@ -102,8 +102,8 @@ struct f75375_data {
 	u8 in_min[4];
 	u16 fan[2];
 	u16 fan_min[2];
-	u16 fan_full[2];
-	u16 fan_exp[2];
+	u16 fan_max[2];
+	u16 fan_target[2];
 	u8 fan_timer;
 	u8 pwm[2];
 	u8 pwm_mode[2];
@@ -181,11 +181,11 @@ static struct f75375_data *f75375_update_device(struct device *dev)
 				f75375_read8(client, F75375_REG_TEMP_HIGH(nr));
 			data->temp_max_hyst[nr]  				f75375_read8(client, F75375_REG_TEMP_HYST(nr));
-			data->fan_full[nr] +			data->fan_max[nr]  				f75375_read16(client, F75375_REG_FAN_FULL(nr));
 			data->fan_min[nr]  				f75375_read16(client, F75375_REG_FAN_MIN(nr));
-			data->fan_exp[nr] +			data->fan_target[nr]  				f75375_read16(client, F75375_REG_FAN_EXP(nr));
 			data->pwm[nr] =	f75375_read8(client,
 				F75375_REG_FAN_PWM_DUTY(nr));
@@ -256,7 +256,7 @@ static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-static ssize_t set_fan_exp(struct device *dev, struct device_attribute *attr,
+static ssize_t set_fan_target(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
@@ -270,8 +270,8 @@ static ssize_t set_fan_exp(struct device *dev, struct device_attribute *attr,
 		return err;
 
 	mutex_lock(&data->update_lock);
-	data->fan_exp[nr] = rpm_to_reg(val);
-	f75375_write16(client, F75375_REG_FAN_EXP(nr), data->fan_exp[nr]);
+	data->fan_target[nr] = rpm_to_reg(val);
+	f75375_write16(client, F75375_REG_FAN_EXP(nr), data->fan_target[nr]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -550,8 +550,8 @@ static ssize_t show_##thing(struct device *dev, struct device_attribute *attr, \
 
 show_fan(fan);
 show_fan(fan_min);
-show_fan(fan_full);
-show_fan(fan_exp);
+show_fan(fan_max);
+show_fan(fan_target);
 
 static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, show_in, NULL, 0);
 static SENSOR_DEVICE_ATTR(in0_max, S_IRUGO|S_IWUSR,
@@ -584,17 +584,17 @@ static SENSOR_DEVICE_ATTR(temp2_max_hyst, S_IRUGO|S_IWUSR,
 static SENSOR_DEVICE_ATTR(temp2_max, S_IRUGO|S_IWUSR,
 	show_temp_max, set_temp_max, 1);
 static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, show_fan, NULL, 0);
-static SENSOR_DEVICE_ATTR(fan1_full, S_IRUGO, show_fan_full, NULL, 0);
+static SENSOR_DEVICE_ATTR(fan1_max, S_IRUGO, show_fan_max, NULL, 0);
 static SENSOR_DEVICE_ATTR(fan1_min, S_IRUGO|S_IWUSR,
 	show_fan_min, set_fan_min, 0);
-static SENSOR_DEVICE_ATTR(fan1_exp, S_IRUGO|S_IWUSR,
-	show_fan_exp, set_fan_exp, 0);
+static SENSOR_DEVICE_ATTR(fan1_target, S_IRUGO|S_IWUSR,
+	show_fan_target, set_fan_target, 0);
 static SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, show_fan, NULL, 1);
-static SENSOR_DEVICE_ATTR(fan2_full, S_IRUGO, show_fan_full, NULL, 1);
+static SENSOR_DEVICE_ATTR(fan2_max, S_IRUGO, show_fan_max, NULL, 1);
 static SENSOR_DEVICE_ATTR(fan2_min, S_IRUGO|S_IWUSR,
 	show_fan_min, set_fan_min, 1);
-static SENSOR_DEVICE_ATTR(fan2_exp, S_IRUGO|S_IWUSR,
-	show_fan_exp, set_fan_exp, 1);
+static SENSOR_DEVICE_ATTR(fan2_target, S_IRUGO|S_IWUSR,
+	show_fan_target, set_fan_target, 1);
 static SENSOR_DEVICE_ATTR(pwm1, S_IRUGO|S_IWUSR,
 	show_pwm, set_pwm, 0);
 static SENSOR_DEVICE_ATTR(pwm1_enable, S_IRUGO|S_IWUSR,
@@ -616,13 +616,13 @@ static struct attribute *f75375_attributes[] = {
 	&sensor_dev_attr_temp2_max.dev_attr.attr,
 	&sensor_dev_attr_temp2_max_hyst.dev_attr.attr,
 	&sensor_dev_attr_fan1_input.dev_attr.attr,
-	&sensor_dev_attr_fan1_full.dev_attr.attr,
+	&sensor_dev_attr_fan1_max.dev_attr.attr,
 	&sensor_dev_attr_fan1_min.dev_attr.attr,
-	&sensor_dev_attr_fan1_exp.dev_attr.attr,
+	&sensor_dev_attr_fan1_target.dev_attr.attr,
 	&sensor_dev_attr_fan2_input.dev_attr.attr,
-	&sensor_dev_attr_fan2_full.dev_attr.attr,
+	&sensor_dev_attr_fan2_max.dev_attr.attr,
 	&sensor_dev_attr_fan2_min.dev_attr.attr,
-	&sensor_dev_attr_fan2_exp.dev_attr.attr,
+	&sensor_dev_attr_fan2_target.dev_attr.attr,
 	&sensor_dev_attr_pwm1.dev_attr.attr,
 	&sensor_dev_attr_pwm1_enable.dev_attr.attr,
 	&sensor_dev_attr_pwm1_mode.dev_attr.attr,
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
