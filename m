From: Jean Delvare <jdelvare@suse.de>
Date: Tue, 18 Feb 2014 21:39:56 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon: (max1668) Fix writing the minimum temperature
Message-Id: <20140218223956.39f14be0@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392516481-16548-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1392516481-16548-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 15 Feb 2014 18:07:59 -0800, Guenter Roeck wrote:
> When trying to set the minimum temperature, the driver was erroneously
> writing the maximum temperature into the chip.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Candidate for -stable.
> 
>  drivers/hwmon/max1668.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/max1668.c b/drivers/hwmon/max1668.c
> index a762635..029b65e 100644
> --- a/drivers/hwmon/max1668.c
> +++ b/drivers/hwmon/max1668.c
> @@ -243,7 +243,7 @@ static ssize_t set_temp_min(struct device *dev,
>  	data->temp_min[index] = clamp_val(temp/1000, -128, 127);
>  	if (i2c_smbus_write_byte_data(client,
>  					MAX1668_REG_LIML_WR(index),
> -					data->temp_max[index]))
> +					data->temp_min[index]))
>  		count = -EIO;
>  	mutex_unlock(&data->update_lock);
>  

Huh, bad bug, good catch.

Definitely good for -stable, even though it may not be the most popular
hwmon driver.

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
