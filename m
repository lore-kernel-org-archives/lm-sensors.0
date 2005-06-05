From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 05 Jun 2005 11:52:54 +0000
Subject: [lm-sensors] [PATCH 2.6] drivers/i2c/chips/it87.c: use dynamic
Message-Id: <20050605115325.27cd4429.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Yani, Greg, all,

> Here is a patch against it87, since it seems to have many more device
> attributes than lm90. The size difference:
> 
> before:
> Module                  Size  Used by
> it87                   28832  0
> after:
> Module                  Size  Used by
> it87                   22432  0

It seems that this patch never made it to Greg's tree. I have been
testing it for two weeks now, and no problem arose, so I'd like it to be
applied. Let's not lose the work that was done. Just like the adm1026
patch, the original it87 patch had some coding style error, which I
fixed. New patch attached. Please apply, thanks.

--------------------------------------------------------------

This patch modifies the it87 hardware monitoring driver to take benefit
of the new sysfs callback features introduced by Yani Ioannou, making
the code much clearer and the resulting driver significantly smaller.

From: Yani Ioannou <yani.ioannou@gmail.com>
Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/i2c/chips/it87.c |  387 ++++++++++++++++++++++-------------------------
 1 files changed, 183 insertions(+), 204 deletions(-)

--- linux-2.6.12-rc5.orig/drivers/i2c/chips/it87.c	2005-06-05 10:53:57.000000000 +0200
+++ linux-2.6.12-rc5/drivers/i2c/chips/it87.c	2005-06-05 11:51:22.000000000 +0200
@@ -37,6 +37,7 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
+#include <linux/i2c-sysfs.h>
 #include <linux/i2c-vid.h>
 #include <asm/io.h>
 
@@ -238,27 +239,42 @@
 	.detach_client	= it87_detach_client,
 };
 
-static ssize_t show_in(struct device *dev, char *buf, int nr)
+static ssize_t show_in(struct device *dev, struct device_attribute *attr,
+		char *buf)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
 	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf, "%d\n", IN_FROM_REG(data->in[nr]));
 }
 
-static ssize_t show_in_min(struct device *dev, char *buf, int nr)
+static ssize_t show_in_min(struct device *dev, struct device_attribute *attr,
+		char *buf)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
 	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf, "%d\n", IN_FROM_REG(data->in_min[nr]));
 }
 
-static ssize_t show_in_max(struct device *dev, char *buf, int nr)
+static ssize_t show_in_max(struct device *dev, struct device_attribute *attr,
+		char *buf)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
 	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf, "%d\n", IN_FROM_REG(data->in_max[nr]));
 }
 
-static ssize_t set_in_min(struct device *dev, const char *buf, 
-		size_t count, int nr)
+static ssize_t set_in_min(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
@@ -270,9 +286,12 @@
 	up(&data->update_lock);
 	return count;
 }
-static ssize_t set_in_max(struct device *dev, const char *buf, 
-		size_t count, int nr)
+static ssize_t set_in_max(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
@@ -286,38 +305,14 @@
 }
 
 #define show_in_offset(offset)					\
-static ssize_t							\
-	show_in##offset (struct device *dev, struct device_attribute *attr, char *buf)		\
-{								\
-	return show_in(dev, buf, offset);			\
-}								\
-static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_in##offset, NULL);
+static SENSOR_DEVICE_ATTR(in##offset##_input, S_IRUGO,		\
+		show_in, NULL, offset);
 
 #define limit_in_offset(offset)					\
-static ssize_t							\
-	show_in##offset##_min (struct device *dev, struct device_attribute *attr, char *buf)	\
-{								\
-	return show_in_min(dev, buf, offset);			\
-}								\
-static ssize_t							\
-	show_in##offset##_max (struct device *dev, struct device_attribute *attr, char *buf)	\
-{								\
-	return show_in_max(dev, buf, offset);			\
-}								\
-static ssize_t set_in##offset##_min (struct device *dev, struct device_attribute *attr, 	\
-		const char *buf, size_t count) 			\
-{								\
-	return set_in_min(dev, buf, count, offset);		\
-}								\
-static ssize_t set_in##offset##_max (struct device *dev, struct device_attribute *attr,	\
-			const char *buf, size_t count)		\
-{								\
-	return set_in_max(dev, buf, count, offset);		\
-}								\
-static DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR, 	\
-		show_in##offset##_min, set_in##offset##_min);	\
-static DEVICE_ATTR(in##offset##_max, S_IRUGO | S_IWUSR, 	\
-		show_in##offset##_max, set_in##offset##_max);
+static SENSOR_DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR,	\
+		show_in_min, set_in_min, offset);		\
+static SENSOR_DEVICE_ATTR(in##offset##_max, S_IRUGO | S_IWUSR,	\
+		show_in_max, set_in_max, offset);
 
 show_in_offset(0);
 limit_in_offset(0);
@@ -338,24 +333,39 @@
 show_in_offset(8);
 
 /* 3 temperatures */
-static ssize_t show_temp(struct device *dev, char *buf, int nr)
+static ssize_t show_temp(struct device *dev, struct device_attribute *attr,
+		char *buf)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
 	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[nr]));
 }
-static ssize_t show_temp_max(struct device *dev, char *buf, int nr)
+static ssize_t show_temp_max(struct device *dev, struct device_attribute *attr,
+		char *buf)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
 	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_high[nr]));
 }
-static ssize_t show_temp_min(struct device *dev, char *buf, int nr)
+static ssize_t show_temp_min(struct device *dev, struct device_attribute *attr,
+		char *buf)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
 	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_low[nr]));
 }
-static ssize_t set_temp_max(struct device *dev, const char *buf, 
-		size_t count, int nr)
+static ssize_t set_temp_max(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
@@ -366,9 +376,12 @@
 	up(&data->update_lock);
 	return count;
 }
-static ssize_t set_temp_min(struct device *dev, const char *buf, 
-		size_t count, int nr)
+static ssize_t set_temp_min(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
@@ -380,42 +393,23 @@
 	return count;
 }
 #define show_temp_offset(offset)					\
-static ssize_t show_temp_##offset (struct device *dev, struct device_attribute *attr, char *buf)	\
-{									\
-	return show_temp(dev, buf, offset - 1);				\
-}									\
-static ssize_t								\
-show_temp_##offset##_max (struct device *dev, struct device_attribute *attr, char *buf)		\
-{									\
-	return show_temp_max(dev, buf, offset - 1);			\
-}									\
-static ssize_t								\
-show_temp_##offset##_min (struct device *dev, struct device_attribute *attr, char *buf)		\
-{									\
-	return show_temp_min(dev, buf, offset - 1);			\
-}									\
-static ssize_t set_temp_##offset##_max (struct device *dev, struct device_attribute *attr, 		\
-		const char *buf, size_t count) 				\
-{									\
-	return set_temp_max(dev, buf, count, offset - 1);		\
-}									\
-static ssize_t set_temp_##offset##_min (struct device *dev, struct device_attribute *attr, 		\
-		const char *buf, size_t count) 				\
-{									\
-	return set_temp_min(dev, buf, count, offset - 1);		\
-}									\
-static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_temp_##offset, NULL); \
-static DEVICE_ATTR(temp##offset##_max, S_IRUGO | S_IWUSR, 		\
-		show_temp_##offset##_max, set_temp_##offset##_max); 	\
-static DEVICE_ATTR(temp##offset##_min, S_IRUGO | S_IWUSR, 		\
-		show_temp_##offset##_min, set_temp_##offset##_min);	
+static SENSOR_DEVICE_ATTR(temp##offset##_input, S_IRUGO,		\
+		show_temp, NULL, offset - 1);				\
+static SENSOR_DEVICE_ATTR(temp##offset##_max, S_IRUGO | S_IWUSR,	\
+		show_temp_max, set_temp_max, offset - 1);		\
+static SENSOR_DEVICE_ATTR(temp##offset##_min, S_IRUGO | S_IWUSR,	\
+		show_temp_min, set_temp_min, offset - 1);
 
 show_temp_offset(1);
 show_temp_offset(2);
 show_temp_offset(3);
 
-static ssize_t show_sensor(struct device *dev, char *buf, int nr)
+static ssize_t show_sensor(struct device *dev, struct device_attribute *attr,
+		char *buf)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
 	struct it87_data *data = it87_update_device(dev);
 	u8 reg = data->sensor; /* In case the value is updated while we use it */
 	
@@ -425,9 +419,12 @@
 		return sprintf(buf, "2\n");  /* thermistor */
 	return sprintf(buf, "0\n");      /* disabled */
 }
-static ssize_t set_sensor(struct device *dev, const char *buf, 
-		size_t count, int nr)
+static ssize_t set_sensor(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
@@ -450,53 +447,67 @@
 	return count;
 }
 #define show_sensor_offset(offset)					\
-static ssize_t show_sensor_##offset (struct device *dev, struct device_attribute *attr, char *buf)	\
-{									\
-	return show_sensor(dev, buf, offset - 1);			\
-}									\
-static ssize_t set_sensor_##offset (struct device *dev, struct device_attribute *attr, 		\
-		const char *buf, size_t count) 				\
-{									\
-	return set_sensor(dev, buf, count, offset - 1);			\
-}									\
-static DEVICE_ATTR(temp##offset##_type, S_IRUGO | S_IWUSR, 		\
-		show_sensor_##offset, set_sensor_##offset);
+static SENSOR_DEVICE_ATTR(temp##offset##_type, S_IRUGO | S_IWUSR,	\
+		show_sensor, set_sensor, offset - 1);
 
 show_sensor_offset(1);
 show_sensor_offset(2);
 show_sensor_offset(3);
 
 /* 3 Fans */
-static ssize_t show_fan(struct device *dev, char *buf, int nr)
+static ssize_t show_fan(struct device *dev, struct device_attribute *attr,
+		char *buf)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
 	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf,"%d\n", FAN_FROM_REG(data->fan[nr], 
 				DIV_FROM_REG(data->fan_div[nr])));
 }
-static ssize_t show_fan_min(struct device *dev, char *buf, int nr)
+static ssize_t show_fan_min(struct device *dev, struct device_attribute *attr,
+		char *buf)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
 	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf,"%d\n",
 		FAN_FROM_REG(data->fan_min[nr], DIV_FROM_REG(data->fan_div[nr])));
 }
-static ssize_t show_fan_div(struct device *dev, char *buf, int nr)
+static ssize_t show_fan_div(struct device *dev, struct device_attribute *attr,
+		char *buf)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
 	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf, "%d\n", DIV_FROM_REG(data->fan_div[nr]));
 }
-static ssize_t show_pwm_enable(struct device *dev, char *buf, int nr)
+static ssize_t show_pwm_enable(struct device *dev, struct device_attribute *attr,
+		char *buf)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
 	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf,"%d\n", (data->fan_main_ctrl & (1 << nr)) ? 1 : 0);
 }
-static ssize_t show_pwm(struct device *dev, char *buf, int nr)
+static ssize_t show_pwm(struct device *dev, struct device_attribute *attr,
+		char *buf)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
 	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf,"%d\n", data->manual_pwm_ctl[nr]);
 }
-static ssize_t set_fan_min(struct device *dev, const char *buf, 
-		size_t count, int nr)
+static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
@@ -507,9 +518,12 @@
 	up(&data->update_lock);
 	return count;
 }
-static ssize_t set_fan_div(struct device *dev, const char *buf, 
-		size_t count, int nr)
+static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
@@ -547,9 +561,12 @@
 	up(&data->update_lock);
 	return count;
 }
-static ssize_t set_pwm_enable(struct device *dev, const char *buf,
-		size_t count, int nr)
+static ssize_t set_pwm_enable(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
@@ -578,9 +595,12 @@
 	up(&data->update_lock);
 	return count;
 }
-static ssize_t set_pwm(struct device *dev, const char *buf,
-		size_t count, int nr)
+static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
@@ -596,64 +616,23 @@
 	return count;
 }
 
-#define show_fan_offset(offset)						\
-static ssize_t show_fan_##offset (struct device *dev, struct device_attribute *attr, char *buf)	\
-{									\
-	return show_fan(dev, buf, offset - 1);				\
-}									\
-static ssize_t show_fan_##offset##_min (struct device *dev, struct device_attribute *attr, char *buf)	\
-{									\
-	return show_fan_min(dev, buf, offset - 1);			\
-}									\
-static ssize_t show_fan_##offset##_div (struct device *dev, struct device_attribute *attr, char *buf)	\
-{									\
-	return show_fan_div(dev, buf, offset - 1);			\
-}									\
-static ssize_t set_fan_##offset##_min (struct device *dev, struct device_attribute *attr, 		\
-	const char *buf, size_t count) 					\
-{									\
-	return set_fan_min(dev, buf, count, offset - 1);		\
-}									\
-static ssize_t set_fan_##offset##_div (struct device *dev, struct device_attribute *attr, 		\
-		const char *buf, size_t count) 				\
-{									\
-	return set_fan_div(dev, buf, count, offset - 1);		\
-}									\
-static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_fan_##offset, NULL); \
-static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, 		\
-		show_fan_##offset##_min, set_fan_##offset##_min); 	\
-static DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR, 		\
-		show_fan_##offset##_div, set_fan_##offset##_div);
+#define show_fan_offset(offset)					\
+static SENSOR_DEVICE_ATTR(fan##offset##_input, S_IRUGO,		\
+		show_fan, NULL, offset - 1);			\
+static SENSOR_DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, \
+		show_fan_min, set_fan_min, offset - 1);		\
+static SENSOR_DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR, \
+		show_fan_div, set_fan_div, offset - 1);
 
 show_fan_offset(1);
 show_fan_offset(2);
 show_fan_offset(3);
 
 #define show_pwm_offset(offset)						\
-static ssize_t show_pwm##offset##_enable (struct device *dev, struct device_attribute *attr,		\
-	char *buf)							\
-{									\
-	return show_pwm_enable(dev, buf, offset - 1);			\
-}									\
-static ssize_t show_pwm##offset (struct device *dev, struct device_attribute *attr, char *buf)		\
-{									\
-	return show_pwm(dev, buf, offset - 1);				\
-}									\
-static ssize_t set_pwm##offset##_enable (struct device *dev, struct device_attribute *attr,		\
-		const char *buf, size_t count)				\
-{									\
-	return set_pwm_enable(dev, buf, count, offset - 1);		\
-}									\
-static ssize_t set_pwm##offset (struct device *dev, struct device_attribute *attr,			\
-		const char *buf, size_t count)				\
-{									\
-	return set_pwm(dev, buf, count, offset - 1);			\
-}									\
-static DEVICE_ATTR(pwm##offset##_enable, S_IRUGO | S_IWUSR,		\
-		show_pwm##offset##_enable,				\
-		set_pwm##offset##_enable);				\
-static DEVICE_ATTR(pwm##offset, S_IRUGO | S_IWUSR,			\
-		show_pwm##offset , set_pwm##offset );
+static SENSOR_DEVICE_ATTR(pwm##offset##_enable, S_IRUGO | S_IWUSR,	\
+		show_pwm_enable, set_pwm_enable, offset - 1);		\
+static SENSOR_DEVICE_ATTR(pwm##offset, S_IRUGO | S_IWUSR,		\
+		show_pwm, set_pwm, offset - 1);
 
 show_pwm_offset(1);
 show_pwm_offset(2);
@@ -861,60 +840,60 @@
 	it87_init_client(new_client, data);
 
 	/* Register sysfs hooks */
-	device_create_file(&new_client->dev, &dev_attr_in0_input);
-	device_create_file(&new_client->dev, &dev_attr_in1_input);
-	device_create_file(&new_client->dev, &dev_attr_in2_input);
-	device_create_file(&new_client->dev, &dev_attr_in3_input);
-	device_create_file(&new_client->dev, &dev_attr_in4_input);
-	device_create_file(&new_client->dev, &dev_attr_in5_input);
-	device_create_file(&new_client->dev, &dev_attr_in6_input);
-	device_create_file(&new_client->dev, &dev_attr_in7_input);
-	device_create_file(&new_client->dev, &dev_attr_in8_input);
-	device_create_file(&new_client->dev, &dev_attr_in0_min);
-	device_create_file(&new_client->dev, &dev_attr_in1_min);
-	device_create_file(&new_client->dev, &dev_attr_in2_min);
-	device_create_file(&new_client->dev, &dev_attr_in3_min);
-	device_create_file(&new_client->dev, &dev_attr_in4_min);
-	device_create_file(&new_client->dev, &dev_attr_in5_min);
-	device_create_file(&new_client->dev, &dev_attr_in6_min);
-	device_create_file(&new_client->dev, &dev_attr_in7_min);
-	device_create_file(&new_client->dev, &dev_attr_in0_max);
-	device_create_file(&new_client->dev, &dev_attr_in1_max);
-	device_create_file(&new_client->dev, &dev_attr_in2_max);
-	device_create_file(&new_client->dev, &dev_attr_in3_max);
-	device_create_file(&new_client->dev, &dev_attr_in4_max);
-	device_create_file(&new_client->dev, &dev_attr_in5_max);
-	device_create_file(&new_client->dev, &dev_attr_in6_max);
-	device_create_file(&new_client->dev, &dev_attr_in7_max);
-	device_create_file(&new_client->dev, &dev_attr_temp1_input);
-	device_create_file(&new_client->dev, &dev_attr_temp2_input);
-	device_create_file(&new_client->dev, &dev_attr_temp3_input);
-	device_create_file(&new_client->dev, &dev_attr_temp1_max);
-	device_create_file(&new_client->dev, &dev_attr_temp2_max);
-	device_create_file(&new_client->dev, &dev_attr_temp3_max);
-	device_create_file(&new_client->dev, &dev_attr_temp1_min);
-	device_create_file(&new_client->dev, &dev_attr_temp2_min);
-	device_create_file(&new_client->dev, &dev_attr_temp3_min);
-	device_create_file(&new_client->dev, &dev_attr_temp1_type);
-	device_create_file(&new_client->dev, &dev_attr_temp2_type);
-	device_create_file(&new_client->dev, &dev_attr_temp3_type);
-	device_create_file(&new_client->dev, &dev_attr_fan1_input);
-	device_create_file(&new_client->dev, &dev_attr_fan2_input);
-	device_create_file(&new_client->dev, &dev_attr_fan3_input);
-	device_create_file(&new_client->dev, &dev_attr_fan1_min);
-	device_create_file(&new_client->dev, &dev_attr_fan2_min);
-	device_create_file(&new_client->dev, &dev_attr_fan3_min);
-	device_create_file(&new_client->dev, &dev_attr_fan1_div);
-	device_create_file(&new_client->dev, &dev_attr_fan2_div);
-	device_create_file(&new_client->dev, &dev_attr_fan3_div);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in0_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in1_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in2_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in3_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in4_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in5_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in6_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in7_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in8_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in0_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in1_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in2_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in3_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in4_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in5_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in6_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in7_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in0_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in1_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in2_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in3_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in4_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in5_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in6_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in7_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp1_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp2_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp3_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp1_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp2_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp3_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp1_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp2_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp3_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp1_type.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp2_type.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp3_type.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan1_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan2_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan3_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan1_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan2_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan3_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan1_div.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan2_div.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan3_div.dev_attr);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
 	if (enable_pwm_interface) {
-		device_create_file(&new_client->dev, &dev_attr_pwm1_enable);
-		device_create_file(&new_client->dev, &dev_attr_pwm2_enable);
-		device_create_file(&new_client->dev, &dev_attr_pwm3_enable);
-		device_create_file(&new_client->dev, &dev_attr_pwm1);
-		device_create_file(&new_client->dev, &dev_attr_pwm2);
-		device_create_file(&new_client->dev, &dev_attr_pwm3);
+		device_create_file(&new_client->dev, &sensor_dev_attr_pwm1_enable.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_pwm2_enable.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_pwm3_enable.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_pwm1.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_pwm2.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_pwm3.dev_attr);
 	}
 
 	if (data->type = it8712) {


-- 
Jean Delvare
