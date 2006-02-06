From: gregkh@suse.de (Greg KH)
Date: Mon, 06 Feb 2006 20:18:57 +0000
Subject: [lm-sensors] [PATCH] i2c-i801: I2C patch for Intel ICH8
Message-Id: <11392571373264@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c-i801: I2C patch for Intel ICH8

This patch adds the Intel ICH8 DID to the i2c-i801.c and Kconfig files for I2C
support.

Signed-off-by: Jason Gaston <Jason.d.gaston at intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
commit 8254fc4afcc81e69428c453cc216aa612c80e98b
tree 812d22ca03a3fd1067136061c47d3c93e9be97fa
parent e3f749c4af69c4344d89f11e2293e3790eb4eaca
author Jason Gaston <jason.d.gaston at intel.com> Mon, 09 Jan 2006 10:58:08 -0800
committer Greg Kroah-Hartman <gregkh at suse.de> Mon, 06 Feb 2006 12:02:14 -0800

 drivers/i2c/busses/Kconfig    |    1 +
 drivers/i2c/busses/i2c-i801.c |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 08d5b8f..ff92735 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -124,6 +124,7 @@ config I2C_I801
 	    ICH6
 	    ICH7
 	    ESB2
+	    ICH8
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-i801.
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 1c752dd..8e0f315 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -32,6 +32,7 @@
     ICH6		266A
     ICH7		27DA
     ESB2		269B
+    ICH8		283E
     This driver supports several versions of Intel's I/O Controller Hubs (ICH).
     For SMBus support, they are similar to the PIIX4 and are part
     of Intel's '810' and other chipsets.
@@ -527,6 +528,7 @@ static struct pci_device_id i801_ids[]  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_16) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_17) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB2_17) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH8_5) },
 	{ 0, }
 };
 


