From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 20 Apr 2013 08:42:20 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/4] hwmon: (tmp401) Simplification and cleanup
Message-Id: <20130420104220.02faf283@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1365962173-28311-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1365962173-28311-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Sun, 14 Apr 2013 10:56:10 -0700, Guenter Roeck wrote:
> Use two-dimensional array pointing to registers
> Merge temperature and limit access functions into a single function
> Return eror codes from I2C reads

You missed a spelling fix: s/eror/error/.

> Use DIV_ROUND_CLOSEST for rounding operations
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Fix spelling error in commit log, and clarify that only i2c reads
>     return errors
>     Mark unused array entries by using 0 instead of 0x00 for improved
>     readability
>     Fix rounding error when writing critical limit
>     Don't rename reg to regval in store_temp
>     Use local client variable in store_temp
> 
>  drivers/hwmon/tmp401.c |  371 ++++++++++++++++++------------------------------
>  1 file changed, 138 insertions(+), 233 deletions(-)
> 
> diff --git a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
> (...)
> @@ -139,7 +145,7 @@ static int tmp401_register_to_temp(u16 reg, u8 config)
>  	if (config & TMP401_CONFIG_RANGE)
>  		temp -= 64 * 256;
>  
> -	return (temp * 625 + 80) / 160;
> +	return DIV_ROUND_CLOSEST(temp * 125, 32);
>  }
>  
>  static u16 tmp401_temp_to_register(long temp, u8 config)
> @@ -150,134 +156,93 @@ static u16 tmp401_temp_to_register(long temp, u8 config)
>  	} else
>  		temp = clamp_val(temp, 0, 127000);
>  
> -	return (temp * 160 + 312) / 625;
> +	return DIV_ROUND_CLOSEST(temp * 32, 125);
>  }

Note that this does not properly drop the 4 LSBs which are supposed to
be always 0 (not to mention bits 4, 5 and 6 which may also need to be 0
when not using the maximum resolution.) This is not a regression, the
original code has the same flaw. This means two things:

 * When writing the limit value to the chip, for a short time the
   driver may return a higher resolution value, until the next cache
   refresh.

 * Rounding isn't perfect. For example, if you want to set the limit to
   50.060 C degrees, it will compute a register value of 0x320f, which
   once written will be read back as 0x3200 i.e. 50.000 degrees C.
   Proper rounding would lead to register value 0x3210, i.e. 50.063
   degree C.

This certainly isn't a big deal in practice because the cache lifetime
is short and the resolution is such that the maximum error is small.
But it would become more of a problem if we ever let the user choose a
lesser resolution. And the fix is so easy that I see no good reason not
to implement it right:

	return DIV_ROUND_CLOSEST(temp * 2, 125) << 4;

> (...)
> -static ssize_t store_temp_max(struct device *dev, struct device_attribute
> -	*devattr, const char *buf, size_t count)
> +static ssize_t store_temp(struct device *dev, struct device_attribute *devattr,
> +			  const char *buf, size_t count)
>  {
> -	int index = to_sensor_dev_attr(devattr)->index;
> +	int nr = to_sensor_dev_attr_2(devattr)->nr;
> +	int index = to_sensor_dev_attr_2(devattr)->index;
> +	struct i2c_client *client = to_i2c_client(dev);
>  	struct tmp401_data *data = tmp401_update_device(dev);
>  	long val;
>  	u16 reg;
>  
> -	if (kstrtol(buf, 10, &val))
> -		return -EINVAL;
> -
> -	reg = tmp401_temp_to_register(val, data->config);
> -
> -	mutex_lock(&data->update_lock);
> -
> -	i2c_smbus_write_byte_data(to_i2c_client(dev),
> -		TMP401_TEMP_HIGH_LIMIT_MSB_WRITE[index], reg >> 8);
> -	i2c_smbus_write_byte_data(to_i2c_client(dev),
> -		TMP401_TEMP_HIGH_LIMIT_LSB[index], reg & 0xFF);
> -
> -	data->temp_high[index] = reg;
> -
> -	mutex_unlock(&data->update_lock);
> -
> -	return count;
> -}
> -
> -static ssize_t store_temp_crit(struct device *dev, struct device_attribute
> -	*devattr, const char *buf, size_t count)
> -{
> -	int index = to_sensor_dev_attr(devattr)->index;
> -	struct tmp401_data *data = tmp401_update_device(dev);
> -	long val;
> -	u8 reg;
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
>  
>  	if (kstrtol(buf, 10, &val))
>  		return -EINVAL;
>  
> -	reg = tmp401_crit_temp_to_register(val, data->config);
> +	reg = tmp401_temp_to_register(val, data->config);
> +	if (nr = 3)	/* drop LSB for critical limit */
> +		reg = (reg + 127) & 0xff00;

Almost there, but not quite yet. For example if I set the limit to
50.500 degree C, it is rounded to 50.000 degrees C instead of 51.000
degrees C. That's because you add 127 instead of the expected (1 <<
8) / 2) = 128. But anyway, after fixing tmp401_temp_to_register() as
suggested above, this approach will break, as you always loose accuracy
from two consecutive rounding operations compared to rounding directly
to what you need. 

So I'm afraid you'll have to reintroduce
tmp401_crit_temp_to_register(), or add a resolution parameter to
tmp401_temp_to_register(). This might be needed later if we want to let
the user choose the resolution.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
