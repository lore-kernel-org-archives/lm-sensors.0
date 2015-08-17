From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 17 Aug 2015 18:54:38 +0000
Subject: [lm-sensors] [PATCH 4/8] hwmon: (ltc2978) Introduce helper functions for min and max values
Message-Id: <1439837682-23748-4-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The code used to determine historic low and high peaks is repeated
several times. Introduce helper functions to simplify it.

Tested-by: Michael Jones <mike@proclivis.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pmbus/ltc2978.c | 148 ++++++++++++++++--------------------------
 1 file changed, 57 insertions(+), 91 deletions(-)

diff --git a/drivers/hwmon/pmbus/ltc2978.c b/drivers/hwmon/pmbus/ltc2978.c
index 48cbb5794e30..c3b71668a47f 100644
--- a/drivers/hwmon/pmbus/ltc2978.c
+++ b/drivers/hwmon/pmbus/ltc2978.c
@@ -118,6 +118,34 @@ static inline int lin11_to_val(int data)
 	return (e < 0 ? m >> -e : m << e);
 }
 
+static int ltc_get_max(struct ltc2978_data *data, struct i2c_client *client,
+		       int page, int reg, u16 *pmax)
+{
+	int ret;
+
+	ret = pmbus_read_word_data(client, page, reg);
+	if (ret >= 0) {
+		if (lin11_to_val(ret) > lin11_to_val(*pmax))
+			*pmax = ret;
+		ret = *pmax;
+	}
+	return ret;
+}
+
+static int ltc_get_min(struct ltc2978_data *data, struct i2c_client *client,
+		       int page, int reg, u16 *pmin)
+{
+	int ret;
+
+	ret = pmbus_read_word_data(client, page, reg);
+	if (ret >= 0) {
+		if (lin11_to_val(ret) < lin11_to_val(*pmin))
+			*pmin = ret;
+		ret = *pmin;
+	}
+	return ret;
+}
+
 static int ltc2978_read_word_data_common(struct i2c_client *client, int page,
 					 int reg)
 {
@@ -127,12 +155,8 @@ static int ltc2978_read_word_data_common(struct i2c_client *client, int page,
 
 	switch (reg) {
 	case PMBUS_VIRT_READ_VIN_MAX:
-		ret = pmbus_read_word_data(client, page, LTC2978_MFR_VIN_PEAK);
-		if (ret >= 0) {
-			if (lin11_to_val(ret) > lin11_to_val(data->vin_max))
-				data->vin_max = ret;
-			ret = data->vin_max;
-		}
+		ret = ltc_get_max(data, client, page, LTC2978_MFR_VIN_PEAK,
+				  &data->vin_max);
 		break;
 	case PMBUS_VIRT_READ_VOUT_MAX:
 		ret = pmbus_read_word_data(client, page, LTC2978_MFR_VOUT_PEAK);
@@ -147,14 +171,9 @@ static int ltc2978_read_word_data_common(struct i2c_client *client, int page,
 		}
 		break;
 	case PMBUS_VIRT_READ_TEMP_MAX:
-		ret = pmbus_read_word_data(client, page,
-					   LTC2978_MFR_TEMPERATURE_PEAK);
-		if (ret >= 0) {
-			if (lin11_to_val(ret)
-			    > lin11_to_val(data->temp_max[page]))
-				data->temp_max[page] = ret;
-			ret = data->temp_max[page];
-		}
+		ret = ltc_get_max(data, client, page,
+				  LTC2978_MFR_TEMPERATURE_PEAK,
+				  &data->temp_max[page]);
 		break;
 	case PMBUS_VIRT_RESET_VOUT_HISTORY:
 	case PMBUS_VIRT_RESET_VIN_HISTORY:
@@ -176,12 +195,8 @@ static int ltc2978_read_word_data(struct i2c_client *client, int page, int reg)
 
 	switch (reg) {
 	case PMBUS_VIRT_READ_VIN_MIN:
-		ret = pmbus_read_word_data(client, page, LTC2978_MFR_VIN_MIN);
-		if (ret >= 0) {
-			if (lin11_to_val(ret) < lin11_to_val(data->vin_min))
-				data->vin_min = ret;
-			ret = data->vin_min;
-		}
+		ret = ltc_get_min(data, client, page, LTC2978_MFR_VIN_MIN,
+				  &data->vin_min);
 		break;
 	case PMBUS_VIRT_READ_VOUT_MIN:
 		ret = pmbus_read_word_data(client, page, LTC2978_MFR_VOUT_MIN);
@@ -200,14 +215,9 @@ static int ltc2978_read_word_data(struct i2c_client *client, int page, int reg)
 		}
 		break;
 	case PMBUS_VIRT_READ_TEMP_MIN:
-		ret = pmbus_read_word_data(client, page,
-					   LTC2978_MFR_TEMPERATURE_MIN);
-		if (ret >= 0) {
-			if (lin11_to_val(ret)
-			    < lin11_to_val(data->temp_min[page]))
-				data->temp_min[page] = ret;
-			ret = data->temp_min[page];
-		}
+		ret = ltc_get_min(data, client, page,
+				  LTC2978_MFR_TEMPERATURE_MIN,
+				  &data->temp_min[page]);
 		break;
 	case PMBUS_VIRT_READ_IOUT_MAX:
 	case PMBUS_VIRT_RESET_IOUT_HISTORY:
@@ -230,22 +240,12 @@ static int ltc2974_read_word_data(struct i2c_client *client, int page, int reg)
 
 	switch (reg) {
 	case PMBUS_VIRT_READ_IOUT_MAX:
-		ret = pmbus_read_word_data(client, page, LTC2974_MFR_IOUT_PEAK);
-		if (ret >= 0) {
-			if (lin11_to_val(ret)
-			    > lin11_to_val(data->iout_max[page]))
-				data->iout_max[page] = ret;
-			ret = data->iout_max[page];
-		}
+		ret = ltc_get_max(data, client, page, LTC2974_MFR_IOUT_PEAK,
+				  &data->iout_max[page]);
 		break;
 	case PMBUS_VIRT_READ_IOUT_MIN:
-		ret = pmbus_read_word_data(client, page, LTC2974_MFR_IOUT_MIN);
-		if (ret >= 0) {
-			if (lin11_to_val(ret)
-			    < lin11_to_val(data->iout_min[page]))
-				data->iout_min[page] = ret;
-			ret = data->iout_min[page];
-		}
+		ret = ltc_get_min(data, client, page, LTC2974_MFR_IOUT_MIN,
+				  &data->iout_min[page]);
 		break;
 	case PMBUS_VIRT_RESET_IOUT_HISTORY:
 		ret = 0;
@@ -265,40 +265,20 @@ static int ltc2975_read_word_data(struct i2c_client *client, int page, int reg)
 
 	switch (reg) {
 	case PMBUS_VIRT_READ_IIN_MAX:
-		ret = pmbus_read_word_data(client, page, LTC2975_MFR_IIN_PEAK);
-		if (ret >= 0) {
-			if (lin11_to_val(ret)
-			    > lin11_to_val(data->iin_max))
-				data->iin_max = ret;
-			ret = data->iin_max;
-		}
+		ret = ltc_get_max(data, client, page, LTC2975_MFR_IIN_PEAK,
+				  &data->iin_max);
 		break;
 	case PMBUS_VIRT_READ_IIN_MIN:
-		ret = pmbus_read_word_data(client, page, LTC2975_MFR_IIN_MIN);
-		if (ret >= 0) {
-			if (lin11_to_val(ret)
-			    < lin11_to_val(data->iin_min))
-				data->iin_min = ret;
-			ret = data->iin_min;
-		}
+		ret = ltc_get_min(data, client, page, LTC2975_MFR_IIN_MIN,
+				  &data->iin_min);
 		break;
 	case PMBUS_VIRT_READ_PIN_MAX:
-		ret = pmbus_read_word_data(client, page, LTC2975_MFR_PIN_PEAK);
-		if (ret >= 0) {
-			if (lin11_to_val(ret)
-			    > lin11_to_val(data->pin_max))
-				data->pin_max = ret;
-			ret = data->pin_max;
-		}
+		ret = ltc_get_max(data, client, page, LTC2975_MFR_PIN_PEAK,
+				  &data->pin_max);
 		break;
 	case PMBUS_VIRT_READ_PIN_MIN:
-		ret = pmbus_read_word_data(client, page, LTC2975_MFR_PIN_MIN);
-		if (ret >= 0) {
-			if (lin11_to_val(ret)
-			    < lin11_to_val(data->pin_min))
-				data->pin_min = ret;
-			ret = data->pin_min;
-		}
+		ret = ltc_get_min(data, client, page, LTC2975_MFR_PIN_MIN,
+				  &data->pin_min);
 		break;
 	case PMBUS_VIRT_RESET_IIN_HISTORY:
 	case PMBUS_VIRT_RESET_PIN_HISTORY:
@@ -319,22 +299,13 @@ static int ltc3880_read_word_data(struct i2c_client *client, int page, int reg)
 
 	switch (reg) {
 	case PMBUS_VIRT_READ_IOUT_MAX:
-		ret = pmbus_read_word_data(client, page, LTC3880_MFR_IOUT_PEAK);
-		if (ret >= 0) {
-			if (lin11_to_val(ret)
-			    > lin11_to_val(data->iout_max[page]))
-				data->iout_max[page] = ret;
-			ret = data->iout_max[page];
-		}
+		ret = ltc_get_max(data, client, page, LTC3880_MFR_IOUT_PEAK,
+				  &data->iout_max[page]);
 		break;
 	case PMBUS_VIRT_READ_TEMP2_MAX:
-		ret = pmbus_read_word_data(client, page,
-					   LTC3880_MFR_TEMPERATURE2_PEAK);
-		if (ret >= 0) {
-			if (lin11_to_val(ret) > lin11_to_val(data->temp2_max))
-				data->temp2_max = ret;
-			ret = data->temp2_max;
-		}
+		ret = ltc_get_max(data, client, page,
+				  LTC3880_MFR_TEMPERATURE2_PEAK,
+				  &data->temp2_max);
 		break;
 	case PMBUS_VIRT_READ_VIN_MIN:
 	case PMBUS_VIRT_READ_VOUT_MIN:
@@ -360,13 +331,8 @@ static int ltc3883_read_word_data(struct i2c_client *client, int page, int reg)
 
 	switch (reg) {
 	case PMBUS_VIRT_READ_IIN_MAX:
-		ret = pmbus_read_word_data(client, page, LTC3883_MFR_IIN_PEAK);
-		if (ret >= 0) {
-			if (lin11_to_val(ret)
-			    > lin11_to_val(data->iin_max))
-				data->iin_max = ret;
-			ret = data->iin_max;
-		}
+		ret = ltc_get_max(data, client, page, LTC3883_MFR_IIN_PEAK,
+				  &data->iin_max);
 		break;
 	case PMBUS_VIRT_RESET_IIN_HISTORY:
 		ret = 0;
-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
