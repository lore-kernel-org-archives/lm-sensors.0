From: se.witt@gmx.net (Sebastian Witt)
Date: Thu, 19 May 2005 06:25:31 +0000
Subject: ATXP1 kernel patch
Message-Id: <41EEBD71.5010404@hasw.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <41D821D9.5030003@hasw.net>
In-Reply-To: <41D821D9.5030003@hasw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> 
> 1075mV isn't valid under VRM 9.x according to the specs, so I really
> wonder how it can work on some plateforms. I would happily see it
> removed to keep the code more simple. And i2c-sensor-vid will not
> support it anyway.

Ok, removed. The IRU3055 converter controller IC used on the 8RDA boards 
allows setting 1.075V.

> As a side note, i2c-sensor-vid.c and i2c-vid.h were written with VID pin
> *read* in mind, not write, so you might have to improve them a bit for
> your own needs.

Something like in the attached patch? I've not added the other VRMs yet, 
first need to know if the ATXP1 is used with other VRMs.

>># Update register data if needed
>>for(count = 0; count <= 0x0a; count++) {
>>     if((data->valid >> count & 1) = 0) {
>>         data->reg[count] = i2c_smbus_read_byte_data(client, count);
>>         data->valid |= 1 << count;
>>     }
>>}
> 
> 
> Huh. Looks even more complex. Do you really need to read all 10 first
> registers, while you were previously only reading 2? What is the benefit
> of having a separate "valid" bit for each register since you always read
> them all at once anyway?

For future versions, which are using more (all registers). For general 
purpose IOs (used to control other voltages, extra functions) and 
watchdog timer. Also a register variable gets only updated at start or
when a value was written.

> That would need to be documented in the code. Actually, the whole way
> the chip works should be, since there is no public datasheet people can
> look at.

Ok, I'll add more comments.

> 
> Note that you won't be able to support VRM 10 since it uses 6-bit VID,
> but all previous versions should work fine.
> 

I don't know if the ATXP1 is used on boards with < 9.0 at all. Would be 
interesting
if somebody knows.

> 
> In other words, it uses VRM 9.x. You will need to add validity checkings
> based on VRM version instead, providing you actually want to support
> other VRM versions.

See current patches.

> 
> OK, that makes sense. Please add a comment explaining this in the code.
> By slow I mean that SMBus transfer are slows (the bus is typically
> operating at 15kHz), and since atxp1_write does 2 transfers and can be
> called a dozen times to change the vid output once, it looked like it
> would be slower that needed. However, if there is a good reason to do it
> in an incremental way, fine with me. The operation isn't time critical
> and we want it to be safe, agreed. But at least this is a good reason to
> get rid of the readback test in atxp1_write.
> 
> Please note that the trick of increasing the vid value by one to
> linearly decrease vcore works with VRM 9.x but wouldn't work with all
> VRM 8.x, which are more complex. This might be a sufficient reason not
> to support VRM 8.x (since we don't know of any system using both VRM 8.x
> and an ATXP1). The fact that you will use i2c-sensor-vid doesn't mean
> that you have to support all VRM versions, just that you will avoid code
> duplication. You can check the VRM version and abort if it is anything
> you don't support (i.e. non-9.x for now).
> 

Yes, see patch.

> I don't know if this exist, but it certainly could. If both CPUs are
> handled by an ATXP1 (and thus the same driver), we could have a common
> static counter so that the first client creates cpu0_vid and the second
> would create cpu1_vid.

Not added yet, next patch.

> 
> Checking that random registers are 0 won't be very efficient because
> that's the default value for most chips. However, some specific
> registers would be worth checking: 0x3e, 0x3f, 0xfe, 0xff. These are the
> locations of device id and manufacturer id registers for most chips, so
> checking that they have value 0 is certainly great. It will avoid
> attaching to the various temperature sensors that can live at 0x4e.
> 
> The fact that registers 0x10-0x1a return the same value as 0x00 will
> also be a very efficient check. You don't have to check them all, a few
> of them will do (remember that each additional read will slow down the
> detection and increase the module load time as a result).
> 
> Your original check (CVID > 0) should probably be removed, as it doesn't
> seem to be valid (0 is a valid VID value, 1.850V under VRM 9.x).
> 

Done.

Bye,
Sebastian

-------------- next part --------------
diff -ruN linux-2.6.10-orig/drivers/i2c/chips/Kconfig linux-2.6.10/drivers/i2c/chips/Kconfig
--- linux-2.6.10-orig/drivers/i2c/chips/Kconfig	2005-01-02 21:41:37.000000000 +0100
+++ linux-2.6.10/drivers/i2c/chips/Kconfig	2005-01-02 16:54:50.000000000 +0100
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
--- linux-2.6.10-orig/drivers/i2c/chips/Makefile	2005-01-02 21:41:37.000000000 +0100
+++ linux-2.6.10/drivers/i2c/chips/Makefile	2005-01-19 20:10:13.223745584 +0100
@@ -11,6 +11,7 @@
 obj-$(CONFIG_SENSORS_ADM1025)	+= adm1025.o
 obj-$(CONFIG_SENSORS_ADM1026)	+= adm1026.o
 obj-$(CONFIG_SENSORS_ADM1031)	+= adm1031.o
+obj-$(CONFIG_SENSORS_ATXP1)	+= atxp1.o
 obj-$(CONFIG_SENSORS_DS1621)	+= ds1621.o
 obj-$(CONFIG_SENSORS_EEPROM)	+= eeprom.o
 obj-$(CONFIG_SENSORS_FSCHER)	+= fscher.o
diff -ruN linux-2.6.10-orig/drivers/i2c/chips/atxp1.c linux-2.6.10/drivers/i2c/chips/atxp1.c
--- linux-2.6.10-orig/drivers/i2c/chips/atxp1.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10/drivers/i2c/chips/atxp1.c	2005-01-19 20:57:29.126622816 +0100
@@ -0,0 +1,356 @@
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
+    0.1: - Converted 8rdavcore into kernel module (Marcin Kaluza <marcin_ml@sekretarka.no-ip.org>)
+    0.2: - Cleanup, general interface for VCore (Sebastian Witt <hasw@hasw.net>)
+    0.3: - Fixed VID calculation (no FP operation)
+         - Fixed VID setting loop
+         - Added update lock
+         - Renamed device file to cpu_vid
+         - Added low_voltage module option to set lowest possible voltage (1075mV or 1100mV)
+    0.4: - Added GPIO[1,2]
+        - Using I2C VRM functions
+        - Changed detection
+        - Some other small fixes
+*/
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/i2c.h>
+#include <linux/i2c-sensor.h>
+#include <linux/i2c-vid.h>
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("System voltages control via Attansic ATXP1");
+MODULE_VERSION("0.4");
+
+#define ATXP1_VID	0x00
+#define ATXP1_CVID	0x01
+#define ATXP1_GPIO1	0x06
+#define ATXP1_GPIO2	0x0a
+#define ATXP1_VIDENA	0x20
+#define ATXP1_VIDMASK	0x1f
+#define ATXP1_GPIO1MASK	0x0f
+
+static unsigned short normal_i2c[]= { 0x37, 0x4e, I2C_CLIENT_END };
+static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
+static int atxp1_attach_adapter(struct i2c_adapter * adapter);
+static int atxp1_detach_client(struct i2c_client * client);
+static struct atxp1_data * atxp1_update_device(struct device *dev);
+static int atxp1_detect(struct i2c_adapter *adapter, int address, int kind);
+
+static struct i2c_driver atxp1_driver = {
+	.owner		= THIS_MODULE,
+	.name		= "atxp1",
+	.flags		= I2C_DF_NOTIFY,
+	.attach_adapter = atxp1_attach_adapter,
+	.detach_client	= atxp1_detach_client,
+};
+
+SENSORS_INSMOD_1(atxp1);
+
+struct atxp1_data {
+	struct i2c_client client;
+	struct semaphore update_lock;
+	u16 valid;
+	unsigned char reg[0x0f];
+	u8 vrm;
+};
+
+static struct atxp1_data * atxp1_update_device(struct device *dev) 
+{
+	struct i2c_client *client;
+	struct atxp1_data *data;
+	unsigned char count;
+	
+	client = to_i2c_client(dev);
+	data = i2c_get_clientdata(client);
+	
+	down(&data->update_lock);
+	
+	/* Update local register data only if register was written */
+	for(count = 0; count <= 0x0a; count++) {
+		if((data->valid >> count & 1) = 0) {
+			data->reg[count] = i2c_smbus_read_byte_data(client, count);
+			data->valid |= 1 << count;
+		}
+	}
+    	
+	up(&data->update_lock);
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
+		dev_err(&client->dev, "Write failed.\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+/* Device file functions for VCore */
+ssize_t atxp1_showvcore(struct device *dev, char *buf)
+{
+	int size;
+	struct atxp1_data *data;
+	
+	data = atxp1_update_device(dev);
+	
+	size = sprintf(buf, "%d\n", vid_from_reg(data->reg[ATXP1_VID] & ATXP1_VIDMASK, data->vrm));
+
+	return size;
+}
+
+ssize_t atxp1_storevcore(struct device *dev, const char* buf, size_t count)
+{
+	struct atxp1_data *data;
+	struct i2c_client *client;
+	char vid;
+	char cvid;
+	unsigned int vcore;
+
+	client = to_i2c_client(dev);
+	data = atxp1_update_device(dev);
+
+	vcore = simple_strtoul(buf, NULL, 10);
+	vcore /= 25;	
+	vcore *= 25;	
+	
+	/* Calculate VID */
+	vid = reg_from_vid(vcore, data->vrm);
+	
+	if(vid < 0) {
+		dev_err(dev, "VID calculation failed.\n");
+		return -1;
+	}
+	
+	/* If output enabled, use control register value. Otherwise original CPU VID */
+	if(data->reg[ATXP1_VID] & ATXP1_VIDENA)
+		cvid = data->reg[ATXP1_VID] & ATXP1_VIDMASK;
+	else
+		cvid = data->reg[ATXP1_CVID];
+	
+	/* Nothing changed, aborting */
+	if(vid = cvid)
+		return strlen(buf);
+	
+	dev_info(dev, "Setting VCore to %d mV (0x%02x)\n", vcore, vid);
+	
+	/* Write every 25 mV step to increase stability */
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
+	data->valid &= ~1;
+	
+	return strlen(buf);
+}
+
+/* CPU core reference voltage
+    unit: millivolt
+*/
+static DEVICE_ATTR(cpu0_vid, S_IRUGO | S_IWUSR, atxp1_showvcore, atxp1_storevcore);
+
+/* Device file functions for GPIO1 */
+ssize_t atxp1_showgpio1(struct device *dev, char *buf)
+{
+	int size;
+	struct atxp1_data *data;
+	
+	data = atxp1_update_device(dev);
+	
+	size = sprintf(buf, "0x%02x\n", data->reg[ATXP1_GPIO1] & ATXP1_GPIO1MASK);
+
+	return size;
+}
+
+ssize_t atxp1_storegpio1(struct device *dev, const char* buf, size_t count)
+{
+	struct atxp1_data *data;
+	struct i2c_client *client;
+	unsigned int value;
+	
+	client = to_i2c_client(dev);
+	data = atxp1_update_device(dev);
+
+	value = simple_strtoul(buf, NULL, 16);
+	
+	value &= ATXP1_GPIO1MASK;
+	
+	dev_info(dev, "Writing 0x%x to GPIO1.\n", value);
+	
+	if(value != (data->reg[ATXP1_GPIO1] & ATXP1_GPIO1MASK)) {
+		atxp1_write(client, ATXP1_GPIO1, value);
+		data->valid &= ~(1 << ATXP1_GPIO1);
+	}
+	
+	return strlen(buf);
+}
+
+static DEVICE_ATTR(gpio1, S_IRUGO | S_IWUSR, atxp1_showgpio1, atxp1_storegpio1);
+
+/* Device file functions for GPIO2 */
+ssize_t atxp1_showgpio2(struct device *dev, char *buf)
+{
+	int size;
+	struct atxp1_data *data;
+	
+	data = atxp1_update_device(dev);
+	
+	size = sprintf(buf, "0x%02x\n", data->reg[ATXP1_GPIO2]);
+
+	return size;
+}
+
+ssize_t atxp1_storegpio2(struct device *dev, const char* buf, size_t count)
+{
+	struct atxp1_data *data;
+	struct i2c_client *client;
+	unsigned int value;
+	
+	client = to_i2c_client(dev);
+	data = atxp1_update_device(dev);
+
+	value = simple_strtoul(buf, NULL, 16) & 0xff;
+	
+	dev_info(dev, "Writing 0x%x to GPIO1.\n", value);
+	
+	if(value != data->reg[ATXP1_GPIO2]) {
+		atxp1_write(client, ATXP1_GPIO2, value);
+		data->valid &= ~(1 << ATXP1_GPIO2);
+	}
+	
+	return strlen(buf);
+}
+
+static DEVICE_ATTR(gpio2, S_IRUGO | S_IWUSR, atxp1_showgpio2, atxp1_storegpio2);
+
+
+static int atxp1_attach_adapter(struct i2c_adapter *adapter)
+{
+	return i2c_detect(adapter, &addr_data, &atxp1_detect);
+};
+	
+static int atxp1_detect(struct i2c_adapter *adapter, int address, int kind)
+{
+	struct i2c_client* new_client;
+	struct atxp1_data * data;
+	int err;
+	u8 temp;
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
+	/* Detect ATXP1, checking if reg. 0x10,0x11 same as reg. 0x00 and vendor
+	 * ID registers are all zero */
+	temp = i2c_smbus_read_byte_data(new_client, ATXP1_VID);
+	if(!((i2c_smbus_read_byte_data(new_client, 0x10) = temp) &&
+	   (i2c_smbus_read_byte_data(new_client, 0x11) = temp) &&
+	   (i2c_smbus_read_byte_data(new_client, 0x3e) = 0x00) &&
+	   (i2c_smbus_read_byte_data(new_client, 0x3f) = 0x00) &&
+	   (i2c_smbus_read_byte_data(new_client, 0xfe) = 0x00) &&
+	   (i2c_smbus_read_byte_data(new_client, 0xff) = 0x00)	)) {
+		kfree(data);
+		return 0;
+	}
+	
+	strncpy(new_client->name, "atxp1", I2C_NAME_SIZE);
+
+	data->valid = 0;
+	
+	init_MUTEX(&data->update_lock);
+	
+	if ((err = i2c_attach_client(new_client)))
+	{
+		dev_err(&new_client->dev, "Attach client error.\n");
+		kfree(data);
+		return err;
+	}
+	
+	device_create_file(&new_client->dev, &dev_attr_gpio1);
+	device_create_file(&new_client->dev, &dev_attr_gpio2);
+	device_create_file(&new_client->dev, &dev_attr_cpu0_vid);
+	
+	/* Get VRM */
+	data->vrm = i2c_which_vrm();
+	
+	if(data->vrm != 90) {
+		dev_err(&new_client->dev, "Not supporting VRM %d\n", data->vrm);
+		return -1;
+	}
+	
+	dev_info(&new_client->dev, "Detected on %s. Using VRM: %d.%d\n", 
+			 adapter->name, data->vrm / 10, data->vrm % 10);
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
+		dev_err(&client->dev, "Failed to detach client.\n");
+	else
+		kfree(i2c_get_clientdata(client));
+	
+	return 0;
+};
+ 
+static int __init atxp1_init(void)  
+{ 
+	i2c_add_driver(&atxp1_driver);
+	
+	return 0; 
+};
+
+static void __exit atxp1_exit(void) 
+{ 
+	i2c_del_driver(&atxp1_driver);
+};
+
+module_init(atxp1_init);
+module_exit(atxp1_exit);
+
-------------- next part --------------
--- linux-2.6.10-orig/include/linux/i2c-vid.h	2004-12-24 22:33:49.000000000 +0100
+++ linux-2.6.10/include/linux/i2c-vid.h	2005-01-19 20:12:26.840432760 +0100
@@ -97,3 +97,22 @@
 		                     2050 - (val) * 50);
 	}
 }
+
+static inline int reg_from_vid(int val, int vrm)
+{
+	
+	switch(vrm) {
+
+	case  0:
+		return -1;
+
+	case 91:		/* VRM 9.1 */
+	case 90:		/* VRM 9.0 */
+		return ((val >= 1100) && (val <= 1850) ?
+				((18500 - val * 10) / 25 + 5) / 10 : -1);
+	
+	default:
+		return -1;
+
+	}
+}
