From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 19 Dec 2012 14:58:31 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (emc6w201) Fix DIV_ROUND_CLOSEST problem with unsigned divisors
Message-Id: <20121219155831.701e7f6a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1355928244-2677-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1355928244-2677-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 19 Dec 2012 06:44:04 -0800, Guenter Roeck wrote:
> Result of DIV_ROUND_CLOSEST is undefined for negative dividends if the divisor
> variable type is unsigned. Fix by declaring dividend as unsigned.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/emc6w201.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/emc6w201.c b/drivers/hwmon/emc6w201.c
> index a98c917..c450c7d 100644
> --- a/drivers/hwmon/emc6w201.c
> +++ b/drivers/hwmon/emc6w201.c
> @@ -208,10 +208,10 @@ static ssize_t set_in(struct device *dev, struct device_attribute *devattr,
>  	int sf = to_sensor_dev_attr_2(devattr)->index;
>  	int nr = to_sensor_dev_attr_2(devattr)->nr;
>  	int err;
> -	long val;
> +	unsigned long val;
>  	u8 reg;
>  
> -	err = kstrtol(buf, 10, &val);
> +	err = kstrtoul(buf, 10, &val);
>  	if (err < 0)
>  		return err;
>  

Nack, sorry. Negative voltage input values must be supported (and
clamped to 0 if needs be). Rationale: the value written can result from
applying a compute formula, so the user may not even realize he/she is
trying to write a negative value.

Just change the type of nominal_mv to s16 or even int?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
