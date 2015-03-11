From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 11 Mar 2015 02:14:19 +0000
Subject: Re: [lm-sensors] [PATCH -next] hwmon: fix gpio-fan.c build
Message-Id: <54FFA4FB.80007@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <54FF8171.9080101@infradead.org>
In-Reply-To: <54FF8171.9080101@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap@infradead.org>, LKML <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org
Cc: Jean Delvare <jdelvare@suse.de>, Simon Guinot <sguinot@lacie.com>

On 03/10/2015 04:42 PM, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix build error when CONFIG_THERMAL=m and SENSORS_GPIO_FAN=y
> by preventing that combination.
>
> Fixes these build errors:
>
> drivers/built-in.o: In function `gpio_fan_remove':
> gpio-fan.c:(.text+0x21e97e): undefined reference to `thermal_cooling_device_unregister'
> drivers/built-in.o: In function `gpio_fan_probe':
> gpio-fan.c:(.text+0x21efbc): undefined reference to `thermal_cooling_device_register'
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc:	Jean Delvare <jdelvare@suse.de>
> Cc:	Guenter Roeck <linux@roeck-us.net>
> Cc:	lm-sensors@lm-sensors.org
> Cc:	Simon Guinot <sguinot@lacie.com>
> ---
>   drivers/hwmon/Kconfig |    1 +
>   1 file changed, 1 insertion(+)
>
> --- linux-next-20150310.orig/drivers/hwmon/Kconfig
> +++ linux-next-20150310/drivers/hwmon/Kconfig
> @@ -510,6 +510,7 @@ config SENSORS_G762
>   config SENSORS_GPIO_FAN
>   	tristate "GPIO fan"
>   	depends on GPIOLIB
> +	depends on THERMAL || THERMAL=n
>   	help
>   	  If you say yes here you get support for fans connected to GPIO lines.
>
>
Applied, thanks.

I really have to add that combination to my build tests :-(

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
