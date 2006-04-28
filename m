From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Fri, 28 Apr 2006 03:10:07 +0000
Subject: [lm-sensors] [PATCH 2.6.17-rc3] I2C: sis96x SMBus quirks cannot
Message-Id: <20060428031007.GB6521@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


The sis96x SMBus PCI device depends on the order of two different
quirks, which depends on link order.  But this is apparently not
guaranteed, as seen on a recent FC4 kernel.  This patch fixes the
quirk so that it works without depending on the link order.  There
are some minor style cleanups also.

http://lists.lm-sensors.org/pipermail/lm-sensors/2006-April/015962.html
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id9719

This patch was tested and should be considered for 2.6.17.

Signed-off-by: Mark M. Hoffman <mhoffman at lightlink.com>

--- sis96x-quirk-patch-20060427.orig/drivers/pci/quirks.c
+++ sis96x-quirk-patch-20060427/drivers/pci/quirks.c
@@ -1053,11 +1053,16 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_I
  */
 static void __init quirk_sis_96x_smbus(struct pci_dev *dev)
 {
-	u8 val = 0;
-	printk(KERN_INFO "Enabling SiS 96x SMBus.\n");
-	pci_read_config_byte(dev, 0x77, &val);
-	pci_write_config_byte(dev, 0x77, val & ~0x10);
-	pci_read_config_byte(dev, 0x77, &val);
+	static int once = 0;
+
+	if (!once) {
+		u8 val = 0;
+		once++;
+		printk(KERN_INFO "Enabling SiS 96x SMBus.\n");
+		pci_read_config_byte(dev, 0x77, &val);
+		pci_write_config_byte(dev, 0x77, val & ~0x10);
+		pci_read_config_byte(dev, 0x77, &val);
+	}
 }
 
 /*
@@ -1086,14 +1091,16 @@ static void __init quirk_sis_503(struct 
 	}
 
 	/* Make people aware that we changed the config.. */
-	printk(KERN_WARNING "Uncovering SIS%x that hid as a SIS503 (compatible=%d)\n", devid, sis_96x_compatible);
+	printk(KERN_WARNING "Uncovering SIS%x that hid as a SIS503 "
+		"(compatible=%d)\n", devid, sis_96x_compatible);
 
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
@@ -1107,6 +1114,11 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_S
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_651,		quirk_sis_96x_compatible );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_735,		quirk_sis_96x_compatible );
 
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_961,		quirk_sis_96x_smbus );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_962,		quirk_sis_96x_smbus );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_963,		quirk_sis_96x_smbus );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_LPC,		quirk_sis_96x_smbus );
+
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_503,		quirk_sis_503 );
 /*
  * On ASUS A8V and A8V Deluxe boards, the onboard AC97 audio controller
@@ -1140,11 +1152,6 @@ static void __init asus_hides_ac97_lpc(s
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237, asus_hides_ac97_lpc );
 
 
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_961,		quirk_sis_96x_smbus );
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_962,		quirk_sis_96x_smbus );
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_963,		quirk_sis_96x_smbus );
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_LPC,		quirk_sis_96x_smbus );
-
 #ifdef CONFIG_X86_IO_APIC
 static void __init quirk_alder_ioapic(struct pci_dev *pdev)
 {
-- 
Mark M. Hoffman
mhoffman at lightlink.com


