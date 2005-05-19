From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: [PATCH 2.6] I2C: i2c-nforce2 supports the nForce3 250Gb
Message-Id: <20041217200217.3ed4e7cb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

One more PCI ID for the i2c-nforce2 driver, this time for the nForce3
250Gb variant. Tested, works.

(Also cleans up a duplicate define in pci_ids.h.)

Please apply,
thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.10-rc3/include/linux/pci_ids.h.orig	2004-12-05 17:33:58.000000000 +0100
+++ linux-2.6.10-rc3/include/linux/pci_ids.h	2004-12-17 19:45:43.000000000 +0100
@@ -1095,7 +1095,6 @@
 #define PCI_DEVICE_ID_NVIDIA_ITNT2		0x00A0
 #define PCI_DEVICE_ID_NVIDIA_NFORCE3		0x00d1
 #define PCI_DEVICE_ID_NVIDIA_MCP3_AUDIO		0x00da
-#define PCI_DEVICE_ID_NVIDIA_NFORCE3S  		0x00e1
 #define PCI_DEVICE_ID_NVIDIA_NFORCE3_SMBUS	0x00d4
 #define PCI_DEVICE_ID_NVIDIA_NFORCE3_IDE	0x00d5
 #define PCI_DEVICE_ID_NVIDIA_NVENET_3		0x00d6
@@ -1103,6 +1102,7 @@
 #define PCI_DEVICE_ID_NVIDIA_NVENET_7		0x00df
 #define PCI_DEVICE_ID_NVIDIA_NFORCE3S		0x00e1
 #define PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA	0x00e3
+#define PCI_DEVICE_ID_NVIDIA_NFORCE3S_SMBUS	0x00e4
 #define PCI_DEVICE_ID_NVIDIA_NFORCE3S_IDE	0x00e5
 #define PCI_DEVICE_ID_NVIDIA_NVENET_6		0x00e6
 #define PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2	0x00ee
--- linux-2.6.10-rc3/drivers/i2c/busses/i2c-nforce2.c.orig	2004-12-17 19:50:29.000000000 +0100
+++ linux-2.6.10-rc3/drivers/i2c/busses/i2c-nforce2.c	2004-12-17 19:46:33.000000000 +0100
@@ -28,6 +28,7 @@
     nForce2 MCP			0064
     nForce2 Ultra 400 MCP	0084
     nForce3 Pro150 MCP		00D4
+    nForce3 250Gb MCP		00E4
 
     This driver supports the 2 SMBuses that are included in the MCP2 of the
     nForce2 chipset.
@@ -296,6 +297,8 @@
 	       	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3_SMBUS,
 	       	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SMBUS,
+	       	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ 0 }
 };
 


-- 
Jean Delvare
http://khali.linux-fr.org/
