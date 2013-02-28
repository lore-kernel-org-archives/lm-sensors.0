From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Thu, 28 Feb 2013 11:15:34 +0000
Subject: Re: [lm-sensors] [PATCH v3 3/3] hwmon: add ST-Ericsson ABX500 hwmon driver
Message-Id: <CAJLyvQwRn8nP1sdfwyuN_DRXve+JJBmrFxoBJTtS3zJC4p95EQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1361442761-2690-4-git-send-email-hongbo.zhang@linaro.org>
In-Reply-To: <1361442761-2690-4-git-send-email-hongbo.zhang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Guenter,
Thanks for you thorough review very much, will adopt all your comments.

On 27 February 2013 13:56, Guenter Roeck <linux@roeck-us.net> wrote:
> On Thu, Feb 21, 2013 at 06:32:41PM +0800, Hongbo Zhang wrote:
>> Each of ST-Ericsson X500 chip set series consists of both ABX500 and DBX500
>> chips. This is ABX500 hwmon driver, where the abx500.c is a common layer for
>> all ABX500s, and the ab8500.c is specific for AB8500 chip. Under this designed
>> structure, other chip specific files can be added simply using the same common
>> layer abx500.c.
>>
>> Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
>> ---
>>  Documentation/hwmon/ab8500 |  22 ++
>>  Documentation/hwmon/abx500 |  26 +++
>>  drivers/hwmon/Kconfig      |  13 ++
>>  drivers/hwmon/Makefile     |   1 +
>>  drivers/hwmon/ab8500.c     | 178 ++++++++++++++++
>>  drivers/hwmon/abx500.c     | 501 +++++++++++++++++++++++++++++++++++++++++++++
>>  drivers/hwmon/abx500.h     |  87 ++++++++
>>  7 files changed, 828 insertions(+)
>>  create mode 100644 Documentation/hwmon/ab8500
>>  create mode 100644 Documentation/hwmon/abx500
>>  create mode 100644 drivers/hwmon/ab8500.c
>>  create mode 100644 drivers/hwmon/abx500.c
>>  create mode 100644 drivers/hwmon/abx500.h
>>
>> diff --git a/Documentation/hwmon/ab8500 b/Documentation/hwmon/ab8500
>> new file mode 100644
>> index 0000000..76c534d
>> --- /dev/null
>> +++ b/Documentation/hwmon/ab8500
>> @@ -0,0 +1,22 @@
>> +Kernel driver ab8500
>> +==========
>> +
>> +Supported chips:
>> +  * ST-Ericsson AB8500
>> +    Prefix: 'ab8500'
>> +    Addresses scanned: -
>> +    Datasheet: http://www.stericsson.com/developers/documentation.jsp
>> +
>> +Authors:
>> +        Martin Persson <martin.persson@stericsson.com>
>> +        Hongbo Zhang <hongbo.zhang@linaro.org>
>> +
>> +Description
>> +-----------
>> +
>> +See also Documentation/hwmon/abx500. This is ST-Ericsson AB8500 hwmon specific
>> +initialization.
>> +
> "This is the ST-Ericsson AB8500 specific driver" or similar might be better.
>
>> +Currently only the AB8500 internal sensor and one external sensor for battery
>> +temperature are monitored. Other GPADC channels can also be monitored if needed
>> +in future.
>> diff --git a/Documentation/hwmon/abx500 b/Documentation/hwmon/abx500
>> new file mode 100644
>> index 0000000..f60b73c
>> --- /dev/null
>> +++ b/Documentation/hwmon/abx500
>> @@ -0,0 +1,26 @@
>> +Kernel driver abx500
>> +==========
>> +
>> +Supported chips:
>> +  * ST-Ericsson ABx500 series
>> +    Prefix: 'abx500'
>> +    Addresses scanned: -
>> +    Datasheet: http://www.stericsson.com/developers/documentation.jsp
>> +
>> +Authors:
>> +        Martin Persson <martin.persson@stericsson.com>
>> +        Hongbo Zhang <hongbo.zhang@linaro.org>
>> +
>> +Description
>> +-----------
>> +
>> +Every ST-Ericsson Ux500 SOC consists of both ABx500 and DBx500 physically,
>> +this is kernel hwmon driver for ABx500.
>> +
>> +There are some GPADCs inside ABx500 which are designed for connecting to
>> +thermal sensors, and there is also a thermal sensor inside ABx500 too, which
>> +raises interrupt when critical temperature reached.
>> +
>> +This abx500 is a common layer which can monitor all of the sensors, every
>> +specific abx500 chip has its special configurations in its own file, e.g. some
>> +sensors can be configured invisible if they are not available on that chip.
>
> Given that limits are disabled if set to 0, you really should document that
> here.
>
>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>> index 32f238f..0a6fd21 100644
>> --- a/drivers/hwmon/Kconfig
>> +++ b/drivers/hwmon/Kconfig
>> @@ -39,6 +39,19 @@ config HWMON_DEBUG_CHIP
>>
>>  comment "Native drivers"
>>
>> +config SENSORS_AB8500
>> +     tristate "AB8500 thermal monitoring"
>> +     depends on AB8500_GPADC
>> +     default n
>> +     help
>> +       If you say yes here you get support for the thermal sensor part
>> +       of the AB8500 chip. The driver includes thermal management for
>> +       AB8500 die and two GPADC channels. The GPADC channel are preferably
>> +       used to access sensors outside the AB8500 chip.
>> +
>> +       This driver can also be built as a module.  If so, the module
>> +       will be called abx500-temp.
>> +
>>  config SENSORS_ABITUGURU
>>       tristate "Abit uGuru (rev 1 & 2)"
>>       depends on X86 && DMI
>> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
>> index 5da2874..06dfe85 100644
>> --- a/drivers/hwmon/Makefile
>> +++ b/drivers/hwmon/Makefile
>> @@ -19,6 +19,7 @@ obj-$(CONFIG_SENSORS_W83795)        += w83795.o
>>  obj-$(CONFIG_SENSORS_W83781D)        += w83781d.o
>>  obj-$(CONFIG_SENSORS_W83791D)        += w83791d.o
>>
>> +obj-$(CONFIG_SENSORS_AB8500) += abx500.o ab8500.o
>>  obj-$(CONFIG_SENSORS_ABITUGURU)      += abituguru.o
>>  obj-$(CONFIG_SENSORS_ABITUGURU3)+= abituguru3.o
>>  obj-$(CONFIG_SENSORS_AD7314) += ad7314.o
>> diff --git a/drivers/hwmon/ab8500.c b/drivers/hwmon/ab8500.c
>> new file mode 100644
>> index 0000000..33221e7
>> --- /dev/null
>> +++ b/drivers/hwmon/ab8500.c
>> @@ -0,0 +1,178 @@
>> +/*
>> + * Copyright (C) ST-Ericsson SA 2010
>
>         2010 - 1013 ?
>
>> + * Author: Martin Persson <martin.persson@stericsson.com>
>> + *         Hongbo Zhang <hongbo.zhang@linaro.org>
>> + * License Terms: GNU General Public License v2
>> + *
>> + * If/when the AB8500 thermal warning temperature is reached (threshold cannot
>> + * be changed by SW), an interrupt is set and the driver notifies user space
>> + * via a sysfs event. If a shut down is not triggered by user space within a
>> + * certain time frame, pm_power off is called.
>> + *
>> + * If/when AB8500 thermal shutdown temperature is reached a hardware shutdown
>> + * of the AB8500 will occur.
>> + */
>> +
>> +#include <linux/err.h>
>> +#include <linux/hwmon.h>
>> +#include <linux/hwmon-sysfs.h>
>> +#include <linux/mfd/abx500.h>
>> +#include <linux/mfd/abx500/ab8500-bm.h>
>> +#include <linux/mfd/abx500/ab8500-gpadc.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +#include <linux/sysfs.h>
>> +#include "abx500.h"
>> +
>> +#define DEFAULT_POWER_OFF_DELAY      10000
>
> I notice you define all delays in ms just to convert them to jiffies, yet the
> delays are hardly ever reported to the user anywhere. I think it would make
> more sense to just define the delays in HZ, use them directly, and use
> msecs_to_jiffies() in the one case where a delay reported to the user.
> This would have the added benefit that (HZ * 10) is easier to understand
> than an unexplained 10000 when reading the code.
>
>> +#define NUM_MONITORED_SENSORS        4
>> +#define THERMAL_VCC          1800
>> +#define PULL_UP_RESISTOR     47000
>> +
>> +/*
>> + * The hardware connection is like this:
>> + * VCC----[ R_up ]-----[ NTC ]----GND
>> + * where R_up is pull-up resistance, and GPADC measures voltage on NTC.
>> + * and res_to_temp table is strictly sorted by falling resistance values.
>> + */
>> +static int voltage_to_temp(int vcc, int r_up, int v_ntc,
>> +             const struct abx500_res_to_temp *tbl, int tbl_sz, int *temp)
>> +{
>> +     int r_ntc, i = 0;
>> +
>> +     if (vcc < 0 || v_ntc > vcc)
>
> Should be 'v_ntc >= vcc' to avoid the = case and resulting division by zero.
>
>> +             return -EINVAL;
>> +
>> +     r_ntc = v_ntc * r_up / (vcc - v_ntc);
>> +     if (r_ntc > tbl[0].resist || r_ntc < tbl[tbl_sz - 1].resist)
>> +             return -EINVAL;
>> +
>> +     while (!(r_ntc <= tbl[i].resist && r_ntc > tbl[i + 1].resist)
>> +             && i < tbl_sz - 2)
>> +             i++;
>> +
>> +     *temp = tbl[i].temp + ((tbl[i + 1].temp - tbl[i].temp) *
>> +             (r_ntc - tbl[i].resist)) / (tbl[i + 1].resist - tbl[i].resist);
>> +
>> +     return 0;
>> +}
>> +
>> +static int ab8500_read_sensor(struct abx500_temp *data, u8 sensor)
>> +{
>> +     int temp, voltage, ret;
>> +
>> +     if (sensor = BAT_CTRL)
>> +             temp = ab8500_btemp_get_batctrl_temp(data->ab8500_btemp);
>
> That can return a valid number below zero unless I am missing something
> (BTEMP_THERMAL_LOW_LIMIT is -10). Which means you can not return the error
> and the return value and need to use a pointer for the return value after all.
>
>> +
>> +     else if (sensor = BTEMP_BALL)
>> +             temp = ab8500_btemp_get_temp(data->ab8500_btemp);
>
> Same here.
>
>> +
>> +     else {
>> +             voltage = ab8500_gpadc_convert(data->ab8500_gpadc, sensor);
>> +             if (voltage < 0)
>> +                     return -EINVAL;
>
>                         return voltage;
>> +
>> +             ret = voltage_to_temp(THERMAL_VCC, PULL_UP_RESISTOR, voltage,
>> +                     temp_tbl_A_thermistor, temp_tbl_A_size, &temp);
>
> This can also return a negative temperature (the first temperature entry in
> temp_tbl_A_thermistor is negative).
>
>> +             if (ret < 0)
>> +                     return -EINVAL;
>
>                         return ret;
>
>> +             temp *= 1000;
>> +     }
>> +
>> +     return temp;
>> +}
>> +
>> +static void ab8500_thermal_power_off(struct work_struct *work)
>> +{
>> +     struct abx500_temp *data = container_of(work, struct abx500_temp,
>> +                                             power_off_work.work);
>> +
>> +     dev_warn(&data->pdev->dev,
>> +             "Power off due to AB8500 thermal warning.\n");
>> +     pm_power_off();
>> +}
>> +
>> +static ssize_t ab8500_show_name(struct device *dev,
>> +                             struct device_attribute *devattr,
>> +                             char *buf)
>> +{
>> +     return sprintf(buf, "ab8500\n");
>> +}
>> +
>> +static ssize_t ab8500_show_label(struct device *dev,
>> +                             struct device_attribute *devattr,
>> +                             char *buf)
>> +{
>> +     char *name;
>
> Nitpick: label, really.
>
>> +     struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>> +     int index = attr->index;
>> +
>> +     switch (index) {
>> +     case 1:
>> +             name = "ext_adc1";
>> +             break;
>> +     case 2:
>> +             name = "ext_adc2";
>> +             break;
>> +     case 3:
>> +             name = "bat_temp";
>> +             break;
>> +     case 4:
>> +             name = "bat_ctrl";
>> +             break;
>> +     default:
>> +             return -EINVAL;
>> +     }
>> +     return sprintf(buf, "%s\n", name);
>> +}
>> +
>> +static int ab8500_is_visible(struct attribute *attr, int n)
>> +{
>> +     return attr->mode;
>> +}
>
> Instead of providing an empty function, you should make is_visible optional
> and have the calling code return attr->mode directly if it is not defined
> (ie NULL).
>
>> +
>> +static int ab8500_temp_irq_handler(int irq, struct abx500_temp *data)
>> +{
>> +     unsigned long delay_in_jiffies;
>> +
>> +     dev_info(&data->pdev->dev, "AB8500 warning, power off in %lu s\n",
>> +             data->power_off_delay);
>> +
>         dev_warn, and "AB8500 warning" is redundant.
>
>> +     delay_in_jiffies = msecs_to_jiffies(data->power_off_delay);
>> +     schedule_delayed_work(&data->power_off_work, delay_in_jiffies);
>> +     return 0;
>> +}
>> +
>> +int abx500_hwmon_init(struct abx500_temp *data)
>> +{
>> +     data->ab8500_gpadc = ab8500_gpadc_get("ab8500-gpadc.0");
>> +     if (IS_ERR(data->ab8500_gpadc))
>> +             return PTR_ERR(data->ab8500_gpadc);
>> +
>> +     data->ab8500_btemp = ab8500_btemp_get();
>> +     if (IS_ERR(data->ab8500_btemp))
>> +             return PTR_ERR(data->ab8500_btemp);
>> +
>> +     INIT_DELAYED_WORK(&data->power_off_work, ab8500_thermal_power_off);
>> +
>> +     /*
>> +      * ADC_AUX1 and ADC_AUX2, connected to external NTC
>> +      * BTEMP_BALL and BAT_CTRL, fixed usage
>> +      */
>> +     data->gpadc_addr[0] = ADC_AUX1;
>> +     data->gpadc_addr[1] = ADC_AUX2;
>> +     data->gpadc_addr[2] = BTEMP_BALL;
>> +     data->gpadc_addr[3] = BAT_CTRL;
>> +
>> +     data->power_off_delay = DEFAULT_POWER_OFF_DELAY;
>> +     data->monitored_sensors = NUM_MONITORED_SENSORS;
>> +
>> +     data->ops.read_sensor = ab8500_read_sensor;
>> +     data->ops.irq_handler = ab8500_temp_irq_handler;
>> +     data->ops.show_name = ab8500_show_name;
>> +     data->ops.show_label = ab8500_show_label;
>> +     data->ops.is_visible = ab8500_is_visible;
>> +
>> +     return 0;
>> +}
>> diff --git a/drivers/hwmon/abx500.c b/drivers/hwmon/abx500.c
>> new file mode 100644
>> index 0000000..69ea8cb
>> --- /dev/null
>> +++ b/drivers/hwmon/abx500.c
>> @@ -0,0 +1,501 @@
>> +/*
>> + * Copyright (C) ST-Ericsson SA 2010
>
>         2010 - 1023 ?
>
>> + * Author: Martin Persson <martin.persson@stericsson.com>
>> + *         Hongbo Zhang <hongbo.zhang@linaro.org>
>> + * License Terms: GNU General Public License v2
>> + *
>> + * ABX500 does not provide auto ADC, so to monitor the required temperatures,
>> + * a periodic work is used. It is more important to not wake up the CPU than
>> + * to perform this job, hence the use of a deferred delay.
>> + *
>> + * A deferred delay for thermal monitor is considered safe because:
>> + * If the chip gets too hot during a sleep state it's most likely due to
>> + * external factors, such as the surrounding temperature. I.e. no SW decisions
>> + * will make any difference.
>> + *
>> + * If/when the ABX500 thermal warning temperature is reached (threshold cannot
>> + * be changed by SW), an interrupt is set and the driver notifies user space
>> + * via a sysfs event.
>> + *
>> + * If/when ABX500 thermal shutdown temperature is reached a hardware shutdown
>> + * of the ABX500 will occur.
>> + */
>> +
>> +#include <linux/err.h>
>> +#include <linux/hwmon.h>
>> +#include <linux/hwmon-sysfs.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/jiffies.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm.h>
>> +#include <linux/slab.h>
>> +#include <linux/sysfs.h>
>> +#include <linux/workqueue.h>
>> +#include "abx500.h"
>> +
>> +#define DEFAULT_MONITOR_DELAY 1000
>> +
>> +static inline void schedule_monitor(struct abx500_temp *data)
>> +{
>> +     unsigned long delay_in_jiffies;
>> +     delay_in_jiffies = msecs_to_jiffies(data->gpadc_monitor_delay);
>> +     data->work_active = true;
>> +     schedule_delayed_work(&data->work, delay_in_jiffies);
>> +}
>> +
>> +static void threshold_updated(struct abx500_temp *data)
>> +{
>> +     int i;
>> +     for (i = 0; i < data->monitored_sensors; i++)
>> +             if (data->max[i] != 0 || data->min[i] != 0) {
>> +                     schedule_monitor(data);
>> +                     return ;
>
>         Extra ' ' before ;
>
>> +             }
>> +
>> +     dev_dbg(&data->pdev->dev, "No active thresholds.\n");
>> +     cancel_delayed_work_sync(&data->work);
>> +     data->work_active = false;
>> +}
>> +
>> +static void gpadc_monitor(struct work_struct *work)
>> +{
>> +     int val, i, ret;
>> +     char alarm_node[30];
>> +     bool updated_min_alarm = false;
>> +     bool updated_max_alarm = false;
>> +     struct abx500_temp *data = container_of(work, struct abx500_temp,
>> +                                             work.work);
>> +
>> +     mutex_lock(&data->lock);
>> +     for (i = 0; i < data->monitored_sensors; i++) {
>> +             /* Thresholds are considered inactive if set to 0 */
>> +             if (data->max[i] = 0 && data->min[i] = 0)
>> +                     continue;
>> +             /*
>> +              * In case we are in the temporary state that one threshold
>> +              * has been changed, but the other hasn't yet.
>> +              */
>> +             if (data->max[i] < data->min[i])
>> +                     continue;
>> +
>> +             val = data->ops.read_sensor(data, data->gpadc_addr[i]);
>> +             if (val < 0) {
>> +                     dev_err(&data->pdev->dev, "GPADC read failed\n");
>> +                     continue;
>> +             }
>> +
>> +             if (data->min[i] != 0) {
>> +                     if (val < data->min[i]) {
>> +                             if (data->min_alarm[i] = false) {
>> +                                     data->min_alarm[i] = true;
>> +                                     updated_min_alarm = true;
>> +                             }
>> +                     } else {
>> +                             if (data->min_alarm[i] = true) {
>> +                                     data->min_alarm[i] = false;
>> +                                     updated_min_alarm = true;
>> +                             }
>> +                     }
>> +
> Unnecessary empty line.
>
>> +             }
>> +             if (data->max[i] != 0) {
>> +                     if (val > data->max[i]) {
>> +                             if (data->max_alarm[i] = false) {
>> +                                     data->max_alarm[i] = true;
>> +                                     updated_max_alarm = true;
>> +                             }
>> +                     } else if (val < data->max[i] - data->max_hyst[i]) {
>> +                             if (data->max_alarm[i] = true) {
>> +                                     data->max_alarm[i] = false;
>> +                                     updated_max_alarm = true;
>> +                             }
>> +                     }
>> +             }
>> +
>> +             if (updated_min_alarm) {
>> +                     ret = sprintf(alarm_node, "temp%d_min_alarm", i);
>> +                     sysfs_notify(&data->pdev->dev.kobj, NULL, alarm_node);
>> +             }
>> +             if (updated_max_alarm) {
>> +                     ret = sprintf(alarm_node, "temp%d_max_alarm", i);
>> +                     sysfs_notify(&data->pdev->dev.kobj, NULL, alarm_node);
>> +             }
>> +
>> +             updated_min_alarm = false;
>> +             updated_max_alarm = false;
>> +     }
>> +
>> +     schedule_monitor(data);
>> +     mutex_unlock(&data->lock);
>> +}
>> +
>> +/* HWMON sysfs interfaces */
>> +static ssize_t show_name(struct device *dev, struct device_attribute *devattr,
>> +                      char *buf)
>> +{
>> +     struct abx500_temp *data = dev_get_drvdata(dev);
>> +     /* Show chip name */
>> +     return data->ops.show_name(dev, devattr, buf);
>> +}
>> +
>> +static ssize_t show_label(struct device *dev,
>> +                       struct device_attribute *devattr, char *buf)
>> +{
>> +     struct abx500_temp *data = dev_get_drvdata(dev);
>> +     /* Show each sensor label */
>> +     return data->ops.show_label(dev, devattr, buf);
>> +}
>> +
>> +static ssize_t show_input(struct device *dev,
>> +                       struct device_attribute *devattr, char *buf)
>> +{
>> +     int val;
>> +     struct abx500_temp *data = dev_get_drvdata(dev);
>> +     struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>> +     u8 gpadc_addr = data->gpadc_addr[attr->index];
>> +
>> +     val = data->ops.read_sensor(data, gpadc_addr);
>> +     if (val < 0)
>> +             dev_err(&data->pdev->dev, "GPADC read failed\n");
>> +
>> +     return sprintf(buf, "%d\n", val);
>> +}
>> +
>> +/* Set functions (RW nodes) */
>> +static ssize_t set_min(struct device *dev, struct device_attribute *devattr,
>> +                    const char *buf, size_t count)
>> +{
>> +     unsigned long val;
>> +     struct abx500_temp *data = dev_get_drvdata(dev);
>> +     struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>> +     int res = kstrtoul(buf, 10, &val);
>> +     if (res < 0)
>> +             return res;
>> +
>
> You should use kstrtol, and use clamp_val() to limit the range. We don't expect
> users to know the valid limits for this chip, and furthermore the limit could be
> the result of a calculation.
>
> Sure you want to accept arbitrary upper limits ? 1,000,000 degrees C ?
>
OK, learned, thanks.

>> +     mutex_lock(&data->lock);
>> +     data->min[attr->index] = val;
>> +     threshold_updated(data);
>> +     mutex_unlock(&data->lock);
>> +
>> +     return count;
>> +}
>> +
>> +static ssize_t set_max(struct device *dev, struct device_attribute *devattr,
>> +                    const char *buf, size_t count)
>> +{
>> +     unsigned long val;
>> +     struct abx500_temp *data = dev_get_drvdata(dev);
>> +     struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>> +     int res = kstrtoul(buf, 10, &val);
>
> Same as above.
>
>> +     if (res < 0)
>> +             return res;
>> +
>> +     mutex_lock(&data->lock);
>> +     data->max[attr->index] = val;
>> +     threshold_updated(data);
>> +     mutex_unlock(&data->lock);
>> +
>> +     return count;
>> +}
>> +
>> +static ssize_t set_max_hyst(struct device *dev,
>> +                         struct device_attribute *devattr,
>> +                         const char *buf, size_t count)
>> +{
>> +     unsigned long val;
>> +     struct abx500_temp *data = dev_get_drvdata(dev);
>> +     struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>> +     int res = kstrtoul(buf, 10, &val);
>> +     if (res < 0)
>> +             return res;
>> +
>> +     mutex_lock(&data->lock);
>> +     data->max_hyst[attr->index] = val;
>> +     threshold_updated(data);
>> +     mutex_unlock(&data->lock);
>> +
>> +     return count;
>> +}
>> +
>> +/* Show functions (RO nodes) */
>> +static ssize_t show_min(struct device *dev,
>> +                     struct device_attribute *devattr, char *buf)
>> +{
>> +     struct abx500_temp *data = dev_get_drvdata(dev);
>> +     struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>> +
>> +     return sprintf(buf, "%ld\n", data->min[attr->index]);
>> +}
>> +
>> +static ssize_t show_max(struct device *dev,
>> +                     struct device_attribute *devattr, char *buf)
>> +{
>> +     struct abx500_temp *data = dev_get_drvdata(dev);
>> +     struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>> +
>> +     return sprintf(buf, "%ld\n", data->max[attr->index]);
>> +}
>> +
>> +static ssize_t show_max_hyst(struct device *dev,
>> +                          struct device_attribute *devattr, char *buf)
>> +{
>> +     struct abx500_temp *data = dev_get_drvdata(dev);
>> +     struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>> +
>> +     return sprintf(buf, "%ld\n", data->max_hyst[attr->index]);
>> +}
>> +
>> +static ssize_t show_min_alarm(struct device *dev,
>> +                           struct device_attribute *devattr, char *buf)
>> +{
>> +     struct abx500_temp *data = dev_get_drvdata(dev);
>> +     struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>> +
>> +     return sprintf(buf, "%d\n", data->min_alarm[attr->index]);
>> +}
>> +
>> +static ssize_t show_max_alarm(struct device *dev,
>> +                           struct device_attribute *devattr, char *buf)
>> +{
>> +     struct abx500_temp *data = dev_get_drvdata(dev);
>> +     struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>> +
>> +     return sprintf(buf, "%d\n", data->max_alarm[attr->index]);
>> +}
>> +
>> +static mode_t abx500_attrs_visible(struct kobject *kobj,
>> +                                struct attribute *a, int n)
>> +{
>> +     struct device *dev = container_of(kobj, struct device, kobj);
>> +     struct abx500_temp *data = dev_get_drvdata(dev);
>> +
>> +     return data->ops.is_visible(a, n);
>> +}
>> +
>> +/* Chip name, required by hwmon */
>> +static SENSOR_DEVICE_ATTR(name, S_IRUGO, show_name, NULL, 0);
>> +
>> +/* GPADC - SENSOR1 */
>> +static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, show_label, NULL, 0);
>> +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_input, NULL, 0);
>> +static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_min, set_min, 0);
>> +static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_max, set_max, 0);
>> +static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO,
>> +                       show_max_hyst, set_max_hyst, 0);
>> +static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO, show_min_alarm, NULL, 0);
>> +static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_max_alarm, NULL, 0);
>> +
>> +/* GPADC - SENSOR2 */
>> +static SENSOR_DEVICE_ATTR(temp2_label, S_IRUGO, show_label, NULL, 1);
>> +static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_input, NULL, 1);
>> +static SENSOR_DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_min, set_min, 1);
>> +static SENSOR_DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_max, set_max, 1);
>> +static SENSOR_DEVICE_ATTR(temp2_max_hyst, S_IWUSR | S_IRUGO,
>> +                       show_max_hyst, set_max_hyst, 1);
>> +static SENSOR_DEVICE_ATTR(temp2_min_alarm, S_IRUGO, show_min_alarm, NULL, 1);
>> +static SENSOR_DEVICE_ATTR(temp2_max_alarm, S_IRUGO, show_max_alarm, NULL, 1);
>> +
>> +/* GPADC - SENSOR3 */
>> +static SENSOR_DEVICE_ATTR(temp3_label, S_IRUGO, show_label, NULL, 2);
>> +static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, show_input, NULL, 2);
>> +static SENSOR_DEVICE_ATTR(temp3_min, S_IWUSR | S_IRUGO, show_min, set_min, 2);
>> +static SENSOR_DEVICE_ATTR(temp3_max, S_IWUSR | S_IRUGO, show_max, set_max, 2);
>> +static SENSOR_DEVICE_ATTR(temp3_max_hyst, S_IWUSR | S_IRUGO,
>> +                       show_max_hyst, set_max_hyst, 2);
>> +static SENSOR_DEVICE_ATTR(temp3_min_alarm, S_IRUGO, show_min_alarm, NULL, 2);
>> +static SENSOR_DEVICE_ATTR(temp3_max_alarm, S_IRUGO, show_max_alarm, NULL, 2);
>> +
>> +/* GPADC - SENSOR4 */
>> +static SENSOR_DEVICE_ATTR(temp4_label, S_IRUGO, show_label, NULL, 3);
>> +static SENSOR_DEVICE_ATTR(temp4_input, S_IRUGO, show_input, NULL, 3);
>> +static SENSOR_DEVICE_ATTR(temp4_min, S_IWUSR | S_IRUGO, show_min, set_min, 3);
>> +static SENSOR_DEVICE_ATTR(temp4_max, S_IWUSR | S_IRUGO, show_max, set_max, 3);
>> +static SENSOR_DEVICE_ATTR(temp4_max_hyst, S_IWUSR | S_IRUGO,
>> +                       show_max_hyst, set_max_hyst, 3);
>> +static SENSOR_DEVICE_ATTR(temp4_min_alarm, S_IRUGO, show_min_alarm, NULL, 3);
>> +static SENSOR_DEVICE_ATTR(temp4_max_alarm, S_IRUGO, show_max_alarm, NULL, 3);
>> +
>> +struct attribute *abx500_temp_attributes[] = {
>> +     &sensor_dev_attr_name.dev_attr.attr,
>> +
>> +     &sensor_dev_attr_temp1_label.dev_attr.attr,
>> +     &sensor_dev_attr_temp1_input.dev_attr.attr,
>> +     &sensor_dev_attr_temp1_min.dev_attr.attr,
>> +     &sensor_dev_attr_temp1_max.dev_attr.attr,
>> +     &sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
>> +     &sensor_dev_attr_temp1_min_alarm.dev_attr.attr,
>> +     &sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
>> +
>> +     &sensor_dev_attr_temp2_label.dev_attr.attr,
>> +     &sensor_dev_attr_temp2_input.dev_attr.attr,
>> +     &sensor_dev_attr_temp2_min.dev_attr.attr,
>> +     &sensor_dev_attr_temp2_max.dev_attr.attr,
>> +     &sensor_dev_attr_temp2_max_hyst.dev_attr.attr,
>> +     &sensor_dev_attr_temp2_min_alarm.dev_attr.attr,
>> +     &sensor_dev_attr_temp2_max_alarm.dev_attr.attr,
>> +
>> +     &sensor_dev_attr_temp3_label.dev_attr.attr,
>> +     &sensor_dev_attr_temp3_input.dev_attr.attr,
>> +     &sensor_dev_attr_temp3_min.dev_attr.attr,
>> +     &sensor_dev_attr_temp3_max.dev_attr.attr,
>> +     &sensor_dev_attr_temp3_max_hyst.dev_attr.attr,
>> +     &sensor_dev_attr_temp3_min_alarm.dev_attr.attr,
>> +     &sensor_dev_attr_temp3_max_alarm.dev_attr.attr,
>> +
>> +     &sensor_dev_attr_temp4_label.dev_attr.attr,
>> +     &sensor_dev_attr_temp4_input.dev_attr.attr,
>> +     &sensor_dev_attr_temp4_min.dev_attr.attr,
>> +     &sensor_dev_attr_temp4_max.dev_attr.attr,
>> +     &sensor_dev_attr_temp4_max_hyst.dev_attr.attr,
>> +     &sensor_dev_attr_temp4_min_alarm.dev_attr.attr,
>> +     &sensor_dev_attr_temp4_max_alarm.dev_attr.attr,
>> +     NULL
>> +};
>> +
>> +static const struct attribute_group abx500_temp_group = {
>> +     .attrs = abx500_temp_attributes,
>> +     .is_visible = abx500_attrs_visible,
>> +};
>> +
>> +static irqreturn_t abx500_temp_irq_handler(int irq, void *irq_data)
>> +{
>> +     struct platform_device *pdev = irq_data;
>> +     struct abx500_temp *data = platform_get_drvdata(pdev);
>> +
>> +     data->ops.irq_handler(irq, data);
>> +     return IRQ_HANDLED;
>> +}
>> +
>> +static int setup_irqs(struct platform_device *pdev)
>> +{
>> +     int ret;
>> +     int irq = platform_get_irq_byname(pdev, "ABX500_TEMP_WARM");
>> +
>> +     if (irq < 0) {
>> +             dev_err(&pdev->dev, "Get irq by name failed\n");
>> +             return irq;
>> +     }
>> +
>> +     ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
>> +             abx500_temp_irq_handler, IRQF_NO_SUSPEND, "abx500-temp", pdev);
>> +     if (ret < 0)
>> +             dev_err(&pdev->dev, "Request threaded irq failed (%d)\n", ret);
>> +
>> +     return ret;
>> +}
>> +
>> +static int abx500_temp_probe(struct platform_device *pdev)
>> +{
>> +     struct abx500_temp *data;
>> +     int err;
>> +
>> +     data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
>> +     if (!data)
>> +             return -ENOMEM;
>> +
>> +     data->pdev = pdev;
>> +     mutex_init(&data->lock);
>> +
>> +     /* Chip specific initialization */
>> +     err = abx500_hwmon_init(data);
>> +     if (err < 0 || !data->ops.read_sensor || !data->ops.show_name
>> +             || !data->ops.show_label || !data->ops.is_visible) {
>
> Nitpick: Second line should be aligned with '('.
>
>> +             dev_err(&pdev->dev, "ABx500 hwmon init failed");
>> +             return -EINVAL;
>> +     }
>> +
>> +     INIT_DEFERRABLE_WORK(&data->work, gpadc_monitor);
>> +     data->gpadc_monitor_delay =  DEFAULT_MONITOR_DELAY;
>
> Any benefit of having this as variable in the first place ? Why not just use the
> define ?
>
> Nitpick: Extra space after '='.
>
>> +     platform_set_drvdata(pdev, data);
>> +
>> +     err = sysfs_create_group(&pdev->dev.kobj, &abx500_temp_group);
>> +     if (err < 0) {
>> +             dev_err(&pdev->dev, "Create sysfs group failed (%d)\n", err);
>> +             return err;
>> +     }
>> +
>> +     data->hwmon_dev = hwmon_device_register(&pdev->dev);
>> +     if (IS_ERR(data->hwmon_dev)) {
>> +             err = PTR_ERR(data->hwmon_dev);
>> +             dev_err(&pdev->dev, "Class registration failed (%d)\n", err);
>> +             goto exit_sysfs_group;
>> +     }
>> +
>> +     if (data->ops.irq_handler) {
>> +             err = setup_irqs(pdev);
>> +             if (err < 0) {
>> +                     dev_err(&pdev->dev, "irq setup failed (%d)\n", err);
>> +                     goto exit_hwmon_reg;
>> +             }
>> +     }
>> +     return 0;
>> +
>> +exit_hwmon_reg:
>> +     hwmon_device_unregister(data->hwmon_dev);
>> +exit_sysfs_group:
>> +     sysfs_remove_group(&pdev->dev.kobj, &abx500_temp_group);
>> +     return err;
>> +}
>> +
>> +static int abx500_temp_remove(struct platform_device *pdev)
>> +{
>> +     struct abx500_temp *data = platform_get_drvdata(pdev);
>> +
>> +     mutex_lock(&data->lock);
>> +     hwmon_device_unregister(data->hwmon_dev);
>> +     sysfs_remove_group(&pdev->dev.kobj, &abx500_temp_group);
>> +     cancel_delayed_work_sync(&data->work);
>
> Should come first.
>
>> +     mutex_unlock(&data->lock);
>
> This mutex protection is definitely not needed.
>
>> +
>> +     return 0;
>> +}
>> +
>> +static int abx500_temp_suspend(struct platform_device *pdev,
>> +                            pm_message_t state)
>> +{
>> +     struct abx500_temp *data = platform_get_drvdata(pdev);
>> +
>> +     mutex_lock(&data->lock);
>> +     if (data->work_active)
>> +             cancel_delayed_work_sync(&data->work);
>> +     mutex_unlock(&data->lock);
>
> I don't think this mutex protection is needed. Looking into other drivers, they
> commonly cancel work outside mutex protection.
>
> What happens if poweroff due to overheating is pending ?
>
>> +
>> +     return 0;
>> +}
>> +
>> +static int abx500_temp_resume(struct platform_device *pdev)
>> +{
>> +     struct abx500_temp *data = platform_get_drvdata(pdev);
>> +
>> +     if (data->work_active)
>> +             schedule_monitor(data);
>> +     return 0;
>> +}
>> +
>> +#ifdef CONFIG_OF
>> +static const struct of_device_id abx500_temp_match[] = {
>> +     { .compatible = "stericsson,abx500-temp" },
>> +     {},
>> +};
>> +#endif
>> +
>> +static struct platform_driver abx500_temp_driver = {
>> +     .driver = {
>> +             .owner = THIS_MODULE,
>> +             .name = "abx500-temp",
>> +             .of_match_table = of_match_ptr(abx500_temp_match),
>> +     },
>> +     .suspend = abx500_temp_suspend,
>> +     .resume = abx500_temp_resume,
>> +     .probe = abx500_temp_probe,
>> +     .remove = abx500_temp_remove,
>> +};
>> +
>> +module_platform_driver(abx500_temp_driver);
>> +
>> +MODULE_AUTHOR("Martin Persson <martin.persson@stericsson.com>");
>> +MODULE_DESCRIPTION("ABX500 temperature driver");
>> +MODULE_LICENSE("GPL");
>> diff --git a/drivers/hwmon/abx500.h b/drivers/hwmon/abx500.h
>> new file mode 100644
>> index 0000000..c1dd41d
>> --- /dev/null
>> +++ b/drivers/hwmon/abx500.h
>> @@ -0,0 +1,87 @@
>> +/*
>> + * Copyright (C) ST-Ericsson SA 2010
>
>         2010 - 2013 ?
>
>> + * License terms: GNU General Public License v2
>> + * Author: Martin Persson <martin.persson@stericsson.com>
>> + */
>> +
>> +#ifndef _ABX500_H
>> +#define _ABX500_H
>> +
>> +#define NUM_SENSORS 5
>> +
>> +struct ab8500_gpadc;
>> +struct ab8500_btemp;
>> +struct abx500_temp;
>> +
>> +extern struct abx500_res_to_temp temp_tbl_A_thermistor[];
>> +extern int temp_tbl_A_size;
>
> Those variables should be defined in the defining code in an exporting
> include file, which this driver should include. Also, the name should be less
> generic and refer to the introducing module (abx500_temp_tbl_a_thermistor,
> maybe).
>
> Also, CamelCase variable names are discouraged nowadays and create a checkpatch
> warning. Please take that into account when selecting a different name.
>
Talked to the owner of that part, we will move the data to proper
place, and rename the variables.

>> +
>> +/*
>> + * struct abx500_temp_ops - abx500 chip specific ops
>> + * @read_sensor: reads gpadc output
>> + * @irq_handler: irq handler
>> + * @show_name: hwmon device name
>> + * @show_label: hwmon attribute label
>> + * @is_visible: is attribute visible
>> + */
>> +struct abx500_temp_ops {
>> +     int (*read_sensor)(struct abx500_temp *, u8);
>> +     int (*irq_handler)(int, struct abx500_temp *);
>> +     ssize_t (*show_name)(struct device *,
>> +                     struct device_attribute *, char *);
>> +     ssize_t (*show_label) (struct device *,
>> +                     struct device_attribute *, char *);
>> +     int (*is_visible)(struct attribute *, int);
>> +};
>> +
>> +/*
>> + * struct abx500_temp - representation of temp mon device
>> + * @pdev: platform device
>> + * @hwmon_dev: hwmon device
>> + * @ab8500_gpadc: gpadc interface for ab8500
>> + * @btemp: battery temperature interface for ab8500
>> + * @gpadc_addr: gpadc channel address
>> + * @min: sensor temperature min value
>> + * @max: sensor temperature max value
>> + * @max_hyst: sensor temperature hysteresis value for max limit
>> + * @crit: sensor temperature critical value
>> + * @min_alarm: sensor temperature min alarm
>> + * @max_alarm: sensor temperature max alarm
>> + * @crit_alarm: sensor temperature critical value alarm
>> + * @work: delayed work scheduled to monitor temperature periodically
>> + * @work_active: True if work is active
>> + * @power_off_work: delayed work scheduled to power off the system
>> + *           when critical temperature is reached
>> + * @lock: mutex
>> + * @gpadc_monitor_delay: delay between temperature readings in ms
>> + * @power_off_delay: delay before power off in ms
>> + * @monitored_sensors: number of monitored sensors
>> + */
>> +struct abx500_temp {
>> +     struct platform_device *pdev;
>> +     struct device *hwmon_dev;
>> +     struct ab8500_gpadc *ab8500_gpadc;
>> +     struct ab8500_btemp *ab8500_btemp;
>> +     struct abx500_temp_ops ops;
>> +     u8 gpadc_addr[NUM_SENSORS];
>> +     unsigned long min[NUM_SENSORS];
>> +     unsigned long max[NUM_SENSORS];
>> +     unsigned long max_hyst[NUM_SENSORS];
>> +     unsigned long crit[NUM_SENSORS];
>
> Not used anywhere.
>
>> +     bool min_alarm[NUM_SENSORS];
>> +     bool max_alarm[NUM_SENSORS];
>> +     bool crit_alarm[NUM_SENSORS];
>
> Not used anywhere.
>
>> +     struct delayed_work work;
>> +     bool work_active;
>> +     struct delayed_work power_off_work;
>> +     struct mutex lock;
>> +     /* Delay (ms) between temperature readings */
>> +     unsigned long gpadc_monitor_delay;
>> +     /* Delay (ms) before power off */
>> +     unsigned long power_off_delay;
>> +     int monitored_sensors;
>
> Many of those variables are only used in the abx500 code. You should have two
> structures, one defined inside the abx500 code for variables only used there,
> and one exported to other drivers. The exported structure could be embedded in
> the private one.
>
> Similar, you should have a private data structure in the ab8500 driver, for
> variables only used there.
>
Yes, will consider this.
(historic reason is that these two files was one file before, and then
separated into two)

>> +};
>> +
>> +int abx500_hwmon_init(struct abx500_temp *data);
>> +
>> +#endif /* _ABX500_H */
>> --
>> 1.8.0
>>
>>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
