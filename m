From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 06 Jul 2015 15:54:21 +0000
Subject: [lm-sensors] [PATCH 2/5] hwmon: (adm1275) Introduce configuration data structure for coeffcients
Message-Id: <1436198064-23678-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Each new chip supported by the driver has a new set of coefficients,
making hard-coding coefficients more and more cumbersome. Introduce
a datastructure and table to simplify configuration.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pmbus/adm1275.c | 110 +++++++++++++++++++++++++-----------------
 1 file changed, 65 insertions(+), 45 deletions(-)

diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
index d34ba4f10c30..468d39289575 100644
--- a/drivers/hwmon/pmbus/adm1275.c
+++ b/drivers/hwmon/pmbus/adm1275.c
@@ -62,6 +62,34 @@ struct adm1275_data {
 
 #define to_adm1275_data(x)  container_of(x, struct adm1275_data, info)
 
+struct coefficients {
+	s16 m;
+	s16 b;
+	s16 R;
+};
+
+static const struct coefficients adm1075_coefficients[] = {
+	[0] = { 27169, 0, -1 },		/* voltage */
+	[1] = { 806, 20475, -1 },	/* current, irange25 */
+	[2] = { 404, 20475, -1 },	/* current, irange50 */
+	[3] = { 0, -1, 8549 },		/* power, irange25 */
+	[4] = { 0, -1, 4279 },		/* power, irange50 */
+};
+
+static const struct coefficients adm1275_coefficients[] = {
+	[0] = { 19199, 0, -2 },		/* voltage, vrange set */
+	[1] = { 6720, 0, -1 },		/* voltage, vrange not set */
+	[2] = { 807, 20475, -1 },	/* current */
+};
+
+static const struct coefficients adm1276_coefficients[] = {
+	[0] = { 19199, 0, -2 },		/* voltage, vrange set */
+	[1] = { 6720, 0, -1 },		/* voltage, vrange not set */
+	[2] = { 807, 20475, -1 },	/* current */
+	[3] = { 6043, 0, -2 },		/* power, vrange set */
+	[4] = { 2115, 0, -1 },		/* power, vrange not set */
+};
+
 static int adm1275_read_word_data(struct i2c_client *client, int page, int reg)
 {
 	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
@@ -235,6 +263,8 @@ static int adm1275_probe(struct i2c_client *client,
 	struct pmbus_driver_info *info;
 	struct adm1275_data *data;
 	const struct i2c_device_id *mid;
+	const struct coefficients *coefficients;
+	int vindex = -1, cindex = -1, pindex = -1;
 
 	if (!i2c_check_functionality(client->adapter,
 				     I2C_FUNC_SMBUS_READ_BYTE_DATA
@@ -291,61 +321,34 @@ static int adm1275_probe(struct i2c_client *client,
 	info->format[PSC_VOLTAGE_IN] = direct;
 	info->format[PSC_VOLTAGE_OUT] = direct;
 	info->format[PSC_CURRENT_OUT] = direct;
-	info->m[PSC_CURRENT_OUT] = 807;
-	info->b[PSC_CURRENT_OUT] = 20475;
-	info->R[PSC_CURRENT_OUT] = -1;
+	info->format[PSC_POWER] = direct;
 	info->func[0] = PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT;
 
 	info->read_word_data = adm1275_read_word_data;
 	info->read_byte_data = adm1275_read_byte_data;
 	info->write_word_data = adm1275_write_word_data;
 
-	if (data->id = adm1075) {
-		info->m[PSC_VOLTAGE_IN] = 27169;
-		info->b[PSC_VOLTAGE_IN] = 0;
-		info->R[PSC_VOLTAGE_IN] = -1;
-		info->m[PSC_VOLTAGE_OUT] = 27169;
-		info->b[PSC_VOLTAGE_OUT] = 0;
-		info->R[PSC_VOLTAGE_OUT] = -1;
-	} else if (config & ADM1275_VRANGE) {
-		info->m[PSC_VOLTAGE_IN] = 19199;
-		info->b[PSC_VOLTAGE_IN] = 0;
-		info->R[PSC_VOLTAGE_IN] = -2;
-		info->m[PSC_VOLTAGE_OUT] = 19199;
-		info->b[PSC_VOLTAGE_OUT] = 0;
-		info->R[PSC_VOLTAGE_OUT] = -2;
-	} else {
-		info->m[PSC_VOLTAGE_IN] = 6720;
-		info->b[PSC_VOLTAGE_IN] = 0;
-		info->R[PSC_VOLTAGE_IN] = -1;
-		info->m[PSC_VOLTAGE_OUT] = 6720;
-		info->b[PSC_VOLTAGE_OUT] = 0;
-		info->R[PSC_VOLTAGE_OUT] = -1;
-	}
-
 	if (device_config & ADM1275_IOUT_WARN2_SELECT)
 		data->have_oc_fault = true;
 
 	switch (data->id) {
 	case adm1075:
-		info->format[PSC_POWER] = direct;
-		info->b[PSC_POWER] = 0;
-		info->R[PSC_POWER] = -1;
+		coefficients = adm1075_coefficients;
+		vindex = 0;
 		switch (config & ADM1075_IRANGE_MASK) {
 		case ADM1075_IRANGE_25:
-			info->m[PSC_POWER] = 8549;
-			info->m[PSC_CURRENT_OUT] = 806;
+			cindex = 1;
+			pindex = 3;
 			break;
 		case ADM1075_IRANGE_50:
-			info->m[PSC_POWER] = 4279;
-			info->m[PSC_CURRENT_OUT] = 404;
+			cindex = 2;
+			pindex = 4;
 			break;
 		default:
 			dev_err(&client->dev, "Invalid input current range");
-			info->m[PSC_POWER] = 0;
-			info->m[PSC_CURRENT_OUT] = 0;
 			break;
 		}
+
 		info->func[0] |= PMBUS_HAVE_VIN | PMBUS_HAVE_PIN
 		  | PMBUS_HAVE_STATUS_INPUT;
 		if (config & ADM1275_VIN_VOUT_SELECT)
@@ -353,6 +356,10 @@ static int adm1275_probe(struct i2c_client *client,
 			  PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
 		break;
 	case adm1275:
+		coefficients = adm1275_coefficients;
+		vindex = (config & ADM1275_VRANGE) ? 0 : 1;
+		cindex = 2;
+
 		if (config & ADM1275_VIN_VOUT_SELECT)
 			info->func[0] | 			  PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
@@ -361,23 +368,36 @@ static int adm1275_probe(struct i2c_client *client,
 			  PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT;
 		break;
 	case adm1276:
-		info->format[PSC_POWER] = direct;
+		coefficients = adm1276_coefficients;
+		vindex = (config & ADM1275_VRANGE) ? 0 : 1;
+		cindex = 2;
+		pindex = (config & ADM1275_VRANGE) ? 3 : 4;
+
 		info->func[0] |= PMBUS_HAVE_VIN | PMBUS_HAVE_PIN
 		  | PMBUS_HAVE_STATUS_INPUT;
 		if (config & ADM1275_VIN_VOUT_SELECT)
 			info->func[0] | 			  PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
-		if (config & ADM1275_VRANGE) {
-			info->m[PSC_POWER] = 6043;
-			info->b[PSC_POWER] = 0;
-			info->R[PSC_POWER] = -2;
-		} else {
-			info->m[PSC_POWER] = 2115;
-			info->b[PSC_POWER] = 0;
-			info->R[PSC_POWER] = -1;
-		}
 		break;
 	}
+	if (vindex >= 0) {
+		info->m[PSC_VOLTAGE_IN] = coefficients[vindex].m;
+		info->b[PSC_VOLTAGE_IN] = coefficients[vindex].b;
+		info->R[PSC_VOLTAGE_IN] = coefficients[vindex].R;
+		info->m[PSC_VOLTAGE_OUT] = coefficients[vindex].m;
+		info->b[PSC_VOLTAGE_OUT] = coefficients[vindex].b;
+		info->R[PSC_VOLTAGE_OUT] = coefficients[vindex].R;
+	}
+	if (cindex >= 0) {
+		info->m[PSC_CURRENT_OUT] = coefficients[cindex].m;
+		info->b[PSC_CURRENT_OUT] = coefficients[cindex].b;
+		info->R[PSC_CURRENT_OUT] = coefficients[cindex].R;
+	}
+	if (pindex >= 0) {
+		info->m[PSC_POWER] = coefficients[pindex].m;
+		info->b[PSC_POWER] = coefficients[pindex].b;
+		info->R[PSC_POWER] = coefficients[pindex].R;
+	}
 
 	return pmbus_do_probe(client, id, info);
 }
-- 
2.1.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
