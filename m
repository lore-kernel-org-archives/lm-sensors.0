From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:54:57 +0000
Subject: [lm-sensors] [PATCH 03/82] hwmon: (ad7414) Fix multi-line comments
Message-Id: <1327017376-20466-4-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/ad7414.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/ad7414.c b/drivers/hwmon/ad7414.c
index edbdb6d..dce679d 100644
--- a/drivers/hwmon/ad7414.c
+++ b/drivers/hwmon/ad7414.c
@@ -50,7 +50,8 @@ struct ad7414_data {
 /* REG: (0.25C/bit, two's complement) << 6 */
 static inline int ad7414_temp_from_reg(s16 reg)
 {
-	/* use integer division instead of equivalent right shift to
+	/*
+	 * use integer division instead of equivalent right shift to
 	 * guarantee arithmetic shift and preserve the sign
 	 */
 	return ((int)reg / 64) * 250;
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
