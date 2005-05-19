From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:12 +0000
Subject: [PATCH 2.6] I2C: Do not init global variables to 0
Message-Id: <20040825225039.0cded377.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

This trivial patch enforces the rule that global variables should not be
explicitely initialized to 0 for all i2c chip drivers.

Thanks.

Signed-off-by: Jean Delvare <khali at linux-fr dot org>

diff -ru linux-2.6.9-rc1/drivers/i2c/chips.orig/adm1021.c linux-2.6.9-rc1/drivers/i2c/chips/adm1021.c
--- linux-2.6.9-rc1/drivers/i2c/chips.orig/adm1021.c	2004-08-24 18:42:46.000000000 +0200
+++ linux-2.6.9-rc1/drivers/i2c/chips/adm1021.c	2004-08-24 21:21:34.000000000 +0200
@@ -148,7 +148,7 @@
 	.detach_client	= adm1021_detach_client,
 };
 
-static int adm1021_id = 0;
+static int adm1021_id;
 
 #define show(value)	\
 static ssize_t show_##value(struct device *dev, char *buf)		\
diff -ru linux-2.6.9-rc1/drivers/i2c/chips.orig/adm1025.c linux-2.6.9-rc1/drivers/i2c/chips/adm1025.c
--- linux-2.6.9-rc1/drivers/i2c/chips.orig/adm1025.c	2004-08-24 18:42:46.000000000 +0200
+++ linux-2.6.9-rc1/drivers/i2c/chips/adm1025.c	2004-08-24 21:21:17.000000000 +0200
@@ -153,7 +153,7 @@
  * Internal variables
  */
 
-static int adm1025_id = 0;
+static int adm1025_id;
 
 /*
  * Sysfs stuff
diff -ru linux-2.6.9-rc1/drivers/i2c/chips.orig/ds1621.c linux-2.6.9-rc1/drivers/i2c/chips/ds1621.c
--- linux-2.6.9-rc1/drivers/i2c/chips.orig/ds1621.c	2004-08-24 18:42:46.000000000 +0200
+++ linux-2.6.9-rc1/drivers/i2c/chips/ds1621.c	2004-08-24 21:21:14.000000000 +0200
@@ -96,7 +96,7 @@
 	.detach_client	= ds1621_detach_client,
 };
 
-static int ds1621_id = 0;
+static int ds1621_id;
 
 /* All registers are word-sized, except for the configuration register.
    DS1621 uses a high-byte first convention, which is exactly opposite to
diff -ru linux-2.6.9-rc1/drivers/i2c/chips.orig/eeprom.c linux-2.6.9-rc1/drivers/i2c/chips/eeprom.c
--- linux-2.6.9-rc1/drivers/i2c/chips.orig/eeprom.c	2004-08-24 18:42:46.000000000 +0200
+++ linux-2.6.9-rc1/drivers/i2c/chips/eeprom.c	2004-08-24 21:21:11.000000000 +0200
@@ -86,7 +86,7 @@
 	.detach_client	= eeprom_detach_client,
 };
 
-static int eeprom_id = 0;
+static int eeprom_id;
 
 static void eeprom_update_client(struct i2c_client *client, u8 slice)
 {
diff -ru linux-2.6.9-rc1/drivers/i2c/chips.orig/fscher.c linux-2.6.9-rc1/drivers/i2c/chips/fscher.c
--- linux-2.6.9-rc1/drivers/i2c/chips.orig/fscher.c	2004-08-21 12:20:41.000000000 +0200
+++ linux-2.6.9-rc1/drivers/i2c/chips/fscher.c	2004-08-24 21:21:07.000000000 +0200
@@ -156,7 +156,7 @@
  * Internal variables
  */
 
-static int fscher_id = 0;
+static int fscher_id;
 
 /*
  * Sysfs stuff
diff -ru linux-2.6.9-rc1/drivers/i2c/chips.orig/gl518sm.c linux-2.6.9-rc1/drivers/i2c/chips/gl518sm.c
--- linux-2.6.9-rc1/drivers/i2c/chips.orig/gl518sm.c	2004-08-21 12:20:41.000000000 +0200
+++ linux-2.6.9-rc1/drivers/i2c/chips/gl518sm.c	2004-08-24 21:21:02.000000000 +0200
@@ -164,7 +164,7 @@
  * Internal variables
  */
 
-static int gl518_id = 0;
+static int gl518_id;
 
 /*
  * Sysfs stuff
diff -ru linux-2.6.9-rc1/drivers/i2c/chips.orig/it87.c linux-2.6.9-rc1/drivers/i2c/chips/it87.c
--- linux-2.6.9-rc1/drivers/i2c/chips.orig/it87.c	2004-08-24 18:42:46.000000000 +0200
+++ linux-2.6.9-rc1/drivers/i2c/chips/it87.c	2004-08-24 21:20:59.000000000 +0200
@@ -226,7 +226,7 @@
 	.detach_client	= it87_detach_client,
 };
 
-static int it87_id = 0;
+static int it87_id;
 
 static ssize_t show_in(struct device *dev, char *buf, int nr)
 {
diff -ru linux-2.6.9-rc1/drivers/i2c/chips.orig/lm75.c linux-2.6.9-rc1/drivers/i2c/chips/lm75.c
--- linux-2.6.9-rc1/drivers/i2c/chips.orig/lm75.c	2004-08-21 12:33:19.000000000 +0200
+++ linux-2.6.9-rc1/drivers/i2c/chips/lm75.c	2004-08-24 21:20:54.000000000 +0200
@@ -74,7 +74,7 @@
 	.detach_client	= lm75_detach_client,
 };
 
-static int lm75_id = 0;
+static int lm75_id;
 
 #define show(value)	\
 static ssize_t show_##value(struct device *dev, char *buf)		\
diff -ru linux-2.6.9-rc1/drivers/i2c/chips.orig/lm77.c linux-2.6.9-rc1/drivers/i2c/chips/lm77.c
--- linux-2.6.9-rc1/drivers/i2c/chips.orig/lm77.c	2004-08-21 12:33:19.000000000 +0200
+++ linux-2.6.9-rc1/drivers/i2c/chips/lm77.c	2004-08-24 21:20:47.000000000 +0200
@@ -83,7 +83,7 @@
 	.detach_client	= lm77_detach_client,
 };
 
-static int lm77_id = 0;
+static int lm77_id;
 
 /* straight from the datasheet */
 #define LM77_TEMP_MIN (-55000)
diff -ru linux-2.6.9-rc1/drivers/i2c/chips.orig/lm80.c linux-2.6.9-rc1/drivers/i2c/chips/lm80.c
--- linux-2.6.9-rc1/drivers/i2c/chips.orig/lm80.c	2004-08-21 12:20:41.000000000 +0200
+++ linux-2.6.9-rc1/drivers/i2c/chips/lm80.c	2004-08-24 21:20:34.000000000 +0200
@@ -145,7 +145,7 @@
  * Internal variables
  */
 
-static int lm80_id = 0;
+static int lm80_id;
 
 /*
  * Driver data (common to all clients)
diff -ru linux-2.6.9-rc1/drivers/i2c/chips.orig/lm83.c linux-2.6.9-rc1/drivers/i2c/chips/lm83.c
--- linux-2.6.9-rc1/drivers/i2c/chips.orig/lm83.c	2004-08-24 18:42:46.000000000 +0200
+++ linux-2.6.9-rc1/drivers/i2c/chips/lm83.c	2004-08-24 21:20:28.000000000 +0200
@@ -152,7 +152,7 @@
  * Internal variables
  */
 
-static int lm83_id = 0;
+static int lm83_id;
 
 /*
  * Sysfs stuff
diff -ru linux-2.6.9-rc1/drivers/i2c/chips.orig/lm85.c linux-2.6.9-rc1/drivers/i2c/chips/lm85.c
--- linux-2.6.9-rc1/drivers/i2c/chips.orig/lm85.c	2004-08-24 18:42:46.000000000 +0200
+++ linux-2.6.9-rc1/drivers/i2c/chips/lm85.c	2004-08-24 21:20:24.000000000 +0200
@@ -405,7 +405,7 @@
 };
 
 /* Unique ID assigned to each LM85 detected */
-static int lm85_id = 0;
+static int lm85_id;
 
 
 /* 4 Fans */
diff -ru linux-2.6.9-rc1/drivers/i2c/chips.orig/lm90.c linux-2.6.9-rc1/drivers/i2c/chips/lm90.c
--- linux-2.6.9-rc1/drivers/i2c/chips.orig/lm90.c	2004-08-21 12:33:19.000000000 +0200
+++ linux-2.6.9-rc1/drivers/i2c/chips/lm90.c	2004-08-24 21:20:18.000000000 +0200
@@ -187,7 +187,7 @@
  * Internal variables
  */
 
-static int lm90_id = 0;
+static int lm90_id;
 
 /*
  * Sysfs stuff
diff -ru linux-2.6.9-rc1/drivers/i2c/chips.orig/max1619.c linux-2.6.9-rc1/drivers/i2c/chips/max1619.c
--- linux-2.6.9-rc1/drivers/i2c/chips.orig/max1619.c	2004-08-21 12:20:41.000000000 +0200
+++ linux-2.6.9-rc1/drivers/i2c/chips/max1619.c	2004-08-24 21:19:50.000000000 +0200
@@ -120,7 +120,7 @@
  * Internal variables
  */
 
-static int max1619_id = 0;
+static int max1619_id;
 
 /*
  * Sysfs stuff
diff -ru linux-2.6.9-rc1/drivers/i2c/chips.orig/pcf8574.c linux-2.6.9-rc1/drivers/i2c/chips/pcf8574.c
--- linux-2.6.9-rc1/drivers/i2c/chips.orig/pcf8574.c	2004-08-21 12:20:06.000000000 +0200
+++ linux-2.6.9-rc1/drivers/i2c/chips/pcf8574.c	2004-08-24 21:19:44.000000000 +0200
@@ -77,7 +77,7 @@
 	.detach_client	= pcf8574_detach_client,
 };
 
-static int pcf8574_id = 0;
+static int pcf8574_id;
 
 /* following are the sysfs callback functions */
 static ssize_t show_read(struct device *dev, char *buf)
diff -ru linux-2.6.9-rc1/drivers/i2c/chips.orig/pcf8591.c linux-2.6.9-rc1/drivers/i2c/chips/pcf8591.c
--- linux-2.6.9-rc1/drivers/i2c/chips.orig/pcf8591.c	2004-08-24 18:42:46.000000000 +0200
+++ linux-2.6.9-rc1/drivers/i2c/chips/pcf8591.c	2004-08-24 21:19:34.000000000 +0200
@@ -99,7 +99,7 @@
 	.detach_client	= pcf8591_detach_client,
 };
 
-static int pcf8591_id = 0;
+static int pcf8591_id;
 
 /* following are the sysfs callback functions */
 #define show_in_channel(channel)					\


-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
