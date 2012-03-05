From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 05 Mar 2012 19:20:37 +0000
Subject: [lm-sensors] [PATCH 5/6] hwmon: (adm1275) Add support for ADM1075
Message-Id: <1330975238-16811-5-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/adm1275   |   30 +++++++++++---
 drivers/hwmon/pmbus/Kconfig   |    4 +-
 drivers/hwmon/pmbus/adm1275.c |   88 +++++++++++++++++++++++++++++++++++++++--
 3 files changed, 109 insertions(+), 13 deletions(-)

diff --git a/Documentation/hwmon/adm1275 b/Documentation/hwmon/adm1275
index ab70d96..535ad23 100644
--- a/Documentation/hwmon/adm1275
+++ b/Documentation/hwmon/adm1275
@@ -2,6 +2,10 @@ Kernel driver adm1275
 ========== 
 Supported chips:
+  * Analog Devices ADM1075
+    Prefix: 'adm1075'
+    Addresses scanned: -
+    Datasheet: www.analog.com/static/imported-files/data_sheets/ADM1075.pdf
   * Analog Devices ADM1275
     Prefix: 'adm1275'
     Addresses scanned: -
@@ -17,13 +21,13 @@ Author: Guenter Roeck <guenter.roeck@ericsson.com>
 Description
 -----------
 
-This driver supports hardware montoring for Analog Devices ADM1275 and ADM1276
-Hot-Swap Controller and Digital Power Monitor.
+This driver supports hardware montoring for Analog Devices ADM1075, ADM1275,
+and ADM1276 Hot-Swap Controller and Digital Power Monitor.
 
-ADM1275 and ADM1276 are hot-swap controllers that allow a circuit board to be
-removed from or inserted into a live backplane. They also feature current and
-voltage readback via an integrated 12-bit analog-to-digital converter (ADC),
-accessed using a PMBus interface.
+ADM1075, ADM1275, and ADM1276 are hot-swap controllers that allow a circuit
+board to be removed from or inserted into a live backplane. They also feature
+current and voltage readback via an integrated 12-bit analog-to-digital
+converter (ADC), accessed using a PMBus interface.
 
 The driver is a client driver to the core PMBus driver. Please see
 Documentation/hwmon/pmbus for details on PMBus client drivers.
@@ -36,6 +40,10 @@ This driver does not auto-detect devices. You will have to instantiate the
 devices explicitly. Please see Documentation/i2c/instantiating-devices for
 details.
 
+The ADM1075, unlike many other PMBus devices, does not support internal voltage
+or current scaling. Reported voltages, currents, and power are raw measurements,
+and will typically have to be scaled.
+
 
 Platform data support
 ---------------------
@@ -51,7 +59,8 @@ The following attributes are supported. Limits are read-write, history reset
 attributes are write-only, all other attributes are read-only.
 
 in1_label		"vin1" or "vout1" depending on chip variant and
-			configuration.
+			configuration. On ADM1075, vout1 reports the voltage on
+			the VAUX pin.
 in1_input		Measured voltage.
 in1_min			Minumum Voltage.
 in1_max			Maximum voltage.
@@ -74,3 +83,10 @@ curr1_crit		Critical maximum current. Depending on the chip
 curr1_crit_alarm	Critical current high alarm.
 curr1_highest		Historical maximum current.
 curr1_reset_history	Write any value to reset history.
+
+power1_label		"pin1"
+power1_input		Input power.
+power1_reset_history	Write any value to reset history.
+
+			Power attributes are supported on ADM1075 and ADM1276
+			only.
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 1f0d011..9246d01 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -31,8 +31,8 @@ config SENSORS_ADM1275
 	default n
 	help
 	  If you say yes here you get hardware monitoring support for Analog
-	  Devices ADM1275 and ADM1276 Hot-Swap Controller and Digital Power
-	  Monitor.
+	  Devices ADM1075, ADM1275, and ADM1276 Hot-Swap Controller and Digital
+	  Power Monitors.
 
 	  This driver can also be built as a module. If so, the module will
 	  be called adm1275.
diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
index 5e4421e..60aad95 100644
--- a/drivers/hwmon/pmbus/adm1275.c
+++ b/drivers/hwmon/pmbus/adm1275.c
@@ -23,7 +23,7 @@
 #include <linux/i2c.h>
 #include "pmbus.h"
 
-enum chips { adm1275, adm1276 };
+enum chips { adm1075, adm1275, adm1276 };
 
 #define ADM1275_PEAK_IOUT		0xd0
 #define ADM1275_PEAK_VIN		0xd1
@@ -32,6 +32,9 @@ enum chips { adm1275, adm1276 };
 
 #define ADM1275_VIN_VOUT_SELECT		(1 << 6)
 #define ADM1275_VRANGE			(1 << 5)
+#define ADM1075_IRANGE_50		(1 << 4)
+#define ADM1075_IRANGE_25		(1 << 3)
+#define ADM1075_IRANGE_MASK		((1 << 3) | (1 << 4))
 
 #define ADM1275_IOUT_WARN2_LIMIT	0xd7
 #define ADM1275_DEVICE_CONFIG		0xd8
@@ -42,6 +45,14 @@ enum chips { adm1275, adm1276 };
 
 #define ADM1275_MFR_STATUS_IOUT_WARN2	(1 << 0)
 
+#define ADM1075_READ_VAUX		0xdd
+#define ADM1075_VAUX_OV_WARN_LIMIT	0xde
+#define ADM1075_VAUX_UV_WARN_LIMIT	0xdf
+#define ADM1075_VAUX_STATUS		0xf6
+
+#define ADM1075_VAUX_OV_WARN		(1<<7)
+#define ADM1075_VAUX_UV_WARN		(1<<6)
+
 struct adm1275_data {
 	int id;
 	bool have_oc_fault;
@@ -74,6 +85,29 @@ static int adm1275_read_word_data(struct i2c_client *client, int page, int reg)
 		}
 		ret = pmbus_read_word_data(client, 0, ADM1275_IOUT_WARN2_LIMIT);
 		break;
+	case PMBUS_VOUT_OV_WARN_LIMIT:
+		if (data->id != adm1075) {
+			ret = -ENODATA;
+			break;
+		}
+		ret = pmbus_read_word_data(client, 0,
+					   ADM1075_VAUX_OV_WARN_LIMIT);
+		break;
+	case PMBUS_VOUT_UV_WARN_LIMIT:
+		if (data->id != adm1075) {
+			ret = -ENODATA;
+			break;
+		}
+		ret = pmbus_read_word_data(client, 0,
+					   ADM1075_VAUX_UV_WARN_LIMIT);
+		break;
+	case PMBUS_READ_VOUT:
+		if (data->id != adm1075) {
+			ret = -ENODATA;
+			break;
+		}
+		ret = pmbus_read_word_data(client, 0, ADM1075_READ_VAUX);
+		break;
 	case PMBUS_VIRT_READ_IOUT_MAX:
 		ret = pmbus_read_word_data(client, 0, ADM1275_PEAK_IOUT);
 		break;
@@ -84,7 +118,7 @@ static int adm1275_read_word_data(struct i2c_client *client, int page, int reg)
 		ret = pmbus_read_word_data(client, 0, ADM1275_PEAK_VIN);
 		break;
 	case PMBUS_VIRT_READ_PIN_MAX:
-		if (data->id != adm1276) {
+		if (data->id = adm1275) {
 			ret = -ENXIO;
 			break;
 		}
@@ -95,7 +129,7 @@ static int adm1275_read_word_data(struct i2c_client *client, int page, int reg)
 	case PMBUS_VIRT_RESET_VIN_HISTORY:
 		break;
 	case PMBUS_VIRT_RESET_PIN_HISTORY:
-		if (data->id != adm1276)
+		if (data->id = adm1275)
 			ret = -ENXIO;
 		break;
 	default:
@@ -163,6 +197,19 @@ static int adm1275_read_byte_data(struct i2c_client *client, int page, int reg)
 			  PB_IOUT_OC_FAULT : PB_IOUT_UC_FAULT;
 		}
 		break;
+	case PMBUS_STATUS_VOUT:
+		if (data->id != adm1075) {
+			ret = -ENODATA;
+			break;
+		}
+		ret = 0;
+		mfr_status = pmbus_read_byte_data(client, 0,
+						  ADM1075_VAUX_STATUS);
+		if (mfr_status & ADM1075_VAUX_OV_WARN)
+			ret |= PB_VOLTAGE_OV_WARNING;
+		if (mfr_status & ADM1075_VAUX_UV_WARN)
+			ret |= PB_VOLTAGE_UV_WARNING;
+		break;
 	default:
 		ret = -ENODATA;
 		break;
@@ -171,6 +218,7 @@ static int adm1275_read_byte_data(struct i2c_client *client, int page, int reg)
 }
 
 static const struct i2c_device_id adm1275_id[] = {
+	{ "adm1075", adm1075 },
 	{ "adm1275", adm1275 },
 	{ "adm1276", adm1276 },
 	{ }
@@ -251,7 +299,14 @@ static int adm1275_probe(struct i2c_client *client,
 	info->read_byte_data = adm1275_read_byte_data;
 	info->write_word_data = adm1275_write_word_data;
 
-	if (config & ADM1275_VRANGE) {
+	if (data->id = adm1075) {
+		info->m[PSC_VOLTAGE_IN] = 27169;
+		info->b[PSC_VOLTAGE_IN] = 0;
+		info->R[PSC_VOLTAGE_IN] = -1;
+		info->m[PSC_VOLTAGE_OUT] = 27169;
+		info->b[PSC_VOLTAGE_OUT] = 0;
+		info->R[PSC_VOLTAGE_OUT] = -1;
+	} else if (config & ADM1275_VRANGE) {
 		info->m[PSC_VOLTAGE_IN] = 19199;
 		info->b[PSC_VOLTAGE_IN] = 0;
 		info->R[PSC_VOLTAGE_IN] = -2;
@@ -271,6 +326,31 @@ static int adm1275_probe(struct i2c_client *client,
 		data->have_oc_fault = true;
 
 	switch (data->id) {
+	case adm1075:
+		info->format[PSC_POWER] = direct;
+		info->b[PSC_POWER] = 0;
+		info->R[PSC_POWER] = -1;
+		switch (config & ADM1075_IRANGE_MASK) {
+		case ADM1075_IRANGE_25:
+			info->m[PSC_POWER] = 8549;
+			info->m[PSC_CURRENT_OUT] = 806;
+			break;
+		case ADM1075_IRANGE_50:
+			info->m[PSC_POWER] = 4279;
+			info->m[PSC_CURRENT_OUT] = 404;
+			break;
+		default:
+			dev_err(&client->dev, "Invalid input current range");
+			info->m[PSC_POWER] = 0;
+			info->m[PSC_CURRENT_OUT] = 0;
+			break;
+		}
+		info->func[0] |= PMBUS_HAVE_VIN | PMBUS_HAVE_PIN
+		  | PMBUS_HAVE_STATUS_INPUT;
+		if (config & ADM1275_VIN_VOUT_SELECT)
+			info->func[0] |+			  PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
+		break;
 	case adm1275:
 		if (config & ADM1275_VIN_VOUT_SELECT)
 			info->func[0] |-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
