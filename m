From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:55:32 +0000
Subject: [lm-sensors] [PATCH 38/82] hwmon: (lm83) Fix multi-line comments
Message-Id: <1327017376-20466-39-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Cc: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm83.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/lm83.c b/drivers/hwmon/lm83.c
index 1fed265..007104f 100644
--- a/drivers/hwmon/lm83.c
+++ b/drivers/hwmon/lm83.c
@@ -155,9 +155,11 @@ struct lm83_data {
 	unsigned long last_updated; /* in jiffies */
 
 	/* registers values */
-	s8 temp[9];	/* 0..3: input 1-4,
-			   4..7: high limit 1-4,
-			   8   : critical limit */
+	s8 temp[9];	/*
+			 * 0..3: input 1-4,
+			 * 4..7: high limit 1-4,
+			 * 8   : critical limit
+			 */
 	u16 alarms; /* bitvector, combined */
 };
 
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
