From: "Engelmayer Christian" <Christian.Engelmayer@frequentis.com>
Date: Tue, 19 May 2009 08:39:16 +0000
Subject: [lm-sensors] [PATCH 2.6.29.3 1/1] hwmon: added support for the
Message-Id: <9EE81EBECB70824985BE0EDA8DC9B5150214E42C@VIECLEX01.frequentis.frq>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Christian Engelmayer <christian.engelmayer@frequentis.com>

Added support for the GPIO definition/status registers and the alarm
enable/status
registers provided by the MAX6650/MAX6651 fan-speed regulator and monitor
chips.

Signed-off-by: Christian Engelmayer <christian.engelmayer@frequentis.com>
---
Tested with the MAX6651 chip.

--- linux-2.6.29.3/drivers/hwmon/max6650.c.orig	2009-05-19 10:13:34.000000000
+0200
+++ linux-2.6.29.3/drivers/hwmon/max6650.c	2009-05-19 10:06:51.000000000
+0200
@@ -12,7 +12,7 @@
  * also work with the MAX6651. It does not distinguish max6650 and max6651
  * chips.
  *
- * Tha datasheet was last seen at:
+ * The datasheet was last seen at:
  *
  *        http://pdfserv.maxim-ic.com/en/ds/MAX6650-MAX6651.pdf
  *
@@ -98,6 +98,24 @@ I2C_CLIENT_INSMOD_1(max6650);
 #define MAX6650_CFG_MODE_OPEN_LOOP	0x30
 #define MAX6650_COUNT_MASK		0x03
 
+/*
+ * Alarm enable register bits
+ */
+
+#define MAX6650_ALARM_EN_GPIO2	0x10
+#define MAX6650_ALARM_EN_GPIO1	0x08
+#define MAX6650_ALARM_EN_TACH	0x04
+#define MAX6650_ALARM_EN_MIN	0x02
+#define MAX6650_ALARM_EN_MAX	0x01
+#define MAX6650_ALARM_EN_MASK	0x1F
+
+/*
+ * GPIO definition register bits
+ */
+
+static const int gpio_def_masks[5] = {0x03, 0x0C, 0x30, 0x40, 0x80};
+static const int gpio_def_shift[5] = {0, 2, 4, 6, 7};
+
 /* Minimum and maximum values of the FAN-RPM */
 #define FAN_RPM_MIN 240
 #define FAN_RPM_MAX 30000
@@ -148,7 +166,11 @@ struct max6650_data
 	/* register values */
 	u8 speed;
 	u8 config;
+	u8 gpio_def;
+	u8 alarm_en;
+	u8 alarm;
 	u8 tach[4];
+	u8 gpio;
 	u8 count;
 	u8 dac;
 };
@@ -327,8 +349,8 @@ static ssize_t set_pwm(struct device *de
  * 2 = Closed loop, RPM for all fans regulated by fan1 tachometer
  */
 
-static ssize_t get_enable(struct device *dev, struct device_attribute
*devattr,
-			  char *buf)
+static ssize_t get_pwm_enable(struct device *dev,
+			      struct device_attribute *devattr, char *buf)
 {
 	struct max6650_data *data = max6650_update_device(dev);
 	int mode = (data->config & MAX6650_CFG_MODE_MASK) >> 4;
@@ -337,8 +359,9 @@ static ssize_t get_enable(struct device 
 	return sprintf(buf, "%d\n", sysfs_modes[mode]);
 }
 
-static ssize_t set_enable(struct device *dev, struct device_attribute
*devattr,
-			  const char *buf, size_t count)
+static ssize_t set_pwm_enable(struct device *dev,
+			      struct device_attribute *devattr, const char
*buf,
+			      size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct max6650_data *data = i2c_get_clientdata(client);
@@ -418,15 +441,160 @@ static ssize_t set_div(struct device *de
 	return count;
 }
 
+/*
+ * Get/Set GPIO pin definition:
+ * Possible values:
+ * 0 = Outputs a logic-level low.
+ * 1 = Outputs a logic-level high or serves as an input.
+ * 2 = Serves as an external clock input.
+ * 3 = Serves as an external clock output.
+ * 4 = Serves as a __FULL_ON__ input.
+ * 5 = Serves as an __ALERT__ output.
+ */
+
+static ssize_t get_gpio_def(struct device *dev,
+			    struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct max6650_data *data = max6650_update_device(dev);
+	int pin = attr->index;
+	int def = (data->gpio_def & gpio_def_masks[pin]) >>
gpio_def_shift[pin];
+
+	int sysfs_def[5][4] = {{1, 5, 0, 1},	/* gpio0		*/
+			       {1, 4, 0, 1},	/* gpio1		*/
+			       {2, 3, 0, 1},	/* gpio2 (MAX6651 only) */
+			       {0, 1, 0, 0},	/* gpio3 (MAX6651 only) */
+			       {0, 1, 0, 0}};	/* gpio4 (MAX6651 only) */
+
+	return sprintf(buf, "%d\n", sysfs_def[pin][def]);
+}
+
+static ssize_t set_gpio_def(struct device *dev,
+			    struct device_attribute *devattr, const char
*buf,
+			    size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct max6650_data *data = i2c_get_clientdata(client);
+	int def = simple_strtoul(buf, NULL, 10);
+	int pin = attr->index;
+
+	int max6650_def[5][6] = {{2, 3,-1,-1,-1, 1},  /* gpio0
*/
+				 {2, 3,-1,-1, 1,-1},  /* gpio1
*/
+				 {2, 3, 0, 1,-1,-1},  /* gpio2 (MAX6651 only)
*/
+				 {0, 1,-1,-1,-1,-1},  /* gpio3 (MAX6651 only)
*/
+				 {0, 1,-1,-1,-1,-1}}; /* gpio4 (MAX6651 only)
*/
+
+	if ((def < 0)||(def > 5) || (max6650_def[pin][def] < 0)) {
+		dev_err(&client->dev,
+			"illegal value for gpio%d_def (%d)\n", pin, def);
+		return -EINVAL;
+	}
+
+	mutex_lock(&data->update_lock);
+
+	data->gpio_def = i2c_smbus_read_byte_data(client,
MAX6650_REG_GPIO_DEF);
+	data->gpio_def = (data->gpio_def & ~gpio_def_masks[pin])
+			 | (max6650_def[pin][def] << gpio_def_shift[pin]);
+	i2c_smbus_write_byte_data(client, MAX6650_REG_GPIO_DEF,
data->gpio_def);
+
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+/*
+ * Get GPIO status bitmask:
+ * Bit definition:
+ * 0x01 = GPIO0 logic-level.
+ * 0x02 = GPIO1 logic-level.
+ * 0x04 = GPIO2 logic-level. (MAX6651 only)
+ * 0x08 = GPIO3 logic-level. (MAX6651 only)
+ * 0x10 = GPIO4 logic-level. (MAX6651 only)
+ */
+
+static ssize_t get_gpio(struct device *dev,
+			 struct device_attribute *devattr, char *buf)
+{
+	struct max6650_data *data = max6650_update_device(dev);
+	return sprintf(buf, "0x%02x\n", data->gpio);
+}
+
+/*
+ * Get/Set alarm enable bitmask:
+ * Bit definition:
+ * 0x01 = Maximum output level alarm enable.
+ * 0x02 = Minimum output level alarm enable.
+ * 0x04 = Tachometer overflow alarm enable.
+ * 0x08 = GPIO1 alarm. Set when GPIO1 is low.
+ * 0x10 = GPIO2 alarm. Set when GPIO2 is low. (MAX6651 only)
+ */
+
+static ssize_t get_alarm_enable(struct device *dev,
+				struct device_attribute *devattr, char *buf)
+{
+	struct max6650_data *data = max6650_update_device(dev);
+	return sprintf(buf, "0x%02x\n", data->alarm_en &
MAX6650_ALARM_EN_MASK);
+}
+
+static ssize_t set_alarm_enable(struct device *dev,
+				struct device_attribute *devattr,
+				const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct max6650_data *data = i2c_get_clientdata(client);
+	int alarm = simple_strtoul(buf, NULL, 16);
+
+	mutex_lock(&data->update_lock);
+
+	data->alarm_en = alarm & MAX6650_ALARM_EN_MASK;
+	i2c_smbus_write_byte_data(client, MAX6650_REG_ALARM_EN,
data->alarm_en);
+
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+/*
+ * Get alarm bitmask:
+ * Bit definition:
+ * 0x01 = Maximum output level alarm.
+ * 0x02 = Minimum output level alarm.
+ * 0x04 = Tachometer overflow alarm.
+ * 0x08 = GPIO1 alarm. Set when GPIO1 is low.
+ * 0x10 = GPIO2 alarm. Set when GPIO2 is low. (MAX6651 only)
+ */
+
+static ssize_t get_alarm(struct device *dev,
+			 struct device_attribute *devattr, char *buf)
+{
+	struct max6650_data *data = max6650_update_device(dev);
+	return sprintf(buf, "0x%02x\n", data->alarm);
+}
+
 static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, get_fan, NULL, 0);
 static SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, get_fan, NULL, 1);
 static SENSOR_DEVICE_ATTR(fan3_input, S_IRUGO, get_fan, NULL, 2);
 static SENSOR_DEVICE_ATTR(fan4_input, S_IRUGO, get_fan, NULL, 3);
 static DEVICE_ATTR(fan1_target, S_IWUSR | S_IRUGO, get_target, set_target);
 static DEVICE_ATTR(fan1_div, S_IWUSR | S_IRUGO, get_div, set_div);
-static DEVICE_ATTR(pwm1_enable, S_IWUSR | S_IRUGO, get_enable, set_enable);
+static DEVICE_ATTR(pwm1_enable, S_IWUSR | S_IRUGO, get_pwm_enable,
+		   set_pwm_enable);
 static DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, get_pwm, set_pwm);
-
+static SENSOR_DEVICE_ATTR(gpio0_def, S_IWUSR | S_IRUGO, get_gpio_def,
+			  set_gpio_def, 0);
+static SENSOR_DEVICE_ATTR(gpio1_def, S_IWUSR | S_IRUGO, get_gpio_def,
+			  set_gpio_def, 1);
+static SENSOR_DEVICE_ATTR(gpio2_def, S_IWUSR | S_IRUGO, get_gpio_def,
+			  set_gpio_def, 2);
+static SENSOR_DEVICE_ATTR(gpio3_def, S_IWUSR | S_IRUGO, get_gpio_def,
+			  set_gpio_def, 3);
+static SENSOR_DEVICE_ATTR(gpio4_def, S_IWUSR | S_IRUGO, get_gpio_def,
+			  set_gpio_def, 4);
+static DEVICE_ATTR(gpio, S_IRUGO, get_gpio, NULL);
+static DEVICE_ATTR(alarm_enable, S_IWUSR | S_IRUGO, get_alarm_enable,
+		   set_alarm_enable);
+static DEVICE_ATTR(alarm, S_IRUGO, get_alarm, NULL);
 
 static struct attribute *max6650_attrs[] = {
 	&sensor_dev_attr_fan1_input.dev_attr.attr,
@@ -437,6 +605,14 @@ static struct attribute *max6650_attrs[]
 	&dev_attr_fan1_div.attr,
 	&dev_attr_pwm1_enable.attr,
 	&dev_attr_pwm1.attr,
+	&sensor_dev_attr_gpio0_def.dev_attr.attr,
+	&sensor_dev_attr_gpio1_def.dev_attr.attr,
+	&sensor_dev_attr_gpio2_def.dev_attr.attr,
+	&sensor_dev_attr_gpio3_def.dev_attr.attr,
+	&sensor_dev_attr_gpio4_def.dev_attr.attr,
+	&dev_attr_alarm_enable.attr,
+	&dev_attr_alarm.attr,
+	&dev_attr_gpio.attr,
 	NULL
 };
 
@@ -651,10 +827,18 @@ static struct max6650_data *max6650_upda
 						       MAX6650_REG_SPEED);
 		data->config = i2c_smbus_read_byte_data(client,
 							MAX6650_REG_CONFIG);
+		data->gpio_def = i2c_smbus_read_byte_data(client,
+
MAX6650_REG_GPIO_DEF);
+		data->alarm_en = i2c_smbus_read_byte_data(client,
+
MAX6650_REG_ALARM_EN);
+		data->alarm = i2c_smbus_read_byte_data(client,
+						       MAX6650_REG_ALARM);
 		for (i = 0; i < 4; i++) {
 			data->tach[i] = i2c_smbus_read_byte_data(client,
 
tach_reg[i]);
 		}
+		data->gpio = i2c_smbus_read_byte_data(client,
+						      MAX6650_REG_GPIO_STAT);
 		data->count = i2c_smbus_read_byte_data(client,
 							MAX6650_REG_COUNT);
 		data->dac = i2c_smbus_read_byte_data(client,
MAX6650_REG_DAC);

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
