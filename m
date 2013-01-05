From: Chris Verges <kg4ysn@gmail.com>
Date: Sat, 05 Jan 2013 09:41:20 +0000
Subject: [lm-sensors] [PATCH 2/2] lm73: added alarm support
Message-Id: <1357378880-3280-2-git-send-email-kg4ysn@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The LM73 supports a basic over-temperature indicator.  When the measured
temperature goes above the high temperature limit, temp1_max, the alarm
is triggered.  When it drops below the low temperature limit, temp1_min,
the alarm is ended.  Full details on usage are included in
Documentation/hwmon/lm73.

Signed-off-by: Chris Verges <kg4ysn@gmail.com>
---
 Documentation/hwmon/lm73           |   30 +++++++
 drivers/hwmon/lm73.c               |  153 +++++++++++++++++++++++++++++++++++-
 include/linux/platform_data/lm73.h |   38 +++++++++
 3 files changed, 220 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/platform_data/lm73.h

diff --git a/Documentation/hwmon/lm73 b/Documentation/hwmon/lm73
index 56150e1..6b4b0ec 100644
--- a/Documentation/hwmon/lm73
+++ b/Documentation/hwmon/lm73
@@ -76,3 +76,33 @@ via the following function:
 
 where 'x' is the output from 'update_interval' and 'g(x)' is the
 resolution in degrees C per LSB.
+
+Alarm Support
+-------------
+
+The LM73 features a simple over-temperature alarm mechanism.  This
+feature is exposed via the sysfs attributes and (optionally) via
+platform device interrupt handling hooks.
+
+The primary attribute is 'temp1_alarm.'  When the measured temperature
+exceeds the value stored in 'temp1_max', the alarm triggers.  When the
+measured temperature drops below the value stored in 'temp1_min', the
+alarm is cleared.  The alarm can also be cleared by writing a '0' to the
+'temp1_alarm' attribute.
+
+The attributes 'temp1_max_alarm' and 'temp1_min_alarm' are flags
+provided by the LM73 that indicate whether the measured temperature has
+passed the 'temp1_max' and 'temp1_min' thresholds, respectively.  These
+values _must_ be read to clear the registers on the LM73.
+
+If the lm73 driver is provided a struct lm73_platform_data during
+initialization, interrupt handling is enabled.  The platform must define
+the IRQ number and IRQ flags at a minimum, and can optionally also
+define a callback function to supplement the IRQ handler provided by the
+lm73 driver.  This internal IRQ handler enables use of epoll() on the
+'temp1_alarm' attribute via the sysfs_notify() method.
+
+Finally, the LM73 can set the polarity of the ALERT interrupt to either
+active-high or active-low (default).  If the platform desired the
+polarity to be switched to active-high, it can declare this in the
+struct lm73_platform_data used during initialization.
diff --git a/drivers/hwmon/lm73.c b/drivers/hwmon/lm73.c
index cb3e17a..2c17e25 100644
--- a/drivers/hwmon/lm73.c
+++ b/drivers/hwmon/lm73.c
@@ -20,7 +20,8 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
-
+#include <linux/interrupt.h>
+#include <linux/platform_data/lm73.h>
 
 /* Addresses scanned */
 static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4c,
@@ -44,6 +45,24 @@ static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4c,
 #define LM73_CTRL_RES_MASK \
 	(((1 << LM73_CTRL_RES_SIZE) - 1) << LM73_CTRL_RES_SHIFT)
 
+#define LM73_CTRL_ALERT_SHIFT	3
+#define LM73_CTRL_ALERT_SIZE	1
+#define LM73_CTRL_ALERT_MASK \
+	(((1 << LM73_CTRL_ALERT_SIZE) - 1) << LM73_CTRL_ALERT_SHIFT)
+
+#define LM73_CTRL_HI_SHIFT	2
+#define LM73_CTRL_LO_SHIFT	1
+
+#define LM73_CONF_POL_SHIFT	4
+#define LM73_CONF_POL_SIZE	1
+#define LM73_CONF_POL_MASK \
+	(((1 << LM73_CONF_POL_SIZE) - 1) << LM73_CONF_POL_SHIFT)
+
+#define LM73_CONF_RESET_SHIFT	3
+#define LM73_CONF_RESET_SIZE	1
+#define LM73_CONF_RESET_MASK \
+	(((1 << LM73_CONF_RESET_SIZE) - 1) << LM73_CONF_RESET_SHIFT)
+
 static const unsigned short lm73_convrates[] = {
 	14,	/* 11-bits (0.25000 C/LSB): RES1 Bit = 0, RES0 Bit = 0 */
 	28,	/* 12-bits (0.12500 C/LSB): RES1 Bit = 0, RES0 Bit = 1 */
@@ -73,6 +92,16 @@ static inline s32 lm73_write(struct i2c_client *client, u8 reg,
 	return i2c_smbus_write_byte_data(client, reg, value);
 }
 
+static inline s32 lm73_write_conf(struct i2c_client *client, u8 clear,
+				  u8 enable)
+{
+	/* always clear bits 1:0 and set bit 6 */
+	enable &= ~(3 << 0);
+	return lm73_write(client, LM73_REG_CONF,
+			  clear  | (3 << 0),
+			  enable | (1 << 6));
+}
+
 static inline s32 lm73_write_ctrl(struct i2c_client *client, u8 clear,
 				  u8 enable)
 {
@@ -171,6 +200,75 @@ static ssize_t show_convrate(struct device *dev, struct device_attribute *da,
 			lm73_convrates[res_bits]);
 }
 
+static ssize_t reset_alarm(struct device *dev, struct device_attribute *da,
+			   const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	unsigned long input;
+	s32 err;
+
+	err = kstrtoul(buf, 10, &input);
+	if (err < 0)
+		return err;
+
+	/* ignore everything but a reset request */
+	if (input)
+		return -EINVAL;
+
+	err = lm73_write_conf(client, 0, LM73_CONF_RESET_MASK);
+	if (err < 0)
+		return err;
+	return count;
+}
+
+static ssize_t show_alarm(struct device *dev, struct device_attribute *da,
+			  char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	s32 ctrl;
+	s32 conf;
+
+	ctrl = lm73_read(client, LM73_REG_CTRL);
+	if (ctrl < 0)
+		return ctrl;
+
+	conf = lm73_read(client, LM73_REG_CONF);
+	if (conf < 0)
+		return conf;
+
+	/* strip out just the ALERT bit */
+	ctrl &= LM73_CTRL_ALERT_MASK;
+	ctrl >>= LM73_CTRL_ALERT_SHIFT;
+
+	/*
+	 * If ALERT's polarity is active-low, the bit needs to be
+	 * flipped to match the semantics of the 'alarm' attribute.
+	 */
+	if (!(conf & LM73_CONF_POL_MASK))
+		ctrl = !ctrl;
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", ctrl);
+}
+
+static ssize_t show_maxmin_alarm(struct device *dev,
+				 struct device_attribute *da,
+				 char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	s32 ctrl;
+
+	ctrl = lm73_read(client, LM73_REG_CTRL);
+	if (ctrl < 0)
+		return ctrl;
+
+	/* strip out just the temperature hi/lo flag */
+	ctrl >>= attr->index;
+	ctrl &= 0x1;
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", ctrl);
+}
+
 /*-----------------------------------------------------------------------*/
 
 /* sysfs attributes for hwmon */
@@ -183,12 +281,21 @@ static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO,
 			show_temp, NULL, LM73_REG_INPUT);
 static SENSOR_DEVICE_ATTR(update_interval, S_IWUSR | S_IRUGO,
 			show_convrate, set_convrate, 0);
+static SENSOR_DEVICE_ATTR(temp1_alarm, S_IWUSR | S_IRUGO,
+			show_alarm, reset_alarm, 0);
+static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO,
+			show_maxmin_alarm, NULL, LM73_CTRL_HI_SHIFT);
+static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO,
+			show_maxmin_alarm, NULL, LM73_CTRL_LO_SHIFT);
 
 static struct attribute *lm73_attributes[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	&sensor_dev_attr_temp1_max.dev_attr.attr,
 	&sensor_dev_attr_temp1_min.dev_attr.attr,
 	&sensor_dev_attr_update_interval.dev_attr.attr,
+	&sensor_dev_attr_temp1_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp1_min_alarm.dev_attr.attr,
 	NULL
 };
 
@@ -198,11 +305,25 @@ static const struct attribute_group lm73_group = {
 
 /*-----------------------------------------------------------------------*/
 
+static irqreturn_t lm73_alarm_irq(int irq, void *arg)
+{
+	struct i2c_client *client = arg;
+	struct lm73_platform_data *data = client->dev.platform_data;
+
+	sysfs_notify(&client->dev.kobj, NULL, "temp1_alarm");
+	if (data && data->handler)
+		return data->handler(irq, arg);
+	return IRQ_HANDLED;
+}
+
+/*-----------------------------------------------------------------------*/
+
 /* device probe and removal */
 
 static int
 lm73_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
+	struct lm73_platform_data *data = client->dev.platform_data;
 	struct device *hwmon_dev;
 	int status;
 
@@ -218,6 +339,32 @@ lm73_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	}
 	i2c_set_clientdata(client, hwmon_dev);
 
+	if (data && data->alert_polarity_high) {
+		status = lm73_write_conf(client, 0, LM73_CONF_POL_MASK);
+		if (status < 0) {
+			dev_err(&client->dev,
+				"%s: unable to set ALERT polarity\n",
+				dev_name(hwmon_dev));
+			status = -EIO;
+			goto exit_remove;
+		}
+	}
+
+	if (data && data->use_irq) {
+		status = devm_request_irq(&client->dev,
+					  data->irq,
+					  lm73_alarm_irq,
+					  data->irqflags,
+					  dev_name(hwmon_dev),
+					  client);
+		if (status < 0) {
+			dev_err(&client->dev,
+				"%s: unable to assign IRQ %d\n",
+				dev_name(hwmon_dev), data->irq);
+			goto exit_remove;
+		}
+	}
+
 	dev_info(&client->dev, "%s: sensor '%s'\n",
 		 dev_name(hwmon_dev), client->name);
 
@@ -231,7 +378,11 @@ exit_remove:
 static int lm73_remove(struct i2c_client *client)
 {
 	struct device *hwmon_dev = i2c_get_clientdata(client);
+	struct lm73_platform_data *data = client->dev.platform_data;
 
+	if (data && data->use_irq)
+		devm_free_irq(&client->dev, data->use_irq,
+			      data->handler);
 	hwmon_device_unregister(hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &lm73_group);
 	return 0;
diff --git a/include/linux/platform_data/lm73.h b/include/linux/platform_data/lm73.h
new file mode 100644
index 0000000..671f672
--- /dev/null
+++ b/include/linux/platform_data/lm73.h
@@ -0,0 +1,38 @@
+/*
+ * LM73 Sensor driver
+ * Based on LM75
+ *
+ * Copyright (C) 2007, CenoSYS (www.cenosys.com).
+ * Copyright (C) 2009, Bollore telecom (www.bolloretelecom.eu).
+ *
+ * Guillaume Ligneul <guillaume.ligneul@gmail.com>
+ * Adrien Demarez <adrien.demarez@bolloretelecom.eu>
+ * Jeremy Laine <jeremy.laine@bolloretelecom.eu>
+ *
+ * This software program is licensed subject to the GNU General Public License
+ * (GPL).Version 2,June 1991, available at
+ * http://www.gnu.org/licenses/old-licenses/gpl-2.0.html
+ */
+#ifndef _LINUX_LM73_H
+#define _LINUX_LM73_H
+
+/**
+ * struct lm73_platform_data - static configuration settings for the
+ * LM73 temperature sensor.
+ *
+ * @alert_polarity_high:  1 if ALERT is active-high, 0 if active-low
+ * @use_irq:              1 if ALERT is wired to an active interrupt pin
+ * @irq:                  the interrupt to use
+ * @irqflags:             the interrupt flags (see IRQF_*)
+ * @handler:              the platform handler function
+ */
+struct lm73_platform_data {
+	int alert_polarity_high;
+
+	int use_irq;
+	unsigned int irq;
+	unsigned long irqflags;
+	irq_handler_t handler;
+};
+
+#endif /* _LINUX_LM73_H */
-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
