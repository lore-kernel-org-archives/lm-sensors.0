From: maartendeprez@scarlet.be (maartendeprez@scarlet.be)
Date: Thu, 19 May 2005 06:25:34 +0000
Subject: GL520SM driver
Message-Id: <20050131111856.GA587@frans.deprez-aerts.dyndns.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050127104814.GA840@frans.deprez-aerts.dyndns.org>
In-Reply-To: <20050127104814.GA840@frans.deprez-aerts.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean,

I rewrote the code, patches to linux and lm_sensors2 (cvs) attached. The two_temps file is now implemented as a module parameter (default is autodetect, so: what the BIOS thinks). For the autodetection: the revision register isn't zero for me, so that cannot be used.

The driver reports that my fan1 is at 8000 RPM while BIOS setup monitor utility says 4000 RPM, i don't know which is right (could be useful to know that this fan is cooling a 667MHz pentium 3 cpu)? Maybe fan_div is interpreted wrong by the driver?
I don't know what fan1_off is, at least it doesn't turn off my fan.

Dump (in word mode because some registers are words) attached.

Maybe we should also send this to the one who was writing a driver so he can check and test it?

Should i send the linux patches (m7101 unhideing and gl520sm driver) for inclusion in the kernel?

Maarten
-------------- next part --------------
     0,8  1,9  2,a  3,b  4,c  5,d  6,e  7,f
00: 0020 0080 0000 0040 00a5 00b4 0000 003d 
08: f0f0 a8b3 8aa3 6f79 cadb 005b 00a5 0050 
10: 0000 0000 00d8 009e 00b2 00d9 0000 00b4 
18: 0000 0000 0000 0000 0000 0000 0000 0000 
20: 0000 0000 0000 0000 0000 0000 0000 0000 
28: 0000 0000 0000 0000 0000 0000 0000 0000 
30: 0000 0000 0000 0000 0000 0000 0000 0000 
38: 0000 0000 0000 0000 0000 0000 0000 0000 
40: 0000 0000 0000 0000 0000 0000 0000 0000 
48: 0000 0000 0000 0000 0000 0000 0000 0000 
50: 0000 0000 0000 0000 0000 0000 0000 0000 
58: 0000 0000 0000 0000 0000 0000 0000 0000 
60: 0000 0000 0000 0000 0000 0000 0000 0000 
68: 0000 0000 0000 0000 0000 0000 0000 0000 
70: 0000 0000 0000 0000 0000 0000 0000 0000 
78: 0000 0000 0000 0000 0000 0000 0000 0000 
80: 0000 0000 0000 0000 0000 0000 0000 0000 
88: 0000 0000 0000 0000 0000 0000 0000 0000 
90: 0000 0000 0000 0000 0000 0000 0000 0000 
98: 0000 0000 0000 0000 0000 0000 0000 0000 
a0: 0000 0000 0000 0000 0000 0000 0000 0000 
a8: 0000 0000 0000 0000 0000 0000 0000 0000 
b0: 0000 0000 0000 0000 0000 0000 0000 0000 
b8: 0000 0000 0000 0000 0000 0000 0000 0000 
c0: 0000 0000 0000 0000 0000 0000 0000 0000 
c8: 0000 0000 0000 0000 0000 0000 0000 0000 
d0: 0000 0000 0000 0000 0000 0000 0000 0000 
d8: 0000 0000 0000 0000 0000 0000 0000 0000 
e0: 0000 0000 0000 0000 0000 0000 0000 0000 
e8: 0000 0000 0000 0000 0000 0000 0000 0000 
f0: 0000 0000 0000 0000 0000 0000 0000 0000 
f8: 0000 0000 0000 0000 0000 0000 0000 0000 
-------------- next part --------------
--- linux-2.6.11-rc2-mm1/drivers/i2c/chips/Kconfig.orig	2005-01-28 10:25:57.000000000 +0100
+++ linux-2.6.11-rc2-mm1/drivers/i2c/chips/Kconfig	2005-01-29 14:23:44.000000000 +0100
@@ -106,6 +106,17 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called gl518sm.
 
+config SENSORS_GL520SM
+	tristate "Genesys Logic GL520SM"
+	depends on I2C && EXPERIMENTAL
+	select I2C_SENSOR
+	help
+	  If you say yes here you get support for Genesys Logic GL520SM
+	  sensor chips.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called gl520sm.
+
 config SENSORS_IT87
 	tristate "ITE IT87xx and compatibles"
 	depends on I2C && EXPERIMENTAL
--- linux-2.6.11-rc2-mm1/drivers/i2c/chips/Makefile.orig	2005-01-28 10:25:57.000000000 +0100
+++ linux-2.6.11-rc2-mm1/drivers/i2c/chips/Makefile	2005-01-29 14:23:44.000000000 +0100
@@ -16,6 +16,7 @@
 obj-$(CONFIG_SENSORS_FSCHER)	+= fscher.o
 obj-$(CONFIG_SENSORS_FSCPOS)	+= fscpos.o
 obj-$(CONFIG_SENSORS_GL518SM)	+= gl518sm.o
+obj-$(CONFIG_SENSORS_GL520SM)	+= gl520sm.o
 obj-$(CONFIG_SENSORS_IT87)	+= it87.o
 obj-$(CONFIG_SENSORS_LM63)	+= lm63.o
 obj-$(CONFIG_SENSORS_LM75)	+= lm75.o
--- linux-2.6.11-rc2-mm1/drivers/i2c/chips/gl520sm.c.orig	2005-01-29 19:55:44.000000000 +0100
+++ linux-2.6.11-rc2-mm1/drivers/i2c/chips/gl520sm.c	2005-01-31 12:07:41.000000000 +0100
@@ -0,0 +1,749 @@
+/*
+    gl520sm.c - Part of lm_sensors, Linux kernel modules for hardware
+                monitoring
+    Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>,
+                              Ky?sti M?lkki <kmalkki@cc.hut.fi>
+    Copyright (c) 2005        Maarten Deprez <maartendeprez@users.sourceforge.net>
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
+
+*/
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/i2c-sensor.h>
+#include <linux/i2c-vid.h>
+
+/* Type of the extra sensor */
+static unsigned short extra_sensor_type = 0;
+module_param(extra_sensor_type, ushort, 0);
+MODULE_PARM_DESC(extra_sensor_type, "Type of extra sensor (0=autodetect, 1=temperature, 2=voltage)");
+
+/* Addresses to scan */
+static unsigned short normal_i2c[] = { 0x2c, 0x2d, I2C_CLIENT_END };
+static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
+
+/* Insmod parameters */
+SENSORS_INSMOD_1(gl520sm);
+
+/* Many GL520 constants specified below 
+One of the inputs can be configured as either temp or voltage.
+That's why _TEMP2 and _IN4 access the same register 
+*/
+
+/* The GL520 registers */
+#define GL520_REG_CHIP_ID		0x00
+#define GL520_REG_REVISION		0x01
+#define GL520_REG_CONF			0x03
+#define GL520_REG_MASK			0x11
+
+#define GL520_REG_VID_INPUT		0x02
+
+#define GL520_REG_IN0_INPUT		0x15
+#define GL520_REG_IN0_LIMIT		0x0c
+#define GL520_REG_IN0_MIN		GL520_REG_IN0_LIMIT
+#define GL520_REG_IN0_MAX		GL520_REG_IN0_LIMIT
+
+#define GL520_REG_IN1_INPUT		0x14
+#define GL520_REG_IN1_LIMIT		0x09
+#define GL520_REG_IN1_MIN		GL520_REG_IN1_LIMIT
+#define GL520_REG_IN1_MAX		GL520_REG_IN1_LIMIT
+
+#define GL520_REG_IN2_INPUT		0x13
+#define GL520_REG_IN2_LIMIT		0x0a
+#define GL520_REG_IN2_MIN		GL520_REG_IN2_LIMIT
+#define GL520_REG_IN2_MAX		GL520_REG_IN2_LIMIT
+
+#define GL520_REG_IN3_INPUT		0x0d
+#define GL520_REG_IN3_LIMIT		0x0b
+#define GL520_REG_IN3_MIN		GL520_REG_IN3_LIMIT
+#define GL520_REG_IN3_MAX		GL520_REG_IN3_LIMIT
+
+#define GL520_REG_IN4_INPUT		0x0e
+#define GL520_REG_IN4_MAX		0x17
+#define GL520_REG_IN4_MIN		0x18
+
+#define GL520_REG_TEMP1_INPUT		0x04
+#define GL520_REG_TEMP1_MAX		0x05
+#define GL520_REG_TEMP1_MAX_HYST	0x06
+
+#define GL520_REG_TEMP2_INPUT		0x0e
+#define GL520_REG_TEMP2_MAX		0x17
+#define GL520_REG_TEMP2_MAX_HYST	0x18
+
+#define GL520_REG_FAN_INPUT		0x07
+#define GL520_REG_FAN_MIN		0x08
+#define GL520_REG_FAN_DIV		0x0f
+#define GL520_REG_FAN_OFF		GL520_REG_FAN_DIV
+
+#define GL520_REG_ALARMS		0x12
+#define GL520_REG_BEEP_MASK		0x10
+#define GL520_REG_BEEP_ENABLE		GL520_REG_CONF
+
+/*
+ * Function declarations
+ */
+
+static int gl520_attach_adapter(struct i2c_adapter *adapter);
+static int gl520_detect(struct i2c_adapter *adapter, int address, int kind);
+static void gl520_init_client(struct i2c_client *client);
+static int gl520_detach_client(struct i2c_client *client);
+static int gl520_read_value(struct i2c_client *client, u8 reg);
+static int gl520_write_value(struct i2c_client *client, u8 reg, u16 value);
+static struct gl520_data *gl520_update_device(struct device *dev);
+
+/* Driver data */
+static struct i2c_driver gl520_driver = {
+	.owner		= THIS_MODULE,
+	.name		= "gl520sm",
+	.id		= I2C_DRIVERID_GL520,
+	.flags		= I2C_DF_NOTIFY,
+	.attach_adapter	= gl520_attach_adapter,
+	.detach_client	= gl520_detach_client,
+};
+
+/* Client data */
+struct gl520_data {
+	struct i2c_client client;
+	struct semaphore update_lock;
+	char valid;		/* zero until the following fields are valid */
+	unsigned long last_updated;	/* in jiffies */
+
+	u8 vid;
+	u8 vrm;
+	u8 in_input[5];		/* [0] = VVD */
+	u8 in_min[5];		/* [0] = VDD */
+	u8 in_max[5];		/* [0] = VDD */
+	u8 fan_input[2];
+	u8 fan_min[2];
+	u8 fan_div[2];
+	u8 fan_off;
+	u8 temp_input[2];
+	u8 temp_max[2];
+	u8 temp_max_hyst[2];
+	u8 alarms;
+	u8 beep_enable;
+	u8 beep_mask;
+	u8 alarm_mask;
+	u8 two_temps;
+};
+
+/*
+ * Sysfs stuff
+ */
+
+#define sysfs_r(type, n, item, reg) \
+static ssize_t get_##type##item (struct gl520_data *, char *, int); \
+static ssize_t get_##type##n##item (struct device *, char *); \
+static ssize_t get_##type##n##item (struct device *dev, char *buf) \
+{ \
+	struct gl520_data *data = gl520_update_device(dev); \
+	return get_##type##item(data, buf, (n)); \
+}
+
+#define sysfs_w(type, n, item, reg) \
+static ssize_t set_##type##item (struct i2c_client *, struct gl520_data *, const char *, size_t, int, int); \
+static ssize_t set_##type##n##item (struct device *, const char *, size_t); \
+static ssize_t set_##type##n##item (struct device *dev, const char *buf, size_t count) \
+{ \
+	struct i2c_client *client = to_i2c_client(dev); \
+	struct gl520_data *data = i2c_get_clientdata(client); \
+	return set_##type##item(client, data, buf, count, (n), reg); \
+}
+
+#define sysfs_rw_n(type, n, item, reg) \
+sysfs_r(type, n, item, reg) \
+sysfs_w(type, n, item, reg) \
+static DEVICE_ATTR(type##n##item, S_IRUGO | S_IWUSR, get_##type##n##item, set_##type##n##item);
+
+#define sysfs_ro_n(type, n, item, reg) \
+sysfs_r(type, n, item, reg) \
+static DEVICE_ATTR(type##n##item, S_IRUGO, get_##type##n##item, NULL);
+
+#define sysfs_rw(type, item, reg) \
+sysfs_r(type, 0, item, reg) \
+sysfs_w(type, 0, item, reg) \
+static DEVICE_ATTR(type##item, S_IRUGO | S_IWUSR, get_##type##0##item, set_##type##0##item);
+
+#define sysfs_ro(type, item, reg) \
+sysfs_r(type, 0, item, reg) \
+static DEVICE_ATTR(type##item, S_IRUGO, get_##type##0##item, NULL);
+
+
+#define sysfs_vid(n) \
+sysfs_ro_n(cpu, n, _vid, GL520_REG_VID_INPUT)
+
+#define device_create_file_vid(client, n) \
+device_create_file(&client->dev, &dev_attr_cpu##n##_vid)
+
+#define sysfs_in(n) \
+sysfs_ro_n(in, n, _input, GL520_REG_IN##n##INPUT) \
+sysfs_rw_n(in, n, _min, GL520_REG_IN##n##_MIN) \
+sysfs_rw_n(in, n, _max, GL520_REG_IN##n##_MAX) \
+
+#define device_create_file_in(client, n) \
+device_create_file(&client->dev, &dev_attr_in##n##_input); \
+device_create_file(&client->dev, &dev_attr_in##n##_min); \
+device_create_file(&client->dev, &dev_attr_in##n##_max)
+
+#define sysfs_fan(n) \
+sysfs_ro_n(fan, n, _input, GL520_REG_FAN_INPUT) \
+sysfs_rw_n(fan, n, _min, GL520_REG_FAN_MIN) \
+sysfs_rw_n(fan, n, _div, GL520_REG_FAN_DIV)
+
+#define device_create_file_fan(client, n) \
+device_create_file(&client->dev, &dev_attr_fan##n##_input); \
+device_create_file(&client->dev, &dev_attr_fan##n##_min); \
+device_create_file(&client->dev, &dev_attr_fan##n##_div)
+
+#define sysfs_fan_off(n) \
+sysfs_rw_n(fan, n, _off, GL520_REG_FAN_OFF) \
+
+#define device_create_file_fan_off(client, n) \
+device_create_file(&client->dev, &dev_attr_fan##n##_off)
+
+#define sysfs_temp(n) \
+sysfs_ro_n(temp, n, _input, GL520_REG_TEMP##n##_INPUT) \
+sysfs_rw_n(temp, n, _max, GL520_REG_TEMP##n##_MAX) \
+sysfs_rw_n(temp, n, _max_hyst, GL520_REG_TEMP##n##_MAX_HYST)
+
+#define device_create_file_temp(client, n) \
+device_create_file(&client->dev, &dev_attr_temp##n##_input); \
+device_create_file(&client->dev, &dev_attr_temp##n##_max); \
+device_create_file(&client->dev, &dev_attr_temp##n##_max_hyst)
+
+#define sysfs_alarms() \
+sysfs_ro(alarms, , GL520_REG_ALARMS) \
+sysfs_rw(beep_enable, , GL520_REG_BEEP_ENABLE) \
+sysfs_rw(beep_mask, , GL520_REG_BEEP_MASK)
+
+#define device_create_file_alarms(client) \
+device_create_file(&client->dev, &dev_attr_alarms); \
+device_create_file(&client->dev, &dev_attr_beep_enable); \
+device_create_file(&client->dev, &dev_attr_beep_mask)
+
+
+sysfs_vid(0)
+
+sysfs_in(0)
+sysfs_in(1)
+sysfs_in(2)
+sysfs_in(3)
+sysfs_in(4)
+
+sysfs_fan(1)
+sysfs_fan(2)
+sysfs_fan_off(1)
+
+sysfs_temp(1)
+sysfs_temp(2)
+
+sysfs_alarms()
+
+
+/*
+ * Real code
+ */
+
+static int gl520_attach_adapter(struct i2c_adapter *adapter)
+{
+	if (!(adapter->class & I2C_CLASS_HWMON))
+		return 0;
+	return i2c_detect(adapter, &addr_data, gl520_detect);
+}
+
+static int gl520_detect(struct i2c_adapter *adapter, int address, int kind)
+{
+	struct i2c_client *new_client;
+	struct gl520_data *data;
+	int err = 0;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
+		    goto exit;
+
+	/* OK. For now, we presume we have a valid client. We now create the
+	   client structure, even though we cannot fill it completely yet.
+	   But it allows us to access gl520_{read,write}_value. */
+
+	if (!(data = kmalloc(sizeof(struct gl520_data), GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto exit;
+	}
+	memset(data, 0, sizeof(struct gl520_data));
+
+	new_client = &data->client;
+	i2c_set_clientdata(new_client, data);
+	new_client->addr = address;
+	new_client->adapter = adapter;
+	new_client->driver = &gl520_driver;
+	new_client->flags = 0;
+
+	/* Determine the chip type. */
+	if (kind < 0) {
+		if ((gl520_read_value(new_client, GL520_REG_CHIP_ID) != 0x20) ||
+		    ((gl520_read_value(new_client, GL520_REG_CONF) & 0x80) != 0x00)) {
+			dev_dbg(&new_client->dev, "Unknown chip type, skipping\n");
+			goto exit_free;
+		}
+	}
+
+	/* Fill in the remaining client fields */
+	strlcpy(new_client->name, "gl520sm", I2C_NAME_SIZE);
+	data->valid = 0;
+	init_MUTEX(&data->update_lock);
+
+	/* Tell the I2C layer a new client has arrived */
+	if ((err = i2c_attach_client(new_client)))
+		goto exit_free;
+
+	/* Initialize the GL520SM chip */
+	gl520_init_client(new_client);
+
+	/* Register sysfs hooks */
+	device_create_file_vid(new_client, 0);
+
+	device_create_file_in(new_client, 0);
+	device_create_file_in(new_client, 1);
+	device_create_file_in(new_client, 2);
+	device_create_file_in(new_client, 3);
+	if (!data->two_temps) {
+		device_create_file_in(new_client, 4);
+	}
+
+	device_create_file_fan(new_client, 1);
+	device_create_file_fan(new_client, 2);
+	device_create_file_fan_off(new_client, 1);
+
+	device_create_file_temp(new_client, 1);
+	if (data->two_temps) {
+		device_create_file_temp(new_client, 2);
+	}
+
+	device_create_file_alarms(new_client);
+
+	return 0;
+
+exit_free:
+	kfree(data);
+exit:
+	return err;
+}
+
+
+/* Called when we have found a new GL520SM. */
+static void gl520_init_client(struct i2c_client *client)
+{
+	struct gl520_data *data = i2c_get_clientdata(client);
+	u8 oldconf, conf;
+
+	conf = oldconf = gl520_read_value(client, GL520_REG_CONF);
+
+	data->alarm_mask = 0xff;
+	data->vrm = i2c_which_vrm();
+
+	if (extra_sensor_type) {
+		if (extra_sensor_type = 1)
+			conf &= ~0x10;
+		else if (extra_sensor_type = 2)
+			conf |= 0x10;
+	}
+	data->two_temps = !(conf & 0x10);
+
+	/* If IRQ# is disabled, we can safely force comparator mode */
+	if (!(conf & 0x20))
+		conf &= 0xf7;
+
+	/* Enable monitoring if needed */
+	conf |= 0x40;
+
+	if (conf != oldconf)
+		gl520_write_value(client, GL520_REG_CONF, conf);
+
+	gl520_update_device(&(client->dev));
+}
+
+static int gl520_detach_client(struct i2c_client *client)
+{
+	int err;
+
+	if ((err = i2c_detach_client(client))) {
+		dev_err(&client->dev, "Client deregistration failed, "
+			"client not detached.\n");
+		return err;
+	}
+
+	kfree(i2c_get_clientdata(client));
+	return 0;
+}
+
+
+/* Registers 0x07 to 0x0c are word-sized, others are byte-sized 
+   GL520 uses a high-byte first convention */
+static int gl520_read_value(struct i2c_client *client, u8 reg)
+{
+	if ((reg >= 0x07) && (reg <= 0x0c))
+		return swab16(i2c_smbus_read_word_data(client, reg));
+	else
+		return i2c_smbus_read_byte_data(client, reg);
+}
+
+static int gl520_write_value(struct i2c_client *client, u8 reg, u16 value)
+{
+	if ((reg >= 0x07) && (reg <= 0x0c))
+		return i2c_smbus_write_word_data(client, reg, swab16(value));
+	else
+		return i2c_smbus_write_byte_data(client, reg, value);
+}
+
+
+static struct gl520_data *gl520_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct gl520_data *data = i2c_get_clientdata(client);
+	int val;
+
+	down(&data->update_lock);
+
+	if ((jiffies - data->last_updated > 2 * HZ) ||
+	    (jiffies < data->last_updated) || !data->valid) {
+
+		dev_dbg(&client->dev, "Starting gl520sm update\n");
+
+		data->alarms = gl520_read_value(client, GL520_REG_ALARMS);
+		data->beep_mask = gl520_read_value(client, GL520_REG_BEEP_MASK);
+		data->vid = gl520_read_value(client, GL520_REG_VID_INPUT) & 0x1f;
+
+		val = gl520_read_value(client, GL520_REG_IN0_LIMIT);
+		data->in_min[0] = val & 0xff;
+		data->in_max[0] = (val >> 8) & 0xff;
+		val = gl520_read_value(client, GL520_REG_IN1_LIMIT);
+		data->in_min[1] = val & 0xff;
+		data->in_max[1] = (val >> 8) & 0xff;
+		val = gl520_read_value(client, GL520_REG_IN2_LIMIT);
+		data->in_min[2] = val & 0xff;
+		data->in_max[2] = (val >> 8) & 0xff;
+		val = gl520_read_value(client, GL520_REG_IN3_LIMIT);
+		data->in_min[3] = val & 0xff;
+		data->in_max[3] = (val >> 8) & 0xff;
+
+		val = gl520_read_value(client, GL520_REG_FAN_INPUT);
+		data->fan_input[0] = (val >> 8) & 0xff;
+		data->fan_input[1] = val & 0xff;
+
+		val = gl520_read_value(client, GL520_REG_FAN_MIN);
+		data->fan_min[0] = (val >> 8) & 0xff;
+		data->fan_min[1] = val & 0xff;
+
+		data->temp_input[0] = gl520_read_value(client, GL520_REG_TEMP1_INPUT);
+		data->temp_max[0] = gl520_read_value(client, GL520_REG_TEMP1_MAX);
+		data->temp_max_hyst[0] = gl520_read_value(client, GL520_REG_TEMP1_MAX_HYST);
+
+		val = gl520_read_value(client, GL520_REG_FAN_DIV);
+		data->fan_div[0] = (val >> 6) & 0x03;
+		data->fan_div[1] = (val >> 4) & 0x03;
+		data->fan_off = (val >> 2) & 0x01;
+
+		data->alarms &= data->alarm_mask;
+
+		val = gl520_read_value(client, GL520_REG_CONF);
+		data->beep_enable = !((val >> 2) & 1);
+
+		data->in_input[0] = gl520_read_value(client, GL520_REG_IN0_INPUT);
+		data->in_input[1] = gl520_read_value(client, GL520_REG_IN1_INPUT);
+		data->in_input[2] = gl520_read_value(client, GL520_REG_IN2_INPUT);
+		data->in_input[3] = gl520_read_value(client, GL520_REG_IN3_INPUT);
+
+		/* Temp1 and Vin4 are the same input */
+		if (data->two_temps) {
+			data->temp_input[1] = gl520_read_value(client, GL520_REG_TEMP2_INPUT);
+			data->temp_max[1] = gl520_read_value(client, GL520_REG_TEMP2_MAX);
+			data->temp_max_hyst[1] = gl520_read_value(client, GL520_REG_TEMP2_MAX_HYST);
+		} else {
+			data->in_input[4] = gl520_read_value(client, GL520_REG_IN4_INPUT);
+			data->in_min[4] = gl520_read_value(client, GL520_REG_IN4_MIN);
+			data->in_max[4] = gl520_read_value(client, GL520_REG_IN4_MAX);
+		}
+
+		data->last_updated = jiffies;
+		data->valid = 1;
+	}
+
+	up(&data->update_lock);
+
+	return data;
+}
+
+static ssize_t get_cpu_vid(struct gl520_data *data, char *buf, int n)
+{
+	return sprintf(buf, "%u\n", vid_from_reg(data->vid, data->vrm));
+}
+
+#define VDD_FROM_REG(val) (((val)*95+2)/4)
+#define VDD_TO_REG(val) (SENSORS_LIMIT((((val)*4+47)/95),0,255))
+
+#define IN_FROM_REG(val) ((val)*19)
+#define IN_TO_REG(val) (SENSORS_LIMIT((((val)+9)/19),0,255))
+
+static ssize_t get_in_input(struct gl520_data *data, char *buf, int n)
+{
+	u8 r = data->in_input[n];
+
+	if (n = 0)
+		return sprintf(buf, "%d\n", VDD_FROM_REG(r));
+	else
+		return sprintf(buf, "%d\n", IN_FROM_REG(r));
+}
+
+static ssize_t get_in_min(struct gl520_data *data, char *buf, int n)
+{
+	u8 r = data->in_min[n];
+
+	if (n = 0)
+		return sprintf(buf, "%d\n", VDD_FROM_REG(r));
+	else
+		return sprintf(buf, "%d\n", IN_FROM_REG(r));
+}
+
+static ssize_t get_in_max(struct gl520_data *data, char *buf, int n)
+{
+	u8 r = data->in_max[n];
+
+	if (n = 0)
+		return sprintf(buf, "%d\n", VDD_FROM_REG(r));
+	else
+		return sprintf(buf, "%d\n", IN_FROM_REG(r));
+}
+
+static ssize_t set_in_min(struct i2c_client *client, struct gl520_data *data, const char *buf, size_t count, int n, int reg)
+{
+	long v = simple_strtol(buf, NULL, 10);
+	u8 r;
+
+	if (n = 0)
+		r = VDD_TO_REG(v);
+	else
+		r = IN_TO_REG(v);
+
+	data->in_min[n] = r;
+
+	if (n < 4) {
+		gl520_write_value(client, reg, (gl520_read_value(client, reg) & ~0xff) | r);
+	}
+	else
+		gl520_write_value(client, reg, r);
+
+	return count;
+}
+
+static ssize_t set_in_max(struct i2c_client *client, struct gl520_data *data, const char *buf, size_t count, int n, int reg)
+{
+	long v = simple_strtol(buf, NULL, 10);
+	u8 r;
+
+	if (n = 0)
+		r = VDD_TO_REG(v);
+	else
+		r = IN_TO_REG(v);
+
+	data->in_max[n] = r;
+
+	if (n < 4) {
+		gl520_write_value(client, reg, (gl520_read_value(client, reg) & ~0xff00) | (r << 8));
+	}
+	else
+		gl520_write_value(client, reg, r);
+
+	return count;
+}
+
+#define DIV_FROM_REG(val) (1 << (val))
+#define FAN_FROM_REG(val,div) ((val)=0 ? 0 : (960000/((val) << (div))))
+#define FAN_TO_REG(val,div) ((val)<=0?0:SENSORS_LIMIT((960000 + ((val) << ((div)-1))) / ((val) << (div)), 1, 255));
+
+static ssize_t get_fan_input(struct gl520_data *data, char *buf, int n)
+{
+	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan_input[n - 1], data->fan_div[n - 1]));
+}
+
+static ssize_t get_fan_min(struct gl520_data *data, char *buf, int n)
+{
+	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan_min[n - 1], data->fan_div[n - 1]));
+}
+
+static ssize_t get_fan_div(struct gl520_data *data, char *buf, int n)
+{
+	return sprintf(buf, "%d\n", DIV_FROM_REG(data->fan_div[n - 1]));
+}
+
+static ssize_t get_fan_off(struct gl520_data *data, char *buf, int n)
+{
+	return sprintf(buf, "%d\n", data->fan_off);
+}
+
+static ssize_t set_fan_min(struct i2c_client *client, struct gl520_data *data, const char *buf, size_t count, int n, int reg)
+{
+	unsigned long v = simple_strtoul(buf, NULL, 10);
+	u8 r = FAN_TO_REG(v, data->fan_div[n - 1]);
+
+	data->fan_min[n - 1] = r;
+
+	if (n = 1)
+		gl520_write_value(client, reg, (gl520_read_value(client, reg) & ~0xff00) | (r << 8));
+	else
+		gl520_write_value(client, reg, (gl520_read_value(client, reg) & ~0xff) | r);
+
+	data->beep_mask = gl520_read_value(client, GL520_REG_BEEP_MASK);
+	if (data->fan_min[n - 1] = 0)
+		data->alarm_mask &= (n = 1) ? ~0x20 : ~0x40;
+	else
+		data->alarm_mask |= (n = 1) ? ~0x20 : ~0x40;
+	data->beep_mask &= data->alarm_mask;
+	gl520_write_value(client, GL520_REG_BEEP_MASK, data->beep_mask);
+
+	return count;
+}
+
+static ssize_t set_fan_div(struct i2c_client *client, struct gl520_data *data, const char *buf, size_t count, int n, int reg)
+{
+	unsigned long v = simple_strtoul(buf, NULL, 10);
+	u8 r;
+
+	switch (v) {
+	case 1: r = 0; break;
+	case 2: r = 1; break;
+	case 4: r = 2; break;
+	case 8: r = 3; break;
+	default:
+		dev_err(&client->dev, "fan_div value %ld not supported. Choose one of 1, 2, 4 or 8!\n", v);
+		return -EINVAL;
+	}
+
+	data->fan_div[n - 1] = r;
+
+	if (n = 1)
+		gl520_write_value(client, reg, (gl520_read_value(client, reg) & ~0xc0) | (r << 6));
+	else
+		gl520_write_value(client, reg, (gl520_read_value(client, reg) & ~0x30) | (r << 4));
+
+	return count;
+}
+
+static ssize_t set_fan_off(struct i2c_client *client, struct gl520_data *data, const char *buf, size_t count, int n, int reg)
+{
+	u8 r = simple_strtoul(buf, NULL, 10)?1:0;
+
+	data->fan_off = r;
+	gl520_write_value(client, reg, (gl520_read_value(client, reg) & ~0x0c) | (r << 2));
+
+	return count;
+}
+
+#define TEMP_FROM_REG(val) (((val) - 130) * 1000)
+#define TEMP_TO_REG(val) (SENSORS_LIMIT(((((val)<0?(val)-500:(val)+500) / 1000)+130),0,255))
+
+static ssize_t get_temp_input(struct gl520_data *data, char *buf, int n)
+{
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_input[n - 1]));
+}
+
+static ssize_t get_temp_max(struct gl520_data *data, char *buf, int n)
+{
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_max[n - 1]));
+}
+
+static ssize_t get_temp_max_hyst(struct gl520_data *data, char *buf, int n)
+{
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_max_hyst[n - 1]));
+}
+
+static ssize_t set_temp_max(struct i2c_client *client, struct gl520_data *data, const char *buf, size_t count, int n, int reg)
+{
+	long v = simple_strtol(buf, NULL, 10);
+	u8 r = TEMP_TO_REG(v);
+
+	data->temp_max[n - 1] = r;
+	gl520_write_value(client, reg, r);
+
+	return count;
+}
+
+static ssize_t set_temp_max_hyst(struct i2c_client *client, struct gl520_data *data, const char *buf, size_t count, int n, int reg)
+{
+	long v = simple_strtol(buf, NULL, 10);
+	u8 r = TEMP_TO_REG(v);
+
+	data->temp_max_hyst[n - 1] = r;
+	gl520_write_value(client, reg, r);
+
+	return count;
+}
+
+static ssize_t get_alarms(struct gl520_data *data, char *buf, int n)
+{
+	return sprintf(buf, "%d\n", data->alarms);
+}
+
+static ssize_t get_beep_enable(struct gl520_data *data, char *buf, int n)
+{
+	return sprintf(buf, "%d\n", data->beep_enable);
+}
+
+static ssize_t get_beep_mask(struct gl520_data *data, char *buf, int n)
+{
+	return sprintf(buf, "%d\n", data->beep_mask);
+}
+
+static ssize_t set_beep_enable(struct i2c_client *client, struct gl520_data *data, const char *buf, size_t count, int n, int reg)
+{
+	u8 r = simple_strtoul(buf, NULL, 10)?0:1;
+
+	data->beep_enable = !r;
+	gl520_write_value(client, reg, (gl520_read_value(client, reg) & ~0x04) | (r << 2));
+
+	return count;
+}
+
+static ssize_t set_beep_mask(struct i2c_client *client, struct gl520_data *data, const char *buf, size_t count, int n, int reg)
+{
+	u8 r = simple_strtoul(buf, NULL, 10) & data->alarm_mask;
+
+	data->beep_mask = r;
+	gl520_write_value(client, reg, r);
+
+	return count;
+}
+
+
+static int __init sensors_gl520sm_init(void)
+{
+	return i2c_add_driver(&gl520_driver);
+}
+
+static void __exit sensors_gl520sm_exit(void)
+{
+	i2c_del_driver(&gl520_driver);
+}
+
+
+MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>, "
+	"Ky?sti M?lkki <kmalkki@cc.hut.fi>, "
+	"Maarten Deprez <maartendeprez@users.sourceforge.net>");
+MODULE_DESCRIPTION("GL520SM driver");
+MODULE_LICENSE("GPL");
+
+module_init(sensors_gl520sm_init);
+module_exit(sensors_gl520sm_exit);
-------------- next part --------------
--- lm_sensors2/prog/sensors/chips.c.orig	2005-01-28 11:56:29.000000000 +0100
+++ lm_sensors2/prog/sensors/chips.c	2005-01-31 11:30:57.000000000 +0100
@@ -1175,6 +1175,181 @@
   free_the_label(&label);
 }
 
+void print_gl520(const sensors_chip_name *name)
+{
+  char *label = NULL;
+  double cur,min,max;
+  int alarms,beeps,valid;
+  int two_temps = 0;
+
+  if (!sensors_get_feature(*name,SENSORS_GL520_ALARMS,&cur))
+    alarms = cur + 0.5;
+  else {
+    printf("ERROR: Can't get ALARMS data!\n");
+    alarms = 0;
+  }
+  if (!sensors_get_feature(*name,SENSORS_GL520_BEEPS,&cur)) 
+    beeps = cur + 0.5;
+  else {
+    printf("ERROR: Can't get BEEPS data!\n");
+    beeps = 0;
+  }
+
+  if (!sensors_get_label_and_valid(*name,SENSORS_GL520_VID,&label,&valid) &&
+      !sensors_get_feature(*name,SENSORS_GL520_VID,&cur)) {
+    if (valid) {
+      print_label(label,10);
+      printf("%+6.2f V\n",cur);
+    }
+  } else
+    printf("ERROR: Can't get VID data!\n");
+  free_the_label(&label);
+
+  if (!sensors_get_label_and_valid(*name,SENSORS_GL520_VDD,&label,&valid) &&
+      !sensors_get_feature(*name,SENSORS_GL520_VDD,&cur) &&
+      !sensors_get_feature(*name,SENSORS_GL520_VDD_MIN,&min) &&
+      !sensors_get_feature(*name,SENSORS_GL520_VDD_MAX,&max)) {
+    if (valid) {
+      print_label(label,10);
+      printf("%+6.2f V  ",cur);
+      printf(  "(min = %+6.2f V, max = %+6.2f V)   %s  %s\n",
+             min,max,alarms&GL520_ALARM_VDD?"ALARM":"     ",
+             beeps&GL520_ALARM_VDD?"(beep)":"");
+    }
+  } else
+    printf("ERROR: Can't get VDD data!\n");
+  free_the_label(&label);
+
+  if (!sensors_get_label_and_valid(*name,SENSORS_GL520_VIN1,&label,&valid) &&
+      !sensors_get_feature(*name,SENSORS_GL520_VIN1,&cur) &&
+      !sensors_get_feature(*name,SENSORS_GL520_VIN1_MIN,&min) &&
+      !sensors_get_feature(*name,SENSORS_GL520_VIN1_MAX,&max)) {
+    if (valid) {
+      print_label(label,10);
+      printf("%+6.2f V  ",cur);
+      printf("(min = %+6.2f V, max = %+6.2f V)   %s  %s\n",
+             min,max,alarms&GL520_ALARM_VIN1?"ALARM":"     ",
+             beeps&GL520_ALARM_VIN1?"(beep)":"");
+    }
+  } else
+    printf("ERROR: Can't get VIN1 data!\n");
+  free_the_label(&label);
+
+  if (!sensors_get_label_and_valid(*name,SENSORS_GL520_VIN2,&label,&valid) &&
+      !sensors_get_feature(*name,SENSORS_GL520_VIN2,&cur) &&
+      !sensors_get_feature(*name,SENSORS_GL520_VIN2_MIN,&min) &&
+      !sensors_get_feature(*name,SENSORS_GL520_VIN2_MAX,&max)) {
+    if (valid) {
+      print_label(label,10);
+      printf("%+6.2f V  ",cur);
+      printf("(min = %+6.2f V, max = %+6.2f V)   %s  %s\n",
+             min,max,alarms&GL520_ALARM_VIN2?"ALARM":"     ",
+             beeps&GL520_ALARM_VIN2?"(beep)":"");
+    }
+  } else
+    printf("ERROR: Can't get VIN2 data!\n");
+  free_the_label(&label);
+
+  if (!sensors_get_label_and_valid(*name,SENSORS_GL520_VIN3,&label,&valid) &&
+      !sensors_get_feature(*name,SENSORS_GL520_VIN3,&cur) &&
+      !sensors_get_feature(*name,SENSORS_GL520_VIN3_MIN,&min) &&
+      !sensors_get_feature(*name,SENSORS_GL520_VIN3_MAX,&max)) {
+    if (valid) {
+      print_label(label,10);
+      printf("%+6.2f V  (min = %+6.2f V, max = %+6.2f V)   %s  %s\n",
+             cur,min,max,alarms&GL520_ALARM_VIN3?"ALARM":"     ",
+             beeps&GL520_ALARM_VIN3?"(beep)":"");
+     }
+  } else
+    printf("ERROR: Can't get VIN3 data!\n");
+  free_the_label(&label);
+
+  if (!sensors_get_label_and_valid(*name,SENSORS_GL520_VIN4,&label,&valid) &&
+      !sensors_get_feature(*name,SENSORS_GL520_VIN4,&cur) &&
+      !sensors_get_feature(*name,SENSORS_GL520_VIN4_MIN,&min) &&
+      !sensors_get_feature(*name,SENSORS_GL520_VIN4_MAX,&max)) {
+    if (valid) {
+      print_label(label,10);
+      printf("%+6.2f V  (min = %+6.2f V, max = %+6.2f V)   %s  %s\n",
+             cur,min,max,alarms&GL520_ALARM_VIN4?"ALARM":"     ",
+             beeps&GL520_ALARM_VIN4?"(beep)":"");
+     }
+  } else
+    two_temps = 1;
+  free_the_label(&label);
+  
+  if (!sensors_get_label_and_valid(*name,SENSORS_GL520_FAN1,&label,&valid) &&
+      !sensors_get_feature(*name,SENSORS_GL520_FAN1,&cur) &&
+      !sensors_get_feature(*name,SENSORS_GL520_FAN1_DIV,&max) &&
+      !sensors_get_feature(*name,SENSORS_GL520_FAN1_MIN,&min)) {
+    if (valid) {
+      print_label(label,10);
+      printf("%4.0f RPM  (min = %4.0f RPM, div = %1.0f)          %s  %s\n",
+             cur,min,max, alarms&GL520_ALARM_FAN1?"ALARM":"     ",
+             beeps&GL520_ALARM_FAN1?"(beep)":"");
+    }
+  } else
+    printf("ERROR: Can't get FAN1 data!\n");
+  free_the_label(&label);
+
+  if (!sensors_get_label_and_valid(*name,SENSORS_GL520_FAN2,&label,&valid) &&
+      !sensors_get_feature(*name,SENSORS_GL520_FAN2,&cur) &&
+      !sensors_get_feature(*name,SENSORS_GL520_FAN2_DIV,&max) &&
+      !sensors_get_feature(*name,SENSORS_GL520_FAN2_MIN,&min)) {
+    if (valid) {
+      print_label(label,10);
+      printf("%4.0f RPM  (min = %4.0f RPM, div = %1.0f)          %s  %s\n",
+             cur,min,max, alarms&GL520_ALARM_FAN2?"ALARM":"     ",
+             beeps&GL520_ALARM_FAN2?"(beep)":"");
+    }
+  } else
+    printf("ERROR: Can't get FAN2 data!\n");
+  free_the_label(&label);
+
+  if (!sensors_get_label_and_valid(*name,SENSORS_GL520_TEMP1,&label,&valid) &&
+      !sensors_get_feature(*name,SENSORS_GL520_TEMP1,&cur) &&
+      !sensors_get_feature(*name,SENSORS_GL520_TEMP1_OVER,&max) &&
+      !sensors_get_feature(*name,SENSORS_GL520_TEMP1_HYST,&min)) {
+    if (valid) {
+      print_label(label,10);
+      print_temp_info( cur, max, min, HYST, 1, 0);
+      printf("%s  %s\n", alarms&GL520_ALARM_TEMP1?"ALARM":"     ",
+             beeps&GL520_ALARM_TEMP1?"(beep)":"");
+    }
+  } else
+    printf("ERROR: Can't get TEMP1 data!\n");
+  free_the_label(&label);
+
+  if (two_temps) {
+    if (!sensors_get_label_and_valid(*name,SENSORS_GL520_TEMP2,&label,&valid) &&
+	!sensors_get_feature(*name,SENSORS_GL520_TEMP2,&cur) &&
+	!sensors_get_feature(*name,SENSORS_GL520_TEMP2_OVER,&max) &&
+	!sensors_get_feature(*name,SENSORS_GL520_TEMP2_HYST,&min)) {
+      if (valid) {
+	print_label(label,10);
+	print_temp_info( cur, max, min, HYST, 1, 0);
+	printf("%s  %s\n", alarms&GL520_ALARM_TEMP2?"ALARM":"     ",
+	       beeps&GL520_ALARM_TEMP2?"(beep)":"");
+      }
+    } else 
+      printf("ERROR: Can't get TEMP1 or VIN4 data!\n");
+    free_the_label(&label);
+  }
+
+  if (!sensors_get_label_and_valid(*name,SENSORS_GL520_BEEP_ENABLE,&label,&valid)
+      && valid) {
+    if (!sensors_get_feature(*name,SENSORS_GL520_BEEP_ENABLE,&cur)) {
+      print_label(label,10);
+      if (cur < 0.5) 
+        printf("Sound alarm disabled\n");
+      else
+        printf("Sound alarm enabled\n");
+    } else
+      printf("ERROR: Can't get BEEP ENABLE data!\n");
+  }
+  free_the_label(&label);
+}
+
 void print_adm1025(const sensors_chip_name *name)
 {
   char *label = NULL;
--- lm_sensors2/prog/sensors/chips.h.orig	2005-01-31 11:24:24.000000000 +0100
+++ lm_sensors2/prog/sensors/chips.h	2005-01-31 11:24:45.000000000 +0100
@@ -37,6 +37,7 @@
 extern void print_sis5595(const sensors_chip_name *name);
 extern void print_via686a(const sensors_chip_name *name);
 extern void print_gl518(const sensors_chip_name *name);
+extern void print_gl520(const sensors_chip_name *name);
 extern void print_lm80(const sensors_chip_name *name);
 extern void print_lm85(const sensors_chip_name *name);
 extern void print_w83781d(const sensors_chip_name *name);
--- lm_sensors2/prog/sensors/main.c.orig	2005-01-31 11:23:54.000000000 +0100
+++ lm_sensors2/prog/sensors/main.c	2005-01-31 11:25:47.000000000 +0100
@@ -349,6 +349,7 @@
 	{ "emc6d100", print_lm85 },
 	{ "lm87", print_lm87 },
 	{ "gl518sm", print_gl518 },
+	{ "gl520sm", print_gl520 },
 	{ "adm1025", print_adm1025 },
 	{ "ne1619", print_adm1025 },
 	{ "adm1024", print_adm1024 },
