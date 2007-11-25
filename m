From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 25 Nov 2007 15:14:44 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (it87) Discard a dead e-mail address
Message-Id: <20071125161444.05b2037d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Sigend-off-by: Jean Delvare <khali@linux-fr.org>
---
 Documentation/hwmon/it87 |    2 +-
 drivers/hwmon/it87.c     |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.24-rc3.orig/Documentation/hwmon/it87	2007-10-24 09:59:17.000000000 +0200
+++ linux-2.6.24-rc3/Documentation/hwmon/it87	2007-11-24 18:06:07.000000000 +0100
@@ -30,7 +30,7 @@ Supported chips:
     Datasheet: No longer be available
 
 Authors:
-    Christophe Gauthron <chrisg@0-in.com>
+    Christophe Gauthron
     Jean Delvare <khali@linux-fr.org>
 
 
--- linux-2.6.24-rc3.orig/drivers/hwmon/it87.c	2007-11-24 17:48:04.000000000 +0100
+++ linux-2.6.24-rc3/drivers/hwmon/it87.c	2007-11-24 18:06:00.000000000 +0100
@@ -9,7 +9,7 @@
               IT8726F  Super I/O chip w/LPC interface
               Sis950   A clone of the IT8705F
 
-    Copyright (C) 2001 Chris Gauthron <chrisg@0-in.com> 
+    Copyright (C) 2001 Chris Gauthron
     Copyright (C) 2005-2006 Jean Delvare <khali@linux-fr.org>
 
     This program is free software; you can redistribute it and/or modify
@@ -1483,7 +1483,7 @@ static void __exit sm_it87_exit(void)
 }
 
 
-MODULE_AUTHOR("Chris Gauthron <chrisg@0-in.com>, "
+MODULE_AUTHOR("Chris Gauthron, "
 	      "Jean Delvare <khali@linux-fr.org>");
 MODULE_DESCRIPTION("IT8705F/8712F/8716F/8718F/8726F, SiS950 driver");
 module_param(update_vbat, bool, 0);


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
