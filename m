From: Hans de Goede <hdegoede@redhat.com>
Date: Sat, 17 Mar 2012 09:40:29 +0000
Subject: [lm-sensors] [PATCH] hwmon/sch56xx: Add support for the integrated watchdog
Message-Id: <1331977229-1370-2-git-send-email-hdegoede@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1331977229-1370-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1331977229-1370-1-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LM Sensors <lm-sensors@lm-sensors.org>
Cc: linux-watchdog@vger.kernel.org, Thilo Cestonaro <thilo.cestonaro@ts.fujitsu.com>, Hans de Goede <hdegoede@redhat.com>

Add support for the watchdog integrated into the SMSC SCH5627 and
SCH5636 superio-s. Since the watchdog is part of the hwmon logical device
and thus shares ioports with it, the watchdog driver is integrated into the
existing hwmon drivers for these.

Note that this version of the watchdog support for sch56xx superio-s
implements the watchdog chardev interface itself, rather then relying on
The recently added watchdog core / watchdog_dev. This is done because
currently some needed functionality is missing from watchdog_dev, as soon
as this functionality is added (which is being discussed on the
linux-watchdog mailinglist), I'll convert this driver over to using
watchdog_dev.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/hwmon/sch5627    |    5 +
 Documentation/hwmon/sch5636    |    3 +
 drivers/hwmon/Kconfig          |    6 +-
 drivers/hwmon/sch5627.c        |   11 +-
 drivers/hwmon/sch5636.c        |   11 +-
 drivers/hwmon/sch56xx-common.c |  507 +++++++++++++++++++++++++++++++++++++++-
 drivers/hwmon/sch56xx-common.h |   10 +-
 7 files changed, 546 insertions(+), 7 deletions(-)

diff --git a/Documentation/hwmon/sch5627 b/Documentation/hwmon/sch5627
index 446a054..0551d26 100644
--- a/Documentation/hwmon/sch5627
+++ b/Documentation/hwmon/sch5627
@@ -16,6 +16,11 @@ Description
 SMSC SCH5627 Super I/O chips include complete hardware monitoring
 capabilities. They can monitor up to 5 voltages, 4 fans and 8 temperatures.
 
+The SMSC SCH5627 hardware monitoring part also contains an integrated
+watchdog. In order for this watchdog to function some motherboard specific
+initialization most be done by the BIOS, so if the watchdog is not enabled
+by the BIOS the sch5627 driver will not register a watchdog device.
+
 The hardware monitoring part of the SMSC SCH5627 is accessed by talking
 through an embedded microcontroller. An application note describing the
 protocol for communicating with the microcontroller is available upon
diff --git a/Documentation/hwmon/sch5636 b/Documentation/hwmon/sch5636
index f83bd1c..7b0a01d 100644
--- a/Documentation/hwmon/sch5636
+++ b/Documentation/hwmon/sch5636
@@ -26,6 +26,9 @@ temperatures. Note that the driver detects how many fan headers /
 temperature sensors are actually implemented on the motherboard, so you will
 likely see fewer temperature and fan inputs.
 
+The Fujitsu Theseus hwmon solution also contains an integrated watchdog.
+This watchdog is fully supported by the sch5636 driver.
+
 An application note describing the Theseus' registers, as well as an
 application note describing the protocol for communicating with the
 microcontroller is available upon request. Please mail me if you want a copy.
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index dad895f..20920c5 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1028,7 +1028,8 @@ config SENSORS_SCH5627
 	select SENSORS_SCH56XX_COMMON
 	help
 	  If you say yes here you get support for the hardware monitoring
-	  features of the SMSC SCH5627 Super-I/O chip.
+	  features of the SMSC SCH5627 Super-I/O chip including support for
+	  the integrated watchdog.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called sch5627.
@@ -1044,7 +1045,8 @@ config SENSORS_SCH5636
 
 	  Currently this driver only supports the Fujitsu Theseus SCH5636 based
 	  hwmon solution. Say yes here if you want support for the Fujitsu
-	  Theseus' hardware monitoring features.
+	  Theseus' hardware monitoring features including support for the
+	  integrated watchdog.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called sch5636.
diff --git a/drivers/hwmon/sch5627.c b/drivers/hwmon/sch5627.c
index 79b6dab..8ec6dfb 100644
--- a/drivers/hwmon/sch5627.c
+++ b/drivers/hwmon/sch5627.c
@@ -1,5 +1,5 @@
 /***************************************************************************
- *   Copyright (C) 2010-2011 Hans de Goede <hdegoede@redhat.com>           *
+ *   Copyright (C) 2010-2012 Hans de Goede <hdegoede@redhat.com>           *
  *                                                                         *
  *   This program is free software; you can redistribute it and/or modify  *
  *   it under the terms of the GNU General Public License as published by  *
@@ -79,6 +79,7 @@ static const char * const SCH5627_IN_LABELS[SCH5627_NO_IN] = {
 struct sch5627_data {
 	unsigned short addr;
 	struct device *hwmon_dev;
+	struct sch56xx_watchdog_data *watchdog;
 	u8 control;
 	u8 temp_max[SCH5627_NO_TEMPS];
 	u8 temp_crit[SCH5627_NO_TEMPS];
@@ -453,6 +454,9 @@ static int sch5627_remove(struct platform_device *pdev)
 {
 	struct sch5627_data *data = platform_get_drvdata(pdev);
 
+	if (data->watchdog)
+		sch56xx_watchdog_unregister(data->watchdog);
+
 	if (data->hwmon_dev)
 		hwmon_device_unregister(data->hwmon_dev);
 
@@ -574,6 +578,11 @@ static int __devinit sch5627_probe(struct platform_device *pdev)
 		goto error;
 	}
 
+	/* Note failing to register the watchdog is not a fatal error */
+	data->watchdog = sch56xx_watchdog_register(data->addr,
+			(build_code << 24) | (build_id << 8) | hwmon_rev,
+			&data->update_lock, 1);
+
 	return 0;
 
 error:
diff --git a/drivers/hwmon/sch5636.c b/drivers/hwmon/sch5636.c
index 9d5236f..906d4ed 100644
--- a/drivers/hwmon/sch5636.c
+++ b/drivers/hwmon/sch5636.c
@@ -1,5 +1,5 @@
 /***************************************************************************
- *   Copyright (C) 2011 Hans de Goede <hdegoede@redhat.com>                *
+ *   Copyright (C) 2011-2012 Hans de Goede <hdegoede@redhat.com>           *
  *                                                                         *
  *   This program is free software; you can redistribute it and/or modify  *
  *   it under the terms of the GNU General Public License as published by  *
@@ -67,6 +67,7 @@ static const u16 SCH5636_REG_FAN_VAL[SCH5636_NO_FANS] = {
 struct sch5636_data {
 	unsigned short addr;
 	struct device *hwmon_dev;
+	struct sch56xx_watchdog_data *watchdog;
 
 	struct mutex update_lock;
 	char valid;			/* !=0 if following fields are valid */
@@ -384,6 +385,9 @@ static int sch5636_remove(struct platform_device *pdev)
 	struct sch5636_data *data = platform_get_drvdata(pdev);
 	int i;
 
+	if (data->watchdog)
+		sch56xx_watchdog_unregister(data->watchdog);
+
 	if (data->hwmon_dev)
 		hwmon_device_unregister(data->hwmon_dev);
 
@@ -505,6 +509,11 @@ static int __devinit sch5636_probe(struct platform_device *pdev)
 		goto error;
 	}
 
+	/* Note failing to register the watchdog is not a fatal error */
+	data->watchdog = sch56xx_watchdog_register(data->addr,
+					(revision[0] << 8) | revision[1],
+					&data->update_lock, 0);
+
 	return 0;
 
 error:
diff --git a/drivers/hwmon/sch56xx-common.c b/drivers/hwmon/sch56xx-common.c
index fac32ee..3693672 100644
--- a/drivers/hwmon/sch56xx-common.c
+++ b/drivers/hwmon/sch56xx-common.c
@@ -1,5 +1,5 @@
 /***************************************************************************
- *   Copyright (C) 2010-2011 Hans de Goede <hdegoede@redhat.com>           *
+ *   Copyright (C) 2010-2012 Hans de Goede <hdegoede@redhat.com>           *
  *                                                                         *
  *   This program is free software; you can redistribute it and/or modify  *
  *   it under the terms of the GNU General Public License as published by  *
@@ -26,8 +26,19 @@
 #include <linux/io.h>
 #include <linux/acpi.h>
 #include <linux/delay.h>
+#include <linux/fs.h>
+#include <linux/watchdog.h>
+#include <linux/miscdevice.h>
+#include <linux/uaccess.h>
+#include <linux/kref.h>
 #include "sch56xx-common.h"
 
+/* Insmod parameters */
+static int nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, int, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
+	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
 #define SIO_SCH56XX_LD_EM	0x0C	/* Embedded uController Logical Dev */
 #define SIO_UNLOCK_KEY		0x55	/* Key to enable Super-I/O */
 #define SIO_LOCK_KEY		0xAA	/* Key to disable Super-I/O */
@@ -40,13 +51,43 @@
 #define SIO_SCH5627_ID		0xC6	/* Chipset ID */
 #define SIO_SCH5636_ID		0xC7	/* Chipset ID */
 
-#define REGION_LENGTH		9
+#define REGION_LENGTH		10
 
 #define SCH56XX_CMD_READ	0x02
 #define SCH56XX_CMD_WRITE	0x03
 
+/* Watchdog registers */
+#define SCH56XX_REG_WDOG_PRESET		0x58B
+#define SCH56XX_REG_WDOG_CONTROL	0x58C
+#define SCH56XX_WDOG_TIME_BASE_SEC	0x01
+#define SCH56XX_REG_WDOG_OUTPUT_ENABLE	0x58E
+#define SCH56XX_WDOG_OUTPUT_ENABLE	0x02
+
+struct sch56xx_watchdog_data {
+	u16 addr;
+	u32 revision;
+	struct mutex *io_lock;
+	struct mutex watchdog_lock;
+	struct list_head list; /* member of the watchdog_data_list */
+	struct kref kref;
+	struct miscdevice watchdog_miscdev;
+	unsigned long watchdog_is_open;
+	char watchdog_name[10]; /* must be unique to avoid sysfs conflict */
+	char watchdog_expect_close;
+	u8 watchdog_preset;
+	u8 watchdog_control;
+	u8 watchdog_output_enable;
+};
+
 static struct platform_device *sch56xx_pdev;
 
+/* Somewhat ugly :( global data pointer list with all sch56xx devices, so that
+   we can find our device data as when using misc_register there is no other
+   method to get to ones device data from the open fop. */
+static LIST_HEAD(watchdog_data_list);
+/* Note this lock not only protect list access, but also data.kref access */
+static DEFINE_MUTEX(watchdog_data_mutex);
+
 /* Super I/O functions */
 static inline int superio_inb(int base, int reg)
 {
@@ -224,6 +265,468 @@ int sch56xx_read_virtual_reg12(u16 addr, u16 msb_reg, u16 lsn_reg,
 }
 EXPORT_SYMBOL(sch56xx_read_virtual_reg12);
 
+/*
+ * Watchdog routines
+ */
+
+/* Release our data struct when the platform device has been released *and*
+   all references to our watchdog device are released */
+static void sch56xx_watchdog_release_resources(struct kref *r)
+{
+	struct sch56xx_watchdog_data *data +		container_of(r, struct sch56xx_watchdog_data, kref);
+	kfree(data);
+}
+
+static int watchdog_set_timeout(struct sch56xx_watchdog_data *data,
+				int timeout)
+{
+	int ret, resolution;
+	u8 control;
+
+	/* 1 second or 60 second resolution? */
+	if (timeout <= 255)
+		resolution = 1;
+	else
+		resolution = 60;
+
+	if (timeout < resolution || timeout > (resolution * 255))
+		return -EINVAL;
+
+	mutex_lock(&data->watchdog_lock);
+	if (!data->addr) {
+		ret = -ENODEV;
+		goto leave;
+	}
+
+	if (resolution = 1)
+		control = data->watchdog_control | SCH56XX_WDOG_TIME_BASE_SEC;
+	else
+		control = data->watchdog_control & ~SCH56XX_WDOG_TIME_BASE_SEC;
+
+	if (data->watchdog_control != control) {
+		mutex_lock(data->io_lock);
+		ret = sch56xx_write_virtual_reg(data->addr,
+						SCH56XX_REG_WDOG_CONTROL,
+						control);
+		mutex_unlock(data->io_lock);
+		if (ret)
+			goto leave;
+
+		data->watchdog_control = control;
+	}
+
+	/* Remember new timeout value, but do not write as that (re)starts
+	   the watchdog countdown */
+	data->watchdog_preset = DIV_ROUND_UP(timeout, resolution);
+
+	ret = data->watchdog_preset * resolution;
+leave:
+	mutex_unlock(&data->watchdog_lock);
+	return ret;
+}
+
+static int watchdog_get_timeout(struct sch56xx_watchdog_data *data)
+{
+	int timeout;
+
+	mutex_lock(&data->watchdog_lock);
+	if (data->watchdog_control & SCH56XX_WDOG_TIME_BASE_SEC)
+		timeout = data->watchdog_preset;
+	else
+		timeout = data->watchdog_preset * 60;
+	mutex_unlock(&data->watchdog_lock);
+
+	return timeout;
+}
+
+static int watchdog_start(struct sch56xx_watchdog_data *data)
+{
+	int ret;
+	u8 val;
+
+	mutex_lock(&data->watchdog_lock);
+	if (!data->addr) {
+		ret = -ENODEV;
+		goto leave_unlock_watchdog;
+	}
+
+	/*
+	 * The sch56xx's watchdog cannot really be started / stopped
+	 * it is always running, but we can avoid the timer expiring
+	 * from causing a system reset by clearing the output enable bit.
+	 *
+	 * The sch56xx's watchdog will set the watchdog event bit, bit 0
+	 * of the second interrupt source register (at base-address + 9),
+	 * when the timer expires.
+	 *
+	 * This will only cause a system reset if the 0-1 flank happens when
+	 * output enable is true. Setting output enable after the flank will
+	 * not cause a reset, nor will the timer expiring a second time.
+	 * This means we must clear the watchdog event bit in case it is set.
+	 *
+	 * The timer may still be running (after a recent watchdog_stop) and
+	 * mere milliseconds away from expiring, so the timer must be reset
+	 * first!
+	 */
+
+	mutex_lock(data->io_lock);
+
+	/* 1. Reset the watchdog countdown counter */
+	ret = sch56xx_write_virtual_reg(data->addr, SCH56XX_REG_WDOG_PRESET,
+					data->watchdog_preset);
+	if (ret)
+		goto leave;
+
+	/* 2. Enable output (if not already enabled) */
+	if (!(data->watchdog_output_enable & SCH56XX_WDOG_OUTPUT_ENABLE)) {
+		val = data->watchdog_output_enable |
+		      SCH56XX_WDOG_OUTPUT_ENABLE;
+		ret = sch56xx_write_virtual_reg(data->addr,
+						SCH56XX_REG_WDOG_OUTPUT_ENABLE,
+						val);
+		if (ret)
+			goto leave;
+
+		data->watchdog_output_enable = val;
+	}
+
+	/* 3. Clear the watchdog event bit if set */
+	val = inb(data->addr + 9);
+	if (val & 0x01)
+		outb(0x01, data->addr + 9);
+
+leave:
+	mutex_unlock(data->io_lock);
+leave_unlock_watchdog:
+	mutex_unlock(&data->watchdog_lock);
+	return ret;
+}
+
+static int watchdog_trigger(struct sch56xx_watchdog_data *data)
+{
+	int ret;
+
+	mutex_lock(&data->watchdog_lock);
+	if (!data->addr) {
+		ret = -ENODEV;
+		goto leave;
+	}
+
+	/* Reset the watchdog countdown counter */
+	mutex_lock(data->io_lock);
+	ret = sch56xx_write_virtual_reg(data->addr, SCH56XX_REG_WDOG_PRESET,
+					data->watchdog_preset);
+	mutex_unlock(data->io_lock);
+leave:
+	mutex_unlock(&data->watchdog_lock);
+	return ret;
+}
+
+static int watchdog_stop_unlocked(struct sch56xx_watchdog_data *data)
+{
+	int ret = 0;
+	u8 val;
+
+	if (!data->addr)
+		return -ENODEV;
+
+	if (data->watchdog_output_enable & SCH56XX_WDOG_OUTPUT_ENABLE) {
+		val = data->watchdog_output_enable &
+		      ~SCH56XX_WDOG_OUTPUT_ENABLE;
+		mutex_lock(data->io_lock);
+		ret = sch56xx_write_virtual_reg(data->addr,
+						SCH56XX_REG_WDOG_OUTPUT_ENABLE,
+						val);
+		mutex_unlock(data->io_lock);
+		if (ret)
+			return ret;
+
+		data->watchdog_output_enable = val;
+	}
+
+	return ret;
+}
+
+static int watchdog_stop(struct sch56xx_watchdog_data *data)
+{
+	int ret;
+
+	mutex_lock(&data->watchdog_lock);
+	ret = watchdog_stop_unlocked(data);
+	mutex_unlock(&data->watchdog_lock);
+
+	return ret;
+}
+
+static int watchdog_release(struct inode *inode, struct file *filp)
+{
+	struct sch56xx_watchdog_data *data = filp->private_data;
+
+	if (data->watchdog_expect_close) {
+		watchdog_stop(data);
+		data->watchdog_expect_close = 0;
+	} else {
+		watchdog_trigger(data);
+		pr_crit("unexpected close, not stopping watchdog!\n");
+	}
+
+	clear_bit(0, &data->watchdog_is_open);
+
+	mutex_lock(&watchdog_data_mutex);
+	kref_put(&data->kref, sch56xx_watchdog_release_resources);
+	mutex_unlock(&watchdog_data_mutex);
+
+	return 0;
+}
+
+static int watchdog_open(struct inode *inode, struct file *filp)
+{
+	struct sch56xx_watchdog_data *pos, *data = NULL;
+	int ret, watchdog_is_open;
+
+	/* We get called from drivers/char/misc.c with misc_mtx hold, and we
+	   call misc_register() from sch56xx_watchdog_probe() with
+	   watchdog_data_mutex hold, as misc_register() takes the misc_mtx
+	   lock, this is a possible deadlock, so we use mutex_trylock here. */
+	if (!mutex_trylock(&watchdog_data_mutex))
+		return -ERESTARTSYS;
+	list_for_each_entry(pos, &watchdog_data_list, list) {
+		if (pos->watchdog_miscdev.minor = iminor(inode)) {
+			data = pos;
+			break;
+		}
+	}
+	/* Note we can never not have found data, so we don't check for this */
+	watchdog_is_open = test_and_set_bit(0, &data->watchdog_is_open);
+	if (!watchdog_is_open)
+		kref_get(&data->kref);
+	mutex_unlock(&watchdog_data_mutex);
+
+	if (watchdog_is_open)
+		return -EBUSY;
+
+	filp->private_data = data;
+
+	/* Start the watchdog */
+	ret = watchdog_start(data);
+	if (ret) {
+		watchdog_release(inode, filp);
+		return ret;
+	}
+
+	return nonseekable_open(inode, filp);
+}
+
+static ssize_t watchdog_write(struct file *filp, const char __user *buf,
+	size_t count, loff_t *offset)
+{
+	int ret;
+	struct sch56xx_watchdog_data *data = filp->private_data;
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
+		if (ret)
+			return ret;
+	}
+	return count;
+}
+
+static long watchdog_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	struct watchdog_info ident = {
+		.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT,
+		.identity = "sch56xx watchdog"
+	};
+	int i, ret = 0;
+	struct sch56xx_watchdog_data *data = filp->private_data;
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
+	case WDIOC_GETBOOTSTATUS:
+		ret = put_user(0, (int __user *)arg);
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
+		if (ret >= 0)
+			ret = put_user(ret, (int __user *)arg);
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
+ 		break;
+
+	default:
+		ret = -ENOTTY;
+	}
+	return ret;
+}
+
+static const struct file_operations watchdog_fops = {
+	.owner = THIS_MODULE,
+	.llseek = no_llseek,
+	.open = watchdog_open,
+	.release = watchdog_release,
+	.write = watchdog_write,
+	.unlocked_ioctl = watchdog_ioctl,
+};
+
+struct sch56xx_watchdog_data *sch56xx_watchdog_register(
+	u16 addr, u32 revision, struct mutex *io_lock, int check_enabled)
+{
+	struct sch56xx_watchdog_data *data;
+	int i, err, control, output_enable;
+	const int watchdog_minors[] = { WATCHDOG_MINOR, 212, 213, 214, 215 };
+
+	/* Cache the watchdog registers */
+	mutex_lock(io_lock);
+	control +		sch56xx_read_virtual_reg(addr, SCH56XX_REG_WDOG_CONTROL);
+	output_enable +		sch56xx_read_virtual_reg(addr, SCH56XX_REG_WDOG_OUTPUT_ENABLE);
+	mutex_unlock(io_lock);
+
+	if (control < 0)
+		return NULL;
+	if (output_enable < 0)
+		return NULL;
+	if (check_enabled && !(output_enable & SCH56XX_WDOG_OUTPUT_ENABLE)) {
+		pr_warn("Watchdog not enabled by BIOS, not registering\n");
+		return NULL;
+	}
+
+	data = kzalloc(sizeof(struct sch56xx_watchdog_data), GFP_KERNEL);
+	if (!data)
+		return NULL;
+
+	data->addr = addr;
+	data->revision = revision;
+	data->io_lock = io_lock;
+	data->watchdog_control = control;
+	data->watchdog_output_enable = output_enable;
+	mutex_init(&data->watchdog_lock);
+	INIT_LIST_HEAD(&data->list);
+	kref_init(&data->kref);
+
+	err = watchdog_set_timeout(data, 60);
+	if (err < 0)
+		goto error;
+
+	/* We take the data_mutex lock early so that watchdog_open() cannot
+	   run when misc_register() has completed, but we've not yet added
+	   our data to the watchdog_data_list */
+	mutex_lock(&watchdog_data_mutex);
+	for (i = 0; i < ARRAY_SIZE(watchdog_minors); i++) {
+		/* Register our watchdog part */
+		snprintf(data->watchdog_name, sizeof(data->watchdog_name),
+			"watchdog%c", (i = 0) ? '\0' : ('0' + i));
+		data->watchdog_miscdev.name = data->watchdog_name;
+		data->watchdog_miscdev.fops = &watchdog_fops;
+		data->watchdog_miscdev.minor = watchdog_minors[i];
+		err = misc_register(&data->watchdog_miscdev);
+		if (err = -EBUSY)
+			continue;
+		if (err)
+			break;
+
+		list_add(&data->list, &watchdog_data_list);
+		pr_info("Registered /dev/%s chardev major 10, minor: %d\n",
+			data->watchdog_name, watchdog_minors[i]);
+		break;
+	}
+	mutex_unlock(&watchdog_data_mutex);
+
+	if (err) {
+		pr_err("Registering watchdog chardev: %d\n", err);
+		goto error;
+	}
+	if (i = ARRAY_SIZE(watchdog_minors)) {
+		pr_warn("Couldn't register watchdog (no free minor)\n");
+		goto error;
+	}
+
+	return data;
+
+error:
+	kfree(data);
+	return NULL;
+}
+EXPORT_SYMBOL(sch56xx_watchdog_register);
+
+void sch56xx_watchdog_unregister(struct sch56xx_watchdog_data *data)
+{
+	mutex_lock(&watchdog_data_mutex);
+	misc_deregister(&data->watchdog_miscdev);
+	list_del(&data->list);
+	mutex_unlock(&watchdog_data_mutex);
+
+	mutex_lock(&data->watchdog_lock);
+	if (data->watchdog_is_open) {
+		pr_warn("platform device unregistered with watchdog "
+			"open! Stopping watchdog.\n");
+		watchdog_stop_unlocked(data);
+	}
+	/* Tell the wdog start/stop/trigger functions our dev is gone */
+	data->addr = 0;
+	data->io_lock = NULL;
+	mutex_unlock(&data->watchdog_lock);
+
+	mutex_lock(&watchdog_data_mutex);
+	kref_put(&data->kref, sch56xx_watchdog_release_resources);
+	mutex_unlock(&watchdog_data_mutex);
+}
+EXPORT_SYMBOL(sch56xx_watchdog_unregister);
+
+/*
+ * platform dev find, add and remove functions
+ */
+
 static int __init sch56xx_find(int sioaddr, unsigned short *address,
 			       const char **name)
 {
diff --git a/drivers/hwmon/sch56xx-common.h b/drivers/hwmon/sch56xx-common.h
index d5eaf3b..7475086 100644
--- a/drivers/hwmon/sch56xx-common.h
+++ b/drivers/hwmon/sch56xx-common.h
@@ -1,5 +1,5 @@
 /***************************************************************************
- *   Copyright (C) 2010-2011 Hans de Goede <hdegoede@redhat.com>           *
+ *   Copyright (C) 2010-2012 Hans de Goede <hdegoede@redhat.com>           *
  *                                                                         *
  *   This program is free software; you can redistribute it and/or modify  *
  *   it under the terms of the GNU General Public License as published by  *
@@ -17,8 +17,16 @@
  *   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             *
  ***************************************************************************/
 
+#include <linux/mutex.h>
+
+struct sch56xx_watchdog_data;
+
 int sch56xx_read_virtual_reg(u16 addr, u16 reg);
 int sch56xx_write_virtual_reg(u16 addr, u16 reg, u8 val);
 int sch56xx_read_virtual_reg16(u16 addr, u16 reg);
 int sch56xx_read_virtual_reg12(u16 addr, u16 msb_reg, u16 lsn_reg,
 			       int high_nibble);
+
+struct sch56xx_watchdog_data *sch56xx_watchdog_register(
+	u16 addr, u32 revision, struct mutex *io_lock, int check_enabled);
+void sch56xx_watchdog_unregister(struct sch56xx_watchdog_data *data);
-- 
1.7.9.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
