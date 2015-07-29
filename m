From: Il Han <corone.il.han@gmail.com>
Date: Wed, 29 Jul 2015 18:49:43 +0000
Subject: [lm-sensors] [PATCH] hwmon: Driver for Maxim MAX31790
Message-Id: <1438195783-26978-1-git-send-email-corone.il.han@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The driver supports the Maxim MAX31790.

Signed-off-by: Il Han <corone.il.han@gmail.com>
---
 drivers/hwmon/Kconfig    |   9 +
 drivers/hwmon/Makefile   |   1 +
 drivers/hwmon/max31790.c | 806 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 816 insertions(+)
 create mode 100644 drivers/hwmon/max31790.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 7c65b73..fcd1c93 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -840,6 +840,15 @@ config SENSORS_MAX6697
 	  This driver can also be built as a module.  If so, the module
 	  will be called max6697.
 
+config SENSORS_MAX31790
+	tristate "Maxim MAX31790 sensor chip"
+	depends on I2C
+	help
+	  If you say yes here you get support for the MAX31790 sensor chips.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called max31790.
+
 config SENSORS_HTU21
 	tristate "Measurement Specialties HTU21D humidity/temperature sensors"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 9e0f3dd..01855ee 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -115,6 +115,7 @@ obj-$(CONFIG_SENSORS_MAX6639)	+= max6639.o
 obj-$(CONFIG_SENSORS_MAX6642)	+= max6642.o
 obj-$(CONFIG_SENSORS_MAX6650)	+= max6650.o
 obj-$(CONFIG_SENSORS_MAX6697)	+= max6697.o
+obj-$(CONFIG_SENSORS_MAX31790)	+= max31790.o
 obj-$(CONFIG_SENSORS_MC13783_ADC)+= mc13783-adc.o
 obj-$(CONFIG_SENSORS_MCP3021)	+= mcp3021.o
 obj-$(CONFIG_SENSORS_MENF21BMC_HWMON) += menf21bmc_hwmon.o
diff --git a/drivers/hwmon/max31790.c b/drivers/hwmon/max31790.c
new file mode 100644
index 0000000..8c4ff08
--- /dev/null
+++ b/drivers/hwmon/max31790.c
@@ -0,0 +1,806 @@
+/*
+ * max31790.c - Part of lm_sensors, Linux kernel modules for hardware
+ *             monitoring.
+ *
+ * (C) 2015 by Il Han <corone.il.han@gmail.com>
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
+
+enum chips { max31790 };
+
+/* MAX31790 registers */
+#define MAX31790_REG_GLOBAL_CONFIG	0x00
+#define MAX31790_REG_PWM_FREQ		0x01
+#define MAX31790_REG_FAN_CONFIG(ch)	(0x02 + (ch))
+#define MAX31790_REG_FAN_DYNAMICS(ch)	(0x08 + (ch))
+#define MAX31790_REG_FAN_FAULT_STATUS2	0x10
+#define MAX31790_REG_FAN_FAULT_STATUS1	0x11
+#define MAX31790_REG_FAN_FAULT_MASK2	0x12
+#define MAX31790_REG_FAN_FAULT_MASK1	0x13
+#define MAX31790_REG_TACH_COUNT(ch)	(0x18 + (ch) * 2)
+#define MAX31790_REG_PWM_DUTY_CYCLE(ch)	(0x30 + (ch) * 2)
+#define MAX31790_REG_PWMOUT(ch)		(0x40 + (ch) * 2)
+#define MAX31790_REG_TARGET_COUNT(ch)	(0x50 + (ch) * 2)
+#define MAX31790_REG_WINDOW(ch)		(0x60 + (ch))
+
+/* Global Config register bits */
+#define MAX31790_GL_CFG_STANDBY		0x80
+#define MAX31790_GL_CFG_RESET		0x40
+#define MAX31790_GL_CFG_BUS_TIMEOUT	0x20
+#define MAX31790_GL_CFG_OSC		0x08
+#define MAX31790_GL_CFG_WD_SHIFT	1
+#define MAX31790_GL_CFG_WD_MASK		0x06
+#define MAX31790_GL_CFG_WD_DISABLE	0x00
+#define MAX31790_GL_CFG_WD_5S		0x02
+#define MAX31790_GL_CFG_WD_10S		0x04
+#define MAX31790_GL_CFG_WD_30S		0x06
+#define MAX31790_GL_CFG_WD_STATUS	0x01
+
+/* Fan Config register bits */
+#define MAX31790_FAN_CFG_MODE_MASK	0x80
+#define MAX31790_FAN_CFG_PWM_MODE	0x00
+#define MAX31790_FAN_CFG_RPM_MODE	0x80
+#define MAX31790_FAN_CFG_MONITOR_ONLY	0x10
+#define MAX31790_FAN_CFG_TACH_INPUT_EN	0x08
+#define MAX31790_FAN_CFG_LOCKED_ROTOR	0x04
+#define MAX31790_FAN_CFG_TACH_INPUT	0x01
+
+/* Fan Dynamics register bits */
+#define MAX31790_FAN_DYNAMICS_SR(reg)	(((reg) >> 5) & 0x7)
+
+/* number of tachometer pulses per revolution */
+#define MAX31790_TACHOMETER_PULSE	2
+
+#define NR_CHANNEL			6
+
+#define FAN_RPM_MIN			480
+#define FAN_RPM_MAX			30000
+
+/*
+ * Client data (each client gets its own)
+ */
+struct max31790_data {
+	struct i2c_client *client;
+	struct mutex update_lock;
+	char valid; /* zero until following fields are valid */
+	unsigned long last_updated; /* in jiffies */
+
+	/* register values */
+	u8 global_config;
+	u8 fan_config[NR_CHANNEL];
+	u8 fan_dynamics[NR_CHANNEL];
+	u8 fault_status2;
+	u8 fault_status1;
+	u8 fault_mask2;
+	u8 fault_mask1;
+	u16 tach[NR_CHANNEL];
+	u16 pwm[NR_CHANNEL];
+	u16 target_count[NR_CHANNEL];
+};
+
+static struct max31790_data *max31790_update_device(struct device *dev)
+{
+	struct max31790_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
+	int i;
+
+	mutex_lock(&data->update_lock);
+
+	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
+		data->global_config = i2c_smbus_read_byte_data(client,
+				MAX31790_REG_GLOBAL_CONFIG);
+		data->fault_status1 = i2c_smbus_read_byte_data(client,
+				MAX31790_REG_FAN_FAULT_STATUS1);
+		data->fault_mask1 = i2c_smbus_read_byte_data(client,
+				MAX31790_REG_FAN_FAULT_MASK1);
+		for (i = 0; i < NR_CHANNEL; i++) {
+			data->fan_config[i] = i2c_smbus_read_byte_data(client,
+					MAX31790_REG_FAN_CONFIG(i));
+			data->fan_dynamics[i] = i2c_smbus_read_byte_data(client,
+					MAX31790_REG_FAN_DYNAMICS(i));
+			data->tach[i] = swab16(i2c_smbus_read_word_data(client,
+					MAX31790_REG_TACH_COUNT(i)));
+			data->pwm[i] = swab16(i2c_smbus_read_word_data(client,
+					MAX31790_REG_PWMOUT(i)));
+			data->target_count[i] +					swab16(i2c_smbus_read_word_data(client,
+					MAX31790_REG_TARGET_COUNT(i)));
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
+int get_speed_range(unsigned char fan_dynamics)
+{
+	int sr;
+
+	switch (MAX31790_FAN_DYNAMICS_SR(fan_dynamics)) {
+	case 0x0:
+		sr = 1;
+		break;
+	case 0x1:
+		sr = 2;
+		break;
+	case 0x2:
+		sr = 4;
+		break;
+	case 0x3:
+		sr = 8;
+		break;
+	case 0x4:
+		sr = 16;
+		break;
+	case 0x5:
+	case 0x6:
+	case 0x7:
+		sr = 32;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return sr;
+}
+
+static ssize_t get_fan(struct device *dev,
+		struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct max31790_data *data = max31790_update_device(dev);
+	int np = MAX31790_TACHOMETER_PULSE;
+	int sr = get_speed_range(data->fan_dynamics[attr->index]);
+	int rpm;
+
+	rpm = (60 * sr * 8192) / (np * (data->tach[attr->index] >> 5));
+	return sprintf(buf, "%d\n", rpm);
+}
+
+static ssize_t get_fan_target(struct device *dev,
+		struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct max31790_data *data = max31790_update_device(dev);
+	int np = MAX31790_TACHOMETER_PULSE;
+	int sr = get_speed_range(data->fan_dynamics[attr->index]);
+	int rpm;
+
+	rpm = (60 * sr * 8192) / (np * (data->target_count[attr->index] >> 5));
+
+	return sprintf(buf, "%d\n", rpm);
+}
+
+static ssize_t set_fan_target(struct device *dev,
+		struct device_attribute *devattr, const char *buf, size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct max31790_data *data = i2c_get_clientdata(client);
+	int np = MAX31790_TACHOMETER_PULSE;
+	int sr;
+	unsigned long rpm;
+	int target_count;
+	int err;
+
+	err = kstrtoul(buf, 10, &rpm);
+	if (err)
+		return err;
+
+	mutex_lock(&data->update_lock);
+
+	rpm = clamp_val(rpm, FAN_RPM_MIN, FAN_RPM_MAX);
+	sr = get_speed_range(data->fan_dynamics[attr->index]);
+	target_count = (60 * sr * 8192) / (np * rpm);
+	target_count = clamp_val(target_count, 0x0, 0x7FF);
+
+	data->target_count[attr->index] = (u16)target_count << 5;
+
+	i2c_smbus_write_word_data(client,
+			MAX31790_REG_TARGET_COUNT(attr->index),
+			swab16(data->target_count[attr->index]));
+
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static ssize_t get_pwm(struct device *dev,
+		struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct max31790_data *data = max31790_update_device(dev);
+	int pwm;
+
+	pwm = data->pwm[attr->index] >> 7;
+
+	return sprintf(buf, "%d\n", pwm);
+}
+
+static ssize_t set_pwm(struct device *dev,
+		struct device_attribute *devattr, const char *buf, size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct max31790_data *data = i2c_get_clientdata(client);
+	unsigned long pwm;
+	int err;
+
+	err = kstrtoul(buf, 10, &pwm);
+	if (err)
+		return err;
+
+	pwm = clamp_val(pwm, 0x0, 0x1FF);
+
+	mutex_lock(&data->update_lock);
+	data->pwm[attr->index] = (u16)pwm << 7;
+	i2c_smbus_write_word_data(client,
+			MAX31790_REG_PWMOUT(attr->index),
+			swab16(data->pwm[attr->index]));
+
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static ssize_t get_reset(struct device *dev,
+		struct device_attribute *devattr, char *buf)
+{
+	struct max31790_data *data = max31790_update_device(dev);
+	int reset;
+
+	if (data->global_config & MAX31790_GL_CFG_RESET)
+		reset = 1;
+	else
+		reset = 0;
+
+	return sprintf(buf, "%d\n", reset);
+}
+
+static ssize_t set_reset(struct device *dev,
+		struct device_attribute *devattr, const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct max31790_data *data = i2c_get_clientdata(client);
+	unsigned long reset;
+	int err;
+
+	err = kstrtoul(buf, 10, &reset);
+	if (err)
+		return err;
+
+	mutex_lock(&data->update_lock);
+
+	if (reset)
+		data->global_config |= MAX31790_GL_CFG_RESET;
+	else
+		data->global_config &= ~MAX31790_GL_CFG_RESET;
+
+	i2c_smbus_write_byte_data(client,
+			MAX31790_REG_GLOBAL_CONFIG, data->global_config);
+
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static ssize_t get_standby(struct device *dev,
+		struct device_attribute *devattr, char *buf)
+{
+	struct max31790_data *data = max31790_update_device(dev);
+	int standby;
+
+	if (data->global_config & MAX31790_GL_CFG_STANDBY)
+		standby = 1;
+	else
+		standby = 0;
+
+	return sprintf(buf, "%d\n", standby);
+}
+
+static ssize_t set_standby(struct device *dev,
+		struct device_attribute *devattr, const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct max31790_data *data = i2c_get_clientdata(client);
+	unsigned long standby;
+	int err;
+
+	err = kstrtoul(buf, 10, &standby);
+	if (err)
+		return err;
+
+	mutex_lock(&data->update_lock);
+
+	if (standby)
+		data->global_config |= MAX31790_GL_CFG_STANDBY;
+	else
+		data->global_config &= ~MAX31790_GL_CFG_STANDBY;
+
+	i2c_smbus_write_byte_data(client,
+			MAX31790_REG_GLOBAL_CONFIG, data->global_config);
+
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static ssize_t get_bus_timeout(struct device *dev,
+		struct device_attribute *devattr, char *buf)
+{
+	struct max31790_data *data = max31790_update_device(dev);
+	int bus_timeout;
+
+	if (data->global_config & MAX31790_GL_CFG_BUS_TIMEOUT)
+		bus_timeout = 0;
+	else
+		bus_timeout = 1;
+
+	return sprintf(buf, "%d\n", bus_timeout);
+}
+
+static ssize_t set_bus_timeout(struct device *dev,
+		struct device_attribute *devattr, const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct max31790_data *data = i2c_get_clientdata(client);
+	unsigned long bus_timeout;
+	int err;
+
+	err = kstrtoul(buf, 10, &bus_timeout);
+	if (err)
+		return err;
+
+	mutex_lock(&data->update_lock);
+
+	if (bus_timeout)
+		data->global_config &= ~MAX31790_GL_CFG_BUS_TIMEOUT;
+	else
+		data->global_config |= MAX31790_GL_CFG_BUS_TIMEOUT;
+
+	i2c_smbus_write_byte_data(client,
+			MAX31790_REG_GLOBAL_CONFIG, data->global_config);
+
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static ssize_t get_watchdog(struct device *dev,
+		struct device_attribute *devattr, char *buf)
+{
+	struct max31790_data *data = max31790_update_device(dev);
+	int watchdog;
+
+	watchdog = (data->global_config & MAX31790_GL_CFG_WD_MASK)
+		>> MAX31790_GL_CFG_WD_SHIFT;
+
+	return sprintf(buf, "%d\n", watchdog);
+}
+
+static ssize_t set_watchdog(struct device *dev,
+		struct device_attribute *devattr, const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct max31790_data *data = i2c_get_clientdata(client);
+	unsigned long watchdog;
+	int err;
+
+	err = kstrtoul(buf, 10, &watchdog);
+	if (err)
+		return err;
+
+	mutex_lock(&data->update_lock);
+
+	if (watchdog < 0x0 || watchdog > 0x3)
+		return -EINVAL;
+
+	data->global_config +		((data->global_config & ~MAX31790_GL_CFG_WD_MASK)
+		 | ((watchdog << MAX31790_GL_CFG_WD_SHIFT)
+			 & MAX31790_GL_CFG_WD_MASK));
+
+	i2c_smbus_write_byte_data(client,
+			MAX31790_REG_GLOBAL_CONFIG, data->global_config);
+
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static ssize_t get_fan_mode(struct device *dev,
+		struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct max31790_data *data = max31790_update_device(dev);
+	int mode;
+
+	if (data->fan_config[attr->index] & MAX31790_FAN_CFG_RPM_MODE)
+		mode = 1;
+	else
+		mode = 0;
+
+	return sprintf(buf, "%d\n", mode);
+}
+
+static ssize_t set_fan_mode(struct device *dev,
+		struct device_attribute *devattr, const char *buf, size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct max31790_data *data = i2c_get_clientdata(client);
+	unsigned long mode;
+	int err;
+
+	err = kstrtoul(buf, 10, &mode);
+	if (err)
+		return err;
+
+	mutex_lock(&data->update_lock);
+
+	if (mode)
+		data->fan_config[attr->index] +			(data->fan_config[attr->index]
+			 & ~MAX31790_FAN_CFG_MODE_MASK)
+			| MAX31790_FAN_CFG_RPM_MODE;
+	else
+		data->fan_config[attr->index] +			(data->fan_config[attr->index]
+			 & ~MAX31790_FAN_CFG_MODE_MASK)
+			| MAX31790_FAN_CFG_PWM_MODE;
+
+	i2c_smbus_write_byte_data(client,
+			MAX31790_REG_FAN_CONFIG(attr->index),
+			data->fan_config[attr->index]);
+
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static ssize_t get_tach_enable(struct device *dev,
+		struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct max31790_data *data = max31790_update_device(dev);
+	int tach_enable;
+
+	if (data->fan_config[attr->index] & MAX31790_FAN_CFG_TACH_INPUT_EN)
+		tach_enable = 1;
+	else
+		tach_enable = 0;
+
+	return sprintf(buf, "%d\n", tach_enable);
+}
+
+static ssize_t set_tach_enable(struct device *dev,
+		struct device_attribute *devattr, const char *buf, size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct max31790_data *data = i2c_get_clientdata(client);
+	unsigned long tach_enable;
+	int err;
+
+	err = kstrtoul(buf, 10, &tach_enable);
+	if (err)
+		return err;
+
+	mutex_lock(&data->update_lock);
+
+	if (tach_enable)
+		data->fan_config[attr->index]
+			|= MAX31790_FAN_CFG_TACH_INPUT_EN;
+	else
+		data->fan_config[attr->index]
+			&= ~MAX31790_FAN_CFG_TACH_INPUT_EN;
+
+	i2c_smbus_write_byte_data(client,
+			MAX31790_REG_FAN_CONFIG(attr->index),
+			data->fan_config[attr->index]);
+
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static ssize_t get_fan_fault(struct device *dev,
+		struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct max31790_data *data = max31790_update_device(dev);
+	int fault;
+
+	if (data->fault_status1 & (1 << attr->index))
+		fault = 1;
+	else
+		fault = 0;
+
+	return sprintf(buf, "%d\n", fault);
+}
+
+static ssize_t set_fan_fault(struct device *dev,
+		struct device_attribute *devattr, const char *buf, size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct max31790_data *data = i2c_get_clientdata(client);
+	unsigned long fault;
+	int err;
+
+	err = kstrtoul(buf, 10, &fault);
+	if (err)
+		return err;
+
+	mutex_lock(&data->update_lock);
+
+	if (fault)
+		data->fault_status1 +			(data->fault_status1 | (1 << attr->index));
+	else
+		data->fault_status1 +			(data->fault_status1 & ~(1 << attr->index));
+
+	i2c_smbus_write_byte_data(client,
+			MAX31790_REG_FAN_FAULT_STATUS1, data->fault_status1);
+
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static ssize_t get_fan_mask(struct device *dev,
+		struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct max31790_data *data = max31790_update_device(dev);
+	int mask;
+
+	if (data->fault_mask1 & (1 << attr->index))
+		mask = 1;
+	else
+		mask = 0;
+
+	return sprintf(buf, "%d\n", mask);
+}
+
+static ssize_t set_fan_mask(struct device *dev,
+		struct device_attribute *devattr, const char *buf, size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct max31790_data *data = i2c_get_clientdata(client);
+	unsigned long mask;
+	int err;
+
+	err = kstrtoul(buf, 10, &mask);
+	if (err)
+		return err;
+
+	mutex_lock(&data->update_lock);
+
+	if (mask)
+		data->fault_mask1 +			(data->fault_mask1 | (1 << attr->index));
+	else
+		data->fault_mask1 +			(data->fault_mask1 & ~(1 << attr->index));
+
+	i2c_smbus_write_byte_data(client,
+			MAX31790_REG_FAN_FAULT_MASK1, data->fault_mask1);
+
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, get_fan, NULL, 0);
+static SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, get_fan, NULL, 1);
+static SENSOR_DEVICE_ATTR(fan3_input, S_IRUGO, get_fan, NULL, 2);
+static SENSOR_DEVICE_ATTR(fan4_input, S_IRUGO, get_fan, NULL, 3);
+static SENSOR_DEVICE_ATTR(fan5_input, S_IRUGO, get_fan, NULL, 4);
+static SENSOR_DEVICE_ATTR(fan6_input, S_IRUGO, get_fan, NULL, 5);
+
+static SENSOR_DEVICE_ATTR(fan1_target, S_IWUSR | S_IRUGO,
+		get_fan_target, set_fan_target, 0);
+static SENSOR_DEVICE_ATTR(fan2_target, S_IWUSR | S_IRUGO,
+		get_fan_target, set_fan_target, 1);
+static SENSOR_DEVICE_ATTR(fan3_target, S_IWUSR | S_IRUGO,
+		get_fan_target, set_fan_target, 2);
+static SENSOR_DEVICE_ATTR(fan4_target, S_IWUSR | S_IRUGO,
+		get_fan_target, set_fan_target, 3);
+static SENSOR_DEVICE_ATTR(fan5_target, S_IWUSR | S_IRUGO,
+		get_fan_target, set_fan_target, 4);
+static SENSOR_DEVICE_ATTR(fan6_target, S_IWUSR | S_IRUGO,
+		get_fan_target, set_fan_target, 5);
+
+static SENSOR_DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, get_pwm, set_pwm, 0);
+static SENSOR_DEVICE_ATTR(pwm2, S_IWUSR | S_IRUGO, get_pwm, set_pwm, 1);
+static SENSOR_DEVICE_ATTR(pwm3, S_IWUSR | S_IRUGO, get_pwm, set_pwm, 2);
+static SENSOR_DEVICE_ATTR(pwm4, S_IWUSR | S_IRUGO, get_pwm, set_pwm, 3);
+static SENSOR_DEVICE_ATTR(pwm5, S_IWUSR | S_IRUGO, get_pwm, set_pwm, 4);
+static SENSOR_DEVICE_ATTR(pwm6, S_IWUSR | S_IRUGO, get_pwm, set_pwm, 5);
+
+static DEVICE_ATTR(reset, S_IWUSR | S_IRUGO, get_reset, set_reset);
+static DEVICE_ATTR(standby, S_IWUSR | S_IRUGO, get_standby, set_standby);
+static DEVICE_ATTR(bus_timeout, S_IWUSR | S_IRUGO,
+		get_bus_timeout, set_bus_timeout);
+static DEVICE_ATTR(watchdog, S_IWUSR | S_IRUGO, get_watchdog, set_watchdog);
+
+static SENSOR_DEVICE_ATTR(fan1_mode, S_IWUSR | S_IRUGO,
+		get_fan_mode, set_fan_mode, 0);
+static SENSOR_DEVICE_ATTR(fan2_mode, S_IWUSR | S_IRUGO,
+		get_fan_mode, set_fan_mode, 1);
+static SENSOR_DEVICE_ATTR(fan3_mode, S_IWUSR | S_IRUGO,
+		get_fan_mode, set_fan_mode, 2);
+static SENSOR_DEVICE_ATTR(fan4_mode, S_IWUSR | S_IRUGO,
+		get_fan_mode, set_fan_mode, 3);
+static SENSOR_DEVICE_ATTR(fan5_mode, S_IWUSR | S_IRUGO,
+		get_fan_mode, set_fan_mode, 4);
+static SENSOR_DEVICE_ATTR(fan6_mode, S_IWUSR | S_IRUGO,
+		get_fan_mode, set_fan_mode, 5);
+
+static SENSOR_DEVICE_ATTR(fan1_tach_enable, S_IWUSR | S_IRUGO,
+		get_tach_enable, set_tach_enable, 0);
+static SENSOR_DEVICE_ATTR(fan2_tach_enable, S_IWUSR | S_IRUGO,
+		get_tach_enable, set_tach_enable, 1);
+static SENSOR_DEVICE_ATTR(fan3_tach_enable, S_IWUSR | S_IRUGO,
+		get_tach_enable, set_tach_enable, 2);
+static SENSOR_DEVICE_ATTR(fan4_tach_enable, S_IWUSR | S_IRUGO,
+		get_tach_enable, set_tach_enable, 3);
+static SENSOR_DEVICE_ATTR(fan5_tach_enable, S_IWUSR | S_IRUGO,
+		get_tach_enable, set_tach_enable, 4);
+static SENSOR_DEVICE_ATTR(fan6_tach_enable, S_IWUSR | S_IRUGO,
+		get_tach_enable, set_tach_enable, 5);
+
+static SENSOR_DEVICE_ATTR(fan1_fault, S_IWUSR | S_IRUGO,
+		get_fan_fault, set_fan_fault, 0);
+static SENSOR_DEVICE_ATTR(fan2_fault, S_IWUSR | S_IRUGO,
+		get_fan_fault, set_fan_fault, 1);
+static SENSOR_DEVICE_ATTR(fan3_fault, S_IWUSR | S_IRUGO,
+		get_fan_fault, set_fan_fault, 2);
+static SENSOR_DEVICE_ATTR(fan4_fault, S_IWUSR | S_IRUGO,
+		get_fan_fault, set_fan_fault, 3);
+static SENSOR_DEVICE_ATTR(fan5_fault, S_IWUSR | S_IRUGO,
+		get_fan_fault, set_fan_fault, 4);
+static SENSOR_DEVICE_ATTR(fan6_fault, S_IWUSR | S_IRUGO,
+		get_fan_fault, set_fan_fault, 5);
+
+static SENSOR_DEVICE_ATTR(fan1_mask, S_IWUSR | S_IRUGO,
+		get_fan_mask, set_fan_mask, 0);
+static SENSOR_DEVICE_ATTR(fan2_mask, S_IWUSR | S_IRUGO,
+		get_fan_mask, set_fan_mask, 1);
+static SENSOR_DEVICE_ATTR(fan3_mask, S_IWUSR | S_IRUGO,
+		get_fan_mask, set_fan_mask, 2);
+static SENSOR_DEVICE_ATTR(fan4_mask, S_IWUSR | S_IRUGO,
+		get_fan_mask, set_fan_mask, 3);
+static SENSOR_DEVICE_ATTR(fan5_mask, S_IWUSR | S_IRUGO,
+		get_fan_mask, set_fan_mask, 4);
+static SENSOR_DEVICE_ATTR(fan6_mask, S_IWUSR | S_IRUGO,
+		get_fan_mask, set_fan_mask, 5);
+
+static struct attribute *max31790_attrs[] = {
+	&sensor_dev_attr_fan1_input.dev_attr.attr,
+	&sensor_dev_attr_fan2_input.dev_attr.attr,
+	&sensor_dev_attr_fan3_input.dev_attr.attr,
+	&sensor_dev_attr_fan4_input.dev_attr.attr,
+	&sensor_dev_attr_fan5_input.dev_attr.attr,
+	&sensor_dev_attr_fan6_input.dev_attr.attr,
+
+	&sensor_dev_attr_fan1_target.dev_attr.attr,
+	&sensor_dev_attr_fan2_target.dev_attr.attr,
+	&sensor_dev_attr_fan3_target.dev_attr.attr,
+	&sensor_dev_attr_fan4_target.dev_attr.attr,
+	&sensor_dev_attr_fan5_target.dev_attr.attr,
+	&sensor_dev_attr_fan6_target.dev_attr.attr,
+
+	&sensor_dev_attr_pwm1.dev_attr.attr,
+	&sensor_dev_attr_pwm2.dev_attr.attr,
+	&sensor_dev_attr_pwm3.dev_attr.attr,
+	&sensor_dev_attr_pwm4.dev_attr.attr,
+	&sensor_dev_attr_pwm5.dev_attr.attr,
+	&sensor_dev_attr_pwm6.dev_attr.attr,
+
+	&dev_attr_reset.attr,
+	&dev_attr_standby.attr,
+	&dev_attr_bus_timeout.attr,
+	&dev_attr_watchdog.attr,
+
+	&sensor_dev_attr_fan1_mode.dev_attr.attr,
+	&sensor_dev_attr_fan2_mode.dev_attr.attr,
+	&sensor_dev_attr_fan3_mode.dev_attr.attr,
+	&sensor_dev_attr_fan4_mode.dev_attr.attr,
+	&sensor_dev_attr_fan5_mode.dev_attr.attr,
+	&sensor_dev_attr_fan6_mode.dev_attr.attr,
+
+	&sensor_dev_attr_fan1_tach_enable.dev_attr.attr,
+	&sensor_dev_attr_fan2_tach_enable.dev_attr.attr,
+	&sensor_dev_attr_fan3_tach_enable.dev_attr.attr,
+	&sensor_dev_attr_fan4_tach_enable.dev_attr.attr,
+	&sensor_dev_attr_fan5_tach_enable.dev_attr.attr,
+	&sensor_dev_attr_fan6_tach_enable.dev_attr.attr,
+
+	&sensor_dev_attr_fan1_fault.dev_attr.attr,
+	&sensor_dev_attr_fan2_fault.dev_attr.attr,
+	&sensor_dev_attr_fan3_fault.dev_attr.attr,
+	&sensor_dev_attr_fan4_fault.dev_attr.attr,
+	&sensor_dev_attr_fan5_fault.dev_attr.attr,
+	&sensor_dev_attr_fan6_fault.dev_attr.attr,
+
+	&sensor_dev_attr_fan1_mask.dev_attr.attr,
+	&sensor_dev_attr_fan2_mask.dev_attr.attr,
+	&sensor_dev_attr_fan3_mask.dev_attr.attr,
+	&sensor_dev_attr_fan4_mask.dev_attr.attr,
+	&sensor_dev_attr_fan5_mask.dev_attr.attr,
+	&sensor_dev_attr_fan6_mask.dev_attr.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(max31790);
+
+static int max31790_probe(struct i2c_client *client,
+		const struct i2c_device_id *id)
+{
+	struct i2c_adapter *adapter = client->adapter;
+	struct device *dev = &client->dev;
+	struct max31790_data *data;
+	struct device *hwmon_dev;
+
+	if (!i2c_check_functionality(adapter,
+			I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
+		return -ENODEV;
+
+	data = devm_kzalloc(dev, sizeof(struct max31790_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->client = client;
+	mutex_init(&data->update_lock);
+
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev,
+			client->name, data, max31790_groups);
+
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+}
+
+static const struct i2c_device_id max31790_id[] = {
+	{ "max31790", max31790 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, max31790_id);
+
+static struct i2c_driver max31790_driver = {
+	.class		= I2C_CLASS_HWMON,
+	.probe		= max31790_probe,
+	.driver = {
+		.name	= "max31790",
+	},
+	.id_table	= max31790_id,
+};
+
+module_i2c_driver(max31790_driver);
+
+MODULE_AUTHOR("Il Han <corone.il.han@gmail.com>");
+MODULE_DESCRIPTION("MAX31790 sensor driver");
+MODULE_LICENSE("GPL");
-- 
2.4.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
