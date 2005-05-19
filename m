From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:32 +0000
Subject: better support for amd 768
Message-Id: <3CD80F97.381F9EE1@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <m2g014mhny.fsf@demo.mitica>
In-Reply-To: <m2g014mhny.fsf@demo.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

thanks.
We have already implemented something similar in CVS.

Juan Quintela wrote:
> 
> Hi
>         could you update this patch, please?
>         As you can see, there is not new behaviour, only cleaner code
>         & print messages.
> 
> Later, Juan.
> 
> diff -u linux/drivers/i2c/i2c-amd756.c.orig linux/drivers/i2c/i2c-amd756.c
> --- linux/drivers/i2c/i2c-amd756.c.orig 2002-05-07 11:18:20.000000000 +0200
> +++ linux/drivers/i2c/i2c-amd756.c      2002-05-07 11:20:30.000000000 +0200
> @@ -52,10 +52,13 @@
>  #ifndef PCI_DEVICE_ID_AMD_766
>  #define PCI_DEVICE_ID_AMD_766 0x7413
>  #endif
> +#ifndef PCI_DEVICE_ID_AMD_768
> +#define PCI_DEVICE_ID_AMD_768 0x7443
> +#endif
> 
>  static int supported[] = {PCI_DEVICE_ID_AMD_756,
>                            PCI_DEVICE_ID_AMD_766,
> -                         0x7443, /* AMD768 */
> +                          PCI_DEVICE_ID_AMD_768,
>                            0 };
> 
>  /* AMD756 SMBus address offsets */
> @@ -453,7 +456,7 @@
>         amd756_initialized = 0;
>         if ((res = amd756_setup())) {
>                 printk
> -                   ("i2c-amd756.o: AMD756/766 not detected, module not inserted.\n");
> +                   ("i2c-amd756.o: AMD756/766/768 not detected, module not inserted.\n");
>                 amd756_cleanup();
>                 return res;
>         }
> @@ -467,7 +470,7 @@
>                 return res;
>         }
>         amd756_initialized++;
> -       printk("i2c-amd756.o: AMD756/766 bus detected and initialized\n");
> +       printk("i2c-amd756.o: AMD756/766/768 bus detected and initialized\n");
>         return 0;
>  }
> 
> 
> --
> In theory, practice and theory are the same, but in practice they
> are different -- Larry McVoy
