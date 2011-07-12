From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 12 Jul 2011 15:41:38 +0000
Subject: [lm-sensors] [PATCH 13/15] hwmon: (max8688) Add support for peak
Message-Id: <1310485300-2168-14-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add support for voltage, current, and temperature peak (historic maximum)
attributes.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/pmbus/max8688.c |   61 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/pmbus/max8688.c b/drivers/hwmon/pmbus/max8688.c
index ddc8a64..c3e72f1 100644
--- a/drivers/hwmon/pmbus/max8688.c
+++ b/drivers/hwmon/pmbus/max8688.c
@@ -25,6 +25,9 @@
 #include <linux/i2c.h>
 #include "pmbus.h"
 
+#define MAX8688_MFR_VOUT_PEAK		0xd4
+#define MAX8688_MFR_IOUT_PEAK		0xd5
+#define MAX8688_MFR_TEMPERATURE_PEAK	0xd6
 #define MAX8688_MFG_STATUS		0xd8
 
 #define MAX8688_STATUS_OC_FAULT		(1 << 4)
@@ -37,6 +40,62 @@
 #define MAX8688_STATUS_OT_FAULT		(1 << 13)
 #define MAX8688_STATUS_OT_WARNING	(1 << 14)
 
+static int max8688_read_word_data(struct i2c_client *client, int page, int reg)
+{
+	int ret;
+
+	if (page)
+		return -EINVAL;
+
+	switch (reg) {
+	case PMBUS_VIRT_READ_VOUT_MAX:
+		ret = pmbus_read_word_data(client, 0, MAX8688_MFR_VOUT_PEAK);
+		break;
+	case PMBUS_VIRT_READ_IOUT_MAX:
+		ret = pmbus_read_word_data(client, 0, MAX8688_MFR_IOUT_PEAK);
+		break;
+	case PMBUS_VIRT_READ_TEMP_MAX:
+		ret = pmbus_read_word_data(client, 0,
+					   MAX8688_MFR_TEMPERATURE_PEAK);
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
+static int max8688_write_word_data(struct i2c_client *client, int page, int reg,
+				   u16 word)
+{
+	int ret;
+
+	switch (reg) {
+	case PMBUS_VIRT_RESET_VOUT_HISTORY:
+		ret = pmbus_write_word_data(client, 0, MAX8688_MFR_VOUT_PEAK,
+					    0);
+		break;
+	case PMBUS_VIRT_RESET_IOUT_HISTORY:
+		ret = pmbus_write_word_data(client, 0, MAX8688_MFR_IOUT_PEAK,
+					    0);
+		break;
+	case PMBUS_VIRT_RESET_TEMP_HISTORY:
+		ret = pmbus_write_word_data(client, 0,
+					    MAX8688_MFR_TEMPERATURE_PEAK,
+					    0xffff);
+		break;
+	default:
+		ret = -ENODATA;
+		break;
+	}
+	return ret;
+}
+
 static int max8688_read_byte_data(struct i2c_client *client, int page, int reg)
 {
 	int ret = 0;
@@ -111,6 +170,8 @@ static struct pmbus_driver_info max8688_info = {
 		| PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT
 		| PMBUS_HAVE_STATUS_TEMP,
 	.read_byte_data = max8688_read_byte_data,
+	.read_word_data = max8688_read_word_data,
+	.write_word_data = max8688_write_word_data,
 };
 
 static int max8688_probe(struct i2c_client *client,
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
