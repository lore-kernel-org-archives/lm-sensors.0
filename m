From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 10 Jul 2011 15:12:41 +0000
Subject: Re: [lm-sensors] [PATCH v4] hwmon: (lm95241) Fix negative
Message-Id: <20110710171241.323f6d7f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 9 Jul 2011 14:21:45 -0700, Guenter Roeck wrote:
> Negative temperatures were returned in degrees C instead of milli-Degrees C.
> Also, negative temperatures were reported for remote temperature sensors even
> if the chip was configured for positive-only results.
> 
> Fix by detecting temperature modes, and by treating negative temperatures
> similar to positive temperatures, with appropriate sign extension.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
> v4: Improve readability and convert table index to bit mask

Acked-by: Jean Delvare <khali@linux-fr.org>

> 
>  drivers/hwmon/lm95241.c |   20 ++++++++++++++------
>  1 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwmon/lm95241.c b/drivers/hwmon/lm95241.c
> index 01c638e..d3b464b 100644
> --- a/drivers/hwmon/lm95241.c
> +++ b/drivers/hwmon/lm95241.c
> @@ -98,11 +98,16 @@ struct lm95241_data {
>  };
>  
>  /* Conversions */
> -static int TempFromReg(u8 val_h, u8 val_l)
> +static int temp_from_reg_signed(u8 val_h, u8 val_l)
>  {
> -	if (val_h & 0x80)
> -		return val_h - 0x100;
> -	return val_h * 1000 + val_l * 1000 / 256;
> +	s16 val_hl = (val_h << 8) | val_l;
> +	return val_hl * 1000 / 256;
> +}
> +
> +static int temp_from_reg_unsigned(u8 val_h, u8 val_l)
> +{
> +	u16 val_hl = (val_h << 8) | val_l;
> +	return val_hl * 1000 / 256;
>  }
>  
>  static struct lm95241_data *lm95241_update_device(struct device *dev)
> @@ -135,10 +140,13 @@ static ssize_t show_input(struct device *dev, struct device_attribute *attr,
>  			  char *buf)
>  {
>  	struct lm95241_data *data = lm95241_update_device(dev);
> +	int index = to_sensor_dev_attr(attr)->index;
>  
>  	return snprintf(buf, PAGE_SIZE - 1, "%d\n",
> -		TempFromReg(data->temp[to_sensor_dev_attr(attr)->index],
> -			    data->temp[to_sensor_dev_attr(attr)->index + 1]));
> +			index = 0 || (data->config & (1 << (index / 2))) ?
> +		temp_from_reg_signed(data->temp[index], data->temp[index + 1]) :
> +		temp_from_reg_unsigned(data->temp[index],
> +				       data->temp[index + 1]));
>  }
>  
>  static ssize_t show_type(struct device *dev, struct device_attribute *attr,


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
