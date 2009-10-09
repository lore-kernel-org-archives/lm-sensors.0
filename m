From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 09 Oct 2009 08:43:56 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (w83791d) Remove experimental
Message-Id: <20091009104356.50be07fb@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200910091039.14945.m.hulsman@tudelft.nl>
In-Reply-To: <200910091039.14945.m.hulsman@tudelft.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Marc,

On Fri, 9 Oct 2009 10:39:14 +0200, Marc Hulsman wrote:
> The w83791d driver has been in the kernel for a while now,
> time to remove the EXPERIMENTAL dependency.
> 
> Signed-off-by: Marc Hulsman <m.hulsman@tudelft.nl>
> ---
>  drivers/hwmon/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6.32-rc3/drivers/hwmon/Kconfig
> =================================> --- linux-2.6.32-rc3.orig/drivers/hwmon/Kconfig
> +++ linux-2.6.32-rc3/drivers/hwmon/Kconfig
> @@ -841,7 +841,7 @@ config SENSORS_W83781D
>  
>  config SENSORS_W83791D
>  	tristate "Winbond W83791D"
> -	depends on I2C && EXPERIMENTAL
> +	depends on I2C
>  	select HWMON_VID
>  	help
>  	  If you say yes here you get support for the Winbond W83791D chip.

I agree. Patch applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
