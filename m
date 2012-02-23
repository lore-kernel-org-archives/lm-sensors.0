From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 23 Feb 2012 01:17:13 +0000
Subject: Re: [lm-sensors] [PATCH 2/6] hwmon: (f75375s) Fix writes to the pwm* attribute for the F75387
Message-Id: <20120223011713.GB4930@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1329949129-4265-3-git-send-email-mail@microschulz.de>
In-Reply-To: <1329949129-4265-3-git-send-email-mail@microschulz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Feb 22, 2012 at 05:18:45PM -0500, Nikolaus Schulz wrote:
> For the F75387, the register holding the current PWM duty cycle value is
> r/o; changing it requires writing to the fan expect register instead.
> 
> Signed-off-by: Nikolaus Schulz <mail@microschulz.de>
> ---
>  drivers/hwmon/f75375s.c |   27 +++++++++++++++++++++------
>  1 files changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwmon/f75375s.c b/drivers/hwmon/f75375s.c
> index 5dae122..fc6444d 100644
> --- a/drivers/hwmon/f75375s.c
> +++ b/drivers/hwmon/f75375s.c
> @@ -308,8 +308,14 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
>  		return err;
>  
>  	mutex_lock(&data->update_lock);
> +	/* TODO: Improve representation in the register cache for the F75387 */

Is this comment needed ? If not, I would prefer not to add it as comment in a bug fix
at this point in the release cycle.

>  	data->pwm[nr] = SENSORS_LIMIT(val, 0, 255);
> -	f75375_write8(client, F75375_REG_FAN_PWM_DUTY(nr), data->pwm[nr]);
> +	if (data->kind = f75387)
> +		f75375_write16(client, F75375_REG_FAN_EXP(nr),
> +				data->pwm[nr]);
> +	else
> +		f75375_write8(client, F75375_REG_FAN_PWM_DUTY(nr),
> +				data->pwm[nr]);

This is three times the same code. Can you move it into a separate function ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
