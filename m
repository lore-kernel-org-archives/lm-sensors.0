From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 17 Aug 2015 18:54:41 +0000
Subject: [lm-sensors] [PATCH 7/8] hwmon: (ltc2978) Add support for LTC2980 and LTM2987
Message-Id: <1439837682-23748-7-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

LTC2980 and LTM2987 are command compatible to LTC2977. They consist of
two LTC2977 on a single die, and are instantiated as two separate chips,
each supporting eight channels.

Suggested-by: Michael Jones <mike@proclivis.com>
Tested-by: Michael Jones <mike@proclivis.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 .../devicetree/bindings/hwmon/ltc2978.txt          |  4 +-
 Documentation/hwmon/ltc2978                        | 49 ++++++++++++++++------
 drivers/hwmon/pmbus/Kconfig                        |  4 +-
 drivers/hwmon/pmbus/ltc2978.c                      | 20 +++++++--
 4 files changed, 58 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/ltc2978.txt b/Documentation/devicetree/bindings/hwmon/ltc2978.txt
index e434d5fba2ae..5dc2691ccf08 100644
--- a/Documentation/devicetree/bindings/hwmon/ltc2978.txt
+++ b/Documentation/devicetree/bindings/hwmon/ltc2978.txt
@@ -6,10 +6,12 @@ Required properties:
   * "lltc,ltc2975"
   * "lltc,ltc2977"
   * "lltc,ltc2978"
+  * "lltc,ltc2980"
   * "lltc,ltc3880"
   * "lltc,ltc3882"
   * "lltc,ltc3883"
   * "lltc,ltc3887"
+  * "lltc,ltm2987"
   * "lltc,ltm4676"
 - reg: I2C slave address
 
@@ -21,7 +23,7 @@ Optional properties:
 
 Valid names of regulators depend on number of supplies supported per device:
   * ltc2974, ltc2975 : vout0 - vout3
-  * ltc2977 : vout0 - vout7
+  * ltc2977, ltc2980, ltm2987 : vout0 - vout7
   * ltc2978 : vout0 - vout7
   * ltc3880, ltc3882 : vout0 - vout1
   * ltc3883 : vout0
diff --git a/Documentation/hwmon/ltc2978 b/Documentation/hwmon/ltc2978
index 7e982884e359..158355398798 100644
--- a/Documentation/hwmon/ltc2978
+++ b/Documentation/hwmon/ltc2978
@@ -19,6 +19,10 @@ Supported chips:
     Addresses scanned: -
     Datasheet: http://www.linear.com/product/ltc2978
     	       http://www.linear.com/product/ltc2978a
+  * Linear Technology LTC2980
+    Prefix: 'ltc2980'
+    Addresses scanned: -
+    Datasheet: http://www.linear.com/product/ltc2980
   * Linear Technology LTC3880
     Prefix: 'ltc3880'
     Addresses scanned: -
@@ -35,6 +39,10 @@ Supported chips:
     Prefix: 'ltc3887'
     Addresses scanned: -
     Datasheet: http://www.linear.com/product/ltc3887
+  * Linear Technology LTM2987
+    Prefix: 'ltm2987'
+    Addresses scanned: -
+    Datasheet: http://www.linear.com/product/ltm2987
   * Linear Technology LTM4676
     Prefix: 'ltm4676'
     Addresses scanned: -
@@ -49,9 +57,15 @@ Description
 LTC2974 and LTC2975 are quad digital power supply managers.
 LTC2978 is an octal power supply monitor.
 LTC2977 is a pin compatible replacement for LTC2978.
+LTC2980 is a 16-channel Power System Manager, consisting of two LTC2977
+in a single die. The chip is instantiated and reported as two separate chips
+on two different I2C bus addresses.
 LTC3880, LTC3882, and LTC3887 are dual output poly-phase step-down DC/DC
 controllers.
 LTC3883 is a single phase step-down DC/DC controller.
+LTM2987 is a 16-channel Power System Manager with two LTC2977 plus
+additional components on a single die. The chip is instantiated and reported
+as two separate chips on two different I2C bus addresses.
 LTM4676 is a dual 13A or single 26A uModule regulator.
 
 
@@ -75,24 +89,29 @@ in1_label		"vin"
 in1_input		Measured input voltage.
 in1_min			Minimum input voltage.
 in1_max			Maximum input voltage.
-			LTC2974, LTC2975, LTC2977, and LTC2978 only.
+			LTC2974, LTC2975, LTC2977, LTC2980, LTC2978, and
+			LTM2987 only.
 in1_lcrit		Critical minimum input voltage.
-			LTC2974, LTC2975, LTC2977, and LTC2978 only.
+			LTC2974, LTC2975, LTC2977, LTC2980, LTC2978, and
+			LTM2987 only.
 in1_crit		Critical maximum input voltage.
 in1_min_alarm		Input voltage low alarm.
 in1_max_alarm		Input voltage high alarm.
-			LTC2974, LTC2975, LTC2977, and LTC2978 only.
+			LTC2974, LTC2975, LTC2977, LTC2980, LTC2978, and
+			LTM2987 only.
 in1_lcrit_alarm		Input voltage critical low alarm.
-			LTC2974, LTC2975, LTC2977, and LTC2978 only.
+			LTC2974, LTC2975, LTC2977, LTC2980, LTC2978, and
+			LTM2987 only.
 in1_crit_alarm		Input voltage critical high alarm.
 in1_lowest		Lowest input voltage.
-			LTC2974, LTC2975, LTC2977, and LTC2978 only.
+			LTC2974, LTC2975, LTC2977, LTC2980, LTC2978, and
+			LTM2987 only.
 in1_highest		Highest input voltage.
 in1_reset_history	Reset input voltage history.
 
 in[N]_label		"vout[1-8]".
 			LTC2974, LTC2975: N=2-5
-			LTC2977: N=2-9
+			LTC2977, LTC2980, LTM2987: N=2-9
 			LTC2978: N=2-9
 			LTC3880, LTC3882, LTC3887, LTM4676: N=2-3
 			LTC3883: N=2
@@ -113,24 +132,28 @@ in[N]_reset_history	Reset output voltage history.
 temp[N]_input		Measured temperature.
 			On LTC2974 and LTC2975, temp[1-4] report external
 			temperatures, and temp5 reports the chip temperature.
-			On LTC2977 and LTC2978, only one temperature measurement
-			is supported and reports the chip temperature.
+			On LTC2977, LTC2980, LTC2978, and LTM2987, only one
+			temperature measurement is supported and reports
+			the chip temperature.
 			On LTC3880, LTC3882, LTC3887, and LTM4676, temp1 and
 			temp2 report external temperatures, and temp3 reports
 			the chip temperature.
 			On LTC3883, temp1 reports an external temperature,
 			and temp2 reports the chip temperature.
-temp[N]_min		Mimimum temperature. LTC2974, LCT2977, and LTC2978 only.
+temp[N]_min		Mimimum temperature. LTC2974, LCT2977, LTM2980, LTC2978,
+			and LTM2987 only.
 temp[N]_max		Maximum temperature.
 temp[N]_lcrit		Critical low temperature.
 temp[N]_crit		Critical high temperature.
 temp[N]_min_alarm	Temperature low alarm.
-			LTC2974, LTC2975, LTC2977, and LTC2978 only.
+			LTC2974, LTC2975, LTC2977, LTM2980, LTC2978, and
+			LTM2987 only.
 temp[N]_max_alarm	Temperature high alarm.
 temp[N]_lcrit_alarm	Temperature critical low alarm.
 temp[N]_crit_alarm	Temperature critical high alarm.
 temp[N]_lowest		Lowest measured temperature.
-			LTC2974, LTC2975, LTC2977, and LTC2978 only.
+			LTC2974, LTC2975, LTC2977, LTM2980, LTC2978, and
+			LTM2987 only.
 			Not supported for chip temperature sensor on LTC2974 and
 			LTC2975.
 temp[N]_highest		Highest measured temperature. Not supported for chip
@@ -143,7 +166,7 @@ power1_input		Measured input power.
 
 power[N]_label		"pout[1-4]".
 			LTC2974, LTC2975: N=1-4
-			LTC2977: Not supported
+			LTC2977, LTC2980, LTM2987: Not supported
 			LTC2978: Not supported
 			LTC3880, LTC3882, LTC3887, LTM4676: N=1-2
 			LTC3883: N=2
@@ -158,7 +181,7 @@ curr1_reset_history	Reset input current history. LTC3883 only.
 
 curr[N]_label		"iout[1-4]".
 			LTC2974, LTC2975: N=1-4
-			LTC2977: not supported
+			LTC2977, LTC2980, LTM2987: not supported
 			LTC2978: not supported
 			LTC3880, LTC3882, LTC3887, LTM4676: N=2-3
 			LTC3883: N=2
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 8279727987cb..af778aed4033 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -52,8 +52,8 @@ config SENSORS_LTC2978
 	default n
 	help
 	  If you say yes here you get hardware monitoring support for Linear
-	  Technology LTC2974, LTC2975, LTC2977, LTC2978, LTC3880, LTC3883,
-	  LTC3887, and LTM4676.
+	  Technology LTC2974, LTC2975, LTC2977, LTC2978, LTC2980, LTC3880,
+	  LTC3883, LTC3887, LTCM2987, and LTM4676.
 
 	  This driver can also be built as a module. If so, the module will
 	  be called ltc2978.
diff --git a/drivers/hwmon/pmbus/ltc2978.c b/drivers/hwmon/pmbus/ltc2978.c
index 87e3fb67d025..f0b1c99ed39b 100644
--- a/drivers/hwmon/pmbus/ltc2978.c
+++ b/drivers/hwmon/pmbus/ltc2978.c
@@ -24,8 +24,8 @@
 #include <linux/regulator/driver.h>
 #include "pmbus.h"
 
-enum chips { ltc2974, ltc2975, ltc2977, ltc2978, ltc3880, ltc3882, ltc3883,
-	     ltc3887, ltm4676 };
+enum chips { ltc2974, ltc2975, ltc2977, ltc2978, ltc2980, ltc3880, ltc3882,
+	ltc3883, ltc3887, ltm2987, ltm4676 };
 
 /* Common for all chips */
 #define LTC2978_MFR_VOUT_PEAK		0xdd
@@ -33,7 +33,7 @@ enum chips { ltc2974, ltc2975, ltc2977, ltc2978, ltc3880, ltc3882, ltc3883,
 #define LTC2978_MFR_TEMPERATURE_PEAK	0xdf
 #define LTC2978_MFR_SPECIAL_ID		0xe7	/* Undocumented on LTC3882 */
 
-/* LTC2974, LTC2975, LCT2977, and LTC2978 */
+/* LTC2974, LTC2975, LCT2977, LTC2980, LTC2978, and LTM2987 */
 #define LTC2978_MFR_VOUT_MIN		0xfb
 #define LTC2978_MFR_VIN_MIN		0xfc
 #define LTC2978_MFR_TEMPERATURE_MIN	0xfd
@@ -63,11 +63,15 @@ enum chips { ltc2974, ltc2975, ltc2977, ltc2978, ltc3880, ltc3882, ltc3883,
 #define LTC2977_ID			0x0130
 #define LTC2978_ID_REV1			0x0110	/* Early revision */
 #define LTC2978_ID_REV2			0x0120
+#define LTC2980_ID_A			0x8030	/* A/B for two die IDs */
+#define LTC2980_ID_B			0x8040
 #define LTC3880_ID			0x4000
 #define LTC3882_ID			0x4200
 #define LTC3882_ID_D1			0x4240	/* Dash 1 */
 #define LTC3883_ID			0x4300
 #define LTC3887_ID			0x4700
+#define LTM2987_ID_A			0x8010	/* A/B for two die IDs */
+#define LTM2987_ID_B			0x8020
 #define LTM4676_ID_REV1			0x4400
 #define LTM4676_ID_REV2			0x4480
 #define LTM4676A_ID			0x47e0
@@ -409,10 +413,12 @@ static const struct i2c_device_id ltc2978_id[] = {
 	{"ltc2975", ltc2975},
 	{"ltc2977", ltc2977},
 	{"ltc2978", ltc2978},
+	{"ltc2980", ltc2980},
 	{"ltc3880", ltc3880},
 	{"ltc3882", ltc3882},
 	{"ltc3883", ltc3883},
 	{"ltc3887", ltc3887},
+	{"ltm2987", ltm2987},
 	{"ltm4676", ltm4676},
 	{}
 };
@@ -471,6 +477,8 @@ static int ltc2978_get_id(struct i2c_client *client)
 		return ltc2977;
 	else if (chip_id = LTC2978_ID_REV1 || chip_id = LTC2978_ID_REV2)
 		return ltc2978;
+	else if (chip_id = LTC2980_ID_A || chip_id = LTC2980_ID_B)
+		return ltc2980;
 	else if (chip_id = LTC3880_ID)
 		return ltc3880;
 	else if (chip_id = LTC3882_ID || chip_id = LTC3882_ID_D1)
@@ -479,6 +487,8 @@ static int ltc2978_get_id(struct i2c_client *client)
 		return ltc3883;
 	else if (chip_id = LTC3887_ID)
 		return ltc3887;
+	else if (chip_id = LTM2987_ID_A || LTM2987_ID_B)
+		return ltm2987;
 	else if (chip_id = LTM4676_ID_REV1 || chip_id = LTM4676_ID_REV2 ||
 		 chip_id = LTM4676A_ID)
 		return ltm4676;
@@ -559,6 +569,8 @@ static int ltc2978_probe(struct i2c_client *client,
 		break;
 	case ltc2977:
 	case ltc2978:
+	case ltc2980:
+	case ltm2987:
 		info->read_word_data = ltc2978_read_word_data;
 		info->pages = LTC2978_NUM_PAGES;
 		info->func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT
@@ -634,10 +646,12 @@ static const struct of_device_id ltc2978_of_match[] = {
 	{ .compatible = "lltc,ltc2975" },
 	{ .compatible = "lltc,ltc2977" },
 	{ .compatible = "lltc,ltc2978" },
+	{ .compatible = "lltc,ltc2980" },
 	{ .compatible = "lltc,ltc3880" },
 	{ .compatible = "lltc,ltc3882" },
 	{ .compatible = "lltc,ltc3883" },
 	{ .compatible = "lltc,ltc3887" },
+	{ .compatible = "lltc,ltm2987" },
 	{ .compatible = "lltc,ltm4676" },
 	{ }
 };
-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
