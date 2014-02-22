From: Jean Delvare <jdelvare@suse.de>
Date: Sat, 22 Feb 2014 13:21:28 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (lm95245) Fix hysteresis temperatures
Message-Id: <20140222142128.1aa1b3a8@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1391747559-7601-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1391747559-7601-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

Sorry for the late review.

On Thu,  6 Feb 2014 20:32:38 -0800, Guenter Roeck wrote:
> Hysteresis temperatures are defined as absolute temperatures,
> not as delta value from the critical temperatures.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/lm95245.c |   30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/hwmon/lm95245.c b/drivers/hwmon/lm95245.c
> index a6c85f0..c58d431 100644
> --- a/drivers/hwmon/lm95245.c
> +++ b/drivers/hwmon/lm95245.c
> @@ -272,19 +272,31 @@ static ssize_t set_limit(struct device *dev, struct device_attribute *attr,
>  	return count;
>  }
>  
> +static ssize_t show_crit_hyst(struct device *dev, struct device_attribute *attr,
> +			      char *buf)
> +{
> +	struct lm95245_data *data = lm95245_update_device(dev);
> +	int index = to_sensor_dev_attr(attr)->index;
> +	int hyst = data->regs[index] - data->regs[8];
> +
> +	return snprintf(buf, PAGE_SIZE - 1, "%d\n", hyst * 1000);
> +}
> +
>  static ssize_t set_crit_hyst(struct device *dev, struct device_attribute *attr,
> -			const char *buf, size_t count)
> +			     const char *buf, size_t count)

These reindentations do not belong to this patch - if they are needed
at all. The same style is used everywhere in the driver and while it's
not my preferred one either, it's used quite consistently as far as I
can tell. I would leave it as is. If it really bothers you then you
should "fix" the whole driver with a separate patch.

>  {
> +	struct lm95245_data *data = lm95245_update_device(dev);

Calling the update function in "set" callbacks is discouraged. Set
functions are typically called at boot time. The update function can be
quite slow as it reads a lot of registers over slow I2C/SMBus.

Admittedly the number of registers of this particular chip isn't too
high so the effect is limited, but you should still consider the option
of only reading the register value you need.

>  	struct i2c_client *client = to_i2c_client(dev);
> -	struct lm95245_data *data = i2c_get_clientdata(client);
> +	int index = to_sensor_dev_attr(attr)->index;
>  	unsigned long val;
> +	long hyst;
>  
>  	if (kstrtoul(buf, 10, &val) < 0)
>  		return -EINVAL;
>  
>  	val /= 1000;
> -
> -	val = clamp_val(val, 0, 31);
> +	hyst = data->regs[index] - val;
> +	hyst = clamp_val(hyst, 0, 31);
>  
>  	mutex_lock(&data->update_lock);
>  
> @@ -292,7 +304,7 @@ static ssize_t set_crit_hyst(struct device *dev, struct device_attribute *attr,
>  
>  	/* shared crit hysteresis */
>  	i2c_smbus_write_byte_data(client, LM95245_REG_RW_COMMON_HYSTERESIS,
> -		val);
> +				  val);
>  
>  	mutex_unlock(&data->update_lock);
>  
> @@ -378,16 +390,16 @@ static ssize_t set_interval(struct device *dev, struct device_attribute *attr,
>  static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_input, NULL, 0);
>  static SENSOR_DEVICE_ATTR(temp1_crit, S_IWUSR | S_IRUGO, show_limit,
>  		set_limit, 6);
> -static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IWUSR | S_IRUGO, show_limit,
> -		set_crit_hyst, 8);
> +static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IWUSR | S_IRUGO, show_crit_hyst,
> +		set_crit_hyst, 6);
>  static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL,
>  		STATUS1_LOC);
>  
>  static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_input, NULL, 2);
>  static SENSOR_DEVICE_ATTR(temp2_crit, S_IWUSR | S_IRUGO, show_limit,
>  		set_limit, 7);
> -static SENSOR_DEVICE_ATTR(temp2_crit_hyst, S_IWUSR | S_IRUGO, show_limit,
> -		set_crit_hyst, 8);
> +static SENSOR_DEVICE_ATTR(temp2_crit_hyst, S_IWUSR | S_IRUGO, show_crit_hyst,
> +		set_crit_hyst, 7);

This isn't directly related to your patch, however this isn't how we
typically handle shared hysteresis registers. If you look at the lm90
driver, temp1_crit_hyst is writable but temp2_crit_hyst is read-only.
This is how we let the user know that both values can't be set
independently. Here the user can set both, and will then consider it a
bug that temp1_crit_hyst isn't set to the right value.

As you are already fixing this interface, I think you should also turn
temp2_crit_hyst to read-only, so that users don't have to change their
configuration file twice.

>  static SENSOR_DEVICE_ATTR(temp2_crit_alarm, S_IRUGO, show_alarm, NULL,
>  		STATUS1_RTCRIT);
>  static SENSOR_DEVICE_ATTR(temp2_type, S_IWUSR | S_IRUGO, show_type,

The code changes themselves look good to me, and are very needed.

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
