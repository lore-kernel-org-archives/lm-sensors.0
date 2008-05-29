From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 29 May 2008 18:38:14 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/adm9240 - remove EXPERIMENTAL
Message-Id: <20080529203814.7939c3da@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <ve7234pijlo02s2eeisrbv774hdqo43mvg@4ax.com>
In-Reply-To: <ve7234pijlo02s2eeisrbv774hdqo43mvg@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 20 May 2008 00:35:10 +1000, Grant Coady wrote:
> Hi Mark,
> 
> I think it's time ;)  (Hopefully I've remembered how to send a patch properly)
> 
> Oops, try again with inline text attachment:
> 
> From: Grant Coady <gcoady.lk@gmail.com>
> 
> The adm9240 driver is in the kernel for three years now, time to remove 
> the EXPERIMENTAL dependency.
> 
> Signed-off-by: Grant Coady <gcoady.lk@gmail.com>
> 
> ---
>  Kconfig |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-2.6.26-rc3a/drivers/hwmon/Kconfig	2008-04-18 14:27:39.000000000 +1000
> +++ linux-2.6.26-rc3b/drivers/hwmon/Kconfig	2008-05-19 16:12:01.000000000 +1000
> @@ -124,7 +124,7 @@
>  
>  config SENSORS_ADM9240
>  	tristate "Analog Devices ADM9240 and compatibles"
> -	depends on I2C && EXPERIMENTAL
> +	depends on I2C
>  	select HWMON_VID
>  	help
>  	  If you say yes here you get support for Analog Devices ADM9240,
> 

Sounds reasonable.

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
