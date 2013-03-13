From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 13 Mar 2013 23:58:41 +0000
Subject: [lm-sensors] [PATCH 3/4] hwmon: (pmbus/lm25066) Refactor device specific coefficients
Message-Id: <1363219122-27226-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Initialize device specific coefficients from table instead of hard-coding it
to simplify adding additional chips.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pmbus/lm25066.c |  196 +++++++++++++++++++++++++----------------
 1 file changed, 118 insertions(+), 78 deletions(-)

diff --git a/drivers/hwmon/pmbus/lm25066.c b/drivers/hwmon/pmbus/lm25066.c
index f9f0c93..0826714 100644
--- a/drivers/hwmon/pmbus/lm25066.c
+++ b/drivers/hwmon/pmbus/lm25066.c
@@ -44,6 +44,103 @@ enum chips { lm25066, lm5064, lm5066 };
 
 #define LM25066_DEV_SETUP_CL		(1 << 4)	/* Current limit */
 
+struct __coeff {
+	short m, b, R;
+};
+
+#define PSC_CURRENT_IN_L	(PSC_NUM_CLASSES)
+#define PSC_POWER_L		(PSC_NUM_CLASSES + 1)
+
+static struct __coeff lm25066_coeff[3][PSC_NUM_CLASSES + 2] = {
+	[lm25066] = {
+		[PSC_VOLTAGE_IN] = {
+			.m = 22070,
+			.R = -2,
+		},
+		[PSC_VOLTAGE_OUT] = {
+			.m = 22070,
+			.R = -2,
+		},
+		[PSC_CURRENT_IN] = {
+			.m = 13661,
+			.R = -2,
+		},
+		[PSC_CURRENT_IN_L] = {
+			.m = 6852,
+			.R = -2,
+		},
+		[PSC_POWER] = {
+			.m = 736,
+			.R = -2,
+		},
+		[PSC_POWER_L] = {
+			.m = 369,
+			.R = -2,
+		},
+		[PSC_TEMPERATURE] = {
+			.m = 16,
+		},
+	},
+	[lm5064] = {
+		[PSC_VOLTAGE_IN] = {
+			.m = 4611,
+			.R = -2,
+		},
+		[PSC_VOLTAGE_OUT] = {
+			.m = 4621,
+			.R = -2,
+		},
+		[PSC_CURRENT_IN] = {
+			.m = 10742,
+			.R = -2,
+		},
+		[PSC_CURRENT_IN_L] = {
+			.m = 5456,
+			.R = -2,
+		},
+		[PSC_POWER] = {
+			.m = 1204,
+			.R = -3,
+		},
+		[PSC_POWER_L] = {
+			.m = 612,
+			.R = -3,
+		},
+		[PSC_TEMPERATURE] = {
+			.m = 16,
+		},
+	},
+	[lm5066] = {
+		[PSC_VOLTAGE_IN] = {
+			.m = 4587,
+			.R = -2,
+		},
+		[PSC_VOLTAGE_OUT] = {
+			.m = 4587,
+			.R = -2,
+		},
+		[PSC_CURRENT_IN] = {
+			.m = 10753,
+			.R = -2,
+		},
+		[PSC_CURRENT_IN_L] = {
+			.m = 5405,
+			.R = -2,
+		},
+		[PSC_POWER] = {
+			.m = 1204,
+			.R = -3,
+		},
+		[PSC_POWER_L] = {
+			.m = 605,
+			.R = -3,
+		},
+		[PSC_TEMPERATURE] = {
+			.m = 16,
+		},
+	},
+};
+
 struct lm25066_data {
 	int id;
 	struct pmbus_driver_info info;
@@ -162,6 +259,7 @@ static int lm25066_probe(struct i2c_client *client,
 	int config;
 	struct lm25066_data *data;
 	struct pmbus_driver_info *info;
+	struct __coeff *coeff;
 
 	if (!i2c_check_functionality(client->adapter,
 				     I2C_FUNC_SMBUS_READ_BYTE_DATA))
@@ -186,9 +284,6 @@ static int lm25066_probe(struct i2c_client *client,
 	info->format[PSC_TEMPERATURE] = direct;
 	info->format[PSC_POWER] = direct;
 
-	info->m[PSC_TEMPERATURE] = 16;
-	info->b[PSC_TEMPERATURE] = 0;
-	info->R[PSC_TEMPERATURE] = 0;
 
 	info->func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_VMON | PMBUS_HAVE_VOUT
 	  | PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_PIN | PMBUS_HAVE_IIN
@@ -197,81 +292,26 @@ static int lm25066_probe(struct i2c_client *client,
 	info->read_word_data = lm25066_read_word_data;
 	info->write_word_data = lm25066_write_word_data;
 
-	switch (id->driver_data) {
-	case lm25066:
-		info->m[PSC_VOLTAGE_IN] = 22070;
-		info->b[PSC_VOLTAGE_IN] = 0;
-		info->R[PSC_VOLTAGE_IN] = -2;
-		info->m[PSC_VOLTAGE_OUT] = 22070;
-		info->b[PSC_VOLTAGE_OUT] = 0;
-		info->R[PSC_VOLTAGE_OUT] = -2;
-
-		if (config & LM25066_DEV_SETUP_CL) {
-			info->m[PSC_CURRENT_IN] = 6852;
-			info->b[PSC_CURRENT_IN] = 0;
-			info->R[PSC_CURRENT_IN] = -2;
-			info->m[PSC_POWER] = 369;
-			info->b[PSC_POWER] = 0;
-			info->R[PSC_POWER] = -2;
-		} else {
-			info->m[PSC_CURRENT_IN] = 13661;
-			info->b[PSC_CURRENT_IN] = 0;
-			info->R[PSC_CURRENT_IN] = -2;
-			info->m[PSC_POWER] = 736;
-			info->b[PSC_POWER] = 0;
-			info->R[PSC_POWER] = -2;
-		}
-		break;
-	case lm5064:
-		info->m[PSC_VOLTAGE_IN] = 22075;
-		info->b[PSC_VOLTAGE_IN] = 0;
-		info->R[PSC_VOLTAGE_IN] = -2;
-		info->m[PSC_VOLTAGE_OUT] = 22075;
-		info->b[PSC_VOLTAGE_OUT] = 0;
-		info->R[PSC_VOLTAGE_OUT] = -2;
-
-		if (config & LM25066_DEV_SETUP_CL) {
-			info->m[PSC_CURRENT_IN] = 6713;
-			info->b[PSC_CURRENT_IN] = 0;
-			info->R[PSC_CURRENT_IN] = -2;
-			info->m[PSC_POWER] = 3619;
-			info->b[PSC_POWER] = 0;
-			info->R[PSC_POWER] = -3;
-		} else {
-			info->m[PSC_CURRENT_IN] = 13426;
-			info->b[PSC_CURRENT_IN] = 0;
-			info->R[PSC_CURRENT_IN] = -2;
-			info->m[PSC_POWER] = 7238;
-			info->b[PSC_POWER] = 0;
-			info->R[PSC_POWER] = -3;
-		}
-		break;
-	case lm5066:
-		info->m[PSC_VOLTAGE_IN] = 4587;
-		info->b[PSC_VOLTAGE_IN] = 0;
-		info->R[PSC_VOLTAGE_IN] = -2;
-		info->m[PSC_VOLTAGE_OUT] = 4587;
-		info->b[PSC_VOLTAGE_OUT] = 0;
-		info->R[PSC_VOLTAGE_OUT] = -2;
-
-		if (config & LM25066_DEV_SETUP_CL) {
-			info->m[PSC_CURRENT_IN] = 10753;
-			info->b[PSC_CURRENT_IN] = 0;
-			info->R[PSC_CURRENT_IN] = -2;
-			info->m[PSC_POWER] = 1204;
-			info->b[PSC_POWER] = 0;
-			info->R[PSC_POWER] = -3;
-		} else {
-			info->m[PSC_CURRENT_IN] = 5405;
-			info->b[PSC_CURRENT_IN] = 0;
-			info->R[PSC_CURRENT_IN] = -2;
-			info->m[PSC_POWER] = 605;
-			info->b[PSC_POWER] = 0;
-			info->R[PSC_POWER] = -3;
-		}
-		break;
-	default:
-		return -ENODEV;
+	coeff = &lm25066_coeff[data->id][0];
+	info->m[PSC_TEMPERATURE] = coeff[PSC_TEMPERATURE].m;
+	info->b[PSC_TEMPERATURE] = coeff[PSC_TEMPERATURE].b;
+	info->R[PSC_TEMPERATURE] = coeff[PSC_TEMPERATURE].R;
+	info->m[PSC_VOLTAGE_IN] = coeff[PSC_VOLTAGE_IN].m;
+	info->b[PSC_VOLTAGE_IN] = coeff[PSC_VOLTAGE_IN].b;
+	info->R[PSC_VOLTAGE_IN] = coeff[PSC_VOLTAGE_IN].R;
+	info->m[PSC_VOLTAGE_OUT] = coeff[PSC_VOLTAGE_OUT].m;
+	info->b[PSC_VOLTAGE_OUT] = coeff[PSC_VOLTAGE_OUT].b;
+	info->R[PSC_VOLTAGE_OUT] = coeff[PSC_VOLTAGE_OUT].R;
+	info->b[PSC_CURRENT_IN] = coeff[PSC_CURRENT_IN].b;
+	info->R[PSC_CURRENT_IN] = coeff[PSC_CURRENT_IN].R;
+	info->b[PSC_POWER] = coeff[PSC_POWER].b;
+	info->R[PSC_POWER] = coeff[PSC_POWER].R;
+	if (config & LM25066_DEV_SETUP_CL) {
+		info->m[PSC_CURRENT_IN] = coeff[PSC_CURRENT_IN_L].m;
+		info->m[PSC_POWER] = coeff[PSC_POWER_L].m;
+	} else {
+		info->m[PSC_CURRENT_IN] = coeff[PSC_CURRENT_IN].m;
+		info->m[PSC_POWER] = coeff[PSC_POWER].m;
 	}
 
 	return pmbus_do_probe(client, id, info);
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
