From: Daniel Willerud <daniel.willerud@stericsson.com>
Date: Mon, 29 Aug 2011 07:58:30 +0000
Subject: [lm-sensors] Notifier in hwmon
Message-Id: <4E5B46A6.7010509@stericsson.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------040506000700040002000608"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--------------040506000700040002000608
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I need our hwmon driver to notify the sysctrl driver if there is a 
thermal warning when powering off the system.

Please advice whether it is a good idea to add the notifier to the core 
hwmon driver. I've attached the hwmon patch and our driver using the 
notification.

Regards,
/Daniel Willerud

-- 
Daniel WILLERUD  M.Sc.EE
CPO Core Platform
Software Developer

.---------------._
| .'            | |   ST-Ericsson
| O0o  ST       | |   Nya Vattentornet
|  o0O ERICSSON | |   SE-221 83 Lund, Sweden
|   ,"          | |   www.stericsson.com
'---------------' |
   '---------------'

Mobile: +46706332670
Email: daniel.willerud@stericsson.com

This communication is confidential and intended solely for the 
addressee(s). Any unauthorized review, use, disclosure or distribution 
is prohibited. If you believe this message has been sent to you in 
error, please notify the sender by replying to this transmission and 
delete the message without disclosing it. Thank you.
E-mail including attachments is susceptible to data corruption, 
interception, unauthorized amendment, tampering and viruses, and we only 
send and receive emails on the basis that we are not liable for any such 
corruption, interception, amendment, tampering or viruses or any 
consequences thereof.

--------------040506000700040002000608
Content-Type: text/x-patch;
	name="0001-hwmon-Adding-notifiers-to-hwmon.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-hwmon-Adding-notifiers-to-hwmon.patch"

From 6534673d29d78d54661f9c1e6ab4cc2bff3f6933 Mon Sep 17 00:00:00 2001
From: Daniel Willerud <daniel.willerud@stericsson.com>
Date: Fri, 26 Aug 2011 10:49:11 +0200
Subject: [PATCH 1/2] hwmon: Adding notifiers to hwmon

ST-Ericsson ID: 354533
ST-Ericsson Linux next: Not tested
ST-Ericsson FOSS-OUT ID: Trivial

Change-Id: I068a3c801405b6f7ca2b78df7cd9f7461ed8738b
Signed-off-by: Daniel Willerud <daniel.willerud@stericsson.com>
---
 drivers/hwmon/hwmon.c |   21 ++++++++++++++++++++-
 include/linux/hwmon.h |    5 +++++
 2 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 29ea675..9634342 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -19,6 +19,7 @@
 #include <linux/gfp.h>
 #include <linux/spinlock.h>
 #include <linux/pci.h>
+#include <linux/notifier.h>
 
 #define HWMON_ID_PREFIX "hwmon"
 #define HWMON_ID_FORMAT HWMON_ID_PREFIX "%d"
@@ -27,7 +28,7 @@ static struct class *hwmon_class;
 
 static DEFINE_IDR(hwmon_idr);
 static DEFINE_SPINLOCK(idr_lock);
-
+static BLOCKING_NOTIFIER_HEAD(hwmon_notifier_list);
 /**
  * hwmon_device_register - register w/ hwmon
  * @dev: the device to register
@@ -87,6 +88,24 @@ void hwmon_device_unregister(struct device *dev)
 			"hwmon_device_unregister() failed: bad class ID!\n");
 }
 
+int hwmon_notifier_register(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&hwmon_notifier_list, nb);
+}
+EXPORT_SYMBOL(hwmon_notifier_register);
+
+int hwmon_notifier_unregister(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&hwmon_notifier_list, nb);
+}
+EXPORT_SYMBOL(hwmon_notifier_unregister);
+
+void hwmon_notify(unsigned long val, void *v)
+{
+	blocking_notifier_call_chain(&hwmon_notifier_list, val, v);
+}
+EXPORT_SYMBOL(hwmon_notify);
+
 static void __init hwmon_pci_quirks(void)
 {
 #if defined CONFIG_X86 && defined CONFIG_PCI
diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
index 6b6ee70..8e891b5 100644
--- a/include/linux/hwmon.h
+++ b/include/linux/hwmon.h
@@ -15,11 +15,16 @@
 #define _HWMON_H_
 
 #include <linux/device.h>
+#include <linux/notifier.h>
 
 struct device *hwmon_device_register(struct device *dev);
 
 void hwmon_device_unregister(struct device *dev);
 
+int hwmon_notifier_register(struct notifier_block *nb);
+int hwmon_notifier_unregister(struct notifier_block *nb);
+void hwmon_notify(unsigned long val, void *v);
+
 /* Scale user input to sensible values */
 static inline int SENSORS_LIMIT(long value, long low, long high)
 {
-- 
1.7.4.1


--------------040506000700040002000608
Content-Type: text/x-csrc; name="ab8500.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="ab8500.c"

/*
 * Copyright (C) ST-Ericsson SA 2010
 * Author: Martin Persson <martin.persson@stericsson.com> for
 * ST-Ericsson.
 * License terms: GNU Gereral Public License (GPL) version 2
 *
 * Note:
 *
 * If/when the AB8500 thermal warning temperature is reached (threshold
 * cannot be changed by SW), an interrupt is set and the driver
 * notifies user space via a sysfs event. If a shut down is not
 * triggered by user space within a certain time frame,
 * pm_power off is called.
 *
 * If/when AB8500 thermal shutdown temperature is reached a hardware
 * shutdown of the AB8500 will occur.
 */

#include <linux/slab.h>
#include <linux/err.h>
#include <linux/hwmon.h>
#include <linux/sysfs.h>
#include <linux/hwmon-sysfs.h>
#include <linux/platform_device.h>
#include <linux/mfd/ab8500/ab8500-gpadc.h>
#include <linux/mfd/ab8500/ab8500-bm.h>
#include "abx500.h"

#define DEFAULT_POWER_OFF_DELAY 10000

/*
 * The driver monitors GPADC - ADC_AUX1, ADC_AUX2, BTEMP_BALL
 * and BAT_CTRL.
 */
#define NUM_MONITORED_SENSORS 4

static int ab8500_read_sensor(struct abx500_temp *data, u8 sensor)
{
	int val;
	/*
	 * Special treatment for the BAT_CTRL node, since this
	 * temperature measurement is more complex than just
	 * an ADC readout
	 *
	 * DIE_TEMP input temperature reading is not supported
	 * in AB8500
	 */
	if (sensor == DIE_TEMP)
		val = 0;
	else if (sensor == BAT_CTRL)
		val = ab8500_btemp_get_batctrl_temp(data->ab8500_btemp);
	else
		val = ab8500_gpadc_convert(data->ab8500_gpadc, sensor);

	return val;
}

static void ab8500_thermal_power_off(struct work_struct *work)
{
	struct abx500_temp *data = container_of(work, struct abx500_temp,
						power_off_work.work);

	dev_warn(&data->pdev->dev, "Power off due to AB8500 thermal warning\n");
	pm_power_off();
}

static ssize_t ab8500_show_name(struct device *dev,
				struct device_attribute *devattr,
				char *buf)
{
	return sprintf(buf, "ab8500\n");
}

static ssize_t ab8500_show_label(struct device *dev,
				struct device_attribute *devattr,
				char *buf)
{
	char *name;
	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	int index = attr->index;

	/*
	 * Make sure these labels correspond to the attribute indexes
	 * used when calling SENSOR_DEVICE_ATRR.
	 * Temperature sensors outside ab8500 (read via GPADC) are marked
	 * with prefix ext_
	 */
	switch (index) {
	case 1:
		name = "ext_rtc_xtal";
		break;
	case 2:
		name = "ext_db8500";
		break;
	case 3:
		name = "bat_temp";
		break;
	case 4:
		name = "bat_ctrl";
		break;
	case 5:
		name = "ab8500";
		break;
	default:
		return -EINVAL;
	}
	return sprintf(buf, "%s\n", name);
}

static int ab8500_temp_irq_handler(int irq, struct abx500_temp *data)
{
	unsigned long delay_in_jiffies;
	/*
	 * Make sure the magic numbers below corresponds to the node
	 * used for AB8500 thermal warning from HW.
	 */
	mutex_lock(&data->lock);
	data->crit_alarm[4] = 1;
	mutex_unlock(&data->lock);

	hwmon_notify(data->crit_alarm[4], NULL);
	sysfs_notify(&data->pdev->dev.kobj, NULL, "temp5_crit_alarm");
	dev_info(&data->pdev->dev, "AB8500 thermal warning,"
		" power off in %lu s\n", data->power_off_delay);
	delay_in_jiffies = msecs_to_jiffies(data->power_off_delay);
	schedule_delayed_work(&data->power_off_work, delay_in_jiffies);
	return 0;
}

int __init abx500_hwmon_init(struct abx500_temp *data)
{
	data->ab8500_gpadc = ab8500_gpadc_get();
	if (IS_ERR(data->ab8500_gpadc))
		return PTR_ERR(data->ab8500_gpadc);

	data->ab8500_btemp = ab8500_btemp_get();
	if (IS_ERR(data->ab8500_btemp))
		return PTR_ERR(data->ab8500_btemp);

	INIT_DELAYED_WORK(&data->power_off_work, ab8500_thermal_power_off);

	/*
	 * Setup HW defined data.
	 *
	 * Reference hardware (HREF):
	 *
	 * GPADC - ADC_AUX1, connected to NTC R2148 next to RTC_XTAL on HREF
	 * GPADC - ADC_AUX2, connected to NTC R2150 near DB8500 on HREF
	 * Hence, temp#_min/max/max_hyst refer to millivolts and not
	 * millidegrees
	 * This is not the case for BAT_CTRL where millidegrees is used
	 *
	 * HREF HW does not support reading AB8500 temperature. BUT an
	 * AB8500 IRQ will be launched if die crit temp limit is reached.
	 *
	 * Make sure indexes correspond to the attribute indexes
	 * used when calling SENSOR_DEVICE_ATRR
	 */
	data->gpadc_addr[0] = ADC_AUX1;
	data->gpadc_addr[1] = ADC_AUX2;
	data->gpadc_addr[2] = BTEMP_BALL;
	data->gpadc_addr[3] = BAT_CTRL;
	data->gpadc_addr[4] = DIE_TEMP;
	data->power_off_delay = DEFAULT_POWER_OFF_DELAY;
	data->monitored_sensors = NUM_MONITORED_SENSORS;

	data->ops.read_sensor = ab8500_read_sensor;
	data->ops.irq_handler = ab8500_temp_irq_handler;
	data->ops.show_name  = ab8500_show_name;
	data->ops.show_label = ab8500_show_label;

	return 0;
}

--------------040506000700040002000608
Content-Type: text/x-csrc; name="abx500.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="abx500.c"

/*
 * Copyright (C) ST-Ericsson SA 2010
 * Author: Martin Persson <martin.persson@stericsson.com> for
 * ST-Ericsson.
 * License terms: GNU Gereral Public License (GPL) version 2
 *
 * Note:
 *
 * ABX500 does not provide auto ADC, so to monitor the required
 * temperatures, a periodic work is used. It is more important
 * to not wake up the CPU than to perform this job, hence the use
 * of a deferred delay.
 *
 * A deferred delay for thermal monitor is considered safe because:
 * If the chip gets too hot during a sleep state it's most likely
 * due to external factors, such as the surrounding temperature.
 * I.e. no SW decisions will make any difference.
 *
 * If/when the ABX500 thermal warning temperature is reached (threshold
 * cannot be changed by SW), an interrupt is set and the driver
 * notifies user space via a sysfs event.
 *
 * If/when ABX500 thermal shutdown temperature is reached a hardware
 * shutdown of the ABX500 will occur.
 */

#include <linux/module.h>
#include <linux/slab.h>
#include <linux/hwmon.h>
#include <linux/sysfs.h>
#include <linux/hwmon-sysfs.h>
#include <linux/err.h>
#include <linux/platform_device.h>
#include <linux/interrupt.h>
#include <linux/workqueue.h>
#include <linux/jiffies.h>
#include <linux/mutex.h>
#include <linux/pm.h>
#include "abx500.h"

#define DEFAULT_MONITOR_DELAY 1000

/*
 * Thresholds are considered inactive if set to 0.
 * To avoid confusion for user space applications,
 * the temp monitor delay is set to 0 if all thresholds
 * are 0.
 */
static bool find_active_thresholds(struct abx500_temp *data)
{
	int i;
	for (i = 0; i < data->monitored_sensors; i++)
		if (data->max[i] != 0 || data->max_hyst[i] != 0
		    || data->min[i] != 0)
			return true;

	dev_dbg(&data->pdev->dev, "No active thresholds,"
		"cancel deferred job (if it exists)"
		"and reset temp monitor delay\n");
	cancel_delayed_work_sync(&data->work);
	return false;
}

static inline void schedule_monitor(struct abx500_temp *data)
{
	unsigned long delay_in_jiffies;
	delay_in_jiffies = msecs_to_jiffies(data->gpadc_monitor_delay);
	schedule_delayed_work(&data->work, delay_in_jiffies);
}

static inline void gpadc_monitor_exit(struct abx500_temp *data)
{
	cancel_delayed_work_sync(&data->work);
}

static void gpadc_monitor(struct work_struct *work)
{
	unsigned long delay_in_jiffies;
	int val, i, ret;
	/* Container for alarm node name */
	char alarm_node[30];

	bool updated_min_alarm = false;
	bool updated_max_alarm = false;
	bool updated_max_hyst_alarm = false;
	struct abx500_temp *data = container_of(work, struct abx500_temp,
						work.work);

	for (i = 0; i < data->monitored_sensors; i++) {
		/* Thresholds are considered inactive if set to 0 */
		if (data->max[i] == 0 && data->max_hyst[i] == 0
		    && data->min[i] == 0)
			continue;

		val = data->ops.read_sensor(data, data->gpadc_addr[i]);
		if (val < 0) {
			dev_err(&data->pdev->dev, "GPADC read failed\n");
				continue;
		}

		mutex_lock(&data->lock);
		if (data->min[i] != 0) {
			if (val < data->min[i]) {
				if (data->min_alarm[i] == 0) {
					data->min_alarm[i] = 1;
					updated_min_alarm = true;
				}
			} else {
				if (data->min_alarm[i] == 1) {
					data->min_alarm[i] = 0;
					updated_min_alarm = true;
				}
			}

		}
		if (data->max[i] != 0) {
			if (val > data->max[i]) {
				if (data->max_alarm[i] == 0) {
					data->max_alarm[i] = 1;
					updated_max_alarm = true;
				}
			} else {
				if (data->max_alarm[i] == 1) {
					data->max_alarm[i] = 0;
					updated_max_alarm = true;
				}
			}

		}
		if (data->max_hyst[i] != 0) {
			if (val > data->max_hyst[i]) {
				if (data->max_hyst_alarm[i] == 0) {
					data->max_hyst_alarm[i] = 1;
					updated_max_hyst_alarm = true;
				}
			} else {
				if (data->max_hyst_alarm[i] == 1) {
					data->max_hyst_alarm[i] = 0;
					updated_max_hyst_alarm = true;
				}
			}
		}
		mutex_unlock(&data->lock);

		/* hwmon attr index starts at 1, thus "i+1" below */
		if (updated_min_alarm) {
			ret = snprintf(alarm_node, 16, "temp%d_min_alarm",
				       (i + 1));
			if (ret < 0) {
				dev_err(&data->pdev->dev,
					"Unable to update alarm node (%d)",
					ret);
				break;
			}
			sysfs_notify(&data->pdev->dev.kobj, NULL, alarm_node);
		}
		if (updated_max_alarm) {
			ret = snprintf(alarm_node, 16, "temp%d_max_alarm",
				       (i + 1));
			if (ret < 0) {
				dev_err(&data->pdev->dev,
					"Unable to update alarm node (%d)",
					ret);
				break;
			}
			hwmon_notify(data->max_alarm[i], NULL);
			sysfs_notify(&data->pdev->dev.kobj, NULL, alarm_node);
		}
		if (updated_max_hyst_alarm) {
			ret = snprintf(alarm_node, 21, "temp%d_max_hyst_alarm",
				       (i + 1));
			if (ret < 0) {
				dev_err(&data->pdev->dev,
					"Unable to update alarm node (%d)",
					ret);
				break;
			}
			sysfs_notify(&data->pdev->dev.kobj, NULL, alarm_node);
		}
	}
	delay_in_jiffies = msecs_to_jiffies(data->gpadc_monitor_delay);
	schedule_delayed_work(&data->work, delay_in_jiffies);
}

static ssize_t set_temp_monitor_delay(struct device *dev,
				      struct device_attribute *devattr,
				      const char *buf, size_t count)
{
	int res;
	unsigned long delay_in_s;
	struct abx500_temp *data = dev_get_drvdata(dev);

	res = strict_strtoul(buf, 10, &delay_in_s);
	if (res < 0)
		return res;

	mutex_lock(&data->lock);
	data->gpadc_monitor_delay = delay_in_s * 1000;

	if (find_active_thresholds(data))
		schedule_monitor(data);

	mutex_unlock(&data->lock);

	return count;
}

static ssize_t set_temp_power_off_delay(struct device *dev,
					struct device_attribute *devattr,
					const char *buf, size_t count)
{
	int res;
	unsigned long delay_in_s;
	struct abx500_temp *data = dev_get_drvdata(dev);

	res = strict_strtoul(buf, 10, &delay_in_s);
	if (res < 0)
		return res;

	mutex_lock(&data->lock);
	data->power_off_delay = delay_in_s * 1000;
	mutex_unlock(&data->lock);

	return count;
}

static ssize_t show_temp_monitor_delay(struct device *dev,
				       struct device_attribute *devattr,
				       char *buf)
{
	struct abx500_temp *data = dev_get_drvdata(dev);
	/* return time in s, not ms */
	return sprintf(buf, "%lu\n", (data->gpadc_monitor_delay) / 1000);
}

static ssize_t show_temp_power_off_delay(struct device *dev,
					 struct device_attribute *devattr,
					 char *buf)
{
	struct abx500_temp *data = dev_get_drvdata(dev);
	/* return time in s, not ms */
	return sprintf(buf, "%lu\n", (data->power_off_delay) / 1000);
}

/* HWMON sysfs interface */
static ssize_t show_name(struct device *dev, struct device_attribute *devattr,
			 char *buf)
{
	/*
	 * To avoid confusion between sensor label and chip name, the function
	 * "show_label" is not used to return the chip name.
	 */
	struct abx500_temp *data = dev_get_drvdata(dev);
	return data->ops.show_name(dev, devattr, buf);
}

static ssize_t show_label(struct device *dev,
			  struct device_attribute *devattr, char *buf)
{
	struct abx500_temp *data = dev_get_drvdata(dev);
	return data->ops.show_label(dev, devattr, buf);
}

static ssize_t show_input(struct device *dev,
			  struct device_attribute *devattr, char *buf)
{
	int val;
	struct abx500_temp *data = dev_get_drvdata(dev);
	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	/* hwmon attr index starts at 1, thus "attr->index-1" below */
	u8 gpadc_addr = data->gpadc_addr[attr->index - 1];

	val = data->ops.read_sensor(data, gpadc_addr);
	if (val < 0)
		dev_err(&data->pdev->dev, "GPADC read failed\n");

	return sprintf(buf, "%d\n", val);
}

/* set functions (RW nodes) */
static ssize_t set_min(struct device *dev, struct device_attribute *devattr,
		       const char *buf, size_t count)
{
	unsigned long val;
	struct abx500_temp *data = dev_get_drvdata(dev);
	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	int res = strict_strtoul(buf, 10, &val);
	if (res < 0)
		return res;

	mutex_lock(&data->lock);
	/*
	 * Threshold is considered inactive if set to 0
	 * hwmon attr index starts at 1, thus "attr->index-1" below
	 */
	if (val == 0)
		data->min_alarm[attr->index - 1] = 0;

	data->min[attr->index - 1] = val;

	if (val == 0)
		(void) find_active_thresholds(data);
	else
		schedule_monitor(data);

	mutex_unlock(&data->lock);

	return count;
}

static ssize_t set_max(struct device *dev, struct device_attribute *devattr,
		       const char *buf, size_t count)
{
	unsigned long val;
	struct abx500_temp *data = dev_get_drvdata(dev);
	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	int res = strict_strtoul(buf, 10, &val);
	if (res < 0)
		return res;

	mutex_lock(&data->lock);
	/*
	 * Threshold is considered inactive if set to 0
	 * hwmon attr index starts at 1, thus "attr->index-1" below
	 */
	if (val == 0)
		data->max_alarm[attr->index - 1] = 0;

	data->max[attr->index - 1] = val;

	if (val == 0)
		(void) find_active_thresholds(data);
	else
		schedule_monitor(data);

	mutex_unlock(&data->lock);

	return count;
}

static ssize_t set_max_hyst(struct device *dev,
			    struct device_attribute *devattr,
			    const char *buf, size_t count)
{
	unsigned long val;
	struct abx500_temp *data = dev_get_drvdata(dev);
	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	int res = strict_strtoul(buf, 10, &val);
	if (res < 0)
		return res;

	mutex_lock(&data->lock);
	/*
	 * Threshold is considered inactive if set to 0
	 * hwmon attr index starts at 1, thus "attr->index-1" below
	 */
	if (val == 0)
		data->max_hyst_alarm[attr->index - 1] = 0;

	data->max_hyst[attr->index - 1] = val;

	if (val == 0)
		(void) find_active_thresholds(data);
	else
		schedule_monitor(data);

	mutex_unlock(&data->lock);

	return count;
}

/*
 * show functions (RO nodes)
 */
static ssize_t show_min(struct device *dev,
			struct device_attribute *devattr, char *buf)
{
	struct abx500_temp *data = dev_get_drvdata(dev);
	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	/* hwmon attr index starts at 1, thus "attr->index-1" below */
	return sprintf(buf, "%ld\n", data->min[attr->index - 1]);
}

static ssize_t show_max(struct device *dev,
			struct device_attribute *devattr, char *buf)
{
	struct abx500_temp *data = dev_get_drvdata(dev);
	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	/* hwmon attr index starts at 1, thus "attr->index-1" below */
	return sprintf(buf, "%ld\n", data->max[attr->index - 1]);
}

static ssize_t show_max_hyst(struct device *dev,
			     struct device_attribute *devattr, char *buf)
{
	struct abx500_temp *data = dev_get_drvdata(dev);
	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	/* hwmon attr index starts at 1, thus "attr->index-1" below */
	return sprintf(buf, "%ld\n", data->max_hyst[attr->index - 1]);
}

/* Alarms */
static ssize_t show_min_alarm(struct device *dev,
			      struct device_attribute *devattr, char *buf)
{
	struct abx500_temp *data = dev_get_drvdata(dev);
	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	/* hwmon attr index starts at 1, thus "attr->index-1" below */
	return sprintf(buf, "%ld\n", data->min_alarm[attr->index - 1]);
}

static ssize_t show_max_alarm(struct device *dev,
			      struct device_attribute *devattr, char *buf)
{
	struct abx500_temp *data = dev_get_drvdata(dev);
	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	/* hwmon attr index starts at 1, thus "attr->index-1" below */
	return sprintf(buf, "%ld\n", data->max_alarm[attr->index - 1]);
}

static ssize_t show_max_hyst_alarm(struct device *dev,
				   struct device_attribute *devattr, char *buf)
{
	struct abx500_temp *data = dev_get_drvdata(dev);
	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	/* hwmon attr index starts at 1, thus "attr->index-1" below */
	return sprintf(buf, "%ld\n", data->max_hyst_alarm[attr->index - 1]);
}

static ssize_t show_crit_alarm(struct device *dev,
			       struct device_attribute *devattr, char *buf)
{
	struct abx500_temp *data = dev_get_drvdata(dev);
	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	/* hwmon attr index starts at 1, thus "attr->index-1" below */
	return sprintf(buf, "%ld\n", data->crit_alarm[attr->index - 1]);
}

static SENSOR_DEVICE_ATTR(temp_monitor_delay, S_IRUGO | S_IWUSR,
			  show_temp_monitor_delay, set_temp_monitor_delay, 0);
static SENSOR_DEVICE_ATTR(temp_power_off_delay, S_IRUGO | S_IWUSR,
			  show_temp_power_off_delay,
			  set_temp_power_off_delay, 0);

/* Chip name, required by hwmon*/
static SENSOR_DEVICE_ATTR(name, S_IRUGO, show_name, NULL, 0);

/* GPADC - SENSOR1 */
static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, show_label, NULL, 1);
static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_input, NULL, 1);
static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_min, set_min, 1);
static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_max, set_max, 1);
static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO,
			  show_max_hyst, set_max_hyst, 1);
static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO, show_min_alarm, NULL, 1);
static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_max_alarm, NULL, 1);
static SENSOR_DEVICE_ATTR(temp1_max_hyst_alarm, S_IRUGO,
			  show_max_hyst_alarm, NULL, 1);

/* GPADC - SENSOR2 */
static SENSOR_DEVICE_ATTR(temp2_label, S_IRUGO, show_label, NULL, 2);
static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_input, NULL, 2);
static SENSOR_DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_min, set_min, 2);
static SENSOR_DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_max, set_max, 2);
static SENSOR_DEVICE_ATTR(temp2_max_hyst, S_IWUSR | S_IRUGO,
			  show_max_hyst, set_max_hyst, 2);
static SENSOR_DEVICE_ATTR(temp2_min_alarm, S_IRUGO, show_min_alarm, NULL, 2);
static SENSOR_DEVICE_ATTR(temp2_max_alarm, S_IRUGO, show_max_alarm, NULL, 2);
static SENSOR_DEVICE_ATTR(temp2_max_hyst_alarm, S_IRUGO,
			  show_max_hyst_alarm, NULL, 2);

/* GPADC - SENSOR3 */
static SENSOR_DEVICE_ATTR(temp3_label, S_IRUGO, show_label, NULL, 3);
static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, show_input, NULL, 3);
static SENSOR_DEVICE_ATTR(temp3_min, S_IWUSR | S_IRUGO, show_min, set_min, 3);
static SENSOR_DEVICE_ATTR(temp3_max, S_IWUSR | S_IRUGO, show_max, set_max, 3);
static SENSOR_DEVICE_ATTR(temp3_max_hyst, S_IWUSR | S_IRUGO,
			  show_max_hyst, set_max_hyst, 3);
static SENSOR_DEVICE_ATTR(temp3_min_alarm, S_IRUGO, show_min_alarm, NULL, 3);
static SENSOR_DEVICE_ATTR(temp3_max_alarm, S_IRUGO, show_max_alarm, NULL, 3);
static SENSOR_DEVICE_ATTR(temp3_max_hyst_alarm, S_IRUGO,
			  show_max_hyst_alarm, NULL, 3);

/* GPADC - SENSOR4 */
static SENSOR_DEVICE_ATTR(temp4_label, S_IRUGO, show_label, NULL, 4);
static SENSOR_DEVICE_ATTR(temp4_input, S_IRUGO, show_input, NULL, 4);
static SENSOR_DEVICE_ATTR(temp4_min, S_IWUSR | S_IRUGO, show_min, set_min, 4);
static SENSOR_DEVICE_ATTR(temp4_max, S_IWUSR | S_IRUGO, show_max, set_max, 4);
static SENSOR_DEVICE_ATTR(temp4_max_hyst, S_IWUSR | S_IRUGO,
			  show_max_hyst, set_max_hyst, 4);
static SENSOR_DEVICE_ATTR(temp4_min_alarm, S_IRUGO, show_min_alarm, NULL, 4);
static SENSOR_DEVICE_ATTR(temp4_max_alarm, S_IRUGO, show_max_alarm, NULL, 4);
static SENSOR_DEVICE_ATTR(temp4_max_hyst_alarm, S_IRUGO,
			  show_max_hyst_alarm, NULL, 4);

/* GPADC - SENSOR4 */
static SENSOR_DEVICE_ATTR(temp5_label, S_IRUGO, show_label, NULL, 5);
static SENSOR_DEVICE_ATTR(temp5_input, S_IRUGO, show_input, NULL, 5);
static SENSOR_DEVICE_ATTR(temp5_crit_alarm, S_IRUGO,
			  show_crit_alarm, NULL, 5);

struct attribute *abx500_temp_attributes[] = {
	&sensor_dev_attr_name.dev_attr.attr,
	&sensor_dev_attr_temp_monitor_delay.dev_attr.attr,
	&sensor_dev_attr_temp_power_off_delay.dev_attr.attr,
	/* GPADC SENSOR1 */
	&sensor_dev_attr_temp1_label.dev_attr.attr,
	&sensor_dev_attr_temp1_input.dev_attr.attr,
	&sensor_dev_attr_temp1_min.dev_attr.attr,
	&sensor_dev_attr_temp1_max.dev_attr.attr,
	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
	&sensor_dev_attr_temp1_min_alarm.dev_attr.attr,
	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
	&sensor_dev_attr_temp1_max_hyst_alarm.dev_attr.attr,
	/* GPADC SENSOR2 */
	&sensor_dev_attr_temp2_label.dev_attr.attr,
	&sensor_dev_attr_temp2_input.dev_attr.attr,
	&sensor_dev_attr_temp2_min.dev_attr.attr,
	&sensor_dev_attr_temp2_max.dev_attr.attr,
	&sensor_dev_attr_temp2_max_hyst.dev_attr.attr,
	&sensor_dev_attr_temp2_min_alarm.dev_attr.attr,
	&sensor_dev_attr_temp2_max_alarm.dev_attr.attr,
	&sensor_dev_attr_temp2_max_hyst_alarm.dev_attr.attr,
	/* GPADC SENSOR3 */
	&sensor_dev_attr_temp3_label.dev_attr.attr,
	&sensor_dev_attr_temp3_input.dev_attr.attr,
	&sensor_dev_attr_temp3_min.dev_attr.attr,
	&sensor_dev_attr_temp3_max.dev_attr.attr,
	&sensor_dev_attr_temp3_max_hyst.dev_attr.attr,
	&sensor_dev_attr_temp3_min_alarm.dev_attr.attr,
	&sensor_dev_attr_temp3_max_alarm.dev_attr.attr,
	&sensor_dev_attr_temp3_max_hyst_alarm.dev_attr.attr,
	/* GPADC SENSOR4 */
	&sensor_dev_attr_temp4_label.dev_attr.attr,
	&sensor_dev_attr_temp4_input.dev_attr.attr,
	&sensor_dev_attr_temp4_min.dev_attr.attr,
	&sensor_dev_attr_temp4_max.dev_attr.attr,
	&sensor_dev_attr_temp4_max_hyst.dev_attr.attr,
	&sensor_dev_attr_temp4_min_alarm.dev_attr.attr,
	&sensor_dev_attr_temp4_max_alarm.dev_attr.attr,
	&sensor_dev_attr_temp4_max_hyst_alarm.dev_attr.attr,
	/* GPADC SENSOR5*/
	&sensor_dev_attr_temp5_label.dev_attr.attr,
	&sensor_dev_attr_temp5_input.dev_attr.attr,
	&sensor_dev_attr_temp5_crit_alarm.dev_attr.attr,
	NULL
};

static const struct attribute_group abx500_temp_group = {
	.attrs = abx500_temp_attributes,
};

static irqreturn_t abx500_temp_irq_handler(int irq, void *irq_data)
{
	struct platform_device *pdev = irq_data;
	struct abx500_temp *data = platform_get_drvdata(pdev);
	data->ops.irq_handler(irq, data);
	return IRQ_HANDLED;
}

static int setup_irqs(struct platform_device *pdev)
{
	int ret;
	int irq = platform_get_irq_byname(pdev, "ABX500_TEMP_WARM");

	if (irq < 0)
		dev_err(&pdev->dev, "Get irq by name failed\n");

	ret = request_threaded_irq(irq, NULL, abx500_temp_irq_handler,
				   IRQF_NO_SUSPEND, "abx500-temp", pdev);
	if (ret < 0)
		dev_err(&pdev->dev, "Request threaded irq failed (%d)\n", ret);

	return ret;
}

static int __devinit abx500_temp_probe(struct platform_device *pdev)
{
	struct abx500_temp *data;
	int err;

	data = kzalloc(sizeof(struct abx500_temp), GFP_KERNEL);
	if (!data)
		return -ENOMEM;

	data->pdev = pdev;
	mutex_init(&data->lock);

	/* Chip specific initialization */
	err = abx500_hwmon_init(data);
	if (err	< 0) {
		dev_err(&pdev->dev, "abx500 init failed");
		goto exit;
	}

	data->hwmon_dev = hwmon_device_register(&pdev->dev);
	if (IS_ERR(data->hwmon_dev)) {
		err = PTR_ERR(data->hwmon_dev);
		dev_err(&pdev->dev, "Class registration failed (%d)\n", err);
		goto exit;
	}

	INIT_DELAYED_WORK_DEFERRABLE(&data->work, gpadc_monitor);
	data->gpadc_monitor_delay =  DEFAULT_MONITOR_DELAY;

	platform_set_drvdata(pdev, data);

	err = sysfs_create_group(&pdev->dev.kobj, &abx500_temp_group);
	if (err < 0) {
		dev_err(&pdev->dev, "Create sysfs group failed (%d)\n", err);
		goto exit_platform_data;
	}

	err = setup_irqs(pdev);
	if (err < 0) {
		dev_err(&pdev->dev, "irq setup failed (%d)\n", err);
		goto exit_sysfs_group;
	}
	return 0;

exit_sysfs_group:
	sysfs_remove_group(&pdev->dev.kobj, &abx500_temp_group);
exit_platform_data:
	hwmon_device_unregister(data->hwmon_dev);
	platform_set_drvdata(pdev, NULL);
exit:
	kfree(data->gpadc_auto);
	kfree(data);
	return err;
}

static int __devexit abx500_temp_remove(struct platform_device *pdev)
{
	struct abx500_temp *data = platform_get_drvdata(pdev);

	gpadc_monitor_exit(data);
	hwmon_device_unregister(data->hwmon_dev);
	sysfs_remove_group(&pdev->dev.kobj, &abx500_temp_group);
	platform_set_drvdata(pdev, NULL);
	kfree(data->gpadc_auto);
	kfree(data);
	return 0;
}

/* No action required in suspend/resume, thus the lack of functions */
static struct platform_driver abx500_temp_driver = {
	.driver = {
		.owner = THIS_MODULE,
		.name = "abx500-temp",
	},
	.probe = abx500_temp_probe,
	.remove = __devexit_p(abx500_temp_remove),
};

static int __init abx500_temp_init(void)
{
	return platform_driver_register(&abx500_temp_driver);
}

static void __exit abx500_temp_exit(void)
{
	platform_driver_unregister(&abx500_temp_driver);
}

MODULE_AUTHOR("Martin Persson <martin.persson@stericsson.com>");
MODULE_DESCRIPTION("ABX500 temperature driver");
MODULE_LICENSE("GPL");

module_init(abx500_temp_init)
module_exit(abx500_temp_exit)

--------------040506000700040002000608
Content-Type: text/x-chdr; name="abx500.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="abx500.h"

/*
 * Copyright (C) ST-Ericsson SA 2010
 * License terms: GNU General Public License v2
 * Author: Martin Persson <martin.persson@stericsson.com>
 */

#ifndef _ABX500_H
#define _ABX500_H

#define NUM_SENSORS 5

struct ab8500_gpadc;
struct ab5500_gpadc;
struct ab8500_btemp;
struct ab5500_btemp;
struct adc_auto_input;
struct abx500_temp;

/**
 * struct abx500_temp_ops - abx500 chip specific ops
 * @read_sensor: reads gpadc output
 * @irq_handler: irq handler
 * @show_name: hwmon device name
 * @show_label: hwmon attribute label
 */
struct abx500_temp_ops {
	int (*read_sensor)(struct abx500_temp *, u8);
	int (*irq_handler)(int, struct abx500_temp *);
	ssize_t (*show_name)(struct device *,
			struct device_attribute *, char *);
	ssize_t (*show_label) (struct device *,
			struct device_attribute *, char *);
};

/**
 * struct abx500_temp - representation of temp mon device
 * @pdev: platform device
 * @hwmon_dev: hwmon device
 * @ab8500_gpadc: gpadc interface for ab8500
 * @ab5500_gpadc: gpadc interface for ab5500
 * @btemp: battery temperature interface for ab8500
 * @adc_auto_input: gpadc auto trigger
 * @gpadc_addr: gpadc channel address
 * @temp: sensor temperature input value
 * @min: sensor temperature min value
 * @max: sensor temperature max value
 * @max_hyst: sensor temperature hysteresis value for max limit
 * @crit: sensor temperature critical value
 * @min_alarm: sensor temperature min alarm
 * @max_alarm: sensor temperature max alarm
 * @max_hyst_alarm: sensor temperature hysteresis alarm
 * @crit_alarm: sensor temperature critical value alarm
 * @work: delayed work scheduled to monitor temperature periodically
 * @power_off_work: delayed work scheduled to power off the system
		when critical temperature is reached
 * @lock: mutex
 * @gpadc_monitor_delay: delay between temperature readings in ms
 * @power_off_delay: delay before power off in ms
 * @monitored_sensors: number of monitored sensors
 */
struct abx500_temp {
	struct platform_device *pdev;
	struct device *hwmon_dev;
	struct ab8500_gpadc *ab8500_gpadc;
	struct ab5500_gpadc *ab5500_gpadc;
	struct ab8500_btemp *ab8500_btemp;
	struct ab5500_btemp *ab5500_btemp;
	struct adc_auto_input *gpadc_auto;
	struct abx500_temp_ops ops;
	u8 gpadc_addr[NUM_SENSORS];
	unsigned long temp[NUM_SENSORS];
	unsigned long min[NUM_SENSORS];
	unsigned long max[NUM_SENSORS];
	unsigned long max_hyst[NUM_SENSORS];
	unsigned long crit[NUM_SENSORS];
	unsigned long min_alarm[NUM_SENSORS];
	unsigned long max_alarm[NUM_SENSORS];
	unsigned long max_hyst_alarm[NUM_SENSORS];
	unsigned long crit_alarm[NUM_SENSORS];
	struct delayed_work work;
	struct delayed_work power_off_work;
	struct mutex lock;
	/* Delay (ms) between temperature readings */
	unsigned long gpadc_monitor_delay;
	/* Delay (ms) before power off */
	unsigned long power_off_delay;
	int monitored_sensors;
};

int abx500_hwmon_init(struct abx500_temp *data) __init;

#endif /* _ABX500_H */

--------------040506000700040002000608
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------040506000700040002000608--
