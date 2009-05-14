From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 14 May 2009 11:36:40 +0000
Subject: Re: [lm-sensors] [PATCH] missing parentheses?
Message-Id: <20090514133640.7992d6d7@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A0C00A2.1080803@gmail.com>
In-Reply-To: <4A0C00A2.1080803@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Roel,

On Thu, 14 May 2009 13:29:38 +0200, Roel Kluin wrote:
> Add missing parentheses.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> The original code looks odd, but I am not sure whether my patch is correct.
> So please review.

The original code looks good to me and your patch doesn't.

> 
> diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
> index 3195a26..a5a511b 100644
> --- a/drivers/hwmon/lm63.c
> +++ b/drivers/hwmon/lm63.c
> @@ -219,9 +219,9 @@ static ssize_t show_pwm1(struct device *dev, struct device_attribute *dummy,
>  			 char *buf)
>  {
>  	struct lm63_data *data = lm63_update_device(dev);
> -	return sprintf(buf, "%d\n", data->pwm1_value >= 2 * data->pwm1_freq ?
> +	return sprintf(buf, "%d\n", data->pwm1_value >= 2 * (data->pwm1_freq ?
>  		       255 : (data->pwm1_value * 255 + data->pwm1_freq) /
> -		       (2 * data->pwm1_freq));
> +		       (2 * data->pwm1_freq)));

The correct parentheses would be:

	return sprintf(buf, "%d\n", (data->pwm1_value >= 2 * data->pwm1_freq) ?
		       255 : ((data->pwm1_value * 255 + data->pwm1_freq) /
		       (2 * data->pwm1_freq)));

Which I think is equivalent to what we already have, since the ?:
operator has low precedence.

>  }
>  
>  static ssize_t set_pwm1(struct device *dev, struct device_attribute *dummy,


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
