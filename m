From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 23 Jul 2011 16:15:18 +0000
Subject: [lm-sensors] [PATCH 3/3] hwmon: (lm78) Become the maintainer
Message-Id: <20110723181518.2cbda377@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Declare myself the maintainer of the lm78 driver. I still have a
running system with one of these chips.

Also count myself as a co-author of the driver. With 34 commits over
6 years, it seems fair.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 Documentation/hwmon/lm78 |    3 ++-
 MAINTAINERS              |    7 +++++++
 drivers/hwmon/lm78.c     |    4 +---
 3 files changed, 10 insertions(+), 4 deletions(-)

--- linux-3.0.orig/Documentation/hwmon/lm78	2011-07-22 04:17:23.000000000 +0200
+++ linux-3.0/Documentation/hwmon/lm78	2011-07-23 18:03:14.000000000 +0200
@@ -13,7 +13,8 @@ Supported chips:
     Datasheet: Publicly available at the National Semiconductor website
                http://www.national.com/
 
-Author: Frodo Looijaard <frodol@dds.nl>
+Authors: Frodo Looijaard <frodol@dds.nl>
+         Jean Delvare <khali@linux-fr.org>
 
 Description
 -----------
--- linux-3.0.orig/MAINTAINERS	2011-07-22 04:17:23.000000000 +0200
+++ linux-3.0/MAINTAINERS	2011-07-23 18:03:54.000000000 +0200
@@ -3951,6 +3951,13 @@ L:	lm-sensors@lm-sensors.org
 S:	Maintained
 F:	drivers/hwmon/lm73.c
 
+LM78 HARDWARE MONITOR DRIVER
+M:	Jean Delvare <khali@linux-fr.org>
+L:	lm-sensors@lm-sensors.org
+S:	Maintained
+F:	Documentation/hwmon/lm78
+F:	drivers/hwmon/lm78.c
+
 LM83 HARDWARE MONITOR DRIVER
 M:	Jean Delvare <khali@linux-fr.org>
 L:	lm-sensors@lm-sensors.org
--- linux-3.0.orig/drivers/hwmon/lm78.c	2011-07-23 18:02:27.000000000 +0200
+++ linux-3.0/drivers/hwmon/lm78.c	2011-07-23 18:03:35.000000000 +0200
@@ -1060,9 +1060,7 @@ static void __exit sm_lm78_exit(void)
 	i2c_del_driver(&lm78_driver);
 }
 
-
-
-MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>");
+MODULE_AUTHOR("Frodo Looijaard, Jean Delvare <khali@linux-fr.org>");
 MODULE_DESCRIPTION("LM78/LM79 driver");
 MODULE_LICENSE("GPL");
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
