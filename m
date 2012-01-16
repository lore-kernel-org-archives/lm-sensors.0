From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 16 Jan 2012 08:49:08 +0000
Subject: [lm-sensors] [PATCH 06/39] hwmon: (adm9240) Fix checkpatch issues
Message-Id: <1326703781-14272-7-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fixed:
ERROR: do not use assignment in if condition
ERROR: that open brace { should be on the previous line
WARNING: please, no space before tabs
WARNING: simple_strtol is obsolete, use kstrtol instead
WARNING: simple_strtoul is obsolete, use kstrtoul instead

Not fixed (false positive):
ERROR: Macros with multiple statements should be enclosed in a do - while loop

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/adm9240.c |   66 ++++++++++++++++++++++++++++++++--------------
 1 files changed, 46 insertions(+), 20 deletions(-)

diff --git a/drivers/hwmon/adm9240.c b/drivers/hwmon/adm9240.c
index 3f63f5f..2de4511 100644
--- a/drivers/hwmon/adm9240.c
+++ b/drivers/hwmon/adm9240.c
@@ -1,12 +1,12 @@
 /*
  * adm9240.c	Part of lm_sensors, Linux kernel modules for hardware
- * 		monitoring
+ *		monitoring
  *
  * Copyright (C) 1999	Frodo Looijaard <frodol@dds.nl>
  *			Philip Edelbrock <phil@netroedge.com>
  * Copyright (C) 2003	Michiel Rook <michiel@grendelproject.nl>
  * Copyright (C) 2005	Grant Coady <gcoady.lk@gmail.com> with valuable
- * 				guidance from Jean Delvare
+ *				guidance from Jean Delvare
  *
  * Driver supports	Analog Devices		ADM9240
  *			Dallas Semiconductor	DS1780
@@ -204,7 +204,12 @@ static ssize_t set_max(struct device *dev, struct device_attribute *devattr,
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm9240_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->temp_max[attr->index] = TEMP_TO_REG(val);
@@ -255,7 +260,12 @@ static ssize_t set_in_min(struct device *dev,
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm9240_data *data = i2c_get_clientdata(client);
-	unsigned long val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->in_min[attr->index] = IN_TO_REG(val, attr->index);
@@ -272,7 +282,12 @@ static ssize_t set_in_max(struct device *dev,
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm9240_data *data = i2c_get_clientdata(client);
-	unsigned long val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->in_max[attr->index] = IN_TO_REG(val, attr->index);
@@ -283,7 +298,7 @@ static ssize_t set_in_max(struct device *dev,
 }
 
 #define vin(nr)							\
-static SENSOR_DEVICE_ATTR(in##nr##_input, S_IRUGO, 		\
+static SENSOR_DEVICE_ATTR(in##nr##_input, S_IRUGO,		\
 		show_in, NULL, nr);				\
 static SENSOR_DEVICE_ATTR(in##nr##_min, S_IRUGO | S_IWUSR,	\
 		show_in_min, set_in_min, nr);			\
@@ -357,9 +372,14 @@ static ssize_t set_fan_min(struct device *dev,
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm9240_data *data = i2c_get_clientdata(client);
-	unsigned long val = simple_strtoul(buf, NULL, 10);
 	int nr = attr->index;
 	u8 new_div;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 
@@ -465,7 +485,12 @@ static ssize_t set_aout(struct device *dev,
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm9240_data *data = i2c_get_clientdata(client);
-	unsigned long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->aout = AOUT_TO_REG(val);
@@ -481,7 +506,12 @@ static ssize_t chassis_clear_legacy(struct device *dev,
 		const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	unsigned long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	dev_warn(dev, "Attribute chassis_clear is deprecated, "
 		 "use intrusion0_alarm instead\n");
@@ -632,7 +662,8 @@ static int adm9240_probe(struct i2c_client *new_client,
 	adm9240_init_client(new_client);
 
 	/* populate sysfs filesystem */
-	if ((err = sysfs_create_group(&new_client->dev.kobj, &adm9240_group)))
+	err = sysfs_create_group(&new_client->dev.kobj, &adm9240_group);
+	if (err)
 		goto exit_free;
 
 	data->hwmon_dev = hwmon_device_register(&new_client->dev);
@@ -681,8 +712,7 @@ static void adm9240_init_client(struct i2c_client *client)
 	} else { /* cold start: open limits before starting chip */
 		int i;
 
-		for (i = 0; i < 6; i++)
-		{
+		for (i = 0; i < 6; i++) {
 			i2c_smbus_write_byte_data(client,
 					ADM9240_REG_IN_MIN(i), 0);
 			i2c_smbus_write_byte_data(client,
@@ -717,8 +747,7 @@ static struct adm9240_data *adm9240_update_device(struct device *dev)
 	if (time_after(jiffies, data->last_updated_measure + (HZ * 7 / 4))
 			|| !data->valid) {
 
-		for (i = 0; i < 6; i++) /* read voltages */
-		{
+		for (i = 0; i < 6; i++) { /* read voltages */
 			data->in[i] = i2c_smbus_read_byte_data(client,
 					ADM9240_REG_IN(i));
 		}
@@ -735,8 +764,7 @@ static struct adm9240_data *adm9240_update_device(struct device *dev)
 					i2c_smbus_read_byte_data(client,
 					ADM9240_REG_TEMP_CONF)) / 128;
 
-		for (i = 0; i < 2; i++) /* read fans */
-		{
+		for (i = 0; i < 2; i++) { /* read fans */
 			data->fan[i] = i2c_smbus_read_byte_data(client,
 					ADM9240_REG_FAN(i));
 
@@ -760,15 +788,13 @@ static struct adm9240_data *adm9240_update_device(struct device *dev)
 	if (time_after(jiffies, data->last_updated_config + (HZ * 300))
 			|| !data->valid) {
 
-		for (i = 0; i < 6; i++)
-		{
+		for (i = 0; i < 6; i++) {
 			data->in_min[i] = i2c_smbus_read_byte_data(client,
 					ADM9240_REG_IN_MIN(i));
 			data->in_max[i] = i2c_smbus_read_byte_data(client,
 					ADM9240_REG_IN_MAX(i));
 		}
-		for (i = 0; i < 2; i++)
-		{
+		for (i = 0; i < 2; i++) {
 			data->fan_min[i] = i2c_smbus_read_byte_data(client,
 					ADM9240_REG_FAN_MIN(i));
 		}
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
