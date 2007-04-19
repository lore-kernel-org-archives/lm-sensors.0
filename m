From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 19 Apr 2007 06:31:19 +0000
Subject: [lm-sensors] [PATCH]smsc47m1: Use dynamic sysfs callbacks
Message-Id: <20070419083119.4ba4a9b4@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This lets us get rid of macro-generated functions and shrinks the
driver size by about 7%.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/smsc47m1.c |  198 ++++++++++++++++++++++------------------------
 1 file changed, 95 insertions(+), 103 deletions(-)

--- linux-2.6.21-rc6.orig/drivers/hwmon/smsc47m1.c	2007-04-18 22:57:24.000000000 +0200
+++ linux-2.6.21-rc6/drivers/hwmon/smsc47m1.c	2007-04-19 08:02:02.000000000 +0200
@@ -32,6 +32,7 @@
 #include <linux/jiffies.h>
 #include <linux/platform_device.h>
 #include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/mutex.h>
@@ -157,11 +158,12 @@ static struct platform_driver smsc47m1_d
 	.remove		= __devexit_p(smsc47m1_remove),
 };
 
-/* nr is 0 or 1 in the callback functions below */
-
-static ssize_t get_fan(struct device *dev, char *buf, int nr)
+static ssize_t get_fan(struct device *dev, struct device_attribute
+		       *devattr, char *buf)
 {
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct smsc47m1_data *data = smsc47m1_update_device(dev, 0);
+	int nr = attr->index;
 	/* This chip (stupidly) stops monitoring fan speed if PWM is
 	   enabled and duty cycle is 0%. This is fine if the monitoring
 	   and control concern the same fan, but troublesome if they are
@@ -173,42 +175,54 @@ static ssize_t get_fan(struct device *de
 	return sprintf(buf, "%d\n", rpm);
 }
 
-static ssize_t get_fan_min(struct device *dev, char *buf, int nr)
+static ssize_t get_fan_min(struct device *dev, struct device_attribute
+			   *devattr, char *buf)
 {
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct smsc47m1_data *data = smsc47m1_update_device(dev, 0);
+	int nr = attr->index;
 	int rpm = MIN_FROM_REG(data->fan_preload[nr],
 			       DIV_FROM_REG(data->fan_div[nr]));
 	return sprintf(buf, "%d\n", rpm);
 }
 
-static ssize_t get_fan_div(struct device *dev, char *buf, int nr)
+static ssize_t get_fan_div(struct device *dev, struct device_attribute
+			   *devattr, char *buf)
 {
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct smsc47m1_data *data = smsc47m1_update_device(dev, 0);
-	return sprintf(buf, "%d\n", DIV_FROM_REG(data->fan_div[nr]));
+	return sprintf(buf, "%d\n", DIV_FROM_REG(data->fan_div[attr->index]));
 }
 
-static ssize_t get_pwm(struct device *dev, char *buf, int nr)
+static ssize_t get_pwm(struct device *dev, struct device_attribute
+		       *devattr, char *buf)
 {
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct smsc47m1_data *data = smsc47m1_update_device(dev, 0);
-	return sprintf(buf, "%d\n", PWM_FROM_REG(data->pwm[nr]));
+	return sprintf(buf, "%d\n", PWM_FROM_REG(data->pwm[attr->index]));
 }
 
-static ssize_t get_pwm_en(struct device *dev, char *buf, int nr)
+static ssize_t get_pwm_en(struct device *dev, struct device_attribute
+			  *devattr, char *buf)
 {
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct smsc47m1_data *data = smsc47m1_update_device(dev, 0);
-	return sprintf(buf, "%d\n", PWM_EN_FROM_REG(data->pwm[nr]));
+	return sprintf(buf, "%d\n", PWM_EN_FROM_REG(data->pwm[attr->index]));
 }
 
-static ssize_t get_alarms(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t get_alarms(struct device *dev, struct device_attribute
+			  *devattr, char *buf)
 {
 	struct smsc47m1_data *data = smsc47m1_update_device(dev, 0);
 	return sprintf(buf, "%d\n", data->alarms);
 }
 
-static ssize_t set_fan_min(struct device *dev, const char *buf,
-		size_t count, int nr)
+static ssize_t set_fan_min(struct device *dev, struct device_attribute
+			   *devattr, const char *buf, size_t count)
 {
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct smsc47m1_data *data = dev_get_drvdata(dev);
+	int nr = attr->index;
 	long rpmdiv, val = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
@@ -231,11 +245,12 @@ static ssize_t set_fan_min(struct device
    determined in part by the fan clock divider.  This follows the principle
    of least surprise; the user doesn't expect the fan minimum to change just
    because the divider changed. */
-static ssize_t set_fan_div(struct device *dev, const char *buf,
-		size_t count, int nr)
+static ssize_t set_fan_div(struct device *dev, struct device_attribute
+			   *devattr, const char *buf, size_t count)
 {
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct smsc47m1_data *data = dev_get_drvdata(dev);
-
+	int nr = attr->index;
 	long new_div = simple_strtol(buf, NULL, 10), tmp;
 	u8 old_div = DIV_FROM_REG(data->fan_div[nr]);
 
@@ -279,11 +294,12 @@ static ssize_t set_fan_div(struct device
 	return count;
 }
 
-static ssize_t set_pwm(struct device *dev, const char *buf,
-		size_t count, int nr)
+static ssize_t set_pwm(struct device *dev, struct device_attribute
+		       *devattr, const char *buf, size_t count)
 {
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct smsc47m1_data *data = dev_get_drvdata(dev);
-
+	int nr = attr->index;
 	long val = simple_strtol(buf, NULL, 10);
 
 	if (val < 0 || val > 255)
@@ -299,11 +315,12 @@ static ssize_t set_pwm(struct device *de
 	return count;
 }
 
-static ssize_t set_pwm_en(struct device *dev, const char *buf,
-		size_t count, int nr)
+static ssize_t set_pwm_en(struct device *dev, struct device_attribute
+			  *devattr, const char *buf, size_t count)
 {
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct smsc47m1_data *data = dev_get_drvdata(dev);
-
+	int nr = attr->index;
 	long val = simple_strtol(buf, NULL, 10);
 	
 	if (val != 0 && val != 1)
@@ -320,56 +337,16 @@ static ssize_t set_pwm_en(struct device 
 }
 
 #define fan_present(offset)						\
-static ssize_t get_fan##offset (struct device *dev, struct device_attribute *attr, char *buf)		\
-{									\
-	return get_fan(dev, buf, offset - 1);				\
-}									\
-static ssize_t get_fan##offset##_min (struct device *dev, struct device_attribute *attr, char *buf)	\
-{									\
-	return get_fan_min(dev, buf, offset - 1);			\
-}									\
-static ssize_t set_fan##offset##_min (struct device *dev, struct device_attribute *attr,		\
-		const char *buf, size_t count)				\
-{									\
-	return set_fan_min(dev, buf, count, offset - 1);		\
-}									\
-static ssize_t get_fan##offset##_div (struct device *dev, struct device_attribute *attr, char *buf)	\
-{									\
-	return get_fan_div(dev, buf, offset - 1);			\
-}									\
-static ssize_t set_fan##offset##_div (struct device *dev, struct device_attribute *attr,		\
-		const char *buf, size_t count)				\
-{									\
-	return set_fan_div(dev, buf, count, offset - 1);		\
-}									\
-static ssize_t get_pwm##offset (struct device *dev, struct device_attribute *attr, char *buf)		\
-{									\
-	return get_pwm(dev, buf, offset - 1);				\
-}									\
-static ssize_t set_pwm##offset (struct device *dev, struct device_attribute *attr,			\
-		const char *buf, size_t count)				\
-{									\
-	return set_pwm(dev, buf, count, offset - 1);			\
-}									\
-static ssize_t get_pwm##offset##_en (struct device *dev, struct device_attribute *attr, char *buf)	\
-{									\
-	return get_pwm_en(dev, buf, offset - 1);			\
-}									\
-static ssize_t set_pwm##offset##_en (struct device *dev, struct device_attribute *attr,		\
-		const char *buf, size_t count)				\
-{									\
-	return set_pwm_en(dev, buf, count, offset - 1);			\
-}									\
-static DEVICE_ATTR(fan##offset##_input, S_IRUGO, get_fan##offset,	\
-		NULL);							\
-static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR,		\
-		get_fan##offset##_min, set_fan##offset##_min);		\
-static DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR,		\
-		get_fan##offset##_div, set_fan##offset##_div);		\
-static DEVICE_ATTR(pwm##offset, S_IRUGO | S_IWUSR,			\
-		get_pwm##offset, set_pwm##offset);			\
-static DEVICE_ATTR(pwm##offset##_enable, S_IRUGO | S_IWUSR,		\
-		get_pwm##offset##_en, set_pwm##offset##_en);
+static SENSOR_DEVICE_ATTR(fan##offset##_input, S_IRUGO, get_fan,	\
+		NULL, offset - 1);					\
+static SENSOR_DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR,		\
+		get_fan_min, set_fan_min, offset - 1);			\
+static SENSOR_DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR,		\
+		get_fan_div, set_fan_div, offset - 1);			\
+static SENSOR_DEVICE_ATTR(pwm##offset, S_IRUGO | S_IWUSR,		\
+		get_pwm, set_pwm, offset - 1);				\
+static SENSOR_DEVICE_ATTR(pwm##offset##_enable, S_IRUGO | S_IWUSR,	\
+		get_pwm_en, set_pwm_en, offset - 1)
 
 fan_present(1);
 fan_present(2);
@@ -390,22 +367,22 @@ static DEVICE_ATTR(name, S_IRUGO, show_n
    setup so we create them individually. It is still convenient to define a
    group to remove them all at once. */
 static struct attribute *smsc47m1_attributes[] = {
-	&dev_attr_fan1_input.attr,
-	&dev_attr_fan1_min.attr,
-	&dev_attr_fan1_div.attr,
-	&dev_attr_fan2_input.attr,
-	&dev_attr_fan2_min.attr,
-	&dev_attr_fan2_div.attr,
-	&dev_attr_fan3_input.attr,
-	&dev_attr_fan3_min.attr,
-	&dev_attr_fan3_div.attr,
-
-	&dev_attr_pwm1.attr,
-	&dev_attr_pwm1_enable.attr,
-	&dev_attr_pwm2.attr,
-	&dev_attr_pwm2_enable.attr,
-	&dev_attr_pwm3.attr,
-	&dev_attr_pwm3_enable.attr,
+	&sensor_dev_attr_fan1_input.dev_attr.attr,
+	&sensor_dev_attr_fan1_min.dev_attr.attr,
+	&sensor_dev_attr_fan1_div.dev_attr.attr,
+	&sensor_dev_attr_fan2_input.dev_attr.attr,
+	&sensor_dev_attr_fan2_min.dev_attr.attr,
+	&sensor_dev_attr_fan2_div.dev_attr.attr,
+	&sensor_dev_attr_fan3_input.dev_attr.attr,
+	&sensor_dev_attr_fan3_min.dev_attr.attr,
+	&sensor_dev_attr_fan3_div.dev_attr.attr,
+
+	&sensor_dev_attr_pwm1.dev_attr.attr,
+	&sensor_dev_attr_pwm1_enable.dev_attr.attr,
+	&sensor_dev_attr_pwm2.dev_attr.attr,
+	&sensor_dev_attr_pwm2_enable.dev_attr.attr,
+	&sensor_dev_attr_pwm3.dev_attr.attr,
+	&sensor_dev_attr_pwm3_enable.dev_attr.attr,
 
 	&dev_attr_alarms.attr,
 	&dev_attr_name.attr,
@@ -547,46 +524,61 @@ static int __devinit smsc47m1_probe(stru
 
 	/* Register sysfs hooks */
 	if (fan1) {
-		if ((err = device_create_file(dev, &dev_attr_fan1_input))
-		 || (err = device_create_file(dev, &dev_attr_fan1_min))
-		 || (err = device_create_file(dev, &dev_attr_fan1_div)))
+		if ((err = device_create_file(dev,
+				&sensor_dev_attr_fan1_input.dev_attr))
+		 || (err = device_create_file(dev,
+		 		&sensor_dev_attr_fan1_min.dev_attr))
+		 || (err = device_create_file(dev,
+		 		&sensor_dev_attr_fan1_div.dev_attr)))
 			goto error_remove_files;
 	} else
 		dev_dbg(dev, "Fan 1 not enabled by hardware, skipping\n");
 
 	if (fan2) {
-		if ((err = device_create_file(dev, &dev_attr_fan2_input))
-		 || (err = device_create_file(dev, &dev_attr_fan2_min))
-		 || (err = device_create_file(dev, &dev_attr_fan2_div)))
+		if ((err = device_create_file(dev,
+				&sensor_dev_attr_fan2_input.dev_attr))
+		 || (err = device_create_file(dev,
+		 		&sensor_dev_attr_fan2_min.dev_attr))
+		 || (err = device_create_file(dev,
+		 		&sensor_dev_attr_fan2_div.dev_attr)))
 			goto error_remove_files;
 	} else
 		dev_dbg(dev, "Fan 2 not enabled by hardware, skipping\n");
 
 	if (fan3) {
-		if ((err = device_create_file(dev, &dev_attr_fan3_input))
-		 || (err = device_create_file(dev, &dev_attr_fan3_min))
-		 || (err = device_create_file(dev, &dev_attr_fan3_div)))
+		if ((err = device_create_file(dev,
+				&sensor_dev_attr_fan3_input.dev_attr))
+		 || (err = device_create_file(dev,
+		 		&sensor_dev_attr_fan3_min.dev_attr))
+		 || (err = device_create_file(dev,
+		 		&sensor_dev_attr_fan3_div.dev_attr)))
 			goto error_remove_files;
 	} else
 		dev_dbg(dev, "Fan 3 not enabled by hardware, skipping\n");
 
 	if (pwm1) {
-		if ((err = device_create_file(dev, &dev_attr_pwm1))
-		 || (err = device_create_file(dev, &dev_attr_pwm1_enable)))
+		if ((err = device_create_file(dev,
+				&sensor_dev_attr_pwm1.dev_attr))
+		 || (err = device_create_file(dev,
+		 		&sensor_dev_attr_pwm1_enable.dev_attr)))
 			goto error_remove_files;
 	} else
 		dev_dbg(dev, "PWM 1 not enabled by hardware, skipping\n");
 
 	if (pwm2) {
-		if ((err = device_create_file(dev, &dev_attr_pwm2))
-		 || (err = device_create_file(dev, &dev_attr_pwm2_enable)))
+		if ((err = device_create_file(dev,
+				&sensor_dev_attr_pwm2.dev_attr))
+		 || (err = device_create_file(dev,
+		 		&sensor_dev_attr_pwm2_enable.dev_attr)))
 			goto error_remove_files;
 	} else
 		dev_dbg(dev, "PWM 2 not enabled by hardware, skipping\n");
 
 	if (pwm3) {
-		if ((err = device_create_file(dev, &dev_attr_pwm3))
-		 || (err = device_create_file(dev, &dev_attr_pwm3_enable)))
+		if ((err = device_create_file(dev,
+				&sensor_dev_attr_pwm3.dev_attr))
+		 || (err = device_create_file(dev,
+		 		&sensor_dev_attr_pwm3_enable.dev_attr)))
 			goto error_remove_files;
 	} else
 		dev_dbg(dev, "PWM 3 not enabled by hardware, skipping\n");


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
