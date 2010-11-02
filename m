From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 02 Nov 2010 18:45:09 +0000
Subject: Re: [lm-sensors] [PATCH 2/4] hwmon: (w83792d) Implement the
Message-Id: <1288723509.22931.47.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101102174111.310ea11e@endymion.delvare>
In-Reply-To: <20101102174111.310ea11e@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Tue, 2010-11-02 at 12:41 -0400, Jean Delvare wrote:
> We have a standard intrusion detection interface now, drivers should
> implement it. I've left the old interface in place for the time being,
> with a deprecation warning, it will be removed later.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
>  drivers/hwmon/w83792d.c |   30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> --- linux-2.6.37-rc1.orig/drivers/hwmon/w83792d.c	2010-08-02 00:11:14.000000000 +0200
> +++ linux-2.6.37-rc1/drivers/hwmon/w83792d.c	2010-11-02 15:03:55.000000000 +0100
> @@ -706,7 +706,7 @@ show_chassis_clear(struct device *dev, s
>  }
>  
>  static ssize_t
> -store_chassis_clear(struct device *dev, struct device_attribute *attr,
> +store_chassis_clear_legacy(struct device *dev, struct device_attribute *attr,
>  			const char *buf, size_t count)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
> @@ -714,6 +714,8 @@ store_chassis_clear(struct device *dev,
>  	u32 val;
>  	u8 temp1 = 0, temp2 = 0;
>  
> +	dev_warn(&client->dev, "Attribute chassis_clear is deprecated, "
> +		 "use intrusion0_alarm instead\n");
>  	val = simple_strtoul(buf, NULL, 10);
>  	mutex_lock(&data->update_lock);
>  	data->chassis_clear = SENSORS_LIMIT(val, 0 ,1);
> @@ -726,6 +728,27 @@ store_chassis_clear(struct device *dev,
>  	return count;
>  }
>  
> +static ssize_t
> +store_chassis_clear(struct device *dev, struct device_attribute *attr,
> +			const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct w83792d_data *data = i2c_get_clientdata(client);
> +	unsigned long val;
> +	u8 reg;
> +
> +	if (strict_strtoul(buf, 10, &val) || val != 0)
> +		return -EINVAL;
> +
> +	mutex_lock(&data->update_lock);
> +	reg = w83792d_read_value(client, W83792D_REG_CHASSIS_CLR);
> +	w83792d_write_value(client, W83792D_REG_CHASSIS_CLR, reg | 0x80);
> +	data->chassis = 0;

Same as before - you don't really know if the chassis is now closed.

> +	mutex_unlock(&data->update_lock);
> +
> +	return count;
> +}
> +
>  /* For Smart Fan I / Thermal Cruise */
>  static ssize_t
>  show_thermal_cruise(struct device *dev, struct device_attribute *attr,
> @@ -1012,7 +1035,9 @@ static SENSOR_DEVICE_ATTR(fan5_alarm, S_
>  static SENSOR_DEVICE_ATTR(fan6_alarm, S_IRUGO, show_alarm, NULL, 23);
>  static DEVICE_ATTR(chassis, S_IRUGO, show_regs_chassis, NULL);

I think the "chassis" attribute should be deprecated as well.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
