From: David.Monniaux@ens.fr (David Monniaux)
Date: Thu, 19 May 2005 06:23:49 +0000
Subject: SiS 648, P4S8X: success (not total, but still good)
Message-Id: <3E5D5A3B.9010701@ens.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Just to let you know that i2c-sis645.o seems to work with the SiS 648 
chipset
(SiS 648 north bridge, SiS 963 south bridge) provided a little patch is 
applied:

http://www.di.ens.fr/~monniaux/download/lm_sensors-2.7.0-SiS648.patch

Just a few notes:
i2c-sis645.o: Found SiS963 south bridge.
i2c-sis645.o: Attempting to enable SiS645 SMBus device
PCI: No IRQ known for interrupt pin B of device 00:02.1. Please try 
using pci=biosirq.
i2c-sis645.o: SiS645 SMBus base address: 0xe600
i2c-sis645.o: SiS645 bus detected and initialized.

This is with <PnP OS: No> in the BIOS. If I set this to "Yes", none of 
my peripheral gets IRQs!

After a few manipulations, the sensors program wouldn't respond. I've 
rebooted since.

On this ASUS P4S8X motherboard, none of the fan inputs seems to work. 
It's probably due to the Q-Fan (auto-adjusting fan speed) feature of the 
motherboard. I don't know how the BIOS reads the fan speed.

I don't even know how to probe peripherals on the SMbus to check whether 
there is some custom chip for the fan!

Regards,
D. Monniaux
