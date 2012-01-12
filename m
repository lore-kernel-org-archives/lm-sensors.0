From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 12 Jan 2012 20:52:14 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm90) Add range check to set_update_interval
Message-Id: <20120112215214.16ea1e83@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1326333305-11082-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1326333305-11082-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 11 Jan 2012 17:55:05 -0800, Guenter Roeck wrote:
> When writing the update_interval attribute, the parameter value was not range
> checked, which could cause an integer overflow and result in an arbitrary
> update interval. Fix by limiting the value range to <0, 100000>.
> 
> Reported-by: Jean Delvare <khali@linux-fr.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/lm90.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
> index bdfd675..d2dd5f9 100644
> --- a/drivers/hwmon/lm90.c
> +++ b/drivers/hwmon/lm90.c
> @@ -917,7 +917,7 @@ static ssize_t set_update_interval(struct device *dev,
>  		return err;
>  
>  	mutex_lock(&data->update_lock);
> -	lm90_set_convrate(client, data, val);
> +	lm90_set_convrate(client, data, SENSORS_LIMIT(val, 0, 100000));
>  	mutex_unlock(&data->update_lock);
>  
>  	return count;

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
