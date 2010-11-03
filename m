From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 03 Nov 2010 12:50:09 +0000
Subject: [lm-sensors] [PATCH 2/4 v2] hwmon: (w83792d) Implement the standard
Message-Id: <20101103135009.49080490@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

We have a standard intrusion detection interface now, drivers should
implement it. I've left the old interface in place for the time being,
with a deprecation warning, it will be removed later.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
Changes in v2:
* Invalidate the cache instead of claiming the intrusion alarm flag is
  0 when the user attempts to clear the intrusion flag.
* Deprecate the chassis attribute too.

 drivers/hwmon/w83792d.c |   44 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

--- linux-2.6.37-rc1.orig/drivers/hwmon/w83792d.c	2010-11-03 11:45:58.000000000 +0100
+++ linux-2.6.37-rc1/drivers/hwmon/w83792d.c	2010-11-03 12:55:59.000000000 +0100
@@ -691,7 +691,7 @@ store_pwm_mode(struct device *dev, struc
 }
 
 static ssize_t
-show_regs_chassis(struct device *dev, struct device_attribute *attr,
+show_chassis(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
 	struct w83792d_data *data = w83792d_update_device(dev);
@@ -699,6 +699,16 @@ show_regs_chassis(struct device *dev, st
 }
 
 static ssize_t
+show_regs_chassis(struct device *dev, struct device_attribute *attr,
+			char *buf)
+{
+	dev_warn(dev,
+		 "Attribute %s is deprecated, use intrusion0_alarm instead\n",
+		 "chassis");
+	return show_chassis(dev, attr, buf);
+}
+
+static ssize_t
 show_chassis_clear(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w83792d_data *data = w83792d_update_device(dev);
@@ -706,7 +716,7 @@ show_chassis_clear(struct device *dev, s
 }
 
 static ssize_t
-store_chassis_clear(struct device *dev, struct device_attribute *attr,
+store_chassis_clear_legacy(struct device *dev, struct device_attribute *attr,
 			const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -714,6 +724,10 @@ store_chassis_clear(struct device *dev,
 	u32 val;
 	u8 temp1 = 0, temp2 = 0;
 
+	dev_warn(dev,
+		 "Attribute %s is deprecated, use intrusion0_alarm instead\n",
+		 "chassis_clear");
+
 	val = simple_strtoul(buf, NULL, 10);
 	mutex_lock(&data->update_lock);
 	data->chassis_clear = SENSORS_LIMIT(val, 0 ,1);
@@ -726,6 +740,27 @@ store_chassis_clear(struct device *dev,
 	return count;
 }
 
+static ssize_t
+store_chassis_clear(struct device *dev, struct device_attribute *attr,
+			const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct w83792d_data *data = i2c_get_clientdata(client);
+	unsigned long val;
+	u8 reg;
+
+	if (strict_strtoul(buf, 10, &val) || val != 0)
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+	reg = w83792d_read_value(client, W83792D_REG_CHASSIS_CLR);
+	w83792d_write_value(client, W83792D_REG_CHASSIS_CLR, reg | 0x80);
+	data->valid = 0;		/* Force cache refresh */
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
 /* For Smart Fan I / Thermal Cruise */
 static ssize_t
 show_thermal_cruise(struct device *dev, struct device_attribute *attr,
@@ -1012,7 +1047,9 @@ static SENSOR_DEVICE_ATTR(fan5_alarm, S_
 static SENSOR_DEVICE_ATTR(fan6_alarm, S_IRUGO, show_alarm, NULL, 23);
 static DEVICE_ATTR(chassis, S_IRUGO, show_regs_chassis, NULL);
 static DEVICE_ATTR(chassis_clear, S_IRUGO | S_IWUSR,
-			show_chassis_clear, store_chassis_clear);
+			show_chassis_clear, store_chassis_clear_legacy);
+static DEVICE_ATTR(intrusion0_alarm, S_IRUGO | S_IWUSR,
+			show_chassis, store_chassis_clear);
 static SENSOR_DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 0);
 static SENSOR_DEVICE_ATTR(pwm2, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 1);
 static SENSOR_DEVICE_ATTR(pwm3, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 2);
@@ -1214,6 +1251,7 @@ static struct attribute *w83792d_attribu
 	&dev_attr_alarms.attr,
 	&dev_attr_chassis.attr,
 	&dev_attr_chassis_clear.attr,
+	&dev_attr_intrusion0_alarm.attr,
 	&sensor_dev_attr_tolerance1.dev_attr.attr,
 	&sensor_dev_attr_thermal_cruise1.dev_attr.attr,
 	&sensor_dev_attr_tolerance2.dev_attr.attr,

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
