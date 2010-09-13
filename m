From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 13 Sep 2010 14:27:52 +0000
Subject: Re: [lm-sensors] [RFC PATCH] Allow the configuration register to be
Message-Id: <20100913162752.250d74fe@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1284386867-21650-1-git-send-email-shubhrajyoti@ti.com>
In-Reply-To: <1284386867-21650-1-git-send-email-shubhrajyoti@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 13 Sep 2010 19:37:47 +0530, Shubhrajyoti D wrote:
> The patch intends to allow the configuration of resolution
> polarity etc.
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
>  drivers/hwmon/lm75.c |   35 +++++++++++++++++++++++++++++++++++
>  1 files changed, 35 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
> index 2a5b12a..abf3135 100644
> --- a/drivers/hwmon/lm75.c
> +++ b/drivers/hwmon/lm75.c
> @@ -111,7 +111,41 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *da,
>  	mutex_unlock(&data->update_lock);
>  	return count;
>  }
> +static ssize_t set_configuration(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t count)
> +{
> +	s32 status;
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct lm75_data *data = i2c_get_clientdata(client);
> +	unsigned long temp;
> +	int error;
> +	error = strict_strtol(buf, 10, &temp);
> +	if (error)
> +		return error;
> +
> +	data->orig_conf = (u8)temp;
> +	/* I2C write to the configuration register */
> +	status = lm75_write_value(client, LM75_REG_CONF,
> +			data->orig_conf);
> +	return count;
> +}
> +
> +static ssize_t show_configuration(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	int status = lm75_read_value(client, LM75_REG_CONF);
> +	if (status < 0) {
> +		dev_dbg(&client->dev, "Can't read config? %d\n", status);
> +		return status;
> +	}
> +
> +	return sprintf(buf, "%u\n", status);
> +}
>  
> +static SENSOR_DEVICE_ATTR(configuration, S_IWUSR | S_IRUGO,
> +			show_configuration, set_configuration, 0);
>  static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO,
>  			show_temp, set_temp, 1);
>  static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO,
> @@ -122,6 +156,7 @@ static struct attribute *lm75_attributes[] = {
>  	&sensor_dev_attr_temp1_input.dev_attr.attr,
>  	&sensor_dev_attr_temp1_max.dev_attr.attr,
>  	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
> +	&sensor_dev_attr_configuration.dev_attr.attr,
>  
>  	NULL
>  };

Massive NACK. You are exposing a raw register interface to user-space,
in a way which can't be standardized. This goes against the philosophy
of our standard sysfs interface.

If you have an LM75-style device in an embedded device, configuration
should be provided as platform data. For other cases, either the
BIOS/firmware should configure the device properly, or you can do it
with i2c-dev + i2cset from user-space.

If any properly really needs to be exposed though sysfs in your
opinion, it must be standardized first and stick to the one file, one
feature philosophy.


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
