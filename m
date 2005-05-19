From: R.Marek@sh.cvut.cz (R.Marek@sh.cvut.cz)
Date: Thu, 19 May 2005 06:25:53 +0000
Subject: [PATCH] Rapid Hance quirk
Message-Id: <20050421104906.17401.qmail@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

This patch just adds Intel's Hance Rapid south bridge IDs to ICH4 region quirk.
Patch was successfuly tested by Chunhao Huang from Winbond.

Signed-Off-By: Rudolf Marek <r.marek@sh.cvut.cz>

Please apply.
Thanks

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
