From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 23 Mar 2006 15:19:49 +0000
Subject: [lm-sensors] [PATCH 01/10] lm83: Add LM82 support
Message-Id: <20060323161949.e6dd074b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jordan Crouse <jordan.crouse at amd.com>
Content-Disposition: inline; filename=hwmon-lm83-add-lm82-support.patch

Add LM82 temperature sensor support (similar to the LM83, 
but less featureful).

Signed-off-by: Jordan Crouse <jordan.crouse at amd.com>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 Documentation/hwmon/lm83 |   16 +++++++++++----
 drivers/hwmon/Kconfig    |    4 ++--
 drivers/hwmon/lm83.c     |   50 ++++++++++++++++++++++++++++++++++------------
 3 files changed, 51 insertions(+), 19 deletions(-)

--- linux-2.6.16-rc6.orig/Documentation/hwmon/lm83	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.16-rc6/Documentation/hwmon/lm83	2006-03-14 20:21:43.000000000 +0100
@@ -7,6 +7,10 @@
     Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
     Datasheet: Publicly available at the National Semiconductor website
                http://www.national.com/pf/LM/LM83.html
+  * National Semiconductor LM82
+    Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
+    Datasheet: Publicly available at the National Semiconductor website
+               http://www.national.com/pf/LM/LM82.html
 
 
 Author: Jean Delvare <khali at linux-fr.org>
@@ -15,10 +19,11 @@
 -----------
 
 The LM83 is a digital temperature sensor. It senses its own temperature as
-well as the temperature of up to three external diodes. It is compatible
-with many other devices such as the LM84 and all other ADM1021 clones.
-The main difference between the LM83 and the LM84 in that the later can
-only sense the temperature of one external diode.
+well as the temperature of up to three external diodes. The LM82 is
+a stripped down version of the LM83 that only supports one external diode.
+Both are compatible with many other devices such as the LM84 and all
+other ADM1021 clones. The main difference between the LM83 and the LM84
+in that the later can only sense the temperature of one external diode.
 
 Using the adm1021 driver for a LM83 should work, but only two temperatures
 will be reported instead of four.
@@ -36,6 +41,9 @@
     Iwill       MPX2
     Soltek      SL-75DRV5
 
+The LM82 is confirmed to have been found on most AMD Geode reference
+designs and test platforms.
+
 The driver has been successfully tested by Magnus Forsstr?m, who I'd
 like to thank here. More testers will be of course welcome.
 
--- linux-2.6.16-rc6.orig/drivers/hwmon/Kconfig	2006-03-14 19:34:06.000000000 +0100
+++ linux-2.6.16-rc6/drivers/hwmon/Kconfig	2006-03-14 20:07:17.000000000 +0100
@@ -236,11 +236,11 @@
 	  will be called lm80.
 
 config SENSORS_LM83
-	tristate "National Semiconductor LM83"
+	tristate "National Semiconductor LM83 and compatibles"
 	depends on HWMON && I2C
 	help
 	  If you say yes here you get support for National Semiconductor
-	  LM83 sensor chips.
+	  LM82 and LM83 sensor chips.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called lm83.
--- linux-2.6.16-rc6.orig/drivers/hwmon/lm83.c	2006-03-14 19:34:06.000000000 +0100
+++ linux-2.6.16-rc6/drivers/hwmon/lm83.c	2006-03-14 20:25:36.000000000 +0100
@@ -12,6 +12,10 @@
  * Since the datasheet omits to give the chip stepping code, I give it
  * here: 0x03 (at register 0xff).
  *
+ * Also supports the LM82 temp sensor, which is basically a stripped down
+ * model of the LM83.  Datasheet is here:
+ * http://www.national.com/pf/LM/LM82.html
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -52,7 +56,7 @@
  * Insmod parameters
  */
 
-I2C_CLIENT_INSMOD_1(lm83);
+I2C_CLIENT_INSMOD_2(lm83, lm82);
 
 /*
  * The LM83 registers
@@ -283,6 +287,9 @@
 		if (man_id = 0x01) { /* National Semiconductor */
 			if (chip_id = 0x03) {
 				kind = lm83;
+			} else
+			if (chip_id = 0x01) {
+				kind = lm82;
 			}
 		}
 
@@ -296,6 +303,9 @@
 
 	if (kind = lm83) {
 		name = "lm83";
+	} else
+	if (kind = lm82) {
+		name = "lm82";
 	}
 
 	/* We can fill in the remaining client fields */
@@ -319,32 +329,46 @@
 		goto exit_detach;
 	}
 
+	/*
+	 * The LM82 can only monitor one external diode which is
+	 * at the same register as the LM83 temp3 entry - so we
+	 * declare 1 and 3 common, and then 2 and 4 only for the LM83.
+	 */
+
 	device_create_file(&new_client->dev,
 			   &sensor_dev_attr_temp1_input.dev_attr);
 	device_create_file(&new_client->dev,
-			   &sensor_dev_attr_temp2_input.dev_attr);
-	device_create_file(&new_client->dev,
 			   &sensor_dev_attr_temp3_input.dev_attr);
-	device_create_file(&new_client->dev,
-			   &sensor_dev_attr_temp4_input.dev_attr);
+
 	device_create_file(&new_client->dev,
 			   &sensor_dev_attr_temp1_max.dev_attr);
 	device_create_file(&new_client->dev,
-			   &sensor_dev_attr_temp2_max.dev_attr);
-	device_create_file(&new_client->dev,
 			   &sensor_dev_attr_temp3_max.dev_attr);
-	device_create_file(&new_client->dev,
-			   &sensor_dev_attr_temp4_max.dev_attr);
+
 	device_create_file(&new_client->dev,
 			   &sensor_dev_attr_temp1_crit.dev_attr);
 	device_create_file(&new_client->dev,
-			   &sensor_dev_attr_temp2_crit.dev_attr);
-	device_create_file(&new_client->dev,
 			   &sensor_dev_attr_temp3_crit.dev_attr);
-	device_create_file(&new_client->dev,
-			   &sensor_dev_attr_temp4_crit.dev_attr);
+
 	device_create_file(&new_client->dev, &dev_attr_alarms);
 
+	if (kind = lm83) {
+		device_create_file(&new_client->dev,
+				   &sensor_dev_attr_temp2_input.dev_attr);
+		device_create_file(&new_client->dev,
+				   &sensor_dev_attr_temp4_input.dev_attr);
+
+		device_create_file(&new_client->dev,
+				   &sensor_dev_attr_temp2_max.dev_attr);
+		device_create_file(&new_client->dev,
+				   &sensor_dev_attr_temp4_max.dev_attr);
+
+		device_create_file(&new_client->dev,
+				   &sensor_dev_attr_temp2_crit.dev_attr);
+		device_create_file(&new_client->dev,
+				   &sensor_dev_attr_temp4_crit.dev_attr);
+	}
+
 	return 0;
 
 exit_detach:

-- 
Jean Delvare

