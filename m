From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 18 Jul 2014 18:52:12 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (smsc47m192) Fix temperature limit and vrm write operations
Message-Id: <20140718205212.7c3ca0c8@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1405694121-5670-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1405694121-5670-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Fri, 18 Jul 2014 07:35:21 -0700, Guenter Roeck wrote:
> Temperature limit clamps are applied after converting the temeprature
> from milli-degrees C to degrees C, so the clamp limit needs to be
> specified in degrees C, not milli-degrees C.
> 
> vrm is an u8, so the written value needs to be clamped to [0, 255].

I'd rather reject out-of-range VRM values. These are discrete values,
not continuous, so clamping makes no sense.

> Cc: Axel Lin <axel.lin@ingics.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/smsc47m192.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/smsc47m192.c b/drivers/hwmon/smsc47m192.c
> index efee4c5..e34918a 100644
> --- a/drivers/hwmon/smsc47m192.c
> +++ b/drivers/hwmon/smsc47m192.c
> @@ -86,7 +86,7 @@ static inline u8 IN_TO_REG(unsigned long val, int n)
>   */
>  static inline s8 TEMP_TO_REG(int val)
>  {
> -	return clamp_val(SCALE(val, 1, 1000), -128000, 127000);
> +	return clamp_val(SCALE(val, 1, 1000), -128, 127);
>  }

SCALE could overflow on large values. It would be safer to clamp first
and then scale.

>  
>  static inline int TEMP_FROM_REG(s8 val)
> @@ -385,7 +385,7 @@ static ssize_t set_vrm(struct device *dev, struct device_attribute *attr,
>  	if (err)
>  		return err;
>  
> -	data->vrm = val;
> +	data->vrm = clamp_val(val, 0, 255);
>  	return count;
>  }
>  static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm);


-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
