From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 18 Apr 2014 22:51:22 +0000
Subject: [lm-sensors] [PATCH 1/4] hwmon: (lm92) Drop unnecessary forward declaration
Message-Id: <1397861485-31740-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm92.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/hwmon/lm92.c b/drivers/hwmon/lm92.c
index b9022db..5ca8e14 100644
--- a/drivers/hwmon/lm92.c
+++ b/drivers/hwmon/lm92.c
@@ -93,9 +93,6 @@ static inline u8 ALARMS_FROM_REG(s16 reg)
 	return reg & 0x0007;
 }
 
-/* Driver data (common to all clients) */
-static struct i2c_driver lm92_driver;
-
 /* Client data (each client gets its own) */
 struct lm92_data {
 	struct device *hwmon_dev;
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
