From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 17 Dec 2006 19:16:12 +0000
Subject: [lm-sensors] [PATCH] Make lm70_remove a __devexit function
Message-Id: <20061217201612.1c7ba106.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20061210192151.GA32262@linux-mips.org>
In-Reply-To: <20061210192151.GA32262@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Ralf,

On Sun, 10 Dec 2006 19:21:51 +0000, Ralf Baechle wrote:
> Saves a few bytes on the module.
> 
> Signed-off-by: Ralf Baechle <ralf at linux-mips.org>
> 
> diff --git a/drivers/hwmon/lm70.c b/drivers/hwmon/lm70.c
> index 6ba8473..7eaae38 100644
> --- a/drivers/hwmon/lm70.c
> +++ b/drivers/hwmon/lm70.c
> @@ -126,7 +126,7 @@ out_dev_reg_failed:
>  	return status;
>  }
>  
> -static int __exit lm70_remove(struct spi_device *spi)
> +static int __devexit lm70_remove(struct spi_device *spi)
>  {
>  	struct lm70 *p_lm70 = dev_get_drvdata(&spi->dev);
>  

You're not actually saving memory with this change, as __devexit is
resolved to either __exit (i.e. nothing changes) or nothing (i.e. the
code is now always compiled in.) This is a bugfix though as currently
the code may be striped away while the driver still holds a pointer to
it.

Good catch, applied (with a different header comment), thanks.

-- 
Jean Delvare

