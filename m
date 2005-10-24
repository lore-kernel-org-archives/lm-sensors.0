From: laurent.riffard@free.fr (Laurent riffard)
Date: Mon, 24 Oct 2005 23:30:51 +0000
Subject: [lm-sensors] [patch 2/9] I2C: remove i2c_driver's .owner and .name
Message-Id: <20051024212540.872897000@antares.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

We should use the i2c_driver.driver's .name and .owner fields
instead of the i2c_drivers's ones.

This patch updates the i2c drivers.

Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
--

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

Index: linux-2.6-mm/drivers/i2c/chips/ds1337.c
=================================--- linux-2.6-mm.orig/drivers/i2c/chips/ds1337.c
+++ linux-2.6-mm/drivers/i2c/chips/ds1337.c
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
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= ds1337_attach_adapter,
 	.detach_client	= ds1337_detach_client,
Index: linux-2.6-mm/drivers/i2c/chips/ds1374.c
=================================--- linux-2.6-mm.orig/drivers/i2c/chips/ds1374.c
+++ linux-2.6-mm/drivers/i2c/chips/ds1374.c
@@ -231,8 +231,10 @@
 }
 
 static struct i2c_driver ds1374_driver = {
-	.owner = THIS_MODULE,
-	.name = DS1374_DRV_NAME,
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= DS1374_DRV_NAME,
+	},
 	.id = I2C_DRIVERID_DS1374,
 	.flags = I2C_DF_NOTIFY,
 	.attach_adapter = ds1374_attach,
Index: linux-2.6-mm/drivers/i2c/chips/eeprom.c
=================================--- linux-2.6-mm.orig/drivers/i2c/chips/eeprom.c
+++ linux-2.6-mm/drivers/i2c/chips/eeprom.c
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
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= eeprom_attach_adapter,
Index: linux-2.6-mm/drivers/i2c/chips/max6875.c
=================================--- linux-2.6-mm.orig/drivers/i2c/chips/max6875.c
+++ linux-2.6-mm/drivers/i2c/chips/max6875.c
@@ -67,8 +67,10 @@
 
 /* This is the driver that will be inserted */
 static struct i2c_driver max6875_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "max6875",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "max6875",
+	},
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= max6875_attach_adapter,
 	.detach_client	= max6875_detach_client,
Index: linux-2.6-mm/drivers/i2c/chips/pca9539.c
=================================--- linux-2.6-mm.orig/drivers/i2c/chips/pca9539.c
+++ linux-2.6-mm/drivers/i2c/chips/pca9539.c
@@ -38,8 +38,10 @@
 
 /* This is the driver that will be inserted */
 static struct i2c_driver pca9539_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "pca9539",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "pca9539",
+	},
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= pca9539_attach_adapter,
 	.detach_client	= pca9539_detach_client,
Index: linux-2.6-mm/drivers/i2c/chips/pcf8574.c
=================================--- linux-2.6-mm.orig/drivers/i2c/chips/pcf8574.c
+++ linux-2.6-mm/drivers/i2c/chips/pcf8574.c
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
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= pcf8574_attach_adapter,
Index: linux-2.6-mm/drivers/i2c/chips/pcf8591.c
=================================--- linux-2.6-mm.orig/drivers/i2c/chips/pcf8591.c
+++ linux-2.6-mm/drivers/i2c/chips/pcf8591.c
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
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= pcf8591_attach_adapter,
Index: linux-2.6-mm/drivers/i2c/chips/rtc8564.c
=================================--- linux-2.6-mm.orig/drivers/i2c/chips/rtc8564.c
+++ linux-2.6-mm/drivers/i2c/chips/rtc8564.c
@@ -361,8 +361,10 @@
 }
 
 static struct i2c_driver rtc8564_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "RTC8564",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "RTC8564",
+	},
 	.id		= I2C_DRIVERID_RTC8564,
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter = rtc8564_probe,
Index: linux-2.6-mm/drivers/i2c/chips/isp1301_omap.c
=================================--- linux-2.6-mm.orig/drivers/i2c/chips/isp1301_omap.c
+++ linux-2.6-mm/drivers/i2c/chips/isp1301_omap.c
@@ -1631,8 +1631,10 @@
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
 	.flags		= I2C_DF_NOTIFY,
Index: linux-2.6-mm/drivers/i2c/chips/m41t00.c
=================================--- linux-2.6-mm.orig/drivers/i2c/chips/m41t00.c
+++ linux-2.6-mm/drivers/i2c/chips/m41t00.c
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
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= m41t00_attach,
Index: linux-2.6-mm/drivers/i2c/chips/tps65010.c
=================================--- linux-2.6-mm.orig/drivers/i2c/chips/tps65010.c
+++ linux-2.6-mm/drivers/i2c/chips/tps65010.c
@@ -637,8 +637,10 @@
 }
 
 static struct i2c_driver tps65010_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "tps65010",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "tps65010",
+	},
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= tps65010_scan_bus,
 	.detach_client	= __exit_p(tps65010_detach_client),
Index: linux-2.6-mm/drivers/i2c/chips/x1205.c
=================================--- linux-2.6-mm.orig/drivers/i2c/chips/x1205.c
+++ linux-2.6-mm/drivers/i2c/chips/x1205.c
@@ -105,8 +105,10 @@
 	void *arg);
 
 static struct i2c_driver x1205_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "x1205",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "x1205",
+	},
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter = &x1205_attach,
 	.detach_client	= &x1205_detach,

--

