From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 16 Jan 2012 08:49:13 +0000
Subject: [lm-sensors] [PATCH 11/39] hwmon: (ds1621 Fix checkpatch issues
Message-Id: <1326703781-14272-12-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fixed:
ERROR: code indent should use tabs where possible
ERROR: do not use assignment in if condition
ERROR: trailing whitespace
WARNING: labels should not be indented
WARNING: please, no spaces at the start of a line
WARNING: simple_strtol is obsolete, use kstrtol instead

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/ds1621.c |   32 +++++++++++++++++++-------------
 1 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/hwmon/ds1621.c b/drivers/hwmon/ds1621.c
index ef1ac996..e23a8ab 100644
--- a/drivers/hwmon/ds1621.c
+++ b/drivers/hwmon/ds1621.c
@@ -1,9 +1,9 @@
 /*
     ds1621.c - Part of lm_sensors, Linux kernel modules for hardware
-             monitoring
+		monitoring
     Christian W. Zuckschwerdt  <zany@triq.net>  2000-11-23
     based on lm75.c by Frodo Looijaard <frodol@dds.nl>
-    Ported to Linux 2.6 by Aurelien Jarno <aurelien@aurel32.net> with 
+    Ported to Linux 2.6 by Aurelien Jarno <aurelien@aurel32.net> with
     the help of Jean Delvare <khali@linux-fr.org>
 
     This program is free software; you can redistribute it and/or modify
@@ -67,7 +67,7 @@ static const u8 DS1621_REG_TEMP[3] = {
 
 /* Conversions */
 #define ALARMS_FROM_REG(val) ((val) & \
-                              (DS1621_ALARM_TEMP_HIGH | DS1621_ALARM_TEMP_LOW))
+			(DS1621_ALARM_TEMP_HIGH | DS1621_ALARM_TEMP_LOW))
 
 /* Each client has this additional data */
 struct ds1621_data {
@@ -93,10 +93,10 @@ static void ds1621_init_client(struct i2c_client *client)
 		new_conf &= ~DS1621_REG_CONFIG_POLARITY;
 	else if (polarity = 1)
 		new_conf |= DS1621_REG_CONFIG_POLARITY;
-	
+
 	if (conf != new_conf)
 		i2c_smbus_write_byte_data(client, DS1621_REG_CONF, new_conf);
-	
+
 	/* start conversion */
 	i2c_smbus_write_byte(client, DS1621_COM_START);
 }
@@ -155,10 +155,15 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *da,
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct ds1621_data *data = i2c_get_clientdata(client);
-	u16 val = LM75_TEMP_TO_REG(simple_strtol(buf, NULL, 10));
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
-	data->temp[attr->index] = val;
+	data->temp[attr->index] = LM75_TEMP_TO_REG(val);
 	i2c_smbus_write_word_swapped(client, DS1621_REG_TEMP[attr->index],
 				     data->temp[attr->index]);
 	mutex_unlock(&data->update_lock);
@@ -212,8 +217,8 @@ static int ds1621_detect(struct i2c_client *client,
 	int conf, temp;
 	int i;
 
-	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA 
-				     | I2C_FUNC_SMBUS_WORD_DATA 
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA
+				     | I2C_FUNC_SMBUS_WORD_DATA
 				     | I2C_FUNC_SMBUS_WRITE_BYTE))
 		return -ENODEV;
 
@@ -254,7 +259,8 @@ static int ds1621_probe(struct i2c_client *client,
 	ds1621_init_client(client);
 
 	/* Register sysfs hooks */
-	if ((err = sysfs_create_group(&client->dev.kobj, &ds1621_group)))
+	err = sysfs_create_group(&client->dev.kobj, &ds1621_group);
+	if (err)
 		goto exit_free;
 
 	data->hwmon_dev = hwmon_device_register(&client->dev);
@@ -265,11 +271,11 @@ static int ds1621_probe(struct i2c_client *client,
 
 	return 0;
 
-      exit_remove_files:
+exit_remove_files:
 	sysfs_remove_group(&client->dev.kobj, &ds1621_group);
-      exit_free:
+exit_free:
 	kfree(data);
-      exit:
+exit:
 	return err;
 }
 
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
