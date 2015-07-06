From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 06 Jul 2015 15:54:23 +0000
Subject: [lm-sensors] [PATCH 4/5] hwmon: (pmbus) Add support for lowest power value attributes
Message-Id: <1436198064-23678-4-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add support for powerX_input_lowest for both input and output power.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pmbus/pmbus.h      | 50 +++++++++++++++++++++-------------------
 drivers/hwmon/pmbus/pmbus_core.c |  8 +++++++
 2 files changed, 34 insertions(+), 24 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index 89a23ff836e7..84cd97dae19b 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -162,30 +162,32 @@
 #define PMBUS_VIRT_READ_IIN_MAX		(PMBUS_VIRT_BASE + 10)
 #define PMBUS_VIRT_RESET_IIN_HISTORY	(PMBUS_VIRT_BASE + 11)
 #define PMBUS_VIRT_READ_PIN_AVG		(PMBUS_VIRT_BASE + 12)
-#define PMBUS_VIRT_READ_PIN_MAX		(PMBUS_VIRT_BASE + 13)
-#define PMBUS_VIRT_RESET_PIN_HISTORY	(PMBUS_VIRT_BASE + 14)
-#define PMBUS_VIRT_READ_POUT_AVG	(PMBUS_VIRT_BASE + 15)
-#define PMBUS_VIRT_READ_POUT_MAX	(PMBUS_VIRT_BASE + 16)
-#define PMBUS_VIRT_RESET_POUT_HISTORY	(PMBUS_VIRT_BASE + 17)
-#define PMBUS_VIRT_READ_VOUT_AVG	(PMBUS_VIRT_BASE + 18)
-#define PMBUS_VIRT_READ_VOUT_MIN	(PMBUS_VIRT_BASE + 19)
-#define PMBUS_VIRT_READ_VOUT_MAX	(PMBUS_VIRT_BASE + 20)
-#define PMBUS_VIRT_RESET_VOUT_HISTORY	(PMBUS_VIRT_BASE + 21)
-#define PMBUS_VIRT_READ_IOUT_AVG	(PMBUS_VIRT_BASE + 22)
-#define PMBUS_VIRT_READ_IOUT_MIN	(PMBUS_VIRT_BASE + 23)
-#define PMBUS_VIRT_READ_IOUT_MAX	(PMBUS_VIRT_BASE + 24)
-#define PMBUS_VIRT_RESET_IOUT_HISTORY	(PMBUS_VIRT_BASE + 25)
-#define PMBUS_VIRT_READ_TEMP2_AVG	(PMBUS_VIRT_BASE + 26)
-#define PMBUS_VIRT_READ_TEMP2_MIN	(PMBUS_VIRT_BASE + 27)
-#define PMBUS_VIRT_READ_TEMP2_MAX	(PMBUS_VIRT_BASE + 28)
-#define PMBUS_VIRT_RESET_TEMP2_HISTORY	(PMBUS_VIRT_BASE + 29)
-
-#define PMBUS_VIRT_READ_VMON		(PMBUS_VIRT_BASE + 30)
-#define PMBUS_VIRT_VMON_UV_WARN_LIMIT	(PMBUS_VIRT_BASE + 31)
-#define PMBUS_VIRT_VMON_OV_WARN_LIMIT	(PMBUS_VIRT_BASE + 32)
-#define PMBUS_VIRT_VMON_UV_FAULT_LIMIT	(PMBUS_VIRT_BASE + 33)
-#define PMBUS_VIRT_VMON_OV_FAULT_LIMIT	(PMBUS_VIRT_BASE + 34)
-#define PMBUS_VIRT_STATUS_VMON		(PMBUS_VIRT_BASE + 35)
+#define PMBUS_VIRT_READ_PIN_MIN		(PMBUS_VIRT_BASE + 13)
+#define PMBUS_VIRT_READ_PIN_MAX		(PMBUS_VIRT_BASE + 14)
+#define PMBUS_VIRT_RESET_PIN_HISTORY	(PMBUS_VIRT_BASE + 15)
+#define PMBUS_VIRT_READ_POUT_AVG	(PMBUS_VIRT_BASE + 16)
+#define PMBUS_VIRT_READ_POUT_MIN	(PMBUS_VIRT_BASE + 17)
+#define PMBUS_VIRT_READ_POUT_MAX	(PMBUS_VIRT_BASE + 18)
+#define PMBUS_VIRT_RESET_POUT_HISTORY	(PMBUS_VIRT_BASE + 19)
+#define PMBUS_VIRT_READ_VOUT_AVG	(PMBUS_VIRT_BASE + 20)
+#define PMBUS_VIRT_READ_VOUT_MIN	(PMBUS_VIRT_BASE + 21)
+#define PMBUS_VIRT_READ_VOUT_MAX	(PMBUS_VIRT_BASE + 22)
+#define PMBUS_VIRT_RESET_VOUT_HISTORY	(PMBUS_VIRT_BASE + 23)
+#define PMBUS_VIRT_READ_IOUT_AVG	(PMBUS_VIRT_BASE + 24)
+#define PMBUS_VIRT_READ_IOUT_MIN	(PMBUS_VIRT_BASE + 25)
+#define PMBUS_VIRT_READ_IOUT_MAX	(PMBUS_VIRT_BASE + 26)
+#define PMBUS_VIRT_RESET_IOUT_HISTORY	(PMBUS_VIRT_BASE + 27)
+#define PMBUS_VIRT_READ_TEMP2_AVG	(PMBUS_VIRT_BASE + 28)
+#define PMBUS_VIRT_READ_TEMP2_MIN	(PMBUS_VIRT_BASE + 29)
+#define PMBUS_VIRT_READ_TEMP2_MAX	(PMBUS_VIRT_BASE + 30)
+#define PMBUS_VIRT_RESET_TEMP2_HISTORY	(PMBUS_VIRT_BASE + 31)
+
+#define PMBUS_VIRT_READ_VMON		(PMBUS_VIRT_BASE + 32)
+#define PMBUS_VIRT_VMON_UV_WARN_LIMIT	(PMBUS_VIRT_BASE + 33)
+#define PMBUS_VIRT_VMON_OV_WARN_LIMIT	(PMBUS_VIRT_BASE + 34)
+#define PMBUS_VIRT_VMON_UV_FAULT_LIMIT	(PMBUS_VIRT_BASE + 35)
+#define PMBUS_VIRT_VMON_OV_FAULT_LIMIT	(PMBUS_VIRT_BASE + 36)
+#define PMBUS_VIRT_STATUS_VMON		(PMBUS_VIRT_BASE + 37)
 
 /*
  * OPERATION
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index f2e47c7dd808..b4f212ca90f5 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -1329,6 +1329,10 @@ static const struct pmbus_limit_attr pin_limit_attrs[] = {
 		.update = true,
 		.attr = "average",
 	}, {
+		.reg = PMBUS_VIRT_READ_PIN_MIN,
+		.update = true,
+		.attr = "input_lowest",
+	}, {
 		.reg = PMBUS_VIRT_READ_PIN_MAX,
 		.update = true,
 		.attr = "input_highest",
@@ -1359,6 +1363,10 @@ static const struct pmbus_limit_attr pout_limit_attrs[] = {
 		.update = true,
 		.attr = "average",
 	}, {
+		.reg = PMBUS_VIRT_READ_POUT_MIN,
+		.update = true,
+		.attr = "input_lowest",
+	}, {
 		.reg = PMBUS_VIRT_READ_POUT_MAX,
 		.update = true,
 		.attr = "input_highest",
-- 
2.1.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
