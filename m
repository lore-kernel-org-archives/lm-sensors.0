From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 26 Nov 2005 20:34:59 +0000
Subject: [lm-sensors] [PATCH 11/25] i2c: Drop i2c_driver.{owner, name},
Message-Id: <20051126203600.4e73e09b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Laurent Riffard <laurent.riffard@free.fr>
Content-Disposition: inline; filename=i2c-drop-driver-owner-and-name-02-chips.patch

We should use the i2c_driver.driver's .name and .owner fields
instead of the i2c_driver's ones.

This patch updates the miscellaneaous i2c chip drivers.

Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/i2c/chips/ds1337.c       |    6 ++++--
 drivers/i2c/chips/ds1374.c       |    6 ++++--
 drivers/i2c/chips/eeprom.c       |    6 ++++--
 drivers/i2c/chips/isp1301_omap.c |    6 ++++--
 drivers/i2c/chips/m41t00.c       |    6 ++++--
 drivers/i2c/chips/max6875.c      |    6 ++++--
 drivers/i2c/chips/pca9539.c      |    6 ++++--
 drivers/i2c/chips/pcf8574.c      |    6 ++++--
 drivers/i2c/chips/pcf8591.c      |    6 ++++--
 drivers/i2c/chips/rtc8564.c      |    6 ++++--
 drivers/i2c/chips/tps65010.c     |    6 ++++--
 drivers/i2c/chips/x1205.c        |    6 ++++--
 12 files changed, 48 insertions(+), 24 deletions(-)

--- linux-2.6.15-rc2.orig/drivers/i2c/chips/ds1337.c	2005-11-25 22:25:46.000000000 +0100
+++ linux-2.6.15-rc2/drivers/i2c/chips/ds1337.c	2005-11-25 22:26:07.000000000 +0100
@@ -52,8 +52,10 @@
  * Driver data (common to all clients)
  */
 static struct i2c_driver ds1337_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "ds1337",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "ds1337",
+	},
 	.attach_adapter	= ds1337_attach_adapter,
 	.detach_client	= ds1337_detach_client,
 	.command	= ds1337_command,
--- linux-2.6.15-rc2.orig/drivers/i2c/chips/ds1374.c	2005-11-25 22:25:46.000000000 +0100
+++ linux-2.6.15-rc2/drivers/i2c/chips/ds1374.c	2005-11-25 22:26:07.000000000 +0100
@@ -232,8 +232,10 @@
 }
 
 static struct i2c_driver ds1374_driver = {
-	.owner = THIS_MODULE,
-	.name = DS1374_DRV_NAME,
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= DS1374_DRV_NAME,
+	},
 	.id = I2C_DRIVERID_DS1374,
 	.attach_adapter = ds1374_attach,
 	.detach_client = ds1374_detach,
--- linux-2.6.15-rc2.orig/drivers/i2c/chips/eeprom.c	2005-11-25 22:25:46.000000000 +0100
+++ linux-2.6.15-rc2/drivers/i2c/chips/eeprom.c	2005-11-25 22:26:07.000000000 +0100
@@ -68,8 +68,10 @@
 
 /* This is the driver that will be inserted */
 static struct i2c_driver eeprom_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "eeprom",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "eeprom",
+	},
 	.id		= I2C_DRIVERID_EEPROM,
 	.attach_adapter	= eeprom_attach_adapter,
 	.detach_client	= eeprom_detach_client,
--- linux-2.6.15-rc2.orig/drivers/i2c/chips/max6875.c	2005-11-25 22:25:46.000000000 +0100
+++ linux-2.6.15-rc2/drivers/i2c/chips/max6875.c	2005-11-25 22:26:07.000000000 +0100
@@ -67,8 +67,10 @@
 
 /* This is the driver that will be inserted */
 static struct i2c_driver max6875_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "max6875",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "max6875",
+	},
 	.attach_adapter	= max6875_attach_adapter,
 	.detach_client	= max6875_detach_client,
 };
--- linux-2.6.15-rc2.orig/drivers/i2c/chips/pca9539.c	2005-11-25 22:25:46.000000000 +0100
+++ linux-2.6.15-rc2/drivers/i2c/chips/pca9539.c	2005-11-25 22:26:07.000000000 +0100
@@ -38,8 +38,10 @@
 
 /* This is the driver that will be inserted */
 static struct i2c_driver pca9539_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "pca9539",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "pca9539",
+	},
 	.attach_adapter	= pca9539_attach_adapter,
 	.detach_client	= pca9539_detach_client,
 };
--- linux-2.6.15-rc2.orig/drivers/i2c/chips/pcf8574.c	2005-11-25 22:25:46.000000000 +0100
+++ linux-2.6.15-rc2/drivers/i2c/chips/pcf8574.c	2005-11-25 22:26:07.000000000 +0100
@@ -65,8 +65,10 @@
 
 /* This is the driver that will be inserted */
 static struct i2c_driver pcf8574_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "pcf8574",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "pcf8574",
+	},
 	.id		= I2C_DRIVERID_PCF8574,
 	.attach_adapter	= pcf8574_attach_adapter,
 	.detach_client	= pcf8574_detach_client,
--- linux-2.6.15-rc2.orig/drivers/i2c/chips/pcf8591.c	2005-11-25 22:25:46.000000000 +0100
+++ linux-2.6.15-rc2/drivers/i2c/chips/pcf8591.c	2005-11-25 22:26:07.000000000 +0100
@@ -88,8 +88,10 @@
 
 /* This is the driver that will be inserted */
 static struct i2c_driver pcf8591_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "pcf8591",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "pcf8591",
+	},
 	.id		= I2C_DRIVERID_PCF8591,
 	.attach_adapter	= pcf8591_attach_adapter,
 	.detach_client	= pcf8591_detach_client,
--- linux-2.6.15-rc2.orig/drivers/i2c/chips/rtc8564.c	2005-11-25 22:25:46.000000000 +0100
+++ linux-2.6.15-rc2/drivers/i2c/chips/rtc8564.c	2005-11-25 22:26:07.000000000 +0100
@@ -359,8 +359,10 @@
 }
 
 static struct i2c_driver rtc8564_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "RTC8564",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "RTC8564",
+	},
 	.id		= I2C_DRIVERID_RTC8564,
 	.attach_adapter = rtc8564_probe,
 	.detach_client	= rtc8564_detach,
--- linux-2.6.15-rc2.orig/drivers/i2c/chips/isp1301_omap.c	2005-11-25 22:25:46.000000000 +0100
+++ linux-2.6.15-rc2/drivers/i2c/chips/isp1301_omap.c	2005-11-25 22:26:07.000000000 +0100
@@ -1632,8 +1632,10 @@
 }
 
 static struct i2c_driver isp1301_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "isp1301_omap",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "isp1301_omap",
+	},
 	.id		= 1301,		/* FIXME "official", i2c-ids.h */
 	.class		= I2C_CLASS_HWMON,
 	.attach_adapter	= isp1301_scan_bus,
--- linux-2.6.15-rc2.orig/drivers/i2c/chips/m41t00.c	2005-11-25 22:25:46.000000000 +0100
+++ linux-2.6.15-rc2/drivers/i2c/chips/m41t00.c	2005-11-25 22:26:07.000000000 +0100
@@ -211,8 +211,10 @@
 }
 
 static struct i2c_driver m41t00_driver = {
-	.owner		= THIS_MODULE,
-	.name		= M41T00_DRV_NAME,
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= M41T00_DRV_NAME,
+	},
 	.id		= I2C_DRIVERID_STM41T00,
 	.attach_adapter	= m41t00_attach,
 	.detach_client	= m41t00_detach,
--- linux-2.6.15-rc2.orig/drivers/i2c/chips/tps65010.c	2005-11-25 22:25:46.000000000 +0100
+++ linux-2.6.15-rc2/drivers/i2c/chips/tps65010.c	2005-11-25 22:26:07.000000000 +0100
@@ -637,8 +637,10 @@
 }
 
 static struct i2c_driver tps65010_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "tps65010",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "tps65010",
+	},
 	.attach_adapter	= tps65010_scan_bus,
 	.detach_client	= __exit_p(tps65010_detach_client),
 };
--- linux-2.6.15-rc2.orig/drivers/i2c/chips/x1205.c	2005-11-25 22:25:47.000000000 +0100
+++ linux-2.6.15-rc2/drivers/i2c/chips/x1205.c	2005-11-25 22:26:07.000000000 +0100
@@ -105,8 +105,10 @@
 	void *arg);
 
 static struct i2c_driver x1205_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "x1205",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "x1205",
+	},
 	.attach_adapter = &x1205_attach,
 	.detach_client	= &x1205_detach,
 };

-- 
Jean Delvare
