From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 Jan 2012 02:48:59 +0000
Subject: [lm-sensors] [PATCH 20/79] hwmon: (ad7414) Fix multi-line comments
Message-Id: <1327373398-997-21-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

Cc: Stefan Roese <sr@denx.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/ad7414.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/ad7414.c b/drivers/hwmon/ad7414.c
index 3646500..06d2d60 100644
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
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
