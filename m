From: gregkh@suse.de (Greg KH)
Date: Fri, 06 Jan 2006 22:07:34 +0000
Subject: [lm-sensors] [PATCH] i2c: Drop i2c_driver.flags, 2 of 3
Message-Id: <1136585254121@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: Drop i2c_driver.flags, 2 of 3

Just about every i2c chip driver sets the I2C_DF_NOTIFY flag, so we
can simply make it the default and drop the flag. If any driver really
doesn't want to be notified when i2c adapters are added, that driver
can simply omit to set .attach_adapter. This approach is also more
robust as it prevents accidental NULL pointer dereferences.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
commit 8a9947552d43b0d20d5fa23ac0ba435d526be454
tree 086844a62f549e488ebeecc196e1d4726a1d4598
parent ff179c8cf5caa17bf3d407edbb5872aa2eee6900
author Jean Delvare <khali at linux-fr.org> Sat, 26 Nov 2005 20:28:06 +0100
committer Greg Kroah-Hartman <gregkh at suse.de> Thu, 05 Jan 2006 22:16:21 -0800

 Documentation/i2c/porting-clients              |    3 +++
 Documentation/i2c/writing-clients              |    5 -----
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
 drivers/hwmon/it87.c                           |    1 -
 drivers/hwmon/lm63.c                           |    1 -
 drivers/hwmon/lm75.c                           |    1 -
 drivers/hwmon/lm77.c                           |    1 -
 drivers/hwmon/lm78.c                           |    1 -
 drivers/hwmon/lm80.c                           |    1 -
 drivers/hwmon/lm83.c                           |    1 -
 drivers/hwmon/lm85.c                           |    1 -
 drivers/hwmon/lm87.c                           |    1 -
 drivers/hwmon/lm90.c                           |    1 -
 drivers/hwmon/lm92.c                           |    1 -
 drivers/hwmon/max1619.c                        |    1 -
 drivers/hwmon/w83781d.c                        |    1 -
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
 drivers/i2c/i2c-core.c                         |    4 ++--
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
 include/linux/i2c.h                            |    1 -
 sound/oss/dmasound/dac3550a.c                  |    1 -
 sound/oss/dmasound/tas_common.c                |    1 -
 sound/ppc/keywest.c                            |    1 -
 91 files changed, 5 insertions(+), 95 deletions(-)

diff --git a/Documentation/i2c/porting-clients b/Documentation/i2c/porting-clients
index 184fac2..64c610b 100644
--- a/Documentation/i2c/porting-clients
+++ b/Documentation/i2c/porting-clients
@@ -109,6 +109,9 @@ Technical changes:
   there is a MODULE_LICENSE() line, at the bottom of the file
   (after MODULE_AUTHOR() and MODULE_DESCRIPTION(), in this order).
 
+* [Driver] The flags field of the i2c_driver structure is gone.
+  I2C_DF_NOTIFY is now the default behavior.
+
 Coding policy:
 
 * [Copyright] Use (C), not (c), for copyright.
diff --git a/Documentation/i2c/writing-clients b/Documentation/i2c/writing-clients
index d19993c..59d2c16 100644
--- a/Documentation/i2c/writing-clients
+++ b/Documentation/i2c/writing-clients
@@ -27,7 +27,6 @@ address.
 static struct i2c_driver foo_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "Foo version 2.3 driver",
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= &foo_attach_adapter,
 	.detach_client	= &foo_detach_client,
 	.command	= &foo_command /* may be NULL */
@@ -36,10 +35,6 @@ static struct i2c_driver foo_driver = {
 The name field must match the driver name, including the case. It must not
 contain spaces, and may be up to 31 characters long.
 
-Don't worry about the flags field; just put I2C_DF_NOTIFY into it. This
-means that your driver will be notified when new adapters are found.
-This is almost always what you want.
-
 All other fields are for call-back functions which will be explained 
 below.
 
diff --git a/arch/arm/mach-pxa/akita-ioexp.c b/arch/arm/mach-pxa/akita-ioexp.c
index f6d73cc..440ebb3 100644
--- a/arch/arm/mach-pxa/akita-ioexp.c
+++ b/arch/arm/mach-pxa/akita-ioexp.c
@@ -127,7 +127,6 @@ static struct i2c_driver max7310_i2c_dri
 	.owner		= THIS_MODULE,
 	.name		= "akita-max7310",
 	.id		= I2C_DRIVERID_AKITAIOEXP,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= max7310_attach_adapter,
 	.detach_client	= max7310_detach_client,
 };
diff --git a/drivers/acorn/char/pcf8583.c b/drivers/acorn/char/pcf8583.c
index e26f007..befc946 100644
--- a/drivers/acorn/char/pcf8583.c
+++ b/drivers/acorn/char/pcf8583.c
@@ -259,7 +259,6 @@ pcf8583_command(struct i2c_client *clien
 static struct i2c_driver pcf8583_driver = {
 	.name		= "PCF8583",
 	.id		= I2C_DRIVERID_PCF8583,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= pcf8583_probe,
 	.detach_client	= pcf8583_detach,
 	.command	= pcf8583_command
diff --git a/drivers/hwmon/adm1021.c b/drivers/hwmon/adm1021.c
index 8102876..5e6df4b 100644
--- a/drivers/hwmon/adm1021.c
+++ b/drivers/hwmon/adm1021.c
@@ -129,7 +129,6 @@ static struct i2c_driver adm1021_driver 
 	.owner		= THIS_MODULE,
 	.name		= "adm1021",
 	.id		= I2C_DRIVERID_ADM1021,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= adm1021_attach_adapter,
 	.detach_client	= adm1021_detach_client,
 };
diff --git a/drivers/hwmon/adm1025.c b/drivers/hwmon/adm1025.c
index bf67860..2be48a7 100644
--- a/drivers/hwmon/adm1025.c
+++ b/drivers/hwmon/adm1025.c
@@ -121,7 +121,6 @@ static struct i2c_driver adm1025_driver 
 	.owner		= THIS_MODULE,
 	.name		= "adm1025",
 	.id		= I2C_DRIVERID_ADM1025,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= adm1025_attach_adapter,
 	.detach_client	= adm1025_detach_client,
 };
diff --git a/drivers/hwmon/adm1026.c b/drivers/hwmon/adm1026.c
index 5036b17..5416db8 100644
--- a/drivers/hwmon/adm1026.c
+++ b/drivers/hwmon/adm1026.c
@@ -310,7 +310,6 @@ static void adm1026_init_client(struct i
 static struct i2c_driver adm1026_driver = {
 	.owner          = THIS_MODULE,
 	.name           = "adm1026",
-	.flags          = I2C_DF_NOTIFY,
 	.attach_adapter = adm1026_attach_adapter,
 	.detach_client  = adm1026_detach_client,
 };
diff --git a/drivers/hwmon/adm1031.c b/drivers/hwmon/adm1031.c
index 7c545d5..1e24428 100644
--- a/drivers/hwmon/adm1031.c
+++ b/drivers/hwmon/adm1031.c
@@ -107,7 +107,6 @@ static struct adm1031_data *adm1031_upda
 static struct i2c_driver adm1031_driver = {
 	.owner = THIS_MODULE,
 	.name = "adm1031",
-	.flags = I2C_DF_NOTIFY,
 	.attach_adapter = adm1031_attach_adapter,
 	.detach_client = adm1031_detach_client,
 };
diff --git a/drivers/hwmon/adm9240.c b/drivers/hwmon/adm9240.c
index 11dc95f..287733f 100644
--- a/drivers/hwmon/adm9240.c
+++ b/drivers/hwmon/adm9240.c
@@ -140,7 +140,6 @@ static struct i2c_driver adm9240_driver 
 	.owner		= THIS_MODULE,
 	.name		= "adm9240",
 	.id		= I2C_DRIVERID_ADM9240,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= adm9240_attach_adapter,
 	.detach_client	= adm9240_detach_client,
 };
diff --git a/drivers/hwmon/asb100.c b/drivers/hwmon/asb100.c
index 52c4697..7227f80 100644
--- a/drivers/hwmon/asb100.c
+++ b/drivers/hwmon/asb100.c
@@ -220,7 +220,6 @@ static struct i2c_driver asb100_driver  	.owner		= THIS_MODULE,
 	.name		= "asb100",
 	.id		= I2C_DRIVERID_ASB100,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= asb100_attach_adapter,
 	.detach_client	= asb100_detach_client,
 };
diff --git a/drivers/hwmon/atxp1.c b/drivers/hwmon/atxp1.c
index 53324f5..a60a9f2 100644
--- a/drivers/hwmon/atxp1.c
+++ b/drivers/hwmon/atxp1.c
@@ -52,7 +52,6 @@ static int atxp1_detect(struct i2c_adapt
 static struct i2c_driver atxp1_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "atxp1",
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter = atxp1_attach_adapter,
 	.detach_client	= atxp1_detach_client,
 };
diff --git a/drivers/hwmon/ds1621.c b/drivers/hwmon/ds1621.c
index 34f71b7..0096eb3 100644
--- a/drivers/hwmon/ds1621.c
+++ b/drivers/hwmon/ds1621.c
@@ -92,7 +92,6 @@ static struct i2c_driver ds1621_driver  	.owner		= THIS_MODULE,
 	.name		= "ds1621",
 	.id		= I2C_DRIVERID_DS1621,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= ds1621_attach_adapter,
 	.detach_client	= ds1621_detach_client,
 };
diff --git a/drivers/hwmon/fscher.c b/drivers/hwmon/fscher.c
index a02e1c3..f56ca06 100644
--- a/drivers/hwmon/fscher.c
+++ b/drivers/hwmon/fscher.c
@@ -121,7 +121,6 @@ static struct i2c_driver fscher_driver  	.owner		= THIS_MODULE,
 	.name		= "fscher",
 	.id		= I2C_DRIVERID_FSCHER,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= fscher_attach_adapter,
 	.detach_client	= fscher_detach_client,
 };
diff --git a/drivers/hwmon/fscpos.c b/drivers/hwmon/fscpos.c
index 64e4edc..701dffc 100644
--- a/drivers/hwmon/fscpos.c
+++ b/drivers/hwmon/fscpos.c
@@ -103,7 +103,6 @@ static struct i2c_driver fscpos_driver  	.owner		= THIS_MODULE,
 	.name		= "fscpos",
 	.id		= I2C_DRIVERID_FSCPOS,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= fscpos_attach_adapter,
 	.detach_client	= fscpos_detach_client,
 };
diff --git a/drivers/hwmon/gl518sm.c b/drivers/hwmon/gl518sm.c
index 2f178db..5788bbb 100644
--- a/drivers/hwmon/gl518sm.c
+++ b/drivers/hwmon/gl518sm.c
@@ -154,7 +154,6 @@ static struct i2c_driver gl518_driver = 
 	.owner		= THIS_MODULE,
 	.name		= "gl518sm",
 	.id		= I2C_DRIVERID_GL518,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= gl518_attach_adapter,
 	.detach_client	= gl518_detach_client,
 };
diff --git a/drivers/hwmon/gl520sm.c b/drivers/hwmon/gl520sm.c
index c39ba12..b399816 100644
--- a/drivers/hwmon/gl520sm.c
+++ b/drivers/hwmon/gl520sm.c
@@ -112,7 +112,6 @@ static struct i2c_driver gl520_driver = 
 	.owner		= THIS_MODULE,
 	.name		= "gl520sm",
 	.id		= I2C_DRIVERID_GL520,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= gl520_attach_adapter,
 	.detach_client	= gl520_detach_client,
 };
diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index a61f5d0..d5f0d92 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -237,7 +237,6 @@ static struct i2c_driver it87_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "it87",
 	.id		= I2C_DRIVERID_IT87,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= it87_attach_adapter,
 	.detach_client	= it87_detach_client,
 };
diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
index 954ec24..c2dd4ac 100644
--- a/drivers/hwmon/lm63.c
+++ b/drivers/hwmon/lm63.c
@@ -141,7 +141,6 @@ static void lm63_init_client(struct i2c_
 static struct i2c_driver lm63_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "lm63",
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= lm63_attach_adapter,
 	.detach_client	= lm63_detach_client,
 };
diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index d70f4c8..0bcbd65 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -69,7 +69,6 @@ static struct i2c_driver lm75_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "lm75",
 	.id		= I2C_DRIVERID_LM75,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= lm75_attach_adapter,
 	.detach_client	= lm75_detach_client,
 };
diff --git a/drivers/hwmon/lm77.c b/drivers/hwmon/lm77.c
index 9380fda..6a524e9 100644
--- a/drivers/hwmon/lm77.c
+++ b/drivers/hwmon/lm77.c
@@ -76,7 +76,6 @@ static struct lm77_data *lm77_update_dev
 static struct i2c_driver lm77_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "lm77",
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter = lm77_attach_adapter,
 	.detach_client	= lm77_detach_client,
 };
diff --git a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
index 78cdd50..18448f8 100644
--- a/drivers/hwmon/lm78.c
+++ b/drivers/hwmon/lm78.c
@@ -167,7 +167,6 @@ static struct i2c_driver lm78_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "lm78",
 	.id		= I2C_DRIVERID_LM78,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= lm78_attach_adapter,
 	.detach_client	= lm78_detach_client,
 };
diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
index c359fde..02303fa 100644
--- a/drivers/hwmon/lm80.c
+++ b/drivers/hwmon/lm80.c
@@ -146,7 +146,6 @@ static struct i2c_driver lm80_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "lm80",
 	.id		= I2C_DRIVERID_LM80,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= lm80_attach_adapter,
 	.detach_client	= lm80_detach_client,
 };
diff --git a/drivers/hwmon/lm83.c b/drivers/hwmon/lm83.c
index 9a70611..96cb34e 100644
--- a/drivers/hwmon/lm83.c
+++ b/drivers/hwmon/lm83.c
@@ -127,7 +127,6 @@ static struct i2c_driver lm83_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "lm83",
 	.id		= I2C_DRIVERID_LM83,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= lm83_attach_adapter,
 	.detach_client	= lm83_detach_client,
 };
diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
index 3f5544a..131ecab 100644
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -383,7 +383,6 @@ static struct i2c_driver lm85_driver = {
 	.owner          = THIS_MODULE,
 	.name           = "lm85",
 	.id             = I2C_DRIVERID_LM85,
-	.flags          = I2C_DF_NOTIFY,
 	.attach_adapter = lm85_attach_adapter,
 	.detach_client  = lm85_detach_client,
 };
diff --git a/drivers/hwmon/lm87.c b/drivers/hwmon/lm87.c
index eeec181..26fd0b3 100644
--- a/drivers/hwmon/lm87.c
+++ b/drivers/hwmon/lm87.c
@@ -164,7 +164,6 @@ static struct i2c_driver lm87_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "lm87",
 	.id		= I2C_DRIVERID_LM87,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= lm87_attach_adapter,
 	.detach_client	= lm87_detach_client,
 };
diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 83cf2e1..011923b 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -189,7 +189,6 @@ static struct i2c_driver lm90_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "lm90",
 	.id		= I2C_DRIVERID_LM90,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= lm90_attach_adapter,
 	.detach_client	= lm90_detach_client,
 };
diff --git a/drivers/hwmon/lm92.c b/drivers/hwmon/lm92.c
index 7a4b370..2005a9e 100644
--- a/drivers/hwmon/lm92.c
+++ b/drivers/hwmon/lm92.c
@@ -413,7 +413,6 @@ static struct i2c_driver lm92_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "lm92",
 	.id		= I2C_DRIVERID_LM92,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= lm92_attach_adapter,
 	.detach_client	= lm92_detach_client,
 };
diff --git a/drivers/hwmon/max1619.c b/drivers/hwmon/max1619.c
index 69e7e12..d5aebef 100644
--- a/drivers/hwmon/max1619.c
+++ b/drivers/hwmon/max1619.c
@@ -92,7 +92,6 @@ static struct max1619_data *max1619_upda
 static struct i2c_driver max1619_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "max1619",
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= max1619_attach_adapter,
 	.detach_client	= max1619_detach_client,
 };
diff --git a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
index ffdb3a0..a78929f 100644
--- a/drivers/hwmon/w83781d.c
+++ b/drivers/hwmon/w83781d.c
@@ -272,7 +272,6 @@ static struct i2c_driver w83781d_driver 
 	.owner = THIS_MODULE,
 	.name = "w83781d",
 	.id = I2C_DRIVERID_W83781D,
-	.flags = I2C_DF_NOTIFY,
 	.attach_adapter = w83781d_attach_adapter,
 	.detach_client = w83781d_detach_client,
 };
diff --git a/drivers/hwmon/w83792d.c b/drivers/hwmon/w83792d.c
index 1ba0726..6824243 100644
--- a/drivers/hwmon/w83792d.c
+++ b/drivers/hwmon/w83792d.c
@@ -319,7 +319,6 @@ static void w83792d_init_client(struct i
 static struct i2c_driver w83792d_driver = {
 	.owner = THIS_MODULE,
 	.name = "w83792d",
-	.flags = I2C_DF_NOTIFY,
 	.attach_adapter = w83792d_attach_adapter,
 	.detach_client = w83792d_detach_client,
 };
diff --git a/drivers/hwmon/w83l785ts.c b/drivers/hwmon/w83l785ts.c
index f495b63..35172fb 100644
--- a/drivers/hwmon/w83l785ts.c
+++ b/drivers/hwmon/w83l785ts.c
@@ -95,7 +95,6 @@ static struct i2c_driver w83l785ts_drive
 	.owner		= THIS_MODULE,
 	.name		= "w83l785ts",
 	.id		= I2C_DRIVERID_W83L785TS,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= w83l785ts_attach_adapter,
 	.detach_client	= w83l785ts_detach_client,
 };
diff --git a/drivers/i2c/chips/ds1337.c b/drivers/i2c/chips/ds1337.c
index 1822895..65146cb 100644
--- a/drivers/i2c/chips/ds1337.c
+++ b/drivers/i2c/chips/ds1337.c
@@ -54,7 +54,6 @@ static int ds1337_command(struct i2c_cli
 static struct i2c_driver ds1337_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "ds1337",
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= ds1337_attach_adapter,
 	.detach_client	= ds1337_detach_client,
 	.command	= ds1337_command,
diff --git a/drivers/i2c/chips/ds1374.c b/drivers/i2c/chips/ds1374.c
index da488b7..5a270d6 100644
--- a/drivers/i2c/chips/ds1374.c
+++ b/drivers/i2c/chips/ds1374.c
@@ -235,7 +235,6 @@ static struct i2c_driver ds1374_driver  	.owner = THIS_MODULE,
 	.name = DS1374_DRV_NAME,
 	.id = I2C_DRIVERID_DS1374,
-	.flags = I2C_DF_NOTIFY,
 	.attach_adapter = ds1374_attach,
 	.detach_client = ds1374_detach,
 };
diff --git a/drivers/i2c/chips/eeprom.c b/drivers/i2c/chips/eeprom.c
index 4baf573..9bb1f8b 100644
--- a/drivers/i2c/chips/eeprom.c
+++ b/drivers/i2c/chips/eeprom.c
@@ -71,7 +71,6 @@ static struct i2c_driver eeprom_driver  	.owner		= THIS_MODULE,
 	.name		= "eeprom",
 	.id		= I2C_DRIVERID_EEPROM,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= eeprom_attach_adapter,
 	.detach_client	= eeprom_detach_client,
 };
diff --git a/drivers/i2c/chips/isp1301_omap.c b/drivers/i2c/chips/isp1301_omap.c
index d2a100d..4f472ba 100644
--- a/drivers/i2c/chips/isp1301_omap.c
+++ b/drivers/i2c/chips/isp1301_omap.c
@@ -1636,7 +1636,6 @@ static struct i2c_driver isp1301_driver 
 	.name		= "isp1301_omap",
 	.id		= 1301,		/* FIXME "official", i2c-ids.h */
 	.class		= I2C_CLASS_HWMON,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= isp1301_scan_bus,
 	.detach_client	= isp1301_detach_client,
 };
diff --git a/drivers/i2c/chips/m41t00.c b/drivers/i2c/chips/m41t00.c
index 3df309a..13e6783 100644
--- a/drivers/i2c/chips/m41t00.c
+++ b/drivers/i2c/chips/m41t00.c
@@ -214,7 +214,6 @@ static struct i2c_driver m41t00_driver  	.owner		= THIS_MODULE,
 	.name		= M41T00_DRV_NAME,
 	.id		= I2C_DRIVERID_STM41T00,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= m41t00_attach,
 	.detach_client	= m41t00_detach,
 };
diff --git a/drivers/i2c/chips/max6875.c b/drivers/i2c/chips/max6875.c
index b376a00..7e61019 100644
--- a/drivers/i2c/chips/max6875.c
+++ b/drivers/i2c/chips/max6875.c
@@ -69,7 +69,6 @@ static int max6875_detach_client(struct 
 static struct i2c_driver max6875_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "max6875",
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= max6875_attach_adapter,
 	.detach_client	= max6875_detach_client,
 };
diff --git a/drivers/i2c/chips/pca9539.c b/drivers/i2c/chips/pca9539.c
index 59a9303..26feb7a 100644
--- a/drivers/i2c/chips/pca9539.c
+++ b/drivers/i2c/chips/pca9539.c
@@ -40,7 +40,6 @@ static int pca9539_detach_client(struct 
 static struct i2c_driver pca9539_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "pca9539",
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= pca9539_attach_adapter,
 	.detach_client	= pca9539_detach_client,
 };
diff --git a/drivers/i2c/chips/pcf8574.c b/drivers/i2c/chips/pcf8574.c
index c323c2d..2fae640 100644
--- a/drivers/i2c/chips/pcf8574.c
+++ b/drivers/i2c/chips/pcf8574.c
@@ -68,7 +68,6 @@ static struct i2c_driver pcf8574_driver 
 	.owner		= THIS_MODULE,
 	.name		= "pcf8574",
 	.id		= I2C_DRIVERID_PCF8574,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= pcf8574_attach_adapter,
 	.detach_client	= pcf8574_detach_client,
 };
diff --git a/drivers/i2c/chips/pcf8591.c b/drivers/i2c/chips/pcf8591.c
index ce420a6..8750f71 100644
--- a/drivers/i2c/chips/pcf8591.c
+++ b/drivers/i2c/chips/pcf8591.c
@@ -91,7 +91,6 @@ static struct i2c_driver pcf8591_driver 
 	.owner		= THIS_MODULE,
 	.name		= "pcf8591",
 	.id		= I2C_DRIVERID_PCF8591,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= pcf8591_attach_adapter,
 	.detach_client	= pcf8591_detach_client,
 };
diff --git a/drivers/i2c/chips/rtc8564.c b/drivers/i2c/chips/rtc8564.c
index 26e498d..e586f75 100644
--- a/drivers/i2c/chips/rtc8564.c
+++ b/drivers/i2c/chips/rtc8564.c
@@ -362,7 +362,6 @@ static struct i2c_driver rtc8564_driver 
 	.owner		= THIS_MODULE,
 	.name		= "RTC8564",
 	.id		= I2C_DRIVERID_RTC8564,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter = rtc8564_probe,
 	.detach_client	= rtc8564_detach,
 	.command	= rtc8564_command
diff --git a/drivers/i2c/chips/tps65010.c b/drivers/i2c/chips/tps65010.c
index 280dd7a..439bf6c 100644
--- a/drivers/i2c/chips/tps65010.c
+++ b/drivers/i2c/chips/tps65010.c
@@ -639,7 +639,6 @@ static int __init tps65010_scan_bus(stru
 static struct i2c_driver tps65010_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "tps65010",
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= tps65010_scan_bus,
 	.detach_client	= __exit_p(tps65010_detach_client),
 };
diff --git a/drivers/i2c/chips/x1205.c b/drivers/i2c/chips/x1205.c
index 7da366c..c5ff2ce 100644
--- a/drivers/i2c/chips/x1205.c
+++ b/drivers/i2c/chips/x1205.c
@@ -107,7 +107,6 @@ static int x1205_command(struct i2c_clie
 static struct i2c_driver x1205_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "x1205",
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter = &x1205_attach,
 	.detach_client	= &x1205_detach,
 };
diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 82ea1b7..ad68ac0 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -197,7 +197,7 @@ int i2c_add_adapter(struct i2c_adapter *
 	/* inform drivers of new adapters */
 	list_for_each(item,&drivers) {
 		driver = list_entry(item, struct i2c_driver, list);
-		if (driver->flags & I2C_DF_NOTIFY)
+		if (driver->attach_adapter)
 			/* We ignore the return code; if it fails, too bad */
 			driver->attach_adapter(adap);
 	}
@@ -309,7 +309,7 @@ int i2c_add_driver(struct i2c_driver *dr
 	pr_debug("i2c-core: driver [%s] registered\n", driver->name);
 
 	/* now look for instances of driver on our adapters */
-	if (driver->flags & I2C_DF_NOTIFY) {
+	if (driver->attach_adapter) {
 		list_for_each(item,&adapters) {
 			adapter = list_entry(item, struct i2c_adapter, list);
 			driver->attach_adapter(adapter);
diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 8af0bd1..9da51eb 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -484,7 +484,6 @@ static struct i2c_driver i2cdev_driver  	.owner		= THIS_MODULE,
 	.name		= "dev_driver",
 	.id		= I2C_DRIVERID_I2CDEV,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= i2cdev_attach_adapter,
 	.detach_adapter	= i2cdev_detach_adapter,
 	.detach_client	= i2cdev_detach_client,
diff --git a/drivers/macintosh/therm_adt746x.c b/drivers/macintosh/therm_adt746x.c
index f386966..f62c16f 100644
--- a/drivers/macintosh/therm_adt746x.c
+++ b/drivers/macintosh/therm_adt746x.c
@@ -173,7 +173,6 @@ detach_thermostat(struct i2c_adapter *ad
 static struct i2c_driver thermostat_driver = {  
 	.owner		= THIS_MODULE,
 	.name		= "therm_adt746x",
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= attach_thermostat,
 	.detach_adapter	= detach_thermostat,
 };
diff --git a/drivers/macintosh/therm_pm72.c b/drivers/macintosh/therm_pm72.c
index 190878e..df00c96 100644
--- a/drivers/macintosh/therm_pm72.c
+++ b/drivers/macintosh/therm_pm72.c
@@ -285,7 +285,6 @@ static struct i2c_driver therm_pm72_driv
 {
 	.owner		= THIS_MODULE,
 	.name		= "therm_pm72",
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= therm_pm72_attach,
 	.detach_adapter	= therm_pm72_detach,
 };
diff --git a/drivers/macintosh/therm_windtunnel.c b/drivers/macintosh/therm_windtunnel.c
index 6aaa1df..f3bae0d 100644
--- a/drivers/macintosh/therm_windtunnel.c
+++ b/drivers/macintosh/therm_windtunnel.c
@@ -357,7 +357,6 @@ static struct i2c_driver g4fan_driver = 
 	.owner		= THIS_MODULE,
 	.name		= "therm_windtunnel",
 	.id		= I2C_DRIVERID_G4FAN,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter = do_attach,
 	.detach_client	= do_detach,
 };
diff --git a/drivers/macintosh/windfarm_lm75_sensor.c b/drivers/macintosh/windfarm_lm75_sensor.c
index a0a41ad..2392789 100644
--- a/drivers/macintosh/windfarm_lm75_sensor.c
+++ b/drivers/macintosh/windfarm_lm75_sensor.c
@@ -49,7 +49,6 @@ static int wf_lm75_detach(struct i2c_cli
 static struct i2c_driver wf_lm75_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "wf_lm75",
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= wf_lm75_attach,
 	.detach_client	= wf_lm75_detach,
 };
diff --git a/drivers/media/video/adv7170.c b/drivers/media/video/adv7170.c
index 1ca2b67..c4f2265 100644
--- a/drivers/media/video/adv7170.c
+++ b/drivers/media/video/adv7170.c
@@ -502,7 +502,6 @@ static struct i2c_driver i2c_driver_adv7
 	.name = "adv7170",	/* name */
 
 	.id = I2C_DRIVERID_ADV7170,
-	.flags = I2C_DF_NOTIFY,
 
 	.attach_adapter = adv7170_attach_adapter,
 	.detach_client = adv7170_detach_client,
diff --git a/drivers/media/video/adv7175.c b/drivers/media/video/adv7175.c
index 173bca1..4fc08b1 100644
--- a/drivers/media/video/adv7175.c
+++ b/drivers/media/video/adv7175.c
@@ -552,7 +552,6 @@ static struct i2c_driver i2c_driver_adv7
 	.name = "adv7175",	/* name */
 
 	.id = I2C_DRIVERID_ADV7175,
-	.flags = I2C_DF_NOTIFY,
 
 	.attach_adapter = adv7175_attach_adapter,
 	.detach_client = adv7175_detach_client,
diff --git a/drivers/media/video/bt819.c b/drivers/media/video/bt819.c
index 3ee0afc..7bba697 100644
--- a/drivers/media/video/bt819.c
+++ b/drivers/media/video/bt819.c
@@ -627,7 +627,6 @@ static struct i2c_driver i2c_driver_bt81
 	.name = "bt819",
 
 	.id = I2C_DRIVERID_BT819,
-	.flags = I2C_DF_NOTIFY,
 
 	.attach_adapter = bt819_attach_adapter,
 	.detach_client = bt819_detach_client,
diff --git a/drivers/media/video/bt832.c b/drivers/media/video/bt832.c
index 3ca1d76..0ba8652 100644
--- a/drivers/media/video/bt832.c
+++ b/drivers/media/video/bt832.c
@@ -233,7 +233,6 @@ static struct i2c_driver driver = {
 	.owner          = THIS_MODULE,
 	.name           = "i2c bt832 driver",
 	.id             = -1, /* FIXME */
-	.flags          = I2C_DF_NOTIFY,
 	.attach_adapter = bt832_probe,
 	.detach_client  = bt832_detach,
 	.command        = bt832_command,
diff --git a/drivers/media/video/bt856.c b/drivers/media/video/bt856.c
index 8eb871d..4c9acd1 100644
--- a/drivers/media/video/bt856.c
+++ b/drivers/media/video/bt856.c
@@ -409,7 +409,6 @@ static struct i2c_driver i2c_driver_bt85
 	.name = "bt856",
 
 	.id = I2C_DRIVERID_BT856,
-	.flags = I2C_DF_NOTIFY,
 
 	.attach_adapter = bt856_attach_adapter,
 	.detach_client = bt856_detach_client,
diff --git a/drivers/media/video/cs53l32a.c b/drivers/media/video/cs53l32a.c
index 780b352..fce5d89 100644
--- a/drivers/media/video/cs53l32a.c
+++ b/drivers/media/video/cs53l32a.c
@@ -218,7 +218,6 @@ static int cs53l32a_detach(struct i2c_cl
 static struct i2c_driver i2c_driver = {
 	.name = "cs53l32a",
 	.id = I2C_DRIVERID_CS53L32A,
-	.flags = I2C_DF_NOTIFY,
 	.attach_adapter = cs53l32a_probe,
 	.detach_client = cs53l32a_detach,
 	.command = cs53l32a_command,
diff --git a/drivers/media/video/cx25840/cx25840-core.c b/drivers/media/video/cx25840/cx25840-core.c
index 5b93723..c66bc14 100644
--- a/drivers/media/video/cx25840/cx25840-core.c
+++ b/drivers/media/video/cx25840/cx25840-core.c
@@ -847,7 +847,6 @@ static struct i2c_driver i2c_driver_cx25
 	.name = "cx25840",
 
 	.id = I2C_DRIVERID_CX25840,
-	.flags = I2C_DF_NOTIFY,
 
 	.attach_adapter = cx25840_attach_adapter,
 	.detach_client = cx25840_detach_client,
diff --git a/drivers/media/video/indycam.c b/drivers/media/video/indycam.c
index deeef12..3eba514 100644
--- a/drivers/media/video/indycam.c
+++ b/drivers/media/video/indycam.c
@@ -454,7 +454,6 @@ static struct i2c_driver i2c_driver_indy
 	.owner		= THIS_MODULE,
 	.name		= "indycam",
 	.id		= I2C_DRIVERID_INDYCAM,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter = indycam_probe,
 	.detach_client	= indycam_detach,
 	.command	= indycam_command,
diff --git a/drivers/media/video/ir-kbd-i2c.c b/drivers/media/video/ir-kbd-i2c.c
index 740e543..2e2f78a 100644
--- a/drivers/media/video/ir-kbd-i2c.c
+++ b/drivers/media/video/ir-kbd-i2c.c
@@ -280,7 +280,6 @@ static int ir_probe(struct i2c_adapter *
 static struct i2c_driver driver = {
 	.name           = "ir remote kbd driver",
 	.id             = I2C_DRIVERID_INFRARED,
-	.flags          = I2C_DF_NOTIFY,
 	.attach_adapter = ir_probe,
 	.detach_client  = ir_detach,
 };
diff --git a/drivers/media/video/msp3400.c b/drivers/media/video/msp3400.c
index d86f8e9..46328fb 100644
--- a/drivers/media/video/msp3400.c
+++ b/drivers/media/video/msp3400.c
@@ -1564,7 +1564,6 @@ static struct i2c_driver driver = {
 	.owner          = THIS_MODULE,
 	.name           = "msp3400",
 	.id             = I2C_DRIVERID_MSP3400,
-	.flags          = I2C_DF_NOTIFY,
 	.attach_adapter = msp_probe,
 	.detach_client  = msp_detach,
 	.command        = msp_command,
diff --git a/drivers/media/video/ovcamchip/ovcamchip_core.c b/drivers/media/video/ovcamchip/ovcamchip_core.c
index 2de34eb..390d0d6 100644
--- a/drivers/media/video/ovcamchip/ovcamchip_core.c
+++ b/drivers/media/video/ovcamchip/ovcamchip_core.c
@@ -414,7 +414,6 @@ static struct i2c_driver driver = {
 	.name =			"ovcamchip",
 	.id =			I2C_DRIVERID_OVCAMCHIP,
 	.class =		I2C_CLASS_CAM_DIGITAL,
-	.flags =		I2C_DF_NOTIFY,
 	.attach_adapter =	ovcamchip_attach,
 	.detach_client =	ovcamchip_detach,
 	.command =		ovcamchip_command,
diff --git a/drivers/media/video/saa5246a.c b/drivers/media/video/saa5246a.c
index b8054da..9bf6869 100644
--- a/drivers/media/video/saa5246a.c
+++ b/drivers/media/video/saa5246a.c
@@ -166,7 +166,6 @@ static struct i2c_driver i2c_driver_vide
 	.owner 		= THIS_MODULE,
 	.name 		= IF_NAME,		/* name */
 	.id 		= I2C_DRIVERID_SAA5249, /* in i2c.h */
-	.flags 		= I2C_DF_NOTIFY,
 	.attach_adapter = saa5246a_probe,
 	.detach_client  = saa5246a_detach,
 	.command 	= saa5246a_command
diff --git a/drivers/media/video/saa5249.c b/drivers/media/video/saa5249.c
index 7ffa2e9..811e863 100644
--- a/drivers/media/video/saa5249.c
+++ b/drivers/media/video/saa5249.c
@@ -239,7 +239,6 @@ static struct i2c_driver i2c_driver_vide
 	.owner 		= THIS_MODULE,
 	.name 		= IF_NAME,		/* name */
 	.id 		= I2C_DRIVERID_SAA5249, /* in i2c.h */
-	.flags 		= I2C_DF_NOTIFY,
 	.attach_adapter = saa5249_probe,
 	.detach_client  = saa5249_detach,
 	.command 	= saa5249_command
diff --git a/drivers/media/video/saa6588.c b/drivers/media/video/saa6588.c
index 9233225..18a0b71 100644
--- a/drivers/media/video/saa6588.c
+++ b/drivers/media/video/saa6588.c
@@ -498,7 +498,6 @@ static struct i2c_driver driver = {
 	.owner = THIS_MODULE,
 	.name = "i2c saa6588 driver",
 	.id = -1,		/* FIXME */
-	.flags = I2C_DF_NOTIFY,
 	.attach_adapter = saa6588_probe,
 	.detach_client = saa6588_detach,
 	.command = saa6588_command,
diff --git a/drivers/media/video/saa7110.c b/drivers/media/video/saa7110.c
index e116bdb..f266b35 100644
--- a/drivers/media/video/saa7110.c
+++ b/drivers/media/video/saa7110.c
@@ -591,7 +591,6 @@ static struct i2c_driver i2c_driver_saa7
 	.name = "saa7110",
 
 	.id = I2C_DRIVERID_SAA7110,
-	.flags = I2C_DF_NOTIFY,
 
 	.attach_adapter = saa7110_attach_adapter,
 	.detach_client = saa7110_detach_client,
diff --git a/drivers/media/video/saa7111.c b/drivers/media/video/saa7111.c
index fe8a5e4..687beaf 100644
--- a/drivers/media/video/saa7111.c
+++ b/drivers/media/video/saa7111.c
@@ -594,7 +594,6 @@ static struct i2c_driver i2c_driver_saa7
 	.name = "saa7111",
 
 	.id = I2C_DRIVERID_SAA7111A,
-	.flags = I2C_DF_NOTIFY,
 
 	.attach_adapter = saa7111_attach_adapter,
 	.detach_client = saa7111_detach_client,
diff --git a/drivers/media/video/saa7114.c b/drivers/media/video/saa7114.c
index d9f50e2..4748cf0 100644
--- a/drivers/media/video/saa7114.c
+++ b/drivers/media/video/saa7114.c
@@ -1208,7 +1208,6 @@ static struct i2c_driver i2c_driver_saa7
 	.name = "saa7114",
 
 	.id = I2C_DRIVERID_SAA7114,
-	.flags = I2C_DF_NOTIFY,
 
 	.attach_adapter = saa7114_attach_adapter,
 	.detach_client = saa7114_detach_client,
diff --git a/drivers/media/video/saa7115.c b/drivers/media/video/saa7115.c
index e717e30..b1079de 100644
--- a/drivers/media/video/saa7115.c
+++ b/drivers/media/video/saa7115.c
@@ -1356,7 +1356,6 @@ static int saa7115_detach(struct i2c_cli
 static struct i2c_driver i2c_driver_saa7115 = {
 	.name = "saa7115",
 	.id = I2C_DRIVERID_SAA711X,
-	.flags = I2C_DF_NOTIFY,
 	.attach_adapter = saa7115_probe,
 	.detach_client = saa7115_detach,
 	.command = saa7115_command,
diff --git a/drivers/media/video/saa711x.c b/drivers/media/video/saa711x.c
index 31f7b95..734a709 100644
--- a/drivers/media/video/saa711x.c
+++ b/drivers/media/video/saa711x.c
@@ -569,7 +569,6 @@ static struct i2c_driver i2c_driver_saa7
 	.name = "saa711x",
 
 	.id = I2C_DRIVERID_SAA711X,
-	.flags = I2C_DF_NOTIFY,
 
 	.attach_adapter = saa711x_attach_adapter,
 	.detach_client = saa711x_detach_client,
diff --git a/drivers/media/video/saa7127.c b/drivers/media/video/saa7127.c
index c36f014..a2fab98 100644
--- a/drivers/media/video/saa7127.c
+++ b/drivers/media/video/saa7127.c
@@ -821,7 +821,6 @@ static int saa7127_detach(struct i2c_cli
 static struct i2c_driver i2c_driver_saa7127 = {
 	.name = "saa7127",
 	.id = I2C_DRIVERID_SAA7127,
-	.flags = I2C_DF_NOTIFY,
 	.attach_adapter = saa7127_probe,
 	.detach_client = saa7127_detach,
 	.command = saa7127_command,
diff --git a/drivers/media/video/saa7134/saa6752hs.c b/drivers/media/video/saa7134/saa6752hs.c
index a61d24f..6fc298e 100644
--- a/drivers/media/video/saa7134/saa6752hs.c
+++ b/drivers/media/video/saa7134/saa6752hs.c
@@ -600,7 +600,6 @@ static struct i2c_driver driver = {
 	.owner          = THIS_MODULE,
 	.name           = "i2c saa6752hs MPEG encoder",
 	.id             = I2C_DRIVERID_SAA6752HS,
-	.flags          = I2C_DF_NOTIFY,
 	.attach_adapter = saa6752hs_probe,
 	.detach_client  = saa6752hs_detach,
 	.command        = saa6752hs_command,
diff --git a/drivers/media/video/saa7185.c b/drivers/media/video/saa7185.c
index 132aa79..e24aa16 100644
--- a/drivers/media/video/saa7185.c
+++ b/drivers/media/video/saa7185.c
@@ -491,7 +491,6 @@ static struct i2c_driver i2c_driver_saa7
 	.name = "saa7185",	/* name */
 
 	.id = I2C_DRIVERID_SAA7185B,
-	.flags = I2C_DF_NOTIFY,
 
 	.attach_adapter = saa7185_attach_adapter,
 	.detach_client = saa7185_detach_client,
diff --git a/drivers/media/video/saa7191.c b/drivers/media/video/saa7191.c
index cbca896..6be98fc 100644
--- a/drivers/media/video/saa7191.c
+++ b/drivers/media/video/saa7191.c
@@ -791,7 +791,6 @@ static struct i2c_driver i2c_driver_saa7
 	.owner		= THIS_MODULE,
 	.name		= "saa7191",
 	.id		= I2C_DRIVERID_SAA7191,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter = saa7191_probe,
 	.detach_client	= saa7191_detach,
 	.command	= saa7191_command
diff --git a/drivers/media/video/tda7432.c b/drivers/media/video/tda7432.c
index d32737d..239a586 100644
--- a/drivers/media/video/tda7432.c
+++ b/drivers/media/video/tda7432.c
@@ -504,7 +504,6 @@ static struct i2c_driver driver = {
 	.owner           = THIS_MODULE,
 	.name            = "i2c tda7432 driver",
 	.id              = I2C_DRIVERID_TDA7432,
-	.flags           = I2C_DF_NOTIFY,
 	.attach_adapter  = tda7432_probe,
 	.detach_client   = tda7432_detach,
 	.command         = tda7432_command,
diff --git a/drivers/media/video/tda9840.c b/drivers/media/video/tda9840.c
index 1794686..f29fb50 100644
--- a/drivers/media/video/tda9840.c
+++ b/drivers/media/video/tda9840.c
@@ -224,7 +224,6 @@ static struct i2c_driver driver = {
 	.owner	= THIS_MODULE,
 	.name	= "tda9840",
 	.id	= I2C_DRIVERID_TDA9840,
-	.flags	= I2C_DF_NOTIFY,
 	.attach_adapter	= attach,
 	.detach_client	= detach,
 	.command	= command,
diff --git a/drivers/media/video/tda9875.c b/drivers/media/video/tda9875.c
index a5e37dc..d053b64 100644
--- a/drivers/media/video/tda9875.c
+++ b/drivers/media/video/tda9875.c
@@ -375,7 +375,6 @@ static struct i2c_driver driver = {
 	.owner          = THIS_MODULE,
 	.name           = "i2c tda9875 driver",
 	.id             = I2C_DRIVERID_TDA9875,
-	.flags          = I2C_DF_NOTIFY,
 	.attach_adapter = tda9875_probe,
 	.detach_client  = tda9875_detach,
 	.command        = tda9875_command,
diff --git a/drivers/media/video/tda9887.c b/drivers/media/video/tda9887.c
index 2f2414e..049b44e 100644
--- a/drivers/media/video/tda9887.c
+++ b/drivers/media/video/tda9887.c
@@ -822,7 +822,6 @@ static struct i2c_driver driver = {
 	.owner          = THIS_MODULE,
 	.name           = "i2c tda9887 driver",
 	.id             = -1, /* FIXME */
-	.flags          = I2C_DF_NOTIFY,
 	.attach_adapter = tda9887_probe,
 	.detach_client  = tda9887_detach,
 	.command        = tda9887_command,
diff --git a/drivers/media/video/tea6415c.c b/drivers/media/video/tea6415c.c
index ee36883..96d88ce 100644
--- a/drivers/media/video/tea6415c.c
+++ b/drivers/media/video/tea6415c.c
@@ -193,7 +193,6 @@ static struct i2c_driver driver = {
 	.owner	= THIS_MODULE,
 	.name 	= "tea6415c",
 	.id 	= I2C_DRIVERID_TEA6415C,
-	.flags 	= I2C_DF_NOTIFY,
 	.attach_adapter	= attach,
 	.detach_client	= detach,
 	.command	= command,
diff --git a/drivers/media/video/tea6420.c b/drivers/media/video/tea6420.c
index 17975c1..fd417de 100644
--- a/drivers/media/video/tea6420.c
+++ b/drivers/media/video/tea6420.c
@@ -170,7 +170,6 @@ static struct i2c_driver driver = {
 	.owner	= THIS_MODULE,
 	.name	= "tea6420",
 	.id	= I2C_DRIVERID_TEA6420,
-	.flags	= I2C_DF_NOTIFY,
 	.attach_adapter	= attach,
 	.detach_client	= detach,
 	.command	= command,
diff --git a/drivers/media/video/tuner-3036.c b/drivers/media/video/tuner-3036.c
index 7920359..3505cec 100644
--- a/drivers/media/video/tuner-3036.c
+++ b/drivers/media/video/tuner-3036.c
@@ -178,7 +178,6 @@ i2c_driver_tuner = 
 	.owner		=	THIS_MODULE,
 	.name		=	"sab3036",
 	.id		=	I2C_DRIVERID_SAB3036,
-        .flags		=	I2C_DF_NOTIFY,
 	.attach_adapter =	tuner_probe,
 	.detach_client  =	tuner_detach,
 	.command	=	tuner_command
diff --git a/drivers/media/video/tuner-core.c b/drivers/media/video/tuner-core.c
index e58abdf..3c75121 100644
--- a/drivers/media/video/tuner-core.c
+++ b/drivers/media/video/tuner-core.c
@@ -745,7 +745,6 @@ static struct i2c_driver driver = {
 	.owner = THIS_MODULE,
 	.name = "tuner",
 	.id = I2C_DRIVERID_TUNER,
-	.flags = I2C_DF_NOTIFY,
 	.attach_adapter = tuner_probe,
 	.detach_client = tuner_detach,
 	.command = tuner_command,
diff --git a/drivers/media/video/tvaudio.c b/drivers/media/video/tvaudio.c
index 5b20e81..3565f35 100644
--- a/drivers/media/video/tvaudio.c
+++ b/drivers/media/video/tvaudio.c
@@ -1705,7 +1705,6 @@ static struct i2c_driver driver = {
 	.owner           = THIS_MODULE,
 	.name            = "generic i2c audio driver",
 	.id              = I2C_DRIVERID_TVAUDIO,
-	.flags           = I2C_DF_NOTIFY,
 	.attach_adapter  = chip_probe,
 	.detach_client   = chip_detach,
 	.command         = chip_command,
diff --git a/drivers/media/video/tveeprom.c b/drivers/media/video/tveeprom.c
index 5ac2353..195bc51 100644
--- a/drivers/media/video/tveeprom.c
+++ b/drivers/media/video/tveeprom.c
@@ -782,7 +782,6 @@ static struct i2c_driver i2c_driver_tvee
 	.owner          = THIS_MODULE,
 	.name           = "tveeprom",
 	.id             = I2C_DRIVERID_TVEEPROM,
-	.flags          = I2C_DF_NOTIFY,
 	.attach_adapter = tveeprom_attach_adapter,
 	.detach_client  = tveeprom_detach_client,
 	.command        = tveeprom_command,
diff --git a/drivers/media/video/tvmixer.c b/drivers/media/video/tvmixer.c
index 5897e5d..936e01d 100644
--- a/drivers/media/video/tvmixer.c
+++ b/drivers/media/video/tvmixer.c
@@ -232,7 +232,6 @@ static struct i2c_driver driver = {
 #endif
 	.name            = "tv card mixer driver",
 	.id              = I2C_DRIVERID_TVMIXER,
-	.flags           = I2C_DF_NOTIFY,
 	.detach_adapter  = tvmixer_adapters,
 	.attach_adapter  = tvmixer_adapters,
 	.detach_client   = tvmixer_clients,
diff --git a/drivers/media/video/tvp5150.c b/drivers/media/video/tvp5150.c
index 97431e2..4f3ee20 100644
--- a/drivers/media/video/tvp5150.c
+++ b/drivers/media/video/tvp5150.c
@@ -806,7 +806,6 @@ static struct i2c_driver driver = {
 
 	/* FIXME */
 	.id = I2C_DRIVERID_SAA7110,
-	.flags = I2C_DF_NOTIFY,
 
 	.attach_adapter = tvp5150_attach_adapter,
 	.detach_client = tvp5150_detach_client,
diff --git a/drivers/media/video/vpx3220.c b/drivers/media/video/vpx3220.c
index 137b58f..c66d285 100644
--- a/drivers/media/video/vpx3220.c
+++ b/drivers/media/video/vpx3220.c
@@ -726,7 +726,6 @@ static struct i2c_driver vpx3220_i2c_dri
 	.name = "vpx3220",
 
 	.id = I2C_DRIVERID_VPX3220,
-	.flags = I2C_DF_NOTIFY,
 
 	.attach_adapter = vpx3220_attach_adapter,
 	.detach_client = vpx3220_detach_client,
diff --git a/drivers/media/video/wm8775.c b/drivers/media/video/wm8775.c
index a6936ad..7b07717 100644
--- a/drivers/media/video/wm8775.c
+++ b/drivers/media/video/wm8775.c
@@ -236,7 +236,6 @@ static struct i2c_driver i2c_driver = {
 	.name = "wm8775",
 
 	.id = I2C_DRIVERID_WM8775,
-	.flags = I2C_DF_NOTIFY,
 
 	.attach_adapter = wm8775_probe,
 	.detach_client = wm8775_detach,
diff --git a/drivers/video/matrox/matroxfb_maven.c b/drivers/video/matrox/matroxfb_maven.c
index ad60bbb..78994c5 100644
--- a/drivers/video/matrox/matroxfb_maven.c
+++ b/drivers/video/matrox/matroxfb_maven.c
@@ -1296,7 +1296,6 @@ static struct i2c_driver maven_driver={
 	.owner		= THIS_MODULE,
 	.name		= "maven",
 	.id		= I2C_DRIVERID_MGATVO,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= maven_attach_adapter,
 	.detach_client	= maven_detach_client,
 	.command	= maven_command,
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 0316ba1..99399fa 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -251,7 +251,6 @@ static inline void i2c_set_adapdata (str
 }
 
 /*flags for the driver struct: */
-#define I2C_DF_NOTIFY	0x01		/* notify on bus (de/a)ttaches 	*/
 
 /*flags for the client struct: */
 #define I2C_CLIENT_ALLOW_USE		0x01	/* Client allows access */
diff --git a/sound/oss/dmasound/dac3550a.c b/sound/oss/dmasound/dac3550a.c
index 533895e..3402a66 100644
--- a/sound/oss/dmasound/dac3550a.c
+++ b/sound/oss/dmasound/dac3550a.c
@@ -44,7 +44,6 @@ struct i2c_driver daca_driver = {  
 	.owner			= THIS_MODULE,
 	.name			= "DAC3550A driver  V " DACA_VERSION,
 	.id			= I2C_DRIVERID_DACA,
-	.flags			= I2C_DF_NOTIFY,
 	.attach_adapter		= daca_attach_adapter,
 	.detach_client		= daca_detach_client,
 };
diff --git a/sound/oss/dmasound/tas_common.c b/sound/oss/dmasound/tas_common.c
index d36a1fe..7e3d517 100644
--- a/sound/oss/dmasound/tas_common.c
+++ b/sound/oss/dmasound/tas_common.c
@@ -49,7 +49,6 @@ static int tas_detach_client(struct i2c_
 struct i2c_driver tas_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "tas",
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= tas_attach_adapter,
 	.detach_client	= tas_detach_client,
 };
diff --git a/sound/ppc/keywest.c b/sound/ppc/keywest.c
index 097fbcf..fd8e2e6 100644
--- a/sound/ppc/keywest.c
+++ b/sound/ppc/keywest.c
@@ -43,7 +43,6 @@ static int keywest_detach_client(struct 
 struct i2c_driver keywest_driver = {  
 	.name = "PMac Keywest Audio",
 	.id = I2C_DRIVERID_KEYWEST,
-	.flags = I2C_DF_NOTIFY,
 	.attach_adapter = &keywest_attach_adapter,
 	.detach_client = &keywest_detach_client,
 };


