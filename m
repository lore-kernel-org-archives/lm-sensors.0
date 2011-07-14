From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 14 Jul 2011 01:54:40 +0000
Subject: [lm-sensors] [PATCH v2 11/15] hwmon: (adm1275) Add support for peak
Message-Id: <1310608484-20678-12-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add support for voltage and current peak (historic maximum) attributes.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
v2: Updated documentation

 Documentation/hwmon/adm1275   |    8 ++++-
 drivers/hwmon/pmbus/adm1275.c |   60 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/Documentation/hwmon/adm1275 b/Documentation/hwmon/adm1275
index 6a3a647..f2bf8b9 100644
--- a/Documentation/hwmon/adm1275
+++ b/Documentation/hwmon/adm1275
@@ -43,8 +43,8 @@ Documentation/hwmon/pmbus for details.
 Sysfs entries
 -------------
 
-The following attributes are supported. Limits are read-write; all other
-attributes are read-only.
+The following attributes are supported. Limits and are read-write, history reset
+attributes are write-only, all other attributes are read-only.
 
 in1_label		"vin1" or "vout1" depending on chip variant and
 			configuration.
@@ -53,8 +53,12 @@ in1_min			Minumum Voltage. From VOUT_UV_WARN_LIMIT register.
 in1_max			Maximum voltage. From VOUT_OV_WARN_LIMIT register.
 in1_min_alarm		Voltage low alarm. From VOLTAGE_UV_WARNING status.
 in1_max_alarm		Voltage high alarm. From VOLTAGE_OV_WARNING status.
+in1_highest		Historical maximum voltage.
+in1_reset_history	Write any value to reset history.
 
 curr1_label		"iout1"
 curr1_input		Measured current. From READ_IOUT register.
 curr1_max		Maximum current. From IOUT_OC_WARN_LIMIT register.
 curr1_max_alarm		Current high alarm. From IOUT_OC_WARN_LIMIT register.
+curr1_highest		Historical maximum current.
+curr1_reset_history	Write any value to reset history.
diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
index 1a91d51..7ca18be 100644
--- a/drivers/hwmon/pmbus/adm1275.c
+++ b/drivers/hwmon/pmbus/adm1275.c
@@ -23,11 +23,68 @@
 #include <linux/i2c.h>
 #include "pmbus.h"
 
+#define ADM1275_PEAK_IOUT		0xd0
+#define ADM1275_PEAK_VIN		0xd1
+#define ADM1275_PEAK_VOUT		0xd2
 #define ADM1275_PMON_CONFIG		0xd4
 
 #define ADM1275_VIN_VOUT_SELECT		(1 << 6)
 #define ADM1275_VRANGE			(1 << 5)
 
+static int adm1275_read_word_data(struct i2c_client *client, int page, int reg)
+{
+	int ret;
+
+	if (page)
+		return -EINVAL;
+
+	switch (reg) {
+	case PMBUS_VIRT_READ_IOUT_MAX:
+		ret = pmbus_read_word_data(client, 0, ADM1275_PEAK_IOUT);
+		break;
+	case PMBUS_VIRT_READ_VOUT_MAX:
+		ret = pmbus_read_word_data(client, 0, ADM1275_PEAK_VOUT);
+		break;
+	case PMBUS_VIRT_READ_VIN_MAX:
+		ret = pmbus_read_word_data(client, 0, ADM1275_PEAK_VIN);
+		break;
+	case PMBUS_VIRT_RESET_IOUT_HISTORY:
+	case PMBUS_VIRT_RESET_VOUT_HISTORY:
+	case PMBUS_VIRT_RESET_VIN_HISTORY:
+		ret = 0;
+		break;
+	default:
+		ret = -ENODATA;
+		break;
+	}
+	return ret;
+}
+
+static int adm1275_write_word_data(struct i2c_client *client, int page, int reg,
+				   u16 word)
+{
+	int ret;
+
+	if (page)
+		return -EINVAL;
+
+	switch (reg) {
+	case PMBUS_VIRT_RESET_IOUT_HISTORY:
+		ret = pmbus_write_word_data(client, 0, ADM1275_PEAK_IOUT, 0);
+		break;
+	case PMBUS_VIRT_RESET_VOUT_HISTORY:
+		ret = pmbus_write_word_data(client, 0, ADM1275_PEAK_VOUT, 0);
+		break;
+	case PMBUS_VIRT_RESET_VIN_HISTORY:
+		ret = pmbus_write_word_data(client, 0, ADM1275_PEAK_VIN, 0);
+		break;
+	default:
+		ret = -ENODATA;
+		break;
+	}
+	return ret;
+}
+
 static int adm1275_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -58,6 +115,9 @@ static int adm1275_probe(struct i2c_client *client,
 	info->R[PSC_CURRENT_OUT] = -1;
 	info->func[0] = PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT;
 
+	info->read_word_data = adm1275_read_word_data;
+	info->write_word_data = adm1275_write_word_data;
+
 	if (config & ADM1275_VRANGE) {
 		info->m[PSC_VOLTAGE_IN] = 19045;
 		info->b[PSC_VOLTAGE_IN] = 0;
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
