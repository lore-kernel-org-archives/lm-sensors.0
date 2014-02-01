From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 01 Feb 2014 19:27:19 +0000
Subject: [lm-sensors] [PATCH] hwmon: (pmbus) Support per-page exponent in linear mode
Message-Id: <1391282839-3982-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Some chips use different exponents for sensors on different pages
or rails. Detect and store exponent per page to support this situation.

This fixes a problem with wrong voltages seen on UCD90120.

Reported-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
Tested-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Tested with LTC2978, LTC3880, ZL9101, MAX34441, MAX34446, TPS40400, TPS40422.

This will be a candidate for -stable, but only after some rest time in Linus'
tree.

 drivers/hwmon/pmbus/pmbus_core.c |   68 ++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 32 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 3cbf66e..291d11f 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -90,7 +90,8 @@ struct pmbus_data {
 
 	u32 flags;		/* from platform data */
 
-	int exponent;		/* linear mode: exponent for output voltages */
+	int exponent[PMBUS_PAGES];
+				/* linear mode: exponent for output voltages */
 
 	const struct pmbus_driver_info *info;
 
@@ -410,7 +411,7 @@ static long pmbus_reg2data_linear(struct pmbus_data *data,
 	long val;
 
 	if (sensor->class = PSC_VOLTAGE_OUT) {	/* LINEAR16 */
-		exponent = data->exponent;
+		exponent = data->exponent[sensor->page];
 		mantissa = (u16) sensor->data;
 	} else {				/* LINEAR11 */
 		exponent = ((s16)sensor->data) >> 11;
@@ -516,7 +517,7 @@ static long pmbus_reg2data(struct pmbus_data *data, struct pmbus_sensor *sensor)
 #define MIN_MANTISSA	(511 * 1000)
 
 static u16 pmbus_data2reg_linear(struct pmbus_data *data,
-				 enum pmbus_sensor_classes class, long val)
+				 struct pmbus_sensor *sensor, long val)
 {
 	s16 exponent = 0, mantissa;
 	bool negative = false;
@@ -525,7 +526,7 @@ static u16 pmbus_data2reg_linear(struct pmbus_data *data,
 	if (val = 0)
 		return 0;
 
-	if (class = PSC_VOLTAGE_OUT) {
+	if (sensor->class = PSC_VOLTAGE_OUT) {
 		/* LINEAR16 does not support negative voltages */
 		if (val < 0)
 			return 0;
@@ -534,10 +535,10 @@ static u16 pmbus_data2reg_linear(struct pmbus_data *data,
 		 * For a static exponents, we don't have a choice
 		 * but to adjust the value to it.
 		 */
-		if (data->exponent < 0)
-			val <<= -data->exponent;
+		if (data->exponent[sensor->page] < 0)
+			val <<= -data->exponent[sensor->page];
 		else
-			val >>= data->exponent;
+			val >>= data->exponent[sensor->page];
 		val = DIV_ROUND_CLOSEST(val, 1000);
 		return val & 0xffff;
 	}
@@ -548,14 +549,14 @@ static u16 pmbus_data2reg_linear(struct pmbus_data *data,
 	}
 
 	/* Power is in uW. Convert to mW before converting. */
-	if (class = PSC_POWER)
+	if (sensor->class = PSC_POWER)
 		val = DIV_ROUND_CLOSEST(val, 1000L);
 
 	/*
 	 * For simplicity, convert fan data to milli-units
 	 * before calculating the exponent.
 	 */
-	if (class = PSC_FAN)
+	if (sensor->class = PSC_FAN)
 		val = val * 1000;
 
 	/* Reduce large mantissa until it fits into 10 bit */
@@ -585,22 +586,22 @@ static u16 pmbus_data2reg_linear(struct pmbus_data *data,
 }
 
 static u16 pmbus_data2reg_direct(struct pmbus_data *data,
-				 enum pmbus_sensor_classes class, long val)
+				 struct pmbus_sensor *sensor, long val)
 {
 	long m, b, R;
 
-	m = data->info->m[class];
-	b = data->info->b[class];
-	R = data->info->R[class];
+	m = data->info->m[sensor->class];
+	b = data->info->b[sensor->class];
+	R = data->info->R[sensor->class];
 
 	/* Power is in uW. Adjust R and b. */
-	if (class = PSC_POWER) {
+	if (sensor->class = PSC_POWER) {
 		R -= 3;
 		b *= 1000;
 	}
 
 	/* Calculate Y = (m * X + b) * 10^R */
-	if (class != PSC_FAN) {
+	if (sensor->class != PSC_FAN) {
 		R -= 3;		/* Adjust R and b for data in milli-units */
 		b *= 1000;
 	}
@@ -619,7 +620,7 @@ static u16 pmbus_data2reg_direct(struct pmbus_data *data,
 }
 
 static u16 pmbus_data2reg_vid(struct pmbus_data *data,
-			      enum pmbus_sensor_classes class, long val)
+			      struct pmbus_sensor *sensor, long val)
 {
 	val = clamp_val(val, 500, 1600);
 
@@ -627,20 +628,20 @@ static u16 pmbus_data2reg_vid(struct pmbus_data *data,
 }
 
 static u16 pmbus_data2reg(struct pmbus_data *data,
-			  enum pmbus_sensor_classes class, long val)
+			  struct pmbus_sensor *sensor, long val)
 {
 	u16 regval;
 
-	switch (data->info->format[class]) {
+	switch (data->info->format[sensor->class]) {
 	case direct:
-		regval = pmbus_data2reg_direct(data, class, val);
+		regval = pmbus_data2reg_direct(data, sensor, val);
 		break;
 	case vid:
-		regval = pmbus_data2reg_vid(data, class, val);
+		regval = pmbus_data2reg_vid(data, sensor, val);
 		break;
 	case linear:
 	default:
-		regval = pmbus_data2reg_linear(data, class, val);
+		regval = pmbus_data2reg_linear(data, sensor, val);
 		break;
 	}
 	return regval;
@@ -746,7 +747,7 @@ static ssize_t pmbus_set_sensor(struct device *dev,
 		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
-	regval = pmbus_data2reg(data, sensor->class, val);
+	regval = pmbus_data2reg(data, sensor, val);
 	ret = _pmbus_write_word_data(client, sensor->page, sensor->reg, regval);
 	if (ret < 0)
 		rv = ret;
@@ -1643,12 +1644,13 @@ static int pmbus_find_attributes(struct i2c_client *client,
  * This function is called for all chips.
  */
 static int pmbus_identify_common(struct i2c_client *client,
-				 struct pmbus_data *data)
+				 struct pmbus_data *data, int page)
 {
 	int vout_mode = -1;
 
-	if (pmbus_check_byte_register(client, 0, PMBUS_VOUT_MODE))
-		vout_mode = _pmbus_read_byte_data(client, 0, PMBUS_VOUT_MODE);
+	if (pmbus_check_byte_register(client, page, PMBUS_VOUT_MODE))
+		vout_mode = _pmbus_read_byte_data(client, page,
+						  PMBUS_VOUT_MODE);
 	if (vout_mode >= 0 && vout_mode != 0xff) {
 		/*
 		 * Not all chips support the VOUT_MODE command,
@@ -1659,7 +1661,7 @@ static int pmbus_identify_common(struct i2c_client *client,
 			if (data->info->format[PSC_VOLTAGE_OUT] != linear)
 				return -ENODEV;
 
-			data->exponent = ((s8)(vout_mode << 3)) >> 3;
+			data->exponent[page] = ((s8)(vout_mode << 3)) >> 3;
 			break;
 		case 1: /* VID mode         */
 			if (data->info->format[PSC_VOLTAGE_OUT] != vid)
@@ -1674,7 +1676,7 @@ static int pmbus_identify_common(struct i2c_client *client,
 		}
 	}
 
-	pmbus_clear_fault_page(client, 0);
+	pmbus_clear_fault_page(client, page);
 	return 0;
 }
 
@@ -1682,7 +1684,7 @@ static int pmbus_init_common(struct i2c_client *client, struct pmbus_data *data,
 			     struct pmbus_driver_info *info)
 {
 	struct device *dev = &client->dev;
-	int ret;
+	int page, ret;
 
 	/*
 	 * Some PMBus chips don't support PMBUS_STATUS_BYTE, so try
@@ -1715,10 +1717,12 @@ static int pmbus_init_common(struct i2c_client *client, struct pmbus_data *data,
 		return -ENODEV;
 	}
 
-	ret = pmbus_identify_common(client, data);
-	if (ret < 0) {
-		dev_err(dev, "Failed to identify chip capabilities\n");
-		return ret;
+	for (page = 0; page < info->pages; page++) {
+		ret = pmbus_identify_common(client, data, page);
+		if (ret < 0) {
+			dev_err(dev, "Failed to identify chip capabilities\n");
+			return ret;
+		}
 	}
 	return 0;
 }
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
