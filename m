From: ink@jurassic.park.msu.ru (Ivan Kokshaysky)
Date: Thu, 19 May 2005 06:25:36 +0000
Subject: M7101
Message-Id: <20050208141322.A2831@jurassic.park.msu.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <41DC59A4.1070006@web.de> <20050206152615.1ab7498c.khali@linux-fr.org> <20050206150611.GR20386@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050206150611.GR20386@parcelfarce.linux.theplanet.co.uk>; from matthew@wil.cx on Sun, Feb 06, 2005 at 03:06:11PM +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Wilcox <matthew@wil.cx>
Cc: Jean Delvare <khali@linux-fr.org>, Enrico Bartky <DOSProfi@web.de>, linux-pci@atrey.karlin.mff.cuni.cz, LM Sensors <sensors@stimpy.netroedge.com>, LKML <linux-kernel@vger.kernel.org>, Maarten Deprez <maartendeprez@scarlet.be>, Greg KH <gregkh@suse.de>

On Sun, Feb 06, 2005 at 03:06:11PM +0000, Matthew Wilcox wrote:
> Looks pretty good to me.  For clarity, I'd change:
> 
> -	m7101 = pci_scan_single_device(dev->bus, 0x18);
> +	m7101 = pci_scan_single_device(dev->bus, PCI_DEVFN(3, 0));

No, it's pretty broken regardless of the change. The integrated devices
on ALi southbridges (IDE, PMU, USB etc.) have programmable IDSELs,
so using hardcoded devfn is just dangerous. We must figure out what
the device number PMU will have before we turn it on.
Something like this:

	// NOTE: These values are for m1543. Someone must verify whether
	// they are the same for m1533 or not.
	static char pmu_idsels[4] __devinitdata = { 28, 29, 14, 15 };

	...

	/* Get IDSEL mapping for PMU (bits 2-3 of 0x72). */
	pci_read_config_byte(dev, 0x72, &val);
	devnum = pmu_idsel[(val >> 2) & 3] - 11;
	m7101 = pci_get_slot(dev->bus, PCI_DEVFN(devnum, 0));
	if (m7101) {
		/* Failure - there is another device with the same number. */
		pci_dev_put(m7101);
		return;
	}

	/* Enable PMU. */
	...

	m7101 = pci_scan_single_device(dev->bus, PCI_DEVFN(devnum, 0));
	...

Ivan.
