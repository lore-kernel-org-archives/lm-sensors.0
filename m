From: gregkh@suse.de (Greg KH)
Date: Fri, 06 Jan 2006 22:07:35 +0000
Subject: [lm-sensors] [PATCH] i2c: Drop i2c_driver.{owner,name}, 2 of 11
Message-Id: <11365852553522@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <11365852541748@kroah.com>
In-Reply-To: <11365852541748@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: Drop i2c_driver.{owner,name}, 2 of 11

We should use the i2c_driver.driver's .name and .owner fields
instead of the i2c_driver's ones.

This patch updates the miscellaneaous i2c chip drivers.

Signed-off-by: Laurent Riffard <laurent.riffard at free.fr>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
commit a9718b0c1154dcbd955be6aaee47a314cde6a25a
tree 5bc275f56d94649477e24f5d2ac03d211a41723f
parent 35d8b2e6b8e86b0d5126f36613b5202d4eb978b6
author Laurent Riffard <laurent.riffard at free.fr> Sat, 26 Nov 2005 20:36:00 +0100
committer Greg Kroah-Hartman <gregkh at suse.de> Thu, 05 Jan 2006 22:16:23 -0800

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

diff --git a/drivers/i2c/chips/ds1337.c b/drivers/i2c/chips/ds1337.c
index 65146cb..a9d4ac7 100644
--- a/drivers/i2c/chips/ds1337.c
+++ b/drivers/i2c/chips/ds1337.c
@@ -52,8 +52,10 @@ static int ds1337_command(struct i2c_cli
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
diff --git a/drivers/i2c/chips/ds1374.c b/drivers/i2c/chips/ds1374.c
index 5a270d6..3e3ebd8 100644
--- a/drivers/i2c/chips/ds1374.c
+++ b/drivers/i2c/chips/ds1374.c
@@ -232,8 +232,10 @@ static int ds1374_detach(struct i2c_clie
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
diff --git a/drivers/i2c/chips/eeprom.c b/drivers/i2c/chips/eeprom.c
index 9bb1f8b..d0c9f29 100644
--- a/drivers/i2c/chips/eeprom.c
+++ b/drivers/i2c/chips/eeprom.c
@@ -68,8 +68,10 @@ static int eeprom_detach_client(struct i
 
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
diff --git a/drivers/i2c/chips/isp1301_omap.c b/drivers/i2c/chips/isp1301_omap.c
index 4f472ba..9f1ec03 100644
--- a/drivers/i2c/chips/isp1301_omap.c
+++ b/drivers/i2c/chips/isp1301_omap.c
@@ -1632,8 +1632,10 @@ static int isp1301_scan_bus(struct i2c_a
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
diff --git a/drivers/i2c/chips/m41t00.c b/drivers/i2c/chips/m41t00.c
index 13e6783..92759b2 100644
--- a/drivers/i2c/chips/m41t00.c
+++ b/drivers/i2c/chips/m41t00.c
@@ -211,8 +211,10 @@ m41t00_detach(struct i2c_client *client)
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
diff --git a/drivers/i2c/chips/max6875.c b/drivers/i2c/chips/max6875.c
index 7e61019..3705117 100644
--- a/drivers/i2c/chips/max6875.c
+++ b/drivers/i2c/chips/max6875.c
@@ -67,8 +67,10 @@ static int max6875_detach_client(struct 
 
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
diff --git a/drivers/i2c/chips/pca9539.c b/drivers/i2c/chips/pca9539.c
index 26feb7a..bb57faa 100644
--- a/drivers/i2c/chips/pca9539.c
+++ b/drivers/i2c/chips/pca9539.c
@@ -38,8 +38,10 @@ static int pca9539_detach_client(struct 
 
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
diff --git a/drivers/i2c/chips/pcf8574.c b/drivers/i2c/chips/pcf8574.c
index 2fae640..3d4d4d6 100644
--- a/drivers/i2c/chips/pcf8574.c
+++ b/drivers/i2c/chips/pcf8574.c
@@ -65,8 +65,10 @@ static void pcf8574_init_client(struct i
 
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
diff --git a/drivers/i2c/chips/pcf8591.c b/drivers/i2c/chips/pcf8591.c
index 8750f71..8f41bb3 100644
--- a/drivers/i2c/chips/pcf8591.c
+++ b/drivers/i2c/chips/pcf8591.c
@@ -88,8 +88,10 @@ static int pcf8591_read_channel(struct d
 
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
diff --git a/drivers/i2c/chips/rtc8564.c b/drivers/i2c/chips/rtc8564.c
index 07494d3..6f567e2 100644
--- a/drivers/i2c/chips/rtc8564.c
+++ b/drivers/i2c/chips/rtc8564.c
@@ -358,8 +358,10 @@ rtc8564_command(struct i2c_client *clien
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
diff --git a/drivers/i2c/chips/tps65010.c b/drivers/i2c/chips/tps65010.c
index 439bf6c..92947a6 100644
--- a/drivers/i2c/chips/tps65010.c
+++ b/drivers/i2c/chips/tps65010.c
@@ -637,8 +637,10 @@ static int __init tps65010_scan_bus(stru
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
diff --git a/drivers/i2c/chips/x1205.c b/drivers/i2c/chips/x1205.c
index c5ff2ce..6880eab 100644
--- a/drivers/i2c/chips/x1205.c
+++ b/drivers/i2c/chips/x1205.c
@@ -105,8 +105,10 @@ static int x1205_command(struct i2c_clie
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


