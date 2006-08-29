From: gregkh@suse.de (gregkh at suse.de)
Date: Tue, 29 Aug 2006 23:24:42 +0000
Subject: [lm-sensors] patch hwmon-it87-copyright-update.patch added to
Message-Id: <20060829232545.96E7D895AC9@imap.suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: [PATCH 11/14] it87: Copyright update

to my gregkh-2.6 tree.  Its filename is

     hwmon-it87-copyright-update.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


From khali at linux-fr.org Mon Aug 28 05:39:29 2006
Date: Mon, 28 Aug 2006 14:39:26 +0200
From: Jean Delvare <khali at linux-fr.org>
To: Greg KH <greg at kroah.com>
Cc: LM Sensors <lm-sensors at lm-sensors.org>
Subject: [PATCH 11/14] it87: Copyright update
Message-Id: <20060828143926.04c8f79d.khali at linux-fr.org>
Content-Disposition: inline; filename=hwmon-it87-copyright-update.patch

it87: Copyright update

I think my contributions to the it87 driver over the past two
years qualify me as a co-author of this driver.

Also drop old comments of dubious usefulness.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
 Documentation/hwmon/it87 |    4 +++-
 drivers/hwmon/it87.c     |   12 +++---------
 2 files changed, 6 insertions(+), 10 deletions(-)

--- gregkh-2.6.orig/Documentation/hwmon/it87
+++ gregkh-2.6/Documentation/hwmon/it87
@@ -29,7 +29,9 @@ Supported chips:
     Addresses scanned: from Super I/O config space (8 I/O ports)
     Datasheet: No longer be available
 
-Author: Christophe Gauthron <chrisg at 0-in.com>
+Authors:
+    Christophe Gauthron <chrisg at 0-in.com>
+    Jean Delvare <khali at linux-fr.org>
 
 
 Module Parameters
--- gregkh-2.6.orig/drivers/hwmon/it87.c
+++ gregkh-2.6/drivers/hwmon/it87.c
@@ -9,7 +9,7 @@
               Sis950   A clone of the IT8705F
 
     Copyright (C) 2001 Chris Gauthron <chrisg at 0-in.com> 
-    Largely inspired by lm78.c of the same package
+    Copyright (C) 2005-2006 Jean Delvare <khali at linux-fr.org>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
@@ -26,13 +26,6 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
-/*
-    djg at pdp8.net David Gesswein 7/18/01
-    Modified to fix bug with not all alarms enabled.
-    Added ability to read battery voltage and select temperature sensor
-    type at module load time.
-*/
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -1391,7 +1384,8 @@ static void __exit sm_it87_exit(void)
 }
 
 
-MODULE_AUTHOR("Chris Gauthron <chrisg at 0-in.com>");
+MODULE_AUTHOR("Chris Gauthron <chrisg at 0-in.com>, "
+	      "Jean Delvare <khali at linux-fr.org>");
 MODULE_DESCRIPTION("IT8705F/8712F/8716F/8718F, SiS950 driver");
 module_param(update_vbat, bool, 0);
 MODULE_PARM_DESC(update_vbat, "Update vbat if set else return powerup value");


Patches currently in gregkh-2.6 which might be from khali at linux-fr.org are

i2c/hwmon-w83627ehf-add-pwm-support.patch
i2c/hwmon-w83627ehf-documentation.patch
i2c/i2c-algo-bit-kill-mdelay.patch
i2c/hwmon-abituguru-suspend-resume.patch
i2c/i2c-__must_check-fixes-i2c-dev.patch
i2c/i2c-__must_check-fixes.patch
i2c/hwmon-it87-disabled-fans.patch
i2c/i2c-algo-sibyte-cleanups.patch
i2c/i2c-algo-sibyte-merge-in-i2c-sibyte.patch
i2c/i2c-au1550-add-au1200-support.patch
i2c/i2c-au1550-add-smbus-functionality-flag.patch
i2c/i2c-au1550-fix-timeout-problem.patch
i2c/i2c-bus-driver-for-TI-OMAP-boards.patch
i2c/i2c-isa-plan-for-removal.patch
i2c/i2c-dev-cleanups.patch
i2c/i2c-dev-convert-array-to-list.patch
i2c/i2c-dev-drop-template-client.patch
i2c/i2c-dev-device.patch
i2c/i2c-fix-copy-n-paste-in-subsystem-Kconfig.patch
i2c/i2c-matroxfb-c99-struct-init.patch
i2c/i2c-sibyte-drop-kip-walker-address.patch
i2c/i2c-stub-add-chip_addr-param.patch
i2c/hwmon-atxp1-signed-unsigned-char-bug.patch
i2c/hwmon-hdaps-handle-errors-from-input-register-device.patch
i2c/hwmon-it87-copyright-update.patch
i2c/hwmon-it87-div-to-reg-overflow.patch
i2c/hwmon-it87-in8-no-limits.patch
i2c/hwmon-it87-it8716f-support.patch
i2c/hwmon-it87-it8718f-support.patch
i2c/hwmon-it87-sane-limit-defaults.patch
i2c/hwmon-it87-set-fan-div.patch
i2c/hwmon-k8temp-autoload.patch
i2c/hwmon-k8temp-new-driver.patch
i2c/hwmon-smsc47m1-fix-dev-message.patch

