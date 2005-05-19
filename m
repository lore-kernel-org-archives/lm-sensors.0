From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: [BK PATCH] i2c driver fixes for 2.6.0-test5
Message-Id: <20030924180956.GG10443@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030802052904.GA9782@kroah.com>
In-Reply-To: <20030802052904.GA9782@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Sep 24, 2003 at 02:01:54AM -0400, Mark M. Hoffman wrote:
> (drivers/i2c/busses/i2c-i810.c)
> 
> > -static unsigned long ioaddr;
> > +static void *ioaddr;
> 
> But later we're doing arithmetic on ioaddr(!)  Apparently the readl/writel
> macros are recasting that... but to me this is an obfuscating change.

I did it this way, as ioremap returns a void *.  And it's ok to do math
on a void pointer, works the same way as math on a char *.  It got rid
of two casts in the driver with this change.

> > @@ -261,49 +225,32 @@
> >  {
> >         i2c_bit_del_bus(&i810_ddc_adapter);
> >         i2c_bit_del_bus(&i810_i2c_adapter);
> > +       iounmap(ioaddr);
> >  }
> >                                                                                                                                             
> > -
> > -/* Don't register driver to avoid driver conflicts */
> > -/*
> >  static struct pci_driver i810_driver = {
> >         .name           = "i810 smbus",
> >         .id_table       = i810_ids,
> >         .probe          = i810_probe,
> >         .remove         = __devexit_p(i810_remove),
> >  };
> > -*/
> >                                                                                                                                             
> >  static int __init i2c_i810_init(void)
> >  {
> > -       struct pci_dev *dev;
> > -       const struct pci_device_id *id;
> > -
> > -       printk("i2c-i810.o version %s (%s)\n", LM_VERSION, LM_DATE);
> > -/*
> >         return pci_module_init(&i810_driver);
> > -*/
> > -       pci_for_each_dev(dev) {
> > -               id = pci_match_device(i810_ids, dev);
> > -               if(id)
> > -                       if(i810_probe(dev, id) >= 0)
> > -                               return 0;
> > -       }
> > -       return -ENODEV;
> >  }
> 
> Didn't you advise mds earlier that the correct solution here is to
> combine this code into the driver with which it now conflicts?  (See
> drivers/video/i810/...)  Likewise for i2c-via.c and i2c-voodoo3.c.

I did say this.  But just "grabbing" the device like you are doing in
2.4 isn't an ok thing to do (the device can disappear underneath you
quite easily in pci hotplug systems.)  It is not safe to do this at all.

So if people complain about both drivers trying to grab the device, then
people will work on merging the drivers properly, and will send me a
patch :)

There are also some devices that these drivers match up to, that do not
match up to some existing video drivers, from what I could tell, so it
isn't a complete overlap.

Thanks for looking over the changes.

greg k-h
