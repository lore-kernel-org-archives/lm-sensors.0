From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Mon, 02 Jul 2007 17:54:48 +0000
Subject: [lm-sensors] [PATCH] THMC50 support for 2.6 (2nd revision)
Message-Id: <20070702195448.2814dfb7.krzysztof.h1@wp.pl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch adds support for THMC50 and ADM1022 chips to 2.6 kernels.

Special thanks to Jean Delavare and Mark M. Hoffman for review of the first patch.

Signed-off-by: Krzysztof Helt <krzysztof.h1 at wp.pl>

---
This patch incorporates all suggestions and requests to the previously sent patch.

diff -urpN linux-2.6.21/Documentation/hwmon/thmc50
linux-2.6.22/Documentation/hwmon/thmc50 ---
linux-2.6.21/Documentation/hwmon/thmc50	1970-01-01 01:00:00.000000000 +0100 +++
linux-2.6.22/Documentation/hwmon/thmc50	2007-07-02 19:46:42.029001269 +0200 @@
-0,0 +1,86 @@ +Kernel driver thmc50
+==========+
+Supported chips:
+  * Analog Devices ADM1022
+    Prefix: 'adm1022'
+    Addresses scanned: I2C 0x2c - 0x2e
+    Datasheet: http://www.analog.com/en/prod/0,2877,ADM1022,00.html
+  * Texas Instruments THMC50
+    Prefix: 'thmc50'
+    Addresses scanned: I2C 0x2c - 0x2e
+    Datasheet: http://focus.ti.com/docs/prod/folders/print/thmc50.html
+
+Author: Krzysztof Helt <krzysztof.h1@wp.pl>
+
+This driver was derived from the 2.4 kernel thmc50.c source file.
+
+Credits:
+  thmc50.c (2.4 kernel):
+	Frodo Looijaard <frodol@dds.nl>
+	Philip Edelbrock <phil@netroedge.com>
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
+  List of adapter,address pairs of ADM1022 chips to set into measuring
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
+1 Hz for THMC50). It can be also put in a new mode to handle additional
+remote temperature sensor. Some pins change their meaning in this mode.
+If the sensor is wired to work in this mode but is not set with adm1022_temp3
+parameter a fan is forced to full output.
+
+Driver Features
+---------------
+
+The driver provides up to three temperatures:
+
+temp1		-- internal
+temp2		-- remote
+temp3		-- 2nd remote only for ADM1022
+
+pwm1		-- fan speed (0 = stop, 255 = full)
+pwm1_mode	-- always 0 (DC mode)
+
+The value of 0 for pwm1 also forces FAN_OFF signal from the chip,
+so it stops fans even if the value 0 into the ANALOG_OUT register does not.
+
+The driver was tested on Compaq AP550 with two ADM1022 chips (one works 
+in the temp3 mode), five temperature readings and two fans.
+
diff -urpN linux-2.6.21/drivers/hwmon/Kconfig linux-2.6.22/drivers/hwmon/Kconfig
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
diff -urpN linux-2.6.21/drivers/hwmon/Makefile linux-2.6.22/drivers/hwmon/Makefile
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
diff -urpN linux-2.6.21/drivers/hwmon/thmc50.c linux-2.6.22/drivers/hwmon/thmc50.c
--- linux-2.6.21/drivers/hwmon/thmc50.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.22/drivers/hwmon/thmc50.c	2007-07-02 19:43:59.519740474 +0200
@@ -0,0 +1,454 @@
+/*
+    thmc50.c - Part of lm_sensors, Linux kernel modules for hardware
+             monitoring
+    Copyright (C) 2007 Krzysztof Helt <krzysztof.h1@wp.pl>
+    Based on 2.4 driver by Frodo Looijaard <frodol@dds.nl> and
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
+static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
+
+/* Insmod parameters */
+I2C_CLIENT_INSMOD_2(thmc50,adm1022);
+I2C_CLIENT_MODULE_PARM(adm1022_temp3, "List of adapter,address pairs "
+			"to enable 3rd temperature (ADM1022 only)");
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
+	s8 temp_input;
+	s8 temp_max;
+	s8 temp_hyst;
+	s8 remote_temp_input;
+	s8 remote_temp_max;
+	s8 remote_temp_hyst;
+	s8 remote_temp2_input;
+	s8 remote_temp2_max;
+	s8 remote_temp2_hyst;
+	u8 analog_out;
+	u8 config_reg;
+};
+
+static int thmc50_attach_adapter(struct i2c_adapter *adapter);
+static int thmc50_detach_client(struct i2c_client *client);
+static void thmc50_init_client(struct i2c_client *client);
+static struct thmc50_data *thmc50_update_device(struct device *dev);
+
+static struct i2c_driver thmc50_driver = {
+	.driver = {
+		.name		= "thmc50 sensor chip driver",
+	},
+	.attach_adapter	= thmc50_attach_adapter,
+	.detach_client	= thmc50_detach_client,
+};
+
+#define show(value)						\
+static ssize_t show_##value(struct device *dev, 		\
+			    struct device_attribute *attr,	\
+	   		    char *buf)				\
+{								\
+	struct thmc50_data *data = thmc50_update_device(dev);	\
+	return sprintf(buf, "%d\n", 1000 * data->value);	\
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
+static ssize_t show_analog_out(struct device *dev,
+	       		       struct device_attribute *attr,
+			       char *buf)
+{
+	struct thmc50_data *data = thmc50_update_device(dev);
+	return sprintf(buf, "%d\n", data->analog_out);
+}
+
+#define set(value, reg)	\
+static ssize_t set_##value(struct device *dev,			\
+		       	   struct device_attribute *attr,	\
+	       		   const char *buf, size_t count)	\
+{								\
+	struct i2c_client *client = to_i2c_client(dev);		\
+	struct thmc50_data *data = i2c_get_clientdata(client);	\
+	int temp = simple_strtoul(buf, NULL, 10);		\
+								\
+	mutex_lock(&data->update_lock);				\
+	data->value = temp / 1000;				\
+	i2c_smbus_write_byte_data(client, reg, data->value);	\
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
+static ssize_t set_analog_out(struct device *dev,
+				  struct device_attribute *attr, 
+				  const char *buf,
+			       	  size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct thmc50_data *data = i2c_get_clientdata(client);
+	int tmp = simple_strtoul(buf, NULL, 10);
+
+	mutex_lock(&data->update_lock);
+	data->analog_out = tmp;
+	i2c_smbus_write_byte_data(client, THMC50_REG_ANALOG_OUT,
+		       			data->analog_out);
+	if (tmp = 0)
+		data->config_reg &= ~THMC50_REG_CONF_FANOFF;
+	else
+		data->config_reg |= THMC50_REG_CONF_FANOFF;
+	i2c_smbus_write_byte_data(client, THMC50_REG_CONF, data->config_reg);
+
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+/* There is only one PWM mode = DC */
+static ssize_t show_pwm_mode(struct device *dev,
+	       		     struct device_attribute *attr,
+			     char *buf)
+{
+	return sprintf(buf, "0\n");
+}
+
+static DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max, set_temp_max);
+static DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp_hyst,
+						 set_temp_hyst);
+static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input, NULL);
+static DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_remote_temp_max,
+	       				 set_remote_temp_max);
+static DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_remote_temp_hyst,
+						set_remote_temp_hyst);
+static DEVICE_ATTR(temp2_input, S_IRUGO, show_remote_temp_input, NULL);
+static DEVICE_ATTR(temp3_max, S_IWUSR | S_IRUGO, show_remote_temp2_max,
+						set_remote_temp2_max);
+static DEVICE_ATTR(temp3_min, S_IWUSR | S_IRUGO, show_remote_temp2_hyst,
+	       				set_remote_temp2_hyst);
+static DEVICE_ATTR(temp3_input, S_IRUGO, show_remote_temp2_input, NULL);
+static DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, show_analog_out,
+	       				 set_analog_out);
+static DEVICE_ATTR(pwm1_mode, S_IRUGO, show_pwm_mode, NULL);
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
+	NULL
+};
+
+static const struct attribute_group thmc50_group = {
+	.attrs = thmc50_attributes,
+};
+
+/* for ADM1022 3rd temperature mode */
+static struct attribute *adm1022_attributes[] = {
+	&dev_attr_temp3_max.attr,
+	&dev_attr_temp3_min.attr,
+	&dev_attr_temp3_input.attr,
+	NULL
+};
+
+static const struct attribute_group adm1022_group = {
+	.attrs = adm1022_attributes,
+};
+
+static int thmc50_detect(struct i2c_adapter *adapter, int address, int kind)
+{
+	int company;
+	int revision;
+	struct i2c_client *client;
+	struct thmc50_data *data;
+	struct device *dev;
+	int err = 0;
+	const char *type_name = "";
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
+		pr_debug("thmc50.o: detect failed, "
+				"smbus byte data not supported!\n");
+		goto exit;
+	}
+
+	/* OK. For now, we presume we have a valid client. We now create the
+	   client structure, even though we cannot fill it completely yet.
+	   But it allows us to access thmc50 registers. */
+	if (!(data = kzalloc(sizeof(struct thmc50_data), GFP_KERNEL))) {
+		pr_debug("thmc50.o: detect failed, kzalloc failed!\n");
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	client = &data->client;
+	i2c_set_clientdata(client, data);
+	client->addr = address;
+	client->adapter = adapter;
+	client->driver = &thmc50_driver;
+	client->flags = 0;
+	dev = &client->dev;
+
+	pr_debug("thmc50.o: Probing for THMC50 at 0x%2X on bus %d\n",
+	       client->addr, i2c_adapter_id(client->adapter));
+
+	/* Now, we do the remaining detection. */
+	company = i2c_smbus_read_byte_data(client, THMC50_REG_COMPANY_ID);
+	revision = i2c_smbus_read_byte_data(client, THMC50_REG_DIE_CODE);
+
+	if (company = 0x49) {
+		kind = thmc50;
+		pr_debug("thmc50.o: Detected THMC50 "
+				"(version %x, revision %x)\n",
+				(revision >> 4) - 0xc, revision & 0xf);
+	} else if (company = 0x41) {
+		kind = adm1022;
+		pr_debug("thmc50.o: Detected ADM1022 "
+				"(version %x, revision %x)\n",
+				(revision >> 4) - 0xc, revision & 0xf);
+	} else {
+		pr_debug("thmc50.o: Detection of THMC50/ADM1022 failed\n");
+		goto exit_free;
+	}
+
+	/* Determine the chip type - only one kind supported! */
+
+	if (kind = thmc50) {
+		type_name = "thmc50";
+	} else if (kind = adm1022) {
+		type_name = "adm1022";
+		if (adm1022_temp3_num > 0 && adm1022_temp3) {
+			int id = i2c_adapter_id(client->adapter);
+			int i;
+
+			for (i=0; i< adm1022_temp3_num - 1; i+=2) {
+				if (adm1022_temp3[i] = id
+				    && adm1022_temp3[i+1] = address) {
+					data->config_reg = 0x80;
+				}
+			}
+		}
+	}
+	data->type = kind;
+
+	/* Fill in the remaining client fields & put it into the global list */
+	strlcpy(client->name, type_name, I2C_NAME_SIZE);
+	data->valid = 0;
+	mutex_init(&data->update_lock);
+
+	/* Tell the I2C layer a new client has arrived */
+	if ((err = i2c_attach_client(client)))
+		goto exit_free;
+
+	thmc50_init_client(client);
+
+	/* Register sysfs hooks */
+	if ((err = sysfs_create_group(&client->dev.kobj, &thmc50_group)))
+		goto exit_detach;
+
+	/* Register ADM1022 sysfs hooks */
+	if (kind = adm1022)
+		if ((err = sysfs_create_group(&client->dev.kobj,
+					       	&adm1022_group)))
+			goto exit_remove_sysfs_thmc50;
+
+	/* Register a new directory entry with module sensors */
+	data->class_dev = hwmon_device_register(&client->dev);
+	if (IS_ERR(data->class_dev)) {
+		err = PTR_ERR(data->class_dev);
+		goto exit_remove_sysfs;
+	}
+
+	return 0;
+
+exit_remove_sysfs:
+	if (kind = adm1022)
+		sysfs_remove_group(&client->dev.kobj, &adm1022_group);
+exit_remove_sysfs_thmc50:
+	sysfs_remove_group(&client->dev.kobj, &thmc50_group);
+exit_detach:
+	i2c_detach_client(client);
+exit_free:
+	kfree(data);
+exit:
+	return err;
+}
+
+static int thmc50_attach_adapter(struct i2c_adapter *adapter)
+{
+	if (!(adapter->class & I2C_CLASS_HWMON))
+		return 0;
+	return i2c_probe(adapter, &addr_data, thmc50_detect);
+}
+
+static int thmc50_detach_client(struct i2c_client *client)
+{
+	struct thmc50_data *data = i2c_get_clientdata(client);
+	int err;
+
+	hwmon_device_unregister(data->class_dev);
+	sysfs_remove_group(&client->dev.kobj, &thmc50_group);
+	if (data->type = adm1022)
+		sysfs_remove_group(&client->dev.kobj, &adm1022_group);
+
+	if ((err = i2c_detach_client(client)))
+		return err;
+
+	kfree(data);
+
+	return 0;
+}
+
+static void thmc50_init_client(struct i2c_client *client)
+{
+	struct thmc50_data *data = i2c_get_clientdata(client);
+
+	data->config_reg |= 0x23;
+	i2c_smbus_write_byte_data(client, THMC50_REG_CONF, data->config_reg);
+	data->analog_out = i2c_smbus_read_byte_data(client,
+						THMC50_REG_ANALOG_OUT);
+	/* set up to at least 1 */
+	if (data->analog_out = 0 ) {
+		data->analog_out = 1;
+		i2c_smbus_write_byte_data(client, THMC50_REG_ANALOG_OUT,
+				       		data->analog_out);
+	}
+}
+
+static struct thmc50_data *thmc50_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct thmc50_data *data = i2c_get_clientdata(client);
+	int timeout = HZ / 5 + (data->type = thmc50 ? HZ : 0);
+
+	mutex_lock(&data->update_lock);
+
+	if (time_after(jiffies, data->last_updated + timeout)
+	    || !data->valid) {
+
+		data->temp_input = i2c_smbus_read_byte_data(client,
+						THMC50_REG_TEMP);
+		data->temp_max +		    i2c_smbus_read_byte_data(client, THMC50_REG_TEMP_OS);
+		data->temp_hyst +		    i2c_smbus_read_byte_data(client, THMC50_REG_TEMP_HYST);
+		data->remote_temp_input +		    i2c_smbus_read_byte_data(client, THMC50_REG_REMOTE_TEMP);
+		data->remote_temp_max +		    i2c_smbus_read_byte_data(client,
+				   		THMC50_REG_REMOTE_TEMP_OS);
+		data->remote_temp_hyst +		    i2c_smbus_read_byte_data(client,
+				   		THMC50_REG_REMOTE_TEMP_HYST);
+		data->analog_out +		    i2c_smbus_read_byte_data(client, THMC50_REG_ANALOG_OUT);
+		data->config_reg +		    i2c_smbus_read_byte_data(client, THMC50_REG_CONF);
+		if (data->type = adm1022) {
+			data->remote_temp2_input +			    i2c_smbus_read_byte_data(client,
+					    	ADM1022_REG_REMOTE_TEMP2);
+			data->remote_temp2_max +			    i2c_smbus_read_byte_data(client,
+					   	ADM1022_REG_REMOTE_TEMP2_OS);
+			data->remote_temp2_hyst +			    i2c_smbus_read_byte_data(client,
+					   	ADM1022_REG_REMOTE_TEMP2_HYST);
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
+MODULE_AUTHOR("Krzysztof Helt <krzysztof.h1@wp.pl>");
+MODULE_DESCRIPTION("THMC50 driver");
+
+module_init(sm_thmc50_init);
+module_exit(sm_thmc50_exit);

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
