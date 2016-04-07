From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 07 Apr 2016 16:52:46 +0000
Subject: Re: [lm-sensors] [PATCH v4] hwmon: (max31722) Add threshold alarm support
Message-Id: <20160407165246.GA24713@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1460037730-2030-1-git-send-email-tiberiu.a.breana@intel.com>
In-Reply-To: <1460037730-2030-1-git-send-email-tiberiu.a.breana@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Apr 07, 2016 at 05:02:10PM +0300, Tiberiu Breana wrote:
> Add threshold alarm support for the max31722 temperature sensor driver.
> 
> Signed-off-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
> ---
> Changes from v3:
> - addressed Guenter's comments
> - threshold attributes are now only visible if interrupts are enabled
> - max31722_show_temp will now print cached threshold values
> - added mutex protection for setting threshold values
> - added the max31722_init_thresh function, called at probing time
> ---
>  drivers/hwmon/max31722.c | 176 +++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 172 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/max31722.c b/drivers/hwmon/max31722.c
> index 30a100e..8d09d39 100644
> --- a/drivers/hwmon/max31722.c
> +++ b/drivers/hwmon/max31722.c
> @@ -12,23 +12,38 @@
>  #include <linux/acpi.h>
>  #include <linux/hwmon.h>
>  #include <linux/hwmon-sysfs.h>
> +#include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/spi/spi.h>
>  
>  #define MAX31722_REG_CFG				0x00
>  #define MAX31722_REG_TEMP_LSB				0x01
> +#define MAX31722_REG_THIGH_LSB				0x03
> +#define MAX31722_REG_TLOW_LSB				0x05
>  
>  #define MAX31722_MODE_CONTINUOUS			0x00
>  #define MAX31722_MODE_STANDBY				0x01
>  #define MAX31722_MODE_MASK				0xFE
>  #define MAX31722_RESOLUTION_12BIT			0x06
> +#define MAX31722_TM_INTERRUPT				0x08
>  #define MAX31722_WRITE_MASK				0x80
> +/*
> + * Minimum temperature value: -2^(12-1)      * 62.5  = -128,000
> + * Maximum temperature value: (2^(12-1) - 1) * 62.5 ~=  127,937
> + */
> +#define MAX31722_MIN_TEMP			       -128000
> +#define MAX31722_MAX_TEMP				127937
>  
>  struct max31722_data {
>  	struct device *hwmon_dev;
>  	struct spi_device *spi_device;
> +	struct mutex update_lock;
>  	u8 mode;
> +	s32 thigh;
> +	s32 tlow;
> +	bool irq_enabled;
> +	bool alarm_active;
>  };
>  
>  static int max31722_set_mode(struct max31722_data *data, u8 mode)
> @@ -56,6 +71,12 @@ static ssize_t max31722_show_temp(struct device *dev,
>  {
>  	ssize_t ret;
>  	struct max31722_data *data = dev_get_drvdata(dev);
> +	struct sensor_device_attribute *dev_attr = to_sensor_dev_attr(attr);
> +
> +	if (dev_attr->index = MAX31722_REG_THIGH_LSB)
> +		return sprintf(buf, "%d\n", data->thigh);
> +	else if (dev_attr->index = MAX31722_REG_TLOW_LSB)
> +		return sprintf(buf, "%d\n", data->tlow);
>  
>  	ret = spi_w8r16(data->spi_device, MAX31722_REG_TEMP_LSB);
>  	if (ret < 0)
> @@ -64,15 +85,142 @@ static ssize_t max31722_show_temp(struct device *dev,
>  	return sprintf(buf, "%d\n", (s16)le16_to_cpu(ret) * 125 / 32);
>  }
>  
> -static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO,
> -			  max31722_show_temp, NULL, 0);
> +static ssize_t max31722_set_temp(struct device *dev,
> +				 struct device_attribute *attr,
> +				 const char *buf, size_t count)
> +{
> +	int ret;
> +	long val;
> +	s16 thresh;
> +	u8 tx_buf[3];
> +	struct max31722_data *data = dev_get_drvdata(dev);
> +	struct sensor_device_attribute *dev_attr = to_sensor_dev_attr(attr);
> +
> +	ret = kstrtol(buf, 10, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	val = clamp_val(val, MAX31722_MIN_TEMP, MAX31722_MAX_TEMP);
> +	thresh = cpu_to_le16(DIV_ROUND_CLOSEST(val * 32, 125));
> +
> +	tx_buf[0] = dev_attr->index | MAX31722_WRITE_MASK;
> +	tx_buf[1] = thresh & 0xff;
> +	tx_buf[2] = thresh >> 8;
> +
> +	mutex_lock(&data->update_lock);
> +
> +	ret = spi_write(data->spi_device, &tx_buf, sizeof(tx_buf));
> +	if (ret < 0) {
> +		mutex_unlock(&data->update_lock);
> +		return ret;
> +	}
> +
> +	if (dev_attr->index = MAX31722_REG_THIGH_LSB)
> +		data->thigh = thresh * 125 / 32;
> +	else
> +		data->tlow = thresh * 125 / 32;
> +
> +	mutex_unlock(&data->update_lock);
> +
> +	return count;
> +}
> +
> +static ssize_t max31722_show_alarm(struct device *dev,
> +				   struct device_attribute *attr,
> +				   char *buf)
> +{
> +	struct spi_device *spi_device = to_spi_device(dev);
> +	struct max31722_data *data = spi_get_drvdata(spi_device);
> +
> +	return sprintf(buf, "%d\n", data->alarm_active);
> +}
> +
> +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, max31722_show_temp, NULL,
> +			  MAX31722_REG_TEMP_LSB);
> +static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, max31722_show_temp,
> +			  max31722_set_temp, MAX31722_REG_THIGH_LSB);
> +static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO, max31722_show_temp,
> +			  max31722_set_temp, MAX31722_REG_TLOW_LSB);
> +static DEVICE_ATTR(temp1_alarm, S_IRUGO, max31722_show_alarm, NULL);
>  
>  static struct attribute *max31722_attrs[] = {
>  	&sensor_dev_attr_temp1_input.dev_attr.attr,
> +	&sensor_dev_attr_temp1_max.dev_attr.attr,
> +	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
> +	&dev_attr_temp1_alarm.attr,
>  	NULL,
>  };
>  
> -ATTRIBUTE_GROUPS(max31722);
> +static umode_t max31722_is_visible(struct kobject *kobj, struct attribute *attr,
> +				   int index)
> +{
> +	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct max31722_data *data = dev_get_drvdata(dev);
> +
> +	/* Hide alarm and threshold attributes if interrupts are disabled. */
> +	if (!data->irq_enabled && index > 0)
> +		return 0;
> +
> +	return attr->mode;
> +}
> +
> +static const struct attribute_group max31722_group = {
> +	.attrs = max31722_attrs, .is_visible = max31722_is_visible,
> +};
> +
> +__ATTRIBUTE_GROUPS(max31722);
> +
> +static void max31722_update_alarm(struct max31722_data *data)
> +{
> +	s16 temp;
> +	ssize_t ret;
> +	/*
> +	 * Do a quick temperature reading and compare it with TLOW/THIGH
> +	 * so we can tell which threshold has been met.
> +	 */
> +	ret = spi_w8r16(data->spi_device, MAX31722_REG_TEMP_LSB);
> +	if (ret < 0)
> +		return;

It might make sense to have this function return the error.

> +	temp = (s16)le16_to_cpu(ret) * 125 / 32;
> +
> +	if (temp > data->thigh || (!data->alarm_active && temp > data->tlow))
> +		data->alarm_active = true;
> +	else if (temp <= data->tlow ||
> +			(data->alarm_active && temp < data->thigh))
> +		data->alarm_active = false;
> +
> +	sysfs_notify(&data->spi_device->dev.kobj, NULL, "temp1_alarm");

temp1_alarm does not yet exist when this function is called during
initialization, so this needs to be reworked. Maybe pass a flag from
the calling code, or call sysfs_notify() from the irq handler.

> +}
> +
> +static irqreturn_t max31722_irq_handler(int irq, void *private)
> +{
> +	struct max31722_data *data = private;
> +
> +	max31722_update_alarm(data);

... while the return value would be ignored here, it would make sense to
evaluate it in the probe function and abort initialization if an error occurs.

> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void max31722_init_thresh(struct max31722_data *data)
> +{
> +	ssize_t ret;
> +
> +	/* Cache threshold values. */
> +	ret = spi_w8r16(data->spi_device, MAX31722_REG_TLOW_LSB);
> +	if (ret < 0)
> +		goto exit_err;
> +	data->tlow = (s16)le16_to_cpu(ret) * 125 / 32;
> +
> +	ret = spi_w8r16(data->spi_device, MAX31722_REG_THIGH_LSB);
> +	if (ret < 0)
> +		goto exit_err;
> +	data->thigh = (s16)le16_to_cpu(ret) * 125 / 32;
> +	return;
> +
> +exit_err:
> +	dev_err(&data->spi_device->dev,
> +		"failed to read temperature threshold\n");

Are you sure you want to ignore this error ? It suggests that something is
seriously wrong. Unless you have a good reason for not doing it, I would
suggest to return the error and abort registering the driver in this case.

> +}
>  
>  static int max31722_probe(struct spi_device *spi)
>  {
> @@ -83,17 +231,37 @@ static int max31722_probe(struct spi_device *spi)
>  	if (!data)
>  		return -ENOMEM;
>  
> +	mutex_init(&data->update_lock);
>  	spi_set_drvdata(spi, data);
>  	data->spi_device = spi;
>  	/*
>  	 * Set SD bit to 0 so we can have continuous measurements.
>  	 * Set resolution to 12 bits for maximum precision.
>  	 */
> -	data->mode = MAX31722_MODE_CONTINUOUS | MAX31722_RESOLUTION_12BIT;
> +	data->mode = MAX31722_MODE_CONTINUOUS | MAX31722_RESOLUTION_12BIT
> +		   | MAX31722_TM_INTERRUPT;
>  	ret = max31722_set_mode(data, MAX31722_MODE_CONTINUOUS);
>  	if (ret < 0)
>  		return ret;
>  
> +	data->irq_enabled = false;

Nitpick, but that initialization isn't needed. The variable will be false
by default.

> +	if (spi->irq > 0) {
> +		ret = devm_request_threaded_irq(&spi->dev, spi->irq,
> +						NULL,
> +						max31722_irq_handler,
> +						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> +						dev_name(&spi->dev), data);
> +		if (ret < 0) {
> +			dev_warn(&spi->dev, "request irq %d failed\n",
> +				  spi->irq);
> +		} else {
> +			data->irq_enabled = true;
> +			data->alarm_active = false;

Same here.

> +			max31722_init_thresh(data);

This function should be called outside the if statement, since the thresholds
are displayed without interrupts as well.

> +			max31722_update_alarm(data);
> +		}
> +	}
> +
>  	data->hwmon_dev = hwmon_device_register_with_groups(&spi->dev,
>  							    spi->modalias,
>  							    data,
> -- 
> 1.9.1
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
