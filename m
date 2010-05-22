From: Steve Glendinning <steve.glendinning@smsc.com>
Date: Sat, 22 May 2010 17:54:03 +0000
Subject: [lm-sensors] [PATCH] Add driver for SMSC EMC2103 temperature
Message-Id: <1274550843-3035-1-git-send-email-steve.glendinning@smsc.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

SMSC's EMC2103 family of temperature/fan controllers have 1
onboard and up to 3 external temperature sensors, and allow
closed-loop control of one fan.  This patch adds support for
them.

Signed-off-by: Steve Glendinning <steve.glendinning@smsc.com>
---
 MAINTAINERS             |    6 +
 drivers/hwmon/Kconfig   |   10 +
 drivers/hwmon/Makefile  |    1 +
 drivers/hwmon/smscemc.c |  675 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 692 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hwmon/smscemc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a8fe9b4..0fc4d50 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5178,6 +5178,12 @@ M:	Nicolas Pitre <nico@fluxnic.net>
 S:	Odd Fixes
 F:	drivers/net/smc91x.*
 
+SMSC EMC2103 HARDWARE MONITOR DRIVER
+M:	Steve Glendinning <steve.glendinning@smsc.com>
+L:	lm-sensors@lm-sensors.org
+S:	Supported
+F:	drivers/hwmon/smscemc.c
+
 SMSC47B397 HARDWARE MONITOR DRIVER
 M:	"Mark M. Hoffman" <mhoffman@lightlink.com>
 L:	lm-sensors@lm-sensors.org
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 9be8e17..6941d1c 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -782,6 +782,16 @@ config SENSORS_SMSC47M192
 	  This driver can also be built as a module.  If so, the module
 	  will be called smsc47m192.
 
+config SENSORS_SMSCEMC
+	tristate "SMSC EMC2103"
+	depends on I2C
+	help
+	  If you say yes here you get support for the temperature
+	  and fan sensors of the SMSC EMC2103 chips.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called smscemc.
+
 config SENSORS_SMSC47B397
 	tristate "SMSC LPC47B397-NC"
 	depends on EXPERIMENTAL
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 4aa1a3d..d28d12c 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -87,6 +87,7 @@ obj-$(CONFIG_SENSORS_SIS5595)	+= sis5595.o
 obj-$(CONFIG_SENSORS_SMSC47B397)+= smsc47b397.o
 obj-$(CONFIG_SENSORS_SMSC47M1)	+= smsc47m1.o
 obj-$(CONFIG_SENSORS_SMSC47M192)+= smsc47m192.o
+obj-$(CONFIG_SENSORS_SMSCEMC)	+= smscemc.o
 obj-$(CONFIG_SENSORS_AMC6821)	+= amc6821.o
 obj-$(CONFIG_SENSORS_THMC50)	+= thmc50.o
 obj-$(CONFIG_SENSORS_TMP401)	+= tmp401.o
diff --git a/drivers/hwmon/smscemc.c b/drivers/hwmon/smscemc.c
new file mode 100644
index 0000000..c83a7be
--- /dev/null
+++ b/drivers/hwmon/smscemc.c
@@ -0,0 +1,675 @@
+/*
+    smscemc.c - Support for SMSC EMC2103
+    Copyright (c) 2010 SMSC
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+*/
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
+/* Addresses scanned */
+static const unsigned short normal_i2c[] = { 0x2E, I2C_CLIENT_END };
+
+static u8 REG_TEMP[4] = { 0x00, 0x02, 0x04, 0x06 };
+static u8 REG_TEMP_MIN[4] = { 0x3c, 0x38, 0x39, 0x3a };
+static u8 REG_TEMP_MAX[4] = { 0x34, 0x30, 0x31, 0x32 };
+
+#define REG_CONF1		(0x20)
+#define REG_TEMP_MAX_ALARM	(0x24)
+#define REG_TEMP_MIN_ALARM	(0x25)
+#define REG_FAN_CONF1		(0x42)
+#define REG_FAN_TARGET_LO	(0x4c)
+#define REG_FAN_TARGET_HI	(0x4d)
+#define REG_FAN_TACH_HI		(0x4e)
+#define REG_FAN_TACH_LO		(0x4f)
+#define REG_PRODUCT_ID		(0xfd)
+#define REG_MFG_ID		(0xfe)
+#define FAN_RPM_FACTOR		(3932160)
+
+static int apd = 1;
+module_param(apd, bool, 0);
+MODULE_PARM_DESC(init, "Set to zero to disable anti-parallel diode mode");
+
+struct temperature {
+	s8	degrees;
+	u8	fraction;	/* 0-7 multiples of 0.125 */
+};
+
+struct smscemc_data {
+	struct device		*hwmon_dev;
+	struct mutex		update_lock;
+	bool			valid;		/* registers are valid */
+	bool			fan_rpm_control;
+	bool			have_temp3;
+	bool			have_temp4;
+	unsigned long		last_updated;	/* in jiffies */
+	struct temperature	temp[4];	/* internal + 3 external */
+	s8			temp_min[4];	/* no fractional part */
+	s8			temp_max[4];    /* no fractional part */
+	u8			temp_min_alarm;
+	u8			temp_max_alarm;
+	u8			fan_range;
+	u16			fan_tach;
+	u16			fan_target;
+};
+
+#define read_i2c_byte(i2c_reg)	do {				\
+	status = i2c_smbus_read_byte_data(client, i2c_reg);	\
+	if (status < 0) {					\
+		dev_dbg(&client->dev, "reg 0x%02x, err %d\n",	\
+			i2c_reg, status);			\
+		return;						\
+	} } while (0)
+
+static void read_u8_from_i2c(struct i2c_client *client, u8 i2c_reg, u8 *output)
+{
+	int status;
+	read_i2c_byte(i2c_reg);
+	*output = status;
+}
+
+static void read_s8_from_i2c(struct i2c_client *client, u8 i2c_reg, s8 *temp)
+{
+	int status;
+	read_i2c_byte(i2c_reg);
+	*temp = status;
+}
+
+static void read_temp_from_i2c(struct i2c_client *client, u8 i2c_reg,
+			       struct temperature *temp)
+{
+	int status;
+
+	/* read integer part */
+	read_i2c_byte(i2c_reg);
+	temp->degrees = status;
+
+	/* Read fractional part from the next register offset */
+	read_i2c_byte(i2c_reg + 1);
+	temp->fraction = (status & 0xe0) >> 5;
+}
+
+static void read_fan_from_i2c(struct i2c_client *client, u16 *output,
+			      u8 hi_addr, u8 lo_addr)
+{
+	int status;
+	u16 high_byte;
+
+	read_i2c_byte(hi_addr);
+	high_byte = status & 0xff;
+
+	read_i2c_byte(lo_addr);
+	*output = (high_byte << 5) | ((status & 0xf8) >> 3);
+}
+
+static void write_fan_target_to_i2c(struct i2c_client *client, u16 new_target)
+{
+	u8 high_byte = (new_target & 0x1fe0) >> 5;
+	u8 low_byte = (new_target & 0x001f) << 3;
+	i2c_smbus_write_byte_data(client, REG_FAN_TARGET_LO, low_byte);
+	i2c_smbus_write_byte_data(client, REG_FAN_TARGET_HI, high_byte);
+}
+
+static void read_fan_range_from_i2c(struct i2c_client *client, u8 *output)
+
+{
+	int status;
+	read_i2c_byte(REG_FAN_CONF1);
+	*output = (status & 0x60) >> 5;
+}
+
+static struct smscemc_data *smscemc_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct smscemc_data *data = i2c_get_clientdata(client);
+
+	mutex_lock(&data->update_lock);
+
+	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
+	    || !data->valid) {
+		int i;
+
+		dev_dbg(&client->dev, "Starting smscemc update\n");
+
+		for (i = 0; i < 4; i++) {
+			read_temp_from_i2c(client, REG_TEMP[i], &data->temp[i]);
+			read_s8_from_i2c(client, REG_TEMP_MIN[i],
+				&data->temp_min[i]);
+			read_s8_from_i2c(client, REG_TEMP_MAX[i],
+				&data->temp_max[i]);
+		}
+
+		read_u8_from_i2c(client, REG_TEMP_MIN_ALARM,
+			&data->temp_min_alarm);
+		read_u8_from_i2c(client, REG_TEMP_MAX_ALARM,
+			&data->temp_max_alarm);
+
+		read_fan_from_i2c(client, &data->fan_tach,
+			REG_FAN_TACH_HI, REG_FAN_TACH_LO);
+		read_fan_from_i2c(client, &data->fan_target,
+			REG_FAN_TARGET_HI, REG_FAN_TARGET_LO);
+		read_fan_range_from_i2c(client, &data->fan_range);
+
+		data->last_updated = jiffies;
+		data->valid = true;
+	}
+
+	mutex_unlock(&data->update_lock);
+
+	return data;
+}
+
+static ssize_t
+show_temp(struct device *dev, struct device_attribute *da, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct smscemc_data *data = smscemc_update_device(dev);
+	int millidegrees = data->temp[attr->index].degrees * 1000
+		+ data->temp[attr->index].fraction * 125;
+	return sprintf(buf, "%d\n", millidegrees);
+}
+
+static ssize_t
+show_temp_min(struct device *dev, struct device_attribute *da, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct smscemc_data *data = smscemc_update_device(dev);
+	int millidegrees = data->temp_min[attr->index] * 1000;
+	return sprintf(buf, "%d\n", millidegrees);
+}
+
+static ssize_t
+show_temp_max(struct device *dev, struct device_attribute *da, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct smscemc_data *data = smscemc_update_device(dev);
+	int millidegrees = data->temp_max[attr->index] * 1000;
+	return sprintf(buf, "%d\n", millidegrees);
+}
+
+static ssize_t
+show_temp_fault(struct device *dev, struct device_attribute *da, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct smscemc_data *data = smscemc_update_device(dev);
+	bool fault = (data->temp[attr->index].degrees = -128);
+	return sprintf(buf, "%d\n", fault ? 1 : 0);
+}
+
+static ssize_t
+show_temp_min_alarm(struct device *dev, struct device_attribute *da, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct smscemc_data *data = smscemc_update_device(dev);
+	bool alarm = data->temp_min_alarm & (1 << attr->index);
+	return sprintf(buf, "%d\n", alarm ? 1 : 0);
+}
+
+static ssize_t
+show_temp_max_alarm(struct device *dev, struct device_attribute *da, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct smscemc_data *data = smscemc_update_device(dev);
+	bool alarm = data->temp_max_alarm & (1 << attr->index);
+	return sprintf(buf, "%d\n", alarm ? 1 : 0);
+}
+
+#define strtol_check(buf, val) do {			\
+	int result = strict_strtol(buf, 10, &val);	\
+	if (result < 0)					\
+		return -EINVAL;				\
+} while (0)
+
+static ssize_t set_temp_min(struct device *dev, struct device_attribute *da,
+			    const char *buf, size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct smscemc_data *data = smscemc_update_device(dev);
+	struct i2c_client *client = to_i2c_client(dev);
+	long val;
+
+	strtol_check(buf, val);
+
+	val = val / 1000;
+	if ((val < -63) || (val > 127))
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+	data->temp_min[attr->index] = val;
+	i2c_smbus_write_byte_data(client, REG_TEMP_MIN[attr->index], val);
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static ssize_t set_temp_max(struct device *dev, struct device_attribute *da,
+			    const char *buf, size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct smscemc_data *data = smscemc_update_device(dev);
+	struct i2c_client *client = to_i2c_client(dev);
+	long val;
+
+	strtol_check(buf, val);
+
+	if ((val < -63) || (val > 127))
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+	data->temp_max[attr->index] = val;
+	i2c_smbus_write_byte_data(client, REG_TEMP_MAX[attr->index], val);
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static ssize_t
+show_fan(struct device *dev, struct device_attribute *da, char *buf)
+{
+	struct smscemc_data *data = smscemc_update_device(dev);
+	int fan_div = 1 << data->fan_range;
+	int rpm = (FAN_RPM_FACTOR * fan_div) / data->fan_tach;
+	return sprintf(buf, "%d\n", rpm);
+}
+
+static ssize_t
+show_fan_div(struct device *dev, struct device_attribute *da, char *buf)
+{
+	struct smscemc_data *data = smscemc_update_device(dev);
+	int fan_div = 1 << data->fan_range;
+	return sprintf(buf, "%d\n", fan_div);
+}
+
+/* Note: we also update the fan target here, because its value is
+   determined in part by the fan clock divider.  This follows the principle
+   of least surprise; the user doesn't expect the fan target to change just
+   because the divider changed. */
+static ssize_t set_fan_div(struct device *dev, struct device_attribute *da,
+			   const char *buf, size_t count)
+{
+	struct smscemc_data *data = smscemc_update_device(dev);
+	struct i2c_client *client = to_i2c_client(dev);
+	int status, old_div = 1 << data->fan_range;
+	long new_div;
+
+	strtol_check(buf, new_div);
+
+	if (new_div = old_div) /* No change */
+		return count;
+
+	mutex_lock(&data->update_lock);
+	switch (new_div) {
+	case 1:
+		data->fan_range = 0;
+		break;
+	case 2:
+		data->fan_range = 1;
+		break;
+	case 4:
+		data->fan_range = 2;
+		break;
+	case 8:
+		data->fan_range = 3;
+		break;
+	default:
+		mutex_unlock(&data->update_lock);
+		return -EINVAL;
+	}
+
+	status = i2c_smbus_read_byte_data(client, REG_FAN_CONF1);
+	if (status < 0) {
+		dev_dbg(&client->dev, "reg 0x%02x, err %d\n",
+			REG_FAN_CONF1, status);
+		mutex_unlock(&data->update_lock);
+		return -EIO;
+	}
+	status &= 0x9F;
+	status |= (data->fan_range << 5) & 0x60;
+	i2c_smbus_write_byte_data(client, REG_FAN_CONF1, status);
+
+	/* update fan target if high word is not disabled */
+	if ((data->fan_target & 0x1fe0) != 0x1fe0) {
+		data->fan_target = (data->fan_target * new_div) / old_div;
+		write_fan_target_to_i2c(client, data->fan_target);
+	}
+
+	/* invalidate data to force re-read from hardware */
+	data->valid = false;
+
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static ssize_t
+show_fan_target(struct device *dev, struct device_attribute *da, char *buf)
+{
+	struct smscemc_data *data = smscemc_update_device(dev);
+	int fan_div = 1 << data->fan_range;
+	int rpm = (FAN_RPM_FACTOR * fan_div) / data->fan_target;
+
+	/* high byte of 0xff = disabled so return 0 */
+	if ((data->fan_target & 0x1fe0) = 0x1fe0)
+		rpm = 0;
+
+	return sprintf(buf, "%d\n", rpm);
+}
+
+static ssize_t set_fan_target(struct device *dev, struct device_attribute *da,
+			      const char *buf, size_t count)
+{
+	struct smscemc_data *data = smscemc_update_device(dev);
+	struct i2c_client *client = to_i2c_client(dev);
+	long rpm_target;
+	int fan_div = 1 << data->fan_range;
+
+	strtol_check(buf, rpm_target);
+
+	if ((rpm_target < 0) || (rpm_target > 16384))
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+
+	if (rpm_target = 0)
+		data->fan_target = 0x1fff;
+	else
+		data->fan_target +			((FAN_RPM_FACTOR * fan_div) / rpm_target) & 0x1fff;
+
+	write_fan_target_to_i2c(client, data->fan_target);
+
+	if (!data->fan_rpm_control) {
+		/* RPM control mode is not currently enabled */
+		int status = i2c_smbus_read_byte_data(client, REG_FAN_CONF1);
+		if (status < 0) {
+			dev_dbg(&client->dev, "reg 0x%02x, err %d\n",
+				REG_FAN_CONF1, status);
+			mutex_unlock(&data->update_lock);
+			return -EIO;
+		}
+		status |= 0x80;
+		i2c_smbus_write_byte_data(client, REG_FAN_CONF1, status);
+
+		data->fan_rpm_control = true;
+	}
+
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static ssize_t
+show_fan_fault(struct device *dev, struct device_attribute *da, char *buf)
+{
+	struct smscemc_data *data = smscemc_update_device(dev);
+	bool fault = ((data->fan_tach & 0x1fe0) = 0x1fe0);
+	return sprintf(buf, "%d\n", fault ? 1 : 0);
+}
+
+#define TEMP_SENSOR(offset)						\
+static SENSOR_DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_temp,	\
+	NULL, offset - 1);						\
+static SENSOR_DEVICE_ATTR(temp##offset##_min, S_IRUGO | S_IWUSR,	\
+	show_temp_min, set_temp_min, offset - 1);			\
+static SENSOR_DEVICE_ATTR(temp##offset##_max, S_IRUGO | S_IWUSR,	\
+	show_temp_max, set_temp_max, offset - 1);			\
+static SENSOR_DEVICE_ATTR(temp##offset##_fault, S_IRUGO,		\
+	show_temp_fault, NULL, offset - 1);				\
+static SENSOR_DEVICE_ATTR(temp##offset##_min_alarm, S_IRUGO,		\
+	show_temp_min_alarm, NULL, offset - 1);				\
+static SENSOR_DEVICE_ATTR(temp##offset##_max_alarm, S_IRUGO,		\
+	show_temp_max_alarm, NULL, offset - 1)
+
+TEMP_SENSOR(1);
+TEMP_SENSOR(2);
+TEMP_SENSOR(3);
+TEMP_SENSOR(4);
+
+static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, show_fan, NULL, 0);
+static SENSOR_DEVICE_ATTR(fan1_div, S_IRUGO | S_IWUSR, show_fan_div,
+	set_fan_div, 0);
+static SENSOR_DEVICE_ATTR(fan1_target, S_IRUGO | S_IWUSR, show_fan_target,
+	set_fan_target, 0);
+static SENSOR_DEVICE_ATTR(fan1_fault, S_IRUGO, show_fan_fault, NULL, 0);
+
+/* sensors present on all models */
+static struct attribute *smscemc_attributes[] = {
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_min.dev_attr.attr,
+	&sensor_dev_attr_temp1_max.dev_attr.attr,
+	&sensor_dev_attr_temp1_fault.dev_attr.attr,
+	&sensor_dev_attr_temp1_min_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp2_input.dev_attr.attr,
+	&sensor_dev_attr_temp2_min.dev_attr.attr,
+	&sensor_dev_attr_temp2_max.dev_attr.attr,
+	&sensor_dev_attr_temp2_fault.dev_attr.attr,
+	&sensor_dev_attr_temp2_min_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp2_max_alarm.dev_attr.attr,
+	&sensor_dev_attr_fan1_input.dev_attr.attr,
+	&sensor_dev_attr_fan1_div.dev_attr.attr,
+	&sensor_dev_attr_fan1_target.dev_attr.attr,
+	&sensor_dev_attr_fan1_fault.dev_attr.attr,
+	NULL
+};
+
+/* extra temperature sensors only present on 2103-2 and 2103-4 */
+static struct attribute *smscemc_attributes_temp3[] = {
+	&sensor_dev_attr_temp3_input.dev_attr.attr,
+	&sensor_dev_attr_temp3_min.dev_attr.attr,
+	&sensor_dev_attr_temp3_max.dev_attr.attr,
+	&sensor_dev_attr_temp3_fault.dev_attr.attr,
+	&sensor_dev_attr_temp3_min_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp3_max_alarm.dev_attr.attr,
+	NULL
+};
+
+/* extra temperature sensors only present on 2103-2 and 2103-4 in APD mode */
+static struct attribute *smscemc_attributes_temp4[] = {
+	&sensor_dev_attr_temp4_input.dev_attr.attr,
+	&sensor_dev_attr_temp4_min.dev_attr.attr,
+	&sensor_dev_attr_temp4_max.dev_attr.attr,
+	&sensor_dev_attr_temp4_fault.dev_attr.attr,
+	&sensor_dev_attr_temp4_min_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp4_max_alarm.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group smscemc_group = {
+	.attrs = smscemc_attributes,
+};
+
+static const struct attribute_group smscemc_temp3_group = {
+	.attrs = smscemc_attributes_temp3,
+};
+
+static const struct attribute_group smscemc_temp4_group = {
+	.attrs = smscemc_attributes_temp4,
+};
+
+static int
+smscemc_probe(struct i2c_client *client, const struct i2c_device_id *id)
+{
+	struct smscemc_data *data;
+	int status;
+
+	if (!i2c_check_functionality(client->adapter,
+			I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
+		return -EIO;
+
+	data = kzalloc(sizeof(struct smscemc_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, data);
+	mutex_init(&data->update_lock);
+
+	/* 2103-2 and 2103-4 have 3 external diodes, 2103-1 has 1 */
+	status = i2c_smbus_read_byte_data(client, REG_PRODUCT_ID);
+	data->have_temp3 = (status = 0x26);
+
+	/* check if the device is already in RPM control mode */
+	status = i2c_smbus_read_byte_data(client, REG_FAN_CONF1);
+	if (status < 0) {
+		dev_dbg(&client->dev, "reg 0x%02x, err %d\n",
+			REG_FAN_CONF1, status);
+		return -EIO;
+	}
+	data->fan_rpm_control = (status & 0x80);
+
+	if (data->have_temp3) {
+		/* Configure anti-parallel diode mode */
+		data->have_temp4 = apd;
+		status = i2c_smbus_read_byte_data(client, REG_CONF1);
+		if (status < 0) {
+			dev_dbg(&client->dev, "reg 0x%02x, err %d\n", REG_CONF1,
+				status);
+			return -EIO;
+		}
+
+		if (data->have_temp4)
+			status |= 0x01;
+		else
+			status &= ~(0x01);
+
+		i2c_smbus_write_byte_data(client, REG_CONF1, status & 0xff);
+	}
+
+	/* Register sysfs hooks */
+	status = sysfs_create_group(&client->dev.kobj, &smscemc_group);
+	if (status)
+		goto exit_free;
+
+	if (data->have_temp3) {
+		status = sysfs_create_group(&client->dev.kobj,
+			&smscemc_temp3_group);
+		if (status)
+			goto exit_remove;
+	}
+
+	if (data->have_temp4) {
+		status = sysfs_create_group(&client->dev.kobj,
+			&smscemc_temp4_group);
+		if (status)
+			goto exit_remove_temp3;
+	}
+
+	data->hwmon_dev = hwmon_device_register(&client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		status = PTR_ERR(data->hwmon_dev);
+		goto exit_remove_temp4;
+	}
+
+	dev_info(&client->dev, "%s: sensor '%s'\n",
+		 dev_name(data->hwmon_dev), client->name);
+
+	return 0;
+
+exit_remove_temp4:
+	if (data->have_temp4)
+		sysfs_remove_group(&client->dev.kobj, &smscemc_temp4_group);
+exit_remove_temp3:
+	if (data->have_temp3)
+		sysfs_remove_group(&client->dev.kobj, &smscemc_temp3_group);
+exit_remove:
+	sysfs_remove_group(&client->dev.kobj, &smscemc_group);
+exit_free:
+	i2c_set_clientdata(client, NULL);
+	kfree(data);
+	return status;
+}
+
+static int smscemc_remove(struct i2c_client *client)
+{
+	struct smscemc_data *data = i2c_get_clientdata(client);
+
+	hwmon_device_unregister(data->hwmon_dev);
+
+	if (data->have_temp4)
+		sysfs_remove_group(&client->dev.kobj, &smscemc_temp4_group);
+
+	if (data->have_temp3)
+		sysfs_remove_group(&client->dev.kobj, &smscemc_temp3_group);
+
+	sysfs_remove_group(&client->dev.kobj, &smscemc_group);
+
+	i2c_set_clientdata(client, NULL);
+	kfree(data);
+	return 0;
+}
+
+static const struct i2c_device_id smscemc_ids[] = {
+	{ "smscemc", 0, },
+	{ /* LIST END */ }
+};
+MODULE_DEVICE_TABLE(i2c, smscemc_ids);
+
+/* Return 0 if detection is successful, -ENODEV otherwise */
+static int
+smscemc_detect(struct i2c_client *new_client, struct i2c_board_info *info)
+{
+	struct i2c_adapter *adapter = new_client->adapter;
+	int manufacturer, product;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		return -ENODEV;
+
+	manufacturer = i2c_smbus_read_byte_data(new_client, REG_MFG_ID);
+	if (manufacturer != 0x5D)
+		return -ENODEV;
+
+	product = i2c_smbus_read_byte_data(new_client, REG_PRODUCT_ID);
+	if ((product != 0x24) && (product != 0x26))
+		return -ENODEV;
+
+	strlcpy(info->type, "smscemc", I2C_NAME_SIZE);
+
+	return 0;
+}
+
+static struct i2c_driver smscemc_driver = {
+	.class		= I2C_CLASS_HWMON,
+	.driver = {
+		.name	= "smscemc",
+	},
+	.probe		= smscemc_probe,
+	.remove		= smscemc_remove,
+	.id_table	= smscemc_ids,
+	.detect		= smscemc_detect,
+	.address_list	= normal_i2c,
+};
+
+static int __init sensors_smscemc_init(void)
+{
+	return i2c_add_driver(&smscemc_driver);
+}
+
+static void __exit sensors_smscemc_exit(void)
+{
+	i2c_del_driver(&smscemc_driver);
+}
+
+MODULE_AUTHOR("Steve Glendinning <steve.glendinning@smsc.com>");
+MODULE_DESCRIPTION("SMSC EMCxxxx hwmon driver");
+MODULE_LICENSE("GPL");
+
+module_init(sensors_smscemc_init);
+module_exit(sensors_smscemc_exit);
-- 
1.6.6.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
