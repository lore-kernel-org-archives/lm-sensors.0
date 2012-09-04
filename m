From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 04 Sep 2012 16:28:12 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon/lm70: Allow 4wire SPI bus with LM70
Message-Id: <20120904162812.GB16877@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <201209040840.q848eiPg028975@localhost.localdomain>
In-Reply-To: <201209040840.q848eiPg028975@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Tue, Sep 04, 2012 at 10:40:44AM +0200, Christophe Leroy wrote:
> Removing the 3wire limitation on LM70 as the component also allows
> operation on 4wire SPI bus
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
Applied to -next.

Thanks,
Guenter

> diff -u linux-3.5-vanilla/drivers/hwmon/lm70.c linux-3.5/drivers/hwmon/lm70.c
> --- linux-3.5-vanilla/drivers/hwmon/lm70.c	2012-07-21 22:58:29.000000000 +0200
> +++ linux-3.5/drivers/hwmon/lm70.c	2012-08-25 00:35:40.000000000 +0200
> @@ -143,10 +143,6 @@
>  	if (spi->mode & (SPI_CPOL | SPI_CPHA))
>  		return -EINVAL;
>  
> -	/* 3-wire link (shared SI/SO) for LM70 */
> -	if (chip = LM70_CHIP_LM70 && !(spi->mode & SPI_3WIRE))
> -		return -EINVAL;
> -
>  	/* NOTE:  we assume 8-bit words, and convert to 16 bits manually */
>  
>  	p_lm70 = kzalloc(sizeof *p_lm70, GFP_KERNEL);
> diff -u linux-3.5-vanilla/Documentation/hwmon/lm70 linux-3.5/Documentation/hwmon/lm70
> --- linux-3.5-vanilla/Documentation/hwmon/lm70	2012-07-21 22:58:29.000000000 +0200
> +++ linux-3.5/Documentation/hwmon/lm70	2012-08-25 00:37:15.000000000 +0200
> @@ -31,9 +31,8 @@
>  with a "SPI master controller driver", see drivers/spi/spi_lm70llp.c
>  and its associated documentation.
>  
> -The TMP121/TMP123 are very similar; main differences are 4 wire SPI inter-
> -face (read only) and 13-bit temperature data (0.0625 degrees celsius reso-
> -lution).
> +The TMP121/TMP123 are very similar; main difference is 13-bit temperature
> +data (0.0625 degrees celsius resolution).
>  
>  Thanks to
>  ---------
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
