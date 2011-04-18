From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 18 Apr 2011 20:49:39 +0000
Subject: [lm-sensors] [PATCH 1/4] hwmon: (pmbus) Documentation updates
Message-Id: <1303159782-2687-2-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fix spelling, correct label name error, and add missing attribute to PMBus
driver documentation.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 Documentation/hwmon/pmbus |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/hwmon/pmbus b/Documentation/hwmon/pmbus
index f2d42e8..ef8555a 100644
--- a/Documentation/hwmon/pmbus
+++ b/Documentation/hwmon/pmbus
@@ -175,11 +175,13 @@ currX_crit		Critical maximum current.
 			From IIN_OC_FAULT_LIMIT or IOUT_OC_FAULT_LIMIT register.
 currX_alarm		Current high alarm.
 			From IIN_OC_WARNING or IOUT_OC_WARNING status.
+currX_max_alarm		Current high alarm.
+			From IIN_OC_WARN_LIMIT or IOUT_OC_WARN_LIMIT status.
 currX_lcrit_alarm	Output current critical low alarm.
 			From IOUT_UC_FAULT status.
 currX_crit_alarm	Current critical high alarm.
 			From IIN_OC_FAULT or IOUT_OC_FAULT status.
-currX_label		"iin" or "vinY"
+currX_label		"iin" or "ioutY"
 
 powerX_input		Measured power. From READ_PIN or READ_POUT register.
 powerX_cap		Output power cap. From POUT_MAX register.
@@ -193,13 +195,13 @@ powerX_crit_alarm	Output power critical high alarm.
 			From POUT_OP_FAULT status.
 powerX_label		"pin" or "poutY"
 
-tempX_input		Measured tempererature.
+tempX_input		Measured temperature.
 			From READ_TEMPERATURE_X register.
-tempX_min		Mimimum tempererature. From UT_WARN_LIMIT register.
-tempX_max		Maximum tempererature. From OT_WARN_LIMIT register.
-tempX_lcrit		Critical low tempererature.
+tempX_min		Mimimum temperature. From UT_WARN_LIMIT register.
+tempX_max		Maximum temperature. From OT_WARN_LIMIT register.
+tempX_lcrit		Critical low temperature.
 			From UT_FAULT_LIMIT register.
-tempX_crit		Critical high tempererature.
+tempX_crit		Critical high temperature.
 			From OT_FAULT_LIMIT register.
 tempX_min_alarm		Chip temperature low alarm. Set by comparing
 			READ_TEMPERATURE_X with UT_WARN_LIMIT if
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
