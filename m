From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 07 Nov 2010 16:23:06 +0000
Subject: Re: [lm-sensors] [PATCH 1/7] hwmon: (w83795) Fix fan control mode
Message-Id: <20101107162306.GA18730@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101107163636.2ca42efe@endymion.delvare>
In-Reply-To: <20101107163636.2ca42efe@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Nov 07, 2010 at 10:36:36AM -0500, Jean Delvare wrote:
> There were two bugs:
> * Speed cruise mode was improperly reported for all fans but fan1.
> * Fan control method (PWM vs. DC) was mixed with the control mode.
>   It will be added back as a separate attribute, as per the standard
>   sysfs interface.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Couple of questions below. If as intended,

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

> ---
>  w83795.c |   18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> --- a/drivers/hwmon/w83795.c	2010-10-29 14:00:04.000000000 +0200
> +++ b/drivers/hwmon/w83795.c	2010-10-29 14:00:07.000000000 +0200
> @@ -857,20 +857,20 @@ show_pwm_enable(struct device *dev, stru
>  	int index = sensor_attr->index;
>  	u8 tmp;
>  
> -	if (1 = (data->pwm_fcms[0] & (1 << index))) {
> +	/* Speed cruise mode */
> +	if (data->pwm_fcms[0] & (1 << index)) {
>  		tmp = 2;
>  		goto out;
>  	}
> +	/* Thermal cruise or SmartFan IV mode */
>  	for (tmp = 0; tmp < 6; tmp++) {
>  		if (data->pwm_tfmr[tmp] & (1 << index)) {
>  			tmp = 3;

That means return values are 1, 2, or 3, but never 0 (= full speed per ABI).
On the setting side, you only support 1 and 2, but not 3 or 0.

Is that as intended ?

>  			goto out;
>  		}
>  	}
> -	if (data->pwm_fomc & (1 << index))
> -		tmp = 0;
> -	else
> -		tmp = 1;
> +	/* Manual mode */
> +	tmp = 1;
>  
What if (pwm_fomc & (1<<index)) is set from the bios ?
Doesn't that state get lost now ?

>  out:
>  	return sprintf(buf, "%u\n", tmp);
> @@ -890,23 +890,21 @@ store_pwm_enable(struct device *dev, str
>  
>  	if (strict_strtoul(buf, 10, &val) < 0)
>  		return -EINVAL;
> -	if (val > 2)
> +	if (val < 1 || val > 2)
>  		return -EINVAL;
>  
>  	mutex_lock(&data->update_lock);
>  	switch (val) {
> -	case 0:
>  	case 1:
> +		/* Clear speed cruise mode bits */
>  		data->pwm_fcms[0] &= ~(1 << index);
>  		w83795_write(client, W83795_REG_FCMS1, data->pwm_fcms[0]);
> +		/* Clear thermal cruise mode bits */
>  		for (i = 0; i < 6; i++) {
>  			data->pwm_tfmr[i] &= ~(1 << index);
>  			w83795_write(client, W83795_REG_TFMR(i),
>  				data->pwm_tfmr[i]);
>  		}
> -		data->pwm_fomc |= 1 << index;
> -		data->pwm_fomc ^= val << index;
> -		w83795_write(client, W83795_REG_FOMC, data->pwm_fomc);
>  		break;
>  	case 2:
>  		data->pwm_fcms[0] |= (1 << index);
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
