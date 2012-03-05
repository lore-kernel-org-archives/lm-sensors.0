From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 05 Mar 2012 19:20:36 +0000
Subject: [lm-sensors] [PATCH 4/6] hwmon: (max34440) Add support for MAX34446
Message-Id: <1330975238-16811-4-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/max34440   |   29 ++++++++++-
 drivers/hwmon/pmbus/Kconfig    |    4 +-
 drivers/hwmon/pmbus/max34440.c |  112 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 138 insertions(+), 7 deletions(-)

diff --git a/Documentation/hwmon/max34440 b/Documentation/hwmon/max34440
index 36b335c..bbdf9bf 100644
--- a/Documentation/hwmon/max34440
+++ b/Documentation/hwmon/max34440
@@ -11,6 +11,11 @@ Supported chips:
     Prefixes: 'max34441'
     Addresses scanned: -
     Datasheet: http://datasheets.maxim-ic.com/en/ds/MAX34441.pdf
+  * Maxim MAX34446
+    PMBus Power-Supply Data Logger
+    Prefixes: 'max34446'
+    Addresses scanned: -
+    Datasheet: http://datasheets.maxim-ic.com/en/ds/MAX34446.pdf
 
 Author: Guenter Roeck <guenter.roeck@ericsson.com>
 
@@ -19,8 +24,8 @@ Description
 -----------
 
 This driver supports hardware montoring for Maxim MAX34440 PMBus 6-Channel
-Power-Supply Manager and MAX34441 PMBus 5-Channel Power-Supply Manager
-and Intelligent Fan Controller.
+Power-Supply Manager, MAX34441 PMBus 5-Channel Power-Supply Manager
+and Intelligent Fan Controller, and MAX34446 PMBus Power-Supply Data Logger.
 
 The driver is a client driver to the core PMBus driver. Please see
 Documentation/hwmon/pmbus for details on PMBus client drivers.
@@ -33,6 +38,13 @@ This driver does not auto-detect devices. You will have to instantiate the
 devices explicitly. Please see Documentation/i2c/instantiating-devices for
 details.
 
+For MAX34446, the value of the currX_crit attribute determines if current or
+voltage measurement is enabled for a given channel. Voltage measurement is
+enabled if currX_crit is set to 0; current measurement is enabled if the
+attribute is set to a positive value. Power measurement is only enabled if
+channel 1 (3) is configured for voltage measurement, and channel 2 (4) is
+configured for current measurement.
+
 
 Platform data support
 ---------------------
@@ -60,16 +72,27 @@ in[1-6]_lowest		Historical minimum voltage.
 in[1-6]_highest		Historical maximum voltage.
 in[1-6]_reset_history	Write any value to reset history.
 
+			MAX34446 only supports in[1-4].
+
 curr[1-6]_label		"iout[1-6]".
 curr[1-6]_input		Measured current. From READ_IOUT register.
 curr[1-6]_max		Maximum current. From IOUT_OC_WARN_LIMIT register.
 curr[1-6]_crit		Critical maximum current. From IOUT_OC_FAULT_LIMIT register.
 curr[1-6]_max_alarm	Current high alarm. From IOUT_OC_WARNING status.
 curr[1-6]_crit_alarm	Current critical high alarm. From IOUT_OC_FAULT status.
+curr[1-4]_average	Historical average current (MAX34446 only).
 curr[1-6]_highest	Historical maximum current.
 curr[1-6]_reset_history	Write any value to reset history.
 
 			in6 and curr6 attributes only exist for MAX34440.
+			MAX34446 only supports curr[1-4].
+
+power[1,3]_label	"pout[1,3]"
+power[1,3]_input	Measured power.
+power[1,3]_average	Historical average power.
+power[1,3]_highest	Historical maximum power.
+
+			Power attributes only exist for MAX34446.
 
 temp[1-8]_input		Measured temperatures. From READ_TEMPERATURE_1 register.
 			temp1 is the chip's internal temperature. temp2..temp5
@@ -80,7 +103,9 @@ temp[1-8]_max		Maximum temperature. From OT_WARN_LIMIT register.
 temp[1-8]_crit		Critical high temperature. From OT_FAULT_LIMIT register.
 temp[1-8]_max_alarm	Temperature high alarm.
 temp[1-8]_crit_alarm	Temperature critical high alarm.
+temp[1-8]_average	Historical average temperature (MAX34446 only).
 temp[1-8]_highest	Historical maximum temperature.
 temp[1-8]_reset_history	Write any value to reset history.
 
 			temp7 and temp8 attributes only exist for MAX34440.
+			MAX34446 only supports temp[1-3].
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index d1aa2db..1f0d011 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -68,11 +68,11 @@ config SENSORS_MAX16064
 	  be called max16064.
 
 config SENSORS_MAX34440
-	tristate "Maxim MAX34440/MAX34441"
+	tristate "Maxim MAX34440 and compatibles"
 	default n
 	help
 	  If you say yes here you get hardware monitoring support for Maxim
-	  MAX34440 and MAX34441.
+	  MAX34440, MAX34441, and MAX34446.
 
 	  This driver can also be built as a module. If so, the module will
 	  be called max34440.
diff --git a/drivers/hwmon/pmbus/max34440.c b/drivers/hwmon/pmbus/max34440.c
index 95ee9e1..2ada7b0 100644
--- a/drivers/hwmon/pmbus/max34440.c
+++ b/drivers/hwmon/pmbus/max34440.c
@@ -25,21 +25,35 @@
 #include <linux/i2c.h>
 #include "pmbus.h"
 
-enum chips { max34440, max34441 };
+enum chips { max34440, max34441, max34446 };
 
 #define MAX34440_MFR_VOUT_PEAK		0xd4
 #define MAX34440_MFR_IOUT_PEAK		0xd5
 #define MAX34440_MFR_TEMPERATURE_PEAK	0xd6
 #define MAX34440_MFR_VOUT_MIN		0xd7
 
+#define MAX34446_MFR_POUT_PEAK		0xe0
+#define MAX34446_MFR_POUT_AVG		0xe1
+#define MAX34446_MFR_IOUT_AVG		0xe2
+#define MAX34446_MFR_TEMPERATURE_AVG	0xe3
+
 #define MAX34440_STATUS_OC_WARN		(1 << 0)
 #define MAX34440_STATUS_OC_FAULT	(1 << 1)
 #define MAX34440_STATUS_OT_FAULT	(1 << 5)
 #define MAX34440_STATUS_OT_WARN		(1 << 6)
 
+struct max34440_data {
+	int id;
+	struct pmbus_driver_info info;
+};
+
+#define to_max34440_data(x)  container_of(x, struct max34440_data, info)
+
 static int max34440_read_word_data(struct i2c_client *client, int page, int reg)
 {
 	int ret;
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	const struct max34440_data *data = to_max34440_data(info);
 
 	switch (reg) {
 	case PMBUS_VIRT_READ_VOUT_MIN:
@@ -50,14 +64,43 @@ static int max34440_read_word_data(struct i2c_client *client, int page, int reg)
 		ret = pmbus_read_word_data(client, page,
 					   MAX34440_MFR_VOUT_PEAK);
 		break;
+	case PMBUS_VIRT_READ_IOUT_AVG:
+		if (data->id != max34446)
+			return -ENXIO;
+		ret = pmbus_read_word_data(client, page,
+					   MAX34446_MFR_IOUT_AVG);
+		break;
 	case PMBUS_VIRT_READ_IOUT_MAX:
 		ret = pmbus_read_word_data(client, page,
 					   MAX34440_MFR_IOUT_PEAK);
 		break;
+	case PMBUS_VIRT_READ_POUT_AVG:
+		if (data->id != max34446)
+			return -ENXIO;
+		ret = pmbus_read_word_data(client, page,
+					   MAX34446_MFR_POUT_AVG);
+		break;
+	case PMBUS_VIRT_READ_POUT_MAX:
+		if (data->id != max34446)
+			return -ENXIO;
+		ret = pmbus_read_word_data(client, page,
+					   MAX34446_MFR_POUT_PEAK);
+		break;
+	case PMBUS_VIRT_READ_TEMP_AVG:
+		if (data->id != max34446)
+			return -ENXIO;
+		ret = pmbus_read_word_data(client, page,
+					   MAX34446_MFR_TEMPERATURE_AVG);
+		break;
 	case PMBUS_VIRT_READ_TEMP_MAX:
 		ret = pmbus_read_word_data(client, page,
 					   MAX34440_MFR_TEMPERATURE_PEAK);
 		break;
+	case PMBUS_VIRT_RESET_POUT_HISTORY:
+		if (data->id != max34446)
+			return -ENXIO;
+		ret = 0;
+		break;
 	case PMBUS_VIRT_RESET_VOUT_HISTORY:
 	case PMBUS_VIRT_RESET_IOUT_HISTORY:
 	case PMBUS_VIRT_RESET_TEMP_HISTORY:
@@ -73,9 +116,19 @@ static int max34440_read_word_data(struct i2c_client *client, int page, int reg)
 static int max34440_write_word_data(struct i2c_client *client, int page,
 				    int reg, u16 word)
 {
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	const struct max34440_data *data = to_max34440_data(info);
 	int ret;
 
 	switch (reg) {
+	case PMBUS_VIRT_RESET_POUT_HISTORY:
+		ret = pmbus_write_word_data(client, page,
+					    MAX34446_MFR_POUT_PEAK, 0);
+		if (ret)
+			break;
+		ret = pmbus_write_word_data(client, page,
+					    MAX34446_MFR_POUT_AVG, 0);
+		break;
 	case PMBUS_VIRT_RESET_VOUT_HISTORY:
 		ret = pmbus_write_word_data(client, page,
 					    MAX34440_MFR_VOUT_MIN, 0x7fff);
@@ -87,11 +140,18 @@ static int max34440_write_word_data(struct i2c_client *client, int page,
 	case PMBUS_VIRT_RESET_IOUT_HISTORY:
 		ret = pmbus_write_word_data(client, page,
 					    MAX34440_MFR_IOUT_PEAK, 0);
+		if (!ret && data->id = max34446)
+			ret = pmbus_write_word_data(client, page,
+					MAX34446_MFR_IOUT_AVG, 0);
+
 		break;
 	case PMBUS_VIRT_RESET_TEMP_HISTORY:
 		ret = pmbus_write_word_data(client, page,
 					    MAX34440_MFR_TEMPERATURE_PEAK,
 					    0x8000);
+		if (!ret && data->id = max34446)
+			ret = pmbus_write_word_data(client, page,
+					MAX34446_MFR_TEMPERATURE_AVG, 0);
 		break;
 	default:
 		ret = -ENODATA;
@@ -225,20 +285,66 @@ static struct pmbus_driver_info max34440_info[] = {
 		.read_word_data = max34440_read_word_data,
 		.write_word_data = max34440_write_word_data,
 	},
+	[max34446] = {
+		.pages = 7,
+		.format[PSC_VOLTAGE_IN] = direct,
+		.format[PSC_VOLTAGE_OUT] = direct,
+		.format[PSC_TEMPERATURE] = direct,
+		.format[PSC_CURRENT_OUT] = direct,
+		.format[PSC_POWER] = direct,
+		.m[PSC_VOLTAGE_IN] = 1,
+		.b[PSC_VOLTAGE_IN] = 0,
+		.R[PSC_VOLTAGE_IN] = 3,
+		.m[PSC_VOLTAGE_OUT] = 1,
+		.b[PSC_VOLTAGE_OUT] = 0,
+		.R[PSC_VOLTAGE_OUT] = 3,
+		.m[PSC_CURRENT_OUT] = 1,
+		.b[PSC_CURRENT_OUT] = 0,
+		.R[PSC_CURRENT_OUT] = 3,
+		.m[PSC_POWER] = 1,
+		.b[PSC_POWER] = 0,
+		.R[PSC_POWER] = 3,
+		.m[PSC_TEMPERATURE] = 1,
+		.b[PSC_TEMPERATURE] = 0,
+		.R[PSC_TEMPERATURE] = 2,
+		.func[0] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
+		  | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_POUT,
+		.func[1] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
+		  | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT,
+		.func[2] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
+		  | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_POUT,
+		.func[3] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
+		  | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT,
+		.func[4] = PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
+		.func[5] = PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
+		.func[6] = PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
+		.read_byte_data = max34440_read_byte_data,
+		.read_word_data = max34440_read_word_data,
+		.write_word_data = max34440_write_word_data,
+	},
 };
 
 static int max34440_probe(struct i2c_client *client,
 			  const struct i2c_device_id *id)
 {
-	return pmbus_do_probe(client, id, &max34440_info[id->driver_data]);
+	struct max34440_data *data;
+
+	data = devm_kzalloc(&client->dev, sizeof(struct max34440_data),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	data->id = id->driver_data;
+	data->info = max34440_info[id->driver_data];
+
+	return pmbus_do_probe(client, id, &data->info);
 }
 
 static const struct i2c_device_id max34440_id[] = {
 	{"max34440", max34440},
 	{"max34441", max34441},
+	{"max34446", max34446},
 	{}
 };
-
 MODULE_DEVICE_TABLE(i2c, max34440_id);
 
 /* This is the driver that will be inserted */
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
