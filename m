From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 19 Apr 2013 06:05:08 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] Add support for GMT G72/G763 PWM fan controller
Message-Id: <20130419080508.4866db90@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1366322287.git.arno@natisbad.org>
	<4f4a821bbc61e2da28fd70553fd717ada255097d.1366322287.git.arno@natisbad.org>
In-Reply-To: <4f4a821bbc61e2da28fd70553fd717ada255097d.1366322287.git.arno@natisbad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnaud Ebalard <arno@natisbad.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, lm-sensors@lm-sensors.org, devicetree-discuss@lists.ozlabs.org, Rob Landley <rob@landley.net>, linux-doc@vger.kernel.org, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Simon Guinot <simon.guinot@sequanux.org>, Olivier Mouchet <olivier.mouchet@gmail.com>

Hi Arnaud,

Just a few things I noticed...

Typo in subject line: G762, not G72.

On Fri, 19 Apr 2013 00:28:21 +0200, Arnaud Ebalard wrote:
> 
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
> Tested-by: Arnaud Ebalard <arno@natisbad.org>
> ---
>  drivers/hwmon/Kconfig  |   10 +
>  drivers/hwmon/Makefile |    1 +
>  drivers/hwmon/g762.c   | 1159 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1170 insertions(+)
>  create mode 100644 drivers/hwmon/g762.c
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 89ac1cb..0c6ddee 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -423,6 +423,16 @@ config SENSORS_G760A
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called g760a.
>  
> +config SENSORS_G762
> +	tristate "GMT G762"
> +	depends on I2C
> +	help
> +	  If you say yes here you get support for Global Mixed-mode
> +	  Technology Inc G762 fan speed PWM controller chips.

If your driver also supports the G763 it should be mentioned here.

> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called g762a.

This is not how your driver is actually named.

> +
>  config SENSORS_GL518SM
>  	tristate "Genesys Logic GL518SM"
>  	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 8d6d97e..4b49504 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -57,6 +57,7 @@ obj-$(CONFIG_SENSORS_F75375S)	+= f75375s.o
>  obj-$(CONFIG_SENSORS_FAM15H_POWER) += fam15h_power.o
>  obj-$(CONFIG_SENSORS_FSCHMD)	+= fschmd.o
>  obj-$(CONFIG_SENSORS_G760A)	+= g760a.o
> +obj-$(CONFIG_SENSORS_G762)	+= g762.o
>  obj-$(CONFIG_SENSORS_GL518SM)	+= gl518sm.o
>  obj-$(CONFIG_SENSORS_GL520SM)	+= gl520sm.o
>  obj-$(CONFIG_SENSORS_GPIO_FAN)	+= gpio-fan.o
> diff --git a/drivers/hwmon/g762.c b/drivers/hwmon/g762.c
> new file mode 100644
> index 0000000..8c4cb39
> --- /dev/null
> +++ b/drivers/hwmon/g762.c
> (...)
> +#define DRVNAME "g762"
> +
> +static const struct i2c_device_id g762_id[] = {
> +	{ DRVNAME, 0 },

No, this is a list of device names, nor driver names, so the use of
DRVNAME is inappropriate. Also, again, if your driver supports the g763
it should be listed here too.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, g762_id);

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
