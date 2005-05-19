From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:53 +0000
Subject: intel ESB rapid quirk fix
Message-Id: <4266914C.6040101@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

This patch only binds ACPI and GPIO IO space regions to southbridge.
Please can you test on that ASUS board this patch?

You can try before you apply:
cat /proc/ioports
after you reboot with the patch
cat /proc/ioports
2 new regions should be there. (round 0x400)

Thanks,
regards

Rudolf

diff -Naur a/drivers/pci/quirks.c c/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c	2005-04-04 18:37:51.000000000 +0200
+++ c/drivers/pci/quirks.c	2005-04-20 19:19:53.666568200 +0200
@@ -328,6 +328,7 @@
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801DB_0,		quirk_ich4_lpc_acpi );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801DB_12,	quirk_ich4_lpc_acpi );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801EB_0,		quirk_ich4_lpc_acpi );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_ESB_1,		quirk_ich4_lpc_acpi );

 /*
  * VIA ACPI: One IO region pointed to by longword at
