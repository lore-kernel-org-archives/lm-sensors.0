From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sat, 24 Sep 2005 21:48:09 +0000
Subject: [lm-sensors] Asus Z80V/M6V i2c support
Message-Id: <4335AD5F.7050605@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <318b1df00509211647a24cdec@mail.gmail.com>
In-Reply-To: <318b1df00509211647a24cdec@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> After some trial and error it finally works today. :-) I now see the
> SMBus device and can access everything. The patch is attached.

Ok thanks. Oh I forgot about the enable bit in the IOBASE...

> Thank you for your help!

No problem.

I'm attaching final patch. Please test it.

Thanks,
regards
Rudolf
-------------- next part --------------
diff -Naur a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c	2005-09-20 05:00:41.000000000 +0200
+++ b/drivers/pci/quirks.c	2005-09-24 21:45:33.099427000 +0200
@@ -847,6 +847,12 @@
 			case 0x186a: /* M6Ne notebook */
 				asus_hides_smbus = 1;
 			}
+		if (dev->device = PCI_DEVICE_ID_INTEL_82915GM_HB)
+			switch (dev->subsystem_device) {
+			case 0x1882: /* MV6V notebook */
+				asus_hides_smbus = 1;
+			}
+			
 	} else if (unlikely(dev->subsystem_vendor = PCI_VENDOR_ID_HP)) {
 		if (dev->device =  PCI_DEVICE_ID_INTEL_82855PM_HB)
 			switch(dev->subsystem_device) {
@@ -891,6 +897,7 @@
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_7205_0,	asus_hides_smbus_hostbridge );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82855PM_HB,	asus_hides_smbus_hostbridge );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82855GM_HB,	asus_hides_smbus_hostbridge );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82915GM_HB,	asus_hides_smbus_hostbridge );
 
 static void __init asus_hides_smbus_lpc(struct pci_dev *dev)
 {
@@ -915,6 +922,23 @@
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_12,	asus_hides_smbus_lpc );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801EB_0,	asus_hides_smbus_lpc );
 
+static void __init asus_hides_smbus_lpc_ich6(struct pci_dev *dev)
+{
+	u32 val, rcba;
+	void __iomem *base;
+
+	if (likely(!asus_hides_smbus))
+		return;
+	pci_read_config_dword(dev, 0xF0, &rcba);
+	base = ioremap_nocache(rcba & 0xFFFFC000, 0x4000); /* use bits 31:14, 16KB aligned */
+	if (base = NULL) return;
+	val = readl(base + 0x3418); /* read the Function Disable register, dword mode only */
+	writel(val & 0xFFFFFFF7, base + 0x3418); /* enable the SMBus device */
+	iounmap(rcba);
+	printk(KERN_INFO "PCI: Enabled ICH6/i801 SMBus device\n");
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1,	asus_hides_smbus_lpc_ich6 );
+
 /*
  * SiS 96x south bridge: BIOS typically hides SMBus device...
  */
