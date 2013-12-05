From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 05 Dec 2013 14:54:59 +0000
Subject: [lm-sensors] [patch v2] hwmon: prevent some divide by zeros in FAN_TO_REG()
Message-Id: <20131205145459.GB13302@elgon.mountain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

The "rpm * div" operations can overflow here, so this patch adds an
upper limit to rpm to prevent that.  Jean Delvare helped me with this
patch.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: cap "rpm" instead of just checking for divide by zero.

diff --git a/drivers/hwmon/vt8231.c b/drivers/hwmon/vt8231.c
index 48025b725777..b3babe3326fb 100644
--- a/drivers/hwmon/vt8231.c
+++ b/drivers/hwmon/vt8231.c
@@ -145,7 +145,7 @@ static const u8 regtempmin[] = { 0x3a, 0x3e, 0x2c, 0x2e, 0x30, 0x32 };
  */
 static inline u8 FAN_TO_REG(long rpm, int div)
 {
-	if (rpm = 0)
+	if (rpm <= 0 || rpm > 1310720)
 		return 0;
 	return clamp_val(1310720 / (rpm * div), 1, 255);
 }
diff --git a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
index 6cf6bff79003..28976d64aa2b 100644
--- a/drivers/hwmon/lm78.c
+++ b/drivers/hwmon/lm78.c
@@ -94,6 +94,8 @@ static inline u8 FAN_TO_REG(long rpm, int div)
 {
 	if (rpm <= 0)
 		return 255;
+	if (rpm > 1350000)
+		return 1;
 	return clamp_val((1350000 + rpm * div / 2) / (rpm * div), 1, 254);
 }
 
diff --git a/drivers/hwmon/sis5595.c b/drivers/hwmon/sis5595.c
index 05565d2d1e54..7e7e25b0473d 100644
--- a/drivers/hwmon/sis5595.c
+++ b/drivers/hwmon/sis5595.c
@@ -141,6 +141,8 @@ static inline u8 FAN_TO_REG(long rpm, int div)
 {
 	if (rpm <= 0)
 		return 255;
+	if (rpm > 1350000)
+		return 1;
 	return clamp_val((1350000 + rpm * div / 2) / (rpm * div), 1, 254);
 }
 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
