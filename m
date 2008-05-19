From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 19 May 2008 21:07:29 +0000
Subject: Re: [lm-sensors] [PATCH] w83627hf: Add pwm_enable sysfs-interface
Message-Id: <20080519230729.2aeab9e3@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200805161836.42920.dominik.geyer@gmx.de>
In-Reply-To: <200805161836.42920.dominik.geyer@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Dominik,

On Fri, 16 May 2008 18:36:42 +0200, Dominik Geyer wrote:
> Adds support for pwm_enable sysfs-interface for the w83627hf-driver.
> 
> Signed-off-by: Dominik Geyer <dominik.geyer@gmx.de>
> 
> Please CC me, because I'm not subscribed to the list.
> ---
> 
> Hi Jean,
> 
> I've reworked my initial patch so that pwmX_enable sysfs-interface is 
> supported now. I'm not really sure about the "Thermal Cruise Mode" and 
> the "Fan Speed Cruise Mode" setting (thus in this patch only value 1 and 2 
> are allowed). I looked up the datasheets and it seems that all chips except 
> W83627HF have support for fan-config.
> 
> I tested the "Manual PWM Control Mode" on a W83697HF.

Thanks for working on this, I wanted to do it long ago but could never
find the time.

> --- linux-2.6.25.3/drivers/hwmon/w83627hf.c.orig	2008-05-12 11:40:03.000000000  +0000
> +++ linux-2.6.25.3/drivers/hwmon/w83627hf.c	2008-05-16 16:01:34.000000000 +0000
> @@ -209,6 +209,9 @@
>  #define W83627HF_REG_PWM1 0x5A
>  #define W83627HF_REG_PWM2 0x5B
>  
> +#define W83627THF_REG_FAN_CONFIG 	0x04	/* 697HF/637HF/687THF too */
> +static const u8 W83627THF_PWM_ENABLE_SHIFT[] = { 2, 4 };
> +

The W83627THF, W83637HF and W83687THF have a 3rd PWM channel those mode
can be changed as well. The configuration bits are in Fan Configuration
Register II (0x12 in bank 0). While I understand that you have no
interest in this for your W83697HF chip, I still would like you to add
support for it in your patch, so that we can really say that the
w83627hf support PWM mode switching. It shouldn't be too difficult.

>  #define W83627THF_REG_PWM1		0x01	/* 697HF/637HF/687THF too */
>  #define W83627THF_REG_PWM2		0x03	/* 697HF/637HF/687THF too */
>  #define W83627THF_REG_PWM3		0x11	/* 637HF/687THF too */
> @@ -366,6 +369,8 @@
>  	u32 alarms;		/* Register encoding, combined */
>  	u32 beep_mask;		/* Register encoding, combined */
>  	u8 pwm[3];		/* Register value */
> +	u8 pwm_enable[2];	/* 1->manual 2->thermal cruise (also called SmartFan I)

Line too long.

> +				   3->fan speed cruise */
>  	u8 pwm_freq[3];		/* Register value */
>  	u16 sens[3];		/* 1 = pentium diode; 2 = 3904 diode;
>  				   4 = thermistor */
> @@ -957,6 +962,40 @@
>  static SENSOR_DEVICE_ATTR(pwm3, S_IRUGO|S_IWUSR, show_pwm, store_pwm, 2);
>  
>  static ssize_t
> +show_pwm_enable(struct device *dev, struct device_attribute *devattr, char 
> *buf)
> +{
> +	int nr = to_sensor_dev_attr(devattr)->index;
> +	struct w83627hf_data *data = w83627hf_update_device(dev);
> +	return sprintf(buf, "%d\n", data->pwm_enable[nr]);
> +}
> +
> +static ssize_t
> +store_pwm_enable(struct device *dev, struct device_attribute *devattr,
> +	  const char *buf, size_t count)
> +{
> +	int nr = to_sensor_dev_attr(devattr)->index;
> +	struct w83627hf_data *data = dev_get_drvdata(dev);
> +	u32 val = simple_strtoul(buf, NULL, 10);

Should be unsigned long.

> +	u16 reg;

Could be u8.

> +
> +	if (!val || (val > 2))	/* only modes 1 and 2 are supported */
> +		return -EINVAL;

You should support value 3 as well. The BIOS might have setup the chip
in this mode, and if you let the user change it to manual, it's only
fair that you let them change it back to the original value afterwards.

> +	mutex_lock(&data->update_lock);
> +	data->pwm_enable[nr] = val;
> +	reg = w83627hf_read_value(data, W83627THF_REG_FAN_CONFIG);
> +	reg &= ~(0x03 << W83627THF_PWM_ENABLE_SHIFT[nr]);
> +	reg |= (val - 1) << W83627THF_PWM_ENABLE_SHIFT[nr];
> +	w83627hf_write_value(data, W83627THF_REG_FAN_CONFIG, reg);
> +	mutex_unlock(&data->update_lock);
> +	return count;
> +}
> +
> +static SENSOR_DEVICE_ATTR(pwm1_enable, S_IRUGO|S_IWUSR, show_pwm_enable,
> +						  store_pwm_enable, 0);
> +static SENSOR_DEVICE_ATTR(pwm2_enable, S_IRUGO|S_IWUSR, show_pwm_enable,
> +						  store_pwm_enable, 1);
> +
> +static ssize_t
>  show_pwm_freq(struct device *dev, struct device_attribute *devattr, char *buf)
>  {
>  	int nr = to_sensor_dev_attr(devattr)->index;
> @@ -1223,6 +1262,10 @@
>  	&sensor_dev_attr_pwm1_freq.dev_attr.attr,
>  	&sensor_dev_attr_pwm2_freq.dev_attr.attr,
>  	&sensor_dev_attr_pwm3_freq.dev_attr.attr,
> +
> +	&sensor_dev_attr_pwm1_enable.dev_attr.attr,
> +	&sensor_dev_attr_pwm2_enable.dev_attr.attr,
> +
>  	NULL
>  };
>  
> @@ -1366,6 +1409,13 @@
>  				&sensor_dev_attr_pwm3_freq.dev_attr)))
>  			goto ERROR4;
>  
> +	if (data->type != w83627hf)
> +		if ((err = device_create_file(dev,
> +				&sensor_dev_attr_pwm1_enable.dev_attr))
> +		 || (err = device_create_file(dev,
> +				&sensor_dev_attr_pwm2_enable.dev_attr)))
> +			goto ERROR4;
> +
>  	data->hwmon_dev = hwmon_device_register(dev);
>  	if (IS_ERR(data->hwmon_dev)) {
>  		err = PTR_ERR(data->hwmon_dev);
> @@ -1707,6 +1757,11 @@
>  					break;
>  			}
>  		}
> +		if (data->type != w83627hf) {
> +			u8 tmp = w83627hf_read_value(data, W83627THF_REG_FAN_CONFIG);
> +			for (i = 0; i < 2; i++)
> +				data->pwm_enable[i] = ((tmp >> W83627THF_PWM_ENABLE_SHIFT[i]) & 0x03) + 1;
> +		}

These lines are too long, please fold them so that they fit in 80 columns.

>  		for (i = 0; i < num_temps; i++) {
>  			data->temp[i] = w83627hf_read_value(
>  						data, w83627hf_reg_temp[i]);

Please submit an updated patch. Unfortunately I won't be able to test
it, as I no longer have a test board with a supported chip.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
