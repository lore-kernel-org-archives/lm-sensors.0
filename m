From: gregkh@suse.de (gregkh at suse.de)
Date: Fri, 16 Jun 2006 22:48:58 +0000
Subject: [lm-sensors] patch i2c-opencores-cleanup.patch added to gregkh-2.6
Message-Id: <20060616225151.8F1107598ED@imap.suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: [PATCH 01/14] i2c-ocores: Minor cleanups

to my gregkh-2.6 tree.  Its filename is

     i2c-opencores-cleanup.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


From khali at linux-fr.org Mon Jun 12 12:41:03 2006
Date: Mon, 12 Jun 2006 21:40:53 +0200
From: Jean Delvare <khali at linux-fr.org>
To: Greg KH <greg at kroah.com>
Cc: LM Sensors <lm-sensors at lm-sensors.org>, Peter Korsgaard <jacmet at sunsite.dk>
Subject: [PATCH 01/14] i2c-ocores: Minor cleanups
Message-Id: <20060612214053.4c7ebc0c.khali at linux-fr.org>
Content-Disposition: inline; filename=i2c-opencores-cleanup.patch

From: Peter Korsgaard <jacmet at sunsite.dk>

Minor cleanup to the i2c-ocores driver.

Peter Korsgaard will maintain the i2c-ocores driver.

Signed-off-by: Peter Korsgaard <jacmet at sunsite.dk>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

--- linux-2.6.17-rc6.orig/MAINTAINERS	2006-06-07 07:27:05.000000000 +0200
+++ linux-2.6.17-rc6/MAINTAINERS	2006-06-07 07:27:05.000000000 +0200
@@ -2051,6 +2051,12 @@
 L:      linux-fbdev-devel at lists.sourceforge.net
 S:      Maintained
 
+OPENCORES I2C BUS DRIVER
+P:	Peter Korsgaard
+M:	jacmet at sunsite.dk
+L:	lm-sensors at lm-sensors.org
+S:	Maintained
+
 ORACLE CLUSTER FILESYSTEM 2 (OCFS2)
 P:	Mark Fasheh
 M:	mark.fasheh at oracle.com
--- linux-2.6.17-rc6.orig/drivers/i2c/busses/i2c-ocores.c	2006-06-07 07:27:04.000000000 +0200
+++ linux-2.6.17-rc6/drivers/i2c/busses/i2c-ocores.c	2006-06-07 07:27:05.000000000 +0200
@@ -38,8 +38,8 @@
 #define OCI2C_PREHIGH		1
 #define OCI2C_CONTROL		2
 #define OCI2C_DATA		3
-#define OCI2C_CMD		4
-#define OCI2C_STATUS		4
+#define OCI2C_CMD		4 /* write only */
+#define OCI2C_STATUS		4 /* read only, same address as OCI2C_CMD */
 
 #define OCI2C_CTRL_IEN		0x40
 #define OCI2C_CTRL_EN		0x80
@@ -209,8 +209,6 @@
 	.name		= "i2c-ocores",
 	.class		= I2C_CLASS_HWMON,
 	.algo		= &ocores_algorithm,
-	.timeout	= 2,
-	.retries	= 1,
 };
 
 

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

