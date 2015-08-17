From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 17 Aug 2015 18:54:42 +0000
Subject: [lm-sensors] [PATCH 8/8] hwmon: (ltc2978) Add support for LTC3886
Message-Id: <1439837682-23748-8-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

LTC3886 is a is a dual PolyPhase DC/DC synchronous step-down switching
regulator controller. It is mostly command compatible to LTC3883,
but supports two phases instead of one.

Suggested-by: Michael Jones <mike@proclivis.com>
Tested-by: Michael Jones <mike@proclivis.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 .../devicetree/bindings/hwmon/ltc2978.txt          |  3 ++-
 Documentation/hwmon/ltc2978                        | 23 +++++++++++++--------
 drivers/hwmon/pmbus/Kconfig                        |  2 +-
 drivers/hwmon/pmbus/ltc2978.c                      | 24 ++++++++++++++++++++--
 4 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/ltc2978.txt b/Documentation/devicetree/bindings/hwmon/ltc2978.txt
index 5dc2691ccf08..a7afbf60bb9c 100644
--- a/Documentation/devicetree/bindings/hwmon/ltc2978.txt
+++ b/Documentation/devicetree/bindings/hwmon/ltc2978.txt
@@ -10,6 +10,7 @@ Required properties:
   * "lltc,ltc3880"
   * "lltc,ltc3882"
   * "lltc,ltc3883"
+  * "lltc,ltc3886"
   * "lltc,ltc3887"
   * "lltc,ltm2987"
   * "lltc,ltm4676"
@@ -25,7 +26,7 @@ Valid names of regulators depend on number of supplies supported per device:
   * ltc2974, ltc2975 : vout0 - vout3
   * ltc2977, ltc2980, ltm2987 : vout0 - vout7
   * ltc2978 : vout0 - vout7
-  * ltc3880, ltc3882 : vout0 - vout1
+  * ltc3880, ltc3882, ltc3886 : vout0 - vout1
   * ltc3883 : vout0
   * ltm4676 : vout0 - vout1
 
diff --git a/Documentation/hwmon/ltc2978 b/Documentation/hwmon/ltc2978
index 158355398798..f997aa53eb95 100644
--- a/Documentation/hwmon/ltc2978
+++ b/Documentation/hwmon/ltc2978
@@ -35,6 +35,10 @@ Supported chips:
     Prefix: 'ltc3883'
     Addresses scanned: -
     Datasheet: http://www.linear.com/product/ltc3883
+  * Linear Technology LTC3886
+    Prefix: 'ltc3886'
+    Addresses scanned: -
+    Datasheet: http://www.linear.com/product/ltc3886
   * Linear Technology LTC3887
     Prefix: 'ltc3887'
     Addresses scanned: -
@@ -60,8 +64,8 @@ LTC2977 is a pin compatible replacement for LTC2978.
 LTC2980 is a 16-channel Power System Manager, consisting of two LTC2977
 in a single die. The chip is instantiated and reported as two separate chips
 on two different I2C bus addresses.
-LTC3880, LTC3882, and LTC3887 are dual output poly-phase step-down DC/DC
-controllers.
+LTC3880, LTC3882, LTC3886, and LTC3887 are dual output poly-phase step-down
+DC/DC controllers.
 LTC3883 is a single phase step-down DC/DC controller.
 LTM2987 is a 16-channel Power System Manager with two LTC2977 plus
 additional components on a single die. The chip is instantiated and reported
@@ -113,7 +117,7 @@ in[N]_label		"vout[1-8]".
 			LTC2974, LTC2975: N=2-5
 			LTC2977, LTC2980, LTM2987: N=2-9
 			LTC2978: N=2-9
-			LTC3880, LTC3882, LTC3887, LTM4676: N=2-3
+			LTC3880, LTC3882, LTC23886 LTC3887, LTM4676: N=2-3
 			LTC3883: N=2
 in[N]_input		Measured output voltage.
 in[N]_min		Minimum output voltage.
@@ -161,29 +165,30 @@ temp[N]_highest		Highest measured temperature. Not supported for chip
 temp[N]_reset_history	Reset temperature history. Not supported for chip
 			temperature sensor on LTC2974 and LTC2975.
 
-power1_label		"pin". LTC3883 only.
+power1_label		"pin". LTC3883 and LTC3886 only.
 power1_input		Measured input power.
 
 power[N]_label		"pout[1-4]".
 			LTC2974, LTC2975: N=1-4
 			LTC2977, LTC2980, LTM2987: Not supported
 			LTC2978: Not supported
-			LTC3880, LTC3882, LTC3887, LTM4676: N=1-2
+			LTC3880, LTC3882, LTC3886, LTC3887, LTM4676: N=1-2
 			LTC3883: N=2
 power[N]_input		Measured output power.
 
-curr1_label		"iin". LTC3880, LTC3883, LTC3887, and LTM4676 only.
+curr1_label		"iin". LTC3880, LTC3883, LTC3886, LTC3887, and LTM4676
+			only.
 curr1_input		Measured input current.
 curr1_max		Maximum input current.
 curr1_max_alarm		Input current high alarm.
-curr1_highest		Highest input current. LTC3883 only.
-curr1_reset_history	Reset input current history. LTC3883 only.
+curr1_highest		Highest input current. LTC3883 and LTC3886 only.
+curr1_reset_history	Reset input current history. LTC3883 and LTC3886 only.
 
 curr[N]_label		"iout[1-4]".
 			LTC2974, LTC2975: N=1-4
 			LTC2977, LTC2980, LTM2987: not supported
 			LTC2978: not supported
-			LTC3880, LTC3882, LTC3887, LTM4676: N=2-3
+			LTC3880, LTC3882, LTC3886, LTC3887, LTM4676: N=2-3
 			LTC3883: N=2
 curr[N]_input		Measured output current.
 curr[N]_max		Maximum output current.
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index af778aed4033..5ebc36255c88 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -53,7 +53,7 @@ config SENSORS_LTC2978
 	help
 	  If you say yes here you get hardware monitoring support for Linear
 	  Technology LTC2974, LTC2975, LTC2977, LTC2978, LTC2980, LTC3880,
-	  LTC3883, LTC3887, LTCM2987, and LTM4676.
+	  LTC3883, LTC3886, LTC3887, LTCM2987, and LTM4676.
 
 	  This driver can also be built as a module. If so, the module will
 	  be called ltc2978.
diff --git a/drivers/hwmon/pmbus/ltc2978.c b/drivers/hwmon/pmbus/ltc2978.c
index f0b1c99ed39b..24d0ee4de08c 100644
--- a/drivers/hwmon/pmbus/ltc2978.c
+++ b/drivers/hwmon/pmbus/ltc2978.c
@@ -25,7 +25,7 @@
 #include "pmbus.h"
 
 enum chips { ltc2974, ltc2975, ltc2977, ltc2978, ltc2980, ltc3880, ltc3882,
-	ltc3883, ltc3887, ltm2987, ltm4676 };
+	ltc3883, ltc3886, ltc3887, ltm2987, ltm4676 };
 
 /* Common for all chips */
 #define LTC2978_MFR_VOUT_PEAK		0xdd
@@ -47,7 +47,7 @@ enum chips { ltc2974, ltc2975, ltc2977, ltc2978, ltc2980, ltc3880, ltc3882,
 #define LTC3880_MFR_CLEAR_PEAKS		0xe3
 #define LTC3880_MFR_TEMPERATURE2_PEAK	0xf4
 
-/* LTC3883 only */
+/* LTC3883 and LTC3886 only */
 #define LTC3883_MFR_IIN_PEAK		0xe1
 
 /* LTC2975 only */
@@ -69,6 +69,7 @@ enum chips { ltc2974, ltc2975, ltc2977, ltc2978, ltc2980, ltc3880, ltc3882,
 #define LTC3882_ID			0x4200
 #define LTC3882_ID_D1			0x4240	/* Dash 1 */
 #define LTC3883_ID			0x4300
+#define LTC3886_ID			0x4600
 #define LTC3887_ID			0x4700
 #define LTM2987_ID_A			0x8010	/* A/B for two die IDs */
 #define LTM2987_ID_B			0x8020
@@ -417,6 +418,7 @@ static const struct i2c_device_id ltc2978_id[] = {
 	{"ltc3880", ltc3880},
 	{"ltc3882", ltc3882},
 	{"ltc3883", ltc3883},
+	{"ltc3886", ltc3886},
 	{"ltc3887", ltc3887},
 	{"ltm2987", ltm2987},
 	{"ltm4676", ltm4676},
@@ -485,6 +487,8 @@ static int ltc2978_get_id(struct i2c_client *client)
 		return ltc3882;
 	else if (chip_id = LTC3883_ID)
 		return ltc3883;
+	else if (chip_id = LTC3886_ID)
+		return ltc3886;
 	else if (chip_id = LTC3887_ID)
 		return ltc3887;
 	else if (chip_id = LTM2987_ID_A || LTM2987_ID_B)
@@ -624,6 +628,21 @@ static int ltc2978_probe(struct i2c_client *client,
 		  | PMBUS_HAVE_PIN | PMBUS_HAVE_POUT | PMBUS_HAVE_TEMP
 		  | PMBUS_HAVE_TEMP2 | PMBUS_HAVE_STATUS_TEMP;
 		break;
+	case ltc3886:
+		data->features |= FEAT_CLEAR_PEAKS;
+		info->read_word_data = ltc3883_read_word_data;
+		info->pages = LTC3880_NUM_PAGES;
+		info->func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN
+		  | PMBUS_HAVE_STATUS_INPUT
+		  | PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
+		  | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT
+		  | PMBUS_HAVE_PIN | PMBUS_HAVE_POUT | PMBUS_HAVE_TEMP
+		  | PMBUS_HAVE_TEMP2 | PMBUS_HAVE_STATUS_TEMP;
+		info->func[1] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
+		  | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT
+		  | PMBUS_HAVE_POUT
+		  | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
+		break;
 	default:
 		return -ENODEV;
 	}
@@ -650,6 +669,7 @@ static const struct of_device_id ltc2978_of_match[] = {
 	{ .compatible = "lltc,ltc3880" },
 	{ .compatible = "lltc,ltc3882" },
 	{ .compatible = "lltc,ltc3883" },
+	{ .compatible = "lltc,ltc3886" },
 	{ .compatible = "lltc,ltc3887" },
 	{ .compatible = "lltc,ltm2987" },
 	{ .compatible = "lltc,ltm4676" },
-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
