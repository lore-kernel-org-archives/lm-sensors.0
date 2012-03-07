From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 07 Mar 2012 12:11:08 +0000
Subject: [lm-sensors] [PATCH] hwmon: (zl6100) Maintain delay parameter in driver instance data
Message-Id: <1331122268-14318-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

A global delay parameter has the side effect of being overwritten with 0 if a
single ZL2004 or ZL6105 is instantiated. If other chips supported by the same
driver are in the system, this will result in access errors for those chips.

To solve the problem, keep a per-instance copy of the delay parameter, and do
not change the original parameter.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pmbus/zl6100.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/pmbus/zl6100.c b/drivers/hwmon/pmbus/zl6100.c
index 48c7b4a..880b90c 100644
--- a/drivers/hwmon/pmbus/zl6100.c
+++ b/drivers/hwmon/pmbus/zl6100.c
@@ -33,6 +33,7 @@ enum chips { zl2004, zl2005, zl2006, zl2008, zl2105, zl2106, zl6100, zl6105 };
 struct zl6100_data {
 	int id;
 	ktime_t access;		/* chip access time */
+	int delay;		/* Delay between chip accesses in uS */
 	struct pmbus_driver_info info;
 };
 
@@ -52,10 +53,10 @@ MODULE_PARM_DESC(delay, "Delay between chip accesses in uS");
 /* Some chips need a delay between accesses */
 static inline void zl6100_wait(const struct zl6100_data *data)
 {
-	if (delay) {
+	if (data->delay) {
 		s64 delta = ktime_us_delta(ktime_get(), data->access);
-		if (delta < delay)
-			udelay(delay - delta);
+		if (delta < data->delay)
+			udelay(data->delay - delta);
 	}
 }
 
@@ -207,8 +208,9 @@ static int zl6100_probe(struct i2c_client *client,
 	 * can be cleared later for additional chips if tests show that it
 	 * is not needed (in other words, better be safe than sorry).
 	 */
+	data->delay = delay;
 	if (data->id = zl2004 || data->id = zl6105)
-		delay = 0;
+		data->delay = 0;
 
 	/*
 	 * Since there was a direct I2C device access above, wait before
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
