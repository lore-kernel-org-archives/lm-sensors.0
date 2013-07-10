From: Shane Huang <shane.huang@amd.com>
Date: Wed, 10 Jul 2013 09:38:10 +0000
Subject: [lm-sensors] [PATCH] hwmon: (w83792d) Update module author
Message-Id: <1373450783-2940-1-git-send-email-shane.huang@amd.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

w83792d was written by me in 2004, I'd like to update my first name
into my current one to keep consistent, and delete invalid address.

Signed-off-by: Shane Huang <shane.huang@amd.com>
---
 Documentation/hwmon/w83791d | 2 +-
 Documentation/hwmon/w83792d | 3 +--
 drivers/hwmon/w83792d.c     | 4 ++--
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/hwmon/w83791d b/Documentation/hwmon/w83791d
index 90387c3..f4021a2 100644
--- a/Documentation/hwmon/w83791d
+++ b/Documentation/hwmon/w83791d
@@ -17,7 +17,7 @@ Credits:
     Philip Edelbrock <phil@netroedge.com>,
     and Mark Studebaker <mdsxyz123@yahoo.com>
   w83792d.c:
-    Chunhao Huang <DZShen@Winbond.com.tw>,
+    Shane Huang (Winbond),
     Rudolf Marek <r.marek@assembler.cz>
 
 Additional contributors:
diff --git a/Documentation/hwmon/w83792d b/Documentation/hwmon/w83792d
index 8a023ce..53f7b68 100644
--- a/Documentation/hwmon/w83792d
+++ b/Documentation/hwmon/w83792d
@@ -7,8 +7,7 @@ Supported chips:
     Addresses scanned: I2C 0x2c - 0x2f
     Datasheet: http://www.winbond.com.tw
 
-Author: Chunhao Huang
-Contact: DZShen <DZShen@Winbond.com.tw>
+Author: Shane Huang (Winbond)
 
 
 Module Parameters
diff --git a/drivers/hwmon/w83792d.c b/drivers/hwmon/w83792d.c
index 0b80489..6267dec 100644
--- a/drivers/hwmon/w83792d.c
+++ b/drivers/hwmon/w83792d.c
@@ -2,7 +2,7 @@
  * w83792d.c - Part of lm_sensors, Linux kernel modules for hardware
  *	       monitoring
  * Copyright (C) 2004, 2005 Winbond Electronics Corp.
- *			    Chunhao Huang <DZShen@Winbond.com.tw>,
+ *			    Shane Huang,
  *			    Rudolf Marek <r.marek@assembler.cz>
  *
  * This program is free software; you can redistribute it and/or modify
@@ -1665,6 +1665,6 @@ static void w83792d_print_debug(struct w83792d_data *data, struct device *dev)
 
 module_i2c_driver(w83792d_driver);
 
-MODULE_AUTHOR("Chunhao Huang @ Winbond <DZShen@Winbond.com.tw>");
+MODULE_AUTHOR("Shane Huang (Winbond)");
 MODULE_DESCRIPTION("W83792AD/D driver for linux-2.6");
 MODULE_LICENSE("GPL");
-- 
1.8.1.2



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
