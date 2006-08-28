From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 28 Aug 2006 12:39:26 +0000
Subject: [lm-sensors] [PATCH 11/14] it87: Copyright update
Message-Id: <20060828143926.04c8f79d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=hwmon-it87-copyright-update.patch

it87: Copyright update

I think my contributions to the it87 driver over the past two
years qualify me as a co-author of this driver.

Also drop old comments of dubious usefulness.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 Documentation/hwmon/it87 |    4 +++-
 drivers/hwmon/it87.c     |   12 +++---------
 2 files changed, 6 insertions(+), 10 deletions(-)

--- linux-2.6.18-rc5.orig/Documentation/hwmon/it87	2006-08-28 10:11:16.000000000 +0200
+++ linux-2.6.18-rc5/Documentation/hwmon/it87	2006-08-28 10:31:52.000000000 +0200
@@ -29,7 +29,9 @@
     Addresses scanned: from Super I/O config space (8 I/O ports)
     Datasheet: No longer be available
 
-Author: Christophe Gauthron <chrisg at 0-in.com>
+Authors:
+    Christophe Gauthron <chrisg at 0-in.com>
+    Jean Delvare <khali at linux-fr.org>
 
 
 Module Parameters
--- linux-2.6.18-rc5.orig/drivers/hwmon/it87.c	2006-08-28 10:30:38.000000000 +0200
+++ linux-2.6.18-rc5/drivers/hwmon/it87.c	2006-08-28 10:31:52.000000000 +0200
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
@@ -1391,7 +1384,8 @@
 }
 
 
-MODULE_AUTHOR("Chris Gauthron <chrisg at 0-in.com>");
+MODULE_AUTHOR("Chris Gauthron <chrisg at 0-in.com>, "
+	      "Jean Delvare <khali at linux-fr.org>");
 MODULE_DESCRIPTION("IT8705F/8712F/8716F/8718F, SiS950 driver");
 module_param(update_vbat, bool, 0);
 MODULE_PARM_DESC(update_vbat, "Update vbat if set else return powerup value");

-- 
Jean Delvare

