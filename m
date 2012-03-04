From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 04 Mar 2012 16:21:26 +0000
Subject: [lm-sensors] [PATCH] hwmon: (pmbus_core) Fix maximum number of POUT alarm attributes
Message-Id: <1330878086-9289-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

There are up to three POUT alarm attributes, not two, since cap_alarm was added.

Reported-by: Michele Petracca <mi.petracca@gmail.com>
Cc: stable@vger.kernel.org # 3.0+ [3.0 will need backport]
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pmbus/pmbus_core.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 00460d8..d89b339 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -54,7 +54,8 @@
 						   lcrit_alarm, crit_alarm */
 #define PMBUS_IOUT_BOOLEANS_PER_PAGE	3	/* alarm, lcrit_alarm,
 						   crit_alarm */
-#define PMBUS_POUT_BOOLEANS_PER_PAGE	2	/* alarm, crit_alarm */
+#define PMBUS_POUT_BOOLEANS_PER_PAGE	3	/* cap_alarm, alarm, crit_alarm
+						 */
 #define PMBUS_MAX_BOOLEANS_PER_FAN	2	/* alarm, fault */
 #define PMBUS_MAX_BOOLEANS_PER_TEMP	4	/* min_alarm, max_alarm,
 						   lcrit_alarm, crit_alarm */
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
