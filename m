From: greg@kroah.com (Greg KH)
Date: Wed, 27 Sep 2006 01:01:56 +0000
Subject: [lm-sensors] [PATCH 25/30] i2c-viapro: Add support for the VT8237A
Message-Id: <11593190063112-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Rudolf Marek <r.marek at sh.cvut.cz>

i2c-viapro: Add support for the VT8237A and VT8251

Documentation update included. Compile tested.

Signed-off-by: Rudolf Marek <r.marek at sh.cvut.cz>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 Documentation/i2c/busses/i2c-viapro |    7 ++++++-
 drivers/i2c/busses/Kconfig          |   18 +++++++++---------
 drivers/i2c/busses/i2c-viapro.c     |    8 ++++++++
 3 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/Documentation/i2c/busses/i2c-viapro b/Documentation/i2c/busses/i2c-viapro
index 1677566..2568034 100644
--- a/Documentation/i2c/busses/i2c-viapro
+++ b/Documentation/i2c/busses/i2c-viapro
@@ -7,9 +7,12 @@ Supported adapters:
   * VIA Technologies, Inc. VT82C686A/B
     Datasheet: Sometimes available at the VIA website
 
-  * VIA Technologies, Inc. VT8231, VT8233, VT8233A, VT8235, VT8237R
+  * VIA Technologies, Inc. VT8231, VT8233, VT8233A
     Datasheet: available on request from VIA
 
+  * VIA Technologies, Inc. VT8235, VT8237R, VT8237A, VT8251
+    Datasheet: available on request and under NDA from VIA
+
 Authors:
 	Ky?sti M?lkki <kmalkki at cc.hut.fi>,
 	Mark D. Studebaker <mdsxyz123 at yahoo.com>,
@@ -39,6 +42,8 @@ Your lspci -n listing must show one of t
  device 1106:8235   (VT8231 function 4)
  device 1106:3177   (VT8235)
  device 1106:3227   (VT8237R)
+ device 1106:3337   (VT8237A)
+ device 1106:3287   (VT8251)
 
 If none of these show up, you should look in the BIOS for settings like
 enable ACPI / SMBus or even USB.
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 1df3bd9..9e56c39 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -492,19 +492,19 @@ config I2C_VIA
 	  will be called i2c-via.
 
 config I2C_VIAPRO
-	tristate "VIA 82C596/82C686/823x"
+	tristate "VIA 82C596/82C686/82xx"
 	depends on I2C && PCI
 	help
 	  If you say yes to this option, support will be included for the VIA
-	  82C596/82C686/823x I2C interfaces.  Specifically, the following 
+	  82C596/82C686/82xx I2C interfaces.  Specifically, the following
 	  chipsets are supported:
-	  82C596A/B
-	  82C686A/B
-	  8231
-	  8233
-	  8233A
-	  8235
-	  8237
+	    VT82C596A/B
+	    VT82C686A/B
+	    VT8231
+	    VT8233/A
+	    VT8235
+	    VT8237R/A
+	    VT8251
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-viapro.
diff --git a/drivers/i2c/busses/i2c-viapro.c b/drivers/i2c/busses/i2c-viapro.c
index 47e52bf..1ccc0fb 100644
--- a/drivers/i2c/busses/i2c-viapro.c
+++ b/drivers/i2c/busses/i2c-viapro.c
@@ -34,6 +34,8 @@
    VT8233A            0x3147             yes?
    VT8235             0x3177             yes
    VT8237R            0x3227             yes
+   VT8237A            0x3337             yes
+   VT8251             0x3287             yes
 
    Note: we assume there can only be one device, with one SMBus interface.
 */
@@ -381,7 +383,9 @@ found:
 	dev_dbg(&pdev->dev, "VT596_smba = 0x%X\n", vt596_smba);
 
 	switch (pdev->device) {
+	case PCI_DEVICE_ID_VIA_8251:
 	case PCI_DEVICE_ID_VIA_8237:
+	case PCI_DEVICE_ID_VIA_8237A:
 	case PCI_DEVICE_ID_VIA_8235:
 	case PCI_DEVICE_ID_VIA_8233A:
 	case PCI_DEVICE_ID_VIA_8233_0:
@@ -432,8 +436,12 @@ static struct pci_device_id vt596_ids[] 
 	  .driver_data = SMBBA3 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8237),
 	  .driver_data = SMBBA3 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8237A),
+	  .driver_data = SMBBA3 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8231_4),
 	  .driver_data = SMBBA1 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8251),
+	  .driver_data = SMBBA3 },
 	{ 0, }
 };
 
-- 
1.4.2.1


