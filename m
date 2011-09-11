From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 11 Sep 2011 14:36:33 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: (pmbus) Fix low limit temperature
Message-Id: <1315751793-19489-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Temperature alarms are detected by checking the alarm bit and comparing
temperature limits against the current temperature. For low limits, this
comparison needs to be reversed (temp < limit instead of temp > limit).
This was not taken into account, resulting in wrong alarms if a temperature
fell below a low limit.

Fix by adding a low limit flag in the limit data structure. When creating the
sensor entry, the order of registers to compare is now reversed for low limits.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
v2: One of the tagged alarms wasn't a low limit.

 drivers/hwmon/pmbus/pmbus_core.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 1798f52..f241a4d 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -978,6 +978,8 @@ static void pmbus_find_max_attr(struct i2c_client *client,
 struct pmbus_limit_attr {
 	u16 reg;		/* Limit register */
 	bool update;		/* True if register needs updates */
+	bool low;		/* True if low limit; for limits with compare
+				   functions only */
 	const char *attr;	/* Attribute name */
 	const char *alarm;	/* Alarm attribute name */
 	u32 sbit;		/* Alarm attribute status bit */
@@ -1029,7 +1031,8 @@ static bool pmbus_add_limit_attrs(struct i2c_client *client,
 				if (attr->compare) {
 					pmbus_add_boolean_cmp(data, name,
 						l->alarm, index,
-						cbase, cindex,
+						l->low ? cindex : cbase,
+						l->low ? cbase : cindex,
 						attr->sbase + page, l->sbit);
 				} else {
 					pmbus_add_boolean_reg(data, name,
@@ -1366,11 +1369,13 @@ static const struct pmbus_sensor_attr power_attributes[] = {
 static const struct pmbus_limit_attr temp_limit_attrs[] = {
 	{
 		.reg = PMBUS_UT_WARN_LIMIT,
+		.low = true,
 		.attr = "min",
 		.alarm = "min_alarm",
 		.sbit = PB_TEMP_UT_WARNING,
 	}, {
 		.reg = PMBUS_UT_FAULT_LIMIT,
+		.low = true,
 		.attr = "lcrit",
 		.alarm = "lcrit_alarm",
 		.sbit = PB_TEMP_UT_FAULT,
@@ -1399,11 +1404,13 @@ static const struct pmbus_limit_attr temp_limit_attrs[] = {
 static const struct pmbus_limit_attr temp_limit_attrs23[] = {
 	{
 		.reg = PMBUS_UT_WARN_LIMIT,
+		.low = true,
 		.attr = "min",
 		.alarm = "min_alarm",
 		.sbit = PB_TEMP_UT_WARNING,
 	}, {
 		.reg = PMBUS_UT_FAULT_LIMIT,
+		.low = true,
 		.attr = "lcrit",
 		.alarm = "lcrit_alarm",
 		.sbit = PB_TEMP_UT_FAULT,
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
