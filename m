From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 09 Oct 2007 13:22:22 +0000
Subject: [lm-sensors] hwmon/lm87: Add support for the Analog Devices ADM1024
Message-Id: <20071009152222.0e4a51a3@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

It happens that the Analog Devices ADM1024 is fully compatible with
the National Semiconductor LM87, so support for the former can easily
be added to the lm87 driver.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
Steven, Murray, can you please test this patch and confirm that it
works for you? I can also provide a standalone driver if it's easier
for you to test. Thanks.

 Documentation/hwmon/lm87 |   11 ++++++++---
 drivers/hwmon/Kconfig    |    4 ++--
 drivers/hwmon/lm87.c     |   25 +++++++++++++++++++------
 3 files changed, 29 insertions(+), 11 deletions(-)

--- linux-2.6.23-rc9.orig/Documentation/hwmon/lm87	2007-10-09 08:42:48.000000000 +0200
+++ linux-2.6.23-rc9/Documentation/hwmon/lm87	2007-10-09 11:14:05.000000000 +0200
@@ -4,8 +4,12 @@ Kernel driver lm87
 Supported chips:
   * National Semiconductor LM87
     Prefix: 'lm87'
-    Addresses scanned: I2C 0x2c - 0x2f
+    Addresses scanned: I2C 0x2c - 0x2e
     Datasheet: http://www.national.com/pf/LM/LM87.html
+  * Analog Devices ADM1024
+    Prefix: 'adm1024'
+    Addresses scanned: I2C 0x2c - 0x2e
+    Datasheet: http://www.analog.com/en/prod/0,2877,ADM1024,00.html
 
 Authors:
         Frodo Looijaard <frodol@dds.nl>,
@@ -19,11 +23,12 @@ Authors:
 Description
 -----------
 
-This driver implements support for the National Semiconductor LM87.
+This driver implements support for the National Semiconductor LM87
+and the Analog Devices ADM1024.
 
 The LM87 implements up to three temperature sensors, up to two fan
 rotation speed sensors, up to seven voltage sensors, alarms, and some
-miscellaneous stuff.
+miscellaneous stuff. The ADM1024 is fully compatible.
 
 Temperatures are measured in degrees Celsius. Each input has a high
 and low alarm settings. A high limit produces an alarm when the value
--- linux-2.6.23-rc9.orig/drivers/hwmon/Kconfig	2007-10-09 08:42:48.000000000 +0200
+++ linux-2.6.23-rc9/drivers/hwmon/Kconfig	2007-10-09 09:09:32.000000000 +0200
@@ -395,12 +395,12 @@ config SENSORS_LM85
 	  will be called lm85.
 
 config SENSORS_LM87
-	tristate "National Semiconductor LM87"
+	tristate "National Semiconductor LM87 and compatibles"
 	depends on I2C
 	select HWMON_VID
 	help
 	  If you say yes here you get support for National Semiconductor LM87
-	  sensor chips.
+	  and Analog Devices ADM1024 sensor chips.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called lm87.
--- linux-2.6.23-rc9.orig/drivers/hwmon/lm87.c	2007-10-09 08:43:55.000000000 +0200
+++ linux-2.6.23-rc9/drivers/hwmon/lm87.c	2007-10-09 12:16:41.000000000 +0200
@@ -5,7 +5,7 @@
  *                          Philip Edelbrock <phil@netroedge.com>
  *                          Stephen Rousset <stephen.rousset@rocketlogix.com>
  *                          Dan Eaton <dan.eaton@rocketlogix.com>
- * Copyright (C) 2004       Jean Delvare <khali@linux-fr.org>
+ * Copyright (C) 2004,2007  Jean Delvare <khali@linux-fr.org>
  *
  * Original port to Linux 2.6 by Jeff Oliver.
  *
@@ -37,6 +37,11 @@
  * instead. The LM87 is the only hardware monitoring chipset I know of
  * which uses amplitude modulation. Be careful when using this feature.
  *
+ * This driver also supports the ADM1024, a sensor chip made by Analog
+ * Devices. That chip is fully compatible with the LM87. Complete
+ * datasheet can be obtained from Analog's website at:
+ *   http://www.analog.com/en/prod/0,2877,ADM1024,00.html
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -74,7 +79,7 @@ static unsigned short normal_i2c[] = { 0
  * Insmod parameters
  */
 
-I2C_CLIENT_INSMOD_1(lm87);
+I2C_CLIENT_INSMOD_2(lm87, adm1024);
 
 /*
  * The LM87 registers
@@ -662,6 +667,7 @@ static int lm87_detect(struct i2c_adapte
 	struct i2c_client *new_client;
 	struct lm87_data *data;
 	int err = 0;
+	static const char *names[] = { "lm87", "adm1024" };
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		goto exit;
@@ -686,11 +692,18 @@ static int lm87_detect(struct i2c_adapte
 
 	/* Now, we do the remaining detection. */
 	if (kind < 0) {
+		u8 cid = lm87_read_value(new_client, LM87_REG_COMPANY_ID);
 		u8 rev = lm87_read_value(new_client, LM87_REG_REVISION);
 
-		if (rev < 0x01 || rev > 0x08
-		 || (lm87_read_value(new_client, LM87_REG_CONFIG) & 0x80)
-		 || lm87_read_value(new_client, LM87_REG_COMPANY_ID) != 0x02) {
+		if (cid = 0x02			/* National Semiconductor */
+		 && (rev >= 0x01 && rev <= 0x08))
+			kind = lm87;
+		else if (cid = 0x41		/* Analog Devices */
+		      && (rev & 0xf0) = 0x10)
+			kind = adm1024;
+
+		if (kind < 0
+		 || (lm87_read_value(new_client, LM87_REG_CONFIG) & 0x80)) {
 			dev_dbg(&adapter->dev,
 				"LM87 detection failed at 0x%02x.\n",
 				address);
@@ -699,7 +712,7 @@ static int lm87_detect(struct i2c_adapte
 	}
 
 	/* We can fill in the remaining client fields */
-	strlcpy(new_client->name, "lm87", I2C_NAME_SIZE);
+	strlcpy(new_client->name, names[kind - 1], I2C_NAME_SIZE);
 	data->valid = 0;
 	mutex_init(&data->update_lock);
 

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
