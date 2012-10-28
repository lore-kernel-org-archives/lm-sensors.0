From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 28 Oct 2012 21:39:54 +0000
Subject: Re: [lm-sensors] [PATCH 1/9] hwmon: (it87) Save temperature registers in 2-dimensional array
Message-Id: <20121028223954.658595ef@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1351448401-13985-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1351448401-13985-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 28 Oct 2012 11:19:53 -0700, Guenter Roeck wrote:
> Cleaner code, fewer checkpatch errors, and reduced code size
> (saves more than 500 bytes on x86-64).

I like the idea.

> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/it87.c |   92 ++++++++++++++++----------------------------------
>  1 file changed, 30 insertions(+), 62 deletions(-)
> 
> diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
> index f1de397..350d8f4 100644
> --- a/drivers/hwmon/it87.c
> +++ b/drivers/hwmon/it87.c
> @@ -265,9 +265,7 @@ struct it87_data {
>  	u16 fan[5];		/* Register values, possibly combined */
>  	u16 fan_min[5];		/* Register values, possibly combined */
>  	u8 has_temp;		/* Bitfield, temp sensors enabled */
> -	s8 temp[3];		/* Register value */
> -	s8 temp_high[3];	/* Register value */
> -	s8 temp_low[3];		/* Register value */
> +	s8 temp[3][3];		/* [nr][0]=temp, [1]=min, [2]=max */
>  	u8 sensor;		/* Register value */
>  	u8 fan_div[3];		/* Register encoding, shifted right */
>  	u8 vid;			/* Register encoding, combined */
> @@ -545,38 +543,22 @@ show_in_offset(8);
>  
>  /* 3 temperatures */
>  static ssize_t show_temp(struct device *dev, struct device_attribute *attr,
> -		char *buf)
> +			 char *buf)
>  {
> -	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
> -	int nr = sensor_attr->index;
> -
> +	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
> +	int nr = sattr->nr;
> +	int index = sattr->index;
>  	struct it87_data *data = it87_update_device(dev);
> -	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[nr]));
> -}
> -static ssize_t show_temp_max(struct device *dev, struct device_attribute *attr,
> -		char *buf)
> -{
> -	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
> -	int nr = sensor_attr->index;
>  
> -	struct it87_data *data = it87_update_device(dev);
> -	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_high[nr]));
> +	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[nr][index]));
>  }
> -static ssize_t show_temp_min(struct device *dev, struct device_attribute *attr,
> -		char *buf)
> -{
> -	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
> -	int nr = sensor_attr->index;
>  
> -	struct it87_data *data = it87_update_device(dev);
> -	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_low[nr]));
> -}
> -static ssize_t set_temp_max(struct device *dev, struct device_attribute *attr,
> -		const char *buf, size_t count)
> +static ssize_t set_temp(struct device *dev, struct device_attribute *attr,
> +			const char *buf, size_t count)
>  {
> -	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
> -	int nr = sensor_attr->index;
> -
> +	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
> +	int nr = sattr->nr;
> +	int index = sattr->index;
>  	struct it87_data *data = dev_get_drvdata(dev);
>  	long val;
>  
> @@ -584,40 +566,26 @@ static ssize_t set_temp_max(struct device *dev, struct device_attribute *attr,
>  		return -EINVAL;
>  
>  	mutex_lock(&data->update_lock);
> -	data->temp_high[nr] = TEMP_TO_REG(val);
> -	it87_write_value(data, IT87_REG_TEMP_HIGH(nr), data->temp_high[nr]);
> +	data->temp[nr][index] = TEMP_TO_REG(val);
> +	it87_write_value(data,
> +			 index = 1 ? IT87_REG_TEMP_LOW(nr)
> +				    : IT87_REG_TEMP_HIGH(nr),
> +			 data->temp[nr][index]);
>  	mutex_unlock(&data->update_lock);
>  	return count;
>  }
> -static ssize_t set_temp_min(struct device *dev, struct device_attribute *attr,
> -		const char *buf, size_t count)
> -{
> -	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
> -	int nr = sensor_attr->index;
> -
> -	struct it87_data *data = dev_get_drvdata(dev);
> -	long val;
>  
> -	if (kstrtol(buf, 10, &val) < 0)
> -		return -EINVAL;
> +#define S_IRUGOWU	(S_IRUGO | S_IWUSR)

I'm not a big fan of this being defined in a single driver. If you
think it helps, then it would help several hundred drivers, not just
this one, so it should be defined in <linux/stat.h>, not locally.

>  
> -	mutex_lock(&data->update_lock);
> -	data->temp_low[nr] = TEMP_TO_REG(val);
> -	it87_write_value(data, IT87_REG_TEMP_LOW(nr), data->temp_low[nr]);
> -	mutex_unlock(&data->update_lock);
> -	return count;
> -}
> -#define show_temp_offset(offset)					\
> -static SENSOR_DEVICE_ATTR(temp##offset##_input, S_IRUGO,		\
> -		show_temp, NULL, offset - 1);				\
> -static SENSOR_DEVICE_ATTR(temp##offset##_max, S_IRUGO | S_IWUSR,	\
> -		show_temp_max, set_temp_max, offset - 1);		\
> -static SENSOR_DEVICE_ATTR(temp##offset##_min, S_IRUGO | S_IWUSR,	\
> -		show_temp_min, set_temp_min, offset - 1);
> -
> -show_temp_offset(1);
> -show_temp_offset(2);
> -show_temp_offset(3);
> +static SENSOR_DEVICE_ATTR_2(temp1_input, S_IRUGO, show_temp, NULL, 0, 0);
> +static SENSOR_DEVICE_ATTR_2(temp1_min, S_IRUGOWU, show_temp, set_temp, 0, 1);
> +static SENSOR_DEVICE_ATTR_2(temp1_max, S_IRUGOWU, show_temp, set_temp, 0, 2);
> +static SENSOR_DEVICE_ATTR_2(temp2_input, S_IRUGO, show_temp, NULL, 1, 0);
> +static SENSOR_DEVICE_ATTR_2(temp2_min, S_IRUGOWU, show_temp, set_temp, 1, 1);
> +static SENSOR_DEVICE_ATTR_2(temp2_max, S_IRUGOWU, show_temp, set_temp, 1, 2);
> +static SENSOR_DEVICE_ATTR_2(temp3_input, S_IRUGO, show_temp, NULL, 2, 0);
> +static SENSOR_DEVICE_ATTR_2(temp3_min, S_IRUGOWU, show_temp, set_temp, 2, 1);
> +static SENSOR_DEVICE_ATTR_2(temp3_max, S_IRUGOWU, show_temp, set_temp, 2, 2);
>  
>  static ssize_t show_sensor(struct device *dev, struct device_attribute *attr,
>  		char *buf)
> @@ -2419,12 +2387,12 @@ static struct it87_data *it87_update_device(struct device *dev)
>  		for (i = 0; i < 3; i++) {
>  			if (!(data->has_temp & (1 << i)))
>  				continue;
> -			data->temp[i] > +			data->temp[i][0] >  				it87_read_value(data, IT87_REG_TEMP(i));
> -			data->temp_high[i] > -				it87_read_value(data, IT87_REG_TEMP_HIGH(i));
> -			data->temp_low[i] > +			data->temp[i][1] >  				it87_read_value(data, IT87_REG_TEMP_LOW(i));
> +			data->temp[i][2] > +				it87_read_value(data, IT87_REG_TEMP_HIGH(i));
>  		}
>  
>  		/* Newer chips don't have clock dividers */

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
