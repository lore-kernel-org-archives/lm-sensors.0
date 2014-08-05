From: Jean Delvare <jdelvare@suse.de>
Date: Tue, 05 Aug 2014 20:10:37 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (emc6w201) Fix temperature limit range
Message-Id: <20140805221037.6649f318@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1407266335-28244-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1407266335-28244-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue,  5 Aug 2014 12:18:55 -0700, Guenter Roeck wrote:
> Temperature limit range is [-127, 127], not [-127, 128].
> The wrong range caused a bad limit to be written into the chip
> if the limit was set to a value of 128 degrees C or above.
> 
> Also use DIV_ROUND_CLOSEST instead of a plan divide operation
> to reduce the rounding error when writing temperature limits.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Correct temperature range is [-127, 127]; -128 indicates an error.
> 
>  drivers/hwmon/emc6w201.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/emc6w201.c b/drivers/hwmon/emc6w201.c
> index e87da90..ada9071 100644
> --- a/drivers/hwmon/emc6w201.c
> +++ b/drivers/hwmon/emc6w201.c
> @@ -252,12 +252,12 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *devattr,
>  	if (err < 0)
>  		return err;
>  
> -	val /= 1000;
> +	val = DIV_ROUND_CLOSEST(val, 1000);
>  	reg = (sf = min) ? EMC6W201_REG_TEMP_LOW(nr)
>  			  : EMC6W201_REG_TEMP_HIGH(nr);
>  
>  	mutex_lock(&data->update_lock);
> -	data->temp[sf][nr] = clamp_val(val, -127, 128);
> +	data->temp[sf][nr] = clamp_val(val, -127, 127);
>  	err = emc6w201_write8(client, reg, data->temp[sf][nr]);
>  	mutex_unlock(&data->update_lock);
>  

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
