From: Randy Dunlap <rdunlap@infradead.org>
Date: Tue, 07 Jan 2014 18:06:47 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/sensors: fix SENSORS_LM75 dependencies
Message-Id: <52CC4237.5000704@infradead.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140106204020.b47e53cc3ead8f90164ef5b7@canb.auug.org.au>	<52CB0948.6030702@infradead.org>	<20140106203209.GA21630@roeck-us.net>	<52CB53DC.4030901@infradead.org>	<52CB65DA.2010103@roeck-us.net>	<20140107130401.23bffcd2@endymion.delvare>	<52CBF1CF.2000603@ti.com> <20140107152148.36768345@endymion.delvare>
In-Reply-To: <20140107152148.36768345@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>, Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Frodo Looijaard <frodol@dds.nl>, lm-sensors@lm-sensors.org, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org

On 01/07/14 06:21, Jean Delvare wrote:
> Hi Eduardo,
> 

> I suppose this works, however I believe there is value in allowing for
> modular building of as much code as possible.

ack, yes, please.

> I have an alternative proposal, which lets thermal be built as module,
> and hopefully also addresses the issue (I can't test...) The only
> drawback is that the same dependency must be added for every other
> hwmon driver which optionally uses THERMAL_OF.
> 
> From: Jean Delvare <khali@linux-fr.org>
> 
> Based on an earlier attempt by Randy Dunlap.
> 
> Fix SENSORS_LM75 dependencies to eliminate build errors:
> 
> drivers/built-in.o: In function `lm75_remove':
> lm75.c:(.text+0x12bd8c): undefined reference to `thermal_zone_of_sensor_unregister'
> drivers/built-in.o: In function `lm75_probe':
> lm75.c:(.text+0x12c123): undefined reference to `thermal_zone_of_sensor_register'
> 
> Add depends on THERMAL since that is what provides the
> register/unregister functions above, but only if THERMAL_OF was
> selected as this is an optional feature of the driver.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Eduardo Valentin <eduardo.valentin@ti.com>

works for me.

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/hwmon/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-3.13-rc7.orig/drivers/hwmon/Kconfig	2014-01-07 09:01:24.812848091 +0100
> +++ linux-3.13-rc7/drivers/hwmon/Kconfig	2014-01-07 15:19:11.039472329 +0100
> @@ -650,6 +650,7 @@ config SENSORS_LM73
>  config SENSORS_LM75
>  	tristate "National Semiconductor LM75 and compatibles"
>  	depends on I2C
> +	depends on THERMAL || !THERMAL_OF
>  	help
>  	  If you say yes here you get support for one common type of
>  	  temperature sensor chip, with models including:
> 
> 


-- 
~Randy

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
