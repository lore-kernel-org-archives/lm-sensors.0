From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 20 Jan 2012 15:11:16 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: (hwmon) Fix multi-line comments
Message-Id: <1327072276-22299-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Do not replace "/**" since it is for documentation.

 drivers/hwmon/hwmon.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index b58a0ff..c3c471c 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -1,14 +1,14 @@
 /*
-    hwmon.c - part of lm_sensors, Linux kernel modules for hardware monitoring
-
-    This file defines the sysfs class "hwmon", for use by sensors drivers.
-
-    Copyright (C) 2005 Mark M. Hoffman <mhoffman@lightlink.com>
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; version 2 of the License.
-*/
+ * hwmon.c - part of lm_sensors, Linux kernel modules for hardware monitoring
+ *
+ * This file defines the sysfs class "hwmon", for use by sensors drivers.
+ *
+ * Copyright (C) 2005 Mark M. Hoffman <mhoffman@lightlink.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
