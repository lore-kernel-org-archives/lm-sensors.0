From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 27 Jul 2005 21:33:27 +0000
Subject: [lm-sensors] [PATCH 2.6] hwmon: Document on the W83627EHG chip
Message-Id: <20050727213315.6ca005ea.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg, all,

Document the fact that the W83627EHG is compatible with the W83627EHF.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/hwmon/Kconfig     |    3 +++
 drivers/hwmon/w83627ehf.c |    3 +++
 2 files changed, 6 insertions(+)

--- linux-2.6.13-rc3.orig/drivers/hwmon/Kconfig	2005-07-24 13:13:41.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/Kconfig	2005-07-24 20:26:24.000000000 +0200
@@ -412,6 +412,9 @@
 	  Only fan and temperature inputs are supported at the moment, while
 	  the chip does much more than that.
 
+	  This driver also supports the W83627EHG, which is the lead-free
+	  version of the W83627EHF.
+
 	  This driver can also be built as a module.  If so, the module
 	  will be called w83627ehf.
 
--- linux-2.6.13-rc3.orig/drivers/hwmon/w83627ehf.c	2005-07-24 13:13:41.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/w83627ehf.c	2005-07-24 20:29:57.000000000 +0200
@@ -9,6 +9,9 @@
     Thanks to Leon Moonen, Steve Cliffe and Grant Coady for their help
     in testing and debugging this driver.
 
+    This driver also supports the W83627EHG, which is the lead-free
+    version of the W83627EHF.
+
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
     the Free Software Foundation; either version 2 of the License, or


-- 
Jean Delvare
