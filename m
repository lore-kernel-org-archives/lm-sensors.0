From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 11 Apr 2006 21:02:45 +0000
Subject: [lm-sensors] scx200_acb: Use PCI I/O resource when appropriate
Message-Id: <20060411230245.fa2c3a7d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060331230309.GE17261@cosmic.amd.com>
	<LYRIS-4270-45297-2006.04.11-06.08.18--jordan.crouse#amd.com@whitestar.amd.com>
	<20060411161942.GB13334@cosmic.amd.com>
In-Reply-To: <20060411161942.GB13334@cosmic.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: linux-kernel@vger.kernel.org, info-linux@ldcmail.amd.com, BGardner@Wabtec.com, lm-sensors@lm-sensors.org

Hi Jordan,

> > > -static struct pci_device_id divil_pci[] = {
> > > -	{ PCI_DEVICE(PCI_VENDOR_ID_NS,  PCI_DEVICE_ID_NS_CS5535_ISA) },
> > > -	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_ISA) },
> > > -	{ } /* NULL entry */
> > > +/* On the CS5535 and CS5536, the SMBUS I/0 base is a PCI resource, so
> > > +   we should allocate that resource through the PCI
> > > +   subsystem. rather then going through the MSR back door.
> > > +*/
> > > +
> > > +static struct {
> > > +	unsigned int vendor;
> > > +	unsigned int device;
> > > +	char *name;
> > > +	int bar;
> > > +} divil_pci[] = {
> > > +	{
> > > +	PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_CS5535_ISA, "CS5535", 0}, {
> > > +	PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_ISA, "CS5536", 0}
> > >  };
> > 
> > It might not be a good idea to move away from pci_device_id. With it,
> > we could have made that module auto-loaded when the supported hardware
> > is found.
>
> I struggled with this.  By pure luck, the SMBus I/O address is available
> on BAR 0 for both parts, but I left it open in case a BIOS vendor wanted
> to do something different.  My fault probably for trying to design for
> something that doesn't exist.

You may not have to drop that information either, I agree that it is
convenient to make the BAR a parameter, and you still have the chip
name anyway. But you can use pci_device_id.driver_data to store an
arbitrary identifier for each device, and use that identifier to lookup
the chip name, BAR or any other information you'd want to attach to the
devices.

Something like this:

static struct pci_device_id divil_pci[] = {
	{ PCI_DEVICE(PCI_VENDOR_ID_NS,  PCI_DEVICE_ID_NS_CS5535_ISA),
		     .driver_data = 0 },
	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_ISA),
		     .driver_data = 1 },
	{ } /* NULL entry */
};

static struct {
	char *name;
	int bar;
} divil_data[] = {
	{ "CS5535", 0},
	{ "CS5536", 0},
};

That's just an idea anyway, there might be other ways to get there.

-- 
Jean Delvare

