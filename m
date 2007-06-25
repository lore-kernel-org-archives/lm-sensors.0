From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Mon, 25 Jun 2007 15:02:10 +0000
Subject: [lm-sensors] [RESEND][PATCH] THMC50 and ADM1022 support for 2.6
Message-Id: <467FD8F2.1000409@wp.pl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------020700050209080303050302"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------020700050209080303050302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds support for THMC50 and ADM1022 chips to 2.6 kernels.

Signed-off-by: Krzysztof Helt <krzysztof.h1 at wp.pl>

---

This patch was redone against linux-2.6.22-rc5-git8 (as requested by Mark M. Hoffman in the "kernel TODO" post).

This patch is improved comparing to previous one: 
 * it allows selection of ADM1022 working mode (THMC50 or
additional remote temperature)
 * adds doc file 
 * stops the fan with pwm1 setting to 0
 * removes interrupt mask and status files from sysfs.

Regards,
Krzysztof

--------------020700050209080303050302
Content-Type: text/plain;
 name="thmc50.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="thmc50.diff"

diff -urNp linux-2.6.21/Documentation/hwmon/thmc50 linux-2.6.22/Documentation/hwmon/thmc50
--- linux-2.6.21/Documentation/hwmon/thmc50	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.22/Documentation/hwmon/thmc50	2007-06-24 22:22:56.852806945 +0200
@@ -0,0 +1,82 @@
+Kernel driver `thmc50.o'
+=====================
+
+Status: Complete and some-what tested
+
+Supported chips: 
+  * Analog Devices ADM1022
+    Prefix: 'adm1022'
+    Addresses scanned: I2C 0x2D - 0x2F
+    Datasheet: Publicly available at the Analog Devices website
+  * Texas Instruments THMC50
+    Prefix: 'thmc50'
+    Addresses scanned: I2C 0x2D - 0x2F
+    Datasheet: Publicly available at the Texas Instruments' website
+
+Authors: Frodo Looijaard <frodol@dds.nl> and 
+         Philip Edelbrock <phil@netroedge.com>
+         Krzysztof Helt <krzysztof.h1@wp.pl>
+
+
+Module Parameters
+-----------------
+
+* force: short array (min = 1, max = 48)
+  List of adapter,address pairs to boldly assume to be present
+* force_thmc50: short array (min = 1, max = 48)
+  List of adapter,address pairs which are unquestionably assumed to contain
+  a `thmc50' chip
+* ignore: short array (min = 1, max = 48)
+  List of adapter,address pairs not to scan
+* ignore_range: short array (min = 1, max = 48)
+  List of adapter,start-addr,end-addr triples not to scan
+* probe: short array (min = 1, max = 48)
+  List of adapter,address pairs to scan additionally
+* probe_range: short array (min = 1, max = 48)
+  List of adapter,start-addr,end-addr triples to scan additionally
+* adm1022_temp3: short array (min = 1, max = 3)
+  List of adapter,address pairs of ADM1022 chips to set into measurening
+  additional remote temperature.
+
+
+Description
+-----------
+
+The THMC50 implements: an internal temperature sensor, support for an
+external diode-type temperature sensor (compatible w/ the diode sensor inside
+many processors), and a controllable fan/analog_out DAC. For the temperature
+sensors, limits can be set through the appropriate Overtemperature Shutdown 
+register and Hysteresis register. Each value can be set and read to half-degree 
+accuracy.  An alarm is issued (usually to a connected LM78) when the 
+temperature gets higher then the Overtemperature Shutdown value; it stays on 
+until the temperature falls below the Hysteresis value. All temperatures are in 
+degrees Celsius, and are guaranteed within a range of -55 to +125 degrees.
+
+The THMC50 only updates its values each 1.5 seconds; reading it more often
+will do no harm, but will return 'old' values.
+
+The THMC50 is usually used in combination with LM78-like chips, to measure
+the temperature of the processor(s).
+
+The ADM1022 works the same as THMC50 but it is faster (5 Hz instead of
+1 Hz for THMC50). Another difference is ability to handle additional
+remote temperature sensor. The ADM1022 so some pins changes their meaning
+in this mode. If the sensor is supposed to work in this mode but is not set 
+with adm1022_temp3 parameter a fan is forced to full output.
+
+Driver Features
+---------------
+
+The the driver provides up to three temperatures:
+
+temp1		-- internal
+temp2		-- remote
+temp3		-- 2nd remote only for ADM1022
+
+pwm1		-- fan speed (0 = stop, 255 = full)
+pwm1_mode	-- always 0 (DC mode)
+
+The value of 0 for pwm1 also forces FAN_OFF signal from the chip, so it stops fans even if the value 0 into the ANALOG_OUT register does not.
+
+
+The driver was tested on Compaq AP550 with two ADM1022 chips (one works in the temp3 mode), five temperature readings and two fans.
diff -urNp linux-2.6.21/drivers/hwmon/Kconfig linux-2.6.22/drivers/hwmon/Kconfig
--- linux-2.6.21/drivers/hwmon/Kconfig	2007-06-24 22:14:45.824824857 +0200
+++ linux-2.6.22/drivers/hwmon/Kconfig	2007-06-24 22:24:58.859759689 +0200
@@ -485,6 +485,16 @@ config SENSORS_SMSC47B397
 	  This driver can also be built as a module.  If so, the module
 	  will be called smsc47b397.
 
+config SENSORS_THMC50
+	tristate "Texas Instruments THMC50 / Analog Devices ADM1022"
+	depends on I2C && EXPERIMENTAL
+	help
+	  If you say yes here you get support for Texas Instruments THMC50
+	  sensor chips and clones: the Analog Devices ADM1022.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called thmc50.
+
 config SENSORS_VIA686A
 	tristate "VIA686A"
 	depends on I2C && PCI
diff -urNp linux-2.6.21/drivers/hwmon/Makefile linux-2.6.22/drivers/hwmon/Makefile
--- linux-2.6.21/drivers/hwmon/Makefile	2007-06-24 22:14:45.824824857 +0200
+++ linux-2.6.22/drivers/hwmon/Makefile	2007-06-24 22:22:56.852806945 +0200
@@ -53,6 +53,7 @@ obj-$(CONFIG_SENSORS_SIS5595)	+= sis5595
 obj-$(CONFIG_SENSORS_SMSC47B397)+= smsc47b397.o
 obj-$(CONFIG_SENSORS_SMSC47M1)	+= smsc47m1.o
 obj-$(CONFIG_SENSORS_SMSC47M192)+= smsc47m192.o
+obj-$(CONFIG_SENSORS_THMC50)	+= thmc50.o
 obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
 obj-$(CONFIG_SENSORS_VT1211)	+= vt1211.o
 obj-$(CONFIG_SENSORS_VT8231)	+= vt8231.o
diff -urNp linux-2.6.21/drivers/hwmon/thmc50.c linux-2.6.22/drivers/hwmon/thmc50.c
--- linux-2.6.21/drivers/hwmon/thmc50.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.22/drivers/hwmon/thmc50.c	2007-06-24 22:22:56.852806945 +0200
@@ -0,0 +1,438 @@
+/*
+    thmc50.c - Part of lm_sensors, Linux kernel modules for hardware
+             monitoring
+    Copyright (C) 2007 Krzysztof Helt <krzysztof.h1@wp.pl> 
+    Copyright (C) 1998, 1999  Frodo Looijaard <frodol@dds.nl> and
+    Philip Edelbrock <phil@netroedge.com>
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
+#include <linux/i2c.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
+#include <linux/mutex.h>
+
+MODULE_LICENSE("GPL");
+
+/* Addresses to scan */
+static unsigned short normal_i2c[] = { 0x2D, 0x2E, I2C_CLIENT_END };
+
+/* Insmod parameters */
+I2C_CLIENT_INSMOD_2(thmc50,adm1022);
+I2C_CLIENT_MODULE_PARM(adm1022_temp3, "List of adapter,address pairs to enable 3rd temperature (ADM1022 only)");
+
+/* Many THMC50 constants specified below */
+
+/* The THMC50 registers */
+#define	THMC50_REG_TEMP				0x27
+#define THMC50_REG_CONF				0x40
+#define THMC50_REG_TEMP_HYST			0x3A
+#define THMC50_REG_TEMP_OS			0x39
+
+#define	THMC50_REG_TEMP_TRIP			0x13
+#define THMC50_REG_TEMP_REMOTE_TRIP		0x14
+#define THMC50_REG_TEMP_DEFAULT_TRIP		0x17
+#define THMC50_REG_TEMP_REMOTE_DEFAULT_TRIP	0x18
+#define THMC50_REG_ANALOG_OUT			0x19
+#define THMC50_REG_REMOTE_TEMP			0x26
+#define THMC50_REG_REMOTE_TEMP_HYST		0x38
+#define THMC50_REG_REMOTE_TEMP_OS		0x37
+#define	ADM1022_REG_REMOTE_TEMP2		0x20
+#define	ADM1022_REG_REMOTE_TEMP2_HYST		0x2C
+#define ADM1022_REG_REMOTE_TEMP2_OS		0x2B
+
+#define THMC50_REG_INTER			0x41
+#define THMC50_REG_INTER_MIRROR			0x4C
+#define THMC50_REG_INTER_MASK			0x43
+
+#define THMC50_REG_COMPANY_ID			0x3E
+#define THMC50_REG_DIE_CODE			0x3F
+
+#define THMC50_REG_CONF_FANOFF			0x20
+
+/* Conversions. Rounding and limit checking is only done on the TO_REG
+   variants. Note that you should be a bit careful with which arguments
+   these macros are called: arguments may be evaluated more than once.
+   Fixing this is just not worth it. */
+#define TEMP_FROM_REG(val) ((val>127)?(val - 0x0100)*1000:val*1000)
+#define TEMP_TO_REG(val)   ((val<0)?0x0100+val/1000:val/1000)
+
+/* Each client has this additional data */
+struct thmc50_data {
+	struct i2c_client client;
+	struct class_device *class_dev;
+
+	struct mutex update_lock;
+	char valid;		/* !=0 if following fields are valid */
+	enum chips type;
+	unsigned long last_updated;	/* In jiffies */
+
+	/* Register values */
+	u16 temp_input;
+	u16 temp_max;
+	u16 temp_hyst;
+	u16 remote_temp_input;
+	u16 remote_temp_max;
+	u16 remote_temp_hyst;
+	u16 remote_temp2_input;
+	u16 remote_temp2_max;
+	u16 remote_temp2_hyst;
+	u16 analog_out;
+	u16 config_reg;
+};
+
+static int thmc50_attach_adapter(struct i2c_adapter *adapter);
+static int thmc50_detect(struct i2c_adapter *adapter, int address, int kind);
+static void thmc50_init_client(struct i2c_client *client);
+static int thmc50_detach_client(struct i2c_client *client);
+static struct thmc50_data *thmc50_update_device(struct device *dev);
+
+static int thmc50_read_value(struct i2c_client *client, u8 reg);
+static int thmc50_write_value(struct i2c_client *client, u8 reg,
+			      u16 value);
+
+/* This is the driver that will be inserted */
+static struct i2c_driver thmc50_driver = {
+	.driver = {
+		.name		= "THMC50 sensor chip driver",
+	},
+	.id		= I2C_DRIVERID_THMC50,
+	.attach_adapter	= thmc50_attach_adapter,
+	.detach_client	= thmc50_detach_client,
+};
+
+#define show(value)	\
+static ssize_t show_##value(struct device *dev, struct device_attribute *attr, char *buf)		\
+{									\
+	struct thmc50_data *data = thmc50_update_device(dev);		\
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->value));	\
+}
+show(temp_input);
+show(temp_max);
+show(temp_hyst);
+show(remote_temp_input);
+show(remote_temp_max);
+show(remote_temp_hyst);
+show(remote_temp2_input);
+show(remote_temp2_max);
+show(remote_temp2_hyst);
+
+static ssize_t show_analog_out(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct thmc50_data *data = thmc50_update_device(dev);
+	return sprintf(buf, "%d\n", data->analog_out);
+}
+
+#define set(value, reg)	\
+static ssize_t set_##value(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)	\
+{								\
+	struct i2c_client *client = to_i2c_client(dev);		\
+	struct thmc50_data *data = i2c_get_clientdata(client);	\
+	int temp = simple_strtoul(buf, NULL, 10);		\
+								\
+	mutex_lock(&data->update_lock);				\
+	data->value = TEMP_TO_REG(temp);			\
+	thmc50_write_value(client, reg, data->value);		\
+	mutex_unlock(&data->update_lock);			\
+	return count;						\
+}
+set(temp_max, THMC50_REG_TEMP_OS);
+set(temp_hyst, THMC50_REG_TEMP_HYST);
+set(remote_temp_max, THMC50_REG_REMOTE_TEMP_OS);
+set(remote_temp_hyst, THMC50_REG_REMOTE_TEMP_HYST);
+set(remote_temp2_max, ADM1022_REG_REMOTE_TEMP2_OS);
+set(remote_temp2_hyst, ADM1022_REG_REMOTE_TEMP2_HYST);
+
+static ssize_t set_reg_analog_out(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct thmc50_data *data = i2c_get_clientdata(client);
+	int tmp = simple_strtoul(buf, NULL, 10);
+
+	mutex_lock(&data->update_lock);
+	data->analog_out = tmp;
+	thmc50_write_value(client, THMC50_REG_ANALOG_OUT, data->analog_out);
+	if (tmp == 0)
+		data->config_reg &= ~THMC50_REG_CONF_FANOFF;
+	else
+		data->config_reg |= THMC50_REG_CONF_FANOFF;
+	thmc50_write_value(client, THMC50_REG_CONF, data->config_reg);
+
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+/* There is only one PWM mode = DC */
+static ssize_t show_pwm_mode(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "0\n");
+}
+
+static DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max, set_temp_max);
+static DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp_hyst, set_temp_hyst);
+static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input, NULL);
+static DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_remote_temp_max, set_remote_temp_max);
+static DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_remote_temp_hyst, set_remote_temp_hyst);
+static DEVICE_ATTR(temp2_input, S_IRUGO, show_remote_temp_input, NULL);
+static DEVICE_ATTR(temp3_max, S_IWUSR | S_IRUGO, show_remote_temp2_max, set_remote_temp2_max);
+static DEVICE_ATTR(temp3_min, S_IWUSR | S_IRUGO, show_remote_temp2_hyst, set_remote_temp2_hyst);
+static DEVICE_ATTR(temp3_input, S_IRUGO, show_remote_temp2_input, NULL);
+static DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, show_analog_out, set_reg_analog_out);
+static DEVICE_ATTR(pwm1_mode, S_IRUGO, show_pwm_mode, NULL);
+
+static int thmc50_attach_adapter(struct i2c_adapter *adapter)
+{
+	if (!(adapter->class & I2C_CLASS_HWMON))
+		return 0;
+	return i2c_probe(adapter, &addr_data, thmc50_detect);
+}
+
+static struct attribute *thmc50_attributes[] = {
+	&dev_attr_temp1_max.attr,
+	&dev_attr_temp1_min.attr,
+	&dev_attr_temp1_input.attr,
+	&dev_attr_temp2_max.attr,
+	&dev_attr_temp2_min.attr,
+	&dev_attr_temp2_input.attr,
+	&dev_attr_pwm1.attr,
+	&dev_attr_pwm1_mode.attr,
+	&dev_attr_temp3_max.attr,
+	&dev_attr_temp3_min.attr,
+	&dev_attr_temp3_input.attr,
+	NULL
+};
+
+static const struct attribute_group thmc50_group = {
+	.attrs = thmc50_attributes,
+};
+
+/* This function is called by i2c_detect */
+int thmc50_detect(struct i2c_adapter *adapter, int address, int kind)
+{
+	int company;
+	int revision;
+	struct i2c_client *new_client;
+	struct thmc50_data *data;
+	struct device *dev;
+	int err = 0;
+	const char *type_name = "";
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		goto exit;
+
+	/* OK. For now, we presume we have a valid client. We now create the
+	   client structure, even though we cannot fill it completely yet.
+	   But it allows us to access thmc50_{read,write}_value. */
+	if (!(data = kzalloc(sizeof(struct thmc50_data), GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	new_client = &data->client;
+	i2c_set_clientdata(new_client, data);
+	new_client->addr = address;
+	new_client->adapter = adapter;
+	new_client->driver = &thmc50_driver;
+	new_client->flags = 0;
+	dev = &new_client->dev;
+
+	dev_dbg(dev, "thmc50.o: Probing for THMC50 at 0x%2X on bus %d\n",
+	       new_client->addr, i2c_adapter_id(new_client->adapter));
+
+	/* Now, we do the remaining detection. */
+	company =
+	    i2c_smbus_read_byte_data(new_client, THMC50_REG_COMPANY_ID);
+	revision =
+	    i2c_smbus_read_byte_data(new_client, THMC50_REG_DIE_CODE);
+
+	if (company == 0x49) {
+		kind = thmc50;
+		dev_dbg(dev, "thmc50.o: Detected THMC50 (version %x, revision %x)\n",
+		     (revision >> 4) - 0xc, revision & 0xf);
+	}
+	else if (company == 0x41) {
+		kind = adm1022;
+		dev_dbg(dev, "thmc50.o: Detected ADM1022 (version %x, revision %x)\n",
+		     (revision >> 4) - 0xc, revision & 0xf);
+	} else {
+		dev_err(dev, "thmc50.o: Detect of THMC50/ADM1022 failed\n");
+		goto exit_free;
+	}
+
+	/* Determine the chip type - only one kind supported! */
+
+	if (kind == thmc50) {
+		type_name = "thmc50";
+	/* Remove temp3 attributes */
+		thmc50_group.attrs[8] = NULL;
+		thmc50_group.attrs[9] = NULL;
+		thmc50_group.attrs[10] = NULL;
+	} else if (kind == adm1022) {
+		type_name = "adm1022";
+		if (adm1022_temp3_num > 0 && adm1022_temp3) {
+			int id = i2c_adapter_id(new_client->adapter);
+			int i;
+
+			for (i=0; i< adm1022_temp3_num - 1; i+=2) {
+				if (adm1022_temp3[i] == id && adm1022_temp3[i+1] == address)
+					data->config_reg = 0x80;
+			}
+		}
+	}
+	data->type = kind;
+
+	/* Fill in the remaining client fields and put it into the global list */
+	strlcpy(new_client->name, type_name, I2C_NAME_SIZE);
+	data->valid = 0;
+	mutex_init(&data->update_lock);
+
+	/* Tell the I2C layer a new client has arrived */
+	if ((err = i2c_attach_client(new_client)))
+		goto exit_free;
+
+	thmc50_init_client(new_client);
+
+	/* Register sysfs hooks */
+	if ((err = sysfs_create_group(&new_client->dev.kobj, &thmc50_group)))
+		goto exit_detach;
+
+	/* Register a new directory entry with module sensors */
+	data->class_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->class_dev)) {
+		err = PTR_ERR(data->class_dev);
+		goto exit_remove_sysfs;
+	}
+
+	return 0;
+
+exit_remove_sysfs:
+	sysfs_remove_group(&new_client->dev.kobj, &thmc50_group);
+exit_detach:
+	i2c_detach_client(new_client);
+exit_free:
+	kfree(data);
+exit:
+	return err;
+}
+
+static int thmc50_detach_client(struct i2c_client *client)
+{
+	struct thmc50_data *data = i2c_get_clientdata(client);
+	int err;
+
+	hwmon_device_unregister(data->class_dev);
+	sysfs_remove_group(&client->dev.kobj, &thmc50_group);
+
+	if ((err = i2c_detach_client(client)))
+		return err;
+
+	kfree(data);
+
+	return 0;
+}
+
+/* All registers are word-sized, except for the configuration register.
+   THMC50 uses a high-byte first convention, which is exactly opposite to
+   the usual practice. */
+static int thmc50_read_value(struct i2c_client *client, u8 reg)
+{
+	return i2c_smbus_read_byte_data(client, reg);
+}
+
+/* All registers are word-sized, except for the configuration register.
+   THMC50 uses a high-byte first convention, which is exactly opposite to
+   the usual practice. */
+static int thmc50_write_value(struct i2c_client *client, u8 reg, u16 value)
+{
+	return i2c_smbus_write_byte_data(client, reg, value);
+}
+
+static void thmc50_init_client(struct i2c_client *client)
+{
+	struct thmc50_data *data = i2c_get_clientdata(client);
+
+	data->config_reg |= 0x23;
+	thmc50_write_value(client, THMC50_REG_CONF, data->config_reg);
+	data->analog_out = thmc50_read_value(client, THMC50_REG_ANALOG_OUT);
+	/* set up to at least 1 */
+	if (data->analog_out == 0 ) {
+		data->analog_out = 1;
+		thmc50_write_value(client, THMC50_REG_ANALOG_OUT, data->analog_out);
+	}
+}
+
+static struct thmc50_data *thmc50_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct thmc50_data *data = i2c_get_clientdata(client);
+	int timeout = HZ / 5 + (data->type == thmc50 ? HZ : 0);
+
+	mutex_lock(&data->update_lock);
+
+	if (time_after(jiffies, data->last_updated + timeout)
+	    || !data->valid) {
+
+		data->temp_input = thmc50_read_value(client, THMC50_REG_TEMP);
+		data->temp_max =
+		    thmc50_read_value(client, THMC50_REG_TEMP_OS);
+		data->temp_hyst =
+		    thmc50_read_value(client, THMC50_REG_TEMP_HYST);
+		data->remote_temp_input =
+		    thmc50_read_value(client, THMC50_REG_REMOTE_TEMP);
+		data->remote_temp_max =
+		    thmc50_read_value(client, THMC50_REG_REMOTE_TEMP_OS);
+		data->remote_temp_hyst =
+		    thmc50_read_value(client, THMC50_REG_REMOTE_TEMP_HYST);
+		data->analog_out =
+		    thmc50_read_value(client, THMC50_REG_ANALOG_OUT);
+		data->config_reg =
+		    thmc50_read_value(client, THMC50_REG_CONF);
+		if (data->type == adm1022) {
+			data->remote_temp2_input =
+			    thmc50_read_value(client, ADM1022_REG_REMOTE_TEMP2);
+			data->remote_temp2_max =
+			    thmc50_read_value(client, ADM1022_REG_REMOTE_TEMP2_OS);
+			data->remote_temp2_hyst =
+			    thmc50_read_value(client, ADM1022_REG_REMOTE_TEMP2_HYST);
+		}
+		data->last_updated = jiffies;
+		data->valid = 1;
+	}
+
+	mutex_unlock(&data->update_lock);
+
+	return data;
+}
+
+static int __init sm_thmc50_init(void)
+{
+	return i2c_add_driver(&thmc50_driver);
+}
+
+static void __exit sm_thmc50_exit(void)
+{
+	i2c_del_driver(&thmc50_driver);
+}
+
+MODULE_AUTHOR
+    ("Frodo Looijaard <frodol@dds.nl> and Philip Edelbrock <phil@netroedge.com>");
+MODULE_DESCRIPTION("THMC50 driver");
+
+module_init(sm_thmc50_init);
+module_exit(sm_thmc50_exit);

--------------020700050209080303050302
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------020700050209080303050302--
