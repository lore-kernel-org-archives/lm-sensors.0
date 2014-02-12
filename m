From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 12 Feb 2014 08:40:59 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (emc2103) Return error from i2c_smbus_read_byte_data
Message-Id: <20140212094059.47698895@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392184009-5683-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1392184009-5683-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 11 Feb 2014 21:46:48 -0800, Guenter Roeck wrote:
> There is no reason to replace one error with another.
> 
> smatch message:
> drivers/hwmon/emc2103.c:352 set_fan_div() info: why not propagate 'status'
> from i2c_smbus_read_byte_data() instead of (-5)?
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/emc2103.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/emc2103.c b/drivers/hwmon/emc2103.c
> index 2c137b2..fd892dd 100644
> --- a/drivers/hwmon/emc2103.c
> +++ b/drivers/hwmon/emc2103.c
> @@ -349,7 +349,7 @@ static ssize_t set_fan_div(struct device *dev, struct device_attribute *da,
>  		dev_dbg(&client->dev, "reg 0x%02x, err %d\n",
>  			REG_FAN_CONF1, status);
>  		mutex_unlock(&data->update_lock);
> -		return -EIO;
> +		return status;
>  	}
>  	status &= 0x9F;
>  	status |= (new_range_bits << 5);

Good catch.

Reviewed-by: Jean Delvare <jdelvare@suse.de>


-- 
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
