From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: DS1621 support for kernel 2.6 (new patch)
Message-Id: <20040306213810.GA14805@pc.aurel32.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

In the latest patch I sent, which adds support for DS1621 to the 2.6
kernels, there is a line which contains a call to the printk function.
I used it for debugging purpose and I forgot to remove it. This line 
can be safely removed. Please find attached the new patch which fixes
that.

Aurelien

-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineering Student 
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
-------------- next part --------------
diff -urN linux-2.6.3.orig/drivers/i2c/chips/ds1621.c linux-2.6.3/drivers/i2c/chips/ds1621.c
--- linux-2.6.3.orig/drivers/i2c/chips/ds1621.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.3/drivers/i2c/chips/ds1621.c	2004-03-05 23:17:50.000000000 +0100
@@ -0,0 +1,462 @@
+/*
+    ds1621.c - Part of lm_sensors, Linux kernel modules for hardware
+             monitoring
+    Christian W. Zuckschwerdt  <zany@triq.net>  2000-11-23
+    based on lm75.c by Frodo Looijaard <frodol@dds.nl>
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
+/* Supports DS1621. See doc/chips/ds1621 for details */
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/i2c-sensor.h>
+#include <linux/init.h>
+
+/* Addresses to scan */
+static unsigned short normal_i2c[] = { I2C_CLIENT_END };
+static unsigned short normal_i2c_range[] = { 0x48, 0x4f, I2C_CLIENT_END };
+static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
+static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
+
+/* Insmod parameters */
+SENSORS_INSMOD_1(ds1621);
+
+/* Many DS1621 constants specified below */
+
+/* Config register used for detection         */
+/*  7    6    5    4    3    2    1    0      */
+/* |Done|THF |TLF |NVB | 1  | 0  |POL |1SHOT| */
+#define DS1621_REG_CONFIG_MASK 		0x0C
+#define DS1621_REG_CONFIG_VAL 		0x08
+#define DS1621_REG_CONFIG_POLARITY 	0x02
+#define DS1621_REG_CONFIG_1SHOT 	0x01
+#define DS1621_REG_CONFIG_DONE 		0x80
+
+/* Note: the done bit is always unset if continuous conversion is in progress.
+         We need to stop the continuous conversion or switch to single shot
+         before this bit becomes available!
+ */
+
+/* The DS1621 registers */
+#define DS1621_REG_TEMP 	0xAA /* word, RO */
+#define DS1621_REG_TEMP_OVER 	0xA1 /* word, RW */
+#define DS1621_REG_TEMP_HYST 	0xA2 /* word, RW -- it's a low temp trigger */
+#define DS1621_REG_CONF 	0xAC /* byte, RW */
+#define DS1621_REG_TEMP_COUNTER 0xA8 /* byte, RO */
+#define DS1621_REG_TEMP_SLOPE 	0xA9 /* byte, RO */
+#define DS1621_COM_START 	0xEE /* no data */
+#define DS1621_COM_STOP 	0x22 /* no data */
+
+/* The DS1621 configuration register */
+#define DS1621_ALARM_TEMP_HIGH 	0x40
+#define DS1621_ALARM_TEMP_LOW 	0x20
+
+/* Conversions. Rounding and limit checking is only done on the TO_REG
+   variants. Note that you should be a bit careful with which arguments
+   these macros are called: arguments may be evaluated more than once.
+   Fixing this is just not worth it. */
+#define TEMP_FROM_REG(val) ((((val & 0x7fff) >> 7) * 500) | \
+                            ((val & 0x8000)?-256:0))
+#define TEMP_TO_REG(val)   (SENSORS_LIMIT((val<0 ? (0x200+((val)/500))<<7 : \
+                                          (((val) + 2) / 5) << 7),0,0xffff))
+#define ALARMS_FROM_REG(val) (!(!((val) & \
+                              (DS1621_ALARM_TEMP_HIGH | DS1621_ALARM_TEMP_LOW))))
+#define ITEMP_FROM_REG(val) (((((val & 0x7fff) >> 8)) | \
+                            ((val & 0x8000)?-256:0)) * 100)
+
+/* Each client has this additional data */
+struct ds1621_data {
+	struct semaphore update_lock;
+	char valid;		/* !=0 if following fields are valid */
+	unsigned long last_updated;	/* In jiffies */
+
+	u16 temp, temp_over, temp_hyst;	/* Register values, word */
+	u8 conf;			/* Register encoding, combined */
+
+	char enable;	/* !=0 if we're expected to restart the conversion */
+	u8 temp_int, temp_counter, temp_slope;	/* Register values, byte */
+};
+
+static int ds1621_attach_adapter(struct i2c_adapter *adapter);
+static int ds1621_detect(struct i2c_adapter *adapter, int address,
+			 int kind);
+static void ds1621_init_client(struct i2c_client *client);
+static int ds1621_detach_client(struct i2c_client *client);
+static void ds1621_update_client(struct i2c_client *client);
+
+/* This is the driver that will be inserted */
+static struct i2c_driver ds1621_driver = {
+	.owner		= THIS_MODULE,
+	.name		= "ds1621",
+	.id		= I2C_DRIVERID_DS1621,
+	.flags		= I2C_DF_NOTIFY,
+	.attach_adapter	= ds1621_attach_adapter,
+	.detach_client	= ds1621_detach_client,
+};
+
+static int ds1621_id = 0;
+
+static u16 swap_bytes(u16 val)
+{
+	return (val >> 8) | (val << 8);
+}
+
+/* All registers are word-sized, except for the configuration register.
+   DS1621 uses a high-byte first convention, which is exactly opposite to
+   the usual practice. */
+static int ds1621_read_value(struct i2c_client *client, u8 reg)
+{
+	if ((reg = DS1621_REG_CONF) || (reg = DS1621_REG_TEMP_COUNTER)
+	    || (reg = DS1621_REG_TEMP_SLOPE))
+		return i2c_smbus_read_byte_data(client, reg);
+	else
+		return swap_bytes(i2c_smbus_read_word_data(client, reg));
+}
+
+/* All registers are word-sized, except for the configuration register.
+   DS1621 uses a high-byte first convention, which is exactly opposite to
+   the usual practice. */
+static int ds1621_write_value(struct i2c_client *client, u8 reg, u16 value)
+{
+	if ( (reg = DS1621_COM_START) || (reg = DS1621_COM_STOP) )
+		return i2c_smbus_write_byte(client, reg);
+	else
+	if ((reg = DS1621_REG_CONF) || (reg = DS1621_REG_TEMP_COUNTER)
+	    || (reg = DS1621_REG_TEMP_SLOPE))
+		return i2c_smbus_write_byte_data(client, reg, value);
+	else
+		return i2c_smbus_write_word_data(client, reg,
+						 swap_bytes(value));
+}
+
+static void ds1621_init_client(struct i2c_client *client)
+{
+	struct ds1621_data *data = i2c_get_clientdata(client);
+	int reg = ds1621_read_value(client, DS1621_REG_CONF);
+	/* switch to continous conversion mode */
+	if(reg & DS1621_REG_CONFIG_1SHOT)
+		ds1621_write_value(client, DS1621_REG_CONF, 
+				   reg & ~ DS1621_REG_CONFIG_1SHOT);
+	/* start conversion */
+	ds1621_write_value(client, DS1621_COM_START, 0);
+	data->enable = 1;
+}
+
+#define show(value)     \
+static ssize_t show_##value(struct device *dev, char *buf)		\
+{									\
+        struct i2c_client *client = to_i2c_client(dev);			\
+	struct ds1621_data *data = i2c_get_clientdata(client);		\
+	ds1621_update_client(client);					\
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->value));	\
+}
+
+show(temp);
+show(temp_hyst);
+show(temp_over);
+
+#define set_temp(suffix, value, reg) \
+static ssize_t set_temp_##suffix(struct device *dev, const char *buf,	\
+		        size_t count)					\
+{									\
+	struct i2c_client *client = to_i2c_client(dev); 		\
+	struct ds1621_data *data = i2c_get_clientdata(client); 		\
+	data->value = TEMP_TO_REG(simple_strtoul(buf, NULL, 10)); 	\
+	ds1621_write_value(client, reg, data->value); 			\
+	return count; 							\
+}
+
+set_temp(hyst, temp_hyst, DS1621_REG_TEMP_HYST);
+set_temp(over, temp_over, DS1621_REG_TEMP_OVER);
+
+static ssize_t show_polarity(struct device *dev, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+        struct ds1621_data *data = i2c_get_clientdata(client);
+	ds1621_update_client(client);
+	return sprintf(buf, "%d\n", !(!(data->conf & DS1621_REG_CONFIG_POLARITY)));
+}
+
+static ssize_t set_polarity(struct device *dev, const char *buf,
+			    size_t count)					
+{									
+	struct i2c_client *client = to_i2c_client(dev);	
+	struct ds1621_data *data = i2c_get_clientdata(client); 	
+	ds1621_update_client(client);
+	if (simple_strtoul(buf, NULL, 10)) 
+		data->conf |= DS1621_REG_CONFIG_POLARITY;
+	else
+		data->conf &= ~DS1621_REG_CONFIG_POLARITY;
+	ds1621_write_value(client, DS1621_REG_CONF, data->conf);
+	return count;
+}
+
+static ssize_t show_continuous(struct device *dev, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+        struct ds1621_data *data = i2c_get_clientdata(client);
+	ds1621_update_client(client);
+	return sprintf(buf, "%d\n", !(data->conf & DS1621_REG_CONFIG_1SHOT));
+}
+
+static ssize_t set_continuous(struct device *dev, const char *buf,
+			      size_t count)					
+{		 							
+	struct i2c_client *client = to_i2c_client(dev);	
+	struct ds1621_data *data = i2c_get_clientdata(client); 	
+	ds1621_update_client(client);
+	if (simple_strtoul(buf, NULL, 10)) 
+		data->conf &= ~DS1621_REG_CONFIG_1SHOT;
+	else
+		data->conf |= DS1621_REG_CONFIG_1SHOT;
+	ds1621_write_value(client, DS1621_REG_CONF, data->conf);
+	if (data->enable)
+		ds1621_write_value(client, DS1621_COM_START, 0);
+	return count;
+}
+
+static ssize_t show_enable(struct device *dev, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+        struct ds1621_data *data = i2c_get_clientdata(client);
+	ds1621_update_client(client);
+	return sprintf(buf, "%d\n", !(data->conf & DS1621_REG_CONFIG_DONE));
+}
+
+static ssize_t set_enable(struct device *dev, const char *buf,
+			  size_t count)					
+{									
+	/* If you really screw up your chip (like I did) this is */
+	/* sometimes needed to (re)start the continous conversion */
+	/* there is no data to read so this might hang your SMBus! */
+
+	struct i2c_client *client = to_i2c_client(dev);	
+	struct ds1621_data *data = i2c_get_clientdata(client); 	
+	if (simple_strtoul(buf, NULL, 10)) {
+		ds1621_write_value(client, DS1621_COM_START, 0);
+		data->enable = 1;
+	} else {
+		ds1621_write_value(client, DS1621_COM_STOP, 0);
+		data->enable = 0;
+	}
+	return count;
+}
+
+
+static ssize_t show_alarms(struct device *dev, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+        struct ds1621_data *data = i2c_get_clientdata(client);
+	ds1621_update_client(client);
+	return sprintf(buf, "%d\n", ALARMS_FROM_REG(data->conf));
+}
+
+static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
+static DEVICE_ATTR(continuous, S_IWUSR | S_IRUGO, show_continuous, set_continuous);
+static DEVICE_ATTR(enable, S_IWUSR | S_IRUGO, show_enable, set_enable);
+static DEVICE_ATTR(temp_input1, S_IRUGO , show_temp, NULL);
+static DEVICE_ATTR(temp_hyst1, S_IWUSR | S_IRUGO , show_temp_hyst, set_temp_hyst);
+static DEVICE_ATTR(temp_max1, S_IWUSR | S_IRUGO, show_temp_over, set_temp_over);
+static DEVICE_ATTR(polarity, S_IWUSR | S_IRUGO, show_polarity, set_polarity);
+
+
+static int ds1621_attach_adapter(struct i2c_adapter *adapter)
+{
+	return i2c_detect(adapter, &addr_data, ds1621_detect);
+}
+
+/* This function is called by i2c_detect */
+int ds1621_detect(struct i2c_adapter *adapter, int address,
+		  int kind)
+{
+	int conf;
+	struct i2c_client *new_client;
+	struct ds1621_data *data;
+	int err = 0;
+	const char *client_name = "";
+
+	/* Make sure we aren't probing the ISA bus!! This is just a safety check
+	   at this moment; i2c_detect really won't call us. */
+	if (i2c_is_isa_adapter(adapter)) {
+		dev_dbg(&adapter->dev, 
+		        "ds1621.o: ds1621_detect called for an ISA bus adapter?!?\n");
+		return 0;
+	}
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
+				     I2C_FUNC_SMBUS_WORD_DATA))
+		    goto ERROR0;
+
+	/* OK. For now, we presume we have a valid client. We now create the
+	   client structure, even though we cannot fill it completely yet.
+	   But it allows us to access ds1621_{read,write}_value. */
+	if (!(new_client = kmalloc(sizeof(struct i2c_client) +
+				   sizeof(struct ds1621_data),
+				   GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto ERROR1;
+	}
+        memset(new_client, 0, sizeof(struct i2c_client) +
+	       sizeof(struct ds1621_data));
+	
+	data = (struct ds1621_data *) (new_client + 1);
+	i2c_set_clientdata(new_client, data);
+	new_client->addr = address;
+	new_client->adapter = adapter;
+	new_client->driver = &ds1621_driver;
+	new_client->flags = 0;
+
+
+	/* Now, we do the remaining detection. It is lousy. */
+	if (kind < 0) {
+		conf = i2c_smbus_read_byte_data(new_client,
+						DS1621_REG_CONF);
+		if ((conf & DS1621_REG_CONFIG_MASK)
+		    != DS1621_REG_CONFIG_VAL)
+			goto ERROR2;
+	}
+
+	/* Determine the chip type - only one kind supported! */
+	if (kind <= 0)
+		kind = ds1621;
+
+	if (kind = ds1621) {
+		client_name = "ds1621";
+	} else {
+		dev_dbg(&adapter->dev,
+		        "ds1621.o: Internal error: unknown kind (%d)?!?",
+		        kind);
+		goto ERROR2;
+	}
+
+	/* Fill in remaining client fields and put it into the global list */
+	strlcpy(new_client->name, client_name, I2C_NAME_SIZE);
+
+	new_client->id = ds1621_id++;
+	data->valid = 0;
+	init_MUTEX(&data->update_lock);
+
+	/* Tell the I2C layer a new client has arrived */
+	if ((err = i2c_attach_client(new_client)))
+		goto ERROR2;
+
+	/* Initialize the DS1621 chip */
+	ds1621_init_client(new_client);
+
+	/* Register sysfs hooks */
+        device_create_file(&new_client->dev, &dev_attr_alarms);
+        device_create_file(&new_client->dev, &dev_attr_continuous);
+        device_create_file(&new_client->dev, &dev_attr_enable);
+        device_create_file(&new_client->dev, &dev_attr_temp_input1);
+        device_create_file(&new_client->dev, &dev_attr_temp_hyst1);
+        device_create_file(&new_client->dev, &dev_attr_temp_max1);
+        device_create_file(&new_client->dev, &dev_attr_polarity);
+	
+	return 0;
+
+/* OK, this is not exactly good programming practice, usually. But it is
+   very code-efficient in this case. */
+      ERROR2:
+	kfree(new_client);
+      ERROR1:
+      ERROR0:
+	return err;
+}
+
+static int ds1621_detach_client(struct i2c_client *client)
+{
+	int err;
+
+	if ((err = i2c_detach_client(client))) {
+		dev_err(&client->dev,
+		        "ds1621.o: Client deregistration failed, client not detached.\n");
+		return err;
+	}
+
+	kfree(client);
+
+	return 0;
+}
+
+static void ds1621_update_client(struct i2c_client *client)
+{
+	struct ds1621_data *data = i2c_get_clientdata(client);
+	u8 new_conf;
+
+	down(&data->update_lock);
+
+	if ((jiffies - data->last_updated > HZ + HZ / 2) ||
+	    (jiffies < data->last_updated) || !data->valid) {
+
+		dev_dbg(&client->dev, "Starting ds1621 update\n");
+
+		data->conf = ds1621_read_value(client, DS1621_REG_CONF);
+
+		data->temp = ds1621_read_value(client, DS1621_REG_TEMP);
+		
+		data->temp_over = ds1621_read_value(client,
+		                                    DS1621_REG_TEMP_OVER);
+		data->temp_hyst = ds1621_read_value(client,
+						    DS1621_REG_TEMP_HYST);
+
+		/* wait for the DONE bit before reading extended values */
+		if (data->conf & DS1621_REG_CONFIG_DONE) {
+			data->temp_counter = ds1621_read_value(client,
+						     DS1621_REG_TEMP_COUNTER);
+			data->temp_slope = ds1621_read_value(client,
+						     DS1621_REG_TEMP_SLOPE);
+			data->temp_int = ITEMP_FROM_REG(data->temp);
+			/* restart the conversion */
+			if (data->enable)
+				ds1621_write_value(client, DS1621_COM_START, 0);
+		}
+
+		/* reset alarms if neccessary */
+		new_conf = data->conf;
+		if (data->temp < data->temp_over)
+			new_conf &= ~DS1621_ALARM_TEMP_HIGH;
+		if (data->temp > data->temp_hyst)
+			new_conf &= ~DS1621_ALARM_TEMP_LOW;
+		if (data->conf != new_conf)
+			ds1621_write_value(client, DS1621_REG_CONF,
+					   new_conf);
+
+		data->last_updated = jiffies;
+		data->valid = 1;
+	}
+
+	up(&data->update_lock);
+}
+
+static int __init ds1621_init(void)
+{
+	return i2c_add_driver(&ds1621_driver);
+}
+
+static void __exit ds1621_exit(void)
+{
+	i2c_del_driver(&ds1621_driver);
+}
+
+
+MODULE_AUTHOR("Christian W. Zuckschwerdt <zany@triq.net>");
+MODULE_DESCRIPTION("DS1621 driver");
+MODULE_LICENSE("GPL");
+
+module_init(ds1621_init);
+module_exit(ds1621_exit);
diff -urN linux-2.6.3.orig/drivers/i2c/chips/Kconfig linux-2.6.3/drivers/i2c/chips/Kconfig
--- linux-2.6.3.orig/drivers/i2c/chips/Kconfig	2004-02-18 04:58:10.000000000 +0100
+++ linux-2.6.3/drivers/i2c/chips/Kconfig	2004-03-05 23:18:06.000000000 +0100
@@ -33,6 +33,17 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called asb100.
 
+config SENSORS_DS1621
+      	tristate "Dallas Semiconductor DS1621 and DS1625"
+	depends on I2C && EXPERIMENTAL
+	select I2C_SENSOR
+	help
+	  If you say yes here you get support for Dallas Semiconductor
+	  DS1621 and DS1625 sensor chips. 
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called ds1621.
+
 config SENSORS_EEPROM
 	tristate "EEPROM (DIMM) reader"
 	depends on I2C && EXPERIMENTAL
diff -urN linux-2.6.3.orig/drivers/i2c/chips/Makefile linux-2.6.3/drivers/i2c/chips/Makefile
--- linux-2.6.3.orig/drivers/i2c/chips/Makefile	2004-02-18 05:00:01.000000000 +0100
+++ linux-2.6.3/drivers/i2c/chips/Makefile	2004-03-05 23:17:54.000000000 +0100
@@ -7,6 +7,7 @@
 obj-$(CONFIG_SENSORS_W83781D)	+= w83781d.o
 
 obj-$(CONFIG_SENSORS_ADM1021)	+= adm1021.o
+obj-$(CONFIG_SENSORS_DS1621)	+= ds1621.o
 obj-$(CONFIG_SENSORS_EEPROM)	+= eeprom.o
 obj-$(CONFIG_SENSORS_FSCHER)	+= fscher.o
 obj-$(CONFIG_SENSORS_GL518SM)	+= gl518sm.o
