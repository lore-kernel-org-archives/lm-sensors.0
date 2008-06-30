From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Mon, 30 Jun 2008 14:53:43 +0000
Subject: [lm-sensors] PATCH:
Message-Id: <4868F377.20309@hhs.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------020106010302030305060201"
List-Id: <lm-sensors.vger.kernel.org>
References: <46F3DD44.4070307@hhs.nl>
In-Reply-To: <46F3DD44.4070307@hhs.nl>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------020106010302030305060201
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

As promised, this patch adds support for the watchdog part found in _all_ 
supported FSC sensor chips. Once this patch is in we can deprecate the old 
fscpos and fscher drivers.

signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>

Regards,

Hans

--------------020106010302030305060201
Content-Type: text/plain;
 name="fschmd-watchdog.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fschmd-watchdog.patch"

This patch adds support for the watchdog part found in _all_ supported FSC
sensor chips.

signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>

diff -up vanilla-2.6.26-rc8/drivers/hwmon/Kconfig.orig vanilla-2.6.26-rc8/drivers/hwmon/Kconfig
--- vanilla-2.6.26-rc8/drivers/hwmon/Kconfig.orig	2008-06-30 16:37:17.000000000 +0200
+++ vanilla-2.6.26-rc8/drivers/hwmon/Kconfig	2008-06-30 16:38:34.000000000 +0200
@@ -292,10 +292,11 @@ config SENSORS_FSCHMD
 	depends on X86 && I2C && EXPERIMENTAL
 	help
 	  If you say yes here you get support for various Fujitsu Siemens
-	  Computers sensor chips.
+	  Computers sensor chips, including support for the integrated
+	  watchdog.
 
 	  This is a new merged driver for FSC sensor chips which is intended
-	  as a replacment for the fscpos, fscscy and fscher drivers and adds
+	  as a replacement for the fscpos, fscscy and fscher drivers and adds
 	  support for several other FCS sensor chips.
 
 	  This driver can also be built as a module.  If so, the module
diff -up vanilla-2.6.26-rc8/drivers/hwmon/fschmd.c.orig vanilla-2.6.26-rc8/drivers/hwmon/fschmd.c
--- vanilla-2.6.26-rc8/drivers/hwmon/fschmd.c.orig	2008-06-30 16:36:32.000000000 +0200
+++ vanilla-2.6.26-rc8/drivers/hwmon/fschmd.c	2008-06-30 16:51:34.000000000 +0200
@@ -1,6 +1,6 @@
 /* fschmd.c
  *
- * Copyright (C) 2007 Hans de Goede <j.w.r.degoede@hhs.nl>
+ * Copyright (C) 2007,2008 Hans de Goede <j.w.r.degoede@hhs.nl>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -42,13 +42,21 @@
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
 #include <linux/dmi.h>
+#include <linux/fs.h>
+#include <linux/watchdog.h>
+#include <linux/miscdevice.h>
+#include <asm/uaccess.h>
 
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = { 0x73, I2C_CLIENT_END };
 
 /* Insmod parameters */
+static int nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, int, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 I2C_CLIENT_INSMOD_5(fscpos, fscher, fscscy, fschrc, fschmd);
 
+
 /*
  * The FSCHMD registers and other defines
  */
@@ -65,11 +73,19 @@ I2C_CLIENT_INSMOD_5(fscpos, fscher, fscs
 
 #define FSCHMD_CONTROL_ALERT_LED_MASK	0x01
 
-/* watchdog (support to be implemented) */
+/* watchdog */
 #define FSCHMD_REG_WDOG_PRESET		0x28
 #define FSCHMD_REG_WDOG_STATE		0x23
 #define FSCHMD_REG_WDOG_CONTROL		0x21
 
+#define FSCHMD_WDOG_CONTROL_TRIGGER_MASK	0x10
+#define FSCHMD_WDOG_CONTROL_STARTED_MASK	0x10 /* the same as trigger */
+#define FSCHMD_WDOG_CONTROL_STOP_MASK		0x20
+#define FSCHMD_WDOG_CONTROL_RESOLUTION_MASK	0x40
+
+#define FSCHMD_WDOG_STATE_CARDRESET_MASK	0x02
+
+
 /* voltages, weird order is to keep the same order as the old drivers */
 static const u8 FSCHMD_REG_VOLT[3] = { 0x45, 0x42, 0x48 };
 
@@ -167,6 +183,22 @@ static const int FSCHMD_NO_TEMP_SENSORS[
 /* our driver name */
 #define FSCHMD_NAME "fschmd"
 
+/* Watchdog filp->private_data pointer use utility macros. We store our minor
+   (to find our device data) in the private_data pointer, since the
+   private_data pointer can hold atleast an int, we use the 'major" space 
+   of that int to store an per open expect_close flag. */
+#define WATCHDOG_INIT_FILP(filp, minor) \
+	(filp)->private_data = (void *)(long)(minor)
+#define WATCHDOG_GET_MINOR(filp) \
+	MINOR((long)(filp)->private_data)
+#define WATCHDOG_CLEAR_EXPECT_CLOSE(filp) \
+	(filp)->private_data = (void *)(long)WATCHDOG_GET_MINOR(filp)
+#define WATCHDOG_SET_EXPECT_CLOSE(filp) \
+	(filp)->private_data = (void *)(long)MKDEV(1, WATCHDOG_GET_MINOR(filp))
+#define WATCHDOG_GET_EXPECT_CLOSE(filp) \
+	MAJOR((long)(filp)->private_data)
+
+
 /*
  * Functions declarations
  */
@@ -195,12 +227,20 @@ struct fschmd_data {
 	struct i2c_client client;
 	struct device *hwmon_dev;
 	struct mutex update_lock;
+	struct list_head list;
+	struct miscdevice watchdog_miscdev;
 	int kind;
+	int watchdog_open_count;
+	char watchdog_name[10]; /* must be unique to avoid sysfs conflict */
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
 
 	/* register values */
+	u8 revision;            /* chip revision */
 	u8 global_control;	/* global control register */
+	u8 watchdog_control;    /* watchdog control register */
+	u8 watchdog_status;     /* watchdog status register */
+	u8 watchdog_preset;     /* watchdog counter preset on trigger val */
 	u8 volt[3];		/* 12, 5, battery voltage */
 	u8 temp_act[5];		/* temperature */
 	u8 temp_status[5];	/* status of sensor */
@@ -212,11 +252,20 @@ struct fschmd_data {
 };
 
 /* Global variables to hold information read from special DMI tables, which are
-   available on FSC machines with an fscher or later chip. */
+   available on FSC machines with an fscher or later chip. There is no need to
+   protect these with a lock as they are only modified from our attach function
+   which always gets called with the i2c-core lock held and never accessed
+   before the attach function is done with them. */
 static int dmi_mult[3] = { 490, 200, 100 };
 static int dmi_offset[3] = { 0, 0, 0 };
 static int dmi_vref = -1;
 
+/* Somewhat ugly :( global data pointer list with all fschmd devices, so that
+   we can find our device data as when using misc_register there is no other
+   method to get to ones device data from the open fop. */
+static LIST_HEAD(watchdog_data_list);
+static DEFINE_MUTEX(watchdog_data_mutex);
+
 
 /*
  * Sysfs attr show / store functions
@@ -535,7 +584,286 @@ static struct sensor_device_attribute fs
 
 
 /*
- * Real code
+ * Watchdog routines
+ */
+static struct fschmd_data *watchdog_get_data_unlocked(int minor)
+{
+	struct fschmd_data *data = NULL, *pos;
+
+	list_for_each_entry(pos, &watchdog_data_list, list) {
+		if (pos->watchdog_miscdev.minor == minor) {
+			data = pos;
+			break;
+		}
+	}
+
+	return data;
+}
+
+static int watchdog_set_timeout_unlocked(struct fschmd_data *data, int timeout)
+{
+	int resolution;
+	int kind = data->kind + 1; /* 0-x array index -> 1-x module param */
+
+	/* 2 second or 60 second resolution? */
+	if (timeout <= 510 || kind == fscpos || kind == fscscy) {
+		data->watchdog_control &= ~FSCHMD_WDOG_CONTROL_RESOLUTION_MASK;
+		resolution = 2;
+	} else {
+		data->watchdog_control |= FSCHMD_WDOG_CONTROL_RESOLUTION_MASK;
+		resolution = 60;
+	}
+
+	if (timeout > (resolution * 255))
+		data->watchdog_preset = 255;
+	else		
+		data->watchdog_preset = (timeout + (resolution - 1)) /
+					resolution;
+
+	/* Write new timeout value */
+	i2c_smbus_write_byte_data(&data->client, FSCHMD_REG_WDOG_PRESET,
+		data->watchdog_preset);
+	/* Write new control register, do not trigger! */
+	i2c_smbus_write_byte_data(&data->client, FSCHMD_REG_WDOG_CONTROL,
+		data->watchdog_control & ~FSCHMD_WDOG_CONTROL_TRIGGER_MASK);
+
+	return data->watchdog_preset * resolution;
+}
+
+static int watchdog_get_timeout(struct fschmd_data *data)
+{
+	int timeout;
+
+	mutex_lock(&data->update_lock);
+	if (data->watchdog_control & FSCHMD_WDOG_CONTROL_RESOLUTION_MASK)
+		timeout = data->watchdog_preset * 60;
+	else
+		timeout = data->watchdog_preset * 2;
+	mutex_unlock(&data->update_lock);	
+
+	return timeout;	
+}
+
+static void watchdog_trigger(struct fschmd_data *data)
+{
+	mutex_lock(&data->update_lock);
+	data->watchdog_control |= FSCHMD_WDOG_CONTROL_TRIGGER_MASK;
+	i2c_smbus_write_byte_data(&data->client, FSCHMD_REG_WDOG_CONTROL,
+					data->watchdog_control);
+	mutex_unlock(&data->update_lock);	
+}
+
+static void watchdog_stop(struct fschmd_data *data)
+{
+	mutex_lock(&data->update_lock);
+	data->watchdog_control &= ~FSCHMD_WDOG_CONTROL_STARTED_MASK;
+	/* Don't store the stop flag in our watchdog control register copy, as
+	   its a write only bit (read always returns 0) */
+	i2c_smbus_write_byte_data(&data->client, FSCHMD_REG_WDOG_CONTROL,
+		data->watchdog_control | FSCHMD_WDOG_CONTROL_STOP_MASK);
+	mutex_unlock(&data->update_lock);
+}
+
+
+static int watchdog_open(struct inode *inode, struct file *filp)
+{
+	int ret;
+	struct fschmd_data *data;
+
+	mutex_lock(&watchdog_data_mutex);
+	data = watchdog_get_data_unlocked(iminor(inode));
+	/* Check our i2c client didn't get removed from underneath us */
+	if (!data) {
+		ret = -ENODEV;
+		goto unlock_mutex;
+	}
+
+	/* Set a default timeout if necessary */
+	mutex_lock(&data->update_lock);
+	if (data->watchdog_preset == 0)
+		watchdog_set_timeout_unlocked(data, 60);
+	mutex_unlock(&data->update_lock);
+
+	/* Start the watchdog */
+	watchdog_trigger(data);
+
+	data->watchdog_open_count++;
+	WATCHDOG_INIT_FILP(filp, data->watchdog_miscdev.minor);
+
+	ret = nonseekable_open(inode, filp);
+
+unlock_mutex:
+	mutex_unlock(&watchdog_data_mutex);
+
+	return ret;
+}
+
+static int watchdog_release(struct inode *inode, struct file *filp)
+{
+	struct fschmd_data *data;
+
+	mutex_lock(&watchdog_data_mutex);
+	data = watchdog_get_data_unlocked(WATCHDOG_GET_MINOR(filp));
+	/* Check our i2c client didn't get removed from underneath us */
+	if (!data)
+		goto unlock_mutex;
+
+	data->watchdog_open_count--;
+
+	if (WATCHDOG_GET_EXPECT_CLOSE(filp)) {
+		if (data->watchdog_open_count)
+			printk(KERN_WARNING FSCHMD_NAME
+				": watchdog still opened %d time(s), "
+				"not stopping\n", data->watchdog_open_count);
+		else
+			watchdog_stop(data);
+	} else {
+		watchdog_trigger(data);
+		printk(KERN_CRIT FSCHMD_NAME
+			": unexpected close, not stopping watchdog!\n");
+	}
+
+unlock_mutex:
+	mutex_unlock(&watchdog_data_mutex);
+
+	return 0;
+}
+
+static ssize_t watchdog_write(struct file *filp, const char __user *buf,
+	size_t count, loff_t *offset)
+{
+	ssize_t ret = count;
+	struct fschmd_data *data;
+
+	mutex_lock(&watchdog_data_mutex);
+	data = watchdog_get_data_unlocked(WATCHDOG_GET_MINOR(filp));
+	/* Check our i2c client didn't get removed from underneath us */
+	if (!data) {
+		ret = -ENODEV;
+		goto unlock_mutex;
+	}
+
+	if (count) {
+		if (!nowayout) {
+			size_t i;
+
+			/* Clear it in case it was set with a previous write */
+			WATCHDOG_CLEAR_EXPECT_CLOSE(filp);
+
+			for (i = 0; i != count; i++) {
+				char c;
+				if (get_user(c, buf + i)) {
+					ret = -EFAULT;
+					goto unlock_mutex;
+				}
+				if (c == 'V')
+					WATCHDOG_SET_EXPECT_CLOSE(filp);
+			}
+		}
+		watchdog_trigger(data);
+	}
+
+unlock_mutex:
+	mutex_unlock(&watchdog_data_mutex);
+
+	return ret;
+}
+
+static int watchdog_ioctl(struct inode *inode, struct file *filp,
+	unsigned int cmd, unsigned long arg)
+{
+	static struct watchdog_info ident = {
+		.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT |
+				WDIOF_CARDRESET,
+		.identity = "FSC watchdog"
+	};
+	int i, ret = 0;
+	struct fschmd_data *data;
+
+	mutex_lock(&watchdog_data_mutex);
+	data = watchdog_get_data_unlocked(WATCHDOG_GET_MINOR(filp));
+	/* Check our i2c client didn't get removed from underneath us */
+	if (!data) {
+		ret = -ENODEV;
+		goto unlock_mutex;
+	}
+
+	switch (cmd) {
+	case WDIOC_GETSUPPORT:
+		ident.firmware_version = data->revision;
+		if (!nowayout)
+			ident.options |= WDIOF_MAGICCLOSE;
+		if (copy_to_user((void __user *)arg, &ident, sizeof(ident)))
+			ret = -EFAULT;
+		break;
+
+	case WDIOC_GETSTATUS:
+		ret = put_user(0, (int *)arg);
+		break;
+
+	case WDIOC_GETBOOTSTATUS:
+		if (data->watchdog_status & FSCHMD_WDOG_STATE_CARDRESET_MASK)
+			ret = put_user(WDIOF_CARDRESET, (int *)arg);
+		else
+			ret = put_user(0, (int *)arg);
+		break;
+
+	case WDIOC_KEEPALIVE:
+		watchdog_trigger(data);
+		break;
+
+	case WDIOC_GETTIMEOUT:
+		i = watchdog_get_timeout(data);
+		ret = put_user(i, (int *)arg);
+		break;
+
+	case WDIOC_SETTIMEOUT:
+		if (get_user(i, (int *)arg)) {
+			ret = -EFAULT;
+			break;
+		}
+		mutex_lock(&data->update_lock);
+		i = watchdog_set_timeout_unlocked(data, i);
+		mutex_unlock(&data->update_lock);
+		ret = put_user(i, (int *)arg);
+		break;
+
+	case WDIOC_SETOPTIONS:
+		if (get_user(i, (int *)arg)) {
+			ret = -EFAULT;
+			break;
+		}
+
+		if (i & WDIOS_DISABLECARD)
+			watchdog_stop(data);
+		else if (i & WDIOS_ENABLECARD)
+			watchdog_trigger(data);
+		else
+			ret = -EINVAL;
+
+		break;
+	default:
+		ret = -ENOTTY;
+	}
+
+unlock_mutex:
+	mutex_unlock(&watchdog_data_mutex);
+
+	return ret;
+}
+
+static struct file_operations watchdog_fops = {
+	.owner = THIS_MODULE,
+	.llseek = no_llseek,
+	.open = watchdog_open,
+	.release = watchdog_release,
+	.write = watchdog_write,
+	.ioctl = watchdog_ioctl,
+};
+
+
+/*
+ * Detect, register, unregister and update device functions
  */
 
 /* DMI decode routine to read voltage scaling factors from special DMI tables,
@@ -604,11 +932,11 @@ static int fschmd_detect(struct i2c_adap
 {
 	struct i2c_client *client;
 	struct fschmd_data *data;
-	u8 revision;
 	const char * const names[5] = { "Poseidon", "Hermes", "Scylla",
 					"Heracles", "Heimdall" };
 	const char * const client_names[5] = { "fscpos", "fscher", "fscscy",
 						"fschrc", "fschmd" };
+	const int watchdog_minors[] = { 130, 212, 213, 214, 215 };
 	int i, err = 0;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
@@ -626,6 +954,7 @@ static int fschmd_detect(struct i2c_adap
 	client->adapter = adapter;
 	client->driver = &fschmd_driver;
 	mutex_init(&data->update_lock);
+	INIT_LIST_HEAD(&data->list);
 
 	/* Detect & Identify the chip */
 	if (kind <= 0) {
@@ -662,7 +991,7 @@ static int fschmd_detect(struct i2c_adap
 	}
 
 	/* Read the special DMI table for fscher and newer chips */
-	if (kind == fscher || kind >= fschrc) {
+	if ((kind == fscher || kind >= fschrc) && dmi_vref == -1){
 		dmi_walk(fschmd_dmi_decode);
 		if (dmi_vref == -1) {
 			printk(KERN_WARNING FSCHMD_NAME
@@ -672,6 +1001,17 @@ static int fschmd_detect(struct i2c_adap
 		}
 	}
 
+	/* Read in some never changing registers */
+	data->revision = i2c_smbus_read_byte_data(client, FSCHMD_REG_REVISION);
+	data->global_control = i2c_smbus_read_byte_data(client,
+					FSCHMD_REG_CONTROL);
+	data->watchdog_control = i2c_smbus_read_byte_data(client,
+					FSCHMD_REG_WDOG_CONTROL);
+	data->watchdog_status = i2c_smbus_read_byte_data(client,
+					FSCHMD_REG_WDOG_STATE);
+	data->watchdog_preset = i2c_smbus_read_byte_data(client,
+					FSCHMD_REG_WDOG_PRESET);
+
 	/* i2c kind goes from 1-5, we want from 0-4 to address arrays */
 	data->kind = kind - 1;
 	strlcpy(client->name, client_names[data->kind], I2C_NAME_SIZE);
@@ -719,9 +1059,36 @@ static int fschmd_detect(struct i2c_adap
 		goto exit_detach;
 	}
 
-	revision = i2c_smbus_read_byte_data(client, FSCHMD_REG_REVISION);
+	/* Register our watchdog part */
+	for (i = 0; i < ARRAY_SIZE(watchdog_minors); i++) {
+		snprintf(data->watchdog_name, sizeof(data->watchdog_name),
+			"watchdog%c", (i == 0) ? '\0' : ('0' + i));
+		data->watchdog_miscdev.name = data->watchdog_name;
+		data->watchdog_miscdev.fops = &watchdog_fops;
+		data->watchdog_miscdev.minor = watchdog_minors[i];
+		err = misc_register(&data->watchdog_miscdev);
+		if (err == -EBUSY)
+			continue;
+		if (err)
+			goto exit_detach;
+
+		mutex_lock(&watchdog_data_mutex);
+		list_add(&data->list, &watchdog_data_list);
+		mutex_unlock(&watchdog_data_mutex);
+		printk(KERN_INFO FSCHMD_NAME
+			": Registered watchdog chardev major 10, minor: %d\n",
+			watchdog_minors[i]);
+		break;
+	}
+	if (i == ARRAY_SIZE(watchdog_minors)) {
+		data->watchdog_miscdev.minor = 0;
+		printk(KERN_WARNING FSCHMD_NAME
+			": Couldn't register watchdog chardev "
+			"(due to no free minor)\n");
+	}
+
 	printk(KERN_INFO FSCHMD_NAME ": Detected FSC %s chip, revision: %d\n",
-		names[data->kind], (int) revision);
+		names[data->kind], (int) data->revision);
 
 	return 0;
 
@@ -746,6 +1113,20 @@ static int fschmd_detach_client(struct i
 	struct fschmd_data *data = i2c_get_clientdata(client);
 	int i, err;
 
+	/* Unregister the watchdog (if registered) */
+	if (data->watchdog_miscdev.minor) {
+		mutex_lock(&watchdog_data_mutex);
+		if (data->watchdog_open_count) {
+			printk(KERN_WARNING FSCHMD_NAME
+				": i2c client detached with watchdog open! "
+				"Stopping watchdog.\n");
+			watchdog_stop(data);
+		}
+		misc_deregister(&data->watchdog_miscdev);
+		list_del(&data->list);
+		mutex_unlock(&watchdog_data_mutex);
+	}
+
 	/* Check if registered in case we're called from fschmd_detect
 	   to cleanup after an error */
 	if (data->hwmon_dev)
@@ -825,17 +1206,6 @@ static struct fschmd_data *fschmd_update
 			data->volt[i] = i2c_smbus_read_byte_data(client,
 						FSCHMD_REG_VOLT[i]);
 
-		data->global_control = i2c_smbus_read_byte_data(client,
-						FSCHMD_REG_CONTROL);
-
-		/* To be implemented in the future
-		data->watchdog[0] = i2c_smbus_read_byte_data(client,
-						FSCHMD_REG_WDOG_PRESET);
-		data->watchdog[1] = i2c_smbus_read_byte_data(client,
-						FSCHMD_REG_WDOG_STATE);
-		data->watchdog[2] = i2c_smbus_read_byte_data(client,
-						FSCHMD_REG_WDOG_CONTROL); */
-
 		data->last_updated = jiffies;
 		data->valid = 1;
 	}
@@ -859,6 +1229,7 @@ MODULE_AUTHOR("Hans de Goede <j.w.r.dego
 MODULE_DESCRIPTION("FSC Poseidon, Hermes, Scylla, Heracles and "
 			"Heimdall driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_MISCDEV(WATCHDOG_GET_MINOR);
 
 module_init(fschmd_init);
 module_exit(fschmd_exit);

--------------020106010302030305060201
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------020106010302030305060201--

