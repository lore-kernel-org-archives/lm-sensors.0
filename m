From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 10 Jul 2013 18:21:54 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/3] hwmon: (lm90) split set&show temp as common codes
Message-Id: <20130710182154.GC22430@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1373455539-2831-1-git-send-email-wni@nvidia.com>
 <1373455539-2831-2-git-send-email-wni@nvidia.com>
In-Reply-To: <1373455539-2831-2-git-send-email-wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, Jul 10, 2013 at 07:25:37PM +0800, Wei Ni wrote:
> Split set&show temp codes as common functions, so we can use it directly when
> implement linux thermal framework.
> 
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  drivers/hwmon/lm90.c |  118 ++++++++++++++++++++++++++++++++------------------
>  1 file changed, 75 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
> index 8eeb141..2cb7f8e 100644
> --- a/drivers/hwmon/lm90.c
> +++ b/drivers/hwmon/lm90.c
> @@ -702,29 +702,37 @@ static u16 temp_to_u16_adt7461(struct lm90_data *data, long val)
>   * Sysfs stuff
>   */
>  
> -static ssize_t show_temp8(struct device *dev, struct device_attribute *devattr,
> -			  char *buf)
> +static int read_temp8(struct device *dev, int index)
>  {
> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -	struct lm90_data *data = lm90_update_device(dev);
>  	int temp;
> +	struct lm90_data *data = lm90_update_device(dev);
>  
Why this reordering of variables ?

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
> +	return temp;
> +}
> +
> +static ssize_t show_temp8(struct device *dev, struct device_attribute *devattr,
> +			  char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	int temp;
> +
> +	temp = read_temp8(dev, attr->index);
> +
>  	return sprintf(buf, "%d\n", temp);

Might as well simplify with
	return sprintf(buf, "%d\n", read_temp8(dev, attr->index));

>  }
>  
> -static ssize_t set_temp8(struct device *dev, struct device_attribute *devattr,
> -			 const char *buf, size_t count)
> +static void write_temp8(struct device *dev, int index, long val)
>  {
>  	static const u8 reg[8] = {
>  		LM90_REG_W_LOCAL_LOW,
> @@ -737,60 +745,76 @@ static ssize_t set_temp8(struct device *dev, struct device_attribute *devattr,
>  		MAX6659_REG_W_REMOTE_EMERG,
>  	};
>  
> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct lm90_data *data = i2c_get_clientdata(client);
> -	int nr = attr->index;
> -	long val;
> -	int err;
> -
> -	err = kstrtol(buf, 10, &val);
> -	if (err < 0)
> -		return err;
>  
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
> +		data->temp8[index] = temp_to_s8(val);
>  
> -	lm90_select_remote_channel(client, data, nr >= 6);
> -	i2c_smbus_write_byte_data(client, reg[nr], data->temp8[nr]);
> +	lm90_select_remote_channel(client, data, index >= 6);
> +	i2c_smbus_write_byte_data(client, reg[index], data->temp8[index]);
>  	lm90_select_remote_channel(client, data, 0);
>  
>  	mutex_unlock(&data->update_lock);
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
> +	write_temp8(dev, index, val);
> +
>  	return count;
>  }
>  
> -static ssize_t show_temp11(struct device *dev, struct device_attribute *devattr,
> -			   char *buf)
> +static int read_temp11(struct device *dev, int index)
>  {
> -	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
> -	struct lm90_data *data = lm90_update_device(dev);
>  	int temp;
> +	struct lm90_data *data = lm90_update_device(dev);
>  
Another unnecessary variable reorder.

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
> +	if (data->kind = lm99 &&  index <= 2)
>  		temp += 16000;
>  
> +	return temp;
> +}
> +
> +static ssize_t show_temp11(struct device *dev, struct device_attribute *devattr,
> +			   char *buf)
> +{
> +	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
> +	int temp;
> +
> +	temp = read_temp11(dev, attr->index);
> +
>  	return sprintf(buf, "%d\n", temp);

Same simplification as above.

>  }
>  
> -static ssize_t set_temp11(struct device *dev, struct device_attribute *devattr,
> -			  const char *buf, size_t count)
> +static void write_temp11(struct device *dev, int nr, int index, long val)
>  {
>  	struct {
>  		u8 high;
> @@ -804,17 +828,8 @@ static ssize_t set_temp11(struct device *dev, struct device_attribute *devattr,
>  		{ LM90_REG_W_REMOTE_HIGHH, LM90_REG_W_REMOTE_HIGHL, 1 }
>  	};
>  
> -	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct lm90_data *data = i2c_get_clientdata(client);
> -	int nr = attr->nr;
> -	int index = attr->index;
> -	long val;
> -	int err;
> -
> -	err = kstrtol(buf, 10, &val);
> -	if (err < 0)
> -		return err;
>  
>  	/* +16 degrees offset for temp2 for the LM99 */
>  	if (data->kind = lm99 && index <= 2)
> @@ -839,6 +854,23 @@ static ssize_t set_temp11(struct device *dev, struct device_attribute *devattr,
>  	lm90_select_remote_channel(client, data, 0);
>  
>  	mutex_unlock(&data->update_lock);
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
> +	write_temp11(dev, nr, index, val);
> +
>  	return count;
>  }
>  
> -- 
> 1.7.9.5
> 
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
