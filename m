From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: [PATCH] i2c-sis630 for 2.6.0-test11 get rid of pci init
Message-Id: <20031217233412.GA6140@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200312160048.17954.amalysh@web.de>
In-Reply-To: <200312160048.17954.amalysh@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Dec 16, 2003 at 12:48:14AM +0100, Alexander Malysh wrote:
> Hello,
> 
> 2.6.0 kernel (with great sysfs) just shown a bug that is present in the 
> current i2c-sis630 and was discussed before with Mark M. Hoffman 
> (unfortunately w/o any conclusion) that i2c-sis630 is not a pci device driver 
> and has no need to claiming any pci device.

Hm, where does that SIS630_ACPI_BASE_REG really live at?  Is it
controlled by the PCI_DEVICE_ID_SI_503 device?  

> This patch removes pci_[init|remove] stuff because i2c-sis630 just
> needs a few io ports and should not claim pci device.

What other driver wants to bind to this device?  If no other, what's the
problem with this driver binding to it?  The very nice side-affect of it
is that we auto-loading of the driver when the pci bus is scanned for
devices, which is a big win for users.

thanks,

greg k-h
