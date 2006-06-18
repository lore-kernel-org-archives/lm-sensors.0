From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 18 Jun 2006 09:23:21 +0000
Subject: [lm-sensors] PATCH- i2c-iop3xx platform driver avoid addressing
Message-Id: <20060618112321.c9beb689.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44931779.6050302@d-tacq.com>
In-Reply-To: <44931779.6050302@d-tacq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Peter,

> Avoid addressing self when sending a Master address. Follows instruction 
> in Intel 80331/80321 manuals.
> Ignoring this worked previously on 80321, but causes a hang on i2cdetect 
> on 80331

Can't you simply disable the slave address? You don't seem to use it
anyway.

BTW, you must be using an old version of i2cdetect, as the slave address
appears to be forced to 0x02 in the i2c-iop3xx driver (not a smart
choice...) and i2cdetect does no more scan this address by default.

> diff -uprN -X dontdiff linux-2.6.16.20/drivers/i2c/busses/i2c-iop3xx.h linux-2.6.16.20-iq80331/drivers/i2c/busses/i2c-iop3xx.h
> --- linux-2.6.16.20/drivers/i2c/busses/i2c-iop3xx.h	2006-06-05 18:18:23.000000000 +0100
> +++ linux-2.6.16.20-iq80331/drivers/i2c/busses/i2c-iop3xx.h	2006-06-16 12:20:07.000000000 +0100
> @@ -85,6 +85,7 @@
>  #define I2C_ERR			321
>  #define I2C_ERR_BERR		(I2C_ERR+0)
>  #define I2C_ERR_ALD		(I2C_ERR+1)
> +#define I2C_ERR_WRITEMYSAR      (I2C_ERR+10)

Please use tabs, not spaces, for alignment.

-- 
Jean Delvare

