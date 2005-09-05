From: gregkh@suse.de (Greg KH)
Date: Mon, 05 Sep 2005 23:47:22 +0000
Subject: [lm-sensors] [PATCH] hwmon: Document on the W83627EHG chip
Message-Id: <11259567653910@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] hwmon: Document on the W83627EHG chip

Document the fact that the W83627EHG is compatible with the W83627EHF.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 8dd2d2ca7fafdedaebd1862e954fccaef212f1e1
tree b215d20fd866d3efa75d71a5ddd31cab029e34c8
parent 27fe048eb3787d29bf9cf9d6d12077bb8af869a6
author Jean Delvare <khali@linux-fr.org> Wed, 27 Jul 2005 21:33:15 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 05 Sep 2005 09:14:07 -0700

 drivers/hwmon/Kconfig     |    3 +++
 drivers/hwmon/w83627ehf.c |    3 +++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -404,6 +404,9 @@ config SENSORS_W83627EHF
 	  Only fan and temperature inputs are supported at the moment, while
 	  the chip does much more than that.
 
+	  This driver also supports the W83627EHG, which is the lead-free
+	  version of the W83627EHF.
+
 	  This driver can also be built as a module.  If so, the module
 	  will be called w83627ehf.
 
diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -9,6 +9,9 @@
     Thanks to Leon Moonen, Steve Cliffe and Grant Coady for their help
     in testing and debugging this driver.
 
+    This driver also supports the W83627EHG, which is the lead-free
+    version of the W83627EHF.
+
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
     the Free Software Foundation; either version 2 of the License, or

