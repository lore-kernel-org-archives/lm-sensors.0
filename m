From: Robert Coulson <robert.coulson@ericsson.com>
Date: Mon, 28 Nov 2011 23:16:37 +0000
Subject: Re: [lm-sensors] [PATCH 3/4] hwmon: (pmbus/zl6100) Add support for
Message-Id: <C379E95F3359F140B21F5259C55CC83148CBF06E45@EUSAACMS0714.eamcs.ericsson.se>
List-Id: <lm-sensors.vger.kernel.org>
References: <1322076654-5652-4-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1322076654-5652-4-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> -----Original Message-----
> From: Guenter Roeck 
> Sent: Wednesday, November 23, 2011 11:31 AM
> To: Jean Delvare
> Cc: Robert Coulson; lm-sensors@lm-sensors.org; Guenter Roeck
> Subject: [PATCH 3/4] hwmon: (pmbus/zl6100) Add support for 
> Ericsson BMR45[0,1] and BMR46[2,3,4]
> 
> Add support for Ericsson BMR450, BMR451, BMR462, BMR463, and 
> BMR464, which are based on ZL2005 and ZL2008, to zl6100 
> driver. Remove BMR450 and BMR451 device IDs from generic PMBus driver.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>

Reviewed-by: Robert Coulson <robert.coulson@ericsson.com>

> ---
>  Documentation/hwmon/pmbus    |    5 ++---
>  Documentation/hwmon/zl6100   |   11 +++++++++++
>  drivers/hwmon/pmbus/Kconfig  |    7 ++++---
>  drivers/hwmon/pmbus/pmbus.c  |    2 --
>  drivers/hwmon/pmbus/zl6100.c |    5 +++++
>  5 files changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/hwmon/pmbus 
> b/Documentation/hwmon/pmbus index 15ac911..d28b591 100644
> --- a/Documentation/hwmon/pmbus
> +++ b/Documentation/hwmon/pmbus
> @@ -2,9 +2,8 @@ Kernel driver pmbus
>  ==========
>  
>  Supported chips:
> -  * Ericsson BMR45X series
> -    DC/DC Converter
> -    Prefixes: 'bmr450', 'bmr451', 'bmr453', 'bmr454'
> +  * Ericsson BMR453, BMR454
> +    Prefixes: 'bmr453', 'bmr454'
>      Addresses scanned: -
>      Datasheet:
>   
> http://archive.ericsson.net/service/internet/picov/get?DocNo=2
> 8701-EN/LZT146395
> diff --git a/Documentation/hwmon/zl6100 
> b/Documentation/hwmon/zl6100 index d3bca06..51f76a1 100644
> --- a/Documentation/hwmon/zl6100
> +++ b/Documentation/hwmon/zl6100
> @@ -34,6 +34,17 @@ Supported chips:
>      Prefix: 'zl6105'
>      Addresses scanned: -
>      Datasheet: http://www.intersil.com/data/fn/fn6906.pdf
> +  * Ericsson BMR450, BMR451
> +    Prefix: 'bmr450', 'bmr451'
> +    Addresses scanned: -
> +    Datasheet:
> +http://archive.ericsson.net/service/internet/picov/get?DocNo> 28701-EN/L
> +ZT146401
> +  * Ericsson BMR462, BMR463, BMR464
> +    Prefixes: 'bmr462', 'bmr463', 'bmr464'
> +    Addresses scanned: -
> +    Datasheet:
> +http://archive.ericsson.net/service/internet/picov/get?DocNo> 28701-EN/L
> +ZT146256
> +
>  
>  Author: Guenter Roeck <guenter.roeck@ericsson.com>
>  
> diff --git a/drivers/hwmon/pmbus/Kconfig 
> b/drivers/hwmon/pmbus/Kconfig index d357ab2..cfec923 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -19,8 +19,8 @@ config SENSORS_PMBUS
>  	default y
>  	help
>  	  If you say yes here you get hardware monitoring 
> support for generic
> -	  PMBus devices, including but not limited to ADP4000, 
> BMR450, BMR451,
> -	  BMR453, BMR454, NCP4200, and NCP4208.
> +	  PMBus devices, including but not limited to ADP4000, 
> BMR453, BMR454,
> +	  NCP4200, and NCP4208.
>  
>  	  This driver can also be built as a module. If so, the 
> module will
>  	  be called pmbus.
> @@ -114,7 +114,8 @@ config SENSORS_ZL6100
>  	help
>  	  If you say yes here you get hardware monitoring 
> support for Intersil
>  	  ZL2004, ZL2005, ZL2006, ZL2008, ZL2105, ZL2106, 
> ZL6100, and ZL6105
> -	  Digital DC/DC Controllers.
> +	  Digital DC/DC Controllers, as well as for Ericsson 
> BMR450, BMR451,
> +	  BMR462, BMR463, and BMR464.
>  
>  	  This driver can also be built as a module. If so, the 
> module will
>  	  be called zl6100.
> diff --git a/drivers/hwmon/pmbus/pmbus.c 
> b/drivers/hwmon/pmbus/pmbus.c index 995e873..18a385e 100644
> --- a/drivers/hwmon/pmbus/pmbus.c
> +++ b/drivers/hwmon/pmbus/pmbus.c
> @@ -200,8 +200,6 @@ static int pmbus_remove(struct i2c_client *client)
>   */
>  static const struct i2c_device_id pmbus_id[] = {
>  	{"adp4000", 1},
> -	{"bmr450", 1},
> -	{"bmr451", 1},
>  	{"bmr453", 1},
>  	{"bmr454", 1},
>  	{"ncp4200", 1},
> diff --git a/drivers/hwmon/pmbus/zl6100.c 
> b/drivers/hwmon/pmbus/zl6100.c index d78bdcf..7a72b6e 100644
> --- a/drivers/hwmon/pmbus/zl6100.c
> +++ b/drivers/hwmon/pmbus/zl6100.c
> @@ -135,6 +135,11 @@ static int zl6100_write_byte(struct 
> i2c_client *client, int page, u8 value)  }
>  
>  static const struct i2c_device_id zl6100_id[] = {
> +	{"bmr450", zl2005},
> +	{"bmr451", zl2005},
> +	{"bmr462", zl2008},
> +	{"bmr463", zl2008},
> +	{"bmr464", zl2008},
>  	{"zl2004", zl2004},
>  	{"zl2005", zl2005},
>  	{"zl2006", zl2006},
> --
> 1.7.3.1
> 
> 
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
