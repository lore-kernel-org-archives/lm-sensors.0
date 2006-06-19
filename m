From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 19 Jun 2006 12:24:27 +0000
Subject: [lm-sensors] PATCH - s3c2410 clock control patch
Message-Id: <20060619142427.ab16da07.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ben,

> This patch makes it possible for the I2C unit
> to disable the clock fed into it whilst it is
> not being used. This should reduce the power
> consumption, with only minimal extra time during
> the start and end of a transfer.
> 
> This patch also ensures that the clock is in
> the right state when going in and out of
> suspend.
> 
> Also included is a minor bugfix to place a minor
> delay if going to next part of a write, the
> controller can generate incorrect bus data if
> a small number of register reads inserted
> before returning from the IRQ handler

This probably should be a separate patch.

> diff -urpN -X ../dontdiff linux-2.6.16-rmk/drivers/i2c/busses/Kconfig linux-2.6.16-rmk-bjd1/drivers/i2c/busses/Kconfig
> --- linux-2.6.16-rmk/drivers/i2c/busses/Kconfig	2006-03-20 05:53:29.000000000 +0000
> +++ linux-2.6.16-rmk-bjd1/drivers/i2c/busses/Kconfig	2006-03-21 22:44:26.000000000 +0000
> @@ -343,6 +343,14 @@ config I2C_S3C2410
>  	  Say Y here to include support for I2C controller in the
>  	  Samsung S3C2410 based System-on-Chip devices.
>  
> +config I2C_S3C2410_CLKIDLE
> +	bool "Stop I2C clock during IDLE"
> +	depends on I2C_S3C2410
> +	help
> +	  Say Y here to enable support for disabling the I2C unit
> +	  clock when the bus is idle. This is useful to save power
> +	  if not using the unit as a bus slave.
> +
>  config I2C_SAVAGE4
>  	tristate "S3 Savage 4"
>  	depends on I2C && PCI && EXPERIMENTAL
> diff -urpN -X ../dontdiff linux-2.6.16-rmk/drivers/i2c/busses/i2c-s3c2410.c linux-2.6.16-rmk-bjd1/drivers/i2c/busses/i2c-s3c2410.c
> --- linux-2.6.16-rmk/drivers/i2c/busses/i2c-s3c2410.c	2006-03-20 05:53:29.000000000 +0000
> +++ linux-2.6.16-rmk-bjd1/drivers/i2c/busses/i2c-s3c2410.c	2006-03-21 22:44:26.000000000 +0000
> @@ -44,6 +44,14 @@
>  #include <asm/arch/regs-iic.h>
>  #include <asm/arch/iic.h>
>  
> +/* configuration */
> +
> +#ifdef CONFIG_I2C_S3C2410_CLKIDLE
> +static int clock_idle = 1;
> +#else
> +static const int clock_idle = 0;
> +#endif
> +

Why did you make it a compilation-time choice, rather than a run-time
one? It would be easy to define a sysfs attribute for the driver, so
that the user can change his/her mind anytime.

>  /* i2c controller state */
>  
>  enum s3c24xx_i2c_state {
> @@ -96,6 +104,11 @@ static inline int s3c24xx_i2c_is2440(str
>  	return !strcmp(pdev->name, "s3c2440-i2c");
>  }
>  
> +static inline int s3c24xx_i2c_clkidle(struct s3c24xx_i2c *i2c)
> +{
> +	return clock_idle;
> +}
> +

This function doesn't make much sense, why don't you test clock_idle
directly?

>  
>  /* s3c24xx_i2c_get_platformdata
>   *
> @@ -214,7 +227,7 @@ static inline void s3c24xx_i2c_stop(stru
>  {
>  	unsigned long iicstat = readl(i2c->regs + S3C2410_IICSTAT);
>  
> -	dev_dbg(i2c->dev, "STOP\n");
> +	dev_dbg(i2c->dev, "STOP (ret=%d)\n", ret);
>  
>  	/* stop the transfer */
>  	iicstat &= ~ S3C2410_IICSTAT_START;
> @@ -269,6 +282,7 @@ static int i2s_s3c_irq_nextbyte(struct s
>  	unsigned long tmp;
>  	unsigned char byte;
>  	int ret = 0;
> +	int i;
>  
>  	switch (i2c->state) {
>  
> @@ -324,7 +338,15 @@ static int i2s_s3c_irq_nextbyte(struct s
>  		if (!is_msgend(i2c)) {
>  			byte = i2c->msg->buf[i2c->msg_ptr++];
>  			writeb(byte, i2c->regs + S3C2410_IICDS);
> -			
> +
> +			/* sometimes write operations fail if the write is
> +			 * let go too quickly, slow down the proceedings
> +			 * slightly.
> +			 */
> +
> +			for (i = 0; i < 6; i++) 
> +				tmp += readl(i2c->regs + S3C2410_IICSTAT);
> +

Ugly hack, is there no cleaner way? :(

BTW I'd expect a warning from the compiler, as tmp is uninitialized at
this point. Why do you need tmp at all?

> @@ -870,6 +903,9 @@ static int s3c24xx_i2c_remove(struct pla
>  	if (i2c != NULL) {
>  		s3c24xx_i2c_free(i2c);
>  		platform_set_drvdata(pdev, NULL);
> +
> +		if (!s3c24xx_i2c_clkidle(i2c))
> +			clk_disable(i2c->clk);
>  	}

You already disable the clock in s3c24xx_i2c_free, so why do it again?

-- 
Jean Delvare

