From: gregkh@suse.de (gregkh at suse.de)
Date: Fri, 16 Jun 2006 22:48:54 +0000
Subject: [lm-sensors] patch i2c-mark-data-const-for-write-block.patch added
Message-Id: <20060616225147.F0D3B758119@imap.suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: [PATCH 02/14] i2c: Mark block write buffers as const

to my gregkh-2.6 tree.  Its filename is

     i2c-mark-data-const-for-write-block.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


From khali at linux-fr.org Mon Jun 12 12:42:21 2006
Date: Mon, 12 Jun 2006 21:42:20 +0200
From: Jean Delvare <khali at linux-fr.org>
To: Greg KH <greg at kroah.com>
Cc: LM Sensors <lm-sensors at lm-sensors.org>, Krzysztof Halasa <khc at pm.waw.pl>
Subject: [PATCH 02/14] i2c: Mark block write buffers as const
Message-Id: <20060612214220.46bb23be.khali at linux-fr.org>
Content-Disposition: inline; filename=i2c-mark-data-const-for-write-block.patch

From: Krzysztof Halasa <khc at pm.waw.pl>

The attached patch marks i2c_smbus_write_block_data() and
i2c_smbus_write_i2c_block_data() buffers as const.

Signed-off-by: Krzysztof Halasa <khc at pm.waw.pl>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

--- linux-2.6.17-rc5.orig/drivers/i2c/i2c-core.c	2006-06-06 19:29:30.000000000 +0200
+++ linux-2.6.17-rc5/drivers/i2c/i2c-core.c	2006-06-06 19:29:42.000000000 +0200
@@ -916,7 +916,7 @@
 }
 
 s32 i2c_smbus_write_block_data(struct i2c_client *client, u8 command,
-			       u8 length, u8 *values)
+			       u8 length, const u8 *values)
 {
 	union i2c_smbus_data data;
 
@@ -944,7 +944,7 @@
 }
 
 s32 i2c_smbus_write_i2c_block_data(struct i2c_client *client, u8 command,
-				   u8 length, u8 *values)
+				   u8 length, const u8 *values)
 {
 	union i2c_smbus_data data;
 
--- linux-2.6.17-rc5.orig/include/linux/i2c.h	2006-06-06 19:29:30.000000000 +0200
+++ linux-2.6.17-rc5/include/linux/i2c.h	2006-06-06 19:31:45.000000000 +0200
@@ -96,13 +96,13 @@
                                      u8 command, u16 value);
 extern s32 i2c_smbus_write_block_data(struct i2c_client * client,
 				      u8 command, u8 length,
-				      u8 *values);
+				      const u8 *values);
 /* Returns the number of read bytes */
 extern s32 i2c_smbus_read_i2c_block_data(struct i2c_client * client,
 					 u8 command, u8 *values);
 extern s32 i2c_smbus_write_i2c_block_data(struct i2c_client * client,
 					  u8 command, u8 length,
-					  u8 *values);
+					  const u8 *values);
 
 /*
  * A driver is capable of handling one or more physical devices present on

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

