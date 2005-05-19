From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: [PATCH 2.6] Bring lm75 and lm78 in compliance with sysfs naming
Message-Id: <20040127200058.1100b1fa.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Here is a patch that brings the lm75 and lm78 drivers in compliance with
sysfs naming conventions. The drivers as found in existing 2.6 kernels
do not have a digit appended to the temperature-related files names as
the sysfs naming conversion recommends (obviously because they each have
a single temperature channel). As a result, libsensors won't find the
files.

It was discussed on the list wether a '1' should be appended in this
case, and our conclusion was that it would be better to do so because it
helps automatic processing of the sysfs exported files. Please apply if
you agree with this.

--- linux-2.6.2-rc2/drivers/i2c/chips/lm75.c.orig	2004-01-27 16:19:26.000000000 +0100
+++ linux-2.6.2-rc2/drivers/i2c/chips/lm75.c	2004-01-27 16:44:01.000000000 +0100
@@ -104,9 +104,9 @@
 set(temp_max, LM75_REG_TEMP_OS);
 set(temp_hyst, LM75_REG_TEMP_HYST);
 
-static DEVICE_ATTR(temp_max, S_IWUSR | S_IRUGO, show_temp_max, set_temp_max);
-static DEVICE_ATTR(temp_hyst, S_IWUSR | S_IRUGO, show_temp_hyst, set_temp_hyst);
-static DEVICE_ATTR(temp_input, S_IRUGO, show_temp_input, NULL);
+static DEVICE_ATTR(temp_max1, S_IWUSR | S_IRUGO, show_temp_max, set_temp_max);
+static DEVICE_ATTR(temp_hyst1, S_IWUSR | S_IRUGO, show_temp_hyst, set_temp_hyst);
+static DEVICE_ATTR(temp_input1, S_IRUGO, show_temp_input, NULL);
 
 static int lm75_attach_adapter(struct i2c_adapter *adapter)
 {
@@ -197,9 +197,9 @@
 	lm75_init_client(new_client);
 	
 	/* Register sysfs hooks */
-	device_create_file(&new_client->dev, &dev_attr_temp_max);
-	device_create_file(&new_client->dev, &dev_attr_temp_hyst);
-	device_create_file(&new_client->dev, &dev_attr_temp_input);
+	device_create_file(&new_client->dev, &dev_attr_temp_max1);
+	device_create_file(&new_client->dev, &dev_attr_temp_hyst1);
+	device_create_file(&new_client->dev, &dev_attr_temp_input1);
 
 	return 0;
 
--- linux-2.6.2-rc2/drivers/i2c/chips/lm78.c.orig	2004-01-27 16:19:26.000000000 +0100
+++ linux-2.6.2-rc2/drivers/i2c/chips/lm78.c	2004-01-27 16:46:43.000000000 +0100
@@ -369,10 +369,10 @@
 	return count;
 }
 
-static DEVICE_ATTR(temp_input, S_IRUGO, show_temp, NULL)
-static DEVICE_ATTR(temp_max, S_IRUGO | S_IWUSR,
+static DEVICE_ATTR(temp_input1, S_IRUGO, show_temp, NULL)
+static DEVICE_ATTR(temp_max1, S_IRUGO | S_IWUSR,
 		show_temp_over, set_temp_over)
-static DEVICE_ATTR(temp_hyst, S_IRUGO | S_IWUSR,
+static DEVICE_ATTR(temp_hyst1, S_IRUGO | S_IWUSR,
 		show_temp_hyst, set_temp_hyst)
 
 /* 3 Fans */
@@ -678,9 +678,9 @@
 	device_create_file(&new_client->dev, &dev_attr_in_input6);
 	device_create_file(&new_client->dev, &dev_attr_in_min6);
 	device_create_file(&new_client->dev, &dev_attr_in_max6);
-	device_create_file(&new_client->dev, &dev_attr_temp_input);
-	device_create_file(&new_client->dev, &dev_attr_temp_max);
-	device_create_file(&new_client->dev, &dev_attr_temp_hyst);
+	device_create_file(&new_client->dev, &dev_attr_temp_input1);
+	device_create_file(&new_client->dev, &dev_attr_temp_max1);
+	device_create_file(&new_client->dev, &dev_attr_temp_hyst1);
 	device_create_file(&new_client->dev, &dev_attr_fan_input1);
 	device_create_file(&new_client->dev, &dev_attr_fan_min1);
 	device_create_file(&new_client->dev, &dev_attr_fan_div1);


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
