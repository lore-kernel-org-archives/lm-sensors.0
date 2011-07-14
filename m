From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 14 Jul 2011 01:54:41 +0000
Subject: [lm-sensors] [PATCH v2 12/15] hwmon: (max16064) Add support for
Message-Id: <1310608484-20678-13-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add support for voltage and temperature peak (historic maximum) attributes.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
v2: Updated documentation

 Documentation/hwmon/max16064   |    4 +++
 drivers/hwmon/pmbus/max16064.c |   51 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 0 deletions(-)

diff --git a/Documentation/hwmon/max16064 b/Documentation/hwmon/max16064
index 4172899..f6e8bcb 100644
--- a/Documentation/hwmon/max16064
+++ b/Documentation/hwmon/max16064
@@ -50,6 +50,8 @@ in[1-4]_min_alarm	Voltage low alarm. From VOLTAGE_UV_WARNING status.
 in[1-4]_max_alarm	Voltage high alarm. From VOLTAGE_OV_WARNING status.
 in[1-4]_lcrit_alarm	Voltage critical low alarm. From VOLTAGE_UV_FAULT status.
 in[1-4]_crit_alarm	Voltage critical high alarm. From VOLTAGE_OV_FAULT status.
+in[1-4]_highest		Historical maximum voltage.
+in[1-4]_reset_history	Write any value to reset history.
 
 temp1_input		Measured temperature. From READ_TEMPERATURE_1 register.
 temp1_max		Maximum temperature. From OT_WARN_LIMIT register.
@@ -60,3 +62,5 @@ temp1_max_alarm		Chip temperature high alarm. Set by comparing
 temp1_crit_alarm	Chip temperature critical high alarm. Set by comparing
 			READ_TEMPERATURE_1 with OT_FAULT_LIMIT if TEMP_OT_FAULT
 			status is set.
+temp1_highest		Historical maximum temperature.
+temp1_reset_history	Write any value to reset history.
diff --git a/drivers/hwmon/pmbus/max16064.c b/drivers/hwmon/pmbus/max16064.c
index 78e20bc..e50b296 100644
--- a/drivers/hwmon/pmbus/max16064.c
+++ b/drivers/hwmon/pmbus/max16064.c
@@ -25,6 +25,55 @@
 #include <linux/i2c.h>
 #include "pmbus.h"
 
+#define MAX16064_MFR_VOUT_PEAK		0xd4
+#define MAX16064_MFR_TEMPERATURE_PEAK	0xd6
+
+static int max16064_read_word_data(struct i2c_client *client, int page, int reg)
+{
+	int ret;
+
+	switch (reg) {
+	case PMBUS_VIRT_READ_VOUT_MAX:
+		ret = pmbus_read_word_data(client, page,
+					   MAX16064_MFR_VOUT_PEAK);
+		break;
+	case PMBUS_VIRT_READ_TEMP_MAX:
+		ret = pmbus_read_word_data(client, page,
+					   MAX16064_MFR_TEMPERATURE_PEAK);
+		break;
+	case PMBUS_VIRT_RESET_VOUT_HISTORY:
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
+static int max16064_write_word_data(struct i2c_client *client, int page,
+				    int reg, u16 word)
+{
+	int ret;
+
+	switch (reg) {
+	case PMBUS_VIRT_RESET_VOUT_HISTORY:
+		ret = pmbus_write_word_data(client, page,
+					    MAX16064_MFR_VOUT_PEAK, 0);
+		break;
+	case PMBUS_VIRT_RESET_TEMP_HISTORY:
+		ret = pmbus_write_word_data(client, page,
+					    MAX16064_MFR_TEMPERATURE_PEAK,
+					    0xffff);
+		break;
+	default:
+		ret = -ENODATA;
+		break;
+	}
+	return ret;
+}
+
 static struct pmbus_driver_info max16064_info = {
 	.pages = 4,
 	.format[PSC_VOLTAGE_IN] = direct,
@@ -44,6 +93,8 @@ static struct pmbus_driver_info max16064_info = {
 	.func[1] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT,
 	.func[2] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT,
 	.func[3] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT,
+	.read_word_data = max16064_read_word_data,
+	.write_word_data = max16064_write_word_data,
 };
 
 static int max16064_probe(struct i2c_client *client,
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
