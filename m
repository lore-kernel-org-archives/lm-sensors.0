From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 28 Oct 2010 13:57:19 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (w83795) Add myself as co-author
Message-Id: <20101028155719.6dde7bb9@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I've made so many changes to the w83795 driver that it's only fair to
list myself as a co-author. I'll also maintain the driver for some
time. There's more work needed on the driver for sure.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 MAINTAINERS            |    6 ++++++
 drivers/hwmon/w83795.c |    3 ++-
 2 files changed, 8 insertions(+), 1 deletion(-)

--- linux-2.6.37-rc0.orig/MAINTAINERS	2010-10-28 15:38:09.000000000 +0200
+++ linux-2.6.37-rc0/MAINTAINERS	2010-10-28 15:49:06.000000000 +0200
@@ -6457,6 +6457,12 @@ S:	Maintained
 F:	Documentation/hwmon/w83793
 F:	drivers/hwmon/w83793.c
 
+W83795 HARDWARE MONITORING DRIVER
+M:	Jean Delvare <khali@linux-fr.org>
+L:	lm-sensors@lm-sensors.org
+S:	Maintained
+F:	drivers/hwmon/w83795.c
+
 W83L51xD SD/MMC CARD INTERFACE DRIVER
 M:	Pierre Ossman <pierre@ossman.eu>
 S:	Maintained
--- linux-2.6.37-rc0.orig/drivers/hwmon/w83795.c	2010-10-28 15:43:21.000000000 +0200
+++ linux-2.6.37-rc0/drivers/hwmon/w83795.c	2010-10-28 15:48:41.000000000 +0200
@@ -2,6 +2,7 @@
  *  w83795.c - Linux kernel driver for hardware monitoring
  *  Copyright (C) 2008 Nuvoton Technology Corp.
  *                Wei Song
+ *  Copyright (C) 2010 Jean Delvare <khali@linux-fr.org>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -2097,7 +2098,7 @@ static void __exit sensors_w83795_exit(v
 	i2c_del_driver(&w83795_driver);
 }
 
-MODULE_AUTHOR("Wei Song");
+MODULE_AUTHOR("Wei Song, Jean Delvare <khali@linux-fr.org>");
 MODULE_DESCRIPTION("W83795G/ADG hardware monitoring driver");
 MODULE_LICENSE("GPL");
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
