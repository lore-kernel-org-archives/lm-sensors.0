From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:55:42 +0000
Subject: [lm-sensors] [PATCH 48/82] hwmon: (max16065) Fix multi-line comments
Message-Id: <1327017376-20466-49-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/max16065.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/max16065.c b/drivers/hwmon/max16065.c
index f8e323a..cb6c1f7 100644
--- a/drivers/hwmon/max16065.c
+++ b/drivers/hwmon/max16065.c
@@ -47,8 +47,10 @@ enum chips { max16065, max16066, max16067, max16068, max16070, max16071 };
 
 #define MAX16065_SW_ENABLE	0x73
 
-#define MAX16065_WARNING_OV	(1 << 3) /* Set if secondary threshold is OV
-					    warning */
+#define MAX16065_WARNING_OV	(1 << 3) /*
+					  * Set if secondary threshold is OV
+					  * warning
+					  */
 
 #define MAX16065_CURR_ENABLE	(1 << 0)
 
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
