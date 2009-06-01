From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 01 Jun 2009 07:41:40 +0000
Subject: Re: [lm-sensors] [PATCH v4 1/1] hwmon: added support for the
Message-Id: <20090601094140.22f2bd74@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Christian,

On Mon, 1 Jun 2009 00:08:09 +0200, Christian Engelmayer wrote:
> From: Christian Engelmayer <christian.engelmayer@frequentis.com>
> 
> Exported the alarm stati provided by the MAX6650/MAX6651 fan-speed regulator
> and monitor chips via sysfs.
> 
> Signed-off-by: Christian Engelmayer <christian.engelmayer@frequentis.com>
> ---
> Tested with the MAX6651 chip. This obsoletes the previously proposed patch
> 'support for the max6650 GPIO and alarm features' after discussion on sane
> gpio handling.
> 
> Revised after remarks by Hans de Goede. Changed the alarm attributes to sensor
> device attributes thus eliminating the need for pointer comparison in show
> function get_alarm(). Left the alarm behaviour unchanged. In case the sysfs
> interface does not prefer 'real time' over 'latched' alarms I prefer to keep
> the style used by the device.
> 
> Incorporated additional remarks by Hans de Goede. Changed a temporary variable
> from 'u8' to 'int'. Changed the order of alarms within the code from MSB first
> to LSB first as occuring within the registers.
> 
> Incorporated additional remarks by Jean Delvare. Using attr->index for
> directly passing alarm masks. Resending the patch as it was previously
> corrupted by the mail client.

This looks good now, although I would suggest some cleanups:

> 
> --- linux-2.6.29.4-vanilla/drivers/hwmon/max6650.c	2009-05-30 23:58:59.000000000 +0200
> +++ linux-2.6.29.4/drivers/hwmon/max6650.c	2009-05-31 00:01:47.000000000 +0200
> @@ -12,7 +12,7 @@
>   * also work with the MAX6651. It does not distinguish max6650 and max6651
>   * chips.
>   *
> - * Tha datasheet was last seen at:
> + * The datasheet was last seen at:
>   *
>   *        http://pdfserv.maxim-ic.com/en/ds/MAX6650-MAX6651.pdf
>   *
> @@ -98,6 +98,17 @@ I2C_CLIENT_INSMOD_1(max6650);
>  #define MAX6650_CFG_MODE_OPEN_LOOP	0x30
>  #define MAX6650_COUNT_MASK		0x03
>  
> +/*
> + * Alarm status register bits
> + */
> +
> +#define MAX6650_ALRM_MAX	0x01
> +#define MAX6650_ALRM_MIN	0x02
> +#define MAX6650_ALRM_TACH	0x04
> +#define MAX6650_ALRM_GPIO1	0x08
> +#define MAX6650_ALRM_GPIO2	0x10
> +#define MAX6650_ALRM_MASK	0x1F

You don't use MAX6650_ALRM_MASK anywhere so I'd rather not bother
defining it.

> +
>  /* Minimum and maximum values of the FAN-RPM */
>  #define FAN_RPM_MIN 240
>  #define FAN_RPM_MAX 30000
> @@ -151,6 +162,7 @@ struct max6650_data
>  	u8 tach[4];
>  	u8 count;
>  	u8 dac;
> +	u8 alarm;
>  };
>  
>  static ssize_t get_fan(struct device *dev, struct device_attribute *devattr,
> @@ -418,6 +430,33 @@ static ssize_t set_div(struct device *de
>  	return count;
>  }
>  
> +/*
> + * Get alarm stati:
> + * Possible values:
> + * 0 = no alarm
> + * 1 = alarm
> + */
> +
> +static ssize_t get_alarm(struct device *dev, struct device_attribute *devattr,
> +			 char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct max6650_data *data = max6650_update_device(dev);
> +	struct i2c_client *client = to_i2c_client(dev);
> +	int alarm = 0;
> +
> +	if (data->alarm & attr->index) {
> +		mutex_lock(&data->update_lock);
> +		alarm = 1;
> +		data->alarm &= ~attr->index;
> +		data->alarm |= i2c_smbus_read_byte_data(client,
> +							MAX6650_REG_ALARM);
> +		mutex_unlock(&data->update_lock);
> +	}
> +
> +	return sprintf(buf, "%d\n", alarm);
> +}
> +
>  static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, get_fan, NULL, 0);
>  static SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, get_fan, NULL, 1);
>  static SENSOR_DEVICE_ATTR(fan3_input, S_IRUGO, get_fan, NULL, 2);
> @@ -426,7 +465,47 @@ static DEVICE_ATTR(fan1_target, S_IWUSR 
>  static DEVICE_ATTR(fan1_div, S_IWUSR | S_IRUGO, get_div, set_div);
>  static DEVICE_ATTR(pwm1_enable, S_IWUSR | S_IRUGO, get_enable, set_enable);
>  static DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, get_pwm, set_pwm);
> +static SENSOR_DEVICE_ATTR(fan1_max_alarm, S_IRUGO, get_alarm, NULL,
> +			  MAX6650_ALRM_MAX);
> +static SENSOR_DEVICE_ATTR(fan1_min_alarm, S_IRUGO, get_alarm, NULL,
> +			  MAX6650_ALRM_MIN);
> +static SENSOR_DEVICE_ATTR(fan1_fault, S_IRUGO, get_alarm, NULL,
> +			  MAX6650_ALRM_TACH);
> +static SENSOR_DEVICE_ATTR(gpio1_alarm, S_IRUGO, get_alarm, NULL,
> +			  MAX6650_ALRM_GPIO1);
> +static SENSOR_DEVICE_ATTR(gpio2_alarm, S_IRUGO, get_alarm, NULL,
> +			  MAX6650_ALRM_GPIO2);
> +
> +static mode_t max6650_attrs_visible(struct kobject *kobj, struct attribute *a,
> +				    int n)
> +{
> +	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct i2c_client *client = to_i2c_client(dev);
> +	u8 alarm_en = i2c_smbus_read_byte_data(client, MAX6650_REG_ALARM_EN);
>  
> +	/*
> +	 * Hide the alarms that have not been enabled by the firmware
> +	 */
> +
> +	if (a = &sensor_dev_attr_fan1_max_alarm.dev_attr.attr) {
> +		if (!(alarm_en & MAX6650_ALRM_MAX))
> +			return 0;
> +	} else if (a = &sensor_dev_attr_fan1_min_alarm.dev_attr.attr) {
> +		if (!(alarm_en & MAX6650_ALRM_MIN))
> +			return 0;
> +	} else if (a = &sensor_dev_attr_fan1_fault.dev_attr.attr) {
> +		if (!(alarm_en & MAX6650_ALRM_TACH))
> +			return 0;
> +	} else if (a = &sensor_dev_attr_gpio1_alarm.dev_attr.attr) {
> +		if (!(alarm_en & MAX6650_ALRM_GPIO1))
> +			return 0;
> +	} else if (a = &sensor_dev_attr_gpio2_alarm.dev_attr.attr) {
> +		if (!(alarm_en & MAX6650_ALRM_GPIO2))
> +			return 0;
> +	}

If I'm not mistaken, this can be written in a more efficient way:

	struct device_attribute *devattr;

	devattr = container_of(a, struct device_attribute, attr);
	if (devattr = &sensor_dev_attr_fan1_max_alarm.dev_attr
	 || devattr = &sensor_dev_attr_fan1_min_alarm.dev_attr
	 || devattr = &sensor_dev_attr_fan1_fault.dev_attr
	 || devattr = &sensor_dev_attr_gpio1_alarm.dev_attr
	 || devattr = &sensor_dev_attr_gpio2_alarm.dev_attr) {
		if (!(alarm_en & to_sensor_dev_attr(devattr)->index))
 			return 0;
 	}

What do you think?

> +
> +	return a->mode;
> +}
>  
>  static struct attribute *max6650_attrs[] = {
>  	&sensor_dev_attr_fan1_input.dev_attr.attr,
> @@ -437,11 +516,17 @@ static struct attribute *max6650_attrs[]
>  	&dev_attr_fan1_div.attr,
>  	&dev_attr_pwm1_enable.attr,
>  	&dev_attr_pwm1.attr,
> +	&sensor_dev_attr_fan1_max_alarm.dev_attr.attr,
> +	&sensor_dev_attr_fan1_min_alarm.dev_attr.attr,
> +	&sensor_dev_attr_fan1_fault.dev_attr.attr,
> +	&sensor_dev_attr_gpio1_alarm.dev_attr.attr,
> +	&sensor_dev_attr_gpio2_alarm.dev_attr.attr,
>  	NULL
>  };
>  
>  static struct attribute_group max6650_attr_grp = {
>  	.attrs = max6650_attrs,
> +	.is_visible = max6650_attrs_visible,
>  };
>  
>  /*
> @@ -659,6 +744,12 @@ static struct max6650_data *max6650_upda
>  							MAX6650_REG_COUNT);
>  		data->dac = i2c_smbus_read_byte_data(client, MAX6650_REG_DAC);
>  
> +		/* Alarms are cleared on read in case the condition that
> +		 * caused the alarm is removed. Keep the value latched here
> +		 * for providing the register through different alarm files. */
> +		data->alarm |= i2c_smbus_read_byte_data(client,
> +							MAX6650_REG_ALARM);
> +
>  		data->last_updated = jiffies;
>  		data->valid = 1;
>  	}


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
