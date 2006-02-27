From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 27 Feb 2006 22:11:45 +0000
Subject: [lm-sensors] [PATCH 3/6] i2c-piix4: Add Broadcom HT-1000 support
Message-Id: <20060227231145.6e298d84.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Martin Devera <devik at cdi.cz>
Content-Disposition: inline; filename=i2c-piix4-add-ht1000-support.patch

Add Broadcom HT-1000 south bridge's PCI ID to i2c-piix driver. Note
that at least on Supermicro H8SSL it uses non-standard SMBHSTCFG = 3
and standard values like 0 or 9 causes hangup.

Signed-off-by: Martin Devera <devik at cdi.cz>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 Documentation/i2c/busses/i2c-piix4 |    2 +-
 drivers/i2c/busses/Kconfig         |    4 +++-
 drivers/i2c/busses/i2c-piix4.c     |    4 +++-
 include/linux/pci_ids.h            |    1 +
 4 files changed, 8 insertions(+), 3 deletions(-)

--- linux-2.6.16-rc4.orig/Documentation/i2c/busses/i2c-piix4	2006-02-22 20:18:46.000000000 +0100
+++ linux-2.6.16-rc4/Documentation/i2c/busses/i2c-piix4	2006-02-22 20:59:06.000000000 +0100
@@ -4,7 +4,7 @@
   * Intel 82371AB PIIX4 and PIIX4E
   * Intel 82443MX (440MX)
     Datasheet: Publicly available at the Intel website
-  * ServerWorks OSB4, CSB5 and CSB6 southbridges
+  * ServerWorks OSB4, CSB5, CSB6 and HT-1000 southbridges
     Datasheet: Only available via NDA from ServerWorks
   * Standard Microsystems (SMSC) SLC90E66 (Victory66) southbridge
     Datasheet: Publicly available at the SMSC website http://www.smsc.com
--- linux-2.6.16-rc4.orig/drivers/i2c/busses/Kconfig	2006-02-22 20:18:46.000000000 +0100
+++ linux-2.6.16-rc4/drivers/i2c/busses/Kconfig	2006-02-22 20:22:00.000000000 +0100
@@ -168,12 +168,14 @@
 	help
 	  If you say yes to this option, support will be included for the Intel
 	  PIIX4 family of mainboard I2C interfaces.  Specifically, the following
-	  versions of the chipset are supported:
+	  versions of the chipset are supported (note that Serverworks is part
+	  of Broadcom):
 	    Intel PIIX4
 	    Intel 440MX
 	    Serverworks OSB4
 	    Serverworks CSB5
 	    Serverworks CSB6
+	    Serverworks HT-1000
 	    SMSC Victory66
 
 	  This driver can also be built as a module.  If so, the module
--- linux-2.6.16-rc4.orig/drivers/i2c/busses/i2c-piix4.c	2006-02-22 20:18:46.000000000 +0100
+++ linux-2.6.16-rc4/drivers/i2c/busses/i2c-piix4.c	2006-02-22 20:58:52.000000000 +0100
@@ -22,7 +22,7 @@
 /*
    Supports:
 	Intel PIIX4, 440MX
-	Serverworks OSB4, CSB5, CSB6
+	Serverworks OSB4, CSB5, CSB6, HT-1000
 	SMSC Victory66
 
    Note: we assume there can only be one device, with one SMBus interface.
@@ -419,6 +419,8 @@
 	  .driver_data = 0 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB6),
 	  .driver_data = 0 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_HT1000SB),
+	  .driver_data = 0 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82443MX_3),
 	  .driver_data = 3 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_SLC90E66_3),
--- linux-2.6.16-rc4.orig/include/linux/pci_ids.h	2006-02-22 20:18:46.000000000 +0100
+++ linux-2.6.16-rc4/include/linux/pci_ids.h	2006-02-22 20:22:00.000000000 +0100
@@ -1368,6 +1368,7 @@
 #define PCI_DEVICE_ID_SERVERWORKS_OSB4	  0x0200
 #define PCI_DEVICE_ID_SERVERWORKS_CSB5	  0x0201
 #define PCI_DEVICE_ID_SERVERWORKS_CSB6    0x0203
+#define PCI_DEVICE_ID_SERVERWORKS_HT1000SB 0x0205
 #define PCI_DEVICE_ID_SERVERWORKS_OSB4IDE 0x0211
 #define PCI_DEVICE_ID_SERVERWORKS_CSB5IDE 0x0212
 #define PCI_DEVICE_ID_SERVERWORKS_CSB6IDE 0x0213

-- 
Jean Delvare

