From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Wed, 19 Oct 2011 09:00:21 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon: add driver for ABx500 chips
Message-Id: <4E9E91A5.6060505@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1318929002-15813-1-git-send-email-linus.walleij@stericsson.com>
In-Reply-To: <1318929002-15813-1-git-send-email-linus.walleij@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 10/18/11 10:10, Linus Walleij wrote:
> From: Martin Persson <martin.r.persson@gmail.com>
> 
> The ST-Ericsson ABx500 Mixed-signals chips contain
> temperature sensors. These sensors are read utilizing the on-chip
> GPADC which we already have in the MFD subsystem.
> 
> This patch adds a driver for both chips, implemented with a
> central driver file with the code that is common for all
> abx500.c and then one file for the AB8500 chip called
> ab8500.c. The AB5500 is similar and we are using the same
> abx500 core, but its GPADC is not yet in the mainline kernel.
> 
> Most of the driver was written by Martin Persson, refactoring
> to work with several ABx500 chips were done by Rajagopala
> Venkataravanappax.

Hi All,

Various comments inline.
> 
> Signed-off-by: Martin Persson <martin.r.persson@gmail.com>
> Signed-off-by: Rajagopala V <rajagopala.v@stericsson.com>
> Signed-off-by: Daniel Willerud <daniel.willerud@stericsson.com>
> Signed-off-by: Johan Palsson <johan.palsson@stericsson.com>
> Signed-off-by: Chris Kimber <chris.kimber@stericsson.com>
> Signed-off-by: Huan Duan <huan.duan@stericsson.com>
> Signed-off-by: Philippe Langlais <philippe.langlais@linaro.org>
> Reviewed-by: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
> Reviewed-by: Jonas Aaberg <jonas.aberg@stericsson.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/hwmon/Kconfig     |   13 +
>  drivers/hwmon/Makefile    |    1 +
>  drivers/hwmon/ab8500.c    |  178 ++++++++++++
>  drivers/hwmon/abx500.c    |  692 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/hwmon/abx500.h    |   90 ++++++
>  drivers/mfd/ab8500-core.c |    4 +-
>  6 files changed, 976 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/hwmon/ab8500.c
>  create mode 100644 drivers/hwmon/abx500.c
>  create mode 100644 drivers/hwmon/abx500.h
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 0b62c3c..2640aea 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -39,6 +39,19 @@ config HWMON_DEBUG_CHIP
>  
>  comment "Native drivers"
>  
> +config SENSORS_AB8500
> +	tristate "AB8500 thermal monitoring"
> +	depends on AB8500_GPADC
> +	default n
> +	help
> +	  If you say yes here you get support for the thermal sensor part
> +	  of the AB8500 chip. The driver includes thermal management for
> +	  AB8500 die and two GPADC channels. The GPADC channel are preferably
> +	  used to access sensors outside the AB8500 chip.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called abx500-temp.
> +
>  config SENSORS_ABITUGURU
>  	tristate "Abit uGuru (rev 1 & 2)"
>  	depends on X86 && DMI && EXPERIMENTAL
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 3c9ccef..7991d40 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -19,6 +19,7 @@ obj-$(CONFIG_SENSORS_W83795)	+= w83795.o
>  obj-$(CONFIG_SENSORS_W83781D)	+= w83781d.o
>  obj-$(CONFIG_SENSORS_W83791D)	+= w83791d.o
>  
> +obj-$(CONFIG_SENSORS_AB8500)	+= abx500.o ab8500.o
>  obj-$(CONFIG_SENSORS_ABITUGURU)	+= abituguru.o
>  obj-$(CONFIG_SENSORS_ABITUGURU3)+= abituguru3.o
>  obj-$(CONFIG_SENSORS_AD7414)	+= ad7414.o
> diff --git a/drivers/hwmon/ab8500.c b/drivers/hwmon/ab8500.c
> new file mode 100644
> index 0000000..e0b1f48
> --- /dev/null
> +++ b/drivers/hwmon/ab8500.c
> @@ -0,0 +1,178 @@
> +/*
> + * Copyright (C) ST-Ericsson SA 2010
> + * Author: Martin Persson <martin.persson@stericsson.com> for
> + * ST-Ericsson.
> + * License terms: GNU Gereral Public License (GPL) version 2
> + *
> + * Note:
> + *
> + * If/when the AB8500 thermal warning temperature is reached (threshold
> + * cannot be changed by SW), an interrupt is set and the driver
> + * notifies user space via a sysfs event. If a shut down is not
> + * triggered by user space within a certain time frame,
> + * pm_power off is called.
> + *
> + * If/when AB8500 thermal shutdown temperature is reached a hardware
> + * shutdown of the AB8500 will occur.
> + */
> +
> +#include <linux/slab.h>
> +#include <linux/err.h>
> +#include <linux/hwmon.h>
> +#include <linux/sysfs.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/platform_device.h>
> +#include <linux/mfd/ab8500/gpadc.h>
> +#include "abx500.h"
> +
> +#define DEFAULT_POWER_OFF_DELAY 10000
> +
> +/*
> + * The driver monitors GPADC - ADC_AUX1, ADC_AUX2, BTEMP_BALL
> + * and BAT_CTRL.
> + */
> +#define NUM_MONITORED_SENSORS 4
> +
> +static int ab8500_read_sensor(struct abx500_temp *data, u8 sensor)
> +{
> +	int val;
> +	/*
> +	 * Special treatment for the BAT_CTRL node, since this
> +	 * temperature measurement is more complex than just
> +	 * an ADC readout
> +	 */
> +	if (sensor = BAT_CTRL) {
> +		dev_err(&data->pdev->dev, "battery sensor unsupported\n");
> +		val = -EINVAL;
> +	} else
> +		val = ab8500_gpadc_convert(data->ab8500_gpadc, sensor);
> +
> +	return val;
> +}
> +
> +static void ab8500_thermal_power_off(struct work_struct *work)
> +{
> +	struct abx500_temp *data = container_of(work, struct abx500_temp,
> +						power_off_work.work);
> +
> +	dev_warn(&data->pdev->dev, "Power off due to AB8500 thermal warning\n");
> +	pm_power_off();
> +}
> +
> +static ssize_t ab8500_show_name(struct device *dev,
> +				struct device_attribute *devattr,
> +				char *buf)
> +{
> +	return sprintf(buf, "ab8500\n");
> +}
> +
> +static ssize_t ab8500_show_label(struct device *dev,
> +				struct device_attribute *devattr,
> +				char *buf)
> +{
> +	char *name;
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	int index = attr->index;
> +
> +	/*
> +	 * Make sure these labels correspond to the attribute indexes
> +	 * used when calling SENSOR_DEVICE_ATRR.
> +	 * Temperature sensors outside ab8500 (read via GPADC) are marked
> +	 * with prefix ext_
> +	 */
A table of names would certainly be shorter. Perhaps not easier to understand though.
> +	switch (index) {
> +	case 1:
> +		name = "ext_rtc_xtal";
> +		break;
> +	case 2:
> +		name = "ext_db8500";
> +		break;
> +	case 3:
> +		name = "bat_temp";
> +		break;
> +	case 4:
> +		name = "bat_ctrl";
> +		break;
> +	case 5:
> +		name = "ab8500";
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	return sprintf(buf, "%s\n", name);
> +}
> +
This does seems a little backwards.  Drivers are obliged to figure
out what they don't support.  Seems destined for a mess given
new parts supported by the core code may add more attributes and
this way around you have to update all drivers to NOT leave
the new attributes visible.

Also, its a little cynical but you could do a strncmp on only
the temp5 bit could you not?
> +static int ab8500_is_visible(struct attribute *attr, int n)
> +{
> +	if (!strcmp(attr->name, "temp5_input") ||
> +	    !strcmp(attr->name, "temp5_min") ||
> +	    !strcmp(attr->name, "temp5_max") ||
> +	    !strcmp(attr->name, "temp5_max_hyst") ||
> +	    !strcmp(attr->name, "temp5_min_alarm") ||
> +	    !strcmp(attr->name, "temp5_max_alarm") ||
> +	    !strcmp(attr->name, "temp5_max_hyst_alarm"))
> +		return 0;
> +
> +	return attr->mode;
> +}
> +
> +static int ab8500_temp_irq_handler(int irq, struct abx500_temp *data)
> +{
> +	unsigned long delay_in_jiffies;
> +	/*
> +	 * Make sure the magic numbers below corresponds to the node
> +	 * used for AB8500 thermal warning from HW.
> +	 */
Which magic numbers?  None of them look all that magic to me!
> +	mutex_lock(&data->lock);
> +	data->crit_alarm[4] = 1;
> +	mutex_unlock(&data->lock);
> +
> +	sysfs_notify(&data->pdev->dev.kobj, NULL, "temp5_crit_alarm");
> +	dev_info(&data->pdev->dev, "AB8500 thermal warning,"
> +		" power off in %lu s\n", data->power_off_delay);
> +	delay_in_jiffies = msecs_to_jiffies(data->power_off_delay);
> +	schedule_delayed_work(&data->power_off_work, delay_in_jiffies);
> +	return 0;
> +}
> +
> +int __init abx500_hwmon_init(struct abx500_temp *data)
> +{
> +	data->ab8500_gpadc = ab8500_gpadc_get("ab8500-gpadc.0");
> +	if (IS_ERR(data->ab8500_gpadc))
> +		return PTR_ERR(data->ab8500_gpadc);
> +
> +	INIT_DELAYED_WORK(&data->power_off_work, ab8500_thermal_power_off);
> +
Does it make sense to have this comment here rather than say at the top?
Most of it doesn't seem to have much to do with the code in this function.
> +	/*
> +	 * Setup HW defined data.
> +	 *
> +	 * Reference hardware (HREF):
> +	 *
> +	 * GPADC - ADC_AUX1, connected to NTC R2148 next to RTC_XTAL on HREF
> +	 * GPADC - ADC_AUX2, connected to NTC R2150 near DB8500 on HREF
> +	 * Hence, temp#_min/max/max_hyst refer to millivolts and not
> +	 * millidegrees
> +	 * This is not the case for BAT_CTRL where millidegrees is used
> +	 *
> +	 * HREF HW does not support reading AB8500 temperature. BUT an
> +	 * AB8500 IRQ will be launched if die crit temp limit is reached.
> +	 *
> +	 * Make sure indexes correspond to the attribute indexes
> +	 * used when calling SENSOR_DEVICE_ATRR
> +	 */
> +	data->gpadc_addr[0] = ADC_AUX1;
> +	data->gpadc_addr[1] = ADC_AUX2;
> +	data->gpadc_addr[2] = BTEMP_BALL;
> +	data->gpadc_addr[3] = BAT_CTRL;
> +	data->gpadc_addr[4] = DIE_TEMP;
> +	data->power_off_delay = DEFAULT_POWER_OFF_DELAY;
> +	data->monitored_sensors = NUM_MONITORED_SENSORS;
> +
Make data->ops a pointer then use a static const struct for these
perhaps?  Are these different for the variants?  If not
why do we have this ops table in the first place.  If yes
then why are they put in place in a function named with
a prefix abx500?

> +	data->ops.read_sensor = ab8500_read_sensor;
> +	data->ops.irq_handler = ab8500_temp_irq_handler;
> +	data->ops.show_name  = ab8500_show_name;
> +	data->ops.show_label = ab8500_show_label;
> +	data->ops.is_visible = ab8500_is_visible;
> +
> +	return 0;
> +}
> diff --git a/drivers/hwmon/abx500.c b/drivers/hwmon/abx500.c
> new file mode 100644
> index 0000000..b9c8810
> --- /dev/null
> +++ b/drivers/hwmon/abx500.c
> @@ -0,0 +1,692 @@
> +/*
> + * Copyright (C) ST-Ericsson SA 2010
> + * Author: Martin Persson <martin.persson@stericsson.com> for
> + * ST-Ericsson.
> + * License terms: GNU Gereral Public License (GPL) version 2
> + *
> + * Note:
> + *
> + * ABX500 does not provide auto ADC, so to monitor the required
> + * temperatures, a periodic work is used. It is more important
> + * to not wake up the CPU than to perform this job, hence the use
> + * of a deferred delay.
> + *
> + * A deferred delay for thermal monitor is considered safe because:
> + * If the chip gets too hot during a sleep state it's most likely
> + * due to external factors, such as the surrounding temperature.
> + * I.e. no SW decisions will make any difference.
> + *
> + * If/when the ABX500 thermal warning temperature is reached (threshold
> + * cannot be changed by SW), an interrupt is set and the driver
> + * notifies user space via a sysfs event.
> + *
> + * If/when ABX500 thermal shutdown temperature is reached a hardware
> + * shutdown of the ABX500 will occur.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/hwmon.h>
> +#include <linux/sysfs.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/err.h>
> +#include <linux/platform_device.h>
> +#include <linux/interrupt.h>
> +#include <linux/workqueue.h>
> +#include <linux/jiffies.h>
> +#include <linux/mutex.h>
> +#include <linux/pm.h>
> +#include "abx500.h"
> +
> +#define DEFAULT_MONITOR_DELAY 1000
> +
> +/*
> + * Thresholds are considered inactive if set to 0.
> + * To avoid confusion for user space applications,
> + * the temp monitor delay is set to 0 if all thresholds
> + * are 0.
> + */
> +static bool find_active_thresholds(struct abx500_temp *data)
> +{
> +	int i;
> +	for (i = 0; i < data->monitored_sensors; i++)
> +		if (data->max[i] != 0 || data->max_hyst[i] != 0
> +		    || data->min[i] != 0)
> +			return true;
> +
> +	dev_dbg(&data->pdev->dev, "No active thresholds,"
> +		"cancel deferred job (if it exists)"
> +		"and reset temp monitor delay\n");
> +	cancel_delayed_work_sync(&data->work);
> +	return false;
> +}
> +
> +static inline void schedule_monitor(struct abx500_temp *data)
> +{
> +	unsigned long delay_in_jiffies;
> +	delay_in_jiffies = msecs_to_jiffies(data->gpadc_monitor_delay);
> +	schedule_delayed_work(&data->work, delay_in_jiffies);
> +}
> +
> +static inline void gpadc_monitor_exit(struct abx500_temp *data)
> +{
> +	cancel_delayed_work_sync(&data->work);
> +}
> +
> +static void gpadc_monitor(struct work_struct *work)
> +{
> +	unsigned long delay_in_jiffies;
> +	int val, i, ret;
> +	/* Container for alarm node name */
> +	char alarm_node[30];
> +
> +	bool updated_min_alarm = false;
> +	bool updated_max_alarm = false;
> +	bool updated_max_hyst_alarm = false;
> +	struct abx500_temp *data = container_of(work, struct abx500_temp,
> +						work.work);
> +
> +	for (i = 0; i < data->monitored_sensors; i++) {
> +		/* Thresholds are considered inactive if set to 0 */
> +		if (data->max[i] = 0 && data->max_hyst[i] = 0
> +		    && data->min[i] = 0)
> +			continue;
> +
> +		val = data->ops.read_sensor(data, data->gpadc_addr[i]);
> +		if (val < 0) {
> +			dev_err(&data->pdev->dev, "GPADC read failed\n");
> +				continue;
Could be my editor but I think the spacing looks weird here.
> +		}
> +
> +		mutex_lock(&data->lock);
> +		if (data->min[i] != 0) {
> +			if (val < data->min[i]) {
> +				if (data->min_alarm[i] = 0) {
if (val < data->min[i] && data->min_alarm[i] = 0) in one line
> +					data->min_alarm[i] = 1;
> +					updated_min_alarm = true;
> +				}
  else if on one line?
> +			} else {
> +				if (data->min_alarm[i] = 1) {
> +					data->min_alarm[i] = 0;
> +					updated_min_alarm = true;
> +				}
> +			}
> +
> +		}
> +		if (data->max[i] != 0) {
> +			if (val > data->max[i]) {
> +				if (data->max_alarm[i] = 0) {
> +					data->max_alarm[i] = 1;
> +					updated_max_alarm = true;
> +				}
> +			} else {
> +				if (data->max_alarm[i] = 1) {
> +					data->max_alarm[i] = 0;
> +					updated_max_alarm = true;
> +				}
> +			}
> +
> +		}
> +		if (data->max_hyst[i] != 0) {
again, why the stacked if statements?
> +			if (val > data->max_hyst[i]) {
> +				if (data->max_hyst_alarm[i] = 0) {
> +					data->max_hyst_alarm[i] = 1;
> +					updated_max_hyst_alarm = true;
> +				}
> +			} else {
> +				if (data->max_hyst_alarm[i] = 1) {
> +					data->max_hyst_alarm[i] = 0;
> +					updated_max_hyst_alarm = true;
> +				}
> +			}
> +		}
> +		mutex_unlock(&data->lock);
> +
> +		/* hwmon attr index starts at 1, thus "i+1" below */
> +		if (updated_min_alarm) {
> +			ret = snprintf(alarm_node, 16, "temp%d_min_alarm",
> +				       (i + 1));
> +			if (ret < 0) {
> +				dev_err(&data->pdev->dev,
> +					"Unable to update alarm node (%d)",
> +					ret);
> +				break;
> +			}
> +			sysfs_notify(&data->pdev->dev.kobj, NULL, alarm_node);
> +		}
> +		if (updated_max_alarm) {
> +			ret = snprintf(alarm_node, 16, "temp%d_max_alarm",
> +				       (i + 1));
> +			if (ret < 0) {
> +				dev_err(&data->pdev->dev,
> +					"Unable to update alarm node (%d)",
> +					ret);
> +				break;
> +			}
> +			sysfs_notify(&data->pdev->dev.kobj, NULL, alarm_node);
> +		}
> +		if (updated_max_hyst_alarm) {
> +			ret = snprintf(alarm_node, 21, "temp%d_max_hyst_alarm",
> +				       (i + 1));
> +			if (ret < 0) {
> +				dev_err(&data->pdev->dev,
> +					"Unable to update alarm node (%d)",
> +					ret);
> +				break;
> +			}
> +			sysfs_notify(&data->pdev->dev.kobj, NULL, alarm_node);
> +		}
> +	}
> +	delay_in_jiffies = msecs_to_jiffies(data->gpadc_monitor_delay);
> +	schedule_delayed_work(&data->work, delay_in_jiffies);
> +}
> +
> +static ssize_t set_temp_monitor_delay(struct device *dev,
> +				      struct device_attribute *devattr,
> +				      const char *buf, size_t count)
> +{
> +	int res;
> +	unsigned long delay_in_s;
> +	struct abx500_temp *data = dev_get_drvdata(dev);
> +
> +	res = strict_strtoul(buf, 10, &delay_in_s);
> +	if (res < 0)
> +		return res;
> +
> +	mutex_lock(&data->lock);
> +	data->gpadc_monitor_delay = delay_in_s * 1000;
> +
> +	if (find_active_thresholds(data))
> +		schedule_monitor(data);
> +
> +	mutex_unlock(&data->lock);
> +
> +	return count;
> +}
> +
> +static ssize_t set_temp_power_off_delay(struct device *dev,
> +					struct device_attribute *devattr,
> +					const char *buf, size_t count)
> +{
> +	int res;
> +	unsigned long delay_in_s;
> +	struct abx500_temp *data = dev_get_drvdata(dev);
> +
> +	res = strict_strtoul(buf, 10, &delay_in_s);
> +	if (res < 0)
> +		return res;
> +
> +	mutex_lock(&data->lock);
> +	data->power_off_delay = delay_in_s * 1000;
> +	mutex_unlock(&data->lock);
> +
> +	return count;
> +}
> +
> +static ssize_t show_temp_monitor_delay(struct device *dev,
> +				       struct device_attribute *devattr,
> +				       char *buf)
> +{
> +	struct abx500_temp *data = dev_get_drvdata(dev);
> +	/* return time in s, not ms */
> +	return sprintf(buf, "%lu\n", (data->gpadc_monitor_delay) / 1000);
> +}
> +
> +static ssize_t show_temp_power_off_delay(struct device *dev,
> +					 struct device_attribute *devattr,
> +					 char *buf)
> +{
> +	struct abx500_temp *data = dev_get_drvdata(dev);
> +	/* return time in s, not ms */
> +	return sprintf(buf, "%lu\n", (data->power_off_delay) / 1000);
> +}
> +
> +/* HWMON sysfs interface */
> +static ssize_t show_name(struct device *dev, struct device_attribute *devattr,
> +			 char *buf)
> +{
> +	/*
> +	 * To avoid confusion between sensor label and chip name, the function
> +	 * "show_label" is not used to return the chip name.
> +	 */
> +	struct abx500_temp *data = dev_get_drvdata(dev);
> +	return data->ops.show_name(dev, devattr, buf);
> +}
> +
> +static ssize_t show_label(struct device *dev,
> +			  struct device_attribute *devattr, char *buf)
> +{
> +	struct abx500_temp *data = dev_get_drvdata(dev);
> +	return data->ops.show_label(dev, devattr, buf);
> +}
> +
> +static ssize_t show_input(struct device *dev,
> +			  struct device_attribute *devattr, char *buf)
> +{
> +	int val;
> +	struct abx500_temp *data = dev_get_drvdata(dev);
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	/* hwmon attr index starts at 1, thus "attr->index-1" below */
> +	u8 gpadc_addr = data->gpadc_addr[attr->index - 1];
> +
> +	val = data->ops.read_sensor(data, gpadc_addr);
> +	if (val < 0)
> +		dev_err(&data->pdev->dev, "GPADC read failed\n");
> +
> +	return sprintf(buf, "%d\n", val);
> +}
> +
> +/* set functions (RW nodes) */
> +static ssize_t set_min(struct device *dev, struct device_attribute *devattr,
> +		       const char *buf, size_t count)
> +{
> +	unsigned long val;
> +	struct abx500_temp *data = dev_get_drvdata(dev);
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	int res = strict_strtoul(buf, 10, &val);
kstrto functions?
> +	if (res < 0)
> +		return res;
> +
> +	mutex_lock(&data->lock);
> +	/*
> +	 * Threshold is considered inactive if set to 0
> +	 * hwmon attr index starts at 1, thus "attr->index-1" below
> +	 */
> +	if (val = 0)
> +		data->min_alarm[attr->index - 1] = 0;
> +
> +	data->min[attr->index - 1] = val;
> +
> +	if (val = 0)
> +		(void) find_active_thresholds(data);
> +	else
> +		schedule_monitor(data);
> +
> +	mutex_unlock(&data->lock);
> +
> +	return count;
> +}
> +
> +static ssize_t set_max(struct device *dev, struct device_attribute *devattr,
> +		       const char *buf, size_t count)
> +{
> +	unsigned long val;
> +	struct abx500_temp *data = dev_get_drvdata(dev);
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	int res = strict_strtoul(buf, 10, &val);
> +	if (res < 0)
> +		return res;
> +
> +	mutex_lock(&data->lock);
> +	/*
> +	 * Threshold is considered inactive if set to 0
> +	 * hwmon attr index starts at 1, thus "attr->index-1" below
> +	 */
> +	if (val = 0)
> +		data->max_alarm[attr->index - 1] = 0;
> +
> +	data->max[attr->index - 1] = val;
> +
> +	if (val = 0)
> +		(void) find_active_thresholds(data);
> +	else
> +		schedule_monitor(data);
> +
> +	mutex_unlock(&data->lock);
> +
> +	return count;
> +}
> +
> +static ssize_t set_max_hyst(struct device *dev,
> +			    struct device_attribute *devattr,
> +			    const char *buf, size_t count)
> +{
> +	unsigned long val;
> +	struct abx500_temp *data = dev_get_drvdata(dev);
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	int res = strict_strtoul(buf, 10, &val);
> +	if (res < 0)
> +		return res;
> +
> +	mutex_lock(&data->lock);
> +	/*
> +	 * Threshold is considered inactive if set to 0
> +	 * hwmon attr index starts at 1, thus "attr->index-1" below
> +	 */
> +	if (val = 0)
> +		data->max_hyst_alarm[attr->index - 1] = 0;
> +
> +	data->max_hyst[attr->index - 1] = val;
> +
> +	if (val = 0)
> +		(void) find_active_thresholds(data);
> +	else
> +		schedule_monitor(data);
> +
> +	mutex_unlock(&data->lock);
> +
> +	return count;
> +}
> +
> +/*
> + * show functions (RO nodes)
> + */
> +static ssize_t show_min(struct device *dev,
> +			struct device_attribute *devattr, char *buf)
> +{
> +	struct abx500_temp *data = dev_get_drvdata(dev);
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	/* hwmon attr index starts at 1, thus "attr->index-1" below */
> +	return sprintf(buf, "%ld\n", data->min[attr->index - 1]);
> +}
> +
> +static ssize_t show_max(struct device *dev,
> +			struct device_attribute *devattr, char *buf)
> +{
> +	struct abx500_temp *data = dev_get_drvdata(dev);
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	/* hwmon attr index starts at 1, thus "attr->index-1" below */
> +	return sprintf(buf, "%ld\n", data->max[attr->index - 1]);
> +}
> +
> +static ssize_t show_max_hyst(struct device *dev,
> +			     struct device_attribute *devattr, char *buf)
> +{
> +	struct abx500_temp *data = dev_get_drvdata(dev);
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	/* hwmon attr index starts at 1, thus "attr->index-1" below */
> +	return sprintf(buf, "%ld\n", data->max_hyst[attr->index - 1]);
> +}
> +
> +/* Alarms */
> +static ssize_t show_min_alarm(struct device *dev,
> +			      struct device_attribute *devattr, char *buf)
> +{
> +	struct abx500_temp *data = dev_get_drvdata(dev);
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	/* hwmon attr index starts at 1, thus "attr->index-1" below */
> +	return sprintf(buf, "%ld\n", data->min_alarm[attr->index - 1]);
> +}
> +
> +static ssize_t show_max_alarm(struct device *dev,
> +			      struct device_attribute *devattr, char *buf)
> +{
> +	struct abx500_temp *data = dev_get_drvdata(dev);
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	/* hwmon attr index starts at 1, thus "attr->index-1" below */
> +	return sprintf(buf, "%ld\n", data->max_alarm[attr->index - 1]);
> +}
> +
> +static ssize_t show_max_hyst_alarm(struct device *dev,
> +				   struct device_attribute *devattr, char *buf)
> +{
> +	struct abx500_temp *data = dev_get_drvdata(dev);
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	/* hwmon attr index starts at 1, thus "attr->index-1" below */
> +	return sprintf(buf, "%ld\n", data->max_hyst_alarm[attr->index - 1]);
> +}
> +
> +static ssize_t show_crit_alarm(struct device *dev,
> +			       struct device_attribute *devattr, char *buf)
> +{
> +	struct abx500_temp *data = dev_get_drvdata(dev);
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	/* hwmon attr index starts at 1, thus "attr->index-1" below */
> +	return sprintf(buf, "%ld\n", data->crit_alarm[attr->index - 1]);
> +}
> +
> +static mode_t abx500_attrs_visible(struct kobject *kobj,
> +				   struct attribute *a, int n)
> +{
> +	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct abx500_temp *data = dev_get_drvdata(dev);
> +	return data->ops.is_visible(a, n);
> +}
> +
> +static SENSOR_DEVICE_ATTR(temp_monitor_delay, S_IRUGO | S_IWUSR,
> +			  show_temp_monitor_delay, set_temp_monitor_delay, 0);
> +static SENSOR_DEVICE_ATTR(temp_power_off_delay, S_IRUGO | S_IWUSR,
> +			  show_temp_power_off_delay,
> +			  set_temp_power_off_delay, 0);
> +
> +/* Chip name, required by hwmon*/
> +static SENSOR_DEVICE_ATTR(name, S_IRUGO, show_name, NULL, 0);
> +
> +/* GPADC - SENSOR1 */
> +static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, show_label, NULL, 1);
> +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_input, NULL, 1);
> +static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_min, set_min, 1);
> +static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_max, set_max, 1);
> +static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO,
> +			  show_max_hyst, set_max_hyst, 1);
> +static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO, show_min_alarm, NULL, 1);
> +static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_max_alarm, NULL, 1);
> +static SENSOR_DEVICE_ATTR(temp1_max_hyst_alarm, S_IRUGO,
> +			  show_max_hyst_alarm, NULL, 1);
> +
> +/* GPADC - SENSOR2 */
> +static SENSOR_DEVICE_ATTR(temp2_label, S_IRUGO, show_label, NULL, 2);
> +static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_input, NULL, 2);
> +static SENSOR_DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_min, set_min, 2);
> +static SENSOR_DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_max, set_max, 2);
> +static SENSOR_DEVICE_ATTR(temp2_max_hyst, S_IWUSR | S_IRUGO,
> +			  show_max_hyst, set_max_hyst, 2);
> +static SENSOR_DEVICE_ATTR(temp2_min_alarm, S_IRUGO, show_min_alarm, NULL, 2);
> +static SENSOR_DEVICE_ATTR(temp2_max_alarm, S_IRUGO, show_max_alarm, NULL, 2);
> +static SENSOR_DEVICE_ATTR(temp2_max_hyst_alarm, S_IRUGO,
> +			  show_max_hyst_alarm, NULL, 2);
> +
> +/* GPADC - SENSOR3 */
> +static SENSOR_DEVICE_ATTR(temp3_label, S_IRUGO, show_label, NULL, 3);
> +static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, show_input, NULL, 3);
> +static SENSOR_DEVICE_ATTR(temp3_min, S_IWUSR | S_IRUGO, show_min, set_min, 3);
> +static SENSOR_DEVICE_ATTR(temp3_max, S_IWUSR | S_IRUGO, show_max, set_max, 3);
> +static SENSOR_DEVICE_ATTR(temp3_max_hyst, S_IWUSR | S_IRUGO,
> +			  show_max_hyst, set_max_hyst, 3);
> +static SENSOR_DEVICE_ATTR(temp3_min_alarm, S_IRUGO, show_min_alarm, NULL, 3);
> +static SENSOR_DEVICE_ATTR(temp3_max_alarm, S_IRUGO, show_max_alarm, NULL, 3);
> +static SENSOR_DEVICE_ATTR(temp3_max_hyst_alarm, S_IRUGO,
> +			  show_max_hyst_alarm, NULL, 3);
> +
> +/* GPADC - SENSOR4 */
> +static SENSOR_DEVICE_ATTR(temp4_label, S_IRUGO, show_label, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp4_input, S_IRUGO, show_input, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp4_min, S_IWUSR | S_IRUGO, show_min, set_min, 4);
> +static SENSOR_DEVICE_ATTR(temp4_max, S_IWUSR | S_IRUGO, show_max, set_max, 4);
> +static SENSOR_DEVICE_ATTR(temp4_max_hyst, S_IWUSR | S_IRUGO,
> +			  show_max_hyst, set_max_hyst, 4);
> +static SENSOR_DEVICE_ATTR(temp4_min_alarm, S_IRUGO, show_min_alarm, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp4_max_alarm, S_IRUGO, show_max_alarm, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp4_max_hyst_alarm, S_IRUGO,
> +			  show_max_hyst_alarm, NULL, 4);
> +
> +/* GPADC - SENSOR5 */
> +static SENSOR_DEVICE_ATTR(temp5_label, S_IRUGO, show_label, NULL, 5);
> +static SENSOR_DEVICE_ATTR(temp5_input, S_IRUGO, show_input, NULL, 5);
> +static SENSOR_DEVICE_ATTR(temp5_min, S_IWUSR | S_IRUGO, show_min, set_min, 4);
> +static SENSOR_DEVICE_ATTR(temp5_max, S_IWUSR | S_IRUGO, show_max, set_max, 4);
> +static SENSOR_DEVICE_ATTR(temp5_max_hyst, S_IWUSR | S_IRUGO,
> +			  show_max_hyst, set_max_hyst, 4);
> +static SENSOR_DEVICE_ATTR(temp5_min_alarm, S_IRUGO, show_min_alarm, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp5_max_alarm, S_IRUGO, show_max_alarm, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp5_max_hyst_alarm, S_IRUGO,
> +			  show_max_hyst_alarm, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp5_crit_alarm, S_IRUGO,
> +			  show_crit_alarm, NULL, 5);
> +
> +struct attribute *abx500_temp_attributes[] = {
> +	&sensor_dev_attr_name.dev_attr.attr,
> +	&sensor_dev_attr_temp_monitor_delay.dev_attr.attr,
> +	&sensor_dev_attr_temp_power_off_delay.dev_attr.attr,
> +	/* GPADC SENSOR1 */
> +	&sensor_dev_attr_temp1_label.dev_attr.attr,
> +	&sensor_dev_attr_temp1_input.dev_attr.attr,
> +	&sensor_dev_attr_temp1_min.dev_attr.attr,
> +	&sensor_dev_attr_temp1_max.dev_attr.attr,
> +	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
> +	&sensor_dev_attr_temp1_min_alarm.dev_attr.attr,
> +	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
> +	&sensor_dev_attr_temp1_max_hyst_alarm.dev_attr.attr,
> +	/* GPADC SENSOR2 */
> +	&sensor_dev_attr_temp2_label.dev_attr.attr,
> +	&sensor_dev_attr_temp2_input.dev_attr.attr,
> +	&sensor_dev_attr_temp2_min.dev_attr.attr,
> +	&sensor_dev_attr_temp2_max.dev_attr.attr,
> +	&sensor_dev_attr_temp2_max_hyst.dev_attr.attr,
> +	&sensor_dev_attr_temp2_min_alarm.dev_attr.attr,
> +	&sensor_dev_attr_temp2_max_alarm.dev_attr.attr,
> +	&sensor_dev_attr_temp2_max_hyst_alarm.dev_attr.attr,
> +	/* GPADC SENSOR3 */
> +	&sensor_dev_attr_temp3_label.dev_attr.attr,
> +	&sensor_dev_attr_temp3_input.dev_attr.attr,
> +	&sensor_dev_attr_temp3_min.dev_attr.attr,
> +	&sensor_dev_attr_temp3_max.dev_attr.attr,
> +	&sensor_dev_attr_temp3_max_hyst.dev_attr.attr,
> +	&sensor_dev_attr_temp3_min_alarm.dev_attr.attr,
> +	&sensor_dev_attr_temp3_max_alarm.dev_attr.attr,
> +	&sensor_dev_attr_temp3_max_hyst_alarm.dev_attr.attr,
> +	/* GPADC SENSOR4 */
> +	&sensor_dev_attr_temp4_label.dev_attr.attr,
> +	&sensor_dev_attr_temp4_input.dev_attr.attr,
> +	&sensor_dev_attr_temp4_min.dev_attr.attr,
> +	&sensor_dev_attr_temp4_max.dev_attr.attr,
> +	&sensor_dev_attr_temp4_max_hyst.dev_attr.attr,
> +	&sensor_dev_attr_temp4_min_alarm.dev_attr.attr,
> +	&sensor_dev_attr_temp4_max_alarm.dev_attr.attr,
> +	&sensor_dev_attr_temp4_max_hyst_alarm.dev_attr.attr,
> +	/* GPADC SENSOR5*/
> +	&sensor_dev_attr_temp5_label.dev_attr.attr,
> +	&sensor_dev_attr_temp5_input.dev_attr.attr,
> +	&sensor_dev_attr_temp5_min.dev_attr.attr,
> +	&sensor_dev_attr_temp5_max.dev_attr.attr,
> +	&sensor_dev_attr_temp5_max_hyst.dev_attr.attr,
> +	&sensor_dev_attr_temp5_min_alarm.dev_attr.attr,
> +	&sensor_dev_attr_temp5_max_alarm.dev_attr.attr,
> +	&sensor_dev_attr_temp5_max_hyst_alarm.dev_attr.attr,
> +	&sensor_dev_attr_temp5_crit_alarm.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group abx500_temp_group = {
> +	.attrs = abx500_temp_attributes,
> +	.is_visible = abx500_attrs_visible,
> +};
> +
> +static irqreturn_t abx500_temp_irq_handler(int irq, void *irq_data)
> +{
> +	struct platform_device *pdev = irq_data;
> +	struct abx500_temp *data = platform_get_drvdata(pdev);
> +	data->ops.irq_handler(irq, data);
> +	return IRQ_HANDLED;
> +}
> +
> +static int setup_irqs(struct platform_device *pdev)
> +{
> +	int ret;
> +	int irq = platform_get_irq_byname(pdev, "ABX500_TEMP_WARM");
> +
> +	if (irq < 0)
> +		dev_err(&pdev->dev, "Get irq by name failed\n");
> +
> +	ret = request_threaded_irq(irq, NULL, abx500_temp_irq_handler,
> +				   IRQF_NO_SUSPEND, "abx500-temp", pdev);
> +	if (ret < 0)
> +		dev_err(&pdev->dev, "Request threaded irq failed (%d)\n", ret);
> +
> +	return ret;
> +}
> +
> +static int __devinit abx500_temp_probe(struct platform_device *pdev)
> +{
> +	struct abx500_temp *data;
> +	int err;
> +
> +	data = kzalloc(sizeof(struct abx500_temp), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->pdev = pdev;
> +	mutex_init(&data->lock);
> +
> +	/* Chip specific initialization */
> +	err = abx500_hwmon_init(data);
> +	if (err	< 0) {
> +		dev_err(&pdev->dev, "abx500 init failed");
> +		goto exit;
> +	}
> +
> +	data->hwmon_dev = hwmon_device_register(&pdev->dev);
> +	if (IS_ERR(data->hwmon_dev)) {
> +		err = PTR_ERR(data->hwmon_dev);
> +		dev_err(&pdev->dev, "Class registration failed (%d)\n", err);
> +		goto exit;
> +	}
> +
> +	INIT_DELAYED_WORK_DEFERRABLE(&data->work, gpadc_monitor);
> +	data->gpadc_monitor_delay =  DEFAULT_MONITOR_DELAY;
> +
> +	platform_set_drvdata(pdev, data);
> +
> +	err = sysfs_create_group(&pdev->dev.kobj, &abx500_temp_group);
> +	if (err < 0) {
> +		dev_err(&pdev->dev, "Create sysfs group failed (%d)\n", err);
> +		goto exit_platform_data;
> +	}
> +
> +	err = setup_irqs(pdev);
> +	if (err < 0) {
> +		dev_err(&pdev->dev, "irq setup failed (%d)\n", err);
> +		goto exit_sysfs_group;
> +	}
> +	return 0;
> +
> +exit_sysfs_group:
> +	sysfs_remove_group(&pdev->dev.kobj, &abx500_temp_group);
> +exit_platform_data:
> +	hwmon_device_unregister(data->hwmon_dev);
> +	platform_set_drvdata(pdev, NULL);
> +exit:
> +	kfree(data->gpadc_auto);
> +	kfree(data);
> +	return err;
> +}
> +
> +static int __devexit abx500_temp_remove(struct platform_device *pdev)
> +{
> +	struct abx500_temp *data = platform_get_drvdata(pdev);
> +
> +	gpadc_monitor_exit(data);
> +	hwmon_device_unregister(data->hwmon_dev);
> +	sysfs_remove_group(&pdev->dev.kobj, &abx500_temp_group);
> +	platform_set_drvdata(pdev, NULL);
> +	kfree(data->gpadc_auto);
> +	kfree(data);
> +	return 0;
> +}
> +
> +/* No action required in suspend/resume, thus the lack of functions */
> +static struct platform_driver abx500_temp_driver = {
> +	.driver = {
> +		.owner = THIS_MODULE,
> +		.name = "abx500-temp",
> +	},
> +	.probe = abx500_temp_probe,
> +	.remove = __devexit_p(abx500_temp_remove),
> +};
> +
> +static int __init abx500_temp_init(void)
> +{
> +	return platform_driver_register(&abx500_temp_driver);
> +}
> +
> +static void __exit abx500_temp_exit(void)
> +{
> +	platform_driver_unregister(&abx500_temp_driver);
> +}
> +
> +MODULE_AUTHOR("Martin Persson <martin.persson@stericsson.com>");
> +MODULE_DESCRIPTION("ABX500 temperature driver");
> +MODULE_LICENSE("GPL");
> +
> +module_init(abx500_temp_init)
> +module_exit(abx500_temp_exit)
> diff --git a/drivers/hwmon/abx500.h b/drivers/hwmon/abx500.h
> new file mode 100644
> index 0000000..aab5b67
> --- /dev/null
> +++ b/drivers/hwmon/abx500.h
> @@ -0,0 +1,90 @@
> +/*
> + * Copyright (C) ST-Ericsson SA 2010
> + * License terms: GNU General Public License v2
> + * Author: Martin Persson <martin.persson@stericsson.com>
> + */
> +
> +#ifndef _ABX500_H
> +#define _ABX500_H
> +
> +#define NUM_SENSORS 5
> +
> +struct ab8500_gpadc;
> +struct ab5500_gpadc;
> +struct adc_auto_input;
> +struct abx500_temp;
> +
> +/**
> + * struct abx500_temp_ops - abx500 chip specific ops
> + * @read_sensor: reads gpadc output
> + * @irq_handler: irq handler
> + * @show_name: hwmon device name
> + * @show_label: hwmon attribute label
> + * @is_visible: is attribute visible
> + */
> +struct abx500_temp_ops {
> +	int (*read_sensor)(struct abx500_temp *, u8);
> +	int (*irq_handler)(int, struct abx500_temp *);
> +	ssize_t (*show_name)(struct device *,
> +			struct device_attribute *, char *);
> +	ssize_t (*show_label) (struct device *,
> +			struct device_attribute *, char *);
> +	int (*is_visible)(struct attribute *, int);
> +};
> +
> +/**
> + * struct abx500_temp - representation of temp mon device
> + * @pdev: platform device
> + * @hwmon_dev: hwmon device
> + * @ab8500_gpadc: gpadc interface for ab8500
> + * @ab5500_gpadc: gpadc interface for ab5500
> + * @btemp: battery temperature interface for ab8500
> + * @adc_auto_input: gpadc auto trigger
> + * @gpadc_addr: gpadc channel address
> + * @temp: sensor temperature input value
> + * @min: sensor temperature min value
> + * @max: sensor temperature max value
> + * @max_hyst: sensor temperature hysteresis value for max limit
> + * @crit: sensor temperature critical value
> + * @min_alarm: sensor temperature min alarm
> + * @max_alarm: sensor temperature max alarm
> + * @max_hyst_alarm: sensor temperature hysteresis alarm
> + * @crit_alarm: sensor temperature critical value alarm
> + * @work: delayed work scheduled to monitor temperature periodically
> + * @power_off_work: delayed work scheduled to power off the system
> +		when critical temperature is reached
> + * @lock: mutex
> + * @gpadc_monitor_delay: delay between temperature readings in ms
> + * @power_off_delay: delay before power off in ms
> + * @monitored_sensors: number of monitored sensors
> + */
> +struct abx500_temp {
> +	struct platform_device *pdev;
> +	struct device *hwmon_dev;
> +	struct ab8500_gpadc *ab8500_gpadc;
> +	struct ab5500_gpadc *ab5500_gpadc;
> +	struct adc_auto_input *gpadc_auto;

gpadc_auto confuses me.  It's not documented and is never
allocated (but is freed in a couple of places).

Actually please check this documentation here thoroughly
as I can't see ops anywhere either.

> +	struct abx500_temp_ops ops;
> +	u8 gpadc_addr[NUM_SENSORS];
> +	unsigned long temp[NUM_SENSORS];
> +	unsigned long min[NUM_SENSORS];
> +	unsigned long max[NUM_SENSORS];
> +	unsigned long max_hyst[NUM_SENSORS];
> +	unsigned long crit[NUM_SENSORS];
> +	unsigned long min_alarm[NUM_SENSORS];
> +	unsigned long max_alarm[NUM_SENSORS];
> +	unsigned long max_hyst_alarm[NUM_SENSORS];
> +	unsigned long crit_alarm[NUM_SENSORS];
> +	struct delayed_work work;
> +	struct delayed_work power_off_work;
> +	struct mutex lock;
> +	/* Delay (ms) between temperature readings */
> +	unsigned long gpadc_monitor_delay;
> +	/* Delay (ms) before power off */
> +	unsigned long power_off_delay;
> +	int monitored_sensors;
> +};
> +
> +int abx500_hwmon_init(struct abx500_temp *data) __init;
> +
> +#endif /* _ABX500_H */
> diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
> index 387705e..e5d3652 100644
> --- a/drivers/mfd/ab8500-core.c
> +++ b/drivers/mfd/ab8500-core.c
> @@ -679,7 +679,7 @@ static struct resource __devinitdata ab8500_usb_resources[] = {
>  
>  static struct resource __devinitdata ab8500_temp_resources[] = {
>  	{
> -		.name  = "AB8500_TEMP_WARM",
> +		.name  = "ABX500_TEMP_WARM",
>  		.start = AB8500_INT_TEMP_WARM,
>  		.end   = AB8500_INT_TEMP_WARM,
>  		.flags = IORESOURCE_IRQ,
> @@ -770,7 +770,7 @@ static struct mfd_cell __devinitdata ab8500_devs[] = {
>  		.name = "ab8500-denc",
>  	},
>  	{
> -		.name = "ab8500-temp",
> +		.name = "abx500-temp",
Not better to just register multiple variant drivers using the core code?
I'm somewhat confused in general at the naming of some of the functions.

Perhaps check for consistency that all abx500 named functions are the
ones covering who series and the ab8500 named ones are definitely
specific to that part.
>  		.num_resources = ARRAY_SIZE(ab8500_temp_resources),
>  		.resources = ab8500_temp_resources,
>  	},


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
