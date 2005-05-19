From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: PCI modules problem
Message-Id: <3F00E297.5080802@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I figured out why i2c-voodoo3 and i2c-viapro weren't loading for me on some machines.

The kernel PCI module init code
(pci_module_init() in pci.h, then pci_register_driver() and pci_dev_driver() in pci.c)
allows only one driver registration per PCI device. If another driver gets in there
first we won't load.

This is a big problem for drivers on multi-purpose PCI devices. Especially on our
i2c bit-bangers for video chips, where we only use a couple of registers,
and we have to coexist with video drivers.

Do we have any choice but to back out some of the pci_module_init cleanup?
Perhaps we need to go through each PCI driver and assess whether the PCI
device it attaches to is "single-function"?

Is there any easy way around this???
arghhhhhhhhhh...
