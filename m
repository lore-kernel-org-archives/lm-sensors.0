From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 06 Jul 2015 15:54:24 +0000
Subject: [lm-sensors] [PATCH 5/5] hwmon: (adm1275) Add support for ADM1293 and ADM1294
Message-Id: <1436198064-23678-5-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

ADM1293 and ADM1294 are mostly compatible with other chips of the same
series, but have more configuration options. There are also some
differences in register details.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/adm1275   |  40 +++++++-----
 drivers/hwmon/pmbus/Kconfig   |   4 +-
 drivers/hwmon/pmbus/adm1275.c | 141 +++++++++++++++++++++++++++++++++++++++---
 3 files changed, 158 insertions(+), 27 deletions(-)

diff --git a/Documentation/hwmon/adm1275 b/Documentation/hwmon/adm1275
index 15b4a20d5062..d697229e3c18 100644
--- a/Documentation/hwmon/adm1275
+++ b/Documentation/hwmon/adm1275
@@ -14,6 +14,10 @@ Supported chips:
     Prefix: 'adm1276'
     Addresses scanned: -
     Datasheet: www.analog.com/static/imported-files/data_sheets/ADM1276.pdf
+  * Analog Devices ADM1293/ADM1294
+    Prefix: 'adm1293', 'adm1294'
+    Addresses scanned: -
+    Datasheet: http://www.analog.com/media/en/technical-documentation/data-sheets/ADM1293_1294.pdf
 
 Author: Guenter Roeck <linux@roeck-us.net>
 
@@ -22,12 +26,12 @@ Description
 -----------
 
 This driver supports hardware montoring for Analog Devices ADM1075, ADM1275,
-and ADM1276 Hot-Swap Controller and Digital Power Monitor.
+ADM1276, ADM1293, and ADM1294 Hot-Swap Controller and Digital Power Monitors.
 
-ADM1075, ADM1275, and ADM1276 are hot-swap controllers that allow a circuit
-board to be removed from or inserted into a live backplane. They also feature
-current and voltage readback via an integrated 12-bit analog-to-digital
-converter (ADC), accessed using a PMBus interface.
+ADM1075, ADM1275, ADM1276, ADM1293, and ADM1294 are hot-swap controllers that
+allow a circuit board to be removed from or inserted into a live backplane.
+They also feature current and voltage readback via an integrated 12
+bit analog-to-digital converter (ADC), accessed using a PMBus interface.
 
 The driver is a client driver to the core PMBus driver. Please see
 Documentation/hwmon/pmbus for details on PMBus client drivers.
@@ -58,16 +62,16 @@ Sysfs entries
 The following attributes are supported. Limits are read-write, history reset
 attributes are write-only, all other attributes are read-only.
 
-in1_label		"vin1" or "vout1" depending on chip variant and
-			configuration. On ADM1075, vout1 reports the voltage on
-			the VAUX pin.
-in1_input		Measured voltage.
-in1_min			Minimum Voltage.
-in1_max			Maximum voltage.
-in1_min_alarm		Voltage low alarm.
-in1_max_alarm		Voltage high alarm.
-in1_highest		Historical maximum voltage.
-in1_reset_history	Write any value to reset history.
+inX_label		"vin1" or "vout1" depending on chip variant and
+			configuration. On ADM1075, ADM1293, and ADM1294,
+			vout1 reports the voltage on the VAUX pin.
+inX_input		Measured voltage.
+inX_min			Minimum Voltage.
+inX_max			Maximum voltage.
+inX_min_alarm		Voltage low alarm.
+inX_max_alarm		Voltage high alarm.
+inX_highest		Historical maximum voltage.
+inX_reset_history	Write any value to reset history.
 
 curr1_label		"iout1"
 curr1_input		Measured current.
@@ -86,7 +90,9 @@ curr1_reset_history	Write any value to reset history.
 
 power1_label		"pin1"
 power1_input		Input power.
+power1_input_lowest	Lowest observed input power. ADM1293 and ADM1294 only.
+power1_input_highest	Highest observed input power.
 power1_reset_history	Write any value to reset history.
 
-			Power attributes are supported on ADM1075 and ADM1276
-			only.
+			Power attributes are supported on ADM1075, ADM1276,
+			ADM1293, and ADM1294.
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 9f7dbd189c97..67901cb08f77 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -30,8 +30,8 @@ config SENSORS_ADM1275
 	default n
 	help
 	  If you say yes here you get hardware monitoring support for Analog
-	  Devices ADM1075, ADM1275, and ADM1276 Hot-Swap Controller and Digital
-	  Power Monitors.
+	  Devices ADM1075, ADM1275, ADM1276, ADM1293, and ADM1294 Hot-Swap
+	  Controller and Digital Power Monitors.
 
 	  This driver can also be built as a module. If so, the module will
 	  be called adm1275.
diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
index 060dace4e688..f78830be1c66 100644
--- a/drivers/hwmon/pmbus/adm1275.c
+++ b/drivers/hwmon/pmbus/adm1275.c
@@ -24,7 +24,11 @@
 #include <linux/bitops.h>
 #include "pmbus.h"
 
-enum chips { adm1075, adm1275, adm1276 };
+enum chips { adm1075, adm1275, adm1276, adm1293, adm1294 };
+
+#define ADM1275_MFR_STATUS_IOUT_WARN2	BIT(0)
+#define ADM1293_MFR_STATUS_VAUX_UV_WARN	BIT(5)
+#define ADM1293_MFR_STATUS_VAUX_OV_WARN	BIT(6)
 
 #define ADM1275_PEAK_IOUT		0xd0
 #define ADM1275_PEAK_VIN		0xd1
@@ -37,18 +41,30 @@ enum chips { adm1075, adm1275, adm1276 };
 #define ADM1075_IRANGE_25		BIT(3)
 #define ADM1075_IRANGE_MASK		(BIT(3) | BIT(4))
 
+#define ADM1293_IRANGE_25		0
+#define ADM1293_IRANGE_50		BIT(6)
+#define ADM1293_IRANGE_100		BIT(7)
+#define ADM1293_IRANGE_200		(BIT(6) | BIT(7))
+#define ADM1293_IRANGE_MASK		(BIT(6) | BIT(7))
+
+#define ADM1293_VIN_SEL_012		BIT(2)
+#define ADM1293_VIN_SEL_074		BIT(3)
+#define ADM1293_VIN_SEL_210		(BIT(2) | BIT(3))
+#define ADM1293_VIN_SEL_MASK		(BIT(2) | BIT(3))
+
+#define ADM1293_VAUX_EN			BIT(1)
+
 #define ADM1275_IOUT_WARN2_LIMIT	0xd7
 #define ADM1275_DEVICE_CONFIG		0xd8
 
 #define ADM1275_IOUT_WARN2_SELECT	BIT(4)
 
 #define ADM1276_PEAK_PIN		0xda
-
-#define ADM1275_MFR_STATUS_IOUT_WARN2	BIT(0)
-
 #define ADM1075_READ_VAUX		0xdd
 #define ADM1075_VAUX_OV_WARN_LIMIT	0xde
 #define ADM1075_VAUX_UV_WARN_LIMIT	0xdf
+#define ADM1293_IOUT_MIN		0xe3
+#define ADM1293_PIN_MIN			0xe4
 #define ADM1075_VAUX_STATUS		0xf6
 
 #define ADM1075_VAUX_OV_WARN		BIT(7)
@@ -60,6 +76,9 @@ struct adm1275_data {
 	bool have_uc_fault;
 	bool have_vout;
 	bool have_vaux_status;
+	bool have_mfr_vaux_status;
+	bool have_iout_min;
+	bool have_pin_min;
 	bool have_pin_max;
 	struct pmbus_driver_info info;
 };
@@ -94,6 +113,28 @@ static const struct coefficients adm1276_coefficients[] = {
 	[4] = { 2115, 0, -1 },		/* power, vrange not set */
 };
 
+static const struct coefficients adm1293_coefficients[] = {
+	[0] = { 3333, -1, 0 },		/* voltage, vrange 1.2V */
+	[1] = { 5552, -5, -1 },		/* voltage, vrange 7.4V */
+	[2] = { 19604, -50, -2 },	/* voltage, vrange 21V */
+	[3] = { 8000, -100, -2 },	/* current, irange25 */
+	[4] = { 4000, -100, -2 },	/* current, irange50 */
+	[5] = { 20000, -1000, -3 },	/* current, irange100 */
+	[6] = { 10000, -1000, -3 },	/* current, irange200 */
+	[7] = { 10417, 0, -1 },		/* power, 1.2V, irange25 */
+	[8] = { 5208, 0, -1 },		/* power, 1.2V, irange50 */
+	[9] = { 26042, 0, -2 },		/* power, 1.2V, irange100 */
+	[10] = { 13021, 0, -2 },	/* power, 1.2V, irange200 */
+	[11] = { 17351, 0, -2 },	/* power, 7.4V, irange25 */
+	[12] = { 8676, 0, -2 },		/* power, 7.4V, irange50 */
+	[13] = { 4338, 0, -2 },		/* power, 7.4V, irange100 */
+	[14] = { 21689, 0, -3 },	/* power, 7.4V, irange200 */
+	[15] = { 6126, 0, -2 },		/* power, 21V, irange25 */
+	[16] = { 30631, 0, -3 },	/* power, 21V, irange50 */
+	[17] = { 15316, 0, -3 },	/* power, 21V, irange100 */
+	[18] = { 7658, 0, -3 },		/* power, 21V, irange200 */
+};
+
 static int adm1275_read_word_data(struct i2c_client *client, int page, int reg)
 {
 	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
@@ -131,6 +172,11 @@ static int adm1275_read_word_data(struct i2c_client *client, int page, int reg)
 			return -ENODATA;
 		ret = pmbus_read_word_data(client, 0, ADM1075_READ_VAUX);
 		break;
+	case PMBUS_VIRT_READ_IOUT_MIN:
+		if (!data->have_iout_min)
+			return -ENXIO;
+		ret = pmbus_read_word_data(client, 0, ADM1293_IOUT_MIN);
+		break;
 	case PMBUS_VIRT_READ_IOUT_MAX:
 		ret = pmbus_read_word_data(client, 0, ADM1275_PEAK_IOUT);
 		break;
@@ -140,6 +186,11 @@ static int adm1275_read_word_data(struct i2c_client *client, int page, int reg)
 	case PMBUS_VIRT_READ_VIN_MAX:
 		ret = pmbus_read_word_data(client, 0, ADM1275_PEAK_VIN);
 		break;
+	case PMBUS_VIRT_READ_PIN_MIN:
+		if (!data->have_pin_min)
+			return -ENXIO;
+		ret = pmbus_read_word_data(client, 0, ADM1293_PIN_MIN);
+		break;
 	case PMBUS_VIRT_READ_PIN_MAX:
 		if (!data->have_pin_max)
 			return -ENXIO;
@@ -163,6 +214,8 @@ static int adm1275_read_word_data(struct i2c_client *client, int page, int reg)
 static int adm1275_write_word_data(struct i2c_client *client, int page, int reg,
 				   u16 word)
 {
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	const struct adm1275_data *data = to_adm1275_data(info);
 	int ret;
 
 	if (page)
@@ -176,6 +229,9 @@ static int adm1275_write_word_data(struct i2c_client *client, int page, int reg,
 		break;
 	case PMBUS_VIRT_RESET_IOUT_HISTORY:
 		ret = pmbus_write_word_data(client, 0, ADM1275_PEAK_IOUT, 0);
+		if (!ret && data->have_iout_min)
+			ret = pmbus_write_word_data(client, 0,
+						    ADM1293_IOUT_MIN, 0);
 		break;
 	case PMBUS_VIRT_RESET_VOUT_HISTORY:
 		ret = pmbus_write_word_data(client, 0, ADM1275_PEAK_VOUT, 0);
@@ -185,6 +241,9 @@ static int adm1275_write_word_data(struct i2c_client *client, int page, int reg,
 		break;
 	case PMBUS_VIRT_RESET_PIN_HISTORY:
 		ret = pmbus_write_word_data(client, 0, ADM1276_PEAK_PIN, 0);
+		if (!ret && data->have_pin_min)
+			ret = pmbus_write_word_data(client, 0,
+						    ADM1293_PIN_MIN, 0);
 		break;
 	default:
 		ret = -ENODATA;
@@ -231,6 +290,15 @@ static int adm1275_read_byte_data(struct i2c_client *client, int page, int reg)
 				ret |= PB_VOLTAGE_OV_WARNING;
 			if (mfr_status & ADM1075_VAUX_UV_WARN)
 				ret |= PB_VOLTAGE_UV_WARNING;
+		} else if (data->have_mfr_vaux_status) {
+			mfr_status = pmbus_read_byte_data(client, page,
+						PMBUS_STATUS_MFR_SPECIFIC);
+			if (mfr_status < 0)
+				return mfr_status;
+			if (mfr_status & ADM1293_MFR_STATUS_VAUX_OV_WARN)
+				ret |= PB_VOLTAGE_OV_WARNING;
+			if (mfr_status & ADM1293_MFR_STATUS_VAUX_UV_WARN)
+				ret |= PB_VOLTAGE_UV_WARNING;
 		}
 		break;
 	default:
@@ -244,6 +312,8 @@ static const struct i2c_device_id adm1275_id[] = {
 	{ "adm1075", adm1075 },
 	{ "adm1275", adm1275 },
 	{ "adm1276", adm1276 },
+	{ "adm1293", adm1293 },
+	{ "adm1294", adm1294 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, adm1275_id);
@@ -258,7 +328,7 @@ static int adm1275_probe(struct i2c_client *client,
 	struct adm1275_data *data;
 	const struct i2c_device_id *mid;
 	const struct coefficients *coefficients;
-	int vindex = -1, cindex = -1, pindex = -1;
+	int vindex = -1, voindex = -1, cindex = -1, pindex = -1;
 
 	if (!i2c_check_functionality(client->adapter,
 				     I2C_FUNC_SMBUS_READ_BYTE_DATA
@@ -390,14 +460,69 @@ static int adm1275_probe(struct i2c_client *client,
 			info->func[0] | 			  PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
 		break;
+	case adm1293:
+	case adm1294:
+		data->have_iout_min = true;
+		data->have_pin_min = true;
+		data->have_pin_max = true;
+		data->have_mfr_vaux_status = true;
+
+		coefficients = adm1293_coefficients;
+
+		voindex = 0;
+		switch (config & ADM1293_VIN_SEL_MASK) {
+		case ADM1293_VIN_SEL_012:	/* 1.2V */
+			vindex = 0;
+			break;
+		case ADM1293_VIN_SEL_074:	/* 7.4V */
+			vindex = 1;
+			break;
+		case ADM1293_VIN_SEL_210:	/* 21V */
+			vindex = 2;
+			break;
+		default:			/* disabled */
+			break;
+		}
+
+		switch (config & ADM1293_IRANGE_MASK) {
+		case ADM1293_IRANGE_25:
+			cindex = 3;
+			break;
+		case ADM1293_IRANGE_50:
+			cindex = 4;
+			break;
+		case ADM1293_IRANGE_100:
+			cindex = 5;
+			break;
+		case ADM1293_IRANGE_200:
+			cindex = 6;
+			break;
+		}
+
+		if (vindex >= 0)
+			pindex = 7 + vindex * 4 + (cindex - 3);
+
+		if (config & ADM1293_VAUX_EN)
+			info->func[0] |+				PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
+
+		info->func[0] |= PMBUS_HAVE_PIN |
+			PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT;
+
+		break;
 	}
+
+	if (voindex < 0)
+		voindex = vindex;
 	if (vindex >= 0) {
 		info->m[PSC_VOLTAGE_IN] = coefficients[vindex].m;
 		info->b[PSC_VOLTAGE_IN] = coefficients[vindex].b;
 		info->R[PSC_VOLTAGE_IN] = coefficients[vindex].R;
-		info->m[PSC_VOLTAGE_OUT] = coefficients[vindex].m;
-		info->b[PSC_VOLTAGE_OUT] = coefficients[vindex].b;
-		info->R[PSC_VOLTAGE_OUT] = coefficients[vindex].R;
+	}
+	if (voindex >= 0) {
+		info->m[PSC_VOLTAGE_OUT] = coefficients[voindex].m;
+		info->b[PSC_VOLTAGE_OUT] = coefficients[voindex].b;
+		info->R[PSC_VOLTAGE_OUT] = coefficients[voindex].R;
 	}
 	if (cindex >= 0) {
 		info->m[PSC_CURRENT_OUT] = coefficients[cindex].m;
-- 
2.1.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
