From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Tue, 03 Jan 2012 15:02:11 +0000
Subject: [lm-sensors] [PATCH] drivers/hwmon/lm80.c: fixed checkpatch warnings
Message-Id: <1325602931-10126-1-git-send-email-fransmeulenbroeks@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

fixed all but one checkpatch warnings
the one not fixed is a line too long at line 271.
Found it too hard to decide where to break the line and as
the line was only slightly longer than 80 decided to leave
it as is.

Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
---
 drivers/hwmon/lm80.c |   73 ++++++++++++++++++++++++++++++--------------------
 1 files changed, 44 insertions(+), 29 deletions(-)

diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
index 18a0e6c..0e87634 100644
--- a/drivers/hwmon/lm80.c
+++ b/drivers/hwmon/lm80.c
@@ -66,7 +66,7 @@ static const unsigned short normal_i2c[] = { 0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d,
    these macros are called: arguments may be evaluated more than once.
    Fixing this is just not worth it. */
 
-#define IN_TO_REG(val)		(SENSORS_LIMIT(((val)+5)/10,0,255))
+#define IN_TO_REG(val)		(SENSORS_LIMIT(((val)+5)/10, 0, 255))
 #define IN_FROM_REG(val)	((val)*10)
 
 static inline unsigned char FAN_TO_REG(unsigned rpm, unsigned div)
@@ -77,8 +77,8 @@ static inline unsigned char FAN_TO_REG(unsigned rpm, unsigned div)
 	return SENSORS_LIMIT((1350000 + rpm*div / 2) / (rpm*div), 1, 254);
 }
 
-#define FAN_FROM_REG(val,div)	((val)=0?-1:\
-				(val)=255?0:1350000/((div)*(val)))
+#define FAN_FROM_REG(val, div)	((val) = 0 ? -1 : \
+				(val) = 255 ? 0 : 1350000/((div)*(val)))
 
 static inline long TEMP_FROM_REG(u16 temp)
 {
@@ -93,10 +93,11 @@ static inline long TEMP_FROM_REG(u16 temp)
 	return res / 10;
 }
 
-#define TEMP_LIMIT_FROM_REG(val)	(((val)>0x80?(val)-0x100:(val))*1000)
+#define TEMP_LIMIT_FROM_REG(val)	\
+	(((val) > 0x80 ? (val)-0x100 : (val))*1000)
 
-#define TEMP_LIMIT_TO_REG(val)		SENSORS_LIMIT((val)<0?\
-					((val)-500)/1000:((val)+500)/1000,0,255)
+#define TEMP_LIMIT_TO_REG(val)		SENSORS_LIMIT((val) < 0 ? \
+	((val)-500)/1000 : ((val)+500)/1000, 0, 255)
 
 #define DIV_FROM_REG(val)		(1 << (val))
 
@@ -164,7 +165,8 @@ static struct i2c_driver lm80_driver = {
  */
 
 #define show_in(suffix, value) \
-static ssize_t show_in_##suffix(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_in_##suffix(struct device *dev, \
+	struct device_attribute *attr, char *buf) \
 { \
 	int nr = to_sensor_dev_attr(attr)->index; \
 	struct lm80_data *data = lm80_update_device(dev); \
@@ -175,14 +177,15 @@ show_in(max, in_max)
 show_in(input, in)
 
 #define set_in(suffix, value, reg) \
-static ssize_t set_in_##suffix(struct device *dev, struct device_attribute *attr, const char *buf, \
+static ssize_t set_in_##suffix(struct device *dev, \
+	struct device_attribute *attr, const char *buf, \
 	size_t count) \
 { \
 	int nr = to_sensor_dev_attr(attr)->index; \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct lm80_data *data = i2c_get_clientdata(client); \
-	long val = simple_strtol(buf, NULL, 10); \
- \
+	long val = kstrtol(buf, NULL, 10); \
+\
 	mutex_lock(&data->update_lock);\
 	data->value[nr] = IN_TO_REG(val); \
 	lm80_write_value(client, reg(nr), data->value[nr]); \
@@ -193,7 +196,8 @@ set_in(min, in_min, LM80_REG_IN_MIN)
 set_in(max, in_max, LM80_REG_IN_MAX)
 
 #define show_fan(suffix, value) \
-static ssize_t show_fan_##suffix(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_fan_##suffix(struct device *dev, \
+	struct device_attribute *attr, char *buf) \
 { \
 	int nr = to_sensor_dev_attr(attr)->index; \
 	struct lm80_data *data = lm80_update_device(dev); \
@@ -217,7 +221,7 @@ static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm80_data *data = i2c_get_clientdata(client);
-	long val = simple_strtoul(buf, NULL, 10);
+	long val = kstrtoul(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
 	data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
@@ -236,7 +240,7 @@ static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm80_data *data = i2c_get_clientdata(client);
-	unsigned long min, val = simple_strtoul(buf, NULL, 10);
+	unsigned long min, val = kstrtoul(buf, NULL, 10);
 	u8 reg;
 
 	/* Save fan_min */
@@ -245,10 +249,18 @@ static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
 			   DIV_FROM_REG(data->fan_div[nr]));
 
 	switch (val) {
-	case 1: data->fan_div[nr] = 0; break;
-	case 2: data->fan_div[nr] = 1; break;
-	case 4: data->fan_div[nr] = 2; break;
-	case 8: data->fan_div[nr] = 3; break;
+	case 1:
+		data->fan_div[nr] = 0;
+		break;
+	case 2:
+		data->fan_div[nr] = 1;
+		break;
+	case 4:
+		data->fan_div[nr] = 2;
+		break;
+	case 8:
+		data->fan_div[nr] = 3;
+		break;
 	default:
 		dev_err(&client->dev, "fan_div value %ld not "
 			"supported. Choose one of 1, 2, 4 or 8!\n", val);
@@ -268,14 +280,16 @@ static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-static ssize_t show_temp_input1(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_temp_input1(struct device *dev, \
+	struct device_attribute *attr, char *buf)
 {
 	struct lm80_data *data = lm80_update_device(dev);
 	return sprintf(buf, "%ld\n", TEMP_FROM_REG(data->temp));
 }
 
 #define show_temp(suffix, value) \
-static ssize_t show_temp_##suffix(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_temp_##suffix(struct device *dev, \
+	struct device_attribute *attr, char *buf) \
 { \
 	struct lm80_data *data = lm80_update_device(dev); \
 	return sprintf(buf, "%d\n", TEMP_LIMIT_FROM_REG(data->value)); \
@@ -286,13 +300,13 @@ show_temp(os_max, temp_os_max);
 show_temp(os_hyst, temp_os_hyst);
 
 #define set_temp(suffix, value, reg) \
-static ssize_t set_temp_##suffix(struct device *dev, struct device_attribute *attr, const char *buf, \
-	size_t count) \
+static ssize_t set_temp_##suffix(struct device *dev, \
+	struct device_attribute *attr, const char *buf, size_t count) \
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct lm80_data *data = i2c_get_clientdata(client); \
-	long val = simple_strtoul(buf, NULL, 10); \
- \
+	long val = kstrtoul(buf, NULL, 10); \
+\
 	mutex_lock(&data->update_lock); \
 	data->value = TEMP_LIMIT_TO_REG(val); \
 	lm80_write_value(client, reg, data->value); \
@@ -366,13 +380,13 @@ static SENSOR_DEVICE_ATTR(fan2_div, S_IWUSR | S_IRUGO,
 		show_fan_div, set_fan_div, 1);
 static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input1, NULL);
 static DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_hot_max,
-    set_temp_hot_max);
+	set_temp_hot_max);
 static DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO, show_temp_hot_hyst,
-    set_temp_hot_hyst);
+	set_temp_hot_hyst);
 static DEVICE_ATTR(temp1_crit, S_IWUSR | S_IRUGO, show_temp_os_max,
-    set_temp_os_max);
+	set_temp_os_max);
 static DEVICE_ATTR(temp1_crit_hyst, S_IWUSR | S_IRUGO, show_temp_os_hyst,
-    set_temp_os_hyst);
+	set_temp_os_hyst);
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 0);
 static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 1);
@@ -459,7 +473,7 @@ static int lm80_detect(struct i2c_client *client, struct i2c_board_info *info)
 		if ((i2c_smbus_read_byte_data(client, i + 0x40) != cur)
 		 || (i2c_smbus_read_byte_data(client, i + 0x80) != cur)
 		 || (i2c_smbus_read_byte_data(client, i + 0xc0) != cur))
-		    return -ENODEV;
+			return -ENODEV;
 	}
 
 	strlcpy(info->type, "lm80", I2C_NAME_SIZE);
@@ -490,7 +504,8 @@ static int lm80_probe(struct i2c_client *client,
 	data->fan_min[1] = lm80_read_value(client, LM80_REG_FAN_MIN(2));
 
 	/* Register sysfs hooks */
-	if ((err = sysfs_create_group(&client->dev.kobj, &lm80_group)))
+	err = sysfs_create_group(&client->dev.kobj, &lm80_group);
+	if (err)
 		goto error_free;
 
 	data->hwmon_dev = hwmon_device_register(&client->dev);
-- 
1.7.0.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
