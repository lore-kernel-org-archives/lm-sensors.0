From: R.Marek@sh.cvut.cz (R.Marek@sh.cvut.cz)
Date: Tue, 27 Sep 2005 23:55:28 +0000
Subject: [lm-sensors] [PATCH] ICH6 ACPI and GPIO quirk
Message-Id: <20050927215451.19403.qmail@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

This patch just adds ACPI and GPIO regions to its LPC bridge, similar
way as ICH4 did. I would like to thank Michal Mleczko for testing.

Please apply.

Signed-Off-By: Rudolf Marek <r.marek@sh.cvut.cz>

Regards
Rudolf

diff -Naur c/drivers/pci/quirks.c d/drivers/pci/quirks.c
--- c/drivers/pci/quirks.c	2005-09-27 23:37:56.432160500 +0200
+++ d/drivers/pci/quirks.c	2005-09-27 23:38:22.197770750 +0200
@@ -339,6 +339,19 @@
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801EB_0,		quirk_ich4_lpc_acpi );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_ESB_1,		quirk_ich4_lpc_acpi );
 
+static void __devinit quirk_ich6_lpc_acpi(struct pci_dev *dev)
+{
+	        u32 region;
+
+	        pci_read_config_dword(dev, 0x40, &region);
+	        quirk_io_region(dev, region, 128, PCI_BRIDGE_RESOURCES);
+
+	        pci_read_config_dword(dev, 0x48, &region);
+	        quirk_io_region(dev, region, 64, PCI_BRIDGE_RESOURCES+1);
+}
+
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1, quirk_ich6_lpc_acpi );
+
 /*
  * VIA ACPI: One IO region pointed to by longword at
  *	0x48 or 0x20 (256 bytes of ACPI registers)
