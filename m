From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 26 Nov 2005 20:59:56 +0000
Subject: [lm-sensors] [PATCH 22/25] i2c: Rework client usage count, 2 of 3
Message-Id: <20051126210054.631ac7f3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=i2c-client-use-02-make-use-flag-default.patch

Make I2C_CLIENT_ALLOW_USE the default for all i2c clients. It doesn't
hurt if the usage count is actually never used for any given driver,
and allows for nice code simplifications in i2c-core.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 arch/arm/mach-pxa/akita-ioexp.c            |    1 -
 drivers/i2c/chips/rtc8564.c                |    1 -
 drivers/i2c/i2c-core.c                     |   28 ++++++++++------------------
 drivers/media/video/adv7170.c              |    1 -
 drivers/media/video/adv7175.c              |    1 -
 drivers/media/video/bt819.c                |    1 -
 drivers/media/video/bt832.c                |    1 -
 drivers/media/video/bt856.c                |    1 -
 drivers/media/video/cs53l32a.c             |    1 -
 drivers/media/video/cx25840/cx25840-core.c |    1 -
 drivers/media/video/em28xx/em28xx-i2c.c    |    1 -
 drivers/media/video/msp3400.c              |    1 -
 drivers/media/video/saa6588.c              |    1 -
 drivers/media/video/saa7110.c              |    1 -
 drivers/media/video/saa7111.c              |    1 -
 drivers/media/video/saa7114.c              |    1 -
 drivers/media/video/saa7115.c              |    1 -
 drivers/media/video/saa711x.c              |    1 -
 drivers/media/video/saa7127.c              |    1 -
 drivers/media/video/saa7134/saa6752hs.c    |    1 -
 drivers/media/video/saa7185.c              |    1 -
 drivers/media/video/tda9887.c              |    1 -
 drivers/media/video/tuner-core.c           |    1 -
 drivers/media/video/tvaudio.c              |    1 -
 drivers/media/video/tveeprom.c             |    1 -
 drivers/media/video/tvp5150.c              |    1 -
 drivers/media/video/vpx3220.c              |    1 -
 drivers/media/video/wm8775.c               |    1 -
 include/linux/i2c.h                        |    1 -
 29 files changed, 10 insertions(+), 46 deletions(-)

--- linux-2.6.15-rc2.orig/arch/arm/mach-pxa/akita-ioexp.c	2005-11-26 14:12:20.000000000 +0100
+++ linux-2.6.15-rc2/arch/arm/mach-pxa/akita-ioexp.c	2005-11-26 14:21:37.000000000 +0100
@@ -135,7 +135,6 @@
 
 static struct i2c_client max7310_template = {
 	name:   "akita-max7310",
-	flags:  I2C_CLIENT_ALLOW_USE,
 	driver: &max7310_i2c_driver,
 };
 
--- linux-2.6.15-rc2.orig/drivers/i2c/chips/rtc8564.c	2005-11-26 13:55:40.000000000 +0100
+++ linux-2.6.15-rc2/drivers/i2c/chips/rtc8564.c	2005-11-26 14:21:37.000000000 +0100
@@ -155,7 +155,6 @@
 
 	strlcpy(new_client->name, "RTC8564", I2C_NAME_SIZE);
 	i2c_set_clientdata(new_client, d);
-	new_client->flags = I2C_CLIENT_ALLOW_USE;
 	new_client->addr = addr;
 	new_client->adapter = adap;
 	new_client->driver = &rtc8564_driver;
--- linux-2.6.15-rc2.orig/drivers/i2c/i2c-core.c	2005-11-26 14:17:46.000000000 +0100
+++ linux-2.6.15-rc2/drivers/i2c/i2c-core.c	2005-11-26 14:21:37.000000000 +0100
@@ -419,8 +419,7 @@
 		}
 	}
 
-	if (client->flags & I2C_CLIENT_ALLOW_USE)
-		client->usage_count = 0;
+	client->usage_count = 0;
 
 	client->dev.parent = &client->adapter->dev;
 	client->dev.driver = &client->driver->driver;
@@ -443,8 +442,7 @@
 	struct i2c_adapter *adapter = client->adapter;
 	int res = 0;
 	
-	if ((client->flags & I2C_CLIENT_ALLOW_USE)
-	 && (client->usage_count > 0)) {
+	if (client->usage_count > 0) {
 		dev_warn(&client->dev, "Client [%s] still busy, "
 			 "can't detach\n", client->name);
 		return -EBUSY;
@@ -499,12 +497,9 @@
 	if (ret)
 		return ret;
 
-	if (client->flags & I2C_CLIENT_ALLOW_USE) {
-		if (client->usage_count > 0)
-			goto busy;
-		else 
-			client->usage_count++;
-	}
+	if (client->usage_count > 0)
+		goto busy;
+	client->usage_count++;
 
 	return 0;
  busy:
@@ -514,16 +509,13 @@
 
 int i2c_release_client(struct i2c_client *client)
 {
-	if(client->flags & I2C_CLIENT_ALLOW_USE) {
-		if(client->usage_count>0)
-			client->usage_count--;
-		else {
-			pr_debug("i2c-core: %s used one too many times\n",
-				__FUNCTION__);
-			return -EPERM;
-		}
+	if (!client->usage_count) {
+		pr_debug("i2c-core: %s used one too many times\n",
+			 __FUNCTION__);
+		return -EPERM;
 	}
 	
+	client->usage_count--;
 	i2c_dec_use_client(client);
 	
 	return 0;
--- linux-2.6.15-rc2.orig/drivers/media/video/adv7170.c	2005-11-26 14:00:37.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/adv7170.c	2005-11-26 14:21:37.000000000 +0100
@@ -420,7 +420,6 @@
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver_adv7170;
-	client->flags = I2C_CLIENT_ALLOW_USE;
 	if ((client->addr = I2C_ADV7170 >> 1) ||
 	    (client->addr = (I2C_ADV7170 >> 1) + 1)) {
 		dname = adv7170_name;
--- linux-2.6.15-rc2.orig/drivers/media/video/adv7175.c	2005-11-26 14:00:37.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/adv7175.c	2005-11-26 14:21:37.000000000 +0100
@@ -470,7 +470,6 @@
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver_adv7175;
-	client->flags = I2C_CLIENT_ALLOW_USE;
 	if ((client->addr = I2C_ADV7175 >> 1) ||
 	    (client->addr = (I2C_ADV7175 >> 1) + 1)) {
 		dname = adv7175_name;
--- linux-2.6.15-rc2.orig/drivers/media/video/bt819.c	2005-11-26 14:00:37.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/bt819.c	2005-11-26 14:21:37.000000000 +0100
@@ -535,7 +535,6 @@
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver_bt819;
-	client->flags = I2C_CLIENT_ALLOW_USE;
 
 	decoder = kmalloc(sizeof(struct bt819), GFP_KERNEL);
 	if (decoder = NULL) {
--- linux-2.6.15-rc2.orig/drivers/media/video/bt832.c	2005-11-26 14:00:37.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/bt832.c	2005-11-26 14:21:37.000000000 +0100
@@ -242,7 +242,6 @@
 static struct i2c_client client_template  {
 	.name       = "bt832",
-	.flags      = I2C_CLIENT_ALLOW_USE,
         .driver     = &driver,
 };
 
--- linux-2.6.15-rc2.orig/drivers/media/video/bt856.c	2005-11-26 14:00:37.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/bt856.c	2005-11-26 14:21:37.000000000 +0100
@@ -323,7 +323,6 @@
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver_bt856;
-	client->flags = I2C_CLIENT_ALLOW_USE;
 	strlcpy(I2C_NAME(client), "bt856", sizeof(I2C_NAME(client)));
 
 	encoder = kmalloc(sizeof(struct bt856), GFP_KERNEL);
--- linux-2.6.15-rc2.orig/drivers/media/video/cs53l32a.c	2005-11-26 14:00:37.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/cs53l32a.c	2005-11-26 14:21:37.000000000 +0100
@@ -155,7 +155,6 @@
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver;
-	client->flags = I2C_CLIENT_ALLOW_USE;
 	snprintf(client->name, sizeof(client->name) - 1, "cs53l32a");
 
 	cs53l32a_info("chip found @ 0x%x (%s)\n", address << 1, adapter->name);
--- linux-2.6.15-rc2.orig/drivers/media/video/cx25840/cx25840-core.c	2005-11-26 14:00:37.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/cx25840/cx25840-core.c	2005-11-26 14:21:37.000000000 +0100
@@ -737,7 +737,6 @@
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver_cx25840;
-	client->flags = I2C_CLIENT_ALLOW_USE;
 	snprintf(client->name, sizeof(client->name) - 1, "cx25840");
 
 	cx25840_dbg("detecting cx25840 client on address 0x%x\n", address << 1);
--- linux-2.6.15-rc2.orig/drivers/media/video/em28xx/em28xx-i2c.c	2005-11-25 22:42:35.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/em28xx/em28xx-i2c.c	2005-11-26 14:21:37.000000000 +0100
@@ -497,7 +497,6 @@
 
 static struct i2c_client em28xx_client_template = {
 	.name = "em28xx internal",
-	.flags = I2C_CLIENT_ALLOW_USE,
 };
 
 /* ----------------------------------------------------------- */
--- linux-2.6.15-rc2.orig/drivers/media/video/msp3400.c	2005-11-26 14:00:37.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/msp3400.c	2005-11-26 14:21:37.000000000 +0100
@@ -1575,7 +1575,6 @@
 static struct i2c_client client_template  {
 	.name      = "(unset)",
-	.flags     = I2C_CLIENT_ALLOW_USE,
         .driver    = &driver,
 };
 
--- linux-2.6.15-rc2.orig/drivers/media/video/saa6588.c	2005-11-26 14:00:37.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/saa6588.c	2005-11-26 14:21:37.000000000 +0100
@@ -508,7 +508,6 @@
 
 static struct i2c_client client_template = {
 	.name = "saa6588",
-	.flags = I2C_CLIENT_ALLOW_USE,
 	.driver = &driver,
 };
 
--- linux-2.6.15-rc2.orig/drivers/media/video/saa7110.c	2005-11-26 14:00:37.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/saa7110.c	2005-11-26 14:21:37.000000000 +0100
@@ -501,7 +501,6 @@
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver_saa7110;
-	client->flags = I2C_CLIENT_ALLOW_USE;
 	strlcpy(I2C_NAME(client), "saa7110", sizeof(I2C_NAME(client)));
 
 	decoder = kmalloc(sizeof(struct saa7110), GFP_KERNEL);
--- linux-2.6.15-rc2.orig/drivers/media/video/saa7111.c	2005-11-26 14:00:37.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/saa7111.c	2005-11-26 14:21:37.000000000 +0100
@@ -518,7 +518,6 @@
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver_saa7111;
-	client->flags = I2C_CLIENT_ALLOW_USE;
 	strlcpy(I2C_NAME(client), "saa7111", sizeof(I2C_NAME(client)));
 
 	decoder = kmalloc(sizeof(struct saa7111), GFP_KERNEL);
--- linux-2.6.15-rc2.orig/drivers/media/video/saa7114.c	2005-11-26 14:00:37.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/saa7114.c	2005-11-26 14:21:37.000000000 +0100
@@ -859,7 +859,6 @@
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver_saa7114;
-	client->flags = I2C_CLIENT_ALLOW_USE;
 	strlcpy(I2C_NAME(client), "saa7114", sizeof(I2C_NAME(client)));
 
 	decoder = kmalloc(sizeof(struct saa7114), GFP_KERNEL);
--- linux-2.6.15-rc2.orig/drivers/media/video/saa7115.c	2005-11-26 14:00:37.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/saa7115.c	2005-11-26 14:21:37.000000000 +0100
@@ -1269,7 +1269,6 @@
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver_saa7115;
-	client->flags = I2C_CLIENT_ALLOW_USE;
 	snprintf(client->name, sizeof(client->name) - 1, "saa7115");
 
 	saa7115_dbg("detecting saa7115 client on address 0x%x\n", address << 1);
--- linux-2.6.15-rc2.orig/drivers/media/video/saa711x.c	2005-11-26 14:00:37.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/saa711x.c	2005-11-26 14:21:37.000000000 +0100
@@ -494,7 +494,6 @@
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver_saa711x;
-	client->flags = I2C_CLIENT_ALLOW_USE;
 	strlcpy(I2C_NAME(client), "saa711x", sizeof(I2C_NAME(client)));
 	decoder = kmalloc(sizeof(struct saa711x), GFP_KERNEL);
 	if (decoder = NULL) {
--- linux-2.6.15-rc2.orig/drivers/media/video/saa7127.c	2005-11-26 14:00:37.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/saa7127.c	2005-11-26 14:21:37.000000000 +0100
@@ -721,7 +721,6 @@
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver_saa7127;
-	client->flags = I2C_CLIENT_ALLOW_USE;
 	snprintf(client->name, sizeof(client->name) - 1, "saa7127");
 
 	saa7127_dbg("detecting saa7127 client on address 0x%x\n", address << 1);
--- linux-2.6.15-rc2.orig/drivers/media/video/saa7134/saa6752hs.c	2005-11-26 14:00:37.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/saa7134/saa6752hs.c	2005-11-26 14:21:37.000000000 +0100
@@ -609,7 +609,6 @@
 static struct i2c_client client_template  {
 	.name       = "saa6752hs",
-	.flags      = I2C_CLIENT_ALLOW_USE,
         .driver     = &driver,
 };
 
--- linux-2.6.15-rc2.orig/drivers/media/video/saa7185.c	2005-11-26 14:00:37.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/saa7185.c	2005-11-26 14:21:37.000000000 +0100
@@ -415,7 +415,6 @@
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver_saa7185;
-	client->flags = I2C_CLIENT_ALLOW_USE;
 	strlcpy(I2C_NAME(client), "saa7185", sizeof(I2C_NAME(client)));
 
 	encoder = kmalloc(sizeof(struct saa7185), GFP_KERNEL);
--- linux-2.6.15-rc2.orig/drivers/media/video/tda9887.c	2005-11-26 14:00:37.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/tda9887.c	2005-11-26 14:21:37.000000000 +0100
@@ -832,7 +832,6 @@
 static struct i2c_client client_template  {
 	.name      = "tda9887",
-	.flags     = I2C_CLIENT_ALLOW_USE,
         .driver    = &driver,
 };
 
--- linux-2.6.15-rc2.orig/drivers/media/video/tuner-core.c	2005-11-26 14:00:37.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/tuner-core.c	2005-11-26 14:21:37.000000000 +0100
@@ -755,7 +755,6 @@
 };
 static struct i2c_client client_template = {
 	.name = "(tuner unset)",
-	.flags = I2C_CLIENT_ALLOW_USE,
 	.driver = &driver,
 };
 
--- linux-2.6.15-rc2.orig/drivers/media/video/tvaudio.c	2005-11-26 14:00:37.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/tvaudio.c	2005-11-26 14:21:37.000000000 +0100
@@ -1715,7 +1715,6 @@
 static struct i2c_client client_template  {
 	.name       = "(unset)",
-	.flags      = I2C_CLIENT_ALLOW_USE,
 	.driver     = &driver,
 };
 
--- linux-2.6.15-rc2.orig/drivers/media/video/tveeprom.c	2005-11-26 14:00:37.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/tveeprom.c	2005-11-26 14:21:37.000000000 +0100
@@ -709,7 +709,6 @@
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver_tveeprom;
-	client->flags = I2C_CLIENT_ALLOW_USE;
 	snprintf(client->name, sizeof(client->name), "tveeprom");
         i2c_attach_client(client);
 	return 0;
--- linux-2.6.15-rc2.orig/drivers/media/video/tvp5150.c	2005-11-26 14:00:37.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/tvp5150.c	2005-11-26 14:21:37.000000000 +0100
@@ -714,7 +714,6 @@
 
 static struct i2c_client client_template = {
 	.name = "(unset)",
-	.flags = I2C_CLIENT_ALLOW_USE,
 	.driver = &driver,
 };
 
--- linux-2.6.15-rc2.orig/drivers/media/video/vpx3220.c	2005-11-26 14:00:37.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/vpx3220.c	2005-11-26 14:21:37.000000000 +0100
@@ -631,7 +631,6 @@
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &vpx3220_i2c_driver;
-	client->flags = I2C_CLIENT_ALLOW_USE;
 
 	/* Check for manufacture ID and part number */
 	if (kind < 0) {
--- linux-2.6.15-rc2.orig/drivers/media/video/wm8775.c	2005-11-26 14:00:37.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/wm8775.c	2005-11-26 14:21:37.000000000 +0100
@@ -168,7 +168,6 @@
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver;
-	client->flags = I2C_CLIENT_ALLOW_USE;
 	snprintf(client->name, sizeof(client->name) - 1, "wm8775");
 
 	wm8775_info("chip found @ 0x%x (%s)\n", address << 1, adapter->name);
--- linux-2.6.15-rc2.orig/include/linux/i2c.h	2005-11-26 14:17:46.000000000 +0100
+++ linux-2.6.15-rc2/include/linux/i2c.h	2005-11-26 14:21:37.000000000 +0100
@@ -251,7 +251,6 @@
 }
 
 /*flags for the client struct: */
-#define I2C_CLIENT_ALLOW_USE		0x01	/* Client allows access */
 #define I2C_CLIENT_PEC  0x04			/* Use Packet Error Checking */
 #define I2C_CLIENT_TEN	0x10			/* we have a ten bit chip address	*/
 						/* Must equal I2C_M_TEN below */

-- 
Jean Delvare
