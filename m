From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 17 Aug 2015 18:54:35 +0000
Subject: [lm-sensors] [PATCH 1/8] hwmon: (ltc2978) Add support for LTC2975
Message-Id: <1439837682-23748-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

LTC2975 is mostly compatible to LTC2974, but supports input current
and power measurement.

Tested-by: Michael Jones <mike@proclivis.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 .../devicetree/bindings/hwmon/ltc2978.txt          |   3 +-
 Documentation/hwmon/ltc2978                        |  47 ++++++----
 drivers/hwmon/pmbus/Kconfig                        |   4 +-
 drivers/hwmon/pmbus/ltc2978.c                      | 104 +++++++++++++++++++--
 4 files changed, 125 insertions(+), 33 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/ltc2978.txt b/Documentation/devicetree/bindings/hwmon/ltc2978.txt
index c1d23c14ddd9..e434d5fba2ae 100644
--- a/Documentation/devicetree/bindings/hwmon/ltc2978.txt
+++ b/Documentation/devicetree/bindings/hwmon/ltc2978.txt
@@ -3,6 +3,7 @@ ltc2978
 Required properties:
 - compatible: should contain one of:
   * "lltc,ltc2974"
+  * "lltc,ltc2975"
   * "lltc,ltc2977"
   * "lltc,ltc2978"
   * "lltc,ltc3880"
@@ -19,7 +20,7 @@ Optional properties:
   standard binding for regulators; see regulator.txt.
 
 Valid names of regulators depend on number of supplies supported per device:
-  * ltc2974 : vout0 - vout3
+  * ltc2974, ltc2975 : vout0 - vout3
   * ltc2977 : vout0 - vout7
   * ltc2978 : vout0 - vout7
   * ltc3880, ltc3882 : vout0 - vout1
diff --git a/Documentation/hwmon/ltc2978 b/Documentation/hwmon/ltc2978
index ff130997f22e..7e982884e359 100644
--- a/Documentation/hwmon/ltc2978
+++ b/Documentation/hwmon/ltc2978
@@ -6,6 +6,10 @@ Supported chips:
     Prefix: 'ltc2974'
     Addresses scanned: -
     Datasheet: http://www.linear.com/product/ltc2974
+  * Linear Technology LTC2975
+    Prefix: 'ltc2975'
+    Addresses scanned: -
+    Datasheet: http://www.linear.com/product/ltc2975
   * Linear Technology LTC2977
     Prefix: 'ltc2977'
     Addresses scanned: -
@@ -42,7 +46,7 @@ Author: Guenter Roeck <linux@roeck-us.net>
 Description
 -----------
 
-LTC2974 is a quad digital power supply managers.
+LTC2974 and LTC2975 are quad digital power supply managers.
 LTC2978 is an octal power supply monitor.
 LTC2977 is a pin compatible replacement for LTC2978.
 LTC3880, LTC3882, and LTC3887 are dual output poly-phase step-down DC/DC
@@ -71,23 +75,23 @@ in1_label		"vin"
 in1_input		Measured input voltage.
 in1_min			Minimum input voltage.
 in1_max			Maximum input voltage.
-			LTC2974, LTC2977, and LTC2978 only.
+			LTC2974, LTC2975, LTC2977, and LTC2978 only.
 in1_lcrit		Critical minimum input voltage.
-			LTC2974, LTC2977, and LTC2978 only.
+			LTC2974, LTC2975, LTC2977, and LTC2978 only.
 in1_crit		Critical maximum input voltage.
 in1_min_alarm		Input voltage low alarm.
 in1_max_alarm		Input voltage high alarm.
-			LTC2974, LTC2977, and LTC2978 only.
+			LTC2974, LTC2975, LTC2977, and LTC2978 only.
 in1_lcrit_alarm		Input voltage critical low alarm.
-			LTC2974, LTC2977, and LTC2978 only.
+			LTC2974, LTC2975, LTC2977, and LTC2978 only.
 in1_crit_alarm		Input voltage critical high alarm.
 in1_lowest		Lowest input voltage.
-			LTC2974, LTC2977, and LTC2978 only.
+			LTC2974, LTC2975, LTC2977, and LTC2978 only.
 in1_highest		Highest input voltage.
 in1_reset_history	Reset input voltage history.
 
 in[N]_label		"vout[1-8]".
-			LTC2974: N=2-5
+			LTC2974, LTC2975: N=2-5
 			LTC2977: N=2-9
 			LTC2978: N=2-9
 			LTC3880, LTC3882, LTC3887, LTM4676: N=2-3
@@ -101,13 +105,14 @@ in[N]_min_alarm		Output voltage low alarm.
 in[N]_max_alarm		Output voltage high alarm.
 in[N]_lcrit_alarm	Output voltage critical low alarm.
 in[N]_crit_alarm	Output voltage critical high alarm.
-in[N]_lowest		Lowest output voltage. LTC2974 and LTC2978 only.
+in[N]_lowest		Lowest output voltage. LTC2974, LTC2975,
+			and LTC2978 only.
 in[N]_highest		Highest output voltage.
 in[N]_reset_history	Reset output voltage history.
 
 temp[N]_input		Measured temperature.
-			On LTC2974, temp[1-4] report external temperatures,
-			and temp5 reports the chip temperature.
+			On LTC2974 and LTC2975, temp[1-4] report external
+			temperatures, and temp5 reports the chip temperature.
 			On LTC2977 and LTC2978, only one temperature measurement
 			is supported and reports the chip temperature.
 			On LTC3880, LTC3882, LTC3887, and LTM4676, temp1 and
@@ -120,23 +125,24 @@ temp[N]_max		Maximum temperature.
 temp[N]_lcrit		Critical low temperature.
 temp[N]_crit		Critical high temperature.
 temp[N]_min_alarm	Temperature low alarm.
-			LTC2974, LTC2977, and LTC2978 only.
+			LTC2974, LTC2975, LTC2977, and LTC2978 only.
 temp[N]_max_alarm	Temperature high alarm.
 temp[N]_lcrit_alarm	Temperature critical low alarm.
 temp[N]_crit_alarm	Temperature critical high alarm.
 temp[N]_lowest		Lowest measured temperature.
-			LTC2974, LTC2977, and LTC2978 only.
-			Not supported for chip temperature sensor on LTC2974.
+			LTC2974, LTC2975, LTC2977, and LTC2978 only.
+			Not supported for chip temperature sensor on LTC2974 and
+			LTC2975.
 temp[N]_highest		Highest measured temperature. Not supported for chip
-			temperature sensor on LTC2974.
+			temperature sensor on LTC2974 and LTC2975.
 temp[N]_reset_history	Reset temperature history. Not supported for chip
-			temperature sensor on LTC2974.
+			temperature sensor on LTC2974 and LTC2975.
 
 power1_label		"pin". LTC3883 only.
 power1_input		Measured input power.
 
 power[N]_label		"pout[1-4]".
-			LTC2974: N=1-4
+			LTC2974, LTC2975: N=1-4
 			LTC2977: Not supported
 			LTC2978: Not supported
 			LTC3880, LTC3882, LTC3887, LTM4676: N=1-2
@@ -151,7 +157,7 @@ curr1_highest		Highest input current. LTC3883 only.
 curr1_reset_history	Reset input current history. LTC3883 only.
 
 curr[N]_label		"iout[1-4]".
-			LTC2974: N=1-4
+			LTC2974, LTC2975: N=1-4
 			LTC2977: not supported
 			LTC2978: not supported
 			LTC3880, LTC3882, LTC3887, LTM4676: N=2-3
@@ -159,10 +165,11 @@ curr[N]_label		"iout[1-4]".
 curr[N]_input		Measured output current.
 curr[N]_max		Maximum output current.
 curr[N]_crit		Critical high output current.
-curr[N]_lcrit		Critical low output current. LTC2974 only.
+curr[N]_lcrit		Critical low output current. LTC2974 and LTC2975 only.
 curr[N]_max_alarm	Output current high alarm.
 curr[N]_crit_alarm	Output current critical high alarm.
-curr[N]_lcrit_alarm	Output current critical low alarm. LTC2974 only.
-curr[N]_lowest		Lowest output current. LTC2974 only.
+curr[N]_lcrit_alarm	Output current critical low alarm.
+			LTC2974 and LTC2975 only.
+curr[N]_lowest		Lowest output current. LTC2974 and LTC2975 only.
 curr[N]_highest		Highest output current.
 curr[N]_reset_history	Reset output current history.
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 43b6de900ce5..8279727987cb 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -52,8 +52,8 @@ config SENSORS_LTC2978
 	default n
 	help
 	  If you say yes here you get hardware monitoring support for Linear
-	  Technology LTC2974, LTC2977, LTC2978, LTC3880, LTC3883, LTC3887,
-	  and LTM4676.
+	  Technology LTC2974, LTC2975, LTC2977, LTC2978, LTC3880, LTC3883,
+	  LTC3887, and LTM4676.
 
 	  This driver can also be built as a module. If so, the module will
 	  be called ltc2978.
diff --git a/drivers/hwmon/pmbus/ltc2978.c b/drivers/hwmon/pmbus/ltc2978.c
index 0756d8ae9dad..e153ffd59ab0 100644
--- a/drivers/hwmon/pmbus/ltc2978.c
+++ b/drivers/hwmon/pmbus/ltc2978.c
@@ -1,9 +1,8 @@
 /*
- * Hardware monitoring driver for LTC2974, LTC2977, LTC2978, LTC3880,
- * LTC3883, LTC3887. and LTM4676
+ * Hardware monitoring driver for LTC2978 and compatible chips.
  *
  * Copyright (c) 2011 Ericsson AB.
- * Copyright (c) 2013, 2014 Guenter Roeck
+ * Copyright (c) 2013, 2014, 2015 Guenter Roeck
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -25,8 +24,8 @@
 #include <linux/regulator/driver.h>
 #include "pmbus.h"
 
-enum chips { ltc2974, ltc2977, ltc2978, ltc3880, ltc3882, ltc3883, ltc3887,
-	     ltm4676 };
+enum chips { ltc2974, ltc2975, ltc2977, ltc2978, ltc3880, ltc3882, ltc3883,
+	     ltc3887, ltm4676 };
 
 /* Common for all chips */
 #define LTC2978_MFR_VOUT_PEAK		0xdd
@@ -34,12 +33,12 @@ enum chips { ltc2974, ltc2977, ltc2978, ltc3880, ltc3882, ltc3883, ltc3887,
 #define LTC2978_MFR_TEMPERATURE_PEAK	0xdf
 #define LTC2978_MFR_SPECIAL_ID		0xe7	/* Not on LTC3882 */
 
-/* LTC2974, LCT2977, and LTC2978 */
+/* LTC2974, LTC2975, LCT2977, and LTC2978 */
 #define LTC2978_MFR_VOUT_MIN		0xfb
 #define LTC2978_MFR_VIN_MIN		0xfc
 #define LTC2978_MFR_TEMPERATURE_MIN	0xfd
 
-/* LTC2974 only */
+/* LTC2974, LTC2975 */
 #define LTC2974_MFR_IOUT_PEAK		0xd7
 #define LTC2974_MFR_IOUT_MIN		0xd8
 
@@ -51,8 +50,15 @@ enum chips { ltc2974, ltc2977, ltc2978, ltc3880, ltc3882, ltc3883, ltc3887,
 /* LTC3883 only */
 #define LTC3883_MFR_IIN_PEAK		0xe1
 
+/* LTC2975 only */
+#define LTC2975_MFR_IIN_PEAK		0xc4
+#define LTC2975_MFR_IIN_MIN		0xc5
+#define LTC2975_MFR_PIN_PEAK		0xc6
+#define LTC2975_MFR_PIN_MIN		0xc7
+
 #define LTC2974_ID_REV1			0x0212
 #define LTC2974_ID_REV2			0x0213
+#define LTC2975_ID			0x0223
 #define LTC2977_ID			0x0130
 #define LTC2978_ID_REV1			0x0121
 #define LTC2978_ID_REV2			0x0122
@@ -87,7 +93,8 @@ struct ltc2978_data {
 	u16 temp_min[LTC2974_NUM_PAGES], temp_max[LTC2974_NUM_PAGES];
 	u16 vout_min[LTC2978_NUM_PAGES], vout_max[LTC2978_NUM_PAGES];
 	u16 iout_min[LTC2974_NUM_PAGES], iout_max[LTC2974_NUM_PAGES];
-	u16 iin_max;
+	u16 iin_min, iin_max;
+	u16 pin_min, pin_max;
 	u16 temp2_max;
 	struct pmbus_driver_info info;
 };
@@ -246,6 +253,60 @@ static int ltc2974_read_word_data(struct i2c_client *client, int page, int reg)
 	return ret;
 }
 
+static int ltc2975_read_word_data(struct i2c_client *client, int page, int reg)
+{
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	struct ltc2978_data *data = to_ltc2978_data(info);
+	int ret;
+
+	switch (reg) {
+	case PMBUS_VIRT_READ_IIN_MAX:
+		ret = pmbus_read_word_data(client, page, LTC2975_MFR_IIN_PEAK);
+		if (ret >= 0) {
+			if (lin11_to_val(ret)
+			    > lin11_to_val(data->iin_max))
+				data->iin_max = ret;
+			ret = data->iin_max;
+		}
+		break;
+	case PMBUS_VIRT_READ_IIN_MIN:
+		ret = pmbus_read_word_data(client, page, LTC2975_MFR_IIN_MIN);
+		if (ret >= 0) {
+			if (lin11_to_val(ret)
+			    < lin11_to_val(data->iin_min))
+				data->iin_min = ret;
+			ret = data->iin_min;
+		}
+		break;
+	case PMBUS_VIRT_READ_PIN_MAX:
+		ret = pmbus_read_word_data(client, page, LTC2975_MFR_PIN_PEAK);
+		if (ret >= 0) {
+			if (lin11_to_val(ret)
+			    > lin11_to_val(data->pin_max))
+				data->pin_max = ret;
+			ret = data->pin_max;
+		}
+		break;
+	case PMBUS_VIRT_READ_PIN_MIN:
+		ret = pmbus_read_word_data(client, page, LTC2975_MFR_PIN_MIN);
+		if (ret >= 0) {
+			if (lin11_to_val(ret)
+			    < lin11_to_val(data->pin_min))
+				data->pin_min = ret;
+			ret = data->pin_min;
+		}
+		break;
+	case PMBUS_VIRT_RESET_IIN_HISTORY:
+	case PMBUS_VIRT_RESET_PIN_HISTORY:
+		ret = 0;
+		break;
+	default:
+		ret = ltc2978_read_word_data(client, page, reg);
+		break;
+	}
+	return ret;
+}
+
 static int ltc3880_read_word_data(struct i2c_client *client, int page, int reg)
 {
 	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
@@ -337,7 +398,13 @@ static int ltc2978_write_word_data(struct i2c_client *client, int page,
 	switch (reg) {
 	case PMBUS_VIRT_RESET_IIN_HISTORY:
 		data->iin_max = 0x7c00;
-		ret = ltc2978_clear_peaks(client, page, data->id);
+		data->iin_min = 0x7bff;
+		ret = ltc2978_clear_peaks(client, 0, data->id);
+		break;
+	case PMBUS_VIRT_RESET_PIN_HISTORY:
+		data->pin_max = 0x7c00;
+		data->pin_min = 0x7bff;
+		ret = ltc2978_clear_peaks(client, 0, data->id);
 		break;
 	case PMBUS_VIRT_RESET_IOUT_HISTORY:
 		data->iout_max[page] = 0x7c00;
@@ -372,6 +439,7 @@ static int ltc2978_write_word_data(struct i2c_client *client, int page,
 
 static const struct i2c_device_id ltc2978_id[] = {
 	{"ltc2974", ltc2974},
+	{"ltc2975", ltc2975},
 	{"ltc2977", ltc2977},
 	{"ltc2978", ltc2978},
 	{"ltc3880", ltc3880},
@@ -428,6 +496,8 @@ static int ltc2978_get_id(struct i2c_client *client)
 
 	if (chip_id = LTC2974_ID_REV1 || chip_id = LTC2974_ID_REV2)
 		return ltc2974;
+	else if (chip_id = LTC2975_ID)
+		return ltc2975;
 	else if (chip_id = LTC2977_ID)
 		return ltc2977;
 	else if (chip_id = LTC2978_ID_REV1 || chip_id = LTC2978_ID_REV2 ||
@@ -505,6 +575,19 @@ static int ltc2978_probe(struct i2c_client *client,
 			  | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT;
 		}
 		break;
+	case ltc2975:
+		info->read_word_data = ltc2975_read_word_data;
+		info->pages = LTC2974_NUM_PAGES;
+		info->func[0] = PMBUS_HAVE_IIN | PMBUS_HAVE_PIN
+		  | PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT
+		  | PMBUS_HAVE_TEMP2;
+		for (i = 0; i < info->pages; i++) {
+			info->func[i] |= PMBUS_HAVE_VOUT
+			  | PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_POUT
+			  | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP
+			  | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT;
+		}
+		break;
 	case ltc2977:
 	case ltc2978:
 		info->read_word_data = ltc2978_read_word_data;
@@ -576,6 +659,7 @@ static int ltc2978_probe(struct i2c_client *client,
 #ifdef CONFIG_OF
 static const struct of_device_id ltc2978_of_match[] = {
 	{ .compatible = "lltc,ltc2974" },
+	{ .compatible = "lltc,ltc2975" },
 	{ .compatible = "lltc,ltc2977" },
 	{ .compatible = "lltc,ltc2978" },
 	{ .compatible = "lltc,ltc3880" },
@@ -601,5 +685,5 @@ static struct i2c_driver ltc2978_driver = {
 module_i2c_driver(ltc2978_driver);
 
 MODULE_AUTHOR("Guenter Roeck");
-MODULE_DESCRIPTION("PMBus driver for LTC2974, LTC2978, LTC3880, LTC3883, and LTM4676");
+MODULE_DESCRIPTION("PMBus driver for LTC2978 and comppatible chips");
 MODULE_LICENSE("GPL");
-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
