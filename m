From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 23 Feb 2013 02:19:31 +0000
Subject: [lm-sensors] [PATCH 3/7] hwmon: (pmbus/ltc2978) Fix peak attribute inizialization and clearing
Message-Id: <1361585975-5604-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Peak attributes were not initialized and cleared correctly.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Candidate for -stable.

 drivers/hwmon/pmbus/ltc2978.c |   24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/pmbus/ltc2978.c b/drivers/hwmon/pmbus/ltc2978.c
index 9652a2c..eec294a 100644
--- a/drivers/hwmon/pmbus/ltc2978.c
+++ b/drivers/hwmon/pmbus/ltc2978.c
@@ -248,26 +248,26 @@ static int ltc2978_write_word_data(struct i2c_client *client, int page,
 
 	switch (reg) {
 	case PMBUS_VIRT_RESET_IOUT_HISTORY:
-		data->iout_max[page] = 0x7fff;
+		data->iout_max[page] = 0x7c00;
 		ret = ltc2978_clear_peaks(client, page, data->id);
 		break;
 	case PMBUS_VIRT_RESET_TEMP2_HISTORY:
-		data->temp2_max[page] = 0x7fff;
+		data->temp2_max[page] = 0x7c00;
 		ret = ltc2978_clear_peaks(client, page, data->id);
 		break;
 	case PMBUS_VIRT_RESET_VOUT_HISTORY:
 		data->vout_min[page] = 0xffff;
-		data->vout_max[page] = 0;
+		data->vout_max[page] = 0x0000;
 		ret = ltc2978_clear_peaks(client, page, data->id);
 		break;
 	case PMBUS_VIRT_RESET_VIN_HISTORY:
 		data->vin_min = 0x7bff;
-		data->vin_max = 0;
+		data->vin_max = 0x7c00;
 		ret = ltc2978_clear_peaks(client, page, data->id);
 		break;
 	case PMBUS_VIRT_RESET_TEMP_HISTORY:
-		data->temp_min = 0x7bff;
-		data->temp_max = 0x7fff;
+		data->temp_min = 0xfbff;
+		data->temp_max = 0x7c00;
 		ret = ltc2978_clear_peaks(client, page, data->id);
 		break;
 	default:
@@ -321,10 +321,10 @@ static int ltc2978_probe(struct i2c_client *client,
 	info = &data->info;
 	info->write_word_data = ltc2978_write_word_data;
 
-	data->vout_min[0] = 0xffff;
 	data->vin_min = 0x7bff;
+	data->vin_max = 0x7c00;
 	data->temp_min = 0x7bff;
-	data->temp_max = 0x7fff;
+	data->temp_max = 0x7c00;
 
 	switch (id->driver_data) {
 	case ltc2978:
@@ -336,7 +336,6 @@ static int ltc2978_probe(struct i2c_client *client,
 		for (i = 1; i < 8; i++) {
 			info->func[i] = PMBUS_HAVE_VOUT
 			  | PMBUS_HAVE_STATUS_VOUT;
-			data->vout_min[i] = 0xffff;
 		}
 		break;
 	case ltc3880:
@@ -352,11 +351,16 @@ static int ltc2978_probe(struct i2c_client *client,
 		  | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT
 		  | PMBUS_HAVE_POUT
 		  | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
-		data->vout_min[1] = 0xffff;
+		data->temp2_max[0] = 0x7c00;
+		data->temp2_max[1] = 0x7c00;
 		break;
 	default:
 		return -ENODEV;
 	}
+	for (i = 0; i < info->pages; i++) {
+		data->vout_min[i] = 0xffff;
+		data->iout_max[i] = 0x7c00;
+	}
 
 	return pmbus_do_probe(client, id, info);
 }
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
