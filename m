From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 23 Sep 2011 03:31:31 +0000
Subject: [lm-sensors] [PATCH 3/4] hwmon: (pmbus/ltc2978) Add support for
Message-Id: <1316748692-8326-4-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The LTC3880 PMBus command set is comparable to LTC2978. Add support for it
to the LTC2978 driver.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 Documentation/hwmon/ltc2978   |   57 ++++++++++++-----
 drivers/hwmon/pmbus/Kconfig   |    4 +-
 drivers/hwmon/pmbus/ltc2978.c |  137 +++++++++++++++++++++++++++++++++++++----
 3 files changed, 168 insertions(+), 30 deletions(-)

diff --git a/Documentation/hwmon/ltc2978 b/Documentation/hwmon/ltc2978
index f4cba8c..1419a19 100644
--- a/Documentation/hwmon/ltc2978
+++ b/Documentation/hwmon/ltc2978
@@ -6,6 +6,10 @@ Supported chips:
     Prefix: 'ltc2978'
     Addresses scanned: -
     Datasheet: http://cds.linear.com/docs/Datasheet/2978fa.pdf
+  * Linear Technology LTC3880
+    Prefix: 'ltc3880'
+    Addresses scanned: -
+    Datasheet: http://cds.linear.com/docs/Datasheet/3880f.pdf
 
 Author: Guenter Roeck <guenter.roeck@ericsson.com>
 
@@ -14,7 +18,8 @@ Description
 -----------
 
 The LTC2978 is an octal power supply monitor, supervisor, sequencer and
-margin controller.
+margin controller. The LTC3880 is a dual, PolyPhase DC/DC synchronous
+step-down switching regulator controller.
 
 
 Usage Notes
@@ -43,12 +48,12 @@ in1_min_alarm		Input voltage low alarm.
 in1_max_alarm		Input voltage high alarm.
 in1_lcrit_alarm		Input voltage critical low alarm.
 in1_crit_alarm		Input voltage critical high alarm.
-in1_lowest		Lowest input voltage.
+in1_lowest		Lowest input voltage. LTC2978 only.
 in1_highest		Highest input voltage.
 in1_reset_history	Reset history. Writing into this attribute will reset
 			history for all attributes.
 
-in[2-9]_label		"vout[1-8]".
+in[2-9]_label		"vout[1-8]". Channels 3 to 9 on LTC2978 only.
 in[2-9]_input		Measured output voltage.
 in[2-9]_min		Minimum output Voltage.
 in[2-9]_max		Maximum output voltage.
@@ -58,21 +63,41 @@ in[2-9]_min_alarm	Output voltage low alarm.
 in[2-9]_max_alarm	Output voltage high alarm.
 in[2-9]_lcrit_alarm	Output voltage critical low alarm.
 in[2-9]_crit_alarm	Output voltage critical high alarm.
-in[2-9]_lowest		Lowest output voltage.
+in[2-9]_lowest		Lowest output voltage. LTC2978 only.
 in[2-9]_highest		Lowest output voltage.
 in[2-9]_reset_history	Reset history. Writing into this attribute will reset
 			history for all attributes.
 
-temp1_input		Measured temperature.
-temp1_min		Mimimum temperature.
-temp1_max		Maximum temperature.
-temp1_lcrit		Critical low temperature.
-temp1_crit		Critical high temperature.
-temp1_min_alarm		Chip temperature low alarm.
-temp1_max_alarm		Chip temperature high alarm.
-temp1_lcrit_alarm	Chip temperature critical low alarm.
-temp1_crit_alarm	Chip temperature critical high alarm.
-temp1_lowest		Lowest measured temperature.
-temp1_highest		Highest measured temperature.
-temp1_reset_history	Reset history. Writing into this attribute will reset
+temp[1-3]_input		Measured temperature.
+			On LTC2978, only one temperature measurement is
+			supported and reflects the internal temperature.
+			On LTC3880, temp1 and temp2 report external
+			temperatures, and temp3 reports the internal
+			temperature.
+temp[1-3]_min		Mimimum temperature.
+temp[1-3]_max		Maximum temperature.
+temp[1-3]_lcrit		Critical low temperature.
+temp[1-3]_crit		Critical high temperature.
+temp[1-3]_min_alarm	Chip temperature low alarm.
+temp[1-3]_max_alarm	Chip temperature high alarm.
+temp[1-3]_lcrit_alarm	Chip temperature critical low alarm.
+temp[1-3]_crit_alarm	Chip temperature critical high alarm.
+temp[1-3]_lowest	Lowest measured temperature. LTC2978 only.
+temp[1-3]_highest	Highest measured temperature.
+temp[1-3]_reset_history	Reset history. Writing into this attribute will reset
 			history for all attributes.
+
+power[1-2]_label	"pout[1-2]". LTC3880 only.
+power[1-2]_input	Measured power.
+
+curr1_label		"iin". LTC3880 only.
+curr1_input		Measured input current.
+curr1_max		Maximum input current.
+curr1_max_alarm		Input current high alarm.
+
+curr[2-3]_label		"iout[1-2]". LTC3880 only.
+curr[2-3]_input		Measured input current.
+curr[2-3]_max		Maximum input current.
+curr[2-3]_crit		Critical input current.
+curr[2-3]_max_alarm	Input current high alarm.
+curr[2-3]_crit_alarm	Input current critical high alarm.
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index c4dcdca..4b26f51 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -47,11 +47,11 @@ config SENSORS_LM25066
 	  be called lm25066.
 
 config SENSORS_LTC2978
-	tristate "Linear Technologies LTC2978"
+	tristate "Linear Technologies LTC2978 and LTC3880"
 	default n
 	help
 	  If you say yes here you get hardware monitoring support for Linear
-	  Technology LTC2978.
+	  Technology LTC2978 and LTC3880.
 
 	  This driver can also be built as a module. If so, the module will
 	  be called ltc2978.
diff --git a/drivers/hwmon/pmbus/ltc2978.c b/drivers/hwmon/pmbus/ltc2978.c
index 0c8e2a6..b8ee20b 100644
--- a/drivers/hwmon/pmbus/ltc2978.c
+++ b/drivers/hwmon/pmbus/ltc2978.c
@@ -1,5 +1,5 @@
 /*
- * Hardware monitoring driver for LTC2978
+ * Hardware monitoring driver for LTC2978 and LTC3880
  *
  * Copyright (c) 2011 Ericsson AB.
  *
@@ -26,19 +26,28 @@
 #include <linux/i2c.h>
 #include "pmbus.h"
 
-enum chips { ltc2978 };
+enum chips { ltc2978, ltc3880 };
 
+/* LTC2978 and LTC3880 */
 #define LTC2978_MFR_VOUT_PEAK		0xdd
 #define LTC2978_MFR_VIN_PEAK		0xde
 #define LTC2978_MFR_TEMPERATURE_PEAK	0xdf
 #define LTC2978_MFR_SPECIAL_ID		0xe7
 
+/* LTC2978 only */
 #define LTC2978_MFR_VOUT_MIN		0xfb
 #define LTC2978_MFR_VIN_MIN		0xfc
 #define LTC2978_MFR_TEMPERATURE_MIN	0xfd
 
+/* LTC3880 only */
+#define LTC3880_MFR_IOUT_PEAK		0xd7
+#define LTC3880_MFR_CLEAR_PEAKS		0xe3
+#define LTC3880_MFR_TEMPERATURE2_PEAK	0xf4
+
 #define LTC2978_ID_REV1			0x0121
 #define LTC2978_ID_REV2			0x0122
+#define LTC3880_ID			0x4000
+#define LTC3880_ID_MASK			0xff00
 
 /*
  * LTC2978 clears peak data whenever the CLEAR_FAULTS command is executed, which
@@ -52,6 +61,8 @@ struct ltc2978_data {
 	int vin_min, vin_max;
 	int temp_min, temp_max;
 	int vout_min[8], vout_max[8];
+	int iout_max[2];
+	int temp2_max[2];
 	struct pmbus_driver_info info;
 };
 
@@ -75,7 +86,8 @@ static inline int lin11_to_val(int data)
 	return (e < 0 ? m >> -e : m << e);
 }
 
-static int ltc2978_read_word_data(struct i2c_client *client, int page, int reg)
+static int ltc2978_read_word_data_common(struct i2c_client *client, int page,
+					 int reg)
 {
 	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
 	struct ltc2978_data *data = to_ltc2978_data(info);
@@ -111,6 +123,25 @@ static int ltc2978_read_word_data(struct i2c_client *client, int page, int reg)
 			ret = data->temp_max;
 		}
 		break;
+	case PMBUS_VIRT_RESET_VOUT_HISTORY:
+	case PMBUS_VIRT_RESET_VIN_HISTORY:
+	case PMBUS_VIRT_RESET_TEMP_HISTORY:
+		ret = 0;
+		break;
+	default:
+		ret = -ENODATA;
+		break;
+	}
+	return ret;
+}
+
+static int ltc2978_read_word_data(struct i2c_client *client, int page, int reg)
+{
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	struct ltc2978_data *data = to_ltc2978_data(info);
+	int ret;
+
+	switch (reg) {
 	case PMBUS_VIRT_READ_VIN_MIN:
 		ret = pmbus_read_word_data(client, page, LTC2978_MFR_VIN_MIN);
 		if (ret >= 0) {
@@ -145,18 +176,74 @@ static int ltc2978_read_word_data(struct i2c_client *client, int page, int reg)
 			ret = data->temp_min;
 		}
 		break;
-	case PMBUS_VIRT_RESET_VOUT_HISTORY:
-	case PMBUS_VIRT_RESET_VIN_HISTORY:
-	case PMBUS_VIRT_RESET_TEMP_HISTORY:
+	case PMBUS_VIRT_READ_IOUT_MAX:
+	case PMBUS_VIRT_RESET_IOUT_HISTORY:
+	case PMBUS_VIRT_READ_TEMP2_MAX:
+	case PMBUS_VIRT_RESET_TEMP2_HISTORY:
+		ret = -ENXIO;
+		break;
+	default:
+		ret = ltc2978_read_word_data_common(client, page, reg);
+		break;
+	}
+	return ret;
+}
+
+static int ltc3880_read_word_data(struct i2c_client *client, int page, int reg)
+{
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	struct ltc2978_data *data = to_ltc2978_data(info);
+	int ret;
+
+	switch (reg) {
+	case PMBUS_VIRT_READ_IOUT_MAX:
+		ret = pmbus_read_word_data(client, page, LTC3880_MFR_IOUT_PEAK);
+		if (ret >= 0) {
+			if (lin11_to_val(ret)
+			    > lin11_to_val(data->iout_max[page]))
+				data->iout_max[page] = ret;
+			ret = data->iout_max[page];
+		}
+		break;
+	case PMBUS_VIRT_READ_TEMP2_MAX:
+		ret = pmbus_read_word_data(client, page,
+					   LTC3880_MFR_TEMPERATURE2_PEAK);
+		if (ret >= 0) {
+			if (lin11_to_val(ret)
+			    > lin11_to_val(data->temp2_max[page]))
+				data->temp2_max[page] = ret;
+			ret = data->temp2_max[page];
+		}
+		break;
+	case PMBUS_VIRT_READ_VIN_MIN:
+	case PMBUS_VIRT_READ_VOUT_MIN:
+	case PMBUS_VIRT_READ_TEMP_MIN:
+		ret = -ENXIO;
+		break;
+	case PMBUS_VIRT_RESET_IOUT_HISTORY:
+	case PMBUS_VIRT_RESET_TEMP2_HISTORY:
 		ret = 0;
 		break;
 	default:
-		ret = -ENODATA;
+		ret = ltc2978_read_word_data_common(client, page, reg);
 		break;
 	}
 	return ret;
 }
 
+static int ltc2978_clear_peaks(struct i2c_client *client, int page,
+			       enum chips id)
+{
+	int ret;
+
+	if (id = ltc2978)
+		ret = pmbus_write_byte(client, page, PMBUS_CLEAR_FAULTS);
+	else
+		ret = pmbus_write_byte(client, 0, LTC3880_MFR_CLEAR_PEAKS);
+
+	return ret;
+}
+
 static int ltc2978_write_word_data(struct i2c_client *client, int page,
 				    int reg, u16 word)
 {
@@ -165,20 +252,28 @@ static int ltc2978_write_word_data(struct i2c_client *client, int page,
 	int ret;
 
 	switch (reg) {
+	case PMBUS_VIRT_RESET_IOUT_HISTORY:
+		data->iout_max[page] = 0x7fff;
+		ret = ltc2978_clear_peaks(client, page, data->id);
+		break;
+	case PMBUS_VIRT_RESET_TEMP2_HISTORY:
+		data->temp2_max[page] = 0x7fff;
+		ret = ltc2978_clear_peaks(client, page, data->id);
+		break;
 	case PMBUS_VIRT_RESET_VOUT_HISTORY:
 		data->vout_min[page] = 0xffff;
 		data->vout_max[page] = 0;
-		ret = pmbus_write_byte(client, page, PMBUS_CLEAR_FAULTS);
+		ret = ltc2978_clear_peaks(client, page, data->id);
 		break;
 	case PMBUS_VIRT_RESET_VIN_HISTORY:
 		data->vin_min = 0x7bff;
 		data->vin_max = 0;
-		ret = pmbus_write_byte(client, page, PMBUS_CLEAR_FAULTS);
+		ret = ltc2978_clear_peaks(client, page, data->id);
 		break;
 	case PMBUS_VIRT_RESET_TEMP_HISTORY:
 		data->temp_min = 0x7bff;
 		data->temp_max = 0x7fff;
-		ret = pmbus_write_byte(client, page, PMBUS_CLEAR_FAULTS);
+		ret = ltc2978_clear_peaks(client, page, data->id);
 		break;
 	default:
 		ret = -ENODATA;
@@ -189,6 +284,7 @@ static int ltc2978_write_word_data(struct i2c_client *client, int page,
 
 static const struct i2c_device_id ltc2978_id[] = {
 	{"ltc2978", ltc2978},
+	{"ltc3880", ltc3880},
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, ltc2978_id);
@@ -216,6 +312,8 @@ static int ltc2978_probe(struct i2c_client *client,
 
 	if (chip_id = LTC2978_ID_REV1 || chip_id = LTC2978_ID_REV2) {
 		data->id = ltc2978;
+	} else if ((chip_id & LTC3880_ID_MASK) = LTC3880_ID) {
+		data->id = ltc3880;
 	} else {
 		dev_err(&client->dev, "Unsupported chip ID 0x%x\n", chip_id);
 		ret = -ENODEV;
@@ -228,7 +326,6 @@ static int ltc2978_probe(struct i2c_client *client,
 			 ltc2978_id[data->id].name);
 
 	info = &data->info;
-	info->read_word_data = ltc2978_read_word_data;
 	info->write_word_data = ltc2978_write_word_data;
 
 	data->vout_min[0] = 0xffff;
@@ -238,6 +335,7 @@ static int ltc2978_probe(struct i2c_client *client,
 
 	switch (id->driver_data) {
 	case ltc2978:
+		info->read_word_data = ltc2978_read_word_data;
 		info->pages = 8;
 		info->func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT
 		  | PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
@@ -248,6 +346,21 @@ static int ltc2978_probe(struct i2c_client *client,
 			data->vout_min[i] = 0xffff;
 		}
 		break;
+	case ltc3880:
+		info->read_word_data = ltc3880_read_word_data;
+		info->pages = 2;
+		info->func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN
+		  | PMBUS_HAVE_STATUS_INPUT
+		  | PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
+		  | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT
+		  | PMBUS_HAVE_POUT | PMBUS_HAVE_TEMP
+		  | PMBUS_HAVE_TEMP2 | PMBUS_HAVE_STATUS_TEMP;
+		info->func[1] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
+		  | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT
+		  | PMBUS_HAVE_POUT
+		  | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
+		data->vout_min[1] = 0xffff;
+		break;
 	default:
 		ret = -ENODEV;
 		goto err_mem;
@@ -294,7 +407,7 @@ static void __exit ltc2978_exit(void)
 }
 
 MODULE_AUTHOR("Guenter Roeck");
-MODULE_DESCRIPTION("PMBus driver for LTC2978");
+MODULE_DESCRIPTION("PMBus driver for LTC2978 and LTC3880");
 MODULE_LICENSE("GPL");
 module_init(ltc2978_init);
 module_exit(ltc2978_exit);
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
