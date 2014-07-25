From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 25 Jul 2014 15:55:20 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (pwm-fan) Make SENSORS_PWM_FAN depend on OF
Message-Id: <20140725175520.067cc7ef@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1406297975.4906.1.camel@phoenix>
In-Reply-To: <1406297975.4906.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Axel,

On Fri, 25 Jul 2014 22:19:35 +0800, Axel Lin wrote:
> This driver won't instantiate if OF is not configured, thus add OF dependency.
> Also add COMPILE_TEST to increase build testing coverage.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/hwmon/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index b93ab97..b9a2764 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1130,7 +1130,7 @@ source drivers/hwmon/pmbus/Kconfig
>  
>  config SENSORS_PWM_FAN
>  	tristate "PWM fan"
> -	depends on PWM
> +	depends on (PWM && OF) || COMPILE_TEST
>  	help
>  	  If you say yes here you get support for fans connected to PWM lines.
>  	  The driver uses the generic PWM interface, thus it will work on a

Does the driver build without PWM? If it does then the patch is correct
and you can add:

Reviewed-by: Jean Delvare <jdelvare@suse.de>

If it does not then you have to leave PWM as a functional dependency,
which would lead to:

	depends on PWM
	depends on OF || COMPILE_TEST

It is allowed to have multiple depends statements, and even encouraged
when you have both functional dependencies and run-time dependencies. I
can't test, so please do.

Thanks,
-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
