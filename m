From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 26 Nov 2005 20:42:42 +0000
Subject: [lm-sensors] [PATCH 14/25] i2c: Drop i2c_driver.{owner, name},
Message-Id: <20051126204339.57f66813.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Laurent Riffard <laurent.riffard@free.fr>
Content-Disposition: inline; filename=i2c-drop-driver-owner-and-name-05-media.patch

We should use the i2c_driver.driver's .name and .owner fields
instead of the i2c_driver's ones.

This patch updates the drivers/media/video and usb/media drivers.

Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/media/video/adv7170.c                  |    6 ++++--
 drivers/media/video/adv7175.c                  |    6 ++++--
 drivers/media/video/bt819.c                    |    6 ++++--
 drivers/media/video/bt832.c                    |    6 ++++--
 drivers/media/video/bt856.c                    |    6 ++++--
 drivers/media/video/bttv-i2c.c                 |    2 +-
 drivers/media/video/cs53l32a.c                 |   13 ++++++++-----
 drivers/media/video/cx25840/cx25840-core.c     |    6 ++++--
 drivers/media/video/cx25840/cx25840.h          |    7 ++++---
 drivers/media/video/cx88/cx88-i2c.c            |    2 +-
 drivers/media/video/indycam.c                  |    6 ++++--
 drivers/media/video/ir-kbd-i2c.c               |    5 ++++-
 drivers/media/video/msp3400.c                  |   19 +++++++++++--------
 drivers/media/video/ovcamchip/ovcamchip_core.c |    6 ++++--
 drivers/media/video/saa5246a.c                 |    6 ++++--
 drivers/media/video/saa5249.c                  |    6 ++++--
 drivers/media/video/saa6588.c                  |    6 ++++--
 drivers/media/video/saa7110.c                  |    6 ++++--
 drivers/media/video/saa7111.c                  |    6 ++++--
 drivers/media/video/saa7114.c                  |    6 ++++--
 drivers/media/video/saa7115.c                  |   13 ++++++++-----
 drivers/media/video/saa711x.c                  |    6 ++++--
 drivers/media/video/saa7127.c                  |   16 ++++++++++------
 drivers/media/video/saa7134/saa6752hs.c        |    6 ++++--
 drivers/media/video/saa7134/saa7134-i2c.c      |    4 ++--
 drivers/media/video/saa7185.c                  |    6 ++++--
 drivers/media/video/saa7191.c                  |    6 ++++--
 drivers/media/video/tda7432.c                  |    6 ++++--
 drivers/media/video/tda9840.c                  |    6 ++++--
 drivers/media/video/tda9875.c                  |    6 ++++--
 drivers/media/video/tda9887.c                  |    4 ++--
 drivers/media/video/tea6415c.c                 |    6 ++++--
 drivers/media/video/tea6420.c                  |    6 ++++--
 drivers/media/video/tuner-3036.c               |    6 ++++--
 drivers/media/video/tuner-core.c               |    6 +++---
 drivers/media/video/tvaudio.c                  |    6 ++++--
 drivers/media/video/tveeprom.c                 |    6 ++++--
 drivers/media/video/tvmixer.c                  |    8 ++++++--
 drivers/media/video/tvp5150.c                  |    6 ++++--
 drivers/media/video/vpx3220.c                  |    6 ++++--
 drivers/media/video/wm8775.c                   |   10 ++++++----
 drivers/media/video/zoran_driver.c             |   14 +++++++-------
 drivers/usb/media/w9968cf.c                    |    4 ++--
 include/media/tuner.h                          |    7 ++++---
 44 files changed, 191 insertions(+), 111 deletions(-)

--- linux-2.6.15-rc2.orig/drivers/media/video/adv7170.c	2005-11-26 13:42:27.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/adv7170.c	2005-11-26 14:00:37.000000000 +0100
@@ -498,8 +498,10 @@
 /* ----------------------------------------------------------------------- */
 
 static struct i2c_driver i2c_driver_adv7170 = {
-	.owner = THIS_MODULE,
-	.name = "adv7170",	/* name */
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "adv7170",	/* name */
+	},
 
 	.id = I2C_DRIVERID_ADV7170,
 
--- linux-2.6.15-rc2.orig/drivers/media/video/adv7175.c	2005-11-26 13:42:27.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/adv7175.c	2005-11-26 14:00:37.000000000 +0100
@@ -548,8 +548,10 @@
 /* ----------------------------------------------------------------------- */
 
 static struct i2c_driver i2c_driver_adv7175 = {
-	.owner = THIS_MODULE,
-	.name = "adv7175",	/* name */
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "adv7175",	/* name */
+	},
 
 	.id = I2C_DRIVERID_ADV7175,
 
--- linux-2.6.15-rc2.orig/drivers/media/video/bt819.c	2005-11-26 13:42:27.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/bt819.c	2005-11-26 14:00:37.000000000 +0100
@@ -623,8 +623,10 @@
 /* ----------------------------------------------------------------------- */
 
 static struct i2c_driver i2c_driver_bt819 = {
-	.owner = THIS_MODULE,
-	.name = "bt819",
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "bt819",
+	},
 
 	.id = I2C_DRIVERID_BT819,
 
--- linux-2.6.15-rc2.orig/drivers/media/video/bt832.c	2005-11-26 13:42:27.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/bt832.c	2005-11-26 14:00:37.000000000 +0100
@@ -230,8 +230,10 @@
 /* ----------------------------------------------------------------------- */
 
 static struct i2c_driver driver = {
-	.owner          = THIS_MODULE,
-        .name           = "i2c bt832 driver",
+	.driver = {
+		.owner  = THIS_MODULE,
+		.name   = "i2c bt832 driver",
+	},
         .id             = -1, /* FIXME */
         .attach_adapter = bt832_probe,
         .detach_client  = bt832_detach,
--- linux-2.6.15-rc2.orig/drivers/media/video/bt856.c	2005-11-26 13:42:27.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/bt856.c	2005-11-26 14:00:37.000000000 +0100
@@ -405,8 +405,10 @@
 /* ----------------------------------------------------------------------- */
 
 static struct i2c_driver i2c_driver_bt856 = {
-	.owner = THIS_MODULE,
-	.name = "bt856",
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "bt856",
+	},
 
 	.id = I2C_DRIVERID_BT856,
 
--- linux-2.6.15-rc2.orig/drivers/media/video/bttv-i2c.c	2005-11-25 22:42:37.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/bttv-i2c.c	2005-11-26 14:00:37.000000000 +0100
@@ -300,7 +300,7 @@
 
 	if (bttv_debug)
 		printk(KERN_DEBUG "bttv%d: %s i2c attach [addr=0x%x,client=%s]\n",
-			btv->c.nr,client->driver->name,client->addr,
+			btv->c.nr, client->driver->driver.name, client->addr,
 			client->name);
 	if (!client->driver->command)
 		return 0;
--- linux-2.6.15-rc2.orig/drivers/media/video/cs53l32a.c	2005-11-26 13:42:27.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/cs53l32a.c	2005-11-26 14:00:37.000000000 +0100
@@ -42,15 +42,16 @@
 #define cs53l32a_dbg(fmt, arg...) \
 	do { \
 		if (debug) \
-			printk(KERN_INFO "%s debug %d-%04x: " fmt, client->driver->name, \
+			printk(KERN_INFO "%s debug %d-%04x: " fmt, \
+			       client->driver->driver.name, \
 			       i2c_adapter_id(client->adapter), client->addr , ## arg); \
 	} while (0)
 
 #define cs53l32a_err(fmt, arg...) do { \
-	printk(KERN_ERR "%s %d-%04x: " fmt, client->driver->name, \
+	printk(KERN_ERR "%s %d-%04x: " fmt, client->driver->driver.name, \
 		i2c_adapter_id(client->adapter), client->addr , ## arg); } while (0)
 #define cs53l32a_info(fmt, arg...) do { \
-	printk(KERN_INFO "%s %d-%04x: " fmt, client->driver->name, \
+	printk(KERN_INFO "%s %d-%04x: " fmt, client->driver->driver.name, \
 		i2c_adapter_id(client->adapter), client->addr , ## arg); } while (0)
 
 static unsigned short normal_i2c[] = { 0x22 >> 1, I2C_CLIENT_END };
@@ -216,12 +217,14 @@
 
 /* i2c implementation */
 static struct i2c_driver i2c_driver = {
-	.name = "cs53l32a",
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "cs53l32a",
+	},
 	.id = I2C_DRIVERID_CS53L32A,
 	.attach_adapter = cs53l32a_probe,
 	.detach_client = cs53l32a_detach,
 	.command = cs53l32a_command,
-	.owner = THIS_MODULE,
 };
 
 
--- linux-2.6.15-rc2.orig/drivers/media/video/cx25840/cx25840-core.c	2005-11-26 13:42:27.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/cx25840/cx25840-core.c	2005-11-26 14:00:37.000000000 +0100
@@ -808,14 +808,16 @@
 /* ----------------------------------------------------------------------- */
 
 struct i2c_driver i2c_driver_cx25840 = {
-	.name = "cx25840",
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "cx25840",
+	},
 
 	.id = I2C_DRIVERID_CX25840,
 
 	.attach_adapter = cx25840_attach_adapter,
 	.detach_client = cx25840_detach_client,
 	.command = cx25840_command,
-	.owner = THIS_MODULE,
 };
 
 
--- linux-2.6.15-rc2.orig/drivers/media/video/cx25840/cx25840.h	2005-11-25 22:42:37.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/cx25840/cx25840.h	2005-11-26 14:00:37.000000000 +0100
@@ -27,15 +27,16 @@
 extern int cx25840_debug;
 
 #define cx25840_dbg(fmt, arg...) do { if (cx25840_debug) \
-	printk(KERN_INFO "%s debug %d-%04x: " fmt, client->driver->name, \
+	printk(KERN_INFO "%s debug %d-%04x: " fmt, \
+	       client->driver->driver.name, \
 	       i2c_adapter_id(client->adapter), client->addr , ## arg); } while (0)
 
 #define cx25840_err(fmt, arg...) do { \
-	printk(KERN_ERR "%s %d-%04x: " fmt, client->driver->name, \
+	printk(KERN_ERR "%s %d-%04x: " fmt, client->driver->driver.name, \
 	       i2c_adapter_id(client->adapter), client->addr , ## arg); } while (0)
 
 #define cx25840_info(fmt, arg...) do { \
-	printk(KERN_INFO "%s %d-%04x: " fmt, client->driver->name, \
+	printk(KERN_INFO "%s %d-%04x: " fmt, client->driver->driver.name, \
 	       i2c_adapter_id(client->adapter), client->addr , ## arg); } while (0)
 
 #define CX25840_CID_CARDTYPE (V4L2_CID_PRIVATE_BASE+0)
--- linux-2.6.15-rc2.orig/drivers/media/video/cx88/cx88-i2c.c	2005-11-25 22:42:37.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/cx88/cx88-i2c.c	2005-11-26 14:00:37.000000000 +0100
@@ -94,7 +94,7 @@
 	struct cx88_core *core = i2c_get_adapdata(client->adapter);
 
 	dprintk(1, "%s i2c attach [addr=0x%x,client=%s]\n",
-		client->driver->name, client->addr, client->name);
+		client->driver->driver.name, client->addr, client->name);
 	if (!client->driver->command)
 		return 0;
 
--- linux-2.6.15-rc2.orig/drivers/media/video/indycam.c	2005-11-26 13:42:27.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/indycam.c	2005-11-26 14:00:37.000000000 +0100
@@ -451,8 +451,10 @@
 }
 
 static struct i2c_driver i2c_driver_indycam = {
-	.owner		= THIS_MODULE,
-	.name		= "indycam",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name 	= "indycam",
+	},
 	.id		= I2C_DRIVERID_INDYCAM,
 	.attach_adapter = indycam_probe,
 	.detach_client	= indycam_detach,
--- linux-2.6.15-rc2.orig/drivers/media/video/ir-kbd-i2c.c	2005-11-26 13:42:27.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/ir-kbd-i2c.c	2005-11-26 14:00:37.000000000 +0100
@@ -277,7 +277,10 @@
 static int ir_probe(struct i2c_adapter *adap);
 
 static struct i2c_driver driver = {
-	.name           = "ir remote kbd driver",
+	.driver = {
+		.owner  = THIS_MODULE,
+		.name   = "ir remote kbd driver",
+	},
 	.id             = I2C_DRIVERID_EXP3, /* FIXME */
 	.attach_adapter = ir_probe,
 	.detach_client  = ir_detach,
--- linux-2.6.15-rc2.orig/drivers/media/video/msp3400.c	2005-11-26 13:42:27.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/msp3400.c	2005-11-26 14:00:37.000000000 +0100
@@ -59,7 +59,8 @@
 #define msp3400_dbg(fmt, arg...) \
 	do { \
 		if (debug) \
-			printk(KERN_INFO "%s debug %d-%04x: " fmt, client->driver->name, \
+			printk(KERN_INFO "%s debug %d-%04x: " fmt, \
+			       client->driver->driver.name, \
 			       i2c_adapter_id(client->adapter), client->addr , ## arg); \
 	} while (0)
 
@@ -67,7 +68,8 @@
 #define msp3400_dbg_mediumvol(fmt, arg...) \
 	do { \
 		if (debug >= 2) \
-			printk(KERN_INFO "%s debug %d-%04x: " fmt, client->driver->name, \
+			printk(KERN_INFO "%s debug %d-%04x: " fmt, \
+				client->driver->driver.name, \
 				i2c_adapter_id(client->adapter), client->addr , ## arg); \
 	} while (0)
 
@@ -75,18 +77,19 @@
 #define msp3400_dbg_highvol(fmt, arg...) \
 	do { \
 		if (debug >= 16) \
-			printk(KERN_INFO "%s debug %d-%04x: " fmt, client->driver->name, \
+			printk(KERN_INFO "%s debug %d-%04x: " fmt, \
+				client->driver->driver.name, \
 				i2c_adapter_id(client->adapter), client->addr , ## arg); \
 	} while (0)
 
 #define msp3400_err(fmt, arg...) do { \
-	printk(KERN_ERR "%s %d-%04x: " fmt, client->driver->name, \
+	printk(KERN_ERR "%s %d-%04x: " fmt, client->driver->driver.name, \
 		i2c_adapter_id(client->adapter), client->addr , ## arg); } while (0)
 #define msp3400_warn(fmt, arg...) do { \
-	printk(KERN_WARNING "%s %d-%04x: " fmt, client->driver->name, \
+	printk(KERN_WARNING "%s %d-%04x: " fmt, client->driver->driver.name, \
 		i2c_adapter_id(client->adapter), client->addr , ## arg); } while (0)
 #define msp3400_info(fmt, arg...) do { \
-	printk(KERN_INFO "%s %d-%04x: " fmt, client->driver->name, \
+	printk(KERN_INFO "%s %d-%04x: " fmt, client->driver->driver.name, \
 		i2c_adapter_id(client->adapter), client->addr , ## arg); } while (0)
 
 #define OPMODE_AUTO    -1
@@ -1557,13 +1560,13 @@
 static void msp_wake_thread(struct i2c_client *client);
 
 static struct i2c_driver driver = {
-	.owner          = THIS_MODULE,
-	.name           = "msp3400",
         .id             = I2C_DRIVERID_MSP3400,
         .attach_adapter = msp_probe,
         .detach_client  = msp_detach,
         .command        = msp_command,
 	.driver = {
+		.owner   = THIS_MODULE,
+		.name    = "i2c msp3400 driver",
 		.suspend = msp_suspend,
 		.resume  = msp_resume,
 	},
--- linux-2.6.15-rc2.orig/drivers/media/video/ovcamchip/ovcamchip_core.c	2005-11-26 13:42:27.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/ovcamchip/ovcamchip_core.c	2005-11-26 14:00:37.000000000 +0100
@@ -410,8 +410,10 @@
 /* ----------------------------------------------------------------------- */
 
 static struct i2c_driver driver = {
-	.owner =		THIS_MODULE,
-	.name =			"ovcamchip",
+	.driver = {
+		.owner =	THIS_MODULE,
+		.name =		"ovcamchip",
+	},
 	.id =			I2C_DRIVERID_OVCAMCHIP,
 	.class =		I2C_CLASS_CAM_DIGITAL,
 	.attach_adapter =	ovcamchip_attach,
--- linux-2.6.15-rc2.orig/drivers/media/video/saa5246a.c	2005-11-26 13:42:27.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/saa5246a.c	2005-11-26 14:00:37.000000000 +0100
@@ -163,8 +163,10 @@
 
 static struct i2c_driver i2c_driver_videotext  {
-	.owner 		= THIS_MODULE,
-	.name 		= IF_NAME,		/* name */
+	.driver = {
+		.owner 	= THIS_MODULE,
+		.name 	= IF_NAME,		/* name */
+	},
 	.id 		= I2C_DRIVERID_SAA5249, /* in i2c.h */
 	.attach_adapter = saa5246a_probe,
 	.detach_client  = saa5246a_detach,
--- linux-2.6.15-rc2.orig/drivers/media/video/saa5249.c	2005-11-26 13:42:27.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/saa5249.c	2005-11-26 14:00:37.000000000 +0100
@@ -236,8 +236,10 @@
 
 static struct i2c_driver i2c_driver_videotext = 
 {
-	.owner 		= THIS_MODULE,
-	.name 		= IF_NAME,		/* name */
+	.driver = {
+		.owner 	= THIS_MODULE,
+		.name 	= IF_NAME,		/* name */
+	},
 	.id 		= I2C_DRIVERID_SAA5249, /* in i2c.h */
 	.attach_adapter = saa5249_probe,
 	.detach_client  = saa5249_detach,
--- linux-2.6.15-rc2.orig/drivers/media/video/saa6588.c	2005-11-26 13:42:27.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/saa6588.c	2005-11-26 14:00:37.000000000 +0100
@@ -496,8 +496,10 @@
 /* ----------------------------------------------------------------------- */
 
 static struct i2c_driver driver = {
-	.owner = THIS_MODULE,
-	.name = "i2c saa6588 driver",
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "i2c saa6588 driver",
+	},
 	.id = -1,		/* FIXME */
 	.attach_adapter = saa6588_probe,
 	.detach_client = saa6588_detach,
--- linux-2.6.15-rc2.orig/drivers/media/video/saa7110.c	2005-11-26 13:42:27.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/saa7110.c	2005-11-26 14:00:37.000000000 +0100
@@ -587,8 +587,10 @@
 /* ----------------------------------------------------------------------- */
 
 static struct i2c_driver i2c_driver_saa7110 = {
-	.owner = THIS_MODULE,
-	.name = "saa7110",
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "saa7110",
+	},
 
 	.id = I2C_DRIVERID_SAA7110,
 
--- linux-2.6.15-rc2.orig/drivers/media/video/saa7111.c	2005-11-26 13:42:27.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/saa7111.c	2005-11-26 14:00:37.000000000 +0100
@@ -590,8 +590,10 @@
 /* ----------------------------------------------------------------------- */
 
 static struct i2c_driver i2c_driver_saa7111 = {
-	.owner = THIS_MODULE,
-	.name = "saa7111",
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "saa7111",
+	},
 
 	.id = I2C_DRIVERID_SAA7111A,
 
--- linux-2.6.15-rc2.orig/drivers/media/video/saa7114.c	2005-11-26 13:42:27.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/saa7114.c	2005-11-26 14:00:37.000000000 +0100
@@ -1204,8 +1204,10 @@
 /* ----------------------------------------------------------------------- */
 
 static struct i2c_driver i2c_driver_saa7114 = {
-	.owner = THIS_MODULE,
-	.name = "saa7114",
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "saa7114",
+	},
 
 	.id = I2C_DRIVERID_SAA7114,
 
--- linux-2.6.15-rc2.orig/drivers/media/video/saa7115.c	2005-11-26 13:42:27.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/saa7115.c	2005-11-26 14:00:37.000000000 +0100
@@ -52,15 +52,16 @@
 #define saa7115_dbg(fmt,arg...) \
 	do { \
 		if (debug) \
-			printk(KERN_INFO "%s debug %d-%04x: " fmt, client->driver->name, \
+			printk(KERN_INFO "%s debug %d-%04x: " fmt, \
+			       client->driver->driver.name, \
 			       i2c_adapter_id(client->adapter), client->addr , ## arg); \
 	} while (0)
 
 #define saa7115_err(fmt, arg...) do { \
-	printk(KERN_ERR "%s %d-%04x: " fmt, client->driver->name, \
+	printk(KERN_ERR "%s %d-%04x: " fmt, client->driver->driver.name, \
 	       i2c_adapter_id(client->adapter), client->addr , ## arg); } while (0)
 #define saa7115_info(fmt, arg...) do { \
-	printk(KERN_INFO "%s %d-%04x: " fmt, client->driver->name, \
+	printk(KERN_INFO "%s %d-%04x: " fmt, client->driver->driver.name, \
 	       i2c_adapter_id(client->adapter), client->addr , ## arg); } while (0)
 
 static unsigned short normal_i2c[] = { 0x42 >> 1, 0x40 >> 1, I2C_CLIENT_END };
@@ -1352,12 +1353,14 @@
 
 /* i2c implementation */
 static struct i2c_driver i2c_driver_saa7115 = {
-	.name = "saa7115",
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "saa7115",
+	},
 	.id = I2C_DRIVERID_SAA711X,
 	.attach_adapter = saa7115_probe,
 	.detach_client = saa7115_detach,
 	.command = saa7115_command,
-	.owner = THIS_MODULE,
 };
 
 
--- linux-2.6.15-rc2.orig/drivers/media/video/saa711x.c	2005-11-26 13:42:27.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/saa711x.c	2005-11-26 14:00:37.000000000 +0100
@@ -565,8 +565,10 @@
 /* ----------------------------------------------------------------------- */
 
 static struct i2c_driver i2c_driver_saa711x = {
-	.owner = THIS_MODULE,
-	.name = "saa711x",
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "saa711x",
+	},
 
 	.id = I2C_DRIVERID_SAA711X,
 
--- linux-2.6.15-rc2.orig/drivers/media/video/saa7127.c	2005-11-26 13:42:27.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/saa7127.c	2005-11-26 14:00:37.000000000 +0100
@@ -69,7 +69,8 @@
 #define saa7127_dbg(fmt, arg...) \
 	do { \
 		if (debug >= 1) \
-			printk(KERN_INFO "%s debug %d-%04x: " fmt, client->driver->name, \
+			printk(KERN_INFO "%s debug %d-%04x: " fmt, \
+			       client->driver->driver.name, \
 			       i2c_adapter_id(client->adapter), client->addr , ## arg); \
 	} while (0)
 
@@ -77,15 +78,16 @@
 #define saa7127_dbg_highvol(fmt, arg...) \
 	do { \
 		if (debug = 2) \
-			printk(KERN_INFO "%s debug %d-%04x: " fmt, client->driver->name, \
+			printk(KERN_INFO "%s debug %d-%04x: " fmt, \
+			       client->driver->driver.name, \
 			       i2c_adapter_id(client->adapter), client->addr , ## arg); \
 	} while (0)
 
 #define saa7127_err(fmt, arg...) do { \
-	printk(KERN_ERR "%s %d-%04x: " fmt, client->driver->name, \
+	printk(KERN_ERR "%s %d-%04x: " fmt, client->driver->driver.name, \
 	       i2c_adapter_id(client->adapter), client->addr , ## arg); } while (0)
 #define saa7127_info(fmt, arg...) do { \
-	printk(KERN_INFO "%s %d-%04x: " fmt, client->driver->name, \
+	printk(KERN_INFO "%s %d-%04x: " fmt, client->driver->driver.name, \
 	       i2c_adapter_id(client->adapter), client->addr , ## arg); } while (0)
 
 static unsigned short normal_i2c[] = { 0x88 >> 1, I2C_CLIENT_END };
@@ -819,12 +821,14 @@
 /* ----------------------------------------------------------------------- */
 
 struct i2c_driver i2c_driver_saa7127 = {
-	.name = "saa7127",
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "saa7127",
+	},
 	.id = I2C_DRIVERID_SAA7127,
 	.attach_adapter = saa7127_probe,
 	.detach_client = saa7127_detach,
 	.command = saa7127_command,
-	.owner = THIS_MODULE,
 };
 
 
--- linux-2.6.15-rc2.orig/drivers/media/video/saa7134/saa6752hs.c	2005-11-26 13:42:27.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/saa7134/saa6752hs.c	2005-11-26 14:00:37.000000000 +0100
@@ -596,8 +596,10 @@
 /* ----------------------------------------------------------------------- */
 
 static struct i2c_driver driver = {
-	.owner          = THIS_MODULE,
-        .name           = "i2c saa6752hs MPEG encoder",
+	.driver = {
+		.owner  = THIS_MODULE,
+		.name   = "i2c saa6752hs MPEG encoder",
+	},
         .id             = I2C_DRIVERID_SAA6752HS,
         .attach_adapter = saa6752hs_probe,
         .detach_client  = saa6752hs_detach,
--- linux-2.6.15-rc2.orig/drivers/media/video/saa7134/saa7134-i2c.c	2005-11-25 22:42:37.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/saa7134/saa7134-i2c.c	2005-11-26 14:00:37.000000000 +0100
@@ -333,7 +333,7 @@
 	struct tuner_setup tun_setup;
 
 	d1printk( "%s i2c attach [addr=0x%x,client=%s]\n",
-		 client->driver->name, client->addr, client->name);
+		 client->driver->driver.name, client->addr, client->name);
 
 	/* Am I an i2c remote control? */
 
@@ -343,7 +343,7 @@
 		{
 			struct IR_i2c *ir = i2c_get_clientdata(client);
 			d1printk("%s i2c IR detected (%s).\n",
-				 client->driver->name,ir->phys);
+				 client->driver->driver.name, ir->phys);
 			saa7134_set_i2c_ir(dev,ir);
 			break;
 		}
--- linux-2.6.15-rc2.orig/drivers/media/video/saa7185.c	2005-11-26 13:42:27.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/saa7185.c	2005-11-26 14:00:37.000000000 +0100
@@ -487,8 +487,10 @@
 /* ----------------------------------------------------------------------- */
 
 static struct i2c_driver i2c_driver_saa7185 = {
-	.owner = THIS_MODULE,
-	.name = "saa7185",	/* name */
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "saa7185",	/* name */
+	},
 
 	.id = I2C_DRIVERID_SAA7185B,
 
--- linux-2.6.15-rc2.orig/drivers/media/video/saa7191.c	2005-11-26 13:42:27.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/saa7191.c	2005-11-26 14:00:37.000000000 +0100
@@ -788,8 +788,10 @@
 }
 
 static struct i2c_driver i2c_driver_saa7191 = {
-	.owner		= THIS_MODULE,
-	.name		= "saa7191",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name 	= "saa7191",
+	},
 	.id		= I2C_DRIVERID_SAA7191,
 	.attach_adapter = saa7191_probe,
 	.detach_client	= saa7191_detach,
--- linux-2.6.15-rc2.orig/drivers/media/video/tda7432.c	2005-11-26 13:42:27.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/tda7432.c	2005-11-26 14:00:37.000000000 +0100
@@ -501,8 +501,10 @@
 }
 
 static struct i2c_driver driver = {
-	.owner           = THIS_MODULE,
-	.name            = "i2c tda7432 driver",
+	.driver = {
+		.owner   = THIS_MODULE,
+		.name    = "i2c tda7432 driver",
+	},
 	.id              = I2C_DRIVERID_TDA7432,
 	.attach_adapter  = tda7432_probe,
 	.detach_client   = tda7432_detach,
--- linux-2.6.15-rc2.orig/drivers/media/video/tda9840.c	2005-11-26 13:42:27.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/tda9840.c	2005-11-26 14:00:37.000000000 +0100
@@ -221,8 +221,10 @@
 }
 
 static struct i2c_driver driver = {
-	.owner	= THIS_MODULE,
-	.name	= "tda9840",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "tda9840",
+	},
 	.id	= I2C_DRIVERID_TDA9840,
 	.attach_adapter	= attach,
 	.detach_client	= detach,
--- linux-2.6.15-rc2.orig/drivers/media/video/tda9875.c	2005-11-26 13:42:27.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/tda9875.c	2005-11-26 14:00:37.000000000 +0100
@@ -372,8 +372,10 @@
 
 
 static struct i2c_driver driver = {
-	.owner          = THIS_MODULE,
-	.name           = "i2c tda9875 driver",
+	.driver = {
+		.owner  = THIS_MODULE,
+		.name   = "i2c tda9875 driver",
+	},
 	.id             = I2C_DRIVERID_TDA9875,
 	.attach_adapter = tda9875_probe,
 	.detach_client  = tda9875_detach,
--- linux-2.6.15-rc2.orig/drivers/media/video/tda9887.c	2005-11-26 13:42:27.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/tda9887.c	2005-11-26 14:00:37.000000000 +0100
@@ -818,13 +818,13 @@
 /* ----------------------------------------------------------------------- */
 
 static struct i2c_driver driver = {
-	.owner          = THIS_MODULE,
-        .name           = "i2c tda9887 driver",
         .id             = -1, /* FIXME */
         .attach_adapter = tda9887_probe,
         .detach_client  = tda9887_detach,
         .command        = tda9887_command,
 	.driver = {
+		.owner   = THIS_MODULE,
+        	.name    = "i2c tda9887 driver",
 		.suspend = tda9887_suspend,
 		.resume  = tda9887_resume,
 	},
--- linux-2.6.15-rc2.orig/drivers/media/video/tea6415c.c	2005-11-26 13:42:27.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/tea6415c.c	2005-11-26 14:00:37.000000000 +0100
@@ -190,8 +190,10 @@
 }
 
 static struct i2c_driver driver = {
-	.owner	= THIS_MODULE,
-	.name 	= "tea6415c",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name 	= "tea6415c",
+	},
 	.id 	= I2C_DRIVERID_TEA6415C,
 	.attach_adapter	= attach,
 	.detach_client	= detach,
--- linux-2.6.15-rc2.orig/drivers/media/video/tea6420.c	2005-11-26 13:42:27.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/tea6420.c	2005-11-26 14:00:37.000000000 +0100
@@ -167,8 +167,10 @@
 }
 
 static struct i2c_driver driver = {
-	.owner	= THIS_MODULE,
-	.name	= "tea6420",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "tea6420",
+	},
 	.id	= I2C_DRIVERID_TEA6420,
 	.attach_adapter	= attach,
 	.detach_client	= detach,
--- linux-2.6.15-rc2.orig/drivers/media/video/tuner-3036.c	2005-11-26 13:42:27.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/tuner-3036.c	2005-11-26 14:00:37.000000000 +0100
@@ -175,8 +175,10 @@
 static struct i2c_driver 
 i2c_driver_tuner = 
 {
-	.owner		=	THIS_MODULE,
-	.name		=	"sab3036",
+	.driver = {
+		.owner	=	THIS_MODULE,
+		.name	=	"sab3036",
+	},
 	.id		=	I2C_DRIVERID_SAB3036,
 	.attach_adapter =	tuner_probe,
 	.detach_client  =	tuner_detach,
--- linux-2.6.15-rc2.orig/drivers/media/video/tuner-core.c	2005-11-26 13:42:27.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/tuner-core.c	2005-11-26 14:00:37.000000000 +0100
@@ -206,7 +206,7 @@
 
 	set_freq(c, t->freq);
 	tuner_dbg("%s %s I2C addr 0x%02x with type %d used for 0x%02x\n",
-		  c->adapter->name, c->driver->name, c->addr << 1, type,
+		  c->adapter->name, c->driver->driver.name, c->addr << 1, type,
 		  t->mode_mask);
 }
 
@@ -742,13 +742,13 @@
 /* ----------------------------------------------------------------------- */
 
 static struct i2c_driver driver = {
-	.owner = THIS_MODULE,
-	.name = "tuner",
 	.id = I2C_DRIVERID_TUNER,
 	.attach_adapter = tuner_probe,
 	.detach_client = tuner_detach,
 	.command = tuner_command,
 	.driver = {
+		   .owner = THIS_MODULE,
+		   .name = "tuner",
 		   .suspend = tuner_suspend,
 		   .resume = tuner_resume,
 		   },
--- linux-2.6.15-rc2.orig/drivers/media/video/tvaudio.c	2005-11-26 13:42:27.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/tvaudio.c	2005-11-26 14:00:37.000000000 +0100
@@ -1702,8 +1702,10 @@
 
 
 static struct i2c_driver driver = {
-	.owner           = THIS_MODULE,
-	.name            = "generic i2c audio driver",
+	.driver = {
+		.owner   = THIS_MODULE,
+		.name    = "generic i2c audio driver",
+	},
 	.id              = I2C_DRIVERID_TVAUDIO,
 	.attach_adapter  = chip_probe,
 	.detach_client   = chip_detach,
--- linux-2.6.15-rc2.orig/drivers/media/video/tveeprom.c	2005-11-26 13:42:27.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/tveeprom.c	2005-11-26 14:00:37.000000000 +0100
@@ -736,8 +736,10 @@
 }
 
 static struct i2c_driver i2c_driver_tveeprom = {
-	.owner          = THIS_MODULE,
-	.name           = "tveeprom",
+	.driver = {
+		.owner  = THIS_MODULE,
+		.name   = "tveeprom",
+	},
 	.id             = I2C_DRIVERID_TVEEPROM,
 	.attach_adapter = tveeprom_attach_adapter,
 	.detach_client  = tveeprom_detach_client,
--- linux-2.6.15-rc2.orig/drivers/media/video/tvmixer.c	2005-11-26 13:42:27.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/tvmixer.c	2005-11-26 14:00:37.000000000 +0100
@@ -228,9 +228,13 @@
 
 static struct i2c_driver driver = {
 #ifdef I2C_PEC
-	.owner           = THIS_MODULE,
-#endif
+	.driver = {
+		.owner   = THIS_MODULE,
+		.name    = "tv card mixer driver",
+	},
+#else
 	.name            = "tv card mixer driver",
+#endif
 	.id              = I2C_DRIVERID_TVMIXER,
 	.detach_adapter  = tvmixer_adapters,
 	.attach_adapter  = tvmixer_adapters,
--- linux-2.6.15-rc2.orig/drivers/media/video/tvp5150.c	2005-11-26 13:42:27.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/tvp5150.c	2005-11-26 14:00:37.000000000 +0100
@@ -802,8 +802,10 @@
 /* ----------------------------------------------------------------------- */
 
 static struct i2c_driver driver = {
-	.owner = THIS_MODULE,
-	.name = "tvp5150",
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "tvp5150",
+	},
 
 	/* FIXME */
 	.id = I2C_DRIVERID_SAA7110,
--- linux-2.6.15-rc2.orig/drivers/media/video/vpx3220.c	2005-11-26 13:42:27.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/vpx3220.c	2005-11-26 14:00:37.000000000 +0100
@@ -722,8 +722,10 @@
  */
 
 static struct i2c_driver vpx3220_i2c_driver = {
-	.owner = THIS_MODULE,
-	.name = "vpx3220",
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "vpx3220",
+	},
 
 	.id = I2C_DRIVERID_VPX3220,
 
--- linux-2.6.15-rc2.orig/drivers/media/video/wm8775.c	2005-11-26 13:42:27.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/wm8775.c	2005-11-26 14:00:37.000000000 +0100
@@ -40,10 +40,10 @@
 MODULE_LICENSE("GPL");
 
 #define wm8775_err(fmt, arg...) do { \
-	printk(KERN_ERR "%s %d-%04x: " fmt, client->driver->name, \
+	printk(KERN_ERR "%s %d-%04x: " fmt, client->driver->driver.name, \
 	       i2c_adapter_id(client->adapter), client->addr , ## arg); } while (0)
 #define wm8775_info(fmt, arg...) do { \
-	printk(KERN_INFO "%s %d-%04x: " fmt, client->driver->name, \
+	printk(KERN_INFO "%s %d-%04x: " fmt, client->driver->driver.name, \
 	       i2c_adapter_id(client->adapter), client->addr , ## arg); } while (0)
 
 
@@ -233,14 +233,16 @@
 
 /* i2c implementation */
 static struct i2c_driver i2c_driver = {
-	.name = "wm8775",
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "wm8775",
+	},
 
 	.id = I2C_DRIVERID_WM8775,
 
 	.attach_adapter = wm8775_probe,
 	.detach_client = wm8775_detach,
 	.command = wm8775_command,
-	.owner = THIS_MODULE,
 };
 
 
--- linux-2.6.15-rc2.orig/drivers/media/video/zoran_driver.c	2005-11-25 22:42:37.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/zoran_driver.c	2005-11-26 14:00:37.000000000 +0100
@@ -1311,7 +1311,7 @@
 		res = -ENODEV;
 		goto open_unlock_and_return;
 	}
-	if (!try_module_get(zr->decoder->driver->owner)) {
+	if (!try_module_get(zr->decoder->driver->driver.owner)) {
 		dprintk(1,
 			KERN_ERR
 			"%s: failed to grab ownership of i2c decoder\n",
@@ -1321,13 +1321,13 @@
 		goto open_unlock_and_return;
 	}
 	if (zr->encoder &&
-	    !try_module_get(zr->encoder->driver->owner)) {
+	    !try_module_get(zr->encoder->driver->driver.owner)) {
 		dprintk(1,
 			KERN_ERR
 			"%s: failed to grab ownership of i2c encoder\n",
 			ZR_DEVNAME(zr));
 		res = -EIO;
-		module_put(zr->decoder->driver->owner);
+		module_put(zr->decoder->driver->driver.owner);
 		module_put(THIS_MODULE);
 		goto open_unlock_and_return;
 	}
@@ -1393,9 +1393,9 @@
 open_unlock_and_return:
 	/* if we grabbed locks, release them accordingly */
 	if (have_module_locks) {
-		module_put(zr->decoder->driver->owner);
+		module_put(zr->decoder->driver->driver.owner);
 		if (zr->encoder) {
-			module_put(zr->encoder->driver->owner);
+			module_put(zr->encoder->driver->driver.owner);
 		}
 		module_put(THIS_MODULE);
 	}
@@ -1461,9 +1461,9 @@
 	kfree(fh);
 
 	/* release locks on the i2c modules */
-	module_put(zr->decoder->driver->owner);
+	module_put(zr->decoder->driver->driver.owner);
 	if (zr->encoder) {
-		 module_put(zr->encoder->driver->owner);
+		 module_put(zr->encoder->driver->driver.owner);
 	}
 	module_put(THIS_MODULE);
 
--- linux-2.6.15-rc2.orig/drivers/usb/media/w9968cf.c	2005-11-25 22:42:37.000000000 +0100
+++ linux-2.6.15-rc2/drivers/usb/media/w9968cf.c	2005-11-26 14:00:37.000000000 +0100
@@ -1533,12 +1533,12 @@
 		}
 	} else {
 		DBG(4, "Rejected client [%s] with driver [%s]", 
-		    client->name, client->driver->name)
+		    client->name, client->driver->driver.name)
 		return -EINVAL;
 	}
 
 	DBG(5, "I2C attach client [%s] with driver [%s]",
-	    client->name, client->driver->name)
+	    client->name, client->driver->driver.name)
 
 	return 0;
 }
--- linux-2.6.15-rc2.orig/include/media/tuner.h	2005-11-25 22:42:37.000000000 +0100
+++ linux-2.6.15-rc2/include/media/tuner.h	2005-11-26 14:00:37.000000000 +0100
@@ -218,14 +218,15 @@
 extern int tea5767_autodetection(struct i2c_client *c);
 
 #define tuner_warn(fmt, arg...) do {\
-	printk(KERN_WARNING "%s %d-%04x: " fmt, t->i2c.driver->name, \
+	printk(KERN_WARNING "%s %d-%04x: " fmt, t->i2c.driver->driver.name, \
 			t->i2c.adapter->nr, t->i2c.addr , ##arg); } while (0)
 #define tuner_info(fmt, arg...) do {\
-	printk(KERN_INFO "%s %d-%04x: " fmt, t->i2c.driver->name, \
+	printk(KERN_INFO "%s %d-%04x: " fmt, t->i2c.driver->driver.name, \
 			t->i2c.adapter->nr, t->i2c.addr , ##arg); } while (0)
 #define tuner_dbg(fmt, arg...) do {\
 	if (tuner_debug) \
-		printk(KERN_DEBUG "%s %d-%04x: " fmt, t->i2c.driver->name, \
+		printk(KERN_DEBUG "%s %d-%04x: " fmt, \
+			t->i2c.driver->driver.name, \
 			t->i2c.adapter->nr, t->i2c.addr , ##arg); } while (0)
 
 #endif /* __KERNEL__ */

-- 
Jean Delvare
