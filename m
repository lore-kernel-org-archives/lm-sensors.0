From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 19 Oct 2011 16:42:25 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] hwmon/abx500: add hwmon notifications
Message-Id: <20111019164225.GD2264@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1318929051-15880-1-git-send-email-linus.walleij@stericsson.com>
In-Reply-To: <1318929051-15880-1-git-send-email-linus.walleij@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Oct 18, 2011 at 05:10:51AM -0400, Linus Walleij wrote:
> From: Daniel Willerud <daniel.willerud@stericsson.com>
> 
> We have drivers that need to be notified about critical
> temperatures, so add notifiers using the hwmon notification
> mechanism.
> 
> Signed-off-by: Daniel Willerud <daniel.willerud@stericsson.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/hwmon/ab8500.c |    1 +
>  drivers/hwmon/abx500.c |    1 +
>  2 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hwmon/ab8500.c b/drivers/hwmon/ab8500.c
> index e0b1f48..03be29e 100644
> --- a/drivers/hwmon/ab8500.c
> +++ b/drivers/hwmon/ab8500.c
> @@ -127,6 +127,7 @@ static int ab8500_temp_irq_handler(int irq, struct abx500_temp *data)
>  	data->crit_alarm[4] = 1;
>  	mutex_unlock(&data->lock);
>  
> +	hwmon_notify(data->crit_alarm[4], NULL);

The definition and use of this notifier makes it pretty worthless outside the scope 
of this driver. What if some other driver registers a notifier and sends a similar
notification with "1, NULL" as parameters ? How would any listener know what to do with it ?

Guenter

>  	sysfs_notify(&data->pdev->dev.kobj, NULL, "temp5_crit_alarm");
>  	dev_info(&data->pdev->dev, "AB8500 thermal warning,"
>  		" power off in %lu s\n", data->power_off_delay);
> diff --git a/drivers/hwmon/abx500.c b/drivers/hwmon/abx500.c
> index b9c8810..b26a13e 100644
> --- a/drivers/hwmon/abx500.c
> +++ b/drivers/hwmon/abx500.c
> @@ -163,6 +163,7 @@ static void gpadc_monitor(struct work_struct *work)
>  					ret);
>  				break;
>  			}
> +			hwmon_notify(data->max_alarm[i], NULL);

Same here. Any listener will be quite clueless about what actually happened.

This will need more thought; we can not add an API with such limited value.

>  			sysfs_notify(&data->pdev->dev.kobj, NULL, alarm_node);
>  		}
>  		if (updated_max_hyst_alarm) {
> -- 
> 1.7.3.2
> 

-- 
Guenter Roeck
Distinguished Engineer
PDU IP Systems

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
