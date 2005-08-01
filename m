From: jcromie@divsol.com (Jim Cromie)
Date: Mon, 01 Aug 2005 22:18:26 +0000
Subject: [lm-sensors] Re: [patchset 6/23] pc87360 pwm dev-attr -->
Message-Id: <42EE833E.3090503@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


upgrade pwm device_attributes to sensor-device-attributes, following 
Yani's form
 a. change declarations: DEVICE_ATTR -> SENSOR_DEVICE_ATTR
 b. compute sensor_dev_attr from dev_attr, with to_sensor_dev_attr(devattr)
 c. change calls to device_create_file() to match.

[jimc@harpo pset]$ diffstat 04-sda-pwm
 pc87360.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

Signed-off-by:  Jim Cromie <jcromie@divsol.com>
-------------- next part --------------
diff -ruNp -X exclude-diffs lxC-5/drivers/hwmon/pc87360.c lxC-6/drivers/hwmon/pc87360.c
--- lxC-5/drivers/hwmon/pc87360.c	2005-07-31 14:14:33.000000000 -0600
+++ lxC-6/drivers/hwmon/pc87360.c	2005-07-31 14:27:34.000000000 -0600
@@ -323,17 +323,19 @@ show_and_set_fan(2)
 show_and_set_fan(3)
 
 #define show_and_set_pwm(offset) \
-static ssize_t show_pwm##offset(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_pwm##offset(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", \
 		       PWM_FROM_REG(data->pwm[offset-1], \
 				    FAN_CONFIG_INVERT(data->fan_conf, \
 						      offset-1))); \
 } \
-static ssize_t set_pwm##offset(struct device *dev, struct device_attribute *attr, const char *buf, \
+static ssize_t set_pwm##offset(struct device *dev, struct device_attribute *devattr, const char *buf, \
 	size_t count) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct pc87360_data *data = i2c_get_clientdata(client); \
 	long val = simple_strtol(buf, NULL, 10); \
