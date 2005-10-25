From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 25 Oct 2005 15:19:08 +0000
Subject: [lm-sensors] Re: [patch 5/9] I2C: remove i2c_driver's .owner and
Message-Id: <2GPAIH59.1130245627.3765220.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051024212541.892926000@antares.localdomain>
In-Reply-To: <20051024212541.892926000@antares.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Laurent,

On 2005-10-24, Laurent Riffard wrote:

> We should use the i2c_driver.driver's .name and .owner fields
> instead of the i2c_drivers's ones.

Looks overall good to me, except:

> Index: linux-2.6-mm/drivers/media/video/ir-kbd-i2c.c
> =================================> --- linux-2.6-mm.orig/drivers/media/video/ir-kbd-i2c.c
> +++ linux-2.6-mm/drivers/media/video/ir-kbd-i2c.c
> @@ -297,8 +297,11 @@
>  static int ir_probe(struct i2c_adapter *adap);
>
>  static struct i2c_driver driver = {
> -        .name           = "ir remote kbd driver",
> -        .id             = I2C_DRIVERID_EXP3, /* FIXME */
> +	.driver = {
> +		.owner  = THIS_MODULE,
> +		.name   = "ir remote kbd driver",
> +	},
> +	.id             = I2C_DRIVERID_EXP3, /* FIXME */

Whitespace change on .id, please revert.

> Index: linux-2.6-mm/drivers/media/video/msp3400.c
> =================================> --- linux-2.6-mm.orig/drivers/media/video/msp3400.c
> +++ linux-2.6-mm/drivers/media/video/msp3400.c
> @@ -1426,17 +1426,17 @@
>  static void msp_wake_thread(struct i2c_client *client);
>
>  static struct i2c_driver driver = {
> -	.owner          = THIS_MODULE,
> -	.name           = "i2c msp3400 driver",
> +	.driver = {
> +		.owner   = THIS_MODULE,
> +		.name    = "i2c msp3400 driver",
> +		.suspend = msp_suspend,
> +		.resume  = msp_resume,
> +	},
>          .id             = I2C_DRIVERID_MSP3400,
>          .flags          = I2C_DF_NOTIFY,
>          .attach_adapter = msp_probe,
>          .detach_client  = msp_detach,
>          .command        = msp_command,
> -	.driver = {
> -		.suspend = msp_suspend,
> -		.resume  = msp_resume,
> -	},
>  };

Please minimize the changes. Leave .suspend and .resume where there are
and move .owner and .name inside .driver, rather than the other way
around. Same comment applies to tda9887.c and tuner-core.c.

> Index: linux-2.6-mm/drivers/media/video/tvmixer.c
> =================================> --- linux-2.6-mm.orig/drivers/media/video/tvmixer.c
> +++ linux-2.6-mm/drivers/media/video/tvmixer.c
> @@ -227,10 +227,12 @@
>  }
>
>  static struct i2c_driver driver = {
> +	.driver = {
>  #ifdef I2C_PEC
> -	.owner           = THIS_MODULE,
> +		.owner   = THIS_MODULE,
>  #endif
> -	.name            = "tv card mixer driver",
> +		.name    = "tv card mixer driver",
> +	},
>          .id              = I2C_DRIVERID_TVMIXER,
>  #ifdef I2C_DF_DUMMY
>  	.flags           = I2C_DF_DUMMY,

This doesn't make much sense that way. #ifdef tests are supposed to
guarantee a compatibility with Linux 2.4, which your change breaks. So,
either make your changes such that compatibility is preserved:

 static struct i2c_driver driver = {
#ifdef I2C_PEC
	.driver = {
		.owner   = THIS_MODULE,
		.name    = "tv card mixer driver",
	},
#else
	.name            = "tv card mixer driver",
#endif

or drop the compatibility stuff altogether (I would prefer that, but v4l
folks may not agree), but don't leave it half broken.

Thanks,
--
Jean Delvare
