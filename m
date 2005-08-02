From: jcromie@divsol.com (Jim Cromie)
Date: Tue, 02 Aug 2005 00:07:15 +0000
Subject: [lm-sensors] [patchset 0/23] pc87360 convert pww dev-attr get-set
Message-Id: <42EE9BD0.2000307@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


convert pww dev-attr get-set macros to functions.

[jimc@harpo pset]$ diffstat 10-pwm-demacro
 pc87360.c |   62 
++++++++++++++++++++++++++++++++------------------------------
 1 files changed, 32 insertions(+), 30 deletions(-)

Signed-off-by:  Jim Cromie <jcromie@divsol.com>


-------------- next part --------------
diff -ruNp -X exclude-diffs lxE-2/drivers/hwmon/pc87360.c lxE-3/drivers/hwmon/pc87360.c
--- lxE-2/drivers/hwmon/pc87360.c	2005-07-31 21:14:56.000000000 -0600
+++ lxE-3/drivers/hwmon/pc87360.c	2005-07-31 21:15:31.000000000 -0600
@@ -323,37 +323,39 @@ show_and_set_fan(1)
 show_and_set_fan(2)
 show_and_set_fan(3)
 
-#define show_and_set_pwm(offset) \
-static ssize_t show_pwm##offset(struct device *dev, struct device_attribute *devattr, char *buf) \
-{ \
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
-	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%u\n", \
-		       PWM_FROM_REG(data->pwm[attr->index-1], \
-				    FAN_CONFIG_INVERT(data->fan_conf, \
-						      offset-1))); \
-} \
-static ssize_t set_pwm##offset(struct device *dev, struct device_attribute *devattr, const char *buf, \
-	size_t count) \
-{ \
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct pc87360_data *data = i2c_get_clientdata(client); \
-	long val = simple_strtol(buf, NULL, 10); \
- \
-	down(&data->update_lock); \
-	data->pwm[attr->index-1] = PWM_TO_REG(val, \
-			      FAN_CONFIG_INVERT(data->fan_conf, offset-1)); \
-	pc87360_write_value(data, LD_FAN, NO_BANK, PC87360_REG_PWM(offset-1), \
-			    data->pwm[attr->index-1]); \
-	up(&data->update_lock); \
-	return count; \
-} \
+static ssize_t show_pwm(struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n",
+		       PWM_FROM_REG(data->pwm[attr->index-1],
+				    FAN_CONFIG_INVERT(data->fan_conf,
+						      attr->index-1)));
+}
+static ssize_t set_pwm(struct device *dev, struct device_attribute *devattr, const char *buf,
+	size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pc87360_data *data = i2c_get_clientdata(client);
+	long val = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
+	data->pwm[attr->index-1] = PWM_TO_REG(val,
+			      FAN_CONFIG_INVERT(data->fan_conf, attr->index-1));
+	pc87360_write_value(data, LD_FAN, NO_BANK, PC87360_REG_PWM(attr->index-1),
+			    data->pwm[attr->index-1]);
+	up(&data->update_lock);
+	return count;
+}
+
+#define declare_pwm_sdas(offset) \
 static SENSOR_DEVICE_ATTR(pwm##offset, S_IWUSR | S_IRUGO, \
-	show_pwm##offset, set_pwm##offset, offset);
-show_and_set_pwm(1)
-show_and_set_pwm(2)
-show_and_set_pwm(3)
+	show_pwm, set_pwm, offset)
+
+declare_pwm_sdas(1);
+declare_pwm_sdas(2);
+declare_pwm_sdas(3);
 
 static ssize_t show_in_input(struct device *dev, struct device_attribute *devattr, char *buf)
 {
