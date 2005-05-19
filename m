From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: i2c clock running at 16Khz
Message-Id: <20050125205914.4209ac60.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <whqVzY37.1106583170.3507600.khali@localhost>
In-Reply-To: <whqVzY37.1106583170.3507600.khali@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Oliver,

> > BTW, may I ask how you did measure the frequency?
> 
> I hooked an oscilloscope to the clock and data pins.

Impressive :) I wish I had the necessary hardware to do so.

> > May I know the SMBus speed (or rather slowness) is so important to
> > you?
> 
> The 3rd party board I am trying to use does not seem to like the
> slower  clock rate.

Strange, usually most chips are fine with that (which is why they chose
it, I guess).

OK, you may try to apply the attached patch to your kernel tree. It
attempts to change a PCI configuration bit which *might* switch the
SMBus speed from 16kHz to 64kHz. I am not able to verify whether it
works or not since I do not have an oscilloscope, and the i2c-viapro is
poll-based so measuring performance from userspace doesn't help (the
poll delay dominates the SMBus speed by a huge factor). Also it might
not work for all VIA chips, I have no datasheets, I can't say. You tell
me if it works for you :)

-- 
Jean Delvare
http://khali.linux-fr.org/
-------------- next part --------------
--- linux-2.6.11-rc1-bk8/drivers/i2c/busses/i2c-viapro.c.orig	2005-01-21 20:05:05.000000000 +0100
+++ linux-2.6.11-rc1-bk8/drivers/i2c/busses/i2c-viapro.c	2005-01-25 20:50:37.000000000 +0100
@@ -341,6 +341,18 @@
 	}
 
 	pci_read_config_byte(pdev, SMBHSTCFG, &temp);
+
+	dev_info(&pdev->dev, "SMBus Host Configuration register: 0x%02x\n", temp);
+	if (!(temp & 0x04)) {
+		dev_info(&pdev->dev, "Attempting to increase SMBus speed... ");
+		pci_write_config_byte(pdev, SMBHSTCFG, temp | 0x04);
+		pci_read_config_byte(pdev, SMBHSTCFG, &temp);
+		if (temp & 0x04)
+			printk("Success!\n");
+		else
+			printk("Failed!\n");
+	}
+
 	/* If force_addr is set, we program the new address here. Just to make
 	   sure, we disable the VT596 first. */
 	if (force_addr) {
