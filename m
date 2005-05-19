From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:35 +0000
Subject: [PATCH 2.6] I2C: New chip driver: sis5595
Message-Id: <UG87F3dV.1107277247.9606340.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <20050201165434.GD23118@kroah.com>
References: <20050125220945.GA23560@bode.aurel32.net>
In-Reply-To: <20050125220945.GA23560@bode.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: greg@kroah.com, aurelien@aurel32.net
Cc: Alexey Dobriyan <adobriyan@mail.ru>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <sensors@Stimpy.netroedge.com>


Hi Greg & all,

> > +/* Locate SiS bridge and correct base address for SIS5595 */
> > +static int sis5595_find_sis(int *address)
> > +{
> > +	u16 val;
> > +	int *i;
> > +
> > +	if (!(s_bridge > > +	    pci_get_device(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_503, NULL)))
> > +		return -ENODEV;
>
> You never free the reference you grabbed on the pci_dev here.  Please
> read the docs on how pci_get_device() is to be used, it isn't just a
> drop in replacement for pci_find_device(), sorry.
>
> > +	/* Look for imposters */
> > +	for(i = blacklist; *i != 0; i++) {
> > +		if (pci_get_device(PCI_VENDOR_ID_SI, *i, NULL)) {
>
> Same here, you are leaking a reference count.
>
> Why are you not using the pci driver interface instead?

Not sure it exactly answers your question, but the sis5595 much
ressembles the via686a in that respect, i.e. it isn't driving a PCI
device, merely grabbing the ISA I/O address data from PCI configuration
space, then driving that ISA device. I'd guess that whatever was done
in via686a (including the recent updates) should work equally well for
the sis5595.

Thanks,
--
Jean Delvare
