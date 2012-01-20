From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 20 Jan 2012 15:23:47 +0000
Subject: Re: [lm-sensors] [PATCH 30/82] hwmon: (it87) Fix multi-line comments
Message-Id: <20120120162347.1adf8bb3@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327017376-20466-31-git-send-email-linux@roeck-us.net>
In-Reply-To: <1327017376-20466-31-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 19 Jan 2012 15:55:24 -0800, Guenter Roeck wrote:
> Cc: Jean Delvare <khali@linux-fr.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/it87.c |  172 ++++++++++++++++++++++++++++++++------------------
>  1 files changed, 111 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
> index 0054d6f..bebd7ab 100644
> --- a/drivers/hwmon/it87.c
> +++ b/drivers/hwmon/it87.c
> (...)
> @@ -388,9 +396,11 @@ static const unsigned int pwm_freq[8] = {
>  
>  static inline int has_16bit_fans(const struct it87_data *data)
>  {
> -	/* IT8705F Datasheet 0.4.1, 3h = Version G.
> -	   IT8712F Datasheet 0.9.1, section 8.3.5 indicates 8h = Version J.
> -	   These are the first revisions with 16bit tachometer support. */
> +	/*
> +	 * IT8705F Datasheet 0.4.1, 3h = Version G.
> +	 * IT8712F Datasheet 0.9.1, section 8.3.5 indicates 8h = Version J.
> +	 * These are the first revisions with 16bit tachometer support.

Might be a good opportunity to fix 16bit -> 16-bit.

> +	 */
>  	return (data->type = it87 && data->revision >= 0x03)
>  	    || (data->type = it8712 && data->revision >= 0x08)
>  	    || data->type = it8716
> (...)
> @@ -608,8 +620,10 @@ static ssize_t show_sensor(struct device *dev, struct device_attribute *attr,
>  	int nr = sensor_attr->index;
>  
>  	struct it87_data *data = it87_update_device(dev);
> -	u8 reg = data->sensor;		/* In case the value is updated while
> -					   we use it */
> +	u8 reg = data->sensor;		/*
> +					 * In case the value is updated while
> +					 * we use it
> +					 */

I don't think multi-line comments in the middle of variable
declarations make a lot of sense. If such a comment is needed then I
suspect the code should be split off the variable declaration.

>  
>  	if (reg & (1 << nr))
>  		return sprintf(buf, "3\n");  /* thermal diode */
> @@ -894,8 +908,10 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
>  
>  	mutex_lock(&data->update_lock);
>  	if (has_newer_autopwm(data)) {
> -		/* If we are in automatic mode, the PWM duty cycle register
> -		 * is read-only so we can't write the value */
> +		/*
> +		 * If we are in automatic mode, the PWM duty cycle register
> +		 * is read-only so we can't write the value
> +		 */

Care to add a trailing dot for consistency with other comments in this
driver?

>  		if (data->pwm_ctrl[nr] & 0x80) {
>  			mutex_unlock(&data->update_lock);
>  			return -EBUSY;
> (...)
> @@ -2220,13 +2266,17 @@ static struct it87_data *it87_update_device(struct device *dev)
>  			it87_update_pwm_ctrl(data, i);
>  
>  		data->sensor = it87_read_value(data, IT87_REG_TEMP_ENABLE);
> -		/* The 8705 does not have VID capability.
> -		   The 8718 and later don't use IT87_REG_VID for the
> -		   same purpose. */
> +		/*
> +		 * The 8705 does not have VID capability.
> +		 * The 8718 and later don't use IT87_REG_VID for the

While you're here, please change 8705 to IT8705F and 8718 to IT8718F.
This is the only place in this driver where the names aren't fully
spelled.

> +		 * same purpose.
> +		 */
>  		if (data->type = it8712 || data->type = it8716) {
>  			data->vid = it87_read_value(data, IT87_REG_VID);
> -			/* The older IT8712F revisions had only 5 VID pins,
> -			   but we assume it is always safe to read 6 bits. */
> +			/*
> +			 * The older IT8712F revisions had only 5 VID pins,
> +			 * but we assume it is always safe to read 6 bits.
> +			 */
>  			data->vid &= 0x3f;
>  		}
>  		data->last_updated = jiffies;

</nitpick> :)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
