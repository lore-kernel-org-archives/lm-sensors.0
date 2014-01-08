From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 08 Jan 2014 13:49:56 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Fix SENSORS_TMP102 dependencies to eliminate build errors
Message-Id: <52CD5784.4060804@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140108080557.3439ec23@endymion.delvare>
In-Reply-To: <20140108080557.3439ec23@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>, Eduardo Valentin <eduardo.valentin@ti.com>, Zhang Rui <rui.zhang@intel.com>
Cc: LM Sensors <lm-sensors@lm-sensors.org>, linux-pm@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>

On 01/07/2014 11:05 PM, Jean Delvare wrote:
> Similar to what was done for the lm75 driver.
>
> Add depends on THERMAL since that is what provides the
> register/unregister functions above, but only if THERMAL_OF was
> selected as this is an optional feature of the driver.
>
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Eduardo Valentin <eduardo.valentin@ti.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/hwmon/Kconfig |    1 +
>   1 file changed, 1 insertion(+)
>
> --- linux-3.13-rc7.orig/drivers/hwmon/Kconfig	2014-01-08 08:00:58.583072658 +0100
> +++ linux-3.13-rc7/drivers/hwmon/Kconfig	2014-01-08 08:01:36.928977997 +0100
> @@ -1285,6 +1285,7 @@ config SENSORS_THMC50
>   config SENSORS_TMP102
>   	tristate "Texas Instruments TMP102"
>   	depends on I2C
> +	depends on THERMAL || !THERMAL_OF
>   	help
>   	  If you say yes here you get support for Texas Instruments TMP102
>   	  sensor chips.
>
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
