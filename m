From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 16 Jan 2012 08:49:31 +0000
Subject: [lm-sensors] [PATCH 29/39] hwmon: (thmc50) Fix checkpatch issues
Message-Id: <1326703781-14272-30-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fixed:
ERROR: code indent should use tabs where possible
ERROR: do not use assignment in if condition
WARNING: simple_strtol is obsolete, use kstrtol instead
WARNING: simple_strtoul is obsolete, use kstrtoul instead

Not fixed (false positive):
ERROR: Macros with multiple statements should be enclosed in a do - while loop

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/thmc50.c |   33 +++++++++++++++++++++++++--------
 1 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/thmc50.c b/drivers/hwmon/thmc50.c
index 7dfb4de..a195914 100644
--- a/drivers/hwmon/thmc50.c
+++ b/drivers/hwmon/thmc50.c
@@ -1,6 +1,6 @@
 /*
     thmc50.c - Part of lm_sensors, Linux kernel modules for hardware
-             monitoring
+	monitoring
     Copyright (C) 2007 Krzysztof Helt <krzysztof.h1@wp.pl>
     Based on 2.4 driver by Frodo Looijaard <frodol@dds.nl> and
     Philip Edelbrock <phil@netroedge.com>
@@ -124,8 +124,13 @@ static ssize_t set_analog_out(struct device *dev,
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct thmc50_data *data = i2c_get_clientdata(client);
-	int tmp = simple_strtoul(buf, NULL, 10);
 	int config;
+	unsigned long tmp;
+	int err;
+
+	err = kstrtoul(buf, 10, &tmp);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->analog_out = SENSORS_LIMIT(tmp, 0, 255);
@@ -173,7 +178,12 @@ static ssize_t set_temp_min(struct device *dev, struct device_attribute *attr,
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct thmc50_data *data = i2c_get_clientdata(client);
-	int val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->temp_min[nr] = SENSORS_LIMIT(val / 1000, -128, 127);
@@ -197,7 +207,12 @@ static ssize_t set_temp_max(struct device *dev, struct device_attribute *attr,
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct thmc50_data *data = i2c_get_clientdata(client);
-	int val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->temp_max[nr] = SENSORS_LIMIT(val / 1000, -128, 127);
@@ -360,14 +375,16 @@ static int thmc50_probe(struct i2c_client *client,
 	thmc50_init_client(client);
 
 	/* Register sysfs hooks */
-	if ((err = sysfs_create_group(&client->dev.kobj, &thmc50_group)))
+	err = sysfs_create_group(&client->dev.kobj, &thmc50_group);
+	if (err)
 		goto exit_free;
 
 	/* Register ADM1022 sysfs hooks */
-	if (data->has_temp3)
-		if ((err = sysfs_create_group(&client->dev.kobj,
-					      &temp3_group)))
+	if (data->has_temp3) {
+		err = sysfs_create_group(&client->dev.kobj, &temp3_group);
+		if (err)
 			goto exit_remove_sysfs_thmc50;
+	}
 
 	/* Register a new directory entry with module sensors */
 	data->hwmon_dev = hwmon_device_register(&client->dev);
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
