From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 18 Jul 2014 22:00:34 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (smsc47m192) Fix temperature limit and vrm write operations
Message-Id: <20140719000034.7ad72d96@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1405710714-6445-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1405710714-6445-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 18 Jul 2014 12:11:54 -0700, Guenter Roeck wrote:
> Temperature limit clamps are applied after converting the temperature
> from milli-degrees C to degrees C, so either the clamp limit needs
> to be specified in degrees C, not milli-degrees C, or clamping must
> happen before converting to degrees C. Use the latter method to avoid
> overflows.
> 
> vrm is an u8, so the written value needs to be limited to [0, 255].
> 
> Cc: Axel Lin <axel.lin@ingics.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Clamp temperature limit first, then scale, to avoid overflows
>     Don't clamp vrm but return an error if it is out of range.
>     Fix typo in description
> 
>  drivers/hwmon/smsc47m192.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/smsc47m192.c b/drivers/hwmon/smsc47m192.c
> index efee4c5..34b9a60 100644
> --- a/drivers/hwmon/smsc47m192.c
> +++ b/drivers/hwmon/smsc47m192.c
> @@ -86,7 +86,7 @@ static inline u8 IN_TO_REG(unsigned long val, int n)
>   */
>  static inline s8 TEMP_TO_REG(int val)
>  {
> -	return clamp_val(SCALE(val, 1, 1000), -128000, 127000);
> +	return SCALE(clamp_val(val, -128000, 127000), 1, 1000);
>  }
>  
>  static inline int TEMP_FROM_REG(s8 val)
> @@ -384,6 +384,8 @@ static ssize_t set_vrm(struct device *dev, struct device_attribute *attr,
>  	err = kstrtoul(buf, 10, &val);
>  	if (err)
>  		return err;
> +	if (val > 255)
> +		return -EINVAL;
>  
>  	data->vrm = val;
>  	return count;

Looks good.

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
