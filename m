From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:24:47 +0000
Subject: DS1621 support for kernel 2.6 (new patch)
Message-Id: <20040314120717.GA24708@pc.aurel32.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040306213810.GA14805@pc.aurel32.private>
In-Reply-To: <20040306213810.GA14805@pc.aurel32.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Mar 13, 2004 at 11:48:34PM +0100, Jean Delvare wrote:
> > The double negation is used to convert a number equal to zero or
> > different to zero to a number equal to 0 or 1.
> > 
> > I don't have a lot of idea to reformulate it, I used:
> > 
> > #define ALARMS_FROM_REG(val) (((val) & \
> > 			      (DS1621_ALARM_TEMP_HIGH |
> > 			       DS621_ALARM_TEMP_LOW)) & \
> > 			       1)
> > 
> > Maybe you have a better idea.
> 
> The problem is, I don't see what you are trying to do. The original
> driver has:
> 
> #define ALARMS_FROM_REG(val) ((val) & \
>                               (DS1621_ALARM_TEMP_HIGH | DS1621_ALARM_TEMP_LOW))
> 
> And this is exactly what you are supposed to have. Why did you want to
> change it in the first place?
In the old driver, the output of ALARMS_FROM_REG was not binary (0 or
1), but could take four values, 0, 32, 64 or 96. That was what I was
trying to change. I recognize that the formulations I used are not
easily readable. In the new version, I let the old formulation and used 
the following line in show_alarms():
return sprintf(buf, "%d\n", ALARMS_FROM_REG(data->conf) != 0);

> > > Polarity
> > > should be left unchanged. 
> > I not really agree with that. The polarity parameter doesn't control
> > the polarity of the alarms, but rather the polarity of the output pin.
> > On my circuit, this pin activates a relay, and the polarity would be
> > different if you want to connect an heater or an air conditionner!
> 
> I usually object that BIOSes are supposed to set things up for you, but
> it of course doesn't apply in this case.
> 
> Don't you think it should be a module parameter instead? I don't think
> that's the kind of setting you want to change at runtime. I'd suggest
> that you leave the polarity unchanged by default, and force it to 0 or 1
> on user request.
> 
> If you don't like the idea, then we have to find a correct name for the
> sysfs file. Whenever possible, sysfs names should express precisely what
> they represent.
I added the polarity parameter to the module.

> On the patch itself:
> 
> > /* The DS1621 registers */
> > #define DS1621_REG_TEMP			0xAA /* word, RO */
> > #define DS1621_REG_TEMP_OVER		0xA1 /* word, RW */
> > #define DS1621_REG_TEMP_HYST		0xA2 /* word, RW -- it's a low temp trigger */
> > #define DS1621_REG_CONF			0xAC /* byte, RW */
> > #define DS1621_REG_TEMP_COUNTER		0xA8 /* byte, RO */
> > #define DS1621_REG_TEMP_SLOPE		0xA9 /* byte, RO */
> > #define DS1621_COM_START		0xEE /* no data */
> > #define DS1621_COM_STOP			0x22 /* no data */
> 
> DS1621_REG_TEMP_COUNTER, DS1621_REG_TEMP_SLOPE and DS1621_COM_STOP are
> unused. Removing them completely would simplify ds1621_read_value and
> ds1621_write_value much.
Done.

> > /* All registers are word-sized, except for the configuration register.
> >    DS1621 uses a high-byte first convention, which is exactly opposite to
> >    the usual practice. */
> > static int ds1621_read_value(struct i2c_client *client, u8 reg)
> > {
> > 	if ((reg = DS1621_REG_CONF) || (reg = DS1621_REG_TEMP_COUNTER)
> > 	    || (reg = DS1621_REG_TEMP_SLOPE))
> > 		return i2c_smbus_read_byte_data(client, reg);
> > 	else
> > 		return swap_bytes(i2c_smbus_read_word_data(client, reg));
> > }
> > 
> > /* All registers are word-sized, except for the configuration register.
> >    DS1621 uses a high-byte first convention, which is exactly opposite to
> >    the usual practice. */
> > static int ds1621_write_value(struct i2c_client *client, u8 reg, u16 value)
> > {
> > 	if ( (reg = DS1621_COM_START) || (reg = DS1621_COM_STOP) )
> > 		return i2c_smbus_write_byte(client, reg);
> > 	else
> > 	if ((reg = DS1621_REG_CONF) || (reg = DS1621_REG_TEMP_COUNTER)
> > 	    || (reg = DS1621_REG_TEMP_SLOPE))
> > 		return i2c_smbus_write_byte_data(client, reg, value);
> > 	else
> > 		return i2c_smbus_write_word_data(client, reg,
> > 						 swap_bytes(value));
> > }
> 
> The comments don't match the code, but it doesn't matter much if you get
> rid of DS1621_REG_TEMP_COUNTER and DS1621_REG_TEMP_SLOPE completely.
> 
> I don't think I would include DS1621_COM_START in ds1621_write_value,
> since it's used only once and isn't a real write. But maybe that's just
> me.
Done.

> > static DEVICE_ATTR(temp_hyst1, S_IWUSR | S_IRUGO , show_temp_hyst, set_temp_hyst);
> > static DEVICE_ATTR(temp_max1, S_IWUSR | S_IRUGO, show_temp_over, set_temp_over);
> 
> BTW, is it an hysteresis or a min limit? After a quick look at the
> DS1621 datasheet, I'm not absolutely sure. It looks like an hysteresis
> for the output but a min for the alarm flags. Doesn't make much sense to
> me. Any chance you can clarify the situation?
After reading the datasheet and making some tests, I have understood how
it functions. It a little bit complicated:

- There is in fact two registers, one for the minimum temperature, and
  one for the maximum temperature. A soft alarm is generated when the
  temperature is outside the range defined by this two temperatures.
- Concerning the output pin, one of the two register, depending on the
  choosen polarity, is used as an hysterisis value. So it could be
  temp_min and temp_hyst, or temp_hyst and temp_max.

I have made the modifications to call the two temperatures temp1_min and
temp1_max. Maybe that should also be changed in the driver for 2.4 
kernels and in libsensors.


> Also, we just changed the sysfs naming conversions. Please see
> Documentation/i2c/sysfs-interface in 2.6.4-mm1 or after applying this
> page on top of 2.6.4:
> http://delvare.nerim.net/i2c/linux-2.6/linux-2.6.4-i2c.patch.gz
> 
> Baically, the idea is that temp_max1 becomes temp1_max, etc...
Done.

> > 	/* Make sure we aren't probing the ISA bus!! This is just a safety check
> > 	   at this moment; i2c_detect really won't call us. */
> > 	if (i2c_is_isa_adapter(adapter)) {
> > 		dev_dbg(&adapter->dev, 
> > 		        "ds1621.o: ds1621_detect called for an ISA bus adapter?!?\n");
> > 		return 0;
> > 	}
> 
> This block isn't needed. The functionality check below it does the same
> as a side effect.
Done.

> 
> >         memset(new_client, 0, sizeof(struct i2c_client) +
> > 	       sizeof(struct ds1621_data));
> Bad indentation.
Fixed.

> > 	/* Now, we do the remaining detection. It is lousy. */
> > 	if (kind < 0) {
> > 		conf = i2c_smbus_read_byte_data(new_client,
> > 						DS1621_REG_CONF);
> 
> Don't you use ds1621_read_value here? (This is a true question, I don't
> know if this was not done on purpose in the first place.)
Fixed.

> > 		if ((conf & DS1621_REG_CONFIG_MASK)
> > 		    != DS1621_REG_CONFIG_VAL)
> > 			goto ERROR2;
> > 	}
> 
> The detection could be improved by reading temperatures (the three of
> them) and check that the 7 lower bits are clear. This is how things are
> done in sensors-detect.
Done.

> > 	if (kind = ds1621) {
> > 		client_name = "ds1621";
> > 	} else {
> > 		dev_dbg(&adapter->dev,
> > 		        "ds1621.o: Internal error: unknown kind (%d)?!?",
> > 		        kind);
> > 		goto ERROR2;
> > 	}
> 
> The "else" block is useless. Several drivers used to do that, but I've
> just submitted a patch that fixes this.
Fixed.

> > 	/* Fill in remaining client fields and put it into the global list */
> > 	strlcpy(new_client->name, client_name, I2C_NAME_SIZE);
>
> You could even hardcode "ds1621" here and save some bytes. It's unlikely
> that such on old driver will be extended to support an additional chip.
Done.

> > /* OK, this is not exactly good programming practice, usually. But it is
> >    very code-efficient in this case. */
> >       ERROR2:
> > 	kfree(new_client);
> >       ERROR1:
> >       ERROR0:
> > 	return err;
> 
> Merge ERROR0 and ERROR1, and rename labels to exit_free and exit.
Done.

> A few more things:
> 
> 1* Don't hesitate to credit yourself for porting the driver.
Done.

> 2* Please provide a patch against 2.6.4-mm1 (or 2.6.4 + the patch
> mentioned above). There were changes made to Makefile and Kconfig, your
> previous patch wouldn't have applied cleanly.
Please find it attached.

> 3* Do you know if there are differences between the DS1621 and the
> DS1625? The driver is supposed to support both.
Basically the DS1621 is an evolution of the DS1625. It is pin compatible
and has the following improvements:
 * more accuracy
 * possibility to read internal registers to compute a high resolution
   temperature
 * wider supply voltage (2.7 to 5.5V)
 

-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineering Student 
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
-------------- next part --------------
diff -urN linux-2.6.4.orig/drivers/i2c/chips/ds1621.c linux-2.6.4/drivers/i2c/chips/ds1621.c
--- linux-2.6.4.orig/drivers/i2c/chips/ds1621.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.4/drivers/i2c/chips/ds1621.c	2004-03-14 12:40:42.000000000 +0100
@@ -0,0 +1,344 @@
+/*
+    ds1621.c - Part of lm_sensors, Linux kernel modules for hardware
+             monitoring
+    Christian W. Zuckschwerdt  <zany@triq.net>  2000-11-23
+    based on lm75.c by Frodo Looijaard <frodol@dds.nl>
+    Ported to Linux 2.6 by Aurelien Jarno <aurelien@aurel32.net> with 
+    the help of Jean Delvare <khali@linux-fr.org>
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
+#include <linux/i2c-sensor.h>
+#include "lm75.h"
+
+/* Addresses to scan */
+static unsigned short normal_i2c[] = { I2C_CLIENT_END };
+static unsigned short normal_i2c_range[] = { 0x48, 0x4f, I2C_CLIENT_END };
+static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
+static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
+
+/* Insmod parameters */
+SENSORS_INSMOD_1(ds1621);
+static int polarity = 1;
+MODULE_PARM(polarity, "i");
+MODULE_PARM_DESC(polarity, "Output's polarity: 0 = active high, 1 = active low (default)");
+
+/* Many DS1621 constants specified below */
+/* Config register used for detection         */
+/*  7    6    5    4    3    2    1    0      */
+/* |Done|THF |TLF |NVB | 1  | 0  |POL |1SHOT| */
+#define DS1621_REG_CONFIG_MASK		0x0C
+#define DS1621_REG_CONFIG_VAL		0x08
+#define DS1621_REG_CONFIG_POLARITY	0x02
+#define DS1621_REG_CONFIG_1SHOT		0x01
+#define DS1621_REG_CONFIG_DONE		0x80
+
+/* The DS1621 registers */
+#define DS1621_REG_TEMP			0xAA /* word, RO */
+#define DS1621_REG_TEMP_MIN		0xA1 /* word, RW */
+#define DS1621_REG_TEMP_MAX		0xA2 /* word, RW */
+#define DS1621_REG_CONF			0xAC /* byte, RW */
+#define DS1621_COM_START		0xEE /* no data */
+
+/* The DS1621 configuration register */
+#define DS1621_ALARM_TEMP_HIGH		0x40
+#define DS1621_ALARM_TEMP_LOW		0x20
+
+/* Conversions. Rounding and limit checking is only done on the TO_REG
+   variants. Note that you should be a bit careful with which arguments
+   these macros are called: arguments may be evaluated more than once.
+   Fixing this is just not worth it. */
+#define ALARMS_FROM_REG(val) ((val) & \
+                              (DS1621_ALARM_TEMP_HIGH | DS1621_ALARM_TEMP_LOW))
+
+/* Each client has this additional data */
+struct ds1621_data {
+	struct semaphore update_lock;
+	char valid;			/* !=0 if following fields are valid */
+	unsigned long last_updated;	/* In jiffies */
+
+	u16 temp, temp_min, temp_max;	/* Register values, word */
+	u8 conf;			/* Register encoding, combined */
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
+	if (reg = DS1621_REG_CONF)
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
+	if (reg = DS1621_REG_CONF)
+		return i2c_smbus_write_byte_data(client, reg, value);
+	else
+		return i2c_smbus_write_word_data(client, reg,
+						 swap_bytes(value));
+}
+
+static void ds1621_init_client(struct i2c_client *client)
+{
+	int reg = ds1621_read_value(client, DS1621_REG_CONF);
+	/* switch to continous conversion mode */
+	reg &= ~ DS1621_REG_CONFIG_1SHOT;
+
+	/* setup output polarity */
+	if (polarity)
+		reg |= DS1621_REG_CONFIG_POLARITY;
+	else
+		reg &= ~DS1621_REG_CONFIG_POLARITY;
+	
+	ds1621_write_value(client, DS1621_REG_CONF, reg);
+	
+	/* start conversion */
+	i2c_smbus_write_byte(client, DS1621_COM_START);
+}
+
+#define show(value)     \
+static ssize_t show_##value(struct device *dev, char *buf)		\
+{									\
+        struct i2c_client *client = to_i2c_client(dev);			\
+	struct ds1621_data *data = i2c_get_clientdata(client);		\
+	ds1621_update_client(client);					\
+	return sprintf(buf, "%d\n", LM75_TEMP_FROM_REG(data->value));	\
+}
+
+show(temp);
+show(temp_min);
+show(temp_max);
+
+#define set_temp(suffix, value, reg) \
+static ssize_t set_temp_##suffix(struct device *dev, const char *buf,	\
+		        size_t count)					\
+{									\
+	struct i2c_client *client = to_i2c_client(dev);			\
+	struct ds1621_data *data = i2c_get_clientdata(client);		\
+	data->value = LM75_TEMP_TO_REG(simple_strtoul(buf, NULL, 10));	\
+	ds1621_write_value(client, reg, data->value);			\
+	return count;							\
+}
+
+set_temp(min, temp_min, DS1621_REG_TEMP_MIN);
+set_temp(max, temp_max, DS1621_REG_TEMP_MAX);
+
+static ssize_t show_alarms(struct device *dev, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+        struct ds1621_data *data = i2c_get_clientdata(client);
+	ds1621_update_client(client);
+	return sprintf(buf, "%d\n", ALARMS_FROM_REG(data->conf) != 0);
+}
+
+static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
+static DEVICE_ATTR(temp1_input, S_IRUGO , show_temp, NULL);
+static DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO , show_temp_min, set_temp_min);
+static DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max, set_temp_max);
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
+	int conf, temp;
+	struct i2c_client *new_client;
+	struct ds1621_data *data;
+	int err = 0;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
+				     I2C_FUNC_SMBUS_WORD_DATA))
+		    goto exit;
+
+	/* OK. For now, we presume we have a valid client. We now create the
+	   client structure, even though we cannot fill it completely yet.
+	   But it allows us to access ds1621_{read,write}_value. */
+	if (!(new_client = kmalloc(sizeof(struct i2c_client) +
+				   sizeof(struct ds1621_data),
+				   GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto exit;
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
+		conf = ds1621_read_value(new_client, DS1621_REG_CONF);
+		if ((conf & DS1621_REG_CONFIG_MASK) != DS1621_REG_CONFIG_VAL)
+			goto exit_free;
+		temp = ds1621_read_value(new_client, DS1621_REG_TEMP);
+		if (temp & 0x007f)
+			goto exit_free;
+		temp = ds1621_read_value(new_client, DS1621_REG_TEMP_MIN);
+		if (temp & 0x007f)
+			goto exit_free;
+		temp = ds1621_read_value(new_client, DS1621_REG_TEMP_MAX);
+		if (temp & 0x007f)
+			goto exit_free;
+	}
+
+	/* Determine the chip type - only one kind supported! */
+	if (kind <= 0)
+		kind = ds1621;
+
+	/* Fill in remaining client fields and put it into the global list */
+	strlcpy(new_client->name, "ds1621", I2C_NAME_SIZE);
+
+	new_client->id = ds1621_id++;
+	data->valid = 0;
+	init_MUTEX(&data->update_lock);
+
+	/* Tell the I2C layer a new client has arrived */
+	if ((err = i2c_attach_client(new_client)))
+		goto exit_free;
+
+	/* Initialize the DS1621 chip */
+	ds1621_init_client(new_client);
+
+	/* Register sysfs hooks */
+        device_create_file(&new_client->dev, &dev_attr_alarms);
+        device_create_file(&new_client->dev, &dev_attr_temp1_input);
+        device_create_file(&new_client->dev, &dev_attr_temp1_min);
+        device_create_file(&new_client->dev, &dev_attr_temp1_max);
+	
+	return 0;
+
+/* OK, this is not exactly good programming practice, usually. But it is
+   very code-efficient in this case. */
+      exit_free:
+	kfree(new_client);
+      exit:
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
+		data->temp_min = ds1621_read_value(client,
+		                                    DS1621_REG_TEMP_MIN);
+		data->temp_max = ds1621_read_value(client,
+						    DS1621_REG_TEMP_MAX);
+
+		/* reset alarms if neccessary */
+		new_conf = data->conf;
+		if (data->temp < data->temp_min)
+			new_conf &= ~DS1621_ALARM_TEMP_LOW;
+		if (data->temp > data->temp_max)
+			new_conf &= ~DS1621_ALARM_TEMP_HIGH;
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
diff -urN linux-2.6.4.orig/drivers/i2c/chips/Kconfig linux-2.6.4/drivers/i2c/chips/Kconfig
--- linux-2.6.4.orig/drivers/i2c/chips/Kconfig	2004-03-14 12:01:40.000000000 +0100
+++ linux-2.6.4/drivers/i2c/chips/Kconfig	2004-03-14 12:40:31.000000000 +0100
@@ -186,6 +186,17 @@
 menu "Other I2C Chip support"
 	depends on I2C
 
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
 	tristate "EEPROM reader"
 	depends on I2C && EXPERIMENTAL
diff -urN linux-2.6.4.orig/drivers/i2c/chips/Makefile linux-2.6.4/drivers/i2c/chips/Makefile
--- linux-2.6.4.orig/drivers/i2c/chips/Makefile	2004-03-14 12:01:40.000000000 +0100
+++ linux-2.6.4/drivers/i2c/chips/Makefile	2004-03-14 12:40:31.000000000 +0100
@@ -8,6 +8,7 @@
 obj-$(CONFIG_SENSORS_W83781D)	+= w83781d.o
 
 obj-$(CONFIG_SENSORS_ADM1021)	+= adm1021.o
+obj-$(CONFIG_SENSORS_DS1621)	+= ds1621.o
 obj-$(CONFIG_SENSORS_EEPROM)	+= eeprom.o
 obj-$(CONFIG_SENSORS_FSCHER)	+= fscher.o
 obj-$(CONFIG_SENSORS_GL518SM)	+= gl518sm.o
