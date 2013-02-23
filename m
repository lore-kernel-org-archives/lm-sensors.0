From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 23 Feb 2013 02:19:33 +0000
Subject: [lm-sensors] [PATCH 5/7] hwmon: (pmbus/ltc2978) Fix temperature reporting
Message-Id: <1361585975-5604-5-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On LTC2978, only READ_TEMPERATURE is supported. It reports
the internal junction temperature. This register is unpaged.

On LTC3880, READ_TEMPERATURE and READ_TEMPERATURE2 are supported.
READ_TEMPERATURE is paged and reports external temperatures.
READ_TEMPERATURE2 is unpaged and reports the internal junction
temperature.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Candidate for -stable.

 drivers/hwmon/pmbus/ltc2978.c |   29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/hwmon/pmbus/ltc2978.c b/drivers/hwmon/pmbus/ltc2978.c
index 14f96ae..e21ef2f 100644
--- a/drivers/hwmon/pmbus/ltc2978.c
+++ b/drivers/hwmon/pmbus/ltc2978.c
@@ -59,10 +59,10 @@ enum chips { ltc2978, ltc3880 };
 struct ltc2978_data {
 	enum chips id;
 	int vin_min, vin_max;
-	int temp_min, temp_max;
+	int temp_min, temp_max[8];
 	int vout_min[8], vout_max[8];
-	int iout_max[2];
-	int temp2_max[2];
+	int iout_max[8];
+	int temp2_max;
 	struct pmbus_driver_info info;
 };
 
@@ -113,9 +113,10 @@ static int ltc2978_read_word_data_common(struct i2c_client *client, int page,
 		ret = pmbus_read_word_data(client, page,
 					   LTC2978_MFR_TEMPERATURE_PEAK);
 		if (ret >= 0) {
-			if (lin11_to_val(ret) > lin11_to_val(data->temp_max))
-				data->temp_max = ret;
-			ret = data->temp_max;
+			if (lin11_to_val(ret)
+			    > lin11_to_val(data->temp_max[page]))
+				data->temp_max[page] = ret;
+			ret = data->temp_max[page];
 		}
 		break;
 	case PMBUS_VIRT_RESET_VOUT_HISTORY:
@@ -204,10 +205,9 @@ static int ltc3880_read_word_data(struct i2c_client *client, int page, int reg)
 		ret = pmbus_read_word_data(client, page,
 					   LTC3880_MFR_TEMPERATURE2_PEAK);
 		if (ret >= 0) {
-			if (lin11_to_val(ret)
-			    > lin11_to_val(data->temp2_max[page]))
-				data->temp2_max[page] = ret;
-			ret = data->temp2_max[page];
+			if (lin11_to_val(ret) > lin11_to_val(data->temp2_max))
+				data->temp2_max = ret;
+			ret = data->temp2_max;
 		}
 		break;
 	case PMBUS_VIRT_READ_VIN_MIN:
@@ -252,7 +252,7 @@ static int ltc2978_write_word_data(struct i2c_client *client, int page,
 		ret = ltc2978_clear_peaks(client, page, data->id);
 		break;
 	case PMBUS_VIRT_RESET_TEMP2_HISTORY:
-		data->temp2_max[page] = 0x7c00;
+		data->temp2_max = 0x7c00;
 		ret = ltc2978_clear_peaks(client, page, data->id);
 		break;
 	case PMBUS_VIRT_RESET_VOUT_HISTORY:
@@ -267,7 +267,7 @@ static int ltc2978_write_word_data(struct i2c_client *client, int page,
 		break;
 	case PMBUS_VIRT_RESET_TEMP_HISTORY:
 		data->temp_min = 0xfbff;
-		data->temp_max = 0x7c00;
+		data->temp_max[page] = 0x7c00;
 		ret = ltc2978_clear_peaks(client, page, data->id);
 		break;
 	default:
@@ -324,7 +324,7 @@ static int ltc2978_probe(struct i2c_client *client,
 	data->vin_min = 0x7bff;
 	data->vin_max = 0x7c00;
 	data->temp_min = 0x7bff;
-	data->temp_max = 0x7c00;
+	data->temp2_max = 0x7c00;
 
 	switch (data->id) {
 	case ltc2978:
@@ -351,13 +351,12 @@ static int ltc2978_probe(struct i2c_client *client,
 		  | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT
 		  | PMBUS_HAVE_POUT
 		  | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
-		data->temp2_max[0] = 0x7c00;
-		data->temp2_max[1] = 0x7c00;
 		break;
 	default:
 		return -ENODEV;
 	}
 	for (i = 0; i < info->pages; i++) {
+		data->temp_max[i] = 0x7c00;
 		data->vout_min[i] = 0xffff;
 		data->iout_max[i] = 0x7c00;
 	}
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
