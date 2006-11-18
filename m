From: dean@arctic.org (dean gaudet)
Date: Sat, 18 Nov 2006 04:48:59 +0000
Subject: [lm-sensors] [patch] incomplete mtp008.c port to 2.6.18.2
Message-Id: <Pine.LNX.4.64.0611172040300.15092@twinlark.arctic.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hi...

i've recently been resurrecting some tyan s2510 and would like to get 
their mtp008 working.  i found Andrew Pam's patch which brought mtp008 
forward to 2.6.12, but i'd like to run 2.6.18.2 or later.

so i went through the patch and compared it with other 2.6.18 hwmon 
drivers and without really any deep understanding made a bunch of changes 
which seem to have made it mostly work.

i have two problems:

- the lm-sensors userland code seems to expect temp?_over/temp?_hyst files 
for mtp008 but the driver has min/max... i patched lm-sensors for this, 
but maybe i should have fixed the driver instead.

- the mtp008 seems to hang and start reporting all zeroes/constant 
garbage.  i'm skeptical this is just my hacked code though because the 
BIOS "System Health Monitor" has the exact same problem after a few 
minutes.

so... does anyone happen to have a datasheet for this part?

or can anyone spot some obvious boneheadedness in my patch?

note i didn't do the up/down -> mutex conversion yet.

thanks
-dean
-------------- next part --------------
Index: linux/drivers/hwmon/Kconfig
=================================--- linux.orig/drivers/hwmon/Kconfig	2006-11-17 02:10:30.000000000 -0800
+++ linux/drivers/hwmon/Kconfig	2006-11-17 15:42:10.000000000 -0800
@@ -517,4 +517,14 @@
 	  a problem with I2C support and want to see more of what is going
 	  on.
 
+config SENSORS_MTP008
+	tristate "Myson MTP008 sensor chip"
+	depends on HWMON && I2C && EXPERIMENTAL
+	select HWMON_VID
+	help
+	  If you say yes here you get support for MTP008 sensor chips.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called mtp008.
+
 endmenu
Index: linux/drivers/hwmon/Makefile
=================================--- linux.orig/drivers/hwmon/Makefile	2006-11-17 02:10:30.000000000 -0800
+++ linux/drivers/hwmon/Makefile	2006-11-17 02:12:14.000000000 -0800
@@ -39,6 +39,7 @@
 obj-$(CONFIG_SENSORS_LM90)	+= lm90.o
 obj-$(CONFIG_SENSORS_LM92)	+= lm92.o
 obj-$(CONFIG_SENSORS_MAX1619)	+= max1619.o
+obj-$(CONFIG_SENSORS_MTP008)	+= mtp008.o
 obj-$(CONFIG_SENSORS_PC87360)	+= pc87360.o
 obj-$(CONFIG_SENSORS_SIS5595)	+= sis5595.o
 obj-$(CONFIG_SENSORS_SMSC47B397)+= smsc47b397.o
Index: linux/drivers/hwmon/mtp008.c
=================================--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/drivers/hwmon/mtp008.c	2006-11-17 02:12:31.000000000 -0800
@@ -0,0 +1,972 @@
+/*
+   mtp008.c - Part of lm_sensors, Linux kernel modules for hardware
+   monitoring
+   Copyright (C) 2001, 2004  Kris Van Hees <aedil at alchar.org>
+   Port to Linux 2.6 Copyright (C) 2005  Andrew Pam <andrew at sericyb.com.au>
+   Port to Linux 2.6.18 Copyright (C) 2006  dean gaudet <dean at arctic.org>
+
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License as published by
+   the Free Software Foundation; either version 2 of the License, or
+   (at your option) any later version.
+
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with this program; if not, write to the Free Software
+   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/hwmon.h>     /* for hardware monitoring drivers */
+#include <linux/hwmon-sysfs.h>
+#include <linux/hwmon-vid.h> /* if you need VRM support */
+#include <linux/init.h>
+#include <linux/jiffies.h>
+#include <linux/err.h>
+
+/* Addresses to scan */
+static unsigned short normal_i2c[] = {0x2c, 0x2d, 0x2e, I2C_CLIENT_END};
+
+/* Insmod parameters */
+I2C_CLIENT_INSMOD_1(mtp008);
+
+/* The MTP008 registers */
+/*      in0 .. in6 */
+#define MTP008_REG_IN(nr)		(0x20 + (nr))
+#define MTP008_REG_IN_MAX(nr)		(0x2b + (nr) * 2)
+#define MTP008_REG_IN_MIN(nr)		(0x2c + (nr) * 2)
+
+/*      temp1 */
+#define MTP008_REG_TEMP			0x27
+#define MTP008_REG_TEMP_MAX		0x39
+#define MTP008_REG_TEMP_MIN		0x3a
+
+/*      fan1 .. fan3 (nr is 0..2) */
+#define MTP008_REG_FAN(nr)		(0x28 + (nr))
+#define MTP008_REG_FAN_MIN(nr)		(0x3b + (nr))
+
+#define MTP008_REG_CONFIG		0x40
+#define MTP008_REG_INT_STAT1		0x41
+#define MTP008_REG_INT_STAT2		0x42
+
+#define MTP008_REG_VID_FANDIV		0x47
+
+#define MTP008_REG_I2C_ADDR		0x48
+
+#define MTP008_REG_RESET_VID4		0x49
+
+#define MTP008_REG_OVT_PROP		0x50
+
+#define MTP008_REG_BEEP_CTRL1		0x51
+#define MTP008_REG_BEEP_CTRL2		0x52
+
+/*      pwm1 .. pwm3 (nr is 0..2) */
+#define MTP008_REG_PWM_CTRL(nr)		(0x53 + (nr))
+
+#define MTP008_REG_PIN_CTRL1		0x56
+#define MTP008_REG_PIN_CTRL2		0x57
+
+#define MTP008_REG_CHIPID		0x58
+
+/*
+ * Pin control register configuration constants.
+ */
+#define MTP008_CFG_VT1_MASK		0x08
+#define MTP008_CFG_VT2_MASK		0x06
+#define MTP008_CFG_VT3_MASK		0x01
+
+/*
+ * Conversion routines and macros.  Limit checking is only done on
+ * the TO_REG variants.
+ */
+
+/* IN: mV, (0V to 4.08V)
+   REG: 16mV/bit */
+#define IN_TO_REG(val)		(SENSORS_LIMIT((((val) + 8) / 16), 0, 255))
+#define IN_FROM_REG(val)	((val) * 16)
+
+/*
+ * The fan rotation count (as stored in the register) is calculated using the
+ * following formula:
+ *      count = (22.5K * 60) / (rpm * div) = 1350000 / (rpm * div)
+ * and the rpm is therefore:
+ *      rpm = 1350000 / (count * div)
+ */
+static inline u8 FAN_TO_REG(long rpm, int div)
+{
+	if (rpm <= 0)
+		return 255;
+
+	return SENSORS_LIMIT( (1350000 + rpm * div / 2) / (rpm * div), 1, 254);
+}
+
+#define FAN_FROM_REG(val, div)	( (val) = 0 ? -1		\
+				: (val) = 255 ? 0		\
+			        : 1350000 / ((val) * (div))	\
+				)
+
+/* TEMP: mC (-128C to +127C)
+   REG: 1C/bit, two's complement */
+#define TEMP_TO_REG(val)	(					\
+				 ( (val) < 0 ? ((val) - 500)		\
+				 	     : ((val) + 500)		\
+			         ) / 1000				\
+				)
+#define TEMP_FROM_REG(val)	( (val) * 1000 )
+
+/* VID: mV
+ * REG: 0x00 to 0x0f    = 2.05 to 1.30 (0.05 per unit)
+ *      0x10 to 0x1e    = 3.50 to 2.10 (0.10 per unit)
+ *      0x1f            = No CPU
+ */
+#define VID_FROM_REG(val)	((val) = 0x1f				      \
+					 ? 0				      \
+					 : (val) < 0x10 ? 2050 - (val) * 50   \
+							: 5100 - (val) * 100)
+
+/*
+ * Fan divider.
+ */
+#define DIV_FROM_REG(val)	(1 << (val))
+
+/*
+ * PWM control.  (nr is 0..2)
+ */
+#define PWM_FROM_REG(val)	(val)
+#define PWM_TO_REG(val)		(SENSORS_LIMIT((val), 0, 255))
+#define PWMENABLE_FROM_REG(nr, val)	(((val) >> ((nr) + 4)) & 1)
+
+/* sysfs temperature sensor types	mtp008 sensor types
+ * 0: Not defined			0: Analog input (voltage)
+ * 1: PII/Celeron Diode			2: PII Diode
+ * 2: 3904 transistor
+ * 3: thermal diode			1: Thermistor
+ */
+#define SENS_FROM_REG(val)	((val) = 0 ? 0	: (val) = 1 ? 3 : 1)
+#define SENS_TO_REG(val)	((val) = 0 ? 0 : (val) = 1 ? 2 : 1)
+
+/*
+ * For each registered MTP008, we need to keep some data in memory.  The
+ * structure itself is dynamically allocated, at the same time when a new
+ * mtp008 client is allocated.
+ */
+struct mtp008_data {
+	struct i2c_client client;
+	struct class_device *class_dev;
+	struct semaphore update_lock;
+	char valid;				/* !=0 if fields are valid */
+	unsigned long last_updated;		/* In jiffies */
+
+	u8 in[7];				/* Register value */
+	u8 in_max[7];				/* Register value */
+	u8 in_min[7];				/* Register value */
+	s8 temp[3];				/* Register value */
+	s8 temp_max[3];				/* Register value */
+	s8 temp_min[3];				/* Register value */
+	u8 fan[3];				/* Register value */
+	u8 fan_min[3];				/* Register value */
+	u8 vid;					/* Register encoding */
+	u8 fan_div[3];				/* Register encoding */
+	u16 alarms;				/* Register encoding */
+	u16 beeps;				/* Register encoding */
+	u8 pwm[3];				/* Register value */
+	u8 sens[3];				/* 0 = Analog input,
+						   1 = Thermistor,
+						   2 = PII/Celeron diode */
+	u8 pwmenable;				/* Register 0x57 value */
+};
+
+static int mtp008_attach_adapter(struct i2c_adapter *adapter);
+static int mtp008_detect(struct i2c_adapter *adapter, int address, int kind);
+static int mtp008_detach_client(struct i2c_client *client);
+
+static struct mtp008_data *mtp008_update_device(struct device *dev);
+static void mtp008_init_client(struct i2c_client *client, struct mtp008_data *data);
+
+static struct i2c_driver mtp008_driver +{
+	.driver = {
+		.name	= "mtp008",
+	},
+	.id		= I2C_DRIVERID_MTP008,
+	.attach_adapter	= mtp008_attach_adapter,
+	.detach_client	= mtp008_detach_client,
+};
+
+/* 7 Voltages */
+static ssize_t show_in(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
+	struct mtp008_data *data = mtp008_update_device(dev);
+	return sprintf(buf, "%d\n", IN_FROM_REG(data->in[nr]));
+}
+
+static ssize_t show_in_max(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
+	struct mtp008_data *data = mtp008_update_device(dev);
+	return sprintf(buf, "%d\n", IN_FROM_REG(data->in_max[nr]));
+}
+
+static ssize_t show_in_min(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
+	struct mtp008_data *data = mtp008_update_device(dev);
+	return sprintf(buf, "%d\n", IN_FROM_REG(data->in_min[nr]));
+}
+
+static ssize_t set_in_min(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
+	struct i2c_client *client = to_i2c_client(dev);
+	struct mtp008_data *data = i2c_get_clientdata(client);
+	unsigned long val = simple_strtoul(buf, NULL, 10);
+
+	if ((nr != 4 && nr != 5) || data->sens[nr - 3] = 0) {
+		down(&data->update_lock);
+		data->in_min[nr] = IN_TO_REG(val);
+		i2c_smbus_write_byte_data(client, MTP008_REG_IN_MIN(nr),
+				data->in_min[nr]);
+		up(&data->update_lock);
+	}
+	return count;
+}
+
+static ssize_t set_in_max(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
+	struct i2c_client *client = to_i2c_client(dev);
+	struct mtp008_data *data = i2c_get_clientdata(client);
+	unsigned long val = simple_strtoul(buf, NULL, 10);
+
+	if ((nr != 4 && nr != 5) || data->sens[nr - 3] = 0) {
+		down(&data->update_lock);
+		data->in_max[nr] = IN_TO_REG(val);
+		i2c_smbus_write_byte_data(client, MTP008_REG_IN_MAX(nr),
+				data->in_max[nr]);
+		up(&data->update_lock);
+	}
+	return count;
+}
+
+#define GENERATE_IN_FUNCTIONS(offset)				\
+static SENSOR_DEVICE_ATTR(in##offset##_input, S_IRUGO, 		\
+		show_in, NULL, offset);				\
+static SENSOR_DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR,	\
+		show_in_min, set_in_min, offset);		\
+static SENSOR_DEVICE_ATTR(in##offset##_max, S_IRUGO | S_IWUSR,	\
+		show_in_max, set_in_max, offset);
+
+GENERATE_IN_FUNCTIONS(0);
+GENERATE_IN_FUNCTIONS(1);
+GENERATE_IN_FUNCTIONS(2);
+GENERATE_IN_FUNCTIONS(3);
+GENERATE_IN_FUNCTIONS(4);
+GENERATE_IN_FUNCTIONS(5);
+GENERATE_IN_FUNCTIONS(6);
+
+/* 3 Temperatures */
+static ssize_t show_temp(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
+	struct mtp008_data *data = mtp008_update_device(dev);
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[nr]));
+}
+
+static ssize_t show_temp_max(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
+	struct mtp008_data *data = mtp008_update_device(dev);
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_max[nr]));
+}
+
+static ssize_t show_temp_min(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
+	struct mtp008_data *data = mtp008_update_device(dev);
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_min[nr]));
+}
+static ssize_t set_temp_max(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
+	struct i2c_client *client = to_i2c_client(dev);
+	struct mtp008_data *data = i2c_get_clientdata(client);
+	long val = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
+	data->temp_max[nr] = TEMP_TO_REG(val);
+	if (nr = 0) {
+		i2c_smbus_write_byte_data(client, MTP008_REG_TEMP_MAX,
+				data->temp_max[nr]);
+	}
+	else if (data->sens[nr] != 0) {
+		i2c_smbus_write_byte_data(client, MTP008_REG_IN_MAX(nr + 3),
+				data->temp_max[nr]);
+	}
+	up(&data->update_lock);
+	return count;
+}
+static ssize_t set_temp_min(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
+	struct i2c_client *client = to_i2c_client(dev);
+	struct mtp008_data *data = i2c_get_clientdata(client);
+	long val = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
+	data->temp_min[nr] = TEMP_TO_REG(val);
+	if (nr = 0) {
+		i2c_smbus_write_byte_data(client, MTP008_REG_TEMP_MIN,
+				data->temp_min[nr]);
+	}
+	else if (data->sens[nr] != 0) {
+		i2c_smbus_write_byte_data(client, MTP008_REG_IN_MIN(nr + 3),
+				data->temp_min[nr]);
+	}
+	up(&data->update_lock);
+	return count;
+}
+
+#define GENERATE_TEMP_FUNCTIONS(offset)					\
+static SENSOR_DEVICE_ATTR(temp##offset##_input, S_IRUGO, 		\
+		show_temp, NULL, offset - 1);				\
+static SENSOR_DEVICE_ATTR(temp##offset##_min, S_IRUGO | S_IWUSR,	\
+		show_temp_min, set_temp_min, offset - 1);		\
+static SENSOR_DEVICE_ATTR(temp##offset##_max, S_IRUGO | S_IWUSR,	\
+		show_temp_max, set_temp_max, offset - 1);
+
+GENERATE_TEMP_FUNCTIONS(1);
+GENERATE_TEMP_FUNCTIONS(2);
+GENERATE_TEMP_FUNCTIONS(3);
+
+/* 3 Fans */
+static ssize_t show_fan(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
+	struct mtp008_data *data = mtp008_update_device(dev);
+	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[nr],
+		DIV_FROM_REG(data->fan_div[nr])) );
+}
+static ssize_t show_fan_min(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
+	struct mtp008_data *data = mtp008_update_device(dev);
+	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan_min[nr],
+		DIV_FROM_REG(data->fan_div[nr])) );
+}
+static ssize_t show_fan_div(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
+	struct mtp008_data *data = mtp008_update_device(dev);
+	return sprintf(buf, "%d\n", DIV_FROM_REG(data->fan_div[nr]) );
+}
+static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
+	struct i2c_client *client = to_i2c_client(dev);
+	struct mtp008_data *data = i2c_get_clientdata(client);
+	unsigned long val = simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
+	data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
+	i2c_smbus_write_byte_data(client, MTP008_REG_FAN_MIN(nr),
+			data->fan_min[nr]);
+	up(&data->update_lock);
+	return count;
+}
+
+/* Note: we save and restore the fan minimum here, because its value is
+   determined in part by the fan divisor.  This follows the principle of
+   least suprise; the user doesn't expect the fan minimum to change just
+   because the divisor changed. */
+static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
+	struct i2c_client *client = to_i2c_client(dev);
+	struct mtp008_data *data = i2c_get_clientdata(client);
+	unsigned long val = simple_strtoul(buf, NULL, 10);
+	unsigned long min;
+	u8 reg;
+
+	down(&data->update_lock);
+	min = FAN_FROM_REG(data->fan_min[nr],
+			   DIV_FROM_REG(data->fan_div[nr]));
+
+	switch (val) {
+	case 1: data->fan_div[nr] = 0; break;
+	case 2: data->fan_div[nr] = 1; break;
+	case 4: data->fan_div[nr] = 2; break;
+	case 8: data->fan_div[nr] = 3; break;
+	default:
+		dev_err(&client->dev, "fan_div value %ld not "
+			"supported. Choose one of 1, 2, 4 or 8!\n", val);
+		up(&data->update_lock);
+		return -EINVAL;
+	}
+
+	switch (nr) {
+	case 0:
+		reg = i2c_smbus_read_byte_data(client, MTP008_REG_VID_FANDIV);
+		reg = (reg & 0xcf) | ((data->fan_div[nr] & 0x03) << 4);
+		i2c_smbus_write_byte_data(client, MTP008_REG_VID_FANDIV, reg);
+		break;
+	case 1:
+		reg = i2c_smbus_read_byte_data(client, MTP008_REG_VID_FANDIV);
+		reg = (reg & 0x3f) | ((data->fan_div[nr] & 0x03) << 6);
+		i2c_smbus_write_byte_data(client, MTP008_REG_VID_FANDIV, reg);
+		break;
+	case 2:
+		reg = i2c_smbus_read_byte_data(client, MTP008_REG_PIN_CTRL1);
+		reg = (reg & 0x3f) | ((data->fan_div[nr] & 0x03) << 6);
+		i2c_smbus_write_byte_data(client, MTP008_REG_PIN_CTRL1, reg);
+		break;
+	}
+
+	data->fan_min[nr] +		FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
+	i2c_smbus_write_byte_data(client, MTP008_REG_FAN_MIN(nr),
+			data->fan_min[nr]);
+	up(&data->update_lock);
+
+	return count;
+}
+
+#define GENERATE_FAN_FUNCTIONS(offset)					\
+static SENSOR_DEVICE_ATTR(fan##offset##_input, S_IRUGO,			\
+		show_fan, NULL, offset - 1); 				\
+static SENSOR_DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR,		\
+		show_fan_min, set_fan_min, offset - 1);			\
+static SENSOR_DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR,		\
+		show_fan_div, set_fan_div, offset - 1);
+
+GENERATE_FAN_FUNCTIONS(1);
+GENERATE_FAN_FUNCTIONS(2);
+GENERATE_FAN_FUNCTIONS(3);
+
+/* VID */
+static ssize_t show_vid(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct mtp008_data *data = mtp008_update_device(dev);
+	return sprintf(buf, "%d\n", VID_FROM_REG(data->vid));
+}
+static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
+
+/* Alarms */
+static ssize_t show_alarms(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct mtp008_data *data = mtp008_update_device(dev);
+	return sprintf(buf, "%u\n", data->alarms);
+}
+static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
+
+/* Beeps */
+static ssize_t show_beeps(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct mtp008_data *data = mtp008_update_device(dev);
+	return sprintf(buf, "%u\n", data->beeps);
+}
+
+static ssize_t set_beeps(struct device *dev, struct device_attribute *attr, const char *buf,
+			size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct mtp008_data *data = i2c_get_clientdata(client);
+	unsigned long val = simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
+	data->beeps = val & 0xdf8f;
+	i2c_smbus_write_byte_data(client, MTP008_REG_BEEP_CTRL1,
+			data->beeps & 0xff);
+	i2c_smbus_write_byte_data(client, MTP008_REG_BEEP_CTRL2,
+			data->beeps >> 8);
+	up(&data->update_lock);
+	return count;
+}
+static DEVICE_ATTR(beep_mask, S_IRUGO | S_IWUSR, show_beeps, set_beeps);
+
+/* 3 PWM fan speed controls */
+static ssize_t show_pwm(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
+	struct mtp008_data *data = mtp008_update_device(dev);
+	return sprintf(buf, "%d\n", PWM_FROM_REG(data->pwm[nr]));
+}
+static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
+	struct i2c_client *client = to_i2c_client(dev);
+	struct mtp008_data *data = i2c_get_clientdata(client);
+	unsigned long val = simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
+	data->pwm[nr] = PWM_TO_REG(val);
+	i2c_smbus_write_byte_data(client, MTP008_REG_PWM_CTRL(nr),
+			data->pwm[nr]);
+	up(&data->update_lock);
+	return count;
+}
+static ssize_t show_pwm_enable(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
+	struct mtp008_data *data = mtp008_update_device(dev);
+	return sprintf(buf, "%d\n", PWMENABLE_FROM_REG(nr, data->pwmenable));
+}
+static ssize_t set_pwm_enable(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
+	struct i2c_client *client = to_i2c_client(dev);
+	struct mtp008_data *data = i2c_get_clientdata(client);
+	unsigned long val = simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
+	if (val)
+		data->pwmenable |= (0x10 << nr);
+	else
+		data->pwmenable &= ~(0x10 << nr);
+	i2c_smbus_write_byte_data(client, MTP008_REG_PIN_CTRL2,
+			data->pwmenable);
+	up(&data->update_lock);
+	return count;
+}
+
+#define GENERATE_PWM_FUNCTIONS(offset)					\
+static SENSOR_DEVICE_ATTR(pwm##offset, S_IRUGO | S_IWUSR,		\
+		show_pwm, set_pwm, offset - 1);				\
+static SENSOR_DEVICE_ATTR(pwm##offset##_enable, S_IRUGO | S_IWUSR,	\
+		show_pwm_enable, set_pwm_enable, offset - 1);
+
+GENERATE_PWM_FUNCTIONS(1);
+GENERATE_PWM_FUNCTIONS(2);
+GENERATE_PWM_FUNCTIONS(3);
+
+/* 3 Sensor type selections */
+static ssize_t show_sensor(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
+	struct mtp008_data *data = mtp008_update_device(dev);
+	return sprintf(buf, "%d\n", SENS_FROM_REG(data->sens[nr]));
+}
+static ssize_t set_sensor(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
+	struct i2c_client *client = to_i2c_client(dev);
+	struct mtp008_data *data = i2c_get_clientdata(client);
+	unsigned long val = simple_strtoul(buf, NULL, 10);
+	u8 reg, mask, bits;
+
+	mask = (nr = 0) ? MTP008_CFG_VT1_MASK
+			 : (nr = 1) ? MTP008_CFG_VT2_MASK
+			 	     : MTP008_CFG_VT3_MASK;
+	bits = SENS_TO_REG(val) << ((2 - nr) + 1);
+
+	if ( (val = 0)				/* Undefined */
+	     || (data->sens[nr] = 0)		/* Voltage sensor */
+	     || ((bits & ~mask) != 0)		/* Invalid setting */
+	   )
+		dev_err(&client->dev,
+			"Invalid sensor type %ld for sensor %d.\n",
+			val, nr + 1);
+	else {
+		down(&data->update_lock);
+		data->sens[nr] = SENS_TO_REG(val);
+		reg = (i2c_smbus_read_byte_data(client, MTP008_REG_PIN_CTRL2)
+			& ~mask) | bits;
+		i2c_smbus_write_byte_data(client, MTP008_REG_PIN_CTRL2, reg);
+		up(&data->update_lock);
+	}
+	return count;
+}
+
+#define GENERATE_SENS_FUNCTIONS(offset)					\
+static SENSOR_DEVICE_ATTR(temp##offset##_type, S_IRUGO | S_IWUSR,	\
+		show_sensor, set_sensor, offset - 1);
+
+GENERATE_SENS_FUNCTIONS(1);
+GENERATE_SENS_FUNCTIONS(2);
+GENERATE_SENS_FUNCTIONS(3);
+
+
+/* This function is called when:
+ * mtp008_driver is inserted (when this module is loaded), for each available
+ * adapter when a new adapter is inserted (and mtp008_driver is still present)
+ */
+static int mtp008_attach_adapter(struct i2c_adapter *adapter)
+{
+	if (!(adapter->class & I2C_CLASS_HWMON))
+		return 0;
+	return i2c_probe(adapter, &addr_data, mtp008_detect);
+}
+
+static int mtp008_detect(struct i2c_adapter *adapter, int address, int kind)
+{
+	int err, i;
+	struct i2c_client *new_client;
+	struct mtp008_data *data;
+
+	err = 0;
+
+	/*
+	 * We presume we have a valid client.  We now create the client
+	 * structure, even though we cannot fill it completely yet.  But it
+	 * allows us to use mtp008_(read|write)_value().
+	 */
+	if (!(data = kzalloc(sizeof(struct mtp008_data), GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	new_client = &data->client;
+	i2c_set_clientdata(new_client, data);
+	new_client->addr = address;
+	new_client->adapter = adapter;
+	new_client->driver = &mtp008_driver;
+	new_client->flags = 0;
+
+	/* Remaining detection. */
+	if ((kind < 0)
+	    && (i2c_smbus_read_byte_data(new_client, MTP008_REG_CHIPID) != 0xac
+		|| i2c_smbus_read_byte_data(new_client, MTP008_REG_I2C_ADDR)
+			!= address)
+	   ) {
+		err = -ENODEV;
+		goto exit_free;
+	}
+
+	/*
+	 * Fill in the remaining client fields and put it into the global list.
+	 */
+	strlcpy(new_client->name, "mtp008", I2C_NAME_SIZE);
+	data->valid = 0;
+	init_MUTEX(&data->update_lock);
+
+	/* Tell the I2C layer that a new client has arrived. */
+	if ((err = i2c_attach_client(new_client)))
+		goto exit_free;
+
+	/* Initialize the MTP008 chip. */
+	mtp008_init_client(new_client, data);
+
+	/* A few vars need to be filled upon startup */
+	for (i = 0; i < 3; i++) {
+		data->fan_min[i] = i2c_smbus_read_byte_data(new_client,
+					MTP008_REG_FAN_MIN(i));
+	}
+
+	/* Register sysfs hooks */
+        data->class_dev = hwmon_device_register(&new_client->dev);
+        if (IS_ERR(data->class_dev)) {
+                err = PTR_ERR(data->class_dev);
+                goto exit_detach;
+        }
+
+	device_create_file(&new_client->dev, &sensor_dev_attr_in0_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in0_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in0_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in1_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in1_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in1_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in2_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in2_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in2_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in3_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in3_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in3_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in4_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in4_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in4_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in5_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in5_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in5_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in6_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in6_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in6_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp1_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp1_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp1_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp1_type.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp2_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp2_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp2_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp2_type.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp3_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp3_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp3_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp3_type.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan1_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan1_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan1_div.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan2_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan2_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan2_div.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan3_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan3_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan3_div.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_pwm1.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_pwm1_enable.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_pwm2.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_pwm2_enable.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_pwm3.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_pwm3_enable.dev_attr);
+	device_create_file(&new_client->dev, &dev_attr_alarms);
+	device_create_file(&new_client->dev, &dev_attr_beep_mask);
+	device_create_file(&new_client->dev, &dev_attr_cpu0_vid);
+
+	return 0;
+
+exit_detach:
+	i2c_detach_client(new_client);
+exit_free:
+	kfree(data);
+exit:
+	return err;
+}
+
+static int mtp008_detach_client(struct i2c_client *client)
+{
+	struct mtp008_data *data = i2c_get_clientdata(client);
+	int err;
+
+        hwmon_device_unregister(data->class_dev);
+
+	if ((err = i2c_detach_client(client))) {
+		dev_err(&client->dev,
+		    "Client deregistration failed, client not detached.\n");
+		return err;
+	}
+
+	kfree(i2c_get_clientdata(client));
+
+	return 0;
+}
+
+static void mtp008_getsensortype(struct mtp008_data *data, u8 inp)
+{
+	inp &= 0x0f;
+	data->sens[0] = (inp >> 3) + 1;		/* 1 or 2 */
+	data->sens[1] = (inp >> 1) & 0x03;	/* 0, 1 or 2 */
+	data->sens[2] = inp & 0x01;		/* 0 or 1 */
+}
+
+/* Called when we have found a new MTP008. */
+static void mtp008_init_client(struct i2c_client *client, struct mtp008_data *data)
+{
+	mtp008_getsensortype(data, i2c_smbus_read_byte_data(client,
+				MTP008_REG_PIN_CTRL2) );
+
+	/* Start monitoring. */
+	i2c_smbus_write_byte_data(
+		client, MTP008_REG_CONFIG,
+		(i2c_smbus_read_byte_data(client, MTP008_REG_CONFIG) & 0xf7)
+		| 0x01
+	);
+}
+
+static struct mtp008_data *mtp008_update_device(struct device *dev)
+{
+	int i;
+	u8 inp;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct mtp008_data *data = i2c_get_clientdata(client);
+
+	down(&data->update_lock);
+
+	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
+	    || !data->valid) {
+
+		dev_dbg(&client->dev, "Starting mtp008 update\n");
+
+		/*
+		 * Read in the analog inputs.  We're reading AIN4 and AIN5 as
+		 * regular analog inputs, even though they may have been
+		 * configured as temperature readings instead.  Interpretation
+		 * of these values is done below.
+		 */
+		for (i = 0; i < 7; i++) {
+			data->in[i] +				i2c_smbus_read_byte_data(client,
+						MTP008_REG_IN(i));
+			data->in_max[i] +				i2c_smbus_read_byte_data(client,
+						MTP008_REG_IN_MAX(i));
+			data->in_min[i] +				i2c_smbus_read_byte_data(client,
+						MTP008_REG_IN_MIN(i));
+		}
+
+		/* Read the temperature sensor. */
+		data->temp[0] = i2c_smbus_read_byte_data(client,
+				MTP008_REG_TEMP);
+		data->temp_max[0] = i2c_smbus_read_byte_data(client,
+				MTP008_REG_TEMP_MAX);
+		data->temp_min[0] = i2c_smbus_read_byte_data(client,
+				MTP008_REG_TEMP_MIN);
+
+		/*
+		 * Read the first 2 fan dividers and the VID setting.  Read the
+		 * third fan divider from a different register.
+		 */
+		inp = i2c_smbus_read_byte_data(client, MTP008_REG_VID_FANDIV);
+		data->vid = inp & 0x0f;
+		data->vid |= (i2c_smbus_read_byte_data(client,
+				MTP008_REG_RESET_VID4) & 0x01) << 4;
+
+		data->fan_div[0] = (inp >> 4) & 0x03;
+		data->fan_div[1] = inp >> 6;
+		data->fan_div[2] = i2c_smbus_read_byte_data(client,
+				MTP008_REG_PIN_CTRL1) >> 6;
+
+		/* Read the interrupt status registers. */
+		data->alarms +			(i2c_smbus_read_byte_data(client,
+					   MTP008_REG_INT_STAT1) & 0xdf) |
+			(i2c_smbus_read_byte_data(client,
+					   MTP008_REG_INT_STAT2) & 0x0f) << 8;
+
+		/* Read the beep control registers. */
+		data->beeps +			(i2c_smbus_read_byte_data(client,
+					   MTP008_REG_BEEP_CTRL1) & 0xdf) |
+			(i2c_smbus_read_byte_data(client,
+					   MTP008_REG_BEEP_CTRL2) & 0x8f) << 8;
+
+		/* Read the sensor configuration. */
+		inp = i2c_smbus_read_byte_data(client, MTP008_REG_PIN_CTRL2);
+		mtp008_getsensortype(data, inp);
+		data->pwmenable = inp;
+
+		/* Deal with the configuration of sensors 2 and 3. */
+		for (i = 1; i < 3; i++)
+			if (data->sens[i] = 0) {	/* Voltage */
+				data->temp[i] = 0;
+				data->temp_max[i] = 0;
+				data->temp_min[i] = 0;
+			}
+			else {
+				data->temp[i] = data->in[i + 3];
+				data->in[i + 3] = 0;
+				data->temp_max[i] = data->in_max[i + 3];
+				data->in_max[i + 3] = 0;
+				data->temp_min[i] = data->in_min[i + 3];
+				data->in_min[i + 3] = 0;
+			}
+
+		/* Read the PWM registers if enabled. */
+		for (i = 0; i < 3; i++) {
+			if(PWMENABLE_FROM_REG(i, inp))
+				data->pwm[i] = i2c_smbus_read_byte_data(client,
+						  MTP008_REG_PWM_CTRL(i));
+			else
+				data->pwm[i] = 255;
+		}
+
+		/* Read the fan sensors. Skip 3 if PWM1 enabled. */
+		for (i = 0; i < 3; i++) {
+			if (i = 2 && PWMENABLE_FROM_REG(0, inp)) {
+				data->fan[2] = 0;
+				data->fan_min[2] = 0;
+			} else {
+				data->fan[i] = i2c_smbus_read_byte_data(client,
+					  MTP008_REG_FAN(i));
+				data->fan_min[i] +					i2c_smbus_read_byte_data(client,
+					  MTP008_REG_FAN_MIN(i));
+			}
+		}
+
+		data->last_updated = jiffies;
+		data->valid = 1;
+	}
+	up(&data->update_lock);
+
+	return data;
+}
+
+static int __init sm_mtp008_init(void)
+{
+	return i2c_add_driver(&mtp008_driver);
+}
+
+static void __exit sm_mtp008_exit(void)
+{
+	i2c_del_driver(&mtp008_driver);
+}
+
+
+
+MODULE_AUTHOR("Kris Van Hees <aedil at alchar.org> "
+	      "and Andrew Pam <andrew at sericyb.com.au>");
+MODULE_DESCRIPTION("MTP008 driver");
+MODULE_LICENSE("GPL");
+
+module_init(sm_mtp008_init);
+module_exit(sm_mtp008_exit);
-------------- next part --------------
Index: lm-sensors-2.10.1/lib/chips.c
=================================--- lm-sensors-2.10.1.orig/lib/chips.c	2006-11-17 01:52:27.000000000 -0800
+++ lm-sensors-2.10.1/lib/chips.c	2006-11-17 01:53:44.000000000 -0800
@@ -4197,22 +4197,22 @@
                         R, MTP008_SYSCTL_TEMP2, VALUE(3), 1 },
     { SENSORS_MTP008_TEMP3, "temp3", NOMAP, NOMAP,
                         R, MTP008_SYSCTL_TEMP3, VALUE(3), 1 },
-    { SENSORS_MTP008_TEMP1_OVER, "temp1_over", SENSORS_MTP008_TEMP1,
+    { SENSORS_MTP008_TEMP1_MAX, "temp1_max", SENSORS_MTP008_TEMP1,
 			SENSORS_MTP008_TEMP1, RW,
 			MTP008_SYSCTL_TEMP1, VALUE(1), 1 },
-    { SENSORS_MTP008_TEMP2_OVER, "temp2_over", SENSORS_MTP008_TEMP2,
+    { SENSORS_MTP008_TEMP2_MAX, "temp2_max", SENSORS_MTP008_TEMP2,
 			SENSORS_MTP008_TEMP2, RW,
 			MTP008_SYSCTL_TEMP2, VALUE(1), 1 },
-    { SENSORS_MTP008_TEMP3_OVER, "temp3_over", SENSORS_MTP008_TEMP3,
+    { SENSORS_MTP008_TEMP3_MAX, "temp3_max", SENSORS_MTP008_TEMP3,
 			SENSORS_MTP008_TEMP3, RW,
 			MTP008_SYSCTL_TEMP3, VALUE(1), 1 },
-    { SENSORS_MTP008_TEMP1_HYST, "temp1_hyst", SENSORS_MTP008_TEMP1,
+    { SENSORS_MTP008_TEMP1_MIN, "temp1_min", SENSORS_MTP008_TEMP1,
 			SENSORS_MTP008_TEMP1, RW,
 			MTP008_SYSCTL_TEMP1, VALUE(2), 1 },
-    { SENSORS_MTP008_TEMP2_HYST, "temp2_hyst", SENSORS_MTP008_TEMP2,
+    { SENSORS_MTP008_TEMP2_MIN, "temp2_min", SENSORS_MTP008_TEMP2,
 			SENSORS_MTP008_TEMP2, RW,
 			MTP008_SYSCTL_TEMP2, VALUE(2), 1 },
-    { SENSORS_MTP008_TEMP3_HYST, "temp3_hyst", SENSORS_MTP008_TEMP3,
+    { SENSORS_MTP008_TEMP3_MIN, "temp3_min", SENSORS_MTP008_TEMP3,
 			SENSORS_MTP008_TEMP3, RW,
 			MTP008_SYSCTL_TEMP3, VALUE(2), 1 },
     { SENSORS_MTP008_VID, "vid", NOMAP, NOMAP,
Index: lm-sensors-2.10.1/lib/chips.h
=================================--- lm-sensors-2.10.1.orig/lib/chips.h	2006-11-17 01:52:28.000000000 -0800
+++ lm-sensors-2.10.1/lib/chips.h	2006-11-17 01:54:04.000000000 -0800
@@ -1494,12 +1494,12 @@
 #define SENSORS_MTP008_TEMP1           51 /* R */
 #define SENSORS_MTP008_TEMP2           52 /* R */
 #define SENSORS_MTP008_TEMP3           53 /* R */
-#define SENSORS_MTP008_TEMP1_OVER      54 /* RW */
-#define SENSORS_MTP008_TEMP1_HYST      55 /* RW */
-#define SENSORS_MTP008_TEMP2_OVER      56 /* RW */
-#define SENSORS_MTP008_TEMP2_HYST      57 /* RW */
-#define SENSORS_MTP008_TEMP3_OVER      58 /* RW */
-#define SENSORS_MTP008_TEMP3_HYST      59 /* RW */
+#define SENSORS_MTP008_TEMP1_MAX       54 /* RW */
+#define SENSORS_MTP008_TEMP1_MIN       55 /* RW */
+#define SENSORS_MTP008_TEMP2_MAX       56 /* RW */
+#define SENSORS_MTP008_TEMP2_MIN       57 /* RW */
+#define SENSORS_MTP008_TEMP3_MAX       58 /* RW */
+#define SENSORS_MTP008_TEMP3_MIN       59 /* RW */
 #define SENSORS_MTP008_VID             61 /* R */
 #define SENSORS_MTP008_FAN1_DIV        71 /* RW */
 #define SENSORS_MTP008_FAN2_DIV        72 /* RW */
Index: lm-sensors-2.10.1/prog/sensors/chips.c
=================================--- lm-sensors-2.10.1.orig/prog/sensors/chips.c	2006-11-17 01:52:27.000000000 -0800
+++ lm-sensors-2.10.1/prog/sensors/chips.c	2006-11-17 02:03:29.000000000 -0800
@@ -2136,11 +2136,11 @@
 
   if (!sensors_get_label_and_valid(*name,SENSORS_MTP008_TEMP1,&label,&valid) &&
       !sensors_get_feature(*name,SENSORS_MTP008_TEMP1,&cur) &&
-      !sensors_get_feature(*name,SENSORS_MTP008_TEMP1_HYST,&min) &&
-      !sensors_get_feature(*name,SENSORS_MTP008_TEMP1_OVER,&max)) {
+      !sensors_get_feature(*name,SENSORS_MTP008_TEMP1_MIN,&min) &&
+      !sensors_get_feature(*name,SENSORS_MTP008_TEMP1_MAX,&max)) {
     if (valid) {
       print_label(label,10);
-      print_temp_info( cur, max, min, HYST, 0, 0);
+      print_temp_info( cur, max, min, MINMAX, 0, 0);
       printf(" %s\n", alarms&MTP008_ALARM_TEMP1?"ALARM":"");
     }
   } else
@@ -2149,11 +2149,11 @@
 
   if (!sensors_get_label_and_valid(*name,SENSORS_MTP008_TEMP2,&label,&valid) &&
       !sensors_get_feature(*name,SENSORS_MTP008_TEMP2,&cur) &&
-      !sensors_get_feature(*name,SENSORS_MTP008_TEMP2_HYST,&min) &&
-      !sensors_get_feature(*name,SENSORS_MTP008_TEMP2_OVER,&max)) {
+      !sensors_get_feature(*name,SENSORS_MTP008_TEMP2_MIN,&min) &&
+      !sensors_get_feature(*name,SENSORS_MTP008_TEMP2_MAX,&max)) {
     if (valid) {
       print_label(label,10);
-      print_temp_info( cur, max, min, HYST, 0, 0);
+      print_temp_info( cur, max, min, MINMAX, 0, 0);
       printf(" %s\n", alarms&MTP008_ALARM_TEMP2?"ALARM":"");
     }
   } else
@@ -2162,11 +2162,11 @@
 
   if (!sensors_get_label_and_valid(*name,SENSORS_MTP008_TEMP3,&label,&valid) &&
       !sensors_get_feature(*name,SENSORS_MTP008_TEMP3,&cur) &&
-      !sensors_get_feature(*name,SENSORS_MTP008_TEMP3_HYST,&min) &&
-      !sensors_get_feature(*name,SENSORS_MTP008_TEMP3_OVER,&max)) {
+      !sensors_get_feature(*name,SENSORS_MTP008_TEMP3_MIN,&min) &&
+      !sensors_get_feature(*name,SENSORS_MTP008_TEMP3_MAX,&max)) {
     if (valid) {
       print_label(label,10);
-      print_temp_info( cur, max, min, HYST, 0, 0);
+      print_temp_info( cur, max, min, MINMAX, 0, 0);
       printf(" %s\n", alarms&MTP008_ALARM_TEMP3?"ALARM":"");
     }
   } else
