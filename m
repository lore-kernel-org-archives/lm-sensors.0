From: gregkh@suse.de (gregkh at suse.de)
Date: Fri, 16 Jun 2006 22:48:36 +0000
Subject: [lm-sensors] patch i2c-i801-04-cleanups.patch added to gregkh-2.6
Message-Id: <20060616225129.E55EB7595E5@imap.suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: [PATCH 09/14] i2c-i801: Cleanups

to my gregkh-2.6 tree.  Its filename is

     i2c-i801-04-cleanups.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


From khali at linux-fr.org Mon Jun 12 12:52:12 2006
Date: Mon, 12 Jun 2006 21:52:02 +0200
From: Jean Delvare <khali at linux-fr.org>
To: Greg KH <greg at kroah.com>
Cc: LM Sensors <lm-sensors at lm-sensors.org>
Subject: [PATCH 09/14] i2c-i801: Cleanups
Message-Id: <20060612215202.7c2541df.khali at linux-fr.org>
Content-Disposition: inline; filename=i2c-i801-04-cleanups.patch

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

--- linux-2.6.17-rc6.orig/drivers/i2c/busses/i2c-i801.c	2006-06-08 14:10:56.000000000 +0200
+++ linux-2.6.17-rc6/drivers/i2c/busses/i2c-i801.c	2006-06-08 15:28:40.000000000 +0200
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
 
@@ -102,9 +102,8 @@
 static struct pci_dev *I801_dev;
 static int isich4;
 
-static int i801_setup(struct pci_dev *dev)
+static int __devinit i801_setup(struct pci_dev *dev)
 {
-	int error_return = 0;
 	unsigned char temp;
 
 	I801_dev = dev;
@@ -115,7 +114,7 @@
 	else
 		isich4 = 0;
 
-	/* Determine the address of the SMBus areas */
+	/* Determine the address of the SMBus area */
 	pci_read_config_word(I801_dev, SMBBA, &i801_smba);
 	i801_smba &= 0xfff0;
 	if (!i801_smba) {
@@ -127,20 +126,18 @@
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
@@ -149,8 +146,7 @@
 	dev_dbg(&dev->dev, "SMBREV = 0x%X\n", temp);
 	dev_dbg(&dev->dev, "I801_smba = 0x%X\n", i801_smba);
 
-END:
-	return error_return;
+	return 0;
 }
 
 static int i801_transaction(void)
@@ -516,12 +512,10 @@
 
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

