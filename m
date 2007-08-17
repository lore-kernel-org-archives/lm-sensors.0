From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Fri, 17 Aug 2007 19:46:36 +0000
Subject: Re: [lm-sensors] [PATCH 4/4] libsensors4: Add support for SPI
Message-Id: <46C5FB1C.5020709@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070817172543.0ab931a5@hyperion.delvare>
In-Reply-To: <20070817172543.0ab931a5@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Add support for hardware monitoring chips on SPI buses.
> 
> SPI bus statements in the configuration file are not yet supported, as
> SPI buses don't have a name attribute yet, it's not possible to identify
> them and thus no substitution is possible.
> 

Looks good to me, can you commit these to svn before the end of the weekend, 
monday I'll be back at work and there I have several machines to test with, so 
if you can get all your changes into svn before monday then I can give svn a 
good testing with various setups @ work.

Regards,

Hans


> ---
>  lib/access.c  |    4 ++++
>  lib/data.c    |   12 +++++++++---
>  lib/sensors.h |    1 +
>  lib/sysfs.c   |    4 ++++
>  4 files changed, 18 insertions(+), 3 deletions(-)
> 
> --- lm-sensors-3.orig/lib/data.c	2007-08-17 14:21:37.000000000 +0200
> +++ lm-sensors-3/lib/data.c	2007-08-17 16:50:08.000000000 +0200
> @@ -106,15 +106,18 @@ int sensors_parse_chip_name(const char *
>  		res->bus.type = SENSORS_BUS_TYPE_ISA;
>  	else if (!strncmp(name, "pci", dash - name))
>  		res->bus.type = SENSORS_BUS_TYPE_PCI;
> +	else if (!strncmp(name, "spi", dash - name))
> +		res->bus.type = SENSORS_BUS_TYPE_SPI;
>  	else
>  		goto ERROR;
>  	name = dash + 1;
>  
> -	/* Some bus types (i2c) have an additional bus number. For these, the
> -	   next part is either a "*" (any bus of that type) or a decimal
> -	   number. */
> +	/* Some bus types (i2c, spi) have an additional bus number.
> +	   For these, the next part is either a "*" (any bus of that type)
> +	   or a decimal number. */
>  	switch (res->bus.type) {
>  	case SENSORS_BUS_TYPE_I2C:
> +	case SENSORS_BUS_TYPE_SPI:
>  		if (!strncmp(name, "*-", 2)) {
>  			res->bus.nr = SENSORS_BUS_NR_ANY;
>  			name += 2;
> @@ -162,6 +165,9 @@ int sensors_snprintf_chip_name(char *str
>  	case SENSORS_BUS_TYPE_I2C:
>  		return snprintf(str, size, "%s-i2c-%hd-%02x", chip->prefix,
>  				chip->bus.nr, chip->addr);
> +	case SENSORS_BUS_TYPE_SPI:
> +		return snprintf(str, size, "%s-spi-%hd-%x", chip->prefix,
> +				chip->bus.nr, chip->addr);
>  	}
>  
>  	return -SENSORS_ERR_CHIP_NAME;
> --- lm-sensors-3.orig/lib/sensors.h	2007-08-17 14:21:37.000000000 +0200
> +++ lm-sensors-3/lib/sensors.h	2007-08-17 14:29:53.000000000 +0200
> @@ -33,6 +33,7 @@
>  #define SENSORS_BUS_TYPE_I2C	0
>  #define SENSORS_BUS_TYPE_ISA	1
>  #define SENSORS_BUS_TYPE_PCI	2
> +#define SENSORS_BUS_TYPE_SPI	3
>  #define SENSORS_BUS_NR_ANY	(-1)
>  #define SENSORS_BUS_NR_IGNORE	(-2)
>  
> --- lm-sensors-3.orig/lib/access.c	2007-08-17 14:21:37.000000000 +0200
> +++ lm-sensors-3/lib/access.c	2007-08-17 16:22:25.000000000 +0200
> @@ -322,6 +322,10 @@ const char *sensors_get_adapter_name(con
>  		return "ISA adapter";
>  	case SENSORS_BUS_TYPE_PCI:
>  		return "PCI adapter";
> +	/* SPI should not be here, but for now SPI adapters have no name
> +	   so we don't have any custom string to return. */
> +	case SENSORS_BUS_TYPE_SPI:
> +		return "SPI adapter";
>  	}
>  
>  	/* bus types with several instances */
> --- lm-sensors-3.orig/lib/sysfs.c	2007-08-17 14:29:21.000000000 +0200
> +++ lm-sensors-3/lib/sysfs.c	2007-08-17 14:42:10.000000000 +0200
> @@ -252,6 +252,10 @@ static int sensors_read_one_sysfs_chip(s
>  				sysfs_close_attribute(bus_attr);
>  			}
>  		}
> +	} else if (sscanf(dev->name, "spi%hd.%d", &entry.chip.bus.nr,
> +			  &entry.chip.addr) = 2) {
> +		/* SPI */
> +		entry.chip.bus.type = SENSORS_BUS_TYPE_SPI;
>  	} else if (sscanf(dev->name, "%*[a-z0-9_].%d", &entry.chip.addr) = 1) {
>  		/* must be new ISA (platform driver) */
>  		entry.chip.bus.type = SENSORS_BUS_TYPE_ISA;
> 
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
