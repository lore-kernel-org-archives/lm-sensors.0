From: Jean Delvare <jdelvare@suse.de>
Date: Tue, 18 Feb 2014 21:44:50 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] hwmon: (max1668) Don't hide return value from i2c_smbus_write_byte_data
Message-Id: <20140218224450.1bb0fd40@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392516481-16548-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1392516481-16548-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 15 Feb 2014 18:08:00 -0800, Guenter Roeck wrote:
> i2c_smbus_write_byte_data returns a valid error code.
> Return it to the user instead of replacing it with -EIO.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/max1668.c |   14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwmon/max1668.c b/drivers/hwmon/max1668.c
> index 029b65e..bbbe340 100644
> --- a/drivers/hwmon/max1668.c
> +++ b/drivers/hwmon/max1668.c
> @@ -216,10 +216,11 @@ static ssize_t set_temp_max(struct device *dev,
>  
>  	mutex_lock(&data->update_lock);
>  	data->temp_max[index] = clamp_val(temp/1000, -128, 127);
> -	if (i2c_smbus_write_byte_data(client,
> +	ret = i2c_smbus_write_byte_data(client,
>  					MAX1668_REG_LIMH_WR(index),
> -					data->temp_max[index]))
> -		count = -EIO;
> +					data->temp_max[index]);
> +	if (ret < 0)
> +		count = ret;
>  	mutex_unlock(&data->update_lock);
>  
>  	return count;
> @@ -241,10 +242,11 @@ static ssize_t set_temp_min(struct device *dev,
>  
>  	mutex_lock(&data->update_lock);
>  	data->temp_min[index] = clamp_val(temp/1000, -128, 127);
> -	if (i2c_smbus_write_byte_data(client,
> +	ret = i2c_smbus_write_byte_data(client,
>  					MAX1668_REG_LIML_WR(index),
> -					data->temp_min[index]))
> -		count = -EIO;
> +					data->temp_min[index]);
> +	if (ret < 0)
> +		count = ret;
>  	mutex_unlock(&data->update_lock);
>  
>  	return count;

Good change.

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
