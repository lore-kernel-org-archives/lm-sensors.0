From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 16 Jan 2012 08:49:07 +0000
Subject: [lm-sensors] [PATCH 05/39] hwmon: (adm1026) Fix checkpatch issues
Message-Id: <1326703781-14272-6-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fixed:
ERROR: do not use assignment in if condition
ERROR: space prohibited after that '~' (ctx:WxW)
ERROR: space required after that ';' (ctx:VxO)
ERROR: space required after that ';' (ctx:VxV)
ERROR: spaces required around that '<' (ctx:VxV)
ERROR: spaces required around that '=' (ctx:VxV)
ERROR: spaces required around that '=' (ctx:VxV)
ERROR: spaces required around that ':' (ctx:VxV)
WARNING: braces {} are not necessary for any arm of this statement
WARNING: braces {} are not necessary for single statement blocks
WARNING: line over 80 characters
WARNING: simple_strtol is obsolete, use kstrtol instead

Not fixed:
ERROR: Macros with multiple statements should be enclosed in a do - while loop

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/adm1026.c |  400 ++++++++++++++++++++++++++++++-----------------
 1 files changed, 260 insertions(+), 140 deletions(-)

diff --git a/drivers/hwmon/adm1026.c b/drivers/hwmon/adm1026.c
index 0531867..cd773ce 100644
--- a/drivers/hwmon/adm1026.c
+++ b/drivers/hwmon/adm1026.c
@@ -202,18 +202,19 @@ static int adm1026_scaling[] = { /* .001 Volts */
  *      22500 kHz * 60 (sec/min) * 2 (pulse) / 2 (pulse/rev) = 1350000
  */
 #define FAN_TO_REG(val, div)  ((val) <= 0 ? 0xff : \
-				SENSORS_LIMIT(1350000/((val)*(div)), 1, 254))
-#define FAN_FROM_REG(val, div) ((val) = 0 ? -1:(val) = 0xff ? 0 : \
-				1350000/((val)*(div)))
-#define DIV_FROM_REG(val) (1<<(val))
+				SENSORS_LIMIT(1350000 / ((val) * (div)), \
+					      1, 254))
+#define FAN_FROM_REG(val, div) ((val) = 0 ? -1 : (val) = 0xff ? 0 : \
+				1350000 / ((val) * (div)))
+#define DIV_FROM_REG(val) (1 << (val))
 #define DIV_TO_REG(val) ((val) >= 8 ? 3 : (val) >= 4 ? 2 : (val) >= 2 ? 1 : 0)
 
 /* Temperature is reported in 1 degC increments */
-#define TEMP_TO_REG(val) (SENSORS_LIMIT(((val)+((val)<0 ? -500 : 500))/1000,\
-	-127, 127))
+#define TEMP_TO_REG(val) (SENSORS_LIMIT(((val) + ((val) < 0 ? -500 : 500)) \
+					/ 1000, -127, 127))
 #define TEMP_FROM_REG(val) ((val) * 1000)
-#define OFFSET_TO_REG(val) (SENSORS_LIMIT(((val)+((val)<0 ? -500 : 500))/1000,\
-	-127, 127))
+#define OFFSET_TO_REG(val) (SENSORS_LIMIT(((val) + ((val) < 0 ? -500 : 500)) \
+					  / 1000, -127, 127))
 #define OFFSET_FROM_REG(val) ((val) * 1000)
 
 #define PWM_TO_REG(val) (SENSORS_LIMIT(val, 0, 255))
@@ -226,8 +227,8 @@ static int adm1026_scaling[] = { /* .001 Volts */
  *   indicates that the DAC could be used to drive the fans, but in our
  *   example board (Arima HDAMA) it isn't connected to the fans at all.
  */
-#define DAC_TO_REG(val) (SENSORS_LIMIT(((((val)*255)+500)/2500), 0, 255))
-#define DAC_FROM_REG(val) (((val)*2500)/255)
+#define DAC_TO_REG(val) (SENSORS_LIMIT(((((val) * 255) + 500) / 2500), 0, 255))
+#define DAC_FROM_REG(val) (((val) * 2500) / 255)
 
 /* Chip sampling rates
  *
@@ -388,17 +389,16 @@ static void adm1026_init_client(struct i2c_client *client)
 		dev_dbg(&client->dev, "THERM pin enabled.  "
 			"GPIO16 disabled.\n");
 	}
-	if (data->config3 & CFG3_VREF_250) {
+	if (data->config3 & CFG3_VREF_250)
 		dev_dbg(&client->dev, "Vref is 2.50 Volts.\n");
-	} else {
+	else
 		dev_dbg(&client->dev, "Vref is 1.82 Volts.\n");
-	}
 	/* Read and pick apart the existing GPIO configuration */
 	value = 0;
-	for (i = 0;i <= 15;++i) {
+	for (i = 0; i <= 15; ++i) {
 		if ((i & 0x03) = 0) {
 			value = adm1026_read_value(client,
-					ADM1026_REG_GPIO_CFG_0_3 + i/4);
+					ADM1026_REG_GPIO_CFG_0_3 + i / 4);
 		}
 		data->gpio_config[i] = value & 0x03;
 		value >>= 2;
@@ -428,7 +428,7 @@ static void adm1026_init_client(struct i2c_client *client)
 	 *   without first setting a value for pwm1.auto_pwm_min
 	 *   will not result in potentially dangerous fan speed decrease.
 	 */
-	data->pwm1.auto_pwm_min%5;
+	data->pwm1.auto_pwm_min = 255;
 	/* Start monitoring */
 	value = adm1026_read_value(client, ADM1026_REG_CONFIG1);
 	/* Set MONITOR, clear interrupt acknowledge and s/w reset */
@@ -440,7 +440,7 @@ static void adm1026_init_client(struct i2c_client *client)
 	/* initialize fan_div[] to hardware defaults */
 	value = adm1026_read_value(client, ADM1026_REG_FAN_DIV_0_3) |
 		(adm1026_read_value(client, ADM1026_REG_FAN_DIV_4_7) << 8);
-	for (i = 0;i <= 7;++i) {
+	for (i = 0; i <= 7; ++i) {
 		data->fan_div[i] = DIV_FROM_REG(value & 0x03);
 		value >>= 2;
 	}
@@ -452,7 +452,7 @@ static void adm1026_print_gpio(struct i2c_client *client)
 	int i;
 
 	dev_dbg(&client->dev, "GPIO config is:\n");
-	for (i = 0;i <= 7;++i) {
+	for (i = 0; i <= 7; ++i) {
 		if (data->config2 & (1 << i)) {
 			dev_dbg(&client->dev, "\t%sGP%s%d\n",
 				data->gpio_config[i] & 0x02 ? "" : "!",
@@ -462,7 +462,7 @@ static void adm1026_print_gpio(struct i2c_client *client)
 			dev_dbg(&client->dev, "\tFAN%d\n", i);
 		}
 	}
-	for (i = 8;i <= 15;++i) {
+	for (i = 8; i <= 15; ++i) {
 		dev_dbg(&client->dev, "\t%sGP%s%d\n",
 			data->gpio_config[i] & 0x02 ? "" : "!",
 			data->gpio_config[i] & 0x01 ? "OUT" : "IN",
@@ -491,46 +491,39 @@ static void adm1026_fixup_gpio(struct i2c_client *client)
 	 */
 
 	/* Make outputs */
-	for (i = 0;i <= 16;++i) {
-		if (gpio_output[i] >= 0 && gpio_output[i] <= 16) {
+	for (i = 0; i <= 16; ++i) {
+		if (gpio_output[i] >= 0 && gpio_output[i] <= 16)
 			data->gpio_config[gpio_output[i]] |= 0x01;
-		}
 		/* if GPIO0-7 is output, it isn't a FAN tach */
-		if (gpio_output[i] >= 0 && gpio_output[i] <= 7) {
+		if (gpio_output[i] >= 0 && gpio_output[i] <= 7)
 			data->config2 |= 1 << gpio_output[i];
-		}
 	}
 
 	/* Input overrides output */
-	for (i = 0;i <= 16;++i) {
-		if (gpio_input[i] >= 0 && gpio_input[i] <= 16) {
-			data->gpio_config[gpio_input[i]] &= ~ 0x01;
-		}
+	for (i = 0; i <= 16; ++i) {
+		if (gpio_input[i] >= 0 && gpio_input[i] <= 16)
+			data->gpio_config[gpio_input[i]] &= ~0x01;
 		/* if GPIO0-7 is input, it isn't a FAN tach */
-		if (gpio_input[i] >= 0 && gpio_input[i] <= 7) {
+		if (gpio_input[i] >= 0 && gpio_input[i] <= 7)
 			data->config2 |= 1 << gpio_input[i];
-		}
 	}
 
 	/* Inverted */
-	for (i = 0;i <= 16;++i) {
-		if (gpio_inverted[i] >= 0 && gpio_inverted[i] <= 16) {
-			data->gpio_config[gpio_inverted[i]] &= ~ 0x02;
-		}
+	for (i = 0; i <= 16; ++i) {
+		if (gpio_inverted[i] >= 0 && gpio_inverted[i] <= 16)
+			data->gpio_config[gpio_inverted[i]] &= ~0x02;
 	}
 
 	/* Normal overrides inverted */
-	for (i = 0;i <= 16;++i) {
-		if (gpio_normal[i] >= 0 && gpio_normal[i] <= 16) {
+	for (i = 0; i <= 16; ++i) {
+		if (gpio_normal[i] >= 0 && gpio_normal[i] <= 16)
 			data->gpio_config[gpio_normal[i]] |= 0x02;
-		}
 	}
 
 	/* Fan overrides input and output */
-	for (i = 0;i <= 7;++i) {
-		if (gpio_fan[i] >= 0 && gpio_fan[i] <= 7) {
+	for (i = 0; i <= 7; ++i) {
+		if (gpio_fan[i] >= 0 && gpio_fan[i] <= 7)
 			data->config2 &= ~(1 << gpio_fan[i]);
-		}
 	}
 
 	/* Write new configs to registers */
@@ -538,7 +531,7 @@ static void adm1026_fixup_gpio(struct i2c_client *client)
 	data->config3 = (data->config3 & 0x3f)
 			| ((data->gpio_config[16] & 0x03) << 6);
 	adm1026_write_value(client, ADM1026_REG_CONFIG3, data->config3);
-	for (i = 15, value = 0;i >= 0;--i) {
+	for (i = 15, value = 0; i >= 0; --i) {
 		value <<= 2;
 		value |= data->gpio_config[i] & 0x03;
 		if ((i & 0x03) = 0) {
@@ -563,20 +556,21 @@ static struct adm1026_data *adm1026_update_device(struct device *dev)
 
 	mutex_lock(&data->update_lock);
 	if (!data->valid
-	    || time_after(jiffies, data->last_reading + ADM1026_DATA_INTERVAL)) {
+	    || time_after(jiffies,
+			  data->last_reading + ADM1026_DATA_INTERVAL)) {
 		/* Things that change quickly */
 		dev_dbg(&client->dev, "Reading sensor values\n");
-		for (i = 0;i <= 16;++i) {
+		for (i = 0; i <= 16; ++i) {
 			data->in[i]  			    adm1026_read_value(client, ADM1026_REG_IN[i]);
 		}
 
-		for (i = 0;i <= 7;++i) {
+		for (i = 0; i <= 7; ++i) {
 			data->fan[i]  			    adm1026_read_value(client, ADM1026_REG_FAN(i));
 		}
 
-		for (i = 0;i <= 2;++i) {
+		for (i = 0; i <= 2; ++i) {
 			/* NOTE: temp[] is s8 and we assume 2's complement
 			 *   "conversion" in the assignment */
 			data->temp[i] @@ -614,7 +608,7 @@ static struct adm1026_data *adm1026_update_device(struct device *dev)
 	    time_after(jiffies, data->last_config + ADM1026_CONFIG_INTERVAL)) {
 		/* Things that don't change often */
 		dev_dbg(&client->dev, "Reading config values\n");
-		for (i = 0;i <= 16;++i) {
+		for (i = 0; i <= 16; ++i) {
 			data->in_min[i] = adm1026_read_value(client,
 				ADM1026_REG_IN_MIN[i]);
 			data->in_max[i] = adm1026_read_value(client,
@@ -624,7 +618,7 @@ static struct adm1026_data *adm1026_update_device(struct device *dev)
 		value = adm1026_read_value(client, ADM1026_REG_FAN_DIV_0_3)
 			| (adm1026_read_value(client, ADM1026_REG_FAN_DIV_4_7)
 			<< 8);
-		for (i = 0;i <= 7;++i) {
+		for (i = 0; i <= 7; ++i) {
 			data->fan_min[i] = adm1026_read_value(client,
 				ADM1026_REG_FAN_MIN(i));
 			data->fan_div[i] = DIV_FROM_REG(value & 0x03);
@@ -681,7 +675,7 @@ static struct adm1026_data *adm1026_update_device(struct device *dev)
 		data->gpio_config[16] = (data->config3 >> 6) & 0x03;
 
 		value = 0;
-		for (i = 0;i <= 15;++i) {
+		for (i = 0; i <= 15; ++i) {
 			if ((i & 0x03) = 0) {
 				value = adm1026_read_value(client,
 					    ADM1026_REG_GPIO_CFG_0_3 + i/4);
@@ -721,7 +715,12 @@ static ssize_t set_in_min(struct device *dev, struct device_attribute *attr,
 	int nr = sensor_attr->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
-	int val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->in_min[nr] = INS_TO_REG(nr, val);
@@ -744,7 +743,12 @@ static ssize_t set_in_max(struct device *dev, struct device_attribute *attr,
 	int nr = sensor_attr->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
-	int val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->in_max[nr] = INS_TO_REG(nr, val);
@@ -779,23 +783,31 @@ in_reg(13);
 in_reg(14);
 in_reg(15);
 
-static ssize_t show_in16(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_in16(struct device *dev, struct device_attribute *attr,
+			 char *buf)
 {
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf, "%d\n", INS_FROM_REG(16, data->in[16]) -
 		NEG12_OFFSET);
 }
-static ssize_t show_in16_min(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_in16_min(struct device *dev, struct device_attribute *attr,
+			     char *buf)
 {
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf, "%d\n", INS_FROM_REG(16, data->in_min[16])
 		- NEG12_OFFSET);
 }
-static ssize_t set_in16_min(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t set_in16_min(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
-	int val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->in_min[16] = INS_TO_REG(16, val + NEG12_OFFSET);
@@ -803,17 +815,24 @@ static ssize_t set_in16_min(struct device *dev, struct device_attribute *attr, c
 	mutex_unlock(&data->update_lock);
 	return count;
 }
-static ssize_t show_in16_max(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_in16_max(struct device *dev, struct device_attribute *attr,
+			     char *buf)
 {
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf, "%d\n", INS_FROM_REG(16, data->in_max[16])
 			- NEG12_OFFSET);
 }
-static ssize_t set_in16_max(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t set_in16_max(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
-	int val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->in_max[16] = INS_TO_REG(16, val+NEG12_OFFSET);
@@ -823,10 +842,10 @@ static ssize_t set_in16_max(struct device *dev, struct device_attribute *attr, c
 }
 
 static SENSOR_DEVICE_ATTR(in16_input, S_IRUGO, show_in16, NULL, 16);
-static SENSOR_DEVICE_ATTR(in16_min, S_IRUGO | S_IWUSR, show_in16_min, set_in16_min, 16);
-static SENSOR_DEVICE_ATTR(in16_max, S_IRUGO | S_IWUSR, show_in16_max, set_in16_max, 16);
-
-
+static SENSOR_DEVICE_ATTR(in16_min, S_IRUGO | S_IWUSR, show_in16_min,
+			  set_in16_min, 16);
+static SENSOR_DEVICE_ATTR(in16_max, S_IRUGO | S_IWUSR, show_in16_max,
+			  set_in16_max, 16);
 
 
 /* Now add fan read/write functions */
@@ -856,7 +875,12 @@ static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
 	int nr = sensor_attr->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
-	int val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->fan_min[nr] = FAN_TO_REG(val, data->fan_div[nr]);
@@ -890,9 +914,8 @@ static void fixup_fan_min(struct device *dev, int fan, int old_div)
 	int new_div = data->fan_div[fan];
 
 	/* 0 and 0xff are special.  Don't adjust them */
-	if (data->fan_min[fan] = 0 || data->fan_min[fan] = 0xff) {
+	if (data->fan_min[fan] = 0 || data->fan_min[fan] = 0xff)
 		return;
-	}
 
 	new_min = data->fan_min[fan] * old_div / new_div;
 	new_min = SENSORS_LIMIT(new_min, 1, 254);
@@ -916,9 +939,14 @@ static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
 	int nr = sensor_attr->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
-	int val, orig_div, new_div;
+	long val;
+	int orig_div, new_div;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
-	val = simple_strtol(buf, NULL, 10);
 	new_div = DIV_TO_REG(val);
 
 	mutex_lock(&data->update_lock);
@@ -939,9 +967,9 @@ static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
 				    (DIV_TO_REG(data->fan_div[7]) << 6));
 	}
 
-	if (data->fan_div[nr] != orig_div) {
+	if (data->fan_div[nr] != orig_div)
 		fixup_fan_min(dev, nr, orig_div);
-	}
+
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -983,7 +1011,12 @@ static ssize_t set_temp_min(struct device *dev, struct device_attribute *attr,
 	int nr = sensor_attr->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
-	int val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->temp_min[nr] = TEMP_TO_REG(val);
@@ -1007,7 +1040,12 @@ static ssize_t set_temp_max(struct device *dev, struct device_attribute *attr,
 	int nr = sensor_attr->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
-	int val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->temp_max[nr] = TEMP_TO_REG(val);
@@ -1046,7 +1084,12 @@ static ssize_t set_temp_offset(struct device *dev,
 	int nr = sensor_attr->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
-	int val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->temp_offset[nr] = TEMP_TO_REG(val);
@@ -1056,8 +1099,8 @@ static ssize_t set_temp_offset(struct device *dev,
 	return count;
 }
 
-#define temp_offset_reg(offset)							\
-static SENSOR_DEVICE_ATTR(temp##offset##_offset, S_IRUGO | S_IWUSR,		\
+#define temp_offset_reg(offset)						\
+static SENSOR_DEVICE_ATTR(temp##offset##_offset, S_IRUGO | S_IWUSR,	\
 		show_temp_offset, set_temp_offset, offset - 1);
 
 temp_offset_reg(1);
@@ -1097,7 +1140,12 @@ static ssize_t set_temp_auto_point1_temp(struct device *dev,
 	int nr = sensor_attr->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
-	int val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->temp_tmin[nr] = TEMP_TO_REG(val);
@@ -1131,15 +1179,21 @@ static ssize_t set_temp_crit_enable(struct device *dev,
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
-	int val = simple_strtol(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+
+	if (val > 1)
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+	data->config1 = (data->config1 & ~CFG1_THERM_HOT) | (val << 4);
+	adm1026_write_value(client, ADM1026_REG_CONFIG1, data->config1);
+	mutex_unlock(&data->update_lock);
 
-	if ((val = 1) || (val=0)) {
-		mutex_lock(&data->update_lock);
-		data->config1 = (data->config1 & ~CFG1_THERM_HOT) | (val << 4);
-		adm1026_write_value(client, ADM1026_REG_CONFIG1,
-			data->config1);
-		mutex_unlock(&data->update_lock);
-	}
 	return count;
 }
 
@@ -1166,7 +1220,12 @@ static ssize_t set_temp_crit(struct device *dev, struct device_attribute *attr,
 	int nr = sensor_attr->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
-	int val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->temp_crit[nr] = TEMP_TO_REG(val);
@@ -1184,17 +1243,24 @@ temp_crit_reg(1);
 temp_crit_reg(2);
 temp_crit_reg(3);
 
-static ssize_t show_analog_out_reg(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_analog_out_reg(struct device *dev,
+				   struct device_attribute *attr, char *buf)
 {
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf, "%d\n", DAC_FROM_REG(data->analog_out));
 }
-static ssize_t set_analog_out_reg(struct device *dev, struct device_attribute *attr, const char *buf,
-		size_t count)
+static ssize_t set_analog_out_reg(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
-	int val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->analog_out = DAC_TO_REG(val);
@@ -1206,7 +1272,8 @@ static ssize_t set_analog_out_reg(struct device *dev, struct device_attribute *a
 static DEVICE_ATTR(analog_out, S_IRUGO | S_IWUSR, show_analog_out_reg,
 	set_analog_out_reg);
 
-static ssize_t show_vid_reg(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_vid_reg(struct device *dev, struct device_attribute *attr,
+			    char *buf)
 {
 	struct adm1026_data *data = adm1026_update_device(dev);
 	int vid = (data->gpio >> 11) & 0x1f;
@@ -1214,25 +1281,35 @@ static ssize_t show_vid_reg(struct device *dev, struct device_attribute *attr, c
 	dev_dbg(dev, "Setting VID from GPIO11-15.\n");
 	return sprintf(buf, "%d\n", vid_from_reg(vid, data->vrm));
 }
+
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
 
-static ssize_t show_vrm_reg(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_vrm_reg(struct device *dev, struct device_attribute *attr,
+			    char *buf)
 {
 	struct adm1026_data *data = dev_get_drvdata(dev);
 	return sprintf(buf, "%d\n", data->vrm);
 }
-static ssize_t store_vrm_reg(struct device *dev, struct device_attribute *attr, const char *buf,
-		size_t count)
+
+static ssize_t store_vrm_reg(struct device *dev, struct device_attribute *attr,
+			     const char *buf, size_t count)
 {
 	struct adm1026_data *data = dev_get_drvdata(dev);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
-	data->vrm = simple_strtol(buf, NULL, 10);
+	data->vrm = SENSORS_LIMIT(val, 0, 255);
 	return count;
 }
 
 static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm_reg, store_vrm_reg);
 
-static ssize_t show_alarms_reg(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_alarms_reg(struct device *dev,
+			       struct device_attribute *attr, char *buf)
 {
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf, "%ld\n", data->alarms);
@@ -1277,18 +1354,24 @@ static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 24);
 static SENSOR_DEVICE_ATTR(in10_alarm, S_IRUGO, show_alarm, NULL, 25);
 static SENSOR_DEVICE_ATTR(in8_alarm, S_IRUGO, show_alarm, NULL, 26);
 
-static ssize_t show_alarm_mask(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_alarm_mask(struct device *dev,
+			       struct device_attribute *attr, char *buf)
 {
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf, "%ld\n", data->alarm_mask);
 }
-static ssize_t set_alarm_mask(struct device *dev, struct device_attribute *attr, const char *buf,
-		size_t count)
+static ssize_t set_alarm_mask(struct device *dev, struct device_attribute *attr,
+			      const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
-	int val = simple_strtol(buf, NULL, 10);
 	unsigned long mask;
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->alarm_mask = val & 0x7fffffff;
@@ -1313,18 +1396,24 @@ static DEVICE_ATTR(alarm_mask, S_IRUGO | S_IWUSR, show_alarm_mask,
 	set_alarm_mask);
 
 
-static ssize_t show_gpio(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_gpio(struct device *dev, struct device_attribute *attr,
+			 char *buf)
 {
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf, "%ld\n", data->gpio);
 }
-static ssize_t set_gpio(struct device *dev, struct device_attribute *attr, const char *buf,
-		size_t count)
+static ssize_t set_gpio(struct device *dev, struct device_attribute *attr,
+			const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
-	int val = simple_strtol(buf, NULL, 10);
 	long gpio;
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->gpio = val & 0x1ffff;
@@ -1340,19 +1429,24 @@ static ssize_t set_gpio(struct device *dev, struct device_attribute *attr, const
 
 static DEVICE_ATTR(gpio, S_IRUGO | S_IWUSR, show_gpio, set_gpio);
 
-
-static ssize_t show_gpio_mask(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_gpio_mask(struct device *dev, struct device_attribute *attr,
+			      char *buf)
 {
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf, "%ld\n", data->gpio_mask);
 }
-static ssize_t set_gpio_mask(struct device *dev, struct device_attribute *attr, const char *buf,
-		size_t count)
+static ssize_t set_gpio_mask(struct device *dev, struct device_attribute *attr,
+			     const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
-	int val = simple_strtol(buf, NULL, 10);
 	long mask;
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->gpio_mask = val & 0x1ffff;
@@ -1368,19 +1462,26 @@ static ssize_t set_gpio_mask(struct device *dev, struct device_attribute *attr,
 
 static DEVICE_ATTR(gpio_mask, S_IRUGO | S_IWUSR, show_gpio_mask, set_gpio_mask);
 
-static ssize_t show_pwm_reg(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_pwm_reg(struct device *dev, struct device_attribute *attr,
+			    char *buf)
 {
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf, "%d\n", PWM_FROM_REG(data->pwm1.pwm));
 }
-static ssize_t set_pwm_reg(struct device *dev, struct device_attribute *attr, const char *buf,
-		size_t count)
+
+static ssize_t set_pwm_reg(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
 
 	if (data->pwm1.enable = 1) {
-		int val = simple_strtol(buf, NULL, 10);
+		long val;
+		int err;
+
+		err = kstrtol(buf, 10, &val);
+		if (err)
+			return err;
 
 		mutex_lock(&data->update_lock);
 		data->pwm1.pwm = PWM_TO_REG(val);
@@ -1389,17 +1490,26 @@ static ssize_t set_pwm_reg(struct device *dev, struct device_attribute *attr, co
 	}
 	return count;
 }
-static ssize_t show_auto_pwm_min(struct device *dev, struct device_attribute *attr, char *buf)
+
+static ssize_t show_auto_pwm_min(struct device *dev,
+				 struct device_attribute *attr, char *buf)
 {
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf, "%d\n", data->pwm1.auto_pwm_min);
 }
-static ssize_t set_auto_pwm_min(struct device *dev, struct device_attribute *attr, const char *buf,
-		size_t count)
+
+static ssize_t set_auto_pwm_min(struct device *dev,
+				struct device_attribute *attr, const char *buf,
+				size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
-	int val = simple_strtol(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->pwm1.auto_pwm_min = SENSORS_LIMIT(val, 0, 255);
@@ -1411,44 +1521,53 @@ static ssize_t set_auto_pwm_min(struct device *dev, struct device_attribute *att
 	mutex_unlock(&data->update_lock);
 	return count;
 }
-static ssize_t show_auto_pwm_max(struct device *dev, struct device_attribute *attr, char *buf)
+
+static ssize_t show_auto_pwm_max(struct device *dev,
+				 struct device_attribute *attr, char *buf)
 {
 	return sprintf(buf, "%d\n", ADM1026_PWM_MAX);
 }
-static ssize_t show_pwm_enable(struct device *dev, struct device_attribute *attr, char *buf)
+
+static ssize_t show_pwm_enable(struct device *dev,
+			       struct device_attribute *attr, char *buf)
 {
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf, "%d\n", data->pwm1.enable);
 }
-static ssize_t set_pwm_enable(struct device *dev, struct device_attribute *attr, const char *buf,
-		size_t count)
+
+static ssize_t set_pwm_enable(struct device *dev, struct device_attribute *attr,
+			      const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
-	int val = simple_strtol(buf, NULL, 10);
 	int old_enable;
+	unsigned long val;
+	int err;
 
-	if ((val >= 0) && (val < 3)) {
-		mutex_lock(&data->update_lock);
-		old_enable = data->pwm1.enable;
-		data->pwm1.enable = val;
-		data->config1 = (data->config1 & ~CFG1_PWM_AFC)
-				| ((val = 2) ? CFG1_PWM_AFC : 0);
-		adm1026_write_value(client, ADM1026_REG_CONFIG1,
-			data->config1);
-		if (val = 2) { /* apply pwm1_auto_pwm_min to pwm1 */
-			data->pwm1.pwm = PWM_TO_REG((data->pwm1.pwm & 0x0f) |
-				PWM_MIN_TO_REG(data->pwm1.auto_pwm_min));
-			adm1026_write_value(client, ADM1026_REG_PWM,
-				data->pwm1.pwm);
-		} else if (!((old_enable = 1) && (val = 1))) {
-			/* set pwm to safe value */
-			data->pwm1.pwm = 255;
-			adm1026_write_value(client, ADM1026_REG_PWM,
-				data->pwm1.pwm);
-		}
-		mutex_unlock(&data->update_lock);
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+
+	if (val >= 3)
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+	old_enable = data->pwm1.enable;
+	data->pwm1.enable = val;
+	data->config1 = (data->config1 & ~CFG1_PWM_AFC)
+			| ((val = 2) ? CFG1_PWM_AFC : 0);
+	adm1026_write_value(client, ADM1026_REG_CONFIG1, data->config1);
+	if (val = 2) { /* apply pwm1_auto_pwm_min to pwm1 */
+		data->pwm1.pwm = PWM_TO_REG((data->pwm1.pwm & 0x0f) |
+			PWM_MIN_TO_REG(data->pwm1.auto_pwm_min));
+		adm1026_write_value(client, ADM1026_REG_PWM, data->pwm1.pwm);
+	} else if (!((old_enable = 1) && (val = 1))) {
+		/* set pwm to safe value */
+		data->pwm1.pwm = 255;
+		adm1026_write_value(client, ADM1026_REG_PWM, data->pwm1.pwm);
 	}
+	mutex_unlock(&data->update_lock);
+
 	return count;
 }
 
@@ -1716,7 +1835,8 @@ static int adm1026_probe(struct i2c_client *client,
 	adm1026_init_client(client);
 
 	/* Register sysfs hooks */
-	if ((err = sysfs_create_group(&client->dev.kobj, &adm1026_group)))
+	err = sysfs_create_group(&client->dev.kobj, &adm1026_group);
+	if (err)
 		goto exitfree;
 	if (data->config1 & CFG1_AIN8_9)
 		err = sysfs_create_group(&client->dev.kobj,
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
