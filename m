From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 06 Feb 2013 17:54:49 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/2] hwmon: add ST-Ericsson ABX500 hwmon driver
Message-Id: <20130206175449.GA23982@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1360149039-7038-2-git-send-email-hongbo.zhang@linaro.org>
In-Reply-To: <1360149039-7038-2-git-send-email-hongbo.zhang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Feb 06, 2013 at 07:10:38PM +0800, Hongbo Zhang wrote:
> Each of ST-Ericsson X500 chip set series consists of both ABX500 and DBX500
> chips. This is ABX500 hwmon driver, where the abx500.c is a common layer for
> all ABX500s, and the ab8500.c is specific for AB8500 chip. Under this designed
> structure, other chip specific files can be added simply using the same common
> layer abx500.c.
> 
> Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>

Better, but you did not answer the most important question: With its
functionality, I think the driver might fit much better into the thermal
subsystem. Did you explore this ?

> ---
>  Documentation/hwmon/ab8500 |  22 ++
>  Documentation/hwmon/abx500 |  26 +++
>  drivers/hwmon/Kconfig      |  13 ++
>  drivers/hwmon/Makefile     |   1 +
>  drivers/hwmon/ab8500.c     | 163 ++++++++++++++
>  drivers/hwmon/abx500.c     | 544 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/hwmon/abx500.h     |  84 +++++++
>  7 files changed, 853 insertions(+)
>  create mode 100644 Documentation/hwmon/ab8500
>  create mode 100644 Documentation/hwmon/abx500
>  create mode 100644 drivers/hwmon/ab8500.c
>  create mode 100644 drivers/hwmon/abx500.c
>  create mode 100644 drivers/hwmon/abx500.h
> 
> diff --git a/Documentation/hwmon/ab8500 b/Documentation/hwmon/ab8500
> new file mode 100644
> index 0000000..76c534d
> --- /dev/null
> +++ b/Documentation/hwmon/ab8500
> @@ -0,0 +1,22 @@
> +Kernel driver ab8500
> +==========
> +
> +Supported chips:
> +  * ST-Ericsson AB8500
> +    Prefix: 'ab8500'
> +    Addresses scanned: -
> +    Datasheet: http://www.stericsson.com/developers/documentation.jsp
> +
> +Authors:
> +        Martin Persson <martin.persson@stericsson.com>
> +        Hongbo Zhang <hongbo.zhang@linaro.org>
> +
> +Description
> +-----------
> +
> +See also Documentation/hwmon/abx500. This is ST-Ericsson AB8500 hwmon specific
> +initialization.
> +
> +Currently only the AB8500 internal sensor and one external sensor for battery
> +temperature are monitored. Other GPADC channels can also be monitored if needed
> +in future.
> diff --git a/Documentation/hwmon/abx500 b/Documentation/hwmon/abx500
> new file mode 100644
> index 0000000..f60b73c
> --- /dev/null
> +++ b/Documentation/hwmon/abx500
> @@ -0,0 +1,26 @@
> +Kernel driver abx500
> +==========
> +
> +Supported chips:
> +  * ST-Ericsson ABx500 series
> +    Prefix: 'abx500'
> +    Addresses scanned: -
> +    Datasheet: http://www.stericsson.com/developers/documentation.jsp
> +
> +Authors:
> +        Martin Persson <martin.persson@stericsson.com>
> +        Hongbo Zhang <hongbo.zhang@linaro.org>
> +
> +Description
> +-----------
> +
> +Every ST-Ericsson Ux500 SOC consists of both ABx500 and DBx500 physically,
> +this is kernel hwmon driver for ABx500.
> +
> +There are some GPADCs inside ABx500 which are designed for connecting to
> +thermal sensors, and there is also a thermal sensor inside ABx500 too, which
> +raises interrupt when critical temperature reached.
> +
> +This abx500 is a common layer which can monitor all of the sensors, every
> +specific abx500 chip has its special configurations in its own file, e.g. some
> +sensors can be configured invisible if they are not available on that chip.
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 32f238f..0a6fd21 100644
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
>  	depends on X86 && DMI
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 5da2874..06dfe85 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -19,6 +19,7 @@ obj-$(CONFIG_SENSORS_W83795)	+= w83795.o
>  obj-$(CONFIG_SENSORS_W83781D)	+= w83781d.o
>  obj-$(CONFIG_SENSORS_W83791D)	+= w83791d.o
>  
> +obj-$(CONFIG_SENSORS_AB8500)	+= abx500.o ab8500.o
>  obj-$(CONFIG_SENSORS_ABITUGURU)	+= abituguru.o
>  obj-$(CONFIG_SENSORS_ABITUGURU3)+= abituguru3.o
>  obj-$(CONFIG_SENSORS_AD7314)	+= ad7314.o
> diff --git a/drivers/hwmon/ab8500.c b/drivers/hwmon/ab8500.c
> new file mode 100644
> index 0000000..ce6c4ef
> --- /dev/null
> +++ b/drivers/hwmon/ab8500.c
> @@ -0,0 +1,163 @@
> +/*
> + * Copyright (C) ST-Ericsson SA 2010
> + * Author: Martin Persson <martin.persson@stericsson.com>
> + *         Hongbo Zhang <hongbo.zhang@linaro.org>
> + * License Terms: GNU General Public License v2
> + *
> + * If/when the AB8500 thermal warning temperature is reached (threshold cannot
> + * be changed by SW), an interrupt is set and the driver notifies user space
> + * via a sysfs event. If a shut down is not triggered by user space within a
> + * certain time frame, pm_power off is called.
> + *
> + * If/when AB8500 thermal shutdown temperature is reached a hardware shutdown
> + * of the AB8500 will occur.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/mfd/abx500/ab8500-bm.h>
> +#include <linux/mfd/abx500/ab8500-gpadc.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
> +#include "abx500.h"
> +
> +#define DEFAULT_POWER_OFF_DELAY	10000
> +#define AB8500_CRIT_TEMP	130000	/* milli-Celsius */
> +
> +/* Maximum number of  sensors being monitored */
> +#define NUM_MONITORED_SENSORS 4
> +
> +static int ab8500_read_sensor(struct abx500_temp *data, u8 sensor)
> +{
> +	int val;
> +
> +	if (sensor = BAT_CTRL)
> +		val = ab8500_btemp_get_batctrl_temp(data->ab8500_btemp);
> +	else
> +		/* Functions for other channels can be added here */
> +		val = -ENOSYS;

Until then, doesn't this mean there would be a bug in the driver if this branch
is ever taken ?

> +	return val;
> +}
> +
> +static void ab8500_thermal_power_off(struct work_struct *work)
> +{
> +	struct abx500_temp *data = container_of(work, struct abx500_temp,
> +						power_off_work.work);
> +
> +	dev_warn(&data->pdev->dev,
> +		"Power off due to AB8500 thermal warning.\n");
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
> +	switch (index) {
> +	case 1:
> +		name = "ext_ntc1";
> +		break;
> +	case 2:
> +		name = "ext_ntc2";
> +		break;
> +	case 3:
> +		name = "bat_temp";
> +		break;

The above three are not supported by the driver. That code is thus wasted.

> +	case 4:
> +		name = "bat_ctrl";
> +		break;
> +	case 5:
> +		name = "ab8500_die";
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	return sprintf(buf, "%s\n", name);
> +}
> +
> +static int ab8500_is_visible(struct attribute *attr, int n)
> +{
> +	if (!strncmp(attr->name, "temp1", 5) ||
> +	    !strncmp(attr->name, "temp2", 5) ||
> +	    !strncmp(attr->name, "temp3", 5) ||
> +	    !strcmp(attr->name, "temp5_input") ||
> +	    !strcmp(attr->name, "temp5_min") ||
> +	    !strcmp(attr->name, "temp5_max") ||
> +	    !strcmp(attr->name, "temp5_max_hyst") ||
> +	    !strcmp(attr->name, "temp5_min_alarm") ||
> +	    !strcmp(attr->name, "temp5_max_alarm"))
> +		return 0;
> +

You should find a less expensive way to express this, for example by providing a
bit mask to the ab85xx driver showing which attributes are supported and which
ones are not. The driver can then simply not create the attributes instead of
having to go through this operation. 

> +	return attr->mode;
> +}
> +
> +static int ab8500_temp_irq_handler(int irq, struct abx500_temp *data)
> +{
> +	unsigned long delay_in_jiffies;
> +
> +	data->crit_alarm[4] = true;
> +
> +	sysfs_notify(&data->pdev->dev.kobj, NULL, "temp5_crit_alarm");
> +	dev_info(&data->pdev->dev, "AB8500 warning, power off in %lu s\n",
> +		data->power_off_delay);
> +	delay_in_jiffies = msecs_to_jiffies(data->power_off_delay);
> +	schedule_delayed_work(&data->power_off_work, delay_in_jiffies);
> +	return 0;
> +}
> +
> +int abx500_hwmon_init(struct abx500_temp *data)
> +{
> +	data->ab8500_gpadc = ab8500_gpadc_get("ab8500-gpadc.0");
> +	if (IS_ERR(data->ab8500_gpadc))
> +		return PTR_ERR(data->ab8500_gpadc);
> +
> +	data->ab8500_btemp = ab8500_btemp_get();
> +	if (IS_ERR(data->ab8500_btemp))
> +		return PTR_ERR(data->ab8500_btemp);
> +
> +	INIT_DELAYED_WORK(&data->power_off_work, ab8500_thermal_power_off);
> +
> +	/*
> +	 * Reference hardware:
> +	 * gpadc_addr[0] = ADC_AUX1, connected to external NTC
> +	 * gpadc_addr[1] = ADC_AUX2, connected to external NTC
> +	 * gpadc_addr[2] = BTEMP_BALL
> +	 * gpadc_addr[3] = BAT_CTRL
> +	 * Setting gpadc_addr[*] to 0 means this channel won't be polled.
> +	 */
> +	data->gpadc_addr[0] = 0;
> +	data->gpadc_addr[1] = 0;
> +	data->gpadc_addr[2] = 0;

You sure this is the correct solution ? Wasn't the issue that the temperature
has to be converted into degrees C ? Why not just do it ?

If you want to keep things this way, why even bother with temp1..3 ? I don't see
those used. If needed later they can always be added.

The same really applies to the temp5 sensor attributes. I don't see any value
providing those right now since they are not used. The only result is additional
unnecessary code. You can drop those, and add support later if/when needed (if
that ever occurs).

> +	data->gpadc_addr[3] = BAT_CTRL;
> +	data->gpadc_addr[4] = DIE_TEMP;
> +	data->crit[4] = AB8500_CRIT_TEMP;
> +	data->power_off_delay = DEFAULT_POWER_OFF_DELAY;
> +	data->monitored_sensors = NUM_MONITORED_SENSORS;
> +
> +	data->ops.read_sensor = ab8500_read_sensor;
> +	data->ops.irq_handler = ab8500_temp_irq_handler;
> +	data->ops.show_name  = ab8500_show_name;
> +	data->ops.show_label = ab8500_show_label;
> +	data->ops.is_visible = ab8500_is_visible;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(abx500_hwmon_init);
> +
> +MODULE_AUTHOR("Martin Persson <martin.persson@stericsson.com>");
> +MODULE_DESCRIPTION("AB8500 temperature driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/hwmon/abx500.c b/drivers/hwmon/abx500.c
> new file mode 100644
> index 0000000..ba72209
> --- /dev/null
> +++ b/drivers/hwmon/abx500.c
> @@ -0,0 +1,544 @@
> +/*
> + * Copyright (C) ST-Ericsson SA 2010
> + * Author: Martin Persson <martin.persson@stericsson.com>
> + *         Hongbo Zhang <hongbo.zhang@linaro.org>
> + * License Terms: GNU General Public License v2
> + *
> + * ABX500 does not provide auto ADC, so to monitor the required temperatures,
> + * a periodic work is used. It is more important to not wake up the CPU than
> + * to perform this job, hence the use of a deferred delay.
> + *
> + * A deferred delay for thermal monitor is considered safe because:
> + * If the chip gets too hot during a sleep state it's most likely due to
> + * external factors, such as the surrounding temperature. I.e. no SW decisions
> + * will make any difference.
> + *
> + * If/when the ABX500 thermal warning temperature is reached (threshold cannot
> + * be changed by SW), an interrupt is set and the driver notifies user space
> + * via a sysfs event.
> + *
> + * If/when ABX500 thermal shutdown temperature is reached a hardware shutdown
> + * of the ABX500 will occur.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/interrupt.h>
> +#include <linux/jiffies.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
> +#include <linux/workqueue.h>
> +#include "abx500.h"
> +
> +#define DEFAULT_MONITOR_DELAY 1000
> +
> +static inline void schedule_monitor(struct abx500_temp *data)
> +{
> +	unsigned long delay_in_jiffies;
> +	delay_in_jiffies = msecs_to_jiffies(data->gpadc_monitor_delay);
> +	data->work_active = true;
> +	schedule_delayed_work(&data->work, delay_in_jiffies);
> +}
> +
> +static void threshold_updated(struct abx500_temp *data)
> +{
> +	int i;
> +	for (i = 0; i < data->monitored_sensors; i++)
> +		if (data->max[i] != 0 || data->min[i] != 0) {
> +			schedule_monitor(data);
> +			return ;
> +		}
> +
> +	dev_dbg(&data->pdev->dev, "No active thresholds.\n");
> +	cancel_delayed_work_sync(&data->work);
> +	data->work_active = false;
> +}
> +
> +static void gpadc_monitor(struct work_struct *work)
> +{
> +	int val, i, ret;
> +	char alarm_node[30];
> +	bool updated_min_alarm = false;
> +	bool updated_max_alarm = false;
> +	struct abx500_temp *data = container_of(work, struct abx500_temp,
> +						work.work);
> +
> +	mutex_lock(&data->lock);
> +	for (i = 0; i < data->monitored_sensors; i++) {
> +		/* Thresholds are considered inactive if set to 0 */
> +		if (data->max[i] = 0 && data->min[i] = 0)
> +			continue;
> +		/*
> +		 * In case we are in the temporary state that one threshold
> +		 * has been changed, but the other hasn't yet.
> +		 */
> +		if (data->max[i] < data->min[i])
> +			continue;
> +
> +		val = data->ops.read_sensor(data, data->gpadc_addr[i]);
> +		if (val < 0) {
> +			dev_err(&data->pdev->dev, "GPADC read failed\n");
> +			continue;
> +		}
> +
> +		if (data->min[i] != 0) {
> +			if (val < data->min[i]) {
> +				if (data->min_alarm[i] = false) {

you don't need to compare against booleans. Just use
				if (!data->min_alarm[i])
or
				if (data->min_alarm[i])
as appropriate. Same for other boolean tests.

> +					data->min_alarm[i] = true;
> +					updated_min_alarm = true;
> +				}
> +			} else {
> +				if (data->min_alarm[i] = true) {
> +					data->min_alarm[i] = false;
> +					updated_min_alarm = true;
> +				}
> +			}
> +
> +		}
> +		if (data->max[i] != 0) {
> +			if (val > data->max[i]) {
> +				if (data->max_alarm[i] = false) {
> +					data->max_alarm[i] = true;
> +					updated_max_alarm = true;
> +				}
> +			} else if (val < data->max[i] - data->max_hyst[i]) {

Per ABI, max_hyst is an absolute temperature, not a difference.
This should be
			} else if (val < data->max_hyst[i]) {

> +				if (data->max_alarm[i] = true) {
> +					data->max_alarm[i] = false;
> +					updated_max_alarm = true;
> +				}
> +			}
> +		}
> +
> +		if (updated_min_alarm) {
> +			ret = sprintf(alarm_node, "temp%d_min_alarm", i);
> +			sysfs_notify(&data->pdev->dev.kobj, NULL, alarm_node);
> +		}
> +		if (updated_max_alarm) {
> +			ret = sprintf(alarm_node, "temp%d_max_alarm", i);
> +			sysfs_notify(&data->pdev->dev.kobj, NULL, alarm_node);
> +		}
> +
> +		updated_min_alarm = false;
> +		updated_max_alarm = false;

Move those assignments to the beginning of the loop to save two lines of
code.

> +	}
> +
> +	schedule_monitor(data);
> +	mutex_unlock(&data->lock);
> +}
> +
> +/* HWMON sysfs interfaces */
> +static ssize_t show_name(struct device *dev, struct device_attribute *devattr,
> +			 char *buf)
> +{
> +	struct abx500_temp *data = dev_get_drvdata(dev);
> +	/* Show chip name */
> +	return data->ops.show_name(dev, devattr, buf);
> +}
> +
> +static ssize_t show_label(struct device *dev,
> +			  struct device_attribute *devattr, char *buf)
> +{
> +	struct abx500_temp *data = dev_get_drvdata(dev);
> +	/* Show each sensor label */
> +	return data->ops.show_label(dev, devattr, buf);
> +}
> +
> +static ssize_t show_input(struct device *dev,
> +			  struct device_attribute *devattr, char *buf)
> +{
> +	int val;
> +	struct abx500_temp *data = dev_get_drvdata(dev);
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	u8 gpadc_addr = data->gpadc_addr[attr->index];
> +
> +	val = data->ops.read_sensor(data, gpadc_addr);
> +	if (val < 0)
> +		dev_err(&data->pdev->dev, "GPADC read failed\n");
> +
> +	return sprintf(buf, "%d\n", val);
> +}
> +
> +/* Set functions (RW nodes) */
> +static ssize_t set_min(struct device *dev, struct device_attribute *devattr,
> +		       const char *buf, size_t count)
> +{
> +	unsigned long val;
> +	struct abx500_temp *data = dev_get_drvdata(dev);
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	int res = kstrtoul(buf, 10, &val);
> +	if (res < 0)
> +		return res;
> +
> +	mutex_lock(&data->lock);
> +	data->min[attr->index] = val;
> +	threshold_updated(data);
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
> +	int res = kstrtoul(buf, 10, &val);
> +	if (res < 0)
> +		return res;
> +
> +	mutex_lock(&data->lock);
> +	data->max[attr->index] = val;
> +	threshold_updated(data);
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
> +	int res = kstrtoul(buf, 10, &val);
> +	if (res < 0)
> +		return res;
> +
> +	mutex_lock(&data->lock);
> +	data->max_hyst[attr->index] = val;
> +	threshold_updated(data);
> +	mutex_unlock(&data->lock);
> +
> +	return count;
> +}
> +
> +/* Show functions (RO nodes) */
> +static ssize_t show_min(struct device *dev,
> +			struct device_attribute *devattr, char *buf)
> +{
> +	struct abx500_temp *data = dev_get_drvdata(dev);
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +
> +	return sprintf(buf, "%ld\n", data->min[attr->index]);
> +}
> +
> +static ssize_t show_max(struct device *dev,
> +			struct device_attribute *devattr, char *buf)
> +{
> +	struct abx500_temp *data = dev_get_drvdata(dev);
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +
> +	return sprintf(buf, "%ld\n", data->max[attr->index]);
> +}
> +
> +static ssize_t show_max_hyst(struct device *dev,
> +			     struct device_attribute *devattr, char *buf)
> +{
> +	struct abx500_temp *data = dev_get_drvdata(dev);
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +
> +	return sprintf(buf, "%ld\n", data->max_hyst[attr->index]);
> +}
> +
> +static ssize_t show_min_alarm(struct device *dev,
> +			      struct device_attribute *devattr, char *buf)
> +{
> +	struct abx500_temp *data = dev_get_drvdata(dev);
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +
> +	return sprintf(buf, "%d\n", data->min_alarm[attr->index]);
> +}
> +
> +static ssize_t show_max_alarm(struct device *dev,
> +			      struct device_attribute *devattr, char *buf)
> +{
> +	struct abx500_temp *data = dev_get_drvdata(dev);
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +
> +	return sprintf(buf, "%d\n", data->max_alarm[attr->index]);
> +}
> +
> +static ssize_t show_crit(struct device *dev,
> +			       struct device_attribute *devattr, char *buf)
> +{
> +	struct abx500_temp *data = dev_get_drvdata(dev);
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +
> +	if (attr->index < 4)
> +		return -EINVAL;
> +	return sprintf(buf, "%ld\n", data->crit[attr->index]);
> +}
> +
> +static ssize_t show_crit_alarm(struct device *dev,
> +			       struct device_attribute *devattr, char *buf)
> +{
> +	struct abx500_temp *data = dev_get_drvdata(dev);
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +
> +	if (attr->index < 4)
> +		return -EINVAL;
> +	return sprintf(buf, "%d\n", data->crit_alarm[attr->index]);
> +}
> +
> +static mode_t abx500_attrs_visible(struct kobject *kobj,
> +				   struct attribute *a, int n)
> +{
> +	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct abx500_temp *data = dev_get_drvdata(dev);
> +
> +	return data->ops.is_visible(a, n);
> +}
> +
> +/* Chip name, required by hwmon */
> +static SENSOR_DEVICE_ATTR(name, S_IRUGO, show_name, NULL, 0);
> +
> +/* GPADC - SENSOR1 */
> +static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, show_label, NULL, 0);
> +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_input, NULL, 0);
> +static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_min, set_min, 0);
> +static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_max, set_max, 0);
> +static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO,
> +			  show_max_hyst, set_max_hyst, 0);
> +static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO, show_min_alarm, NULL, 0);
> +static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_max_alarm, NULL, 0);
> +
> +/* GPADC - SENSOR2 */
> +static SENSOR_DEVICE_ATTR(temp2_label, S_IRUGO, show_label, NULL, 1);
> +static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_input, NULL, 1);
> +static SENSOR_DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_min, set_min, 1);
> +static SENSOR_DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_max, set_max, 1);
> +static SENSOR_DEVICE_ATTR(temp2_max_hyst, S_IWUSR | S_IRUGO,
> +			  show_max_hyst, set_max_hyst, 1);
> +static SENSOR_DEVICE_ATTR(temp2_min_alarm, S_IRUGO, show_min_alarm, NULL, 1);
> +static SENSOR_DEVICE_ATTR(temp2_max_alarm, S_IRUGO, show_max_alarm, NULL, 1);
> +
> +/* GPADC - SENSOR3 */
> +static SENSOR_DEVICE_ATTR(temp3_label, S_IRUGO, show_label, NULL, 2);
> +static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, show_input, NULL, 2);
> +static SENSOR_DEVICE_ATTR(temp3_min, S_IWUSR | S_IRUGO, show_min, set_min, 2);
> +static SENSOR_DEVICE_ATTR(temp3_max, S_IWUSR | S_IRUGO, show_max, set_max, 2);
> +static SENSOR_DEVICE_ATTR(temp3_max_hyst, S_IWUSR | S_IRUGO,
> +			  show_max_hyst, set_max_hyst, 2);
> +static SENSOR_DEVICE_ATTR(temp3_min_alarm, S_IRUGO, show_min_alarm, NULL, 2);
> +static SENSOR_DEVICE_ATTR(temp3_max_alarm, S_IRUGO, show_max_alarm, NULL, 2);
> +
> +/* GPADC - SENSOR4 */
> +static SENSOR_DEVICE_ATTR(temp4_label, S_IRUGO, show_label, NULL, 3);
> +static SENSOR_DEVICE_ATTR(temp4_input, S_IRUGO, show_input, NULL, 3);
> +static SENSOR_DEVICE_ATTR(temp4_min, S_IWUSR | S_IRUGO, show_min, set_min, 3);
> +static SENSOR_DEVICE_ATTR(temp4_max, S_IWUSR | S_IRUGO, show_max, set_max, 3);
> +static SENSOR_DEVICE_ATTR(temp4_max_hyst, S_IWUSR | S_IRUGO,
> +			  show_max_hyst, set_max_hyst, 3);
> +static SENSOR_DEVICE_ATTR(temp4_min_alarm, S_IRUGO, show_min_alarm, NULL, 3);
> +static SENSOR_DEVICE_ATTR(temp4_max_alarm, S_IRUGO, show_max_alarm, NULL, 3);
> +
> +/* GPADC - SENSOR5 */
> +static SENSOR_DEVICE_ATTR(temp5_label, S_IRUGO, show_label, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp5_input, S_IRUGO, show_input, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp5_min, S_IWUSR | S_IRUGO, show_min, set_min, 4);
> +static SENSOR_DEVICE_ATTR(temp5_max, S_IWUSR | S_IRUGO, show_max, set_max, 4);
> +static SENSOR_DEVICE_ATTR(temp5_max_hyst, S_IWUSR | S_IRUGO,
> +			  show_max_hyst, set_max_hyst, 4);
> +static SENSOR_DEVICE_ATTR(temp5_min_alarm, S_IRUGO, show_min_alarm, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp5_max_alarm, S_IRUGO, show_max_alarm, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp5_crit, S_IRUGO, show_crit, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp5_crit_alarm, S_IRUGO, show_crit_alarm, NULL, 4);
> +
> +struct attribute *abx500_temp_attributes[] = {
> +	&sensor_dev_attr_name.dev_attr.attr,
> +
> +	&sensor_dev_attr_temp1_label.dev_attr.attr,
> +	&sensor_dev_attr_temp1_input.dev_attr.attr,
> +	&sensor_dev_attr_temp1_min.dev_attr.attr,
> +	&sensor_dev_attr_temp1_max.dev_attr.attr,
> +	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
> +	&sensor_dev_attr_temp1_min_alarm.dev_attr.attr,
> +	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
> +
> +	&sensor_dev_attr_temp2_label.dev_attr.attr,
> +	&sensor_dev_attr_temp2_input.dev_attr.attr,
> +	&sensor_dev_attr_temp2_min.dev_attr.attr,
> +	&sensor_dev_attr_temp2_max.dev_attr.attr,
> +	&sensor_dev_attr_temp2_max_hyst.dev_attr.attr,
> +	&sensor_dev_attr_temp2_min_alarm.dev_attr.attr,
> +	&sensor_dev_attr_temp2_max_alarm.dev_attr.attr,
> +
> +	&sensor_dev_attr_temp3_label.dev_attr.attr,
> +	&sensor_dev_attr_temp3_input.dev_attr.attr,
> +	&sensor_dev_attr_temp3_min.dev_attr.attr,
> +	&sensor_dev_attr_temp3_max.dev_attr.attr,
> +	&sensor_dev_attr_temp3_max_hyst.dev_attr.attr,
> +	&sensor_dev_attr_temp3_min_alarm.dev_attr.attr,
> +	&sensor_dev_attr_temp3_max_alarm.dev_attr.attr,
> +
> +	&sensor_dev_attr_temp4_label.dev_attr.attr,
> +	&sensor_dev_attr_temp4_input.dev_attr.attr,
> +	&sensor_dev_attr_temp4_min.dev_attr.attr,
> +	&sensor_dev_attr_temp4_max.dev_attr.attr,
> +	&sensor_dev_attr_temp4_max_hyst.dev_attr.attr,
> +	&sensor_dev_attr_temp4_min_alarm.dev_attr.attr,
> +	&sensor_dev_attr_temp4_max_alarm.dev_attr.attr,
> +
> +	&sensor_dev_attr_temp5_label.dev_attr.attr,
> +	&sensor_dev_attr_temp5_input.dev_attr.attr,
> +	&sensor_dev_attr_temp5_min.dev_attr.attr,
> +	&sensor_dev_attr_temp5_max.dev_attr.attr,
> +	&sensor_dev_attr_temp5_max_hyst.dev_attr.attr,
> +	&sensor_dev_attr_temp5_min_alarm.dev_attr.attr,
> +	&sensor_dev_attr_temp5_max_alarm.dev_attr.attr,
> +	&sensor_dev_attr_temp5_crit.dev_attr.attr,
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
> +
> +	data->ops.irq_handler(irq, data);
> +	return IRQ_HANDLED;
> +}
> +
> +static int setup_irqs(struct platform_device *pdev)
> +{
> +	int ret;
> +	int irq = platform_get_irq_byname(pdev, "ABX500_TEMP_WARM");
> +
> +	if (irq < 0) {
> +		dev_err(&pdev->dev, "Get irq by name failed\n");
> +		return irq;
> +	}
> +
> +	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> +		abx500_temp_irq_handler, IRQF_NO_SUSPEND, "abx500-temp", pdev);
> +	if (ret < 0)
> +		dev_err(&pdev->dev, "Request threaded irq failed (%d)\n", ret);
> +
> +	return ret;
> +}
> +
> +static int abx500_temp_probe(struct platform_device *pdev)
> +{
> +	struct abx500_temp *data;
> +	int err;
> +
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->pdev = pdev;
> +	mutex_init(&data->lock);
> +
> +	/* Chip specific initialization */
> +	err = abx500_hwmon_init(data);
> +	if (err	< 0 || !data->ops.read_sensor || !data->ops.irq_handler
> +	    || !data->ops.show_name || !data->ops.show_label
> +	    || !data->ops.is_visible) {
> +		dev_err(&pdev->dev, "ABx500 hwmon init failed");
> +		return -EINVAL;

You should not hide the original error if one was returned.
	if (err < 0)
		return err;
	if (...)
		return -EINVAL;

> +	}
> +
> +	INIT_DEFERRABLE_WORK(&data->work, gpadc_monitor);
> +	data->gpadc_monitor_delay =  DEFAULT_MONITOR_DELAY;
> +	platform_set_drvdata(pdev, data);
> +
> +	err = sysfs_create_group(&pdev->dev.kobj, &abx500_temp_group);
> +	if (err < 0) {
> +		dev_err(&pdev->dev, "Create sysfs group failed (%d)\n", err);
> +		return err;
> +	}
> +
> +	data->hwmon_dev = hwmon_device_register(&pdev->dev);
> +	if (IS_ERR(data->hwmon_dev)) {
> +		err = PTR_ERR(data->hwmon_dev);
> +		dev_err(&pdev->dev, "Class registration failed (%d)\n", err);
> +		goto exit_sysfs_group;
> +	}
> +
> +	err = setup_irqs(pdev);
> +	if (err < 0) {
> +		dev_err(&pdev->dev, "irq setup failed (%d)\n", err);
> +		goto exit_hwmon_reg;
> +	}
> +	return 0;
> +
> +exit_hwmon_reg:
> +	hwmon_device_unregister(data->hwmon_dev);
> +exit_sysfs_group:
> +	sysfs_remove_group(&pdev->dev.kobj, &abx500_temp_group);
> +	return err;
> +}
> +
> +static int abx500_temp_remove(struct platform_device *pdev)
> +{
> +	struct abx500_temp *data = platform_get_drvdata(pdev);
> +
> +	mutex_lock(&data->lock);
> +	hwmon_device_unregister(data->hwmon_dev);
> +	sysfs_remove_group(&pdev->dev.kobj, &abx500_temp_group);
> +	cancel_delayed_work_sync(&data->work);
> +	mutex_unlock(&data->lock);
> +
> +	return 0;
> +}
> +
> +static int abx500_temp_suspend(struct platform_device *pdev,
> +			       pm_message_t state)
> +{
> +	struct abx500_temp *data = platform_get_drvdata(pdev);
> +
> +	mutex_lock(&data->lock);
> +	if (data->work_active)
> +		cancel_delayed_work_sync(&data->work);
> +	mutex_unlock(&data->lock);
> +
> +	return 0;
> +}
> +
> +static int abx500_temp_resume(struct platform_device *pdev)
> +{
> +	struct abx500_temp *data = platform_get_drvdata(pdev);
> +
> +	if (data->work_active)
> +		schedule_monitor(data);
> +	return 0;
> +}
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id abx500_temp_match[] = {
> +	{ .compatible = "stericsson,abx500-temp" },
> +	{},
> +};
> +#endif
> +
> +static struct platform_driver abx500_temp_driver = {
> +	.driver = {
> +		.owner = THIS_MODULE,
> +		.name = "abx500-temp",
> +		.of_match_table = of_match_ptr(abx500_temp_match),
> +	},
> +	.suspend = abx500_temp_suspend,
> +	.resume = abx500_temp_resume,
> +	.probe = abx500_temp_probe,
> +	.remove = abx500_temp_remove,
> +};
> +
> +module_platform_driver(abx500_temp_driver);
> +
> +MODULE_AUTHOR("Martin Persson <martin.persson@stericsson.com>");
> +MODULE_DESCRIPTION("ABX500 temperature driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/hwmon/abx500.h b/drivers/hwmon/abx500.h
> new file mode 100644
> index 0000000..a1026d8
> --- /dev/null
> +++ b/drivers/hwmon/abx500.h
> @@ -0,0 +1,84 @@
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
> +struct ab8500_btemp;
> +struct abx500_temp;
> +
> +/*
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
> +/*
> + * struct abx500_temp - representation of temp mon device
> + * @pdev: platform device
> + * @hwmon_dev: hwmon device
> + * @ab8500_gpadc: gpadc interface for ab8500
> + * @btemp: battery temperature interface for ab8500
> + * @gpadc_addr: gpadc channel address
> + * @min: sensor temperature min value
> + * @max: sensor temperature max value
> + * @max_hyst: sensor temperature hysteresis value for max limit
> + * @crit: sensor temperature critical value
> + * @min_alarm: sensor temperature min alarm
> + * @max_alarm: sensor temperature max alarm
> + * @crit_alarm: sensor temperature critical value alarm
> + * @work: delayed work scheduled to monitor temperature periodically
> + * @work_active: True if work is active
> + * @power_off_work: delayed work scheduled to power off the system
> + *		when critical temperature is reached
> + * @lock: mutex
> + * @gpadc_monitor_delay: delay between temperature readings in ms
> + * @power_off_delay: delay before power off in ms
> + * @monitored_sensors: number of monitored sensors
> + */
> +struct abx500_temp {
> +	struct platform_device *pdev;
> +	struct device *hwmon_dev;
> +	struct ab8500_gpadc *ab8500_gpadc;
> +	struct ab8500_btemp *ab8500_btemp;
> +	struct abx500_temp_ops ops;
> +	u8 gpadc_addr[NUM_SENSORS];
> +	unsigned long min[NUM_SENSORS];
> +	unsigned long max[NUM_SENSORS];
> +	unsigned long max_hyst[NUM_SENSORS];
> +	unsigned long crit[NUM_SENSORS];
> +	bool min_alarm[NUM_SENSORS];
> +	bool max_alarm[NUM_SENSORS];
> +	bool crit_alarm[NUM_SENSORS];
> +	struct delayed_work work;
> +	bool work_active;
> +	struct delayed_work power_off_work;
> +	struct mutex lock;
> +	/* Delay (ms) between temperature readings */
> +	unsigned long gpadc_monitor_delay;
> +	/* Delay (ms) before power off */
> +	unsigned long power_off_delay;
> +	int monitored_sensors;
> +};
> +
> +int abx500_hwmon_init(struct abx500_temp *data);
> +
> +#endif /* _ABX500_H */
> -- 
> 1.8.0
> 
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
