From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 08 Dec 2009 16:09:02 +0000
Subject: Re: [lm-sensors] [PATCH] w83793 watchdog support.
Message-Id: <4B1E7A1E.3070704@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4B18F35A.5060808@anduras.de>
In-Reply-To: <4B18F35A.5060808@anduras.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Comments inline.


--- linux-2.6.29.6/drivers/hwmon/w83793.c	2009-07-03 01:41:20.000000000 +0200
+++ linux-2.6.29.6.watchdog/drivers/hwmon/w83793.c	2009-12-04 12:10:55.000000000 +0100

<snip>

@@ -1064,14 +1123,336 @@ static void w83793_init_client(struct i2
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

timeout is in seconds here, you should do the DIV_ROUND_UP before taking the lock, and
do this check on stimeout.

+	mutex_lock(&data->watchdog_lock);
+	if (!data->client) {
+		ret = -ENODEV;
+		goto leave;
+	}
+
+	stimeout = DIV_ROUND_UP(timeout, 60);
+
+	/* Set Timeout value (in Minutes) */
+	w83793_write_value(data->client, W83793_REG_WDT_TIMEOUT, stimeout);
+
+	ret = stimeout;
+

That should be "stimeout * 60".

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
+
+	mutex_lock(&data->watchdog_lock);
+	if (!data->client) {
+		ret = -ENODEV;
+		goto leave;
+	}
+
+	/* Set Timeout value (in Minutes) */
+	w83793_write_value(data->client, W83793_REG_WDT_TIMEOUT, timeout);
+

Hmm, and here things get a bit funky, you write the TIMEOUT configuration
register, are you sure this is the right way to do a trigger ?

If so you should remember the configured timeout (the one configured through the
ioctl) in data and write that each trigger.

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
+	w83793_write_value(data->client, W83793_REG_WDT_TIMEOUT, timeout);
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
+	   call misc_register() from fschmd_probe() with watchdog_data_mutex
+	   hold, as misc_register() takes the misc_mtx lock, this is a possible
+	   deadlock, so we use mutex_trylock here. */

That fschmd_probe should be w83793_probe I think :)

+	if (!mutex_trylock(&watchdog_data_mutex))
+		return -ERESTARTSYS;
+	list_for_each_entry(pos, &watchdog_data_list, list) {
+		if (pos->watchdog_miscdev.minor = iminor(inode)) {
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

You are missing:

         mutex_lock(&watchdog_data_mutex);
         kref_put(&data->kref, w83793_release_resources);
         mutex_unlock(&watchdog_data_mutex);

Here !!

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
+				if (c = 'V')
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
+	if (code = SYS_DOWN || code = SYS_HALT) {
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

@@ -1102,6 +1495,10 @@ static int w83793_remove(struct i2c_clie

  	kfree(data);

+	mutex_lock(&watchdog_data_mutex);
+	kref_put(&data->kref, w83793_release_resources);
+	mutex_unlock(&watchdog_data_mutex);
+
  	return 0;
  }


The kfree(data) should be removed, this is done by w83793_release_resources() now.

@@ -1221,6 +1620,7 @@ static int w83793_probe(struct i2c_clien
  			const struct i2c_device_id *id)
  {
  	struct device *dev = &client->dev;
+	const int watchdog_minors[] = { WATCHDOG_MINOR, 212, 213, 214, 215 };
  	struct w83793_data *data;
  	int i, tmp, val, err;
  	int files_fan = ARRAY_SIZE(w83793_left_fan) / 7;
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
@@ -1398,8 +1808,74 @@ static int w83793_probe(struct i2c_clien
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
+	/* Check, if last reboot was caused by watchdog */
+	data->watchdog_caused_reboot +	  w83793_read_value(data->client, W83793_REG_WDT_STATUS) & 0x01;
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
+			"watchdog%c", (i = 0) ? '\0' : ('0' + i));
+		data->watchdog_miscdev.name = data->watchdog_name;
+		data->watchdog_miscdev.fops = &watchdog_fops;
+		data->watchdog_miscdev.minor = watchdog_minors[i];
+
+		err = misc_register(&data->watchdog_miscdev);
+		if (err = -EBUSY)
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
+	if (i = ARRAY_SIZE(watchdog_minors)) {
+		data->watchdog_miscdev.minor = 0;
+		dev_warn(&client->dev, "Couldn't register watchdog chardev "
+			"(due to no free minor)\n");
+	}
+
+	mutex_unlock(&watchdog_data_mutex);
+

You do not seem to be setting a default timeout here even though you've made this configurable
through a module parameter, but this might be due to the remarks given above wrt the trigger.

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

Not quite sure why you are adding Rudolf Marek here.


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

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
