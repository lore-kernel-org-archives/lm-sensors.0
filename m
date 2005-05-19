From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:33 +0000
Subject: [PATCH 2.6] I2C: Do not show disabled pc87360 fans
Message-Id: <20050127231022.6331ef93.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

The pc87360 driver create sysfs files even for disabled fans. Since data
won't ever be updated, it doesn't make much sense. The following patch
adds some tests to only create the interface files that are actually
needed.

Please apply,
thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.11-rc2/drivers/i2c/chips/pc87360.c.orig	2005-01-22 15:08:51.000000000 +0100
+++ linux-2.6.11-rc2/drivers/i2c/chips/pc87360.c	2005-01-27 22:58:23.000000000 +0100
@@ -795,8 +795,10 @@
 
 	/* Fan clock dividers may be needed before any data is read */
 	for (i = 0; i < data->fannr; i++) {
-		data->fan_status[i] = pc87360_read_value(data, LD_FAN,
-				      NO_BANK, PC87360_REG_FAN_STATUS(i));
+		if (FAN_CONFIG_MONITOR(data->fan_conf, i))
+			data->fan_status[i] = pc87360_read_value(data,
+					      LD_FAN, NO_BANK,
+					      PC87360_REG_FAN_STATUS(i));
 	}
 
 	if (init > 0) {
@@ -898,14 +900,27 @@
 	}
 
 	if (data->fannr) {
-		device_create_file(&new_client->dev, &dev_attr_fan1_input);
-		device_create_file(&new_client->dev, &dev_attr_fan2_input);
-		device_create_file(&new_client->dev, &dev_attr_fan1_min);
-		device_create_file(&new_client->dev, &dev_attr_fan2_min);
-		device_create_file(&new_client->dev, &dev_attr_fan1_div);
-		device_create_file(&new_client->dev, &dev_attr_fan2_div);
-		device_create_file(&new_client->dev, &dev_attr_fan1_status);
-		device_create_file(&new_client->dev, &dev_attr_fan2_status);
+		if (FAN_CONFIG_MONITOR(data->fan_conf, 0)) {
+			device_create_file(&new_client->dev,
+					   &dev_attr_fan1_input);
+			device_create_file(&new_client->dev,
+					   &dev_attr_fan1_min);
+			device_create_file(&new_client->dev,
+					   &dev_attr_fan1_div);
+			device_create_file(&new_client->dev,
+					   &dev_attr_fan1_status);
+		}
+
+		if (FAN_CONFIG_MONITOR(data->fan_conf, 1)) {
+			device_create_file(&new_client->dev,
+					   &dev_attr_fan2_input);
+			device_create_file(&new_client->dev,
+					   &dev_attr_fan2_min);
+			device_create_file(&new_client->dev,
+					   &dev_attr_fan2_div);
+			device_create_file(&new_client->dev,
+					   &dev_attr_fan2_status);
+		}
 
 		if (FAN_CONFIG_CONTROL(data->fan_conf, 0))
 			device_create_file(&new_client->dev, &dev_attr_pwm1);
@@ -913,10 +928,16 @@
 			device_create_file(&new_client->dev, &dev_attr_pwm2);
 	}
 	if (data->fannr = 3) {
-		device_create_file(&new_client->dev, &dev_attr_fan3_input);
-		device_create_file(&new_client->dev, &dev_attr_fan3_min);
-		device_create_file(&new_client->dev, &dev_attr_fan3_div);
-		device_create_file(&new_client->dev, &dev_attr_fan3_status);
+		if (FAN_CONFIG_MONITOR(data->fan_conf, 2)) {
+			device_create_file(&new_client->dev,
+					   &dev_attr_fan3_input);
+			device_create_file(&new_client->dev,
+					   &dev_attr_fan3_min);
+			device_create_file(&new_client->dev,
+					   &dev_attr_fan3_div);
+			device_create_file(&new_client->dev,
+					   &dev_attr_fan3_status);
+		}
 
 		if (FAN_CONFIG_CONTROL(data->fan_conf, 2))
 			device_create_file(&new_client->dev, &dev_attr_pwm3);


-- 
Jean Delvare
http://khali.linux-fr.org/
