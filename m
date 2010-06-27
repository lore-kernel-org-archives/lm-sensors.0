From: Steve Glendinning <steve.glendinning@smsc.com>
Date: Sun, 27 Jun 2010 15:27:07 +0000
Subject: [lm-sensors] [PATCH] Add driver for SMSC EMC2103 temperature
Message-Id: <1277652427-4061-1-git-send-email-steve.glendinning@smsc.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1274550843-3035-1-git-send-email-steve.glendinning@smsc.com>
In-Reply-To: <1274550843-3035-1-git-send-email-steve.glendinning@smsc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

SMSC's EMC2103 family of temperature/fan controllers have 1
onboard and up to 3 external temperature sensors, and allow
closed-loop control of one fan.  This patch adds support for
them.

Changes since v2:
- Add Documentation/hwmon/emc2103
- move Kconfig and Makefile definitions to preserve alphabetical order
- mark constants as const
- add comment to explain FAN_RPM_FACTOR
- increase severity of error in read_u8_from_i2c
- combine read_u8_from_i2c and read_s8_from_i2c
- reduce duplication of code in read_temp_from_i2c
- reduce duplication in read_temp_from_i2c
- reduce duplication in read_fan_range_from_i2c
- remove frequent debugging message
- change temperature sensor flags to a count
- only read registers for temperature sensors fitted
- simplify dev_attr syntax
- use DIV_ROUND_CLOSEST in set_temp_min
- add missing division by 1000 to set_temp_max
- remove superfluous mask and correct comment
- clamp recalculated fan target when setting divisor
- check for possible divide by zeroes in show_fan and show_fan_target
- add rationale for 16384rpm fan target limit
- replace mask with SENSORS_LIMIT to clamp input
- convert tabs to spaces
- convert fan attributes to DEVICE_ATTR
- remove requirement for i2c WORD data reads
- fix potential memory leak on init error
- remove unnecessary i2c_set_clientdata calls
- correct MODULE_DESCRIPTION to list the supported part number
- enable/disable fan speed control explicitly
- add rationale for APD configuration
- remove unnecessary parentheses from #defines

Changes since v1:
- rename driver to emc2103
- expand return-hiding macros

Signed-off-by: Steve Glendinning <steve.glendinning@smsc.com>
---
 Documentation/hwmon/emc2103 |   33 ++
 MAINTAINERS                 |    6 +
 drivers/hwmon/Kconfig       |   10 +
 drivers/hwmon/Makefile      |    1 +
 drivers/hwmon/emc2103.c     |  734 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 784 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/hwmon/emc2103
 create mode 100644 drivers/hwmon/emc2103.c

diff --git a/Documentation/hwmon/emc2103 b/Documentation/hwmon/emc2103
new file mode 100644
index 0000000..3fa8884
--- /dev/null
+++ b/Documentation/hwmon/emc2103
@@ -0,0 +1,33 @@
+Kernel driver emc2103
+===========
+
+Supported chips:
+  * SMSC EMC2103
+    Addresses scanned: I2C 0x2e
+    Prefix: 'emc2103'
+    Datasheet: Not public
+
+Authors:
+        Steve Glendinning <steve.glendinning@smsc.com>
+
+Description
+-----------
+
+The Standard Microsystems Corporation (SMSC) EMC2103 chips
+contain up to 4 temperature sensors and a single fan controller.
+
+Fan rotation speeds are reported in RPM (rotations per minute). An alarm is
+triggered if the rotation speed has dropped below a programmable limit. Fan
+readings can be divided by a programmable divider (1, 2, 4 or 8) to give
+the readings more range or accuracy. Not all RPM values can accurately be
+represented, so some rounding is done. With a divider of 2, the lowest
+representable value is around 2600 RPM.
+
+This driver supports RPM based control, to use this a fan target
+should be written to fan1_target and pwm1_enable should be set to 3.
+
+The 2103-2 and 2103-4 variants have a third temperature sensor, which can
+be connected to two anti-parallel diodes.  These values can be read
+as temp3 and temp4.  If only one diode is attached to this channel, temp4
+will show as "fault".  The module parameter "apd=0" can be used to suppress
+this 4th channel when anti-parallel diodes are not fitted.
diff --git a/MAINTAINERS b/MAINTAINERS
index 6d119c9..6835f89 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5205,6 +5205,12 @@ M:	Nicolas Pitre <nico@fluxnic.net>
 S:	Odd Fixes
 F:	drivers/net/smc91x.*
 
+SMSC EMC2103 HARDWARE MONITOR DRIVER
+M:	Steve Glendinning <steve.glendinning@smsc.com>
+L:	lm-sensors@lm-sensors.org
+S:	Supported
+F:	drivers/hwmon/emc2103.c
+
 SMSC47B397 HARDWARE MONITOR DRIVER
 M:	"Mark M. Hoffman" <mhoffman@lightlink.com>
 L:	lm-sensors@lm-sensors.org
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index e19cf8e..2608e38 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -761,6 +761,16 @@ config SENSORS_EMC1403
 	  Threshold values can be configured using sysfs.
 	  Data from the different diodes are accessible via sysfs.
 
+config SENSORS_EMC2103
+	tristate "SMSC EMC2103"
+	depends on I2C
+	help
+	  If you say yes here you get support for the temperature
+	  and fan sensors of the SMSC EMC2103 chips.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called emc2103.
+
 config SENSORS_SMSC47M1
 	tristate "SMSC LPC47M10x and compatibles"
 	help
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 2138ceb..b8e7e65 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_SENSORS_CORETEMP)	+= coretemp.o
 obj-$(CONFIG_SENSORS_DME1737)	+= dme1737.o
 obj-$(CONFIG_SENSORS_DS1621)	+= ds1621.o
 obj-$(CONFIG_SENSORS_EMC1403)	+= emc1403.o
+obj-$(CONFIG_SENSORS_EMC2103)	+= emc2103.o
 obj-$(CONFIG_SENSORS_F71805F)	+= f71805f.o
 obj-$(CONFIG_SENSORS_F71882FG)	+= f71882fg.o
 obj-$(CONFIG_SENSORS_F75375S)	+= f75375s.o
diff --git a/drivers/hwmon/emc2103.c b/drivers/hwmon/emc2103.c
new file mode 100644
index 0000000..10ee58e
--- /dev/null
+++ b/drivers/hwmon/emc2103.c
@@ -0,0 +1,734 @@
+/*
+    emc2103.c - Support for SMSC EMC2103
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
+static const u8 REG_TEMP[4] = { 0x00, 0x02, 0x04, 0x06 };
+static const u8 REG_TEMP_MIN[4] = { 0x3c, 0x38, 0x39, 0x3a };
+static const u8 REG_TEMP_MAX[4] = { 0x34, 0x30, 0x31, 0x32 };
+
+#define REG_CONF1		0x20
+#define REG_TEMP_MAX_ALARM	0x24
+#define REG_TEMP_MIN_ALARM	0x25
+#define REG_FAN_CONF1		0x42
+#define REG_FAN_TARGET_LO	0x4c
+#define REG_FAN_TARGET_HI	0x4d
+#define REG_FAN_TACH_HI		0x4e
+#define REG_FAN_TACH_LO		0x4f
+#define REG_PRODUCT_ID		0xfd
+#define REG_MFG_ID		0xfe
+
+/* equation 4 from datasheet: rpm = (3932160 * multipler) / count */
+#define FAN_RPM_FACTOR		3932160
+
+/* 2103-2 and 2103-4's 3rd temperature sensor can be connected to two diodes
+ * in anti-parallel mode, and in this configuration both can be read
+ * independently (so we have 4 temperature inputs).  The device can't
+ * detect if it's connected in this mode, so we have to manually enable
+ * it.  Default is to enable it, so in non-APD configurations the 4th
+ * channel will appear as a fault.  This parameter allows APD mode to be
+ * optionally disabled. */
+static int apd = 1;
+module_param(apd, bool, 0);
+MODULE_PARM_DESC(init, "Set to zero to disable anti-parallel diode mode");
+
+struct temperature {
+	s8	degrees;
+	u8	fraction;	/* 0-7 multiples of 0.125 */
+};
+
+struct emc2103_data {
+	struct device		*hwmon_dev;
+	struct mutex		update_lock;
+	bool			valid;		/* registers are valid */
+	bool			fan_rpm_control;
+	int			temp_count;	/* num of temp sensors */
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
+static void read_u8_from_i2c(struct i2c_client *client, u8 i2c_reg, u8 *output)
+{
+	int status = i2c_smbus_read_byte_data(client, i2c_reg);
+	if (status < 0) {
+		dev_warn(&client->dev, "reg 0x%02x, err %d\n",
+			i2c_reg, status);
+	} else {
+		*output = status;
+	}
+}
+
+static void read_temp_from_i2c(struct i2c_client *client, u8 i2c_reg,
+			       struct temperature *temp)
+{
+	u8 fractional;
+	read_u8_from_i2c(client, i2c_reg, &temp->degrees);
+	read_u8_from_i2c(client, i2c_reg + 1, &fractional);
+	temp->fraction = (fractional & 0xe0) >> 5;
+}
+
+static void read_fan_from_i2c(struct i2c_client *client, u16 *output,
+			      u8 hi_addr, u8 lo_addr)
+{
+	u8 high_byte, lo_byte;
+	read_u8_from_i2c(client, hi_addr, &high_byte);
+	read_u8_from_i2c(client, lo_addr, &lo_byte);
+	*output = ((u16)high_byte << 5) | (lo_byte >> 3);
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
+	u8 conf1;
+	read_u8_from_i2c(client, REG_FAN_CONF1, &conf1);
+	*output = (conf1 & 0x60) >> 5;
+}
+
+static struct emc2103_data *emc2103_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct emc2103_data *data = i2c_get_clientdata(client);
+
+	mutex_lock(&data->update_lock);
+
+	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
+	    || !data->valid) {
+		int i;
+		u8 conf1;
+
+		for (i = 0; i < data->temp_count; i++) {
+			read_temp_from_i2c(client, REG_TEMP[i], &data->temp[i]);
+			read_u8_from_i2c(client, REG_TEMP_MIN[i],
+				&data->temp_min[i]);
+			read_u8_from_i2c(client, REG_TEMP_MAX[i],
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
+		read_u8_from_i2c(client, REG_FAN_CONF1, &conf1);
+		data->fan_rpm_control = (conf1 & 0x80) != 0;
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
+	int nr = to_sensor_dev_attr(da)->index;
+	struct emc2103_data *data = emc2103_update_device(dev);
+	int millidegrees = data->temp[nr].degrees * 1000
+		+ data->temp[nr].fraction * 125;
+	return sprintf(buf, "%d\n", millidegrees);
+}
+
+static ssize_t
+show_temp_min(struct device *dev, struct device_attribute *da, char *buf)
+{
+	int nr = to_sensor_dev_attr(da)->index;
+	struct emc2103_data *data = emc2103_update_device(dev);
+	int millidegrees = data->temp_min[nr] * 1000;
+	return sprintf(buf, "%d\n", millidegrees);
+}
+
+static ssize_t
+show_temp_max(struct device *dev, struct device_attribute *da, char *buf)
+{
+	int nr = to_sensor_dev_attr(da)->index;
+	struct emc2103_data *data = emc2103_update_device(dev);
+	int millidegrees = data->temp_max[nr] * 1000;
+	return sprintf(buf, "%d\n", millidegrees);
+}
+
+static ssize_t
+show_temp_fault(struct device *dev, struct device_attribute *da, char *buf)
+{
+	int nr = to_sensor_dev_attr(da)->index;
+	struct emc2103_data *data = emc2103_update_device(dev);
+	bool fault = (data->temp[nr].degrees = -128);
+	return sprintf(buf, "%d\n", fault ? 1 : 0);
+}
+
+static ssize_t
+show_temp_min_alarm(struct device *dev, struct device_attribute *da, char *buf)
+{
+	int nr = to_sensor_dev_attr(da)->index;
+	struct emc2103_data *data = emc2103_update_device(dev);
+	bool alarm = data->temp_min_alarm & (1 << nr);
+	return sprintf(buf, "%d\n", alarm ? 1 : 0);
+}
+
+static ssize_t
+show_temp_max_alarm(struct device *dev, struct device_attribute *da, char *buf)
+{
+	int nr = to_sensor_dev_attr(da)->index;
+	struct emc2103_data *data = emc2103_update_device(dev);
+	bool alarm = data->temp_max_alarm & (1 << nr);
+	return sprintf(buf, "%d\n", alarm ? 1 : 0);
+}
+
+static ssize_t set_temp_min(struct device *dev, struct device_attribute *da,
+			    const char *buf, size_t count)
+{
+	int nr = to_sensor_dev_attr(da)->index;
+	struct emc2103_data *data = emc2103_update_device(dev);
+	struct i2c_client *client = to_i2c_client(dev);
+	long val;
+
+	int result = strict_strtol(buf, 10, &val);
+	if (result < 0)
+		return -EINVAL;
+
+	val = DIV_ROUND_CLOSEST(val, 1000);
+	if ((val < -63) || (val > 127))
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+	data->temp_min[nr] = val;
+	i2c_smbus_write_byte_data(client, REG_TEMP_MIN[nr], val);
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static ssize_t set_temp_max(struct device *dev, struct device_attribute *da,
+			    const char *buf, size_t count)
+{
+	int nr = to_sensor_dev_attr(da)->index;
+	struct emc2103_data *data = emc2103_update_device(dev);
+	struct i2c_client *client = to_i2c_client(dev);
+	long val;
+
+	int result = strict_strtol(buf, 10, &val);
+	if (result < 0)
+		return -EINVAL;
+
+	val = DIV_ROUND_CLOSEST(val, 1000);
+	if ((val < -63) || (val > 127))
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+	data->temp_max[nr] = val;
+	i2c_smbus_write_byte_data(client, REG_TEMP_MAX[nr], val);
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static ssize_t
+show_fan(struct device *dev, struct device_attribute *da, char *buf)
+{
+	struct emc2103_data *data = emc2103_update_device(dev);
+	int fan_div = 1 << data->fan_range;
+	int rpm = 0;
+	if (data->fan_tach != 0)
+		rpm = (FAN_RPM_FACTOR * fan_div) / data->fan_tach;
+	return sprintf(buf, "%d\n", rpm);
+}
+
+static ssize_t
+show_fan_div(struct device *dev, struct device_attribute *da, char *buf)
+{
+	struct emc2103_data *data = emc2103_update_device(dev);
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
+	struct emc2103_data *data = emc2103_update_device(dev);
+	struct i2c_client *client = to_i2c_client(dev);
+	int status, old_div = 1 << data->fan_range;
+	long new_div;
+
+	int result = strict_strtol(buf, 10, &new_div);
+	if (result < 0)
+		return -EINVAL;
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
+	status |= (data->fan_range << 5);
+	i2c_smbus_write_byte_data(client, REG_FAN_CONF1, status);
+
+	/* update fan target if high byte is not disabled */
+	if ((data->fan_target & 0x1fe0) != 0x1fe0) {
+		u16 new_target = (data->fan_target * new_div) / old_div;
+		data->fan_target = min(new_target, (u16)0x1fff);
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
+	struct emc2103_data *data = emc2103_update_device(dev);
+	int fan_div = 1 << data->fan_range;
+	int rpm = 0;
+
+	if (data->fan_target != 0)
+	{
+		rpm = (FAN_RPM_FACTOR * fan_div) / data->fan_target;
+
+		/* high byte of 0xff = disabled so return 0 */
+		if ((data->fan_target & 0x1fe0) = 0x1fe0)
+			rpm = 0;
+	}
+
+	return sprintf(buf, "%d\n", rpm);
+}
+
+static ssize_t set_fan_target(struct device *dev, struct device_attribute *da,
+			      const char *buf, size_t count)
+{
+	struct emc2103_data *data = emc2103_update_device(dev);
+	struct i2c_client *client = to_i2c_client(dev);
+	long rpm_target;
+	int fan_div = 1 << data->fan_range;
+
+	int result = strict_strtol(buf, 10, &rpm_target);
+	if (result < 0)
+		return -EINVAL;
+
+	/* Datasheet states 16384 as maximum RPM target (table 3.2) */
+	if ((rpm_target < 0) || (rpm_target > 16384))
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+
+	if (rpm_target = 0)
+		data->fan_target = 0x1fff;
+	else
+		data->fan_target = SENSORS_LIMIT(
+			(FAN_RPM_FACTOR * fan_div) / rpm_target, 0, 0x1fff);
+
+	write_fan_target_to_i2c(client, data->fan_target);
+
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static ssize_t
+show_fan_fault(struct device *dev, struct device_attribute *da, char *buf)
+{
+	struct emc2103_data *data = emc2103_update_device(dev);
+	bool fault = ((data->fan_tach & 0x1fe0) = 0x1fe0);
+	return sprintf(buf, "%d\n", fault ? 1 : 0);
+}
+
+static ssize_t
+show_pwm_enable(struct device *dev, struct device_attribute *da, char *buf)
+{
+	struct emc2103_data *data = emc2103_update_device(dev);
+	return sprintf(buf, "%d\n", data->fan_rpm_control ? 3 : 0);
+}
+
+static ssize_t set_pwm_enable(struct device *dev, struct device_attribute *da,
+			      const char *buf, size_t count)
+{
+	struct emc2103_data *data = emc2103_update_device(dev);
+	struct i2c_client *client = to_i2c_client(dev);
+	bool old_rpm_control = data->fan_rpm_control;
+	long new_value;
+	u8 conf_reg;
+
+	int result = strict_strtol(buf, 10, &new_value);
+	if (result < 0)
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+	switch (new_value) {
+	case 0:
+		data->fan_rpm_control = false;
+		break;
+	case 3:
+		data->fan_rpm_control = true;
+		break;
+	default:
+		mutex_unlock(&data->update_lock);
+		return -EINVAL;
+	}
+
+	if (data->fan_rpm_control = old_rpm_control) {
+		mutex_unlock(&data->update_lock);
+		return count;
+	}
+
+	read_u8_from_i2c(client, REG_FAN_CONF1, &conf_reg);
+
+	if (data->fan_rpm_control)
+		conf_reg |= 0x80;
+	else
+		conf_reg &= ~0x80;
+
+	i2c_smbus_write_byte_data(client, REG_FAN_CONF1, conf_reg);
+
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp1_min, S_IRUGO | S_IWUSR, show_temp_min,
+	set_temp_min, 0);
+static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO | S_IWUSR, show_temp_max,
+	set_temp_max, 0);
+static SENSOR_DEVICE_ATTR(temp1_fault, S_IRUGO, show_temp_fault, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO, show_temp_min_alarm,
+	NULL, 0);
+static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_temp_max_alarm,
+	NULL, 0);
+
+static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 1);
+static SENSOR_DEVICE_ATTR(temp2_min, S_IRUGO | S_IWUSR, show_temp_min,
+	set_temp_min, 1);
+static SENSOR_DEVICE_ATTR(temp2_max, S_IRUGO | S_IWUSR, show_temp_max,
+	set_temp_max, 1);
+static SENSOR_DEVICE_ATTR(temp2_fault, S_IRUGO, show_temp_fault, NULL, 1);
+static SENSOR_DEVICE_ATTR(temp2_min_alarm, S_IRUGO, show_temp_min_alarm,
+	NULL, 1);
+static SENSOR_DEVICE_ATTR(temp2_max_alarm, S_IRUGO, show_temp_max_alarm,
+	NULL, 1);
+
+static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, show_temp, NULL, 2);
+static SENSOR_DEVICE_ATTR(temp3_min, S_IRUGO | S_IWUSR, show_temp_min,
+	set_temp_min, 2);
+static SENSOR_DEVICE_ATTR(temp3_max, S_IRUGO | S_IWUSR, show_temp_max,
+	set_temp_max, 2);
+static SENSOR_DEVICE_ATTR(temp3_fault, S_IRUGO, show_temp_fault, NULL, 2);
+static SENSOR_DEVICE_ATTR(temp3_min_alarm, S_IRUGO, show_temp_min_alarm,
+	NULL, 2);
+static SENSOR_DEVICE_ATTR(temp3_max_alarm, S_IRUGO, show_temp_max_alarm,
+	NULL, 2);
+
+static SENSOR_DEVICE_ATTR(temp4_input, S_IRUGO, show_temp, NULL, 3);
+static SENSOR_DEVICE_ATTR(temp4_min, S_IRUGO | S_IWUSR, show_temp_min,
+	set_temp_min, 3);
+static SENSOR_DEVICE_ATTR(temp4_max, S_IRUGO | S_IWUSR, show_temp_max,
+	set_temp_max, 3);
+static SENSOR_DEVICE_ATTR(temp4_fault, S_IRUGO, show_temp_fault, NULL, 3);
+static SENSOR_DEVICE_ATTR(temp4_min_alarm, S_IRUGO, show_temp_min_alarm,
+	NULL, 3);
+static SENSOR_DEVICE_ATTR(temp4_max_alarm, S_IRUGO, show_temp_max_alarm,
+	NULL, 3);
+
+static DEVICE_ATTR(fan1_input, S_IRUGO, show_fan, NULL);
+static DEVICE_ATTR(fan1_div, S_IRUGO | S_IWUSR, show_fan_div, set_fan_div);
+static DEVICE_ATTR(fan1_target, S_IRUGO | S_IWUSR, show_fan_target,
+	set_fan_target);
+static DEVICE_ATTR(fan1_fault, S_IRUGO, show_fan_fault, NULL);
+
+static DEVICE_ATTR(pwm1_enable, S_IRUGO | S_IWUSR, show_pwm_enable,
+	set_pwm_enable);
+
+/* sensors present on all models */
+static struct attribute *emc2103_attributes[] = {
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
+	&dev_attr_fan1_input.attr,
+	&dev_attr_fan1_div.attr,
+	&dev_attr_fan1_target.attr,
+	&dev_attr_fan1_fault.attr,
+	&dev_attr_pwm1_enable.attr,
+	NULL
+};
+
+/* extra temperature sensors only present on 2103-2 and 2103-4 */
+static struct attribute *emc2103_attributes_temp3[] = {
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
+static struct attribute *emc2103_attributes_temp4[] = {
+	&sensor_dev_attr_temp4_input.dev_attr.attr,
+	&sensor_dev_attr_temp4_min.dev_attr.attr,
+	&sensor_dev_attr_temp4_max.dev_attr.attr,
+	&sensor_dev_attr_temp4_fault.dev_attr.attr,
+	&sensor_dev_attr_temp4_min_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp4_max_alarm.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group emc2103_group = {
+	.attrs = emc2103_attributes,
+};
+
+static const struct attribute_group emc2103_temp3_group = {
+	.attrs = emc2103_attributes_temp3,
+};
+
+static const struct attribute_group emc2103_temp4_group = {
+	.attrs = emc2103_attributes_temp4,
+};
+
+static int
+emc2103_probe(struct i2c_client *client, const struct i2c_device_id *id)
+{
+	struct emc2103_data *data;
+	int status;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		return -EIO;
+
+	data = kzalloc(sizeof(struct emc2103_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, data);
+	mutex_init(&data->update_lock);
+
+	/* 2103-2 and 2103-4 have 3 external diodes, 2103-1 has 1 */
+	status = i2c_smbus_read_byte_data(client, REG_PRODUCT_ID);
+	if (status = 0x26)
+		data->temp_count = apd ? 4 : 3;
+	else
+		data->temp_count = 2;
+
+	if (data->temp_count >= 3) {
+		/* Configure anti-parallel diode mode. The device cannot detect
+		 * this itself so must be explicitly configured based on how
+		 * diodes are externally attached. Set the apd module parameter
+		 * to 0 if non-APD mode is required. */
+		status = i2c_smbus_read_byte_data(client, REG_CONF1);
+		if (status < 0) {
+			dev_dbg(&client->dev, "reg 0x%02x, err %d\n", REG_CONF1,
+				status);
+			goto exit_free;
+		}
+
+		if (data->temp_count = 4)
+			status |= 0x01;
+		else
+			status &= ~(0x01);
+
+		i2c_smbus_write_byte_data(client, REG_CONF1, status & 0xff);
+	}
+
+	/* Register sysfs hooks */
+	status = sysfs_create_group(&client->dev.kobj, &emc2103_group);
+	if (status)
+		goto exit_free;
+
+	if (data->temp_count >= 3) {
+		status = sysfs_create_group(&client->dev.kobj,
+			&emc2103_temp3_group);
+		if (status)
+			goto exit_remove;
+	}
+
+	if (data->temp_count = 4) {
+		status = sysfs_create_group(&client->dev.kobj,
+			&emc2103_temp4_group);
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
+	if (data->temp_count = 4)
+		sysfs_remove_group(&client->dev.kobj, &emc2103_temp4_group);
+exit_remove_temp3:
+	if (data->temp_count >= 3)
+		sysfs_remove_group(&client->dev.kobj, &emc2103_temp3_group);
+exit_remove:
+	sysfs_remove_group(&client->dev.kobj, &emc2103_group);
+exit_free:
+	kfree(data);
+	return status;
+}
+
+static int emc2103_remove(struct i2c_client *client)
+{
+	struct emc2103_data *data = i2c_get_clientdata(client);
+
+	hwmon_device_unregister(data->hwmon_dev);
+
+	if (data->temp_count = 4)
+		sysfs_remove_group(&client->dev.kobj, &emc2103_temp4_group);
+
+	if (data->temp_count >= 3)
+		sysfs_remove_group(&client->dev.kobj, &emc2103_temp3_group);
+
+	sysfs_remove_group(&client->dev.kobj, &emc2103_group);
+
+	kfree(data);
+	return 0;
+}
+
+static const struct i2c_device_id emc2103_ids[] = {
+	{ "emc2103", 0, },
+	{ /* LIST END */ }
+};
+MODULE_DEVICE_TABLE(i2c, emc2103_ids);
+
+/* Return 0 if detection is successful, -ENODEV otherwise */
+static int
+emc2103_detect(struct i2c_client *new_client, struct i2c_board_info *info)
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
+	strlcpy(info->type, "emc2103", I2C_NAME_SIZE);
+
+	return 0;
+}
+
+static struct i2c_driver emc2103_driver = {
+	.class		= I2C_CLASS_HWMON,
+	.driver = {
+		.name	= "emc2103",
+	},
+	.probe		= emc2103_probe,
+	.remove		= emc2103_remove,
+	.id_table	= emc2103_ids,
+	.detect		= emc2103_detect,
+	.address_list	= normal_i2c,
+};
+
+static int __init sensors_emc2103_init(void)
+{
+	return i2c_add_driver(&emc2103_driver);
+}
+
+static void __exit sensors_emc2103_exit(void)
+{
+	i2c_del_driver(&emc2103_driver);
+}
+
+MODULE_AUTHOR("Steve Glendinning <steve.glendinning@smsc.com>");
+MODULE_DESCRIPTION("SMSC EMC2103 hwmon driver");
+MODULE_LICENSE("GPL");
+
+module_init(sensors_emc2103_init);
+module_exit(sensors_emc2103_exit);
-- 
1.7.0.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
