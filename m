From: amalysh@web.de (Alexander Malysh)
Date: Thu, 19 May 2005 06:23:39 +0000
Subject: i2c-sis630 bus driver (was Re: last call for 2.6.5)
Message-Id: <200209182043.04047.amalysh@web.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020917150545.S20006@Stimpy.netroedge.com>
In-Reply-To: <20020917150545.S20006@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am Mittwoch, 18. September 2002 20:14 schrieb phil@netroedge.com:
[snip]
> >
> > [snip]
> > I have this one too ... It's only VGA-Card. Can you please provide full
> > lspci -vvv from this board ?
>
> Sure, here it is:
>
> [root@drtheopolis phil]# lspci -d 1039:6300 -vvv
[snip]

Phil, I meant without -d option ... Thank you in advance ...
I'm not sure , what kind of pci-id should be checked ? i found 2 id's = 6300
	1. PCI_DEVICE_ID_SI_630_VGA (this is your case)
	2. PCI_DEVICE_ID_SI_6300

Therefore I would have gladly full lspci output ...

>
> > > As a test, I substituted PCI_DEVICE_ID_SI_630 with 0x6300:
> >
> > no needed anymore , the driver have force option for this :)
>
> Can we have the driver detect it instead of requiring the users to
> force it?  I mean, the driver is for the SiS630, and this PCI device
> is a SiS630.  It wouldn't be obvious to a user that they not only use
> the driver, but must force it to use it.

You are right , but I meant you does't need to "hack" the code anymore  to 
probe a driver for supported chips...

>
> > >         /* Look for the SIS630 */
> > >         if (!(sis630_dev = pci_find_device(PCI_VENDOR_ID_SI,
> > >                                             PCI_DEVICE_ID_SI_503,
> > >                                             sis630_dev))) {
> > >                 printk(KERN_ERR "i2c-sis630.o: Error: Can't detect
> > > SIS630!\n"); return -ENODEV;
> > >         }
> > >         tmp > > > pci_find_device(PCI_VENDOR_ID_SI,/*PCI_DEVICE_ID_SI_630*/0x6300,NULL);
> > > if (tmp = NULL && force = 0) {
> > >                 printk(KERN_ERR "i2c-sis630.o: Error: Can't detect
> > > SIS630!\n"); return -ENODEV;
> > >         }
> > >
> > > And, things seems to be working thus far (but perhaps a bit slow):
> >
> > yes it's slow, because I have disabled change of the Host Master Clock 
> > (it's hang  my Laptop) ... You can try to change i2c-sis630.c at line 194
> > from: sis630_write(SMB_CNT, 0x00);
> > to: sis630_write(SMB_CNT, 0x20);
>
> With just some brief testing, it seems to work.  Doesn't seem much
> faster, but it works.
>
> > In this case Host Master Clock will be changed to 56KHz and should be a
> > bit faster :) Tell me please if it works for you ...
>
> I'm OK with it being slow for the sake of added stability/reliability.
>
>
> Phil

-- 
Alexander Malysh
