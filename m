From: waltergoossens@home.nl (Walter Goossens)
Date: Mon, 27 Nov 2006 23:04:29 +0000
Subject: [lm-sensors] RFC patch to add eeprom write support
Message-Id: <456B6EFD.6090302@home.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <16475947.1164204132228.JavaMail.root@webmail2.tilbu1>
In-Reply-To: <16475947.1164204132228.JavaMail.root@webmail2.tilbu1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fixed documentation thanks to David Hubbard

======

Added support for the MAX7311 i2c io port expanders. This driver is
based on the pcf8574 driver which supports the same kind of chip.

Signed off by Walter Goossens <waltergoossens at home.nl>

diff -uarN -x '*.o' -x '*.ko' linux-2.6.17/drivers/i2c/chips/Kconfig 
linux-2.6.17-mpe04/drivers/i2c/chips/Kconfig
--- linux-2.6.17/drivers/i2c/chips/Kconfig    2006-06-18 
01:49:35.000000000 +0000
+++ linux-2.6.17-mpe04/drivers/i2c/chips/Kconfig    2006-10-18 
11:00:05.000000000 +0000
@@ -117,4 +117,23 @@
       This driver can also be built as a module.  If so, the module
       will be called max6875.
 
+config SENSORS_MAX7311
+    tristate "Maxim MAX7311 16 port io expander"
+    depends on I2C
+    help
+      If you say yes here you will get support for the max7311 port
+      expander chip. This chip has 16 ioports each configurable for
+      input or output.
+     
+      This driver can also be built as a module. If so, the module
+      will be called max7311.
+config SENSORS_MAX7311_NUMCLIENTS
+    int "Maximum number of chips"
+    default "4"
+    depends on SENSORS_MAX7311
+config SENSORS_MAX7311_ADDRESSES
+    string "Addresses to scan"
+    default "0x20 0x24"
+    depends on SENSORS_MAX7311
+
 endmenu
diff -uarN -x '*.o' -x '*.ko' linux-2.6.17/drivers/i2c/chips/Makefile 
linux-2.6.17-mpe04/drivers/i2c/chips/Makefile
--- linux-2.6.17/drivers/i2c/chips/Makefile    2006-06-18 
01:49:35.000000000 +0000
+++ linux-2.6.17-mpe04/drivers/i2c/chips/Makefile    2006-10-18 
10:00:29.000000000 +0000
@@ -6,6 +6,7 @@
 obj-$(CONFIG_SENSORS_DS1374)    += ds1374.o
 obj-$(CONFIG_SENSORS_EEPROM)    += eeprom.o
 obj-$(CONFIG_SENSORS_MAX6875)    += max6875.o
+obj-$(CONFIG_SENSORS_MAX7311)    += max7311.o
 obj-$(CONFIG_SENSORS_M41T00)    += m41t00.o
 obj-$(CONFIG_SENSORS_PCA9539)    += pca9539.o
 obj-$(CONFIG_SENSORS_PCF8574)    += pcf8574.o
diff -uarN -x '*.o' -x '*.ko' linux-2.6.17/drivers/i2c/chips/max7311.c 
linux-2.6.17-mpe04/drivers/i2c/chips/max7311.c
--- linux-2.6.17/drivers/i2c/chips/max7311.c    1970-01-01 
00:00:00.000000000 +0000
+++ linux-2.6.17-mpe04/drivers/i2c/chips/max7311.c    2006-10-18 
11:27:59.000000000 +0000
@@ -0,0 +1,352 @@
+/*
+    max7311.c
+    Copyright (c) 2006  Walter Goossens <walter.goossens at axon.tv>
+   
+    Based on:
+   
+    pcf8574.c - Part of lm_sensors, Linux kernel modules for hardware
+             monitoring
+    Copyright (c) 2000  Frodo Looijaard <frodol at dds.nl>,
+                        Philip Edelbrock <phil at netroedge.com>,
+                        Dan Eaton <dan.eaton at rocketlogix.com>
+    Ported to Linux 2.6 by Aurelien Jarno <aurel32 at debian.org> with
+    the help of Jean Delvare <khali at linux-fr.org>
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
+#include <linux/list.h>
+
+/* Addresses to scan */
+static unsigned short normal_i2c[CONFIG_SENSORS_MAX7311_NUMCLIENTS];
+
+/* Insmod parameters */
+I2C_CLIENT_INSMOD;
+
+/* Initial values */
+#define MAX7311_INIT 0xFFFF  /* All ports in input */
+/* Chip registers */
+#define REG_INPUT       0x00
+#define REG_OUTPUT      0x02
+#define REG_POLARITY    0x04
+#define REG_CONFIG      0x06
+#define REG_TIMEOUT     0x08
+
+/* Keep a list of all registered clients */
+static LIST_HEAD(max7311_clients);
+
+/* Each client has this additional data */
+struct max7311_data {
+  struct i2c_client client;
+
+  uint16_t output;
+  uint16_t config;
+  uint16_t polarity;
+  struct list_head list;
+};
+
+
+static int max7311_attach_adapter(struct i2c_adapter *adapter);
+static int max7311_detect(struct i2c_adapter *adapter, int address, int 
kind);
+static int max7311_detach_client(struct i2c_client *client);
+static void max7311_init_client(struct i2c_client *client);
+
+/* This is the driver that will be inserted */
+static struct i2c_driver max7311_driver = {
+  .driver = {
+    .name = "max7311",
+  },
+  .id   = I2C_DRIVERID_MAX7311,
+  .attach_adapter = max7311_attach_adapter,
+  .detach_client  = max7311_detach_client,
+};
+
+/* following are the sysfs callback functions */
+static ssize_t show_read(struct device *dev, struct device_attribute 
*attr, char *buf)
+{
+  struct i2c_client *client = to_i2c_client(dev);
+  return sprintf(buf, "%u\n", i2c_smbus_read_word_data(client,REG_INPUT));
+}
+
+static DEVICE_ATTR(read, S_IRUGO, show_read, NULL);
+
+static ssize_t show_write(struct device *dev, struct device_attribute 
*attr, char *buf)
+{
+  struct max7311_data *data = i2c_get_clientdata(to_i2c_client(dev));
+  return sprintf(buf, "%u\n", data->output);
+}
+
+static ssize_t set_write(struct device *dev, struct device_attribute 
*attr, const char *buf, size_t count)
+{
+  struct i2c_client *client = to_i2c_client(dev);
+  struct max7311_data *data = i2c_get_clientdata(client);
+  unsigned long val = simple_strtoul(buf, NULL, 10);
+
+  if (val > 0xFFFF)
+  {
+    return -EINVAL;
+  }
+  data->output = val;
+  i2c_smbus_write_word_data(client, REG_OUTPUT,data->output);
+  return count;
+}
+
+static DEVICE_ATTR(write, S_IWUSR | S_IRUGO, show_write, set_write);
+
+static ssize_t show_config(struct device *dev, struct device_attribute 
*attr, char *buf)
+{
+  struct max7311_data *data = i2c_get_clientdata(to_i2c_client(dev));
+  return sprintf(buf, "%u\n", data->config);
+}
+
+static ssize_t set_config(struct device *dev, struct device_attribute 
*attr, const char *buf, size_t count)
+{
+  struct i2c_client *client = to_i2c_client(dev);
+  struct max7311_data *data = i2c_get_clientdata(client);
+  unsigned long val = simple_strtoul(buf, NULL, 10);
+
+  if (val > 0xFFFF)
+  {
+    return -EINVAL;
+  }
+  data->config = val;
+  i2c_smbus_write_word_data(client, REG_CONFIG,data->config);
+  return count;
+}
+
+static DEVICE_ATTR(config, S_IWUSR | S_IRUGO, show_config, set_config);
+
+static ssize_t show_polarity(struct device *dev, struct 
device_attribute *attr, char *buf)
+{
+  struct max7311_data *data = i2c_get_clientdata(to_i2c_client(dev));
+  return sprintf(buf, "%u\n", data->polarity);
+}
+
+static ssize_t set_polarity(struct device *dev, struct device_attribute 
*attr, const char *buf, size_t count)
+{
+  struct i2c_client *client = to_i2c_client(dev);
+  struct max7311_data *data = i2c_get_clientdata(client);
+  unsigned long val = simple_strtoul(buf, NULL, 10);
+
+  if (val > 0xFFFF)
+  {
+    return -EINVAL;
+  }
+  data->polarity = val;
+  i2c_smbus_write_word_data(client, REG_CONFIG,data->polarity);
+  return count;
+}
+
+static DEVICE_ATTR(polarity, S_IWUSR | S_IRUGO, show_polarity, 
set_polarity);
+
+/*
+ * Real code
+ */
+
+static int max7311_attach_adapter(struct i2c_adapter *adapter)
+{
+  return i2c_probe(adapter, &addr_data, max7311_detect);
+}
+
+/* This function is called by i2c_probe */
+static int max7311_detect(struct i2c_adapter *adapter, int address, int 
kind)
+{
+  struct i2c_client *new_client;
+  struct max7311_data *data;
+  int err = 0;
+  /* Can out adapter suply everything we need ? */
+  if (!i2c_check_functionality(adapter, 
I2C_FUNC_SMBUS_BYTE|I2C_FUNC_SMBUS_BYTE_DATA))
+  {
+    return -1;
+  }
+
+  /* OK. For now, we presume we have a valid client. We now create the
+  client structure, even though we cannot fill it completely yet. */
+  if (!(data = kzalloc(sizeof(struct max7311_data), GFP_KERNEL))) {
+    err = -ENOMEM;
+    return err;
+  }
+
+  new_client = &data->client;
+  i2c_set_clientdata(new_client, data);
+  new_client->addr = address;
+  new_client->adapter = adapter;
+  new_client->driver = &max7311_driver;
+  new_client->flags = 0;
+
+  /* Fill in the remaining client fields and put it into the global list */
+  strlcpy(new_client->name, "max7311", I2C_NAME_SIZE);
+
+  /* Tell the I2C layer a new client has arrived */
+  if ((err = i2c_attach_client(new_client)))
+  {
+    kfree(data);
+    return err;
+  }
+  /* Initialize the PCF8574 chip */
+  max7311_init_client(new_client);
+
+  /* Register sysfs hooks */
+  device_create_file(&new_client->dev, &dev_attr_read);
+  device_create_file(&new_client->dev, &dev_attr_write);
+  device_create_file(&new_client->dev, &dev_attr_config);
+  device_create_file(&new_client->dev, &dev_attr_polarity);
+  return 0;
+}
+
+static int max7311_detach_client(struct i2c_client *client)
+{
+  int err;
+  struct max7311_data *data = i2c_get_clientdata(client);
+ 
+  if ((err = i2c_detach_client(client)))
+  {
+    return err;
+  }
+  list_del(&data->list);
+  kfree(data);
+  return 0;
+}
+
+/* Called when we have found a new MAX7311. */
+static void max7311_init_client(struct i2c_client *client)
+{
+  struct max7311_data *data = i2c_get_clientdata(client);
+  //Default all ports to inputs!
+  data->config = i2c_smbus_read_word_data(client,REG_CONFIG);
+  data->output = i2c_smbus_read_word_data(client,REG_OUTPUT);
+  data->polarity = i2c_smbus_read_word_data(client,REG_POLARITY);
+  //Enable bus timeout
+  i2c_smbus_write_byte_data(client,REG_TIMEOUT,0x01);
+  //Register with our list
+  INIT_LIST_HEAD(&data->list);
+  list_add_tail(&data->list, &max7311_clients);
+}
+
+struct max7311_data * get_max7311_client(int bus, int address)
+{
+  struct list_head *walk;
+  struct list_head *tmp;
+  struct max7311_data *data;
+
+  list_for_each_safe(walk, tmp, &max7311_clients) {
+    data = list_entry(walk, struct max7311_data, list);
+    if ((data->client.adapter->nr = bus)&&(data->client.addr=address))
+      return data;
+  }
+  return NULL;
+}
+
+static int do_max7311_write(int bus, int address, int chipReg, int newData)
+{
+  struct max7311_data *data;
+  if((data=get_max7311_client(bus,address)))
+  {
+    switch(chipReg) {
+      case REG_OUTPUT:
+      {
+        data->output = newData;
+        return i2c_smbus_write_word_data(&data->client,REG_OUTPUT,newData);
+      } break;
+      case REG_POLARITY:
+      {
+        data->polarity = newData;
+        return 
i2c_smbus_write_word_data(&data->client,REG_POLARITY,newData);
+      } break;
+      case REG_CONFIG:
+      {
+        data->config = newData;
+        return i2c_smbus_write_word_data(&data->client,REG_CONFIG,newData);
+      }
+      default:
+      {
+        return -1;
+      }
+    }
+  } else {
+    return -ENODEV;
+  }
+}
+static int do_max7311_read(int bus, int address, int chipReg)
+{
+  struct max7311_data *data;
+  if((data=get_max7311_client(bus,address)))
+  {
+    switch(chipReg) {
+      case REG_INPUT:
+      {
+        return i2c_smbus_read_word_data(&data->client,REG_INPUT);
+      } break;
+      case REG_OUTPUT:
+      {
+        return data->output;
+      } break;
+      case REG_POLARITY:
+      {
+        return data->polarity;
+      } break;
+      case REG_CONFIG:
+      {
+        return data->config;
+      }
+      default:
+      {
+        return -1;
+      }
+    }
+  } else {
+    return -ENODEV;
+  }
+}
+
+static int __init max7311_init(void)
+{
+  int i;
+  unsigned short addr;
+  char *all_addr = CONFIG_SENSORS_MAX7311_ADDRESSES;
+  for(i=0; i<CONFIG_SENSORS_MAX7311_NUMCLIENTS; i++) {
+    addr = simple_strtoul(all_addr,&all_addr,16);
+    if(all_addr[0]!='\0') {
+      all_addr++;
+    }
+    if(addr)
+    {
+      normal_i2c[i] = addr;
+    } else {
+      normal_i2c[i] = I2C_CLIENT_END;
+    }
+  }
+  return i2c_add_driver(&max7311_driver);
+}
+
+static void __exit max7311_exit(void)
+{
+  i2c_del_driver(&max7311_driver);
+}
+
+
+MODULE_AUTHOR("Walter Goossens <walter.goossens at axon.tv>");
+MODULE_DESCRIPTION("MAX7311 driver");
+MODULE_LICENSE("GPL");
+
+EXPORT_SYMBOL(do_max7311_read);
+EXPORT_SYMBOL(do_max7311_write);
+
+module_init(max7311_init);
+module_exit(max7311_exit);


