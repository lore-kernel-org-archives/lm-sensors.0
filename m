From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 11 Nov 2008 09:15:30 +0000
Subject: [lm-sensors] PATCH: add watchdog support to the fschmd driver [2/2]
Message-Id: <49194D32.9040103@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------030905000007000500060407"
List-Id: <lm-sensors.vger.kernel.org>
References: <49194CAD.6000408@redhat.com>
In-Reply-To: <49194CAD.6000408@redhat.com>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------030905000007000500060407
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jean (and all),

This patch adds support for the watchdog part found in _all_ supported FSC
sensor chips.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


--------------030905000007000500060407
Content-Type: text/plain;
 name="hwmon-fschmd-watchdog-v3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hwmon-fschmd-watchdog-v3.patch"

This patch adds support for the watchdog part found in _all_ supported FSC
sensor chips.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
diff -up linux-2.6.28-rc4/drivers/hwmon/Kconfig.wtd linux-2.6.28-rc4/drivers/hwmon/Kconfig
--- linux-2.6.28-rc4/drivers/hwmon/Kconfig.wtd	2008-11-10 11:13:01.000000000 +0100
+++ linux-2.6.28-rc4/drivers/hwmon/Kconfig	2008-11-10 11:27:10.000000000 +0100
@@ -318,10 +318,11 @@ config SENSORS_FSCHMD
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
diff -up linux-2.6.28-rc4/drivers/hwmon/fschmd.c.wtd linux-2.6.28-rc4/drivers/hwmon/fschmd.c
--- linux-2.6.28-rc4/drivers/hwmon/fschmd.c.wtd	2008-11-10 12:18:29.000000000 +0100
+++ linux-2.6.28-rc4/drivers/hwmon/fschmd.c	2008-11-10 12:22:03.000000000 +0100
@@ -42,11 +42,20 @@
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
 #include <linux/dmi.h>
+#include <linux/fs.h>
+#include <linux/watchdog.h>
+#include <linux/miscdevice.h>
+#include <linux/uaccess.h>
+#include <linux/kref.h>
 
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = { 0x73, I2C_CLIENT_END };
 
 /* Insmod parameters */
+static int nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, int, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
+	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 I2C_CLIENT_INSMOD_5(fscpos, fscher, fscscy, fschrc, fschmd);
 
 /*
@@ -65,11 +74,18 @@ I2C_CLIENT_INSMOD_5(fscpos, fscher, fscs
 
 #define FSCHMD_CONTROL_ALERT_LED	0x01
 
-/* watchdog (support to be implemented) */
+/* watchdog */
 #define FSCHMD_REG_WDOG_PRESET		0x28
 #define FSCHMD_REG_WDOG_STATE		0x23
 #define FSCHMD_REG_WDOG_CONTROL		0x21
 
+#define FSCHMD_WDOG_CONTROL_TRIGGER	0x10
+#define FSCHMD_WDOG_CONTROL_STARTED	0x10 /* the same as trigger */
+#define FSCHMD_WDOG_CONTROL_STOP	0x20
+#define FSCHMD_WDOG_CONTROL_RESOLUTION	0x40
+
+#define FSCHMD_WDOG_STATE_CARDRESET	0x02
+
 /* voltages, weird order is to keep the same order as the old drivers */
 static const u8 FSCHMD_REG_VOLT[3] = { 0x45, 0x42, 0x48 };
 
@@ -206,14 +222,26 @@ static struct i2c_driver fschmd_driver =
  */
 
 struct fschmd_data {
+	struct i2c_client *client;
 	struct device *hwmon_dev;
 	struct mutex update_lock;
+	struct mutex watchdog_lock;
+	struct list_head list; /* member of the watchdog_data_list */
+	struct kref kref;
+	struct miscdevice watchdog_miscdev;
 	int kind;
+	int watchdog_open_count;
+	char watchdog_expect_close;
+	char watchdog_name[10]; /* must be unique to avoid sysfs conflict */
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
 
 	/* register values */
+	u8 revision;            /* chip revision */
 	u8 global_control;	/* global control register */
+	u8 watchdog_control;    /* watchdog control register */
+	u8 watchdog_state;      /* watchdog status register */
+	u8 watchdog_preset;     /* watchdog counter preset on trigger val */
 	u8 volt[3];		/* 12, 5, battery voltage */
 	u8 temp_act[5];		/* temperature */
 	u8 temp_status[5];	/* status of sensor */
@@ -225,11 +253,28 @@ struct fschmd_data {
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
+/* Note this lock not only protect list access, but also data.kref access */
+static DEFINE_MUTEX(watchdog_data_mutex);
+
+/* Release our data struct when we're detached from the i2c client *and* all
+   references to our watchdog device are released */
+static void fschmd_release_resources(struct kref *ref)
+{
+	struct fschmd_data *data = container_of(ref, struct fschmd_data, kref);
+	kfree(data);
+}
 
 /*
  * Sysfs attr show / store functions
@@ -548,7 +593,271 @@ static struct sensor_device_attribute fs
 
 
 /*
- * Real code
+ * Watchdog routines
+ */
+
+static int watchdog_set_timeout(struct fschmd_data *data, int timeout)
+{
+	int ret, resolution;
+	int kind = data->kind + 1; /* 0-x array index -> 1-x module param */
+
+	/* 2 second or 60 second resolution? */
+	if (timeout <= 510 || kind == fscpos || kind == fscscy)
+		resolution = 2;
+	else
+		resolution = 60;
+
+	if (timeout < resolution || timeout > (resolution * 255))
+		return -EINVAL;
+
+	mutex_lock(&data->watchdog_lock);
+	if (!data->client) {
+		ret = -ENODEV;
+		goto leave;
+	}
+
+	if (resolution == 2)
+		data->watchdog_control &= ~FSCHMD_WDOG_CONTROL_RESOLUTION;
+	else
+		data->watchdog_control |= FSCHMD_WDOG_CONTROL_RESOLUTION;
+
+	data->watchdog_preset = DIV_ROUND_UP(timeout, resolution);
+
+	/* Write new timeout value */
+	i2c_smbus_write_byte_data(data->client, FSCHMD_REG_WDOG_PRESET,
+		data->watchdog_preset);
+	/* Write new control register, do not trigger! */
+	i2c_smbus_write_byte_data(data->client, FSCHMD_REG_WDOG_CONTROL,
+		data->watchdog_control & ~FSCHMD_WDOG_CONTROL_TRIGGER);
+
+	ret = data->watchdog_preset * resolution;
+
+leave:
+	mutex_unlock(&data->watchdog_lock);
+	return ret;
+}
+
+static int watchdog_get_timeout(struct fschmd_data *data)
+{
+	int timeout;
+
+	mutex_lock(&data->watchdog_lock);
+	if (data->watchdog_control & FSCHMD_WDOG_CONTROL_RESOLUTION)
+		timeout = data->watchdog_preset * 60;
+	else
+		timeout = data->watchdog_preset * 2;
+	mutex_unlock(&data->watchdog_lock);
+
+	return timeout;
+}
+
+static int watchdog_trigger(struct fschmd_data *data)
+{
+	int ret = 0;
+
+	mutex_lock(&data->watchdog_lock);
+	if (!data->client) {
+		ret = -ENODEV;
+		goto leave;
+	}
+
+	data->watchdog_control |= FSCHMD_WDOG_CONTROL_TRIGGER;
+	i2c_smbus_write_byte_data(data->client, FSCHMD_REG_WDOG_CONTROL,
+					data->watchdog_control);
+leave:
+	mutex_unlock(&data->watchdog_lock);
+	return ret;
+}
+
+static int watchdog_stop(struct fschmd_data *data)
+{
+	int ret = 0;
+
+	mutex_lock(&data->watchdog_lock);
+	if (!data->client) {
+		ret = -ENODEV;
+		goto leave;
+	}
+
+	data->watchdog_control &= ~FSCHMD_WDOG_CONTROL_STARTED;
+	/* Don't store the stop flag in our watchdog control register copy, as
+	   its a write only bit (read always returns 0) */
+	i2c_smbus_write_byte_data(data->client, FSCHMD_REG_WDOG_CONTROL,
+		data->watchdog_control | FSCHMD_WDOG_CONTROL_STOP);
+leave:
+	mutex_unlock(&data->watchdog_lock);
+	return ret;
+}
+
+static int watchdog_open(struct inode *inode, struct file *filp)
+{
+	int ret = 0;
+	struct fschmd_data *pos, *data = NULL;
+
+	/* We get called from drivers/char/misc.c with misc_mtx hold, and we
+	   call misc_register() from fschmd_probe() with watchdog_data_mutex
+	   hold, as misc_register() takes the misc_mtx lock, this is a possible
+	   deadlock, so we use mutex_trylock here. */
+	if (!mutex_trylock(&watchdog_data_mutex))
+		return -ERESTARTSYS;
+	list_for_each_entry(pos, &watchdog_data_list, list) {
+		if (pos->watchdog_miscdev.minor == iminor(inode)) {
+			data = pos;
+			break;
+		}
+	}
+	/* Note we can never not have found data, so we don't check for this */
+	kref_get(&data->kref);
+	mutex_unlock(&watchdog_data_mutex);
+
+	mutex_lock(&data->watchdog_lock);
+	if (data->watchdog_open_count)
+		ret = -EBUSY;
+	data->watchdog_open_count++;
+	mutex_unlock(&data->watchdog_lock);
+	if (ret)
+		return ret;
+
+	/* Start the watchdog */
+	watchdog_trigger(data);
+	filp->private_data = data;
+
+	return nonseekable_open(inode, filp);
+}
+
+static int watchdog_release(struct inode *inode, struct file *filp)
+{
+	struct fschmd_data *data = filp->private_data;
+
+	if (data->watchdog_expect_close) {
+		watchdog_stop(data);
+		data->watchdog_expect_close = 0;
+	} else {
+		watchdog_trigger(data);
+		dev_crit(&data->client->dev,
+			"unexpected close, not stopping watchdog!\n");
+	}
+
+	data->watchdog_open_count--;
+
+	mutex_lock(&watchdog_data_mutex);
+	kref_put(&data->kref, fschmd_release_resources);
+	mutex_unlock(&watchdog_data_mutex);
+
+	return 0;
+}
+
+static ssize_t watchdog_write(struct file *filp, const char __user *buf,
+	size_t count, loff_t *offset)
+{
+	size_t ret;
+	struct fschmd_data *data = filp->private_data;
+
+	if (count) {
+		if (!nowayout) {
+			size_t i;
+
+			/* Clear it in case it was set with a previous write */
+			data->watchdog_expect_close = 0;
+
+			for (i = 0; i != count; i++) {
+				char c;
+				if (get_user(c, buf + i))
+					return -EFAULT;
+				if (c == 'V')
+					data->watchdog_expect_close = 1;
+			}
+		}
+		ret = watchdog_trigger(data);
+		if (ret < 0)
+			return ret;
+	}
+	return count;
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
+	struct fschmd_data *data = filp->private_data;
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
+		ret = put_user(0, (int __user *)arg);
+		break;
+
+	case WDIOC_GETBOOTSTATUS:
+		if (data->watchdog_state & FSCHMD_WDOG_STATE_CARDRESET)
+			ret = put_user(WDIOF_CARDRESET, (int __user *)arg);
+		else
+			ret = put_user(0, (int __user *)arg);
+		break;
+
+	case WDIOC_KEEPALIVE:
+		ret = watchdog_trigger(data);
+		break;
+
+	case WDIOC_GETTIMEOUT:
+		i = watchdog_get_timeout(data);
+		ret = put_user(i, (int __user *)arg);
+		break;
+
+	case WDIOC_SETTIMEOUT:
+		if (get_user(i, (int __user *)arg)) {
+			ret = -EFAULT;
+			break;
+		}
+		ret = watchdog_set_timeout(data, i);
+		if (ret > 0)
+			ret = put_user(i, (int __user *)arg);
+		break;
+
+	case WDIOC_SETOPTIONS:
+		if (get_user(i, (int __user *)arg)) {
+			ret = -EFAULT;
+			break;
+		}
+
+		if (i & WDIOS_DISABLECARD)
+			ret = watchdog_stop(data);
+		else if (i & WDIOS_ENABLECARD)
+			ret = watchdog_trigger(data);
+		else
+			ret = -EINVAL;
+
+		break;
+	default:
+		ret = -ENOTTY;
+	}
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
@@ -658,9 +967,9 @@ static int fschmd_probe(struct i2c_clien
 			const struct i2c_device_id *id)
 {
 	struct fschmd_data *data;
-	u8 revision;
 	const char * const names[5] = { "Poseidon", "Hermes", "Scylla",
 					"Heracles", "Heimdall" };
+	const int watchdog_minors[] = { WATCHDOG_MINOR, 212, 213, 214, 215 };
 	int i, err;
 	enum chips kind = id->driver_data;
 
@@ -670,6 +979,13 @@ static int fschmd_probe(struct i2c_clien
 
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
+	mutex_init(&data->watchdog_lock);
+	INIT_LIST_HEAD(&data->list);
+	kref_init(&data->kref);
+	/* Store client pointer in our data struct for watchdog usage
+	   (where the client is found through a data ptr instead of the
+	   otherway around) */
+	data->client = client;
 
 	if (kind == fscpos) {
 		/* The Poseidon has hardwired temp limits, fill these
@@ -690,6 +1006,17 @@ static int fschmd_probe(struct i2c_clien
 		}
 	}
 
+	/* Read in some never changing registers */
+	data->revision = i2c_smbus_read_byte_data(client, FSCHMD_REG_REVISION);
+	data->global_control = i2c_smbus_read_byte_data(client,
+					FSCHMD_REG_CONTROL);
+	data->watchdog_control = i2c_smbus_read_byte_data(client,
+					FSCHMD_REG_WDOG_CONTROL);
+	data->watchdog_state = i2c_smbus_read_byte_data(client,
+					FSCHMD_REG_WDOG_STATE);
+	data->watchdog_preset = i2c_smbus_read_byte_data(client,
+					FSCHMD_REG_WDOG_PRESET);
+
 	/* i2c kind goes from 1-5, we want from 0-4 to address arrays */
 	data->kind = kind - 1;
 
@@ -732,9 +1059,43 @@ static int fschmd_probe(struct i2c_clien
 		goto exit_detach;
 	}
 
-	revision = i2c_smbus_read_byte_data(client, FSCHMD_REG_REVISION);
+	/* We take the data_mutex lock early so that watchdog_open() cannot
+	   run when misc_register() has completed, but we've not yet added
+	   our data to the watchdog_data_list (and set the default timeout) */
+	mutex_lock(&watchdog_data_mutex);
+	for (i = 0; i < ARRAY_SIZE(watchdog_minors); i++) {
+		/* Register our watchdog part */
+		snprintf(data->watchdog_name, sizeof(data->watchdog_name),
+			"watchdog%c", (i == 0) ? '\0' : ('0' + i));
+		data->watchdog_miscdev.name = data->watchdog_name;
+		data->watchdog_miscdev.fops = &watchdog_fops;
+		data->watchdog_miscdev.minor = watchdog_minors[i];
+		err = misc_register(&data->watchdog_miscdev);
+		if (err == -EBUSY)
+			continue;
+		if (err) {
+			data->watchdog_miscdev.minor = 0;
+			dev_err(&client->dev,
+				"Registering watchdog chardev: %d\n", err);
+			break;
+		}
+
+		list_add(&data->list, &watchdog_data_list);
+		watchdog_set_timeout(data, 60);
+		dev_info(&client->dev,
+			"Registered watchdog chardev major 10, minor: %d\n",
+			watchdog_minors[i]);
+		break;
+	}
+	if (i == ARRAY_SIZE(watchdog_minors)) {
+		data->watchdog_miscdev.minor = 0;
+		dev_warn(&client->dev, "Couldn't register watchdog chardev "
+			"(due to no free minor)\n");
+	}
+	mutex_unlock(&watchdog_data_mutex);
+
 	dev_info(&client->dev, "Detected FSC %s chip, revision: %d\n",
-		names[data->kind], (int) revision);
+		names[data->kind], (int) data->revision);
 
 	return 0;
 
@@ -748,6 +1109,24 @@ static int fschmd_remove(struct i2c_clie
 	struct fschmd_data *data = i2c_get_clientdata(client);
 	int i;
 
+	/* Unregister the watchdog (if registered) */
+	if (data->watchdog_miscdev.minor) {
+		misc_deregister(&data->watchdog_miscdev);
+		if (data->watchdog_open_count) {
+			dev_warn(&client->dev,
+				"i2c client detached with watchdog open! "
+				"Stopping watchdog.\n");
+			watchdog_stop(data);
+		}
+		mutex_lock(&watchdog_data_mutex);
+		list_del(&data->list);
+		mutex_unlock(&watchdog_data_mutex);
+		/* Tell the watchdog code the client is gone */
+		mutex_lock(&data->watchdog_lock);
+		data->client = NULL;
+		mutex_unlock(&data->watchdog_lock);
+	}
+
 	/* Check if registered in case we're called from fschmd_detect
 	   to cleanup after an error */
 	if (data->hwmon_dev)
@@ -762,7 +1141,10 @@ static int fschmd_remove(struct i2c_clie
 		device_remove_file(&client->dev,
 					&fschmd_fan_attr[i].dev_attr);
 
-	kfree(data);
+	mutex_lock(&watchdog_data_mutex);
+	kref_put(&data->kref, fschmd_release_resources);
+	mutex_unlock(&watchdog_data_mutex);
+
 	return 0;
 }
 
@@ -824,17 +1206,6 @@ static struct fschmd_data *fschmd_update
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

--------------030905000007000500060407
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------030905000007000500060407--
