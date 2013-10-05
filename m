From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 05 Oct 2013 21:29:32 +0000
Subject: [lm-sensors] [PATCH 1/3] hwmon: (pmbus/lm25066) Add support for LM25063
Message-Id: <1381008574-21557-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/lm25066   |   20 ++++++++-
 drivers/hwmon/pmbus/lm25066.c |   91 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 101 insertions(+), 10 deletions(-)

diff --git a/Documentation/hwmon/lm25066 b/Documentation/hwmon/lm25066
index c1b57d7..b34c3de 100644
--- a/Documentation/hwmon/lm25066
+++ b/Documentation/hwmon/lm25066
@@ -8,6 +8,11 @@ Supported chips:
     Datasheets:
 	http://www.ti.com/lit/gpn/lm25056
 	http://www.ti.com/lit/gpn/lm25056a
+  * TI LM25063
+    Prefix: 'lm25063'
+    Addresses scanned: -
+    Datasheet:
+	To be announced
   * National Semiconductor LM25066
     Prefix: 'lm25066'
     Addresses scanned: -
@@ -32,7 +37,7 @@ Description
 -----------
 
 This driver supports hardware montoring for National Semiconductor / TI LM25056,
-LM25066, LM5064, and LM5064 Power Management, Monitoring, Control, and
+LM25063, LM25066, LM5064, and LM5066 Power Management, Monitoring, Control, and
 Protection ICs.
 
 The driver is a client driver to the core PMBus driver. Please see
@@ -64,8 +69,12 @@ in1_input		Measured input voltage.
 in1_average		Average measured input voltage.
 in1_min			Minimum input voltage.
 in1_max			Maximum input voltage.
+in1_crit		Critical high input voltage (LM25063 only).
+in1_lcrit		Critical low input voltage (LM25063 only).
 in1_min_alarm		Input voltage low alarm.
 in1_max_alarm		Input voltage high alarm.
+in1_lcrit_alarm		Input voltage critical low alarm (LM25063 only).
+in1_crit_alarm		Input voltage critical high alarm. (LM25063 only).
 
 in2_label		"vmon"
 in2_input		Measured voltage on VAUX pin
@@ -80,12 +89,16 @@ in3_input		Measured output voltage.
 in3_average		Average measured output voltage.
 in3_min			Minimum output voltage.
 in3_min_alarm		Output voltage low alarm.
+in3_highest		Historical minimum output voltage (LM25063 only).
+in3_lowest		Historical maximum output voltage (LM25063 only).
 
 curr1_label		"iin"
 curr1_input		Measured input current.
 curr1_average		Average measured input current.
 curr1_max		Maximum input current.
+curr1_crit		Critical input current (LM25063 only).
 curr1_max_alarm		Input current high alarm.
+curr1_crit_alarm	Input current critical high alarm (LM25063 only).
 
 power1_label		"pin"
 power1_input		Measured input power.
@@ -95,6 +108,11 @@ power1_alarm		Input power alarm
 power1_input_highest	Historical maximum power.
 power1_reset_history	Write any value to reset maximum power history.
 
+power2_label		"pout". LM25063 only.
+power2_input		Measured output power.
+power2_max		Maximum output power limit.
+power2_crit		Critical output power limit.
+
 temp1_input		Measured temperature.
 temp1_max		Maximum temperature.
 temp1_crit		Critical high temperature.
diff --git a/drivers/hwmon/pmbus/lm25066.c b/drivers/hwmon/pmbus/lm25066.c
index 6a9d6ed..a26b1d1 100644
--- a/drivers/hwmon/pmbus/lm25066.c
+++ b/drivers/hwmon/pmbus/lm25066.c
@@ -1,5 +1,5 @@
 /*
- * Hardware monitoring driver for LM25056 / LM25066 / LM5064 / LM5066
+ * Hardware monitoring driver for LM25056 / LM25063 / LM25066 / LM5064 / LM5066
  *
  * Copyright (c) 2011 Ericsson AB.
  * Copyright (c) 2013 Guenter Roeck
@@ -27,7 +27,7 @@
 #include <linux/i2c.h>
 #include "pmbus.h"
 
-enum chips { lm25056, lm25066, lm5064, lm5066 };
+enum chips { lm25056, lm25063, lm25066, lm5064, lm5066 };
 
 #define LM25066_READ_VAUX		0xd0
 #define LM25066_MFR_READ_IIN		0xd1
@@ -52,6 +52,11 @@ enum chips { lm25056, lm25066, lm5064, lm5066 };
 #define LM25056_MFR_STS_VAUX_OV_WARN	(1 << 1)
 #define LM25056_MFR_STS_VAUX_UV_WARN	(1 << 0)
 
+/* LM25063 only */
+
+#define LM25063_READ_VOUT_MAX		0xe5
+#define LM25063_READ_VOUT_MIN		0xe6
+
 struct __coeff {
 	short m, b, R;
 };
@@ -59,7 +64,7 @@ struct __coeff {
 #define PSC_CURRENT_IN_L	(PSC_NUM_CLASSES)
 #define PSC_POWER_L		(PSC_NUM_CLASSES + 1)
 
-static struct __coeff lm25066_coeff[4][PSC_NUM_CLASSES + 2] = {
+static struct __coeff lm25066_coeff[5][PSC_NUM_CLASSES + 2] = {
 	[lm25056] = {
 		[PSC_VOLTAGE_IN] = {
 			.m = 16296,
@@ -116,6 +121,36 @@ static struct __coeff lm25066_coeff[4][PSC_NUM_CLASSES + 2] = {
 			.m = 16,
 		},
 	},
+	[lm25063] = {
+		[PSC_VOLTAGE_IN] = {
+			.m = 16000,
+			.R = -2,
+		},
+		[PSC_VOLTAGE_OUT] = {
+			.m = 16000,
+			.R = -2,
+		},
+		[PSC_CURRENT_IN] = {
+			.m = 10000,
+			.R = -2,
+		},
+		[PSC_CURRENT_IN_L] = {
+			.m = 10000,
+			.R = -2,
+		},
+		[PSC_POWER] = {
+			.m = 5000,
+			.R = -3,
+		},
+		[PSC_POWER_L] = {
+			.m = 5000,
+			.R = -3,
+		},
+		[PSC_TEMPERATURE] = {
+			.m = 15596,
+			.R = -3,
+		},
+	},
 	[lm5064] = {
 		[PSC_VOLTAGE_IN] = {
 			.m = 4611,
@@ -178,6 +213,7 @@ static struct __coeff lm25066_coeff[4][PSC_NUM_CLASSES + 2] = {
 
 struct lm25066_data {
 	int id;
+	u16 rlimit;			/* Maximum register value */
 	struct pmbus_driver_info info;
 };
 
@@ -200,6 +236,10 @@ static int lm25066_read_word_data(struct i2c_client *client, int page, int reg)
 			/* VIN: 6.14 mV VAUX: 293 uV LSB */
 			ret = DIV_ROUND_CLOSEST(ret * 293, 6140);
 			break;
+		case lm25063:
+			/* VIN: 6.25 mV VAUX: 200.0 uV LSB */
+			ret = DIV_ROUND_CLOSEST(ret * 20, 625);
+			break;
 		case lm25066:
 			/* VIN: 4.54 mV VAUX: 283.2 uV LSB */
 			ret = DIV_ROUND_CLOSEST(ret * 2832, 45400);
@@ -253,6 +293,24 @@ static int lm25066_read_word_data(struct i2c_client *client, int page, int reg)
 	return ret;
 }
 
+static int lm25063_read_word_data(struct i2c_client *client, int page, int reg)
+{
+	int ret;
+
+	switch (reg) {
+	case PMBUS_VIRT_READ_VOUT_MAX:
+		ret = pmbus_read_word_data(client, 0, LM25063_READ_VOUT_MAX);
+		break;
+	case PMBUS_VIRT_READ_VOUT_MIN:
+		ret = pmbus_read_word_data(client, 0, LM25063_READ_VOUT_MIN);
+		break;
+	default:
+		ret = lm25066_read_word_data(client, page, reg);
+		break;
+	}
+	return ret;
+}
+
 static int lm25056_read_word_data(struct i2c_client *client, int page, int reg)
 {
 	int ret;
@@ -308,27 +366,34 @@ static int lm25056_read_byte_data(struct i2c_client *client, int page, int reg)
 static int lm25066_write_word_data(struct i2c_client *client, int page, int reg,
 				   u16 word)
 {
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	const struct lm25066_data *data = to_lm25066_data(info);
 	int ret;
 
 	switch (reg) {
+	case PMBUS_POUT_OP_FAULT_LIMIT:
+	case PMBUS_POUT_OP_WARN_LIMIT:
 	case PMBUS_VOUT_UV_WARN_LIMIT:
 	case PMBUS_OT_FAULT_LIMIT:
 	case PMBUS_OT_WARN_LIMIT:
+	case PMBUS_IIN_OC_FAULT_LIMIT:
 	case PMBUS_VIN_UV_WARN_LIMIT:
+	case PMBUS_VIN_UV_FAULT_LIMIT:
+	case PMBUS_VIN_OV_FAULT_LIMIT:
 	case PMBUS_VIN_OV_WARN_LIMIT:
-		word = ((s16)word < 0) ? 0 : clamp_val(word, 0, 0x0fff);
+		word = ((s16)word < 0) ? 0 : clamp_val(word, 0, data->rlimit);
 		ret = pmbus_write_word_data(client, 0, reg, word);
 		pmbus_clear_cache(client);
 		break;
 	case PMBUS_IIN_OC_WARN_LIMIT:
-		word = ((s16)word < 0) ? 0 : clamp_val(word, 0, 0x0fff);
+		word = ((s16)word < 0) ? 0 : clamp_val(word, 0, data->rlimit);
 		ret = pmbus_write_word_data(client, 0,
 					    LM25066_MFR_IIN_OC_WARN_LIMIT,
 					    word);
 		pmbus_clear_cache(client);
 		break;
 	case PMBUS_PIN_OP_WARN_LIMIT:
-		word = ((s16)word < 0) ? 0 : clamp_val(word, 0, 0x0fff);
+		word = ((s16)word < 0) ? 0 : clamp_val(word, 0, data->rlimit);
 		ret = pmbus_write_word_data(client, 0,
 					    LM25066_MFR_PIN_OP_WARN_LIMIT,
 					    word);
@@ -337,7 +402,7 @@ static int lm25066_write_word_data(struct i2c_client *client, int page, int reg,
 	case PMBUS_VIRT_VMON_UV_WARN_LIMIT:
 		/* Adjust from VIN coefficients (for LM25056) */
 		word = DIV_ROUND_CLOSEST((int)word * 6140, 293);
-		word = ((s16)word < 0) ? 0 : clamp_val(word, 0, 0x0fff);
+		word = ((s16)word < 0) ? 0 : clamp_val(word, 0, data->rlimit);
 		ret = pmbus_write_word_data(client, 0,
 					    LM25056_VAUX_UV_WARN_LIMIT, word);
 		pmbus_clear_cache(client);
@@ -345,7 +410,7 @@ static int lm25066_write_word_data(struct i2c_client *client, int page, int reg,
 	case PMBUS_VIRT_VMON_OV_WARN_LIMIT:
 		/* Adjust from VIN coefficients (for LM25056) */
 		word = DIV_ROUND_CLOSEST((int)word * 6140, 293);
-		word = ((s16)word < 0) ? 0 : clamp_val(word, 0, 0x0fff);
+		word = ((s16)word < 0) ? 0 : clamp_val(word, 0, data->rlimit);
 		ret = pmbus_write_word_data(client, 0,
 					    LM25056_VAUX_OV_WARN_LIMIT, word);
 		pmbus_clear_cache(client);
@@ -399,9 +464,16 @@ static int lm25066_probe(struct i2c_client *client,
 		info->func[0] |= PMBUS_HAVE_STATUS_VMON;
 		info->read_word_data = lm25056_read_word_data;
 		info->read_byte_data = lm25056_read_byte_data;
+		data->rlimit = 0x0fff;
+	} else if (data->id = lm25063) {
+		info->func[0] |= PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
+		  | PMBUS_HAVE_POUT;
+		info->read_word_data = lm25063_read_word_data;
+		data->rlimit = 0xffff;
 	} else {
 		info->func[0] |= PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
 		info->read_word_data = lm25066_read_word_data;
+		data->rlimit = 0x0fff;
 	}
 	info->write_word_data = lm25066_write_word_data;
 
@@ -432,6 +504,7 @@ static int lm25066_probe(struct i2c_client *client,
 
 static const struct i2c_device_id lm25066_id[] = {
 	{"lm25056", lm25056},
+	{"lm25063", lm25063},
 	{"lm25066", lm25066},
 	{"lm5064", lm5064},
 	{"lm5066", lm5066},
@@ -453,5 +526,5 @@ static struct i2c_driver lm25066_driver = {
 module_i2c_driver(lm25066_driver);
 
 MODULE_AUTHOR("Guenter Roeck");
-MODULE_DESCRIPTION("PMBus driver for LM25056/LM25066/LM5064/LM5066");
+MODULE_DESCRIPTION("PMBus driver for LM25066 and compatible chips");
 MODULE_LICENSE("GPL");
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
