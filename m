From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 05 Jul 2007 18:36:12 +0000
Subject: [lm-sensors] [PATCH 1/5] hwmon/lm85: Use dynamic sysfs callbacks
Message-Id: <20070705203612.7e630af2@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This lets us get rid of macro-generated functions and shrinks the
driver size by about 10%. I used a new style suggested by Mark M.
Hoffman to retrieve the channel number. Instead of:

	struct sensor_device_attribute *sda = to_sensor_dev_attr(attr);
	int nr = sda->index;

I do:

	int nr = to_sensor_dev_attr(attr)->index;

This looks better, and even allows the compiler to do some minor
optimizations.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/lm85.c |  551 ++++++++++++++++++++++----------------------------
 1 file changed, 244 insertions(+), 307 deletions(-)

--- linux-2.6.22-rc6.orig/drivers/hwmon/lm85.c	2007-06-30 20:52:42.000000000 +0200
+++ linux-2.6.22-rc6/drivers/hwmon/lm85.c	2007-07-01 10:53:26.000000000 +0200
@@ -30,6 +30,7 @@
 #include <linux/i2c.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-vid.h>
+#include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
 
@@ -387,19 +388,26 @@ static struct i2c_driver lm85_driver = {
 
 
 /* 4 Fans */
-static ssize_t show_fan(struct device *dev, char *buf, int nr)
+static ssize_t show_fan(struct device *dev, struct device_attribute *attr,
+		char *buf)
 {
+	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
 	return sprintf(buf,"%d\n", FAN_FROM_REG(data->fan[nr]) );
 }
-static ssize_t show_fan_min(struct device *dev, char *buf, int nr)
+
+static ssize_t show_fan_min(struct device *dev, struct device_attribute *attr,
+		char *buf)
 {
+	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
 	return sprintf(buf,"%d\n", FAN_FROM_REG(data->fan_min[nr]) );
 }
-static ssize_t set_fan_min(struct device *dev, const char *buf, 
-		size_t count, int nr)
+
+static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
 {
+	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
 	long val = simple_strtol(buf, NULL, 10);
@@ -412,23 +420,10 @@ static ssize_t set_fan_min(struct device
 }
 
 #define show_fan_offset(offset)						\
-static ssize_t show_fan_##offset (struct device *dev, struct device_attribute *attr, char *buf)	\
-{									\
-	return show_fan(dev, buf, offset - 1);				\
-}									\
-static ssize_t show_fan_##offset##_min (struct device *dev, struct device_attribute *attr, char *buf)	\
-{									\
-	return show_fan_min(dev, buf, offset - 1);			\
-}									\
-static ssize_t set_fan_##offset##_min (struct device *dev, struct device_attribute *attr, 		\
-	const char *buf, size_t count) 					\
-{									\
-	return set_fan_min(dev, buf, count, offset - 1);		\
-}									\
-static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_fan_##offset,	\
-		NULL);							\
-static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, 		\
-		show_fan_##offset##_min, set_fan_##offset##_min);
+static SENSOR_DEVICE_ATTR(fan##offset##_input, S_IRUGO,			\
+		show_fan, NULL, offset - 1);				\
+static SENSOR_DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR,		\
+		show_fan_min, set_fan_min, offset - 1)
 
 show_fan_offset(1);
 show_fan_offset(2);
@@ -484,14 +479,18 @@ static DEVICE_ATTR(alarms, S_IRUGO, show
 
 /* pwm */
 
-static ssize_t show_pwm(struct device *dev, char *buf, int nr)
+static ssize_t show_pwm(struct device *dev, struct device_attribute *attr,
+		char *buf)
 {
+	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
 	return sprintf(buf,"%d\n", PWM_FROM_REG(data->pwm[nr]) );
 }
-static ssize_t set_pwm(struct device *dev, const char *buf, 
-		size_t count, int nr)
+
+static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
 {
+	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
 	long val = simple_strtol(buf, NULL, 10);
@@ -502,8 +501,11 @@ static ssize_t set_pwm(struct device *de
 	mutex_unlock(&data->update_lock);
 	return count;
 }
-static ssize_t show_pwm_enable(struct device *dev, char *buf, int nr)
+
+static ssize_t show_pwm_enable(struct device *dev, struct device_attribute
+		*attr, char *buf)
 {
+	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
 	int	pwm_zone;
 
@@ -512,23 +514,10 @@ static ssize_t show_pwm_enable(struct de
 }
 
 #define show_pwm_reg(offset)						\
-static ssize_t show_pwm_##offset (struct device *dev, struct device_attribute *attr, char *buf)	\
-{									\
-	return show_pwm(dev, buf, offset - 1);				\
-}									\
-static ssize_t set_pwm_##offset (struct device *dev, struct device_attribute *attr,			\
-				 const char *buf, size_t count)		\
-{									\
-	return set_pwm(dev, buf, count, offset - 1);			\
-}									\
-static ssize_t show_pwm_enable##offset (struct device *dev, struct device_attribute *attr, char *buf)	\
-{									\
-	return show_pwm_enable(dev, buf, offset - 1);			\
-}									\
-static DEVICE_ATTR(pwm##offset, S_IRUGO | S_IWUSR, 			\
-		show_pwm_##offset, set_pwm_##offset);			\
-static DEVICE_ATTR(pwm##offset##_enable, S_IRUGO, 			\
-		show_pwm_enable##offset, NULL);
+static SENSOR_DEVICE_ATTR(pwm##offset, S_IRUGO | S_IWUSR,		\
+		show_pwm, set_pwm, offset - 1);				\
+static SENSOR_DEVICE_ATTR(pwm##offset##_enable, S_IRUGO,		\
+		show_pwm_enable, NULL, offset - 1)
 
 show_pwm_reg(1);
 show_pwm_reg(2);
@@ -536,22 +525,29 @@ show_pwm_reg(3);
 
 /* Voltages */
 
-static ssize_t show_in(struct device *dev, char *buf, int nr)
+static ssize_t show_in(struct device *dev, struct device_attribute *attr,
+		char *buf)
 {
+	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
 	return sprintf(	buf, "%d\n", INSEXT_FROM_REG(nr,
 						     data->in[nr],
 						     data->in_ext[nr],
 						     data->adc_scale) );
 }
-static ssize_t show_in_min(struct device *dev, char *buf, int nr)
+
+static ssize_t show_in_min(struct device *dev,  struct device_attribute *attr,
+		char *buf)
 {
+	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
 	return sprintf(buf,"%d\n", INS_FROM_REG(nr, data->in_min[nr]) );
 }
-static ssize_t set_in_min(struct device *dev, const char *buf, 
-		size_t count, int nr)
+
+static ssize_t set_in_min(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
 {
+	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
 	long val = simple_strtol(buf, NULL, 10);
@@ -562,14 +558,19 @@ static ssize_t set_in_min(struct device 
 	mutex_unlock(&data->update_lock);
 	return count;
 }
-static ssize_t show_in_max(struct device *dev, char *buf, int nr)
+
+static ssize_t show_in_max(struct device *dev, struct device_attribute *attr,
+		char *buf)
 {
+	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
 	return sprintf(buf,"%d\n", INS_FROM_REG(nr, data->in_max[nr]) );
 }
-static ssize_t set_in_max(struct device *dev, const char *buf, 
-		size_t count, int nr)
+
+static ssize_t set_in_max(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
 {
+	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
 	long val = simple_strtol(buf, NULL, 10);
@@ -580,35 +581,14 @@ static ssize_t set_in_max(struct device 
 	mutex_unlock(&data->update_lock);
 	return count;
 }
+
 #define show_in_reg(offset)						\
-static ssize_t show_in_##offset (struct device *dev, struct device_attribute *attr, char *buf)		\
-{									\
-	return show_in(dev, buf, offset);				\
-}									\
-static ssize_t show_in_##offset##_min (struct device *dev, struct device_attribute *attr, char *buf)	\
-{									\
-	return show_in_min(dev, buf, offset);				\
-}									\
-static ssize_t show_in_##offset##_max (struct device *dev, struct device_attribute *attr, char *buf)	\
-{									\
-	return show_in_max(dev, buf, offset);				\
-}									\
-static ssize_t set_in_##offset##_min (struct device *dev, struct device_attribute *attr, 		\
-	const char *buf, size_t count) 					\
-{									\
-	return set_in_min(dev, buf, count, offset);			\
-}									\
-static ssize_t set_in_##offset##_max (struct device *dev, struct device_attribute *attr, 		\
-	const char *buf, size_t count) 					\
-{									\
-	return set_in_max(dev, buf, count, offset);			\
-}									\
-static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_in_##offset, 	\
-		NULL);							\
-static DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR, 		\
-		show_in_##offset##_min, set_in_##offset##_min);		\
-static DEVICE_ATTR(in##offset##_max, S_IRUGO | S_IWUSR, 		\
-		show_in_##offset##_max, set_in_##offset##_max);
+static SENSOR_DEVICE_ATTR(in##offset##_input, S_IRUGO,			\
+		show_in, NULL, offset);					\
+static SENSOR_DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR,		\
+		show_in_min, set_in_min, offset);			\
+static SENSOR_DEVICE_ATTR(in##offset##_max, S_IRUGO | S_IWUSR,		\
+		show_in_max, set_in_max, offset)
 
 show_in_reg(0);
 show_in_reg(1);
@@ -618,21 +598,28 @@ show_in_reg(4);
 
 /* Temps */
 
-static ssize_t show_temp(struct device *dev, char *buf, int nr)
+static ssize_t show_temp(struct device *dev, struct device_attribute *attr,
+		char *buf)
 {
+	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
 	return sprintf(buf,"%d\n", TEMPEXT_FROM_REG(data->temp[nr],
 						    data->temp_ext[nr],
 						    data->adc_scale) );
 }
-static ssize_t show_temp_min(struct device *dev, char *buf, int nr)
+
+static ssize_t show_temp_min(struct device *dev, struct device_attribute *attr,
+		char *buf)
 {
+	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
 	return sprintf(buf,"%d\n", TEMP_FROM_REG(data->temp_min[nr]) );
 }
-static ssize_t set_temp_min(struct device *dev, const char *buf, 
-		size_t count, int nr)
+
+static ssize_t set_temp_min(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
 {
+	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
 	long val = simple_strtol(buf, NULL, 10);
@@ -643,14 +630,19 @@ static ssize_t set_temp_min(struct devic
 	mutex_unlock(&data->update_lock);
 	return count;
 }
-static ssize_t show_temp_max(struct device *dev, char *buf, int nr)
+
+static ssize_t show_temp_max(struct device *dev, struct device_attribute *attr,
+		char *buf)
 {
+	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
 	return sprintf(buf,"%d\n", TEMP_FROM_REG(data->temp_max[nr]) );
 }
-static ssize_t set_temp_max(struct device *dev, const char *buf, 
-		size_t count, int nr)
+
+static ssize_t set_temp_max(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
 {
+	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
 	long val = simple_strtol(buf, NULL, 10);	
@@ -661,35 +653,14 @@ static ssize_t set_temp_max(struct devic
 	mutex_unlock(&data->update_lock);
 	return count;
 }
+
 #define show_temp_reg(offset)						\
-static ssize_t show_temp_##offset (struct device *dev, struct device_attribute *attr, char *buf)	\
-{									\
-	return show_temp(dev, buf, offset - 1);				\
-}									\
-static ssize_t show_temp_##offset##_min (struct device *dev, struct device_attribute *attr, char *buf)	\
-{									\
-	return show_temp_min(dev, buf, offset - 1);			\
-}									\
-static ssize_t show_temp_##offset##_max (struct device *dev, struct device_attribute *attr, char *buf)	\
-{									\
-	return show_temp_max(dev, buf, offset - 1);			\
-}									\
-static ssize_t set_temp_##offset##_min (struct device *dev, struct device_attribute *attr, 		\
-	const char *buf, size_t count) 					\
-{									\
-	return set_temp_min(dev, buf, count, offset - 1);		\
-}									\
-static ssize_t set_temp_##offset##_max (struct device *dev, struct device_attribute *attr, 		\
-	const char *buf, size_t count) 					\
-{									\
-	return set_temp_max(dev, buf, count, offset - 1);		\
-}									\
-static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_temp_##offset,	\
-		NULL);							\
-static DEVICE_ATTR(temp##offset##_min, S_IRUGO | S_IWUSR, 		\
-		show_temp_##offset##_min, set_temp_##offset##_min);	\
-static DEVICE_ATTR(temp##offset##_max, S_IRUGO | S_IWUSR, 		\
-		show_temp_##offset##_max, set_temp_##offset##_max);
+static SENSOR_DEVICE_ATTR(temp##offset##_input, S_IRUGO,		\
+		show_temp, NULL, offset - 1);				\
+static SENSOR_DEVICE_ATTR(temp##offset##_min, S_IRUGO | S_IWUSR,	\
+		show_temp_min, set_temp_min, offset - 1);		\
+static SENSOR_DEVICE_ATTR(temp##offset##_max, S_IRUGO | S_IWUSR,	\
+		show_temp_max, set_temp_max, offset - 1);
 
 show_temp_reg(1);
 show_temp_reg(2);
@@ -698,14 +669,18 @@ show_temp_reg(3);
 
 /* Automatic PWM control */
 
-static ssize_t show_pwm_auto_channels(struct device *dev, char *buf, int nr)
+static ssize_t show_pwm_auto_channels(struct device *dev,
+		struct device_attribute *attr, char *buf)
 {
+	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
 	return sprintf(buf,"%d\n", ZONE_FROM_REG(data->autofan[nr].config));
 }
-static ssize_t set_pwm_auto_channels(struct device *dev, const char *buf,
-	size_t count, int nr)
+
+static ssize_t set_pwm_auto_channels(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
 {
+	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
 	long val = simple_strtol(buf, NULL, 10);   
@@ -718,14 +693,19 @@ static ssize_t set_pwm_auto_channels(str
 	mutex_unlock(&data->update_lock);
 	return count;
 }
-static ssize_t show_pwm_auto_pwm_min(struct device *dev, char *buf, int nr)
+
+static ssize_t show_pwm_auto_pwm_min(struct device *dev,
+		struct device_attribute *attr, char *buf)
 {
+	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
 	return sprintf(buf,"%d\n", PWM_FROM_REG(data->autofan[nr].min_pwm));
 }
-static ssize_t set_pwm_auto_pwm_min(struct device *dev, const char *buf,
-	size_t count, int nr)
+
+static ssize_t set_pwm_auto_pwm_min(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
 {
+	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
 	long val = simple_strtol(buf, NULL, 10);
@@ -737,14 +717,19 @@ static ssize_t set_pwm_auto_pwm_min(stru
 	mutex_unlock(&data->update_lock);
 	return count;
 }
-static ssize_t show_pwm_auto_pwm_minctl(struct device *dev, char *buf, int nr)
+
+static ssize_t show_pwm_auto_pwm_minctl(struct device *dev,
+		struct device_attribute *attr, char *buf)
 {
+	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
 	return sprintf(buf,"%d\n", data->autofan[nr].min_off);
 }
-static ssize_t set_pwm_auto_pwm_minctl(struct device *dev, const char *buf,
-	size_t count, int nr)
+
+static ssize_t set_pwm_auto_pwm_minctl(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
 {
+	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
 	long val = simple_strtol(buf, NULL, 10);
@@ -760,14 +745,19 @@ static ssize_t set_pwm_auto_pwm_minctl(s
 	mutex_unlock(&data->update_lock);
 	return count;
 }
-static ssize_t show_pwm_auto_pwm_freq(struct device *dev, char *buf, int nr)
+
+static ssize_t show_pwm_auto_pwm_freq(struct device *dev,
+		struct device_attribute *attr, char *buf)
 {
+	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
 	return sprintf(buf,"%d\n", FREQ_FROM_REG(data->autofan[nr].freq));
 }
-static ssize_t set_pwm_auto_pwm_freq(struct device *dev, const char *buf,
-		size_t count, int nr)
+
+static ssize_t set_pwm_auto_pwm_freq(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
 {
+	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
 	long val = simple_strtol(buf, NULL, 10);
@@ -781,74 +771,40 @@ static ssize_t set_pwm_auto_pwm_freq(str
 	mutex_unlock(&data->update_lock);
 	return count;
 }
+
 #define pwm_auto(offset)						\
-static ssize_t show_pwm##offset##_auto_channels (struct device *dev, struct device_attribute *attr,	\
-	char *buf)							\
-{									\
-	return show_pwm_auto_channels(dev, buf, offset - 1);		\
-}									\
-static ssize_t set_pwm##offset##_auto_channels (struct device *dev, struct device_attribute *attr,	\
-	const char *buf, size_t count)					\
-{									\
-	return set_pwm_auto_channels(dev, buf, count, offset - 1);	\
-}									\
-static ssize_t show_pwm##offset##_auto_pwm_min (struct device *dev, struct device_attribute *attr,	\
-	char *buf)							\
-{									\
-	return show_pwm_auto_pwm_min(dev, buf, offset - 1);		\
-}									\
-static ssize_t set_pwm##offset##_auto_pwm_min (struct device *dev, struct device_attribute *attr,	\
-	const char *buf, size_t count)					\
-{									\
-	return set_pwm_auto_pwm_min(dev, buf, count, offset - 1);	\
-}									\
-static ssize_t show_pwm##offset##_auto_pwm_minctl (struct device *dev, struct device_attribute *attr,	\
-	char *buf)							\
-{									\
-	return show_pwm_auto_pwm_minctl(dev, buf, offset - 1);		\
-}									\
-static ssize_t set_pwm##offset##_auto_pwm_minctl (struct device *dev, struct device_attribute *attr,	\
-	const char *buf, size_t count)					\
-{									\
-	return set_pwm_auto_pwm_minctl(dev, buf, count, offset - 1);	\
-}									\
-static ssize_t show_pwm##offset##_auto_pwm_freq (struct device *dev, struct device_attribute *attr,	\
-	char *buf)							\
-{									\
-	return show_pwm_auto_pwm_freq(dev, buf, offset - 1);		\
-}									\
-static ssize_t set_pwm##offset##_auto_pwm_freq(struct device *dev, struct device_attribute *attr,	\
-	const char *buf, size_t count)					\
-{									\
-	return set_pwm_auto_pwm_freq(dev, buf, count, offset - 1);	\
-}									\
-static DEVICE_ATTR(pwm##offset##_auto_channels, S_IRUGO | S_IWUSR,	\
-		show_pwm##offset##_auto_channels,			\
-		set_pwm##offset##_auto_channels);			\
-static DEVICE_ATTR(pwm##offset##_auto_pwm_min, S_IRUGO | S_IWUSR,	\
-		show_pwm##offset##_auto_pwm_min,			\
-		set_pwm##offset##_auto_pwm_min);			\
-static DEVICE_ATTR(pwm##offset##_auto_pwm_minctl, S_IRUGO | S_IWUSR,	\
-		show_pwm##offset##_auto_pwm_minctl,			\
-		set_pwm##offset##_auto_pwm_minctl);			\
-static DEVICE_ATTR(pwm##offset##_auto_pwm_freq, S_IRUGO | S_IWUSR,	\
-		show_pwm##offset##_auto_pwm_freq,			\
-		set_pwm##offset##_auto_pwm_freq);              
+static SENSOR_DEVICE_ATTR(pwm##offset##_auto_channels,			\
+		S_IRUGO | S_IWUSR, show_pwm_auto_channels,		\
+		set_pwm_auto_channels, offset - 1);			\
+static SENSOR_DEVICE_ATTR(pwm##offset##_auto_pwm_min,			\
+		S_IRUGO | S_IWUSR, show_pwm_auto_pwm_min,		\
+		set_pwm_auto_pwm_min, offset - 1);			\
+static SENSOR_DEVICE_ATTR(pwm##offset##_auto_pwm_minctl,		\
+		S_IRUGO | S_IWUSR, show_pwm_auto_pwm_minctl,		\
+		set_pwm_auto_pwm_minctl, offset - 1);			\
+static SENSOR_DEVICE_ATTR(pwm##offset##_auto_pwm_freq,			\
+		S_IRUGO | S_IWUSR, show_pwm_auto_pwm_freq,		\
+		set_pwm_auto_pwm_freq, offset - 1);
+
 pwm_auto(1);
 pwm_auto(2);
 pwm_auto(3);
 
 /* Temperature settings for automatic PWM control */
 
-static ssize_t show_temp_auto_temp_off(struct device *dev, char *buf, int nr)
+static ssize_t show_temp_auto_temp_off(struct device *dev,
+		struct device_attribute *attr, char *buf)
 {
+	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
 	return sprintf(buf,"%d\n", TEMP_FROM_REG(data->zone[nr].limit) -
 		HYST_FROM_REG(data->zone[nr].hyst));
 }
-static ssize_t set_temp_auto_temp_off(struct device *dev, const char *buf,
-	size_t count, int nr)
+
+static ssize_t set_temp_auto_temp_off(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
 {
+	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
 	int min;
@@ -871,14 +827,19 @@ static ssize_t set_temp_auto_temp_off(st
 	mutex_unlock(&data->update_lock);
 	return count;
 }
-static ssize_t show_temp_auto_temp_min(struct device *dev, char *buf, int nr)
+
+static ssize_t show_temp_auto_temp_min(struct device *dev,
+		struct device_attribute *attr, char *buf)
 {
+	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
 	return sprintf(buf,"%d\n", TEMP_FROM_REG(data->zone[nr].limit) );
 }
-static ssize_t set_temp_auto_temp_min(struct device *dev, const char *buf,
-	size_t count, int nr)
+
+static ssize_t set_temp_auto_temp_min(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
 {
+	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
 	long val = simple_strtol(buf, NULL, 10);
@@ -913,15 +874,20 @@ static ssize_t set_temp_auto_temp_min(st
 	mutex_unlock(&data->update_lock);
 	return count;
 }
-static ssize_t show_temp_auto_temp_max(struct device *dev, char *buf, int nr)
+
+static ssize_t show_temp_auto_temp_max(struct device *dev,
+		struct device_attribute *attr, char *buf)
 {
+	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
 	return sprintf(buf,"%d\n", TEMP_FROM_REG(data->zone[nr].limit) +
 		RANGE_FROM_REG(data->zone[nr].range));
 }
-static ssize_t set_temp_auto_temp_max(struct device *dev, const char *buf,
-	size_t count, int nr)
+
+static ssize_t set_temp_auto_temp_max(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
 {
+	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
 	int min;
@@ -938,14 +904,19 @@ static ssize_t set_temp_auto_temp_max(st
 	mutex_unlock(&data->update_lock);
 	return count;
 }
-static ssize_t show_temp_auto_temp_crit(struct device *dev, char *buf, int nr)
+
+static ssize_t show_temp_auto_temp_crit(struct device *dev,
+		struct device_attribute *attr, char *buf)
 {
+	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
 	return sprintf(buf,"%d\n", TEMP_FROM_REG(data->zone[nr].critical));
 }
-static ssize_t set_temp_auto_temp_crit(struct device *dev, const char *buf,
-		size_t count, int nr)
+
+static ssize_t set_temp_auto_temp_crit(struct device *dev,
+		struct device_attribute *attr,const char *buf, size_t count)
 {
+	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
 	long val = simple_strtol(buf, NULL, 10);
@@ -957,59 +928,21 @@ static ssize_t set_temp_auto_temp_crit(s
 	mutex_unlock(&data->update_lock);
 	return count;
 }
+
 #define temp_auto(offset)						\
-static ssize_t show_temp##offset##_auto_temp_off (struct device *dev, struct device_attribute *attr,	\
-	char *buf)							\
-{									\
-	return show_temp_auto_temp_off(dev, buf, offset - 1);		\
-}									\
-static ssize_t set_temp##offset##_auto_temp_off (struct device *dev, struct device_attribute *attr,	\
-	const char *buf, size_t count)					\
-{									\
-	return set_temp_auto_temp_off(dev, buf, count, offset - 1);	\
-}									\
-static ssize_t show_temp##offset##_auto_temp_min (struct device *dev, struct device_attribute *attr,	\
-	char *buf)							\
-{									\
-	return show_temp_auto_temp_min(dev, buf, offset - 1);		\
-}									\
-static ssize_t set_temp##offset##_auto_temp_min (struct device *dev, struct device_attribute *attr,	\
-	const char *buf, size_t count)					\
-{									\
-	return set_temp_auto_temp_min(dev, buf, count, offset - 1);	\
-}									\
-static ssize_t show_temp##offset##_auto_temp_max (struct device *dev, struct device_attribute *attr,	\
-	char *buf)							\
-{									\
-	return show_temp_auto_temp_max(dev, buf, offset - 1);		\
-}									\
-static ssize_t set_temp##offset##_auto_temp_max (struct device *dev, struct device_attribute *attr,	\
-	const char *buf, size_t count)					\
-{									\
-	return set_temp_auto_temp_max(dev, buf, count, offset - 1);	\
-}									\
-static ssize_t show_temp##offset##_auto_temp_crit (struct device *dev, struct device_attribute *attr,	\
-	char *buf)							\
-{									\
-	return show_temp_auto_temp_crit(dev, buf, offset - 1);		\
-}									\
-static ssize_t set_temp##offset##_auto_temp_crit (struct device *dev, struct device_attribute *attr,	\
-	const char *buf, size_t count)					\
-{									\
-	return set_temp_auto_temp_crit(dev, buf, count, offset - 1);	\
-}									\
-static DEVICE_ATTR(temp##offset##_auto_temp_off, S_IRUGO | S_IWUSR,	\
-		show_temp##offset##_auto_temp_off,			\
-		set_temp##offset##_auto_temp_off);			\
-static DEVICE_ATTR(temp##offset##_auto_temp_min, S_IRUGO | S_IWUSR,	\
-		show_temp##offset##_auto_temp_min,			\
-		set_temp##offset##_auto_temp_min);			\
-static DEVICE_ATTR(temp##offset##_auto_temp_max, S_IRUGO | S_IWUSR,	\
-		show_temp##offset##_auto_temp_max,			\
-		set_temp##offset##_auto_temp_max);			\
-static DEVICE_ATTR(temp##offset##_auto_temp_crit, S_IRUGO | S_IWUSR,	\
-		show_temp##offset##_auto_temp_crit,			\
-		set_temp##offset##_auto_temp_crit);
+static SENSOR_DEVICE_ATTR(temp##offset##_auto_temp_off,			\
+		S_IRUGO | S_IWUSR, show_temp_auto_temp_off,		\
+		set_temp_auto_temp_off, offset - 1);			\
+static SENSOR_DEVICE_ATTR(temp##offset##_auto_temp_min,			\
+		S_IRUGO | S_IWUSR, show_temp_auto_temp_min,		\
+		set_temp_auto_temp_min, offset - 1);			\
+static SENSOR_DEVICE_ATTR(temp##offset##_auto_temp_max,			\
+		S_IRUGO | S_IWUSR, show_temp_auto_temp_max,		\
+		set_temp_auto_temp_max, offset - 1);			\
+static SENSOR_DEVICE_ATTR(temp##offset##_auto_temp_crit,		\
+		S_IRUGO | S_IWUSR, show_temp_auto_temp_crit,		\
+		set_temp_auto_temp_crit, offset - 1);
+
 temp_auto(1);
 temp_auto(2);
 temp_auto(3);
@@ -1022,69 +955,74 @@ static int lm85_attach_adapter(struct i2
 }
 
 static struct attribute *lm85_attributes[] = {
-	&dev_attr_fan1_input.attr,
-	&dev_attr_fan2_input.attr,
-	&dev_attr_fan3_input.attr,
-	&dev_attr_fan4_input.attr,
-	&dev_attr_fan1_min.attr,
-	&dev_attr_fan2_min.attr,
-	&dev_attr_fan3_min.attr,
-	&dev_attr_fan4_min.attr,
-	&dev_attr_pwm1.attr,
-	&dev_attr_pwm2.attr,
-	&dev_attr_pwm3.attr,
-	&dev_attr_pwm1_enable.attr,
-	&dev_attr_pwm2_enable.attr,
-	&dev_attr_pwm3_enable.attr,
-	&dev_attr_in0_input.attr,
-	&dev_attr_in1_input.attr,
-	&dev_attr_in2_input.attr,
-	&dev_attr_in3_input.attr,
-	&dev_attr_in0_min.attr,
-	&dev_attr_in1_min.attr,
-	&dev_attr_in2_min.attr,
-	&dev_attr_in3_min.attr,
-	&dev_attr_in0_max.attr,
-	&dev_attr_in1_max.attr,
-	&dev_attr_in2_max.attr,
-	&dev_attr_in3_max.attr,
-	&dev_attr_temp1_input.attr,
-	&dev_attr_temp2_input.attr,
-	&dev_attr_temp3_input.attr,
-	&dev_attr_temp1_min.attr,
-	&dev_attr_temp2_min.attr,
-	&dev_attr_temp3_min.attr,
-	&dev_attr_temp1_max.attr,
-	&dev_attr_temp2_max.attr,
-	&dev_attr_temp3_max.attr,
+	&sensor_dev_attr_fan1_input.dev_attr.attr,
+	&sensor_dev_attr_fan2_input.dev_attr.attr,
+	&sensor_dev_attr_fan3_input.dev_attr.attr,
+	&sensor_dev_attr_fan4_input.dev_attr.attr,
+	&sensor_dev_attr_fan1_min.dev_attr.attr,
+	&sensor_dev_attr_fan2_min.dev_attr.attr,
+	&sensor_dev_attr_fan3_min.dev_attr.attr,
+	&sensor_dev_attr_fan4_min.dev_attr.attr,
+
+	&sensor_dev_attr_pwm1.dev_attr.attr,
+	&sensor_dev_attr_pwm2.dev_attr.attr,
+	&sensor_dev_attr_pwm3.dev_attr.attr,
+	&sensor_dev_attr_pwm1_enable.dev_attr.attr,
+	&sensor_dev_attr_pwm2_enable.dev_attr.attr,
+	&sensor_dev_attr_pwm3_enable.dev_attr.attr,
+
+	&sensor_dev_attr_in0_input.dev_attr.attr,
+	&sensor_dev_attr_in1_input.dev_attr.attr,
+	&sensor_dev_attr_in2_input.dev_attr.attr,
+	&sensor_dev_attr_in3_input.dev_attr.attr,
+	&sensor_dev_attr_in0_min.dev_attr.attr,
+	&sensor_dev_attr_in1_min.dev_attr.attr,
+	&sensor_dev_attr_in2_min.dev_attr.attr,
+	&sensor_dev_attr_in3_min.dev_attr.attr,
+	&sensor_dev_attr_in0_max.dev_attr.attr,
+	&sensor_dev_attr_in1_max.dev_attr.attr,
+	&sensor_dev_attr_in2_max.dev_attr.attr,
+	&sensor_dev_attr_in3_max.dev_attr.attr,
+
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp2_input.dev_attr.attr,
+	&sensor_dev_attr_temp3_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_min.dev_attr.attr,
+	&sensor_dev_attr_temp2_min.dev_attr.attr,
+	&sensor_dev_attr_temp3_min.dev_attr.attr,
+	&sensor_dev_attr_temp1_max.dev_attr.attr,
+	&sensor_dev_attr_temp2_max.dev_attr.attr,
+	&sensor_dev_attr_temp3_max.dev_attr.attr,
+
+	&sensor_dev_attr_pwm1_auto_channels.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_channels.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_channels.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_pwm_min.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_pwm_min.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_pwm_min.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_pwm_minctl.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_pwm_minctl.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_pwm_minctl.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_pwm_freq.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_pwm_freq.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_pwm_freq.dev_attr.attr,
+
+	&sensor_dev_attr_temp1_auto_temp_off.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_temp_off.dev_attr.attr,
+	&sensor_dev_attr_temp3_auto_temp_off.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_temp_min.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_temp_min.dev_attr.attr,
+	&sensor_dev_attr_temp3_auto_temp_min.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_temp_max.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_temp_max.dev_attr.attr,
+	&sensor_dev_attr_temp3_auto_temp_max.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_temp_crit.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_temp_crit.dev_attr.attr,
+	&sensor_dev_attr_temp3_auto_temp_crit.dev_attr.attr,
+
 	&dev_attr_vrm.attr,
 	&dev_attr_cpu0_vid.attr,
 	&dev_attr_alarms.attr,
-	&dev_attr_pwm1_auto_channels.attr,
-	&dev_attr_pwm2_auto_channels.attr,
-	&dev_attr_pwm3_auto_channels.attr,
-	&dev_attr_pwm1_auto_pwm_min.attr,
-	&dev_attr_pwm2_auto_pwm_min.attr,
-	&dev_attr_pwm3_auto_pwm_min.attr,
-	&dev_attr_pwm1_auto_pwm_minctl.attr,
-	&dev_attr_pwm2_auto_pwm_minctl.attr,
-	&dev_attr_pwm3_auto_pwm_minctl.attr,
-	&dev_attr_pwm1_auto_pwm_freq.attr,
-	&dev_attr_pwm2_auto_pwm_freq.attr,
-	&dev_attr_pwm3_auto_pwm_freq.attr,
-	&dev_attr_temp1_auto_temp_off.attr,
-	&dev_attr_temp2_auto_temp_off.attr,
-	&dev_attr_temp3_auto_temp_off.attr,
-	&dev_attr_temp1_auto_temp_min.attr,
-	&dev_attr_temp2_auto_temp_min.attr,
-	&dev_attr_temp3_auto_temp_min.attr,
-	&dev_attr_temp1_auto_temp_max.attr,
-	&dev_attr_temp2_auto_temp_max.attr,
-	&dev_attr_temp3_auto_temp_max.attr,
-	&dev_attr_temp1_auto_temp_crit.attr,
-	&dev_attr_temp2_auto_temp_crit.attr,
-	&dev_attr_temp3_auto_temp_crit.attr,
-
 	NULL
 };
 
@@ -1093,10 +1031,9 @@ static const struct attribute_group lm85
 };
 
 static struct attribute *lm85_attributes_opt[] = {
-	&dev_attr_in4_input.attr,
-	&dev_attr_in4_min.attr,
-	&dev_attr_in4_max.attr,
-
+	&sensor_dev_attr_in4_input.dev_attr.attr,
+	&sensor_dev_attr_in4_min.dev_attr.attr,
+	&sensor_dev_attr_in4_max.dev_attr.attr,
 	NULL
 };
 
@@ -1250,11 +1187,11 @@ static int lm85_detect(struct i2c_adapte
 	data->vid = lm85_read_value(new_client, LM85_REG_VID);
 	if (!(kind = adt7463 && (data->vid & 0x80)))
 		if ((err = device_create_file(&new_client->dev,
-					&dev_attr_in4_input))
+					&sensor_dev_attr_in4_input.dev_attr))
 		 || (err = device_create_file(&new_client->dev,
-					&dev_attr_in4_min))
+					&sensor_dev_attr_in4_min.dev_attr))
 		 || (err = device_create_file(&new_client->dev,
-					&dev_attr_in4_max)))
+					&sensor_dev_attr_in4_max.dev_attr)))
 			goto ERROR3;
 
 	data->class_dev = hwmon_device_register(&new_client->dev);

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
