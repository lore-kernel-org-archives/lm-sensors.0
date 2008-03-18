From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 18 Mar 2008 15:55:34 +0000
Subject: Re: [lm-sensors] [RFC/PATCH] hwmon: fix common race conditions,
Message-Id: <20080318165534.254ac641@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080304145440.GE2892@jupiter.solarsys.private>
In-Reply-To: <20080304145440.GE2892@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

On Tue, 4 Mar 2008 09:54:40 -0500, Mark M. Hoffman wrote:
> Hi all:
> 
> Here is the first in a batch of patches which aim to fix a common class
> of race conditions in most hwmon drivers.  Credit goes to Herbert
> Valerio Riedel for pointing this out, here:
> 
> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-November/022014.html
> 
> To actually trip on any of these race conditions in practice would be
> *exceedingly* rare.  In fact, I don't think we've ever seen a report for
> such a case.  OTOH, one can see by looking at this patch that the fixes
> are not always completely trivial.
> 
> I will concentrate on cranking out the remaining patches as I have time.
> But of course I would like thorough reviews, especially from the driver
> author/maintainer if possible.  To all potential reviewers: look not
> just at the patch itself; please also scan the entire driver to see if
> there are any races that I missed.  Testing is also much appreciated.

When looking for this kind of race, you should pay particular attention
to macros and inline functions. Historically, some of our macros were
evaluating their arguments more than once. I have tried to clean this
up as we ported the driver to Linux 2.6 but I wouldn't swear that such
macros are all gone; there could be a couple still lurking.

As for inline functions, I really don't know how gcc handles these. If
it creates a temporary copy of the parameters on the stack, then we're
safe. If not, then even inline functions evaluating their parameters
more than once could hide the race.

<snip>

> diff --git a/drivers/hwmon/adm1026.c b/drivers/hwmon/adm1026.c
> index 904c6ce..92bed53 100644
> --- a/drivers/hwmon/adm1026.c
> +++ b/drivers/hwmon/adm1026.c
> @@ -838,20 +838,24 @@ static SENSOR_DEVICE_ATTR(in16_max, S_IRUGO | S_IWUSR, show_in16_max, set_in16_m
>  static ssize_t show_fan(struct device *dev, struct device_attribute *attr,
>  		char *buf)
>  {
> -	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
> -	int nr = sensor_attr->index;
> +	int nr = to_sensor_dev_attr(attr)->index;
>  	struct adm1026_data *data = adm1026_update_device(dev);
> -	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[nr],
> -		data->fan_div[nr]));
> +	int val;
> +	mutex_lock(&data->update_lock);
> +	val = FAN_FROM_REG(data->fan[nr], data->fan_div[nr]);
> +	mutex_unlock(&data->update_lock);
> +	return sprintf(buf, "%d\n", val);
>  }

As you are making the functions bigger, I think it would be a good idea
to leave a blank like between the variable declarations and the "real"
code, as is common practice for non-trivial functions. Same goes for
the rest of the patch, of course.

<snip>

> diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
> index 6b5325f..2c398d5 100644
> --- a/drivers/hwmon/adt7470.c
> +++ b/drivers/hwmon/adt7470.c
> (...)
> @@ -678,14 +684,15 @@ static ssize_t show_pwm_auto_temp(struct device *dev,
>  				  struct device_attribute *devattr,
>  				  char *buf)
>  {
> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	int index = to_sensor_dev_attr(devattr)->index;
>  	struct adt7470_data *data = adt7470_update_device(dev);
> -	u8 ctrl = data->pwm_auto_temp[attr->index];
> -
> -	if (ctrl)
> -		return sprintf(buf, "%d\n", 1 << (ctrl - 1));
> -	else
> -		return sprintf(buf, "%d\n", ADT7470_PWM_ALL_TEMPS);
> +	u8 ctrl;
> +	int val;
> +	mutex_lock(&data->lock);
> +	ctrl = data->pwm_auto_temp[index];
> +	val = ctrl ?  (1 << (ctrl - 1)) : ADT7470_PWM_ALL_TEMPS;
> +	mutex_unlock(&data->lock);
> +	return sprintf(buf, "%d\n", val);
>  }

Not sure why this change is needed? data->pwm_auto_temp[index] is only
accessed once. Unless gcc optimizes the code to get rid of the ctrl
local variable, of course. I really have no idea what gcc is allowed to
do or not in this respect. Oh my, this is soooo tricky.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
