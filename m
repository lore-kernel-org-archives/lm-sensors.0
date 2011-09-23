From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 23 Sep 2011 03:31:29 +0000
Subject: [lm-sensors] [PATCH 1/4] hwmon: (pmbus) Add support for TEMP2 peak
Message-Id: <1316748692-8326-2-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

At least one PMBus chip supports peak attributes for READ_TEMPERATURE2.
Add virtual registers to be able to report it to the user.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/pmbus/pmbus.h      |    3 ++
 drivers/hwmon/pmbus/pmbus_core.c |   45 +++++++++++++++++++++++++++++++++----
 2 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index cfa912d..5d31d1c 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -168,6 +168,9 @@
 #define PMBUS_VIRT_READ_IOUT_MIN	(PMBUS_VIRT_BASE + 19)
 #define PMBUS_VIRT_READ_IOUT_MAX	(PMBUS_VIRT_BASE + 20)
 #define PMBUS_VIRT_RESET_IOUT_HISTORY	(PMBUS_VIRT_BASE + 21)
+#define PMBUS_VIRT_READ_TEMP2_MIN	(PMBUS_VIRT_BASE + 22)
+#define PMBUS_VIRT_READ_TEMP2_MAX	(PMBUS_VIRT_BASE + 23)
+#define PMBUS_VIRT_RESET_TEMP2_HISTORY	(PMBUS_VIRT_BASE + 24)
 
 /*
  * CAPABILITY
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index f241a4d..814ebb1 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -1401,7 +1401,42 @@ static const struct pmbus_limit_attr temp_limit_attrs[] = {
 	}
 };
 
-static const struct pmbus_limit_attr temp_limit_attrs23[] = {
+static const struct pmbus_limit_attr temp_limit_attrs2[] = {
+	{
+		.reg = PMBUS_UT_WARN_LIMIT,
+		.low = true,
+		.attr = "min",
+		.alarm = "min_alarm",
+		.sbit = PB_TEMP_UT_WARNING,
+	}, {
+		.reg = PMBUS_UT_FAULT_LIMIT,
+		.low = true,
+		.attr = "lcrit",
+		.alarm = "lcrit_alarm",
+		.sbit = PB_TEMP_UT_FAULT,
+	}, {
+		.reg = PMBUS_OT_WARN_LIMIT,
+		.attr = "max",
+		.alarm = "max_alarm",
+		.sbit = PB_TEMP_OT_WARNING,
+	}, {
+		.reg = PMBUS_OT_FAULT_LIMIT,
+		.attr = "crit",
+		.alarm = "crit_alarm",
+		.sbit = PB_TEMP_OT_FAULT,
+	}, {
+		.reg = PMBUS_VIRT_READ_TEMP2_MIN,
+		.attr = "lowest",
+	}, {
+		.reg = PMBUS_VIRT_READ_TEMP2_MAX,
+		.attr = "highest",
+	}, {
+		.reg = PMBUS_VIRT_RESET_TEMP2_HISTORY,
+		.attr = "reset_history",
+	}
+};
+
+static const struct pmbus_limit_attr temp_limit_attrs3[] = {
 	{
 		.reg = PMBUS_UT_WARN_LIMIT,
 		.low = true,
@@ -1450,8 +1485,8 @@ static const struct pmbus_sensor_attr temp_attributes[] = {
 		.sfunc = PMBUS_HAVE_STATUS_TEMP,
 		.sbase = PB_STATUS_TEMP_BASE,
 		.gbit = PB_STATUS_TEMPERATURE,
-		.limit = temp_limit_attrs23,
-		.nlimit = ARRAY_SIZE(temp_limit_attrs23),
+		.limit = temp_limit_attrs2,
+		.nlimit = ARRAY_SIZE(temp_limit_attrs2),
 	}, {
 		.reg = PMBUS_READ_TEMPERATURE_3,
 		.class = PSC_TEMPERATURE,
@@ -1462,8 +1497,8 @@ static const struct pmbus_sensor_attr temp_attributes[] = {
 		.sfunc = PMBUS_HAVE_STATUS_TEMP,
 		.sbase = PB_STATUS_TEMP_BASE,
 		.gbit = PB_STATUS_TEMPERATURE,
-		.limit = temp_limit_attrs23,
-		.nlimit = ARRAY_SIZE(temp_limit_attrs23),
+		.limit = temp_limit_attrs3,
+		.nlimit = ARRAY_SIZE(temp_limit_attrs3),
 	}
 };
 
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
