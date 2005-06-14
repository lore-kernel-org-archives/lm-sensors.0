From: bgardner@wabtec.com (bgardner@wabtec.com)
Date: Tue, 14 Jun 2005 19:40:25 +0000
Subject: [lm-sensors] w1-dev
Message-Id: <200506141239.28609.bgardner@wabtec.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Evgeniy,

I've been toying with a dev interface for the w1 bus to allow a user-space 
program to talk directly to a w1 slave.
The w1 slave that I am using it with is the DS2433 (family 23 4kb EEPROM).
The examples in the documentation refer to that chip.

The dev interface accepts a string as a series of w1 commands.
You then read back the results.
Documentation is included in the patch.

Although it works, I don't think it is quite ready to be considered 'done'.
There are a few areas that I am not comfortable with: locking, reference 
counts, etc.

If you (or anyone else) would like to play with it, feel free to do so.

The patch is against the latest set of w1 changes that we did.

Thanks,
Ben
-------------- next part --------------
--- linux-2.6.12-rc5-mm2-w1/drivers/w1/Kconfig	2005-06-07 10:53:49.000000000 -0500
+++ linux-2.6.12-rc5-mm2/drivers/w1/Kconfig	2005-06-06 17:07:09.000000000 -0500
@@ -11,6 +11,15 @@
 	  This W1 support can also be built as a module.  If so, the module
 	  will be called wire.ko.
 
+config W1_DEV
+	tristate "w1 master character device"
+	depends on W1
+	help
+	  Enables a char device interface to the w1 bus.
+
+	  This can also be built as a module.  If so, the module
+	  will be called w1_dev.
+
 config W1_MATROX
 	tristate "Matrox G400 transport layer for 1-wire"
 	depends on W1 && PCI
--- linux-2.6.12-rc5-mm2-w1/drivers/w1/Makefile	2005-06-07 10:53:49.000000000 -0500
+++ linux-2.6.12-rc5-mm2/drivers/w1/Makefile	2005-06-07 11:03:45.000000000 -0500
@@ -18,3 +18,5 @@
 
 obj-$(CONFIG_W1_DS9490_BRIDGE)	+= ds_w1_bridge.o
 
+obj-$(CONFIG_W1_DEV)		+= w1_dev.o 
+
--- linux-2.6.12-rc5-mm2-w1/drivers/w1/w1_int.h	2005-06-07 10:53:49.000000000 -0500
+++ linux-2.6.12-rc5-mm2/drivers/w1/w1_int.h	2005-06-14 11:16:59.986565375 -0500
@@ -27,6 +27,14 @@
 
 #include "w1.h"
 
+struct w1_notify_ops
+{
+	void	(*notify_add)(struct w1_master *master);
+	void	(*notify_remove)(struct w1_master *master);
+};
+int w1_add_notify(struct w1_notify_ops *ops);
+int w1_remove_notify(struct w1_notify_ops *ops);
+
 int w1_add_master_device(struct w1_bus_master *);
 void w1_remove_master_device(struct w1_bus_master *);
 void __w1_remove_master_device(struct w1_master *);
--- linux-2.6.12-rc5-mm2-w1/drivers/w1/w1_int.c	2005-06-14 11:09:23.338577775 -0500
+++ linux-2.6.12-rc5-mm2/drivers/w1/w1_int.c	2005-06-14 11:10:33.005564004 -0500
@@ -39,6 +39,10 @@
 
 extern int w1_process(void *);
 
+#define MAX_NOTIFY_OPS  1
+static struct w1_notify_ops *notify_ops[MAX_NOTIFY_OPS];
+static int notify_count = 0;
+
 static struct w1_master * w1_alloc_dev(u32 id, int slave_count, int slave_ttl,
 				       struct device_driver *driver,
 				       struct device *device)
@@ -119,6 +123,7 @@
 int w1_add_master_device(struct w1_bus_master *master)
 {
 	struct w1_master *dev;
+	int i;
 	int retval = 0;
 	struct w1_netlink_msg msg;
 
@@ -159,6 +164,11 @@
 	msg.type = W1_MASTER_ADD;
 	w1_netlink_send(dev, &msg);
 
+	for (i=0; i < notify_count; i++) {
+		if (notify_ops[i] && notify_ops[i]->notify_add)
+			notify_ops[i]->notify_add(dev);
+	}
+
 	return 0;
 
 err_out_kill_thread:
@@ -178,6 +188,7 @@
 void __w1_remove_master_device(struct w1_master *dev)
 {
 	int err;
+	int i;
 	struct w1_netlink_msg msg;
 
 	set_bit(W1_MASTER_NEED_EXIT, &dev->flags);
@@ -195,6 +206,11 @@
 			flush_signals(current);
 	}
 
+	for (i=0; i < notify_count; i++) {
+		if (notify_ops[i] && notify_ops[i]->notify_remove)
+			notify_ops[i]->notify_remove(dev);
+	}
+
 	msg.id.mst.id = dev->id;
 	msg.id.mst.pid = dev->kpid;
 	msg.type = W1_MASTER_REMOVE;
@@ -223,5 +239,39 @@
 	__w1_remove_master_device(dev);
 }
 
+int w1_add_notify(struct w1_notify_ops *ops)
+{
+	struct w1_master *master;
+
+	if (notify_count >= MAX_NOTIFY_OPS)
+		return -1;
+
+	notify_ops[notify_count++] = ops;
+
+	/* loop through all masters */
+	if (ops->notify_add) {
+		list_for_each_entry(master, &w1_masters, w1_master_entry) {
+			ops->notify_add(master);
+		}
+	}
+
+	return 0;
+}
+
+int w1_remove_notify(struct w1_notify_ops *ops)
+{
+	int i;
+	for (i=0; i < notify_count; i++) {
+		if (notify_ops[i] = ops) {
+			notify_count--;
+			notify_ops[i] = notify_ops[notify_count];
+			return 0;
+		}
+	}
+	return -1;
+}
+
+EXPORT_SYMBOL(w1_add_notify);
+EXPORT_SYMBOL(w1_remove_notify);
 EXPORT_SYMBOL(w1_add_master_device);
 EXPORT_SYMBOL(w1_remove_master_device);
--- linux-2.6.12-rc5-mm2-w1/drivers/w1/w1_dev.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.12-rc5-mm2/drivers/w1/w1_dev.c	2005-06-14 11:02:15.652913321 -0500
@@ -0,0 +1,536 @@
+/*
+ *	w1_dev.c - a script-like character interface
+ *
+ * Copyright (c) 2005 Ben Gardner <bgardner@wabtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ */
+
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/list.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/timer.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/sched.h>
+
+#include <asm/atomic.h>
+
+#include <linux/types.h>
+#include <linux/ctype.h>
+#include <linux/fs.h>
+#include <linux/cdev.h>
+
+#include "w1_int.h"
+#include "w1_io.h"
+
+
+#define W1_CHAR_DEV_COUNT  	16
+#define W1_RAW_DATA_SIZE	2048
+
+
+static int major = 0;
+module_param(major, int, 0);
+MODULE_PARM_DESC(major, "Set the chrdev major number");
+
+struct w1_raw_dev {
+	struct w1_master	*master;
+
+	struct semaphore	raw_lock;
+
+	dev_t			dev_id;
+	struct cdev		cdev;
+
+	char			*data;
+	int			data_len;
+};
+
+/* Protects w1_devs, below */
+static DECLARE_MUTEX(w1_devs_lock);
+static struct w1_raw_dev *w1_devs[W1_CHAR_DEV_COUNT];
+
+static dev_t w1_dev;
+
+
+/** Adds a char to the script buffer */
+static void w1_script_add_char(struct w1_raw_dev *rd, char ch)
+{
+	if (rd->data_len < (W1_RAW_DATA_SIZE - 1)) {
+		rd->data[rd->data_len++] = ch;
+	}
+}
+
+/** Adds two hex digits to the script buffer */
+static void w1_script_add_hexbyte(struct w1_raw_dev *rd, u8 byte)
+{
+	if (rd->data_len < (W1_RAW_DATA_SIZE - 2)) {
+		rd->data_len += sprintf(&rd->data[rd->data_len], "%02X", byte);
+	}
+}
+
+/** Adds a decimal number (0-255) to the script buffer */
+static void w1_script_add_decbyte(struct w1_raw_dev *rd, u8 byte)
+{
+	if (rd->data_len < (W1_RAW_DATA_SIZE - 3)) {
+		rd->data_len += sprintf(&rd->data[rd->data_len], "%u", byte);
+	}
+}
+
+/** Converts a hex character into a number (0-16) */
+static u8 hexchar_to_byte(char ch)
+{
+	u8 val = 0;
+	if (isxdigit(ch)) {
+		val = (ch <= '9') ? ch - '0' :
+		      (ch > 'F') ? ch - ('a' - 10) : ch - ('A' - 10);
+	}
+	return val;
+}
+
+/** Converts two hex characters into a number */
+static inline u8 make_byte(char hi, char lo)
+{
+	return (hexchar_to_byte(hi) << 4) | hexchar_to_byte(lo);
+}
+
+/**
+ * Executes a simple w1 script. 
+ * The ouput is put in the master structure. 
+ * The master semaphore should be held.
+ * 
+ * Commands:
+ *  s = reSet        "S"
+ *  r = Read bytes   "R3"
+ *  w = Write bytes  "W2,1234"
+ *  t = Touch bit    "T0110"
+ *  p = Pause (ms)   "P5"
+ *  v = Verify read  "V2,1234"
+ * 
+ * The output is a more-or-less copy of the input.
+ * Here's an example for the DS2433 - writing two bytes (1234) at offset 0026. 
+ *   "S W6,CC0F26001234 S W2,CCAA V5,2600071234 S W5,CC55260007 P5 S"
+ * 
+ * Successful output would match the input:
+ *   "S W6,CC0F26001234 S W2,CCAA V5,2600071234 S W5,CC55260007 P5 S"
+ * 
+ * On failure, a * is placed after the failed command and the rest is omitted.
+ * Output if the verify failed:
+ *   "S W6,CC0F26001234 S W2,CCAA V5,26000F1234*"
+ * 
+ * Output if no devices were present:
+ *   "S*"
+ * 
+ * Read example:
+ * In:  "S W4,CCF00000 R10 S"
+ * Out: "S W4,CCF00000 R10,00112233445566778899 S"
+ * 
+ * @param rd   The raw dev
+ * @param buf  The buffer to process
+ * @param len  The number of characters in the buffer
+ * @return -1=error encountered, 0=all successful
+ */
+static int w1_exec_script(struct w1_raw_dev *rd, const char *buf, size_t len)
+{
+	int		ret = 0;
+	unsigned int	uret;
+	int		ch;
+	const char	*endptr = &buf[len];
+	char		*newptr;
+	u8		val, valread;
+
+	rd->data_len = 0;
+	while ((buf < endptr) && (*buf != 0)) {
+		ch = toupper(*buf);
+		buf++;
+		w1_script_add_char(rd, ch);
+		if (isspace(ch))
+			continue;
+
+		switch (ch) {
+		case 'S':	/* reSet : no additional data */
+			if (w1_reset_bus(rd->master))
+				goto error_out;
+			break;
+
+		case 'T':	/* Touch bit : one bit per char */
+			while ((*buf = '0') || (*buf = '1')) {
+				ret = w1_touch_bit(rd->master, *buf = '1');
+				w1_script_add_char(rd, ret ? '1' : '0');
+				buf++;
+			}
+			break;
+
+		case 'P':	/* Pause : one decimal uint */
+			uret = simple_strtoul(buf, &newptr, 0);
+			buf = newptr;
+			w1_script_add_decbyte(rd, uret);
+			msleep_interruptible(uret);
+			break;
+
+		case 'R':	/* Read : one decimal uint */
+			uret = simple_strtoul(buf, &newptr, 0);
+			buf = newptr;
+			w1_script_add_decbyte(rd, uret);
+			w1_script_add_char(rd, ',');
+			while (uret-- > 0)
+				w1_script_add_hexbyte(rd,
+						      w1_read_8(rd->master));
+			break;
+
+		case 'W':	/* Write : one decimal uint, hex bytes */
+		case 'V':	/* Validate : one decimal uint, hex bytes */
+			uret = simple_strtoul(buf, &newptr, 0);
+			buf = newptr;
+			w1_script_add_decbyte(rd, uret);
+			w1_script_add_char(rd, *buf);
+			if (*buf != ',')
+				goto error_out;
+			buf++;
+			while ((uret-- > 0) && (buf < (endptr - 1))) {
+				val = make_byte(buf[0], buf[1]);
+				buf += 2;
+				if (ch = 'W') {
+					w1_script_add_hexbyte(rd, val);
+					w1_write_8(rd->master, val);
+				} else {
+					valread = w1_read_8(rd->master);
+					w1_script_add_hexbyte(rd, valread);
+					if (valread != val)
+						goto error_out;
+				}
+			}
+			break;
+
+		default:
+			goto error_out;
+		}
+	}
+	return 0;
+
+error_out:
+	w1_script_add_char(rd, '*');
+	return -1;
+}
+
+static ssize_t w1_dev_fop_write(struct file *file, const char __user *buf,
+				size_t len, loff_t *ppos)
+{
+	struct w1_raw_dev *rd;
+	u8 mycopy[W1_RAW_DATA_SIZE];
+	int idx;
+
+	if (len > (W1_RAW_DATA_SIZE - 1))
+		return -EINVAL;
+
+	idx = (int)file->private_data;
+
+	printk(KERN_WARNING "w1_raw: write(%d)\n", idx);
+
+	if ((idx < 0) || (idx >= W1_CHAR_DEV_COUNT) ||
+	    ((rd = w1_devs[idx]) = NULL))
+		return -ENODEV;
+
+	if (copy_from_user(mycopy, buf, len))
+		return -EFAULT;
+
+	/* Ensure termination */
+	mycopy[len] = 0;
+
+	if (rd->master = NULL) {
+		printk(KERN_WARNING "w1_raw: write(%d) rd->master is NULL\n",
+		       idx);
+		return -EFAULT;
+	}
+
+	/* Lock the raw entry so it doesn't go away */
+	if (down_interruptible(&rd->raw_lock))
+		return -EAGAIN;
+
+	/* Lock master to prevent a search in the middle of the script */
+	if (down_interruptible(&rd->master->mutex)) {
+		len = -EAGAIN;
+		goto exit_up1;
+	}
+
+	/* Reset the read size */
+	if (rd->data = NULL) {
+		if (!(rd->data = kmalloc(W1_RAW_DATA_SIZE, GFP_KERNEL))) {
+			len = -ENOMEM;
+			goto exit_up2;
+		}
+		memset(rd->data, 0, W1_RAW_DATA_SIZE);
+	}
+	w1_exec_script(rd, mycopy, len);
+
+	/* write always resets the position */
+	*ppos = 0;
+
+exit_up2:
+	up(&rd->master->mutex);
+exit_up1:
+	up(&rd->raw_lock);
+
+	return len;
+}
+
+/**
+ * Reads the results from the last script executed.
+ */
+static ssize_t w1_dev_fop_read(struct file *file, char __user *buf,
+			       size_t count, loff_t *ppos)
+{
+	unsigned i = *ppos;
+	struct w1_raw_dev *rd;
+
+	int idx;
+	ssize_t len = 0;
+
+	idx = (int)file->private_data;
+
+	printk(KERN_WARNING "w1_raw: read(%d)\n", idx);
+
+	if ((idx < 0) || (idx >= W1_CHAR_DEV_COUNT) ||
+	    ((rd = w1_devs[idx]) = NULL))
+		return -ENODEV;
+
+	/* Lock the interface */
+	if (down_interruptible(&rd->raw_lock))
+		return -EAGAIN;
+
+	if (rd->data != NULL) {
+		if (i > rd->data_len) {
+			len = 0;
+		} else {
+			len = rd->data_len - i;
+			if (len > count) {
+				len = count;
+			}
+		}
+
+		if (copy_to_user(buf, &rd->data[i], len)) {
+			len = -EFAULT;
+		} else {
+			i += len;
+		}
+	}
+	up(&rd->raw_lock);
+
+	*ppos = i;
+
+	return len;
+}
+
+/** 
+ * Sets private_data to the w1_master structure index 
+ * TODO: support exclusive opens?
+ */
+static int w1_dev_fop_open(struct inode *inode, struct file *file)
+{
+	int dev_idx;
+
+	if (inode = NULL) {
+		printk(KERN_ERR "w1_dev_fop_open() inode is NULL\n");
+		return -ENODEV;
+	}
+
+	if (file = NULL) {
+		printk(KERN_ERR "w1_dev_fop_open() file is NULL\n");
+		return -ENODEV;
+	}
+
+	if (inode->i_cdev = NULL) {
+		printk(KERN_ERR "w1_dev_fop_open() inode->i_cdev is NULL\n");
+		return -ENODEV;
+	}
+
+	dev_idx = iminor(inode);
+	if ((dev_idx >= W1_CHAR_DEV_COUNT) || (w1_devs[dev_idx] = NULL)) {
+		printk(KERN_ERR "w1_dev_fop_open() bad dev_idx %d\n", dev_idx);
+		return -ENODEV;
+	}
+
+	printk(KERN_WARNING "w1_raw: open(%d)\n", dev_idx);
+
+	file->private_data = (void *)dev_idx;
+	return 0;
+}
+
+static struct file_operations w1_dev_fileops = {
+	.open = w1_dev_fop_open,
+	.read = w1_dev_fop_read,
+	.write = w1_dev_fop_write,
+};
+
+
+ssize_t w1_master_attribute_show_dev(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct w1_master *md = container_of(dev, struct w1_master, dev);
+	int i;
+
+	for (i = 0; i < W1_CHAR_DEV_COUNT; i++) {
+		if ((w1_devs[i] != NULL) && (w1_devs[i]->master = md))
+			return print_dev_t(buf, w1_devs[i]->dev_id);
+	}
+	return 0;
+}
+
+static DEVICE_ATTR(dev, S_IRUGO, w1_master_attribute_show_dev, NULL);
+
+
+/**
+ * Registers a master with the w1_raw module.
+ * 
+ * @param master The w1_master structure
+ */
+void w1_raw_register(struct w1_master *master)
+{
+	int i;
+	int free_idx = -1;
+	struct w1_raw_dev *raw_dev = NULL;
+
+	down(&w1_devs_lock);
+
+	/* See if this master is already registered */
+	for (i = 0; i < W1_CHAR_DEV_COUNT; i++) {
+		if ((w1_devs[i] != NULL) && (w1_devs[i]->master = master)) {
+			printk(KERN_INFO "w1_raw_register(%d): duplicate\n",
+			       master->id);
+			goto exit_up;
+		}
+	}
+	for (free_idx = 0; free_idx < W1_CHAR_DEV_COUNT; free_idx++) {
+		if (!w1_devs[free_idx])
+			break;
+	}
+	if (free_idx >= W1_CHAR_DEV_COUNT)
+		goto exit_up;
+
+	printk(KERN_WARNING "w1_raw_register() free_idx=%d\n", free_idx);
+
+	if (!(raw_dev = kmalloc(sizeof(struct w1_raw_dev), GFP_KERNEL)))
+		goto exit_up;
+
+	memset(raw_dev, 0, sizeof(struct w1_raw_dev));
+
+	raw_dev->master = master;
+	raw_dev->dev_id = MKDEV(MAJOR(w1_dev), free_idx);
+	init_MUTEX(&raw_dev->raw_lock);
+
+	device_create_file(&master->dev, &dev_attr_dev);
+	cdev_init(&raw_dev->cdev, &w1_dev_fileops);
+	w1_devs[free_idx] = raw_dev;
+
+	cdev_add(&raw_dev->cdev, raw_dev->dev_id, 1);
+
+	printk(KERN_NOTICE "w1_raw_register(%d) dev=%d:%d\n",
+	       master->id, MAJOR(raw_dev->dev_id), MINOR(raw_dev->dev_id));
+
+exit_up:
+	up(&w1_devs_lock);
+}
+
+
+static void w1_raw_free(struct w1_raw_dev *rd)
+{
+	down(&rd->raw_lock);
+
+	device_remove_file(&rd->master->dev, &dev_attr_dev);
+	cdev_del(&rd->cdev);
+
+	if (rd->data != NULL) {
+		kfree(rd->data);
+	}
+	kfree(rd->data);
+}
+
+/**
+ * Unregisters a master with the w1_raw module.
+ * 
+ * @param master The w1_master structure
+ */
+void w1_raw_unregister(struct w1_master *master)
+{
+	int i;
+
+	down(&w1_devs_lock);
+
+	/* Find the master & remove it */
+	for (i = 0; i < W1_CHAR_DEV_COUNT; i++) {
+		if ((w1_devs[i] != NULL) && (w1_devs[i]->master = master)) {
+			struct w1_raw_dev *rd = w1_devs[i];
+			w1_devs[i] = NULL;
+
+			printk(KERN_NOTICE "w1_raw_unregister(%d) dev=%d:%d\n",
+			       master->id,
+			       MAJOR(rd->dev_id), MINOR(rd->dev_id));
+
+			w1_raw_free(rd);
+			break;
+		}
+	}
+
+	up(&w1_devs_lock);
+}
+
+static struct w1_notify_ops raw_notify_ops = {
+	.notify_add	= w1_raw_register,
+	.notify_remove	= w1_raw_unregister,
+};
+
+
+static int w1_raw_init(void)
+{
+	int retval;
+
+	printk(KERN_INFO "w1 raw char driver\n");
+
+	if (major) {
+		w1_dev = MKDEV(major, 0);
+		retval = register_chrdev_region(w1_dev, W1_CHAR_DEV_COUNT,
+						"w1_dev");
+	} else {
+		retval = alloc_chrdev_region(&w1_dev, 0, W1_CHAR_DEV_COUNT,
+					     "w1_dev");
+		major = MAJOR(w1_dev);
+	}
+
+	if (retval >= 0) {
+		w1_add_notification(&raw_notify_ops);
+	}
+
+	return retval;
+}
+
+static void w1_raw_fini(void)
+{
+	int i;
+
+	w1_remove_notification(&raw_notify_ops);
+
+	/* Unregister all devices */
+	down(&w1_devs_lock);
+	for (i = 0; i < W1_CHAR_DEV_COUNT; i++) {
+		if (w1_devs[i] != NULL) {
+			struct w1_raw_dev *rd = w1_devs[i];
+			w1_devs[i] = NULL;
+			w1_raw_free(rd);
+		}
+	}
+	up(&w1_devs_lock);
+
+	unregister_chrdev_region(w1_dev, W1_CHAR_DEV_COUNT);
+}
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Ben Gardner <bgardner@wabtec.com>");
+MODULE_DESCRIPTION("dev interface for w1 bus master");
+
+module_init(w1_raw_init);
+module_exit(w1_raw_fini);
--- linux-2.6.12-rc5-mm2-w1/Documentation/w1/w1.dev	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.12-rc5-mm2/Documentation/w1/w1.dev	2005-06-09 13:56:16.000000000 -0500
@@ -0,0 +1,103 @@
+dev interface for 1-wire (w1) masters
+------------------------------------------------------------------
+The w1_dev module adds a simple script-like character interface for each
+w1 master present in the system (up to 16).
+This is useful to tinker with a w1 slave device without touching kernel code.
+
+It adds a "dev" entry to each w1_bus_masterN entry in sysfs.
+Example:
+/sys/devices/w1_bus_master1/dev
+
+Commands are executed by writing to the character device.
+The result of a command is retained until a new command is executed.
+
+There are 6 basic commands, which are case-insensitive:
+  s = reSet        
+  r = Read bytes   
+  w = Write bytes  
+  t = Touch bit    
+  p = Pause (ms)   
+  v = Verify read  
+
+The output is a copy of the input, except for the T and R commands.
+If a command fails, a '*' is placed in the output buffer at the point of 
+failure and execution terminates.
+
+ 
+Reset "s"
+--------------------------------
+Resets the bus.  
+This fails if there is not a device present on the w1 bus.
+
+
+Read bytes "rN"
+--------------------------------
+Reads N (decimal) bytes from the bus.  
+Output format "rN,XXXX", where XX is N*2 hexidecimal characters.
+
+
+Write bytes "wN,XX"
+--------------------------------
+Writes N (decimal) bytes to the bus.  
+XX is the N*2 hexidecimal characters to write to the bus.
+
+
+Touch bit "tBBB"
+--------------------------------
+Performs a series of touch bit commands.  
+Each B is a 1 or 0. 
+In the output, a 1 may change to a 0 if that is the value read.
+
+
+Pause "pN"
+--------------------------------
+Pauses for N milliseconds.  
+
+
+Verify read "vN,XX"
+--------------------------------
+Reads N (decimal) bytes from the bus and compares against the given bytes.
+XX is the N*2 hexidecimal characters that are expected to be read from the bus.
+
+
+Real-world examples - MAXIM DS2433 (family 23) 512 byte EEPROM
+----------------------------------------------------------------
+Assume $dev is set to the char device node you created for the w1 master.
+Commands are written using echo, and results are read with cat.
+Scan the result string for a '*' to see if the command failed.
+
+This example assumes that the DS2433 is the only device on the w1 bus.
+If there are multiple devices on the w1 bus, you can't use the SkipROM (0xCC)
+command to address the device.  Rather, you'd have to address it using the 
+MatchROM (0x55) command plus the 8 byte ROM address.
+
+Other commands for the DS2433, used in the examples below:
+ 0x0F - write scratch
+ 0xAA - read scratch
+ 0x55 - copy scratch to EEPROM
+ 0xF0 - read EEPROM
+ 
+
+Example 1 - write to EEPROM
+--------------------------------
+To write to the DS2433, you must write to a scratch buffer, verify the
+content of the scratch buffer and then send a copy scratch command.
+See the datasheet for details.
+
+This string will write two bytes (1234) at offset 0026.
+Write: "S W6,CC0F26001234 S W2,CCAA V5,2600071234 S W5,CC55260007 P5 S"
+Read:  "S W6,CC0F26001234 S W2,CCAA V5,2600071234 S W5,CC55260007 P5 S"
+ 
+If no devices were present on the bus, you'd get this output:
+Read:  "S*"
+
+If the verify failed on the second byte, you'd get:
+Read:  "S W6,CC0F26001234 S W2,CCAA V5,2600*"
+
+
+Example 2 - read from EEPROM
+--------------------------------
+This string will read 10 bytes from offset 0x123.
+Write: "S W4,CCF02301 R10 S"
+Read:  "S W4,CCF02301 R10,00112233445566778899 S"
+
