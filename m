From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: ATXP3 and ATXP5
Message-Id: <4277310B.9060700@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

FYI. They released full datasheet for ATXP5. None for ATXP3 but this is quite for sure cut-off version of
ATXP1.

I have ATXP3 :)

http://www.attansic.com.tw/english/products/pdf/ATXP5_1.0%20.pdf


Regards,
Rudolf

-------------- next part --------------
diff -ruN linux-2.6.10-orig/drivers/i2c/chips/Kconfig linux-2.6.10/drivers/i2c/chips/Kconfig
--- linux-2.6.10-orig/drivers/i2c/chips/Kconfig	2004-12-24 22:34:58.000000000 +0100
+++ linux-2.6.10/drivers/i2c/chips/Kconfig	2005-01-02 16:54:50.545276192 +0100
@@ -347,6 +347,19 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-rtc8564.
 
+config SENSORS_ATXP1
+	tristate "Attansic ATXP1 VID controller"
+	depends on I2C && EXPERIMENTAL
+	help
+	  If you say yes here you get support for the Attansic ATXP1 VID
+	  controller.
+
+	  If your board have such a chip, you are able to control your CPU
+	  core and other voltages.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called atxp1.
+	  
 config ISP1301_OMAP
 	tristate "Philips ISP1301 with OMAP OTG"
 	depends on I2C && ARCH_OMAP_OTG
diff -ruN linux-2.6.10-orig/drivers/i2c/chips/Makefile linux-2.6.10/drivers/i2c/chips/Makefile
--- linux-2.6.10-orig/drivers/i2c/chips/Makefile	2004-12-24 22:35:50.000000000 +0100
+++ linux-2.6.10/drivers/i2c/chips/Makefile	2005-01-02 16:51:30.293719056 +0100
@@ -34,6 +34,7 @@
 obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
 obj-$(CONFIG_SENSORS_W83L785TS)	+= w83l785ts.o
 obj-$(CONFIG_ISP1301_OMAP)	+= isp1301_omap.o
+obj-$(CONFIG_SENSORS_ATXP1)	+= atxp1.o
 
 ifeq ($(CONFIG_I2C_DEBUG_CHIP),y)
 EXTRA_CFLAGS += -DDEBUG
diff -ruN linux-2.6.10-orig/drivers/i2c/chips/atxp1.c linux-2.6.10/drivers/i2c/chips/atxp1.c
--- linux-2.6.10-orig/drivers/i2c/chips/atxp1.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10/drivers/i2c/chips/atxp1.c	2005-01-02 16:50:36.531892096 +0100
@@ -0,0 +1,259 @@
+/*
+    atxp1.c - kernel module for setting Vcore using ATXP1 chip. 
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
+    Version history:
+    0.1: Converted 8rdavcore into kernel module (Marcin Kaluza <marcin_ml@sekretarka.no-ip.org>)
+    0.2: Cleanup, general interface for VCore (Sebastian Witt <hasw@hasw.net>)
+    
+*/
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/i2c.h>
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("VCore changing via Attansic ATXP1");
+MODULE_VERSION("0.2");
+
+#define ATXP1_VID 0x00
+#define ATXP1_CVID 0x01
+#define ATXP1_VIDENA 0x20
+#define ATXP1_VIDMASK 0x1f
+
+static unsigned short normal_i2c[]= { 0x37, 0x4e, I2C_CLIENT_END };
+static unsigned short normal_i2c_range[]= { I2C_CLIENT_END };
+static int atxp1_attach_adapter(struct i2c_adapter * adapter);
+static int atxp1_detach_client(struct i2c_client * client);
+static struct atxp1_data * atxp1_update_device(struct device *dev);
+static int atxp1_detect(struct i2c_adapter *adapter, int address, int kind);
+
+static struct i2c_driver atxp1_driver = {
+	.owner		= THIS_MODULE,
+	.name		= "atxp1",
+	.id		= I2C_DRIVERID_EXP1,
+	.flags		= I2C_DF_NOTIFY,
+	.attach_adapter = atxp1_attach_adapter,
+	.detach_client	= atxp1_detach_client,
+};
+
+I2C_CLIENT_INSMOD;
+
+struct atxp1_data {
+	struct i2c_client client;
+//	struct semaphore update_lock;
+	u8 valid;
+	//unsigned long last_updated;
+	unsigned char cpu_vid;
+	unsigned char vid;
+};
+
+/* Conversion VCore <-> VID */
+static unsigned int atxp1_calc_vcore(unsigned char vid)
+{
+	return 1850 - (vid & ATXP1_VIDMASK) * 25;
+};
+
+static unsigned char atxp1_calc_vid(unsigned int vt) {
+	return(((1850 - vt) / 25 + 0.5));
+}
+
+static struct atxp1_data * atxp1_update_device(struct device *dev) 
+{
+	struct i2c_client *client;
+	struct atxp1_data *data;
+	
+	client = to_i2c_client(dev);
+	data = i2c_get_clientdata(client);
+	
+	if(data->valid = 0) {
+		data->vid = i2c_smbus_read_byte_data(client, ATXP1_VID);
+		data->cpu_vid = i2c_smbus_read_byte_data(client, ATXP1_CVID);
+	}
+    	
+	return(data);
+}
+
+static int atxp1_write(struct i2c_client *client, unsigned char adr, unsigned char data) 
+{
+	int ret = -1;
+
+	ret = i2c_smbus_write_byte_data(client, adr, data);
+	
+	if(ret < 0) {
+		printk(KERN_ERR "atxp1_write(): Write failed\n");
+		return -1;
+	}
+
+	ret = i2c_smbus_read_byte_data(client, adr);
+	if(ret < 0) {
+		printk(KERN_ERR "atxp1_write(): Read from 0x%02x failed\n", adr);
+		return -1;
+	}
+	
+	if(ret = data) return(0);
+	else {
+		printk(KERN_ERR "atxp1_write(): Readback failed, 0x%02x written, 0x%02x readback from 0x%02x\n", data, ret, adr);
+		return -1;
+	}
+
+	return 0;
+}
+
+ssize_t atxp1_showvcore(struct device *dev, char *buf)
+{
+	int size;
+	struct atxp1_data *data;
+	
+	data = atxp1_update_device(dev);
+	
+	size = sprintf(buf, "%d\n", atxp1_calc_vcore(data->vid));
+
+	return size;
+}
+
+ssize_t atxp1_storevcore(struct device *dev, const char* buf, size_t count)
+{
+	struct atxp1_data *data;
+	struct i2c_client *client;
+	unsigned char vid;
+	unsigned char cvid;
+	unsigned int vcore = 1650;
+
+	client = to_i2c_client(dev);
+	data = atxp1_update_device(dev);
+
+	sscanf(buf, "%d", &vcore);
+	vcore /= 25;	
+	vcore *= 25;	
+	
+	if((vcore < 1075) || (vcore > 1850)) {
+		printk(KERN_INFO "Use VCore between 1075 mV and 1850 mV\n");
+		return strlen(buf);
+	}
+	
+        vid = atxp1_calc_vid(vcore);
+
+        if(data->vid & ATXP1_VIDENA)
+		cvid = data->vid & ~ATXP1_VIDENA;
+	else
+		cvid = data->cpu_vid;
+	
+	if(vid = cvid)
+		return strlen(buf);
+	
+	printk(KERN_DEBUG "atxp1: Setting VCore to %d mV (0x%02x)\n", vcore, vid);
+	
+	if(cvid > vid) {
+		for(; cvid >= vid; cvid--) {
+        		atxp1_write(client, ATXP1_VID, cvid | ATXP1_VIDENA);
+		}
+	}
+	else {
+		for(; cvid <= vid; cvid++) {
+        		atxp1_write(client, ATXP1_VID, cvid | ATXP1_VIDENA);
+		}
+	}
+	
+	data->valid = 0;
+	
+	return strlen(buf);
+}
+
+static 	DEVICE_ATTR(vcore, 0644, atxp1_showvcore, atxp1_storevcore);
+
+
+static int atxp1_attach_adapter(struct i2c_adapter *adapter)
+{
+	return i2c_probe(adapter, &addr_data, &atxp1_detect);
+};
+	
+static int atxp1_detect(struct i2c_adapter *adapter, int address, int kind)
+{
+	/* Checking if CVID != 00 (and maybe VID) */
+	struct i2c_client* new_client;
+	struct atxp1_data * data;
+	int err;
+
+	if (!(data = kmalloc(sizeof(struct atxp1_data), GFP_KERNEL)))
+		return -ENOMEM;
+
+	memset(data, 0, sizeof(struct atxp1_data));
+	new_client = &data->client;
+	i2c_set_clientdata(new_client, data);
+	
+	new_client->addr = address;
+	new_client->adapter = adapter;
+	new_client->driver = &atxp1_driver;
+	new_client->flags = 0;
+	
+	/* Detect ATXP1 */
+	if(i2c_smbus_read_byte_data(new_client, ATXP1_CVID) <= 0) {
+		kfree(data);
+		return 0;
+	}
+	
+	strncpy(new_client->name, "atxp1", I2C_NAME_SIZE);
+	new_client->id=0;
+	data->valid=0;
+	
+//	init_MUTEX(&data->update_lock);
+	
+	if ((err = i2c_attach_client(new_client)))
+	{
+		printk(KERN_ERR "atxp1: Attach client error\n");
+		kfree(data);
+		return err;
+	}
+	
+	device_create_file(&new_client->dev, &dev_attr_vcore);
+	
+	printk(KERN_INFO "atxp1: Detected on %s, address 0x%02x\n", adapter->name, new_client->addr);
+	
+	return 0;
+};
+
+static int atxp1_detach_client(struct i2c_client * client)
+{
+	int err;
+	
+	err = i2c_detach_client(client);
+	
+	if (err) 
+		printk(KERN_ERR "atxp1: failed to detach client");
+	
+	kfree(i2c_get_clientdata(client));
+	
+	return 0;
+};
+ 
+static int atxp1_init(void)  
+{ 
+	i2c_add_driver(&atxp1_driver);
+	
+	return 0; 
+};
+
+void atxp1_exit(void) 
+{ 
+	i2c_del_driver(&atxp1_driver);
+};
+
+module_init(atxp1_init);
+module_exit(atxp1_exit);
+
