From: Wei Ni <wni@nvidia.com>
Date: Tue, 08 Oct 2013 07:10:10 +0000
Subject: Re: [lm-sensors] [PATCH v5] hwmon: (lm90) split set&show temp as common codes
Message-Id: <5253AFD2.2010405@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1381215866-20608-1-git-send-email-wni@nvidia.com>
In-Reply-To: <1381215866-20608-1-git-send-email-wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org" <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

The previous version is in https://lkml.org/lkml/2013/8/6/170 .

Changes from v4:
Couple of changes to get right error codes, as per Jean's review.

On 10/08/2013 03:04 PM, Wei Ni wrote:
> Split set&show temp codes as common functions, so we can use it
> directly when implement linux thermal framework.
> And handle error return value for the lm90_select_remote_channel
> and write_tempx, then set_temp8 and set_temp11 could return it
> to user-space.
> 
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  drivers/hwmon/lm90.c |  166 ++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 113 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
> index 3f51680..82a1ca15 100644
> --- a/drivers/hwmon/lm90.c
> +++ b/drivers/hwmon/lm90.c
> @@ -424,20 +424,29 @@ static int lm90_read16(struct i2c_client *client, u8 regh, u8 regl, u16 *value)
>   * various registers have different meanings as a result of selecting a
>   * non-default remote channel.
>   */
> -static inline void lm90_select_remote_channel(struct i2c_client *client,
> +static inline int lm90_select_remote_channel(struct i2c_client *client,
>  					      struct lm90_data *data,
>  					      int channel)
>  {
>  	u8 config;
> +	int err;
>  
>  	if (data->kind = max6696) {
>  		lm90_read_reg(client, LM90_REG_R_CONFIG1, &config);
>  		config &= ~0x08;
>  		if (channel)
>  			config |= 0x08;
> -		i2c_smbus_write_byte_data(client, LM90_REG_W_CONFIG1,
> -					  config);
> +		err = i2c_smbus_write_byte_data(client, LM90_REG_W_CONFIG1,
> +						config);
> +		if (err < 0) {
> +			dev_err(&client->dev,
> +				"Failed to select remote channel %d, err %d\n",
> +				channel, err);
> +			return err;
> +		}
>  	}
> +
> +	return 0;
>  }
>  
>  /*
> @@ -704,29 +713,34 @@ static u16 temp_to_u16_adt7461(struct lm90_data *data, long val)
>   * Sysfs stuff
>   */
>  
> -static ssize_t show_temp8(struct device *dev, struct device_attribute *devattr,
> -			  char *buf)
> +static int read_temp8(struct device *dev, int index)
>  {
> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct lm90_data *data = lm90_update_device(dev);
>  	int temp;
>  
>  	if (data->kind = adt7461)
> -		temp = temp_from_u8_adt7461(data, data->temp8[attr->index]);
> +		temp = temp_from_u8_adt7461(data, data->temp8[index]);
>  	else if (data->kind = max6646)
> -		temp = temp_from_u8(data->temp8[attr->index]);
> +		temp = temp_from_u8(data->temp8[index]);
>  	else
> -		temp = temp_from_s8(data->temp8[attr->index]);
> +		temp = temp_from_s8(data->temp8[index]);
>  
>  	/* +16 degrees offset for temp2 for the LM99 */
> -	if (data->kind = lm99 && attr->index = 3)
> +	if (data->kind = lm99 && index = 3)
>  		temp += 16000;
>  
> -	return sprintf(buf, "%d\n", temp);
> +	return temp;
>  }
>  
> -static ssize_t set_temp8(struct device *dev, struct device_attribute *devattr,
> -			 const char *buf, size_t count)
> +static ssize_t show_temp8(struct device *dev, struct device_attribute *devattr,
> +			  char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +
> +	return sprintf(buf, "%d\n", read_temp8(dev, attr->index));
> +}
> +
> +static int write_temp8(struct device *dev, int index, long val)
>  {
>  	static const u8 reg[8] = {
>  		LM90_REG_W_LOCAL_LOW,
> @@ -739,60 +753,79 @@ static ssize_t set_temp8(struct device *dev, struct device_attribute *devattr,
>  		MAX6659_REG_W_REMOTE_EMERG,
>  	};
>  
> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct lm90_data *data = i2c_get_clientdata(client);
> -	int nr = attr->index;
> -	long val;
>  	int err;
>  
> -	err = kstrtol(buf, 10, &val);
> -	if (err < 0)
> -		return err;
> -
>  	/* +16 degrees offset for temp2 for the LM99 */
> -	if (data->kind = lm99 && attr->index = 3)
> +	if (data->kind = lm99 && index = 3)
>  		val -= 16000;
>  
>  	mutex_lock(&data->update_lock);
>  	if (data->kind = adt7461)
> -		data->temp8[nr] = temp_to_u8_adt7461(data, val);
> +		data->temp8[index] = temp_to_u8_adt7461(data, val);
>  	else if (data->kind = max6646)
> -		data->temp8[nr] = temp_to_u8(val);
> +		data->temp8[index] = temp_to_u8(val);
>  	else
> -		data->temp8[nr] = temp_to_s8(val);
> -
> -	lm90_select_remote_channel(client, data, nr >= 6);
> -	i2c_smbus_write_byte_data(client, reg[nr], data->temp8[nr]);
> -	lm90_select_remote_channel(client, data, 0);
> +		data->temp8[index] = temp_to_s8(val);
>  
> +	if ((err = lm90_select_remote_channel(client, data, index >= 6)) ||
> +	    (err = i2c_smbus_write_byte_data(client, reg[index], data->temp8[index])) ||
> +	    (err = lm90_select_remote_channel(client, data, 0))) {
> +		dev_err(dev, "write_temp8 failed %d\n", err);
> +	}
>  	mutex_unlock(&data->update_lock);
> +
> +	return err;
> +}
> +
> +static ssize_t set_temp8(struct device *dev, struct device_attribute *devattr,
> +			 const char *buf, size_t count)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	int index = attr->index;
> +	long val;
> +	int err;
> +
> +	err = kstrtol(buf, 10, &val);
> +	if (err < 0)
> +		return err;
> +
> +	err = write_temp8(dev, index, val);
> +	if (err < 0)
> +		return err;
> +
>  	return count;
>  }
>  
> -static ssize_t show_temp11(struct device *dev, struct device_attribute *devattr,
> -			   char *buf)
> +static int read_temp11(struct device *dev, int index)
>  {
> -	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
>  	struct lm90_data *data = lm90_update_device(dev);
>  	int temp;
>  
>  	if (data->kind = adt7461)
> -		temp = temp_from_u16_adt7461(data, data->temp11[attr->index]);
> +		temp = temp_from_u16_adt7461(data, data->temp11[index]);
>  	else if (data->kind = max6646)
> -		temp = temp_from_u16(data->temp11[attr->index]);
> +		temp = temp_from_u16(data->temp11[index]);
>  	else
> -		temp = temp_from_s16(data->temp11[attr->index]);
> +		temp = temp_from_s16(data->temp11[index]);
>  
>  	/* +16 degrees offset for temp2 for the LM99 */
> -	if (data->kind = lm99 &&  attr->index <= 2)
> +	if (data->kind = lm99 && index <= 2)
>  		temp += 16000;
>  
> -	return sprintf(buf, "%d\n", temp);
> +	return temp;
>  }
>  
> -static ssize_t set_temp11(struct device *dev, struct device_attribute *devattr,
> -			  const char *buf, size_t count)
> +static ssize_t show_temp11(struct device *dev, struct device_attribute *devattr,
> +			   char *buf)
> +{
> +	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
> +
> +	return sprintf(buf, "%d\n", read_temp11(dev, attr->index));
> +}
> +
> +static int write_temp11(struct device *dev, int nr, int index, long val)
>  {
>  	struct {
>  		u8 high;
> @@ -806,18 +839,10 @@ static ssize_t set_temp11(struct device *dev, struct device_attribute *devattr,
>  		{ LM90_REG_W_REMOTE_HIGHH, LM90_REG_W_REMOTE_HIGHL, 1 }
>  	};
>  
> -	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct lm90_data *data = i2c_get_clientdata(client);
> -	int nr = attr->nr;
> -	int index = attr->index;
> -	long val;
>  	int err;
>  
> -	err = kstrtol(buf, 10, &val);
> -	if (err < 0)
> -		return err;
> -
>  	/* +16 degrees offset for temp2 for the LM99 */
>  	if (data->kind = lm99 && index <= 2)
>  		val -= 16000;
> @@ -832,15 +857,50 @@ static ssize_t set_temp11(struct device *dev, struct device_attribute *devattr,
>  	else
>  		data->temp11[index] = temp_to_s8(val) << 8;
>  
> -	lm90_select_remote_channel(client, data, reg[nr].channel);
> -	i2c_smbus_write_byte_data(client, reg[nr].high,
> -				  data->temp11[index] >> 8);
> -	if (data->flags & LM90_HAVE_REM_LIMIT_EXT)
> -		i2c_smbus_write_byte_data(client, reg[nr].low,
> -					  data->temp11[index] & 0xff);
> -	lm90_select_remote_channel(client, data, 0);
> +	err = lm90_select_remote_channel(client, data, reg[nr].channel);
> +	if (err)
> +		goto error;
> +
> +	err = i2c_smbus_write_byte_data(client, reg[nr].high,
> +					data->temp11[index] >> 8);
> +	if (err)
> +		goto error;
> +
> +	if (data->flags & LM90_HAVE_REM_LIMIT_EXT) {
> +		err = i2c_smbus_write_byte_data(client, reg[nr].low,
> +						data->temp11[index] & 0xff);
> +		if (err)
> +			goto error;
> +	}
> +
> +	err = lm90_select_remote_channel(client, data, 0);
> +
> +error:
> +	if (err)
> +		dev_err(dev, "write_temp11 failed %d\n", err);
>  
>  	mutex_unlock(&data->update_lock);
> +
> +	return err;
> +}
> +
> +static ssize_t set_temp11(struct device *dev, struct device_attribute *devattr,
> +			  const char *buf, size_t count)
> +{
> +	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
> +	int nr = attr->nr;
> +	int index = attr->index;
> +	long val;
> +	int err;
> +
> +	err = kstrtol(buf, 10, &val);
> +	if (err < 0)
> +		return err;
> +
> +	err = write_temp11(dev, nr, index, val);
> +	if (err < 0)
> +		return err;
> +
>  	return count;
>  }
>  
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
