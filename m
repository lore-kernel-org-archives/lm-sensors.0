From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:14 +0000
Subject: Call for testers: Kernel connector update, SuperIO update.
Message-Id: <20040909162737.GA13672@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040909080310.GA32003@uganda.factory.vocord.ru>
In-Reply-To: <20040909080310.GA32003@uganda.factory.vocord.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Sep 09, 2004 at 12:03:10PM +0400, Evgeniy Polyakov wrote:
> Attached patches and changelogs for the latest connector and superio
> drivers updates.

Can you please fix up the coding style issues?

> +source "drivers/connector/Kconfig"

This code will have to go through the linux-kernel list before it will
be accepted, as you are creating a new way for kernel and userspace to
talk.  How about just dropping it for now from this superio patch?

> diff -Nru /tmp/empty/Kconfig linux-2.6/drivers/superio/Kconfig
> --- /tmp/empty/Kconfig	1970-01-01 03:00:00.000000000 +0300
> +++ linux-2.6/drivers/superio/Kconfig	2004-09-09 11:58:03.000000000 +0400
> @@ -0,0 +1,34 @@
> +menu "SuperIO subsystem support"
> +
> +config SC_SUPERIO
> +	tristate "SuperIO subsystem support"
> +	depends on CONNECTOR
> +	help
> +	  SuperIO subsystem support.
> +
> +config SC_PC8736X
> +	tristate "PC8736x SuperIO"
> +	depends on SC_SUPERIO
> +	help
> +	  Say Y here if you want to use PC8736x controller.
> +
> +config SC_SCX200
> +	tristate "SCx200/SC1100 SuperIO"
> +	depends on SC_SUPERIO
> +	help
> +	  Say Y here if you want to use SCx200/SC1100 controller.
> +
> +
> +config SC_GPIO
> +	tristate "SuperIO - GPIO"
> +	depends on SC_SUPERIO
> +	help
> +	  Say Y here if you want to use GPIO pins.
> +
> +config SC_ACB
> +	tristate "SuperIO - Access Bus"
> +	depends on SC_SUPERIO
> +	help
> +	  Say Y here if you want to use Access Bus.


Please add more documentation about what this is.

thanks,

greg k-h
