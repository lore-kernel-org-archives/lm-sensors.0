From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 16 Jan 2012 19:38:56 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (pmbus) Replace strict_strtol with kstrtol
Message-Id: <20120116203856.4b67f733@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1326737807-14774-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1326737807-14774-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 16 Jan 2012 10:16:47 -0800, Guenter Roeck wrote:
> strict_strtol is deprecated and results in a checkpatch warning.
> Replace it with kstrtol.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/pmbus/pmbus_core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 00460d8..b31f461 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -781,7 +781,7 @@ static ssize_t pmbus_set_sensor(struct device *dev,
>  	int ret;
>  	u16 regval;
>  
> -	if (strict_strtol(buf, 10, &val) < 0)
> +	if (kstrtol(buf, 10, &val) < 0)
>  		return -EINVAL;
>  
>  	mutex_lock(&data->update_lock);

Obviously correct.

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
