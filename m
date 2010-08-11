From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 11 Aug 2010 17:43:31 +0000
Subject: Re: [lm-sensors] [PATCH -next] hwmon: jc42 depends on I2C
Message-Id: <1281548611.5745.287.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100811140009.6ff33109.sfr@canb.auug.org.au>
	 <20100811103511.41428e62.randy.dunlap@oracle.com>
In-Reply-To: <20100811103511.41428e62.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, akpm <akpm@linux-foundation.org>

On Wed, 2010-08-11 at 13:35 -0400, Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> jc42 uses i2c interfaces, so it should depend on I2C.
> 
> drivers/hwmon/jc42.c:426: error: implicit declaration of function 'i2c_check_functionality'
> drivers/hwmon/jc42.c:521: error: implicit declaration of function 'i2c_smbus_read_word_data'
> drivers/hwmon/jc42.c:529: error: implicit declaration of function 'i2c_smbus_write_word_data'
> drivers/hwmon/jc42.c:580: error: implicit declaration of function 'i2c_add_driver'
> drivers/hwmon/jc42.c:585: error: implicit declaration of function 'i2c_del_driver'
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> Cc:	lm-sensors@lm-sensors.org
Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

> ---
>  drivers/hwmon/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-next-20100811.orig/drivers/hwmon/Kconfig
> +++ linux-next-20100811/drivers/hwmon/Kconfig
> @@ -465,6 +465,7 @@ config SENSORS_JZ4740
>  
>  config SENSORS_JC42
>  	tristate "JEDEC JC42.4 compliant temperature sensors"
> +	depends on I2C
>  	help
>  	  If you say yes here you get support for Jedec JC42.4 compliant
>  	  temperature sensors. Support will include, but not be limited to,



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
