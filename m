From: gregkh@suse.de (gregkh at suse.de)
Date: Fri, 16 Jun 2006 22:48:50 +0000
Subject: [lm-sensors] patch i2c-i801-06-merge-setup-function.patch added to
Message-Id: <20060616225143.E5127758119@imap.suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: [PATCH 11/14] i2c-i801: Merge setup function

to my gregkh-2.6 tree.  Its filename is

     i2c-i801-06-merge-setup-function.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


From khali at linux-fr.org Mon Jun 12 12:53:41 2006
Date: Mon, 12 Jun 2006 21:53:41 +0200
From: Jean Delvare <khali at linux-fr.org>
To: Greg KH <greg at kroah.com>
Cc: LM Sensors <lm-sensors at lm-sensors.org>
Subject: [PATCH 11/14] i2c-i801: Merge setup function
Message-Id: <20060612215341.cdc67d11.khali at linux-fr.org>
Content-Disposition: inline; filename=i2c-i801-06-merge-setup-function.patch

i2c-i801: Merge setup function

Merge i801_setup into i801_probe, as it doesn't make much sense to
have them split. This lets us handle errors better. Christopher
Hellwig had been suggesting this back in March 2003 when the driver
was merged.

Also drop two useless debug messages (revision and base address can be
obtained from lspci, procfs or sysfs.)

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

--- linux-2.6.17-rc6.orig/drivers/i2c/busses/i2c-i801.c	2006-06-08 15:16:31.000000000 +0200
+++ linux-2.6.17-rc6/drivers/i2c/busses/i2c-i801.c	2006-06-08 15:28:21.000000000 +0200
@@ -68,7 +68,6 @@
 /* PCI Address Constants */
 #define SMBBAR		4
 #define SMBHSTCFG	0x040
-#define SMBREV		0x008
 
 /* Host configuration bits for SMBHSTCFG */
 #define SMBHSTCFG_HST_EN	1
@@ -102,68 +101,6 @@
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
@@ -527,17 +464,69 @@
 
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
Jean Delvare



Patches currently in gregkh-2.6 which might be from khali at linux-fr.org are

i2c/hwmon-f71805f-no-global-resource.patch
i2c/hwmon-lm83-add-lm82-support.patch
i2c/hwmon-smsc47m192-new-driver.patch
i2c/hwmon-sysfs-interface-individual-alarm-files.patch
i2c/hwmon-w83627ehf-add-alarms.patch
i2c/hwmon-w83627ehf-add-voltages.patch
i2c/i2c-piix4-add-ati-smbus-support.patch
i2c/rtc-add-support-for-m41t81-m41t85-chips-to-m41t00-driver.patch
i2c/hwmon-hdaps-update-id-list.patch
i2c/rtc-m41t00-driver-cleanup.patch
i2c/i2c-nforce2-add-mcp51-mcp55-support.patch
i2c/i2c-piix4-fix-typo-in-documentation.patch
i2c/i2c-piix4-improve-ibm-error-message.patch
i2c/i2c-piix4-remove-fix_hstcfg-parameter.patch
i2c/hwmon-improve-Kconfig-help.patch
i2c/hwmon-lm83-documentation-update.patch
i2c/hwmon-vid-mask-per-vrm.patch
i2c/hwmon-w83791d-new-driver.patch
i2c/hwmon-abituguru-fixes.patch
i2c/hwmon-abituguru-new-driver.patch
i2c/hwmon-abituguru-nofans-detect-fix.patch
i2c/hwmon-hdaps-typo.patch
i2c/hwmon-maintenance-update.patch
i2c/hwmon-sysfs-interface-update-1.patch
i2c/hwmon-sysfs-interface-update-2.patch
i2c/hwmon-w83792d-add-data-lock.patch
i2c/hwmon-w83792d-pwm-set-fix.patch
i2c/i2c-Kconfig-suggest-N-for-rare-devices.patch
i2c/i2c-opencores-new-driver.patch
i2c/hwmon-kconfig-header-fix.patch
i2c/hwmon-lm70-new-driver.patch
i2c/hwmon-vid-add-core-and-conroe-support.patch
i2c/i2c-i801-01-fix-block-transaction-poll-loops.patch
i2c/i2c-i801-02-remove-force_addr-parameter.patch
i2c/i2c-i801-03-remove-pci-function-check.patch
i2c/i2c-i801-04-cleanups.patch
i2c/i2c-i801-05-better-pci-subsystem-integration.patch
i2c/i2c-i801-06-merge-setup-function.patch
i2c/i2c-mark-data-const-for-write-block.patch
i2c/i2c-opencores-cleanup.patch
i2c/i2c-scx200_acb-documentation-update.patch
i2c/i2c-scx200_acb-mark-scx200_acb_probe-init.patch
i2c/i2c-scx200_acb-use-PCI-IO-resource-when-appropriate.patch

