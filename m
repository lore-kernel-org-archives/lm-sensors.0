From: Sven Anders <anders@anduras.de>
Date: Thu, 21 Jan 2010 09:47:52 +0000
Subject: Re: [lm-sensors] [PATCH] w83793 watchdog support.
Message-Id: <4B5822C8.2070906@anduras.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------010908070102000908060601"
List-Id: <lm-sensors.vger.kernel.org>
References: <4B18F35A.5060808@anduras.de>
In-Reply-To: <4B18F35A.5060808@anduras.de>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------010908070102000908060601
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hello!

Thanks for you last comments on the code. Now after the holidays, I found=

time to write you an answer and sent you an updated patch as well.


>> The timeout here is an global variable, so it's already done here.
>>
> Erm, no.
>
> The watchdog_set_timeout() function currently writes the timeout passed=
 in
> to the chip, but that will only change the timeout now, and not for fut=
ure
> triggers. The way the ioctl should work is that the timeout between 2 t=
riggers
> (before the system resets) should be changed, so the value written by
> watchdog_trigger() should be changed. And since this driver can support=
 multiple
> ic's (unlikely this ever happens but still) the timeout should be store=
d in
> the w83793_data struct so that it can be changed per device. The module=
 parameter
> can then be used to initialize the per device timeout when the
> device is probed.

Ok, I thought I already implemented the assignment but I really missed it=
=2E
But you're correct, the value should be implemented in the data struct. I=
've
done it in the current patch.

>>> In "static int watchdog_close(struct inode *inode, struct file *filp)=
"
>>> you are missing:
>>>
>>>           mutex_lock(&watchdog_data_mutex);
>>>           kref_put(&data->kref, w83793_release_resources);
>>>           mutex_unlock(&watchdog_data_mutex);
>>
>> I'm not sure if you're right. Closing the watchdog did not remove the
>> module nor does it disable it configurability.
>> But maybe I misunderstood something here.
>
> Well I'm sure I'm right :)   (please don't take this wrong and please
> keep asking questions).
>
> The problem with the free-ing of the per device data struct is that the=
re
> are 2 ways to get to it:
>
> 1) Through the hwmon interface
> 2) Through the watchdog device
>
> Now the following can happen:
>
> 1) Driver attaches to w83793 i2c device
> 2) app opens /dev/watchdog
> 3) Driver detaches from w83793 i2c device
>     (for example because the i2c master module
>      gets unloaded)

Is it really possible to unload the i2c master module without
unloading any dependend module first? I thought this isn't possible...

> Now before your changes 3) Would remove the hwmon interface
> (and thus the only path to the per device data) and then
> the per device data would be freed.
>
> However now, someone can still have a reference to the per device
> data (the app which has /dev/watchdog open). This is why we now
> use reference counting for the per device data struct (this is
> what the kref stuff does). So we start by initializing the
> kref in probe() which puts its counter at 1, then the
> watchdog open function increases the counter (the kref_get)
> to 2. Then when the driver detaches, the w83793_remove() function
> decreases the counter (the kref_put) to 1, this does not
> call w83793_release_resources, as that will only get called when
> the kref hits 0.
>
> Now when:
> 4) The app closes /dev/watchdog
>
> The close function should call kref_put too, so that the counter
> will hit 0 and the data struct gets free-ed.

Ok, I think I now understand this.

>Notes:
>
> 1) that the misc_deregister() call in w83793_remove() only
> removes the /dev/watchdog node, and does not close any open
> filehandles already pointing to the watchdog (closing of filehandles
> is up to the application not the kernel).
>
> 2) that this (the i2c client being detached while /dev/watchdog is stil=
l
> open), is the reason for the data->client check in all watchdog functio=
ns
> which actually read/write the chip.

I assume the already running watchdog app can still access the opened
file even if the /dev/watchdog node does not exist anymore. So this
should be a problem.


There is one small problem left:

If the watchdog_open() functions failes with EBUSY, we must not
increase the counter.


Ok. This was my first encounter with the i2c framework. Until now I was
only using direct hardware access, which was easier because anything was
coded (and called!) in only one module source file.
Thanks for your explantations!

>> On the other hand, I think you are missing the 'reboot notifier' in
>> your fschmd driver code.
>
> The fsc chips are all part of Fujitsu Siemens Computers, iow the manufa=
cturer
> of the motherboard =3D=3D the manufacturer of the watchdog. As such the=
 watchdog
> always gets initialized by the BIOS, so there is no reason to disable
> it before shutdown / reboot.

But you will need it, to prevent the watchdog to reboot the machine, if t=
he
shutdown sequence needs more time to shutdown than the watchdog is set to=
=2E

Consider the following szenario:

1) Watchdog timeout is set to 1 Minute.
2) Watchdog helper tool resets the watchdog timer every 30 seconds.
3) User executes "shutdown" binary.
4) Watchdog timer is currently at 31 seconds and the watchdog helper
   tool is stopped first.
5) Watchdog timer has now about 30 seconds left.
6) Heavy loaded database needs much time to write it's caches or perform =
any
   other tasks during shutdown. For instance it will need about 2 minutes=
=2E
7) After 30 seconds the hardware watchdog kicks in and reboots the machin=
e
   leaving the database in an inconsistent state.


Please notify me, if I need to make some more changes or if you sent the =
patch
upstream.

Regards
 Sven Anders

--=20
 Sven Anders <anders@anduras.de>                 () Ascii Ribbon Campaign=

                                                 /\ Support plain text e-=
mail
 ANDURAS service solutions AG
 Innstra=DFe 71 - 94036 Passau - Germany
 Web: www.anduras.de - Tel: +49 (0)851-4 90 50-0 - Fax: +49 (0)851-4 90 5=
0-55

Rechtsform: Aktiengesellschaft - Sitz: Passau - Amtsgericht Passau HRB 60=
32
Mitglieder des Vorstands: Sven Anders, Marcus Junker
Vorsitzender des Aufsichtsrats: Mark Peters

--------------010908070102000908060601
Content-Type: text/x-patch;
 name="w83793_wdt.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="w83793_wdt.patch"

This patch add watchdog functionality to the Winbond 83793 chipset driver.

Signed-off-by: Sven Anders <anders@anduras.de>

--- linux-2.6.29.6/drivers/hwmon/w83793.c	2009-07-03 01:41:20.000000000 +0200
+++ linux-2.6.29.6.watchdog/drivers/hwmon/w83793.c	2010-01-20 15:22:55.000000000 +0100
@@ -3,6 +3,10 @@
     Copyright (C) 2006 Winbond Electronics Corp.
                   Yuan Mu
                   Rudolf Marek <r.marek@assembler.cz>
+    Copyright (C) 2009-2010 Sven Anders <anders@anduras.de>, ANDURAS AG.
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
+#define WATCHDOG_TIMEOUT 2	/* 2 minute default timeout */
 
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, 0x2f,
-						I2C_CLIENT_END };
+					     I2C_CLIENT_END };
 
 /* Insmod parameters */
 I2C_CLIENT_INSMOD_1(w83793);
@@ -52,6 +66,18 @@
 module_param(reset, bool, 0);
 MODULE_PARM_DESC(reset, "Set to 1 to reset chip, not recommended");
 
+static int timeout = WATCHDOG_TIMEOUT;	/* default timeout in minutes */
+module_param(timeout, int, 0);
+MODULE_PARM_DESC(timeout,
+	"Watchdog timeout in minutes. 2<= timeout <=255 (default="
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
@@ -73,6 +99,11 @@
 #define W83793_REG_VID_LATCHB		0x08
 #define W83793_REG_VID_CTRL		0x59
 
+#define W83793_REG_WDT_LOCK		0x01
+#define W83793_REG_WDT_ENABLE		0x02
+#define W83793_REG_WDT_STATUS		0x03
+#define W83793_REG_WDT_TIMEOUT		0x04
+
 static u16 W83793_REG_TEMP_MODE[2] = { 0x5e, 0x5f };
 
 #define TEMP_READ	0
@@ -224,8 +255,37 @@
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
+	int watchdog_timeout;
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
@@ -1064,14 +1124,349 @@
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
+	stimeout = DIV_ROUND_UP(timeout, 60);
+
+	if (stimeout > 255)
+		return -EINVAL;
+
+	mutex_lock(&data->watchdog_lock);
+	if (!data->client) {
+		ret = -ENODEV;
+		goto leave;
+	}
+
+	/* Set Timeout value (in Minutes) */
+	w83793_write_value(data->client, W83793_REG_WDT_TIMEOUT, stimeout);
+
+	ret = stimeout * 60;
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
+
+	mutex_unlock(&data->watchdog_lock);
+
+	return gtimeout;
+}
+
+static int watchdog_trigger(struct w83793_data *data)
+{
+	int ret = 0;
 
+	mutex_lock(&data->watchdog_lock);
+	if (!data->client) {
+		ret = -ENODEV;
+		goto leave;
+	}
+
+	/* Set Timeout value (in Minutes) */
+	w83793_write_value(data->client, W83793_REG_WDT_TIMEOUT,
+			   data->watchdog_timeout);
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
+	w83793_write_value(data->client, W83793_REG_WDT_TIMEOUT,
+			   data->watchdog_timeout);
+
+	/* Enable Soft Watchdog */
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
+	   call misc_register() from  w83793_probe() with watchdog_data_mutex
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
+	/* Check, if device is already open and do not increase
+	   data ref counter in this case... */
+	if (test_and_set_bit(0, &data->watchdog_is_open)) {
+		mutex_unlock(&watchdog_data_mutex);
+		return -EBUSY;
+	}
+
+	/* Increase data reference counter.
+	   Note we can never not have found data, so we don't check for this */
+	kref_get(&data->kref);
+	mutex_unlock(&watchdog_data_mutex);
+
+	/* Enable Soft Watchdog */
+	watchdog_enable(data);
+
+	/* Store pointer to data into filp's private data */
+	filp->private_data = data;
+
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
+	/* Decrease data reference counter */
+	mutex_lock(&watchdog_data_mutex);
+	kref_put(&data->kref, w83793_release_resources);
+	mutex_unlock(&watchdog_data_mutex);
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
+		data->watchdog_timeout = val;
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
+	tmp = w83793_read_value(client, W83793_REG_CONFIG);
+	w83793_write_value(client, W83793_REG_CONFIG, tmp & ~0x04);
+
+	unregister_reboot_notifier(&watchdog_notifier);
 
 	hwmon_device_unregister(data->hwmon_dev);
 
@@ -1100,7 +1495,10 @@
 	if (data->lm75[1] != NULL)
 		i2c_unregister_device(data->lm75[1]);
 
-	kfree(data);
+	/* Decrease data reference counter */
+	mutex_lock(&watchdog_data_mutex);
+	kref_put(&data->kref, w83793_release_resources);
+	mutex_unlock(&watchdog_data_mutex);
 
 	return 0;
 }
@@ -1168,9 +1566,8 @@
 	struct i2c_adapter *adapter = client->adapter;
 	unsigned short address = client->addr;
 
-	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
-	}
 
 	bank = i2c_smbus_read_byte_data(client, W83793_REG_BANKSEL);
 
@@ -1221,6 +1618,7 @@
 			const struct i2c_device_id *id)
 {
 	struct device *dev = &client->dev;
+	const int watchdog_minors[] = { WATCHDOG_MINOR, 212, 213, 214, 215 };
 	struct w83793_data *data;
 	int i, tmp, val, err;
 	int files_fan = ARRAY_SIZE(w83793_left_fan) / 7;
@@ -1236,6 +1634,14 @@
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
@@ -1398,8 +1804,77 @@
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
+	tmp = w83793_read_value(client, W83793_REG_CONFIG);
+	w83793_write_value(client, W83793_REG_CONFIG, tmp | 0x04);
+
+	/* Set the default watchdog timeout */
+	data->watchdog_timeout = timeout;
+
+	/* Check, if last reboot was caused by watchdog */
+	data->watchdog_caused_reboot =
+	  w83793_read_value(data->client, W83793_REG_WDT_STATUS) & 0x01;
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
@@ -1646,7 +2121,7 @@
 	i2c_del_driver(&w83793_driver);
 }
 
-MODULE_AUTHOR("Yuan Mu");
+MODULE_AUTHOR("Yuan Mu, Sven Anders");
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


--------------010908070102000908060601
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


--------------010908070102000908060601
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------010908070102000908060601--
