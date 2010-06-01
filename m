From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 01 Jun 2010 12:54:33 +0000
Subject: Re: [lm-sensors] [PATCH] emc1403: Add power support
Message-Id: <20100601145433.46dd6d73@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alan,

Adding the lm-sensors list...

On Tue, 01 Jun 2010 12:52:57 +0100, Alan Cox wrote:
> Add back the power interface we lost due to a slight misunderstanding of
> the maintainers wishes
> 
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
> 
>  drivers/hwmon/emc1403.c |   33 +++++++++++++++++++++++++++++++++
>  1 files changed, 33 insertions(+), 0 deletions(-)
> 
> 
> diff --git a/drivers/hwmon/emc1403.c b/drivers/hwmon/emc1403.c
> index 0e4b564..5b58b20 100644
> --- a/drivers/hwmon/emc1403.c
> +++ b/drivers/hwmon/emc1403.c
> @@ -89,6 +89,35 @@ static ssize_t store_temp(struct device *dev,
>  	return count;
>  }
>  
> +static ssize_t store_bit(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct thermal_data *data = i2c_get_clientdata(client);
> +	struct sensor_device_attribute_2 *sda = to_sensor_dev_attr_2(attr);
> +	unsigned long val;
> +	int retval;
> +
> +	if (strict_strtoul(buf, 10, &val))
> +		return -EINVAL;
> +
> +	mutex_lock(&data->mutex);
> +	retval = i2c_smbus_read_byte_data(client, sda->nr);
> +	if (retval < 0)
> +		goto fail;
> +
> +	retval &= ~sda->index;
> +	if (val)
> +		retval |= sda->index;
> +
> +	retval = i2c_smbus_write_byte_data(client, sda->index, retval);
> +	if (retval = 0)
> +		retval = count;
> +fail:
> +	mutex_unlock(&data->mutex);
> +	return retval;
> +}
> +
>  static ssize_t show_hyst(struct device *dev,
>  			struct device_attribute *attr, char *buf)
>  {
> @@ -200,6 +229,9 @@ static SENSOR_DEVICE_ATTR_2(temp3_crit_alarm, S_IRUGO,
>  static SENSOR_DEVICE_ATTR(temp3_crit_hyst, S_IRUGO | S_IWUSR,
>  	show_hyst, store_hyst, 0x1A);
>  
> +static SENSOR_DEVICE_ATTR_2(power_state, S_IRUGO | S_IWUSR,
> +	show_bit, store_bit, 0x03, 0x40);
> +
>  static struct attribute *mid_att_thermal[] = {
>  	&sensor_dev_attr_temp1_min.dev_attr.attr,
>  	&sensor_dev_attr_temp1_max.dev_attr.attr,
> @@ -225,6 +257,7 @@ static struct attribute *mid_att_thermal[] = {
>  	&sensor_dev_attr_temp3_max_alarm.dev_attr.attr,
>  	&sensor_dev_attr_temp3_crit_alarm.dev_attr.attr,
>  	&sensor_dev_attr_temp3_crit_hyst.dev_attr.attr,
> +	&sensor_dev_attr_power_state.dev_attr.attr,
>  	NULL
>  };
>  

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
