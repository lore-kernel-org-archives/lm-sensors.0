From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: RFC: complete rewrite of i2c-i801 for 2.6.x
Message-Id: <20041208225355.249ff730.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041128193640.GB5855@jupiter.solarsys.private>
In-Reply-To: <20041128193640.GB5855@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > >	/* default: SMBus, no SMI#, enable host controller */
> > >	pci_write_config_byte(pcidev, I801_PCI_HOSTC, 0x01);
> > >	pci_read_config_byte(pcidev, I801_PCI_HOSTC, &temp);
> > 
> > And after that you don't use temp... Am I missing something?
> 
> This is commonly done to ensure that the write actually hits the bus
> before the code continues.  Otherwise, the write could happen at some
> later point in time.  The read after a write ensures that everything
> is synced up properly.

That's odd. Is is a hardware issue or is it implied by the way the PCI
accesses are handled by Linux itself?

Thanks,
-- 
Jean Delvare
http://khali.linux-fr.org/
