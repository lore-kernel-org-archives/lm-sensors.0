From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 05 Mar 2012 19:20:35 +0000
Subject: [lm-sensors] [PATCH 3/6] hwmon: (pmbus) Add more virtual registers
Message-Id: <1330975238-16811-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add PMBUS_VIRT_READ_TEMP_AVG, PMBUS_VIRT_READ_TEMP2_AVG,
PMBUS_VIRT_READ_POUT_AVG, PMBUS_VIRT_READ_POUT_MAX,
and PMBUS_VIRT_RESET_POUT_HISTORY.

We'll need those for MAX34446.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pmbus/pmbus.h      |   55 ++++++++++++++++++++-----------------
 drivers/hwmon/pmbus/pmbus_core.c |   28 ++++++++++++++++---
 2 files changed, 54 insertions(+), 29 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index 0b17d4f..3fe03dc 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -146,31 +146,36 @@
  * code when reading or writing virtual registers.
  */
 #define PMBUS_VIRT_BASE			0x100
-#define PMBUS_VIRT_READ_TEMP_MIN	(PMBUS_VIRT_BASE + 0)
-#define PMBUS_VIRT_READ_TEMP_MAX	(PMBUS_VIRT_BASE + 1)
-#define PMBUS_VIRT_RESET_TEMP_HISTORY	(PMBUS_VIRT_BASE + 2)
-#define PMBUS_VIRT_READ_VIN_AVG		(PMBUS_VIRT_BASE + 3)
-#define PMBUS_VIRT_READ_VIN_MIN		(PMBUS_VIRT_BASE + 4)
-#define PMBUS_VIRT_READ_VIN_MAX		(PMBUS_VIRT_BASE + 5)
-#define PMBUS_VIRT_RESET_VIN_HISTORY	(PMBUS_VIRT_BASE + 6)
-#define PMBUS_VIRT_READ_IIN_AVG		(PMBUS_VIRT_BASE + 7)
-#define PMBUS_VIRT_READ_IIN_MIN		(PMBUS_VIRT_BASE + 8)
-#define PMBUS_VIRT_READ_IIN_MAX		(PMBUS_VIRT_BASE + 9)
-#define PMBUS_VIRT_RESET_IIN_HISTORY	(PMBUS_VIRT_BASE + 10)
-#define PMBUS_VIRT_READ_PIN_AVG		(PMBUS_VIRT_BASE + 11)
-#define PMBUS_VIRT_READ_PIN_MAX		(PMBUS_VIRT_BASE + 12)
-#define PMBUS_VIRT_RESET_PIN_HISTORY	(PMBUS_VIRT_BASE + 13)
-#define PMBUS_VIRT_READ_VOUT_AVG	(PMBUS_VIRT_BASE + 14)
-#define PMBUS_VIRT_READ_VOUT_MIN	(PMBUS_VIRT_BASE + 15)
-#define PMBUS_VIRT_READ_VOUT_MAX	(PMBUS_VIRT_BASE + 16)
-#define PMBUS_VIRT_RESET_VOUT_HISTORY	(PMBUS_VIRT_BASE + 17)
-#define PMBUS_VIRT_READ_IOUT_AVG	(PMBUS_VIRT_BASE + 18)
-#define PMBUS_VIRT_READ_IOUT_MIN	(PMBUS_VIRT_BASE + 19)
-#define PMBUS_VIRT_READ_IOUT_MAX	(PMBUS_VIRT_BASE + 20)
-#define PMBUS_VIRT_RESET_IOUT_HISTORY	(PMBUS_VIRT_BASE + 21)
-#define PMBUS_VIRT_READ_TEMP2_MIN	(PMBUS_VIRT_BASE + 22)
-#define PMBUS_VIRT_READ_TEMP2_MAX	(PMBUS_VIRT_BASE + 23)
-#define PMBUS_VIRT_RESET_TEMP2_HISTORY	(PMBUS_VIRT_BASE + 24)
+#define PMBUS_VIRT_READ_TEMP_AVG	(PMBUS_VIRT_BASE + 0)
+#define PMBUS_VIRT_READ_TEMP_MIN	(PMBUS_VIRT_BASE + 1)
+#define PMBUS_VIRT_READ_TEMP_MAX	(PMBUS_VIRT_BASE + 2)
+#define PMBUS_VIRT_RESET_TEMP_HISTORY	(PMBUS_VIRT_BASE + 3)
+#define PMBUS_VIRT_READ_VIN_AVG		(PMBUS_VIRT_BASE + 4)
+#define PMBUS_VIRT_READ_VIN_MIN		(PMBUS_VIRT_BASE + 5)
+#define PMBUS_VIRT_READ_VIN_MAX		(PMBUS_VIRT_BASE + 6)
+#define PMBUS_VIRT_RESET_VIN_HISTORY	(PMBUS_VIRT_BASE + 7)
+#define PMBUS_VIRT_READ_IIN_AVG		(PMBUS_VIRT_BASE + 8)
+#define PMBUS_VIRT_READ_IIN_MIN		(PMBUS_VIRT_BASE + 9)
+#define PMBUS_VIRT_READ_IIN_MAX		(PMBUS_VIRT_BASE + 10)
+#define PMBUS_VIRT_RESET_IIN_HISTORY	(PMBUS_VIRT_BASE + 11)
+#define PMBUS_VIRT_READ_PIN_AVG		(PMBUS_VIRT_BASE + 12)
+#define PMBUS_VIRT_READ_PIN_MAX		(PMBUS_VIRT_BASE + 13)
+#define PMBUS_VIRT_RESET_PIN_HISTORY	(PMBUS_VIRT_BASE + 14)
+#define PMBUS_VIRT_READ_POUT_AVG	(PMBUS_VIRT_BASE + 15)
+#define PMBUS_VIRT_READ_POUT_MAX	(PMBUS_VIRT_BASE + 16)
+#define PMBUS_VIRT_RESET_POUT_HISTORY	(PMBUS_VIRT_BASE + 17)
+#define PMBUS_VIRT_READ_VOUT_AVG	(PMBUS_VIRT_BASE + 18)
+#define PMBUS_VIRT_READ_VOUT_MIN	(PMBUS_VIRT_BASE + 19)
+#define PMBUS_VIRT_READ_VOUT_MAX	(PMBUS_VIRT_BASE + 20)
+#define PMBUS_VIRT_RESET_VOUT_HISTORY	(PMBUS_VIRT_BASE + 21)
+#define PMBUS_VIRT_READ_IOUT_AVG	(PMBUS_VIRT_BASE + 22)
+#define PMBUS_VIRT_READ_IOUT_MIN	(PMBUS_VIRT_BASE + 23)
+#define PMBUS_VIRT_READ_IOUT_MAX	(PMBUS_VIRT_BASE + 24)
+#define PMBUS_VIRT_RESET_IOUT_HISTORY	(PMBUS_VIRT_BASE + 25)
+#define PMBUS_VIRT_READ_TEMP2_AVG	(PMBUS_VIRT_BASE + 26)
+#define PMBUS_VIRT_READ_TEMP2_MIN	(PMBUS_VIRT_BASE + 27)
+#define PMBUS_VIRT_READ_TEMP2_MAX	(PMBUS_VIRT_BASE + 28)
+#define PMBUS_VIRT_RESET_TEMP2_HISTORY	(PMBUS_VIRT_BASE + 29)
 
 /*
  * CAPABILITY
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index aada0c6..be51037 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -40,11 +40,14 @@
 #define PMBUS_IOUT_SENSORS_PER_PAGE	8	/* input, min, max, crit,
 						   lowest, highest, avg,
 						   reset */
-#define PMBUS_POUT_SENSORS_PER_PAGE	4	/* input, cap, max, crit */
+#define PMBUS_POUT_SENSORS_PER_PAGE	7	/* input, cap, max, crit,
+						 * highest, avg, reset
+						 */
 #define PMBUS_MAX_SENSORS_PER_FAN	1	/* input */
-#define PMBUS_MAX_SENSORS_PER_TEMP	8	/* input, min, max, lcrit,
-						   crit, lowest, highest,
-						   reset */
+#define PMBUS_MAX_SENSORS_PER_TEMP	9	/* input, min, max, lcrit,
+						 * crit, lowest, highest, avg,
+						 * reset
+						 */
 
 #define PMBUS_MAX_INPUT_BOOLEANS	7	/* v: min_alarm, max_alarm,
 						   lcrit_alarm, crit_alarm;
@@ -1334,6 +1337,17 @@ static const struct pmbus_limit_attr pout_limit_attrs[] = {
 		.attr = "crit",
 		.alarm = "crit_alarm",
 		.sbit = PB_POUT_OP_FAULT,
+	}, {
+		.reg = PMBUS_VIRT_READ_POUT_AVG,
+		.update = true,
+		.attr = "average",
+	}, {
+		.reg = PMBUS_VIRT_READ_POUT_MAX,
+		.update = true,
+		.attr = "input_highest",
+	}, {
+		.reg = PMBUS_VIRT_RESET_POUT_HISTORY,
+		.attr = "reset_history",
 	}
 };
 
@@ -1389,6 +1403,9 @@ static const struct pmbus_limit_attr temp_limit_attrs[] = {
 		.reg = PMBUS_VIRT_READ_TEMP_MIN,
 		.attr = "lowest",
 	}, {
+		.reg = PMBUS_VIRT_READ_TEMP_AVG,
+		.attr = "average",
+	}, {
 		.reg = PMBUS_VIRT_READ_TEMP_MAX,
 		.attr = "highest",
 	}, {
@@ -1424,6 +1441,9 @@ static const struct pmbus_limit_attr temp_limit_attrs2[] = {
 		.reg = PMBUS_VIRT_READ_TEMP2_MIN,
 		.attr = "lowest",
 	}, {
+		.reg = PMBUS_VIRT_READ_TEMP2_AVG,
+		.attr = "average",
+	}, {
 		.reg = PMBUS_VIRT_READ_TEMP2_MAX,
 		.attr = "highest",
 	}, {
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
