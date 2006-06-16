From: gregkh@suse.de (gregkh at suse.de)
Date: Fri, 16 Jun 2006 22:48:43 +0000
Subject: [lm-sensors] patch
Message-Id: <20060616225136.A81BA758119@imap.suse.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060502054527.8533748769D@imap.suse.de>
In-Reply-To: <20060502054527.8533748769D@imap.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: [PATCH 10/14] i2c-i801: Better pci subsystem integration

to my gregkh-2.6 tree.  Its filename is

     i2c-i801-05-better-pci-subsystem-integration.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


From khali at linux-fr.org Mon Jun 12 12:53:08 2006
Date: Mon, 12 Jun 2006 21:53:02 +0200
From: Jean Delvare <khali at linux-fr.org>
To: Greg KH <greg at kroah.com>
Cc: LM Sensors <lm-sensors at lm-sensors.org>
Subject: [PATCH 10/14] i2c-i801: Better pci subsystem integration
Message-Id: <20060612215302.3540ed7b.khali at linux-fr.org>
Content-Disposition: inline; filename=i2c-i801-05-better-pci-subsystem-integration.patch

i2c-i801: Better pci subsystem integration

Integrate the i2c-i801 driver better with the pci subsystem, by
calling pci_{enable,disable}_device and requesting the I/O region
by BAR rather than direct configuration space access.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

--- linux-2.6.17-rc6.orig/drivers/i2c/busses/i2c-i801.c	2006-06-08 14:41:14.000000000 +0200
+++ linux-2.6.17-rc6/drivers/i2c/busses/i2c-i801.c	2006-06-08 15:03:13.000000000 +0200
@@ -66,7 +66,7 @@
 #define SMBAUXCTL	(13 + i801_smba)	/* ICH4 only */
 
 /* PCI Address Constants */
-#define SMBBA		0x020
+#define SMBBAR		4
 #define SMBHSTCFG	0x040
 #define SMBREV		0x008
 
@@ -97,7 +97,7 @@
 static int i801_block_transaction(union i2c_smbus_data *data, char read_write,
 				  int command, int hwpec);
 
-static unsigned short i801_smba;
+static unsigned long i801_smba;
 static struct pci_driver i801_driver;
 static struct pci_dev *I801_dev;
 static int isich4;
@@ -105,6 +105,7 @@
 static int __devinit i801_setup(struct pci_dev *dev)
 {
 	unsigned char temp;
+	int err;
 
 	I801_dev = dev;
 	if ((dev->device = PCI_DEVICE_ID_INTEL_82801DB_3) ||
@@ -114,19 +115,28 @@
 	else
 		isich4 = 0;
 
+	err = pci_enable_device(dev);
+	if (err) {
+		dev_err(&dev->dev, "Failed to enable SMBus device (%d)\n",
+			err);
+		goto exit;
+	}
+
 	/* Determine the address of the SMBus area */
-	pci_read_config_word(I801_dev, SMBBA, &i801_smba);
-	i801_smba &= 0xfff0;
+	i801_smba = pci_resource_start(dev, SMBBAR);
 	if (!i801_smba) {
 		dev_err(&dev->dev, "SMBus base address uninitialized, "
 			"upgrade BIOS\n");
-		return -ENODEV;
+		err = -ENODEV;
+		goto exit_disable;
 	}
 
-	if (!request_region(i801_smba, (isich4 ? 16 : 8), i801_driver.name)) {
-		dev_err(&dev->dev, "I801_smb region 0x%x already in use!\n",
-			i801_smba);
-		return -EBUSY;
+	err = pci_request_region(dev, SMBBAR, i801_driver.name);
+	if (err) {
+		dev_err(&dev->dev, "Failed to request SMBus region "
+			"0x%lx-0x%lx\n", i801_smba,
+			pci_resource_end(dev, SMBBAR));
+		goto exit_disable;
 	}
 
 	pci_read_config_byte(I801_dev, SMBHSTCFG, &temp);
@@ -147,6 +157,11 @@
 	dev_dbg(&dev->dev, "I801_smba = 0x%X\n", i801_smba);
 
 	return 0;
+
+exit_disable:
+	pci_disable_device(dev);
+exit:
+	return err;
 }
 
 static int i801_transaction(void)
@@ -521,14 +536,15 @@
 	i801_adapter.dev.parent = &dev->dev;
 
 	snprintf(i801_adapter.name, I2C_NAME_SIZE,
-		"SMBus I801 adapter at %04x", i801_smba);
+		"SMBus I801 adapter at %04lx", i801_smba);
 	return i2c_add_adapter(&i801_adapter);
 }
 
 static void __devexit i801_remove(struct pci_dev *dev)
 {
 	i2c_del_adapter(&i801_adapter);
-	release_region(i801_smba, (isich4 ? 16 : 8));
+	pci_release_region(dev, SMBBAR);
+	pci_disable_device(dev);
 }
 
 static struct pci_driver i801_driver = {

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

