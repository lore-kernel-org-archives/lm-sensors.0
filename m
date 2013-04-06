From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 06 Apr 2013 01:02:55 +0000
Subject: [lm-sensors] [PATCH 3/5] hwmon: (tmp401) Simplification and cleanup
Message-Id: <1365210177-24656-4-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use two-dimensional array pointing to registers
Merge temperature and limit access function into a single function
Return eror codes from I2C accesses
Use DIV_ROUND_CLOSEST for rounding operations

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/tmp401.c |  369 ++++++++++++++++++------------------------------
 1 file changed, 137 insertions(+), 232 deletions(-)

diff --git a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
index f07fc40..c0cf87d 100644
--- a/drivers/hwmon/tmp401.c
+++ b/drivers/hwmon/tmp401.c
@@ -57,21 +57,32 @@ enum chips { tmp401, tmp411, tmp431 };
 #define TMP401_MANUFACTURER_ID_REG		0xFE
 #define TMP401_DEVICE_ID_REG			0xFF
 
-static const u8 TMP401_TEMP_MSB[2]			= { 0x00, 0x01 };
-static const u8 TMP401_TEMP_LSB[2]			= { 0x15, 0x10 };
-static const u8 TMP401_TEMP_LOW_LIMIT_MSB_READ[2]	= { 0x06, 0x08 };
-static const u8 TMP401_TEMP_LOW_LIMIT_MSB_WRITE[2]	= { 0x0C, 0x0E };
-static const u8 TMP401_TEMP_LOW_LIMIT_LSB[2]		= { 0x17, 0x14 };
-static const u8 TMP401_TEMP_HIGH_LIMIT_MSB_READ[2]	= { 0x05, 0x07 };
-static const u8 TMP401_TEMP_HIGH_LIMIT_MSB_WRITE[2]	= { 0x0B, 0x0D };
-static const u8 TMP401_TEMP_HIGH_LIMIT_LSB[2]		= { 0x16, 0x13 };
-/* These are called the THERM limit / hysteresis / mask in the datasheet */
-static const u8 TMP401_TEMP_CRIT_LIMIT[2]		= { 0x20, 0x19 };
-
-static const u8 TMP411_TEMP_LOWEST_MSB[2]		= { 0x30, 0x34 };
-static const u8 TMP411_TEMP_LOWEST_LSB[2]		= { 0x31, 0x35 };
-static const u8 TMP411_TEMP_HIGHEST_MSB[2]		= { 0x32, 0x36 };
-static const u8 TMP411_TEMP_HIGHEST_LSB[2]		= { 0x33, 0x37 };
+static const u8 TMP401_TEMP_MSB_READ[6][2] = {
+	{ 0x00, 0x01 },	/* temp */
+	{ 0x06, 0x08 },	/* low limit */
+	{ 0x05, 0x07 },	/* high limit */
+	{ 0x20, 0x19 },	/* therm (crit) limit */
+	{ 0x30, 0x34 },	/* lowest */
+	{ 0x32, 0x36 },	/* highest */
+};
+
+static const u8 TMP401_TEMP_MSB_WRITE[6][2] = {
+	{ 0x00, 0x00 },	/* temp  (unused) */
+	{ 0x0C, 0x0E },	/* low limit */
+	{ 0x0B, 0x0D },	/* high limit */
+	{ 0x20, 0x19 },	/* therm (crit) limit */
+	{ 0x30, 0x34 },	/* lowest */
+	{ 0x32, 0x36 },	/* highest */
+};
+
+static const u8 TMP401_TEMP_LSB[6][2] = {
+	{ 0x15, 0x10 },	/* temp */
+	{ 0x17, 0x14 },	/* low limit */
+	{ 0x16, 0x13 },	/* high limit */
+	{ 0x00, 0x00 },	/* therm (crit) limit (unused) */
+	{ 0x31, 0x35 },	/* lowest */
+	{ 0x33, 0x37 },	/* highest */
+};
 
 /* Flags */
 #define TMP401_CONFIG_RANGE			BIT(2)
@@ -118,13 +129,8 @@ struct tmp401_data {
 	/* register values */
 	u8 status;
 	u8 config;
-	u16 temp[2];
-	u16 temp_low[2];
-	u16 temp_high[2];
-	u8 temp_crit[2];
+	u16 temp[6][2];
 	u8 temp_crit_hyst;
-	u16 temp_lowest[2];
-	u16 temp_highest[2];
 };
 
 /*
@@ -138,7 +144,7 @@ static int tmp401_register_to_temp(u16 reg, u8 config)
 	if (config & TMP401_CONFIG_RANGE)
 		temp -= 64 * 256;
 
-	return (temp * 625 + 80) / 160;
+	return DIV_ROUND_CLOSEST(temp * 125, 32);
 }
 
 static u16 tmp401_temp_to_register(long temp, u8 config)
@@ -149,134 +155,93 @@ static u16 tmp401_temp_to_register(long temp, u8 config)
 	} else
 		temp = clamp_val(temp, 0, 127000);
 
-	return (temp * 160 + 312) / 625;
-}
-
-static int tmp401_crit_register_to_temp(u8 reg, u8 config)
-{
-	int temp = reg;
-
-	if (config & TMP401_CONFIG_RANGE)
-		temp -= 64;
-
-	return temp * 1000;
+	return DIV_ROUND_CLOSEST(temp * 32, 125);
 }
 
-static u8 tmp401_crit_temp_to_register(long temp, u8 config)
+static int tmp401_update_device_reg16(struct i2c_client *client,
+				      struct tmp401_data *data)
 {
-	if (config & TMP401_CONFIG_RANGE) {
-		temp = clamp_val(temp, -64000, 191000);
-		temp += 64000;
-	} else
-		temp = clamp_val(temp, 0, 127000);
-
-	return (temp + 500) / 1000;
-}
-
-static struct tmp401_data *tmp401_update_device_reg16(
-	struct i2c_client *client, struct tmp401_data *data)
-{
-	int i;
-
-	for (i = 0; i < 2; i++) {
-		/*
-		 * High byte must be read first immediately followed
-		 * by the low byte
-		 */
-		data->temp[i] = i2c_smbus_read_byte_data(client,
-			TMP401_TEMP_MSB[i]) << 8;
-		data->temp[i] |= i2c_smbus_read_byte_data(client,
-			TMP401_TEMP_LSB[i]);
-		data->temp_low[i] = i2c_smbus_read_byte_data(client,
-			TMP401_TEMP_LOW_LIMIT_MSB_READ[i]) << 8;
-		data->temp_low[i] |= i2c_smbus_read_byte_data(client,
-			TMP401_TEMP_LOW_LIMIT_LSB[i]);
-		data->temp_high[i] = i2c_smbus_read_byte_data(client,
-			TMP401_TEMP_HIGH_LIMIT_MSB_READ[i]) << 8;
-		data->temp_high[i] |= i2c_smbus_read_byte_data(client,
-			TMP401_TEMP_HIGH_LIMIT_LSB[i]);
-		data->temp_crit[i] = i2c_smbus_read_byte_data(client,
-			TMP401_TEMP_CRIT_LIMIT[i]);
-
-		if (data->kind = tmp411) {
-			data->temp_lowest[i] = i2c_smbus_read_byte_data(client,
-				TMP411_TEMP_LOWEST_MSB[i]) << 8;
-			data->temp_lowest[i] |= i2c_smbus_read_byte_data(
-				client, TMP411_TEMP_LOWEST_LSB[i]);
-
-			data->temp_highest[i] = i2c_smbus_read_byte_data(
-				client, TMP411_TEMP_HIGHEST_MSB[i]) << 8;
-			data->temp_highest[i] |= i2c_smbus_read_byte_data(
-				client, TMP411_TEMP_HIGHEST_LSB[i]);
+	int i, j, val;
+	int num_regs = data->kind = tmp411 ? 6 : 4;
+
+	for (i = 0; i < 2; i++) {			/* local / rem1 */
+		for (j = 0; j < num_regs; j++) {	/* temp / low / ... */
+			/*
+			 * High byte must be read first immediately followed
+			 * by the low byte
+			 */
+			val = i2c_smbus_read_byte_data(client,
+						TMP401_TEMP_MSB_READ[j][i]);
+			if (val < 0)
+				return val;
+			data->temp[j][i] = val << 8;
+			if (j = 3)		/* crit is msb only */
+				continue;
+			val = i2c_smbus_read_byte_data(client,
+						TMP401_TEMP_LSB[j][i]);
+			if (val < 0)
+				return val;
+			data->temp[j][i] |= val;
 		}
 	}
-	return data;
+	return 0;
 }
 
 static struct tmp401_data *tmp401_update_device(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct tmp401_data *data = i2c_get_clientdata(client);
+	struct tmp401_data *ret = data;
+	int val;
 
 	mutex_lock(&data->update_lock);
 
 	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
-		data->status = i2c_smbus_read_byte_data(client, TMP401_STATUS);
-		data->config = i2c_smbus_read_byte_data(client,
-						TMP401_CONFIG_READ);
-		tmp401_update_device_reg16(client, data);
-
-		data->temp_crit_hyst = i2c_smbus_read_byte_data(client,
-						TMP401_TEMP_CRIT_HYST);
+		val = i2c_smbus_read_byte_data(client, TMP401_STATUS);
+		if (val < 0) {
+			ret = ERR_PTR(val);
+			goto abort;
+		}
+		data->status = val;
+		val = i2c_smbus_read_byte_data(client, TMP401_CONFIG_READ);
+		if (val < 0) {
+			ret = ERR_PTR(val);
+			goto abort;
+		}
+		data->config = val;
+		val = tmp401_update_device_reg16(client, data);
+		if (val < 0) {
+			ret = ERR_PTR(val);
+			goto abort;
+		}
+		val = i2c_smbus_read_byte_data(client, TMP401_TEMP_CRIT_HYST);
+		if (val < 0) {
+			ret = ERR_PTR(val);
+			goto abort;
+		}
+		data->temp_crit_hyst = val;
 
 		data->last_updated = jiffies;
 		data->valid = 1;
 	}
 
+abort:
 	mutex_unlock(&data->update_lock);
-
-	return data;
+	return ret;
 }
 
-static ssize_t show_temp_value(struct device *dev,
-	struct device_attribute *devattr, char *buf)
+static ssize_t show_temp(struct device *dev,
+			 struct device_attribute *devattr, char *buf)
 {
-	int index = to_sensor_dev_attr(devattr)->index;
+	int nr = to_sensor_dev_attr_2(devattr)->nr;
+	int index = to_sensor_dev_attr_2(devattr)->index;
 	struct tmp401_data *data = tmp401_update_device(dev);
 
-	return sprintf(buf, "%d\n",
-		tmp401_register_to_temp(data->temp[index], data->config));
-}
-
-static ssize_t show_temp_min(struct device *dev,
-	struct device_attribute *devattr, char *buf)
-{
-	int index = to_sensor_dev_attr(devattr)->index;
-	struct tmp401_data *data = tmp401_update_device(dev);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
 
 	return sprintf(buf, "%d\n",
-		tmp401_register_to_temp(data->temp_low[index], data->config));
-}
-
-static ssize_t show_temp_max(struct device *dev,
-	struct device_attribute *devattr, char *buf)
-{
-	int index = to_sensor_dev_attr(devattr)->index;
-	struct tmp401_data *data = tmp401_update_device(dev);
-
-	return sprintf(buf, "%d\n",
-		tmp401_register_to_temp(data->temp_high[index], data->config));
-}
-
-static ssize_t show_temp_crit(struct device *dev,
-	struct device_attribute *devattr, char *buf)
-{
-	int index = to_sensor_dev_attr(devattr)->index;
-	struct tmp401_data *data = tmp401_update_device(dev);
-
-	return sprintf(buf, "%d\n",
-			tmp401_crit_register_to_temp(data->temp_crit[index],
-							data->config));
+		tmp401_register_to_temp(data->temp[nr][index], data->config));
 }
 
 static ssize_t show_temp_crit_hyst(struct device *dev,
@@ -285,122 +250,60 @@ static ssize_t show_temp_crit_hyst(struct device *dev,
 	int temp, index = to_sensor_dev_attr(devattr)->index;
 	struct tmp401_data *data = tmp401_update_device(dev);
 
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	mutex_lock(&data->update_lock);
-	temp = tmp401_crit_register_to_temp(data->temp_crit[index],
-						data->config);
+	temp = tmp401_register_to_temp(data->temp[3][index], data->config);
 	temp -= data->temp_crit_hyst * 1000;
 	mutex_unlock(&data->update_lock);
 
 	return sprintf(buf, "%d\n", temp);
 }
 
-static ssize_t show_temp_lowest(struct device *dev,
-	struct device_attribute *devattr, char *buf)
-{
-	int index = to_sensor_dev_attr(devattr)->index;
-	struct tmp401_data *data = tmp401_update_device(dev);
-
-	return sprintf(buf, "%d\n",
-		tmp401_register_to_temp(data->temp_lowest[index],
-					data->config));
-}
-
-static ssize_t show_temp_highest(struct device *dev,
-	struct device_attribute *devattr, char *buf)
-{
-	int index = to_sensor_dev_attr(devattr)->index;
-	struct tmp401_data *data = tmp401_update_device(dev);
-
-	return sprintf(buf, "%d\n",
-		tmp401_register_to_temp(data->temp_highest[index],
-					data->config));
-}
-
 static ssize_t show_status(struct device *dev,
 	struct device_attribute *devattr, char *buf)
 {
 	int mask = to_sensor_dev_attr(devattr)->index;
 	struct tmp401_data *data = tmp401_update_device(dev);
 
-	if (data->status & mask)
-		return sprintf(buf, "1\n");
-	else
-		return sprintf(buf, "0\n");
-}
-
-static ssize_t store_temp_min(struct device *dev, struct device_attribute
-	*devattr, const char *buf, size_t count)
-{
-	int index = to_sensor_dev_attr(devattr)->index;
-	struct tmp401_data *data = tmp401_update_device(dev);
-	long val;
-	u16 reg;
-
-	if (kstrtol(buf, 10, &val))
-		return -EINVAL;
-
-	reg = tmp401_temp_to_register(val, data->config);
-
-	mutex_lock(&data->update_lock);
-
-	i2c_smbus_write_byte_data(to_i2c_client(dev),
-		TMP401_TEMP_LOW_LIMIT_MSB_WRITE[index], reg >> 8);
-	i2c_smbus_write_byte_data(to_i2c_client(dev),
-		TMP401_TEMP_LOW_LIMIT_LSB[index], reg & 0xFF);
-
-	data->temp_low[index] = reg;
+	if (IS_ERR(data))
+		return PTR_ERR(data);
 
-	mutex_unlock(&data->update_lock);
-
-	return count;
+	return sprintf(buf, "%d\n", !!(data->status & mask));
 }
 
-static ssize_t store_temp_max(struct device *dev, struct device_attribute
-	*devattr, const char *buf, size_t count)
+static ssize_t store_temp(struct device *dev, struct device_attribute *devattr,
+			  const char *buf, size_t count)
 {
-	int index = to_sensor_dev_attr(devattr)->index;
+	int nr = to_sensor_dev_attr_2(devattr)->nr;
+	int index = to_sensor_dev_attr_2(devattr)->index;
 	struct tmp401_data *data = tmp401_update_device(dev);
 	long val;
-	u16 reg;
-
-	if (kstrtol(buf, 10, &val))
-		return -EINVAL;
+	u16 regval;
 
-	reg = tmp401_temp_to_register(val, data->config);
-
-	mutex_lock(&data->update_lock);
-
-	i2c_smbus_write_byte_data(to_i2c_client(dev),
-		TMP401_TEMP_HIGH_LIMIT_MSB_WRITE[index], reg >> 8);
-	i2c_smbus_write_byte_data(to_i2c_client(dev),
-		TMP401_TEMP_HIGH_LIMIT_LSB[index], reg & 0xFF);
-
-	data->temp_high[index] = reg;
-
-	mutex_unlock(&data->update_lock);
-
-	return count;
-}
-
-static ssize_t store_temp_crit(struct device *dev, struct device_attribute
-	*devattr, const char *buf, size_t count)
-{
-	int index = to_sensor_dev_attr(devattr)->index;
-	struct tmp401_data *data = tmp401_update_device(dev);
-	long val;
-	u8 reg;
+	if (IS_ERR(data))
+		return PTR_ERR(data);
 
 	if (kstrtol(buf, 10, &val))
 		return -EINVAL;
 
-	reg = tmp401_crit_temp_to_register(val, data->config);
+	regval = tmp401_temp_to_register(val, data->config);
 
 	mutex_lock(&data->update_lock);
 
 	i2c_smbus_write_byte_data(to_i2c_client(dev),
-		TMP401_TEMP_CRIT_LIMIT[index], reg);
+		TMP401_TEMP_MSB_WRITE[nr][index], regval >> 8);
+	if (nr = 3) {
+		/* drop LSB for critical limit */
+		regval &= 0xff00;
+	} else {
+		i2c_smbus_write_byte_data(to_i2c_client(dev),
+					  TMP401_TEMP_LSB[nr][index],
+					  regval & 0xFF);
+	}
 
-	data->temp_crit[index] = reg;
+	data->temp[nr][index] = regval;
 
 	mutex_unlock(&data->update_lock);
 
@@ -415,6 +318,9 @@ static ssize_t store_temp_crit_hyst(struct device *dev, struct device_attribute
 	long val;
 	u8 reg;
 
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	if (kstrtol(buf, 10, &val))
 		return -EINVAL;
 
@@ -424,13 +330,12 @@ static ssize_t store_temp_crit_hyst(struct device *dev, struct device_attribute
 		val = clamp_val(val, 0, 127000);
 
 	mutex_lock(&data->update_lock);
-	temp = tmp401_crit_register_to_temp(data->temp_crit[index],
-						data->config);
+	temp = tmp401_register_to_temp(data->temp[3][index], data->config);
 	val = clamp_val(val, temp - 255000, temp);
 	reg = ((temp - val) + 500) / 1000;
 
-	i2c_smbus_write_byte_data(to_i2c_client(dev),
-		TMP401_TEMP_CRIT_HYST, reg);
+	i2c_smbus_write_byte_data(to_i2c_client(dev), TMP401_TEMP_CRIT_HYST,
+				  reg);
 
 	data->temp_crit_hyst = reg;
 
@@ -459,18 +364,18 @@ static ssize_t reset_temp_history(struct device *dev,
 		return -EINVAL;
 	}
 	i2c_smbus_write_byte_data(to_i2c_client(dev),
-		TMP411_TEMP_LOWEST_MSB[0], val);
+				  TMP401_TEMP_MSB_WRITE[5][0], val);
 
 	return count;
 }
 
-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_value, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp_min,
-			  store_temp_min, 0);
-static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max,
-			  store_temp_max, 0);
-static SENSOR_DEVICE_ATTR(temp1_crit, S_IWUSR | S_IRUGO, show_temp_crit,
-			  store_temp_crit, 0);
+static SENSOR_DEVICE_ATTR_2(temp1_input, S_IRUGO, show_temp, NULL, 0, 0);
+static SENSOR_DEVICE_ATTR_2(temp1_min, S_IWUSR | S_IRUGO, show_temp,
+			    store_temp, 1, 0);
+static SENSOR_DEVICE_ATTR_2(temp1_max, S_IWUSR | S_IRUGO, show_temp,
+			    store_temp, 2, 0);
+static SENSOR_DEVICE_ATTR_2(temp1_crit, S_IWUSR | S_IRUGO, show_temp,
+			    store_temp, 3, 0);
 static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IWUSR | S_IRUGO,
 			  show_temp_crit_hyst, store_temp_crit_hyst, 0);
 static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO, show_status, NULL,
@@ -479,13 +384,13 @@ static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_status, NULL,
 			  TMP401_STATUS_LOCAL_HIGH);
 static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_status, NULL,
 			  TMP401_STATUS_LOCAL_CRIT);
-static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp_value, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_temp_min,
-			  store_temp_min, 1);
-static SENSOR_DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_temp_max,
-			  store_temp_max, 1);
-static SENSOR_DEVICE_ATTR(temp2_crit, S_IWUSR | S_IRUGO, show_temp_crit,
-			  store_temp_crit, 1);
+static SENSOR_DEVICE_ATTR_2(temp2_input, S_IRUGO, show_temp, NULL, 0, 1);
+static SENSOR_DEVICE_ATTR_2(temp2_min, S_IWUSR | S_IRUGO, show_temp,
+			    store_temp, 1, 1);
+static SENSOR_DEVICE_ATTR_2(temp2_max, S_IWUSR | S_IRUGO, show_temp,
+			    store_temp, 2, 1);
+static SENSOR_DEVICE_ATTR_2(temp2_crit, S_IWUSR | S_IRUGO, show_temp,
+			    store_temp, 3, 1);
 static SENSOR_DEVICE_ATTR(temp2_crit_hyst, S_IRUGO, show_temp_crit_hyst,
 			  NULL, 1);
 static SENSOR_DEVICE_ATTR(temp2_fault, S_IRUGO, show_status, NULL,
@@ -531,10 +436,10 @@ static const struct attribute_group tmp401_group = {
  * minimum and maximum register reset for both the local
  * and remote channels.
  */
-static SENSOR_DEVICE_ATTR(temp1_highest, S_IRUGO, show_temp_highest, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp1_lowest, S_IRUGO, show_temp_lowest, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp2_highest, S_IRUGO, show_temp_highest, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp2_lowest, S_IRUGO, show_temp_lowest, NULL, 1);
+static SENSOR_DEVICE_ATTR_2(temp1_lowest, S_IRUGO, show_temp, NULL, 4, 0);
+static SENSOR_DEVICE_ATTR_2(temp1_highest, S_IRUGO, show_temp, NULL, 5, 0);
+static SENSOR_DEVICE_ATTR_2(temp2_lowest, S_IRUGO, show_temp, NULL, 4, 1);
+static SENSOR_DEVICE_ATTR_2(temp2_highest, S_IRUGO, show_temp, NULL, 5, 1);
 static SENSOR_DEVICE_ATTR(temp_reset_history, S_IWUSR, NULL, reset_temp_history,
 			  0);
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
