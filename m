From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 13 Apr 2011 15:33:44 +0000
Subject: [lm-sensors] [PATCH 2/2] Add hwmon-style fan speed control
Message-Id: <20110413173344.433453e8@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Let i8k create pwm hwmon attributes for fan speed control. This is
more standard than the i8k-specific interface.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Massimo Dal Zotto <dz@debian.org>
---
This needs testing... I've seen one Vostro model where the pwm values
would change automatically. I'm unsure what would have happened if the
user had tried to write to the attributes.

 drivers/char/i8k.c |   51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

--- linux-2.6.39-rc3.orig/drivers/char/i8k.c	2011-04-13 16:51:33.000000000 +0200
+++ linux-2.6.39-rc3/drivers/char/i8k.c	2011-04-13 17:25:07.000000000 +0200
@@ -487,6 +487,43 @@ static ssize_t i8k_hwmon_show_fan(struct
 	return sprintf(buf, "%d\n", fan_speed);
 }
 
+static ssize_t i8k_hwmon_show_pwm(struct device *dev,
+				  struct device_attribute *devattr,
+				  char *buf)
+{
+	int index = to_sensor_dev_attr(devattr)->index;
+	int status;
+
+	status = i8k_get_fan_status(index);
+	if (status < 0)
+		return status;
+	return sprintf(buf, "%d\n", I8K_FAN_OFF ? 0 : I8K_FAN_LOW ? 128 : 255);
+}
+
+static ssize_t i8k_hwmon_set_pwm(struct device *dev,
+				 struct device_attribute *devattr,
+				 const char *buf, size_t count)
+{
+	int index = to_sensor_dev_attr(devattr)->index;
+	int speed, status;
+	long val;
+
+	if (strict_strtol(buf, 10, &val) < 0 || val < 0 || val > 255)
+		return -EINVAL;
+
+	if (val = 0)
+		speed = I8K_FAN_OFF;
+	else if (val <= 192)
+		speed = I8K_FAN_LOW;
+	else
+		speed = I8K_FAN_HIGH;
+
+	status = i8k_set_fan(index, speed);
+	if (status != speed)
+		return -EIO;
+	return count;
+}
+
 static ssize_t i8k_hwmon_show_label(struct device *dev,
 				    struct device_attribute *devattr,
 				    char *buf)
@@ -511,6 +548,10 @@ static SENSOR_DEVICE_ATTR(name, S_IRUGO,
 static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, i8k_hwmon_show_label, NULL, 1);
 static SENSOR_DEVICE_ATTR(fan1_label, S_IRUGO, i8k_hwmon_show_label, NULL, 2);
 static SENSOR_DEVICE_ATTR(fan2_label, S_IRUGO, i8k_hwmon_show_label, NULL, 3);
+static SENSOR_DEVICE_ATTR(pwm1, S_IRUGO, i8k_hwmon_show_pwm, i8k_hwmon_set_pwm,
+			  I8K_FAN_LEFT);
+static SENSOR_DEVICE_ATTR(pwm2, S_IRUGO, i8k_hwmon_show_pwm, i8k_hwmon_set_pwm,
+			  I8K_FAN_RIGHT);
 
 static void i8k_hwmon_remove_files(struct device *dev)
 {
@@ -520,6 +561,8 @@ static void i8k_hwmon_remove_files(struc
 	device_remove_file(dev, &sensor_dev_attr_temp1_label.dev_attr);
 	device_remove_file(dev, &sensor_dev_attr_fan1_label.dev_attr);
 	device_remove_file(dev, &sensor_dev_attr_fan2_label.dev_attr);
+	device_remove_file(dev, &sensor_dev_attr_pwm1.dev_attr);
+	device_remove_file(dev, &sensor_dev_attr_pwm2.dev_attr);
 	device_remove_file(dev, &sensor_dev_attr_name.dev_attr);
 }
 
@@ -564,6 +607,10 @@ static int __init i8k_init_hwmon(void)
 					 &sensor_dev_attr_fan1_label.dev_attr);
 		if (err)
 			goto exit_remove_files;
+		err = device_create_file(i8k_hwmon_dev,
+					 &sensor_dev_attr_pwm1.dev_attr);
+		if (err)
+			goto exit_remove_files;
 	}
 
 	/* Right fan attributes, if right fan is present */
@@ -580,6 +627,10 @@ static int __init i8k_init_hwmon(void)
 					 &sensor_dev_attr_fan2_label.dev_attr);
 		if (err)
 			goto exit_remove_files;
+		err = device_create_file(i8k_hwmon_dev,
+					 &sensor_dev_attr_pwm2.dev_attr);
+		if (err)
+			goto exit_remove_files;
 	}
 
 	return 0;


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
