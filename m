From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 05 Jul 2011 23:04:13 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (pmbus) Add support for VID output
Message-Id: <1309907054-4254-2-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

In VID mode, output voltages are measured and reported as VID values, and
have to be converted to voltages using VID conversion tables or functions.
Support is added for VR11 only at this time.

This patch enables support for PMBus devices supporting VID VR11 based output
voltage selection such as NCP4200 and NCP4208.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/adm1275.c    |    6 ++--
 drivers/hwmon/max16064.c   |    6 ++--
 drivers/hwmon/max34440.c   |   18 ++++++------
 drivers/hwmon/max8688.c    |    8 +++---
 drivers/hwmon/pmbus.c      |   34 ++++++++++++++++++++++--
 drivers/hwmon/pmbus.h      |    7 +++--
 drivers/hwmon/pmbus_core.c |   60 +++++++++++++++++++++++++++++++++++++------
 7 files changed, 105 insertions(+), 34 deletions(-)

diff --git a/drivers/hwmon/adm1275.c b/drivers/hwmon/adm1275.c
index b9b7caf..1a91d51 100644
--- a/drivers/hwmon/adm1275.c
+++ b/drivers/hwmon/adm1275.c
@@ -50,9 +50,9 @@ static int adm1275_probe(struct i2c_client *client,
 	}
 
 	info->pages = 1;
-	info->direct[PSC_VOLTAGE_IN] = true;
-	info->direct[PSC_VOLTAGE_OUT] = true;
-	info->direct[PSC_CURRENT_OUT] = true;
+	info->format[PSC_VOLTAGE_IN] = direct;
+	info->format[PSC_VOLTAGE_OUT] = direct;
+	info->format[PSC_CURRENT_OUT] = direct;
 	info->m[PSC_CURRENT_OUT] = 800;
 	info->b[PSC_CURRENT_OUT] = 20475;
 	info->R[PSC_CURRENT_OUT] = -1;
diff --git a/drivers/hwmon/max16064.c b/drivers/hwmon/max16064.c
index 1d6d717..78e20bc 100644
--- a/drivers/hwmon/max16064.c
+++ b/drivers/hwmon/max16064.c
@@ -27,9 +27,9 @@
 
 static struct pmbus_driver_info max16064_info = {
 	.pages = 4,
-	.direct[PSC_VOLTAGE_IN] = true,
-	.direct[PSC_VOLTAGE_OUT] = true,
-	.direct[PSC_TEMPERATURE] = true,
+	.format[PSC_VOLTAGE_IN] = direct,
+	.format[PSC_VOLTAGE_OUT] = direct,
+	.format[PSC_TEMPERATURE] = direct,
 	.m[PSC_VOLTAGE_IN] = 19995,
 	.b[PSC_VOLTAGE_IN] = 0,
 	.R[PSC_VOLTAGE_IN] = -1,
diff --git a/drivers/hwmon/max34440.c b/drivers/hwmon/max34440.c
index db11e1a..2e30046 100644
--- a/drivers/hwmon/max34440.c
+++ b/drivers/hwmon/max34440.c
@@ -72,10 +72,10 @@ static int max34440_read_byte_data(struct i2c_client *client, int page, int reg)
 static struct pmbus_driver_info max34440_info[] = {
 	[max34440] = {
 		.pages = 14,
-		.direct[PSC_VOLTAGE_IN] = true,
-		.direct[PSC_VOLTAGE_OUT] = true,
-		.direct[PSC_TEMPERATURE] = true,
-		.direct[PSC_CURRENT_OUT] = true,
+		.format[PSC_VOLTAGE_IN] = direct,
+		.format[PSC_VOLTAGE_OUT] = direct,
+		.format[PSC_TEMPERATURE] = direct,
+		.format[PSC_CURRENT_OUT] = direct,
 		.m[PSC_VOLTAGE_IN] = 1,
 		.b[PSC_VOLTAGE_IN] = 0,
 		.R[PSC_VOLTAGE_IN] = 3,	    /* R = 0 in datasheet reflects mV */
@@ -112,11 +112,11 @@ static struct pmbus_driver_info max34440_info[] = {
 	},
 	[max34441] = {
 		.pages = 12,
-		.direct[PSC_VOLTAGE_IN] = true,
-		.direct[PSC_VOLTAGE_OUT] = true,
-		.direct[PSC_TEMPERATURE] = true,
-		.direct[PSC_CURRENT_OUT] = true,
-		.direct[PSC_FAN] = true,
+		.format[PSC_VOLTAGE_IN] = direct,
+		.format[PSC_VOLTAGE_OUT] = direct,
+		.format[PSC_TEMPERATURE] = direct,
+		.format[PSC_CURRENT_OUT] = direct,
+		.format[PSC_FAN] = direct,
 		.m[PSC_VOLTAGE_IN] = 1,
 		.b[PSC_VOLTAGE_IN] = 0,
 		.R[PSC_VOLTAGE_IN] = 3,
diff --git a/drivers/hwmon/max8688.c b/drivers/hwmon/max8688.c
index 7fb93f4..ddc8a64 100644
--- a/drivers/hwmon/max8688.c
+++ b/drivers/hwmon/max8688.c
@@ -91,10 +91,10 @@ static int max8688_read_byte_data(struct i2c_client *client, int page, int reg)
 
 static struct pmbus_driver_info max8688_info = {
 	.pages = 1,
-	.direct[PSC_VOLTAGE_IN] = true,
-	.direct[PSC_VOLTAGE_OUT] = true,
-	.direct[PSC_TEMPERATURE] = true,
-	.direct[PSC_CURRENT_OUT] = true,
+	.format[PSC_VOLTAGE_IN] = direct,
+	.format[PSC_VOLTAGE_OUT] = direct,
+	.format[PSC_TEMPERATURE] = direct,
+	.format[PSC_CURRENT_OUT] = direct,
 	.m[PSC_VOLTAGE_IN] = 19995,
 	.b[PSC_VOLTAGE_IN] = 0,
 	.R[PSC_VOLTAGE_IN] = -1,
diff --git a/drivers/hwmon/pmbus.c b/drivers/hwmon/pmbus.c
index 9b1f0c3..4d8e31b 100644
--- a/drivers/hwmon/pmbus.c
+++ b/drivers/hwmon/pmbus.c
@@ -96,6 +96,8 @@ static void pmbus_find_sensor_groups(struct i2c_client *client,
 static int pmbus_identify(struct i2c_client *client,
 			  struct pmbus_driver_info *info)
 {
+	int ret = 0;
+
 	if (!info->pages) {
 		/*
 		 * Check if the PAGE command is supported. If it is,
@@ -117,6 +119,27 @@ static int pmbus_identify(struct i2c_client *client,
 		}
 	}
 
+	if (pmbus_check_byte_register(client, 0, PMBUS_VOUT_MODE)) {
+		int vout_mode;
+
+		vout_mode = pmbus_read_byte_data(client, 0, PMBUS_VOUT_MODE);
+		if (vout_mode >= 0 && vout_mode != 0xff) {
+			switch (vout_mode >> 5) {
+			case 0:
+				break;
+			case 1:
+				info->format[PSC_VOLTAGE_OUT] = vid;
+				break;
+			case 2:
+				info->format[PSC_VOLTAGE_OUT] = direct;
+				break;
+			default:
+				ret = -ENODEV;
+				goto abort;
+			}
+		}
+	}
+
 	/*
 	 * We should check if the COEFFICIENTS register is supported.
 	 * If it is, and the chip is configured for direct mode, we can read
@@ -125,13 +148,18 @@ static int pmbus_identify(struct i2c_client *client,
 	 *
 	 * To do this, we will need access to a chip which actually supports the
 	 * COEFFICIENTS command, since the command is too complex to implement
-	 * without testing it.
+	 * without testing it. Until then, abort if a chip configured for direct
+	 * mode was detected.
 	 */
+	if (info->format[PSC_VOLTAGE_OUT] = direct) {
+		ret = -ENODEV;
+		goto abort;
+	}
 
 	/* Try to find sensor groups  */
 	pmbus_find_sensor_groups(client, info);
-
-	return 0;
+abort:
+	return ret;
 }
 
 static int pmbus_probe(struct i2c_client *client,
diff --git a/drivers/hwmon/pmbus.h b/drivers/hwmon/pmbus.h
index 50647ab..cc5b6a2 100644
--- a/drivers/hwmon/pmbus.h
+++ b/drivers/hwmon/pmbus.h
@@ -266,11 +266,11 @@ enum pmbus_sensor_classes {
 #define PMBUS_HAVE_STATUS_FAN12	(1 << 16)
 #define PMBUS_HAVE_STATUS_FAN34	(1 << 17)
 
+enum pmbus_data_format { linear = 0, direct, vid };
+
 struct pmbus_driver_info {
 	int pages;		/* Total number of pages */
-	bool direct[PSC_NUM_CLASSES];
-				/* true if device uses direct data format
-				   for the given sensor class */
+	enum pmbus_data_format format[PSC_NUM_CLASSES];
 	/*
 	 * Support one set of coefficients for each sensor type
 	 * Used for chips providing data in direct mode.
@@ -299,6 +299,7 @@ struct pmbus_driver_info {
 
 int pmbus_set_page(struct i2c_client *client, u8 page);
 int pmbus_read_word_data(struct i2c_client *client, u8 page, u8 reg);
+int pmbus_read_byte_data(struct i2c_client *client, u8 page, u8 reg);
 void pmbus_clear_faults(struct i2c_client *client);
 bool pmbus_check_byte_register(struct i2c_client *client, int page, int reg);
 bool pmbus_check_word_register(struct i2c_client *client, int page, int reg);
diff --git a/drivers/hwmon/pmbus_core.c b/drivers/hwmon/pmbus_core.c
index 744672c..748f42a 100644
--- a/drivers/hwmon/pmbus_core.c
+++ b/drivers/hwmon/pmbus_core.c
@@ -197,7 +197,7 @@ int pmbus_read_word_data(struct i2c_client *client, u8 page, u8 reg)
 }
 EXPORT_SYMBOL_GPL(pmbus_read_word_data);
 
-static int pmbus_read_byte_data(struct i2c_client *client, u8 page, u8 reg)
+int pmbus_read_byte_data(struct i2c_client *client, u8 page, u8 reg)
 {
 	int rv;
 
@@ -207,6 +207,7 @@ static int pmbus_read_byte_data(struct i2c_client *client, u8 page, u8 reg)
 
 	return i2c_smbus_read_byte_data(client, reg);
 }
+EXPORT_SYMBOL_GPL(pmbus_read_byte_data);
 
 static void pmbus_clear_fault_page(struct i2c_client *client, int page)
 {
@@ -443,15 +444,37 @@ static int pmbus_reg2data_direct(struct pmbus_data *data,
 	return (int)((val - b) / m);
 }
 
+/*
+ * Convert VID sensor values to milli- or micro-units
+ * depending on sensor type.
+ * We currently only support VR11.
+ */
+static int pmbus_reg2data_vid(struct pmbus_data *data,
+			      struct pmbus_sensor *sensor)
+{
+	long val = sensor->data;
+
+	if (val < 0x02 || val > 0xb2)
+		return 0;
+	return DIV_ROUND_CLOSEST(160000 - (val - 2) * 625, 100);
+}
+
 static int pmbus_reg2data(struct pmbus_data *data, struct pmbus_sensor *sensor)
 {
 	int val;
 
-	if (data->info->direct[sensor->class])
+	switch (data->info->format[sensor->class]) {
+	case direct:
 		val = pmbus_reg2data_direct(data, sensor);
-	else
+		break;
+	case vid:
+		val = pmbus_reg2data_vid(data, sensor);
+		break;
+	case linear:
+	default:
 		val = pmbus_reg2data_linear(data, sensor);
-
+		break;
+	}
 	return val;
 }
 
@@ -561,16 +584,31 @@ static u16 pmbus_data2reg_direct(struct pmbus_data *data,
 	return val;
 }
 
+static u16 pmbus_data2reg_vid(struct pmbus_data *data,
+			      enum pmbus_sensor_classes class, long val)
+{
+	val = SENSORS_LIMIT(val, 500, 1600);
+
+	return 2 + DIV_ROUND_CLOSEST((1600 - val) * 100, 625);
+}
+
 static u16 pmbus_data2reg(struct pmbus_data *data,
 			  enum pmbus_sensor_classes class, long val)
 {
 	u16 regval;
 
-	if (data->info->direct[class])
+	switch (data->info->format[class]) {
+	case direct:
 		regval = pmbus_data2reg_direct(data, class, val);
-	else
+		break;
+	case vid:
+		regval = pmbus_data2reg_vid(data, class, val);
+		break;
+	case linear:
+	default:
 		regval = pmbus_data2reg_linear(data, class, val);
-
+		break;
+	}
 	return regval;
 }
 
@@ -1380,7 +1418,7 @@ static int pmbus_identify_common(struct i2c_client *client,
 		 */
 		switch (vout_mode >> 5) {
 		case 0:	/* linear mode      */
-			if (data->info->direct[PSC_VOLTAGE_OUT])
+			if (data->info->format[PSC_VOLTAGE_OUT] != linear)
 				return -ENODEV;
 
 			exponent = vout_mode & 0x1f;
@@ -1389,8 +1427,12 @@ static int pmbus_identify_common(struct i2c_client *client,
 				exponent |= ~0x1f;
 			data->exponent = exponent;
 			break;
+		case 1: /* VID mode         */
+			if (data->info->format[PSC_VOLTAGE_OUT] != vid)
+				return -ENODEV;
+			break;
 		case 2:	/* direct mode      */
-			if (!data->info->direct[PSC_VOLTAGE_OUT])
+			if (data->info->format[PSC_VOLTAGE_OUT] != direct)
 				return -ENODEV;
 			break;
 		default:
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
