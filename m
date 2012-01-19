From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:55:23 +0000
Subject: [lm-sensors] [PATCH 29/82] hwmon: (hwmon) Fix multi-line comments
Message-Id: <1327017376-20466-30-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/hwmon.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index b58a0ff..c0b05ca 100644
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
 
@@ -29,7 +29,7 @@ static struct class *hwmon_class;
 
 static DEFINE_IDA(hwmon_ida);
 
-/**
+/*
  * hwmon_device_register - register w/ hwmon
  * @dev: the device to register
  *
@@ -57,7 +57,7 @@ struct device *hwmon_device_register(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(hwmon_device_register);
 
-/**
+/*
  * hwmon_device_unregister - removes the previously registered class device
  *
  * @dev: the class device to destroy
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
