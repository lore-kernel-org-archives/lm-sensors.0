From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 06 May 2011 11:37:39 +0000
Subject: [lm-sensors] [PATCH 2.2] hwmon: (max6650) Properly support the
Message-Id: <20110506133739.452576b6@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The MAX6650 has only one fan input.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: "Hans J. Koch" <hjk@hansjkoch.de>
---
 Documentation/hwmon/max6650 |   12 ++++++++----
 drivers/hwmon/max6650.c     |   34 ++++++++++++++++++++++++++++------
 2 files changed, 36 insertions(+), 10 deletions(-)

--- linux-2.6.39-rc6.orig/Documentation/hwmon/max6650	2011-05-06 10:32:11.000000000 +0200
+++ linux-2.6.39-rc6/Documentation/hwmon/max6650	2011-05-06 11:00:26.000000000 +0200
@@ -2,10 +2,14 @@ Kernel driver max6650
 ========== 
 Supported chips:
-  * Maxim 6650 / 6651
+  * Maxim MAX6650
     Prefix: 'max6650'
     Addresses scanned: none
     Datasheet: http://pdfserv.maxim-ic.com/en/ds/MAX6650-MAX6651.pdf
+  * Maxim MAX6651
+    Prefix: 'max6651'
+    Addresses scanned: none
+    Datasheet: http://pdfserv.maxim-ic.com/en/ds/MAX6650-MAX6651.pdf
 
 Authors:
     Hans J. Koch <hjk@hansjkoch.de>
@@ -15,10 +19,10 @@ Authors:
 Description
 -----------
 
-This driver implements support for the Maxim 6650/6651
+This driver implements support for the Maxim MAX6650 and MAX6651.
 
-The 2 devices are very similar, but the Maxim 6550 has a reduced feature
-set, e.g. only one fan-input, instead of 4 for the 6651.
+The 2 devices are very similar, but the MAX6550 has a reduced feature
+set, e.g. only one fan-input, instead of 4 for the MAX6651.
 
 The driver is not able to distinguish between the 2 devices.
 
--- linux-2.6.39-rc6.orig/drivers/hwmon/max6650.c	2011-05-06 10:32:11.000000000 +0200
+++ linux-2.6.39-rc6/drivers/hwmon/max6650.c	2011-05-06 11:11:20.000000000 +0200
@@ -116,7 +116,8 @@ static struct max6650_data *max6650_upda
  */
 
 static const struct i2c_device_id max6650_id[] = {
-	{ "max6650", 0 },
+	{ "max6650", 1 },
+	{ "max6651", 4 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, max6650_id);
@@ -138,6 +139,7 @@ struct max6650_data
 {
 	struct device *hwmon_dev;
 	struct mutex update_lock;
+	int nr_fans;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
 
@@ -489,9 +491,6 @@ static mode_t max6650_attrs_visible(stru
 
 static struct attribute *max6650_attrs[] = {
 	&sensor_dev_attr_fan1_input.dev_attr.attr,
-	&sensor_dev_attr_fan2_input.dev_attr.attr,
-	&sensor_dev_attr_fan3_input.dev_attr.attr,
-	&sensor_dev_attr_fan4_input.dev_attr.attr,
 	&dev_attr_fan1_target.attr,
 	&dev_attr_fan1_div.attr,
 	&dev_attr_pwm1_enable.attr,
@@ -509,6 +508,17 @@ static struct attribute_group max6650_at
 	.is_visible = max6650_attrs_visible,
 };
 
+static struct attribute *max6651_attrs[] = {
+	&sensor_dev_attr_fan2_input.dev_attr.attr,
+	&sensor_dev_attr_fan3_input.dev_attr.attr,
+	&sensor_dev_attr_fan4_input.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group max6651_attr_grp = {
+	.attrs = max6651_attrs,
+};
+
 /*
  * Real code
  */
@@ -526,6 +536,7 @@ static int max6650_probe(struct i2c_clie
 
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
+	data->nr_fans = id->driver_data;
 
 	/*
 	 * Initialize the max6650 chip
@@ -537,6 +548,12 @@ static int max6650_probe(struct i2c_clie
 	err = sysfs_create_group(&client->dev.kobj, &max6650_attr_grp);
 	if (err)
 		goto err_free;
+	/* 3 additional fan inputs for the MAX6651 */
+	if (data->nr_fans = 4) {
+		err = sysfs_create_group(&client->dev.kobj, &max6651_attr_grp);
+		if (err)
+			goto err_remove;
+	}
 
 	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (!IS_ERR(data->hwmon_dev))
@@ -544,6 +561,9 @@ static int max6650_probe(struct i2c_clie
 
 	err = PTR_ERR(data->hwmon_dev);
 	dev_err(&client->dev, "error registering hwmon device.\n");
+	if (data->nr_fans = 4)
+		sysfs_remove_group(&client->dev.kobj, &max6651_attr_grp);
+err_remove:
 	sysfs_remove_group(&client->dev.kobj, &max6650_attr_grp);
 err_free:
 	kfree(data);
@@ -554,8 +574,10 @@ static int max6650_remove(struct i2c_cli
 {
 	struct max6650_data *data = i2c_get_clientdata(client);
 
-	sysfs_remove_group(&client->dev.kobj, &max6650_attr_grp);
 	hwmon_device_unregister(data->hwmon_dev);
+	if (data->nr_fans = 4)
+		sysfs_remove_group(&client->dev.kobj, &max6651_attr_grp);
+	sysfs_remove_group(&client->dev.kobj, &max6650_attr_grp);
 	kfree(data);
 	return 0;
 }
@@ -668,7 +690,7 @@ static struct max6650_data *max6650_upda
 						       MAX6650_REG_SPEED);
 		data->config = i2c_smbus_read_byte_data(client,
 							MAX6650_REG_CONFIG);
-		for (i = 0; i < 4; i++) {
+		for (i = 0; i < data->nr_fans; i++) {
 			data->tach[i] = i2c_smbus_read_byte_data(client,
 								 tach_reg[i]);
 		}


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
