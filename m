From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: [PATCH 2.6] Add support for Intel IXP42x GPIO-based I2C
Message-Id: <20040214092838.3ff8ad43.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040213235906.GA5551@plexity.net>
In-Reply-To: <20040213235906.GA5551@plexity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> The following patch against Linus' BK tree adds a driver for using
> GPIO pins on Intel's IXP42x ARM SOCs for an I2C interface.  
> 
> Tnx,
> ~Deepak

See my comments inline.

> diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> --- a/drivers/i2c/busses/Kconfig	Fri Feb 13 16:56:09 2004
> +++ b/drivers/i2c/busses/Kconfig	Fri Feb 13 16:56:09 2004
> @@ -144,6 +144,17 @@
>  	  This support is also available as a module.  If so, the module
>  	  will be called i2c-ite.
>  
> +config I2C_IXP42X
> +	tristate "IXP42x GPIO-Based I2C Interface"
> +	depends on I2C && ARCH_IXP425
> +	select I2C_ALGOBIT
> +	help
> +	  Say Y here if you have an Intel IXP42x(420,421,422,425) based 
> +	  system and are using GPIO lines for an I2C bus.
> +
> +	  This support is also available as a module. If so, the module
> +	  will be called i2c-ixp42x.
> +
>  config I2C_KEYWEST
>  	tristate "Powermac Keywest I2C interface"
>  	depends on I2C && PPC_PMAC
> diff -Nru a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> --- a/drivers/i2c/busses/Makefile	Fri Feb 13 16:56:09 2004
> +++ b/drivers/i2c/busses/Makefile	Fri Feb 13 16:56:09 2004
> @@ -15,6 +15,7 @@
>  obj-$(CONFIG_I2C_IOP3XX)	+= i2c-iop3xx.o
>  obj-$(CONFIG_I2C_ISA)		+= i2c-isa.o
>  obj-$(CONFIG_I2C_ITE)		+= i2c-ite.o
> +obj-$(CONFIG_I2C_IXP42X)	+= i2c-ixp42x.o
>  obj-$(CONFIG_I2C_KEYWEST)	+= i2c-keywest.o
>  obj-$(CONFIG_I2C_NFORCE2)	+= i2c-nforce2.o
>  obj-$(CONFIG_I2C_PHILIPSPAR)	+= i2c-philips-par.o
> diff -Nru a/drivers/i2c/busses/i2c-ixp42x.c
> b/drivers/i2c/busses/i2c-ixp42x.c--- /dev/null	Wed Dec 31 16:00:00 1969
> +++ b/drivers/i2c/busses/i2c-ixp42x.c	Fri Feb 13 16:56:09 2004
> @@ -0,0 +1,170 @@
> +/*
> + * drivers/i2c/i2c-adap-ixp425.c

Doesn't match the actual filename and module name advertised above.

> + *
> + * Driver for gpio-based i2c adapter on Intel IXP42x systems.
> + *
> + * Author: Deepak Saxena <dsaxena@plexity.net>
> + *
> + * Copyright (c) 2003-2004 MontaVista Software Inc.
> + *
> + * This file is licensed under the terms of the GNU General Public 
> + * License version 2. This program is licensed "as is" without any 
> + * warranty of any kind, whether express or implied.
> + *
> + * NOTE: Do NOT add board specific hooks here. All that belongs in platform
> + *       specific code in arch/arm/mach-ixp425/your_platform.c. See
> + *       arch/arm/mach-ixp425/ixdp425.c for an example of building a
> + *       device list and filling in the ixp425_i2c_pins data structure
> + *       that is passed as the platform_data to this driver.
> + */
> +
> +#include <linux/config.h>

Please insert the usual 3 lines debug stuff here (see other bus drivers).

> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/i2c-algo-bit.h>
> +#include <linux/i2c-id.h>

You do not need to include this, i2c.h includes it for you.

> +
> +#include <asm/hardware.h>
> +
> +static inline int ixp425_scl_pin(void *data)
> +{
> +	return ((struct ixp425_i2c_pins*)data)->scl_pin;
> +}
> +
> +static inline int ixp425_sda_pin(void *data)
> +{
> +	return ((struct ixp425_i2c_pins*)data)->sda_pin;
> +}
> +
> +static void ixdp425_bit_setscl(void *data, int val)
> +{
> +	gpio_line_set(ixp425_scl_pin(data), 0);
> +	gpio_line_config(ixp425_scl_pin(data),
> +		val ? IXP425_GPIO_IN : IXP425_GPIO_OUT );
> +}
> +
> +static void ixdp425_bit_setsda(void *data, int val)
> +{
> +	gpio_line_set(ixp425_sda_pin(data), 0);
> +	gpio_line_config(ixp425_sda_pin(data),
> +		val ? IXP425_GPIO_IN : IXP425_GPIO_OUT );
> +}
> +

Where are these gpio_line_* functions defined? and the IXP425_GPIO_*
constants?

> (...)
> +MODULE_DESCRIPTION("GPIO-based I2C adapter for IXP425 systems");
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Deepak Saxena<dsaxena@plexity.net>");

Missing space between name and address.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
