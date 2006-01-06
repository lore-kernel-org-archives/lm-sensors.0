From: gregkh@suse.de (Greg KH)
Date: Fri, 06 Jan 2006 22:07:38 +0000
Subject: [lm-sensors] [PATCH] i2c: i2c-nforce2 add nforce4 MCP-04 device ID
Message-Id: <11365852582543@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: i2c-nforce2 add nforce4 MCP-04 device ID

One more supported PCI ID for the i2c-nforce2 driver.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
commit 7c72ccf09b6debe55b8e049377ad3183ed4f4cb3
tree d9a4cfd4074c90a7ea1565449c304dcde8693c32
parent a4787c0d232e16e727b37205dc647337b8974f35
author Jean Delvare <khali at linux-fr.org> Sun, 18 Dec 2005 17:25:18 +0100
committer Greg Kroah-Hartman <gregkh at suse.de> Thu, 05 Jan 2006 22:16:27 -0800

 Documentation/i2c/busses/i2c-nforce2 |    3 ++-
 drivers/i2c/busses/i2c-nforce2.c     |    2 ++
 include/linux/pci_ids.h              |    1 +
 3 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/Documentation/i2c/busses/i2c-nforce2 b/Documentation/i2c/busses/i2c-nforce2
index e379e18..d751282 100644
--- a/Documentation/i2c/busses/i2c-nforce2
+++ b/Documentation/i2c/busses/i2c-nforce2
@@ -5,7 +5,8 @@ Supported adapters:
   * nForce2 Ultra 400 MCP      10de:0084 
   * nForce3 Pro150 MCP         10de:00D4 
   * nForce3 250Gb MCP          10de:00E4 
-  * nForce4 MCP	       	       10de:0052
+  * nForce4 MCP                10de:0052
+  * nForce4 MCP-04             10de:0034
 
 Datasheet: not publically available, but seems to be similar to the
            AMD-8111 SMBus 2.0 adapter.
diff --git a/drivers/i2c/busses/i2c-nforce2.c b/drivers/i2c/busses/i2c-nforce2.c
index 4d18e6e..2d80eb2 100644
--- a/drivers/i2c/busses/i2c-nforce2.c
+++ b/drivers/i2c/busses/i2c-nforce2.c
@@ -30,6 +30,7 @@
     nForce3 Pro150 MCP		00D4
     nForce3 250Gb MCP		00E4
     nForce4 MCP			0052
+    nForce4 MCP-04		0034
 
     This driver supports the 2 SMBuses that are included in the MCP of the
     nForce2/3/4 chipsets.
@@ -257,6 +258,7 @@ static struct pci_device_id nforce2_ids[
 	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE4_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SMBUS) },
 	{ 0 }
 };
 
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 4f01710..96a0403 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -976,6 +976,7 @@
 #define PCI_DEVICE_ID_NVIDIA_TNT_UNKNOWN        0x002a
 #define PCI_DEVICE_ID_NVIDIA_VTNT2		0x002C
 #define PCI_DEVICE_ID_NVIDIA_UVTNT2		0x002D
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SMBUS	0x0034
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE	0x0035
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA	0x0036
 #define PCI_DEVICE_ID_NVIDIA_NVENET_10		0x0037


