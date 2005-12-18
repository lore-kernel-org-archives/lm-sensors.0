From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 18 Dec 2005 16:25:18 +0000
Subject: [lm-sensors] [PATCH 11/11] i2c: i2c-nforce2 add nforce4 MCP-04
Message-Id: <20051218172518.73a00f8d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=i2c-nforce2-support-nforce4-mcp04.patch

One more supported PCI ID for the i2c-nforce2 driver.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 Documentation/i2c/busses/i2c-nforce2 |    3 ++-
 drivers/i2c/busses/i2c-nforce2.c     |    2 ++
 include/linux/pci_ids.h              |    1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

--- linux-2.6.15-rc5.orig/drivers/i2c/busses/i2c-nforce2.c	2005-12-18 08:52:24.000000000 +0100
+++ linux-2.6.15-rc5/drivers/i2c/busses/i2c-nforce2.c	2005-12-18 11:09:40.000000000 +0100
@@ -30,6 +30,7 @@
     nForce3 Pro150 MCP		00D4
     nForce3 250Gb MCP		00E4
     nForce4 MCP			0052
+    nForce4 MCP-04		0034
 
     This driver supports the 2 SMBuses that are included in the MCP of the
     nForce2/3/4 chipsets.
@@ -257,6 +258,7 @@
 	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE4_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SMBUS) },
 	{ 0 }
 };
 
--- linux-2.6.15-rc5.orig/Documentation/i2c/busses/i2c-nforce2	2005-12-18 08:52:24.000000000 +0100
+++ linux-2.6.15-rc5/Documentation/i2c/busses/i2c-nforce2	2005-12-18 11:12:21.000000000 +0100
@@ -5,7 +5,8 @@
   * nForce2 Ultra 400 MCP      10de:0084 
   * nForce3 Pro150 MCP         10de:00D4 
   * nForce3 250Gb MCP          10de:00E4 
-  * nForce4 MCP	       	       10de:0052
+  * nForce4 MCP                10de:0052
+  * nForce4 MCP-04             10de:0034
 
 Datasheet: not publically available, but seems to be similar to the
            AMD-8111 SMBus 2.0 adapter.
--- linux-2.6.15-rc5.orig/include/linux/pci_ids.h	2005-12-18 08:52:24.000000000 +0100
+++ linux-2.6.15-rc5/include/linux/pci_ids.h	2005-12-18 11:09:40.000000000 +0100
@@ -971,6 +971,7 @@
 #define PCI_DEVICE_ID_NVIDIA_TNT_UNKNOWN        0x002a
 #define PCI_DEVICE_ID_NVIDIA_VTNT2		0x002C
 #define PCI_DEVICE_ID_NVIDIA_UVTNT2		0x002D
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SMBUS	0x0034
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE	0x0035
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA	0x0036
 #define PCI_DEVICE_ID_NVIDIA_NVENET_10		0x0037

-- 
Jean Delvare

