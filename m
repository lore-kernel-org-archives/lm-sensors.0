From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 05 Apr 2016 14:53:23 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (max31722) Add threshold alarm support
Message-Id: <20160405145323.GA27359@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1459860813-25435-1-git-send-email-tiberiu.a.breana@intel.com>
In-Reply-To: <1459860813-25435-1-git-send-email-tiberiu.a.breana@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Apr 05, 2016 at 03:53:33PM +0300, Tiberiu Breana wrote:
> Add threshold alarm support for the max31722 temperature sensor driver.
> 
> Signed-off-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
> ---
> Changes from v1:
> - addressed Guenter's comments
> - chip is now set to "interrupt mode" at probe time
> - changed minimum and maximum threshold values according to register limits
> - the interrupt handler now compares the current temperature to the thresholds
>   before (re)setting the alarm
> - added sysfs notifications for temp1_alarm
> - added the max31722_update_alarm function used by the irq handler as well as
>   at probing time
> ---
>  drivers/hwmon/max31722.c | 156 +++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 151 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwmon/max31722.c b/drivers/hwmon/max31722.c
> index 30a100e..de3cd18 100644
> --- a/drivers/hwmon/max31722.c
> +++ b/drivers/hwmon/max31722.c
> @@ -12,23 +12,42 @@
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
> + * The 12-bit scale of 62.5 millidegrees/bit is rounded up instead of down
> + * so we don't exceed the maximum register values when setting thresholds.
> + */
> +#define MAX31722_12BIT_STEP				63

That gives you the same rounding error as in the other diretion, though.
It would be better to use 
	DIV_ROUND_CLOSEST(val * 32, 125);
inetead of
	DIV_ROUND_CLOSEST(val, 63) << 4;

below.

> +/*
> + * Minimum temperature value: -2^(12-1)      * 62.5  = -128,000
> + * Maximum temperature value: (2^(12-1) - 1) * 62.5 ~=  127,938
> + * Due to the rounding of the scale value, the actual threshold limits,
> + * after re-calculating register values, will be -127,000 and 126,937.
> + */
> +#define MAX31722_MIN_TEMP			       -128000
> +#define MAX31722_MAX_TEMP				127938
>  
>  struct max31722_data {
>  	struct device *hwmon_dev;
>  	struct spi_device *spi_device;
>  	u8 mode;
> +	bool irq_enabled;
> +	bool alarm_active;
>  };
>  
>  static int max31722_set_mode(struct max31722_data *data, u8 mode)
> @@ -56,23 +75,133 @@ static ssize_t max31722_show_temp(struct device *dev,
>  {
>  	ssize_t ret;
>  	struct max31722_data *data = dev_get_drvdata(dev);
> +	struct sensor_device_attribute *dev_attr = to_sensor_dev_attr(attr);
>  
> -	ret = spi_w8r16(data->spi_device, MAX31722_REG_TEMP_LSB);
> +	ret = spi_w8r16(data->spi_device, dev_attr->index);
>  	if (ret < 0)
>  		return ret;
>  	/* Keep 12 bits and multiply by the scale of 62.5 millidegrees/bit. */
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
> +	thresh = cpu_to_le16(DIV_ROUND_CLOSEST(val, MAX31722_12BIT_STEP) << 4);
> +

see above - please try to avoid rounding errors.

> +	tx_buf[0] = dev_attr->index | MAX31722_WRITE_MASK;
> +	tx_buf[1] = (thresh << 8) >> 8;

I would suggest "thresh & 0xff", as it is easier to understand. Besides, for
negative values, the upper 8 bits are going to be 0xff, meaning the double shift
doesn't really do what you think it will do.

> +	tx_buf[2] = thresh >> 8;
> +	ret = spi_write(data->spi_device, &tx_buf, sizeof(tx_buf));
> +	if (ret < 0)
> +		return ret;
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
> +	/* Hide the alarm attribute if interrupts are disabled. */
> +	if (!data->irq_enabled &&
> +	    strncmp(attr->name, "temp1_alarm", sizeof("temp1_alarm")) = 0)

Just use "&& index = 3" here. That is what it is for.

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
> +	u16 temp;
> +	u16 thigh;
> +	u16 tlow;
> +	ssize_t ret;
> +
> +	/*
> +	 * Do a quick temperature reading and compare it with TLOW/THIGH
> +	 * so we can tell which threshold has been met.
> +	 */
> +	ret = spi_w8r16(data->spi_device, MAX31722_REG_TEMP_LSB);
> +	if (ret < 0)
> +		goto exit_err;
> +	temp = (s16)(le16_to_cpu(ret) * 125 / 32);
> +	ret = spi_w8r16(data->spi_device, MAX31722_REG_TLOW_LSB);
> +	if (ret < 0)
> +		goto exit_err;
> +	tlow = (s16)(le16_to_cpu(ret) * 125 / 32);
> +	ret = spi_w8r16(data->spi_device, MAX31722_REG_THIGH_LSB);
> +	if (ret < 0)
> +		goto exit_err;
> +	thigh = (s16)(le16_to_cpu(ret) * 125 / 32);
> +
Please consider caching tlow and thigh. Those won't change.

> +	if (temp > thigh || (temp < thigh && temp > tlow))
> +		data->alarm_active = true;

If we assume that thigh > tlow, this is equivalent to "temp != thigh && temp >
tlow", which doesn't make much sense.

> +	else
> +		data->alarm_active = false;
> +
I think something like the following would be better, since it takes
the current alarm status into account.

	if (temp > thigh || (!data->alarm_active && temp > tlow))
		data->alarm_active = true;
	else if (temp <= tlow || (data->alarm_active && temp < thigh))
		data->alarm_active = false;

> +	sysfs_notify(&data->spi_device->dev.kobj, NULL, "temp1_alarm");
> +	return;
> +
> +exit_err:
> +	dev_err(&data->spi_device->dev, "failed to read temperature register\n");
> +}
> +
> +static irqreturn_t max31722_irq_handler(int irq, void *private)
> +{
> +	struct max31722_data *data = private;
> +
> +	max31722_update_alarm(data);
> +
> +	return IRQ_HANDLED;
> +}
>  
>  static int max31722_probe(struct spi_device *spi)
>  {
> @@ -89,11 +218,28 @@ static int max31722_probe(struct spi_device *spi)
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
> +	if (spi->irq > 0) {
> +		ret = devm_request_threaded_irq(&spi->dev, spi->irq,
> +						NULL,
> +						max31722_irq_handler,
> +						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> +						dev_name(&spi->dev), data);
> +		if (ret < 0) {
> +			dev_err(&spi->dev, "request irq %d failed\n", spi->irq);

dev_warn(), please, since the error is ignored.

> +		} else {
> +			data->irq_enabled = true;
> +			data->alarm_active = false;
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
