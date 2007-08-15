From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Wed, 15 Aug 2007 17:00:32 +0000
Subject: Re: [lm-sensors] [PATCH 5/6] libsensors4: sensors_snprintf_chip_name
Message-Id: <46C33130.6050702@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070815174429.0e221e21@hyperion>
In-Reply-To: <20070815174429.0e221e21@hyperion>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Add a new function to libsensors doing the opposite of
> sensors_parse_chip_name(). sensors_snprintf_chip_name() converts
> a chip name from its internal representation to a human readable
> string. So far, each user program had to reimplement this function.
> 

Looks good too, again I'll run some tests once things hit svn.

Regards,

Hans

> ---
>  lib/access.c         |    2 +-
>  lib/access.h         |    5 +++++
>  lib/data.c           |   20 ++++++++++++++++++++
>  lib/sensors.h        |    6 ++++++
>  prog/sensord/sense.c |    8 ++------
>  prog/sensors/main.c  |    9 ++-------
>  6 files changed, 36 insertions(+), 14 deletions(-)
> 
> --- lm-sensors-3.orig/lib/data.c	2007-08-15 12:19:24.000000000 +0200
> +++ lm-sensors-3/lib/data.c	2007-08-15 13:59:44.000000000 +0200
> @@ -20,6 +20,7 @@
>  #include <stdlib.h>
>  #include <string.h>
>  
> +#include "access.h"
>  #include "error.h"
>  #include "data.h"
>  #include "sensors.h"
> @@ -154,6 +155,25 @@ ERROR:
>    return -SENSORS_ERR_CHIP_NAME;
>  }
>  
> +int sensors_snprintf_chip_name(char *str, size_t size,
> +			       const sensors_chip_name *chip)
> +{
> +	if (sensors_chip_name_has_wildcards(chip))
> +		return -SENSORS_ERR_WILDCARDS;
> +
> +	switch (chip->bus) {
> +	case SENSORS_CHIP_NAME_BUS_ISA:
> +		return snprintf(str, size, "%s-isa-%04x", chip->prefix,
> +				chip->addr);
> +	case SENSORS_CHIP_NAME_BUS_PCI:
> +		return snprintf(str, size, "%s-pci-%04x", chip->prefix,
> +				chip->addr);
> +	default:
> +		return snprintf(str, size, "%s-i2c-%d-%02x", chip->prefix,
> +				chip->bus, chip->addr);
> +	}
> +}
> +
>  int sensors_parse_i2cbus_name(const char *name, int *res)
>  {
>    char *endptr;
> --- lm-sensors-3.orig/lib/sensors.h	2007-08-15 12:09:52.000000000 +0200
> +++ lm-sensors-3/lib/sensors.h	2007-08-15 13:32:31.000000000 +0200
> @@ -60,6 +60,12 @@ extern void sensors_cleanup(void);
>  extern int sensors_parse_chip_name(const char *orig_name,
>                                     sensors_chip_name *res);
>  
> +/* Print a chip name from its internal representation. Note that chip should
> +   not contain wildcard values! Return the number of characters printed on
> +   success (same as snprintf), <0 on error. */
> +int sensors_snprintf_chip_name(char *str, size_t size,
> +			       const sensors_chip_name *chip);
> +
>  /* Compare two chips name descriptions, to see whether they could match.
>     Return 0 if it does not match, return 1 if it does match. */
>  extern int sensors_match_chip(const sensors_chip_name *chip1,
> --- lm-sensors-3.orig/prog/sensors/main.c	2007-08-15 12:08:23.000000000 +0200
> +++ lm-sensors-3/prog/sensors/main.c	2007-08-15 13:33:34.000000000 +0200
> @@ -298,13 +298,8 @@ const char *sprintf_chip_name(const sens
>    #define BUF_SIZE 200
>    static char buf[BUF_SIZE];
>  
> -  if (name->bus = SENSORS_CHIP_NAME_BUS_ISA)
> -    snprintf(buf, BUF_SIZE, "%s-isa-%04x", name->prefix, name->addr);
> -  else if (name->bus = SENSORS_CHIP_NAME_BUS_PCI)
> -    snprintf(buf, BUF_SIZE, "%s-pci-%04x", name->prefix, name->addr);
> -  else
> -    snprintf(buf, BUF_SIZE, "%s-i2c-%d-%02x", name->prefix, name->bus,
> -             name->addr);
> +  if (sensors_snprintf_chip_name(buf, BUF_SIZE, name) < 0)
> +    return NULL;
>    return buf;
>  }
>  
> --- lm-sensors-3.orig/prog/sensord/sense.c	2007-08-15 12:00:23.000000000 +0200
> +++ lm-sensors-3/prog/sensord/sense.c	2007-08-15 13:33:47.000000000 +0200
> @@ -74,12 +74,8 @@ static const char *
>  chipName
>  (const sensors_chip_name *chip) {
>    static char buffer[256];
> -  if (chip->bus = SENSORS_CHIP_NAME_BUS_ISA)
> -    sprintf (buffer, "%s-isa-%04x", chip->prefix, chip->addr);
> -  else if (chip->bus = SENSORS_CHIP_NAME_BUS_PCI)
> -	    sprintf (buffer, "%s-pci-%04x", chip->prefix, chip->addr);
> -  else
> -    sprintf (buffer, "%s-i2c-%d-%02x", chip->prefix, chip->bus, chip->addr);
> +  if (sensors_snprintf_chip_name(buffer, 256, chip) < 0)
> +    return NULL;
>    return buffer;
>  }
>  
> --- lm-sensors-3.orig/lib/access.c	2007-08-15 12:09:52.000000000 +0200
> +++ lm-sensors-3/lib/access.c	2007-08-15 13:34:20.000000000 +0200
> @@ -133,7 +133,7 @@ sensors_lookup_feature_name(const sensor
>  /* Check whether the chip name is an 'absolute' name, which can only match
>     one chip, or whether it has wildcards. Returns 0 if it is absolute, 1
>     if there are wildcards. */
> -static int sensors_chip_name_has_wildcards(const sensors_chip_name *chip)
> +int sensors_chip_name_has_wildcards(const sensors_chip_name *chip)
>  {
>  	if ((chip->prefix = SENSORS_CHIP_NAME_PREFIX_ANY) ||
>  	    (chip->bus = SENSORS_CHIP_NAME_BUS_ANY) ||
> --- lm-sensors-3.orig/lib/access.h	2007-07-22 14:24:18.000000000 +0200
> +++ lm-sensors-3/lib/access.h	2007-08-15 13:35:15.000000000 +0200
> @@ -29,6 +29,11 @@
>  extern const sensors_chip_feature *sensors_lookup_feature_nr(const sensors_chip_name *chip,
>                                                               int feature);
>  
> +/* Check whether the chip name is an 'absolute' name, which can only match
> +   one chip, or whether it has wildcards. Returns 0 if it is absolute, 1
> +   if there are wildcards. */
> +int sensors_chip_name_has_wildcards(const sensors_chip_name *chip);
> +
>  sensors_feature_type sensors_feature_get_type(const char *name, int *nr);
>  
>  #endif /* def LIB_SENSORS_ACCESS_H */
> 
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
