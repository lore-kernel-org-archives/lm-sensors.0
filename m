From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 16 Sep 2012 12:53:55 +0000
Subject: [lm-sensors] [PATCH] hwmon: Drop Alexey Fisher's e-mail address
Message-Id: <20120916145355.391ce86f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This address is no longer valid.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Oleksij Rempel <bug-track@fisher-privat.net>
---
 Documentation/hwmon/max1619 |    2 +-
 drivers/hwmon/max1619.c     |    4 ++--
 drivers/hwmon/max6642.c     |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

--- linux-3.6-rc5.orig/Documentation/hwmon/max1619	2012-07-21 22:58:29.000000000 +0200
+++ linux-3.6-rc5/Documentation/hwmon/max1619	2012-09-16 14:51:41.279946750 +0200
@@ -9,7 +9,7 @@ Supported chips:
                http://pdfserv.maxim-ic.com/en/ds/MAX1619.pdf
 
 Authors:
-        Alexey Fisher <fishor@mail.ru>,
+        Alexey Fisher,
         Jean Delvare <khali@linux-fr.org>
 
 Description
--- linux-3.6-rc5.orig/drivers/hwmon/max1619.c	2012-08-04 21:49:26.000000000 +0200
+++ linux-3.6-rc5/drivers/hwmon/max1619.c	2012-09-16 14:51:55.544949517 +0200
@@ -1,7 +1,7 @@
 /*
  * max1619.c - Part of lm_sensors, Linux kernel modules for hardware
  *             monitoring
- * Copyright (C) 2003-2004 Alexey Fisher <fishor@mail.ru>
+ * Copyright (C) 2003-2004 Alexey Fisher
  *                         Jean Delvare <khali@linux-fr.org>
  *
  * Based on the lm90 driver. The MAX1619 is a sensor chip made by Maxim.
@@ -357,7 +357,7 @@ static struct max1619_data *max1619_upda
 
 module_i2c_driver(max1619_driver);
 
-MODULE_AUTHOR("Alexey Fisher <fishor@mail.ru> and "
+MODULE_AUTHOR("Alexey Fisher and "
 	"Jean Delvare <khali@linux-fr.org>");
 MODULE_DESCRIPTION("MAX1619 sensor driver");
 MODULE_LICENSE("GPL");
--- linux-3.6-rc5.orig/drivers/hwmon/max6642.c	2012-08-04 21:49:26.000000000 +0200
+++ linux-3.6-rc5/drivers/hwmon/max6642.c	2012-09-16 14:52:04.065951043 +0200
@@ -7,7 +7,7 @@
  * Derived from:
  *
  *  Based on the max1619 driver.
- *  Copyright (C) 2003-2004 Alexey Fisher <fishor@mail.ru>
+ *  Copyright (C) 2003-2004 Alexey Fisher
  *                          Jean Delvare <khali@linux-fr.org>
  *
  * The MAX6642 is a sensor chip made by Maxim.


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
