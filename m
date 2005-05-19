From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: RFC: complete rewrite of i2c-i801 for 2.6.x
Message-Id: <20041204022848.GJ7903@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041128193640.GB5855@jupiter.solarsys.private>
In-Reply-To: <20041128193640.GB5855@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2004-12-03 22:57:25 +0100]:
> I have been (partly) reviewing the code of your i2c-i801 driver today,
> and also (partly) read the datasheet for my own variant, the ICH3-M.

Good, thanks!

> First, I'd have a question. What is I801_PCI_BAR (and how do you know
> its value)? Looks like you get the base address in a different way than
> the old driver did, can you explain how it works and how different it is
> exactly?

I'm using pci_resource_start() instead of reading the PCI config space
directly with pci_read_config_word().  Within the PCI config space, there
are six possible locations for a base address register: 0x10, 0x14, ... 0x24.
The second argument to pci_resource_start() specifies from which of those
locations to read: 0 -> 0x10, 1 -> 0x14, etc.  Given that, it should be
obvious why I801_PCI_BAR is 4.

> Second I'd have a suggestion. It looks like you can detect the length of
> the I/O space automatically. You'd simply do:
> 
>   i801_iosize = pci_resource_len(pcidev, I801_PCI_BAR);
> 
> instead of explicitely setting it to 16 or 32. This makes the code more
> compact and will automatically support the possibly different length of
> future compatible chips. I would also suggest that you compute i801_smba
> before i801_iosize, because the former can fail, and also because it is
> more logical that way (IMHO at least).

Good point about pci_resource_len(), I'll do that.  Eventually though, I'll
need to check the PCI IDs anyway when I want to use some features that the
older chipsets don't have.  I.e. it won't save me the "if" statements by
then.

> I tested it and it works fine for me.
> 
> I'm impatient to test the next version of your driver :)

Be patient please. :)

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
