From: Jean Delvare <jdelvare@suse.de>
Date: Sun, 18 May 2014 10:17:24 +0000
Subject: Re: [lm-sensors] [PATCH 6/9] hwmon: (emc1403) Relax hysteresis limit write checks
Message-Id: <20140518121724.69b74063@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1399921311-9524-7-git-send-email-linux@roeck-us.net>
In-Reply-To: <1399921311-9524-7-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 12 May 2014 12:01:48 -0700, Guenter Roeck wrote:
> Writing the hysteresis limit returned -ERANGE if the written hysteresis
> was too high or too low. Relax error check and adjust the hysteresis
> value to its valid range.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/emc1403.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/hwmon/emc1403.c b/drivers/hwmon/emc1403.c
> index 877144c..13cac04 100644
> --- a/drivers/hwmon/emc1403.c
> +++ b/drivers/hwmon/emc1403.c
> @@ -147,12 +147,7 @@ static ssize_t store_hyst(struct device *dev,
>  		goto fail;
>  
>  	hyst = limit * 1000 - val;
> -	hyst = DIV_ROUND_CLOSEST(hyst, 1000);
> -	if (hyst < 0 || hyst > 255) {
> -		retval = -ERANGE;
> -		goto fail;
> -	}
> -
> +	hyst = clamp_val(DIV_ROUND_CLOSEST(hyst, 1000), 0, 255);
>  	retval = regmap_write(regmap, 0x21, hyst);
>  	if (retval = 0)
>  		retval = count;

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
