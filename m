From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 23 Mar 2006 15:48:09 +0000
Subject: [lm-sensors] [PATCH 08/10] i2c-piix4: Add ATI IXP200/300/400 support
Message-Id: <20060323164809.cdcef765.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Rudolf Marek <r.marek at sh.cvut.cz>
Content-Disposition: inline; filename=i2c-piix4-add-ati-smbus-support.patch

This patch adds the ATI IXP southbridges support to i2c-piix4,
as it turned out those chips are compatible with it.

Signed-off-by: Rudolf Marek <r.marek at sh.cvut.cz>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 Documentation/i2c/busses/i2c-piix4 |    2 ++
 drivers/i2c/busses/Kconfig         |    5 ++++-
 drivers/i2c/busses/i2c-piix4.c     |    6 ++++++
 include/linux/pci_ids.h            |    3 +++
 4 files changed, 15 insertions(+), 1 deletion(-)

--- linux-2.6.16-rc6.orig/Documentation/i2c/busses/i2c-piix4	2006-03-13 21:41:04.000000000 +0100
+++ linux-2.6.16-rc6/Documentation/i2c/busses/i2c-piix4	2006-03-13 21:42:13.000000000 +0100
@@ -6,6 +6,8 @@
     Datasheet: Publicly available at the Intel website
   * ServerWorks OSB4, CSB5, CSB6 and HT-1000 southbridges
     Datasheet: Only available via NDA from ServerWorks
+  * ATI IXP southbridges IXP200, IXP300, IXP400
+    Datasheet: Not publicly available
   * Standard Microsystems (SMSC) SLC90E66 (Victory66) southbridge
     Datasheet: Publicly available at the SMSC website http://www.smsc.com
 
--- linux-2.6.16-rc6.orig/drivers/i2c/busses/i2c-piix4.c	2006-03-13 21:41:04.000000000 +0100
+++ linux-2.6.16-rc6/drivers/i2c/busses/i2c-piix4.c	2006-03-13 21:42:13.000000000 +0100
@@ -413,6 +413,12 @@
 static struct pci_device_id piix4_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_3),
 	  .driver_data = 3 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP200_SMBUS),
+	  .driver_data = 0 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP300_SMBUS),
+	  .driver_data = 0 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP400_SMBUS),
+	  .driver_data = 0 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_OSB4),
 	  .driver_data = 0 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB5),
--- linux-2.6.16-rc6.orig/drivers/i2c/busses/Kconfig	2006-03-13 21:41:04.000000000 +0100
+++ linux-2.6.16-rc6/drivers/i2c/busses/Kconfig	2006-03-13 21:42:13.000000000 +0100
@@ -163,7 +163,7 @@
 	  I2C bus.
 
 config I2C_PIIX4
-	tristate "Intel PIIX4"
+	tristate "Intel PIIX4 and compatible (ATI/Serverworks/Broadcom/SMSC)"
 	depends on I2C && PCI
 	help
 	  If you say yes to this option, support will be included for the Intel
@@ -172,6 +172,9 @@
 	  of Broadcom):
 	    Intel PIIX4
 	    Intel 440MX
+	    ATI IXP200
+	    ATI IXP300
+	    ATI IXP400
 	    Serverworks OSB4
 	    Serverworks CSB5
 	    Serverworks CSB6
--- linux-2.6.16-rc6.orig/include/linux/pci_ids.h	2006-03-13 21:41:04.000000000 +0100
+++ linux-2.6.16-rc6/include/linux/pci_ids.h	2006-03-13 21:42:13.000000000 +0100
@@ -351,8 +351,11 @@
 #define PCI_DEVICE_ID_ATI_RS480         0x5950
 /* ATI IXP Chipset */
 #define PCI_DEVICE_ID_ATI_IXP200_IDE	0x4349
+#define PCI_DEVICE_ID_ATI_IXP200_SMBUS	0x4353
+#define PCI_DEVICE_ID_ATI_IXP300_SMBUS	0x4363
 #define PCI_DEVICE_ID_ATI_IXP300_IDE	0x4369
 #define PCI_DEVICE_ID_ATI_IXP300_SATA   0x436e
+#define PCI_DEVICE_ID_ATI_IXP400_SMBUS	0x4372
 #define PCI_DEVICE_ID_ATI_IXP400_IDE	0x4376
 #define PCI_DEVICE_ID_ATI_IXP400_SATA   0x4379
 

-- 
Jean Delvare

