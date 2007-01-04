From: mgreer@mvista.com (Mark A. Greer)
Date: Thu, 04 Jan 2007 22:38:04 +0000
Subject: [lm-sensors] [PATCH] i2c: fix oops in i2c-mv64xxx
Message-Id: <20070104223804.GB22035@mag.az.mvista.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1167950019.22993.95.camel@sakura.staff.proxad.net>
In-Reply-To: <1167950019.22993.95.camel@sakura.staff.proxad.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jan 04, 2007 at 11:33:39PM +0100, Maxime Bizon wrote:

<snip>

> The oops is caused by a spurious interrupt that occurs when request_irq
> is called. mv64xxx_i2c_fsm() tries to read drv_data->msg, which is NULL.
> 
> I noticed that hardware init is done after requesting irq. Thus any
> pending irq from previous hardware usage may cause this.
> 
> The following patch fixes it:

This looks like a reasonable fix (although I haven't tested it yet).
Thanks Maxime.

Mark

> Signed-off-by: Maxime Bizon <mbizon at freebox.fr>

Acked-by: Mark A. Greer <mgreer at mvista.com>

> 
> --- linux-2.6.19.1/drivers/i2c/busses/i2c-mv64xxx.c.old	2007-01-04 18:08:00.000000000 +0100
> +++ linux-2.6.19.1/drivers/i2c/busses/i2c-mv64xxx.c	2007-01-04 18:08:28.000000000 +0100
> @@ -529,6 +529,8 @@
>  	platform_set_drvdata(pd, drv_data);
>  	i2c_set_adapdata(&drv_data->adapter, drv_data);
>  
> +	mv64xxx_i2c_hw_init(drv_data);
> +
>  	if (request_irq(drv_data->irq, mv64xxx_i2c_intr, 0,
>  			MV64XXX_I2C_CTLR_NAME, drv_data)) {
>  		dev_err(&drv_data->adapter.dev,
> @@ -542,8 +544,6 @@
>  		goto exit_free_irq;
>  	}
>  
> -	mv64xxx_i2c_hw_init(drv_data);
> -
>  	return 0;
>  
>  	exit_free_irq:

