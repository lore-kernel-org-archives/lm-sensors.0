From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 11 Jul 2012 22:43:06 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (it87) Preserve configuration register bits on init
Message-Id: <20120711224306.GA20916@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120711221130.6d8bfa6e@endymion.delvare>
In-Reply-To: <20120711221130.6d8bfa6e@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jul 11, 2012 at 10:11:30PM +0200, Jean Delvare wrote:
> We were accidentally losing one bit in the configuration register on
> device initialization. It was reported to freeze one specific system
> right away. Properly preserve all bits we don't explicitly want to
> change in order to prevent that.
> 
> Reported-by: Stevie Trujillo <stevie.trujillo@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/hwmon/it87.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-3.5-rc6.orig/drivers/hwmon/it87.c	2012-06-05 16:22:59.000000000 +0200
> +++ linux-3.5-rc6/drivers/hwmon/it87.c	2012-07-11 22:04:23.476958967 +0200
> @@ -2341,7 +2341,7 @@ static void __devinit it87_init_device(s
>  
>  	/* Start monitoring */
>  	it87_write_value(data, IT87_REG_CONFIG,
> -			 (it87_read_value(data, IT87_REG_CONFIG) & 0x36)
> +			 (it87_read_value(data, IT87_REG_CONFIG) & 0x3e)
>  			 | (update_vbat ? 0x41 : 0x01));
>  }
>  
> 
> -- 
> Jean Delvare
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
