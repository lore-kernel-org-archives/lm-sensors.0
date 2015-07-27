From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 27 Jul 2015 17:33:44 +0000
Subject: [lm-sensors] [PATCH] hwmon: (nct7904) Rename pwm attributes to match hwmon ABI
Message-Id: <1438018424-31644-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

pwm attributes have well defined names, which should be used.

Cc: Vadim V. Vlasov <vvlasov@dev.rtsoft.ru>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
No idea how I missed that earlier.
Should go into 4.2 as well as 4.1.

 drivers/hwmon/nct7904.c | 57 +++++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 28 deletions(-)

diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
index b77b82f24480..6153df735e82 100644
--- a/drivers/hwmon/nct7904.c
+++ b/drivers/hwmon/nct7904.c
@@ -412,8 +412,9 @@ static ssize_t show_pwm(struct device *dev,
 	return sprintf(buf, "%d\n", val);
 }
 
-static ssize_t store_mode(struct device *dev, struct device_attribute *devattr,
-			  const char *buf, size_t count)
+static ssize_t store_enable(struct device *dev,
+			    struct device_attribute *devattr,
+			    const char *buf, size_t count)
 {
 	int index = to_sensor_dev_attr(devattr)->index;
 	struct nct7904_data *data = dev_get_drvdata(dev);
@@ -422,18 +423,18 @@ static ssize_t store_mode(struct device *dev, struct device_attribute *devattr,
 
 	if (kstrtoul(buf, 10, &val) < 0)
 		return -EINVAL;
-	if (val > 1 || (val && !data->fan_mode[index]))
+	if (val < 1 || val > 2 || (val = 2 && !data->fan_mode[index]))
 		return -EINVAL;
 
 	ret = nct7904_write_reg(data, BANK_3, FANCTL1_FMR_REG + index,
-				val ? data->fan_mode[index] : 0);
+				val = 2 ? data->fan_mode[index] : 0);
 
 	return ret ? ret : count;
 }
 
-/* Return 0 for manual mode or 1 for SmartFan mode */
-static ssize_t show_mode(struct device *dev,
-			 struct device_attribute *devattr, char *buf)
+/* Return 1 for manual mode or 2 for SmartFan mode */
+static ssize_t show_enable(struct device *dev,
+			   struct device_attribute *devattr, char *buf)
 {
 	int index = to_sensor_dev_attr(devattr)->index;
 	struct nct7904_data *data = dev_get_drvdata(dev);
@@ -443,36 +444,36 @@ static ssize_t show_mode(struct device *dev,
 	if (val < 0)
 		return val;
 
-	return sprintf(buf, "%d\n", val ? 1 : 0);
+	return sprintf(buf, "%d\n", val ? 2 : 1);
 }
 
 /* 2 attributes per channel: pwm and mode */
-static SENSOR_DEVICE_ATTR(fan1_pwm, S_IRUGO | S_IWUSR,
+static SENSOR_DEVICE_ATTR(pwm1, S_IRUGO | S_IWUSR,
 			show_pwm, store_pwm, 0);
-static SENSOR_DEVICE_ATTR(fan1_mode, S_IRUGO | S_IWUSR,
-			show_mode, store_mode, 0);
-static SENSOR_DEVICE_ATTR(fan2_pwm, S_IRUGO | S_IWUSR,
+static SENSOR_DEVICE_ATTR(pwm1_enable, S_IRUGO | S_IWUSR,
+			show_enable, store_enable, 0);
+static SENSOR_DEVICE_ATTR(pwm2, S_IRUGO | S_IWUSR,
 			show_pwm, store_pwm, 1);
-static SENSOR_DEVICE_ATTR(fan2_mode, S_IRUGO | S_IWUSR,
-			show_mode, store_mode, 1);
-static SENSOR_DEVICE_ATTR(fan3_pwm, S_IRUGO | S_IWUSR,
+static SENSOR_DEVICE_ATTR(pwm2_enable, S_IRUGO | S_IWUSR,
+			show_enable, store_enable, 1);
+static SENSOR_DEVICE_ATTR(pwm3, S_IRUGO | S_IWUSR,
 			show_pwm, store_pwm, 2);
-static SENSOR_DEVICE_ATTR(fan3_mode, S_IRUGO | S_IWUSR,
-			show_mode, store_mode, 2);
-static SENSOR_DEVICE_ATTR(fan4_pwm, S_IRUGO | S_IWUSR,
+static SENSOR_DEVICE_ATTR(pwm3_enable, S_IRUGO | S_IWUSR,
+			show_enable, store_enable, 2);
+static SENSOR_DEVICE_ATTR(pwm4, S_IRUGO | S_IWUSR,
 			show_pwm, store_pwm, 3);
-static SENSOR_DEVICE_ATTR(fan4_mode, S_IRUGO | S_IWUSR,
-			show_mode, store_mode, 3);
+static SENSOR_DEVICE_ATTR(pwm4_enable, S_IRUGO | S_IWUSR,
+			show_enable, store_enable, 3);
 
 static struct attribute *nct7904_fanctl_attrs[] = {
-	&sensor_dev_attr_fan1_pwm.dev_attr.attr,
-	&sensor_dev_attr_fan1_mode.dev_attr.attr,
-	&sensor_dev_attr_fan2_pwm.dev_attr.attr,
-	&sensor_dev_attr_fan2_mode.dev_attr.attr,
-	&sensor_dev_attr_fan3_pwm.dev_attr.attr,
-	&sensor_dev_attr_fan3_mode.dev_attr.attr,
-	&sensor_dev_attr_fan4_pwm.dev_attr.attr,
-	&sensor_dev_attr_fan4_mode.dev_attr.attr,
+	&sensor_dev_attr_pwm1.dev_attr.attr,
+	&sensor_dev_attr_pwm1_enable.dev_attr.attr,
+	&sensor_dev_attr_pwm2.dev_attr.attr,
+	&sensor_dev_attr_pwm2_enable.dev_attr.attr,
+	&sensor_dev_attr_pwm3.dev_attr.attr,
+	&sensor_dev_attr_pwm3_enable.dev_attr.attr,
+	&sensor_dev_attr_pwm4.dev_attr.attr,
+	&sensor_dev_attr_pwm4_enable.dev_attr.attr,
 	NULL
 };
 
-- 
2.1.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
