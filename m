From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 23 Feb 2013 02:19:35 +0000
Subject: [lm-sensors] [PATCH v2 7/7] hwmon: (pmbus/ltc2978) Add support for LTC2974 and LTC3883
Message-Id: <1361585975-5604-7-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Moved bug fixes to separate patches
    Documentation now correctly reports supported attributes for all chips
    Fixed initialization values for cached lowest and highest attributes
    Updated copyright
    Reordered definitions
    Fixed clear_peaks functions to work correctly for all chips
    Provide all supported attributes

 Documentation/hwmon/ltc2978   |  134 ++++++++++++++++++++++-------------
 drivers/hwmon/pmbus/Kconfig   |    4 +-
 drivers/hwmon/pmbus/ltc2978.c |  155 +++++++++++++++++++++++++++++++++++------
 3 files changed, 222 insertions(+), 71 deletions(-)

diff --git a/Documentation/hwmon/ltc2978 b/Documentation/hwmon/ltc2978
index dcb10be..dc0d08c 100644
--- a/Documentation/hwmon/ltc2978
+++ b/Documentation/hwmon/ltc2978
@@ -2,6 +2,10 @@ Kernel driver ltc2978
 ========== 
 Supported chips:
+  * Linear Technology LTC2974
+    Prefix: 'ltc2974'
+    Addresses scanned: -
+    Datasheet: http://www.linear.com/product/ltc2974
   * Linear Technology LTC2978
     Prefix: 'ltc2978'
     Addresses scanned: -
@@ -10,6 +14,10 @@ Supported chips:
     Prefix: 'ltc3880'
     Addresses scanned: -
     Datasheet: http://www.linear.com/product/ltc3880
+  * Linear Technology LTC3883
+    Prefix: 'ltc3883'
+    Addresses scanned: -
+    Datasheet: http://www.linear.com/product/ltc3883
 
 Author: Guenter Roeck <linux@roeck-us.net>
 
@@ -17,9 +25,9 @@ Author: Guenter Roeck <linux@roeck-us.net>
 Description
 -----------
 
-The LTC2978 is an octal power supply monitor, supervisor, sequencer and
-margin controller. The LTC3880 is a dual, PolyPhase DC/DC synchronous
-step-down switching regulator controller.
+LTC2974 is a quad digital power supply manager. LTC2978 is an octal power supply
+monitor. LTC3880 is a dual output poly-phase step-down DC/DC controller. LTC3883
+is a single phase step-down DC/DC controller.
 
 
 Usage Notes
@@ -41,60 +49,90 @@ Sysfs attributes
 in1_label		"vin"
 in1_input		Measured input voltage.
 in1_min			Minimum input voltage.
-in1_max			Maximum input voltage. LTC2978 only.
-in1_lcrit		Critical minimum input voltage. LTC2978 only.
+in1_max			Maximum input voltage. LTC2974 and LTC2978 only.
+in1_lcrit		Critical minimum input voltage. LTC2974 and LTC2978
+			only.
 in1_crit		Critical maximum input voltage.
 in1_min_alarm		Input voltage low alarm.
-in1_max_alarm		Input voltage high alarm. LTC2978 only.
-in1_lcrit_alarm		Input voltage critical low alarm. LTC2978 only.
+in1_max_alarm		Input voltage high alarm. LTC2974 and LTC2978 only.
+in1_lcrit_alarm		Input voltage critical low alarm. LTC2974 and LTC2978
+			only.
 in1_crit_alarm		Input voltage critical high alarm.
-in1_lowest		Lowest input voltage. LTC2978 only.
+in1_lowest		Lowest input voltage. LTC2974 and LTC2978 only.
 in1_highest		Highest input voltage.
 in1_reset_history	Reset input voltage history.
 
-in[2-9]_label		"vout[1-8]". Channels 3 to 9 on LTC2978 only.
-in[2-9]_input		Measured output voltage.
-in[2-9]_min		Minimum output voltage.
-in[2-9]_max		Maximum output voltage.
-in[2-9]_lcrit		Critical minimum output voltage.
-in[2-9]_crit		Critical maximum output voltage.
-in[2-9]_min_alarm	Output voltage low alarm.
-in[2-9]_max_alarm	Output voltage high alarm.
-in[2-9]_lcrit_alarm	Output voltage critical low alarm.
-in[2-9]_crit_alarm	Output voltage critical high alarm.
-in[2-9]_lowest		Lowest output voltage. LTC2978 only.
-in[2-9]_highest		Lowest output voltage.
-in[2-9]_reset_history	Reset output voltage history.
-
-temp[1-3]_input		Measured temperature.
+in[N]_label		"vout[1-8]".
+			LTC2974: N=2-5
+			LTC2978: N=2-9
+			LTC3880: N=2-3
+			LTC3883: N=2
+in[N]_input		Measured output voltage.
+in[N]_min		Minimum output voltage.
+in[N]_max		Maximum output voltage.
+in[N]_lcrit		Critical minimum output voltage.
+in[N]_crit		Critical maximum output voltage.
+in[N]_min_alarm		Output voltage low alarm.
+in[N]_max_alarm		Output voltage high alarm.
+in[N]_lcrit_alarm	Output voltage critical low alarm.
+in[N]_crit_alarm	Output voltage critical high alarm.
+in[N]_lowest		Lowest output voltage. LTC2974 and LTC2978 only.
+in[N]_highest		Highest output voltage.
+in[N]_reset_history	Reset output voltage history.
+
+temp[N]_input		Measured temperature.
+			On LTC2974, temp[1-4] report external temperatures,
+			and temp5 reports the chip temperature.
 			On LTC2978, only one temperature measurement is
 			supported and reports the chip temperature.
 			On LTC3880, temp1 and temp2 report external
-			temperatures, and temp3 reports the chip
-			temperature.
-temp[1-3]_min		Mimimum temperature. LTC2978 only.
-temp[1-3]_max		Maximum temperature.
-temp[1-3]_lcrit		Critical low temperature.
-temp[1-3]_crit		Critical high temperature.
-temp[1-3]_min_alarm	Temperature low alarm. LTC2978 only.
-temp[1-3]_max_alarm	Temperature high alarm.
-temp[1-3]_lcrit_alarm	Temperature critical low alarm.
-temp[1-3]_crit_alarm	Temperature critical high alarm.
-temp[1-3]_lowest	Lowest measured temperature. LTC2978 only.
-temp[1-3]_highest	Highest measured temperature.
-temp[1-3]_reset_history	Reset temperature history.
-
-power[1-2]_label	"pout[1-2]". LTC3880 only.
-power[1-2]_input	Measured power.
-
-curr1_label		"iin". LTC3880 only.
+			temperatures, and temp3 reports the chip temperature.
+			On LTC3883, temp1 reports an external temperature,
+			and temp2 reports the chip temperature.
+temp[N]_min		Mimimum temperature. LTC2974 and LTC2978 only.
+temp[N]_max		Maximum temperature.
+temp[N]_lcrit		Critical low temperature.
+temp[N]_crit		Critical high temperature.
+temp[N]_min_alarm	Temperature low alarm. LTC2974 and LTC2978 only.
+temp[N]_max_alarm	Temperature high alarm.
+temp[N]_lcrit_alarm	Temperature critical low alarm.
+temp[N]_crit_alarm	Temperature critical high alarm.
+temp[N]_lowest		Lowest measured temperature. LTC2974 and LTC2978 only.
+			Not supported for chip temperature sensor on LTC2974.
+temp[N]_highest		Highest measured temperature. Not supported for chip
+			temperature sensor on LTC2974.
+temp[N]_reset_history	Reset temperature history. Not supported for chip
+			temperature sensor on LTC2974.
+
+power1_label		"pin". LTC3883 only.
+power1_input		Measured input power.
+
+power[N]_label		"pout[1-4]".
+			LTC2974: N=1-4
+			LTC2978: Not supported
+			LTC3880: N=1-2
+			LTC3883: N=2
+power[N]_input		Measured output power.
+
+curr1_label		"iin". LTC3880 and LTC3883 only.
 curr1_input		Measured input current.
 curr1_max		Maximum input current.
 curr1_max_alarm		Input current high alarm.
-
-curr[2-3]_label		"iout[1-2]". LTC3880 only.
-curr[2-3]_input		Measured output current.
-curr[2-3]_max		Maximum output current.
-curr[2-3]_crit		Critical output current.
-curr[2-3]_max_alarm	Output current high alarm.
-curr[2-3]_crit_alarm	Output current critical high alarm.
+curr1_highest		Highest input current. LTC3883 only.
+curr1_reset_history	Reset input current history. LTC3883 only.
+
+curr[N]_label		"iout[1-4]".
+			LTC2974: N=1-4
+			LTC2978: not supported
+			LTC3880: N=2-3
+			LTC3883: N=2
+curr[N]_input		Measured output current.
+curr[N]_max		Maximum output current.
+curr[N]_crit		Critical high output current.
+curr[N]_lcrit		Critical low output current. LTC2974 only.
+curr[N]_max_alarm	Output current high alarm.
+curr[N]_crit_alarm	Output current critical high alarm.
+curr[N]_lcrit_alarm	Output current critical low alarm. LTC2974 only.
+curr[N]_lowest		Lowest output current. LTC2974 only.
+curr[N]_highest		Highest output current.
+curr[N]_reset_history	Reset output current history.
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 4f9eb0a..b1adad6 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -48,11 +48,11 @@ config SENSORS_LM25066
 	  be called lm25066.
 
 config SENSORS_LTC2978
-	tristate "Linear Technologies LTC2978 and LTC3880"
+	tristate "Linear Technologies LTC2974, LTC2978, LTC3880, and LTC3883"
 	default n
 	help
 	  If you say yes here you get hardware monitoring support for Linear
-	  Technology LTC2978 and LTC3880.
+	  Technology LTC2974, LTC2978, LTC3880, and LTC3883.
 
 	  This driver can also be built as a module. If so, the module will
 	  be called ltc2978.
diff --git a/drivers/hwmon/pmbus/ltc2978.c b/drivers/hwmon/pmbus/ltc2978.c
index e21ef2f..cc6b635 100644
--- a/drivers/hwmon/pmbus/ltc2978.c
+++ b/drivers/hwmon/pmbus/ltc2978.c
@@ -1,7 +1,8 @@
 /*
- * Hardware monitoring driver for LTC2978 and LTC3880
+ * Hardware monitoring driver for LTC2974, LTC2978, LTC3880, and LTC3883
  *
  * Copyright (c) 2011 Ericsson AB.
+ * Copyright (c) 2013 Guenter Roeck
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -26,28 +27,44 @@
 #include <linux/i2c.h>
 #include "pmbus.h"
 
-enum chips { ltc2978, ltc3880 };
+enum chips { ltc2974, ltc2978, ltc3880, ltc3883 };
 
-/* LTC2978 and LTC3880 */
+/* Common for all chips */
 #define LTC2978_MFR_VOUT_PEAK		0xdd
 #define LTC2978_MFR_VIN_PEAK		0xde
 #define LTC2978_MFR_TEMPERATURE_PEAK	0xdf
 #define LTC2978_MFR_SPECIAL_ID		0xe7
 
-/* LTC2978 only */
+/* LTC2974 and LTC2978 */
 #define LTC2978_MFR_VOUT_MIN		0xfb
 #define LTC2978_MFR_VIN_MIN		0xfc
 #define LTC2978_MFR_TEMPERATURE_MIN	0xfd
 
-/* LTC3880 only */
+/* LTC2974 only */
+#define LTC2974_MFR_IOUT_PEAK		0xd7
+#define LTC2974_MFR_IOUT_MIN		0xd8
+
+/* LTC3880 and LTC3883 */
 #define LTC3880_MFR_IOUT_PEAK		0xd7
 #define LTC3880_MFR_CLEAR_PEAKS		0xe3
 #define LTC3880_MFR_TEMPERATURE2_PEAK	0xf4
 
+/* LTC3883 only */
+#define LTC3883_MFR_IIN_PEAK		0xe1
+
+#define LTC2974_ID			0x0212
 #define LTC2978_ID_REV1			0x0121
 #define LTC2978_ID_REV2			0x0122
 #define LTC3880_ID			0x4000
 #define LTC3880_ID_MASK			0xff00
+#define LTC3883_ID			0x4300
+
+#define LTC2974_NUM_PAGES		4
+#define LTC2978_NUM_PAGES		8
+#define LTC3880_NUM_PAGES		2
+#define LTC3883_NUM_PAGES		1
+
+#define MAX_NUM_PAGES			LTC2978_NUM_PAGES
 
 /*
  * LTC2978 clears peak data whenever the CLEAR_FAULTS command is executed, which
@@ -59,9 +76,10 @@ enum chips { ltc2978, ltc3880 };
 struct ltc2978_data {
 	enum chips id;
 	int vin_min, vin_max;
-	int temp_min, temp_max[8];
-	int vout_min[8], vout_max[8];
-	int iout_max[8];
+	int temp_min[MAX_NUM_PAGES], temp_max[MAX_NUM_PAGES];
+	int vout_min[MAX_NUM_PAGES], vout_max[MAX_NUM_PAGES];
+	int iout_min[MAX_NUM_PAGES], iout_max[MAX_NUM_PAGES];
+	int iin_max;
 	int temp2_max;
 	struct pmbus_driver_info info;
 };
@@ -167,9 +185,9 @@ static int ltc2978_read_word_data(struct i2c_client *client, int page, int reg)
 					   LTC2978_MFR_TEMPERATURE_MIN);
 		if (ret >= 0) {
 			if (lin11_to_val(ret)
-			    < lin11_to_val(data->temp_min))
-				data->temp_min = ret;
-			ret = data->temp_min;
+			    < lin11_to_val(data->temp_min[page]))
+				data->temp_min[page] = ret;
+			ret = data->temp_min[page];
 		}
 		break;
 	case PMBUS_VIRT_READ_IOUT_MAX:
@@ -185,6 +203,41 @@ static int ltc2978_read_word_data(struct i2c_client *client, int page, int reg)
 	return ret;
 }
 
+static int ltc2974_read_word_data(struct i2c_client *client, int page, int reg)
+{
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	struct ltc2978_data *data = to_ltc2978_data(info);
+	int ret;
+
+	switch (reg) {
+	case PMBUS_VIRT_READ_IOUT_MAX:
+		ret = pmbus_read_word_data(client, page, LTC2974_MFR_IOUT_PEAK);
+		if (ret >= 0) {
+			if (lin11_to_val(ret)
+			    > lin11_to_val(data->iout_max[page]))
+				data->iout_max[page] = ret;
+			ret = data->iout_max[page];
+		}
+		break;
+	case PMBUS_VIRT_READ_IOUT_MIN:
+		ret = pmbus_read_word_data(client, page, LTC2974_MFR_IOUT_MIN);
+		if (ret >= 0) {
+			if (lin11_to_val(ret)
+			    < lin11_to_val(data->iout_min[page]))
+				data->iout_min[page] = ret;
+			ret = data->iout_min[page];
+		}
+		break;
+	case PMBUS_VIRT_RESET_IOUT_HISTORY:
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
@@ -226,15 +279,41 @@ static int ltc3880_read_word_data(struct i2c_client *client, int page, int reg)
 	return ret;
 }
 
+static int ltc3883_read_word_data(struct i2c_client *client, int page, int reg)
+{
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	struct ltc2978_data *data = to_ltc2978_data(info);
+	int ret;
+
+	switch (reg) {
+	case PMBUS_VIRT_READ_IIN_MAX:
+		ret = pmbus_read_word_data(client, page, LTC3883_MFR_IIN_PEAK);
+		if (ret >= 0) {
+			if (lin11_to_val(ret)
+			    > lin11_to_val(data->iin_max))
+				data->iin_max = ret;
+			ret = data->iin_max;
+		}
+		break;
+	case PMBUS_VIRT_RESET_IIN_HISTORY:
+		ret = 0;
+		break;
+	default:
+		ret = ltc3880_read_word_data(client, page, reg);
+		break;
+	}
+	return ret;
+}
+
 static int ltc2978_clear_peaks(struct i2c_client *client, int page,
 			       enum chips id)
 {
 	int ret;
 
-	if (id = ltc2978)
-		ret = pmbus_write_byte(client, page, PMBUS_CLEAR_FAULTS);
-	else
+	if (id = ltc3880 || id = ltc3883)
 		ret = pmbus_write_byte(client, 0, LTC3880_MFR_CLEAR_PEAKS);
+	else
+		ret = pmbus_write_byte(client, page, PMBUS_CLEAR_FAULTS);
 
 	return ret;
 }
@@ -247,8 +326,13 @@ static int ltc2978_write_word_data(struct i2c_client *client, int page,
 	int ret;
 
 	switch (reg) {
+	case PMBUS_VIRT_RESET_IIN_HISTORY:
+		data->iin_max = 0x7c00;
+		ret = ltc2978_clear_peaks(client, page, data->id);
+		break;
 	case PMBUS_VIRT_RESET_IOUT_HISTORY:
 		data->iout_max[page] = 0x7c00;
+		data->iout_min[page] = 0xfbff;
 		ret = ltc2978_clear_peaks(client, page, data->id);
 		break;
 	case PMBUS_VIRT_RESET_TEMP2_HISTORY:
@@ -266,7 +350,7 @@ static int ltc2978_write_word_data(struct i2c_client *client, int page,
 		ret = ltc2978_clear_peaks(client, page, data->id);
 		break;
 	case PMBUS_VIRT_RESET_TEMP_HISTORY:
-		data->temp_min = 0xfbff;
+		data->temp_min[page] = 0xfbff;
 		data->temp_max[page] = 0x7c00;
 		ret = ltc2978_clear_peaks(client, page, data->id);
 		break;
@@ -278,8 +362,10 @@ static int ltc2978_write_word_data(struct i2c_client *client, int page,
 }
 
 static const struct i2c_device_id ltc2978_id[] = {
+	{"ltc2974", ltc2974},
 	{"ltc2978", ltc2978},
 	{"ltc3880", ltc3880},
+	{"ltc3883", ltc3883},
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, ltc2978_id);
@@ -304,10 +390,14 @@ static int ltc2978_probe(struct i2c_client *client,
 	if (chip_id < 0)
 		return chip_id;
 
-	if (chip_id = LTC2978_ID_REV1 || chip_id = LTC2978_ID_REV2) {
+	if (chip_id = LTC2974_ID) {
+		data->id = ltc2974;
+	} else if (chip_id = LTC2978_ID_REV1 || chip_id = LTC2978_ID_REV2) {
 		data->id = ltc2978;
 	} else if ((chip_id & LTC3880_ID_MASK) = LTC3880_ID) {
 		data->id = ltc3880;
+	} else if ((chip_id & LTC3880_ID_MASK) = LTC3883_ID) {
+		data->id = ltc3883;
 	} else {
 		dev_err(&client->dev, "Unsupported chip ID 0x%x\n", chip_id);
 		return -ENODEV;
@@ -323,24 +413,35 @@ static int ltc2978_probe(struct i2c_client *client,
 
 	data->vin_min = 0x7bff;
 	data->vin_max = 0x7c00;
-	data->temp_min = 0x7bff;
 	data->temp2_max = 0x7c00;
 
 	switch (data->id) {
+	case ltc2974:
+		info->read_word_data = ltc2974_read_word_data;
+		info->pages = LTC2974_NUM_PAGES;
+		info->func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT
+		  | PMBUS_HAVE_TEMP2;
+		for (i = 0; i < info->pages; i++) {
+			info->func[i] |= PMBUS_HAVE_VOUT
+			  | PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_POUT
+			  | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP
+			  | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT;
+		}
+		break;
 	case ltc2978:
 		info->read_word_data = ltc2978_read_word_data;
-		info->pages = 8;
+		info->pages = LTC2978_NUM_PAGES;
 		info->func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT
 		  | PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
 		  | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
-		for (i = 1; i < 8; i++) {
+		for (i = 1; i < info->pages; i++) {
 			info->func[i] = PMBUS_HAVE_VOUT
 			  | PMBUS_HAVE_STATUS_VOUT;
 		}
 		break;
 	case ltc3880:
 		info->read_word_data = ltc3880_read_word_data;
-		info->pages = 2;
+		info->pages = LTC3880_NUM_PAGES;
 		info->func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN
 		  | PMBUS_HAVE_STATUS_INPUT
 		  | PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
@@ -352,12 +453,24 @@ static int ltc2978_probe(struct i2c_client *client,
 		  | PMBUS_HAVE_POUT
 		  | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
 		break;
+	case ltc3883:
+		info->read_word_data = ltc3883_read_word_data;
+		info->pages = LTC3883_NUM_PAGES;
+		info->func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN
+		  | PMBUS_HAVE_STATUS_INPUT
+		  | PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
+		  | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT
+		  | PMBUS_HAVE_PIN | PMBUS_HAVE_POUT | PMBUS_HAVE_TEMP
+		  | PMBUS_HAVE_TEMP2 | PMBUS_HAVE_STATUS_TEMP;
+		break;
 	default:
 		return -ENODEV;
 	}
 	for (i = 0; i < info->pages; i++) {
+		data->temp_min[i] = 0x7bff;
 		data->temp_max[i] = 0x7c00;
 		data->vout_min[i] = 0xffff;
+		data->iout_min[i] = 0xfbff;
 		data->iout_max[i] = 0x7c00;
 	}
 
@@ -377,5 +490,5 @@ static struct i2c_driver ltc2978_driver = {
 module_i2c_driver(ltc2978_driver);
 
 MODULE_AUTHOR("Guenter Roeck");
-MODULE_DESCRIPTION("PMBus driver for LTC2978 and LTC3880");
+MODULE_DESCRIPTION("PMBus driver for LTC2974, LTC2978, LTC3880, and LTC3883");
 MODULE_LICENSE("GPL");
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
