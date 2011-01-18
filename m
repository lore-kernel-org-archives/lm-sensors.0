From: stigge@antcom.de
Date: Tue, 18 Jan 2011 14:41:51 +0000
Subject: [lm-sensors] [PATCH] Added driver for Maxim MAX6639
Message-Id: <1295361711-4638-1-git-send-email-stigge@antcom.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

2-Channel Temperature Monitor with Dual PWM Fan-Speed Controller

Signed-off-by: Roland Stigge <stigge@antcom.de>

diff --git a/Documentation/hwmon/max6639 b/Documentation/hwmon/max6639
new file mode 100644
index 0000000..2352e54
--- /dev/null
+++ b/Documentation/hwmon/max6639
@@ -0,0 +1,39 @@
+Kernel driver max6639
+==========+
+Supported chips:
+  * Maxim MAX6639
+    Prefix: 'max6639'
+    Addresses scanned: I2C 0x2c, 0x2e, 0x2f
+    Datasheet: http://pdfserv.maxim-ic.com/en/ds/MAX6639.pdf
+
+Authors:
+    He Changqing <hechangqing@semptian.com>
+    Roland Stigge <stigge@antcom.de>
+
+Description
+-----------
+
+This driver implements support for the Maxim MAX6639. This chip is a 2-channel
+temperature monitor with dual PWM fan speed controller. It can monitor its own
+temperature and one external diode-connected transistor or two external
+diode-connected transistors.
+
+The following device attributes are implemented via sysfs:
+
+Attribute       R/W  Contents
+----------------------------------------------------------------------------
+temp1_input     R    Temperature channel 1 input (0..150 C)
+temp2_input     R    Temperature channel 2 input (0..150 C)
+temp1_max       RW   Set THERM temperature for input 1 (in C, see datasheet)
+temp2_max       RW   Set THERM temperature for input 2 (in C, see datasheet)
+temp1_crit      RW   Set ALERM temperature for input 1 (in C, see datasheet)
+temp2_crit      RW   Set ALARM temperature for input 2 (in C, see datasheet)
+temp1_emergency RW   Set OT temperature for input 1 (in C, see datasheet)
+temp2_emergency RW   Set OT temperature for input 2 (in C, see datasheet)
+pwm1            RW   Fan 1 target duty cycle (0..255)
+pwm2            RW   Fan 2 target duty cycle (0..255)
+fan1_input      R    TACH1 fan tachometer input (in RPM)
+fan2_input      R    TACH2 fan tachometer input (in RPM)
+fan1_div        RW   Fan 1 divisor (adjust to fan: e.g. 4 pulses per cycle)
+fan2_div        RW   Fan 2 divisor (adjust to fan: e.g. 4 pulses per cycle)
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index a56f6ad..8eb116c 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -674,6 +674,16 @@ config SENSORS_MAX1619
 	  This driver can also be built as a module.  If so, the module
 	  will be called max1619.
 
+config SENSORS_MAX6639
+	tristate "Maxim MAX6639 sensor chip"
+	depends on I2C && EXPERIMENTAL
+	help
+	  If you say yes here you get support for the MAX6639
+	  sensor chips.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called max6639.
+
 config SENSORS_MAX6650
 	tristate "Maxim MAX6650 sensor chip"
 	depends on I2C && EXPERIMENTAL
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 2479b3d..a85fa3f 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_SENSORS_LTC4245)	+= ltc4245.o
 obj-$(CONFIG_SENSORS_LTC4261)	+= ltc4261.o
 obj-$(CONFIG_SENSORS_MAX1111)	+= max1111.o
 obj-$(CONFIG_SENSORS_MAX1619)	+= max1619.o
+obj-$(CONFIG_SENSORS_MAX6639)	+= max6639.o
 obj-$(CONFIG_SENSORS_MAX6650)	+= max6650.o
 obj-$(CONFIG_SENSORS_MC13783_ADC)+= mc13783-adc.o
 obj-$(CONFIG_SENSORS_PC87360)	+= pc87360.o
diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
new file mode 100644
index 0000000..266a3c0
--- /dev/null
+++ b/drivers/hwmon/max6639.c
@@ -0,0 +1,537 @@
+/*
+ * max6639.c - Support for Maxim MAX6639
+ *
+ * 2-Channel Temperature Monitor with Dual PWM Fan-Speed Controller
+ *
+ * Copyright (C) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
+ * and Philip Edelbrock <phil@netroedge.com>
+ * Copyright (C) 2010 He Changqing <hechangqing@semptian.com>
+ * Copyright (C) 2010, 2011 Roland Stigge <stigge@antcom.de>
+ *
+ * Ported to Linux 2.6 by Tiago Sousa <mirage@kaotik.org>
+ * Ported to Linux 2.6.37 by Roland Stigge <stigge@antcom.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/jiffies.h>
+#include <linux/i2c.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/err.h>
+#include <linux/mutex.h>
+
+/* Addresses to scan */
+static unsigned short normal_i2c[] = { 0x2c, 0x2e, 0x2f, I2C_CLIENT_END };
+
+/* The MAX6639 registers, valid channel numbers: 0, 1 */
+#define MAX6639_REG_
+#define MAX6639_REG_TEMP(ch)			(0x00 + ch)
+#define MAX6639_REG_STATUS			0x02
+#define MAX6639_REG_OUTPUT_MASK			0x03
+#define MAX6639_REG_GCONFIG			0x04
+#define MAX6639_REG_TEMP_EXT(ch)		(0x05 + ch)
+#define MAX6639_REG_ALERT_LIMIT(ch)             (0x08 + ch)
+#define MAX6639_REG_OT_LIMIT(ch)		(0x0A + ch)
+#define MAX6639_REG_THERM_LIMIT(ch)		(0x0C + ch)
+#define MAX6639_REG_FAN_CONFIG1(ch)		(0x10 + ch * 4)
+#define MAX6639_REG_FAN_CONFIG2a(ch)		(0x11 + ch * 4)
+#define MAX6639_REG_FAN_CONFIG2b(ch)		(0x12 + ch * 4)
+#define MAX6639_REG_FAN_CONFIG3(ch)		(0x13 + ch * 4)
+#define MAX6639_REG_FAN_CNT(ch)			(0x20 + ch)
+#define MAX6639_REG_TARGET_CNT(ch)		(0x22 + ch)
+#define MAX6639_REG_FAN_PPR(ch)			(0x24 + ch)
+#define MAX6639_REG_TARGTDUTY(ch)		(0x26 + ch)
+#define MAX6639_REG_FAN_START_TEMP(ch)		(0x28 + ch)
+#define MAX6639_REG_DEVID			0x3D
+#define MAX6639_REG_MANUID			0x3E
+#define MAX6639_REG_DEVREV			0x3F
+
+/* Register bits */
+#define MAX6639_GCONFIG_STANDBY			0x80
+#define MAX6639_GCONFIG_POR			0x40
+#define MAX6639_GCONFIG_DISABLE_TIMEOUT		0x20
+#define MAX6639_GCONFIG_CH2_LOCAL		0x10
+
+#define MAX6639_FAN_CONFIG1_PWM			0x80
+
+#define FAN_FROM_REG(val, div)	((val) = 0 ? -1 : \
+	(val) = 255 ? 0 : (4000 * 30) / ((div) * (val)))
+#define TEMP_LIMIT_TO_REG(val) \
+	SENSORS_LIMIT((val) < 0 ? \
+	((val) - 500) / 1000 : ((val) + 500) / 1000, 0, 255)
+
+/*
+ * Client data (each client gets its own)
+ */
+struct max6639_data {
+	struct device *hwmon_dev;
+	struct mutex update_lock;
+	char valid;		/* !=0 if following fields are valid */
+	unsigned long last_updated;	/* In jiffies */
+
+	u16 temp[2];		/* Temperature, in 1/8 C, 0..255 C */
+	u8 temp_therm[2];	/* THERM Temperature, 0..255 C (->_max) */
+	u8 temp_alert[2];	/* ALERT Temperature, 0..255 C (->_crit) */
+	u8 temp_ot[2];		/* OT Temperature, 0..255 C (->_emergency) */
+	u8 pwm[2];		/* Register value: Duty cycle 0..120 */
+	u8 fan[2];		/* Register value: TACH count for fans: >0 */
+	u8 fan_div[2];		/* Speed divisor: 1, 2, 4, ... */
+};
+
+static int max6639_read_value(struct i2c_client *client, u8 reg)
+{
+	return i2c_smbus_read_byte_data(client, reg);
+}
+
+static int max6639_write_value(struct i2c_client *client, u8 reg, u8 value)
+{
+	return i2c_smbus_write_byte_data(client, reg, value);
+}
+
+static struct max6639_data *max6639_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct max6639_data *data = i2c_get_clientdata(client);
+	int i;
+
+	mutex_lock(&data->update_lock);
+
+	if (time_after(jiffies, data->last_updated + 2 * HZ) || !data->valid) {
+		dev_dbg(&client->dev, "Starting max6639 update\n");
+
+		for (i = 0; i < 2; i++) {
+			data->fan[i] = max6639_read_value(client,
+						MAX6639_REG_FAN_CNT(i));
+			data->temp[i] = (max6639_read_value(client,
+					MAX6639_REG_TEMP_EXT(i)) >> 5)
+				| (max6639_read_value(client,
+					MAX6639_REG_TEMP(i)) << 3);
+			data->temp_therm[i] = max6639_read_value(client,
+						MAX6639_REG_THERM_LIMIT(i));
+			data->temp_alert[i] = max6639_read_value(client,
+						MAX6639_REG_ALERT_LIMIT(i));
+			data->temp_ot[i] = max6639_read_value(client,
+						MAX6639_REG_OT_LIMIT(i));
+			data->pwm[i] = max6639_read_value(client,
+						MAX6639_REG_TARGTDUTY(i));
+		}
+
+		data->last_updated = jiffies;
+		data->valid = 1;
+	}
+
+	mutex_unlock(&data->update_lock);
+
+	return data;
+}
+
+#define show_temp_input(suffix) \
+static ssize_t show_temp_input##suffix(struct device *dev, \
+		struct device_attribute *attr, char *buf) \
+{ \
+	long	temp;\
+	struct max6639_data *data = max6639_update_device(dev); \
+	temp = data->temp[suffix - 1] * 125;\
+	return sprintf(buf, "%ld\n", temp); \
+}
+show_temp_input(1);
+show_temp_input(2);
+
+#define show_temp_max(suffix) \
+static ssize_t show_temp_max##suffix(struct device *dev, \
+				  struct device_attribute *attr, char *buf) \
+{ \
+	struct max6639_data *data = max6639_update_device(dev); \
+	return sprintf(buf, "%d\n", (data->temp_therm[suffix - 1] * 1000)); \
+}
+show_temp_max(1);
+show_temp_max(2);
+
+#define set_temp_max(suffix) \
+static ssize_t set_temp_max##suffix(struct device *dev, \
+	struct device_attribute *attr, const char *buf, \
+	size_t count) \
+{ \
+	struct i2c_client *client = to_i2c_client(dev); \
+	struct max6639_data *data = i2c_get_clientdata(client); \
+	long val; \
+	int res; \
+\
+	res = strict_strtoul(buf, 10, &val); \
+	if (res) \
+		return res; \
+\
+	mutex_lock(&data->update_lock); \
+	data->temp_therm[suffix - 1] = TEMP_LIMIT_TO_REG(val); \
+	max6639_write_value(client, MAX6639_REG_THERM_LIMIT(suffix - 1), \
+			data->temp_therm[suffix - 1]); \
+	mutex_unlock(&data->update_lock); \
+	return count; \
+}
+set_temp_max(1);
+set_temp_max(2);
+
+#define show_temp_crit(suffix) \
+static ssize_t show_temp_crit##suffix(struct device *dev, \
+				  struct device_attribute *attr, char *buf) \
+{ \
+	struct max6639_data *data = max6639_update_device(dev); \
+	return sprintf(buf, "%d\n", (data->temp_alert[suffix - 1] * 1000)); \
+}
+show_temp_crit(1);
+show_temp_crit(2);
+
+#define set_temp_crit(suffix) \
+static ssize_t set_temp_crit##suffix(struct device *dev, \
+	struct device_attribute *attr, const char *buf, \
+	size_t count) \
+{ \
+	struct i2c_client *client = to_i2c_client(dev); \
+	struct max6639_data *data = i2c_get_clientdata(client); \
+	long val; \
+	int res; \
+\
+	res = strict_strtoul(buf, 10, &val); \
+	if (res) \
+		return res; \
+\
+	mutex_lock(&data->update_lock); \
+	data->temp_alert[suffix - 1] = TEMP_LIMIT_TO_REG(val); \
+	max6639_write_value(client, MAX6639_REG_THERM_LIMIT(suffix - 1), \
+			data->temp_alert[suffix - 1]); \
+	mutex_unlock(&data->update_lock); \
+	return count; \
+}
+set_temp_crit(1);
+set_temp_crit(2);
+
+#define show_temp_emergency(suffix) \
+static ssize_t show_temp_emergency##suffix(struct device *dev, \
+				  struct device_attribute *attr, char *buf) \
+{ \
+	struct max6639_data *data = max6639_update_device(dev); \
+	return sprintf(buf, "%d\n", (data->temp_ot[suffix - 1] * 1000)); \
+}
+show_temp_emergency(1);
+show_temp_emergency(2);
+
+#define set_temp_emergency(suffix) \
+static ssize_t set_temp_emergency##suffix(struct device *dev, \
+	struct device_attribute *attr, const char *buf, \
+	size_t count) \
+{ \
+	struct i2c_client *client = to_i2c_client(dev); \
+	struct max6639_data *data = i2c_get_clientdata(client); \
+	long val; \
+	int res; \
+\
+	res = strict_strtoul(buf, 10, &val); \
+	if (res) \
+		return res; \
+\
+	mutex_lock(&data->update_lock); \
+	data->temp_ot[suffix - 1] = TEMP_LIMIT_TO_REG(val); \
+	max6639_write_value(client, MAX6639_REG_THERM_LIMIT(suffix - 1), \
+			data->temp_ot[suffix - 1]); \
+	mutex_unlock(&data->update_lock); \
+	return count; \
+}
+set_temp_emergency(1);
+set_temp_emergency(2);
+
+#define show_pwm(suffix) \
+static ssize_t show_pwm##suffix(struct device *dev, \
+		struct device_attribute *attr, char *buf) \
+{ \
+	struct max6639_data *data = max6639_update_device(dev); \
+	return sprintf(buf, "%d\n", data->pwm[suffix - 1] * 255 / 120); \
+}
+show_pwm(1);
+show_pwm(2);
+
+#define set_pwm(suffix) \
+static ssize_t set_pwm##suffix(struct device *dev, \
+	struct device_attribute *attr, const char *buf, \
+	size_t count) \
+{ \
+	struct i2c_client *client = to_i2c_client(dev); \
+	struct max6639_data *data = i2c_get_clientdata(client); \
+	long val; \
+	int res; \
+\
+	res = strict_strtoul(buf, 10, &val); \
+	if (res) \
+		return res; \
+\
+	mutex_lock(&data->update_lock); \
+	data->pwm[suffix - 1] = (u8)(val * 120 / 255); \
+	max6639_write_value(client, MAX6639_REG_TARGTDUTY(suffix - 1), \
+			data->pwm[suffix - 1]); \
+	mutex_unlock(&data->update_lock); \
+	return count; \
+}
+set_pwm(1);
+set_pwm(2);
+
+#define show_fan_input(suffix) \
+static ssize_t show_fan_input##suffix(struct device *dev, \
+		struct device_attribute *attr, char *buf) \
+{ \
+	struct max6639_data *data = max6639_update_device(dev); \
+	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[suffix - 1], \
+				data->fan_div[suffix - 1])); \
+}
+show_fan_input(1);
+show_fan_input(2);
+
+#define show_fan_div(suffix) \
+static ssize_t show_fan_div##suffix(struct device *dev, \
+		struct device_attribute *attr, char *buf) \
+{ \
+	struct max6639_data *data = max6639_update_device(dev); \
+	return sprintf(buf, "%d\n", (int)(data->fan_div[suffix - 1])); \
+}
+show_fan_div(1);
+show_fan_div(2);
+
+#define set_fan_div(suffix) \
+static ssize_t set_fan_div##suffix(struct device *dev, \
+		struct device_attribute *attr, const char *buf, size_t count) \
+{ \
+	struct i2c_client *client = to_i2c_client(dev); \
+	struct max6639_data *data = i2c_get_clientdata(client); \
+	long val; \
+	int res; \
+\
+	res = strict_strtoul(buf, 10, &val); \
+	if (res) \
+		return res; \
+\
+	mutex_lock(&data->update_lock); \
+	data->fan_div[suffix - 1] = (u8) val; \
+	mutex_unlock(&data->update_lock); \
+	return count; \
+}
+set_fan_div(1);
+set_fan_div(2);
+
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input1, NULL, 6);
+static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp_input2, NULL, 7);
+static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max1,
+		set_temp_max1, 8);
+static SENSOR_DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_temp_max2,
+		set_temp_max2, 10);
+static SENSOR_DEVICE_ATTR(temp1_crit, S_IWUSR | S_IRUGO, show_temp_crit1,
+		set_temp_crit1, 8);
+static SENSOR_DEVICE_ATTR(temp2_crit, S_IWUSR | S_IRUGO, show_temp_crit2,
+		set_temp_crit2, 10);
+static SENSOR_DEVICE_ATTR(temp1_emergency, S_IWUSR | S_IRUGO,
+		show_temp_emergency1, set_temp_emergency1, 8);
+static SENSOR_DEVICE_ATTR(temp2_emergency, S_IWUSR | S_IRUGO,
+		show_temp_emergency2, set_temp_emergency2, 10);
+static SENSOR_DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, show_pwm1, set_pwm1, 2);
+static SENSOR_DEVICE_ATTR(pwm2, S_IWUSR | S_IRUGO, show_pwm2, set_pwm2, 3);
+static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, show_fan_input1, NULL, 4);
+static SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, show_fan_input2, NULL, 5);
+static SENSOR_DEVICE_ATTR(fan1_div, S_IWUSR | S_IRUGO, show_fan_div1,
+		set_fan_div1, 0);
+static SENSOR_DEVICE_ATTR(fan2_div, S_IWUSR | S_IRUGO, show_fan_div2,
+		set_fan_div2, 1);
+
+static struct attribute *max6639_attributes[] = {
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp2_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_max.dev_attr.attr,
+	&sensor_dev_attr_temp2_max.dev_attr.attr,
+	&sensor_dev_attr_temp1_crit.dev_attr.attr,
+	&sensor_dev_attr_temp2_crit.dev_attr.attr,
+	&sensor_dev_attr_temp1_emergency.dev_attr.attr,
+	&sensor_dev_attr_temp2_emergency.dev_attr.attr,
+	&sensor_dev_attr_pwm1.dev_attr.attr,
+	&sensor_dev_attr_pwm2.dev_attr.attr,
+	&sensor_dev_attr_fan1_input.dev_attr.attr,
+	&sensor_dev_attr_fan2_input.dev_attr.attr,
+	&sensor_dev_attr_fan1_div.dev_attr.attr,
+	&sensor_dev_attr_fan2_div.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group max6639_group = {
+	.attrs = max6639_attributes,
+};
+
+/* Called when we have found a new max6639. */
+static void max6639_init_client(struct i2c_client *client)
+{
+	int i;
+
+	/* Reset chip to default values */
+	max6639_write_value(client, MAX6639_REG_GCONFIG, MAX6639_GCONFIG_POR);
+
+	for (i = 0; i < 2; i++) {
+		/* Fans config 4000 RPM, PWM */
+		max6639_write_value(client, MAX6639_REG_FAN_CONFIG1(i),
+				MAX6639_FAN_CONFIG1_PWM | 0x01);
+		/* Fans pulse per revolution is 2 */
+		max6639_write_value(client, MAX6639_REG_FAN_PPR(i), 0x40);
+		/* Fans PWM polarity high */
+		max6639_write_value(client, MAX6639_REG_FAN_CONFIG2a(i), 0x02);
+		/* Max. temp. 80C */
+		max6639_write_value(client, MAX6639_REG_THERM_LIMIT(i), 80);
+		/* PWM 120/120 (i.e. 100%) */
+		max6639_write_value(client, MAX6639_REG_TARGTDUTY(i), 120);
+	}
+	/* Start monitoring */
+	max6639_write_value(client, MAX6639_REG_GCONFIG,
+		MAX6639_GCONFIG_DISABLE_TIMEOUT | MAX6639_GCONFIG_CH2_LOCAL);
+}
+
+/* Return 0 if detection is successful, -ENODEV otherwise */
+static int max6639_detect(struct i2c_client *client,
+			  struct i2c_board_info *info)
+{
+	struct i2c_adapter *adapter = client->adapter;
+	int dev_id, manu_id;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		return -ENODEV;
+
+	/* Actual detection via device and manufacturer ID */
+	dev_id = max6639_read_value(client, MAX6639_REG_DEVID);
+	manu_id = max6639_read_value(client, MAX6639_REG_MANUID);
+	if (dev_id != 0x58 || manu_id != 0x4D) {
+		printk(KERN_ERR "Bad DevId/ManuID: 0x%02x/0x%02x!\n", dev_id,
+		       manu_id);
+		return -ENODEV;
+	}
+
+	strlcpy(info->type, "max6639", I2C_NAME_SIZE);
+
+	return 0;
+}
+
+static int max6639_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct max6639_data *data;
+	int err;
+
+	data = kzalloc(sizeof(struct max6639_data), GFP_KERNEL);
+	if (!data) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	i2c_set_clientdata(client, data);
+	mutex_init(&data->update_lock);
+
+	/* Initialize the max6639 chip */
+	max6639_init_client(client);
+
+	data->fan_div[0] = 1;
+	data->fan_div[1] = 1;
+
+	/* Register sysfs hooks */
+	err = sysfs_create_group(&client->dev.kobj, &max6639_group);
+	if (err)
+		goto error_free;
+
+	data->hwmon_dev = hwmon_device_register(&client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
+		goto error_remove;
+	}
+	return 0;
+
+error_remove:
+	sysfs_remove_group(&client->dev.kobj, &max6639_group);
+error_free:
+	kfree(data);
+exit:
+	return err;
+}
+
+static int max6639_remove(struct i2c_client *client)
+{
+	struct max6639_data *data = i2c_get_clientdata(client);
+
+	hwmon_device_unregister(data->hwmon_dev);
+	sysfs_remove_group(&client->dev.kobj, &max6639_group);
+
+	kfree(data);
+	return 0;
+}
+
+static int max6639_suspend(struct i2c_client *client, pm_message_t mesg)
+{
+	int data = max6639_read_value(client, MAX6639_REG_GCONFIG);
+	if (data < 0)
+		return data;
+
+	return max6639_write_value(client,
+			MAX6639_REG_GCONFIG, data | MAX6639_GCONFIG_STANDBY);
+}
+
+static int max6639_resume(struct i2c_client *client)
+{
+	int data = max6639_read_value(client, MAX6639_REG_GCONFIG);
+	if (data < 0)
+		return data;
+
+	return max6639_write_value(client,
+			MAX6639_REG_GCONFIG, data & ~MAX6639_GCONFIG_STANDBY);
+}
+
+static const struct i2c_device_id max6639_id[] = {
+	{"max6639", 0},
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, max6639_id);
+
+static struct i2c_driver max6639_driver = {
+	.class = I2C_CLASS_HWMON,
+	.driver = {
+		   .name = "max6639",
+		   },
+	.probe = max6639_probe,
+	.remove = max6639_remove,
+	.suspend = max6639_suspend,
+	.resume = max6639_resume,
+	.id_table = max6639_id,
+	.detect = max6639_detect,
+	.address_list = normal_i2c,
+};
+
+static int __init sensors_max6639_init(void)
+{
+	return i2c_add_driver(&max6639_driver);
+}
+
+static void __exit sensors_max6639_exit(void)
+{
+	i2c_del_driver(&max6639_driver);
+}
+
+MODULE_AUTHOR("Roland Stigge <stigge@antcom.de>");
+MODULE_DESCRIPTION("max6639 driver");
+MODULE_LICENSE("GPL");
+
+module_init(sensors_max6639_init);
+module_exit(sensors_max6639_exit);

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
