From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 02 Dec 2007 22:39:38 +0000
Subject: [lm-sensors] [PATCH 3/4] hwmon: (adm1031) Get rid of
Message-Id: <20071202233938.7c3cfb03@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use the standard dynamic sysfs callbacks instead of macro-generated
wrappers. It makes the code more simple and the binary smaller (-8% on
my system.)

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/adm1031.c |  323 +++++++++++++++++++----------------------------
 1 file changed, 131 insertions(+), 192 deletions(-)

--- linux-2.6.24-rc3.orig/drivers/hwmon/adm1031.c	2007-12-01 15:58:23.000000000 +0100
+++ linux-2.6.24-rc3/drivers/hwmon/adm1031.c	2007-12-01 15:59:16.000000000 +0100
@@ -27,6 +27,7 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
 
@@ -245,17 +246,21 @@ get_fan_auto_nearest(struct adm1031_data
 	return 0;
 }
 
-static ssize_t show_fan_auto_channel(struct device *dev, char *buf, int nr)
+static ssize_t show_fan_auto_channel(struct device *dev,
+				     struct device_attribute *attr, char *buf)
 {
+	int nr = to_sensor_dev_attr(attr)->index;
 	struct adm1031_data *data = adm1031_update_device(dev);
 	return sprintf(buf, "%d\n", GET_FAN_AUTO_BITFIELD(data, nr));
 }
 
 static ssize_t
-set_fan_auto_channel(struct device *dev, const char *buf, size_t count, int nr)
+set_fan_auto_channel(struct device *dev, struct device_attribute *attr,
+		     const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1031_data *data = i2c_get_clientdata(client);
+	int nr = to_sensor_dev_attr(attr)->index;
 	int val = simple_strtol(buf, NULL, 10);
 	u8 reg;
 	int ret;
@@ -294,41 +299,35 @@ set_fan_auto_channel(struct device *dev,
 	return count;
 }
 
-#define fan_auto_channel_offset(offset)						\
-static ssize_t show_fan_auto_channel_##offset (struct device *dev, struct device_attribute *attr, char *buf)	\
-{										\
-	return show_fan_auto_channel(dev, buf, offset - 1);			\
-}										\
-static ssize_t set_fan_auto_channel_##offset (struct device *dev, struct device_attribute *attr,		\
-	const char *buf, size_t count)						\
-{										\
-	return set_fan_auto_channel(dev, buf, count, offset - 1);		\
-}										\
-static DEVICE_ATTR(auto_fan##offset##_channel, S_IRUGO | S_IWUSR,		\
-		   show_fan_auto_channel_##offset,				\
-		   set_fan_auto_channel_##offset)
-
-fan_auto_channel_offset(1);
-fan_auto_channel_offset(2);
+static SENSOR_DEVICE_ATTR(auto_fan1_channel, S_IRUGO | S_IWUSR,
+		show_fan_auto_channel, set_fan_auto_channel, 0);
+static SENSOR_DEVICE_ATTR(auto_fan2_channel, S_IRUGO | S_IWUSR,
+		show_fan_auto_channel, set_fan_auto_channel, 1);
 
 /* Auto Temps */
-static ssize_t show_auto_temp_off(struct device *dev, char *buf, int nr)
+static ssize_t show_auto_temp_off(struct device *dev,
+				  struct device_attribute *attr, char *buf)
 {
+	int nr = to_sensor_dev_attr(attr)->index;
 	struct adm1031_data *data = adm1031_update_device(dev);
 	return sprintf(buf, "%d\n",
 		       AUTO_TEMP_OFF_FROM_REG(data->auto_temp[nr]));
 }
-static ssize_t show_auto_temp_min(struct device *dev, char *buf, int nr)
+static ssize_t show_auto_temp_min(struct device *dev,
+				  struct device_attribute *attr, char *buf)
 {
+	int nr = to_sensor_dev_attr(attr)->index;
 	struct adm1031_data *data = adm1031_update_device(dev);
 	return sprintf(buf, "%d\n",
 		       AUTO_TEMP_MIN_FROM_REG(data->auto_temp[nr]));
 }
 static ssize_t
-set_auto_temp_min(struct device *dev, const char *buf, size_t count, int nr)
+set_auto_temp_min(struct device *dev, struct device_attribute *attr,
+		  const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1031_data *data = i2c_get_clientdata(client);
+	int nr = to_sensor_dev_attr(attr)->index;
 	int val = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
@@ -338,17 +337,21 @@ set_auto_temp_min(struct device *dev, co
 	mutex_unlock(&data->update_lock);
 	return count;
 }
-static ssize_t show_auto_temp_max(struct device *dev, char *buf, int nr)
+static ssize_t show_auto_temp_max(struct device *dev,
+				  struct device_attribute *attr, char *buf)
 {
+	int nr = to_sensor_dev_attr(attr)->index;
 	struct adm1031_data *data = adm1031_update_device(dev);
 	return sprintf(buf, "%d\n",
 		       AUTO_TEMP_MAX_FROM_REG(data->auto_temp[nr]));
 }
 static ssize_t
-set_auto_temp_max(struct device *dev, const char *buf, size_t count, int nr)
+set_auto_temp_max(struct device *dev, struct device_attribute *attr,
+		  const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1031_data *data = i2c_get_clientdata(client);
+	int nr = to_sensor_dev_attr(attr)->index;
 	int val = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
@@ -359,51 +362,32 @@ set_auto_temp_max(struct device *dev, co
 	return count;
 }
 
-#define auto_temp_reg(offset)							\
-static ssize_t show_auto_temp_##offset##_off (struct device *dev, struct device_attribute *attr, char *buf)	\
-{										\
-	return show_auto_temp_off(dev, buf, offset - 1);			\
-}										\
-static ssize_t show_auto_temp_##offset##_min (struct device *dev, struct device_attribute *attr, char *buf)	\
-{										\
-	return show_auto_temp_min(dev, buf, offset - 1);			\
-}										\
-static ssize_t show_auto_temp_##offset##_max (struct device *dev, struct device_attribute *attr, char *buf)	\
-{										\
-	return show_auto_temp_max(dev, buf, offset - 1);			\
-}										\
-static ssize_t set_auto_temp_##offset##_min (struct device *dev, struct device_attribute *attr,		\
-					     const char *buf, size_t count)	\
-{										\
-	return set_auto_temp_min(dev, buf, count, offset - 1);		\
-}										\
-static ssize_t set_auto_temp_##offset##_max (struct device *dev, struct device_attribute *attr,		\
-					     const char *buf, size_t count)	\
-{										\
-	return set_auto_temp_max(dev, buf, count, offset - 1);		\
-}										\
-static DEVICE_ATTR(auto_temp##offset##_off, S_IRUGO,				\
-		   show_auto_temp_##offset##_off, NULL);			\
-static DEVICE_ATTR(auto_temp##offset##_min, S_IRUGO | S_IWUSR,			\
-		   show_auto_temp_##offset##_min, set_auto_temp_##offset##_min);\
-static DEVICE_ATTR(auto_temp##offset##_max, S_IRUGO | S_IWUSR,			\
-		   show_auto_temp_##offset##_max, set_auto_temp_##offset##_max)
+#define auto_temp_reg(offset)						\
+static SENSOR_DEVICE_ATTR(auto_temp##offset##_off, S_IRUGO,		\
+		show_auto_temp_off, NULL, offset - 1);			\
+static SENSOR_DEVICE_ATTR(auto_temp##offset##_min, S_IRUGO | S_IWUSR,	\
+		show_auto_temp_min, set_auto_temp_min, offset - 1);	\
+static SENSOR_DEVICE_ATTR(auto_temp##offset##_max, S_IRUGO | S_IWUSR,	\
+		show_auto_temp_max, set_auto_temp_max, offset - 1)
 
 auto_temp_reg(1);
 auto_temp_reg(2);
 auto_temp_reg(3);
 
 /* pwm */
-static ssize_t show_pwm(struct device *dev, char *buf, int nr)
+static ssize_t show_pwm(struct device *dev,
+			struct device_attribute *attr, char *buf)
 {
+	int nr = to_sensor_dev_attr(attr)->index;
 	struct adm1031_data *data = adm1031_update_device(dev);
 	return sprintf(buf, "%d\n", PWM_FROM_REG(data->pwm[nr]));
 }
-static ssize_t
-set_pwm(struct device *dev, const char *buf, size_t count, int nr)
+static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
+		       const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1031_data *data = i2c_get_clientdata(client);
+	int nr = to_sensor_dev_attr(attr)->index;
 	int val = simple_strtol(buf, NULL, 10);
 	int reg;
 
@@ -423,21 +407,12 @@ set_pwm(struct device *dev, const char *
 	return count;
 }
 
-#define pwm_reg(offset)							\
-static ssize_t show_pwm_##offset (struct device *dev, struct device_attribute *attr, char *buf)	\
-{									\
-	return show_pwm(dev, buf, offset - 1);			\
-}									\
-static ssize_t set_pwm_##offset (struct device *dev, struct device_attribute *attr,			\
-				 const char *buf, size_t count)		\
-{									\
-	return set_pwm(dev, buf, count, offset - 1);		\
-}									\
-static DEVICE_ATTR(pwm##offset, S_IRUGO | S_IWUSR,			\
-		   show_pwm_##offset, set_pwm_##offset)
-
-pwm_reg(1);
-pwm_reg(2);
+static SENSOR_DEVICE_ATTR(pwm1, S_IRUGO | S_IWUSR, show_pwm, set_pwm, 0);
+static SENSOR_DEVICE_ATTR(pwm2, S_IRUGO | S_IWUSR, show_pwm, set_pwm, 1);
+static SENSOR_DEVICE_ATTR(auto_fan1_min_pwm, S_IRUGO | S_IWUSR,
+		show_pwm, set_pwm, 0);
+static SENSOR_DEVICE_ATTR(auto_fan2_min_pwm, S_IRUGO | S_IWUSR,
+		show_pwm, set_pwm, 1);
 
 /* Fans */
 
@@ -484,8 +459,10 @@ static int trust_fan_readings(struct adm
 }
 
 
-static ssize_t show_fan(struct device *dev, char *buf, int nr)
+static ssize_t show_fan(struct device *dev,
+			struct device_attribute *attr, char *buf)
 {
+	int nr = to_sensor_dev_attr(attr)->index;
 	struct adm1031_data *data = adm1031_update_device(dev);
 	int value;
 
@@ -494,23 +471,28 @@ static ssize_t show_fan(struct device *d
 	return sprintf(buf, "%d\n", value);
 }
 
-static ssize_t show_fan_div(struct device *dev, char *buf, int nr)
+static ssize_t show_fan_div(struct device *dev,
+			    struct device_attribute *attr, char *buf)
 {
+	int nr = to_sensor_dev_attr(attr)->index;
 	struct adm1031_data *data = adm1031_update_device(dev);
 	return sprintf(buf, "%d\n", FAN_DIV_FROM_REG(data->fan_div[nr]));
 }
-static ssize_t show_fan_min(struct device *dev, char *buf, int nr)
+static ssize_t show_fan_min(struct device *dev,
+			    struct device_attribute *attr, char *buf)
 {
+	int nr = to_sensor_dev_attr(attr)->index;
 	struct adm1031_data *data = adm1031_update_device(dev);
 	return sprintf(buf, "%d\n",
 		       FAN_FROM_REG(data->fan_min[nr],
 				    FAN_DIV_FROM_REG(data->fan_div[nr])));
 }
-static ssize_t
-set_fan_min(struct device *dev, const char *buf, size_t count, int nr)
+static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1031_data *data = i2c_get_clientdata(client);
+	int nr = to_sensor_dev_attr(attr)->index;
 	int val = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
@@ -524,11 +506,12 @@ set_fan_min(struct device *dev, const ch
 	mutex_unlock(&data->update_lock);
 	return count;
 }
-static ssize_t
-set_fan_div(struct device *dev, const char *buf, size_t count, int nr)
+static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1031_data *data = i2c_get_clientdata(client);
+	int nr = to_sensor_dev_attr(attr)->index;
 	int val = simple_strtol(buf, NULL, 10);
 	u8 tmp;
 	int old_div;
@@ -567,44 +550,22 @@ set_fan_div(struct device *dev, const ch
 }
 
 #define fan_offset(offset)						\
-static ssize_t show_fan_##offset (struct device *dev, struct device_attribute *attr, char *buf)	\
-{									\
-	return show_fan(dev, buf, offset - 1);			\
-}									\
-static ssize_t show_fan_##offset##_min (struct device *dev, struct device_attribute *attr, char *buf)	\
-{									\
-	return show_fan_min(dev, buf, offset - 1);			\
-}									\
-static ssize_t show_fan_##offset##_div (struct device *dev, struct device_attribute *attr, char *buf)	\
-{									\
-	return show_fan_div(dev, buf, offset - 1);			\
-}									\
-static ssize_t set_fan_##offset##_min (struct device *dev, struct device_attribute *attr,		\
-	const char *buf, size_t count)					\
-{									\
-	return set_fan_min(dev, buf, count, offset - 1);		\
-}									\
-static ssize_t set_fan_##offset##_div (struct device *dev, struct device_attribute *attr,		\
-	const char *buf, size_t count)					\
-{									\
-	return set_fan_div(dev, buf, count, offset - 1);		\
-}									\
-static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_fan_##offset,	\
-		   NULL);						\
-static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR,		\
-		   show_fan_##offset##_min, set_fan_##offset##_min);	\
-static DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR,		\
-		   show_fan_##offset##_div, set_fan_##offset##_div);	\
-static DEVICE_ATTR(auto_fan##offset##_min_pwm, S_IRUGO | S_IWUSR,	\
-		   show_pwm_##offset, set_pwm_##offset)
+static SENSOR_DEVICE_ATTR(fan##offset##_input, S_IRUGO,			\
+		show_fan, NULL, offset - 1);				\
+static SENSOR_DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR,		\
+		show_fan_min, set_fan_min, offset - 1);			\
+static SENSOR_DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR,		\
+		show_fan_div, set_fan_div, offset - 1)
 
 fan_offset(1);
 fan_offset(2);
 
 
 /* Temps */
-static ssize_t show_temp(struct device *dev, char *buf, int nr)
+static ssize_t show_temp(struct device *dev,
+			 struct device_attribute *attr, char *buf)
 {
+	int nr = to_sensor_dev_attr(attr)->index;
 	struct adm1031_data *data = adm1031_update_device(dev);
 	int ext;
 	ext = nr = 0 ?
@@ -612,26 +573,33 @@ static ssize_t show_temp(struct device *
 	    (((data->ext_temp[nr] >> ((nr - 1) * 3)) & 7));
 	return sprintf(buf, "%d\n", TEMP_FROM_REG_EXT(data->temp[nr], ext));
 }
-static ssize_t show_temp_min(struct device *dev, char *buf, int nr)
+static ssize_t show_temp_min(struct device *dev,
+			     struct device_attribute *attr, char *buf)
 {
+	int nr = to_sensor_dev_attr(attr)->index;
 	struct adm1031_data *data = adm1031_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_min[nr]));
 }
-static ssize_t show_temp_max(struct device *dev, char *buf, int nr)
+static ssize_t show_temp_max(struct device *dev,
+			     struct device_attribute *attr, char *buf)
 {
+	int nr = to_sensor_dev_attr(attr)->index;
 	struct adm1031_data *data = adm1031_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_max[nr]));
 }
-static ssize_t show_temp_crit(struct device *dev, char *buf, int nr)
+static ssize_t show_temp_crit(struct device *dev,
+			      struct device_attribute *attr, char *buf)
 {
+	int nr = to_sensor_dev_attr(attr)->index;
 	struct adm1031_data *data = adm1031_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_crit[nr]));
 }
-static ssize_t
-set_temp_min(struct device *dev, const char *buf, size_t count, int nr)
+static ssize_t set_temp_min(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1031_data *data = i2c_get_clientdata(client);
+	int nr = to_sensor_dev_attr(attr)->index;
 	int val;
 
 	val = simple_strtol(buf, NULL, 10);
@@ -643,11 +611,12 @@ set_temp_min(struct device *dev, const c
 	mutex_unlock(&data->update_lock);
 	return count;
 }
-static ssize_t
-set_temp_max(struct device *dev, const char *buf, size_t count, int nr)
+static ssize_t set_temp_max(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1031_data *data = i2c_get_clientdata(client);
+	int nr = to_sensor_dev_attr(attr)->index;
 	int val;
 
 	val = simple_strtol(buf, NULL, 10);
@@ -659,11 +628,12 @@ set_temp_max(struct device *dev, const c
 	mutex_unlock(&data->update_lock);
 	return count;
 }
-static ssize_t
-set_temp_crit(struct device *dev, const char *buf, size_t count, int nr)
+static ssize_t set_temp_crit(struct device *dev, struct device_attribute *attr,
+			     const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1031_data *data = i2c_get_clientdata(client);
+	int nr = to_sensor_dev_attr(attr)->index;
 	int val;
 
 	val = simple_strtol(buf, NULL, 10);
@@ -676,46 +646,15 @@ set_temp_crit(struct device *dev, const 
 	return count;
 }
 
-#define temp_reg(offset)							\
-static ssize_t show_temp_##offset (struct device *dev, struct device_attribute *attr, char *buf)		\
-{										\
-	return show_temp(dev, buf, offset - 1);				\
-}										\
-static ssize_t show_temp_##offset##_min (struct device *dev, struct device_attribute *attr, char *buf)		\
-{										\
-	return show_temp_min(dev, buf, offset - 1);				\
-}										\
-static ssize_t show_temp_##offset##_max (struct device *dev, struct device_attribute *attr, char *buf)		\
-{										\
-	return show_temp_max(dev, buf, offset - 1);				\
-}										\
-static ssize_t show_temp_##offset##_crit (struct device *dev, struct device_attribute *attr, char *buf)	\
-{										\
-	return show_temp_crit(dev, buf, offset - 1);			\
-}										\
-static ssize_t set_temp_##offset##_min (struct device *dev, struct device_attribute *attr,			\
-					const char *buf, size_t count)		\
-{										\
-	return set_temp_min(dev, buf, count, offset - 1);			\
-}										\
-static ssize_t set_temp_##offset##_max (struct device *dev, struct device_attribute *attr,			\
-					const char *buf, size_t count)		\
-{										\
-	return set_temp_max(dev, buf, count, offset - 1);			\
-}										\
-static ssize_t set_temp_##offset##_crit (struct device *dev, struct device_attribute *attr,			\
-					 const char *buf, size_t count)		\
-{										\
-	return set_temp_crit(dev, buf, count, offset - 1);			\
-}										\
-static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_temp_##offset,		\
-		   NULL);							\
-static DEVICE_ATTR(temp##offset##_min, S_IRUGO | S_IWUSR,			\
-		   show_temp_##offset##_min, set_temp_##offset##_min);		\
-static DEVICE_ATTR(temp##offset##_max, S_IRUGO | S_IWUSR,			\
-		   show_temp_##offset##_max, set_temp_##offset##_max);		\
-static DEVICE_ATTR(temp##offset##_crit, S_IRUGO | S_IWUSR,			\
-		   show_temp_##offset##_crit, set_temp_##offset##_crit)
+#define temp_reg(offset)						\
+static SENSOR_DEVICE_ATTR(temp##offset##_input, S_IRUGO,		\
+		show_temp, NULL, offset - 1);				\
+static SENSOR_DEVICE_ATTR(temp##offset##_min, S_IRUGO | S_IWUSR,	\
+		show_temp_min, set_temp_min, offset - 1);		\
+static SENSOR_DEVICE_ATTR(temp##offset##_max, S_IRUGO | S_IWUSR,	\
+		show_temp_max, set_temp_max, offset - 1);		\
+static SENSOR_DEVICE_ATTR(temp##offset##_crit, S_IRUGO | S_IWUSR,	\
+		show_temp_crit, set_temp_crit, offset - 1)
 
 temp_reg(1);
 temp_reg(2);
@@ -739,29 +678,29 @@ static int adm1031_attach_adapter(struct
 }
 
 static struct attribute *adm1031_attributes[] = {
-	&dev_attr_fan1_input.attr,
-	&dev_attr_fan1_div.attr,
-	&dev_attr_fan1_min.attr,
-	&dev_attr_pwm1.attr,
-	&dev_attr_auto_fan1_channel.attr,
-	&dev_attr_temp1_input.attr,
-	&dev_attr_temp1_min.attr,
-	&dev_attr_temp1_max.attr,
-	&dev_attr_temp1_crit.attr,
-	&dev_attr_temp2_input.attr,
-	&dev_attr_temp2_min.attr,
-	&dev_attr_temp2_max.attr,
-	&dev_attr_temp2_crit.attr,
-
-	&dev_attr_auto_temp1_off.attr,
-	&dev_attr_auto_temp1_min.attr,
-	&dev_attr_auto_temp1_max.attr,
-
-	&dev_attr_auto_temp2_off.attr,
-	&dev_attr_auto_temp2_min.attr,
-	&dev_attr_auto_temp2_max.attr,
+	&sensor_dev_attr_fan1_input.dev_attr.attr,
+	&sensor_dev_attr_fan1_div.dev_attr.attr,
+	&sensor_dev_attr_fan1_min.dev_attr.attr,
+	&sensor_dev_attr_pwm1.dev_attr.attr,
+	&sensor_dev_attr_auto_fan1_channel.dev_attr.attr,
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_min.dev_attr.attr,
+	&sensor_dev_attr_temp1_max.dev_attr.attr,
+	&sensor_dev_attr_temp1_crit.dev_attr.attr,
+	&sensor_dev_attr_temp2_input.dev_attr.attr,
+	&sensor_dev_attr_temp2_min.dev_attr.attr,
+	&sensor_dev_attr_temp2_max.dev_attr.attr,
+	&sensor_dev_attr_temp2_crit.dev_attr.attr,
+
+	&sensor_dev_attr_auto_temp1_off.dev_attr.attr,
+	&sensor_dev_attr_auto_temp1_min.dev_attr.attr,
+	&sensor_dev_attr_auto_temp1_max.dev_attr.attr,
+
+	&sensor_dev_attr_auto_temp2_off.dev_attr.attr,
+	&sensor_dev_attr_auto_temp2_min.dev_attr.attr,
+	&sensor_dev_attr_auto_temp2_max.dev_attr.attr,
 
-	&dev_attr_auto_fan1_min_pwm.attr,
+	&sensor_dev_attr_auto_fan1_min_pwm.dev_attr.attr,
 
 	&dev_attr_alarms.attr,
 
@@ -773,19 +712,19 @@ static const struct attribute_group adm1
 };
 
 static struct attribute *adm1031_attributes_opt[] = {
-	&dev_attr_fan2_input.attr,
-	&dev_attr_fan2_div.attr,
-	&dev_attr_fan2_min.attr,
-	&dev_attr_pwm2.attr,
-	&dev_attr_auto_fan2_channel.attr,
-	&dev_attr_temp3_input.attr,
-	&dev_attr_temp3_min.attr,
-	&dev_attr_temp3_max.attr,
-	&dev_attr_temp3_crit.attr,
-	&dev_attr_auto_temp3_off.attr,
-	&dev_attr_auto_temp3_min.attr,
-	&dev_attr_auto_temp3_max.attr,
-	&dev_attr_auto_fan2_min_pwm.attr,
+	&sensor_dev_attr_fan2_input.dev_attr.attr,
+	&sensor_dev_attr_fan2_div.dev_attr.attr,
+	&sensor_dev_attr_fan2_min.dev_attr.attr,
+	&sensor_dev_attr_pwm2.dev_attr.attr,
+	&sensor_dev_attr_auto_fan2_channel.dev_attr.attr,
+	&sensor_dev_attr_temp3_input.dev_attr.attr,
+	&sensor_dev_attr_temp3_min.dev_attr.attr,
+	&sensor_dev_attr_temp3_max.dev_attr.attr,
+	&sensor_dev_attr_temp3_crit.dev_attr.attr,
+	&sensor_dev_attr_auto_temp3_off.dev_attr.attr,
+	&sensor_dev_attr_auto_temp3_min.dev_attr.attr,
+	&sensor_dev_attr_auto_temp3_max.dev_attr.attr,
+	&sensor_dev_attr_auto_fan2_min_pwm.dev_attr.attr,
 	NULL
 };
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
