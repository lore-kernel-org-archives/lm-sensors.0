From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 Jan 2012 02:49:24 +0000
Subject: [lm-sensors] [PATCH 45/79] hwmon: (lm77) Fix checkpatch issues
Message-Id: <1327373398-997-46-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

Fixed:
ERROR: code indent should use tabs where possible
ERROR: do not use assignment in if condition
ERROR: trailing whitespace
WARNING: line over 80 characters
WARNING: please, no space before tabs
WARNING: simple_strtol is obsolete, use kstrtol instead
WARNING: simple_strtoul is obsolete, use kstrtoul instead

Modify multi-line comments to follow Documentation/CodingStyle.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm77.c |  159 ++++++++++++++++++++++++++++++--------------------
 1 files changed, 95 insertions(+), 64 deletions(-)

diff --git a/drivers/hwmon/lm77.c b/drivers/hwmon/lm77.c
index 7cd516f..0fca861 100644
--- a/drivers/hwmon/lm77.c
+++ b/drivers/hwmon/lm77.c
@@ -1,29 +1,29 @@
 /*
-    lm77.c - Part of lm_sensors, Linux kernel modules for hardware
-             monitoring
-
-    Copyright (c) 2004  Andras BALI <drewie@freemail.hu>
-
-    Heavily based on lm75.c by Frodo Looijaard <frodol@dds.nl>.  The LM77
-    is a temperature sensor and thermal window comparator with 0.5 deg
-    resolution made by National Semiconductor.  Complete datasheet can be
-    obtained at their site:
-       http://www.national.com/pf/LM/LM77.html
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-*/
+ * lm77.c - Part of lm_sensors, Linux kernel modules for hardware
+ *	    monitoring
+ *
+ * Copyright (c) 2004  Andras BALI <drewie@freemail.hu>
+ *
+ * Heavily based on lm75.c by Frodo Looijaard <frodol@dds.nl>.  The LM77
+ * is a temperature sensor and thermal window comparator with 0.5 deg
+ * resolution made by National Semiconductor.  Complete datasheet can be
+ * obtained at their site:
+ *	http://www.national.com/pf/LM/LM77.html
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
 
 #include <linux/module.h>
 #include <linux/init.h>
@@ -49,7 +49,7 @@ static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b,
 
 /* Each client has this additional data */
 struct lm77_data {
-	struct device 		*hwmon_dev;
+	struct device		*hwmon_dev;
 	struct mutex		update_lock;
 	char			valid;
 	unsigned long		last_updated;	/* In jiffies */
@@ -95,8 +95,10 @@ static struct i2c_driver lm77_driver = {
 #define LM77_TEMP_MIN (-55000)
 #define LM77_TEMP_MAX 125000
 
-/* In the temperature registers, the low 3 bits are not part of the
-   temperature values; they are the status bits. */
+/*
+ * In the temperature registers, the low 3 bits are not part of the
+ * temperature values; they are the status bits.
+ */
 static inline s16 LM77_TEMP_TO_REG(int temp)
 {
 	int ntemp = SENSORS_LIMIT(temp, LM77_TEMP_MIN, LM77_TEMP_MAX);
@@ -112,7 +114,9 @@ static inline int LM77_TEMP_FROM_REG(s16 reg)
 
 /* read routines for temperature limits */
 #define show(value)	\
-static ssize_t show_##value(struct device *dev, struct device_attribute *attr, char *buf)	\
+static ssize_t show_##value(struct device *dev,			\
+			    struct device_attribute *attr,	\
+			    char *buf)				\
 {								\
 	struct lm77_data *data = lm77_update_device(dev);	\
 	return sprintf(buf, "%d\n", data->value);		\
@@ -124,17 +128,20 @@ show(temp_min);
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
@@ -142,29 +149,42 @@ static ssize_t show_temp_max_hyst(struct device *dev, struct device_attribute *a
 
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
 set(temp_max, LM77_REG_TEMP_MAX);
 
-/* hysteresis is stored as a relative value on the chip, so it has to be
-   converted first */
-static ssize_t set_temp_crit_hyst(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+/*
+ * hysteresis is stored as a relative value on the chip, so it has to be
+ * converted first
+ */
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
@@ -175,13 +195,19 @@ static ssize_t set_temp_crit_hyst(struct device *dev, struct device_attribute *a
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
@@ -251,17 +277,19 @@ static int lm77_detect(struct i2c_client *new_client,
 				     I2C_FUNC_SMBUS_WORD_DATA))
 		return -ENODEV;
 
-	/* Here comes the remaining detection.  Since the LM77 has no
-	   register dedicated to identification, we have to rely on the
-	   following tricks:
-
-	   1. the high 4 bits represent the sign and thus they should
-	      always be the same
-	   2. the high 3 bits are unused in the configuration register
-	   3. addresses 0x06 and 0x07 return the last read value
-	   4. registers cycling over 8-address boundaries
-
-	   Word-sized registers are high-byte first. */
+	/*
+	 * Here comes the remaining detection.  Since the LM77 has no
+	 * register dedicated to identification, we have to rely on the
+	 * following tricks:
+	 *
+	 * 1. the high 4 bits represent the sign and thus they should
+	 *    always be the same
+	 * 2. the high 3 bits are unused in the configuration register
+	 * 3. addresses 0x06 and 0x07 return the last read value
+	 * 4. registers cycling over 8-address boundaries
+	 *
+	 * Word-sized registers are high-byte first.
+	 */
 
 	/* addresses cycling */
 	cur = i2c_smbus_read_word_data(new_client, 0);
@@ -330,7 +358,8 @@ static int lm77_probe(struct i2c_client *new_client,
 	lm77_init_client(new_client);
 
 	/* Register sysfs hooks */
-	if ((err = sysfs_create_group(&new_client->dev.kobj, &lm77_group)))
+	err = sysfs_create_group(&new_client->dev.kobj, &lm77_group);
+	if (err)
 		goto exit_free;
 
 	data->hwmon_dev = hwmon_device_register(&new_client->dev);
@@ -358,8 +387,10 @@ static int lm77_remove(struct i2c_client *client)
 	return 0;
 }
 
-/* All registers are word-sized, except for the configuration register.
-   The LM77 uses the high-byte first convention. */
+/*
+ * All registers are word-sized, except for the configuration register.
+ * The LM77 uses the high-byte first convention.
+ */
 static u16 lm77_read_value(struct i2c_client *client, u8 reg)
 {
 	if (reg = LM77_REG_CONF)
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
