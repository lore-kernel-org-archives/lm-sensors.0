From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: RFC: complete rewrite of i2c-i801 for 2.6.x
Message-Id: <20041208210743.4ec5c2f0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041128193640.GB5855@jupiter.solarsys.private>
In-Reply-To: <20041128193640.GB5855@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > First, I'd have a question. What is I801_PCI_BAR (and how do you
> > know its value)? Looks like you get the base address in a different
> > way than the old driver did, can you explain how it works and how
> > different it is exactly?
> 
> I'm using pci_resource_start() instead of reading the PCI config space
> directly with pci_read_config_word().  Within the PCI config space,
> there are six possible locations for a base address register: 0x10,
> 0x14, ... 0x24. The second argument to pci_resource_start() specifies
> from which of those locations to read: 0 -> 0x10, 1 -> 0x14, etc. 
> Given that, it should be obvious why I801_PCI_BAR is 4.

OK. But then you shouldn't present it as if it were a register. Defining
it as 4 instead of 0x04 would certainly help, and an empty line to
separate it from I801_PCI_HOSTC may be welcome as well and/or a relevant
comment maybe?

One more comment about the code:

>	/* default: SMBus, no SMI#, enable host controller */
>	pci_write_config_byte(pcidev, I801_PCI_HOSTC, 0x01);
>	pci_read_config_byte(pcidev, I801_PCI_HOSTC, &temp);

And after that you don't use temp... Am I missing something?

You might want to only write the bits that you know about, in case
future chips would have more. Also you could use the constants you
defined earlier. What about:

>	/* default: SMBus, no SMI#, enable host controller */
>	pci_read_config_byte(pcidev, I801_PCI_HOSTC, &temp);
>	pci_write_config_byte(pcidev, I801_PCI_HOSTC,
>			      (temp & 0xF8) | I801_PCI_HOSTC_HST_EN);

Thanks,
-- 
Jean Delvare
http://khali.linux-fr.org/
