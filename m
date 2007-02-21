From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 21 Feb 2007 08:29:08 +0000
Subject: [lm-sensors] [PATCH] hwmon/smsc47m192: Document the LPC47M292 as
Message-Id: <20070221092908.b8465ef0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Subject: hwmon/smsc47m192: Document the LPC47M292 as supported

The new SMSC LPC47M292 Super-I/O chip includes a hardware monitoring
block which is compatible with those of the LPC47M192.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 Documentation/hwmon/smsc47m192 |    7 ++++---
 drivers/hwmon/Kconfig          |    3 ++-
 drivers/hwmon/smsc47m192.c     |    4 ++--
 3 files changed, 8 insertions(+), 6 deletions(-)

--- linux-2.6.21-rc1.orig/Documentation/hwmon/smsc47m192	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6.21-rc1/Documentation/hwmon/smsc47m192	2007-02-21 08:50:14.000000000 +0100
@@ -2,12 +2,13 @@ Kernel driver smsc47m192
 ============
 
 Supported chips:
-  * SMSC LPC47M192 and LPC47M997
+  * SMSC LPC47M192, LPC47M15x, LPC47M292 and LPC47M997
     Prefix: 'smsc47m192'
     Addresses scanned: I2C 0x2c - 0x2d
     Datasheet: The datasheet for LPC47M192 is publicly available from
                http://www.smsc.com/
-               The LPC47M997 is compatible for hardware monitoring.
+               The LPC47M15x, LPC47M292 and LPC47M997 are compatible for
+               hardware monitoring.
 
 Author: Hartmut Rick <linux at rick.claranet.de>
         Special thanks to Jean Delvare for careful checking
@@ -18,7 +19,7 @@ Description
 -----------
 
 This driver implements support for the hardware sensor capabilities
-of the SMSC LPC47M192 and LPC47M997 Super-I/O chips.
+of the SMSC LPC47M192 and compatible Super-I/O chips.
 
 These chips support 3 temperature channels and 8 voltage inputs
 as well as CPU voltage VID input.
--- linux-2.6.21-rc1.orig/drivers/hwmon/Kconfig	2007-02-21 08:36:07.000000000 +0100
+++ linux-2.6.21-rc1/drivers/hwmon/Kconfig	2007-02-21 08:48:55.000000000 +0100
@@ -437,7 +437,8 @@ config SENSORS_SMSC47M192
 	select HWMON_VID
 	help
 	  If you say yes here you get support for the temperature and
-	  voltage sensors of the SMSC LPC47M192 and LPC47M997 chips.
+	  voltage sensors of the SMSC LPC47M192, LPC47M15x, LPC47M292
+	  and LPC47M997 chips.
 
 	  The fan monitoring and control capabilities of these chips
 	  are supported by another driver, select
--- linux-2.6.21-rc1.orig/drivers/hwmon/smsc47m192.c	2007-02-09 09:17:47.000000000 +0100
+++ linux-2.6.21-rc1/drivers/hwmon/smsc47m192.c	2007-02-21 08:43:49.000000000 +0100
@@ -1,6 +1,6 @@
 /*
     smsc47m192.c - Support for hardware monitoring block of
-                   SMSC LPC47M192 and LPC47M997 Super I/O chips
+                   SMSC LPC47M192 and compatible Super I/O chips
 
     Copyright (C) 2006  Hartmut Rick <linux at rick.claranet.de>
 
@@ -518,7 +518,7 @@ static int smsc47m192_detect(struct i2c_
 		 && (i2c_smbus_read_byte_data(client,
 				SMSC47M192_REG_VID4) & 0xfe) = 0x80) {
 			dev_info(&adapter->dev,
-				 "found SMSC47M192 or SMSC47M997, "
+				 "found SMSC47M192 or compatible, "
 				 "version 2, stepping A%d\n", version & 0x0f);
 		} else {
 			dev_dbg(&adapter->dev,


-- 
Jean Delvare

