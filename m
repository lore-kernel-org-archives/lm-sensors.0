From: gregkh@suse.de (Greg KH)
Date: Fri, 06 Jan 2006 22:07:37 +0000
Subject: [lm-sensors] [PATCH] I2C: Remove .owner setting from i2c_driver as
Message-Id: <11365852573305@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] I2C: Remove .owner setting from i2c_driver as it's no longer needed

Now that i2c_add_driver() doesn't need the module owner to be set by
hand, we can delete it from the drivers.  This patch catches all of the
drivers that I found in the current tree (if a driver sets the .owner by
hand, it's not a problem, just not needed.)

Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
Cc: Jean Delvare <khali at linux-fr.org>

---
commit 2b48716d1d2f2edb1e7cbc5ecf1cb2cb39373e33
tree 04c095d45dfa892b7710e338724a1ac4f1da7cba
parent de59cf9ed44f64991e52a9de6094729537f0420c
author Greg Kroah-Hartman <gregkh at suse.de> Tue, 06 Dec 2005 15:33:15 -0800
committer Greg Kroah-Hartman <gregkh at suse.de> Thu, 05 Jan 2006 22:16:25 -0800

 arch/arm/mach-pxa/akita-ioexp.c                |    1 -
 drivers/acorn/char/pcf8583.c                   |    1 -
 drivers/hwmon/adm1021.c                        |    1 -
 drivers/hwmon/adm1025.c                        |    1 -
 drivers/hwmon/adm1026.c                        |    1 -
 drivers/hwmon/adm1031.c                        |    1 -
 drivers/hwmon/adm9240.c                        |    1 -
 drivers/hwmon/asb100.c                         |    1 -
 drivers/hwmon/atxp1.c                          |    1 -
 drivers/hwmon/ds1621.c                         |    1 -
 drivers/hwmon/fscher.c                         |    1 -
 drivers/hwmon/fscpos.c                         |    1 -
 drivers/hwmon/gl518sm.c                        |    1 -
 drivers/hwmon/gl520sm.c                        |    1 -
 drivers/hwmon/it87.c                           |    2 --
 drivers/hwmon/lm63.c                           |    1 -
 drivers/hwmon/lm75.c                           |    1 -
 drivers/hwmon/lm77.c                           |    1 -
 drivers/hwmon/lm78.c                           |    2 --
 drivers/hwmon/lm80.c                           |    1 -
 drivers/hwmon/lm83.c                           |    1 -
 drivers/hwmon/lm85.c                           |    1 -
 drivers/hwmon/lm87.c                           |    1 -
 drivers/hwmon/lm90.c                           |    1 -
 drivers/hwmon/lm92.c                           |    1 -
 drivers/hwmon/max1619.c                        |    1 -
 drivers/hwmon/pc87360.c                        |    1 -
 drivers/hwmon/sis5595.c                        |    1 -
 drivers/hwmon/smsc47b397.c                     |    1 -
 drivers/hwmon/smsc47m1.c                       |    1 -
 drivers/hwmon/via686a.c                        |    1 -
 drivers/hwmon/vt8231.c                         |    1 -
 drivers/hwmon/w83627ehf.c                      |    1 -
 drivers/hwmon/w83627hf.c                       |    1 -
 drivers/hwmon/w83781d.c                        |    2 --
 drivers/hwmon/w83792d.c                        |    1 -
 drivers/hwmon/w83l785ts.c                      |    1 -
 drivers/i2c/chips/ds1337.c                     |    1 -
 drivers/i2c/chips/ds1374.c                     |    1 -
 drivers/i2c/chips/eeprom.c                     |    1 -
 drivers/i2c/chips/isp1301_omap.c               |    1 -
 drivers/i2c/chips/m41t00.c                     |    1 -
 drivers/i2c/chips/max6875.c                    |    1 -
 drivers/i2c/chips/pca9539.c                    |    1 -
 drivers/i2c/chips/pcf8574.c                    |    1 -
 drivers/i2c/chips/pcf8591.c                    |    1 -
 drivers/i2c/chips/rtc8564.c                    |    1 -
 drivers/i2c/chips/tps65010.c                   |    1 -
 drivers/i2c/chips/x1205.c                      |    1 -
 drivers/i2c/i2c-dev.c                          |    1 -
 drivers/macintosh/therm_adt746x.c              |    1 -
 drivers/macintosh/therm_pm72.c                 |    1 -
 drivers/macintosh/therm_windtunnel.c           |    1 -
 drivers/macintosh/windfarm_lm75_sensor.c       |    1 -
 drivers/media/video/adv7170.c                  |    1 -
 drivers/media/video/adv7175.c                  |    1 -
 drivers/media/video/bt819.c                    |    1 -
 drivers/media/video/bt832.c                    |    1 -
 drivers/media/video/bt856.c                    |    1 -
 drivers/media/video/cs53l32a.c                 |    1 -
 drivers/media/video/cx25840/cx25840-core.c     |    1 -
 drivers/media/video/indycam.c                  |    1 -
 drivers/media/video/ir-kbd-i2c.c               |    1 -
 drivers/media/video/msp3400.c                  |    1 -
 drivers/media/video/ovcamchip/ovcamchip_core.c |    1 -
 drivers/media/video/saa5246a.c                 |    1 -
 drivers/media/video/saa5249.c                  |    1 -
 drivers/media/video/saa6588.c                  |    1 -
 drivers/media/video/saa7110.c                  |    1 -
 drivers/media/video/saa7111.c                  |    1 -
 drivers/media/video/saa7114.c                  |    1 -
 drivers/media/video/saa7115.c                  |    1 -
 drivers/media/video/saa711x.c                  |    1 -
 drivers/media/video/saa7127.c                  |    1 -
 drivers/media/video/saa7134/saa6752hs.c        |    1 -
 drivers/media/video/saa7185.c                  |    1 -
 drivers/media/video/saa7191.c                  |    1 -
 drivers/media/video/tda7432.c                  |    1 -
 drivers/media/video/tda9840.c                  |    1 -
 drivers/media/video/tda9875.c                  |    1 -
 drivers/media/video/tda9887.c                  |    1 -
 drivers/media/video/tea6415c.c                 |    1 -
 drivers/media/video/tea6420.c                  |    1 -
 drivers/media/video/tuner-3036.c               |    1 -
 drivers/media/video/tuner-core.c               |    1 -
 drivers/media/video/tvaudio.c                  |    1 -
 drivers/media/video/tveeprom.c                 |    1 -
 drivers/media/video/tvmixer.c                  |    1 -
 drivers/media/video/tvp5150.c                  |    1 -
 drivers/media/video/vpx3220.c                  |    1 -
 drivers/media/video/wm8775.c                   |    1 -
 drivers/video/matrox/matroxfb_maven.c          |    1 -
 sound/oss/dmasound/dac3550a.c                  |    1 -
 sound/oss/dmasound/tas_common.c                |    1 -
 sound/ppc/keywest.c                            |    1 -
 95 files changed, 0 insertions(+), 98 deletions(-)

diff --git a/arch/arm/mach-pxa/akita-ioexp.c b/arch/arm/mach-pxa/akita-ioexp.c
index 6f7b965..1b39874 100644
--- a/arch/arm/mach-pxa/akita-ioexp.c
+++ b/arch/arm/mach-pxa/akita-ioexp.c
@@ -125,7 +125,6 @@ static int max7310_detach_client(struct 
 
 static struct i2c_driver max7310_i2c_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "akita-max7310",
 	},
 	.id		= I2C_DRIVERID_AKITAIOEXP,
diff --git a/drivers/acorn/char/pcf8583.c b/drivers/acorn/char/pcf8583.c
index 5fc5940..9b49f31 100644
--- a/drivers/acorn/char/pcf8583.c
+++ b/drivers/acorn/char/pcf8583.c
@@ -258,7 +258,6 @@ pcf8583_command(struct i2c_client *clien
 
 static struct i2c_driver pcf8583_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "PCF8583",
 	},
 	.id		= I2C_DRIVERID_PCF8583,
diff --git a/drivers/hwmon/adm1021.c b/drivers/hwmon/adm1021.c
index 679cb92..6656127 100644
--- a/drivers/hwmon/adm1021.c
+++ b/drivers/hwmon/adm1021.c
@@ -127,7 +127,6 @@ static int read_only;
 /* This is the driver that will be inserted */
 static struct i2c_driver adm1021_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "adm1021",
 	},
 	.id		= I2C_DRIVERID_ADM1021,
diff --git a/drivers/hwmon/adm1025.c b/drivers/hwmon/adm1025.c
index 3c70622..9331c56 100644
--- a/drivers/hwmon/adm1025.c
+++ b/drivers/hwmon/adm1025.c
@@ -119,7 +119,6 @@ static struct adm1025_data *adm1025_upda
 
 static struct i2c_driver adm1025_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "adm1025",
 	},
 	.id		= I2C_DRIVERID_ADM1025,
diff --git a/drivers/hwmon/adm1026.c b/drivers/hwmon/adm1026.c
index 92fac34..fefe6e7 100644
--- a/drivers/hwmon/adm1026.c
+++ b/drivers/hwmon/adm1026.c
@@ -309,7 +309,6 @@ static void adm1026_init_client(struct i
 
 static struct i2c_driver adm1026_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "adm1026",
 	},
 	.attach_adapter = adm1026_attach_adapter,
diff --git a/drivers/hwmon/adm1031.c b/drivers/hwmon/adm1031.c
index e42d75e..d063979 100644
--- a/drivers/hwmon/adm1031.c
+++ b/drivers/hwmon/adm1031.c
@@ -106,7 +106,6 @@ static struct adm1031_data *adm1031_upda
 /* This is the driver that will be inserted */
 static struct i2c_driver adm1031_driver = {
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = "adm1031",
 	},
 	.attach_adapter = adm1031_attach_adapter,
diff --git a/drivers/hwmon/adm9240.c b/drivers/hwmon/adm9240.c
index e60309e..5ddc22f 100644
--- a/drivers/hwmon/adm9240.c
+++ b/drivers/hwmon/adm9240.c
@@ -138,7 +138,6 @@ static struct adm9240_data *adm9240_upda
 /* driver data */
 static struct i2c_driver adm9240_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "adm9240",
 	},
 	.id		= I2C_DRIVERID_ADM9240,
diff --git a/drivers/hwmon/asb100.c b/drivers/hwmon/asb100.c
index 3068de0..ae9de63 100644
--- a/drivers/hwmon/asb100.c
+++ b/drivers/hwmon/asb100.c
@@ -218,7 +218,6 @@ static void asb100_init_client(struct i2
 
 static struct i2c_driver asb100_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "asb100",
 	},
 	.id		= I2C_DRIVERID_ASB100,
diff --git a/drivers/hwmon/atxp1.c b/drivers/hwmon/atxp1.c
index ed152d9..b0c4900 100644
--- a/drivers/hwmon/atxp1.c
+++ b/drivers/hwmon/atxp1.c
@@ -51,7 +51,6 @@ static int atxp1_detect(struct i2c_adapt
 
 static struct i2c_driver atxp1_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "atxp1",
 	},
 	.attach_adapter = atxp1_attach_adapter,
diff --git a/drivers/hwmon/ds1621.c b/drivers/hwmon/ds1621.c
index 8600940..203f9c7 100644
--- a/drivers/hwmon/ds1621.c
+++ b/drivers/hwmon/ds1621.c
@@ -90,7 +90,6 @@ static struct ds1621_data *ds1621_update
 /* This is the driver that will be inserted */
 static struct i2c_driver ds1621_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "ds1621",
 	},
 	.id		= I2C_DRIVERID_DS1621,
diff --git a/drivers/hwmon/fscher.c b/drivers/hwmon/fscher.c
index 982fff4..2540918 100644
--- a/drivers/hwmon/fscher.c
+++ b/drivers/hwmon/fscher.c
@@ -119,7 +119,6 @@ static int fscher_write_value(struct i2c
  
 static struct i2c_driver fscher_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "fscher",
 	},
 	.id		= I2C_DRIVERID_FSCHER,
diff --git a/drivers/hwmon/fscpos.c b/drivers/hwmon/fscpos.c
index 971146b..6d0146b 100644
--- a/drivers/hwmon/fscpos.c
+++ b/drivers/hwmon/fscpos.c
@@ -101,7 +101,6 @@ static void reset_fan_alarm(struct i2c_c
  */
 static struct i2c_driver fscpos_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "fscpos",
 	},
 	.id		= I2C_DRIVERID_FSCPOS,
diff --git a/drivers/hwmon/gl518sm.c b/drivers/hwmon/gl518sm.c
index 9c5ca1f..9e685e3 100644
--- a/drivers/hwmon/gl518sm.c
+++ b/drivers/hwmon/gl518sm.c
@@ -152,7 +152,6 @@ static struct gl518_data *gl518_update_d
 /* This is the driver that will be inserted */
 static struct i2c_driver gl518_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "gl518sm",
 	},
 	.id		= I2C_DRIVERID_GL518,
diff --git a/drivers/hwmon/gl520sm.c b/drivers/hwmon/gl520sm.c
index a9a724a..baee60e 100644
--- a/drivers/hwmon/gl520sm.c
+++ b/drivers/hwmon/gl520sm.c
@@ -110,7 +110,6 @@ static struct gl520_data *gl520_update_d
 /* Driver data */
 static struct i2c_driver gl520_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "gl520sm",
 	},
 	.id		= I2C_DRIVERID_GL520,
diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index 24d520b..29b74a8 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -235,7 +235,6 @@ static void it87_init_client(struct i2c_
 
 static struct i2c_driver it87_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "it87",
 	},
 	.id		= I2C_DRIVERID_IT87,
@@ -245,7 +244,6 @@ static struct i2c_driver it87_driver = {
 
 static struct i2c_driver it87_isa_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "it87-isa",
 	},
 	.attach_adapter	= it87_isa_attach_adapter,
diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
index 35baae7..6b1aa7e 100644
--- a/drivers/hwmon/lm63.c
+++ b/drivers/hwmon/lm63.c
@@ -140,7 +140,6 @@ static void lm63_init_client(struct i2c_
 
 static struct i2c_driver lm63_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "lm63",
 	},
 	.attach_adapter	= lm63_attach_adapter,
diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index db35fbf..74ca2c8 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -67,7 +67,6 @@ static struct lm75_data *lm75_update_dev
 /* This is the driver that will be inserted */
 static struct i2c_driver lm75_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "lm75",
 	},
 	.id		= I2C_DRIVERID_LM75,
diff --git a/drivers/hwmon/lm77.c b/drivers/hwmon/lm77.c
index 1770720..a2f420d 100644
--- a/drivers/hwmon/lm77.c
+++ b/drivers/hwmon/lm77.c
@@ -75,7 +75,6 @@ static struct lm77_data *lm77_update_dev
 /* This is the driver that will be inserted */
 static struct i2c_driver lm77_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "lm77",
 	},
 	.attach_adapter = lm77_attach_adapter,
diff --git a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
index 3af5b06..e404001 100644
--- a/drivers/hwmon/lm78.c
+++ b/drivers/hwmon/lm78.c
@@ -165,7 +165,6 @@ static void lm78_init_client(struct i2c_
 
 static struct i2c_driver lm78_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "lm78",
 	},
 	.id		= I2C_DRIVERID_LM78,
@@ -175,7 +174,6 @@ static struct i2c_driver lm78_driver = {
 
 static struct i2c_driver lm78_isa_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "lm78-isa",
 	},
 	.attach_adapter	= lm78_isa_attach_adapter,
diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
index 1dc118f..c9a7cde 100644
--- a/drivers/hwmon/lm80.c
+++ b/drivers/hwmon/lm80.c
@@ -144,7 +144,6 @@ static int lm80_write_value(struct i2c_c
 
 static struct i2c_driver lm80_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "lm80",
 	},
 	.id		= I2C_DRIVERID_LM80,
diff --git a/drivers/hwmon/lm83.c b/drivers/hwmon/lm83.c
index 1c1744f..26dfa9e 100644
--- a/drivers/hwmon/lm83.c
+++ b/drivers/hwmon/lm83.c
@@ -125,7 +125,6 @@ static struct lm83_data *lm83_update_dev
  
 static struct i2c_driver lm83_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "lm83",
 	},
 	.id		= I2C_DRIVERID_LM83,
diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
index b537c18..7389a01 100644
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -381,7 +381,6 @@ static void lm85_init_client(struct i2c_
 
 static struct i2c_driver lm85_driver = {
 	.driver = {
-		.owner  = THIS_MODULE,
 		.name   = "lm85",
 	},
 	.id             = I2C_DRIVERID_LM85,
diff --git a/drivers/hwmon/lm87.c b/drivers/hwmon/lm87.c
index 3152c00..6ba34c3 100644
--- a/drivers/hwmon/lm87.c
+++ b/drivers/hwmon/lm87.c
@@ -162,7 +162,6 @@ static struct lm87_data *lm87_update_dev
 
 static struct i2c_driver lm87_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "lm87",
 	},
 	.id		= I2C_DRIVERID_LM87,
diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index ff7ba1e..5679464 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -187,7 +187,6 @@ static struct lm90_data *lm90_update_dev
 
 static struct i2c_driver lm90_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "lm90",
 	},
 	.id		= I2C_DRIVERID_LM90,
diff --git a/drivers/hwmon/lm92.c b/drivers/hwmon/lm92.c
index b4e4a84..b0c4cb7 100644
--- a/drivers/hwmon/lm92.c
+++ b/drivers/hwmon/lm92.c
@@ -411,7 +411,6 @@ static int lm92_detach_client(struct i2c
 
 static struct i2c_driver lm92_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "lm92",
 	},
 	.id		= I2C_DRIVERID_LM92,
diff --git a/drivers/hwmon/max1619.c b/drivers/hwmon/max1619.c
index 1a50b13..3abe330 100644
--- a/drivers/hwmon/max1619.c
+++ b/drivers/hwmon/max1619.c
@@ -91,7 +91,6 @@ static struct max1619_data *max1619_upda
 
 static struct i2c_driver max1619_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "max1619",
 	},
 	.attach_adapter	= max1619_attach_adapter,
diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
index 5469489..f161e88 100644
--- a/drivers/hwmon/pc87360.c
+++ b/drivers/hwmon/pc87360.c
@@ -237,7 +237,6 @@ static struct pc87360_data *pc87360_upda
 
 static struct i2c_driver pc87360_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "pc87360",
 	},
 	.attach_adapter	= pc87360_detect,
diff --git a/drivers/hwmon/sis5595.c b/drivers/hwmon/sis5595.c
index 9f44b93..8be5189 100644
--- a/drivers/hwmon/sis5595.c
+++ b/drivers/hwmon/sis5595.c
@@ -199,7 +199,6 @@ static void sis5595_init_client(struct i
 
 static struct i2c_driver sis5595_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "sis5595",
 	},
 	.attach_adapter	= sis5595_detect,
diff --git a/drivers/hwmon/smsc47b397.c b/drivers/hwmon/smsc47b397.c
index 02e5d55..8663bbb 100644
--- a/drivers/hwmon/smsc47b397.c
+++ b/drivers/hwmon/smsc47b397.c
@@ -227,7 +227,6 @@ static int smsc47b397_detect(struct i2c_
 
 static struct i2c_driver smsc47b397_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "smsc47b397",
 	},
 	.attach_adapter	= smsc47b397_detect,
diff --git a/drivers/hwmon/smsc47m1.c b/drivers/hwmon/smsc47m1.c
index b3051ad..d1e3ec0 100644
--- a/drivers/hwmon/smsc47m1.c
+++ b/drivers/hwmon/smsc47m1.c
@@ -127,7 +127,6 @@ static struct smsc47m1_data *smsc47m1_up
 
 static struct i2c_driver smsc47m1_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "smsc47m1",
 	},
 	.attach_adapter	= smsc47m1_detect,
diff --git a/drivers/hwmon/via686a.c b/drivers/hwmon/via686a.c
index db75fbc..cb01848 100644
--- a/drivers/hwmon/via686a.c
+++ b/drivers/hwmon/via686a.c
@@ -573,7 +573,6 @@ static DEVICE_ATTR(alarms, S_IRUGO, show
    smbus_driver and isa_driver, and clients could be of either kind */
 static struct i2c_driver via686a_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "via686a",
 	},
 	.attach_adapter	= via686a_detect,
diff --git a/drivers/hwmon/vt8231.c b/drivers/hwmon/vt8231.c
index c2eb54b..d00a726 100644
--- a/drivers/hwmon/vt8231.c
+++ b/drivers/hwmon/vt8231.c
@@ -586,7 +586,6 @@ static DEVICE_ATTR(alarms, S_IRUGO, show
 
 static struct i2c_driver vt8231_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "vt8231",
 	},
 	.attach_adapter	= vt8231_detect,
diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index 94538fb..12d79f5 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -786,7 +786,6 @@ static int w83627ehf_detach_client(struc
 
 static struct i2c_driver w83627ehf_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "w83627ehf",
 	},
 	.attach_adapter	= w83627ehf_detect,
diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
index 2ffb84f..7ea441d 100644
--- a/drivers/hwmon/w83627hf.c
+++ b/drivers/hwmon/w83627hf.c
@@ -333,7 +333,6 @@ static void w83627hf_init_client(struct 
 
 static struct i2c_driver w83627hf_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "w83627hf",
 	},
 	.attach_adapter	= w83627hf_detect,
diff --git a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
index fd1a59c..5571148 100644
--- a/drivers/hwmon/w83781d.c
+++ b/drivers/hwmon/w83781d.c
@@ -270,7 +270,6 @@ static void w83781d_init_client(struct i
 
 static struct i2c_driver w83781d_driver = {
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = "w83781d",
 	},
 	.id = I2C_DRIVERID_W83781D,
@@ -280,7 +279,6 @@ static struct i2c_driver w83781d_driver 
 
 static struct i2c_driver w83781d_isa_driver = {
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = "w83781d-isa",
 	},
 	.attach_adapter = w83781d_isa_attach_adapter,
diff --git a/drivers/hwmon/w83792d.c b/drivers/hwmon/w83792d.c
index 9018445..ff1c9f0 100644
--- a/drivers/hwmon/w83792d.c
+++ b/drivers/hwmon/w83792d.c
@@ -318,7 +318,6 @@ static void w83792d_init_client(struct i
 
 static struct i2c_driver w83792d_driver = {
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = "w83792d",
 	},
 	.attach_adapter = w83792d_attach_adapter,
diff --git a/drivers/hwmon/w83l785ts.c b/drivers/hwmon/w83l785ts.c
index fc9f202..f66c0cf 100644
--- a/drivers/hwmon/w83l785ts.c
+++ b/drivers/hwmon/w83l785ts.c
@@ -93,7 +93,6 @@ static struct w83l785ts_data *w83l785ts_
  
 static struct i2c_driver w83l785ts_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "w83l785ts",
 	},
 	.id		= I2C_DRIVERID_W83L785TS,
diff --git a/drivers/i2c/chips/ds1337.c b/drivers/i2c/chips/ds1337.c
index a9d4ac7..93d483b 100644
--- a/drivers/i2c/chips/ds1337.c
+++ b/drivers/i2c/chips/ds1337.c
@@ -53,7 +53,6 @@ static int ds1337_command(struct i2c_cli
  */
 static struct i2c_driver ds1337_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "ds1337",
 	},
 	.attach_adapter	= ds1337_attach_adapter,
diff --git a/drivers/i2c/chips/ds1374.c b/drivers/i2c/chips/ds1374.c
index 3e3ebd8..0710b9d 100644
--- a/drivers/i2c/chips/ds1374.c
+++ b/drivers/i2c/chips/ds1374.c
@@ -233,7 +233,6 @@ static int ds1374_detach(struct i2c_clie
 
 static struct i2c_driver ds1374_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= DS1374_DRV_NAME,
 	},
 	.id = I2C_DRIVERID_DS1374,
diff --git a/drivers/i2c/chips/eeprom.c b/drivers/i2c/chips/eeprom.c
index d0c9f29..41116b7 100644
--- a/drivers/i2c/chips/eeprom.c
+++ b/drivers/i2c/chips/eeprom.c
@@ -69,7 +69,6 @@ static int eeprom_detach_client(struct i
 /* This is the driver that will be inserted */
 static struct i2c_driver eeprom_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "eeprom",
 	},
 	.id		= I2C_DRIVERID_EEPROM,
diff --git a/drivers/i2c/chips/isp1301_omap.c b/drivers/i2c/chips/isp1301_omap.c
index 9f1ec03..1251c7f 100644
--- a/drivers/i2c/chips/isp1301_omap.c
+++ b/drivers/i2c/chips/isp1301_omap.c
@@ -1633,7 +1633,6 @@ static int isp1301_scan_bus(struct i2c_a
 
 static struct i2c_driver isp1301_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "isp1301_omap",
 	},
 	.id		= 1301,		/* FIXME "official", i2c-ids.h */
diff --git a/drivers/i2c/chips/m41t00.c b/drivers/i2c/chips/m41t00.c
index 92759b2..2dc3d48 100644
--- a/drivers/i2c/chips/m41t00.c
+++ b/drivers/i2c/chips/m41t00.c
@@ -212,7 +212,6 @@ m41t00_detach(struct i2c_client *client)
 
 static struct i2c_driver m41t00_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= M41T00_DRV_NAME,
 	},
 	.id		= I2C_DRIVERID_STM41T00,
diff --git a/drivers/i2c/chips/max6875.c b/drivers/i2c/chips/max6875.c
index 3705117..6d3ff58 100644
--- a/drivers/i2c/chips/max6875.c
+++ b/drivers/i2c/chips/max6875.c
@@ -68,7 +68,6 @@ static int max6875_detach_client(struct 
 /* This is the driver that will be inserted */
 static struct i2c_driver max6875_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "max6875",
 	},
 	.attach_adapter	= max6875_attach_adapter,
diff --git a/drivers/i2c/chips/pca9539.c b/drivers/i2c/chips/pca9539.c
index bb57faa..54b6e6a 100644
--- a/drivers/i2c/chips/pca9539.c
+++ b/drivers/i2c/chips/pca9539.c
@@ -39,7 +39,6 @@ static int pca9539_detach_client(struct 
 /* This is the driver that will be inserted */
 static struct i2c_driver pca9539_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "pca9539",
 	},
 	.attach_adapter	= pca9539_attach_adapter,
diff --git a/drivers/i2c/chips/pcf8574.c b/drivers/i2c/chips/pcf8574.c
index 3d4d4d6..c3e6449 100644
--- a/drivers/i2c/chips/pcf8574.c
+++ b/drivers/i2c/chips/pcf8574.c
@@ -66,7 +66,6 @@ static void pcf8574_init_client(struct i
 /* This is the driver that will be inserted */
 static struct i2c_driver pcf8574_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "pcf8574",
 	},
 	.id		= I2C_DRIVERID_PCF8574,
diff --git a/drivers/i2c/chips/pcf8591.c b/drivers/i2c/chips/pcf8591.c
index 8f41bb3..36cff09 100644
--- a/drivers/i2c/chips/pcf8591.c
+++ b/drivers/i2c/chips/pcf8591.c
@@ -89,7 +89,6 @@ static int pcf8591_read_channel(struct d
 /* This is the driver that will be inserted */
 static struct i2c_driver pcf8591_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "pcf8591",
 	},
 	.id		= I2C_DRIVERID_PCF8591,
diff --git a/drivers/i2c/chips/rtc8564.c b/drivers/i2c/chips/rtc8564.c
index 6f567e2..ceaa6b0 100644
--- a/drivers/i2c/chips/rtc8564.c
+++ b/drivers/i2c/chips/rtc8564.c
@@ -359,7 +359,6 @@ rtc8564_command(struct i2c_client *clien
 
 static struct i2c_driver rtc8564_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "RTC8564",
 	},
 	.id		= I2C_DRIVERID_RTC8564,
diff --git a/drivers/i2c/chips/tps65010.c b/drivers/i2c/chips/tps65010.c
index 92947a6..e70b3db 100644
--- a/drivers/i2c/chips/tps65010.c
+++ b/drivers/i2c/chips/tps65010.c
@@ -638,7 +638,6 @@ static int __init tps65010_scan_bus(stru
 
 static struct i2c_driver tps65010_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "tps65010",
 	},
 	.attach_adapter	= tps65010_scan_bus,
diff --git a/drivers/i2c/chips/x1205.c b/drivers/i2c/chips/x1205.c
index 6880eab..245fffa 100644
--- a/drivers/i2c/chips/x1205.c
+++ b/drivers/i2c/chips/x1205.c
@@ -106,7 +106,6 @@ static int x1205_command(struct i2c_clie
 
 static struct i2c_driver x1205_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "x1205",
 	},
 	.attach_adapter = &x1205_attach,
diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 9715217..e140dd7 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -482,7 +482,6 @@ static int i2cdev_command(struct i2c_cli
 
 static struct i2c_driver i2cdev_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "dev_driver",
 	},
 	.id		= I2C_DRIVERID_I2CDEV,
diff --git a/drivers/macintosh/therm_adt746x.c b/drivers/macintosh/therm_adt746x.c
index 8bb1d85..02a3117 100644
--- a/drivers/macintosh/therm_adt746x.c
+++ b/drivers/macintosh/therm_adt746x.c
@@ -172,7 +172,6 @@ detach_thermostat(struct i2c_adapter *ad
 
 static struct i2c_driver thermostat_driver = {  
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "therm_adt746x",
 	},
 	.attach_adapter	= attach_thermostat,
diff --git a/drivers/macintosh/therm_pm72.c b/drivers/macintosh/therm_pm72.c
index 97807be..cf72b78 100644
--- a/drivers/macintosh/therm_pm72.c
+++ b/drivers/macintosh/therm_pm72.c
@@ -284,7 +284,6 @@ static int therm_pm72_detach(struct i2c_
 static struct i2c_driver therm_pm72_driver  {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "therm_pm72",
 	},
 	.attach_adapter	= therm_pm72_attach,
diff --git a/drivers/macintosh/therm_windtunnel.c b/drivers/macintosh/therm_windtunnel.c
index 259f19d..3d9dd2e 100644
--- a/drivers/macintosh/therm_windtunnel.c
+++ b/drivers/macintosh/therm_windtunnel.c
@@ -355,7 +355,6 @@ do_detach( struct i2c_client *client )
 
 static struct i2c_driver g4fan_driver = {  
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "therm_windtunnel",
 	},
 	.id		= I2C_DRIVERID_G4FAN,
diff --git a/drivers/macintosh/windfarm_lm75_sensor.c b/drivers/macintosh/windfarm_lm75_sensor.c
index 555d0e4..fd16642 100644
--- a/drivers/macintosh/windfarm_lm75_sensor.c
+++ b/drivers/macintosh/windfarm_lm75_sensor.c
@@ -48,7 +48,6 @@ static int wf_lm75_detach(struct i2c_cli
 
 static struct i2c_driver wf_lm75_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "wf_lm75",
 	},
 	.attach_adapter	= wf_lm75_attach,
diff --git a/drivers/media/video/adv7170.c b/drivers/media/video/adv7170.c
index c5f1c6b..e61003d 100644
--- a/drivers/media/video/adv7170.c
+++ b/drivers/media/video/adv7170.c
@@ -498,7 +498,6 @@ adv7170_detach_client (struct i2c_client
 
 static struct i2c_driver i2c_driver_adv7170 = {
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = "adv7170",	/* name */
 	},
 
diff --git a/drivers/media/video/adv7175.c b/drivers/media/video/adv7175.c
index 33158aa..6d9536a 100644
--- a/drivers/media/video/adv7175.c
+++ b/drivers/media/video/adv7175.c
@@ -548,7 +548,6 @@ adv7175_detach_client (struct i2c_client
 
 static struct i2c_driver i2c_driver_adv7175 = {
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = "adv7175",	/* name */
 	},
 
diff --git a/drivers/media/video/bt819.c b/drivers/media/video/bt819.c
index 5868bbb..560b998 100644
--- a/drivers/media/video/bt819.c
+++ b/drivers/media/video/bt819.c
@@ -623,7 +623,6 @@ bt819_detach_client (struct i2c_client *
 
 static struct i2c_driver i2c_driver_bt819 = {
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = "bt819",
 	},
 
diff --git a/drivers/media/video/bt832.c b/drivers/media/video/bt832.c
index 347eb71..1c3ff5f 100644
--- a/drivers/media/video/bt832.c
+++ b/drivers/media/video/bt832.c
@@ -231,7 +231,6 @@ bt832_command(struct i2c_client *client,
 
 static struct i2c_driver driver = {
 	.driver = {
-		.owner  = THIS_MODULE,
 		.name   = "i2c bt832 driver",
 	},
 	.id             = -1, /* FIXME */
diff --git a/drivers/media/video/bt856.c b/drivers/media/video/bt856.c
index 207525a..6050806 100644
--- a/drivers/media/video/bt856.c
+++ b/drivers/media/video/bt856.c
@@ -405,7 +405,6 @@ bt856_detach_client (struct i2c_client *
 
 static struct i2c_driver i2c_driver_bt856 = {
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = "bt856",
 	},
 
diff --git a/drivers/media/video/cs53l32a.c b/drivers/media/video/cs53l32a.c
index 60484f9..643ead1 100644
--- a/drivers/media/video/cs53l32a.c
+++ b/drivers/media/video/cs53l32a.c
@@ -217,7 +217,6 @@ static int cs53l32a_detach(struct i2c_cl
 /* i2c implementation */
 static struct i2c_driver i2c_driver = {
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = "cs53l32a",
 	},
 	.id = I2C_DRIVERID_CS53L32A,
diff --git a/drivers/media/video/cx25840/cx25840-core.c b/drivers/media/video/cx25840/cx25840-core.c
index 830d519..3b09f46 100644
--- a/drivers/media/video/cx25840/cx25840-core.c
+++ b/drivers/media/video/cx25840/cx25840-core.c
@@ -844,7 +844,6 @@ static int cx25840_detach_client(struct 
 
 static struct i2c_driver i2c_driver_cx25840 = {
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = "cx25840",
 	},
 
diff --git a/drivers/media/video/indycam.c b/drivers/media/video/indycam.c
index 96a808e..bb5cbec 100644
--- a/drivers/media/video/indycam.c
+++ b/drivers/media/video/indycam.c
@@ -452,7 +452,6 @@ static int indycam_command(struct i2c_cl
 
 static struct i2c_driver i2c_driver_indycam = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name 	= "indycam",
 	},
 	.id		= I2C_DRIVERID_INDYCAM,
diff --git a/drivers/media/video/ir-kbd-i2c.c b/drivers/media/video/ir-kbd-i2c.c
index 82c7f50..3cc1d6a 100644
--- a/drivers/media/video/ir-kbd-i2c.c
+++ b/drivers/media/video/ir-kbd-i2c.c
@@ -279,7 +279,6 @@ static int ir_probe(struct i2c_adapter *
 
 static struct i2c_driver driver = {
 	.driver = {
-		.owner  = THIS_MODULE,
 		.name   = "ir remote kbd driver",
 	},
 	.id             = I2C_DRIVERID_INFRARED,
diff --git a/drivers/media/video/msp3400.c b/drivers/media/video/msp3400.c
index 3847d89..183253e 100644
--- a/drivers/media/video/msp3400.c
+++ b/drivers/media/video/msp3400.c
@@ -1569,7 +1569,6 @@ static struct i2c_driver driver = {
 	.detach_client  = msp_detach,
 	.command        = msp_command,
 	.driver = {
-		.owner   = THIS_MODULE,
 		.name    = "i2c msp3400 driver",
 		.suspend = msp_suspend,
 		.resume  = msp_resume,
diff --git a/drivers/media/video/ovcamchip/ovcamchip_core.c b/drivers/media/video/ovcamchip/ovcamchip_core.c
index 9ac398b..428f1bb 100644
--- a/drivers/media/video/ovcamchip/ovcamchip_core.c
+++ b/drivers/media/video/ovcamchip/ovcamchip_core.c
@@ -411,7 +411,6 @@ static int ovcamchip_command(struct i2c_
 
 static struct i2c_driver driver = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"ovcamchip",
 	},
 	.id =			I2C_DRIVERID_OVCAMCHIP,
diff --git a/drivers/media/video/saa5246a.c b/drivers/media/video/saa5246a.c
index 8c99edb..135c214 100644
--- a/drivers/media/video/saa5246a.c
+++ b/drivers/media/video/saa5246a.c
@@ -164,7 +164,6 @@ static int saa5246a_command(struct i2c_c
 static struct i2c_driver i2c_driver_videotext  {
 	.driver = {
-		.owner 	= THIS_MODULE,
 		.name 	= IF_NAME,		/* name */
 	},
 	.id 		= I2C_DRIVERID_SAA5249, /* in i2c.h */
diff --git a/drivers/media/video/saa5249.c b/drivers/media/video/saa5249.c
index 5b346bd..d7c4e33 100644
--- a/drivers/media/video/saa5249.c
+++ b/drivers/media/video/saa5249.c
@@ -237,7 +237,6 @@ static int saa5249_command(struct i2c_cl
 static struct i2c_driver i2c_driver_videotext = 
 {
 	.driver = {
-		.owner 	= THIS_MODULE,
 		.name 	= IF_NAME,		/* name */
 	},
 	.id 		= I2C_DRIVERID_SAA5249, /* in i2c.h */
diff --git a/drivers/media/video/saa6588.c b/drivers/media/video/saa6588.c
index 5ea36ee..d60a783 100644
--- a/drivers/media/video/saa6588.c
+++ b/drivers/media/video/saa6588.c
@@ -496,7 +496,6 @@ static int saa6588_command(struct i2c_cl
 
 static struct i2c_driver driver = {
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = "i2c saa6588 driver",
 	},
 	.id = -1,		/* FIXME */
diff --git a/drivers/media/video/saa7110.c b/drivers/media/video/saa7110.c
index 58f60ba..619ff0b 100644
--- a/drivers/media/video/saa7110.c
+++ b/drivers/media/video/saa7110.c
@@ -587,7 +587,6 @@ saa7110_detach_client (struct i2c_client
 
 static struct i2c_driver i2c_driver_saa7110 = {
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = "saa7110",
 	},
 
diff --git a/drivers/media/video/saa7111.c b/drivers/media/video/saa7111.c
index 946eb74..acaeee5 100644
--- a/drivers/media/video/saa7111.c
+++ b/drivers/media/video/saa7111.c
@@ -590,7 +590,6 @@ saa7111_detach_client (struct i2c_client
 
 static struct i2c_driver i2c_driver_saa7111 = {
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = "saa7111",
 	},
 
diff --git a/drivers/media/video/saa7114.c b/drivers/media/video/saa7114.c
index df53b58..b7ac012 100644
--- a/drivers/media/video/saa7114.c
+++ b/drivers/media/video/saa7114.c
@@ -1204,7 +1204,6 @@ saa7114_detach_client (struct i2c_client
 
 static struct i2c_driver i2c_driver_saa7114 = {
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = "saa7114",
 	},
 
diff --git a/drivers/media/video/saa7115.c b/drivers/media/video/saa7115.c
index 6ac1ab4..29e28c7 100644
--- a/drivers/media/video/saa7115.c
+++ b/drivers/media/video/saa7115.c
@@ -1355,7 +1355,6 @@ static int saa7115_detach(struct i2c_cli
 /* i2c implementation */
 static struct i2c_driver i2c_driver_saa7115 = {
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = "saa7115",
 	},
 	.id = I2C_DRIVERID_SAA711X,
diff --git a/drivers/media/video/saa711x.c b/drivers/media/video/saa711x.c
index 3f7cfb7..8008537 100644
--- a/drivers/media/video/saa711x.c
+++ b/drivers/media/video/saa711x.c
@@ -565,7 +565,6 @@ saa711x_detach_client (struct i2c_client
 
 static struct i2c_driver i2c_driver_saa711x = {
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = "saa711x",
 	},
 
diff --git a/drivers/media/video/saa7127.c b/drivers/media/video/saa7127.c
index 659cb8a..bca6ed0 100644
--- a/drivers/media/video/saa7127.c
+++ b/drivers/media/video/saa7127.c
@@ -821,7 +821,6 @@ static int saa7127_detach(struct i2c_cli
 
 static struct i2c_driver i2c_driver_saa7127 = {
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = "saa7127",
 	},
 	.id = I2C_DRIVERID_SAA7127,
diff --git a/drivers/media/video/saa7134/saa6752hs.c b/drivers/media/video/saa7134/saa6752hs.c
index 0e8c9ed..4615a98 100644
--- a/drivers/media/video/saa7134/saa6752hs.c
+++ b/drivers/media/video/saa7134/saa6752hs.c
@@ -598,7 +598,6 @@ saa6752hs_command(struct i2c_client *cli
 
 static struct i2c_driver driver = {
 	.driver = {
-		.owner  = THIS_MODULE,
 		.name   = "i2c saa6752hs MPEG encoder",
 	},
 	.id             = I2C_DRIVERID_SAA6752HS,
diff --git a/drivers/media/video/saa7185.c b/drivers/media/video/saa7185.c
index 64047d7..f72a9f7 100644
--- a/drivers/media/video/saa7185.c
+++ b/drivers/media/video/saa7185.c
@@ -487,7 +487,6 @@ saa7185_detach_client (struct i2c_client
 
 static struct i2c_driver i2c_driver_saa7185 = {
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = "saa7185",	/* name */
 	},
 
diff --git a/drivers/media/video/saa7191.c b/drivers/media/video/saa7191.c
index a0f8eaf..41f6f05 100644
--- a/drivers/media/video/saa7191.c
+++ b/drivers/media/video/saa7191.c
@@ -789,7 +789,6 @@ static int saa7191_command(struct i2c_cl
 
 static struct i2c_driver i2c_driver_saa7191 = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name 	= "saa7191",
 	},
 	.id		= I2C_DRIVERID_SAA7191,
diff --git a/drivers/media/video/tda7432.c b/drivers/media/video/tda7432.c
index 59674d9..549c992 100644
--- a/drivers/media/video/tda7432.c
+++ b/drivers/media/video/tda7432.c
@@ -502,7 +502,6 @@ static int tda7432_command(struct i2c_cl
 
 static struct i2c_driver driver = {
 	.driver = {
-		.owner   = THIS_MODULE,
 		.name    = "i2c tda7432 driver",
 	},
 	.id              = I2C_DRIVERID_TDA7432,
diff --git a/drivers/media/video/tda9840.c b/drivers/media/video/tda9840.c
index 8efc726..2a353d2 100644
--- a/drivers/media/video/tda9840.c
+++ b/drivers/media/video/tda9840.c
@@ -222,7 +222,6 @@ static int detach(struct i2c_client *cli
 
 static struct i2c_driver driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "tda9840",
 	},
 	.id	= I2C_DRIVERID_TDA9840,
diff --git a/drivers/media/video/tda9875.c b/drivers/media/video/tda9875.c
index de89616..9c3ecf7 100644
--- a/drivers/media/video/tda9875.c
+++ b/drivers/media/video/tda9875.c
@@ -373,7 +373,6 @@ static int tda9875_command(struct i2c_cl
 
 static struct i2c_driver driver = {
 	.driver = {
-		.owner  = THIS_MODULE,
 		.name   = "i2c tda9875 driver",
 	},
 	.id             = I2C_DRIVERID_TDA9875,
diff --git a/drivers/media/video/tda9887.c b/drivers/media/video/tda9887.c
index 081f478..7165a1b 100644
--- a/drivers/media/video/tda9887.c
+++ b/drivers/media/video/tda9887.c
@@ -824,7 +824,6 @@ static struct i2c_driver driver = {
 	.detach_client  = tda9887_detach,
 	.command        = tda9887_command,
 	.driver = {
-		.owner   = THIS_MODULE,
 		.name    = "i2c tda9887 driver",
 		.suspend = tda9887_suspend,
 		.resume  = tda9887_resume,
diff --git a/drivers/media/video/tea6415c.c b/drivers/media/video/tea6415c.c
index e7e2213..17046d9 100644
--- a/drivers/media/video/tea6415c.c
+++ b/drivers/media/video/tea6415c.c
@@ -191,7 +191,6 @@ static int command(struct i2c_client *cl
 
 static struct i2c_driver driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name 	= "tea6415c",
 	},
 	.id 	= I2C_DRIVERID_TEA6415C,
diff --git a/drivers/media/video/tea6420.c b/drivers/media/video/tea6420.c
index 74cc25f..3dc89d9 100644
--- a/drivers/media/video/tea6420.c
+++ b/drivers/media/video/tea6420.c
@@ -168,7 +168,6 @@ static int command(struct i2c_client *cl
 
 static struct i2c_driver driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "tea6420",
 	},
 	.id	= I2C_DRIVERID_TEA6420,
diff --git a/drivers/media/video/tuner-3036.c b/drivers/media/video/tuner-3036.c
index 83257af..d97f668 100644
--- a/drivers/media/video/tuner-3036.c
+++ b/drivers/media/video/tuner-3036.c
@@ -176,7 +176,6 @@ static struct i2c_driver 
 i2c_driver_tuner = 
 {
 	.driver = {
-		.owner	=	THIS_MODULE,
 		.name	=	"sab3036",
 	},
 	.id		=	I2C_DRIVERID_SAB3036,
diff --git a/drivers/media/video/tuner-core.c b/drivers/media/video/tuner-core.c
index e8c8549..c13c7b9 100644
--- a/drivers/media/video/tuner-core.c
+++ b/drivers/media/video/tuner-core.c
@@ -747,7 +747,6 @@ static struct i2c_driver driver = {
 	.detach_client = tuner_detach,
 	.command = tuner_command,
 	.driver = {
-		   .owner = THIS_MODULE,
 		   .name = "tuner",
 		   .suspend = tuner_suspend,
 		   .resume = tuner_resume,
diff --git a/drivers/media/video/tvaudio.c b/drivers/media/video/tvaudio.c
index 30bb2a3..0292c5a 100644
--- a/drivers/media/video/tvaudio.c
+++ b/drivers/media/video/tvaudio.c
@@ -1703,7 +1703,6 @@ static int chip_command(struct i2c_clien
 
 static struct i2c_driver driver = {
 	.driver = {
-		.owner   = THIS_MODULE,
 		.name    = "generic i2c audio driver",
 	},
 	.id              = I2C_DRIVERID_TVAUDIO,
diff --git a/drivers/media/video/tveeprom.c b/drivers/media/video/tveeprom.c
index d8b5a17..8ac4cb8 100644
--- a/drivers/media/video/tveeprom.c
+++ b/drivers/media/video/tveeprom.c
@@ -779,7 +779,6 @@ tveeprom_detach_client (struct i2c_clien
 
 static struct i2c_driver i2c_driver_tveeprom = {
 	.driver = {
-		.owner  = THIS_MODULE,
 		.name   = "tveeprom",
 	},
 	.id             = I2C_DRIVERID_TVEEPROM,
diff --git a/drivers/media/video/tvmixer.c b/drivers/media/video/tvmixer.c
index 5f4d018..e837f9f 100644
--- a/drivers/media/video/tvmixer.c
+++ b/drivers/media/video/tvmixer.c
@@ -229,7 +229,6 @@ static int tvmixer_release(struct inode 
 static struct i2c_driver driver = {
 #ifdef I2C_PEC
 	.driver = {
-		.owner   = THIS_MODULE,
 		.name    = "tv card mixer driver",
 	},
 #else
diff --git a/drivers/media/video/tvp5150.c b/drivers/media/video/tvp5150.c
index 5eca71f..a60442e 100644
--- a/drivers/media/video/tvp5150.c
+++ b/drivers/media/video/tvp5150.c
@@ -801,7 +801,6 @@ static int tvp5150_detach_client(struct 
 
 static struct i2c_driver driver = {
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = "tvp5150",
 	},
 
diff --git a/drivers/media/video/vpx3220.c b/drivers/media/video/vpx3220.c
index b85b598..8dcee8b 100644
--- a/drivers/media/video/vpx3220.c
+++ b/drivers/media/video/vpx3220.c
@@ -722,7 +722,6 @@ vpx3220_attach_adapter (struct i2c_adapt
 
 static struct i2c_driver vpx3220_i2c_driver = {
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = "vpx3220",
 	},
 
diff --git a/drivers/media/video/wm8775.c b/drivers/media/video/wm8775.c
index 22875f1..bbfd55c 100644
--- a/drivers/media/video/wm8775.c
+++ b/drivers/media/video/wm8775.c
@@ -233,7 +233,6 @@ static int wm8775_detach(struct i2c_clie
 /* i2c implementation */
 static struct i2c_driver i2c_driver = {
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = "wm8775",
 	},
 
diff --git a/drivers/video/matrox/matroxfb_maven.c b/drivers/video/matrox/matroxfb_maven.c
index f6fdb69..2558753 100644
--- a/drivers/video/matrox/matroxfb_maven.c
+++ b/drivers/video/matrox/matroxfb_maven.c
@@ -1294,7 +1294,6 @@ static int maven_command(struct i2c_clie
 
 static struct i2c_driver maven_driver={
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "maven",
 	},
 	.id		= I2C_DRIVERID_MGATVO,
diff --git a/sound/oss/dmasound/dac3550a.c b/sound/oss/dmasound/dac3550a.c
index 835e0cf..7360d89 100644
--- a/sound/oss/dmasound/dac3550a.c
+++ b/sound/oss/dmasound/dac3550a.c
@@ -42,7 +42,6 @@ static int daca_detach_client(struct i2c
 
 struct i2c_driver daca_driver = {  
 	.driver = {
-		.owner		= THIS_MODULE,
 		.name		= "DAC3550A driver  V " DACA_VERSION,
 	},
 	.id			= I2C_DRIVERID_DACA,
diff --git a/sound/oss/dmasound/tas_common.c b/sound/oss/dmasound/tas_common.c
index bd6910a..8131599 100644
--- a/sound/oss/dmasound/tas_common.c
+++ b/sound/oss/dmasound/tas_common.c
@@ -48,7 +48,6 @@ static int tas_detach_client(struct i2c_
 
 struct i2c_driver tas_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "tas",
 	},
 	.attach_adapter	= tas_attach_adapter,
diff --git a/sound/ppc/keywest.c b/sound/ppc/keywest.c
index d532924..6058c2d 100644
--- a/sound/ppc/keywest.c
+++ b/sound/ppc/keywest.c
@@ -42,7 +42,6 @@ static int keywest_detach_client(struct 
 
 struct i2c_driver keywest_driver = {  
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = "PMac Keywest Audio",
 	},
 	.id = I2C_DRIVERID_KEYWEST,


