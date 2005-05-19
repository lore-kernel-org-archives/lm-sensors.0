From: amalysh@web.de (Alexander Malysh)
Date: Thu, 19 May 2005 06:24:31 +0000
Subject: [PATCH] i2c-sis630 for 2.6.0-test11 get rid of pci init
Message-Id: <200312252212.31139.amalysh@web.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200312160048.17954.amalysh@web.de>
In-Reply-To: <200312160048.17954.amalysh@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

sorry for the late response...

On Thursday 18 December 2003 00:34, Greg KH wrote:
> On Tue, Dec 16, 2003 at 12:48:14AM +0100, Alexander Malysh wrote:
> > Hello,
> >
> > 2.6.0 kernel (with great sysfs) just shown a bug that is present in the
> > current i2c-sis630 and was discussed before with Mark M. Hoffman
> > (unfortunately w/o any conclusion) that i2c-sis630 is not a pci device
> > driver and has no need to claiming any pci device.
>
> Hm, where does that SIS630_ACPI_BASE_REG really live at?  Is it
> controlled by the PCI_DEVICE_ID_SI_503 device?

acpi base live at io space behind isa-bridge (SI_503 pci dev) and is indeed 
controlled by isa-bridge.

>
> > This patch removes pci_[init|remove] stuff because i2c-sis630 just
> > needs a few io ports and should not claim pci device.
>
> What other driver wants to bind to this device?  If no other, what's the
> problem with this driver binding to it?  The very nice side-affect of it
> is that we auto-loading of the driver when the pci bus is scanned for
> devices, which is a big win for users.

at this point in time, no other driver known that want claim isa-bridge. I do 
not see any problem to binding driver to isa-bridge. just it has incorrect 
representation within sysfs in my eyes, but I can live with it, due to a big 
user win...

thanks,

-- 
Alexander Malysh
