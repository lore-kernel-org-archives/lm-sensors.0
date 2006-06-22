From: greg@kroah.com (Greg KH)
Date: Thu, 22 Jun 2006 18:27:33 +0000
Subject: [lm-sensors] [PATCH 7/44] [PATCH] i2c-piix4: Add ATI IXP200/300/400
Message-Id: <11510009121292-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Rudolf Marek <r.marek at sh.cvut.cz>

This patch adds the ATI IXP southbridges support to i2c-piix4,
as it turned out those chips are compatible with it.

Signed-off-by: Rudolf Marek <r.marek at sh.cvut.cz>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 Documentation/i2c/busses/i2c-piix4 |    2 ++
 drivers/i2c/busses/Kconfig         |    5 ++++-
 drivers/i2c/busses/i2c-piix4.c     |    6 ++++++
 include/linux/pci_ids.h            |    3 +++
 4 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/Documentation/i2c/busses/i2c-piix4 b/Documentation/i2c/busses/i2c-piix4
index a1c8f58..6e6c905 100644
--- a/Documentation/i2c/busses/i2c-piix4
+++ b/Documentation/i2c/busses/i2c-piix4
@@ -6,6 +6,8 @@ Supported adapters:
     Datasheet: Publicly available at the Intel website
   * ServerWorks OSB4, CSB5, CSB6 and HT-1000 southbridges
     Datasheet: Only available via NDA from ServerWorks
+  * ATI IXP southbridges IXP200, IXP300, IXP400
+    Datasheet: Not publicly available
   * Standard Microsystems (SMSC) SLC90E66 (Victory66) southbridge
     Datasheet: Publicly available at the SMSC website http://www.smsc.com
 
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index d6d4494..e3450d1 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -163,7 +163,7 @@ config I2C_PXA_SLAVE
 	  I2C bus.
 
 config I2C_PIIX4
-	tristate "Intel PIIX4"
+	tristate "Intel PIIX4 and compatible (ATI/Serverworks/Broadcom/SMSC)"
 	depends on I2C && PCI
 	help
 	  If you say yes to this option, support will be included for the Intel
@@ -172,6 +172,9 @@ config I2C_PIIX4
 	  of Broadcom):
 	    Intel PIIX4
 	    Intel 440MX
+	    ATI IXP200
+	    ATI IXP300
+	    ATI IXP400
 	    Serverworks OSB4
 	    Serverworks CSB5
 	    Serverworks CSB6
diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index d9c7c00..5f06e81 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -413,6 +413,12 @@ static struct i2c_adapter piix4_adapter 
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
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index bcfe9d4..489af9d 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -352,8 +352,11 @@ #define PCI_DEVICE_ID_ATI_RS400_200     
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
 #define PCI_DEVICE_ID_ATI_IXP400_SATA2	0x437a
-- 
1.4.0


