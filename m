From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:29 +0000
Subject: [PATCH] AMD760MPX support
Message-Id: <3C5D7E55.39A0E6D6@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200202020858.g128w7h03063@ns.home.local>
In-Reply-To: <200202020858.g128w7h03063@ns.home.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

support for the 768 was added to CVS a month ago.
thanks anyway.
mds

Willy Tarreau wrote:
> 
> Hi !
> 
> I bought an ASUS dual-Athlon motherboard which comes with an AMD760MPX
> chipset (761 + 768). I just added the PCI IDs of this chipset to the
> existing driver and it works (using wb87381). Here is the patch against
> lmsensors-2.6.2.
> 
> Regards,
> Willy
> 
> --- linux-2.4.16/drivers/i2c/i2c-amd756.c       Tue Jan  8 23:15:11 2002
> +++ linux/drivers/i2c/i2c-amd756.c      Sat Jan 26 23:42:54 2002
> @@ -52,9 +52,13 @@
>  #ifndef PCI_DEVICE_ID_AMD_766
>  #define PCI_DEVICE_ID_AMD_766 0x7413
>  #endif
> +#ifndef PCI_DEVICE_ID_AMD_768
> +#define PCI_DEVICE_ID_AMD_768 0x7443
> +#endif
> 
>  static int supported[] = {PCI_DEVICE_ID_AMD_756,
>                            PCI_DEVICE_ID_AMD_766,
> +                          PCI_DEVICE_ID_AMD_768,
>                            0 };
> 
>  /* AMD756 SMBus address offsets */
> @@ -452,7 +456,7 @@
>         amd756_initialized = 0;
>         if ((res = amd756_setup())) {
>                 printk
> -                   ("i2c-amd756.o: AMD756/766 not detected, module not inserted.\n");
> +                   ("i2c-amd756.o: AMD756/766/768 not detected, module not inserted.\n");
>                 amd756_cleanup();
>                 return res;
>         }
> @@ -466,7 +470,7 @@
>                 return res;
>         }
>         amd756_initialized++;
> -       printk("i2c-amd756.o: AMD756/766 bus detected and initialized\n");
> +       printk("i2c-amd756.o: AMD756/766/768 bus detected and initialized\n");
>         return 0;
>  }
>
