From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 12 Aug 2015 18:18:52 +0000
Subject: [lm-sensors] [PATCH v2 4/4] hwmon: (ltc2978) Add support for LTC3887
Message-Id: <1439403532-30884-4-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

LTC3887 is an enhanced version of LTC3880 and supports the same commands.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: rebase

 Documentation/devicetree/bindings/hwmon/ltc2978.txt |  1 +
 Documentation/hwmon/ltc2978                         | 19 ++++++++++++-------
 drivers/hwmon/pmbus/Kconfig                         |  3 ++-
 drivers/hwmon/pmbus/ltc2978.c                       | 19 ++++++++++++++-----
 4 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/ltc2978.txt b/Documentation/devicetree/bindings/hwmon/ltc2978.txt
index 230389f6c984..c1d23c14ddd9 100644
--- a/Documentation/devicetree/bindings/hwmon/ltc2978.txt
+++ b/Documentation/devicetree/bindings/hwmon/ltc2978.txt
@@ -8,6 +8,7 @@ Required properties:
   * "lltc,ltc3880"
   * "lltc,ltc3882"
   * "lltc,ltc3883"
+  * "lltc,ltc3887"
   * "lltc,ltm4676"
 - reg: I2C slave address
 
diff --git a/Documentation/hwmon/ltc2978 b/Documentation/hwmon/ltc2978
index 521ee8a1135c..ff130997f22e 100644
--- a/Documentation/hwmon/ltc2978
+++ b/Documentation/hwmon/ltc2978
@@ -27,6 +27,10 @@ Supported chips:
     Prefix: 'ltc3883'
     Addresses scanned: -
     Datasheet: http://www.linear.com/product/ltc3883
+  * Linear Technology LTC3887
+    Prefix: 'ltc3887'
+    Addresses scanned: -
+    Datasheet: http://www.linear.com/product/ltc3887
   * Linear Technology LTM4676
     Prefix: 'ltm4676'
     Addresses scanned: -
@@ -41,7 +45,8 @@ Description
 LTC2974 is a quad digital power supply managers.
 LTC2978 is an octal power supply monitor.
 LTC2977 is a pin compatible replacement for LTC2978.
-LTC3880 and LTC3882 are dual output poly-phase step-down DC/DC controllers.
+LTC3880, LTC3882, and LTC3887 are dual output poly-phase step-down DC/DC
+controllers.
 LTC3883 is a single phase step-down DC/DC controller.
 LTM4676 is a dual 13A or single 26A uModule regulator.
 
@@ -85,7 +90,7 @@ in[N]_label		"vout[1-8]".
 			LTC2974: N=2-5
 			LTC2977: N=2-9
 			LTC2978: N=2-9
-			LTC3880, LTC3882, LTM4676: N=2-3
+			LTC3880, LTC3882, LTC3887, LTM4676: N=2-3
 			LTC3883: N=2
 in[N]_input		Measured output voltage.
 in[N]_min		Minimum output voltage.
@@ -105,8 +110,8 @@ temp[N]_input		Measured temperature.
 			and temp5 reports the chip temperature.
 			On LTC2977 and LTC2978, only one temperature measurement
 			is supported and reports the chip temperature.
-			On LTC3880, LTC3882, and LTM4676, temp1 and temp2
-			report external temperatures, and temp3 reports
+			On LTC3880, LTC3882, LTC3887, and LTM4676, temp1 and
+			temp2 report external temperatures, and temp3 reports
 			the chip temperature.
 			On LTC3883, temp1 reports an external temperature,
 			and temp2 reports the chip temperature.
@@ -134,11 +139,11 @@ power[N]_label		"pout[1-4]".
 			LTC2974: N=1-4
 			LTC2977: Not supported
 			LTC2978: Not supported
-			LTC3880, LTC3882, LTM4676: N=1-2
+			LTC3880, LTC3882, LTC3887, LTM4676: N=1-2
 			LTC3883: N=2
 power[N]_input		Measured output power.
 
-curr1_label		"iin". LTC3880, LTC3883, and LTM4676 only.
+curr1_label		"iin". LTC3880, LTC3883, LTC3887, and LTM4676 only.
 curr1_input		Measured input current.
 curr1_max		Maximum input current.
 curr1_max_alarm		Input current high alarm.
@@ -149,7 +154,7 @@ curr[N]_label		"iout[1-4]".
 			LTC2974: N=1-4
 			LTC2977: not supported
 			LTC2978: not supported
-			LTC3880, LTC3882, LTM4676: N=2-3
+			LTC3880, LTC3882, LTC3887, LTM4676: N=2-3
 			LTC3883: N=2
 curr[N]_input		Measured output current.
 curr[N]_max		Maximum output current.
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 2b3242cc7779..43b6de900ce5 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -52,7 +52,8 @@ config SENSORS_LTC2978
 	default n
 	help
 	  If you say yes here you get hardware monitoring support for Linear
-	  Technology LTC2974, LTC2977, LTC2978, LTC3880, LTC3883, and LTM4676.
+	  Technology LTC2974, LTC2977, LTC2978, LTC3880, LTC3883, LTC3887,
+	  and LTM4676.
 
 	  This driver can also be built as a module. If so, the module will
 	  be called ltc2978.
diff --git a/drivers/hwmon/pmbus/ltc2978.c b/drivers/hwmon/pmbus/ltc2978.c
index acbfe3ec2ffd..0756d8ae9dad 100644
--- a/drivers/hwmon/pmbus/ltc2978.c
+++ b/drivers/hwmon/pmbus/ltc2978.c
@@ -1,6 +1,6 @@
 /*
  * Hardware monitoring driver for LTC2974, LTC2977, LTC2978, LTC3880,
- * LTC3883, and LTM4676
+ * LTC3883, LTC3887. and LTM4676
  *
  * Copyright (c) 2011 Ericsson AB.
  * Copyright (c) 2013, 2014 Guenter Roeck
@@ -25,7 +25,8 @@
 #include <linux/regulator/driver.h>
 #include "pmbus.h"
 
-enum chips { ltc2974, ltc2977, ltc2978, ltc3880, ltc3882, ltc3883, ltm4676 };
+enum chips { ltc2974, ltc2977, ltc2978, ltc3880, ltc3882, ltc3883, ltc3887,
+	     ltm4676 };
 
 /* Common for all chips */
 #define LTC2978_MFR_VOUT_PEAK		0xdd
@@ -42,7 +43,7 @@ enum chips { ltc2974, ltc2977, ltc2978, ltc3880, ltc3882, ltc3883, ltm4676 };
 #define LTC2974_MFR_IOUT_PEAK		0xd7
 #define LTC2974_MFR_IOUT_MIN		0xd8
 
-/* LTC3880, LTC3882, LTC3883, and LTM4676 */
+/* LTC3880, LTC3882, LTC3883, LTC3887, and LTM4676 */
 #define LTC3880_MFR_IOUT_PEAK		0xd7
 #define LTC3880_MFR_CLEAR_PEAKS		0xe3
 #define LTC3880_MFR_TEMPERATURE2_PEAK	0xf4
@@ -60,9 +61,11 @@ enum chips { ltc2974, ltc2977, ltc2978, ltc3880, ltc3882, ltc3883, ltm4676 };
 #define LTC3880_ID_MASK			0xff00
 #define LTC3883_ID			0x4300
 #define LTC3883_ID_MASK			0xff00
+#define LTC3887_ID			0x4700
+#define LTC3887_ID_MASK			0xff00
 #define LTM4676_ID			0x4400
 #define LTM4676_ID_2			0x4480
-#define LTM4676A_ID			0x47E0
+#define LTM4676A_ID			0x47e0
 #define LTM4676_ID_MASK			0xfff0
 
 #define LTC2974_NUM_PAGES		4
@@ -315,7 +318,8 @@ static int ltc2978_clear_peaks(struct i2c_client *client, int page,
 {
 	int ret;
 
-	if (id = ltc3880 || id = ltc3882 || id = ltc3883 || id = ltm4676)
+	if (id = ltc3880 || id = ltc3882 || id = ltc3883 || id = ltc3887 ||
+	    id = ltm4676)
 		ret = pmbus_write_byte(client, 0, LTC3880_MFR_CLEAR_PEAKS);
 	else
 		ret = pmbus_write_byte(client, page, PMBUS_CLEAR_FAULTS);
@@ -373,6 +377,7 @@ static const struct i2c_device_id ltc2978_id[] = {
 	{"ltc3880", ltc3880},
 	{"ltc3882", ltc3882},
 	{"ltc3883", ltc3883},
+	{"ltc3887", ltc3887},
 	{"ltm4676", ltm4676},
 	{}
 };
@@ -432,6 +437,8 @@ static int ltc2978_get_id(struct i2c_client *client)
 		return ltc3880;
 	else if ((chip_id & LTC3883_ID_MASK) = LTC3883_ID)
 		return ltc3883;
+	else if ((chip_id & LTC3887_ID_MASK) = LTC3887_ID)
+		return ltc3887;
 	else if ((chip_id & LTM4676_ID_MASK) = LTM4676_ID ||
 		 (chip_id & LTM4676_ID_MASK) = LTM4676_ID_2 ||
 		 (chip_id & LTM4676_ID_MASK) = LTM4676A_ID)
@@ -511,6 +518,7 @@ static int ltc2978_probe(struct i2c_client *client,
 		}
 		break;
 	case ltc3880:
+	case ltc3887:
 	case ltm4676:
 		info->read_word_data = ltc3880_read_word_data;
 		info->pages = LTC3880_NUM_PAGES;
@@ -573,6 +581,7 @@ static const struct of_device_id ltc2978_of_match[] = {
 	{ .compatible = "lltc,ltc3880" },
 	{ .compatible = "lltc,ltc3882" },
 	{ .compatible = "lltc,ltc3883" },
+	{ .compatible = "lltc,ltc3887" },
 	{ .compatible = "lltc,ltm4676" },
 	{ }
 };
-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
