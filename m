From: gregkh@suse.de (gregkh@suse.de)
Date: Thu, 28 Jul 2005 08:33:38 +0000
Subject: [lm-sensors] patch i2c-hwmon-document-w83627ehg.patch added to
Message-Id: <1Dy1wt-6PD-00@press.kroah.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: hwmon: Document on the W83627EHG chip

to my gregkh-2.6 tree.  Its filename is

     i2c-hwmon-document-w83627ehg.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/

Patches currently in gregkh-2.6 which might be from khali@linux-fr.org are

i2c/i2c-max6875-documentation-update.patch
i2c/i2c-max6875-simplify.patch
i2c/i2c-hwmon-class-01.patch
i2c/i2c-hwmon-class-02.patch
i2c/i2c-hwmon-class-03.patch
i2c/i2c-missing-space.patch
i2c/i2c-nforce2-cleanup.patch
i2c/i2c-hwmon-split-01.patch
i2c/i2c-hwmon-split-02.patch
i2c/i2c-hwmon-split-03.patch
i2c/i2c-hwmon-split-04.patch
i2c/i2c-hwmon-split-05.patch
i2c/i2c-hwmon-split-06.patch
i2c/i2c-hwmon-split-07.patch
i2c/i2c-hwmon-split-08.patch
i2c/i2c-hwmon-split-09.patch
i2c/i2c-max6875-cleanup.patch
i2c/i2c-max6875-documentation-cleanup.patch
i2c/i2c-max6875-kobj_to_i2c_client.patch
i2c/i2c-24rf08-corruption-prevention.patch
i2c/i2c-missing-newlines.patch
i2c/i2c-refactor-message.patch
i2c/i2c-use-time_after.patch
i2c/i2c-hwmon-document-w83627ehg.patch
i2c/i2c-hwmon-lm78-j.patch
i2c/i2c-hwmon-soften-lm75.patch
i2c/i2c-hwmon-tag-superio-functions-__init.patch


From khali@linux-fr.org Wed Jul 27 12:34:19 2005
Date: Wed, 27 Jul 2005 21:33:15 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>
Cc: LM Sensors <lm-sensors@lm-sensors.org>
Subject: hwmon: Document on the W83627EHG chip
Message-Id: <20050727213315.6ca005ea.khali@linux-fr.org>

Document the fact that the W83627EHG is compatible with the W83627EHF.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/hwmon/Kconfig     |    3 +++
 drivers/hwmon/w83627ehf.c |    3 +++
 2 files changed, 6 insertions(+)

--- gregkh-2.6.orig/drivers/hwmon/Kconfig	2005-07-27 23:26:34.000000000 -0700
+++ gregkh-2.6/drivers/hwmon/Kconfig	2005-07-27 23:30:37.000000000 -0700
@@ -404,6 +404,9 @@
 	  Only fan and temperature inputs are supported at the moment, while
 	  the chip does much more than that.
 
+	  This driver also supports the W83627EHG, which is the lead-free
+	  version of the W83627EHF.
+
 	  This driver can also be built as a module.  If so, the module
 	  will be called w83627ehf.
 
--- gregkh-2.6.orig/drivers/hwmon/w83627ehf.c	2005-07-27 23:26:34.000000000 -0700
+++ gregkh-2.6/drivers/hwmon/w83627ehf.c	2005-07-27 23:30:37.000000000 -0700
@@ -9,6 +9,9 @@
     Thanks to Leon Moonen, Steve Cliffe and Grant Coady for their help
     in testing and debugging this driver.
 
+    This driver also supports the W83627EHG, which is the lead-free
+    version of the W83627EHF.
+
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
     the Free Software Foundation; either version 2 of the License, or
