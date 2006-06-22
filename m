From: greg@kroah.com (Greg KH)
Date: Thu, 22 Jun 2006 18:28:04 +0000
Subject: [lm-sensors] [PATCH 38/44] [PATCH] i2c-i801: Cleanups
Message-Id: <11510010421299-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

i2c-i801: Cleanups

Various cleanups to the i2c-i801 driver:
* Fix documentation file and self file name references.
* i801_setup can be marked __devinit.
* Drop useless error local variable and label in i801_setup.
* Avoid a double PCI configuration register write in some cases.
* Use symbolic names for SMBHSTCFG bits.
* Transmit the error code returned by i801_setup instead of forcing it
  to an arbitrary value.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/i2c/busses/i2c-i801.c |   32 +++++++++++++-------------------
 1 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index b651493..b9e6fac 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1,5 +1,5 @@
 /*
-    i801.c - Part of lm_sensors, Linux kernel modules for hardware
+    i2c-i801.c - Part of lm_sensors, Linux kernel modules for hardware
               monitoring
     Copyright (c) 1998 - 2002  Frodo Looijaard <frodol at dds.nl>,
     Philip Edelbrock <phil at netroedge.com>, and Mark D. Studebaker
@@ -36,7 +36,7 @@
     This driver supports several versions of Intel's I/O Controller Hubs (ICH).
     For SMBus support, they are similar to the PIIX4 and are part
     of Intel's '810' and other chipsets.
-    See the doc/busses/i2c-i801 file for details.
+    See the file Documentation/i2c/busses/i2c-i801 for details.
     I2C Block Read and Process Call are not supported.
 */
 
@@ -102,9 +102,8 @@ static struct pci_driver i801_driver;
 static struct pci_dev *I801_dev;
 static int isich4;
 
-static int i801_setup(struct pci_dev *dev)
+static int __devinit i801_setup(struct pci_dev *dev)
 {
-	int error_return = 0;
 	unsigned char temp;
 
 	I801_dev = dev;
@@ -115,7 +114,7 @@ static int i801_setup(struct pci_dev *de
 	else
 		isich4 = 0;
 
-	/* Determine the address of the SMBus areas */
+	/* Determine the address of the SMBus area */
 	pci_read_config_word(I801_dev, SMBBA, &i801_smba);
 	i801_smba &= 0xfff0;
 	if (!i801_smba) {
@@ -127,20 +126,18 @@ static int i801_setup(struct pci_dev *de
 	if (!request_region(i801_smba, (isich4 ? 16 : 8), i801_driver.name)) {
 		dev_err(&dev->dev, "I801_smb region 0x%x already in use!\n",
 			i801_smba);
-		error_return = -EBUSY;
-		goto END;
+		return -EBUSY;
 	}
 
 	pci_read_config_byte(I801_dev, SMBHSTCFG, &temp);
 	temp &= ~SMBHSTCFG_I2C_EN;	/* SMBus timing */
-	pci_write_config_byte(I801_dev, SMBHSTCFG, temp);
-
-	if (!(temp & 1)) {
-		pci_write_config_byte(I801_dev, SMBHSTCFG, temp | 1);
+	if (!(temp & SMBHSTCFG_HST_EN)) {
 		dev_warn(&dev->dev, "enabling SMBus device\n");
+		temp |= SMBHSTCFG_HST_EN;
 	}
+	pci_write_config_byte(I801_dev, SMBHSTCFG, temp);
 
-	if (temp & 0x02)
+	if (temp & SMBHSTCFG_SMB_SMI_EN)
 		dev_dbg(&dev->dev, "I801 using Interrupt SMI# for SMBus.\n");
 	else
 		dev_dbg(&dev->dev, "I801 using PCI Interrupt for SMBus.\n");
@@ -149,8 +146,7 @@ static int i801_setup(struct pci_dev *de
 	dev_dbg(&dev->dev, "SMBREV = 0x%X\n", temp);
 	dev_dbg(&dev->dev, "I801_smba = 0x%X\n", i801_smba);
 
-END:
-	return error_return;
+	return 0;
 }
 
 static int i801_transaction(void)
@@ -516,12 +512,10 @@ MODULE_DEVICE_TABLE (pci, i801_ids);
 
 static int __devinit i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
+	int err;
 
-	if (i801_setup(dev)) {
-		dev_warn(&dev->dev,
-			"I801 not detected, module not inserted.\n");
-		return -ENODEV;
-	}
+	if ((err = i801_setup(dev)))
+		return err;
 
 	/* set up the driverfs linkage to our parent device */
 	i801_adapter.dev.parent = &dev->dev;
-- 
1.4.0


