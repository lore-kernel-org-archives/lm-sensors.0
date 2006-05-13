From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Sat, 13 May 2006 18:26:12 +0000
Subject: [lm-sensors] [PATCH 2.6.17-rc4] I2C: sis96x SMBus quirks cannot
Message-Id: <20060513182612.GB8642@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The sis96x SMBus PCI device depends on the order of two different
quirks, which depends on link order.  But this is apparently not
guaranteed, as seen on a recent FC4 kernel.  This patch fixes the
quirk so that it works without depending on the link order.

http://lists.lm-sensors.org/pipermail/lm-sensors/2006-April/015962.html
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id9719

This code was suggested by Jean Delvare; the patch was tested and
should be considered for 2.6.17.

Signed-off-by: Mark M. Hoffman <mhoffman at lightlink.com>

--- linux-2.6.17-rc4.orig/drivers/pci/quirks.c
+++ linux-2.6.17-rc4/drivers/pci/quirks.c
@@ -1056,10 +1056,11 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_I
 static void __init quirk_sis_96x_smbus(struct pci_dev *dev)
 {
 	u8 val = 0;
-	printk(KERN_INFO "Enabling SiS 96x SMBus.\n");
-	pci_read_config_byte(dev, 0x77, &val);
-	pci_write_config_byte(dev, 0x77, val & ~0x10);
 	pci_read_config_byte(dev, 0x77, &val);
+	if (val & 0x10) {
+		printk(KERN_INFO "Enabling SiS 96x SMBus.\n");
+		pci_write_config_byte(dev, 0x77, val & ~0x10);
+	}
 }
 
 /*
@@ -1091,11 +1092,12 @@ static void __init quirk_sis_503(struct 
 	printk(KERN_WARNING "Uncovering SIS%x that hid as a SIS503 (compatible=%d)\n", devid, sis_96x_compatible);
 
 	/*
-	 * Ok, it now shows up as a 96x.. The 96x quirks are after
-	 * the 503 quirk in the quirk table, so they'll automatically
-	 * run and enable things like the SMBus device
+	 * Ok, it now shows up as a 96x... run the 96x quirk by
+	 * hand in case that one has already been processed.
+	 * (depends on link order, which is apparently not guaranteed)
 	 */
 	dev->device = devid;
+	quirk_sis_96x_smbus(dev);
 }
 
 static void __init quirk_sis_96x_compatible(struct pci_dev *dev)

-- 
Mark M. Hoffman
mhoffman at lightlink.com


