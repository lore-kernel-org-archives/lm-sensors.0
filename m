From: Lucas Stach <dev@lynxeye.de>
Date: Thu, 08 Dec 2011 21:10:01 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: convert adt7475 driver to new core
Message-Id: <1323378601-6930-3-git-send-email-dev@lynxeye.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This is a full coversion of the adt7475 driver to the newly
introduced hwmon-core interface.

It left in place as much code as possible to minimize the chance
for breakages, but in some places functions were merged to avoid
code bloat and better adapt to the new interface.

Signed-off-by: Lucas Stach <dev@lynxeye.de>
---
 drivers/hwmon/adt7475.c | 1185 +++++++++++++++++++----------------------------
 1 files changed, 485 insertions(+), 700 deletions(-)

diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index b5fcd87..2ba96c2 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2008 Jordan Crouse <jordan@cosmicpenguin.net>
  * Copyright (C) 2008 Hans de Goede <hdegoede@redhat.com>
  * Copyright (C) 2009 Jean Delvare <khali@linux-fr.org>
+ * Copyright (C) 2011 Lucas Stach <dev@lynxeye.de>
  *
  * Derived from the lm83 driver by Jean Delvare
  *
@@ -17,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/i2c.h>
 #include <linux/hwmon.h>
+#include <linux/hwmon-core.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/hwmon-vid.h>
 #include <linux/err.h>
@@ -160,7 +162,6 @@ static const struct i2c_device_id adt7475_id[] = {
 MODULE_DEVICE_TABLE(i2c, adt7475_id);
 
 struct adt7475_data {
-	struct device *hwmon_dev;
 	struct mutex lock;
 
 	unsigned long measure_updated;
@@ -193,7 +194,6 @@ static void adt7475_read_hystersis(struct i2c_client *client);
 static void adt7475_read_pwm(struct i2c_client *client, int index);
 
 /* Given a temp value, convert it to register value */
-
 static inline u16 temp2reg(struct adt7475_data *data, long val)
 {
 	u16 ret;
@@ -213,7 +213,6 @@ static inline u16 temp2reg(struct adt7475_data *data, long val)
 }
 
 /* Given a register value, convert it to a real temp value */
-
 static inline int reg2temp(struct adt7475_data *data, u16 reg)
 {
 	if (data->config5 & CONFIG5_TWOSCOMP) {
@@ -315,88 +314,116 @@ static int find_nearest(long val, const int *array, int size)
 	return 0;
 }
 
-static ssize_t show_voltage(struct device *dev, struct device_attribute *attr,
-			    char *buf)
+static int show_cpu(struct adt7475_data *data, u32 subfeature)
 {
-	struct adt7475_data *data = adt7475_update_device(dev);
-	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
-	unsigned short val;
-
-	switch (sattr->nr) {
-	case ALARM:
-		return sprintf(buf, "%d\n",
-			       (data->alarms >> sattr->index) & 1);
+	switch (subfeature) {
+	case cpu_vid:
+		return vid_from_reg(data->vid, data->vrm);
+
+	case cpu_vrm:
+		return (int)data->vrm;
+
 	default:
-		val = data->voltage[sattr->nr][sattr->index];
-		return sprintf(buf, "%d\n",
-			       reg2volt(sattr->index, val, data->bypass_attn));
+		return 0;
 	}
 }
 
-static ssize_t set_voltage(struct device *dev, struct device_attribute *attr,
-			   const char *buf, size_t count)
+static int set_vrm(struct adt7475_data *data, int value)
 {
+	if (value < 0 || value > 255)
+		return -EINVAL;
+	data->vrm = value;
 
-	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adt7475_data *data = i2c_get_clientdata(client);
+	return 0;
+}
+
+static int show_voltage(struct adt7475_data *data, u8 index, u32 subfeature)
+{
+	switch (subfeature) {
+	case in_alarm:
+		return (data->alarms >> (index)) & 1;
+
+	case in_input:
+		return reg2volt(index, data->voltage[INPUT][index],
+				data->bypass_attn);
+
+	case in_min:
+		return reg2volt(index, data->voltage[MIN][index],
+				data->bypass_attn);
+
+	case in_max:
+		return reg2volt(index, data->voltage[MAX][index],
+				data->bypass_attn);
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int set_voltage(struct adt7475_data *data, struct device *hw_dev,
+		       u8 index, u32 subfeature, int value)
+{
+	struct i2c_client *client = to_i2c_client(hw_dev->parent);
 	unsigned char reg;
-	long val;
+	u8 nr;
 
-	if (strict_strtol(buf, 10, &val))
+	switch (subfeature) {
+	case in_min:
+		nr = MIN;
+		reg = index < ADT7475_VOLTAGE_COUNT ?
+		      VOLTAGE_MIN_REG(index) : REG_VTT_MIN;
+		break;
+	case in_max:
+		nr = MAX;
+		reg = index < ADT7475_VOLTAGE_COUNT ?
+		      VOLTAGE_MAX_REG(index) : REG_VTT_MAX;
+		break;
+	default:
 		return -EINVAL;
+	}
 
 	mutex_lock(&data->lock);
 
-	data->voltage[sattr->nr][sattr->index] -				volt2reg(sattr->index, val, data->bypass_attn);
-
-	if (sattr->index < ADT7475_VOLTAGE_COUNT) {
-		if (sattr->nr = MIN)
-			reg = VOLTAGE_MIN_REG(sattr->index);
-		else
-			reg = VOLTAGE_MAX_REG(sattr->index);
-	} else {
-		if (sattr->nr = MIN)
-			reg = REG_VTT_MIN;
-		else
-			reg = REG_VTT_MAX;
-	}
+	data->voltage[nr][index] = volt2reg(index, value, data->bypass_attn);
+	i2c_smbus_write_byte_data(client, reg, data->voltage[nr][index] >> 2);
 
-	i2c_smbus_write_byte_data(client, reg,
-				  data->voltage[sattr->nr][sattr->index] >> 2);
 	mutex_unlock(&data->lock);
 
-	return count;
+	return 0;
 }
 
-static ssize_t show_temp(struct device *dev, struct device_attribute *attr,
-			 char *buf)
+/* Table of autorange values - the user will write the value in millidegrees,
+   and we'll convert it */
+static const int autorange_table[] = {
+	2000, 2500, 3330, 4000, 5000, 6670, 8000,
+	10000, 13330, 16000, 20000, 26670, 32000, 40000,
+	53330, 80000
+};
+
+static int show_temp(struct adt7475_data *data, u8 index, u8 nr, u32 subfeature)
 {
-	struct adt7475_data *data = adt7475_update_device(dev);
-	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
-	int out;
+	int out = 0, tmp;
 
-	switch (sattr->nr) {
-	case HYSTERSIS:
+	switch (subfeature) {
+	case temp_crit_hyst:
 		mutex_lock(&data->lock);
-		out = data->temp[sattr->nr][sattr->index];
-		if (sattr->index != 1)
+		out = data->temp[HYSTERSIS][index];
+		if (index != 1)
 			out = (out >> 4) & 0xF;
 		else
 			out = (out & 0xF);
 		/* Show the value as an absolute number tied to
 		 * THERM */
-		out = reg2temp(data, data->temp[THERM][sattr->index]) -
+		out = reg2temp(data, data->temp[THERM][index]) -
 			out * 1000;
 		mutex_unlock(&data->lock);
 		break;
 
-	case OFFSET:
+	case temp_offset:
 		/* Offset is always 2's complement, regardless of the
 		 * setting in CONFIG5 */
 		mutex_lock(&data->lock);
-		out = (s8)data->temp[sattr->nr][sattr->index];
+		out = (s8)data->temp[OFFSET][index];
 		if (data->config5 & CONFIG5_TEMPOFFSET)
 			out *= 1000;
 		else
@@ -404,296 +431,226 @@ static ssize_t show_temp(struct device *dev, struct device_attribute *attr,
 		mutex_unlock(&data->lock);
 		break;
 
-	case ALARM:
-		out = (data->alarms >> (sattr->index + 4)) & 1;
+	case temp_alarm:
+		out = (data->alarms >> (index + 4)) & 1;
 		break;
 
-	case FAULT:
+	case temp_fault:
 		/* Note - only for remote1 and remote2 */
-		out = !!(data->alarms & (sattr->index ? 0x8000 : 0x4000));
+		out = !!(data->alarms & (index ? 0x8000 : 0x4000));
+		break;
+
+	case temp_crit:
+		out = reg2temp(data, data->temp[THERM][index]);
+		break;
+
+	case temp_input:
+		out = reg2temp(data, data->temp[INPUT][index]);
+		break;
+
+	case temp_min:
+		out = reg2temp(data, data->temp[MIN][index]);
+		break;
+
+	case temp_max:
+		out = reg2temp(data, data->temp[MAX][index]);
+		break;
+
+	case temp_auto_point_temp:
+		if (nr = 1)
+			out = reg2temp(data, data->temp[AUTOMIN][index]);
+		else {
+			mutex_lock(&data->lock);
+			tmp = (data->range[index] >> 4) & 0x0F;
+			out = reg2temp(data, data->temp[AUTOMIN][index]);
+			mutex_unlock(&data->lock);
+			out += autorange_table[tmp];
+		}
 		break;
 
 	default:
-		/* All other temp values are in the configured format */
-		out = reg2temp(data, data->temp[sattr->nr][sattr->index]);
+		out = -EINVAL;
+		break;
 	}
 
-	return sprintf(buf, "%d\n", out);
+	return out;
 }
 
-static ssize_t set_temp(struct device *dev, struct device_attribute *attr,
-			const char *buf, size_t count)
+static int set_temp(struct adt7475_data *data, struct device *hw_dev,
+		       u8 index, u8 nr, u32 subfeature, int val)
 {
-	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adt7475_data *data = i2c_get_clientdata(client);
+	struct i2c_client *client = to_i2c_client(hw_dev->parent);
 	unsigned char reg = 0;
 	u8 out;
-	int temp;
-	long val;
+	int temp, ret = 0;
 
-	if (strict_strtol(buf, 10, &val))
-		return -EINVAL;
 
 	mutex_lock(&data->lock);
 
 	/* We need the config register in all cases for temp <-> reg conv. */
 	data->config5 = adt7475_read(REG_CONFIG5);
+	data->temp[AUTOMIN][index] +		adt7475_read(TEMP_TMIN_REG(index)) << 2;
+	data->range[index] +		adt7475_read(TEMP_TRANGE_REG(index));
 
-	switch (sattr->nr) {
-	case OFFSET:
+	switch (subfeature) {
+	case temp_offset:
 		if (data->config5 & CONFIG5_TEMPOFFSET) {
 			val = SENSORS_LIMIT(val, -63000, 127000);
-			out = data->temp[OFFSET][sattr->index] = val / 1000;
+			out = data->temp[OFFSET][index] = val / 1000;
 		} else {
 			val = SENSORS_LIMIT(val, -63000, 64000);
-			out = data->temp[OFFSET][sattr->index] = val / 500;
+			out = data->temp[OFFSET][index] = val / 500;
 		}
+		reg = TEMP_OFFSET_REG(index);
 		break;
 
-	case HYSTERSIS:
+	case temp_crit_hyst:
 		/* The value will be given as an absolute value, turn it
 		   into an offset based on THERM */
 
 		/* Read fresh THERM and HYSTERSIS values from the chip */
-		data->temp[THERM][sattr->index] -			adt7475_read(TEMP_THERM_REG(sattr->index)) << 2;
+		data->temp[THERM][index] +			adt7475_read(TEMP_THERM_REG(index)) << 2;
 		adt7475_read_hystersis(client);
 
-		temp = reg2temp(data, data->temp[THERM][sattr->index]);
+		temp = reg2temp(data, data->temp[THERM][index]);
 		val = SENSORS_LIMIT(val, temp - 15000, temp);
 		val = (temp - val) / 1000;
 
-		if (sattr->index != 1) {
-			data->temp[HYSTERSIS][sattr->index] &= 0xF0;
-			data->temp[HYSTERSIS][sattr->index] |= (val & 0xF) << 4;
+		if (index != 1) {
+			data->temp[HYSTERSIS][index] &= 0xF0;
+			data->temp[HYSTERSIS][index] |= (val & 0xF) << 4;
 		} else {
-			data->temp[HYSTERSIS][sattr->index] &= 0x0F;
-			data->temp[HYSTERSIS][sattr->index] |= (val & 0xF);
+			data->temp[HYSTERSIS][index] &= 0x0F;
+			data->temp[HYSTERSIS][index] |= (val & 0xF);
 		}
 
-		out = data->temp[HYSTERSIS][sattr->index];
-		break;
-
-	default:
-		data->temp[sattr->nr][sattr->index] = temp2reg(data, val);
-
-		/* We maintain an extra 2 digits of precision for simplicity
-		 * - shift those back off before writing the value */
-		out = (u8) (data->temp[sattr->nr][sattr->index] >> 2);
-	}
+		if (index != 2)
+			reg = REG_REMOTE1_HYSTERSIS;
+		else
+			reg = REG_REMOTE2_HYSTERSIS;
 
-	switch (sattr->nr) {
-	case MIN:
-		reg = TEMP_MIN_REG(sattr->index);
+		out = data->temp[HYSTERSIS][index];
 		break;
-	case MAX:
-		reg = TEMP_MAX_REG(sattr->index);
+
+	case temp_min:
+		data->temp[MIN][index] = temp2reg(data, val);
+		out = (u8) (data->temp[MIN][index] >> 2);
+		reg = TEMP_MIN_REG(index);
 		break;
-	case OFFSET:
-		reg = TEMP_OFFSET_REG(sattr->index);
+
+	case temp_max:
+		data->temp[MAX][index] = temp2reg(data, val);
+		out = (u8) (data->temp[MAX][index] >> 2);
+		reg = TEMP_MAX_REG(index);
 		break;
-	case AUTOMIN:
-		reg = TEMP_TMIN_REG(sattr->index);
+
+	case temp_crit:
+		data->temp[THERM][index] = temp2reg(data, val);
+		out = (u8) (data->temp[THERM][index] >> 2);
+		reg = TEMP_THERM_REG(index);
 		break;
-	case THERM:
-		reg = TEMP_THERM_REG(sattr->index);
+
+	case temp_auto_point_temp:
+		if (nr = 1) {
+			data->temp[AUTOMIN][index] = temp2reg(data, val);
+			out = (u8) (data->temp[AUTOMIN][index] >> 2);
+			reg = TEMP_TMIN_REG(index);
+		} else {
+			/* The user will write an absolute value, so subtract
+			 * the start point to figure the range */
+			temp = reg2temp(data, data->temp[AUTOMIN][index]);
+			val = SENSORS_LIMIT(val, temp + autorange_table[0],
+					temp +
+			      autorange_table[ARRAY_SIZE(autorange_table) - 1]);
+			val -= temp;
+
+			/* Find the nearest table entry */
+			val = find_nearest(val, autorange_table,
+					ARRAY_SIZE(autorange_table));
+			data->range[index] &= ~0xF0;
+			data->range[index] |= val << 4;
+
+			out = data->range[index];
+			reg = TEMP_TRANGE_REG(index);
+		}
 		break;
-	case HYSTERSIS:
-		if (sattr->index != 2)
-			reg = REG_REMOTE1_HYSTERSIS;
-		else
-			reg = REG_REMOTE2_HYSTERSIS;
 
+	default:
+		ret = -EINVAL;
+		goto inval;
 		break;
 	}
 
 	i2c_smbus_write_byte_data(client, reg, out);
 
+inval:
 	mutex_unlock(&data->lock);
-	return count;
+	return ret;
 }
 
-/* Table of autorange values - the user will write the value in millidegrees,
-   and we'll convert it */
-static const int autorange_table[] = {
-	2000, 2500, 3330, 4000, 5000, 6670, 8000,
-	10000, 13330, 16000, 20000, 26670, 32000, 40000,
-	53330, 80000
-};
-
-static ssize_t show_point2(struct device *dev, struct device_attribute *attr,
-			   char *buf)
+static int show_tach(struct adt7475_data *data, u8 index, u32 subfeature)
 {
-	struct adt7475_data *data = adt7475_update_device(dev);
-	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
-	int out, val;
+	switch (subfeature) {
+	case fan_alarm:
+		return (data->alarms >> (index + 10)) & 1;
 
-	mutex_lock(&data->lock);
-	out = (data->range[sattr->index] >> 4) & 0x0F;
-	val = reg2temp(data, data->temp[AUTOMIN][sattr->index]);
-	mutex_unlock(&data->lock);
+	case fan_min:
+		return tach2rpm(data->tach[MIN][index]);
 
-	return sprintf(buf, "%d\n", val + autorange_table[out]);
-}
-
-static ssize_t set_point2(struct device *dev, struct device_attribute *attr,
-			  const char *buf, size_t count)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adt7475_data *data = i2c_get_clientdata(client);
-	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
-	int temp;
-	long val;
+	case fan_input:
+		return tach2rpm(data->tach[INPUT][index]);
 
-	if (strict_strtol(buf, 10, &val))
+	default:
 		return -EINVAL;
-
-	mutex_lock(&data->lock);
-
-	/* Get a fresh copy of the needed registers */
-	data->config5 = adt7475_read(REG_CONFIG5);
-	data->temp[AUTOMIN][sattr->index] -		adt7475_read(TEMP_TMIN_REG(sattr->index)) << 2;
-	data->range[sattr->index] -		adt7475_read(TEMP_TRANGE_REG(sattr->index));
-
-	/* The user will write an absolute value, so subtract the start point
-	   to figure the range */
-	temp = reg2temp(data, data->temp[AUTOMIN][sattr->index]);
-	val = SENSORS_LIMIT(val, temp + autorange_table[0],
-		temp + autorange_table[ARRAY_SIZE(autorange_table) - 1]);
-	val -= temp;
-
-	/* Find the nearest table entry to what the user wrote */
-	val = find_nearest(val, autorange_table, ARRAY_SIZE(autorange_table));
-
-	data->range[sattr->index] &= ~0xF0;
-	data->range[sattr->index] |= val << 4;
-
-	i2c_smbus_write_byte_data(client, TEMP_TRANGE_REG(sattr->index),
-				  data->range[sattr->index]);
-
-	mutex_unlock(&data->lock);
-	return count;
+	}
 }
 
-static ssize_t show_tach(struct device *dev, struct device_attribute *attr,
-			 char *buf)
+static int set_tach(struct adt7475_data *data, struct device *hw_dev,
+		       u8 index, u32 subfeature, int value)
 {
-	struct adt7475_data *data = adt7475_update_device(dev);
-	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
-	int out;
-
-	if (sattr->nr = ALARM)
-		out = (data->alarms >> (sattr->index + 10)) & 1;
-	else
-		out = tach2rpm(data->tach[sattr->nr][sattr->index]);
-
-	return sprintf(buf, "%d\n", out);
-}
+	struct i2c_client *client = to_i2c_client(hw_dev->parent);
 
-static ssize_t set_tach(struct device *dev, struct device_attribute *attr,
-			const char *buf, size_t count)
-{
+	if (subfeature = fan_min) {
+		mutex_lock(&data->lock);
 
-	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adt7475_data *data = i2c_get_clientdata(client);
-	unsigned long val;
+		data->tach[MIN][index] = rpm2tach(value);
+		adt7475_write_word(client, TACH_MIN_REG(index),
+				data->tach[MIN][index]);
 
-	if (strict_strtoul(buf, 10, &val))
+		mutex_unlock(&data->lock);
+		return 0;
+	} else
 		return -EINVAL;
-
-	mutex_lock(&data->lock);
-
-	data->tach[MIN][sattr->index] = rpm2tach(val);
-
-	adt7475_write_word(client, TACH_MIN_REG(sattr->index),
-			   data->tach[MIN][sattr->index]);
-
-	mutex_unlock(&data->lock);
-	return count;
 }
 
-static ssize_t show_pwm(struct device *dev, struct device_attribute *attr,
-			char *buf)
-{
-	struct adt7475_data *data = adt7475_update_device(dev);
-	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
-
-	return sprintf(buf, "%d\n", data->pwm[sattr->nr][sattr->index]);
-}
-
-static ssize_t show_pwmchan(struct device *dev, struct device_attribute *attr,
-			    char *buf)
-{
-	struct adt7475_data *data = adt7475_update_device(dev);
-	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
-
-	return sprintf(buf, "%d\n", data->pwmchan[sattr->index]);
-}
+/* List of frequencies for the PWM */
+static const int pwmfreq_table[] = {
+	11, 14, 22, 29, 35, 44, 58, 88
+};
 
-static ssize_t show_pwmctrl(struct device *dev, struct device_attribute *attr,
-			    char *buf)
+static int show_pwm(struct adt7475_data *data, u8 index, u32 subfeature)
 {
-	struct adt7475_data *data = adt7475_update_device(dev);
-	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+	switch (subfeature) {
+	case pwm_input:
+		return data->pwm[INPUT][index];
 
-	return sprintf(buf, "%d\n", data->pwmctl[sattr->index]);
-}
+	case pwm_auto_channels_temp:
+		return data->pwmchan[index];
 
-static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
-		       const char *buf, size_t count)
-{
+	case pwm_enable:
+		return data->pwmctl[index];
 
-	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adt7475_data *data = i2c_get_clientdata(client);
-	unsigned char reg = 0;
-	long val;
+	case pwm_freq:
+		return pwmfreq_table[data->range[index] & 7];
 
-	if (strict_strtol(buf, 10, &val))
+	default:
 		return -EINVAL;
-
-	mutex_lock(&data->lock);
-
-	switch (sattr->nr) {
-	case INPUT:
-		/* Get a fresh value for CONTROL */
-		data->pwm[CONTROL][sattr->index] -			adt7475_read(PWM_CONFIG_REG(sattr->index));
-
-		/* If we are not in manual mode, then we shouldn't allow
-		 * the user to set the pwm speed */
-		if (((data->pwm[CONTROL][sattr->index] >> 5) & 7) != 7) {
-			mutex_unlock(&data->lock);
-			return count;
-		}
-
-		reg = PWM_REG(sattr->index);
-		break;
-
-	case MIN:
-		reg = PWM_MIN_REG(sattr->index);
-		break;
-
-	case MAX:
-		reg = PWM_MAX_REG(sattr->index);
-		break;
 	}
-
-	data->pwm[sattr->nr][sattr->index] = SENSORS_LIMIT(val, 0, 0xFF);
-	i2c_smbus_write_byte_data(client, reg,
-				  data->pwm[sattr->nr][sattr->index]);
-
-	mutex_unlock(&data->lock);
-
-	return count;
 }
 
-/* Called by set_pwmctrl and set_pwmchan */
-
 static int hw_set_pwm(struct i2c_client *client, int index,
 		      unsigned int pwmctl, unsigned int pwmchan)
 {
@@ -749,99 +706,81 @@ static int hw_set_pwm(struct i2c_client *client, int index,
 	return 0;
 }
 
-static ssize_t set_pwmchan(struct device *dev, struct device_attribute *attr,
-			   const char *buf, size_t count)
-{
-	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adt7475_data *data = i2c_get_clientdata(client);
-	int r;
-	long val;
-
-	if (strict_strtol(buf, 10, &val))
-		return -EINVAL;
-
-	mutex_lock(&data->lock);
-	/* Read Modify Write PWM values */
-	adt7475_read_pwm(client, sattr->index);
-	r = hw_set_pwm(client, sattr->index, data->pwmctl[sattr->index], val);
-	if (r)
-		count = r;
-	mutex_unlock(&data->lock);
-
-	return count;
-}
-
-static ssize_t set_pwmctrl(struct device *dev, struct device_attribute *attr,
-			   const char *buf, size_t count)
+static int set_pwm(struct adt7475_data *data, struct device *hw_dev,
+		       u8 index, u8 nr, u32 subfeature, int val)
 {
-	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adt7475_data *data = i2c_get_clientdata(client);
-	int r;
-	long val;
-
-	if (strict_strtol(buf, 10, &val))
-		return -EINVAL;
+	struct i2c_client *client = to_i2c_client(hw_dev->parent);
+	unsigned char reg = 0;
+	u8 ar;
+	int ret = 0;
 
 	mutex_lock(&data->lock);
-	/* Read Modify Write PWM values */
-	adt7475_read_pwm(client, sattr->index);
-	r = hw_set_pwm(client, sattr->index, val, data->pwmchan[sattr->index]);
-	if (r)
-		count = r;
-	mutex_unlock(&data->lock);
-
-	return count;
-}
 
-/* List of frequencies for the PWM */
-static const int pwmfreq_table[] = {
-	11, 14, 22, 29, 35, 44, 58, 88
-};
+	switch (subfeature) {
+	case pwm_input:
+		/* Get a fresh value for CONTROL */
+		data->pwm[CONTROL][index] = adt7475_read(PWM_CONFIG_REG(index));
 
-static ssize_t show_pwmfreq(struct device *dev, struct device_attribute *attr,
-			    char *buf)
-{
-	struct adt7475_data *data = adt7475_update_device(dev);
-	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+		/* If we are not in manual mode, then we shouldn't allow
+		 * the user to set the pwm speed */
+		if (((data->pwm[CONTROL][index] >> 5) & 7) != 7) {
+			mutex_unlock(&data->lock);
+			return 0;
+		}
 
-	return sprintf(buf, "%d\n",
-		       pwmfreq_table[data->range[sattr->index] & 7]);
-}
+		data->pwm[INPUT][index] = SENSORS_LIMIT(val, 0, 0xFF);
+		i2c_smbus_write_byte_data(client, PWM_REG(index),
+					  data->pwm[INPUT][index]);
+		break;
 
-static ssize_t set_pwmfreq(struct device *dev, struct device_attribute *attr,
-			   const char *buf, size_t count)
-{
-	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adt7475_data *data = i2c_get_clientdata(client);
-	int out;
-	long val;
+	case pwm_auto_point_pwm:
+		if (nr = 1) {
+			reg = PWM_MIN_REG(index);
+			ar = MIN;
+		} else {
+			reg = PWM_MAX_REG(index);
+			ar = MAX;
+		}
+		data->pwm[ar][index] = SENSORS_LIMIT(val, 0, 0xFF);
+		i2c_smbus_write_byte_data(client, reg, data->pwm[ar][index]);
+		break;
 
-	if (strict_strtol(buf, 10, &val))
-		return -EINVAL;
+	case pwm_auto_channels_temp:
+		adt7475_read_pwm(client, index);
+		ret = hw_set_pwm(client, index, data->pwmctl[index], val);
+		break;
 
-	out = find_nearest(val, pwmfreq_table, ARRAY_SIZE(pwmfreq_table));
+	case pwm_enable:
+		adt7475_read_pwm(client, index);
+		ret = hw_set_pwm(client, index, val, data->pwmchan[index]);
+		break;
 
-	mutex_lock(&data->lock);
+	case pwm_freq:
+		val = find_nearest(val, pwmfreq_table,
+				   ARRAY_SIZE(pwmfreq_table));
+		data->range[index] = adt7475_read(TEMP_TRANGE_REG(index));
+		data->range[index] &= ~7;
+		data->range[index] |= val;
 
-	data->range[sattr->index] -		adt7475_read(TEMP_TRANGE_REG(sattr->index));
-	data->range[sattr->index] &= ~7;
-	data->range[sattr->index] |= out;
+		i2c_smbus_write_byte_data(client, TEMP_TRANGE_REG(index),
+					  data->range[index]);
+		break;
 
-	i2c_smbus_write_byte_data(client, TEMP_TRANGE_REG(sattr->index),
-				  data->range[sattr->index]);
+	default:
+		ret = -EINVAL;
+		break;
+	}
 
 	mutex_unlock(&data->lock);
-	return count;
+
+	return ret;
 }
 
 static ssize_t show_pwm_at_crit(struct device *dev,
 				struct device_attribute *devattr, char *buf)
 {
-	struct adt7475_data *data = adt7475_update_device(dev);
+	struct device *hw_dev = dev_get_drvdata(dev);
+	struct adt7475_data *data = adt7475_update_device(hw_dev);
 	return sprintf(buf, "%d\n", !!(data->config4 & CONFIG4_MAXDUTY));
 }
 
@@ -850,7 +789,9 @@ static ssize_t set_pwm_at_crit(struct device *dev,
 			       const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	struct adt7475_data *data = i2c_get_clientdata(client);
+	struct device *hw_dev = dev_get_drvdata(dev);
+	struct hwmon_device_instance *hw_inst = dev_get_drvdata(hw_dev);
+	struct adt7475_data *data = hw_inst->inst_data;
 	long val;
 
 	if (strict_strtol(buf, 10, &val))
@@ -870,307 +811,84 @@ static ssize_t set_pwm_at_crit(struct device *dev,
 	return count;
 }
 
-static ssize_t show_vrm(struct device *dev, struct device_attribute *devattr,
-			char *buf)
+/* XXX: Non-standard name, this should really go away */
+static DEVICE_ATTR(pwm_use_point2_pwm_at_crit, S_IWUSR | S_IRUGO,
+		   show_pwm_at_crit, set_pwm_at_crit);
+
+static struct attribute *nonstandard_attrs +	&dev_attr_pwm_use_point2_pwm_at_crit.attr;
+
+static int adt7475_get_text(struct device *hw_device,
+		enum hwmon_feature feature, u32 subfeature, u8 index, char *buf)
 {
-	struct adt7475_data *data = dev_get_drvdata(dev);
-	return sprintf(buf, "%d\n", (int)data->vrm);
+	return -EINVAL;
 }
 
-static ssize_t set_vrm(struct device *dev, struct device_attribute *devattr,
-		       const char *buf, size_t count)
+static int adt7475_get_num(struct device *hw_device,
+		enum hwmon_feature feature, u32 subfeature, u8 index,
+		u8 nr, int *value)
 {
-	struct adt7475_data *data = dev_get_drvdata(dev);
-	long val;
+	struct adt7475_data *data = adt7475_update_device(hw_device);
+	int idx = index-1; /* adt7475 indices start from 0 */
 
-	if (strict_strtol(buf, 10, &val))
-		return -EINVAL;
-	if (val < 0 || val > 255)
-		return -EINVAL;
-	data->vrm = val;
+	switch (feature) {
+	case hwmon_feature_cpu:
+		*value = show_cpu(data, subfeature);
+		break;
 
-	return count;
-}
+	case hwmon_feature_in:
+		*value = show_voltage(data, idx, subfeature);
+		break;
 
-static ssize_t show_vid(struct device *dev, struct device_attribute *devattr,
-			char *buf)
-{
-	struct adt7475_data *data = adt7475_update_device(dev);
-	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
-}
+	case hwmon_feature_temp:
+		*value = show_temp(data, idx, nr, subfeature);
+		break;
 
-static SENSOR_DEVICE_ATTR_2(in0_input, S_IRUGO, show_voltage, NULL, INPUT, 0);
-static SENSOR_DEVICE_ATTR_2(in0_max, S_IRUGO | S_IWUSR, show_voltage,
-			    set_voltage, MAX, 0);
-static SENSOR_DEVICE_ATTR_2(in0_min, S_IRUGO | S_IWUSR, show_voltage,
-			    set_voltage, MIN, 0);
-static SENSOR_DEVICE_ATTR_2(in0_alarm, S_IRUGO, show_voltage, NULL, ALARM, 0);
-static SENSOR_DEVICE_ATTR_2(in1_input, S_IRUGO, show_voltage, NULL, INPUT, 1);
-static SENSOR_DEVICE_ATTR_2(in1_max, S_IRUGO | S_IWUSR, show_voltage,
-			    set_voltage, MAX, 1);
-static SENSOR_DEVICE_ATTR_2(in1_min, S_IRUGO | S_IWUSR, show_voltage,
-			    set_voltage, MIN, 1);
-static SENSOR_DEVICE_ATTR_2(in1_alarm, S_IRUGO, show_voltage, NULL, ALARM, 1);
-static SENSOR_DEVICE_ATTR_2(in2_input, S_IRUGO, show_voltage, NULL, INPUT, 2);
-static SENSOR_DEVICE_ATTR_2(in2_max, S_IRUGO | S_IWUSR, show_voltage,
-			    set_voltage, MAX, 2);
-static SENSOR_DEVICE_ATTR_2(in2_min, S_IRUGO | S_IWUSR, show_voltage,
-			    set_voltage, MIN, 2);
-static SENSOR_DEVICE_ATTR_2(in2_alarm, S_IRUGO, show_voltage, NULL, ALARM, 2);
-static SENSOR_DEVICE_ATTR_2(in3_input, S_IRUGO, show_voltage, NULL, INPUT, 3);
-static SENSOR_DEVICE_ATTR_2(in3_max, S_IRUGO | S_IWUSR, show_voltage,
-			    set_voltage, MAX, 3);
-static SENSOR_DEVICE_ATTR_2(in3_min, S_IRUGO | S_IWUSR, show_voltage,
-			    set_voltage, MIN, 3);
-static SENSOR_DEVICE_ATTR_2(in3_alarm, S_IRUGO, show_voltage, NULL, ALARM, 3);
-static SENSOR_DEVICE_ATTR_2(in4_input, S_IRUGO, show_voltage, NULL, INPUT, 4);
-static SENSOR_DEVICE_ATTR_2(in4_max, S_IRUGO | S_IWUSR, show_voltage,
-			    set_voltage, MAX, 4);
-static SENSOR_DEVICE_ATTR_2(in4_min, S_IRUGO | S_IWUSR, show_voltage,
-			    set_voltage, MIN, 4);
-static SENSOR_DEVICE_ATTR_2(in4_alarm, S_IRUGO, show_voltage, NULL, ALARM, 8);
-static SENSOR_DEVICE_ATTR_2(in5_input, S_IRUGO, show_voltage, NULL, INPUT, 5);
-static SENSOR_DEVICE_ATTR_2(in5_max, S_IRUGO | S_IWUSR, show_voltage,
-			    set_voltage, MAX, 5);
-static SENSOR_DEVICE_ATTR_2(in5_min, S_IRUGO | S_IWUSR, show_voltage,
-			    set_voltage, MIN, 5);
-static SENSOR_DEVICE_ATTR_2(in5_alarm, S_IRUGO, show_voltage, NULL, ALARM, 31);
-static SENSOR_DEVICE_ATTR_2(temp1_input, S_IRUGO, show_temp, NULL, INPUT, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_alarm, S_IRUGO, show_temp, NULL, ALARM, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_fault, S_IRUGO, show_temp, NULL, FAULT, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_max, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    MAX, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_min, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    MIN, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_offset, S_IRUGO | S_IWUSR, show_temp,
-			    set_temp, OFFSET, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_auto_point1_temp, S_IRUGO | S_IWUSR,
-			    show_temp, set_temp, AUTOMIN, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_auto_point2_temp, S_IRUGO | S_IWUSR,
-			    show_point2, set_point2, 0, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_crit, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    THERM, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_crit_hyst, S_IRUGO | S_IWUSR, show_temp,
-			    set_temp, HYSTERSIS, 0);
-static SENSOR_DEVICE_ATTR_2(temp2_input, S_IRUGO, show_temp, NULL, INPUT, 1);
-static SENSOR_DEVICE_ATTR_2(temp2_alarm, S_IRUGO, show_temp, NULL, ALARM, 1);
-static SENSOR_DEVICE_ATTR_2(temp2_max, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    MAX, 1);
-static SENSOR_DEVICE_ATTR_2(temp2_min, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    MIN, 1);
-static SENSOR_DEVICE_ATTR_2(temp2_offset, S_IRUGO | S_IWUSR, show_temp,
-			    set_temp, OFFSET, 1);
-static SENSOR_DEVICE_ATTR_2(temp2_auto_point1_temp, S_IRUGO | S_IWUSR,
-			    show_temp, set_temp, AUTOMIN, 1);
-static SENSOR_DEVICE_ATTR_2(temp2_auto_point2_temp, S_IRUGO | S_IWUSR,
-			    show_point2, set_point2, 0, 1);
-static SENSOR_DEVICE_ATTR_2(temp2_crit, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    THERM, 1);
-static SENSOR_DEVICE_ATTR_2(temp2_crit_hyst, S_IRUGO | S_IWUSR, show_temp,
-			    set_temp, HYSTERSIS, 1);
-static SENSOR_DEVICE_ATTR_2(temp3_input, S_IRUGO, show_temp, NULL, INPUT, 2);
-static SENSOR_DEVICE_ATTR_2(temp3_alarm, S_IRUGO, show_temp, NULL, ALARM, 2);
-static SENSOR_DEVICE_ATTR_2(temp3_fault, S_IRUGO, show_temp, NULL, FAULT, 2);
-static SENSOR_DEVICE_ATTR_2(temp3_max, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    MAX, 2);
-static SENSOR_DEVICE_ATTR_2(temp3_min, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    MIN, 2);
-static SENSOR_DEVICE_ATTR_2(temp3_offset, S_IRUGO | S_IWUSR, show_temp,
-			    set_temp, OFFSET, 2);
-static SENSOR_DEVICE_ATTR_2(temp3_auto_point1_temp, S_IRUGO | S_IWUSR,
-			    show_temp, set_temp, AUTOMIN, 2);
-static SENSOR_DEVICE_ATTR_2(temp3_auto_point2_temp, S_IRUGO | S_IWUSR,
-			    show_point2, set_point2, 0, 2);
-static SENSOR_DEVICE_ATTR_2(temp3_crit, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    THERM, 2);
-static SENSOR_DEVICE_ATTR_2(temp3_crit_hyst, S_IRUGO | S_IWUSR, show_temp,
-			    set_temp, HYSTERSIS, 2);
-static SENSOR_DEVICE_ATTR_2(fan1_input, S_IRUGO, show_tach, NULL, INPUT, 0);
-static SENSOR_DEVICE_ATTR_2(fan1_min, S_IRUGO | S_IWUSR, show_tach, set_tach,
-			    MIN, 0);
-static SENSOR_DEVICE_ATTR_2(fan1_alarm, S_IRUGO, show_tach, NULL, ALARM, 0);
-static SENSOR_DEVICE_ATTR_2(fan2_input, S_IRUGO, show_tach, NULL, INPUT, 1);
-static SENSOR_DEVICE_ATTR_2(fan2_min, S_IRUGO | S_IWUSR, show_tach, set_tach,
-			    MIN, 1);
-static SENSOR_DEVICE_ATTR_2(fan2_alarm, S_IRUGO, show_tach, NULL, ALARM, 1);
-static SENSOR_DEVICE_ATTR_2(fan3_input, S_IRUGO, show_tach, NULL, INPUT, 2);
-static SENSOR_DEVICE_ATTR_2(fan3_min, S_IRUGO | S_IWUSR, show_tach, set_tach,
-			    MIN, 2);
-static SENSOR_DEVICE_ATTR_2(fan3_alarm, S_IRUGO, show_tach, NULL, ALARM, 2);
-static SENSOR_DEVICE_ATTR_2(fan4_input, S_IRUGO, show_tach, NULL, INPUT, 3);
-static SENSOR_DEVICE_ATTR_2(fan4_min, S_IRUGO | S_IWUSR, show_tach, set_tach,
-			    MIN, 3);
-static SENSOR_DEVICE_ATTR_2(fan4_alarm, S_IRUGO, show_tach, NULL, ALARM, 3);
-static SENSOR_DEVICE_ATTR_2(pwm1, S_IRUGO | S_IWUSR, show_pwm, set_pwm, INPUT,
-			    0);
-static SENSOR_DEVICE_ATTR_2(pwm1_freq, S_IRUGO | S_IWUSR, show_pwmfreq,
-			    set_pwmfreq, INPUT, 0);
-static SENSOR_DEVICE_ATTR_2(pwm1_enable, S_IRUGO | S_IWUSR, show_pwmctrl,
-			    set_pwmctrl, INPUT, 0);
-static SENSOR_DEVICE_ATTR_2(pwm1_auto_channels_temp, S_IRUGO | S_IWUSR,
-			    show_pwmchan, set_pwmchan, INPUT, 0);
-static SENSOR_DEVICE_ATTR_2(pwm1_auto_point1_pwm, S_IRUGO | S_IWUSR, show_pwm,
-			    set_pwm, MIN, 0);
-static SENSOR_DEVICE_ATTR_2(pwm1_auto_point2_pwm, S_IRUGO | S_IWUSR, show_pwm,
-			    set_pwm, MAX, 0);
-static SENSOR_DEVICE_ATTR_2(pwm2, S_IRUGO | S_IWUSR, show_pwm, set_pwm, INPUT,
-			    1);
-static SENSOR_DEVICE_ATTR_2(pwm2_freq, S_IRUGO | S_IWUSR, show_pwmfreq,
-			    set_pwmfreq, INPUT, 1);
-static SENSOR_DEVICE_ATTR_2(pwm2_enable, S_IRUGO | S_IWUSR, show_pwmctrl,
-			    set_pwmctrl, INPUT, 1);
-static SENSOR_DEVICE_ATTR_2(pwm2_auto_channels_temp, S_IRUGO | S_IWUSR,
-			    show_pwmchan, set_pwmchan, INPUT, 1);
-static SENSOR_DEVICE_ATTR_2(pwm2_auto_point1_pwm, S_IRUGO | S_IWUSR, show_pwm,
-			    set_pwm, MIN, 1);
-static SENSOR_DEVICE_ATTR_2(pwm2_auto_point2_pwm, S_IRUGO | S_IWUSR, show_pwm,
-			    set_pwm, MAX, 1);
-static SENSOR_DEVICE_ATTR_2(pwm3, S_IRUGO | S_IWUSR, show_pwm, set_pwm, INPUT,
-			    2);
-static SENSOR_DEVICE_ATTR_2(pwm3_freq, S_IRUGO | S_IWUSR, show_pwmfreq,
-			    set_pwmfreq, INPUT, 2);
-static SENSOR_DEVICE_ATTR_2(pwm3_enable, S_IRUGO | S_IWUSR, show_pwmctrl,
-			    set_pwmctrl, INPUT, 2);
-static SENSOR_DEVICE_ATTR_2(pwm3_auto_channels_temp, S_IRUGO | S_IWUSR,
-			    show_pwmchan, set_pwmchan, INPUT, 2);
-static SENSOR_DEVICE_ATTR_2(pwm3_auto_point1_pwm, S_IRUGO | S_IWUSR, show_pwm,
-			    set_pwm, MIN, 2);
-static SENSOR_DEVICE_ATTR_2(pwm3_auto_point2_pwm, S_IRUGO | S_IWUSR, show_pwm,
-			    set_pwm, MAX, 2);
-
-/* Non-standard name, might need revisiting */
-static DEVICE_ATTR(pwm_use_point2_pwm_at_crit, S_IWUSR | S_IRUGO,
-		   show_pwm_at_crit, set_pwm_at_crit);
+	case hwmon_feature_fan:
+		*value = show_tach(data, idx, subfeature);
+		break;
 
-static DEVICE_ATTR(vrm, S_IWUSR | S_IRUGO, show_vrm, set_vrm);
-static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
-
-static struct attribute *adt7475_attrs[] = {
-	&sensor_dev_attr_in1_input.dev_attr.attr,
-	&sensor_dev_attr_in1_max.dev_attr.attr,
-	&sensor_dev_attr_in1_min.dev_attr.attr,
-	&sensor_dev_attr_in1_alarm.dev_attr.attr,
-	&sensor_dev_attr_in2_input.dev_attr.attr,
-	&sensor_dev_attr_in2_max.dev_attr.attr,
-	&sensor_dev_attr_in2_min.dev_attr.attr,
-	&sensor_dev_attr_in2_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp1_input.dev_attr.attr,
-	&sensor_dev_attr_temp1_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp1_fault.dev_attr.attr,
-	&sensor_dev_attr_temp1_max.dev_attr.attr,
-	&sensor_dev_attr_temp1_min.dev_attr.attr,
-	&sensor_dev_attr_temp1_offset.dev_attr.attr,
-	&sensor_dev_attr_temp1_auto_point1_temp.dev_attr.attr,
-	&sensor_dev_attr_temp1_auto_point2_temp.dev_attr.attr,
-	&sensor_dev_attr_temp1_crit.dev_attr.attr,
-	&sensor_dev_attr_temp1_crit_hyst.dev_attr.attr,
-	&sensor_dev_attr_temp2_input.dev_attr.attr,
-	&sensor_dev_attr_temp2_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp2_max.dev_attr.attr,
-	&sensor_dev_attr_temp2_min.dev_attr.attr,
-	&sensor_dev_attr_temp2_offset.dev_attr.attr,
-	&sensor_dev_attr_temp2_auto_point1_temp.dev_attr.attr,
-	&sensor_dev_attr_temp2_auto_point2_temp.dev_attr.attr,
-	&sensor_dev_attr_temp2_crit.dev_attr.attr,
-	&sensor_dev_attr_temp2_crit_hyst.dev_attr.attr,
-	&sensor_dev_attr_temp3_input.dev_attr.attr,
-	&sensor_dev_attr_temp3_fault.dev_attr.attr,
-	&sensor_dev_attr_temp3_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp3_max.dev_attr.attr,
-	&sensor_dev_attr_temp3_min.dev_attr.attr,
-	&sensor_dev_attr_temp3_offset.dev_attr.attr,
-	&sensor_dev_attr_temp3_auto_point1_temp.dev_attr.attr,
-	&sensor_dev_attr_temp3_auto_point2_temp.dev_attr.attr,
-	&sensor_dev_attr_temp3_crit.dev_attr.attr,
-	&sensor_dev_attr_temp3_crit_hyst.dev_attr.attr,
-	&sensor_dev_attr_fan1_input.dev_attr.attr,
-	&sensor_dev_attr_fan1_min.dev_attr.attr,
-	&sensor_dev_attr_fan1_alarm.dev_attr.attr,
-	&sensor_dev_attr_fan2_input.dev_attr.attr,
-	&sensor_dev_attr_fan2_min.dev_attr.attr,
-	&sensor_dev_attr_fan2_alarm.dev_attr.attr,
-	&sensor_dev_attr_fan3_input.dev_attr.attr,
-	&sensor_dev_attr_fan3_min.dev_attr.attr,
-	&sensor_dev_attr_fan3_alarm.dev_attr.attr,
-	&sensor_dev_attr_pwm1.dev_attr.attr,
-	&sensor_dev_attr_pwm1_freq.dev_attr.attr,
-	&sensor_dev_attr_pwm1_enable.dev_attr.attr,
-	&sensor_dev_attr_pwm1_auto_channels_temp.dev_attr.attr,
-	&sensor_dev_attr_pwm1_auto_point1_pwm.dev_attr.attr,
-	&sensor_dev_attr_pwm1_auto_point2_pwm.dev_attr.attr,
-	&sensor_dev_attr_pwm3.dev_attr.attr,
-	&sensor_dev_attr_pwm3_freq.dev_attr.attr,
-	&sensor_dev_attr_pwm3_enable.dev_attr.attr,
-	&sensor_dev_attr_pwm3_auto_channels_temp.dev_attr.attr,
-	&sensor_dev_attr_pwm3_auto_point1_pwm.dev_attr.attr,
-	&sensor_dev_attr_pwm3_auto_point2_pwm.dev_attr.attr,
-	&dev_attr_pwm_use_point2_pwm_at_crit.attr,
-	NULL,
-};
+	case hwmon_feature_pwm:
+		*value = show_pwm(data, idx, subfeature);
+		break;
 
-static struct attribute *fan4_attrs[] = {
-	&sensor_dev_attr_fan4_input.dev_attr.attr,
-	&sensor_dev_attr_fan4_min.dev_attr.attr,
-	&sensor_dev_attr_fan4_alarm.dev_attr.attr,
-	NULL
-};
+	default:
+		return -EINVAL;
+	}
 
-static struct attribute *pwm2_attrs[] = {
-	&sensor_dev_attr_pwm2.dev_attr.attr,
-	&sensor_dev_attr_pwm2_freq.dev_attr.attr,
-	&sensor_dev_attr_pwm2_enable.dev_attr.attr,
-	&sensor_dev_attr_pwm2_auto_channels_temp.dev_attr.attr,
-	&sensor_dev_attr_pwm2_auto_point1_pwm.dev_attr.attr,
-	&sensor_dev_attr_pwm2_auto_point2_pwm.dev_attr.attr,
-	NULL
-};
+	return 0;
+}
 
-static struct attribute *in0_attrs[] = {
-	&sensor_dev_attr_in0_input.dev_attr.attr,
-	&sensor_dev_attr_in0_max.dev_attr.attr,
-	&sensor_dev_attr_in0_min.dev_attr.attr,
-	&sensor_dev_attr_in0_alarm.dev_attr.attr,
-	NULL
-};
+static int adt7475_set_num(struct device *hw_device,
+		enum hwmon_feature feature, u32 subfeature, u8 index,
+		u8 nr, int value)
+{
+	struct hwmon_device_instance *hw_inst = dev_get_drvdata(hw_device);
+	struct adt7475_data *data = hw_inst->inst_data;
+	int idx = index-1; /* adt7475 indices start from 0 */
+
+	switch (feature) {
+	case hwmon_feature_cpu:
+		if (subfeature = cpu_vrm)
+			return set_vrm(data, value);
+		return 0;
 
-static struct attribute *in3_attrs[] = {
-	&sensor_dev_attr_in3_input.dev_attr.attr,
-	&sensor_dev_attr_in3_max.dev_attr.attr,
-	&sensor_dev_attr_in3_min.dev_attr.attr,
-	&sensor_dev_attr_in3_alarm.dev_attr.attr,
-	NULL
-};
+	case hwmon_feature_in:
+		return set_voltage(data, hw_device, idx, subfeature, value);
 
-static struct attribute *in4_attrs[] = {
-	&sensor_dev_attr_in4_input.dev_attr.attr,
-	&sensor_dev_attr_in4_max.dev_attr.attr,
-	&sensor_dev_attr_in4_min.dev_attr.attr,
-	&sensor_dev_attr_in4_alarm.dev_attr.attr,
-	NULL
-};
+	case hwmon_feature_temp:
+		return set_temp(data, hw_device, idx, nr, subfeature, value);
 
-static struct attribute *in5_attrs[] = {
-	&sensor_dev_attr_in5_input.dev_attr.attr,
-	&sensor_dev_attr_in5_max.dev_attr.attr,
-	&sensor_dev_attr_in5_min.dev_attr.attr,
-	&sensor_dev_attr_in5_alarm.dev_attr.attr,
-	NULL
-};
+	case hwmon_feature_fan:
+		return set_tach(data, hw_device, idx, subfeature, value);
 
-static struct attribute *vid_attrs[] = {
-	&dev_attr_cpu0_vid.attr,
-	&dev_attr_vrm.attr,
-	NULL
-};
+	case hwmon_feature_pwm:
+		return set_pwm(data, hw_device, idx, nr, subfeature, value);
 
-static struct attribute_group adt7475_attr_group = { .attrs = adt7475_attrs };
-static struct attribute_group fan4_attr_group = { .attrs = fan4_attrs };
-static struct attribute_group pwm2_attr_group = { .attrs = pwm2_attrs };
-static struct attribute_group in0_attr_group = { .attrs = in0_attrs };
-static struct attribute_group in3_attr_group = { .attrs = in3_attrs };
-static struct attribute_group in4_attr_group = { .attrs = in4_attrs };
-static struct attribute_group in5_attr_group = { .attrs = in5_attrs };
-static struct attribute_group vid_attr_group = { .attrs = vid_attrs };
+	default:
+		return -EINVAL;
+	}
+}
 
 static int adt7475_detect(struct i2c_client *client,
 			  struct i2c_board_info *info)
@@ -1209,25 +927,27 @@ static int adt7475_detect(struct i2c_client *client,
 	return 0;
 }
 
-static void adt7475_remove_files(struct i2c_client *client,
-				 struct adt7475_data *data)
-{
-	sysfs_remove_group(&client->dev.kobj, &adt7475_attr_group);
-	if (data->has_fan4)
-		sysfs_remove_group(&client->dev.kobj, &fan4_attr_group);
-	if (data->has_pwm2)
-		sysfs_remove_group(&client->dev.kobj, &pwm2_attr_group);
-	if (data->has_voltage & (1 << 0))
-		sysfs_remove_group(&client->dev.kobj, &in0_attr_group);
-	if (data->has_voltage & (1 << 3))
-		sysfs_remove_group(&client->dev.kobj, &in3_attr_group);
-	if (data->has_voltage & (1 << 4))
-		sysfs_remove_group(&client->dev.kobj, &in4_attr_group);
-	if (data->has_voltage & (1 << 5))
-		sysfs_remove_group(&client->dev.kobj, &in5_attr_group);
-	if (data->has_vid)
-		sysfs_remove_group(&client->dev.kobj, &vid_attr_group);
-}
+/* channel capability definitions */
+static u32 adt7475_in_caps = HWMON_CAP(in_input) | HWMON_CAP(in_min) |
+			      HWMON_CAP(in_max) | HWMON_CAP(in_alarm);
+
+static u32 adt7475_cpu_caps = HWMON_CAP(cpu_vid) | HWMON_CAP(cpu_vrm);
+
+static u32 adt7475_temp_caps = HWMON_CAP(temp_input) | HWMON_CAP(temp_alarm) |
+			       HWMON_CAP(temp_fault) | HWMON_CAP(temp_max) |
+			       HWMON_CAP(temp_min) | HWMON_CAP(temp_offset) |
+			       HWMON_CAP(temp_crit) | HWMON_CAP(temp_crit_hyst)
+			       | HWMON_CAP(temp_auto_point_temp);
+static u8 adt7475_num_temp_trips[ADT7475_TEMP_COUNT] = {2, 2, 2};
+
+static u32 adt7475_fan_caps = HWMON_CAP(fan_input) | HWMON_CAP(fan_min) |
+			      HWMON_CAP(fan_alarm);
+
+static u32 adt7475_pwm_caps = HWMON_CAP(pwm_input) | HWMON_CAP(pwm_freq) |
+			      HWMON_CAP(pwm_auto_channels_temp) |
+			      HWMON_CAP(pwm_enable) |
+			      HWMON_CAP(pwm_auto_point_pwm);
+static u8 adt7475_num_pwm_trips[ADT7475_PWM_COUNT] = {2, 2, 2};
 
 static int adt7475_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
@@ -1239,16 +959,92 @@ static int adt7475_probe(struct i2c_client *client,
 		[adt7490] = "ADT7490",
 	};
 
-	struct adt7475_data *data;
+	struct device *hw_device;
+	struct hwmon_device_instance *hw_inst = NULL;
+	struct hwmon_device_caps *caps;
+	struct adt7475_data *data = NULL;
 	int i, ret = 0, revision;
 	u8 config2, config3;
 
+	hw_inst = kzalloc(sizeof(*hw_inst), GFP_KERNEL);
+	if (!hw_inst) {
+		ret = -ENOMEM;
+		goto efree;
+	}
+	caps = &hw_inst->caps;
+
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
-	if (data = NULL)
-		return -ENOMEM;
+	if (!data) {
+		ret = -ENOMEM;
+		goto efree;
+	}
+
+	/* alloc space for feature descriptions */
+	caps->subfeature_caps[hwmon_feature_in] +		kcalloc(sizeof(u32), ADT7475_VOLTAGE_COUNT+1, GFP_KERNEL);
+	if (!hw_inst->caps.subfeature_caps[hwmon_feature_in]) {
+		ret = -ENOMEM;
+		goto efree;
+	}
+	caps->subfeature_caps[hwmon_feature_temp] +		kcalloc(sizeof(u32), ADT7475_TEMP_COUNT, GFP_KERNEL);
+	if (!hw_inst->caps.subfeature_caps[hwmon_feature_temp]) {
+		ret = -ENOMEM;
+		goto efree;
+	}
+	caps->subfeature_caps[hwmon_feature_fan] +		kcalloc(sizeof(u32), ADT7475_TACH_COUNT, GFP_KERNEL);
+	if (!hw_inst->caps.subfeature_caps[hwmon_feature_fan]) {
+		ret = -ENOMEM;
+		goto efree;
+	}
+	caps->subfeature_caps[hwmon_feature_pwm] +		kcalloc(sizeof(u32), ADT7475_PWM_COUNT, GFP_KERNEL);
+	if (!hw_inst->caps.subfeature_caps[hwmon_feature_pwm]) {
+		ret = -ENOMEM;
+		goto efree;
+	}
+
+	/* fill in static fields */
+	hw_inst->get_text_attr = &adt7475_get_text;
+	hw_inst->get_numeric_attr = &adt7475_get_num;
+	hw_inst->set_numeric_attr = &adt7475_set_num;
+
+	caps->num_channels[hwmon_feature_in] = ADT7475_VOLTAGE_COUNT+1;
+	caps->subfeature_caps[hwmon_feature_in][1] = adt7475_in_caps;
+	caps->subfeature_caps[hwmon_feature_in][2] = adt7475_in_caps;
+
+	/* set vid caps to avoid NULL pointer */
+	caps->subfeature_caps[hwmon_feature_cpu] = &adt7475_cpu_caps;
+
+	caps->num_channels[hwmon_feature_temp] = ADT7475_TEMP_COUNT;
+	caps->subfeature_caps[hwmon_feature_temp][0] = adt7475_temp_caps;
+	caps->subfeature_caps[hwmon_feature_temp][1] = adt7475_temp_caps;
+	caps->subfeature_caps[hwmon_feature_temp][2] = adt7475_temp_caps;
+	caps->num_trippoints[hwmon_feature_temp] = adt7475_num_temp_trips;
+
+	caps->num_channels[hwmon_feature_fan] = ADT7475_TACH_COUNT;
+	caps->subfeature_caps[hwmon_feature_fan][0] = adt7475_fan_caps;
+	caps->subfeature_caps[hwmon_feature_fan][1] = adt7475_fan_caps;
+	caps->subfeature_caps[hwmon_feature_fan][2] = adt7475_fan_caps;
+
+	caps->num_channels[hwmon_feature_pwm] = ADT7475_PWM_COUNT;
+	caps->subfeature_caps[hwmon_feature_pwm][0] = adt7475_pwm_caps;
+	caps->subfeature_caps[hwmon_feature_pwm][2] = adt7475_pwm_caps;
+	caps->num_trippoints[hwmon_feature_pwm] = adt7475_num_pwm_trips;
+
+	hw_device = hwmon_device_register(&client->dev);
+	if (IS_ERR(hw_device)) {
+		ret = PTR_ERR(hw_device);
+		goto efree;
+	}
+
+	/* link together all the devices */
+	i2c_set_clientdata(client, hw_device);
+	dev_set_drvdata(hw_device, hw_inst);
+	hw_inst->inst_data = (void *)data;
 
 	mutex_init(&data->lock);
-	i2c_set_clientdata(client, data);
 
 	/* Initialize device-specific values */
 	switch (id->driver_data) {
@@ -1265,6 +1061,7 @@ static int adt7475_probe(struct i2c_client *client,
 	default:
 		data->has_voltage = 0x06;	/* in1, in2 */
 		revision = adt7475_read(REG_DEVID2) & 0x07;
+		break;
 	}
 
 	config3 = adt7475_read(REG_CONFIG3);
@@ -1319,52 +1116,25 @@ static int adt7475_probe(struct i2c_client *client,
 	for (i = 0; i < ADT7475_PWM_COUNT; i++)
 		adt7475_read_pwm(client, i);
 
-	ret = sysfs_create_group(&client->dev.kobj, &adt7475_attr_group);
+	/* Features that can be disabled individually */
+	if (data->has_fan4)
+		caps->subfeature_caps[hwmon_feature_fan][3] = adt7475_fan_caps;
+	if (data->has_pwm2)
+		caps->subfeature_caps[hwmon_feature_pwm][1] = adt7475_pwm_caps;
+	for (i = 0; i < ADT7475_VOLTAGE_COUNT; i++)
+		caps->subfeature_caps[hwmon_feature_in][i] = adt7475_in_caps;
+	if (data->has_vid)
+		caps->num_channels[hwmon_feature_cpu] = 1;
+
+	ret = hwmon_create_sysfs(hw_device);
 	if (ret)
 		goto efree;
 
-	/* Features that can be disabled individually */
-	if (data->has_fan4) {
-		ret = sysfs_create_group(&client->dev.kobj, &fan4_attr_group);
-		if (ret)
-			goto eremove;
-	}
-	if (data->has_pwm2) {
-		ret = sysfs_create_group(&client->dev.kobj, &pwm2_attr_group);
-		if (ret)
-			goto eremove;
-	}
-	if (data->has_voltage & (1 << 0)) {
-		ret = sysfs_create_group(&client->dev.kobj, &in0_attr_group);
-		if (ret)
-			goto eremove;
-	}
-	if (data->has_voltage & (1 << 3)) {
-		ret = sysfs_create_group(&client->dev.kobj, &in3_attr_group);
-		if (ret)
-			goto eremove;
-	}
-	if (data->has_voltage & (1 << 4)) {
-		ret = sysfs_create_group(&client->dev.kobj, &in4_attr_group);
-		if (ret)
-			goto eremove;
-	}
-	if (data->has_voltage & (1 << 5)) {
-		ret = sysfs_create_group(&client->dev.kobj, &in5_attr_group);
-		if (ret)
-			goto eremove;
-	}
-	if (data->has_vid) {
-		data->vrm = vid_which_vrm();
-		ret = sysfs_create_group(&client->dev.kobj, &vid_attr_group);
-		if (ret)
-			goto eremove;
-	}
-
-	data->hwmon_dev = hwmon_device_register(&client->dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		ret = PTR_ERR(data->hwmon_dev);
-		goto eremove;
+	/* XXX: create non-standard sysfs entries */
+	ret = sysfs_create_file(&hw_device->parent->kobj, nonstandard_attrs);
+	if (ret) {
+		sysfs_remove_file(&hw_device->parent->kobj, nonstandard_attrs);
+		goto efree;
 	}
 
 	dev_info(&client->dev, "%s device, revision %d\n",
@@ -1385,20 +1155,30 @@ static int adt7475_probe(struct i2c_client *client,
 
 	return 0;
 
-eremove:
-	adt7475_remove_files(client, data);
 efree:
+	kfree(hw_inst->caps.subfeature_caps[hwmon_feature_in]);
+	kfree(hw_inst->caps.subfeature_caps[hwmon_feature_temp]);
+	kfree(hw_inst->caps.subfeature_caps[hwmon_feature_fan]);
+	kfree(hw_inst->caps.subfeature_caps[hwmon_feature_pwm]);
 	kfree(data);
+	kfree(hw_inst);
 	return ret;
 }
 
 static int adt7475_remove(struct i2c_client *client)
 {
-	struct adt7475_data *data = i2c_get_clientdata(client);
-
-	hwmon_device_unregister(data->hwmon_dev);
-	adt7475_remove_files(client, data);
-	kfree(data);
+	struct device *hw_device = i2c_get_clientdata(client);
+	struct hwmon_device_instance *hw_inst = dev_get_drvdata(hw_device);
+
+	hwmon_destroy_sysfs(hw_device);
+	sysfs_remove_file(&hw_device->parent->kobj, nonstandard_attrs);
+	kfree(hw_inst->caps.subfeature_caps[hwmon_feature_in]);
+	kfree(hw_inst->caps.subfeature_caps[hwmon_feature_temp]);
+	kfree(hw_inst->caps.subfeature_caps[hwmon_feature_fan]);
+	kfree(hw_inst->caps.subfeature_caps[hwmon_feature_pwm]);
+	kfree(hw_inst->inst_data);
+	kfree(hw_inst);
+	hwmon_device_unregister(hw_device);
 
 	return 0;
 }
@@ -1417,7 +1197,9 @@ static struct i2c_driver adt7475_driver = {
 
 static void adt7475_read_hystersis(struct i2c_client *client)
 {
-	struct adt7475_data *data = i2c_get_clientdata(client);
+	struct device *hw_dev = i2c_get_clientdata(client);
+	struct hwmon_device_instance *hw_inst = dev_get_drvdata(hw_dev);
+	struct adt7475_data *data = hw_inst->inst_data;
 
 	data->temp[HYSTERSIS][0] = (u16) adt7475_read(REG_REMOTE1_HYSTERSIS);
 	data->temp[HYSTERSIS][1] = data->temp[HYSTERSIS][0];
@@ -1426,7 +1208,9 @@ static void adt7475_read_hystersis(struct i2c_client *client)
 
 static void adt7475_read_pwm(struct i2c_client *client, int index)
 {
-	struct adt7475_data *data = i2c_get_clientdata(client);
+	struct device *hw_dev = i2c_get_clientdata(client);
+	struct hwmon_device_instance *hw_inst = dev_get_drvdata(hw_dev);
+	struct adt7475_data *data = hw_inst->inst_data;
 	unsigned int v;
 
 	data->pwm[CONTROL][index] = adt7475_read(PWM_CONFIG_REG(index));
@@ -1480,8 +1264,9 @@ static void adt7475_read_pwm(struct i2c_client *client, int index)
 
 static struct adt7475_data *adt7475_update_device(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adt7475_data *data = i2c_get_clientdata(client);
+	struct i2c_client *client = to_i2c_client(dev->parent);
+	struct hwmon_device_instance *hw_inst = dev_get_drvdata(dev);
+	struct adt7475_data *data = hw_inst->inst_data;
 	u16 ext;
 	int i;
 
-- 
1.7.7.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
