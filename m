From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 28 Feb 2013 16:46:32 +0000
Subject: [lm-sensors] [PATCH 3/4] hwmon: (pmbus/ltc2978) Clean up documentation
Message-Id: <1362069993-9530-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Some sysfs attributes are only supported on LTC2978 and not on LTC3880.
Update documentation to reflect which attributes are supported for which chips.

Output current attributes supported on LTC3880 were described as providing
input current values. Fix text to reflect that the attributes provide output
current values.

"reset history" attribute descriptions were misleading and seemed to imply
that all history was reset when writing a single attribute. Replace with more
accurate text.

Replace 'internal temperature" with "chip temperature". Temperature limits
not only apply to the chip temperature, but also to external temperatures
on LTC3880, so remove the word "chip" from the attribute description.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/ltc2978 |   41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/Documentation/hwmon/ltc2978 b/Documentation/hwmon/ltc2978
index e4d75c6..dcb10be 100644
--- a/Documentation/hwmon/ltc2978
+++ b/Documentation/hwmon/ltc2978
@@ -41,17 +41,16 @@ Sysfs attributes
 in1_label		"vin"
 in1_input		Measured input voltage.
 in1_min			Minimum input voltage.
-in1_max			Maximum input voltage.
-in1_lcrit		Critical minimum input voltage.
+in1_max			Maximum input voltage. LTC2978 only.
+in1_lcrit		Critical minimum input voltage. LTC2978 only.
 in1_crit		Critical maximum input voltage.
 in1_min_alarm		Input voltage low alarm.
-in1_max_alarm		Input voltage high alarm.
-in1_lcrit_alarm		Input voltage critical low alarm.
+in1_max_alarm		Input voltage high alarm. LTC2978 only.
+in1_lcrit_alarm		Input voltage critical low alarm. LTC2978 only.
 in1_crit_alarm		Input voltage critical high alarm.
 in1_lowest		Lowest input voltage. LTC2978 only.
 in1_highest		Highest input voltage.
-in1_reset_history	Reset history. Writing into this attribute will reset
-			history for all attributes.
+in1_reset_history	Reset input voltage history.
 
 in[2-9]_label		"vout[1-8]". Channels 3 to 9 on LTC2978 only.
 in[2-9]_input		Measured output voltage.
@@ -65,27 +64,25 @@ in[2-9]_lcrit_alarm	Output voltage critical low alarm.
 in[2-9]_crit_alarm	Output voltage critical high alarm.
 in[2-9]_lowest		Lowest output voltage. LTC2978 only.
 in[2-9]_highest		Lowest output voltage.
-in[2-9]_reset_history	Reset history. Writing into this attribute will reset
-			history for all attributes.
+in[2-9]_reset_history	Reset output voltage history.
 
 temp[1-3]_input		Measured temperature.
 			On LTC2978, only one temperature measurement is
-			supported and reflects the internal temperature.
+			supported and reports the chip temperature.
 			On LTC3880, temp1 and temp2 report external
-			temperatures, and temp3 reports the internal
+			temperatures, and temp3 reports the chip
 			temperature.
-temp[1-3]_min		Mimimum temperature.
+temp[1-3]_min		Mimimum temperature. LTC2978 only.
 temp[1-3]_max		Maximum temperature.
 temp[1-3]_lcrit		Critical low temperature.
 temp[1-3]_crit		Critical high temperature.
-temp[1-3]_min_alarm	Chip temperature low alarm.
-temp[1-3]_max_alarm	Chip temperature high alarm.
-temp[1-3]_lcrit_alarm	Chip temperature critical low alarm.
-temp[1-3]_crit_alarm	Chip temperature critical high alarm.
+temp[1-3]_min_alarm	Temperature low alarm. LTC2978 only.
+temp[1-3]_max_alarm	Temperature high alarm.
+temp[1-3]_lcrit_alarm	Temperature critical low alarm.
+temp[1-3]_crit_alarm	Temperature critical high alarm.
 temp[1-3]_lowest	Lowest measured temperature. LTC2978 only.
 temp[1-3]_highest	Highest measured temperature.
-temp[1-3]_reset_history	Reset history. Writing into this attribute will reset
-			history for all attributes.
+temp[1-3]_reset_history	Reset temperature history.
 
 power[1-2]_label	"pout[1-2]". LTC3880 only.
 power[1-2]_input	Measured power.
@@ -96,8 +93,8 @@ curr1_max		Maximum input current.
 curr1_max_alarm		Input current high alarm.
 
 curr[2-3]_label		"iout[1-2]". LTC3880 only.
-curr[2-3]_input		Measured input current.
-curr[2-3]_max		Maximum input current.
-curr[2-3]_crit		Critical input current.
-curr[2-3]_max_alarm	Input current high alarm.
-curr[2-3]_crit_alarm	Input current critical high alarm.
+curr[2-3]_input		Measured output current.
+curr[2-3]_max		Maximum output current.
+curr[2-3]_crit		Critical output current.
+curr[2-3]_max_alarm	Output current high alarm.
+curr[2-3]_crit_alarm	Output current critical high alarm.
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
