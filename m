From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 Jan 2012 02:49:05 +0000
Subject: [lm-sensors] [PATCH 26/79] hwmon: (g760a) Fix multi-line comments
Message-Id: <1327373398-997-27-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

Cc: Herbert Valerio Riedel <hvr@gnu.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/g760a.c |   33 +++++++++++++++++----------------
 1 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/hwmon/g760a.c b/drivers/hwmon/g760a.c
index 052e304..ebcd269 100644
--- a/drivers/hwmon/g760a.c
+++ b/drivers/hwmon/g760a.c
@@ -1,17 +1,17 @@
 /*
-    g760a - Driver for the Global Mixed-mode Technology Inc. G760A
-	    fan speed PWM controller chip
-
-    Copyright (C) 2007  Herbert Valerio Riedel <hvr@gnu.org>
-
-    Complete datasheet is available at GMT's website:
-      http://www.gmt.com.tw/product/datasheet/EDS-760A.pdf
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-*/
+ * g760a - Driver for the Global Mixed-mode Technology Inc. G760A
+ *	   fan speed PWM controller chip
+ *
+ * Copyright (C) 2007  Herbert Valerio Riedel <hvr@gnu.org>
+ *
+ * Complete datasheet is available at GMT's website:
+ * http://www.gmt.com.tw/product/datasheet/EDS-760A.pdf
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
 
 #include <linux/module.h>
 #include <linux/init.h>
@@ -59,7 +59,8 @@ struct g760a_data {
 	u8 act_cnt; /*   formula: cnt = (CLK * 30)/(rpm * P) */
 	u8 fan_sta; /* bit 0: set when actual fan speed more than 20%
 		     *   outside requested fan speed
-		     * bit 1: set when fan speed below 1920 rpm */
+		     * bit 1: set when fan speed below 1920 rpm
+		     */
 };
 
 #define G760A_DEFAULT_CLK 32768
@@ -99,7 +100,7 @@ static int g760a_write_value(struct i2c_client *client, enum g760a_regs reg,
 	return i2c_smbus_write_byte_data(client, reg, value);
 }
 
-/****************************************************************************
+/*
  * sysfs attributes
  */
 
@@ -192,7 +193,7 @@ static const struct attribute_group g760a_group = {
 	.attrs = g760a_attributes,
 };
 
-/****************************************************************************
+/*
  * new-style driver model code
  */
 
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
