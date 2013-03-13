From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 13 Mar 2013 23:58:42 +0000
Subject: [lm-sensors] [PATCH 4/4] hwmon: (pmbus/lm25066) Add support for LM25056
Message-Id: <1363219122-27226-4-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/lm25066   |   18 +++++-
 drivers/hwmon/pmbus/Kconfig   |    2 +-
 drivers/hwmon/pmbus/lm25066.c |  132 ++++++++++++++++++++++++++++++++++++++---
 3 files changed, 139 insertions(+), 13 deletions(-)

diff --git a/Documentation/hwmon/lm25066 b/Documentation/hwmon/lm25066
index 2bc5ba6..c1b57d7 100644
--- a/Documentation/hwmon/lm25066
+++ b/Documentation/hwmon/lm25066
@@ -1,7 +1,13 @@
-Kernel driver max8688
+Kernel driver lm25066
 ========== 
 Supported chips:
+  * TI LM25056
+    Prefix: 'lm25056'
+    Addresses scanned: -
+    Datasheets:
+	http://www.ti.com/lit/gpn/lm25056
+	http://www.ti.com/lit/gpn/lm25056a
   * National Semiconductor LM25066
     Prefix: 'lm25066'
     Addresses scanned: -
@@ -25,8 +31,9 @@ Author: Guenter Roeck <linux@roeck-us.net>
 Description
 -----------
 
-This driver supports hardware montoring for National Semiconductor LM25066,
-LM5064, and LM5064 Power Management, Monitoring, Control, and Protection ICs.
+This driver supports hardware montoring for National Semiconductor / TI LM25056,
+LM25066, LM5064, and LM5064 Power Management, Monitoring, Control, and
+Protection ICs.
 
 The driver is a client driver to the core PMBus driver. Please see
 Documentation/hwmon/pmbus for details on PMBus client drivers.
@@ -62,8 +69,13 @@ in1_max_alarm		Input voltage high alarm.
 
 in2_label		"vmon"
 in2_input		Measured voltage on VAUX pin
+in2_min			Minimum VAUX voltage (LM25056 only).
+in2_max			Maximum VAUX voltage (LM25056 only).
+in2_min_alarm		VAUX voltage low alarm (LM25056 only).
+in2_max_alarm		VAUX voltage high alarm (LM25056 only).
 
 in3_label		"vout1"
+			Not supported on LM25056.
 in3_input		Measured output voltage.
 in3_average		Average measured output voltage.
 in3_min			Minimum output voltage.
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index b1adad6..39cc63e 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -42,7 +42,7 @@ config SENSORS_LM25066
 	default n
 	help
 	  If you say yes here you get hardware monitoring support for National
-	  Semiconductor LM25066, LM5064, and LM5066.
+	  Semiconductor LM25056, LM25066, LM5064, and LM5066.
 
 	  This driver can also be built as a module. If so, the module will
 	  be called lm25066.
diff --git a/drivers/hwmon/pmbus/lm25066.c b/drivers/hwmon/pmbus/lm25066.c
index 0826714..6a9d6ed 100644
--- a/drivers/hwmon/pmbus/lm25066.c
+++ b/drivers/hwmon/pmbus/lm25066.c
@@ -1,5 +1,5 @@
 /*
- * Hardware monitoring driver for LM25066 / LM5064 / LM5066
+ * Hardware monitoring driver for LM25056 / LM25066 / LM5064 / LM5066
  *
  * Copyright (c) 2011 Ericsson AB.
  * Copyright (c) 2013 Guenter Roeck
@@ -27,7 +27,7 @@
 #include <linux/i2c.h>
 #include "pmbus.h"
 
-enum chips { lm25066, lm5064, lm5066 };
+enum chips { lm25056, lm25066, lm5064, lm5066 };
 
 #define LM25066_READ_VAUX		0xd0
 #define LM25066_MFR_READ_IIN		0xd1
@@ -44,6 +44,14 @@ enum chips { lm25066, lm5064, lm5066 };
 
 #define LM25066_DEV_SETUP_CL		(1 << 4)	/* Current limit */
 
+/* LM25056 only */
+
+#define LM25056_VAUX_OV_WARN_LIMIT	0xe3
+#define LM25056_VAUX_UV_WARN_LIMIT	0xe4
+
+#define LM25056_MFR_STS_VAUX_OV_WARN	(1 << 1)
+#define LM25056_MFR_STS_VAUX_UV_WARN	(1 << 0)
+
 struct __coeff {
 	short m, b, R;
 };
@@ -51,7 +59,34 @@ struct __coeff {
 #define PSC_CURRENT_IN_L	(PSC_NUM_CLASSES)
 #define PSC_POWER_L		(PSC_NUM_CLASSES + 1)
 
-static struct __coeff lm25066_coeff[3][PSC_NUM_CLASSES + 2] = {
+static struct __coeff lm25066_coeff[4][PSC_NUM_CLASSES + 2] = {
+	[lm25056] = {
+		[PSC_VOLTAGE_IN] = {
+			.m = 16296,
+			.R = -2,
+		},
+		[PSC_CURRENT_IN] = {
+			.m = 13797,
+			.R = -2,
+		},
+		[PSC_CURRENT_IN_L] = {
+			.m = 6726,
+			.R = -2,
+		},
+		[PSC_POWER] = {
+			.m = 5501,
+			.R = -3,
+		},
+		[PSC_POWER_L] = {
+			.m = 26882,
+			.R = -4,
+		},
+		[PSC_TEMPERATURE] = {
+			.m = 1580,
+			.b = -14500,
+			.R = -2,
+		},
+	},
 	[lm25066] = {
 		[PSC_VOLTAGE_IN] = {
 			.m = 22070,
@@ -161,6 +196,10 @@ static int lm25066_read_word_data(struct i2c_client *client, int page, int reg)
 			break;
 		/* Adjust returned value to match VIN coefficients */
 		switch (data->id) {
+		case lm25056:
+			/* VIN: 6.14 mV VAUX: 293 uV LSB */
+			ret = DIV_ROUND_CLOSEST(ret * 293, 6140);
+			break;
 		case lm25066:
 			/* VIN: 4.54 mV VAUX: 283.2 uV LSB */
 			ret = DIV_ROUND_CLOSEST(ret * 2832, 45400);
@@ -214,6 +253,58 @@ static int lm25066_read_word_data(struct i2c_client *client, int page, int reg)
 	return ret;
 }
 
+static int lm25056_read_word_data(struct i2c_client *client, int page, int reg)
+{
+	int ret;
+
+	switch (reg) {
+	case PMBUS_VIRT_VMON_UV_WARN_LIMIT:
+		ret = pmbus_read_word_data(client, 0,
+					   LM25056_VAUX_UV_WARN_LIMIT);
+		if (ret < 0)
+			break;
+		/* Adjust returned value to match VIN coefficients */
+		ret = DIV_ROUND_CLOSEST(ret * 293, 6140);
+		break;
+	case PMBUS_VIRT_VMON_OV_WARN_LIMIT:
+		ret = pmbus_read_word_data(client, 0,
+					   LM25056_VAUX_OV_WARN_LIMIT);
+		if (ret < 0)
+			break;
+		/* Adjust returned value to match VIN coefficients */
+		ret = DIV_ROUND_CLOSEST(ret * 293, 6140);
+		break;
+	default:
+		ret = lm25066_read_word_data(client, page, reg);
+		break;
+	}
+	return ret;
+}
+
+static int lm25056_read_byte_data(struct i2c_client *client, int page, int reg)
+{
+	int ret, s;
+
+	switch (reg) {
+	case PMBUS_VIRT_STATUS_VMON:
+		ret = pmbus_read_byte_data(client, 0,
+					   PMBUS_STATUS_MFR_SPECIFIC);
+		if (ret < 0)
+			break;
+		s = 0;
+		if (ret & LM25056_MFR_STS_VAUX_UV_WARN)
+			s |= PB_VOLTAGE_UV_WARNING;
+		if (ret & LM25056_MFR_STS_VAUX_OV_WARN)
+			s |= PB_VOLTAGE_OV_WARNING;
+		ret = s;
+		break;
+	default:
+		ret = -ENODATA;
+		break;
+	}
+	return ret;
+}
+
 static int lm25066_write_word_data(struct i2c_client *client, int page, int reg,
 				   u16 word)
 {
@@ -243,6 +334,22 @@ static int lm25066_write_word_data(struct i2c_client *client, int page, int reg,
 					    word);
 		pmbus_clear_cache(client);
 		break;
+	case PMBUS_VIRT_VMON_UV_WARN_LIMIT:
+		/* Adjust from VIN coefficients (for LM25056) */
+		word = DIV_ROUND_CLOSEST((int)word * 6140, 293);
+		word = ((s16)word < 0) ? 0 : clamp_val(word, 0, 0x0fff);
+		ret = pmbus_write_word_data(client, 0,
+					    LM25056_VAUX_UV_WARN_LIMIT, word);
+		pmbus_clear_cache(client);
+		break;
+	case PMBUS_VIRT_VMON_OV_WARN_LIMIT:
+		/* Adjust from VIN coefficients (for LM25056) */
+		word = DIV_ROUND_CLOSEST((int)word * 6140, 293);
+		word = ((s16)word < 0) ? 0 : clamp_val(word, 0, 0x0fff);
+		ret = pmbus_write_word_data(client, 0,
+					    LM25056_VAUX_OV_WARN_LIMIT, word);
+		pmbus_clear_cache(client);
+		break;
 	case PMBUS_VIRT_RESET_PIN_HISTORY:
 		ret = pmbus_write_byte(client, 0, LM25066_CLEAR_PIN_PEAK);
 		break;
@@ -284,12 +391,18 @@ static int lm25066_probe(struct i2c_client *client,
 	info->format[PSC_TEMPERATURE] = direct;
 	info->format[PSC_POWER] = direct;
 
+	info->func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_VMON
+	  | PMBUS_HAVE_PIN | PMBUS_HAVE_IIN | PMBUS_HAVE_STATUS_INPUT
+	  | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
 
-	info->func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_VMON | PMBUS_HAVE_VOUT
-	  | PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_PIN | PMBUS_HAVE_IIN
-	  | PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
-
-	info->read_word_data = lm25066_read_word_data;
+	if (data->id = lm25056) {
+		info->func[0] |= PMBUS_HAVE_STATUS_VMON;
+		info->read_word_data = lm25056_read_word_data;
+		info->read_byte_data = lm25056_read_byte_data;
+	} else {
+		info->func[0] |= PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
+		info->read_word_data = lm25066_read_word_data;
+	}
 	info->write_word_data = lm25066_write_word_data;
 
 	coeff = &lm25066_coeff[data->id][0];
@@ -318,6 +431,7 @@ static int lm25066_probe(struct i2c_client *client,
 }
 
 static const struct i2c_device_id lm25066_id[] = {
+	{"lm25056", lm25056},
 	{"lm25066", lm25066},
 	{"lm5064", lm5064},
 	{"lm5066", lm5066},
@@ -339,5 +453,5 @@ static struct i2c_driver lm25066_driver = {
 module_i2c_driver(lm25066_driver);
 
 MODULE_AUTHOR("Guenter Roeck");
-MODULE_DESCRIPTION("PMBus driver for LM25066/LM5064/LM5066");
+MODULE_DESCRIPTION("PMBus driver for LM25056/LM25066/LM5064/LM5066");
 MODULE_LICENSE("GPL");
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
