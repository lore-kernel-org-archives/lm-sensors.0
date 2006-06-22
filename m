From: greg@kroah.com (Greg KH)
Date: Thu, 22 Jun 2006 18:28:06 +0000
Subject: [lm-sensors] [PATCH 40/44] [PATCH] i2c-i801: Merge setup function
Message-Id: <11510010492312-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

i2c-i801: Merge setup function

Merge i801_setup into i801_probe, as it doesn't make much sense to
have them split. This lets us handle errors better. Christopher
Hellwig had been suggesting this back in March 2003 when the driver
was merged.

Also drop two useless debug messages (revision and base address can be
obtained from lspci, procfs or sysfs.)

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/i2c/busses/i2c-i801.c |  121 +++++++++++++++++++----------------------
 1 files changed, 55 insertions(+), 66 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 94a30f5..3e0d04d 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -68,7 +68,6 @@ #define SMBAUXCTL	(13 + i801_smba)	/* IC
 /* PCI Address Constants */
 #define SMBBAR		4
 #define SMBHSTCFG	0x040
-#define SMBREV		0x008
 
 /* Host configuration bits for SMBHSTCFG */
 #define SMBHSTCFG_HST_EN	1
@@ -102,68 +101,6 @@ static struct pci_driver i801_driver;
 static struct pci_dev *I801_dev;
 static int isich4;
 
-static int __devinit i801_setup(struct pci_dev *dev)
-{
-	unsigned char temp;
-	int err;
-
-	I801_dev = dev;
-	if ((dev->device = PCI_DEVICE_ID_INTEL_82801DB_3) ||
-	    (dev->device = PCI_DEVICE_ID_INTEL_82801EB_3) ||
-	    (dev->device = PCI_DEVICE_ID_INTEL_ESB_4))
-		isich4 = 1;
-	else
-		isich4 = 0;
-
-	err = pci_enable_device(dev);
-	if (err) {
-		dev_err(&dev->dev, "Failed to enable SMBus device (%d)\n",
-			err);
-		goto exit;
-	}
-
-	/* Determine the address of the SMBus area */
-	i801_smba = pci_resource_start(dev, SMBBAR);
-	if (!i801_smba) {
-		dev_err(&dev->dev, "SMBus base address uninitialized, "
-			"upgrade BIOS\n");
-		err = -ENODEV;
-		goto exit_disable;
-	}
-
-	err = pci_request_region(dev, SMBBAR, i801_driver.name);
-	if (err) {
-		dev_err(&dev->dev, "Failed to request SMBus region "
-			"0x%lx-0x%lx\n", i801_smba,
-			pci_resource_end(dev, SMBBAR));
-		goto exit_disable;
-	}
-
-	pci_read_config_byte(I801_dev, SMBHSTCFG, &temp);
-	temp &= ~SMBHSTCFG_I2C_EN;	/* SMBus timing */
-	if (!(temp & SMBHSTCFG_HST_EN)) {
-		dev_warn(&dev->dev, "enabling SMBus device\n");
-		temp |= SMBHSTCFG_HST_EN;
-	}
-	pci_write_config_byte(I801_dev, SMBHSTCFG, temp);
-
-	if (temp & SMBHSTCFG_SMB_SMI_EN)
-		dev_dbg(&dev->dev, "I801 using Interrupt SMI# for SMBus.\n");
-	else
-		dev_dbg(&dev->dev, "I801 using PCI Interrupt for SMBus.\n");
-
-	pci_read_config_byte(I801_dev, SMBREV, &temp);
-	dev_dbg(&dev->dev, "SMBREV = 0x%X\n", temp);
-	dev_dbg(&dev->dev, "I801_smba = 0x%X\n", i801_smba);
-
-	return 0;
-
-exit_disable:
-	pci_disable_device(dev);
-exit:
-	return err;
-}
-
 static int i801_transaction(void)
 {
 	int temp;
@@ -527,17 +464,69 @@ MODULE_DEVICE_TABLE (pci, i801_ids);
 
 static int __devinit i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
+	unsigned char temp;
 	int err;
 
-	if ((err = i801_setup(dev)))
-		return err;
+	I801_dev = dev;
+	if ((dev->device = PCI_DEVICE_ID_INTEL_82801DB_3) ||
+	    (dev->device = PCI_DEVICE_ID_INTEL_82801EB_3) ||
+	    (dev->device = PCI_DEVICE_ID_INTEL_ESB_4))
+		isich4 = 1;
+	else
+		isich4 = 0;
+
+	err = pci_enable_device(dev);
+	if (err) {
+		dev_err(&dev->dev, "Failed to enable SMBus PCI device (%d)\n",
+			err);
+		goto exit;
+	}
+
+	/* Determine the address of the SMBus area */
+	i801_smba = pci_resource_start(dev, SMBBAR);
+	if (!i801_smba) {
+		dev_err(&dev->dev, "SMBus base address uninitialized, "
+			"upgrade BIOS\n");
+		err = -ENODEV;
+		goto exit_disable;
+	}
+
+	err = pci_request_region(dev, SMBBAR, i801_driver.name);
+	if (err) {
+		dev_err(&dev->dev, "Failed to request SMBus region "
+			"0x%lx-0x%lx\n", i801_smba,
+			pci_resource_end(dev, SMBBAR));
+		goto exit_disable;
+	}
+
+	pci_read_config_byte(I801_dev, SMBHSTCFG, &temp);
+	temp &= ~SMBHSTCFG_I2C_EN;	/* SMBus timing */
+	if (!(temp & SMBHSTCFG_HST_EN)) {
+		dev_info(&dev->dev, "Enabling SMBus device\n");
+		temp |= SMBHSTCFG_HST_EN;
+	}
+	pci_write_config_byte(I801_dev, SMBHSTCFG, temp);
+
+	if (temp & SMBHSTCFG_SMB_SMI_EN)
+		dev_dbg(&dev->dev, "SMBus using interrupt SMI#\n");
+	else
+		dev_dbg(&dev->dev, "SMBus using PCI Interrupt\n");
 
 	/* set up the driverfs linkage to our parent device */
 	i801_adapter.dev.parent = &dev->dev;
 
 	snprintf(i801_adapter.name, I2C_NAME_SIZE,
 		"SMBus I801 adapter at %04lx", i801_smba);
-	return i2c_add_adapter(&i801_adapter);
+	err = i2c_add_adapter(&i801_adapter);
+	if (err) {
+		dev_err(&dev->dev, "Failed to add SMBus adapter\n");
+		goto exit_disable;
+	}
+
+exit_disable:
+	pci_disable_device(dev);
+exit:
+	return err;
 }
 
 static void __devexit i801_remove(struct pci_dev *dev)
-- 
1.4.0


