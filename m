From: devik@cdi.cz (Martin Devera)
Date: Wed, 15 Feb 2006 23:42:10 +0000
Subject: [lm-sensors] [PATCH 1/1] i2c: add BroadCom HT-1000 to i2c-piix
Message-Id: <E1F9WHi-0008EA-00@devix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Martin Devera <devik at cdi.cz>

Add BroadCom HT-1000 south bridge's PCI ID to i2c-piix driver. Note
that at least on Supermicro H8SSL it uses non-standard SMBHSTCFG = 3
and standard values like 0 or 9 causes hangup.

Signed-off-by: Martin Devera <devik at cdi.cz>
---
Kudos to Rudolf Marek for its helpful comments.

diff -ur a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
--- linux-2.6.14.3/drivers/i2c/busses/i2c-piix4.c	Tue Feb 14 17:03:23 2006
+++ linux-2.6.15.4/drivers/i2c/busses/i2c-piix4.c	Tue Feb 14 16:57:29 2006
@@ -419,6 +419,8 @@
 	  .driver_data = 0 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB6),
 	  .driver_data = 0 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_HT1000SB),
+	  .driver_data = 0 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82443MX_3),
 	  .driver_data = 3 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_SLC90E66_3),
diff -ur a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- linux-2.6.14.3/include/linux/pci_ids.h	Tue Feb 14 17:03:36 2006
+++ linux-2.6.15.4/include/linux/pci_ids.h	Tue Feb 14 16:55:16 2006
@@ -1343,6 +1343,7 @@
 #define PCI_DEVICE_ID_SERVERWORKS_OSB4	  0x0200
 #define PCI_DEVICE_ID_SERVERWORKS_CSB5	  0x0201
 #define PCI_DEVICE_ID_SERVERWORKS_CSB6    0x0203
+#define PCI_DEVICE_ID_SERVERWORKS_HT1000SB 0x0205
 #define PCI_DEVICE_ID_SERVERWORKS_OSB4IDE 0x0211
 #define PCI_DEVICE_ID_SERVERWORKS_CSB5IDE 0x0212
 #define PCI_DEVICE_ID_SERVERWORKS_CSB6IDE 0x0213

