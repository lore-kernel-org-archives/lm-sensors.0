From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 25 Aug 2005 23:43:18 +0000
Subject: [lm-sensors] Re: [PATCH 2.6] I2C: Drop probe parameter of
Message-Id: <1125005915.12543.16.camel@gaston>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2005-08-25 at 15:40 +0200, Jean Delvare wrote:
> Hi Greg, Ben, all,
> 
> The i2c-keywest driver has a "probe" module parameter which enables bus
> scanning at load time. This can be done in userspace with the i2cdetect
> tool (part of the lm_sensors package) instead. What's more, i2cdetect
> gives more control on the way the bus is scanned, and is safer
> (i2c-keywest currently scans reserved addresses and doesn't properly
> handle the famous 24RF08 corruption case.)
> 
> Thus, I would propose that this module parameter be simply dropped.

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

>  drivers/i2c/busses/i2c-keywest.c |   12 ------------
>  1 file changed, 12 deletions(-)
> 
> --- linux-2.6.13-rc7.orig/drivers/i2c/busses/i2c-keywest.c	2005-08-24 21:35:14.000000000 +0200
> +++ linux-2.6.13-rc7/drivers/i2c/busses/i2c-keywest.c	2005-08-25 14:36:45.000000000 +0200
> @@ -87,12 +87,9 @@
>  };
>  #endif /* DEBUG */
>  
> -static int probe;
> -
>  MODULE_AUTHOR("Benjamin Herrenschmidt <benh@kernel.crashing.org>");
>  MODULE_DESCRIPTION("I2C driver for Apple's Keywest");
>  MODULE_LICENSE("GPL");
> -module_param(probe, bool, 0);
>  
>  #ifdef POLLED_MODE
>  /* Don't schedule, the g5 fan controller is too
> @@ -632,15 +629,6 @@
>  				chan->adapter.name);
>  			i2c_set_adapdata(&chan->adapter, NULL);
>  		}
> -		if (probe) {
> -			printk("Probe: ");
> -			for (addr = 0x00; addr <= 0x7f; addr++) {
> -				if (i2c_smbus_xfer(&chan->adapter,addr,
> -				    0,0,0,I2C_SMBUS_QUICK,NULL) >= 0)
> -					printk("%02x ", addr);
> -			}
> -			printk("\n");
> -		}
>  	}
>  
>  	printk(KERN_INFO "Found KeyWest i2c on \"%s\", %d channel%s, stepping: %d bits\n",
> 
> 

