From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 12 Jul 2011 15:41:36 +0000
Subject: [lm-sensors] [PATCH 11/15] hwmon: (adm1275) Add support for peak
Message-Id: <1310485300-2168-12-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add support for voltage and current peak (historic maximum) attributes.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/pmbus/adm1275.c |   60 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 60 insertions(+), 0 deletions(-)

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
