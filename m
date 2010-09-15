From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Sep 2010 13:55:59 +0000
Subject: [lm-sensors] [patch 08/36] hwmon: (w83795) Merge
Message-Id: <20100915155559.690507fc@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Functions w83795_create_files and w83795_remove_files iterate over
the same set of files, just calling a different function. Merge them
into a single function which takes the action as a parameter. This
saves code, and also ensure that file creation and deletion are in
sync.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83795.c |   55 ++++++++++++++----------------------------------
 1 file changed, 17 insertions(+), 38 deletions(-)

--- linux-2.6.36-rc4.orig/drivers/hwmon/w83795.c	2010-09-15 15:11:46.000000000 +0200
+++ linux-2.6.36-rc4/drivers/hwmon/w83795.c	2010-09-15 15:11:48.000000000 +0200
@@ -1777,7 +1777,8 @@ static int w83795_detect(struct i2c_clie
 	return 0;
 }
 
-static int w83795_create_files(struct device *dev)
+static int w83795_handle_files(struct device *dev, int (*fn)(struct device *,
+			       const struct device_attribute *))
 {
 	struct w83795_data *data = dev_get_drvdata(dev);
 	int err, i;
@@ -1785,7 +1786,7 @@ static int w83795_create_files(struct de
 	for (i = 0; i < ARRAY_SIZE(w83795_in); i++) {
 		if (!(data->has_in & (1 << (i / 6))))
 			continue;
-		err = device_create_file(dev, &w83795_in[i].dev_attr);
+		err = fn(dev, &w83795_in[i].dev_attr);
 		if (err)
 			return err;
 	}
@@ -1793,21 +1794,20 @@ static int w83795_create_files(struct de
 	for (i = 0; i < ARRAY_SIZE(w83795_fan); i++) {
 		if (!(data->has_fan & (1 << (i / 5))))
 			continue;
-		err = device_create_file(dev, &w83795_fan[i].dev_attr);
+		err = fn(dev, &w83795_fan[i].dev_attr);
 		if (err)
 			return err;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(sda_single_files); i++) {
-		err = device_create_file(dev, &sda_single_files[i].dev_attr);
+		err = fn(dev, &sda_single_files[i].dev_attr);
 		if (err)
 			return err;
 	}
 
 	if (data->chip_type = w83795g) {
 		for (i = 0; i < ARRAY_SIZE(w83795_left_reg); i++) {
-			err = device_create_file(dev,
-						 &w83795_left_reg[i].dev_attr);
+			err = fn(dev, &w83795_left_reg[i].dev_attr);
 			if (err)
 				return err;
 		}
@@ -1816,7 +1816,7 @@ static int w83795_create_files(struct de
 	for (i = 0; i < ARRAY_SIZE(w83795_temp); i++) {
 		if (!(data->has_temp & (1 << (i / 29))))
 			continue;
-		err = device_create_file(dev, &w83795_temp[i].dev_attr);
+		err = fn(dev, &w83795_temp[i].dev_attr);
 		if (err)
 			return err;
 	}
@@ -1825,14 +1825,14 @@ static int w83795_create_files(struct de
 		for (i = 0; i < ARRAY_SIZE(w83795_dts); i++) {
 			if (!(data->has_dts & (1 << (i / 8))))
 				continue;
-			err = device_create_file(dev, &w83795_dts[i].dev_attr);
+			err = fn(dev, &w83795_dts[i].dev_attr);
 			if (err)
 				return err;
 		}
 	}
 
 	for (i = 0; i < ARRAY_SIZE(w83795_static); i++) {
-		err = device_create_file(dev, &w83795_static[i].dev_attr);
+		err = fn(dev, &w83795_static[i].dev_attr);
 		if (err)
 			return err;
 	}
@@ -1840,33 +1840,12 @@ static int w83795_create_files(struct de
 	return 0;
 }
 
-static void w83795_remove_files(struct device *dev)
+/* We need a wrapper that fits in w83795_handle_files */
+static int device_remove_file_wrapper(struct device *dev,
+				      const struct device_attribute *attr)
 {
-	struct w83795_data *data = dev_get_drvdata(dev);
-	int i;
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
+	device_remove_file(dev, attr);
+	return 0;
 }
 
 static int w83795_probe(struct i2c_client *client,
@@ -2093,7 +2072,7 @@ static int w83795_probe(struct i2c_clien
 	data->beep_enable  		(w83795_read(client, W83795_REG_BEEP(5)) >> 7) & 0x01;
 
-	err = w83795_create_files(dev);
+	err = w83795_handle_files(dev, device_create_file);
 	if (err)
 		goto exit_remove;
 
@@ -2106,7 +2085,7 @@ static int w83795_probe(struct i2c_clien
 	return 0;
 
 exit_remove:
-	w83795_remove_files(dev);
+	w83795_handle_files(dev, device_remove_file_wrapper);
 	kfree(data);
 exit:
 	return err;
@@ -2117,7 +2096,7 @@ static int w83795_remove(struct i2c_clie
 	struct w83795_data *data = i2c_get_clientdata(client);
 
 	hwmon_device_unregister(data->hwmon_dev);
-	w83795_remove_files(&client->dev);
+	w83795_handle_files(&client->dev, device_remove_file_wrapper);
 	kfree(data);
 
 	return 0;


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
