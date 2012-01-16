From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 16 Jan 2012 08:49:05 +0000
Subject: [lm-sensors] [PATCH 03/39] hwmon: (adm1021) Fix checkpatch issues
Message-Id: <1326703781-14272-4-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fixed:
ERROR: do not use assignment in if condition
WARNING: simple_strtol is obsolete, use kstrtol instead
WARNING: space prohibited between function name and open parenthesis '('

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/adm1021.c |   30 +++++++++++++++++++++++++-----
 1 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/adm1021.c b/drivers/hwmon/adm1021.c
index 1ad0a88..b8ea426 100644
--- a/drivers/hwmon/adm1021.c
+++ b/drivers/hwmon/adm1021.c
@@ -182,7 +182,13 @@ static ssize_t set_temp_max(struct device *dev,
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
@@ -201,7 +207,13 @@ static ssize_t set_temp_min(struct device *dev,
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
@@ -226,7 +238,14 @@ static ssize_t set_low_power(struct device *dev,
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
@@ -361,7 +380,8 @@ static int adm1021_probe(struct i2c_client *client,
 		adm1021_init_client(client);
 
 	/* Register sysfs hooks */
-	if ((err = sysfs_create_group(&client->dev.kobj, &adm1021_group)))
+	err = sysfs_create_group(&client->dev.kobj, &adm1021_group);
+	if (err)
 		goto error1;
 
 	data->hwmon_dev = hwmon_device_register(&client->dev);
@@ -461,7 +481,7 @@ static void __exit sensors_adm1021_exit(void)
 	i2c_del_driver(&adm1021_driver);
 }
 
-MODULE_AUTHOR ("Frodo Looijaard <frodol@dds.nl> and "
+MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl> and "
 		"Philip Edelbrock <phil@netroedge.com>");
 MODULE_DESCRIPTION("adm1021 driver");
 MODULE_LICENSE("GPL");
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
