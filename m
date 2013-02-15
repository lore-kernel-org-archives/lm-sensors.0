From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Feb 2013 20:20:02 +0000
Subject: Re: [lm-sensors] [PATCH 6/9] hwmon: (adt7410) Don't re-read non-volatile registers
Message-Id: <20130215202002.GF32433@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1360947438-2550-1-git-send-email-lars@metafoo.de>
 <1360947438-2550-6-git-send-email-lars@metafoo.de>
In-Reply-To: <1360947438-2550-6-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jean Delvare <khali@linux-fr.org>, Hartmut Knaack <knaack.h@gmx.de>, Jonathan Cameron <jic23@cam.ac.uk>, lm-sensors@lm-sensors.org, linux-iio@vger.kernel.org

On Fri, Feb 15, 2013 at 05:57:15PM +0100, Lars-Peter Clausen wrote:
> Currently each time the temperature register is read the driver also reads the
> threshold and hysteresis registers. This increases the amount of I2C traffic and
> time needed to read the temperature by a factor of ~5. Neither the threshold nor
> the hysteresis change on their own, so once we've read them, we should be able
> to just use the cached value of the registers. This patch modifies the code
> accordingly and only reads the threshold and hysteresis registers once during
> probe.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  drivers/hwmon/adt7410.c | 89 +++++++++++++++++++++++++++++++------------------
>  1 file changed, 56 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/hwmon/adt7410.c b/drivers/hwmon/adt7410.c
> index 99a7290..5de0376 100644
> --- a/drivers/hwmon/adt7410.c
> +++ b/drivers/hwmon/adt7410.c
> @@ -119,45 +119,31 @@ static int adt7410_temp_ready(struct i2c_client *client)
>  	return -ETIMEDOUT;
>  }
>  
> -static struct adt7410_data *adt7410_update_device(struct device *dev)
> +static int adt7410_update_temp(struct device *dev)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct adt7410_data *data = i2c_get_clientdata(client);
> -	struct adt7410_data *ret = data;
> +	int ret = 0;
> +
>  	mutex_lock(&data->update_lock);
>  
>  	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
>  	    || !data->valid) {
> -		int i, status;
>  
>  		dev_dbg(&client->dev, "Starting update\n");
>  
> -		status = adt7410_temp_ready(client); /* check for new value */
> -		if (unlikely(status)) {
> -			ret = ERR_PTR(status);
> +		ret = adt7410_temp_ready(client); /* check for new value */
> +		if (ret)
>  			goto abort;
> -		}
> -		for (i = 0; i < ARRAY_SIZE(data->temp); i++) {
> -			status = i2c_smbus_read_word_swapped(client,
> -							ADT7410_REG_TEMP[i]);
> -			if (unlikely(status < 0)) {
> -				dev_dbg(dev,
> -					"Failed to read value: reg %d, error %d\n",
> -					ADT7410_REG_TEMP[i], status);
> -				ret = ERR_PTR(status);
> -				goto abort;
> -			}
> -			data->temp[i] = status;
> -		}
> -		status = i2c_smbus_read_byte_data(client, ADT7410_T_HYST);
> -		if (unlikely(status < 0)) {
> -			dev_dbg(dev,
> -				"Failed to read value: reg %d, error %d\n",
> -				ADT7410_T_HYST, status);
> -			ret = ERR_PTR(status);
> +
> +		ret = i2c_smbus_read_word_swapped(client, ADT7410_REG_TEMP[0]);
> +		if (ret) {

Should be
		if (ret < 0) {

or non-zero temperatures always create an error condition.

> +			dev_dbg(dev, "Failed to read value: reg %d, error %d\n",
> +				ADT7410_REG_TEMP[0], ret);
>  			goto abort;
>  		}
> -		data->hyst = status;
> +		data->temp[0] = ret;
> +
>  		data->last_updated = jiffies;
>  		data->valid = true;
>  	}
> @@ -167,6 +153,35 @@ abort:
>  	return ret;

	ret can be > 0 as no-error return. So you'll either have to
	change the no-error return case to always return 0, or change the
	return value check when the function is called.
>  }
>  
> +static int adt7410_fill_cache(struct i2c_client *client)
> +{
> +	struct adt7410_data *data = i2c_get_clientdata(client);
> +	int ret;
> +	int i;
> +
> +	for (i = 1; i < 3; i++) {

I think using ARRAY_SIZE would be better here. With "i < 3" you don't read the
critical temperature, which proves the point (unless I am missing something).

> +		ret = i2c_smbus_read_word_swapped(client, ADT7410_REG_TEMP[i]);
> +		if (ret) {

		ret < 0

> +			dev_dbg(&client->dev,
> +				"Failed to read value: reg %d, error %d\n",
> +				ADT7410_REG_TEMP[0], ret);
> +			return ret;
> +		}
> +		data->temp[i] = ret;
> +	}
> +
> +	ret = i2c_smbus_read_byte_data(client, ADT7410_T_HYST);
> +	if (ret) {

	ret < 0

> +		dev_dbg(&client->dev,
> +			"Failed to read value: hyst reg, error %d\n",
> +			ret);
> +		return ret;
> +	}
> +	data->hyst = ret;
> +
> +	return 0;
> +}
> +
>  static s16 ADT7410_TEMP_TO_REG(long temp)
>  {
>  	return DIV_ROUND_CLOSEST(clamp_val(temp, ADT7410_TEMP_MIN,
> @@ -193,10 +208,16 @@ static ssize_t adt7410_show_temp(struct device *dev,
>  				 struct device_attribute *da, char *buf)
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
> -	struct adt7410_data *data = adt7410_update_device(dev);
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct adt7410_data *data = i2c_get_clientdata(client);
>  
> -	if (IS_ERR(data))
> -		return PTR_ERR(data);
> +	if (attr->index = 0) {
> +		int ret;
> +
> +		ret = adt7410_update_temp(dev);
> +		if (ret)

Problematic; see above.

> +			return ret;
> +	}
>  
>  	return sprintf(buf, "%d\n", ADT7410_REG_TO_TEMP(data,
>  		       data->temp[attr->index]));
> @@ -232,13 +253,11 @@ static ssize_t adt7410_show_t_hyst(struct device *dev,
>  				   char *buf)
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
> -	struct adt7410_data *data;
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct adt7410_data *data = i2c_get_clientdata(client);
>  	int nr = attr->index;
>  	int hyst;
>  
> -	data = adt7410_update_device(dev);
> -	if (IS_ERR(data))
> -		return PTR_ERR(data);
>  	hyst = (data->hyst & ADT7410_T_HYST_MASK) * 1000;
>  
>  	/*
> @@ -371,6 +390,10 @@ static int adt7410_probe(struct i2c_client *client,
>  	}
>  	dev_dbg(&client->dev, "Config %02x\n", data->config);
>  
> +	ret = adt7410_fill_cache(client);
> +	if (ret)
> +		goto exit_restore;
> +
>  	/* Register sysfs hooks */
>  	ret = sysfs_create_group(&client->dev.kobj, &adt7410_group);
>  	if (ret)
> -- 
> 1.8.0
> 
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
