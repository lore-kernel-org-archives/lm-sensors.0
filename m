From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 19 May 2013 15:04:09 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm90) Drop redundant safety on cache lifetime
Message-Id: <20130519150409.GA20607@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130519165416.3165eb43@endymion.delvare>
In-Reply-To: <20130519165416.3165eb43@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, May 19, 2013 at 04:54:16PM +0200, Jean Delvare wrote:
> time_after (as opposed to time_after_equal) already ensures that the
> cache lifetime is at least as much as requested. There is no point in
> manually adding another jiffy to that value, and this can confuse the
> reader into wrong interpretation.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Imre Deak <imre.deak@intel.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Tested OK on my ADM1032 evaluation board.
> 
>  drivers/hwmon/lm90.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- linux-3.10-rc1.orig/drivers/hwmon/lm90.c	2013-04-29 02:36:01.000000000 +0200
> +++ linux-3.10-rc1/drivers/hwmon/lm90.c	2013-05-19 16:34:07.915505072 +0200
> @@ -470,8 +470,8 @@ static struct lm90_data *lm90_update_dev
>  
>  	mutex_lock(&data->update_lock);
>  
> -	next_update = data->last_updated
> -	  + msecs_to_jiffies(data->update_interval) + 1;
> +	next_update = data->last_updated +
> +		      msecs_to_jiffies(data->update_interval);
>  	if (time_after(jiffies, next_update) || !data->valid) {
>  		u8 h, l;
>  		u8 alarms;
> 
> 
> -- 
> Jean Delvare
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
