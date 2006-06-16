From: gregkh@suse.de (gregkh at suse.de)
Date: Fri, 16 Jun 2006 22:49:01 +0000
Subject: [lm-sensors] patch i2c-scx200_acb-documentation-update.patch added
Message-Id: <20060616225157.56D15758119@imap.suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: [PATCH 05/14] scx200_acb: Documentation update

to my gregkh-2.6 tree.  Its filename is

     i2c-scx200_acb-documentation-update.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


From khali at linux-fr.org Mon Jun 12 12:48:10 2006
Date: Mon, 12 Jun 2006 21:48:08 +0200
From: Jean Delvare <khali at linux-fr.org>
To: Greg KH <greg at kroah.com>
Cc: LM Sensors <lm-sensors at lm-sensors.org>, Jordan Crouse <jordan.crouse at amd.com>
Subject: [PATCH 05/14] scx200_acb: Documentation update
Message-Id: <20060612214808.35510747.khali at linux-fr.org>
Content-Disposition: inline; filename=i2c-scx200_acb-documentation-update.patch

Documentation update for the scx200_acb driver. Hopefully this will
help future users.

References:

[lm-sensors] Support of i2c-nscacb (April, May 2005)
  http://lists.lm-sensors.org/pipermail/lm-sensors/2005-April/011756.html
  http://lists.lm-sensors.org/pipermail/lm-sensors/2005-May/012043.html

[lm-sensors] making a geode i2c slave driver (April 2006)
  http://lists.lm-sensors.org/pipermail/lm-sensors/2006-April/015998.html

Kernel bug #6445
  http://bugzilla.kernel.org/show_bug.cgi?idd45

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

--- linux-2.6.17-rc3.orig/Documentation/i2c/busses/scx200_acb	2006-04-03 20:12:23.000000000 +0200
+++ linux-2.6.17-rc3/Documentation/i2c/busses/scx200_acb	2006-04-28 10:45:30.000000000 +0200
@@ -2,14 +2,31 @@
 
 Author: Christer Weinigel <wingel at nano-system.com>
 
+The driver supersedes the older, never merged driver named i2c-nscacb.
+
 Module Parameters
 -----------------
 
-* base: int
+* base: up to 4 ints
   Base addresses for the ACCESS.bus controllers on SCx200 and SC1100 devices
 
+  By default the driver uses two base addresses 0x820 and 0x840.
+  If you want only one base address, specify the second as 0 so as to
+  override this default.
+
 Description
 -----------
 
 Enable the use of the ACCESS.bus controller on the Geode SCx200 and
 SC1100 processors and the CS5535 and CS5536 Geode companion devices.
+
+Device-specific notes
+---------------------
+
+The SC1100 WRAP boards are known to use base addresses 0x810 and 0x820.
+If the scx200_acb driver is built into the kernel, add the following
+parameter to your boot command line:
+  scx200_acb.base=0x810,0x820
+If the scx200_acb driver is built as a module, add the following line to
+the file /etc/modprobe.conf instead:
+  options scx200_acb base=0x810,0x820

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

