From: laurent.riffard@free.fr (Laurent riffard)
Date: Mon, 24 Oct 2005 23:31:23 +0000
Subject: [lm-sensors] [patch 5/9] I2C: remove i2c_driver's .owner and .name
Message-Id: <20051024212541.892926000@antares.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

We should use the i2c_driver.driver's .name and .owner fields
instead of the i2c_drivers's ones.

This patch updates the drivers/media/video files.

Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
--

 drivers/media/video/adv7170.c                  |    6 ++++--
 drivers/media/video/adv7175.c                  |    6 ++++--
 drivers/media/video/bt819.c                    |    6 ++++--
 drivers/media/video/bt832.c                    |    6 ++++--
 drivers/media/video/bt856.c                    |    6 ++++--
 drivers/media/video/indycam.c                  |    6 ++++--
 drivers/media/video/ir-kbd-i2c.c               |    7 +++++--
 drivers/media/video/msp3400.c                  |   12 ++++++------
 drivers/media/video/ovcamchip/ovcamchip_core.c |    6 ++++--
 drivers/media/video/saa5246a.c                 |    6 ++++--
 drivers/media/video/saa5249.c                  |    6 ++++--
 drivers/media/video/saa6588.c                  |    6 ++++--
 drivers/media/video/saa7110.c                  |    6 ++++--
 drivers/media/video/saa7111.c                  |    6 ++++--
 drivers/media/video/saa7114.c                  |    6 ++++--
 drivers/media/video/saa7134/saa6752hs.c        |    6 ++++--
 drivers/media/video/saa7185.c                  |    6 ++++--
 drivers/media/video/saa7191.c                  |    6 ++++--
 drivers/media/video/tda7432.c                  |    6 ++++--
 drivers/media/video/tda9840.c                  |    6 ++++--
 drivers/media/video/tda9875.c                  |    6 ++++--
 drivers/media/video/tda9887.c                  |   12 ++++++------
 drivers/media/video/tea6415c.c                 |    6 ++++--
 drivers/media/video/tea6420.c                  |    6 ++++--
 drivers/media/video/tuner-3036.c               |    6 ++++--
 drivers/media/video/tuner-core.c               |   12 ++++++------
 drivers/media/video/tvaudio.c                  |    6 ++++--
 drivers/media/video/tveeprom.c                 |    6 ++++--
 drivers/media/video/tvmixer.c                  |    6 ++++--
 drivers/media/video/vpx3220.c                  |    6 ++++--
 30 files changed, 127 insertions(+), 72 deletions(-)

Index: linux-2.6-mm/drivers/media/video/adv7170.c
=================================--- linux-2.6-mm.orig/drivers/media/video/adv7170.c
+++ linux-2.6-mm/drivers/media/video/adv7170.c
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
 	.flags = I2C_DF_NOTIFY,
Index: linux-2.6-mm/drivers/media/video/adv7175.c
=================================--- linux-2.6-mm.orig/drivers/media/video/adv7175.c
+++ linux-2.6-mm/drivers/media/video/adv7175.c
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
 	.flags = I2C_DF_NOTIFY,
Index: linux-2.6-mm/drivers/media/video/bt819.c
=================================--- linux-2.6-mm.orig/drivers/media/video/bt819.c
+++ linux-2.6-mm/drivers/media/video/bt819.c
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
 	.flags = I2C_DF_NOTIFY,
Index: linux-2.6-mm/drivers/media/video/bt832.c
=================================--- linux-2.6-mm.orig/drivers/media/video/bt832.c
+++ linux-2.6-mm/drivers/media/video/bt832.c
@@ -231,8 +231,10 @@
 /* ----------------------------------------------------------------------- */
 
 static struct i2c_driver driver = {
-	.owner          = THIS_MODULE,
-        .name           = "i2c bt832 driver",
+	.driver = {
+		.owner  = THIS_MODULE,
+		.name   = "i2c bt832 driver",
+	},
         .id             = -1, /* FIXME */
         .flags          = I2C_DF_NOTIFY,
         .attach_adapter = bt832_probe,
Index: linux-2.6-mm/drivers/media/video/bt856.c
=================================--- linux-2.6-mm.orig/drivers/media/video/bt856.c
+++ linux-2.6-mm/drivers/media/video/bt856.c
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
 	.flags = I2C_DF_NOTIFY,
Index: linux-2.6-mm/drivers/media/video/indycam.c
=================================--- linux-2.6-mm.orig/drivers/media/video/indycam.c
+++ linux-2.6-mm/drivers/media/video/indycam.c
@@ -387,8 +387,10 @@
 }
 
 static struct i2c_driver i2c_driver_indycam = {
-	.owner		= THIS_MODULE,
-	.name 		= "indycam",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name 	= "indycam",
+	},
 	.id 		= I2C_DRIVERID_INDYCAM,
 	.flags 		= I2C_DF_NOTIFY,
 	.attach_adapter = indycam_probe,
Index: linux-2.6-mm/drivers/media/video/ir-kbd-i2c.c
=================================--- linux-2.6-mm.orig/drivers/media/video/ir-kbd-i2c.c
+++ linux-2.6-mm/drivers/media/video/ir-kbd-i2c.c
@@ -297,8 +297,11 @@
 static int ir_probe(struct i2c_adapter *adap);
 
 static struct i2c_driver driver = {
-        .name           = "ir remote kbd driver",
-        .id             = I2C_DRIVERID_EXP3, /* FIXME */
+	.driver = {
+		.owner  = THIS_MODULE,
+		.name   = "ir remote kbd driver",
+	},
+	.id             = I2C_DRIVERID_EXP3, /* FIXME */
         .flags          = I2C_DF_NOTIFY,
         .attach_adapter = ir_probe,
         .detach_client  = ir_detach,
Index: linux-2.6-mm/drivers/media/video/msp3400.c
=================================--- linux-2.6-mm.orig/drivers/media/video/msp3400.c
+++ linux-2.6-mm/drivers/media/video/msp3400.c
@@ -1426,17 +1426,17 @@
 static void msp_wake_thread(struct i2c_client *client);
 
 static struct i2c_driver driver = {
-	.owner          = THIS_MODULE,
-	.name           = "i2c msp3400 driver",
+	.driver = {
+		.owner   = THIS_MODULE,
+		.name    = "i2c msp3400 driver",
+		.suspend = msp_suspend,
+		.resume  = msp_resume,
+	},
         .id             = I2C_DRIVERID_MSP3400,
         .flags          = I2C_DF_NOTIFY,
         .attach_adapter = msp_probe,
         .detach_client  = msp_detach,
         .command        = msp_command,
-	.driver = {
-		.suspend = msp_suspend,
-		.resume  = msp_resume,
-	},
 };
 
 static struct i2c_client client_template Index: linux-2.6-mm/drivers/media/video/ovcamchip/ovcamchip_core.c
=================================--- linux-2.6-mm.orig/drivers/media/video/ovcamchip/ovcamchip_core.c
+++ linux-2.6-mm/drivers/media/video/ovcamchip/ovcamchip_core.c
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
 	.flags =		I2C_DF_NOTIFY,
Index: linux-2.6-mm/drivers/media/video/saa5246a.c
=================================--- linux-2.6-mm.orig/drivers/media/video/saa5246a.c
+++ linux-2.6-mm/drivers/media/video/saa5246a.c
@@ -163,8 +163,10 @@
 
 static struct i2c_driver i2c_driver_videotext  {
-	.owner 		= THIS_MODULE,
-	.name 		= IF_NAME,		/* name */
+	.driver = {
+		.owner 	= THIS_MODULE,
+		.name 	= IF_NAME,		/* name */
+	},
 	.id 		= I2C_DRIVERID_SAA5249, /* in i2c.h */
 	.flags 		= I2C_DF_NOTIFY,
 	.attach_adapter = saa5246a_probe,
Index: linux-2.6-mm/drivers/media/video/saa5249.c
=================================--- linux-2.6-mm.orig/drivers/media/video/saa5249.c
+++ linux-2.6-mm/drivers/media/video/saa5249.c
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
 	.flags 		= I2C_DF_NOTIFY,
 	.attach_adapter = saa5249_probe,
Index: linux-2.6-mm/drivers/media/video/saa6588.c
=================================--- linux-2.6-mm.orig/drivers/media/video/saa6588.c
+++ linux-2.6-mm/drivers/media/video/saa6588.c
@@ -497,8 +497,10 @@
 /* ----------------------------------------------------------------------- */
 
 static struct i2c_driver driver = {
-	.owner = THIS_MODULE,
-	.name = "i2c saa6588 driver",
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "i2c saa6588 driver",
+	},
 	.id = -1,		/* FIXME */
 	.flags = I2C_DF_NOTIFY,
 	.attach_adapter = saa6588_probe,
Index: linux-2.6-mm/drivers/media/video/saa7110.c
=================================--- linux-2.6-mm.orig/drivers/media/video/saa7110.c
+++ linux-2.6-mm/drivers/media/video/saa7110.c
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
 	.flags = I2C_DF_NOTIFY,
Index: linux-2.6-mm/drivers/media/video/saa7111.c
=================================--- linux-2.6-mm.orig/drivers/media/video/saa7111.c
+++ linux-2.6-mm/drivers/media/video/saa7111.c
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
 	.flags = I2C_DF_NOTIFY,
Index: linux-2.6-mm/drivers/media/video/saa7114.c
=================================--- linux-2.6-mm.orig/drivers/media/video/saa7114.c
+++ linux-2.6-mm/drivers/media/video/saa7114.c
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
 	.flags = I2C_DF_NOTIFY,
Index: linux-2.6-mm/drivers/media/video/saa7134/saa6752hs.c
=================================--- linux-2.6-mm.orig/drivers/media/video/saa7134/saa6752hs.c
+++ linux-2.6-mm/drivers/media/video/saa7134/saa6752hs.c
@@ -587,8 +587,10 @@
 /* ----------------------------------------------------------------------- */
 
 static struct i2c_driver driver = {
-	.owner          = THIS_MODULE,
-        .name           = "i2c saa6752hs MPEG encoder",
+	.driver = {
+		.owner  = THIS_MODULE,
+		.name   = "i2c saa6752hs MPEG encoder",
+	},
         .id             = I2C_DRIVERID_SAA6752HS,
         .flags          = I2C_DF_NOTIFY,
         .attach_adapter = saa6752hs_probe,
Index: linux-2.6-mm/drivers/media/video/saa7185.c
=================================--- linux-2.6-mm.orig/drivers/media/video/saa7185.c
+++ linux-2.6-mm/drivers/media/video/saa7185.c
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
 	.flags = I2C_DF_NOTIFY,
Index: linux-2.6-mm/drivers/media/video/saa7191.c
=================================--- linux-2.6-mm.orig/drivers/media/video/saa7191.c
+++ linux-2.6-mm/drivers/media/video/saa7191.c
@@ -487,8 +487,10 @@
 }
 
 static struct i2c_driver i2c_driver_saa7191 = {
-	.owner		= THIS_MODULE,
-	.name 		= "saa7191",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name 	= "saa7191",
+	},
 	.id 		= I2C_DRIVERID_SAA7191,
 	.flags 		= I2C_DF_NOTIFY,
 	.attach_adapter = saa7191_probe,
Index: linux-2.6-mm/drivers/media/video/tda7432.c
=================================--- linux-2.6-mm.orig/drivers/media/video/tda7432.c
+++ linux-2.6-mm/drivers/media/video/tda7432.c
@@ -502,8 +502,10 @@
 }
 
 static struct i2c_driver driver = {
-	.owner           = THIS_MODULE,
-        .name            = "i2c tda7432 driver",
+	.driver = {
+		.owner   = THIS_MODULE,
+		.name    = "i2c tda7432 driver",
+	},
 	.id              = I2C_DRIVERID_TDA7432,
         .flags           = I2C_DF_NOTIFY,
 	.attach_adapter  = tda7432_probe,
Index: linux-2.6-mm/drivers/media/video/tda9840.c
=================================--- linux-2.6-mm.orig/drivers/media/video/tda9840.c
+++ linux-2.6-mm/drivers/media/video/tda9840.c
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
 	.flags	= I2C_DF_NOTIFY,
 	.attach_adapter	= attach,
Index: linux-2.6-mm/drivers/media/video/tda9875.c
=================================--- linux-2.6-mm.orig/drivers/media/video/tda9875.c
+++ linux-2.6-mm/drivers/media/video/tda9875.c
@@ -373,8 +373,10 @@
 
 
 static struct i2c_driver driver = {
-	.owner          = THIS_MODULE,
-        .name           = "i2c tda9875 driver",
+	.driver = {
+		.owner  = THIS_MODULE,
+		.name   = "i2c tda9875 driver",
+	},
         .id             = I2C_DRIVERID_TDA9875,
         .flags          = I2C_DF_NOTIFY,
 	.attach_adapter = tda9875_probe,
Index: linux-2.6-mm/drivers/media/video/tda9887.c
=================================--- linux-2.6-mm.orig/drivers/media/video/tda9887.c
+++ linux-2.6-mm/drivers/media/video/tda9887.c
@@ -803,17 +803,17 @@
 /* ----------------------------------------------------------------------- */
 
 static struct i2c_driver driver = {
-	.owner          = THIS_MODULE,
-        .name           = "i2c tda9887 driver",
+	.driver = {
+		.owner   = THIS_MODULE,
+		.name    = "i2c tda9887 driver",
+		.suspend = tda9887_suspend,
+		.resume  = tda9887_resume,
+	},
         .id             = -1, /* FIXME */
         .flags          = I2C_DF_NOTIFY,
         .attach_adapter = tda9887_probe,
         .detach_client  = tda9887_detach,
         .command        = tda9887_command,
-	.driver = {
-		.suspend = tda9887_suspend,
-		.resume  = tda9887_resume,
-	},
 };
 static struct i2c_client client_template  {
Index: linux-2.6-mm/drivers/media/video/tea6415c.c
=================================--- linux-2.6-mm.orig/drivers/media/video/tea6415c.c
+++ linux-2.6-mm/drivers/media/video/tea6415c.c
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
 	.flags 	= I2C_DF_NOTIFY,
 	.attach_adapter	= attach,
Index: linux-2.6-mm/drivers/media/video/tea6420.c
=================================--- linux-2.6-mm.orig/drivers/media/video/tea6420.c
+++ linux-2.6-mm/drivers/media/video/tea6420.c
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
 	.flags	= I2C_DF_NOTIFY,
 	.attach_adapter	= attach,
Index: linux-2.6-mm/drivers/media/video/tuner-3036.c
=================================--- linux-2.6-mm.orig/drivers/media/video/tuner-3036.c
+++ linux-2.6-mm/drivers/media/video/tuner-3036.c
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
         .flags		=	I2C_DF_NOTIFY,
 	.attach_adapter =	tuner_probe,
Index: linux-2.6-mm/drivers/media/video/tuner-core.c
=================================--- linux-2.6-mm.orig/drivers/media/video/tuner-core.c
+++ linux-2.6-mm/drivers/media/video/tuner-core.c
@@ -721,17 +721,17 @@
 /* ----------------------------------------------------------------------- */
 
 static struct i2c_driver driver = {
-	.owner = THIS_MODULE,
-	.name = "tuner",
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "tuner",
+		.suspend = tuner_suspend,
+		.resume = tuner_resume,
+	},
 	.id = I2C_DRIVERID_TUNER,
 	.flags = I2C_DF_NOTIFY,
 	.attach_adapter = tuner_probe,
 	.detach_client = tuner_detach,
 	.command = tuner_command,
-	.driver = {
-		   .suspend = tuner_suspend,
-		   .resume = tuner_resume,
-		   },
 };
 static struct i2c_client client_template = {
 	.name = "(tuner unset)",
Index: linux-2.6-mm/drivers/media/video/tvaudio.c
=================================--- linux-2.6-mm.orig/drivers/media/video/tvaudio.c
+++ linux-2.6-mm/drivers/media/video/tvaudio.c
@@ -1703,8 +1703,10 @@
 
 
 static struct i2c_driver driver = {
-	.owner           = THIS_MODULE,
-	.name            = "generic i2c audio driver",
+	.driver = {
+		.owner   = THIS_MODULE,
+		.name    = "generic i2c audio driver",
+	},
 	.id              = I2C_DRIVERID_TVAUDIO,
 	.flags           = I2C_DF_NOTIFY,
 	.attach_adapter  = chip_probe,
Index: linux-2.6-mm/drivers/media/video/tveeprom.c
=================================--- linux-2.6-mm.orig/drivers/media/video/tveeprom.c
+++ linux-2.6-mm/drivers/media/video/tveeprom.c
@@ -672,8 +672,10 @@
 }
 
 static struct i2c_driver i2c_driver_tveeprom = {
-	.owner          = THIS_MODULE,
-	.name           = "tveeprom",
+	.driver = {
+		.owner  = THIS_MODULE,
+		.name   = "tveeprom",
+	},
 	.id             = I2C_DRIVERID_TVEEPROM,
 	.flags          = I2C_DF_NOTIFY,
 	.attach_adapter = tveeprom_attach_adapter,
Index: linux-2.6-mm/drivers/media/video/tvmixer.c
=================================--- linux-2.6-mm.orig/drivers/media/video/tvmixer.c
+++ linux-2.6-mm/drivers/media/video/tvmixer.c
@@ -227,10 +227,12 @@
 }
 
 static struct i2c_driver driver = {
+	.driver = {
 #ifdef I2C_PEC
-	.owner           = THIS_MODULE,
+		.owner   = THIS_MODULE,
 #endif
-	.name            = "tv card mixer driver",
+		.name    = "tv card mixer driver",
+	},
         .id              = I2C_DRIVERID_TVMIXER,
 #ifdef I2C_DF_DUMMY
 	.flags           = I2C_DF_DUMMY,
Index: linux-2.6-mm/drivers/media/video/vpx3220.c
=================================--- linux-2.6-mm.orig/drivers/media/video/vpx3220.c
+++ linux-2.6-mm/drivers/media/video/vpx3220.c
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
 	.flags = I2C_DF_NOTIFY,

--

