From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 05 Dec 2013 10:58:45 +0000
Subject: [lm-sensors] [patch] hwmon: prevent some divide by zeros in FAN_TO_REG()
Message-Id: <20131205105845.GA23161@elgon.mountain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

It's not enough to just test if "rpm" is zero, the "rpm * div" operation
could overflow and that could also lead to a divide by zero.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/hwmon/vt8231.c b/drivers/hwmon/vt8231.c
index 0e7017841f7d..923c18034a5f 100644
--- a/drivers/hwmon/vt8231.c
+++ b/drivers/hwmon/vt8231.c
@@ -145,7 +145,7 @@ static const u8 regtempmin[] = { 0x3a, 0x3e, 0x2c, 0x2e, 0x30, 0x32 };
  */
 static inline u8 FAN_TO_REG(long rpm, int div)
 {
-	if (rpm = 0)
+	if (rpm * div = 0)
 		return 0;
 	return clamp_val(1310720 / (rpm * div), 1, 255);
 }
diff --git a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
index 6cf6bff79003..fc4578195674 100644
--- a/drivers/hwmon/lm78.c
+++ b/drivers/hwmon/lm78.c
@@ -92,7 +92,7 @@ static inline u8 IN_TO_REG(unsigned long val)
 
 static inline u8 FAN_TO_REG(long rpm, int div)
 {
-	if (rpm <= 0)
+	if (rpm <= 0 || rpm * div = 0)
 		return 255;
 	return clamp_val((1350000 + rpm * div / 2) / (rpm * div), 1, 254);
 }
diff --git a/drivers/hwmon/sis5595.c b/drivers/hwmon/sis5595.c
index 1404e6319deb..811620fe63b4 100644
--- a/drivers/hwmon/sis5595.c
+++ b/drivers/hwmon/sis5595.c
@@ -139,7 +139,7 @@ static inline u8 IN_TO_REG(unsigned long val)
 
 static inline u8 FAN_TO_REG(long rpm, int div)
 {
-	if (rpm <= 0)
+	if (rpm <= 0 || rpm * div = 0)
 		return 255;
 	return clamp_val((1350000 + rpm * div / 2) / (rpm * div), 1, 254);
 }

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
