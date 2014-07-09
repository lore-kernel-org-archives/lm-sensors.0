From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 09 Jul 2014 17:10:31 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: gpio-fan: Change name passed to hwmon_device_register_with_groups
Message-Id: <20140709171031.GA25748@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1404917613-4467-1-git-send-email-k.debski@samsung.com>
In-Reply-To: <1404917613-4467-1-git-send-email-k.debski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kamil Debski <k.debski@samsung.com>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, sguinot@lacie.com, t.figa@samsung.com, m.szyprowski@samsung.com

On Wed, Jul 09, 2014 at 04:53:32PM +0200, Kamil Debski wrote:
> Commit 648cd48c9e566f53c5df30d79857e0937ae13b09 (hwmon: Do not accept
> invalid name attributes) added check for "-" in the name of hwmon device.
> This patch changes the name supplied by gpio-fan so that it is accepted
> by hwmon.
> 
> Signed-off-by: Kamil Debski <k.debski@samsung.com>
> ---
>  drivers/hwmon/gpio-fan.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
> index ba35e4d..5acd555 100644
> --- a/drivers/hwmon/gpio-fan.c
> +++ b/drivers/hwmon/gpio-fan.c
> @@ -538,7 +538,7 @@ static int gpio_fan_probe(struct platform_device *pdev)
>  
>  	/* Make this driver part of hwmon class. */
>  	fan_data->hwmon_dev = hwmon_device_register_with_groups(&pdev->dev,
> -						"gpio-fan", fan_data,
> +						"gpiofan", fan_data,

This has already been changed to "gpio_fan" in the latest kernel.
See commit d26e0da78 (hwmon: (gpio-fan) Change name used in
hwmon_device_register_with_groups).

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
