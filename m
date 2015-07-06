From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 06 Jul 2015 15:54:22 +0000
Subject: [lm-sensors] [PATCH 3/5] hwmon: (adm1275) Introduce new feature flags
Message-Id: <1436198064-23678-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Introduce have_vout, have_vaux_status, have_pin_max, and have_uc_fault
to simplify adding support for new chips.

Also simplify error returns where appropriate to return immediately
on error.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pmbus/adm1275.c | 97 ++++++++++++++++++++++++-------------------
 1 file changed, 54 insertions(+), 43 deletions(-)

diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
index 468d39289575..060dace4e688 100644
--- a/drivers/hwmon/pmbus/adm1275.c
+++ b/drivers/hwmon/pmbus/adm1275.c
@@ -57,6 +57,10 @@ enum chips { adm1075, adm1275, adm1276 };
 struct adm1275_data {
 	int id;
 	bool have_oc_fault;
+	bool have_uc_fault;
+	bool have_vout;
+	bool have_vaux_status;
+	bool have_pin_max;
 	struct pmbus_driver_info info;
 };
 
@@ -101,40 +105,30 @@ static int adm1275_read_word_data(struct i2c_client *client, int page, int reg)
 
 	switch (reg) {
 	case PMBUS_IOUT_UC_FAULT_LIMIT:
-		if (data->have_oc_fault) {
-			ret = -ENXIO;
-			break;
-		}
+		if (!data->have_uc_fault)
+			return -ENXIO;
 		ret = pmbus_read_word_data(client, 0, ADM1275_IOUT_WARN2_LIMIT);
 		break;
 	case PMBUS_IOUT_OC_FAULT_LIMIT:
-		if (!data->have_oc_fault) {
-			ret = -ENXIO;
-			break;
-		}
+		if (!data->have_oc_fault)
+			return -ENXIO;
 		ret = pmbus_read_word_data(client, 0, ADM1275_IOUT_WARN2_LIMIT);
 		break;
 	case PMBUS_VOUT_OV_WARN_LIMIT:
-		if (data->id != adm1075) {
-			ret = -ENODATA;
-			break;
-		}
+		if (data->have_vout)
+			return -ENODATA;
 		ret = pmbus_read_word_data(client, 0,
 					   ADM1075_VAUX_OV_WARN_LIMIT);
 		break;
 	case PMBUS_VOUT_UV_WARN_LIMIT:
-		if (data->id != adm1075) {
-			ret = -ENODATA;
-			break;
-		}
+		if (data->have_vout)
+			return -ENODATA;
 		ret = pmbus_read_word_data(client, 0,
 					   ADM1075_VAUX_UV_WARN_LIMIT);
 		break;
 	case PMBUS_READ_VOUT:
-		if (data->id != adm1075) {
-			ret = -ENODATA;
-			break;
-		}
+		if (data->have_vout)
+			return -ENODATA;
 		ret = pmbus_read_word_data(client, 0, ADM1075_READ_VAUX);
 		break;
 	case PMBUS_VIRT_READ_IOUT_MAX:
@@ -147,10 +141,8 @@ static int adm1275_read_word_data(struct i2c_client *client, int page, int reg)
 		ret = pmbus_read_word_data(client, 0, ADM1275_PEAK_VIN);
 		break;
 	case PMBUS_VIRT_READ_PIN_MAX:
-		if (data->id = adm1275) {
-			ret = -ENXIO;
-			break;
-		}
+		if (!data->have_pin_max)
+			return -ENXIO;
 		ret = pmbus_read_word_data(client, 0, ADM1276_PEAK_PIN);
 		break;
 	case PMBUS_VIRT_RESET_IOUT_HISTORY:
@@ -158,8 +150,8 @@ static int adm1275_read_word_data(struct i2c_client *client, int page, int reg)
 	case PMBUS_VIRT_RESET_VIN_HISTORY:
 		break;
 	case PMBUS_VIRT_RESET_PIN_HISTORY:
-		if (data->id = adm1275)
-			ret = -ENXIO;
+		if (!data->have_pin_max)
+			return -ENXIO;
 		break;
 	default:
 		ret = -ENODATA;
@@ -215,29 +207,31 @@ static int adm1275_read_byte_data(struct i2c_client *client, int page, int reg)
 		ret = pmbus_read_byte_data(client, page, PMBUS_STATUS_IOUT);
 		if (ret < 0)
 			break;
+		if (!data->have_oc_fault && !data->have_uc_fault)
+			break;
 		mfr_status = pmbus_read_byte_data(client, page,
 						  PMBUS_STATUS_MFR_SPECIFIC);
-		if (mfr_status < 0) {
-			ret = mfr_status;
-			break;
-		}
+		if (mfr_status < 0)
+			return mfr_status;
 		if (mfr_status & ADM1275_MFR_STATUS_IOUT_WARN2) {
 			ret |= data->have_oc_fault ?
 			  PB_IOUT_OC_FAULT : PB_IOUT_UC_FAULT;
 		}
 		break;
 	case PMBUS_STATUS_VOUT:
-		if (data->id != adm1075) {
-			ret = -ENODATA;
-			break;
-		}
+		if (data->have_vout)
+			return -ENODATA;
 		ret = 0;
-		mfr_status = pmbus_read_byte_data(client, 0,
-						  ADM1075_VAUX_STATUS);
-		if (mfr_status & ADM1075_VAUX_OV_WARN)
-			ret |= PB_VOLTAGE_OV_WARNING;
-		if (mfr_status & ADM1075_VAUX_UV_WARN)
-			ret |= PB_VOLTAGE_UV_WARNING;
+		if (data->have_vaux_status) {
+			mfr_status = pmbus_read_byte_data(client, 0,
+							  ADM1075_VAUX_STATUS);
+			if (mfr_status < 0)
+				return mfr_status;
+			if (mfr_status & ADM1075_VAUX_OV_WARN)
+				ret |= PB_VOLTAGE_OV_WARNING;
+			if (mfr_status & ADM1075_VAUX_UV_WARN)
+				ret |= PB_VOLTAGE_UV_WARNING;
+		}
 		break;
 	default:
 		ret = -ENODATA;
@@ -328,11 +322,15 @@ static int adm1275_probe(struct i2c_client *client,
 	info->read_byte_data = adm1275_read_byte_data;
 	info->write_word_data = adm1275_write_word_data;
 
-	if (device_config & ADM1275_IOUT_WARN2_SELECT)
-		data->have_oc_fault = true;
-
 	switch (data->id) {
 	case adm1075:
+		if (device_config & ADM1275_IOUT_WARN2_SELECT)
+			data->have_oc_fault = true;
+		else
+			data->have_uc_fault = true;
+		data->have_pin_max = true;
+		data->have_vaux_status = true;
+
 		coefficients = adm1075_coefficients;
 		vindex = 0;
 		switch (config & ADM1075_IRANGE_MASK) {
@@ -356,6 +354,12 @@ static int adm1275_probe(struct i2c_client *client,
 			  PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
 		break;
 	case adm1275:
+		if (device_config & ADM1275_IOUT_WARN2_SELECT)
+			data->have_oc_fault = true;
+		else
+			data->have_uc_fault = true;
+		data->have_vout = true;
+
 		coefficients = adm1275_coefficients;
 		vindex = (config & ADM1275_VRANGE) ? 0 : 1;
 		cindex = 2;
@@ -368,6 +372,13 @@ static int adm1275_probe(struct i2c_client *client,
 			  PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT;
 		break;
 	case adm1276:
+		if (device_config & ADM1275_IOUT_WARN2_SELECT)
+			data->have_oc_fault = true;
+		else
+			data->have_uc_fault = true;
+		data->have_vout = true;
+		data->have_pin_max = true;
+
 		coefficients = adm1276_coefficients;
 		vindex = (config & ADM1275_VRANGE) ? 0 : 1;
 		cindex = 2;
-- 
2.1.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
