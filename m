From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 04 Nov 2007 22:45:14 +0000
Subject: [lm-sensors] [PATCH 3/4] hwmon: (gl520sm) De-macro the sysfs
Message-Id: <20071104234514.1b60d6f0@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use standard dynamic sysfs callbacks instead of macro-generated
wrappers. This makes the code more readable, and the binary smaller
(by about 11%).

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/gl520sm.c |  416 +++++++++++++++++++++++++++--------------------
 1 file changed, 243 insertions(+), 173 deletions(-)

--- linux-2.6.24-rc1.orig/drivers/hwmon/gl520sm.c	2007-11-04 20:59:28.000000000 +0100
+++ linux-2.6.24-rc1/drivers/hwmon/gl520sm.c	2007-11-04 22:15:12.000000000 +0100
@@ -27,6 +27,7 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
 #include <linux/hwmon-vid.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
@@ -126,93 +127,13 @@ struct gl520_data {
  * Sysfs stuff
  */
 
-#define sysfs_r(type, n, item, reg) \
-static ssize_t get_##type##item (struct gl520_data *, char *, int); \
-static ssize_t get_##type##n##item (struct device *, struct device_attribute *attr, char *); \
-static ssize_t get_##type##n##item (struct device *dev, struct device_attribute *attr, char *buf) \
-{ \
-	struct gl520_data *data = gl520_update_device(dev); \
-	return get_##type##item(data, buf, (n)); \
-}
-
-#define sysfs_w(type, n, item, reg) \
-static ssize_t set_##type##item (struct i2c_client *, struct gl520_data *, const char *, size_t, int, int); \
-static ssize_t set_##type##n##item (struct device *, struct device_attribute *attr, const char *, size_t); \
-static ssize_t set_##type##n##item (struct device *dev, struct device_attribute *attr, const char *buf, size_t count) \
-{ \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct gl520_data *data = i2c_get_clientdata(client); \
-	return set_##type##item(client, data, buf, count, (n), reg); \
-}
-
-#define sysfs_rw_n(type, n, item, reg) \
-sysfs_r(type, n, item, reg) \
-sysfs_w(type, n, item, reg) \
-static DEVICE_ATTR(type##n##item, S_IRUGO | S_IWUSR, get_##type##n##item, set_##type##n##item);
-
-#define sysfs_ro_n(type, n, item, reg) \
-sysfs_r(type, n, item, reg) \
-static DEVICE_ATTR(type##n##item, S_IRUGO, get_##type##n##item, NULL);
-
-#define sysfs_rw(type, item, reg) \
-sysfs_r(type, 0, item, reg) \
-sysfs_w(type, 0, item, reg) \
-static DEVICE_ATTR(type##item, S_IRUGO | S_IWUSR, get_##type##0##item, set_##type##0##item);
-
-#define sysfs_ro(type, item, reg) \
-sysfs_r(type, 0, item, reg) \
-static DEVICE_ATTR(type##item, S_IRUGO, get_##type##0##item, NULL);
-
-
-#define sysfs_vid(n) \
-sysfs_ro_n(cpu, n, _vid, GL520_REG_VID_INPUT)
-
-#define sysfs_in(n) \
-sysfs_ro_n(in, n, _input, GL520_REG_IN_INPUT[n]) \
-sysfs_rw_n(in, n, _min, GL520_REG_IN_MIN[n]) \
-sysfs_rw_n(in, n, _max, GL520_REG_IN_MAX[n])
-
-#define sysfs_fan(n) \
-sysfs_ro_n(fan, n, _input, GL520_REG_FAN_INPUT) \
-sysfs_rw_n(fan, n, _min, GL520_REG_FAN_MIN) \
-sysfs_rw_n(fan, n, _div, GL520_REG_FAN_DIV)
-
-#define sysfs_fan_off(n) \
-sysfs_rw_n(fan, n, _off, GL520_REG_FAN_OFF)
-
-#define sysfs_temp(n) \
-sysfs_ro_n(temp, n, _input, GL520_REG_TEMP_INPUT[(n) - 1]) \
-sysfs_rw_n(temp, n, _max, GL520_REG_TEMP_MAX[(n) - 1]) \
-sysfs_rw_n(temp, n, _max_hyst, GL520_REG_TEMP_MAX_HYST[(n) - 1])
-
-#define sysfs_alarms() \
-sysfs_ro(alarms, , GL520_REG_ALARMS) \
-sysfs_rw(beep_enable, , GL520_REG_BEEP_ENABLE) \
-sysfs_rw(beep_mask, , GL520_REG_BEEP_MASK)
-
-
-sysfs_vid(0)
-
-sysfs_in(0)
-sysfs_in(1)
-sysfs_in(2)
-sysfs_in(3)
-sysfs_in(4)
-
-sysfs_fan(1)
-sysfs_fan(2)
-sysfs_fan_off(1)
-
-sysfs_temp(1)
-sysfs_temp(2)
-
-sysfs_alarms()
-
-
-static ssize_t get_cpu_vid(struct gl520_data *data, char *buf, int n)
+static ssize_t get_cpu_vid(struct device *dev, struct device_attribute *attr,
+			   char *buf)
 {
+	struct gl520_data *data = gl520_update_device(dev);
 	return sprintf(buf, "%u\n", vid_from_reg(data->vid, data->vrm));
 }
+static DEVICE_ATTR(cpu0_vid, S_IRUGO, get_cpu_vid, NULL);
 
 #define VDD_FROM_REG(val) (((val)*95+2)/4)
 #define VDD_TO_REG(val) (SENSORS_LIMIT((((val)*4+47)/95),0,255))
@@ -220,8 +141,11 @@ static ssize_t get_cpu_vid(struct gl520_
 #define IN_FROM_REG(val) ((val)*19)
 #define IN_TO_REG(val) (SENSORS_LIMIT((((val)+9)/19),0,255))
 
-static ssize_t get_in_input(struct gl520_data *data, char *buf, int n)
+static ssize_t get_in_input(struct device *dev, struct device_attribute *attr,
+			    char *buf)
 {
+	int n = to_sensor_dev_attr(attr)->index;
+	struct gl520_data *data = gl520_update_device(dev);
 	u8 r = data->in_input[n];
 
 	if (n = 0)
@@ -230,8 +154,11 @@ static ssize_t get_in_input(struct gl520
 		return sprintf(buf, "%d\n", IN_FROM_REG(r));
 }
 
-static ssize_t get_in_min(struct gl520_data *data, char *buf, int n)
+static ssize_t get_in_min(struct device *dev, struct device_attribute *attr,
+			  char *buf)
 {
+	int n = to_sensor_dev_attr(attr)->index;
+	struct gl520_data *data = gl520_update_device(dev);
 	u8 r = data->in_min[n];
 
 	if (n = 0)
@@ -240,8 +167,11 @@ static ssize_t get_in_min(struct gl520_d
 		return sprintf(buf, "%d\n", IN_FROM_REG(r));
 }
 
-static ssize_t get_in_max(struct gl520_data *data, char *buf, int n)
+static ssize_t get_in_max(struct device *dev, struct device_attribute *attr,
+			  char *buf)
 {
+	int n = to_sensor_dev_attr(attr)->index;
+	struct gl520_data *data = gl520_update_device(dev);
 	u8 r = data->in_max[n];
 
 	if (n = 0)
@@ -250,8 +180,12 @@ static ssize_t get_in_max(struct gl520_d
 		return sprintf(buf, "%d\n", IN_FROM_REG(r));
 }
 
-static ssize_t set_in_min(struct i2c_client *client, struct gl520_data *data, const char *buf, size_t count, int n, int reg)
+static ssize_t set_in_min(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
 {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct gl520_data *data = i2c_get_clientdata(client);
+	int n = to_sensor_dev_attr(attr)->index;
 	long v = simple_strtol(buf, NULL, 10);
 	u8 r;
 
@@ -265,16 +199,22 @@ static ssize_t set_in_min(struct i2c_cli
 	data->in_min[n] = r;
 
 	if (n < 4)
-		gl520_write_value(client, reg, (gl520_read_value(client, reg) & ~0xff) | r);
+		gl520_write_value(client, GL520_REG_IN_MIN[n],
+				  (gl520_read_value(client, GL520_REG_IN_MIN[n])
+				   & ~0xff) | r);
 	else
-		gl520_write_value(client, reg, r);
+		gl520_write_value(client, GL520_REG_IN_MIN[n], r);
 
 	mutex_unlock(&data->update_lock);
 	return count;
 }
 
-static ssize_t set_in_max(struct i2c_client *client, struct gl520_data *data, const char *buf, size_t count, int n, int reg)
+static ssize_t set_in_max(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
 {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct gl520_data *data = i2c_get_clientdata(client);
+	int n = to_sensor_dev_attr(attr)->index;
 	long v = simple_strtol(buf, NULL, 10);
 	u8 r;
 
@@ -288,57 +228,109 @@ static ssize_t set_in_max(struct i2c_cli
 	data->in_max[n] = r;
 
 	if (n < 4)
-		gl520_write_value(client, reg, (gl520_read_value(client, reg) & ~0xff00) | (r << 8));
+		gl520_write_value(client, GL520_REG_IN_MAX[n],
+				  (gl520_read_value(client, GL520_REG_IN_MAX[n])
+				   & ~0xff00) | (r << 8));
 	else
-		gl520_write_value(client, reg, r);
+		gl520_write_value(client, GL520_REG_IN_MAX[n], r);
 
 	mutex_unlock(&data->update_lock);
 	return count;
 }
 
+static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, get_in_input, NULL, 0);
+static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, get_in_input, NULL, 1);
+static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, get_in_input, NULL, 2);
+static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO, get_in_input, NULL, 3);
+static SENSOR_DEVICE_ATTR(in4_input, S_IRUGO, get_in_input, NULL, 4);
+static SENSOR_DEVICE_ATTR(in0_min, S_IRUGO | S_IWUSR,
+		get_in_min, set_in_min, 0);
+static SENSOR_DEVICE_ATTR(in1_min, S_IRUGO | S_IWUSR,
+		get_in_min, set_in_min, 1);
+static SENSOR_DEVICE_ATTR(in2_min, S_IRUGO | S_IWUSR,
+		get_in_min, set_in_min, 2);
+static SENSOR_DEVICE_ATTR(in3_min, S_IRUGO | S_IWUSR,
+		get_in_min, set_in_min, 3);
+static SENSOR_DEVICE_ATTR(in4_min, S_IRUGO | S_IWUSR,
+		get_in_min, set_in_min, 4);
+static SENSOR_DEVICE_ATTR(in0_max, S_IRUGO | S_IWUSR,
+		get_in_max, set_in_max, 0);
+static SENSOR_DEVICE_ATTR(in1_max, S_IRUGO | S_IWUSR,
+		get_in_max, set_in_max, 1);
+static SENSOR_DEVICE_ATTR(in2_max, S_IRUGO | S_IWUSR,
+		get_in_max, set_in_max, 2);
+static SENSOR_DEVICE_ATTR(in3_max, S_IRUGO | S_IWUSR,
+		get_in_max, set_in_max, 3);
+static SENSOR_DEVICE_ATTR(in4_max, S_IRUGO | S_IWUSR,
+		get_in_max, set_in_max, 4);
+
 #define DIV_FROM_REG(val) (1 << (val))
 #define FAN_FROM_REG(val,div) ((val)=0 ? 0 : (480000/((val) << (div))))
 #define FAN_TO_REG(val,div) ((val)<=0?0:SENSORS_LIMIT((480000 + ((val) << ((div)-1))) / ((val) << (div)), 1, 255));
 
-static ssize_t get_fan_input(struct gl520_data *data, char *buf, int n)
+static ssize_t get_fan_input(struct device *dev, struct device_attribute *attr,
+			     char *buf)
 {
-	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan_input[n - 1], data->fan_div[n - 1]));
+	int n = to_sensor_dev_attr(attr)->index;
+	struct gl520_data *data = gl520_update_device(dev);
+
+	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan_input[n],
+						 data->fan_div[n]));
 }
 
-static ssize_t get_fan_min(struct gl520_data *data, char *buf, int n)
+static ssize_t get_fan_min(struct device *dev, struct device_attribute *attr,
+			   char *buf)
 {
-	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan_min[n - 1], data->fan_div[n - 1]));
+	int n = to_sensor_dev_attr(attr)->index;
+	struct gl520_data *data = gl520_update_device(dev);
+
+	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan_min[n],
+						 data->fan_div[n]));
 }
 
-static ssize_t get_fan_div(struct gl520_data *data, char *buf, int n)
+static ssize_t get_fan_div(struct device *dev, struct device_attribute *attr,
+			   char *buf)
 {
-	return sprintf(buf, "%d\n", DIV_FROM_REG(data->fan_div[n - 1]));
+	int n = to_sensor_dev_attr(attr)->index;
+	struct gl520_data *data = gl520_update_device(dev);
+
+	return sprintf(buf, "%d\n", DIV_FROM_REG(data->fan_div[n]));
 }
 
-static ssize_t get_fan_off(struct gl520_data *data, char *buf, int n)
+static ssize_t get_fan_off(struct device *dev, struct device_attribute *attr,
+			   char *buf)
 {
+	struct gl520_data *data = gl520_update_device(dev);
 	return sprintf(buf, "%d\n", data->fan_off);
 }
 
-static ssize_t set_fan_min(struct i2c_client *client, struct gl520_data *data, const char *buf, size_t count, int n, int reg)
+static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
 {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct gl520_data *data = i2c_get_clientdata(client);
+	int n = to_sensor_dev_attr(attr)->index;
 	unsigned long v = simple_strtoul(buf, NULL, 10);
 	u8 r;
 
 	mutex_lock(&data->update_lock);
-	r = FAN_TO_REG(v, data->fan_div[n - 1]);
-	data->fan_min[n - 1] = r;
+	r = FAN_TO_REG(v, data->fan_div[n]);
+	data->fan_min[n] = r;
 
-	if (n = 1)
-		gl520_write_value(client, reg, (gl520_read_value(client, reg) & ~0xff00) | (r << 8));
-	else
-		gl520_write_value(client, reg, (gl520_read_value(client, reg) & ~0xff) | r);
+	if (n = 0)
+		gl520_write_value(client, GL520_REG_FAN_MIN,
+				  (gl520_read_value(client, GL520_REG_FAN_MIN)
+				   & ~0xff00) | (r << 8));
+	else
+		gl520_write_value(client, GL520_REG_FAN_MIN,
+				  (gl520_read_value(client, GL520_REG_FAN_MIN)
+				   & ~0xff) | r);
 
 	data->beep_mask = gl520_read_value(client, GL520_REG_BEEP_MASK);
-	if (data->fan_min[n - 1] = 0)
-		data->alarm_mask &= (n = 1) ? ~0x20 : ~0x40;
+	if (data->fan_min[n] = 0)
+		data->alarm_mask &= (n = 0) ? ~0x20 : ~0x40;
 	else
-		data->alarm_mask |= (n = 1) ? 0x20 : 0x40;
+		data->alarm_mask |= (n = 0) ? 0x20 : 0x40;
 	data->beep_mask &= data->alarm_mask;
 	gl520_write_value(client, GL520_REG_BEEP_MASK, data->beep_mask);
 
@@ -346,8 +338,12 @@ static ssize_t set_fan_min(struct i2c_cl
 	return count;
 }
 
-static ssize_t set_fan_div(struct i2c_client *client, struct gl520_data *data, const char *buf, size_t count, int n, int reg)
+static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
 {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct gl520_data *data = i2c_get_clientdata(client);
+	int n = to_sensor_dev_attr(attr)->index;
 	unsigned long v = simple_strtoul(buf, NULL, 10);
 	u8 r;
 
@@ -362,133 +358,207 @@ static ssize_t set_fan_div(struct i2c_cl
 	}
 
 	mutex_lock(&data->update_lock);
-	data->fan_div[n - 1] = r;
+	data->fan_div[n] = r;
 
-	if (n = 1)
-		gl520_write_value(client, reg, (gl520_read_value(client, reg) & ~0xc0) | (r << 6));
-	else
-		gl520_write_value(client, reg, (gl520_read_value(client, reg) & ~0x30) | (r << 4));
+	if (n = 0)
+		gl520_write_value(client, GL520_REG_FAN_DIV,
+				  (gl520_read_value(client, GL520_REG_FAN_DIV)
+				   & ~0xc0) | (r << 6));
+	else
+		gl520_write_value(client, GL520_REG_FAN_DIV,
+				  (gl520_read_value(client, GL520_REG_FAN_DIV)
+				   & ~0x30) | (r << 4));
 
 	mutex_unlock(&data->update_lock);
 	return count;
 }
 
-static ssize_t set_fan_off(struct i2c_client *client, struct gl520_data *data, const char *buf, size_t count, int n, int reg)
+static ssize_t set_fan_off(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
 {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct gl520_data *data = i2c_get_clientdata(client);
 	u8 r = simple_strtoul(buf, NULL, 10)?1:0;
 
 	mutex_lock(&data->update_lock);
 	data->fan_off = r;
-	gl520_write_value(client, reg, (gl520_read_value(client, reg) & ~0x0c) | (r << 2));
+	gl520_write_value(client, GL520_REG_FAN_OFF,
+			  (gl520_read_value(client, GL520_REG_FAN_OFF)
+			   & ~0x0c) | (r << 2));
 	mutex_unlock(&data->update_lock);
 	return count;
 }
 
+static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, get_fan_input, NULL, 0);
+static SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, get_fan_input, NULL, 1);
+static SENSOR_DEVICE_ATTR(fan1_min, S_IRUGO | S_IWUSR,
+		get_fan_min, set_fan_min, 0);
+static SENSOR_DEVICE_ATTR(fan2_min, S_IRUGO | S_IWUSR,
+		get_fan_min, set_fan_min, 1);
+static SENSOR_DEVICE_ATTR(fan1_div, S_IRUGO | S_IWUSR,
+		get_fan_div, set_fan_div, 0);
+static SENSOR_DEVICE_ATTR(fan2_div, S_IRUGO | S_IWUSR,
+		get_fan_div, set_fan_div, 1);
+static DEVICE_ATTR(fan1_off, S_IRUGO | S_IWUSR,
+		get_fan_off, set_fan_off);
+
 #define TEMP_FROM_REG(val) (((val) - 130) * 1000)
 #define TEMP_TO_REG(val) (SENSORS_LIMIT(((((val)<0?(val)-500:(val)+500) / 1000)+130),0,255))
 
-static ssize_t get_temp_input(struct gl520_data *data, char *buf, int n)
+static ssize_t get_temp_input(struct device *dev, struct device_attribute *attr,
+			      char *buf)
 {
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_input[n - 1]));
+	int n = to_sensor_dev_attr(attr)->index;
+	struct gl520_data *data = gl520_update_device(dev);
+
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_input[n]));
 }
 
-static ssize_t get_temp_max(struct gl520_data *data, char *buf, int n)
+static ssize_t get_temp_max(struct device *dev, struct device_attribute *attr,
+			    char *buf)
 {
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_max[n - 1]));
+	int n = to_sensor_dev_attr(attr)->index;
+	struct gl520_data *data = gl520_update_device(dev);
+
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_max[n]));
 }
 
-static ssize_t get_temp_max_hyst(struct gl520_data *data, char *buf, int n)
+static ssize_t get_temp_max_hyst(struct device *dev, struct device_attribute
+				 *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_max_hyst[n - 1]));
+	int n = to_sensor_dev_attr(attr)->index;
+	struct gl520_data *data = gl520_update_device(dev);
+
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_max_hyst[n]));
 }
 
-static ssize_t set_temp_max(struct i2c_client *client, struct gl520_data *data, const char *buf, size_t count, int n, int reg)
+static ssize_t set_temp_max(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
 {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct gl520_data *data = i2c_get_clientdata(client);
+	int n = to_sensor_dev_attr(attr)->index;
 	long v = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
-	data->temp_max[n - 1] = TEMP_TO_REG(v);
-	gl520_write_value(client, reg, data->temp_max[n - 1]);
+	data->temp_max[n] = TEMP_TO_REG(v);
+	gl520_write_value(client, GL520_REG_TEMP_MAX[n], data->temp_max[n]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
 
-static ssize_t set_temp_max_hyst(struct i2c_client *client, struct gl520_data *data, const char *buf, size_t count, int n, int reg)
+static ssize_t set_temp_max_hyst(struct device *dev, struct device_attribute
+				 *attr, const char *buf, size_t count)
 {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct gl520_data *data = i2c_get_clientdata(client);
+	int n = to_sensor_dev_attr(attr)->index;
 	long v = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
-	data->temp_max_hyst[n - 1] = TEMP_TO_REG(v);
-	gl520_write_value(client, reg, data->temp_max_hyst[n - 1]);
+	data->temp_max_hyst[n] = TEMP_TO_REG(v);
+	gl520_write_value(client, GL520_REG_TEMP_MAX_HYST[n],
+			  data->temp_max_hyst[n]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
 
-static ssize_t get_alarms(struct gl520_data *data, char *buf, int n)
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, get_temp_input, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, get_temp_input, NULL, 1);
+static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO | S_IWUSR,
+		get_temp_max, set_temp_max, 0);
+static SENSOR_DEVICE_ATTR(temp2_max, S_IRUGO | S_IWUSR,
+		get_temp_max, set_temp_max, 1);
+static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IRUGO | S_IWUSR,
+		get_temp_max_hyst, set_temp_max_hyst, 0);
+static SENSOR_DEVICE_ATTR(temp2_max_hyst, S_IRUGO | S_IWUSR,
+		get_temp_max_hyst, set_temp_max_hyst, 1);
+
+static ssize_t get_alarms(struct device *dev, struct device_attribute *attr,
+			  char *buf)
 {
+	struct gl520_data *data = gl520_update_device(dev);
 	return sprintf(buf, "%d\n", data->alarms);
 }
 
-static ssize_t get_beep_enable(struct gl520_data *data, char *buf, int n)
+static ssize_t get_beep_enable(struct device *dev, struct device_attribute
+			       *attr, char *buf)
 {
+	struct gl520_data *data = gl520_update_device(dev);
 	return sprintf(buf, "%d\n", data->beep_enable);
 }
 
-static ssize_t get_beep_mask(struct gl520_data *data, char *buf, int n)
+static ssize_t get_beep_mask(struct device *dev, struct device_attribute *attr,
+			     char *buf)
 {
+	struct gl520_data *data = gl520_update_device(dev);
 	return sprintf(buf, "%d\n", data->beep_mask);
 }
 
-static ssize_t set_beep_enable(struct i2c_client *client, struct gl520_data *data, const char *buf, size_t count, int n, int reg)
+static ssize_t set_beep_enable(struct device *dev, struct device_attribute
+			       *attr, const char *buf, size_t count)
 {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct gl520_data *data = i2c_get_clientdata(client);
 	u8 r = simple_strtoul(buf, NULL, 10)?0:1;
 
 	mutex_lock(&data->update_lock);
 	data->beep_enable = !r;
-	gl520_write_value(client, reg, (gl520_read_value(client, reg) & ~0x04) | (r << 2));
+	gl520_write_value(client, GL520_REG_BEEP_ENABLE,
+			  (gl520_read_value(client, GL520_REG_BEEP_ENABLE)
+			   & ~0x04) | (r << 2));
 	mutex_unlock(&data->update_lock);
 	return count;
 }
 
-static ssize_t set_beep_mask(struct i2c_client *client, struct gl520_data *data, const char *buf, size_t count, int n, int reg)
+static ssize_t set_beep_mask(struct device *dev, struct device_attribute *attr,
+			     const char *buf, size_t count)
 {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct gl520_data *data = i2c_get_clientdata(client);
 	u8 r = simple_strtoul(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
 	r &= data->alarm_mask;
 	data->beep_mask = r;
-	gl520_write_value(client, reg, r);
+	gl520_write_value(client, GL520_REG_BEEP_MASK, r);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
 
+static DEVICE_ATTR(alarms, S_IRUGO, get_alarms, NULL);
+static DEVICE_ATTR(beep_enable, S_IRUGO | S_IWUSR,
+		get_beep_enable, set_beep_enable);
+static DEVICE_ATTR(beep_mask, S_IRUGO | S_IWUSR,
+		get_beep_mask, set_beep_mask);
+
 static struct attribute *gl520_attributes[] = {
 	&dev_attr_cpu0_vid.attr,
 
-	&dev_attr_in0_input.attr,
-	&dev_attr_in0_min.attr,
-	&dev_attr_in0_max.attr,
-	&dev_attr_in1_input.attr,
-	&dev_attr_in1_min.attr,
-	&dev_attr_in1_max.attr,
-	&dev_attr_in2_input.attr,
-	&dev_attr_in2_min.attr,
-	&dev_attr_in2_max.attr,
-	&dev_attr_in3_input.attr,
-	&dev_attr_in3_min.attr,
-	&dev_attr_in3_max.attr,
-
-	&dev_attr_fan1_input.attr,
-	&dev_attr_fan1_min.attr,
-	&dev_attr_fan1_div.attr,
+	&sensor_dev_attr_in0_input.dev_attr.attr,
+	&sensor_dev_attr_in0_min.dev_attr.attr,
+	&sensor_dev_attr_in0_max.dev_attr.attr,
+	&sensor_dev_attr_in1_input.dev_attr.attr,
+	&sensor_dev_attr_in1_min.dev_attr.attr,
+	&sensor_dev_attr_in1_max.dev_attr.attr,
+	&sensor_dev_attr_in2_input.dev_attr.attr,
+	&sensor_dev_attr_in2_min.dev_attr.attr,
+	&sensor_dev_attr_in2_max.dev_attr.attr,
+	&sensor_dev_attr_in3_input.dev_attr.attr,
+	&sensor_dev_attr_in3_min.dev_attr.attr,
+	&sensor_dev_attr_in3_max.dev_attr.attr,
+
+	&sensor_dev_attr_fan1_input.dev_attr.attr,
+	&sensor_dev_attr_fan1_min.dev_attr.attr,
+	&sensor_dev_attr_fan1_div.dev_attr.attr,
 	&dev_attr_fan1_off.attr,
-	&dev_attr_fan2_input.attr,
-	&dev_attr_fan2_min.attr,
-	&dev_attr_fan2_div.attr,
-
-	&dev_attr_temp1_input.attr,
-	&dev_attr_temp1_max.attr,
-	&dev_attr_temp1_max_hyst.attr,
+	&sensor_dev_attr_fan2_input.dev_attr.attr,
+	&sensor_dev_attr_fan2_min.dev_attr.attr,
+	&sensor_dev_attr_fan2_div.dev_attr.attr,
+
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_max.dev_attr.attr,
+	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
 
 	&dev_attr_alarms.attr,
 	&dev_attr_beep_enable.attr,
@@ -501,13 +571,13 @@ static const struct attribute_group gl52
 };
 
 static struct attribute *gl520_attributes_opt[] = {
-	&dev_attr_in4_input.attr,
-	&dev_attr_in4_min.attr,
-	&dev_attr_in4_max.attr,
-
-	&dev_attr_temp2_input.attr,
-	&dev_attr_temp2_max.attr,
-	&dev_attr_temp2_max_hyst.attr,
+	&sensor_dev_attr_in4_input.dev_attr.attr,
+	&sensor_dev_attr_in4_min.dev_attr.attr,
+	&sensor_dev_attr_in4_max.dev_attr.attr,
+
+	&sensor_dev_attr_temp2_input.dev_attr.attr,
+	&sensor_dev_attr_temp2_max.dev_attr.attr,
+	&sensor_dev_attr_temp2_max_hyst.dev_attr.attr,
 	NULL
 };
 
@@ -579,19 +649,19 @@ static int gl520_detect(struct i2c_adapt
 
 	if (data->two_temps) {
 		if ((err = device_create_file(&client->dev,
-					      &dev_attr_temp2_input))
+				&sensor_dev_attr_temp2_input.dev_attr))
 		 || (err = device_create_file(&client->dev,
-					      &dev_attr_temp2_max))
+				&sensor_dev_attr_temp2_max.dev_attr))
 		 || (err = device_create_file(&client->dev,
-					      &dev_attr_temp2_max_hyst)))
+				&sensor_dev_attr_temp2_max_hyst.dev_attr)))
 			goto exit_remove_files;
 	} else {
 		if ((err = device_create_file(&client->dev,
-					      &dev_attr_in4_input))
+				&sensor_dev_attr_in4_input.dev_attr))
 		 || (err = device_create_file(&client->dev,
-					      &dev_attr_in4_min))
+				&sensor_dev_attr_in4_min.dev_attr))
 		 || (err = device_create_file(&client->dev,
-					      &dev_attr_in4_max)))
+				&sensor_dev_attr_in4_max.dev_attr)))
 			goto exit_remove_files;
 	}
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
