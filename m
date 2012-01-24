From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 Jan 2012 02:49:13 +0000
Subject: [lm-sensors] [PATCH 34/79] hwmon: (adm1021) Fix checkpatch issues
Message-Id: <1327373398-997-35-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

Fixed:
ERROR: do not use assignment in if condition
WARNING: simple_strtol is obsolete, use kstrtol instead
WARNING: space prohibited between function name and open parenthesis '('

Modify multi-line comments to follow Documentation/CodingStyle.

Cc: Michael Abbott <michael.abbott@diamond.ac.uk>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/adm1021.c |   84 ++++++++++++++++++++++++++++++-----------------
 1 files changed, 54 insertions(+), 30 deletions(-)

diff --git a/drivers/hwmon/adm1021.c b/drivers/hwmon/adm1021.c
index bce5439..4394e7e 100644
--- a/drivers/hwmon/adm1021.c
+++ b/drivers/hwmon/adm1021.c
@@ -1,23 +1,23 @@
 /*
-    adm1021.c - Part of lm_sensors, Linux kernel modules for hardware
-		monitoring
-    Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl> and
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
+ * adm1021.c - Part of lm_sensors, Linux kernel modules for hardware
+ *	       monitoring
+ * Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl> and
+ *			     Philip Edelbrock <phil@netroedge.com>
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
@@ -70,10 +70,12 @@ enum chips {
 
 /* Initial values */
 
-/* Note: Even though I left the low and high limits named os and hyst,
-they don't quite work like a thermostat the way the LM75 does.  I.e.,
-a lower temp than THYST actually triggers an alarm instead of
-clearing it.  Weird, ey?   --Phil  */
+/*
+ * Note: Even though I left the low and high limits named os and hyst,
+ * they don't quite work like a thermostat the way the LM75 does.  I.e.,
+ * a lower temp than THYST actually triggers an alarm instead of
+ * clearing it.  Weird, ey?   --Phil
+ */
 
 /* Each client has this additional data */
 struct adm1021_data {
@@ -182,7 +184,13 @@ static ssize_t set_temp_max(struct device *dev,
 	int index = to_sensor_dev_attr(devattr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1021_data *data = i2c_get_clientdata(client);
-	long temp = simple_strtol(buf, NULL, 10) / 1000;
+	long temp;
+	int err;
+
+	err = kstrtol(buf, 10, &temp);
+	if (err)
+		return err;
+	temp /= 1000;
 
 	mutex_lock(&data->update_lock);
 	data->temp_max[index] = SENSORS_LIMIT(temp, -128, 127);
@@ -201,7 +209,13 @@ static ssize_t set_temp_min(struct device *dev,
 	int index = to_sensor_dev_attr(devattr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1021_data *data = i2c_get_clientdata(client);
-	long temp = simple_strtol(buf, NULL, 10) / 1000;
+	long temp;
+	int err;
+
+	err = kstrtol(buf, 10, &temp);
+	if (err)
+		return err;
+	temp /= 1000;
 
 	mutex_lock(&data->update_lock);
 	data->temp_min[index] = SENSORS_LIMIT(temp, -128, 127);
@@ -226,7 +240,14 @@ static ssize_t set_low_power(struct device *dev,
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1021_data *data = i2c_get_clientdata(client);
-	int low_power = simple_strtol(buf, NULL, 10) != 0;
+	char low_power;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+	low_power = val != 0;
 
 	mutex_lock(&data->update_lock);
 	if (low_power != data->low_power) {
@@ -361,7 +382,8 @@ static int adm1021_probe(struct i2c_client *client,
 		adm1021_init_client(client);
 
 	/* Register sysfs hooks */
-	if ((err = sysfs_create_group(&client->dev.kobj, &adm1021_group)))
+	err = sysfs_create_group(&client->dev.kobj, &adm1021_group);
+	if (err)
 		goto error1;
 
 	data->hwmon_dev = hwmon_device_register(&client->dev);
@@ -427,8 +449,10 @@ static struct adm1021_data *adm1021_update_device(struct device *dev)
 		data->alarms = i2c_smbus_read_byte_data(client,
 						ADM1021_REG_STATUS) & 0x7c;
 		if (data->type = adm1023) {
-			/* The ADM1023 provides 3 extra bits of precision for
-			 * the remote sensor in extra registers. */
+			/*
+			 * The ADM1023 provides 3 extra bits of precision for
+			 * the remote sensor in extra registers.
+			 */
 			data->temp[1] += 125 * (i2c_smbus_read_byte_data(
 				client, ADM1023_REG_REM_TEMP_PREC) >> 5);
 			data->temp_max[1] += 125 * (i2c_smbus_read_byte_data(
@@ -453,7 +477,7 @@ static struct adm1021_data *adm1021_update_device(struct device *dev)
 
 module_i2c_driver(adm1021_driver);
 
-MODULE_AUTHOR ("Frodo Looijaard <frodol@dds.nl> and "
+MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl> and "
 		"Philip Edelbrock <phil@netroedge.com>");
 MODULE_DESCRIPTION("adm1021 driver");
 MODULE_LICENSE("GPL");
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
