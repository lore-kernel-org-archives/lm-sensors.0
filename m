From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Sep 2010 13:55:37 +0000
Subject: [lm-sensors] [patch 06/36] hwmon: (w83795) Move files removal to a
Message-Id: <20100915155537.6ecc2dc8@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Sysfs files must be removed on device removal but also when device
registration fails. Move the code to a separate function to avoid
code redundancy.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83795.c |   81 ++++++++++++++++++------------------------------
 1 file changed, 31 insertions(+), 50 deletions(-)

--- linux-2.6.36-rc4.orig/drivers/hwmon/w83795.c	2010-09-15 15:11:42.000000000 +0200
+++ linux-2.6.36-rc4/drivers/hwmon/w83795.c	2010-09-15 15:11:44.000000000 +0200
@@ -1777,6 +1777,35 @@ static int w83795_detect(struct i2c_clie
 	return 0;
 }
 
+static void w83795_remove_files(struct device *dev)
+{
+	struct w83795_data *data = dev_get_drvdata(dev);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(w83795_in); i++)
+		device_remove_file(dev, &w83795_in[i].dev_attr);
+
+	for (i = 0; i < ARRAY_SIZE(w83795_fan); i++)
+		device_remove_file(dev, &w83795_fan[i].dev_attr);
+
+	for (i = 0; i < ARRAY_SIZE(sda_single_files); i++)
+		device_remove_file(dev, &sda_single_files[i].dev_attr);
+
+	if (data->chip_type = w83795g) {
+		for (i = 0; i < ARRAY_SIZE(w83795_left_reg); i++)
+			device_remove_file(dev, &w83795_left_reg[i].dev_attr);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(w83795_temp); i++)
+		device_remove_file(dev, &w83795_temp[i].dev_attr);
+
+	for (i = 0; i < ARRAY_SIZE(w83795_dts); i++)
+		device_remove_file(dev, &w83795_dts[i].dev_attr);
+
+	for (i = 0; i < ARRAY_SIZE(w83795_static); i++)
+		device_remove_file(dev, &w83795_static[i].dev_attr);
+}
+
 static int w83795_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -2065,31 +2094,8 @@ static int w83795_probe(struct i2c_clien
 
 	return 0;
 
-	/* Unregister sysfs hooks */
 exit_remove:
-	for (i = 0; i < ARRAY_SIZE(w83795_in); i++)
-		device_remove_file(dev, &w83795_in[i].dev_attr);
-
-	for (i = 0; i < ARRAY_SIZE(w83795_fan); i++)
-		device_remove_file(dev, &w83795_fan[i].dev_attr);
-
-	for (i = 0; i < ARRAY_SIZE(sda_single_files); i++)
-		device_remove_file(dev, &sda_single_files[i].dev_attr);
-
-	if (data->chip_type = w83795g) {
-		for (i = 0; i < ARRAY_SIZE(w83795_left_reg); i++)
-			device_remove_file(dev, &w83795_left_reg[i].dev_attr);
-	}
-
-	for (i = 0; i < ARRAY_SIZE(w83795_temp); i++)
-		device_remove_file(dev, &w83795_temp[i].dev_attr);
-
-	for (i = 0; i < ARRAY_SIZE(w83795_dts); i++)
-		device_remove_file(dev, &w83795_dts[i].dev_attr);
-
-	for (i = 0; i < ARRAY_SIZE(w83795_static); i++)
-		device_remove_file(dev, &w83795_static[i].dev_attr);
-
+	w83795_remove_files(dev);
 	kfree(data);
 exit:
 	return err;
@@ -2098,34 +2104,9 @@ exit:
 static int w83795_remove(struct i2c_client *client)
 {
 	struct w83795_data *data = i2c_get_clientdata(client);
-	struct device *dev = &client->dev;
-	int i;
 
 	hwmon_device_unregister(data->hwmon_dev);
-
-	for (i = 0; i < ARRAY_SIZE(w83795_in); i++)
-		device_remove_file(dev, &w83795_in[i].dev_attr);
-
-	for (i = 0; i < ARRAY_SIZE(w83795_fan); i++)
-		device_remove_file(dev, &w83795_fan[i].dev_attr);
-
-	for (i = 0; i < ARRAY_SIZE(sda_single_files); i++)
-		device_remove_file(dev, &sda_single_files[i].dev_attr);
-
-	if (data->chip_type = w83795g) {
-		for (i = 0; i < ARRAY_SIZE(w83795_left_reg); i++)
-			device_remove_file(dev, &w83795_left_reg[i].dev_attr);
-	}
-
-	for (i = 0; i < ARRAY_SIZE(w83795_temp); i++)
-		device_remove_file(dev, &w83795_temp[i].dev_attr);
-
-	for (i = 0; i < ARRAY_SIZE(w83795_dts); i++)
-		device_remove_file(dev, &w83795_dts[i].dev_attr);
-
-	for (i = 0; i < ARRAY_SIZE(w83795_static); i++)
-		device_remove_file(dev, &w83795_static[i].dev_attr);
-
+	w83795_remove_files(&client->dev);
 	kfree(data);
 
 	return 0;


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
