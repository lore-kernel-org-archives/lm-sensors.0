From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 12 Oct 2012 09:19:47 +0000
Subject: Re: [lm-sensors] [PATCH 3/5] hwmon: (coretemp) Drop N4xx, N5xx, D4xx, D5xx CPUs from tjmax table
Message-Id: <20121012111947.31a47ae2@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1349816943-17697-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1349816943-17697-4-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue,  9 Oct 2012 14:09:01 -0700, Guenter Roeck wrote:
> Since N4xx, N5xx, D4xx, and D5xx are now reliably detected using the model ID
> and the stepping/mask, drop the respective entries from tjmax_table.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/coretemp.c |    8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index 7107096..96ab10c 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -196,14 +196,6 @@ struct tjmax {
>  };
>  
>  static const struct tjmax __cpuinitconst tjmax_table[] = {
> -	{ "CPU D410", 100000 },
> -	{ "CPU D425", 100000 },
> -	{ "CPU D510", 100000 },
> -	{ "CPU D525", 100000 },
> -	{ "CPU N450", 100000 },
> -	{ "CPU N455", 100000 },
> -	{ "CPU N470", 100000 },
> -	{ "CPU N475", 100000 },
>  	{ "CPU  230", 100000 },
>  	{ "CPU  330", 125000 },
>  };

Great, matching by model is certainly faster.

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
