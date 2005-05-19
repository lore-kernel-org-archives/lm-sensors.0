From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: [PATCH 2.6] Add support for the nForce2 Ultra 400 to i2c-nforce2
Message-Id: <20041129220347.737b1705.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

This simple patch adds support for the nForce2 Ultra 400 to i2c-nforce2.
I just made a similar update on the 2.4/CVS version of the driver.

Please apply,
thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.10-rc2/include/linux/pci_ids.h.orig	2004-11-28 11:35:35.000000000 +0100
+++ linux-2.6.10-rc2/include/linux/pci_ids.h	2004-11-29 21:42:46.000000000 +0100
@@ -1086,6 +1086,7 @@
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE	0x0065
 #define PCI_DEVICE_ID_NVIDIA_NVENET_2		0x0066
 #define PCI_DEVICE_ID_NVIDIA_MCP2_AUDIO		0x006a
+#define PCI_DEVICE_ID_NVIDIA_NFORCE2S_SMBUS	0x0084
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2S_IDE	0x0085
 #define PCI_DEVICE_ID_NVIDIA_NVENET_4		0x0086
 #define PCI_DEVICE_ID_NVIDIA_NVENET_5		0x008c
--- linux-2.6.10-rc2/drivers/i2c/busses/i2c-nforce2.c.orig	2004-11-29 21:45:26.000000000 +0100
+++ linux-2.6.10-rc2/drivers/i2c/busses/i2c-nforce2.c	2004-11-29 21:46:06.000000000 +0100
@@ -24,9 +24,10 @@
 */
 
 /*
-    SUPPORTED DEVICES	PCI ID
-    nForce2 MCP		0064
-    nForce3 Pro150 MCP	00D4
+    SUPPORTED DEVICES		PCI ID
+    nForce2 MCP			0064
+    nForce2 Ultra 400 MCP	0084
+    nForce3 Pro150 MCP		00D4
 
     This driver supports the 2 SMBuses that are included in the MCP2 of the
     nForce2 chipset.
@@ -291,6 +292,8 @@
 static struct pci_device_id nforce2_ids[] = {
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2_SMBUS,
 	       	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2S_SMBUS,
+	       	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3_SMBUS,
 	       	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ 0 }


-- 
Jean Delvare
http://khali.linux-fr.org/
