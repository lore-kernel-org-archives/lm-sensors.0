From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:55:26 +0000
Subject: [lm-sensors] [PATCH 32/82] hwmon: (lm63) Fix multi-line comments
Message-Id: <1327017376-20466-33-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm63.c |   32 ++++++++++++++++++++------------
 1 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
index 5e6457a..6030a7e 100644
--- a/drivers/hwmon/lm63.c
+++ b/drivers/hwmon/lm63.c
@@ -207,19 +207,27 @@ struct lm63_data {
 
 	/* registers values */
 	u8 config, config_fan;
-	u16 fan[2];	/* 0: input
-			   1: low limit */
+	u16 fan[2];	/*
+			 * 0: input
+			 * 1: low limit
+			 */
 	u8 pwm1_freq;
-	u8 pwm1[13];	/* 0: current output
-			   1-12: lookup table */
-	s8 temp8[15];	/* 0: local input
-			   1: local high limit
-			   2: remote critical limit
-			   3-14: lookup table */
-	s16 temp11[4];	/* 0: remote input
-			   1: remote low limit
-			   2: remote high limit
-			   3: remote offset */
+	u8 pwm1[13];	/*
+			 * 0: current output
+			 * 1-12: lookup table
+			 */
+	s8 temp8[15];	/*
+			 * 0: local input
+			 * 1: local high limit
+			 * 2: remote critical limit
+			 * 3-14: lookup table
+			 */
+	s16 temp11[4];	/*
+			 * 0: remote input
+			 * 1: remote low limit
+			 * 2: remote high limit
+			 * 3: remote offset
+			 */
 	u16 temp11u;	/* remote input (unsigned) */
 	u8 temp2_crit_hyst;
 	u8 lut_temp_hyst;
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
