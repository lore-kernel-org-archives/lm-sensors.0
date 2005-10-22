From: adaplas@gmail.com (Antonino A. Daplas)
Date: Sat, 22 Oct 2005 16:16:59 +0000
Subject: [lm-sensors] Re: [PATCH 2.6] i2c: Fix incorrect ID uses
Message-Id: <435A47E3.5070102@pol.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051022154830.0b7688ab.khali@linux-fr.org>
In-Reply-To: <20051022154830.0b7688ab.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> --- linux-2.6.14-rc4.orig/drivers/video/i810/i810-i2c.c	2005-10-01 11:01:06.000000000 +0200
> +++ linux-2.6.14-rc4/drivers/video/i810/i810-i2c.c	2005-10-22 15:06:24.000000000 +0200
> @@ -128,8 +128,6 @@
>  	return (0 != (i810_readl(mmio, GPIOA) & SDA_VAL_IN));
>  }
>  
> -#define I2C_ALGO_DDC_I810   0x0e0000
> -#define I2C_ALGO_I2C_I810   0x0f0000
>  static int i810_setup_i2c_bus(struct i810fb_i2c_chan *chan, const char *name,
>  			      int conn)
>  {
> @@ -139,16 +137,15 @@
>          chan->adapter.owner             = THIS_MODULE;
>          chan->adapter.algo_data         = &chan->algo;
>          chan->adapter.dev.parent        = &chan->par->dev->dev;
> +	chan->adapter.id		= I2C_HW_B_I810;
>  	switch (conn) {
>  	case 1:
> -		chan->adapter.id                = I2C_ALGO_DDC_I810;
>  		chan->algo.setsda               = i810ddc_setsda;
>  		chan->algo.setscl               = i810ddc_setscl;
>  		chan->algo.getsda               = i810ddc_getsda;
>  		chan->algo.getscl               = i810ddc_getscl;
>  		break;
>  	case 2:
> -		chan->adapter.id                = I2C_ALGO_I2C_I810;
>  		chan->algo.setsda               = i810i2c_setsda;
>  		chan->algo.setscl               = i810i2c_setscl;
>  		chan->algo.getsda               = i810i2c_getsda;

Please exclude the i810-i2c chunk. I've already sent Andrew a patch
that does this and more.

Thanks.

Tony
