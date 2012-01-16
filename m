From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 16 Jan 2012 08:49:16 +0000
Subject: [lm-sensors] [PATCH 14/39] hwmon: (gl518sm) Fix checkpatch issues
Message-Id: <1326703781-14272-15-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fixed:
ERROR: do not use assignment in if condition
ERROR: space required after that ',' (ctx:VxV)
ERROR: spaces required around that '?' (ctx:VxE)
ERROR: spaces required around that '<' (ctx:VxV)
ERROR: spaces required around that '=' (ctx:VxV)
ERROR: spaces required around that ':' (ctx:VxV)
ERROR: spaces required around that '?' (ctx:VxV)
ERROR: trailing statements should be on next line
WARNING: line over 80 characters
WARNING: simple_strtol is obsolete, use kstrtol instead
WARNING: simple_strtoul is obsolete, use kstrtoul instead

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/gl518sm.c |   88 ++++++++++++++++++++++++++++++++--------------
 1 files changed, 61 insertions(+), 27 deletions(-)

diff --git a/drivers/hwmon/gl518sm.c b/drivers/hwmon/gl518sm.c
index a13e2da..8d0f71d 100644
--- a/drivers/hwmon/gl518sm.c
+++ b/drivers/hwmon/gl518sm.c
@@ -83,11 +83,12 @@ enum chips { gl518sm_r00, gl518sm_r80 };
 
 #define RAW_FROM_REG(val)	val
 
-#define BOOL_FROM_REG(val)	((val)?0:1)
-#define BOOL_TO_REG(val)	((val)?0:1)
+#define BOOL_FROM_REG(val)	((val) ? 0 : 1)
+#define BOOL_TO_REG(val)	((val) ? 0 : 1)
 
-#define TEMP_TO_REG(val)	(SENSORS_LIMIT(((((val)<0? \
-				(val)-500:(val)+500)/1000)+119),0,255))
+#define TEMP_TO_REG(val)	SENSORS_LIMIT(((((val) < 0 ? \
+				(val) - 500 : \
+				(val) + 500) / 1000) + 119), 0, 255)
 #define TEMP_FROM_REG(val)	(((val) - 119) * 1000)
 
 static inline u8 FAN_TO_REG(long rpm, int div)
@@ -98,13 +99,13 @@ static inline u8 FAN_TO_REG(long rpm, int div)
 	rpmdiv = SENSORS_LIMIT(rpm, 1, 960000) * div;
 	return SENSORS_LIMIT((480000 + rpmdiv / 2) / rpmdiv, 1, 255);
 }
-#define FAN_FROM_REG(val,div)	((val)=0 ? 0 : (480000/((val)*(div))))
+#define FAN_FROM_REG(val, div)	((val) = 0 ? 0 : (480000 / ((val) * (div))))
 
-#define IN_TO_REG(val)		(SENSORS_LIMIT((((val)+9)/19),0,255))
-#define IN_FROM_REG(val)	((val)*19)
+#define IN_TO_REG(val)		SENSORS_LIMIT((((val) + 9) / 19), 0, 255)
+#define IN_FROM_REG(val)	((val) * 19)
 
-#define VDD_TO_REG(val)		(SENSORS_LIMIT((((val)*4+47)/95),0,255))
-#define VDD_FROM_REG(val)	(((val)*95+2)/4)
+#define VDD_TO_REG(val)		SENSORS_LIMIT((((val) * 4 + 47) / 95), 0, 255)
+#define VDD_FROM_REG(val)	(((val) * 95 + 2) / 4)
 
 #define DIV_FROM_REG(val)	(1 << (val))
 
@@ -169,7 +170,8 @@ static struct i2c_driver gl518_driver = {
  */
 
 #define show(type, suffix, value)					\
-static ssize_t show_##suffix(struct device *dev, struct device_attribute *attr, char *buf)		\
+static ssize_t show_##suffix(struct device *dev,			\
+			     struct device_attribute *attr, char *buf)	\
 {									\
 	struct gl518_data *data = gl518_update_device(dev);		\
 	return sprintf(buf, "%d\n", type##_FROM_REG(data->value));	\
@@ -222,12 +224,16 @@ static ssize_t show_fan_div(struct device *dev,
 }
 
 #define set(type, suffix, value, reg)					\
-static ssize_t set_##suffix(struct device *dev, struct device_attribute *attr, const char *buf,	\
-	size_t count)							\
+static ssize_t set_##suffix(struct device *dev,				\
+			    struct device_attribute *attr,		\
+			    const char *buf, size_t count)		\
 {									\
 	struct i2c_client *client = to_i2c_client(dev);			\
 	struct gl518_data *data = i2c_get_clientdata(client);		\
-	long val = simple_strtol(buf, NULL, 10);			\
+	long val;							\
+	int err = kstrtol(buf, 10, &val);				\
+	if (err)							\
+		return err;						\
 									\
 	mutex_lock(&data->update_lock);					\
 	data->value = type##_TO_REG(val);				\
@@ -237,13 +243,17 @@ static ssize_t set_##suffix(struct device *dev, struct device_attribute *attr, c
 }
 
 #define set_bits(type, suffix, value, reg, mask, shift)			\
-static ssize_t set_##suffix(struct device *dev, struct device_attribute *attr, const char *buf,	\
-	size_t count)							\
+static ssize_t set_##suffix(struct device *dev,				\
+			    struct device_attribute *attr,		\
+			    const char *buf, size_t count)		\
 {									\
 	struct i2c_client *client = to_i2c_client(dev);			\
 	struct gl518_data *data = i2c_get_clientdata(client);		\
 	int regvalue;							\
-	unsigned long val = simple_strtoul(buf, NULL, 10);		\
+	unsigned long val;						\
+	int err = kstrtoul(buf, 10, &val);				\
+	if (err)							\
+		return err;						\
 									\
 	mutex_lock(&data->update_lock);					\
 	regvalue = gl518_read_value(client, reg);			\
@@ -280,7 +290,12 @@ static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
 	struct gl518_data *data = i2c_get_clientdata(client);
 	int nr = to_sensor_dev_attr(attr)->index;
 	int regvalue;
-	unsigned long val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	regvalue = gl518_read_value(client, GL518_REG_FAN_LIMIT);
@@ -308,13 +323,26 @@ static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
 	struct gl518_data *data = i2c_get_clientdata(client);
 	int nr = to_sensor_dev_attr(attr)->index;
 	int regvalue;
-	unsigned long val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	switch (val) {
-	case 1: val = 0; break;
-	case 2: val = 1; break;
-	case 4: val = 2; break;
-	case 8: val = 3; break;
+	case 1:
+		val = 0;
+		break;
+	case 2:
+		val = 1;
+		break;
+	case 4:
+		val = 2;
+		break;
+	case 8:
+		val = 3;
+		break;
 	default:
 		dev_err(dev, "Invalid fan clock divider %lu, choose one "
 			"of 1, 2, 4 or 8\n", val);
@@ -395,8 +423,12 @@ static ssize_t set_beep(struct device *dev, struct device_attribute *attr,
 	struct gl518_data *data = i2c_get_clientdata(client);
 	int bitnr = to_sensor_dev_attr(attr)->index;
 	unsigned long bit;
+	int err;
+
+	err = kstrtoul(buf, 10, &bit);
+	if (err)
+		return err;
 
-	bit = simple_strtoul(buf, NULL, 10);
 	if (bit & ~1)
 		return -EINVAL;
 
@@ -528,12 +560,14 @@ static int gl518_probe(struct i2c_client *client,
 	gl518_init_client(client);
 
 	/* Register sysfs hooks */
-	if ((err = sysfs_create_group(&client->dev.kobj, &gl518_group)))
+	err = sysfs_create_group(&client->dev.kobj, &gl518_group);
+	if (err)
 		goto exit_free;
-	if (data->type = gl518sm_r80)
-		if ((err = sysfs_create_group(&client->dev.kobj,
-					      &gl518_group_r80)))
+	if (data->type = gl518sm_r80) {
+		err = sysfs_create_group(&client->dev.kobj, &gl518_group_r80);
+		if (err)
 			goto exit_remove_files;
+	}
 
 	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
