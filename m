From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 17 Aug 2015 18:54:37 +0000
Subject: [lm-sensors] [PATCH 3/8] hwmon: (ltc2978) Introduce feature flags
Message-Id: <1439837682-23748-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

It is becoming cumbersom to track per-chip feature support.
Introduce feature flag to simplify the code.

Tested-by: Michael Jones <mike@proclivis.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pmbus/ltc2978.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/hwmon/pmbus/ltc2978.c b/drivers/hwmon/pmbus/ltc2978.c
index e153ffd59ab0..48cbb5794e30 100644
--- a/drivers/hwmon/pmbus/ltc2978.c
+++ b/drivers/hwmon/pmbus/ltc2978.c
@@ -97,10 +97,14 @@ struct ltc2978_data {
 	u16 pin_min, pin_max;
 	u16 temp2_max;
 	struct pmbus_driver_info info;
+	u32 features;
 };
-
 #define to_ltc2978_data(x)  container_of(x, struct ltc2978_data, info)
 
+#define FEAT_CLEAR_PEAKS	BIT(0)
+
+#define has_clear_peaks(d)	((d)->features & FEAT_CLEAR_PEAKS)
+
 static inline int lin11_to_val(int data)
 {
 	s16 e = ((s16)data) >> 11;
@@ -374,13 +378,12 @@ static int ltc3883_read_word_data(struct i2c_client *client, int page, int reg)
 	return ret;
 }
 
-static int ltc2978_clear_peaks(struct i2c_client *client, int page,
-			       enum chips id)
+static int ltc2978_clear_peaks(struct ltc2978_data *data,
+			       struct i2c_client *client, int page)
 {
 	int ret;
 
-	if (id = ltc3880 || id = ltc3882 || id = ltc3883 || id = ltc3887 ||
-	    id = ltm4676)
+	if (has_clear_peaks(data))
 		ret = pmbus_write_byte(client, 0, LTC3880_MFR_CLEAR_PEAKS);
 	else
 		ret = pmbus_write_byte(client, page, PMBUS_CLEAR_FAULTS);
@@ -399,36 +402,36 @@ static int ltc2978_write_word_data(struct i2c_client *client, int page,
 	case PMBUS_VIRT_RESET_IIN_HISTORY:
 		data->iin_max = 0x7c00;
 		data->iin_min = 0x7bff;
-		ret = ltc2978_clear_peaks(client, 0, data->id);
+		ret = ltc2978_clear_peaks(data, client, 0);
 		break;
 	case PMBUS_VIRT_RESET_PIN_HISTORY:
 		data->pin_max = 0x7c00;
 		data->pin_min = 0x7bff;
-		ret = ltc2978_clear_peaks(client, 0, data->id);
+		ret = ltc2978_clear_peaks(data, client, 0);
 		break;
 	case PMBUS_VIRT_RESET_IOUT_HISTORY:
 		data->iout_max[page] = 0x7c00;
 		data->iout_min[page] = 0xfbff;
-		ret = ltc2978_clear_peaks(client, page, data->id);
+		ret = ltc2978_clear_peaks(data, client, page);
 		break;
 	case PMBUS_VIRT_RESET_TEMP2_HISTORY:
 		data->temp2_max = 0x7c00;
-		ret = ltc2978_clear_peaks(client, page, data->id);
+		ret = ltc2978_clear_peaks(data, client, page);
 		break;
 	case PMBUS_VIRT_RESET_VOUT_HISTORY:
 		data->vout_min[page] = 0xffff;
 		data->vout_max[page] = 0;
-		ret = ltc2978_clear_peaks(client, page, data->id);
+		ret = ltc2978_clear_peaks(data, client, page);
 		break;
 	case PMBUS_VIRT_RESET_VIN_HISTORY:
 		data->vin_min = 0x7bff;
 		data->vin_max = 0x7c00;
-		ret = ltc2978_clear_peaks(client, page, data->id);
+		ret = ltc2978_clear_peaks(data, client, page);
 		break;
 	case PMBUS_VIRT_RESET_TEMP_HISTORY:
 		data->temp_min[page] = 0x7bff;
 		data->temp_max[page] = 0x7c00;
-		ret = ltc2978_clear_peaks(client, page, data->id);
+		ret = ltc2978_clear_peaks(data, client, page);
 		break;
 	default:
 		ret = -ENODATA;
@@ -603,6 +606,7 @@ static int ltc2978_probe(struct i2c_client *client,
 	case ltc3880:
 	case ltc3887:
 	case ltm4676:
+		data->features |= FEAT_CLEAR_PEAKS;
 		info->read_word_data = ltc3880_read_word_data;
 		info->pages = LTC3880_NUM_PAGES;
 		info->func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN
@@ -617,6 +621,7 @@ static int ltc2978_probe(struct i2c_client *client,
 		  | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
 		break;
 	case ltc3882:
+		data->features |= FEAT_CLEAR_PEAKS;
 		info->read_word_data = ltc3880_read_word_data;
 		info->pages = LTC3880_NUM_PAGES;
 		info->func[0] = PMBUS_HAVE_VIN
@@ -631,6 +636,7 @@ static int ltc2978_probe(struct i2c_client *client,
 		  | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
 		break;
 	case ltc3883:
+		data->features |= FEAT_CLEAR_PEAKS;
 		info->read_word_data = ltc3883_read_word_data;
 		info->pages = LTC3883_NUM_PAGES;
 		info->func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN
-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
