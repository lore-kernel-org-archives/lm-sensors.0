From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:13 +0000
Subject: sensors-detect and 2.6.0-test3
Message-Id: <20030823161555.GC27070@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.GSO.4.21.0308172027560.12924-100000@vervain.sonytel.be>
In-Reply-To: <Pine.GSO.4.21.0308172027560.12924-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Aug 21, 2003 at 06:02:53PM +0200, Geert Uytterhoeven wrote:
> On Thu, 21 Aug 2003, Greg KH wrote:
> > On Thu, Aug 21, 2003 at 11:34:32AM +0200, Geert Uytterhoeven wrote:
> > > On Tue, 19 Aug 2003, Greg KH wrote:
> > > > On Sun, Aug 17, 2003 at 08:32:44PM +0200, Geert Uytterhoeven wrote:
> > > > > I'm porting i2c-hydra (which I wrote many years ago) to 2.6.0-test3 and am
> > > > > trying to test it. I want to probe for all i2c devices on my i2c bus, but
> > > > > sensors-detect doesn't work because /proc/bus/i2c is not there.
> > > > 
> > > > sensors-detect does not work on 2.6, sorry.  You have to poke around in
> > > > the sysfs tree by hand right now after loading the drivers by hand :)
> > > > 
> > > > > How do I probe for all i2c devices in 2.6.0-test3? Thanks!
> > > > 
> > > > I just load all of the drivers and see what happens :)
> > > 
> > > Hmm... And all I have on the i2c bus is the SPD EEPROMs on my SDRAM DIMMs.
> > > AFAIK there's no kernel `driver' for these?
> > 
> > There's one in my bk tree, but it's not "correct" and I haven't taken
> > the time to fix it up in order to get it into shape for submission to
> > the main kernel.
> > 
> > If you want, I can send a patch so you can test with.
> 
> Please do so, thanks!

Oops, forgot to send this out, sorry for the delay.

Here's a patch against 2.6.0-test3.  It should work just fine against
2.6.0-test4 too.  Let me know if you have any problems.

thanks,

greg k-h


diff -Nru a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
--- a/drivers/i2c/chips/Kconfig	Fri Aug 22 13:30:06 2003
+++ b/drivers/i2c/chips/Kconfig	Fri Aug 22 13:30:06 2003
@@ -22,6 +22,20 @@
 	  in the lm_sensors package, which you can download at 
 	  http://www.lm-sensors.nu
 
+config SENSORS_EEPROM
+	tristate "  EEPROM (DIMM) reader"
+	depends on I2C
+	help
+	  If you say yes here you get read-only access to the EEPROM data
+	  available on modern memory DIMMs, and which could theoretically
+	  also be available on other devices. This can also be built as a
+	  module which can be inserted and removed while the kernel is
+	  running.
+
+	  You will also need the latest user-space utilties: you can find them
+	  in the lm_sensors package, which you can download at
+	  http://www.lm-sensors.nu
+
 config SENSORS_IT87
 	tristate "  National Semiconductors IT87 and compatibles"
 	depends on I2C && EXPERIMENTAL
diff -Nru a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
--- a/drivers/i2c/chips/Makefile	Fri Aug 22 13:30:57 2003
+++ b/drivers/i2c/chips/Makefile	Fri Aug 22 13:30:57 2003
@@ -11,3 +11,8 @@
 obj-$(CONFIG_SENSORS_LM78)	+= lm78.o
 obj-$(CONFIG_SENSORS_LM85)	+= lm85.o
 obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
+
+
+
+obj-$(CONFIG_SENSORS_EEPROM)	+= eeprom.o
+obj-$(CONFIG_SENSORS_SMBUS_ARP)	+= smbus-arp.o
diff -Nru a/drivers/i2c/chips/eeprom.c b/drivers/i2c/chips/eeprom.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/i2c/chips/eeprom.c	Fri Aug 22 13:30:58 2003
@@ -0,0 +1,310 @@
+/*
+    eeprom.c - Part of lm_sensors, Linux kernel modules for hardware
+               monitoring
+    Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl> and
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
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/i2c-sensor.h>
+#include <linux/init.h>
+
+/* Addresses to scan */
+static unsigned short normal_i2c[] = { I2C_CLIENT_END };
+static unsigned short normal_i2c_range[] = { 0x50, 0x57, I2C_CLIENT_END };
+static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
+static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
+
+/* Insmod parameters */
+SENSORS_INSMOD_1(eeprom);
+
+static int checksum = 0;
+MODULE_PARM(checksum, "i");
+MODULE_PARM_DESC(checksum, "Only accept eeproms whose checksum is correct");
+
+
+/* EEPROM registers */
+#define EEPROM_REG_CHECKSUM	0x3f
+
+/* EEPROM memory types: */
+#define ONE_K			1
+#define TWO_K			2
+#define FOUR_K			3
+#define EIGHT_K			4
+#define SIXTEEN_K		5
+
+/* Size of EEPROM in bytes */
+#define EEPROM_SIZE		256
+
+/* Each client has this additional data */
+struct eeprom_data {
+//	int sysctl_id;
+	struct semaphore update_lock;
+	char valid;			/* !=0 if following fields are valid */
+	unsigned long last_updated;	/* In jiffies */
+	u8 data[EEPROM_SIZE];		/* Register values */
+};
+
+
+static int eeprom_attach_adapter(struct i2c_adapter *adapter);
+static int eeprom_detect(struct i2c_adapter *adapter, int address, int kind);
+static int eeprom_detach_client(struct i2c_client *client);
+
+static void eeprom_update_client(struct i2c_client *client);
+
+
+/* This is the driver that will be inserted */
+static struct i2c_driver eeprom_driver = {
+	.owner		= THIS_MODULE,
+	.name		= "eeprom",
+	.id		= I2C_DRIVERID_EEPROM,
+	.flags		= I2C_DF_NOTIFY,
+	.attach_adapter	= eeprom_attach_adapter,
+	.detach_client	= eeprom_detach_client,
+};
+
+static int eeprom_id = 0;
+
+static ssize_t show_eeprom(struct device *dev, char *buf, int base)
+{
+	struct i2c_client *client;
+	struct eeprom_data *data;
+	char *buffer;
+	int i;
+
+	client = to_i2c_client(dev);
+	data = i2c_get_clientdata(client);
+	buffer = buf;
+
+	eeprom_update_client(client);
+	for (i = 0; i < 15; ++i)
+		buf += sprintf(buf, "%d ", data->data[i + base]);
+	buf += sprintf(buf, "%d\n", data->data[15 + base]);
+	return (buf - buffer);
+}
+#define show_eeprom_offset(offset)			\
+static ssize_t						\
+show_eeprom_##offset (struct device *dev, char *buf)	\
+{							\
+	return show_eeprom(dev, buf, 0x##offset);	\
+}							\
+static DEVICE_ATTR(eeprom_##offset, S_IRUGO, show_eeprom_##offset, NULL)
+show_eeprom_offset(00);
+show_eeprom_offset(10);
+show_eeprom_offset(20);
+show_eeprom_offset(30);
+show_eeprom_offset(40);
+show_eeprom_offset(50);
+show_eeprom_offset(60);
+show_eeprom_offset(70);
+show_eeprom_offset(80);
+show_eeprom_offset(90);
+show_eeprom_offset(a0);
+show_eeprom_offset(b0);
+show_eeprom_offset(c0);
+show_eeprom_offset(d0);
+show_eeprom_offset(e0);
+show_eeprom_offset(f0);
+
+static int eeprom_attach_adapter(struct i2c_adapter *adapter)
+{
+	return i2c_detect(adapter, &addr_data, eeprom_detect);
+}
+
+/* This function is called by i2c_detect */
+int eeprom_detect(struct i2c_adapter *adapter, int address, int kind)
+{
+	int i, cs;
+	struct i2c_client *new_client;
+	struct eeprom_data *data;
+	int err = 0;
+	const char *type_name, *client_name;
+
+	/* Make sure we aren't probing the ISA bus!! This is just a safety check
+	   at this moment; i2c_detect really won't call us. */
+#ifdef DEBUG
+	if (i2c_is_isa_adapter(adapter)) {
+		dev_dbg(&adapter->dev, " eeprom_detect called for an ISA bus adapter?!?\n");
+		return 0;
+	}
+#endif
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		goto ERROR0;
+
+	/* OK. For now, we presume we have a valid client. We now create the
+	   client structure, even though we cannot fill it completely yet.
+	   But it allows us to access eeprom_{read,write}_value. */
+	if (!(new_client = kmalloc(sizeof(struct i2c_client) +
+				   sizeof(struct eeprom_data),
+				   GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto ERROR0;
+	}
+	memset(new_client, 0x00, sizeof(struct i2c_client) +
+				 sizeof(struct eeprom_data));
+
+	data = (struct eeprom_data *) (new_client + 1);
+	memset(data, 0xff, EEPROM_SIZE);
+	i2c_set_clientdata(new_client, data);
+	new_client->addr = address;
+	new_client->adapter = adapter;
+	new_client->driver = &eeprom_driver;
+	new_client->flags = 0;
+
+	/* Now, we do the remaining detection. It is not there, unless you force
+	   the checksum to work out. */
+	if (checksum) {
+		/* prevent 24RF08 corruption */
+		i2c_smbus_write_quick(new_client, 0);
+		cs = 0;
+		for (i = 0; i <= 0x3e; i++)
+			cs += i2c_smbus_read_byte_data(new_client, i);
+		cs &= 0xff;
+		if (i2c_smbus_read_byte_data (new_client, EEPROM_REG_CHECKSUM) != cs)
+			goto ERROR1;
+	}
+
+	/* Determine the chip type - only one kind supported! */
+	if (kind <= 0)
+		kind = eeprom;
+
+	if (kind = eeprom) {
+		type_name = "eeprom";
+		client_name = "EEPROM chip";
+	} else {
+		dev_dbg(&adap->dev, "Internal error: unknown kind (%d)?!?", kind);
+		goto ERROR1;
+	}
+
+	/* Fill in the remaining client fields and put it into the global list */
+	strncpy(new_client->name, client_name, DEVICE_NAME_SIZE);
+
+	new_client->id = eeprom_id++;
+	data->valid = 0;
+	init_MUTEX(&data->update_lock);
+
+	/* Tell the I2C layer a new client has arrived */
+	if ((err = i2c_attach_client(new_client)))
+		goto ERROR3;
+
+	device_create_file(&new_client->dev, &dev_attr_eeprom_00);
+	device_create_file(&new_client->dev, &dev_attr_eeprom_10);
+	device_create_file(&new_client->dev, &dev_attr_eeprom_20);
+	device_create_file(&new_client->dev, &dev_attr_eeprom_30);
+	device_create_file(&new_client->dev, &dev_attr_eeprom_40);
+	device_create_file(&new_client->dev, &dev_attr_eeprom_50);
+	device_create_file(&new_client->dev, &dev_attr_eeprom_60);
+	device_create_file(&new_client->dev, &dev_attr_eeprom_70);
+	device_create_file(&new_client->dev, &dev_attr_eeprom_80);
+	device_create_file(&new_client->dev, &dev_attr_eeprom_90);
+	device_create_file(&new_client->dev, &dev_attr_eeprom_a0);
+	device_create_file(&new_client->dev, &dev_attr_eeprom_b0);
+	device_create_file(&new_client->dev, &dev_attr_eeprom_c0);
+	device_create_file(&new_client->dev, &dev_attr_eeprom_d0);
+	device_create_file(&new_client->dev, &dev_attr_eeprom_e0);
+	device_create_file(&new_client->dev, &dev_attr_eeprom_f0);
+
+//	/* Register a new directory entry with module sensors */
+//	if ((i = i2c_register_entry(new_client, type_name, eeprom_dir_table_template)) < 0) {
+//		err = i;
+//		goto ERROR4;
+//	}
+//	data->sysctl_id = i;
+
+	return 0;
+
+//ERROR4:
+//	i2c_detach_client(new_client);
+ERROR3:
+ERROR1:
+	kfree(new_client);
+ERROR0:
+	return err;
+}
+
+static int eeprom_detach_client(struct i2c_client *client)
+{
+	int err;
+
+//	i2c_deregister_entry(((struct eeprom_data *) (i2c_get_clientdata(client)))->sysctl_id);
+
+	if ((err = i2c_detach_client(client))) {
+		printk
+		    ("eeprom.o: Client deregistration failed, client not detached.\n");
+		return err;
+	}
+
+	kfree(client);
+
+	return 0;
+}
+
+static void eeprom_update_client(struct i2c_client *client)
+{
+	struct eeprom_data *data = i2c_get_clientdata(client);
+	int i, j;
+
+	down(&data->update_lock);
+
+	if ((jiffies - data->last_updated > 300 * HZ) |
+	    (jiffies < data->last_updated) || !data->valid) {
+		dev_dbg(&client->dev, "Starting eeprom update\n");
+
+		if (i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
+			for (i=0; i<EEPROM_SIZE; i+=I2C_SMBUS_I2C_BLOCK_MAX)
+				if (i2c_smbus_read_i2c_block_data(client, i, data->data + i) != I2C_SMBUS_I2C_BLOCK_MAX)
+					goto DONE;
+		} else {
+			if (i2c_smbus_write_byte(client, 0)) {
+				dev_dbg(&client->dev, "eeprom read start has failed!\n");
+				goto DONE;
+			}
+			for (i = 0; i < EEPROM_SIZE; i++) {
+				j = i2c_smbus_read_byte(client);
+				if (j < 0)
+					goto DONE;
+				data->data[i] = (u8) j;
+			}
+		}
+		data->last_updated = jiffies;
+		data->valid = 1;
+	}
+DONE:
+	up(&data->update_lock);
+}
+
+static int __init sm_eeprom_init(void)
+{
+	return i2c_add_driver(&eeprom_driver);
+}
+
+static void __exit sm_eeprom_exit(void)
+{
+	i2c_del_driver(&eeprom_driver);
+}
+
+
+MODULE_AUTHOR ("Frodo Looijaard <frodol@dds.nl> and "
+		"Philip Edelbrock <phil@netroedge.com>");
+MODULE_DESCRIPTION("EEPROM driver");
+MODULE_LICENSE("GPL");
+
+module_init(sm_eeprom_init);
+module_exit(sm_eeprom_exit);
