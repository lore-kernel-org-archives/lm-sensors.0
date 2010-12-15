From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 15 Dec 2010 17:36:26 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: sysfs ABI updates
Message-Id: <1292434586-7283-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add attributes supported by various PMBus devices to hwmon sysfs ABI.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
v2 changes:
Removed power[1-*]_alarm description from power section. Refer to alarms
section instead.
Added power[1-*]_cap_alarm.

 Documentation/hwmon/sysfs-interface |   40 ++++++++++++++++++++++++++++------
 1 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
index 6456990..5997b5e 100644
--- a/Documentation/hwmon/sysfs-interface
+++ b/Documentation/hwmon/sysfs-interface
@@ -384,10 +384,20 @@ curr[1-*]_min	Current min value.
 		Unit: milliampere
 		RW
 
+curr[1-*]_lcrit	Current critical low value
+		Unit: milliampere
+		RW
+
+curr[1-*]_crit	Current critical high value.
+		Unit: milliampere
+		RW
+
 curr[1-*]_input	Current input value
 		Unit: milliampere
 		RO
 
+Also see the Alarms section for status flags associated with currents.
+
 *********
 * Power *
 *********
@@ -450,13 +460,6 @@ power[1-*]_accuracy		Accuracy of the power meter.
 				Unit: Percent
 				RO
 
-power[1-*]_alarm		1 if the system is drawing more power than the
-				cap allows; 0 otherwise.  A poll notification is
-				sent to this file when the power use exceeds the
-				cap.  This file only appears if the cap is known
-				to be enforced by hardware.
-				RO
-
 power[1-*]_cap			If power use rises above this limit, the
 				system should take action to reduce power use.
 				A poll notification is sent to this file if the
@@ -479,6 +482,20 @@ power[1-*]_cap_min		Minimum cap that can be set.
 				Unit: microWatt
 				RO
 
+power[1-*]_max			Maximum power.
+				Unit: microWatt
+				RW
+
+power[1-*]_crit			Critical maximum power.
+				If power rises to or above this limit, the
+				system is expected take drastic action to reduce
+				power consumption, such as a system shutdown or
+				a forced powerdown of some devices.
+				Unit: microWatt
+				RW
+
+Also see the Alarms section for status flags associated with power readings.
+
 **********
 * Energy *
 **********
@@ -501,6 +518,7 @@ implementation.
 
 in[0-*]_alarm
 curr[1-*]_alarm
+power[1-*]_alarm
 fan[1-*]_alarm
 temp[1-*]_alarm
 		Channel alarm
@@ -512,12 +530,20 @@ OR
 
 in[0-*]_min_alarm
 in[0-*]_max_alarm
+in[0-*]_lcrit_alarm
+in[0-*]_crit_alarm
 curr[1-*]_min_alarm
 curr[1-*]_max_alarm
+curr[1-*]_lcrit_alarm
+curr[1-*]_crit_alarm
+power[1-*]_cap_alarm
+power[1-*]_max_alarm
+power[1-*]_crit_alarm
 fan[1-*]_min_alarm
 fan[1-*]_max_alarm
 temp[1-*]_min_alarm
 temp[1-*]_max_alarm
+temp[1-*]_lcrit_alarm
 temp[1-*]_crit_alarm
 temp[1-*]_emergency_alarm
 		Limit alarm
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
