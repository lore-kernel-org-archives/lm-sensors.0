From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 03 Jan 2008 18:44:09 +0000
Subject: [lm-sensors] [PATCH] hwmon: Discard useless I2C driver IDs
Message-Id: <20080103194409.7f04100f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Many I2C hwmon drivers define a driver ID but no other code references
these, meaning that they are useless. Discard them, along with a few
IDs which are defined but never used at all.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/adm1021.c     |    1 -
 drivers/hwmon/adm1025.c     |    1 -
 drivers/hwmon/adm9240.c     |    1 -
 drivers/hwmon/asb100.c      |    1 -
 drivers/hwmon/ds1621.c      |    1 -
 drivers/hwmon/fscher.c      |    1 -
 drivers/hwmon/fscpos.c      |    1 -
 drivers/hwmon/lm75.c        |    1 -
 drivers/hwmon/lm78.c        |    1 -
 drivers/hwmon/lm80.c        |    1 -
 drivers/hwmon/lm83.c        |    1 -
 drivers/hwmon/lm85.c        |    1 -
 drivers/hwmon/lm87.c        |    1 -
 drivers/hwmon/lm90.c        |    1 -
 drivers/hwmon/lm92.c        |    1 -
 drivers/hwmon/w83l785ts.c   |    1 -
 drivers/i2c/chips/eeprom.c  |    1 -
 drivers/i2c/chips/pcf8574.c |    1 -
 drivers/i2c/chips/pcf8591.c |    1 -
 include/linux/i2c-id.h      |   33 ---------------------------------
 20 files changed, 52 deletions(-)

--- linux-2.6.24-rc6.orig/drivers/hwmon/adm1021.c	2007-10-24 09:59:28.000000000 +0200
+++ linux-2.6.24-rc6/drivers/hwmon/adm1021.c	2008-01-03 19:08:06.000000000 +0100
@@ -115,7 +115,6 @@ static struct i2c_driver adm1021_driver 
 	.driver = {
 		.name	= "adm1021",
 	},
-	.id		= I2C_DRIVERID_ADM1021,
 	.attach_adapter	= adm1021_attach_adapter,
 	.detach_client	= adm1021_detach_client,
 };
--- linux-2.6.24-rc6.orig/drivers/hwmon/adm1025.c	2008-01-03 18:17:52.000000000 +0100
+++ linux-2.6.24-rc6/drivers/hwmon/adm1025.c	2008-01-03 19:08:06.000000000 +0100
@@ -123,7 +123,6 @@ static struct i2c_driver adm1025_driver 
 	.driver = {
 		.name	= "adm1025",
 	},
-	.id		= I2C_DRIVERID_ADM1025,
 	.attach_adapter	= adm1025_attach_adapter,
 	.detach_client	= adm1025_detach_client,
 };
--- linux-2.6.24-rc6.orig/drivers/hwmon/adm9240.c	2007-12-01 11:11:13.000000000 +0100
+++ linux-2.6.24-rc6/drivers/hwmon/adm9240.c	2008-01-03 19:08:06.000000000 +0100
@@ -141,7 +141,6 @@ static struct i2c_driver adm9240_driver 
 	.driver = {
 		.name	= "adm9240",
 	},
-	.id		= I2C_DRIVERID_ADM9240,
 	.attach_adapter	= adm9240_attach_adapter,
 	.detach_client	= adm9240_detach_client,
 };
--- linux-2.6.24-rc6.orig/drivers/hwmon/asb100.c	2008-01-03 18:17:52.000000000 +0100
+++ linux-2.6.24-rc6/drivers/hwmon/asb100.c	2008-01-03 19:08:06.000000000 +0100
@@ -221,7 +221,6 @@ static struct i2c_driver asb100_driver  	.driver = {
 		.name	= "asb100",
 	},
-	.id		= I2C_DRIVERID_ASB100,
 	.attach_adapter	= asb100_attach_adapter,
 	.detach_client	= asb100_detach_client,
 };
--- linux-2.6.24-rc6.orig/drivers/hwmon/ds1621.c	2007-10-24 09:59:28.000000000 +0200
+++ linux-2.6.24-rc6/drivers/hwmon/ds1621.c	2008-01-03 19:08:06.000000000 +0100
@@ -94,7 +94,6 @@ static struct i2c_driver ds1621_driver  	.driver = {
 		.name	= "ds1621",
 	},
-	.id		= I2C_DRIVERID_DS1621,
 	.attach_adapter	= ds1621_attach_adapter,
 	.detach_client	= ds1621_detach_client,
 };
--- linux-2.6.24-rc6.orig/drivers/hwmon/fscher.c	2007-10-24 09:59:28.000000000 +0200
+++ linux-2.6.24-rc6/drivers/hwmon/fscher.c	2008-01-03 19:08:06.000000000 +0100
@@ -123,7 +123,6 @@ static struct i2c_driver fscher_driver  	.driver = {
 		.name	= "fscher",
 	},
-	.id		= I2C_DRIVERID_FSCHER,
 	.attach_adapter	= fscher_attach_adapter,
 	.detach_client	= fscher_detach_client,
 };
--- linux-2.6.24-rc6.orig/drivers/hwmon/fscpos.c	2007-10-24 09:59:28.000000000 +0200
+++ linux-2.6.24-rc6/drivers/hwmon/fscpos.c	2008-01-03 19:08:06.000000000 +0100
@@ -105,7 +105,6 @@ static struct i2c_driver fscpos_driver  	.driver = {
 		.name	= "fscpos",
 	},
-	.id		= I2C_DRIVERID_FSCPOS,
 	.attach_adapter	= fscpos_attach_adapter,
 	.detach_client	= fscpos_detach_client,
 };
--- linux-2.6.24-rc6.orig/drivers/hwmon/lm75.c	2007-10-24 09:59:28.000000000 +0200
+++ linux-2.6.24-rc6/drivers/hwmon/lm75.c	2008-01-03 19:08:06.000000000 +0100
@@ -74,7 +74,6 @@ static struct i2c_driver lm75_driver = {
 	.driver = {
 		.name	= "lm75",
 	},
-	.id		= I2C_DRIVERID_LM75,
 	.attach_adapter	= lm75_attach_adapter,
 	.detach_client	= lm75_detach_client,
 };
--- linux-2.6.24-rc6.orig/drivers/hwmon/lm78.c	2008-01-03 18:17:51.000000000 +0100
+++ linux-2.6.24-rc6/drivers/hwmon/lm78.c	2008-01-03 19:08:06.000000000 +0100
@@ -168,7 +168,6 @@ static struct i2c_driver lm78_driver = {
 	.driver = {
 		.name	= "lm78",
 	},
-	.id		= I2C_DRIVERID_LM78,
 	.attach_adapter	= lm78_attach_adapter,
 	.detach_client	= lm78_detach_client,
 };
--- linux-2.6.24-rc6.orig/drivers/hwmon/lm80.c	2007-10-24 09:59:28.000000000 +0200
+++ linux-2.6.24-rc6/drivers/hwmon/lm80.c	2008-01-03 19:08:06.000000000 +0100
@@ -147,7 +147,6 @@ static struct i2c_driver lm80_driver = {
 	.driver = {
 		.name	= "lm80",
 	},
-	.id		= I2C_DRIVERID_LM80,
 	.attach_adapter	= lm80_attach_adapter,
 	.detach_client	= lm80_detach_client,
 };
--- linux-2.6.24-rc6.orig/drivers/hwmon/lm83.c	2007-10-24 09:59:28.000000000 +0200
+++ linux-2.6.24-rc6/drivers/hwmon/lm83.c	2008-01-03 19:08:06.000000000 +0100
@@ -133,7 +133,6 @@ static struct i2c_driver lm83_driver = {
 	.driver = {
 		.name	= "lm83",
 	},
-	.id		= I2C_DRIVERID_LM83,
 	.attach_adapter	= lm83_attach_adapter,
 	.detach_client	= lm83_detach_client,
 };
--- linux-2.6.24-rc6.orig/drivers/hwmon/lm85.c	2008-01-03 18:17:52.000000000 +0100
+++ linux-2.6.24-rc6/drivers/hwmon/lm85.c	2008-01-03 19:08:06.000000000 +0100
@@ -367,7 +367,6 @@ static struct i2c_driver lm85_driver = {
 	.driver = {
 		.name   = "lm85",
 	},
-	.id             = I2C_DRIVERID_LM85,
 	.attach_adapter = lm85_attach_adapter,
 	.detach_client  = lm85_detach_client,
 };
--- linux-2.6.24-rc6.orig/drivers/hwmon/lm87.c	2008-01-03 18:17:52.000000000 +0100
+++ linux-2.6.24-rc6/drivers/hwmon/lm87.c	2008-01-03 19:08:06.000000000 +0100
@@ -171,7 +171,6 @@ static struct i2c_driver lm87_driver = {
 	.driver = {
 		.name	= "lm87",
 	},
-	.id		= I2C_DRIVERID_LM87,
 	.attach_adapter	= lm87_attach_adapter,
 	.detach_client	= lm87_detach_client,
 };
--- linux-2.6.24-rc6.orig/drivers/hwmon/lm90.c	2008-01-03 18:17:51.000000000 +0100
+++ linux-2.6.24-rc6/drivers/hwmon/lm90.c	2008-01-03 19:08:06.000000000 +0100
@@ -204,7 +204,6 @@ static struct i2c_driver lm90_driver = {
 	.driver = {
 		.name	= "lm90",
 	},
-	.id		= I2C_DRIVERID_LM90,
 	.attach_adapter	= lm90_attach_adapter,
 	.detach_client	= lm90_detach_client,
 };
--- linux-2.6.24-rc6.orig/drivers/hwmon/lm92.c	2007-10-24 09:59:28.000000000 +0200
+++ linux-2.6.24-rc6/drivers/hwmon/lm92.c	2008-01-03 19:08:06.000000000 +0100
@@ -428,7 +428,6 @@ static struct i2c_driver lm92_driver = {
 	.driver = {
 		.name	= "lm92",
 	},
-	.id		= I2C_DRIVERID_LM92,
 	.attach_adapter	= lm92_attach_adapter,
 	.detach_client	= lm92_detach_client,
 };
--- linux-2.6.24-rc6.orig/drivers/hwmon/w83l785ts.c	2007-10-24 09:59:28.000000000 +0200
+++ linux-2.6.24-rc6/drivers/hwmon/w83l785ts.c	2008-01-03 19:08:06.000000000 +0100
@@ -96,7 +96,6 @@ static struct i2c_driver w83l785ts_drive
 	.driver = {
 		.name	= "w83l785ts",
 	},
-	.id		= I2C_DRIVERID_W83L785TS,
 	.attach_adapter	= w83l785ts_attach_adapter,
 	.detach_client	= w83l785ts_detach_client,
 };
--- linux-2.6.24-rc6.orig/drivers/i2c/chips/eeprom.c	2008-01-03 16:10:02.000000000 +0100
+++ linux-2.6.24-rc6/drivers/i2c/chips/eeprom.c	2008-01-03 19:08:06.000000000 +0100
@@ -71,7 +71,6 @@ static struct i2c_driver eeprom_driver  	.driver = {
 		.name	= "eeprom",
 	},
-	.id		= I2C_DRIVERID_EEPROM,
 	.attach_adapter	= eeprom_attach_adapter,
 	.detach_client	= eeprom_detach_client,
 };
--- linux-2.6.24-rc6.orig/drivers/i2c/chips/pcf8574.c	2008-01-03 16:10:02.000000000 +0100
+++ linux-2.6.24-rc6/drivers/i2c/chips/pcf8574.c	2008-01-03 19:08:06.000000000 +0100
@@ -67,7 +67,6 @@ static struct i2c_driver pcf8574_driver 
 	.driver = {
 		.name	= "pcf8574",
 	},
-	.id		= I2C_DRIVERID_PCF8574,
 	.attach_adapter	= pcf8574_attach_adapter,
 	.detach_client	= pcf8574_detach_client,
 };
--- linux-2.6.24-rc6.orig/drivers/i2c/chips/pcf8591.c	2008-01-03 16:10:02.000000000 +0100
+++ linux-2.6.24-rc6/drivers/i2c/chips/pcf8591.c	2008-01-03 19:08:06.000000000 +0100
@@ -92,7 +92,6 @@ static struct i2c_driver pcf8591_driver 
 	.driver = {
 		.name	= "pcf8591",
 	},
-	.id		= I2C_DRIVERID_PCF8591,
 	.attach_adapter	= pcf8591_attach_adapter,
 	.detach_client	= pcf8591_detach_client,
 };
--- linux-2.6.24-rc6.orig/include/linux/i2c-id.h	2008-01-03 18:17:52.000000000 +0100
+++ linux-2.6.24-rc6/include/linux/i2c-id.h	2008-01-03 19:08:06.000000000 +0100
@@ -94,39 +94,6 @@
 
 #define I2C_DRIVERID_I2CDEV	900
 
-/* IDs --   Use DRIVERIDs 1000-1999 for sensors.
-   These were originally in sensors.h in the lm_sensors package */
-#define I2C_DRIVERID_LM78 1002
-#define I2C_DRIVERID_LM75 1003
-#define I2C_DRIVERID_EEPROM 1005
-#define I2C_DRIVERID_LM80 1007
-#define I2C_DRIVERID_ADM1021 1008
-#define I2C_DRIVERID_ADM9240 1009
-#define I2C_DRIVERID_LTC1710 1010
-#define I2C_DRIVERID_BT869 1013
-#define I2C_DRIVERID_MAXILIFE 1014
-#define I2C_DRIVERID_MATORB 1015
-#define I2C_DRIVERID_THMC50 1017
-#define I2C_DRIVERID_ADM1025 1020
-#define I2C_DRIVERID_LM87 1021
-#define I2C_DRIVERID_PCF8574 1022
-#define I2C_DRIVERID_MTP008 1023
-#define I2C_DRIVERID_DS1621 1024
-#define I2C_DRIVERID_ADM1024 1025
-#define I2C_DRIVERID_CH700X 1027 /* single driver for CH7003-7009 digital pc to tv encoders */
-#define I2C_DRIVERID_FSCPOS 1028
-#define I2C_DRIVERID_FSCSCY 1029
-#define I2C_DRIVERID_PCF8591 1030
-#define I2C_DRIVERID_LM92 1033
-#define I2C_DRIVERID_SMARTBATT 1035
-#define I2C_DRIVERID_BMCSENSORS 1036
-#define I2C_DRIVERID_FS451 1037
-#define I2C_DRIVERID_LM85 1039
-#define I2C_DRIVERID_LM83 1040
-#define I2C_DRIVERID_LM90 1042
-#define I2C_DRIVERID_ASB100 1043
-#define I2C_DRIVERID_FSCHER 1046
-#define I2C_DRIVERID_W83L785TS 1047
 #define I2C_DRIVERID_OV7670 1048	/* Omnivision 7670 camera */
 
 /*


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
