From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 14 Jul 2011 01:54:43 +0000
Subject: [lm-sensors] [PATCH v2 14/15] hwmon: (max34440) Add support for
Message-Id: <1310608484-20678-15-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add support for voltage, current, and temperature peak (historic maximum)
attributes.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
v2: Updated documentation

 Documentation/hwmon/max34440   |    6 ++++
 drivers/hwmon/pmbus/max34440.c |   63 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 0 deletions(-)

diff --git a/Documentation/hwmon/max34440 b/Documentation/hwmon/max34440
index 6c525dd..8ab5153 100644
--- a/Documentation/hwmon/max34440
+++ b/Documentation/hwmon/max34440
@@ -56,6 +56,8 @@ in[1-6]_min_alarm	Voltage low alarm. From VOLTAGE_UV_WARNING status.
 in[1-6]_max_alarm	Voltage high alarm. From VOLTAGE_OV_WARNING status.
 in[1-6]_lcrit_alarm	Voltage critical low alarm. From VOLTAGE_UV_FAULT status.
 in[1-6]_crit_alarm	Voltage critical high alarm. From VOLTAGE_OV_FAULT status.
+in[1-6]_highest		Historical maximum voltage.
+in[1-6]_reset_history	Write any value to reset history.
 
 curr[1-6]_label		"iout[1-6]".
 curr[1-6]_input		Measured current. From READ_IOUT register.
@@ -63,6 +65,8 @@ curr[1-6]_max		Maximum current. From IOUT_OC_WARN_LIMIT register.
 curr[1-6]_crit		Critical maximum current. From IOUT_OC_FAULT_LIMIT register.
 curr[1-6]_max_alarm	Current high alarm. From IOUT_OC_WARNING status.
 curr[1-6]_crit_alarm	Current critical high alarm. From IOUT_OC_FAULT status.
+curr[1-6]_highest	Historical maximum current.
+curr[1-6]_reset_history	Write any value to reset history.
 
 			in6 and curr6 attributes only exist for MAX34440.
 
@@ -75,5 +79,7 @@ temp[1-8]_max		Maximum temperature. From OT_WARN_LIMIT register.
 temp[1-8]_crit		Critical high temperature. From OT_FAULT_LIMIT register.
 temp[1-8]_max_alarm	Temperature high alarm.
 temp[1-8]_crit_alarm	Temperature critical high alarm.
+temp[1-8]_highest	Historical maximum temperature.
+temp[1-8]_reset_history	Write any value to reset history.
 
 			temp7 and temp8 attributes only exist for MAX34440.
diff --git a/drivers/hwmon/pmbus/max34440.c b/drivers/hwmon/pmbus/max34440.c
index 2e30046..fda621d 100644
--- a/drivers/hwmon/pmbus/max34440.c
+++ b/drivers/hwmon/pmbus/max34440.c
@@ -27,11 +27,70 @@
 
 enum chips { max34440, max34441 };
 
+#define MAX34440_MFR_VOUT_PEAK		0xd4
+#define MAX34440_MFR_IOUT_PEAK		0xd5
+#define MAX34440_MFR_TEMPERATURE_PEAK	0xd6
+
 #define MAX34440_STATUS_OC_WARN		(1 << 0)
 #define MAX34440_STATUS_OC_FAULT	(1 << 1)
 #define MAX34440_STATUS_OT_FAULT	(1 << 5)
 #define MAX34440_STATUS_OT_WARN		(1 << 6)
 
+static int max34440_read_word_data(struct i2c_client *client, int page, int reg)
+{
+	int ret;
+
+	switch (reg) {
+	case PMBUS_VIRT_READ_VOUT_MAX:
+		ret = pmbus_read_word_data(client, page,
+					   MAX34440_MFR_VOUT_PEAK);
+		break;
+	case PMBUS_VIRT_READ_IOUT_MAX:
+		ret = pmbus_read_word_data(client, page,
+					   MAX34440_MFR_IOUT_PEAK);
+		break;
+	case PMBUS_VIRT_READ_TEMP_MAX:
+		ret = pmbus_read_word_data(client, page,
+					   MAX34440_MFR_TEMPERATURE_PEAK);
+		break;
+	case PMBUS_VIRT_RESET_VOUT_HISTORY:
+	case PMBUS_VIRT_RESET_IOUT_HISTORY:
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
+static int max34440_write_word_data(struct i2c_client *client, int page,
+				    int reg, u16 word)
+{
+	int ret;
+
+	switch (reg) {
+	case PMBUS_VIRT_RESET_VOUT_HISTORY:
+		ret = pmbus_write_word_data(client, page,
+					    MAX34440_MFR_VOUT_PEAK, 0);
+		break;
+	case PMBUS_VIRT_RESET_IOUT_HISTORY:
+		ret = pmbus_write_word_data(client, page,
+					    MAX34440_MFR_IOUT_PEAK, 0);
+		break;
+	case PMBUS_VIRT_RESET_TEMP_HISTORY:
+		ret = pmbus_write_word_data(client, page,
+					    MAX34440_MFR_TEMPERATURE_PEAK,
+					    0xffff);
+		break;
+	default:
+		ret = -ENODATA;
+		break;
+	}
+	return ret;
+}
+
 static int max34440_read_byte_data(struct i2c_client *client, int page, int reg)
 {
 	int ret;
@@ -109,6 +168,8 @@ static struct pmbus_driver_info max34440_info[] = {
 		.func[12] = PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
 		.func[13] = PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
 		.read_byte_data = max34440_read_byte_data,
+		.read_word_data = max34440_read_word_data,
+		.write_word_data = max34440_write_word_data,
 	},
 	[max34441] = {
 		.pages = 12,
@@ -150,6 +211,8 @@ static struct pmbus_driver_info max34440_info[] = {
 		.func[10] = PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
 		.func[11] = PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
 		.read_byte_data = max34440_read_byte_data,
+		.read_word_data = max34440_read_word_data,
+		.write_word_data = max34440_write_word_data,
 	},
 };
 
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
