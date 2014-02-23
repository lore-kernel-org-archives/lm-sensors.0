From: Jean Delvare <jdelvare@suse.de>
Date: Sun, 23 Feb 2014 09:49:54 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/4] hwmon: (lm95245) Fix hysteresis temperatures
Message-Id: <20140223104954.0ba2e259@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1393090212-24900-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1393090212-24900-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Sat, 22 Feb 2014 09:30:09 -0800, Guenter Roeck wrote:
> Hysteresis temperatures are defined as absolute temperatures,
> not as delta value from the critical temperatures.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Don't change indentation
>     Don't call lm95245_update_device from set function
>     In set function, actually write the calculated hysteresis
>     instead of the entered value.
> 
>  drivers/hwmon/lm95245.c |   30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/hwmon/lm95245.c b/drivers/hwmon/lm95245.c
> index 3f0956e..d7bcea1 100644
> --- a/drivers/hwmon/lm95245.c
> +++ b/drivers/hwmon/lm95245.c
> @@ -272,27 +272,39 @@ static ssize_t set_limit(struct device *dev, struct device_attribute *attr,
>  	return count;
>  }
>  
> +static ssize_t show_crit_hyst(struct device *dev, struct device_attribute *attr,
> +			char *buf)
> +{
> +	struct lm95245_data *data = lm95245_update_device(dev);
> +	int index = to_sensor_dev_attr(attr)->index;
> +	int hyst = data->regs[index] - data->regs[8];
> +
> +	return snprintf(buf, PAGE_SIZE - 1, "%d\n", hyst * 1000);
> +}
> +
>  static ssize_t set_crit_hyst(struct device *dev, struct device_attribute *attr,
>  			const char *buf, size_t count)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct lm95245_data *data = i2c_get_clientdata(client);
> +	int index = to_sensor_dev_attr(attr)->index;
>  	unsigned long val;
> +	long hyst;
> +	int limit;

Nitpicking: it makes little sense to have hyst and limit as different
types.

>  
>  	if (kstrtoul(buf, 10, &val) < 0)
>  		return -EINVAL;
>  
> -	val /= 1000;
> -
> -	val = clamp_val(val, 0, 31);
> -
>  	mutex_lock(&data->update_lock);
>  
> +	limit = i2c_smbus_read_byte_data(client, lm95245_reg_address[index]);
> +	hyst = limit - val / 1000;
> +	hyst = clamp_val(hyst, 0, 31);

Note that you don't actually need to hold the lock for that. Access to
the SMBus itself is already serialized at the bus driver level, and
you're not touching any field of the data structure (that's what the
lock is protecting.)

>  	data->valid = 0;

BTW do you have any idea why the whole cache is invalidated here? I'd
think that storing hyst as data->regs[8] would be enough?

>  
>  	/* shared crit hysteresis */
>  	i2c_smbus_write_byte_data(client, LM95245_REG_RW_COMMON_HYSTERESIS,
> -		val);
> +		hyst);
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
>  static SENSOR_DEVICE_ATTR(temp2_crit_alarm, S_IRUGO, show_alarm, NULL,
>  		STATUS1_RTCRIT);
>  static SENSOR_DEVICE_ATTR(temp2_type, S_IWUSR | S_IRUGO, show_type,

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
