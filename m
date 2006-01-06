From: gregkh@suse.de (Greg KH)
Date: Fri, 06 Jan 2006 22:07:35 +0000
Subject: [lm-sensors] [PATCH] i2c: Rework client usage count, 2 of 3
Message-Id: <1136585255392@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <11365852552960@kroah.com>
In-Reply-To: <11365852552960@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: Rework client usage count, 2 of 3

Make I2C_CLIENT_ALLOW_USE the default for all i2c clients. It doesn't
hurt if the usage count is actually never used for any given driver,
and allows for nice code simplifications in i2c-core.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
commit cde7859bda0d1124392b44e50aa11df99707e1d9
tree c852e7ff9b44b5e59f6ae75951514585f0ff10d9
parent cb748fb20186d4b345c68a7f580429f379fdd268
author Jean Delvare <khali at linux-fr.org> Sat, 26 Nov 2005 21:00:54 +0100
committer Greg Kroah-Hartman <gregkh at suse.de> Thu, 05 Jan 2006 22:16:22 -0800

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

diff --git a/arch/arm/mach-pxa/akita-ioexp.c b/arch/arm/mach-pxa/akita-ioexp.c
index 440ebb3..b6bff55 100644
--- a/arch/arm/mach-pxa/akita-ioexp.c
+++ b/arch/arm/mach-pxa/akita-ioexp.c
@@ -133,7 +133,6 @@ static struct i2c_driver max7310_i2c_dri
 
 static struct i2c_client max7310_template = {
 	name:   "akita-max7310",
-	flags:  I2C_CLIENT_ALLOW_USE,
 	driver: &max7310_i2c_driver,
 };
 
diff --git a/drivers/i2c/chips/rtc8564.c b/drivers/i2c/chips/rtc8564.c
index e586f75..07494d3 100644
--- a/drivers/i2c/chips/rtc8564.c
+++ b/drivers/i2c/chips/rtc8564.c
@@ -155,7 +155,6 @@ static int rtc8564_attach(struct i2c_ada
 
 	strlcpy(new_client->name, "RTC8564", I2C_NAME_SIZE);
 	i2c_set_clientdata(new_client, d);
-	new_client->flags = I2C_CLIENT_ALLOW_USE;
 	new_client->addr = addr;
 	new_client->adapter = adap;
 	new_client->driver = &rtc8564_driver;
diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 2f0bc95..d16b499 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -419,8 +419,7 @@ int i2c_attach_client(struct i2c_client 
 		}
 	}
 
-	if (client->flags & I2C_CLIENT_ALLOW_USE)
-		client->usage_count = 0;
+	client->usage_count = 0;
 
 	client->dev.parent = &client->adapter->dev;
 	client->dev.driver = &client->driver->driver;
@@ -443,8 +442,7 @@ int i2c_detach_client(struct i2c_client 
 	struct i2c_adapter *adapter = client->adapter;
 	int res = 0;
 	
-	if ((client->flags & I2C_CLIENT_ALLOW_USE)
-	 && (client->usage_count > 0)) {
+	if (client->usage_count > 0) {
 		dev_warn(&client->dev, "Client [%s] still busy, "
 			 "can't detach\n", client->name);
 		return -EBUSY;
@@ -499,12 +497,9 @@ int i2c_use_client(struct i2c_client *cl
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
@@ -514,16 +509,13 @@ int i2c_use_client(struct i2c_client *cl
 
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
diff --git a/drivers/media/video/adv7170.c b/drivers/media/video/adv7170.c
index c4f2265..622b161 100644
--- a/drivers/media/video/adv7170.c
+++ b/drivers/media/video/adv7170.c
@@ -420,7 +420,6 @@ adv7170_detect_client (struct i2c_adapte
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver_adv7170;
-	client->flags = I2C_CLIENT_ALLOW_USE;
 	if ((client->addr = I2C_ADV7170 >> 1) ||
 	    (client->addr = (I2C_ADV7170 >> 1) + 1)) {
 		dname = adv7170_name;
diff --git a/drivers/media/video/adv7175.c b/drivers/media/video/adv7175.c
index 4fc08b1..d4859b4 100644
--- a/drivers/media/video/adv7175.c
+++ b/drivers/media/video/adv7175.c
@@ -470,7 +470,6 @@ adv7175_detect_client (struct i2c_adapte
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver_adv7175;
-	client->flags = I2C_CLIENT_ALLOW_USE;
 	if ((client->addr = I2C_ADV7175 >> 1) ||
 	    (client->addr = (I2C_ADV7175 >> 1) + 1)) {
 		dname = adv7175_name;
diff --git a/drivers/media/video/bt819.c b/drivers/media/video/bt819.c
index 7bba697..741e59a 100644
--- a/drivers/media/video/bt819.c
+++ b/drivers/media/video/bt819.c
@@ -535,7 +535,6 @@ bt819_detect_client (struct i2c_adapter 
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver_bt819;
-	client->flags = I2C_CLIENT_ALLOW_USE;
 
 	decoder = kmalloc(sizeof(struct bt819), GFP_KERNEL);
 	if (decoder = NULL) {
diff --git a/drivers/media/video/bt832.c b/drivers/media/video/bt832.c
index 0ba8652..4ed1386 100644
--- a/drivers/media/video/bt832.c
+++ b/drivers/media/video/bt832.c
@@ -240,7 +240,6 @@ static struct i2c_driver driver = {
 static struct i2c_client client_template  {
 	.name       = "bt832",
-	.flags      = I2C_CLIENT_ALLOW_USE,
 	.driver     = &driver,
 };
 
diff --git a/drivers/media/video/bt856.c b/drivers/media/video/bt856.c
index 4c9acd1..d4bba8e 100644
--- a/drivers/media/video/bt856.c
+++ b/drivers/media/video/bt856.c
@@ -323,7 +323,6 @@ bt856_detect_client (struct i2c_adapter 
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver_bt856;
-	client->flags = I2C_CLIENT_ALLOW_USE;
 	strlcpy(I2C_NAME(client), "bt856", sizeof(I2C_NAME(client)));
 
 	encoder = kmalloc(sizeof(struct bt856), GFP_KERNEL);
diff --git a/drivers/media/video/cs53l32a.c b/drivers/media/video/cs53l32a.c
index fce5d89..f442ce3 100644
--- a/drivers/media/video/cs53l32a.c
+++ b/drivers/media/video/cs53l32a.c
@@ -154,7 +154,6 @@ static int cs53l32a_attach(struct i2c_ad
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver;
-	client->flags = I2C_CLIENT_ALLOW_USE;
 	snprintf(client->name, sizeof(client->name) - 1, "cs53l32a");
 
 	cs53l32a_info("chip found @ 0x%x (%s)\n", address << 1, adapter->name);
diff --git a/drivers/media/video/cx25840/cx25840-core.c b/drivers/media/video/cx25840/cx25840-core.c
index c66bc14..0b278ab 100644
--- a/drivers/media/video/cx25840/cx25840-core.c
+++ b/drivers/media/video/cx25840/cx25840-core.c
@@ -773,7 +773,6 @@ static int cx25840_detect_client(struct 
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver_cx25840;
-	client->flags = I2C_CLIENT_ALLOW_USE;
 	snprintf(client->name, sizeof(client->name) - 1, "cx25840");
 
 	cx25840_dbg("detecting cx25840 client on address 0x%x\n", address << 1);
diff --git a/drivers/media/video/em28xx/em28xx-i2c.c b/drivers/media/video/em28xx/em28xx-i2c.c
index 7f56030..d14bcf4 100644
--- a/drivers/media/video/em28xx/em28xx-i2c.c
+++ b/drivers/media/video/em28xx/em28xx-i2c.c
@@ -497,7 +497,6 @@ static struct i2c_adapter em28xx_adap_te
 
 static struct i2c_client em28xx_client_template = {
 	.name = "em28xx internal",
-	.flags = I2C_CLIENT_ALLOW_USE,
 };
 
 /* ----------------------------------------------------------- */
diff --git a/drivers/media/video/msp3400.c b/drivers/media/video/msp3400.c
index 46328fb..c5e8ad3 100644
--- a/drivers/media/video/msp3400.c
+++ b/drivers/media/video/msp3400.c
@@ -1576,7 +1576,6 @@ static struct i2c_driver driver = {
 static struct i2c_client client_template  {
 	.name      = "(unset)",
-	.flags     = I2C_CLIENT_ALLOW_USE,
 	.driver    = &driver,
 };
 
diff --git a/drivers/media/video/saa6588.c b/drivers/media/video/saa6588.c
index 18a0b71..3d4076c 100644
--- a/drivers/media/video/saa6588.c
+++ b/drivers/media/video/saa6588.c
@@ -505,7 +505,6 @@ static struct i2c_driver driver = {
 
 static struct i2c_client client_template = {
 	.name = "saa6588",
-	.flags = I2C_CLIENT_ALLOW_USE,
 	.driver = &driver,
 };
 
diff --git a/drivers/media/video/saa7110.c b/drivers/media/video/saa7110.c
index f266b35..8affa63 100644
--- a/drivers/media/video/saa7110.c
+++ b/drivers/media/video/saa7110.c
@@ -501,7 +501,6 @@ saa7110_detect_client (struct i2c_adapte
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver_saa7110;
-	client->flags = I2C_CLIENT_ALLOW_USE;
 	strlcpy(I2C_NAME(client), "saa7110", sizeof(I2C_NAME(client)));
 
 	decoder = kmalloc(sizeof(struct saa7110), GFP_KERNEL);
diff --git a/drivers/media/video/saa7111.c b/drivers/media/video/saa7111.c
index 687beaf..2b22045 100644
--- a/drivers/media/video/saa7111.c
+++ b/drivers/media/video/saa7111.c
@@ -518,7 +518,6 @@ saa7111_detect_client (struct i2c_adapte
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver_saa7111;
-	client->flags = I2C_CLIENT_ALLOW_USE;
 	strlcpy(I2C_NAME(client), "saa7111", sizeof(I2C_NAME(client)));
 
 	decoder = kmalloc(sizeof(struct saa7111), GFP_KERNEL);
diff --git a/drivers/media/video/saa7114.c b/drivers/media/video/saa7114.c
index 4748cf0..285f6c7 100644
--- a/drivers/media/video/saa7114.c
+++ b/drivers/media/video/saa7114.c
@@ -859,7 +859,6 @@ saa7114_detect_client (struct i2c_adapte
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver_saa7114;
-	client->flags = I2C_CLIENT_ALLOW_USE;
 	strlcpy(I2C_NAME(client), "saa7114", sizeof(I2C_NAME(client)));
 
 	decoder = kmalloc(sizeof(struct saa7114), GFP_KERNEL);
diff --git a/drivers/media/video/saa7115.c b/drivers/media/video/saa7115.c
index b1079de..79aadd2 100644
--- a/drivers/media/video/saa7115.c
+++ b/drivers/media/video/saa7115.c
@@ -1270,7 +1270,6 @@ static int saa7115_attach(struct i2c_ada
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver_saa7115;
-	client->flags = I2C_CLIENT_ALLOW_USE;
 	snprintf(client->name, sizeof(client->name) - 1, "saa7115");
 
 	saa7115_dbg("detecting saa7115 client on address 0x%x\n", address << 1);
diff --git a/drivers/media/video/saa711x.c b/drivers/media/video/saa711x.c
index 734a709..44bfc04 100644
--- a/drivers/media/video/saa711x.c
+++ b/drivers/media/video/saa711x.c
@@ -494,7 +494,6 @@ saa711x_detect_client (struct i2c_adapte
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver_saa711x;
-	client->flags = I2C_CLIENT_ALLOW_USE;
 	strlcpy(I2C_NAME(client), "saa711x", sizeof(I2C_NAME(client)));
 	decoder = kmalloc(sizeof(struct saa711x), GFP_KERNEL);
 	if (decoder = NULL) {
diff --git a/drivers/media/video/saa7127.c b/drivers/media/video/saa7127.c
index a2fab98..1f4b415 100644
--- a/drivers/media/video/saa7127.c
+++ b/drivers/media/video/saa7127.c
@@ -719,7 +719,6 @@ static int saa7127_attach(struct i2c_ada
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver_saa7127;
-	client->flags = I2C_CLIENT_ALLOW_USE;
 	snprintf(client->name, sizeof(client->name) - 1, "saa7127");
 
 	saa7127_dbg("detecting saa7127 client on address 0x%x\n", address << 1);
diff --git a/drivers/media/video/saa7134/saa6752hs.c b/drivers/media/video/saa7134/saa6752hs.c
index 6fc298e..6820606 100644
--- a/drivers/media/video/saa7134/saa6752hs.c
+++ b/drivers/media/video/saa7134/saa6752hs.c
@@ -608,7 +608,6 @@ static struct i2c_driver driver = {
 static struct i2c_client client_template  {
 	.name       = "saa6752hs",
-	.flags      = I2C_CLIENT_ALLOW_USE,
 	.driver     = &driver,
 };
 
diff --git a/drivers/media/video/saa7185.c b/drivers/media/video/saa7185.c
index e24aa16..9f37585 100644
--- a/drivers/media/video/saa7185.c
+++ b/drivers/media/video/saa7185.c
@@ -415,7 +415,6 @@ saa7185_detect_client (struct i2c_adapte
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver_saa7185;
-	client->flags = I2C_CLIENT_ALLOW_USE;
 	strlcpy(I2C_NAME(client), "saa7185", sizeof(I2C_NAME(client)));
 
 	encoder = kmalloc(sizeof(struct saa7185), GFP_KERNEL);
diff --git a/drivers/media/video/tda9887.c b/drivers/media/video/tda9887.c
index 049b44e..324f61b 100644
--- a/drivers/media/video/tda9887.c
+++ b/drivers/media/video/tda9887.c
@@ -833,7 +833,6 @@ static struct i2c_driver driver = {
 static struct i2c_client client_template  {
 	.name      = "tda9887",
-	.flags     = I2C_CLIENT_ALLOW_USE,
 	.driver    = &driver,
 };
 
diff --git a/drivers/media/video/tuner-core.c b/drivers/media/video/tuner-core.c
index 3c75121..6328f09 100644
--- a/drivers/media/video/tuner-core.c
+++ b/drivers/media/video/tuner-core.c
@@ -755,7 +755,6 @@ static struct i2c_driver driver = {
 };
 static struct i2c_client client_template = {
 	.name = "(tuner unset)",
-	.flags = I2C_CLIENT_ALLOW_USE,
 	.driver = &driver,
 };
 
diff --git a/drivers/media/video/tvaudio.c b/drivers/media/video/tvaudio.c
index 3565f35..4f1f339 100644
--- a/drivers/media/video/tvaudio.c
+++ b/drivers/media/video/tvaudio.c
@@ -1713,7 +1713,6 @@ static struct i2c_driver driver = {
 static struct i2c_client client_template  {
 	.name       = "(unset)",
-	.flags      = I2C_CLIENT_ALLOW_USE,
 	.driver     = &driver,
 };
 
diff --git a/drivers/media/video/tveeprom.c b/drivers/media/video/tveeprom.c
index 195bc51..d833b65 100644
--- a/drivers/media/video/tveeprom.c
+++ b/drivers/media/video/tveeprom.c
@@ -751,7 +751,6 @@ tveeprom_detect_client(struct i2c_adapte
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver_tveeprom;
-	client->flags = I2C_CLIENT_ALLOW_USE;
 	snprintf(client->name, sizeof(client->name), "tveeprom");
 	i2c_attach_client(client);
 
diff --git a/drivers/media/video/tvp5150.c b/drivers/media/video/tvp5150.c
index 4f3ee20..3734554 100644
--- a/drivers/media/video/tvp5150.c
+++ b/drivers/media/video/tvp5150.c
@@ -714,7 +714,6 @@ static struct i2c_driver driver;
 
 static struct i2c_client client_template = {
 	.name = "(unset)",
-	.flags = I2C_CLIENT_ALLOW_USE,
 	.driver = &driver,
 };
 
diff --git a/drivers/media/video/vpx3220.c b/drivers/media/video/vpx3220.c
index c66d285..54bc888 100644
--- a/drivers/media/video/vpx3220.c
+++ b/drivers/media/video/vpx3220.c
@@ -631,7 +631,6 @@ vpx3220_detect_client (struct i2c_adapte
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &vpx3220_i2c_driver;
-	client->flags = I2C_CLIENT_ALLOW_USE;
 
 	/* Check for manufacture ID and part number */
 	if (kind < 0) {
diff --git a/drivers/media/video/wm8775.c b/drivers/media/video/wm8775.c
index 7b07717..527c259 100644
--- a/drivers/media/video/wm8775.c
+++ b/drivers/media/video/wm8775.c
@@ -168,7 +168,6 @@ static int wm8775_attach(struct i2c_adap
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver;
-	client->flags = I2C_CLIENT_ALLOW_USE;
 	snprintf(client->name, sizeof(client->name) - 1, "wm8775");
 
 	wm8775_info("chip found @ 0x%x (%s)\n", address << 1, adapter->name);
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 4487c51..8b4d469 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -250,7 +250,6 @@ static inline void i2c_set_adapdata (str
 }
 
 /*flags for the client struct: */
-#define I2C_CLIENT_ALLOW_USE		0x01	/* Client allows access */
 #define I2C_CLIENT_PEC  0x04			/* Use Packet Error Checking */
 #define I2C_CLIENT_TEN	0x10			/* we have a ten bit chip address	*/
 						/* Must equal I2C_M_TEN below */


