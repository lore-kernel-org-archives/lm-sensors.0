From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 12 Apr 2008 18:04:26 +0000
Subject: [lm-sensors] [PATCH 08/10] hwmon: (lm85) Implement the standard PWM
Message-Id: <20080412200426.6c56eb5c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Implement the standard PWM frequency interface: pwm[1-*]_freq in
units of 1 Hz, instead of the non-standard pwm[1-*]_auto_pwm_freq
in units of 0.1 Hz. The old naming was not only non-standard, it was
also confusing, because it suggested that the frequency value only
applied in automatic fan speed mode, which isn't true.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
Note: this patch looks much bigger than it really is, because it moves
around and renames a lot of code to make the result more consistent.

 Documentation/hwmon/lm85 |   10 -----
 drivers/hwmon/lm85.c     |   78 +++++++++++++++++++++++-----------------------
 2 files changed, 39 insertions(+), 49 deletions(-)

--- linux-2.6.25-rc8.orig/drivers/hwmon/lm85.c	2008-04-04 15:50:53.000000000 +0200
+++ linux-2.6.25-rc8/drivers/hwmon/lm85.c	2008-04-04 15:50:54.000000000 +0200
@@ -192,8 +192,8 @@ static int RANGE_TO_REG(int range)
 #define RANGE_FROM_REG(val)	lm85_range_map[(val) & 0x0f]
 
 /* These are the PWM frequency encodings */
-static const int lm85_freq_map[] = { /* .1 Hz */
-	100, 150, 230, 300, 380, 470, 620, 940
+static const int lm85_freq_map[8] = { /* 1 Hz */
+	10, 15, 23, 30, 38, 47, 62, 94
 };
 
 static int FREQ_TO_REG(int freq)
@@ -276,7 +276,6 @@ struct lm85_zone {
 
 struct lm85_autofan {
 	u8 config;	/* Register value */
-	u8 freq;	/* PWM frequency, encoded */
 	u8 min_pwm;	/* Minimum PWM value, encoded */
 	u8 min_off;	/* Min PWM or OFF below "limit", flag */
 };
@@ -302,6 +301,7 @@ struct lm85_data {
 	u16 fan[4];		/* Register value */
 	u16 fan_min[4];		/* Register value */
 	u8 pwm[3];		/* Register value */
+	u8 pwm_freq[3];		/* Register encoding */
 	u8 temp_ext[3];		/* Decoded values */
 	u8 in_ext[8];		/* Decoded values */
 	u8 vid;			/* Register value */
@@ -529,11 +529,39 @@ static ssize_t set_pwm_enable(struct dev
 	return count;
 }
 
+static ssize_t show_pwm_freq(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	int nr = to_sensor_dev_attr(attr)->index;
+	struct lm85_data *data = lm85_update_device(dev);
+	return sprintf(buf, "%d\n", FREQ_FROM_REG(data->pwm_freq[nr]));
+}
+
+static ssize_t set_pwm_freq(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	int nr = to_sensor_dev_attr(attr)->index;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm85_data *data = i2c_get_clientdata(client);
+	long val = simple_strtol(buf, NULL, 10);
+
+	mutex_lock(&data->update_lock);
+	data->pwm_freq[nr] = FREQ_TO_REG(val);
+	lm85_write_value(client, LM85_REG_AFAN_RANGE(nr),
+		(data->zone[nr].range << 4)
+		| data->pwm_freq[nr]);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
 #define show_pwm_reg(offset)						\
 static SENSOR_DEVICE_ATTR(pwm##offset, S_IRUGO | S_IWUSR,		\
 		show_pwm, set_pwm, offset - 1);				\
 static SENSOR_DEVICE_ATTR(pwm##offset##_enable, S_IRUGO | S_IWUSR,	\
-		show_pwm_enable, set_pwm_enable, offset - 1)
+		show_pwm_enable, set_pwm_enable, offset - 1);		\
+static SENSOR_DEVICE_ATTR(pwm##offset##_freq, S_IRUGO | S_IWUSR,	\
+		show_pwm_freq, set_pwm_freq, offset - 1)
+
 
 show_pwm_reg(1);
 show_pwm_reg(2);
@@ -762,31 +790,6 @@ static ssize_t set_pwm_auto_pwm_minctl(s
 	return count;
 }
 
-static ssize_t show_pwm_auto_pwm_freq(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	int nr = to_sensor_dev_attr(attr)->index;
-	struct lm85_data *data = lm85_update_device(dev);
-	return sprintf(buf, "%d\n", FREQ_FROM_REG(data->autofan[nr].freq));
-}
-
-static ssize_t set_pwm_auto_pwm_freq(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t count)
-{
-	int nr = to_sensor_dev_attr(attr)->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm85_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
-
-	mutex_lock(&data->update_lock);
-	data->autofan[nr].freq = FREQ_TO_REG(val);
-	lm85_write_value(client, LM85_REG_AFAN_RANGE(nr),
-		(data->zone[nr].range << 4)
-		| data->autofan[nr].freq);
-	mutex_unlock(&data->update_lock);
-	return count;
-}
-
 #define pwm_auto(offset)						\
 static SENSOR_DEVICE_ATTR(pwm##offset##_auto_channels,			\
 		S_IRUGO | S_IWUSR, show_pwm_auto_channels,		\
@@ -796,10 +799,7 @@ static SENSOR_DEVICE_ATTR(pwm##offset##_
 		set_pwm_auto_pwm_min, offset - 1);			\
 static SENSOR_DEVICE_ATTR(pwm##offset##_auto_pwm_minctl,		\
 		S_IRUGO | S_IWUSR, show_pwm_auto_pwm_minctl,		\
-		set_pwm_auto_pwm_minctl, offset - 1);			\
-static SENSOR_DEVICE_ATTR(pwm##offset##_auto_pwm_freq,			\
-		S_IRUGO | S_IWUSR, show_pwm_auto_pwm_freq,		\
-		set_pwm_auto_pwm_freq, offset - 1);
+		set_pwm_auto_pwm_minctl, offset - 1)
 
 pwm_auto(1);
 pwm_auto(2);
@@ -868,7 +868,7 @@ static ssize_t set_temp_auto_temp_min(st
 		TEMP_FROM_REG(data->zone[nr].limit));
 	lm85_write_value(client, LM85_REG_AFAN_RANGE(nr),
 		((data->zone[nr].range & 0x0f) << 4)
-		| (data->autofan[nr].freq & 0x07));
+		| (data->pwm_freq[nr] & 0x07));
 
 /* Update temp_auto_hyst and temp_auto_off */
 	data->zone[nr].hyst = HYST_TO_REG(TEMP_FROM_REG(
@@ -911,7 +911,7 @@ static ssize_t set_temp_auto_temp_max(st
 		val - min);
 	lm85_write_value(client, LM85_REG_AFAN_RANGE(nr),
 		((data->zone[nr].range & 0x0f) << 4)
-		| (data->autofan[nr].freq & 0x07));
+		| (data->pwm_freq[nr] & 0x07));
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -985,6 +985,9 @@ static struct attribute *lm85_attributes
 	&sensor_dev_attr_pwm1_enable.dev_attr.attr,
 	&sensor_dev_attr_pwm2_enable.dev_attr.attr,
 	&sensor_dev_attr_pwm3_enable.dev_attr.attr,
+	&sensor_dev_attr_pwm1_freq.dev_attr.attr,
+	&sensor_dev_attr_pwm2_freq.dev_attr.attr,
+	&sensor_dev_attr_pwm3_freq.dev_attr.attr,
 
 	&sensor_dev_attr_in0_input.dev_attr.attr,
 	&sensor_dev_attr_in1_input.dev_attr.attr,
@@ -1027,9 +1030,6 @@ static struct attribute *lm85_attributes
 	&sensor_dev_attr_pwm1_auto_pwm_minctl.dev_attr.attr,
 	&sensor_dev_attr_pwm2_auto_pwm_minctl.dev_attr.attr,
 	&sensor_dev_attr_pwm3_auto_pwm_minctl.dev_attr.attr,
-	&sensor_dev_attr_pwm1_auto_pwm_freq.dev_attr.attr,
-	&sensor_dev_attr_pwm2_auto_pwm_freq.dev_attr.attr,
-	&sensor_dev_attr_pwm3_auto_pwm_freq.dev_attr.attr,
 
 	&sensor_dev_attr_temp1_auto_temp_off.dev_attr.attr,
 	&sensor_dev_attr_temp2_auto_temp_off.dev_attr.attr,
@@ -1460,7 +1460,7 @@ static struct lm85_data *lm85_update_dev
 			data->autofan[i].config  			    lm85_read_value(client, LM85_REG_AFAN_CONFIG(i));
 			val = lm85_read_value(client, LM85_REG_AFAN_RANGE(i));
-			data->autofan[i].freq = val & 0x07;
+			data->pwm_freq[i] = val & 0x07;
 			data->zone[i].range = val >> 4;
 			data->autofan[i].min_pwm  			    lm85_read_value(client, LM85_REG_AFAN_MINPWM(i));
--- linux-2.6.25-rc8.orig/Documentation/hwmon/lm85	2008-04-04 15:46:40.000000000 +0200
+++ linux-2.6.25-rc8/Documentation/hwmon/lm85	2008-04-04 15:50:54.000000000 +0200
@@ -163,16 +163,6 @@ configured individually according to the
 * pwm#_auto_pwm_min - this specifies the PWM value for temp#_auto_temp_off
                       temperature. (PWM value from 0 to 255)
 
-* pwm#_auto_pwm_freq - select base frequency of PWM output. You can select
-                       in range of 10.0 to 94.0 Hz in .1 Hz units.
-		       (Values 100 to 940).
-
-The pwm#_auto_pwm_freq can be set to one of the following 8 values. Setting the
-frequency to a value not on this list, will result in the next higher frequency
-being selected. The actual device frequency may vary slightly from this
-specification as designed by the manufacturer. Consult the datasheet for more
-details. (PWM Frequency values:  100, 150, 230, 300, 380, 470, 620, 940)
-
 * pwm#_auto_pwm_minctl - this flags selects for temp#_auto_temp_off temperature
                          the bahaviour of fans. Write 1 to let fans spinning at
 			 pwm#_auto_pwm_min or write 0 to let them off.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
