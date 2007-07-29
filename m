From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sun, 29 Jul 2007 16:08:46 +0000
Subject: Re: [lm-sensors] [2.6 patch] make
Message-Id: <46ACBB8E.9080302@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070729145701.GJ16817@stusta.de>
In-Reply-To: <20070729145701.GJ16817@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@stusta.de>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Adrian Bunk wrote:
> abituguru3_read_increment_offset() can become static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Looks good, good catch.

Acked-by: Hans de Goede <j.w.r.degoede@hhs.nl>

> 
> ---
> --- linux-2.6.23-rc1-mm1/drivers/hwmon/abituguru3.c.old	2007-07-26 08:56:33.000000000 +0200
> +++ linux-2.6.23-rc1-mm1/drivers/hwmon/abituguru3.c	2007-07-26 08:57:00.000000000 +0200
> @@ -691,8 +691,9 @@
>  
>  /* Sensor settings are stored 1 byte per offset with the bytes
>     placed add consecutive offsets. */
> -int abituguru3_read_increment_offset(struct abituguru3_data *data, u8 bank,
> -	u8 offset, u8 count, u8 *buf, int offset_count)
> +static int abituguru3_read_increment_offset(struct abituguru3_data *data,
> +					    u8 bank, u8 offset, u8 count,
> +					    u8 *buf, int offset_count)
>  {
>  	int i, x;
>  
> 
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
