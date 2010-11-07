From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 07 Nov 2010 16:27:19 +0000
Subject: Re: [lm-sensors] [PATCH 2/7] hwmon: (w83795) Expose fan control
Message-Id: <20101107162718.GB18730@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101107164405.5e6b6d2a@endymion.delvare>
In-Reply-To: <20101107164405.5e6b6d2a@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Nov 07, 2010 at 10:44:05AM -0500, Jean Delvare wrote:
> Expose fan control method (DC vs. PWM) using the standard sysfs
> attributes. I've made it read-only as the board should be wired for
> a given mode, the BIOS should have set up the chip for this mode, and
> you shouldn't have to change it. But it would be easy enough to make
> it changeable if someone comes up with a use case.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Guess that explains why you don't expose pwm_fomc anymore in the first patch.

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

> ---
>  w83795.c |   19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> --- a/drivers/hwmon/w83795.c	2010-10-29 14:00:07.000000000 +0200
> +++ b/drivers/hwmon/w83795.c	2010-10-29 14:00:44.000000000 +0200
> @@ -916,6 +916,21 @@ store_pwm_enable(struct device *dev, str
>  }
>  
>  static ssize_t
> +show_pwm_mode(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct w83795_data *data = w83795_update_pwm_config(dev);
> +	int index = to_sensor_dev_attr_2(attr)->index;
> +	unsigned int mode;
> +
> +	if (data->pwm_fomc & (1 << index))
> +		mode = 0;	/* DC */
> +	else
> +		mode = 1;	/* PWM */
> +
> +	return sprintf(buf, "%u\n", mode);
> +}
> +
> +static ssize_t
>  show_temp_src(struct device *dev, struct device_attribute *attr, char *buf)
>  {
>  	struct sensor_device_attribute_2 *sensor_attr > @@ -1551,6 +1566,8 @@ store_sf_setup(struct device *dev, struc
>  		show_pwm, store_pwm, PWM_FREQ, index - 1),	 \
>  	SENSOR_ATTR_2(pwm##index##_enable, S_IWUSR | S_IRUGO,		\
>  		show_pwm_enable, store_pwm_enable, NOT_USED, index - 1), \
> +	SENSOR_ATTR_2(pwm##index##_mode, S_IRUGO,			\
> +		show_pwm_mode, NULL, NOT_USED, index - 1),		\
>  	SENSOR_ATTR_2(fan##index##_target, S_IWUSR | S_IRUGO, \
>  		show_fanin, store_fanin, FANIN_TARGET, index - 1) }
>  
> @@ -1698,7 +1715,7 @@ static const struct sensor_device_attrib
>  	SENSOR_ATTR_DTS(14),
>  };
>  
> -static const struct sensor_device_attribute_2 w83795_pwm[][7] = {
> +static const struct sensor_device_attribute_2 w83795_pwm[][8] = {
>  	SENSOR_ATTR_PWM(1),
>  	SENSOR_ATTR_PWM(2),
>  	SENSOR_ATTR_PWM(3),
> 
> -- 
> Jean Delvare
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
