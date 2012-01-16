From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 16 Jan 2012 08:49:18 +0000
Subject: [lm-sensors] [PATCH 16/39] hwmon: (lm77) Fix checkpatch issues
Message-Id: <1326703781-14272-17-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fixed:
ERROR: code indent should use tabs where possible
ERROR: do not use assignment in if condition
ERROR: trailing whitespace
WARNING: line over 80 characters
WARNING: please, no space before tabs
WARNING: simple_strtol is obsolete, use kstrtol instead
WARNING: simple_strtoul is obsolete, use kstrtoul instead

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm77.c |   69 +++++++++++++++++++++++++++++++++----------------
 1 files changed, 46 insertions(+), 23 deletions(-)

diff --git a/drivers/hwmon/lm77.c b/drivers/hwmon/lm77.c
index 8dfc678..08f7ffe 100644
--- a/drivers/hwmon/lm77.c
+++ b/drivers/hwmon/lm77.c
@@ -1,6 +1,6 @@
 /*
     lm77.c - Part of lm_sensors, Linux kernel modules for hardware
-             monitoring
+		monitoring
 
     Copyright (c) 2004  Andras BALI <drewie@freemail.hu>
 
@@ -49,7 +49,7 @@ static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b,
 
 /* Each client has this additional data */
 struct lm77_data {
-	struct device 		*hwmon_dev;
+	struct device		*hwmon_dev;
 	struct mutex		update_lock;
 	char			valid;
 	unsigned long		last_updated;	/* In jiffies */
@@ -112,7 +112,9 @@ static inline int LM77_TEMP_FROM_REG(s16 reg)
 
 /* read routines for temperature limits */
 #define show(value)	\
-static ssize_t show_##value(struct device *dev, struct device_attribute *attr, char *buf)	\
+static ssize_t show_##value(struct device *dev,			\
+			    struct device_attribute *attr,	\
+			    char *buf)				\
 {								\
 	struct lm77_data *data = lm77_update_device(dev);	\
 	return sprintf(buf, "%d\n", data->value);		\
@@ -124,17 +126,20 @@ show(temp_min);
 show(temp_max);
 
 /* read routines for hysteresis values */
-static ssize_t show_temp_crit_hyst(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_temp_crit_hyst(struct device *dev,
+				   struct device_attribute *attr, char *buf)
 {
 	struct lm77_data *data = lm77_update_device(dev);
 	return sprintf(buf, "%d\n", data->temp_crit - data->temp_hyst);
 }
-static ssize_t show_temp_min_hyst(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_temp_min_hyst(struct device *dev,
+				  struct device_attribute *attr, char *buf)
 {
 	struct lm77_data *data = lm77_update_device(dev);
 	return sprintf(buf, "%d\n", data->temp_min + data->temp_hyst);
 }
-static ssize_t show_temp_max_hyst(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_temp_max_hyst(struct device *dev,
+				  struct device_attribute *attr, char *buf)
 {
 	struct lm77_data *data = lm77_update_device(dev);
 	return sprintf(buf, "%d\n", data->temp_max - data->temp_hyst);
@@ -142,17 +147,21 @@ static ssize_t show_temp_max_hyst(struct device *dev, struct device_attribute *a
 
 /* write routines */
 #define set(value, reg)	\
-static ssize_t set_##value(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)	\
-{										\
-	struct i2c_client *client = to_i2c_client(dev);				\
-	struct lm77_data *data = i2c_get_clientdata(client);			\
-	long val = simple_strtol(buf, NULL, 10);				\
-										\
-	mutex_lock(&data->update_lock);						\
-	data->value = val;				\
-	lm77_write_value(client, reg, LM77_TEMP_TO_REG(data->value));		\
-	mutex_unlock(&data->update_lock);					\
-	return count;								\
+static ssize_t set_##value(struct device *dev, struct device_attribute *attr, \
+			   const char *buf, size_t count)		\
+{									\
+	struct i2c_client *client = to_i2c_client(dev);			\
+	struct lm77_data *data = i2c_get_clientdata(client);		\
+	long val;							\
+	int err = kstrtol(buf, 10, &val);				\
+	if (err)							\
+		return err;						\
+									\
+	mutex_lock(&data->update_lock);					\
+	data->value = val;						\
+	lm77_write_value(client, reg, LM77_TEMP_TO_REG(data->value));	\
+	mutex_unlock(&data->update_lock);				\
+	return count;							\
 }
 
 set(temp_min, LM77_REG_TEMP_MIN);
@@ -160,11 +169,18 @@ set(temp_max, LM77_REG_TEMP_MAX);
 
 /* hysteresis is stored as a relative value on the chip, so it has to be
    converted first */
-static ssize_t set_temp_crit_hyst(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t set_temp_crit_hyst(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm77_data *data = i2c_get_clientdata(client);
-	unsigned long val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->temp_hyst = data->temp_crit - val;
@@ -175,13 +191,19 @@ static ssize_t set_temp_crit_hyst(struct device *dev, struct device_attribute *a
 }
 
 /* preserve hysteresis when setting T_crit */
-static ssize_t set_temp_crit(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t set_temp_crit(struct device *dev, struct device_attribute *attr,
+			     const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm77_data *data = i2c_get_clientdata(client);
-	long val = simple_strtoul(buf, NULL, 10);
 	int oldcrithyst;
-	
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+
 	mutex_lock(&data->update_lock);
 	oldcrithyst = data->temp_crit - data->temp_hyst;
 	data->temp_crit = val;
@@ -330,7 +352,8 @@ static int lm77_probe(struct i2c_client *new_client,
 	lm77_init_client(new_client);
 
 	/* Register sysfs hooks */
-	if ((err = sysfs_create_group(&new_client->dev.kobj, &lm77_group)))
+	err = sysfs_create_group(&new_client->dev.kobj, &lm77_group);
+	if (err)
 		goto exit_free;
 
 	data->hwmon_dev = hwmon_device_register(&new_client->dev);
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
