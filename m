From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 12 Sep 2011 09:57:00 +0000
Subject: [lm-sensors] [PATCH 5/5] hwmon/sch5636: Add support for the
Message-Id: <1315821420-16205-6-git-send-email-hdegoede@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1315821420-16205-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1315821420-16205-1-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-watchdog@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Wim Van Sebroeck <wim@iguana.be>, LM Sensors <lm-sensors@lm-sensors.org>, Thilo Cestonaro <thilo.cestonaro@ts.fujitsu.com>, Hans de Goede <hdegoede@redhat.com>

Add support for the watchdog integrated into the (Fujitsu Theseus version of)
the sch5636 superio hwmon part. Using the new watchdog timer core.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hwmon/sch5636.c |  233 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 231 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/sch5636.c b/drivers/hwmon/sch5636.c
index 244407a..8cf3630 100644
--- a/drivers/hwmon/sch5636.c
+++ b/drivers/hwmon/sch5636.c
@@ -28,14 +28,23 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
+#include <linux/watchdog.h>
+#include <linux/kref.h>
 #include "sch56xx-common.h"
 
+/* Insmod parameters */
+static int nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, int, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
+	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
 #define DRVNAME "sch5636"
 #define DEVNAME "theseus" /* We only support one model for now */
 
 #define SCH5636_REG_FUJITSU_ID		0x780
 #define SCH5636_REG_FUJITSU_REV		0x783
 
+/* hwmon registers */
 #define SCH5636_NO_INS			5
 #define SCH5636_NO_TEMPS		16
 #define SCH5636_NO_FANS			8
@@ -63,11 +72,18 @@ static const u16 SCH5636_REG_FAN_VAL[SCH5636_NO_FANS] = {
 #define SCH5636_FAN_NOT_PRESENT		0x08
 #define SCH5636_FAN_DEACTIVATED		0x80
 
+/* Watchdog registers */
+#define SCH5636_REG_WDOG_PRESET		0x58B
+#define SCH5636_REG_WDOG_CONTROL	0x58C
+#define SCH5636_WDOG_TIME_BASE_SEC	0x01
+#define SCH5636_REG_WDOG_OUTPUT_ENABLE	0x58E
+#define SCH5636_WDOG_OUTPUT_ENABLE	0x02
 
 struct sch5636_data {
 	unsigned short addr;
-	struct device *hwmon_dev;
 
+	/* hwmon related variables */
+	struct device *hwmon_dev;
 	struct mutex update_lock;
 	char valid;			/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
@@ -76,8 +92,25 @@ struct sch5636_data {
 	u8 temp_ctrl[SCH5636_NO_TEMPS];
 	u16 fan_val[SCH5636_NO_FANS];
 	u8 fan_ctrl[SCH5636_NO_FANS];
+
+	/* watchdog related variables */
+	struct watchdog_device wddev;
+	struct watchdog_info wdinfo;
+	struct kref kref;
+	bool watchdog_registered;
+	u8 watchdog_preset;
+	u8 watchdog_control;
+	u8 watchdog_output_enable;
 };
 
+/* Release our data struct when the platform device has been released *and*
+   all references to our watchdog device are released */
+static void sch5636_release_resources(struct kref *r)
+{
+	struct sch5636_data *data = container_of(r, struct sch5636_data, kref);
+	kfree(data);
+}
+
 static struct sch5636_data *sch5636_update_device(struct device *dev)
 {
 	struct sch5636_data *data = dev_get_drvdata(dev);
@@ -379,11 +412,154 @@ static struct sensor_device_attribute sch5636_fan_attr[] = {
 	SENSOR_ATTR(fan8_alarm, 0444, show_fan_alarm, NULL, 7),
 };
 
+/*
+ * Watchdog routines
+ */
+
+static int watchdog_set_timeout(struct watchdog_device *wddev,
+				unsigned int timeout)
+{
+	struct sch5636_data *data = watchdog_get_drvdata(wddev);
+	int err, resolution;
+	u8 control;
+
+	/* 1 second or 60 second resolution? */
+	if (timeout <= 255)
+		resolution = 1;
+	else
+		resolution = 60;
+
+	if (resolution = 1)
+		control = data->watchdog_control | SCH5636_WDOG_TIME_BASE_SEC;
+	else
+		control = data->watchdog_control & ~SCH5636_WDOG_TIME_BASE_SEC;
+
+	if (data->watchdog_control != control) {
+		err = sch56xx_write_virtual_reg(data->addr,
+						SCH5636_REG_WDOG_CONTROL,
+						control);
+		if (err)
+			return err;
+
+		data->watchdog_control = control;
+	}
+
+	/* Remember new timeout value, but do not write as that (re)starts
+	   the watchdog countdown */
+	data->watchdog_preset = DIV_ROUND_UP(timeout, resolution);
+	wddev->timeout = data->watchdog_preset * resolution;
+
+	return 0;
+}
+
+static int watchdog_start(struct watchdog_device *wddev)
+{
+	struct sch5636_data *data = watchdog_get_drvdata(wddev);
+	int err;
+	u8 val;
+
+	/*
+	 * The sch5636's watchdog cannot really be started / stopped
+	 * it is always running, but we can avoid the timer expiring
+	 * from causing a system reset by clearing the output enable bit.
+	 *
+	 * The sch5636's watchdog will set the watchdog event bit, bit 0
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
+	/* 1. Reset the watchdog countdown counter */
+	err = sch56xx_write_virtual_reg(data->addr, SCH5636_REG_WDOG_PRESET,
+					data->watchdog_preset);
+	if (err)
+		return err;
+
+	/* 2. Enable output (if not already enabled) */
+	val = data->watchdog_output_enable | SCH5636_WDOG_OUTPUT_ENABLE;
+	err = sch56xx_write_virtual_reg(data->addr,
+					SCH5636_REG_WDOG_OUTPUT_ENABLE, val);
+	if (err)
+		return err;
+	data->watchdog_output_enable = val;
+
+	/* 3. Clear the watchdog event bit if set */
+	val = inb(data->addr + 9);
+	if (val & 0x01)
+		outb(0x01, data->addr + 9);
+
+	return 0;
+}
+
+static int watchdog_trigger(struct watchdog_device *wddev)
+{
+	struct sch5636_data *data = watchdog_get_drvdata(wddev);
+
+	/* Reset the watchdog countdown counter */
+	return sch56xx_write_virtual_reg(data->addr, SCH5636_REG_WDOG_PRESET,
+					 data->watchdog_preset);
+}
+
+static int watchdog_stop(struct watchdog_device *wddev)
+{
+	struct sch5636_data *data = watchdog_get_drvdata(wddev);
+	int err;
+	u8 val;
+
+	val = data->watchdog_output_enable & ~SCH5636_WDOG_OUTPUT_ENABLE;
+	err = sch56xx_write_virtual_reg(data->addr,
+					SCH5636_REG_WDOG_OUTPUT_ENABLE, val);
+	if (err)
+		return err;
+	data->watchdog_output_enable = val;
+
+	return 0;
+}
+
+static void watchdog_ref(struct watchdog_device *wddev)
+{
+	struct sch5636_data *data = watchdog_get_drvdata(wddev);
+
+	kref_get(&data->kref);
+}
+
+static void watchdog_unref(struct watchdog_device *wddev)
+{
+	struct sch5636_data *data = watchdog_get_drvdata(wddev);
+
+	kref_put(&data->kref, sch5636_release_resources);
+}
+
+static const struct watchdog_ops watchdog_ops = {
+	.owner		= THIS_MODULE,
+	.start		= watchdog_start,
+	.stop		= watchdog_stop,
+	.ref		= watchdog_ref,
+	.unref		= watchdog_unref,
+	.ping		= watchdog_trigger,
+	.set_timeout	= watchdog_set_timeout,
+};
+
+/*
+ * Remove, probe, register and unregister device functions
+ */
+
 static int sch5636_remove(struct platform_device *pdev)
 {
 	struct sch5636_data *data = platform_get_drvdata(pdev);
 	int i;
 
+	if (data->watchdog_registered)
+		watchdog_unregister_device(&data->wddev);
+
 	if (data->hwmon_dev)
 		hwmon_device_unregister(data->hwmon_dev);
 
@@ -399,7 +575,7 @@ static int sch5636_remove(struct platform_device *pdev)
 				   &sch5636_fan_attr[i].dev_attr);
 
 	platform_set_drvdata(pdev, NULL);
-	kfree(data);
+	kref_put(&data->kref, sch5636_release_resources);
 
 	return 0;
 }
@@ -416,6 +592,7 @@ static int __devinit sch5636_probe(struct platform_device *pdev)
 
 	data->addr = platform_get_resource(pdev, IORESOURCE_IO, 0)->start;
 	mutex_init(&data->update_lock);
+	kref_init(&data->kref);
 	platform_set_drvdata(pdev, data);
 
 	for (i = 0; i < 3; i++) {
@@ -450,6 +627,8 @@ static int __devinit sch5636_probe(struct platform_device *pdev)
 	pr_info("Found %s chip at %#hx, revison: %d.%02d\n", DEVNAME,
 		data->addr, revision[0], revision[1]);
 
+	/********* hwmon initialization *********/
+
 	/* Read all temp + fan ctrl registers to determine which are active */
 	for (i = 0; i < SCH5636_NO_TEMPS; i++) {
 		val = sch56xx_read_virtual_reg(data->addr,
@@ -505,6 +684,56 @@ static int __devinit sch5636_probe(struct platform_device *pdev)
 		goto error;
 	}
 
+	/********* watchdog initialization *********/
+
+	data->wdinfo.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT;
+	strlcpy(data->wdinfo.identity, "Fujitsu watchdog",
+		sizeof(data->wdinfo.identity));
+	data->wdinfo.firmware_version = revision[0];
+	data->wddev.info = &data->wdinfo;
+	data->wddev.ops = &watchdog_ops;
+	data->wddev.min_timeout = 1;
+	data->wddev.max_timeout = 255 * 60;
+	if (nowayout)
+		data->wddev.status |= WDOG_NO_WAY_OUT;
+	else
+		data->wdinfo.options |= WDIOF_MAGICCLOSE;
+
+	/* Since the watchdog uses a downcounter there is no register to read
+	   the BIOS set timeout from (if any was set at all) -> choose a preset
+	   which will give us a 1 minute timeout */
+	val = sch56xx_read_virtual_reg(data->addr, SCH5636_REG_WDOG_CONTROL);
+	if (val < 0) {
+		err = val;
+		goto error;
+	}
+	data->watchdog_control = val;
+	if (data->watchdog_control & SCH5636_WDOG_TIME_BASE_SEC)
+		data->watchdog_preset = 60; /* seconds */
+	else
+		data->watchdog_preset = 1; /* minute */
+	data->wddev.timeout = 60;
+
+	/* Check if the watchdog was already enabled by the BIOS */
+	val = sch56xx_read_virtual_reg(data->addr,
+				       SCH5636_REG_WDOG_OUTPUT_ENABLE);
+	if (val < 0) {
+		err = val;
+		goto error;
+	}
+	data->watchdog_output_enable = val;
+	if (data->watchdog_output_enable & SCH5636_WDOG_OUTPUT_ENABLE)
+		data->wddev.status |= WDOG_ACTIVE;
+
+	/*
+	 * Note we don't abort on failure to register the watchdog, as we
+	 * still want to stick around for the hwmon stuff.
+	 */
+	watchdog_set_drvdata(&data->wddev, data);
+	err = watchdog_register_device(&data->wddev);
+	if (!err)
+		data->watchdog_registered = true;
+
 	return 0;
 
 error:
-- 
1.7.6.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
