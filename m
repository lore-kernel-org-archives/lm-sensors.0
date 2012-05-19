From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 19 May 2012 18:48:20 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (max34440) Add support for MAX34460
Message-Id: <1337453300-27643-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

MAX34460 is a PMBus 12-Channel Voltage Monitor & Sequencer.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/max34440   |    7 +++++++
 drivers/hwmon/pmbus/Kconfig    |    2 +-
 drivers/hwmon/pmbus/max34440.c |   37 +++++++++++++++++++++++++++++++++++--
 3 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/Documentation/hwmon/max34440 b/Documentation/hwmon/max34440
index 0448222..fb06c60 100644
--- a/Documentation/hwmon/max34440
+++ b/Documentation/hwmon/max34440
@@ -16,6 +16,11 @@ Supported chips:
     Prefixes: 'max34446'
     Addresses scanned: -
     Datasheet: http://datasheets.maxim-ic.com/en/ds/MAX34446.pdf
+  * Maxim MAX34460
+    PMBus 12-Channel Voltage Monitor & Sequencer
+    Prefix: 'max34460'
+    Addresses scanned: -
+    Datasheet: Not yet final
 
 Author: Guenter Roeck <guenter.roeck@ericsson.com>
 
@@ -109,3 +114,5 @@ temp[1-8]_reset_history	Write any value to reset history.
 
 			temp7 and temp8 attributes only exist for MAX34440.
 			MAX34446 only supports temp[1-3].
+
+MAX34460 supports attribute groups in[1-12] and temp[1-5].
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 2ca6a5a..a6d0b77 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -72,7 +72,7 @@ config SENSORS_MAX34440
 	default n
 	help
 	  If you say yes here you get hardware monitoring support for Maxim
-	  MAX34440, MAX34441, and MAX34446.
+	  MAX34440, MAX34441, MAX34446, and MAX34460.
 
 	  This driver can also be built as a module. If so, the module will
 	  be called max34440.
diff --git a/drivers/hwmon/pmbus/max34440.c b/drivers/hwmon/pmbus/max34440.c
index 2ada7b0..c677dbb 100644
--- a/drivers/hwmon/pmbus/max34440.c
+++ b/drivers/hwmon/pmbus/max34440.c
@@ -25,7 +25,7 @@
 #include <linux/i2c.h>
 #include "pmbus.h"
 
-enum chips { max34440, max34441, max34446 };
+enum chips { max34440, max34441, max34446, max34460 };
 
 #define MAX34440_MFR_VOUT_PEAK		0xd4
 #define MAX34440_MFR_IOUT_PEAK		0xd5
@@ -87,7 +87,7 @@ static int max34440_read_word_data(struct i2c_client *client, int page, int reg)
 					   MAX34446_MFR_POUT_PEAK);
 		break;
 	case PMBUS_VIRT_READ_TEMP_AVG:
-		if (data->id != max34446)
+		if (data->id != max34446 && data->id != max34460)
 			return -ENXIO;
 		ret = pmbus_read_word_data(client, page,
 					   MAX34446_MFR_TEMPERATURE_AVG);
@@ -322,6 +322,38 @@ static struct pmbus_driver_info max34440_info[] = {
 		.read_word_data = max34440_read_word_data,
 		.write_word_data = max34440_write_word_data,
 	},
+	[max34460] = {
+		.pages = 18,
+		.format[PSC_VOLTAGE_OUT] = direct,
+		.format[PSC_TEMPERATURE] = direct,
+		.m[PSC_VOLTAGE_OUT] = 1,
+		.b[PSC_VOLTAGE_OUT] = 0,
+		.R[PSC_VOLTAGE_OUT] = 3,
+		.m[PSC_TEMPERATURE] = 1,
+		.b[PSC_TEMPERATURE] = 0,
+		.R[PSC_TEMPERATURE] = 2,
+		.func[0] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT,
+		.func[1] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT,
+		.func[2] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT,
+		.func[3] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT,
+		.func[4] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT,
+		.func[5] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT,
+		.func[6] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT,
+		.func[7] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT,
+		.func[8] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT,
+		.func[9] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT,
+		.func[10] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT,
+		.func[11] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT,
+		.func[13] = PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
+		.func[14] = PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
+		.func[15] = PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
+		.func[16] = PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
+		.func[17] = PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
+		.read_byte_data = max34440_read_byte_data,
+		.read_word_data = max34440_read_word_data,
+		.write_word_data = max34440_write_word_data,
+		.status_register = PMBUS_STATUS_WORD,
+	},
 };
 
 static int max34440_probe(struct i2c_client *client,
@@ -343,6 +375,7 @@ static const struct i2c_device_id max34440_id[] = {
 	{"max34440", max34440},
 	{"max34441", max34441},
 	{"max34446", max34446},
+	{"max34460", max34460},
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, max34440_id);
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
