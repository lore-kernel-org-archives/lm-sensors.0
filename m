From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: Dallas 1-wire protocol implementation.
Message-Id: <20040412180004.3fc61829.johnpol@2ka.mipt.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040402012453.0b5db46e.johnpol@2ka.mipt.ru>
In-Reply-To: <20040402012453.0b5db46e.johnpol@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello.

This patch resolves following issues:
1. Moving w1 transport layer primitives from .h into .c file (w1_io.c)
2. Creates new sysfs file(it's name and callback are defined in
family_ops structure and are provided by "chip" driver) which contains
some ascii based data. For temperature device this file is called
temp1_input and contains last good reading temperature value multiplied
by 1000.
Old file which contains ROM data probably shoud be called
rom(?).
3. Renaming term->therm is not attached.

Patch is not in incremental form and contains previous family
abstraction split, sorry.
Actually current changes are obvious and small enough.

If you have any suggestions or questions about design please comment,
else I can provide patch for inclusion.

Thank you.

	Evgeniy Polyakov ( s0mbre )

Only failure makes us experts. -- Theo de Raadt
-------------- next part --------------
Index: Makefile
=================================RCS file: /usr/local/cvsroot/w1/Makefile,v
retrieving revision 1.5
diff -u -r1.5 Makefile
--- Makefile	28 Mar 2004 20:52:52 -0000	1.5
+++ Makefile	12 Apr 2004 13:25:40 -0000
@@ -1,5 +1,4 @@
-obj-m		:= wire.o
-wire-objs	:= w1.o w1_int.o w1_netlink.o
+obj-m		:= w1_term.o
 
 KDIR	:= /lib/modules/$(shell uname -r)/build
 PWD	:= $(shell pwd)
@@ -9,6 +8,3 @@
 
 clean:
 	rm -f *.o *.ko *.mod.* .*.cmd
-
-w1d:	w1d.c w1_netlink.h
-	gcc -W -Wall -O9 w1d.c -o w1d
Index: w1.c
=================================RCS file: /usr/local/cvsroot/w1/w1.c,v
retrieving revision 1.7
diff -u -r1.7 w1.c
--- w1.c	29 Mar 2004 22:11:21 -0000	1.7
+++ w1.c	12 Apr 2004 13:24:33 -0000
@@ -37,11 +37,12 @@
 #include "w1_io.h"
 #include "w1_log.h"
 #include "w1_int.h"
+#include "w1_family.h"
 #include "w1_netlink.h"
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Evgeniy Polyakov <johnpol@2ka.mipt.ru>");
-MODULE_DESCRIPTION("Driver for 1-wire Dallas network devotocol.");
+MODULE_DESCRIPTION("Driver for 1-wire Dallas network protocol.");
 
 static int w1_timeout = 5*HZ;
 int w1_max_slave_count = 10;
@@ -59,125 +60,23 @@
 
 static int w1_master_match(struct device *dev, struct device_driver *drv)
 {
-	log("%s: dev=%p, rv=%p\n", __func__, dev, drv);
 	return 1;
 }
 
 static int w1_master_probe(struct device *dev)
 {
-	log("%s: dev=%p\n", __func__, dev);
 	return -ENODEV;
 }
 
 static int w1_master_remove(struct device *dev)
 {
-	log("%s: dev=%p\n", __func__, dev);
 	return 0;
 }
 
-static ssize_t w1_show_slave_name(struct device *dev, char *buf)
-{
-	struct w1_slave *sl = container_of(dev, struct w1_slave, dev);
-	
-	log("%s: dev=%p, buf=%p\n", __func__, dev, buf);
-	return sprintf(buf, "%s\n", sl->name);
-}
-
-static ssize_t w1_slave_read(struct kobject *kobj, char *buf, loff_t off, size_t count)
-{
-	struct w1_slave	*sl = container_of(container_of(kobj, struct device, kobj), struct w1_slave, dev);
-	struct w1_master *dev = sl->master;
-	u8 rom[9], crc, verdict;
-	size_t icount;
-	int i;
-	u16 temp;
-	
-	atomic_inc(&sl->refcnt);
-	if (down_interruptible(&sl->master->mutex))
-	{
-		count = 0;
-		goto out_dec;
-	}
-
-	if (off > W1_SLAVE_DATA_SIZE)
-	{
-		count = 0;
-		goto out;
-	}
-	if (off + count > W1_SLAVE_DATA_SIZE)
-		count = W1_SLAVE_DATA_SIZE - off;
-
-	icount = count;
-	
-	memset(buf, 0, count);
-	memset(rom, 0, sizeof(rom));
-	
-	count 	= 0;
-	verdict = 0;
-	crc 	= 0;
-	if (!w1_reset_bus(dev))
-	{
-		u64 id = *(u64 *)&sl->reg_num;
-		int count = 0;
-		
-		w1_write_8(dev, W1_MATCH_ROM);
-		for (i=0; i<8; ++i)
-			w1_write_8(dev, (id >> i*8) & 0xff);
-
-		w1_write_8(dev, W1_CONVERT_TEMP);
-
-		while(dev->bus_master->read_bit(dev->bus_master->data) = 0 && count < 10)
-		{
-			udelay(1);
-			count++;
-		}
-
-		if (count < 10)
-		{
-			if (!w1_reset_bus(dev))
-			{
-				w1_write_8(dev, W1_MATCH_ROM);
-				for (i=0; i<8; ++i)
-					w1_write_8(dev, (id >> i*8) & 0xff);
-				
-				w1_write_8(dev, W1_READ_SCRATCHPAD);
-				for (i=0; i<9; ++i)
-					rom[i] = w1_read_8(dev);
-
-				crc = w1_calc_crc8(rom, 8);
-
-				if (rom[8] = crc && rom[0])
-					verdict = 1;
-			}
-		}
-		else
-			log("18S20 doesn't respond to CONVERT_TEMP.\n");
-	}
-	
-	for (i=0; i<9; ++i)
-		count += snprintf(buf+count, icount - count, "%02x ", rom[i]);
-	count += snprintf(buf+count, icount-count, ": crc=%02x %s\n", crc, (verdict)?"YES":"NO");
-	if (verdict)
-		memcpy(sl->rom, rom, sizeof(sl->rom));
-	for (i=0; i<9; ++i)
-		count += snprintf(buf+count, icount - count, "%02x ", sl->rom[i]);
-	temp = 0;
-	temp <<= sl->rom[1]/2;
-	temp |= sl->rom[0]/2;
-	count += snprintf(buf+count, icount-count, "t=%u\n", temp);
-out:
-	up(&dev->mutex);
-out_dec:
-	atomic_dec(&sl->refcnt);
-
-	return count;
-}
-
 static void w1_master_release(struct device *dev)
 {
 	struct w1_master *md = container_of(dev, struct w1_master, dev);
 	
-	log("%s: dev=%p\n", __func__, dev);
 	complete(&md->dev_released);
 }
 
@@ -185,10 +84,18 @@
 {
 	struct w1_slave *sl = container_of(dev, struct w1_slave, dev);
 	
-	log("%s: dev=%p, sl=%p\n", __func__, dev, sl);
 	complete(&sl->dev_released);
 }
 
+static ssize_t w1_default_read_name(struct device *dev, char *buf)
+{
+	return sprintf(buf, "No family registered.\n");
+}
+
+static ssize_t w1_default_read_bin(struct kobject *kobj, char *buf, loff_t off, size_t count)
+{
+	return sprintf(buf, "No family registered.\n");
+}
 
 struct bus_type w1_bus_type = 
 {
@@ -216,7 +123,13 @@
 static struct device_attribute w1_slave_attribute  {
 	.attr = {.name = "name", .mode = S_IRUGO, .owner = THIS_MODULE },
-	.show = &w1_show_slave_name,
+	.show = &w1_default_read_name,
+};
+
+static struct device_attribute w1_slave_attribute_val +{
+	.attr = {.name = "value", .mode = S_IRUGO, .owner = THIS_MODULE },
+	.show = &w1_default_read_name,
 };
 	
 ssize_t w1_master_attribute_show(struct device * dev, char * buf)
@@ -266,7 +179,7 @@
 			.mode = S_IRUGO,
 		},
 	.size 	= W1_SLAVE_DATA_SIZE,
-	.read	= &w1_slave_read,
+	.read	= &w1_default_read_bin,
 };
 
 static int __w1_attach_slave_device(struct w1_slave *sl)
@@ -283,19 +196,33 @@
 	snprintf(&sl->name[0], sizeof(sl->name),
 			"%x-%llx", (unsigned int)sl->reg_num.family, (unsigned long long)sl->reg_num.id);
 	
-	log("%s: registering %s.\n", __func__, &sl->dev.bus_id[0]);
+	dev_info(&sl->dev, "%s: registering %s.\n", __func__, &sl->dev.bus_id[0]);
 
 	err = device_register(&sl->dev);
 	if (err < 0)
 	{
-		log("Device registration [%s] failed. err=%d\n", sl->dev.bus_id, err);
+		dev_err(&sl->dev, "Device registration [%s] failed. err=%d\n", sl->dev.bus_id, err);
 		return err;
 	}
 	
+	w1_slave_bin_attribute.read 	= sl->family->fops->rbin;
+	w1_slave_attribute.show		= sl->family->fops->rname;
+	w1_slave_attribute_val.show	= sl->family->fops->rval;
+	w1_slave_attribute_val.attr.name	= sl->family->fops->rvalname;
+		
 	err = device_create_file(&sl->dev, &w1_slave_attribute);
 	if (err < 0)
 	{
-		log("sysfs file creation for [%s] failed. err=%d\n", sl->dev.bus_id, err);
+		dev_err(&sl->dev, "sysfs file creation for [%s] failed. err=%d\n", sl->dev.bus_id, err);
+		device_unregister(&sl->dev);
+		return err;
+	}
+	
+	err = device_create_file(&sl->dev, &w1_slave_attribute);
+	if (err < 0)
+	{
+		dev_err(&sl->dev, "sysfs file creation for [%s] failed. err=%d\n", sl->dev.bus_id, err);
+		device_remove_file(&sl->dev, &w1_slave_attribute);
 		device_unregister(&sl->dev);
 		return err;
 	}
@@ -303,8 +230,10 @@
 	err = sysfs_create_bin_file(&sl->dev.kobj, &w1_slave_bin_attribute);
 	if (err < 0)
 	{
-		log("%s: sysfs file creation for [%s] failed. err=%d\n", __func__, sl->dev.bus_id, err);
+		dev_err(&sl->dev, "%s: sysfs file creation for [%s] failed. err=%d\n", 
+				__func__, sl->dev.bus_id, err);
 		device_remove_file(&sl->dev, &w1_slave_attribute);
+		device_remove_file(&sl->dev, &w1_slave_attribute_val);
 		device_unregister(&sl->dev);
 		return err;
 	}
@@ -317,12 +246,13 @@
 static int w1_attach_slave_device(struct w1_master *dev, struct w1_reg_num *rn)
 {
 	struct w1_slave *sl;
+	struct w1_family *f;
 	int err;
-
+	
 	sl = kmalloc(sizeof(struct w1_slave), GFP_KERNEL);
 	if (!sl)
 	{
-		log("%s: failed to allocate new slave device.\n", __func__);
+		dev_err(&dev->dev, "%s: failed to allocate new slave device.\n", __func__);
 		return -ENOMEM;
 	}
 
@@ -335,10 +265,26 @@
 	atomic_set(&sl->refcnt, 0);
 	init_completion(&sl->dev_released);
 	
+	spin_lock(&flock);
+	f = w1_family_registered(rn->family);
+	if (!f)
+	{
+		spin_unlock(&flock);
+		dev_info(&dev->dev, "Family %x is not registered.\n", rn->family);
+		kfree(sl);
+		return -ENODEV;
+	}
+	__family_get(f);
+	spin_unlock(&flock);
+	
+	sl->family	= f;
+	
+
 	err = __w1_attach_slave_device(sl);
 	if (err < 0)
 	{
-		log("%s: Attaching %s failed.\n", __func__, sl->name);
+		dev_err(&dev->dev, "%s: Attaching %s failed.\n", __func__, sl->name);
+		family_put(sl->family);
 		kfree(sl);
 		return err;
 	}
@@ -350,14 +296,15 @@
 
 static void w1_slave_detach(struct w1_slave *sl)
 {
-	log("%s: detaching %s.\n", __func__, sl->name);
+	dev_info(&sl->dev, "%s: detaching %s.\n", __func__, sl->name);
 	
 	while (atomic_read(&sl->refcnt))
-		schedule_timeout(100);
+		schedule_timeout(10);
 
 	sysfs_remove_bin_file(&sl->dev.kobj, &w1_slave_bin_attribute);
 	device_remove_file(&sl->dev, &w1_slave_attribute);
 	device_unregister(&sl->dev);
+	family_put(sl->family);
 }
 
 static void w1_search(struct w1_master *dev)
@@ -396,7 +343,7 @@
 		 */
 		if (w1_reset_bus(dev))
 		{
-			log("No devices present on the wire.\n");
+			dev_info(&dev->dev, "No devices present on the wire.\n");
 			break;
 		}
 
@@ -471,12 +418,12 @@
 				sl->reg_num.id = tmp->id &&
 				sl->reg_num.crc = tmp->crc)
 			{
-				//log("%s: %s still exists.\n", __func__, sl->name);
+				//dev_info(&sl->dev, "%s: %s still exists.\n", __func__, sl->name);
 				break;
 			}
 			else if (sl->reg_num.family = tmp->family)
 			{
-				//log("%s: found new family %u.\n", __func__, tmp->family);
+				//dev_info(&dev->dev, "%s: found new family %u.\n", __func__, tmp->family);
 				family_found = 1;
 				break;
 			}
@@ -485,7 +432,7 @@
 		}
 
 		if (slave_count = dev->slave_count && 
-				msg.val && (*((__u8 *)&msg.val) = msg.id.id.crc && msg.id.id.family = W1_FAMILY))
+				msg.val && (*((__u8 *)&msg.val) = msg.id.id.crc))
 		{
 			w1_attach_slave_device(dev, (struct w1_reg_num *)&rn);
 		}
@@ -543,7 +490,8 @@
 
 				err = kill_proc(dev->kpid, SIGTERM, 1);
 				if (err)
-					log("%s: Failed to send signal to w1 kernel thread %d.\n", __func__, dev->kpid);
+					dev_err(&dev->dev, "%s: Failed to send signal to w1 kernel thread %d.\n", 
+							__func__, dev->kpid);
 			}
 			
 			wait_for_completion(&dev->dev_exited);
@@ -553,7 +501,7 @@
 				sl = list_entry(ent, struct w1_slave, w1_slave_entry);
 
 				if (!sl)
-					log("%s: slave entry is NULL.\n", __func__);
+					dev_warn(&dev->dev, "%s: slave entry is NULL.\n", __func__);
 				else
 				{
 					list_del(&sl->w1_slave_entry);
@@ -613,26 +561,26 @@
 {
 	int retval;
 
-	log("Driver for 1-wire Dallas network protocol.\n");
+	printk(KERN_INFO "Driver for 1-wire Dallas network protocol.\n");
 
 	retval = bus_register(&w1_bus_type);
 	if (retval)
 	{
-		log("Failed to register bus. err=%d.\n", retval);
+		printk(KERN_ERR "Failed to register bus. err=%d.\n", retval);
 		goto err_out_exit_init;
 	}
 	
 	retval = driver_register(&w1_driver);
 	if (retval)
 	{
-		log("Failed to register master driver. err=%d.\n", retval);
+		printk(KERN_ERR "Failed to register master driver. err=%d.\n", retval);
 		goto err_out_bus_unregister;
 	}
 
 	control_thread = kernel_thread(&w1_control, NULL, 0);
 	if (control_thread < 0)
 	{
-		log("Failed to create control thread. err=%d\n", control_thread);
+		printk(KERN_ERR "Failed to create control thread. err=%d\n", control_thread);
 		retval = control_thread;
 		goto err_out_driver_unregister;
 	}
@@ -667,7 +615,7 @@
 	driver_unregister(&w1_driver);
 	bus_unregister(&w1_bus_type);
 
-	log("Driver for 1-wire Dallas network protocol is removed.\n");
+	printk(KERN_INFO "Driver for 1-wire Dallas network protocol is removed.\n");
 }
 
 module_init(w1_init);
Index: w1.h
=================================RCS file: /usr/local/cvsroot/w1/w1.h,v
retrieving revision 1.7
diff -u -r1.7 w1.h
--- w1.h	29 Mar 2004 22:11:21 -0000	1.7
+++ w1.h	12 Apr 2004 13:24:34 -0000
@@ -38,10 +38,10 @@
 
 #include <asm/semaphore.h>
 
+#include "w1_family.h"
 
 #define W1_MAXNAMELEN		32
 #define W1_SLAVE_DATA_SIZE	128
-#define W1_FAMILY		0x10
 
 #define W1_SEARCH		0xF0
 #define W1_CONDITIONAL_SEARCH	0xEC
@@ -62,6 +62,7 @@
 	u8			rom[9];
 
 	struct w1_master	*master;
+	struct w1_family 	*family;
 	struct device 		dev;
 	struct completion 	dev_released;
 };
Index: w1_family.h
=================================RCS file: /usr/local/cvsroot/w1/w1_family.h,v
retrieving revision 1.1
diff -u -r1.1 w1_family.h
--- w1_family.h	5 Apr 2004 18:18:54 -0000	1.1
+++ w1_family.h	12 Apr 2004 13:24:34 -0000
@@ -30,10 +30,15 @@
 #define W1_FAMILY_TERM		0x10
 #define W1_FAMILY_IBUT		0xff /* ? */
 
+#define MAXNAMELEN		32
+
 struct w1_family_ops
 {
 	ssize_t (* rname)(struct device *, char *);
 	ssize_t (* rbin)(struct kobject *, char *, loff_t, size_t);
+	
+	ssize_t (* rval)(struct device *, char *);
+	unsigned char rvalname[MAXNAMELEN];
 };
 
 struct w1_family
Index: w1_io.h
=================================RCS file: /usr/local/cvsroot/w1/w1_io.h,v
retrieving revision 1.5
diff -u -r1.5 w1_io.h
--- w1_io.h	4 Apr 2004 13:33:09 -0000	1.5
+++ w1_io.h	12 Apr 2004 13:24:34 -0000
@@ -22,114 +22,14 @@
 #ifndef __W1_IO_H
 #define __W1_IO_H
 
-#include <asm/io.h>
-#include <asm/delay.h>
-
 #include "w1.h"
-#include "w1_log.h"
-
-extern int w1_delay_parm;
-
-static u8 w1_crc8_table[] = {
-        0, 94,188,226, 97, 63,221,131,194,156,126, 32,163,253, 31, 65,
-      157,195, 33,127,252,162, 64, 30, 95,  1,227,189, 62, 96,130,220,
-       35,125,159,193, 66, 28,254,160,225,191, 93,  3,128,222, 60, 98,
-      190,224,  2, 92,223,129, 99, 61,124, 34,192,158, 29, 67,161,255,
-       70, 24,250,164, 39,121,155,197,132,218, 56,102,229,187, 89,  7,
-      219,133,103, 57,186,228,  6, 88, 25, 71,165,251,120, 38,196,154,
-      101, 59,217,135,  4, 90,184,230,167,249, 27, 69,198,152,122, 36,
-      248,166, 68, 26,153,199, 37,123, 58,100,134,216, 91,  5,231,185,
-      140,210, 48,110,237,179, 81, 15, 78, 16,242,172, 47,113,147,205,
-       17, 79,173,243,112, 46,204,146,211,141,111, 49,178,236, 14, 80,
-      175,241, 19, 77,206,144,114, 44,109, 51,209,143, 12, 82,176,238,
-       50,108,142,208, 83, 13,239,177,240,174, 76, 18,145,207, 45,115,
-      202,148,118, 40,171,245, 23, 73,  8, 86,180,234,105, 55,213,139,
-       87,  9,235,181, 54,104,138,212,149,203, 41,119,244,170, 72, 22,
-      233,183, 85, 11,136,214, 52,106, 43,117,151,201, 74, 20,246,168,
-      116, 42,200,150, 21, 75,169,247,182,232, 10, 84,215,137,107, 53
-};
-
-static __inline__ void w1_delay(unsigned long tm)
-{
-	udelay(tm*w1_delay_parm);
-}
-
-static __inline__ void w1_write_bit(struct w1_master *dev, int bit)
-{
-	if (bit)
-	{
-		dev->bus_master->write_bit(dev->bus_master->data, 0);
-		w1_delay(6);
-		dev->bus_master->write_bit(dev->bus_master->data, 1);
-		w1_delay(64);
-	}
-	else
-	{
-		dev->bus_master->write_bit(dev->bus_master->data, 0);
-		w1_delay(60);
-		dev->bus_master->write_bit(dev->bus_master->data, 1);
-		w1_delay(10);
-	}
-}
-
-static __inline__ void w1_write_8(struct w1_master *dev, u8 byte)
-{
-	int i;
-
-	for (i=0; i<8; ++i)
-		w1_write_bit(dev, (byte >> i) & 0x1);
-}
-
-static __inline__ u8 w1_read_bit(struct w1_master *dev)
-{
-	int result;
-
-	dev->bus_master->write_bit(dev->bus_master->data, 0);
-	w1_delay(6);
-	dev->bus_master->write_bit(dev->bus_master->data, 1);
-	w1_delay(9);
-	
-	result = dev->bus_master->read_bit(dev->bus_master->data);
-	w1_delay(55);
-
-	return result & 0x1;
-}
-
-static __inline__ u8 w1_read_8(struct w1_master *dev)
-{
-	int i;
-	u8 res = 0;
-
-	for (i=0; i<8; ++i)
-		res |= (w1_read_bit(dev) << i);
-
-	return res;
-}
-
-
-static __inline__ int w1_reset_bus(struct w1_master *dev)
-{
-	int result;
-
-	dev->bus_master->write_bit(dev->bus_master->data, 0);
-	w1_delay(480);
-	dev->bus_master->write_bit(dev->bus_master->data, 1);
-	w1_delay(70);
-
-	result = dev->bus_master->read_bit(dev->bus_master->data) & 0x1;
-	w1_delay(410);
-
-	return result;
-}
-
-static __inline__ u8 w1_calc_crc8(u8 *data, int len)
-{
-	u8 crc = 0;
-
-	while (len--)
-		crc = w1_crc8_table[crc ^ *data++];
 
-	return crc;
-}
+void w1_delay(unsigned long);
+void w1_write_bit(struct w1_master *, int);
+void w1_write_8(struct w1_master *, u8);
+u8 w1_read_bit(struct w1_master *);
+u8 w1_read_8(struct w1_master *);
+int w1_reset_bus(struct w1_master *);
+u8 w1_calc_crc8(u8 *, int);
 
 #endif /* __W1_IO_H */
Index: w1_term.c
=================================RCS file: /usr/local/cvsroot/w1/w1_term.c,v
retrieving revision 1.1
diff -u -r1.1 w1_term.c
--- w1_term.c	5 Apr 2004 13:04:25 -0000	1.1
+++ w1_term.c	12 Apr 2004 13:24:35 -0000
@@ -37,12 +37,16 @@
 MODULE_DESCRIPTION("Driver for 1-wire Dallas network protocol, temperature family.");
 
 static ssize_t w1_term_read_name(struct device *, char *);
+static ssize_t w1_term_read_temp(struct device *, char *);
 static ssize_t w1_term_read_bin(struct kobject *, char *, loff_t, size_t);
 
 static struct w1_family_ops w1_term_fops  {
 	.rname		= &w1_term_read_name,
 	.rbin		= &w1_term_read_bin,
+	
+	.rval		= &w1_term_read_temp,
+	.rvalname	= "temp1_input",
 };
 
 static ssize_t w1_term_read_name(struct device *dev, char *buf)
@@ -50,6 +54,21 @@
 	struct w1_slave *sl = container_of(dev, struct w1_slave, dev);
 	
 	return sprintf(buf, "%s\n", sl->name);
+}
+
+static ssize_t w1_term_read_temp(struct device *dev, char *buf)
+{
+	struct w1_slave *sl = container_of(dev, struct w1_slave, dev);
+	s16 temp;
+	
+	/* 
+	 * Must be more precise.
+	 */
+	temp = 0;
+	temp <<= sl->rom[1]/2;
+	temp |= sl->rom[0]/2;
+	
+	return sprintf(buf, "%d\n", temp*1000);
 }
 
 static ssize_t w1_term_read_bin(struct kobject *kobj, char *buf, loff_t off, size_t count)
--- /dev/null	Thu Oct 30 21:31:23 2003
+++ w1_io.c	Mon Apr 12 17:24:34 2004
@@ -0,0 +1,141 @@
+/*
+ * 	w1_io.c
+ *
+ * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * 
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <asm/io.h>
+#include <asm/delay.h>
+
+#include <linux/moduleparam.h>
+
+#include "w1.h"
+#include "w1_log.h"
+#include "w1_io.h"
+
+int w1_delay_parm = 1;
+module_param_named(delay_coef, w1_delay_parm, int, 0);
+
+static u8 w1_crc8_table[] = {
+        0, 94,188,226, 97, 63,221,131,194,156,126, 32,163,253, 31, 65,
+      157,195, 33,127,252,162, 64, 30, 95,  1,227,189, 62, 96,130,220,
+       35,125,159,193, 66, 28,254,160,225,191, 93,  3,128,222, 60, 98,
+      190,224,  2, 92,223,129, 99, 61,124, 34,192,158, 29, 67,161,255,
+       70, 24,250,164, 39,121,155,197,132,218, 56,102,229,187, 89,  7,
+      219,133,103, 57,186,228,  6, 88, 25, 71,165,251,120, 38,196,154,
+      101, 59,217,135,  4, 90,184,230,167,249, 27, 69,198,152,122, 36,
+      248,166, 68, 26,153,199, 37,123, 58,100,134,216, 91,  5,231,185,
+      140,210, 48,110,237,179, 81, 15, 78, 16,242,172, 47,113,147,205,
+       17, 79,173,243,112, 46,204,146,211,141,111, 49,178,236, 14, 80,
+      175,241, 19, 77,206,144,114, 44,109, 51,209,143, 12, 82,176,238,
+       50,108,142,208, 83, 13,239,177,240,174, 76, 18,145,207, 45,115,
+      202,148,118, 40,171,245, 23, 73,  8, 86,180,234,105, 55,213,139,
+       87,  9,235,181, 54,104,138,212,149,203, 41,119,244,170, 72, 22,
+      233,183, 85, 11,136,214, 52,106, 43,117,151,201, 74, 20,246,168,
+      116, 42,200,150, 21, 75,169,247,182,232, 10, 84,215,137,107, 53
+};
+
+void w1_delay(unsigned long tm)
+{
+	udelay(tm*w1_delay_parm);
+}
+
+void w1_write_bit(struct w1_master *dev, int bit)
+{
+	if (bit)
+	{
+		dev->bus_master->write_bit(dev->bus_master->data, 0);
+		w1_delay(6);
+		dev->bus_master->write_bit(dev->bus_master->data, 1);
+		w1_delay(64);
+	}
+	else
+	{
+		dev->bus_master->write_bit(dev->bus_master->data, 0);
+		w1_delay(60);
+		dev->bus_master->write_bit(dev->bus_master->data, 1);
+		w1_delay(10);
+	}
+}
+
+void w1_write_8(struct w1_master *dev, u8 byte)
+{
+	int i;
+
+	for (i=0; i<8; ++i)
+		w1_write_bit(dev, (byte >> i) & 0x1);
+}
+
+u8 w1_read_bit(struct w1_master *dev)
+{
+	int result;
+
+	dev->bus_master->write_bit(dev->bus_master->data, 0);
+	w1_delay(6);
+	dev->bus_master->write_bit(dev->bus_master->data, 1);
+	w1_delay(9);
+	
+	result = dev->bus_master->read_bit(dev->bus_master->data);
+	w1_delay(55);
+
+	return result & 0x1;
+}
+
+u8 w1_read_8(struct w1_master *dev)
+{
+	int i;
+	u8 res = 0;
+
+	for (i=0; i<8; ++i)
+		res |= (w1_read_bit(dev) << i);
+
+	return res;
+}
+
+int w1_reset_bus(struct w1_master *dev)
+{
+	int result;
+
+	dev->bus_master->write_bit(dev->bus_master->data, 0);
+	w1_delay(480);
+	dev->bus_master->write_bit(dev->bus_master->data, 1);
+	w1_delay(70);
+
+	result = dev->bus_master->read_bit(dev->bus_master->data) & 0x1;
+	w1_delay(410);
+
+	return result;
+}
+
+u8 w1_calc_crc8(u8 *data, int len)
+{
+	u8 crc = 0;
+
+	while (len--)
+		crc = w1_crc8_table[crc ^ *data++];
+
+	return crc;
+}
+
+EXPORT_SYMBOL(w1_write_bit);
+EXPORT_SYMBOL(w1_write_8);
+EXPORT_SYMBOL(w1_read_bit);
+EXPORT_SYMBOL(w1_read_8);
+EXPORT_SYMBOL(w1_reset_bus);
+EXPORT_SYMBOL(w1_calc_crc8);
+EXPORT_SYMBOL(w1_delay);
