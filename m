From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 Jan 2012 02:48:54 +0000
Subject: [lm-sensors] [PATCH 15/79] hwmon: (thmc50) Fix checkpatch issues
Message-Id: <1327373398-997-16-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

Fixed:
ERROR: code indent should use tabs where possible
ERROR: do not use assignment in if condition
WARNING: simple_strtol is obsolete, use kstrtol instead
WARNING: simple_strtoul is obsolete, use kstrtoul instead

Modify multi-line comments to follow Documentation/CodingStyle.

Not fixed (false positive):
ERROR: Macros with multiple statements should be enclosed in a do - while loop

Cc: Krzysztof Helt <krzysztof.h1@wp.pl>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/thmc50.c |   71 +++++++++++++++++++++++++++++------------------
 1 files changed, 44 insertions(+), 27 deletions(-)

diff --git a/drivers/hwmon/thmc50.c b/drivers/hwmon/thmc50.c
index bd83bc0..add9f01 100644
--- a/drivers/hwmon/thmc50.c
+++ b/drivers/hwmon/thmc50.c
@@ -1,24 +1,24 @@
 /*
-    thmc50.c - Part of lm_sensors, Linux kernel modules for hardware
-             monitoring
-    Copyright (C) 2007 Krzysztof Helt <krzysztof.h1@wp.pl>
-    Based on 2.4 driver by Frodo Looijaard <frodol@dds.nl> and
-    Philip Edelbrock <phil@netroedge.com>
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
+ * thmc50.c - Part of lm_sensors, Linux kernel modules for hardware
+ *	      monitoring
+ * Copyright (C) 2007 Krzysztof Helt <krzysztof.h1@wp.pl>
+ * Based on 2.4 driver by Frodo Looijaard <frodol@dds.nl> and
+ * Philip Edelbrock <phil@netroedge.com>
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
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
