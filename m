From: Randy Dunlap <rdunlap@xenotime.net>
Date: Fri, 28 Jan 2011 16:42:42 +0000
Subject: Re: [lm-sensors] [PATCH v3 1/5] hwmon: PMBus device driver
Message-Id: <20110128084242.8eee8088.rdunlap@xenotime.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1296182192-28562-2-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1296182192-28562-2-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 27 Jan 2011 18:36:28 -0800 Guenter Roeck wrote:

> This driver adds support for hardware monitoring features of various PMBus
> devices.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
>  drivers/hwmon/Kconfig      |   25 +
>  drivers/hwmon/Makefile     |    4 +
>  drivers/hwmon/pmbus.c      |  234 +++++++
>  drivers/hwmon/pmbus.h      |  307 +++++++++
>  drivers/hwmon/pmbus_core.c | 1611 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/i2c/pmbus.h  |   45 ++
>  6 files changed, 2226 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/hwmon/pmbus.c
>  create mode 100644 drivers/hwmon/pmbus.h
>  create mode 100644 drivers/hwmon/pmbus_core.c
>  create mode 100644 include/linux/i2c/pmbus.h
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 773e484..7c36091 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -734,6 +734,31 @@ config SENSORS_PCF8591
>  	  These devices are hard to detect and rarely found on mainstream
>  	  hardware.  If unsure, say N.
>  
> +config PMBUS
> +	tristate "PMBus support"
> +	depends on I2C && EXPERIMENTAL
> +	default n
> +	help
> +	  If you say yes here to enable PMBus support.

	  Say Yes here if you want to enable PMBus support.

> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called pmbus_core.
> +
> +if PMBUS
> +
> +config SENSORS_PMBUS
> +	tristate "Generic PMBus devices"
> +	default n
> +	help
> +	  If you say yes here you get hardware monitoring support for generic
> +	  PMBus devices, including but not limited to BMR450, BMR451, BMR453,
> +	  BMR454, and LTC2978.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called pmbus.
> +
> +endif # PMBUS
> +
>  config SENSORS_SHT15
>  	tristate "Sensiron humidity and temperature sensors. SHT15 and compat."
>  	depends on GENERIC_GPIO


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
