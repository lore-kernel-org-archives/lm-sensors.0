From: "Engelmayer Christian" <Christian.Engelmayer@frequentis.com>
Date: Wed, 20 May 2009 10:52:11 +0000
Subject: [lm-sensors] [PATCH 2.6.29.3 1/1] hwmon: added support for the
Message-Id: <9EE81EBECB70824985BE0EDA8DC9B5150214E75D@VIECLEX01.frequentis.frq>
List-Id: <lm-sensors.vger.kernel.org>
References: <9EE81EBECB70824985BE0EDA8DC9B5150214E42C@VIECLEX01.frequentis.frq>
In-Reply-To: <9EE81EBECB70824985BE0EDA8DC9B5150214E42C@VIECLEX01.frequentis.frq>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Christian Engelmayer <christian.engelmayer@frequentis.com>

Exported the alarm stati provided by the MAX6650/MAX6651 fan-speed regulator
and monitor chips via sysfs.

Signed-off-by: Christian Engelmayer <christian.engelmayer@frequentis.com>
---
Tested with the MAX6651 chip. This obsoletes the previously proposed patch
'support for the max6650 GPIO and alarm features' after discussion on sane
gpio handling.

--- drivers/hwmon/max6650.c.orig	2009-05-20 12:36:21.000000000 +0200
+++ drivers/hwmon/max6650.c	2009-05-20 12:38:54.000000000 +0200
@@ -12,7 +12,7 @@
  * also work with the MAX6651. It does not distinguish max6650 and max6651
  * chips.
  *
- * Tha datasheet was last seen at:
+ * The datasheet was last seen at:
  *
  *        http://pdfserv.maxim-ic.com/en/ds/MAX6650-MAX6651.pdf
  *
@@ -98,6 +98,17 @@ I2C_CLIENT_INSMOD_1(max6650);
 #define MAX6650_CFG_MODE_OPEN_LOOP	0x30
 #define MAX6650_COUNT_MASK		0x03
 
+/*
+ * Alarm register bits
+ */
+
+#define MAX6650_ALRM_GPIO2	0x10
+#define MAX6650_ALRM_GPIO1	0x08
+#define MAX6650_ALRM_TACH	0x04
+#define MAX6650_ALRM_MIN	0x02
+#define MAX6650_ALRM_MAX	0x01
+#define MAX6650_ALRM_MASK	0x1F
+
 /* Minimum and maximum values of the FAN-RPM */
 #define FAN_RPM_MIN 240
 #define FAN_RPM_MAX 30000
@@ -111,6 +122,8 @@ static int max6650_detect(struct i2c_cli
 static int max6650_init_client(struct i2c_client *client);
 static int max6650_remove(struct i2c_client *client);
 static struct max6650_data *max6650_update_device(struct device *dev);
+static ssize_t get_alarm(struct device *dev, struct device_attribute
*devattr,
+			 char *buf);
 
 /*
  * Driver data (common to all clients)
@@ -151,6 +164,8 @@ struct max6650_data
 	u8 tach[4];
 	u8 count;
 	u8 dac;
+	u8 alarm_en;
+	u8 alarm;
 };
 
 static ssize_t get_fan(struct device *dev, struct device_attribute *devattr,
@@ -426,7 +441,80 @@ static DEVICE_ATTR(fan1_target, S_IWUSR 
 static DEVICE_ATTR(fan1_div, S_IWUSR | S_IRUGO, get_div, set_div);
 static DEVICE_ATTR(pwm1_enable, S_IWUSR | S_IRUGO, get_enable, set_enable);
 static DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, get_pwm, set_pwm);
+static DEVICE_ATTR(gpio2_alarm, S_IRUGO, get_alarm, NULL);
+static DEVICE_ATTR(gpio1_alarm, S_IRUGO, get_alarm, NULL);
+static DEVICE_ATTR(fan1_fault, S_IRUGO, get_alarm, NULL);
+static DEVICE_ATTR(fan1_min_alarm, S_IRUGO, get_alarm, NULL);
+static DEVICE_ATTR(fan1_max_alarm, S_IRUGO, get_alarm, NULL);
 
+/*
+ * Get alarm stati:
+ * Possible values:
+ * 0 = no alarm
+ * 1 = alarm
+ */
+
+static ssize_t get_alarm(struct device *dev, struct device_attribute
*devattr,
+			 char *buf)
+{
+	struct max6650_data *data = max6650_update_device(dev);
+	struct i2c_client *client = to_i2c_client(dev);
+	u8 mask = 0x00;
+	u8 alarm = 0;
+
+	if (devattr = &dev_attr_gpio2_alarm) {
+		mask = MAX6650_ALRM_GPIO2;
+	} else if (devattr = &dev_attr_gpio1_alarm) {
+		mask = MAX6650_ALRM_GPIO1;
+	} else if (devattr = &dev_attr_fan1_fault) {
+		mask = MAX6650_ALRM_TACH;
+	} else if (devattr = &dev_attr_fan1_min_alarm) {
+		mask = MAX6650_ALRM_MIN;
+	} else if (devattr = &dev_attr_fan1_max_alarm) {
+		mask = MAX6650_ALRM_MAX;
+	}
+
+	if (data->alarm & mask) {
+		mutex_lock(&data->update_lock);
+		alarm = 1;
+		data->alarm &= ~mask;
+		data->alarm |= i2c_smbus_read_byte_data(client,
+							MAX6650_REG_ALARM);
+		mutex_unlock(&data->update_lock);
+	}
+
+	return sprintf(buf, "%d\n", alarm);
+}
+
+static mode_t max6650_attrs_visible(struct kobject *kobj, struct attribute
*a,
+				    int n)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct max6650_data *data = max6650_update_device(dev);
+
+	/*
+	 * Hide the alarms that have not been enabled by the firmware
+	 */
+
+	if (a = &dev_attr_gpio2_alarm.attr) {
+		if (!(data->alarm_en & MAX6650_ALRM_GPIO2))
+			return 0;
+	} else if (a = &dev_attr_gpio1_alarm.attr) {
+		if (!(data->alarm_en & MAX6650_ALRM_GPIO1))
+			return 0;
+	} else if (a = &dev_attr_fan1_fault.attr) {
+		if (!(data->alarm_en & MAX6650_ALRM_TACH))
+			return 0;
+	} else if (a = &dev_attr_fan1_min_alarm.attr) {
+		if (!(data->alarm_en & MAX6650_ALRM_MIN))
+			return 0;
+	} else if (a = &dev_attr_fan1_max_alarm.attr) {
+		if (!(data->alarm_en & MAX6650_ALRM_MAX))
+			return 0;
+	}
+
+	return a->mode;
+}
 
 static struct attribute *max6650_attrs[] = {
 	&sensor_dev_attr_fan1_input.dev_attr.attr,
@@ -437,11 +525,17 @@ static struct attribute *max6650_attrs[]
 	&dev_attr_fan1_div.attr,
 	&dev_attr_pwm1_enable.attr,
 	&dev_attr_pwm1.attr,
+	&dev_attr_gpio2_alarm.attr,
+	&dev_attr_gpio1_alarm.attr,
+	&dev_attr_fan1_fault.attr,
+	&dev_attr_fan1_min_alarm.attr,
+	&dev_attr_fan1_max_alarm.attr,
 	NULL
 };
 
 static struct attribute_group max6650_attr_grp = {
 	.attrs = max6650_attrs,
+	.is_visible = max6650_attrs_visible,
 };
 
 /*
@@ -658,6 +752,14 @@ static struct max6650_data *max6650_upda
 		data->count = i2c_smbus_read_byte_data(client,
 							MAX6650_REG_COUNT);
 		data->dac = i2c_smbus_read_byte_data(client,
MAX6650_REG_DAC);
+		data->alarm_en = i2c_smbus_read_byte_data(client,
+
MAX6650_REG_ALARM_EN);
+
+		/* Alarms are cleared on read in case the condition that
+		 * caused the alarm is removed. Keep the value latched here
+		 * for providing the register through different alarm files.
*/
+		data->alarm |= i2c_smbus_read_byte_data(client,
+							MAX6650_REG_ALARM);
 
 		data->last_updated = jiffies;
 		data->valid = 1;


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
