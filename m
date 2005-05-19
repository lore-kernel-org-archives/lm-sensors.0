From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: Usbvision/i2c-algo-usb port to 2.8.0
Message-Id: <20030804141400.64d134b5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030730165206.M58081@bandos.homelinux.com>
In-Reply-To: <20030730165206.M58081@bandos.homelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I finally managed to test the patch, the following (or something like
> it) should be added:
> 
> --------------------------------------------------------------
> --- /usr/src/usbvision-0.3.3-test5/src/i2c-algo-usb.c   2003-06-05
> 10:34:26.000000000 +0100
> +++ /usr/src/linux/drivers/usb/i2c-algo-usb.c   2003-08-03
> 22:23:20.000000000+0100
> @@ -182,14 +182,11 @@
>  /* -----exported algorithm data:
>  ------------------------------------- */
> 
>  static struct i2c_algorithm i2c_usb_algo = {
> -       "USB algorithm",
> -       I2C_ALGO_BIT,           /* FIXME */
> -       usb_xfer,
> -       NULL,
> -       NULL,                   /* slave_xmit           */
> -       NULL,                   /* slave_recv           */
> -       algo_control,           /* ioctl                */
> -       usb_func,               /* functionality        */
> +       .owner          = THIS_MODULE,
> +       .name           = "USB algorithm",
> +       .id             = I2C_ALGO_BIT,
> +       .master_xfer    = usb_xfer,
> +       .functionality  = usb_func,
>  };
> 
>  /*
> --------------------------------------------------------------
> 
> Apart from that, it worked fine. Thanks!

You're welcome. I didn't know that the i2c_algorithm struct could
require changes too, thanks a lot for pointing this out. I hope I didn't
miss such changes for other drivers I have been converting, other than
the saa7134 which I just fixed too. Since I had been testing the other
drivers (use or at least compilation), I guess it's OK.

I uploaded fixed patches a few minutes ago. My fix for i2c-algo-usb is
slightly different, since you forgot the algo_control member. I guess it
wasn't intentional and fixed that too.

Thanks for reporting!

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
