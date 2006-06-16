From: gregkh@suse.de (gregkh at suse.de)
Date: Fri, 16 Jun 2006 22:48:18 +0000
Subject: [lm-sensors] patch i2c-i801-02-remove-force_addr-parameter.patch
Message-Id: <20060616225112.3EBB07597E2@imap.suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: [PATCH 07/14] i2c-i801: Remove force_addr parameter

to my gregkh-2.6 tree.  Its filename is

     i2c-i801-02-remove-force_addr-parameter.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


From khali at linux-fr.org Mon Jun 12 12:50:22 2006
Date: Mon, 12 Jun 2006 21:50:11 +0200
From: Jean Delvare <khali at linux-fr.org>
To: Greg KH <greg at kroah.com>
Cc: LM Sensors <lm-sensors at lm-sensors.org>
Subject: [PATCH 07/14] i2c-i801: Remove force_addr parameter
Message-Id: <20060612215011.c5843671.khali at linux-fr.org>
Content-Disposition: inline; filename=i2c-i801-02-remove-force_addr-parameter.patch

i2c-i801: Remove force_addr parameter

Remove the force_addr module parameter. It doesn't appear to ever
have been needed, and PCI resources shouldn't be arbitrarily
changed anyway.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

--- linux-2.6.17-rc6.orig/Documentation/i2c/busses/i2c-i801	2006-06-08 13:25:15.000000000 +0200
+++ linux-2.6.17-rc6/Documentation/i2c/busses/i2c-i801	2006-06-08 13:51:43.000000000 +0200
@@ -21,8 +21,7 @@
 Module Parameters
 -----------------
 
-* force_addr: int
-  Forcibly enable the ICH at the given address. EXTREMELY DANGEROUS!
+None.
 
 
 Description
--- linux-2.6.17-rc6.orig/drivers/i2c/busses/i2c-i801.c	2006-06-08 13:25:36.000000000 +0200
+++ linux-2.6.17-rc6/drivers/i2c/busses/i2c-i801.c	2006-06-08 13:55:43.000000000 +0200
@@ -92,15 +92,6 @@
 #define I801_START		0x40
 #define I801_PEC_EN		0x80	/* ICH4 only */
 
-/* insmod parameters */
-
-/* If force_addr is set to anything different from 0, we forcibly enable
-   the I801 at the given address. VERY DANGEROUS! */
-static u16 force_addr;
-module_param(force_addr, ushort, 0);
-MODULE_PARM_DESC(force_addr,
-		 "Forcibly enable the I801 at the given address. "
-		 "EXTREMELY DANGEROUS!");
 
 static int i801_transaction(void);
 static int i801_block_transaction(union i2c_smbus_data *data, char read_write,
@@ -129,16 +120,12 @@
 		isich4 = 0;
 
 	/* Determine the address of the SMBus areas */
-	if (force_addr) {
-		i801_smba = force_addr & 0xfff0;
-	} else {
-		pci_read_config_word(I801_dev, SMBBA, &i801_smba);
-		i801_smba &= 0xfff0;
-		if(i801_smba = 0) {
-			dev_err(&dev->dev, "SMB base address uninitialized "
-				"- upgrade BIOS or use force_addr=0xaddr\n");
-			return -ENODEV;
-		}
+	pci_read_config_word(I801_dev, SMBBA, &i801_smba);
+	i801_smba &= 0xfff0;
+	if (!i801_smba) {
+		dev_err(&dev->dev, "SMBus base address uninitialized, "
+			"upgrade BIOS\n");
+		return -ENODEV;
 	}
 
 	if (!request_region(i801_smba, (isich4 ? 16 : 8), i801_driver.name)) {
@@ -152,15 +139,7 @@
 	temp &= ~SMBHSTCFG_I2C_EN;	/* SMBus timing */
 	pci_write_config_byte(I801_dev, SMBHSTCFG, temp);
 
-	/* If force_addr is set, we program the new address here. Just to make
-	   sure, we disable the device first. */
-	if (force_addr) {
-		pci_write_config_byte(I801_dev, SMBHSTCFG, temp & 0xfe);
-		pci_write_config_word(I801_dev, SMBBA, i801_smba);
-		pci_write_config_byte(I801_dev, SMBHSTCFG, temp | 0x01);
-		dev_warn(&dev->dev, "WARNING: I801 SMBus interface set to "
-			"new address %04x!\n", i801_smba);
-	} else if ((temp & 1) = 0) {
+	if (!(temp & 1)) {
 		pci_write_config_byte(I801_dev, SMBHSTCFG, temp | 1);
 		dev_warn(&dev->dev, "enabling SMBus device\n");
 	}

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

