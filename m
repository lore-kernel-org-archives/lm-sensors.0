From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 05 Sep 2012 02:03:28 +0000
Subject: [lm-sensors] [PATCH 2/4] hwmon: (w83793) Remove legacy chassis intrusion detection attributes
Message-Id: <1346810610-26352-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/w83792d.c |   58 ++---------------------------------------------
 1 file changed, 2 insertions(+), 56 deletions(-)

diff --git a/drivers/hwmon/w83792d.c b/drivers/hwmon/w83792d.c
index 0ba5a2b..06d6f56 100644
--- a/drivers/hwmon/w83792d.c
+++ b/drivers/hwmon/w83792d.c
@@ -296,7 +296,6 @@ struct w83792d_data {
 	u8 pwmenable[3];
 	u32 alarms;		/* realtime status register encoding,combined */
 	u8 chassis;		/* Chassis status */
-	u8 chassis_clear;	/* CLR_CHS, clear chassis intrusion detection */
 	u8 thermal_cruise[3];	/* Smart FanI: Fan1,2,3 target value */
 	u8 tolerance[3];	/* Fan1,2,3 tolerance(Smart Fan I/II) */
 	u8 sf2_points[3][4];	/* Smart FanII: Fan1,2,3 temperature points */
@@ -739,7 +738,7 @@ store_pwm_mode(struct device *dev, struct device_attribute *attr,
 }
 
 static ssize_t
-show_chassis(struct device *dev, struct device_attribute *attr,
+show_chassis_clear(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
 	struct w83792d_data *data = w83792d_update_device(dev);
@@ -747,52 +746,6 @@ show_chassis(struct device *dev, struct device_attribute *attr,
 }
 
 static ssize_t
-show_regs_chassis(struct device *dev, struct device_attribute *attr,
-			char *buf)
-{
-	dev_warn(dev,
-		 "Attribute %s is deprecated, use intrusion0_alarm instead\n",
-		 "chassis");
-	return show_chassis(dev, attr, buf);
-}
-
-static ssize_t
-show_chassis_clear(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct w83792d_data *data = w83792d_update_device(dev);
-	return sprintf(buf, "%d\n", data->chassis_clear);
-}
-
-static ssize_t
-store_chassis_clear_legacy(struct device *dev, struct device_attribute *attr,
-			const char *buf, size_t count)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83792d_data *data = i2c_get_clientdata(client);
-	unsigned long val;
-	int err;
-	u8 temp1 = 0, temp2 = 0;
-
-	dev_warn(dev,
-		 "Attribute %s is deprecated, use intrusion0_alarm instead\n",
-		 "chassis_clear");
-
-	err = kstrtoul(buf, 10, &val);
-	if (err)
-		return err;
-
-	mutex_lock(&data->update_lock);
-	data->chassis_clear = SENSORS_LIMIT(val, 0, 1);
-	temp1 = ((data->chassis_clear) << 7) & 0x80;
-	temp2 = w83792d_read_value(client,
-		W83792D_REG_CHASSIS_CLR) & 0x7f;
-	w83792d_write_value(client, W83792D_REG_CHASSIS_CLR, temp1 | temp2);
-	mutex_unlock(&data->update_lock);
-
-	return count;
-}
-
-static ssize_t
 store_chassis_clear(struct device *dev, struct device_attribute *attr,
 			const char *buf, size_t count)
 {
@@ -1116,11 +1069,8 @@ static SENSOR_DEVICE_ATTR(in8_alarm, S_IRUGO, show_alarm, NULL, 20);
 static SENSOR_DEVICE_ATTR(fan4_alarm, S_IRUGO, show_alarm, NULL, 21);
 static SENSOR_DEVICE_ATTR(fan5_alarm, S_IRUGO, show_alarm, NULL, 22);
 static SENSOR_DEVICE_ATTR(fan6_alarm, S_IRUGO, show_alarm, NULL, 23);
-static DEVICE_ATTR(chassis, S_IRUGO, show_regs_chassis, NULL);
-static DEVICE_ATTR(chassis_clear, S_IRUGO | S_IWUSR,
-			show_chassis_clear, store_chassis_clear_legacy);
 static DEVICE_ATTR(intrusion0_alarm, S_IRUGO | S_IWUSR,
-			show_chassis, store_chassis_clear);
+			show_chassis_clear, store_chassis_clear);
 static SENSOR_DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 0);
 static SENSOR_DEVICE_ATTR(pwm2, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 1);
 static SENSOR_DEVICE_ATTR(pwm3, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 2);
@@ -1320,8 +1270,6 @@ static struct attribute *w83792d_attributes[] = {
 	&sensor_dev_attr_pwm3_mode.dev_attr.attr,
 	&sensor_dev_attr_pwm3_enable.dev_attr.attr,
 	&dev_attr_alarms.attr,
-	&dev_attr_chassis.attr,
-	&dev_attr_chassis_clear.attr,
 	&dev_attr_intrusion0_alarm.attr,
 	&sensor_dev_attr_tolerance1.dev_attr.attr,
 	&sensor_dev_attr_thermal_cruise1.dev_attr.attr,
@@ -1627,8 +1575,6 @@ static struct w83792d_data *w83792d_update_device(struct device *dev)
 		/* Update CaseOpen status and it's CLR_CHS. */
 		data->chassis = (w83792d_read_value(client,
 			W83792D_REG_CHASSIS) >> 5) & 0x01;
-		data->chassis_clear = (w83792d_read_value(client,
-			W83792D_REG_CHASSIS_CLR) >> 7) & 0x01;
 
 		/* Update Thermal Cruise/Smart Fan I target value */
 		for (i = 0; i < 3; i++) {
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
