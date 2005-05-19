From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: [BK PATCH] i2c driver fixes for 2.6.0-test5
Message-Id: <20030924060154.GB25614@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030802052904.GA9782@kroah.com>
In-Reply-To: <20030802052904.GA9782@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Greg KH <greg@kroah.com> [2003-09-22 16:28:47 -0700]:
> Here are some i2c driver fixes and additions for 2.6.0-test5.  I've
> ported almost all of the i2c bus drivers from the 2.4 cvs tree to the
> 2.6 kernel (the one exception is a crazy one that acts like a pci
> hotplug driver in its init function, I'll leave that to someone else...)
> I've also cleaned up the existing i2c bus drivers by moving them into
> the proper directory, and polishing up the Kconfig entries.
> 
> There are a also a few other minor i2c cleanups and fixes in here.

Hi Greg:

To help me digest your patch, I generated some diffs from sensors CVS
to linux-2.6.0-test5 + your patch.  You can find them (and the script
I used to generate them) here:

http://members.dca.net/mhoffman/sensors/diff_cvs-to-lk2.6/

The following quoted diffs are from the above link...

(drivers/i2c/busses/i2c-i810.c)

> -static unsigned long ioaddr;
> +static void *ioaddr;

But later we're doing arithmetic on ioaddr(!)  Apparently the readl/writel
macros are recasting that... but to me this is an obfuscating change.

> @@ -261,49 +225,32 @@
>  {
>         i2c_bit_del_bus(&i810_ddc_adapter);
>         i2c_bit_del_bus(&i810_i2c_adapter);
> +       iounmap(ioaddr);
>  }
>                                                                                                                                             
> -
> -/* Don't register driver to avoid driver conflicts */
> -/*
>  static struct pci_driver i810_driver = {
>         .name           = "i810 smbus",
>         .id_table       = i810_ids,
>         .probe          = i810_probe,
>         .remove         = __devexit_p(i810_remove),
>  };
> -*/
>                                                                                                                                             
>  static int __init i2c_i810_init(void)
>  {
> -       struct pci_dev *dev;
> -       const struct pci_device_id *id;
> -
> -       printk("i2c-i810.o version %s (%s)\n", LM_VERSION, LM_DATE);
> -/*
>         return pci_module_init(&i810_driver);
> -*/
> -       pci_for_each_dev(dev) {
> -               id = pci_match_device(i810_ids, dev);
> -               if(id)
> -                       if(i810_probe(dev, id) >= 0)
> -                               return 0;
> -       }
> -       return -ENODEV;
>  }

Didn't you advise mds earlier that the correct solution here is to
combine this code into the driver with which it now conflicts?  (See
drivers/video/i810/...)  Likewise for i2c-via.c and i2c-voodoo3.c.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
