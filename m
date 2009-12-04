From: Sven Anders <anders@anduras.de>
Date: Fri, 04 Dec 2009 11:32:42 +0000
Subject: [lm-sensors] [PATCH] w83793 watchdog support.
Message-Id: <4B18F35A.5060808@anduras.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1959474436223071931=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a cryptographically signed message in MIME format.

--===============1959474436223071931==
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms070000060102050805090503"

This is a cryptographically signed message in MIME format.

--------------ms070000060102050805090503
Content-Type: multipart/mixed;
 boundary="------------040806020403010408080508"

This is a multi-part message in MIME format.
--------------040806020403010408080508
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hello!

I implemented watchdog support for the Winbond 83793 chipset.
I'll attached the patch.

Any comments welcome!

Regards
 Sven Anders

-- 
 Sven Anders <anders@anduras.de>                 () Ascii Ribbon Campaign
                                                 /\ Support plain text e-mail
 ANDURAS service solutions AG
 Innstrasse 71 - 94036 Passau - Germany
 Web: www.anduras.de - Tel: +49 (0)851-4 90 50-0 - Fax: +49 (0)851-4 90 50-55

Those who would give up essential Liberty, to purchase a little
temporary Safety, deserve neither Liberty nor Safety.
  - Benjamin Franklin

--------------040806020403010408080508
Content-Type: text/x-patch;
 name="w83793_wdt.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="w83793_wdt.patch"

This patch add watchdog functionality to the Winbond 83793 chipset driver.

Signed-off-by: Sven Anders <anders@anduras.de

--- linux-2.6.29.6/drivers/hwmon/w83793.c	2009-07-03 01:41:20.000000000 +0200
+++ linux-2.6.29.6.watchdog/drivers/hwmon/w83793.c	2009-12-04 12:10:55.000000000 +0100
@@ -3,6 +3,10 @@
     Copyright (C) 2006 Winbond Electronics Corp.
                   Yuan Mu
                   Rudolf Marek <r.marek@assembler.cz>
+    Copyright (C) 2009 Sven Anders <anders@anduras.de>, ANDURAS AG.
+		  Watchdog driver part
+		  (Based partially on fschmd driver,
+		   Copyright 2007-2008 by Hans de Goede)
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
@@ -35,10 +39,20 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
+#include <linux/fs.h>
+#include <linux/watchdog.h>
+#include <linux/miscdevice.h>
+#include <linux/uaccess.h>
+#include <linux/kref.h>
+#include <linux/notifier.h>
+#include <linux/reboot.h>
+
+/* Default values */
+#define WATCHDOG_TIMEOUT 1	/* 1 minute default timeout */
 
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, 0x2f,
-						I2C_CLIENT_END };
+					     I2C_CLIENT_END };
 
 /* Insmod parameters */
 I2C_CLIENT_INSMOD_1(w83793);
@@ -52,6 +66,18 @@ static int reset;
 module_param(reset, bool, 0);
 MODULE_PARM_DESC(reset, "Set to 1 to reset chip, not recommended");
 
+static int timeout = WATCHDOG_TIMEOUT;	/* in minutes */
+module_param(timeout, int, 0);
+MODULE_PARM_DESC(timeout,
+	"Watchdog timeout in minutes. 1<= timeout <=255 (default="
+				__MODULE_STRING(WATCHDOG_TIMEOUT) ")");
+
+static int nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, int, 0);
+MODULE_PARM_DESC(nowayout,
+	"Watchdog cannot be stopped once started (default="
+				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
 /*
    Address 0x00, 0x0d, 0x0e, 0x0f in all three banks are reserved
    as ID, Bank Select registers
@@ -73,6 +99,11 @@ MODULE_PARM_DESC(reset, "Set to 1 to res
 #define W83793_REG_VID_LATCHB		0x08
 #define W83793_REG_VID_CTRL		0x59
 
+#define W83793_REG_WDT_LOCK		0x01
+#define W83793_REG_WDT_ENABLE		0x02
+#define W83793_REG_WDT_STATUS		0x03
+#define W83793_REG_WDT_TIMEOUT		0x04
+
 static u16 W83793_REG_TEMP_MODE[2] = { 0x5e, 0x5f };
 
 #define TEMP_READ	0
@@ -224,8 +255,36 @@ struct w83793_data {
 	u8 tolerance[3];	/* Temp tolerance(Smart Fan I/II) */
 	u8 sf2_pwm[6][7];	/* Smart FanII: Fan duty cycle */
 	u8 sf2_temp[6][7];	/* Smart FanII: Temp level point */
+
+	/* watchdog */
+	struct i2c_client *client;
+	struct mutex watchdog_lock;
+	struct list_head list; /* member of the watchdog_data_list */
+	struct kref kref;
+	struct miscdevice watchdog_miscdev;
+	unsigned long watchdog_is_open;
+	char watchdog_expect_close;
+	char watchdog_name[10]; /* must be unique to avoid sysfs conflict */
+	unsigned int watchdog_caused_reboot;
 };
 
+/* Somewhat ugly :( global data pointer list with all devices, so that
+   we can find our device data as when using misc_register. There is no
+   other method to get to one's device data from the open file-op and
+   for usage in the reboot notifier callback. */
+static LIST_HEAD(watchdog_data_list);
+
+/* Note this lock not only protect list access, but also data.kref access */
+static DEFINE_MUTEX(watchdog_data_mutex);
+
+/* Release our data struct when we're detached from the i2c client *and* all
+   references to our watchdog device are released */
+static void w83793_release_resources(struct kref *ref)
+{
+	struct w83793_data *data = container_of(ref, struct w83793_data, kref);
+	kfree(data);
+}
+
 static u8 w83793_read_value(struct i2c_client *client, u16 reg);
 static int w83793_write_value(struct i2c_client *client, u16 reg, u8 value);
 static int w83793_probe(struct i2c_client *client,
@@ -1064,14 +1123,348 @@ static void w83793_init_client(struct i2
 	/* Start monitoring */
 	w83793_write_value(client, W83793_REG_CONFIG,
 			   w83793_read_value(client, W83793_REG_CONFIG) | 0x01);
+}
+
+/*
+ * Watchdog routines
+ */
+
+static int watchdog_set_timeout(struct w83793_data *data, int timeout)
+{
+	int ret, stimeout;
+
+	if (timeout > 255)
+		return -EINVAL;
+
+	mutex_lock(&data->watchdog_lock);
+	if (!data->client) {
+		ret = -ENODEV;
+		goto leave;
+	}
+
+	printk(KERN_ERR "Set Timeout to %u seconds\n", timeout);
+
+	stimeout = DIV_ROUND_UP(timeout, 60);
+
+	/* Set Timeout value (in Minutes) */
+	printk(KERN_ERR "Set Timeout to %u minutes\n", stimeout);
+	w83793_write_value(data->client, W83793_REG_WDT_TIMEOUT, stimeout);
+
+	ret = stimeout;
+
+leave:
+	mutex_unlock(&data->watchdog_lock);
+	return ret;
+}
+
+static int watchdog_get_timeout(struct w83793_data *data)
+{
+	int gtimeout;
+
+	mutex_lock(&data->watchdog_lock);
+	if (!data->client)
+		return -ENODEV;
+
+	/* Get Timeout value (in Minutes) */
+	gtimeout = w83793_read_value(data->client, W83793_REG_WDT_TIMEOUT) * 60;
+	printk(KERN_ERR "Get Timeout: %u seconds\n", gtimeout);
+
+	mutex_unlock(&data->watchdog_lock);
+
+	return gtimeout;
+}
+
+static int watchdog_trigger(struct w83793_data *data)
+{
+	int ret = 0;
+
+	mutex_lock(&data->watchdog_lock);
+	if (!data->client) {
+		ret = -ENODEV;
+		goto leave;
+	}
+
+	printk(KERN_ERR "Reset Timeout to %u seconds\n", timeout*60);
+
+	/* Set Timeout value (in Minutes) */
+	w83793_write_value(data->client, W83793_REG_WDT_TIMEOUT, timeout);
+
+leave:
+	mutex_unlock(&data->watchdog_lock);
+	return ret;
+}
+
+static int watchdog_enable(struct w83793_data *data)
+{
+	int ret = 0;
+
+	mutex_lock(&data->watchdog_lock);
+	if (!data->client) {
+		ret = -ENODEV;
+		goto leave;
+	}
+
+	/* Set initial timeout */
+	printk(KERN_ERR "Set timeout: %u\n", timeout);
+	w83793_write_value(data->client, W83793_REG_WDT_TIMEOUT, timeout);
+
+	/* Enable Soft Watchdog */
+	printk(KERN_ERR "ENABLE Watchdog: 0x55\n");
+	w83793_write_value(data->client, W83793_REG_WDT_LOCK, 0x55);
+
+leave:
+	mutex_unlock(&data->watchdog_lock);
+	return ret;
+}
+
+static int watchdog_disable(struct w83793_data *data)
+{
+	int ret = 0;
+
+	mutex_lock(&data->watchdog_lock);
+	if (!data->client) {
+		ret = -ENODEV;
+		goto leave;
+	}
+
+	/* Disable Soft Watchdog */
+	printk(KERN_ERR "DISABLE Watchdog: 0xAA\n");
+	w83793_write_value(data->client, W83793_REG_WDT_LOCK, 0xAA);
+
+leave:
+	mutex_unlock(&data->watchdog_lock);
+	return ret;
+}
+
+static int watchdog_open(struct inode *inode, struct file *filp)
+{
+	struct w83793_data *pos, *data = NULL;
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
+
+	/* Note we can never not have found data, so we don't check for this */
+	kref_get(&data->kref);
+	mutex_unlock(&watchdog_data_mutex);
+
+	if (test_and_set_bit(0, &data->watchdog_is_open))
+		return -EBUSY;
+
+	/* Enable Soft Watchdog */
+	watchdog_enable(data);
+
+	/* Store pointer to data into filp's private data */
+	filp->private_data = data;
 
+	return nonseekable_open(inode, filp);
 }
 
+static int watchdog_close(struct inode *inode, struct file *filp)
+{
+	struct w83793_data *data = filp->private_data;
+
+	if (data->watchdog_expect_close) {
+		watchdog_disable(data);
+		data->watchdog_expect_close = 0;
+	} else {
+		watchdog_trigger(data);
+		dev_crit(&data->client->dev,
+			"unexpected close, not stopping watchdog!\n");
+	}
+
+	clear_bit(0, &data->watchdog_is_open);
+
+	return 0;
+}
+
+static ssize_t watchdog_write(struct file *filp, const char __user *buf,
+	size_t count, loff_t *offset)
+{
+	size_t ret;
+	struct w83793_data *data = filp->private_data;
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
+			  unsigned int cmd, unsigned long arg)
+{
+	static struct watchdog_info ident = {
+		.options = WDIOF_KEEPALIVEPING |
+			   WDIOF_SETTIMEOUT |
+			   WDIOF_CARDRESET,
+		.identity = "w83793 watchdog"
+	};
+
+	int val, ret = 0;
+	struct w83793_data *data = filp->private_data;
+
+	switch (cmd) {
+	case WDIOC_GETSUPPORT:
+		if (!nowayout)
+			ident.options |= WDIOF_MAGICCLOSE;
+		if (copy_to_user((void __user *)arg, &ident, sizeof(ident)))
+			ret = -EFAULT;
+		break;
+
+	case WDIOC_GETSTATUS:
+		val = data->watchdog_caused_reboot ? WDIOF_CARDRESET : 0;
+		ret = put_user(val, (int __user *)arg);
+		break;
+
+	case WDIOC_GETBOOTSTATUS:
+		ret = put_user(0, (int __user *)arg);
+		break;
+
+	case WDIOC_KEEPALIVE:
+		ret = watchdog_trigger(data);
+		break;
+
+	case WDIOC_GETTIMEOUT:
+		val = watchdog_get_timeout(data);
+		ret = put_user(val, (int __user *)arg);
+		break;
+
+	case WDIOC_SETTIMEOUT:
+		if (get_user(val, (int __user *)arg)) {
+			ret = -EFAULT;
+			break;
+		}
+		ret = watchdog_set_timeout(data, val);
+		if (ret > 0)
+			ret = put_user(ret, (int __user *)arg);
+		break;
+
+	case WDIOC_SETOPTIONS:
+		if (get_user(val, (int __user *)arg)) {
+			ret = -EFAULT;
+			break;
+		}
+
+		if (val & WDIOS_DISABLECARD)
+			ret = watchdog_disable(data);
+		else if (val & WDIOS_ENABLECARD)
+			ret = watchdog_enable(data);
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
+static const struct file_operations watchdog_fops = {
+	.owner = THIS_MODULE,
+	.llseek = no_llseek,
+	.open = watchdog_open,
+	.release = watchdog_close,
+	.write = watchdog_write,
+	.ioctl = watchdog_ioctl,
+};
+
+/*
+ *	Notifier for system down
+ */
+
+static int watchdog_notify_sys(struct notifier_block *this, unsigned long code,
+			       void *unused)
+{
+	struct w83793_data *data = NULL;
+
+	if (code == SYS_DOWN || code == SYS_HALT) {
+
+		/* Disable each registered watchdog */
+		mutex_lock(&watchdog_data_mutex);
+		list_for_each_entry(data, &watchdog_data_list, list) {
+			if (data->watchdog_miscdev.minor)
+				watchdog_disable(data);
+		}
+		mutex_unlock(&watchdog_data_mutex);
+	}
+
+	return NOTIFY_DONE;
+}
+
+/*
+ *	The WDT needs to learn about soft shutdowns in order to
+ *	turn the timebomb registers off.
+ */
+
+static struct notifier_block watchdog_notifier = {
+	.notifier_call = watchdog_notify_sys,
+};
+
+/*
+ * Init / remove routines
+ */
+
 static int w83793_remove(struct i2c_client *client)
 {
 	struct w83793_data *data = i2c_get_clientdata(client);
 	struct device *dev = &client->dev;
-	int i;
+	int i, tmp;
+
+	printk(KERN_ERR "** in w83793_remove()\n");
+
+	/* Unregister the watchdog (if registered) */
+	if (data->watchdog_miscdev.minor) {
+		misc_deregister(&data->watchdog_miscdev);
+
+		if (data->watchdog_is_open) {
+			dev_warn(&client->dev,
+				"i2c client detached with watchdog open! "
+				"Stopping watchdog.\n");
+			watchdog_disable(data);
+		}
+
+		mutex_lock(&watchdog_data_mutex);
+		list_del(&data->list);
+		mutex_unlock(&watchdog_data_mutex);
+
+		/* Tell the watchdog code the client is gone */
+		mutex_lock(&data->watchdog_lock);
+		data->client = NULL;
+		mutex_unlock(&data->watchdog_lock);
+	}
+
+	/* Reset Configuration Register to Disable Watch Dog Registers */
+	printk(KERN_ERR "Disable WATCHDOG config registers\n");
+	tmp = w83793_read_value(client, W83793_REG_CONFIG);
+	w83793_write_value(client, W83793_REG_CONFIG, tmp & ~0x04);
+
+	unregister_reboot_notifier(&watchdog_notifier);
 
 	hwmon_device_unregister(data->hwmon_dev);
 
@@ -1102,6 +1495,10 @@ static int w83793_remove(struct i2c_clie
 
 	kfree(data);
 
+	mutex_lock(&watchdog_data_mutex);
+	kref_put(&data->kref, w83793_release_resources);
+	mutex_unlock(&watchdog_data_mutex);
+
 	return 0;
 }
 
@@ -1168,6 +1565,8 @@ static int w83793_detect(struct i2c_clie
 	struct i2c_adapter *adapter = client->adapter;
 	unsigned short address = client->addr;
 
+	printk(KERN_ERR "** in w83793_detect()\n");
+
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
 		return -ENODEV;
 	}
@@ -1221,12 +1620,15 @@ static int w83793_probe(struct i2c_clien
 			const struct i2c_device_id *id)
 {
 	struct device *dev = &client->dev;
+	const int watchdog_minors[] = { WATCHDOG_MINOR, 212, 213, 214, 215 };
 	struct w83793_data *data;
 	int i, tmp, val, err;
 	int files_fan = ARRAY_SIZE(w83793_left_fan) / 7;
 	int files_pwm = ARRAY_SIZE(w83793_left_pwm) / 5;
 	int files_temp = ARRAY_SIZE(w83793_temp) / 6;
 
+	printk(KERN_ERR "** in w83793_probe()\n");
+
 	data = kzalloc(sizeof(struct w83793_data), GFP_KERNEL);
 	if (!data) {
 		err = -ENOMEM;
@@ -1236,6 +1638,14 @@ static int w83793_probe(struct i2c_clien
 	i2c_set_clientdata(client, data);
 	data->bank = i2c_smbus_read_byte_data(client, W83793_REG_BANKSEL);
 	mutex_init(&data->update_lock);
+	mutex_init(&data->watchdog_lock);
+	INIT_LIST_HEAD(&data->list);
+	kref_init(&data->kref);
+
+	/* Store client pointer in our data struct for watchdog usage
+	   (where the client is found through a data ptr instead of the
+	   otherway around) */
+	data->client = client;
 
 	err = w83793_detect_subclients(client);
 	if (err)
@@ -1398,8 +1808,76 @@ static int w83793_probe(struct i2c_clien
 		goto exit_remove;
 	}
 
+	/* Watchdog initialization */
+
+	/* Register boot notifier */
+	err = register_reboot_notifier(&watchdog_notifier);
+	if (err != 0) {
+		dev_err(&client->dev,
+			"cannot register reboot notifier (err=%d)\n", err);
+		goto exit_devunreg;
+	}
+
+	/* Enable Watchdog registers.
+	   Set Configuration Register to Enable Watch Dog Registers
+	   (Bit 2) = XXXX, X1XX. */
+	printk(KERN_ERR "ENABLE WatchDog registers\n");
+	tmp = w83793_read_value(client, W83793_REG_CONFIG);
+	w83793_write_value(client, W83793_REG_CONFIG, tmp | 0x04);
+
+	/* Check, if last reboot was caused by watchdog */
+	data->watchdog_caused_reboot =
+	  w83793_read_value(data->client, W83793_REG_WDT_STATUS) & 0x01;
+	printk(KERN_ERR "WatchDog status: %u\n", data->watchdog_caused_reboot);
+
+	/* Disable Soft Watchdog during initialiation */
+	watchdog_disable(data);
+
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
+
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
+
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
+
+	mutex_unlock(&watchdog_data_mutex);
+
 	return 0;
 
+	/* Unregister hwmon device */
+
+exit_devunreg:
+
+	hwmon_device_unregister(data->hwmon_dev);
+
 	/* Unregister sysfs hooks */
 
 exit_remove:
@@ -1646,7 +2124,7 @@ static void __exit sensors_w83793_exit(v
 	i2c_del_driver(&w83793_driver);
 }
 
-MODULE_AUTHOR("Yuan Mu");
+MODULE_AUTHOR("Yuan Mu, Rudolf Marek, Sven Anders");
 MODULE_DESCRIPTION("w83793 driver");
 MODULE_LICENSE("GPL");
 
--- linux-2.6.29.6/drivers/hwmon/Kconfig	2009-07-03 01:41:20.000000000 +0200
+++ linux-2.6.29.6.watchdog/drivers/hwmon/Kconfig	2009-12-04 12:13:08.000000000 +0100
@@ -789,7 +789,8 @@ config SENSORS_W83793
 	select HWMON_VID
 	help
 	  If you say yes here you get support for the Winbond W83793
-	  hardware monitoring chip.
+	  hardware monitoring chip, including support for the integrated
+	  watchdog.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called w83793.

--------------040806020403010408080508
Content-Type: text/x-vcard; charset=utf-8;
 name="anders.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="anders.vcf"

begin:vcard
fn:Sven Anders
n:Anders;Sven
org:ANDURAS AG;Research and Development
adr;quoted-printable:;;Innstra=C3=9Fe 71;Passau;Bavaria;94036;Germany
email;internet:anders@anduras.de
title:Dipl. Inf.
tel;work:++49 (0)851 / 490 50 -0
tel;fax:++49 (0)851 / 590 50 - 55
x-mozilla-html:FALSE
url:http://www.anduras.de
version:2.1
end:vcard


--------------040806020403010408080508--

--------------ms070000060102050805090503
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIOsDCC
B1QwggU8oAMCAQICAxAABTANBgkqhkiG9w0BAQUFADCBqjELMAkGA1UEBhMCREUxCzAJBgNV
BAgTAkJZMQ8wDQYDVQQHEwZQYXNzYXUxEzARBgNVBAoTCkFORFVSQVMgQUcxHjAcBgNVBAsT
FUNlcnRpZmljYXRlIEF1dGhvcml0eTEpMCcGA1UEAxMgQU5EVVJBUyBBRyBDZXJ0aWZpY2F0
ZSBBdXRob3JpdHkxHTAbBgkqhkiG9w0BCQEWDnBraUBhbmR1cmFzLmRlMB4XDTA5MTAyMDIw
MzQ1N1oXDTE0MTAyMDIwMzQ1N1owgbAxCzAJBgNVBAYTAkRFMQswCQYDVQQIEwJCWTEPMA0G
A1UEBxMGUGFzc2F1MRMwEQYDVQQKEwpBTkRVUkFTIEFHMSkwJwYDVQQKEyBmOTIyMjlhOWM5
MjBiOGVkZGEwYzRlYzg4MGQ4ZTgzYjELMAkGA1UECxMCR0wxFDASBgNVBAMTC3N2ZW4uYW5k
ZXJzMSAwHgYJKoZIhvcNAQkBFhFhbmRlcnNAYW5kdXJhcy5kZTCCASIwDQYJKoZIhvcNAQEB
BQADggEPADCCAQoCggEBALxbO8bh1hRSEsTu7n/7sPpS7fHqLeQWzwg1mengwU8V1xK3nfB5
gA/LyZDo96CDnhlnizlaSXRHCjVOVGO7IiM/GWhRFhSXBz1uqv0FHffkC1xI0T1C9ySSDp4R
RgKry3PiR79wS9E2fzKjqctNZIld3blaGBHmElRSEjHuxOiyR/k0I1YndkLrJA/n4UsLzoEF
qGNJ49EDRucUEL1bBCjT8ZiCiPrQiBSfk2K5BPtqg68I+BQMjIAVmhpvxv5UQcrKWKFoeWyF
JqgJb4+gioDlDuTYUxDjurdU6+dI+I011vS/rj5qe81DcXNiQA55NqTgDQrsJCyj+H0qMZW2
lk0CAwEAAaOCAnkwggJ1MAwGA1UdEwEB/wQCMAAwDgYDVR0PAQH/BAQDAgP4MCoGA1UdJQQj
MCEGCCsGAQUFBwMEBggrBgEFBQcDAgYLKwYBBAGB6y0DAQEwFAYJYIZIAYb4QgEBAQH/BAQD
AgWgMB0GA1UdDgQWBBT1nf148Ot7Zwor+h/kFKOzgPoJPzCB3wYDVR0jBIHXMIHUgBQ34zit
047U9ZuPSA8TE9kjVMkm96GBsKSBrTCBqjELMAkGA1UEBhMCREUxCzAJBgNVBAgTAkJZMQ8w
DQYDVQQHEwZQYXNzYXUxEzARBgNVBAoTCkFORFVSQVMgQUcxHjAcBgNVBAsTFUNlcnRpZmlj
YXRlIEF1dGhvcml0eTEpMCcGA1UEAxMgQU5EVVJBUyBBRyBDZXJ0aWZpY2F0ZSBBdXRob3Jp
dHkxHTAbBgkqhkiG9w0BCQEWDnBraUBhbmR1cmFzLmRlggkAhNxpBFvYvqIwGQYDVR0SBBIw
EIEOcGtpQGFuZHVyYXMuZGUwYAYDVR0fBFkwVzApoCegJYYjaHR0cDovL2NhLmFuZHVyYXMu
ZGUvYW5kdXJhcy1jYS5jcmwwKqAooCaGJGh0dHA6Ly9jcmwuYW5kdXJhcy5kZS9hbmR1cmFz
LWNhLmNybDAuBglghkgBhvhCAQ0EIRYfQU5EVVJBUyBBRyBQZXJzb25hbCBDZXJ0aWZpY2F0
ZTBlBggrBgEFBQcBAQRZMFcwIwYIKwYBBQUHMAGGF2h0dHA6Ly9vY3NwLmFuZHVyYXMuZGUv
MDAGCCsGAQUFBzAChiRodHRwOi8vY2EuYW5kdXJhcy5kZS9hbmR1cmFzLWNhLmh0bWwwDQYJ
KoZIhvcNAQEFBQADggIBAD7x+V+hQ00k19ISJgTDzupxFpAnOugXe2sgM9zmdx+RlsAJ56mB
nvdhoTtlwi2wCUV1jW848w024TJ+xW5kOrU5RzpWc+8lrOhakcs4VYgaYez+fSXOk/t1gAxV
haFglg5mfdj5XZvKs8NnvlkKZioWWbKVW6S404HGNn5pOwxRnT+1SaSpSWxWbng0XC6BZuP4
FkxnKD9yCWcKDbfkIYk3CQFAlVMB6jZNffiScf9SVHkwytnw+Op0LwvEaK9oSJ+9KxPKYbkG
V4DP3bDujeI448gUZExT/FH501eaWr0U3P6I88Omru6UwVZnIx+cJgUmNGr0RoyPMuD5KAX6
1cvDukeJVLhT3uUChsl3huWQkUVH6kvPqNyG+PM1LnhGk0LGGQvk5NMMHDFl9Su+9SRIh8BA
xb8dbIUEorXKgYoxNWGdv/0qpcik7pUOygqSdYOleIqlUVUG53KtwVhrOvZEpu3kSldTm5m2
z16VD4AIediBB5AxpyWVF3OXyGLrsKWofydZrrMdu+l0GNKPC2NVFGlXt3U49b+nvsW4TSBP
IbIkTmbQwbbj0jXVrBfzx95zHsaq7152Y+857Fm9NSSws1nEBvMBSVmCsRtM00tqZedVZzZG
VFKHByO2+xsG0QSksVA0VGIDczgpmjJBVm2UkO66/ZBwQ/mm6u3wMx4OMIIHVDCCBTygAwIB
AgIDEAAFMA0GCSqGSIb3DQEBBQUAMIGqMQswCQYDVQQGEwJERTELMAkGA1UECBMCQlkxDzAN
BgNVBAcTBlBhc3NhdTETMBEGA1UEChMKQU5EVVJBUyBBRzEeMBwGA1UECxMVQ2VydGlmaWNh
dGUgQXV0aG9yaXR5MSkwJwYDVQQDEyBBTkRVUkFTIEFHIENlcnRpZmljYXRlIEF1dGhvcml0
eTEdMBsGCSqGSIb3DQEJARYOcGtpQGFuZHVyYXMuZGUwHhcNMDkxMDIwMjAzNDU3WhcNMTQx
MDIwMjAzNDU3WjCBsDELMAkGA1UEBhMCREUxCzAJBgNVBAgTAkJZMQ8wDQYDVQQHEwZQYXNz
YXUxEzARBgNVBAoTCkFORFVSQVMgQUcxKTAnBgNVBAoTIGY5MjIyOWE5YzkyMGI4ZWRkYTBj
NGVjODgwZDhlODNiMQswCQYDVQQLEwJHTDEUMBIGA1UEAxMLc3Zlbi5hbmRlcnMxIDAeBgkq
hkiG9w0BCQEWEWFuZGVyc0BhbmR1cmFzLmRlMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
CgKCAQEAvFs7xuHWFFISxO7uf/uw+lLt8eot5BbPCDWZ6eDBTxXXEred8HmAD8vJkOj3oIOe
GWeLOVpJdEcKNU5UY7siIz8ZaFEWFJcHPW6q/QUd9+QLXEjRPUL3JJIOnhFGAqvLc+JHv3BL
0TZ/MqOpy01kiV3duVoYEeYSVFISMe7E6LJH+TQjVid2QuskD+fhSwvOgQWoY0nj0QNG5xQQ
vVsEKNPxmIKI+tCIFJ+TYrkE+2qDrwj4FAyMgBWaGm/G/lRByspYoWh5bIUmqAlvj6CKgOUO
5NhTEOO6t1Tr50j4jTXW9L+uPmp7zUNxc2JADnk2pOANCuwkLKP4fSoxlbaWTQIDAQABo4IC
eTCCAnUwDAYDVR0TAQH/BAIwADAOBgNVHQ8BAf8EBAMCA/gwKgYDVR0lBCMwIQYIKwYBBQUH
AwQGCCsGAQUFBwMCBgsrBgEEAYHrLQMBATAUBglghkgBhvhCAQEBAf8EBAMCBaAwHQYDVR0O
BBYEFPWd/Xjw63tnCiv6H+QUo7OA+gk/MIHfBgNVHSMEgdcwgdSAFDfjOK3TjtT1m49IDxMT
2SNUySb3oYGwpIGtMIGqMQswCQYDVQQGEwJERTELMAkGA1UECBMCQlkxDzANBgNVBAcTBlBh
c3NhdTETMBEGA1UEChMKQU5EVVJBUyBBRzEeMBwGA1UECxMVQ2VydGlmaWNhdGUgQXV0aG9y
aXR5MSkwJwYDVQQDEyBBTkRVUkFTIEFHIENlcnRpZmljYXRlIEF1dGhvcml0eTEdMBsGCSqG
SIb3DQEJARYOcGtpQGFuZHVyYXMuZGWCCQCE3GkEW9i+ojAZBgNVHRIEEjAQgQ5wa2lAYW5k
dXJhcy5kZTBgBgNVHR8EWTBXMCmgJ6AlhiNodHRwOi8vY2EuYW5kdXJhcy5kZS9hbmR1cmFz
LWNhLmNybDAqoCigJoYkaHR0cDovL2NybC5hbmR1cmFzLmRlL2FuZHVyYXMtY2EuY3JsMC4G
CWCGSAGG+EIBDQQhFh9BTkRVUkFTIEFHIFBlcnNvbmFsIENlcnRpZmljYXRlMGUGCCsGAQUF
BwEBBFkwVzAjBggrBgEFBQcwAYYXaHR0cDovL29jc3AuYW5kdXJhcy5kZS8wMAYIKwYBBQUH
MAKGJGh0dHA6Ly9jYS5hbmR1cmFzLmRlL2FuZHVyYXMtY2EuaHRtbDANBgkqhkiG9w0BAQUF
AAOCAgEAPvH5X6FDTSTX0hImBMPO6nEWkCc66Bd7ayAz3OZ3H5GWwAnnqYGe92GhO2XCLbAJ
RXWNbzjzDTbhMn7FbmQ6tTlHOlZz7yWs6FqRyzhViBph7P59Jc6T+3WADFWFoWCWDmZ92Pld
m8qzw2e+WQpmKhZZspVbpLjTgcY2fmk7DFGdP7VJpKlJbFZueDRcLoFm4/gWTGcoP3IJZwoN
t+QhiTcJAUCVUwHqNk19+JJx/1JUeTDK2fD46nQvC8Ror2hIn70rE8phuQZXgM/dsO6N4jjj
yBRkTFP8UfnTV5pavRTc/ojzw6au7pTBVmcjH5wmBSY0avRGjI8y4PkoBfrVy8O6R4lUuFPe
5QKGyXeG5ZCRRUfqS8+o3Ib48zUueEaTQsYZC+Tk0wwcMWX1K771JEiHwEDFvx1shQSitcqB
ijE1YZ2//SqlyKTulQ7KCpJ1g6V4iqVRVQbncq3BWGs69kSm7eRKV1ObmbbPXpUPgAh52IEH
kDGnJZUXc5fIYuuwpah/J1musx276XQY0o8LY1UUaVe3dTj1v6e+xbhNIE8hsiROZtDBtuPS
NdWsF/PH3nMexqrvXnZj7znsWb01JLCzWcQG8wFJWYKxG0zTS2pl51VnNkZUUocHI7b7GwbR
BKSxUDRUYgNzOCmaMkFWbZSQ7rr9kHBD+abq7fAzHg4xggQqMIIEJgIBATCBsjCBqjELMAkG
A1UEBhMCREUxCzAJBgNVBAgTAkJZMQ8wDQYDVQQHEwZQYXNzYXUxEzARBgNVBAoTCkFORFVS
QVMgQUcxHjAcBgNVBAsTFUNlcnRpZmljYXRlIEF1dGhvcml0eTEpMCcGA1UEAxMgQU5EVVJB
UyBBRyBDZXJ0aWZpY2F0ZSBBdXRob3JpdHkxHTAbBgkqhkiG9w0BCQEWDnBraUBhbmR1cmFz
LmRlAgMQAAUwCQYFKw4DAhoFAKCCAkwwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkq
hkiG9w0BCQUxDxcNMDkxMjA0MTEzMjQyWjAjBgkqhkiG9w0BCQQxFgQUZlz7UOurQMBtEmSv
3wJyAoa4Pq4wXwYJKoZIhvcNAQkPMVIwUDALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYI
KoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIHD
BgkrBgEEAYI3EAQxgbUwgbIwgaoxCzAJBgNVBAYTAkRFMQswCQYDVQQIEwJCWTEPMA0GA1UE
BxMGUGFzc2F1MRMwEQYDVQQKEwpBTkRVUkFTIEFHMR4wHAYDVQQLExVDZXJ0aWZpY2F0ZSBB
dXRob3JpdHkxKTAnBgNVBAMTIEFORFVSQVMgQUcgQ2VydGlmaWNhdGUgQXV0aG9yaXR5MR0w
GwYJKoZIhvcNAQkBFg5wa2lAYW5kdXJhcy5kZQIDEAAFMIHFBgsqhkiG9w0BCRACCzGBtaCB
sjCBqjELMAkGA1UEBhMCREUxCzAJBgNVBAgTAkJZMQ8wDQYDVQQHEwZQYXNzYXUxEzARBgNV
BAoTCkFORFVSQVMgQUcxHjAcBgNVBAsTFUNlcnRpZmljYXRlIEF1dGhvcml0eTEpMCcGA1UE
AxMgQU5EVVJBUyBBRyBDZXJ0aWZpY2F0ZSBBdXRob3JpdHkxHTAbBgkqhkiG9w0BCQEWDnBr
aUBhbmR1cmFzLmRlAgMQAAUwDQYJKoZIhvcNAQEBBQAEggEAI4JGxboTiay6JuhEK/LG8bWW
fa321vueF7XqOs758qXaHLR8TmR40RMo9+qQzP+GaSCMvF+y6ZHR3TcW651fqhxmQR9KkHTN
FX0NwzsqjNZMgUO3MwMQN8/dRaByBJCcJxVHapGhFc8mlvf1WXLKdEZkFieNOvP03wz1X4M3
8kx+4XYx0ae5T/SHqyL3vkfuVk8Uc2tXEubfgvxXuRV0BSf9BZrzufdxdeOhnGkXwrJiQNZk
jKHduF/L/nZevrpHcYEZRRzQB8zrNsXkV+43Cch2e2aCUMja6dzgl6atysx6HQ+q3MC1Y1GL
W2LT81Zxnat2iQIyEv419XJIXFuGVAAAAAAAAA==
--------------ms070000060102050805090503--


--===============1959474436223071931==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1959474436223071931==--
