From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 12 Mar 2013 17:16:05 +0000
Subject: Re: [lm-sensors] [PATCH 3/5] hwmon: (lm75) Prepare to support per-chip resolution and sample time
Message-Id: <20130312171605.GE30269@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130312154543.03f85393@endymion.delvare>
In-Reply-To: <20130312154543.03f85393@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Mar 12, 2013 at 03:45:43PM +0100, Jean Delvare wrote:
> Prepare the lm75 driver to support per-chip resolution and sample
> time. For now we only make the code generic enough to support it, but
> we still use the same, unchanged resolution (9-bit) and sample time
> (1.5 s) for all chips.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/hwmon/lm75.c |   31 ++++++++++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 5 deletions(-)
> 
> --- linux-3.9-rc2.orig/drivers/hwmon/lm75.c	2013-03-12 13:37:45.206041683 +0100
> +++ linux-3.9-rc2/drivers/hwmon/lm75.c	2013-03-12 13:58:09.676334428 +0100
> @@ -71,9 +71,12 @@ struct lm75_data {
>  	struct device		*hwmon_dev;
>  	struct mutex		update_lock;
>  	u8			orig_conf;
> +	u8			resolution;	/* In bits, between 9 and 12 */
> +	u8			resolution_limits;
>  	char			valid;		/* !=0 if registers are valid */
>  	unsigned long		last_updated;	/* In jiffies */
> -	u16			temp[3];	/* Register values,
> +	unsigned long		sample_time;	/* In jiffies */
> +	s16			temp[3];	/* Register values,
>  						   0 = input
>  						   1 = max
>  						   2 = hyst */
> @@ -93,12 +96,15 @@ static ssize_t show_temp(struct device *
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
>  	struct lm75_data *data = lm75_update_device(dev);
> +	long temp;
>  
>  	if (IS_ERR(data))
>  		return PTR_ERR(data);
>  
> -	return sprintf(buf, "%d\n",
> -		       LM75_TEMP_FROM_REG(data->temp[attr->index]));
> +	temp = ((data->temp[attr->index] >> (16 - data->resolution)) * 1000)
> +	       >> (data->resolution - 8);
> +
> +	return sprintf(buf, "%ld\n", temp);
>  }
>  
>  static ssize_t set_temp(struct device *dev, struct device_attribute *da,
> @@ -110,13 +116,25 @@ static ssize_t set_temp(struct device *d
>  	int nr = attr->index;
>  	long temp;
>  	int error;
> +	u8 resolution;
>  
>  	error = kstrtol(buf, 10, &temp);
>  	if (error)
>  		return error;
>  
> +	/*
> +	 * Resolution of limit registers is assumed to be the same as the
> +	 * temperature input register resolution unless given explicitly.
> +	 */
> +	if (attr->index && data->resolution_limits)
> +		resolution = data->resolution_limits;
> +	else
> +		resolution = data->resolution;
> +
>  	mutex_lock(&data->update_lock);
> -	data->temp[nr] = LM75_TEMP_TO_REG(temp);
> +	temp = clamp_val(temp, LM75_TEMP_MIN, LM75_TEMP_MAX);
> +	data->temp[nr] = DIV_ROUND_CLOSEST(temp  << (resolution - 8),
> +					   1000) << (16 - resolution);
>  	lm75_write_value(client, LM75_REG_TEMP[nr], data->temp[nr]);
>  	mutex_unlock(&data->update_lock);
>  	return count;
> @@ -190,6 +208,9 @@ lm75_probe(struct i2c_client *client, co
>  		break;
>  	}
>  
> +	data->resolution = 9;
> +	data->sample_time = HZ + HZ / 2;
> +
>  	/* configure as specified */
>  	status = lm75_read_value(client, LM75_REG_CONF);
>  	if (status < 0) {
> @@ -427,7 +448,7 @@ static struct lm75_data *lm75_update_dev
>  
>  	mutex_lock(&data->update_lock);
>  
> -	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
> +	if (time_after(jiffies, data->last_updated + data->sample_time)
>  	    || !data->valid) {
>  		int i;
>  		dev_dbg(&client->dev, "Starting lm75 update\n");
> 
> -- 
> Jean Delvare
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
