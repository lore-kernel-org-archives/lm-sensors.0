From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Sep 2010 13:55:48 +0000
Subject: [lm-sensors] [patch 07/36] hwmon: (w83795) Move file creation to a
Message-Id: <20100915155548.59d5ca83@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Function w83795_probe() is way too big, move file creation to a separate
function to make it more readable.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83795.c |  121 ++++++++++++++++++++++++++----------------------
 1 file changed, 66 insertions(+), 55 deletions(-)

--- linux-2.6.36-rc4.orig/drivers/hwmon/w83795.c	2010-09-15 15:11:44.000000000 +0200
+++ linux-2.6.36-rc4/drivers/hwmon/w83795.c	2010-09-15 15:11:46.000000000 +0200
@@ -1777,6 +1777,69 @@ static int w83795_detect(struct i2c_clie
 	return 0;
 }
 
+static int w83795_create_files(struct device *dev)
+{
+	struct w83795_data *data = dev_get_drvdata(dev);
+	int err, i;
+
+	for (i = 0; i < ARRAY_SIZE(w83795_in); i++) {
+		if (!(data->has_in & (1 << (i / 6))))
+			continue;
+		err = device_create_file(dev, &w83795_in[i].dev_attr);
+		if (err)
+			return err;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(w83795_fan); i++) {
+		if (!(data->has_fan & (1 << (i / 5))))
+			continue;
+		err = device_create_file(dev, &w83795_fan[i].dev_attr);
+		if (err)
+			return err;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(sda_single_files); i++) {
+		err = device_create_file(dev, &sda_single_files[i].dev_attr);
+		if (err)
+			return err;
+	}
+
+	if (data->chip_type = w83795g) {
+		for (i = 0; i < ARRAY_SIZE(w83795_left_reg); i++) {
+			err = device_create_file(dev,
+						 &w83795_left_reg[i].dev_attr);
+			if (err)
+				return err;
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(w83795_temp); i++) {
+		if (!(data->has_temp & (1 << (i / 29))))
+			continue;
+		err = device_create_file(dev, &w83795_temp[i].dev_attr);
+		if (err)
+			return err;
+	}
+
+	if (data->enable_dts != 0) {
+		for (i = 0; i < ARRAY_SIZE(w83795_dts); i++) {
+			if (!(data->has_dts & (1 << (i / 8))))
+				continue;
+			err = device_create_file(dev, &w83795_dts[i].dev_attr);
+			if (err)
+				return err;
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(w83795_static); i++) {
+		err = device_create_file(dev, &w83795_static[i].dev_attr);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static void w83795_remove_files(struct device *dev)
 {
 	struct w83795_data *data = dev_get_drvdata(dev);
@@ -2030,61 +2093,9 @@ static int w83795_probe(struct i2c_clien
 	data->beep_enable  		(w83795_read(client, W83795_REG_BEEP(5)) >> 7) & 0x01;
 
-	/* Register sysfs hooks */
-	for (i = 0; i < ARRAY_SIZE(w83795_in); i++) {
-		if (!(data->has_in & (1 << (i / 6))))
-			continue;
-		err = device_create_file(dev, &w83795_in[i].dev_attr);
-		if (err)
-			goto exit_remove;
-	}
-
-	for (i = 0; i < ARRAY_SIZE(w83795_fan); i++) {
-		if (!(data->has_fan & (1 << (i / 5))))
-			continue;
-		err = device_create_file(dev, &w83795_fan[i].dev_attr);
-		if (err)
-			goto exit_remove;
-	}
-
-	for (i = 0; i < ARRAY_SIZE(sda_single_files); i++) {
-		err = device_create_file(dev, &sda_single_files[i].dev_attr);
-		if (err)
-			goto exit_remove;
-	}
-
-	for (i = 0; i < ARRAY_SIZE(w83795_temp); i++) {
-		if (!(data->has_temp & (1 << (i / 29))))
-			continue;
-		err = device_create_file(dev, &w83795_temp[i].dev_attr);
-		if (err)
-			goto exit_remove;
-	}
-
-	if (data->enable_dts != 0) {
-		for (i = 0; i < ARRAY_SIZE(w83795_dts); i++) {
-			if (!(data->has_dts & (1 << (i / 8))))
-				continue;
-			err = device_create_file(dev, &w83795_dts[i].dev_attr);
-			if (err)
-				goto exit_remove;
-		}
-	}
-
-	if (data->chip_type = w83795g) {
-		for (i = 0; i < ARRAY_SIZE(w83795_left_reg); i++) {
-			err = device_create_file(dev,
-						 &w83795_left_reg[i].dev_attr);
-			if (err)
-				goto exit_remove;
-		}
-	}
-
-	for (i = 0; i < ARRAY_SIZE(w83795_static); i++) {
-		err = device_create_file(dev, &w83795_static[i].dev_attr);
-		if (err)
-			goto exit_remove;
-	}
+	err = w83795_create_files(dev);
+	if (err)
+		goto exit_remove;
 
 	data->hwmon_dev = hwmon_device_register(dev);
 	if (IS_ERR(data->hwmon_dev)) {


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
