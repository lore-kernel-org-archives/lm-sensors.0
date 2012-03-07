From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 07 Mar 2012 14:57:23 +0000
Subject: Re: [lm-sensors] [PATCH v2 6/6] hwmon: (zl6100) Add support for ZL9101M and ZL9117M
Message-Id: <20120307155723.7946b75e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1331005677-24129-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1331005677-24129-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon,  5 Mar 2012 19:47:57 -0800, Guenter Roeck wrote:
> ZL9101M and ZL9117M are compatible to ZL6100. Add support to the zl6100 driver.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Tested driver with both chips.
>     The ZL9117 device ID string is ZL9117-002-FC03, ie does not include an 'M'.
>     Rename chip IDs to zl9101 and zl9117 for consistency. Also, both chips
>     require a delay between I2C bus accesses. Mention this in the code.
> 
>  Documentation/hwmon/zl6100   |    8 ++++++++
>  drivers/hwmon/pmbus/Kconfig  |    6 +++---
>  drivers/hwmon/pmbus/zl6100.c |   11 +++++++----
>  3 files changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/hwmon/zl6100 b/Documentation/hwmon/zl6100
> index 51f76a1..52084b3 100644
> --- a/Documentation/hwmon/zl6100
> +++ b/Documentation/hwmon/zl6100
> @@ -34,6 +34,14 @@ Supported chips:
>      Prefix: 'zl6105'
>      Addresses scanned: -
>      Datasheet: http://www.intersil.com/data/fn/fn6906.pdf
> +  * Intersil / Zilker Labs ZL9101M
> +    Prefix: 'zl9101'
> +    Addresses scanned: -
> +    Datasheet: http://www.intersil.com/data/fn/fn7669.pdf
> +  * Intersil / Zilker Labs ZL9117M
> +    Prefix: 'zl9117'
> +    Addresses scanned: -
> +    Datasheet: http://www.intersil.com/data/fn/fn7914.pdf
>    * Ericsson BMR450, BMR451
>      Prefix: 'bmr450', 'bmr451'
>      Addresses scanned: -
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index 9246d01..2ca6a5a 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -114,9 +114,9 @@ config SENSORS_ZL6100
>  	default n
>  	help
>  	  If you say yes here you get hardware monitoring support for Intersil
> -	  ZL2004, ZL2005, ZL2006, ZL2008, ZL2105, ZL2106, ZL6100, and ZL6105
> -	  Digital DC/DC Controllers, as well as for Ericsson BMR450, BMR451,
> -	  BMR462, BMR463, and BMR464.
> +	  ZL2004, ZL2005, ZL2006, ZL2008, ZL2105, ZL2106, ZL6100, ZL6105,
> +	  ZL9101M, and ZL9117M Digital DC/DC Controllers, as well as for
> +	  Ericsson BMR450, BMR451, BMR462, BMR463, and BMR464.
>  
>  	  This driver can also be built as a module. If so, the module will
>  	  be called zl6100.
> diff --git a/drivers/hwmon/pmbus/zl6100.c b/drivers/hwmon/pmbus/zl6100.c
> index 4a8fc63..6d7d591 100644
> --- a/drivers/hwmon/pmbus/zl6100.c
> +++ b/drivers/hwmon/pmbus/zl6100.c
> @@ -28,7 +28,8 @@
>  #include <linux/delay.h>
>  #include "pmbus.h"
>  
> -enum chips { zl2004, zl2005, zl2006, zl2008, zl2105, zl2106, zl6100, zl6105 };
> +enum chips { zl2004, zl2005, zl2006, zl2008, zl2105, zl2106, zl6100, zl6105,
> +	     zl9101, zl9117 };
>  
>  struct zl6100_data {
>  	int id;
> @@ -151,6 +152,8 @@ static const struct i2c_device_id zl6100_id[] = {
>  	{"zl2106", zl2106},
>  	{"zl6100", zl6100},
>  	{"zl6105", zl6105},
> +	{"zl9101", zl9101},
> +	{"zl9117", zl9117},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, zl6100_id);
> @@ -200,9 +203,9 @@ static int zl6100_probe(struct i2c_client *client,
>  	data->id = mid->driver_data;
>  
>  	/*
> -	 * ZL2005, ZL2008, ZL2105, and ZL6100 are known to require a wait time
> -	 * between I2C accesses. ZL2004 and ZL6105 are known to be safe.
> -	 * Other chips have not yet been tested.
> +	 * ZL2005, ZL2008, ZL2105, ZL6100, ZL9101M, and ZL9117M are known to
> +	 * require a wait time between I2C accesses. ZL2004 and ZL6105 are known
> +	 * to be safe. Other chips have not yet been tested.
>  	 *
>  	 * Only clear the wait time for chips known to be safe. The wait time
>  	 * can be cleared later for additional chips if tests show that it

Looks OK.

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
