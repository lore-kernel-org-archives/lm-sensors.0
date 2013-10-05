From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 05 Oct 2013 21:29:33 +0000
Subject: [lm-sensors] [PATCH 2/3] hwmon: (pmbus/ltc2978): Add support for LTC2977
Message-Id: <1381008574-21557-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

LTC2977 is a pin compatible replacement for LTC2978.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/ltc2978   |   41 +++++++++++++++++++++++++++--------------
 drivers/hwmon/pmbus/ltc2978.c |   12 +++++++++---
 2 files changed, 36 insertions(+), 17 deletions(-)

diff --git a/Documentation/hwmon/ltc2978 b/Documentation/hwmon/ltc2978
index dc0d08c..6934936 100644
--- a/Documentation/hwmon/ltc2978
+++ b/Documentation/hwmon/ltc2978
@@ -6,6 +6,10 @@ Supported chips:
     Prefix: 'ltc2974'
     Addresses scanned: -
     Datasheet: http://www.linear.com/product/ltc2974
+  * Linear Technology LTC2977
+    Prefix: 'ltc2977'
+    Addresses scanned: -
+    Datasheet: http://www.linear.com/product/ltc2977
   * Linear Technology LTC2978
     Prefix: 'ltc2978'
     Addresses scanned: -
@@ -26,8 +30,9 @@ Description
 -----------
 
 LTC2974 is a quad digital power supply manager. LTC2978 is an octal power supply
-monitor. LTC3880 is a dual output poly-phase step-down DC/DC controller. LTC3883
-is a single phase step-down DC/DC controller.
+monitor. LTC2977 is a pin compatible replacement for LTC2978. LTC3880 is a dual
+output poly-phase step-down DC/DC controller. LTC3883 is a single phase
+step-down DC/DC controller.
 
 
 Usage Notes
@@ -49,21 +54,25 @@ Sysfs attributes
 in1_label		"vin"
 in1_input		Measured input voltage.
 in1_min			Minimum input voltage.
-in1_max			Maximum input voltage. LTC2974 and LTC2978 only.
-in1_lcrit		Critical minimum input voltage. LTC2974 and LTC2978
-			only.
+in1_max			Maximum input voltage.
+			LTC2974, LTC2977, and LTC2978 only.
+in1_lcrit		Critical minimum input voltage.
+			LTC2974, LTC2977, and LTC2978 only.
 in1_crit		Critical maximum input voltage.
 in1_min_alarm		Input voltage low alarm.
-in1_max_alarm		Input voltage high alarm. LTC2974 and LTC2978 only.
-in1_lcrit_alarm		Input voltage critical low alarm. LTC2974 and LTC2978
-			only.
+in1_max_alarm		Input voltage high alarm.
+			LTC2974, LTC2977, and LTC2978 only.
+in1_lcrit_alarm		Input voltage critical low alarm.
+			LTC2974, LTC2977, and LTC2978 only.
 in1_crit_alarm		Input voltage critical high alarm.
-in1_lowest		Lowest input voltage. LTC2974 and LTC2978 only.
+in1_lowest		Lowest input voltage.
+			LTC2974, LTC2977, and LTC2978 only.
 in1_highest		Highest input voltage.
 in1_reset_history	Reset input voltage history.
 
 in[N]_label		"vout[1-8]".
 			LTC2974: N=2-5
+			LTC2977: N=2-9
 			LTC2978: N=2-9
 			LTC3880: N=2-3
 			LTC3883: N=2
@@ -83,21 +92,23 @@ in[N]_reset_history	Reset output voltage history.
 temp[N]_input		Measured temperature.
 			On LTC2974, temp[1-4] report external temperatures,
 			and temp5 reports the chip temperature.
-			On LTC2978, only one temperature measurement is
-			supported and reports the chip temperature.
+			On LTC2977 and LTC2978, only one temperature measurement
+			is supported and reports the chip temperature.
 			On LTC3880, temp1 and temp2 report external
 			temperatures, and temp3 reports the chip temperature.
 			On LTC3883, temp1 reports an external temperature,
 			and temp2 reports the chip temperature.
-temp[N]_min		Mimimum temperature. LTC2974 and LTC2978 only.
+temp[N]_min		Mimimum temperature. LTC2974, LCT2977, and LTC2978 only.
 temp[N]_max		Maximum temperature.
 temp[N]_lcrit		Critical low temperature.
 temp[N]_crit		Critical high temperature.
-temp[N]_min_alarm	Temperature low alarm. LTC2974 and LTC2978 only.
+temp[N]_min_alarm	Temperature low alarm.
+			LTC2974, LTC2977, and LTC2978 only.
 temp[N]_max_alarm	Temperature high alarm.
 temp[N]_lcrit_alarm	Temperature critical low alarm.
 temp[N]_crit_alarm	Temperature critical high alarm.
-temp[N]_lowest		Lowest measured temperature. LTC2974 and LTC2978 only.
+temp[N]_lowest		Lowest measured temperature.
+			LTC2974, LTC2977, and LTC2978 only.
 			Not supported for chip temperature sensor on LTC2974.
 temp[N]_highest		Highest measured temperature. Not supported for chip
 			temperature sensor on LTC2974.
@@ -109,6 +120,7 @@ power1_input		Measured input power.
 
 power[N]_label		"pout[1-4]".
 			LTC2974: N=1-4
+			LTC2977: Not supported
 			LTC2978: Not supported
 			LTC3880: N=1-2
 			LTC3883: N=2
@@ -123,6 +135,7 @@ curr1_reset_history	Reset input current history. LTC3883 only.
 
 curr[N]_label		"iout[1-4]".
 			LTC2974: N=1-4
+			LTC2977: not supported
 			LTC2978: not supported
 			LTC3880: N=2-3
 			LTC3883: N=2
diff --git a/drivers/hwmon/pmbus/ltc2978.c b/drivers/hwmon/pmbus/ltc2978.c
index 586a89e..e05ff56 100644
--- a/drivers/hwmon/pmbus/ltc2978.c
+++ b/drivers/hwmon/pmbus/ltc2978.c
@@ -1,5 +1,6 @@
 /*
- * Hardware monitoring driver for LTC2974, LTC2978, LTC3880, and LTC3883
+ * Hardware monitoring driver for LTC2974, LTC2977, LTC2978, LTC3880,
+ * and LTC3883
  *
  * Copyright (c) 2011 Ericsson AB.
  * Copyright (c) 2013 Guenter Roeck
@@ -27,7 +28,7 @@
 #include <linux/i2c.h>
 #include "pmbus.h"
 
-enum chips { ltc2974, ltc2978, ltc3880, ltc3883 };
+enum chips { ltc2974, ltc2977, ltc2978, ltc3880, ltc3883 };
 
 /* Common for all chips */
 #define LTC2978_MFR_VOUT_PEAK		0xdd
@@ -35,7 +36,7 @@ enum chips { ltc2974, ltc2978, ltc3880, ltc3883 };
 #define LTC2978_MFR_TEMPERATURE_PEAK	0xdf
 #define LTC2978_MFR_SPECIAL_ID		0xe7
 
-/* LTC2974 and LTC2978 */
+/* LTC2974, LCT2977, and LTC2978 */
 #define LTC2978_MFR_VOUT_MIN		0xfb
 #define LTC2978_MFR_VIN_MIN		0xfc
 #define LTC2978_MFR_TEMPERATURE_MIN	0xfd
@@ -53,6 +54,7 @@ enum chips { ltc2974, ltc2978, ltc3880, ltc3883 };
 #define LTC3883_MFR_IIN_PEAK		0xe1
 
 #define LTC2974_ID			0x0212
+#define LTC2977_ID			0x0130
 #define LTC2978_ID_REV1			0x0121
 #define LTC2978_ID_REV2			0x0122
 #define LTC3880_ID			0x4000
@@ -363,6 +365,7 @@ static int ltc2978_write_word_data(struct i2c_client *client, int page,
 
 static const struct i2c_device_id ltc2978_id[] = {
 	{"ltc2974", ltc2974},
+	{"ltc2977", ltc2977},
 	{"ltc2978", ltc2978},
 	{"ltc3880", ltc3880},
 	{"ltc3883", ltc3883},
@@ -392,6 +395,8 @@ static int ltc2978_probe(struct i2c_client *client,
 
 	if (chip_id = LTC2974_ID) {
 		data->id = ltc2974;
+	} else if (chip_id = LTC2977_ID) {
+		data->id = ltc2977;
 	} else if (chip_id = LTC2978_ID_REV1 || chip_id = LTC2978_ID_REV2) {
 		data->id = ltc2978;
 	} else if ((chip_id & LTC3880_ID_MASK) = LTC3880_ID) {
@@ -438,6 +443,7 @@ static int ltc2978_probe(struct i2c_client *client,
 			  | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT;
 		}
 		break;
+	case ltc2977:
 	case ltc2978:
 		info->read_word_data = ltc2978_read_word_data;
 		info->pages = LTC2978_NUM_PAGES;
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
