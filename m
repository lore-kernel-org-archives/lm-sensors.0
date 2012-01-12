From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 12 Jan 2012 10:23:14 +0000
Subject: [lm-sensors] [PATCH] hwmon: (adm1031) Fix coding style issues
Message-Id: <1326363794-18299-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fix almost all coding style issues except for the multi-line macro errors,
which do not really apply since the macros are not multi-line statements but
declarations.

Based on merged patch series from Zac Storer; fixed remaining checkpatch
errors and warnings.

Cc: Zac Storer <zac.3.14159@gmail.com>
Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/adm1031.c |  152 +++++++++++++++++++++++++++++++---------------
 1 files changed, 102 insertions(+), 50 deletions(-)

diff --git a/drivers/hwmon/adm1031.c b/drivers/hwmon/adm1031.c
index e6291da..4c10fe9 100644
--- a/drivers/hwmon/adm1031.c
+++ b/drivers/hwmon/adm1031.c
@@ -155,7 +155,7 @@ adm1031_write_value(struct i2c_client *client, u8 reg, unsigned int value)
 #define TEMP_OFFSET_FROM_REG(val)	TEMP_FROM_REG((val) < 0 ? \
 						      (val) | 0x70 : (val))
 
-#define FAN_FROM_REG(reg, div)		((reg) ? (11250 * 60) / ((reg) * (div)) : 0)
+#define FAN_FROM_REG(reg, div)	((reg) ? (11250 * 60) / ((reg) * (div)) : 0)
 
 static int FAN_TO_REG(int reg, int div)
 {
@@ -174,8 +174,8 @@ static int FAN_TO_REG(int reg, int div)
 	(((reg) & 0x1F) | (((val) << 5) & 0xe0))
 
 #define AUTO_TEMP_MIN_TO_REG(val, reg)	\
-	((((val)/500) & 0xf8)|((reg) & 0x7))
-#define AUTO_TEMP_RANGE_FROM_REG(reg)	(5000 * (1<< ((reg)&0x7)))
+	((((val) / 500) & 0xf8) | ((reg) & 0x7))
+#define AUTO_TEMP_RANGE_FROM_REG(reg)	(5000 * (1 << ((reg) & 0x7)))
 #define AUTO_TEMP_MIN_FROM_REG(reg)	(1000 * ((((reg) >> 3) & 0x1f) << 2))
 
 #define AUTO_TEMP_MIN_FROM_REG_DEG(reg)	((((reg) >> 3) & 0x1f) << 2)
@@ -202,7 +202,7 @@ static int AUTO_TEMP_MAX_TO_REG(int val, int reg, int pwm)
 
 /* FAN auto control */
 #define GET_FAN_AUTO_BITFIELD(data, idx)	\
-	(*(data)->chan_select_table)[FAN_CHAN_FROM_REG((data)->conf1)][idx%2]
+	(*(data)->chan_select_table)[FAN_CHAN_FROM_REG((data)->conf1)][idx % 2]
 
 /* The tables below contains the possible values for the auto fan
  * control bitfields. the index in the table is the register value.
@@ -230,7 +230,7 @@ static const auto_chan_table_t auto_channel_select_table_adm1030 = {
  */
 static int
 get_fan_auto_nearest(struct adm1031_data *data,
-		     int chan, u8 val, u8 reg, u8 * new_reg)
+		     int chan, u8 val, u8 reg, u8 *new_reg)
 {
 	int i;
 	int first_match = -1, exact_match = -1;
@@ -258,13 +258,13 @@ get_fan_auto_nearest(struct adm1031_data *data,
 		}
 	}
 
-	if (exact_match >= 0) {
+	if (exact_match >= 0)
 		*new_reg = exact_match;
-	} else if (first_match >= 0) {
+	else if (first_match >= 0)
 		*new_reg = first_match;
-	} else {
+	else
 		return -EINVAL;
-	}
+
 	return 0;
 }
 
@@ -283,23 +283,28 @@ set_fan_auto_channel(struct device *dev, struct device_attribute *attr,
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1031_data *data = i2c_get_clientdata(client);
 	int nr = to_sensor_dev_attr(attr)->index;
-	int val = simple_strtol(buf, NULL, 10);
+	long val;
 	u8 reg;
 	int ret;
 	u8 old_fan_mode;
 
+	ret = kstrtol(buf, 10, &val);
+	if (ret)
+		return ret;
+
 	old_fan_mode = data->conf1;
 
 	mutex_lock(&data->update_lock);
 
-	if ((ret = get_fan_auto_nearest(data, nr, val, data->conf1, &reg))) {
+	ret = get_fan_auto_nearest(data, nr, val, data->conf1, &reg);
+	if (ret) {
 		mutex_unlock(&data->update_lock);
 		return ret;
 	}
 	data->conf1 = FAN_CHAN_TO_REG(reg, data->conf1);
 	if ((data->conf1 & ADM1031_CONF1_AUTO_MODE) ^
 	    (old_fan_mode & ADM1031_CONF1_AUTO_MODE)) {
-		if (data->conf1 & ADM1031_CONF1_AUTO_MODE){
+		if (data->conf1 & ADM1031_CONF1_AUTO_MODE) {
 			/* Switch to Auto Fan Mode
 			 * Save PWM registers
 			 * Set PWM registers to 33% Both */
@@ -350,7 +355,12 @@ set_auto_temp_min(struct device *dev, struct device_attribute *attr,
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1031_data *data = i2c_get_clientdata(client);
 	int nr = to_sensor_dev_attr(attr)->index;
-	int val = simple_strtol(buf, NULL, 10);
+	long val;
+	int ret;
+
+	ret = kstrtol(buf, 10, &val);
+	if (ret)
+		return ret;
 
 	mutex_lock(&data->update_lock);
 	data->auto_temp[nr] = AUTO_TEMP_MIN_TO_REG(val, data->auto_temp[nr]);
@@ -374,10 +384,16 @@ set_auto_temp_max(struct device *dev, struct device_attribute *attr,
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1031_data *data = i2c_get_clientdata(client);
 	int nr = to_sensor_dev_attr(attr)->index;
-	int val = simple_strtol(buf, NULL, 10);
+	long val;
+	int ret;
+
+	ret = kstrtol(buf, 10, &val);
+	if (ret)
+		return ret;
 
 	mutex_lock(&data->update_lock);
-	data->temp_max[nr] = AUTO_TEMP_MAX_TO_REG(val, data->auto_temp[nr], data->pwm[nr]);
+	data->temp_max[nr] = AUTO_TEMP_MAX_TO_REG(val, data->auto_temp[nr],
+						  data->pwm[nr]);
 	adm1031_write_value(client, ADM1031_REG_AUTO_TEMP(nr),
 			    data->temp_max[nr]);
 	mutex_unlock(&data->update_lock);
@@ -410,8 +426,12 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1031_data *data = i2c_get_clientdata(client);
 	int nr = to_sensor_dev_attr(attr)->index;
-	int val = simple_strtol(buf, NULL, 10);
-	int reg;
+	long val;
+	int ret, reg;
+
+	ret = kstrtol(buf, 10, &val);
+	if (ret)
+		return ret;
 
 	mutex_lock(&data->update_lock);
 	if ((data->conf1 & ADM1031_CONF1_AUTO_MODE) &&
@@ -449,9 +469,13 @@ static int trust_fan_readings(struct adm1031_data *data, int chan)
 
 	if (data->conf1 & ADM1031_CONF1_AUTO_MODE) {
 		switch (data->conf1 & 0x60) {
-		case 0x00:	/* remote temp1 controls fan1 remote temp2 controls fan2 */
+		case 0x00:
+			/*
+			 * remote temp1 controls fan1,
+			 * remote temp2 controls fan2
+			 */
 			res = data->temp[chan+1] >-			      AUTO_TEMP_MIN_FROM_REG_DEG(data->auto_temp[chan+1]);
+			    AUTO_TEMP_MIN_FROM_REG_DEG(data->auto_temp[chan+1]);
 			break;
 		case 0x20:	/* remote temp1 controls both fans */
 			res @@ -515,7 +539,12 @@ static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1031_data *data = i2c_get_clientdata(client);
 	int nr = to_sensor_dev_attr(attr)->index;
-	int val = simple_strtol(buf, NULL, 10);
+	long val;
+	int ret;
+
+	ret = kstrtol(buf, 10, &val);
+	if (ret)
+		return ret;
 
 	mutex_lock(&data->update_lock);
 	if (val) {
@@ -534,10 +563,15 @@ static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1031_data *data = i2c_get_clientdata(client);
 	int nr = to_sensor_dev_attr(attr)->index;
-	int val = simple_strtol(buf, NULL, 10);
+	long val;
 	u8 tmp;
 	int old_div;
 	int new_min;
+	int ret;
+
+	ret = kstrtol(buf, 10, &val);
+	if (ret)
+		return ret;
 
 	tmp = val = 8 ? 0xc0 :
 	      val = 4 ? 0x80 :
@@ -631,9 +665,13 @@ static ssize_t set_temp_offset(struct device *dev,
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1031_data *data = i2c_get_clientdata(client);
 	int nr = to_sensor_dev_attr(attr)->index;
-	int val;
+	long val;
+	int ret;
+
+	ret = kstrtol(buf, 10, &val);
+	if (ret)
+		return ret;
 
-	val = simple_strtol(buf, NULL, 10);
 	val = SENSORS_LIMIT(val, -15000, 15000);
 	mutex_lock(&data->update_lock);
 	data->temp_offset[nr] = TEMP_OFFSET_TO_REG(val);
@@ -648,9 +686,13 @@ static ssize_t set_temp_min(struct device *dev, struct device_attribute *attr,
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1031_data *data = i2c_get_clientdata(client);
 	int nr = to_sensor_dev_attr(attr)->index;
-	int val;
+	long val;
+	int ret;
+
+	ret = kstrtol(buf, 10, &val);
+	if (ret)
+		return ret;
 
-	val = simple_strtol(buf, NULL, 10);
 	val = SENSORS_LIMIT(val, -55000, nr = 0 ? 127750 : 127875);
 	mutex_lock(&data->update_lock);
 	data->temp_min[nr] = TEMP_TO_REG(val);
@@ -665,9 +707,13 @@ static ssize_t set_temp_max(struct device *dev, struct device_attribute *attr,
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1031_data *data = i2c_get_clientdata(client);
 	int nr = to_sensor_dev_attr(attr)->index;
-	int val;
+	long val;
+	int ret;
+
+	ret = kstrtol(buf, 10, &val);
+	if (ret)
+		return ret;
 
-	val = simple_strtol(buf, NULL, 10);
 	val = SENSORS_LIMIT(val, -55000, nr = 0 ? 127750 : 127875);
 	mutex_lock(&data->update_lock);
 	data->temp_max[nr] = TEMP_TO_REG(val);
@@ -682,9 +728,13 @@ static ssize_t set_temp_crit(struct device *dev, struct device_attribute *attr,
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1031_data *data = i2c_get_clientdata(client);
 	int nr = to_sensor_dev_attr(attr)->index;
-	int val;
+	long val;
+	int ret;
+
+	ret = kstrtol(buf, 10, &val);
+	if (ret)
+		return ret;
 
-	val = simple_strtol(buf, NULL, 10);
 	val = SENSORS_LIMIT(val, -55000, nr = 0 ? 127750 : 127875);
 	mutex_lock(&data->update_lock);
 	data->temp_crit[nr] = TEMP_TO_REG(val);
@@ -711,7 +761,8 @@ temp_reg(2);
 temp_reg(3);
 
 /* Alarms */
-static ssize_t show_alarms(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_alarms(struct device *dev, struct device_attribute *attr,
+			   char *buf)
 {
 	struct adm1031_data *data = adm1031_update_device(dev);
 	return sprintf(buf, "%d\n", data->alarm);
@@ -919,12 +970,13 @@ static int adm1031_probe(struct i2c_client *client,
 	adm1031_init_client(client);
 
 	/* Register sysfs hooks */
-	if ((err = sysfs_create_group(&client->dev.kobj, &adm1031_group)))
+	err = sysfs_create_group(&client->dev.kobj, &adm1031_group);
+	if (err)
 		goto exit_free;
 
 	if (data->chip_type = adm1031) {
-		if ((err = sysfs_create_group(&client->dev.kobj,
-						&adm1031_group_opt)))
+		err = sysfs_create_group(&client->dev.kobj, &adm1031_group_opt);
+		if (err)
 			goto exit_remove;
 	}
 
@@ -970,14 +1022,13 @@ static void adm1031_init_client(struct i2c_client *client)
 	}
 	/* Initialize the ADM1031 chip (enables fan speed reading ) */
 	read_val = adm1031_read_value(client, ADM1031_REG_CONF2);
-	if ((read_val | mask) != read_val) {
-	    adm1031_write_value(client, ADM1031_REG_CONF2, read_val | mask);
-	}
+	if ((read_val | mask) != read_val)
+		adm1031_write_value(client, ADM1031_REG_CONF2, read_val | mask);
 
 	read_val = adm1031_read_value(client, ADM1031_REG_CONF1);
 	if ((read_val | ADM1031_CONF1_MONITOR_ENABLE) != read_val) {
-	    adm1031_write_value(client, ADM1031_REG_CONF1, read_val |
-				ADM1031_CONF1_MONITOR_ENABLE);
+		adm1031_write_value(client, ADM1031_REG_CONF1,
+				    read_val | ADM1031_CONF1_MONITOR_ENABLE);
 	}
 
 	/* Read the chip's update rate */
@@ -1024,8 +1075,7 @@ static struct adm1031_data *adm1031_update_device(struct device *dev)
 				/* oldh is actually newer */
 				if (newh != oldh)
 					dev_warn(&client->dev,
-						 "Remote temperature may be "
-						 "wrong.\n");
+					  "Remote temperature may be wrong.\n");
 #endif
 			}
 			data->temp[chan] = newh;
@@ -1052,22 +1102,24 @@ static struct adm1031_data *adm1031_update_device(struct device *dev)
 		data->conf2 = adm1031_read_value(client, ADM1031_REG_CONF2);
 
 		data->alarm = adm1031_read_value(client, ADM1031_REG_STATUS(0))
-			     | (adm1031_read_value(client, ADM1031_REG_STATUS(1))
-				<< 8);
-		if (data->chip_type = adm1030) {
+		    | (adm1031_read_value(client, ADM1031_REG_STATUS(1)) << 8);
+		if (data->chip_type = adm1030)
 			data->alarm &= 0xc0ff;
-		}
 
-		for (chan=0; chan<(data->chip_type = adm1030 ? 1 : 2); chan++) {
+		for (chan = 0; chan < (data->chip_type = adm1030 ? 1 : 2);
+		     chan++) {
 			data->fan_div[chan] -			    adm1031_read_value(client, ADM1031_REG_FAN_DIV(chan));
+			    adm1031_read_value(client,
+					       ADM1031_REG_FAN_DIV(chan));
 			data->fan_min[chan] -			    adm1031_read_value(client, ADM1031_REG_FAN_MIN(chan));
+			    adm1031_read_value(client,
+					       ADM1031_REG_FAN_MIN(chan));
 			data->fan[chan] -			    adm1031_read_value(client, ADM1031_REG_FAN_SPEED(chan));
+			    adm1031_read_value(client,
+					       ADM1031_REG_FAN_SPEED(chan));
 			data->pwm[chan] -			    0xf & (adm1031_read_value(client, ADM1031_REG_PWM) >>
-				   (4*chan));
+			  (adm1031_read_value(client,
+					ADM1031_REG_PWM) >> (4 * chan)) & 0x0f;
 		}
 		data->last_updated = jiffies;
 		data->valid = 1;
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
