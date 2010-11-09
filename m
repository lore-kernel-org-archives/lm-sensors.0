From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 09 Nov 2010 08:01:47 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (gpio-fan) Fix fan_ctrl_init error
Message-Id: <20101109090147.155dd1e9@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1289279919.14461.7.camel@mola>
In-Reply-To: <1289279919.14461.7.camel@mola>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Guenter Roeck <guenter.roeck@ericsson.com>, Simon Guinot <sguinot@lacie.com>, lm-sensors@lm-sensors.org

On Tue, 09 Nov 2010 13:18:39 +0800, Axel Lin wrote:
> Remove sysfs entries before return -ENODEV.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  drivers/hwmon/gpio-fan.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
> index aa701a1..d2e66b4 100644
> --- a/drivers/hwmon/gpio-fan.c
> +++ b/drivers/hwmon/gpio-fan.c
> @@ -388,11 +388,13 @@ static int fan_ctrl_init(struct gpio_fan_data *fan_data,
>  	fan_data->speed_index = get_fan_speed_index(fan_data);
>  	if (fan_data->speed_index < 0) {
>  		err = -ENODEV;
> -		goto err_free_gpio;
> +		goto err_remove_sysfs;
>  	}
>  
>  	return 0;
>  
> +err_remove_sysfs:
> +	sysfs_remove_group(&pdev->dev.kobj, &gpio_fan_ctrl_group);
>  err_free_gpio:
>  	for (i = i - 1; i >= 0; i--)
>  		gpio_free(ctrl[i]);

Oh, and while you're here, fan_alarm_init() needs some love as well.
There's a "return 0" in the middle which clearly can't be correct.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
