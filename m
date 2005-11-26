From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 26 Nov 2005 20:27:13 +0000
Subject: [lm-sensors] [PATCH 08/25] i2c: Drop i2c_driver.flags, 2 of 3
Message-Id: <20051126202806.57c55d7c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=i2c-drop-driver-flags-02-df-notify.patch

Just about every i2c chip driver sets the I2C_DF_NOTIFY flag, so we
can simply make it the default and drop the flag. If any driver really
doesn't want to be notified when i2c adapters are added, that driver
can simply omit to set .attach_adapter. This approach is also more
robust as it prevents accidental NULL pointer dereferences.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
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

--- linux-2.6.15-rc2.orig/Documentation/i2c/porting-clients	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/Documentation/i2c/porting-clients	2005-11-26 13:42:27.000000000 +0100
@@ -109,6 +109,9 @@
   there is a MODULE_LICENSE() line, at the bottom of the file
   (after MODULE_AUTHOR() and MODULE_DESCRIPTION(), in this order).
 
+* [Driver] The flags field of the i2c_driver structure is gone.
+  I2C_DF_NOTIFY is now the default behavior.
+
 Coding policy:
 
 * [Copyright] Use (C), not (c), for copyright.
--- linux-2.6.15-rc2.orig/Documentation/i2c/writing-clients	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/Documentation/i2c/writing-clients	2005-11-26 13:42:27.000000000 +0100
@@ -27,7 +27,6 @@
 static struct i2c_driver foo_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "Foo version 2.3 driver",
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= &foo_attach_adapter,
 	.detach_client	= &foo_detach_client,
 	.command	= &foo_command /* may be NULL */
@@ -36,10 +35,6 @@
 The name field must match the driver name, including the case. It must not
 contain spaces, and may be up to 31 characters long.
 
-Don't worry about the flags field; just put I2C_DF_NOTIFY into it. This
-means that your driver will be notified when new adapters are found.
-This is almost always what you want.
-
 All other fields are for call-back functions which will be explained 
 below.
 
--- linux-2.6.15-rc2.orig/arch/arm/mach-pxa/akita-ioexp.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/arch/arm/mach-pxa/akita-ioexp.c	2005-11-26 13:42:27.000000000 +0100
@@ -127,7 +127,6 @@
 	.owner		= THIS_MODULE,
 	.name		= "akita-max7310",
 	.id		= I2C_DRIVERID_AKITAIOEXP,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= max7310_attach_adapter,
 	.detach_client	= max7310_detach_client,
 };
--- linux-2.6.15-rc2.orig/drivers/acorn/char/pcf8583.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/acorn/char/pcf8583.c	2005-11-26 13:42:27.000000000 +0100
@@ -259,7 +259,6 @@
 static struct i2c_driver pcf8583_driver = {
 	.name		= "PCF8583",
 	.id		= I2C_DRIVERID_PCF8583,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= pcf8583_probe,
 	.detach_client	= pcf8583_detach,
 	.command	= pcf8583_command
--- linux-2.6.15-rc2.orig/drivers/hwmon/adm1021.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/hwmon/adm1021.c	2005-11-26 13:42:27.000000000 +0100
@@ -129,7 +129,6 @@
 	.owner		= THIS_MODULE,
 	.name		= "adm1021",
 	.id		= I2C_DRIVERID_ADM1021,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= adm1021_attach_adapter,
 	.detach_client	= adm1021_detach_client,
 };
--- linux-2.6.15-rc2.orig/drivers/hwmon/adm1025.c	2005-11-26 13:42:21.000000000 +0100
+++ linux-2.6.15-rc2/drivers/hwmon/adm1025.c	2005-11-26 13:42:27.000000000 +0100
@@ -121,7 +121,6 @@
 	.owner		= THIS_MODULE,
 	.name		= "adm1025",
 	.id		= I2C_DRIVERID_ADM1025,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= adm1025_attach_adapter,
 	.detach_client	= adm1025_detach_client,
 };
--- linux-2.6.15-rc2.orig/drivers/hwmon/adm1026.c	2005-11-26 13:42:21.000000000 +0100
+++ linux-2.6.15-rc2/drivers/hwmon/adm1026.c	2005-11-26 13:42:27.000000000 +0100
@@ -310,7 +310,6 @@
 static struct i2c_driver adm1026_driver = {
 	.owner          = THIS_MODULE,
 	.name           = "adm1026",
-	.flags          = I2C_DF_NOTIFY,
 	.attach_adapter = adm1026_attach_adapter,
 	.detach_client  = adm1026_detach_client,
 };
--- linux-2.6.15-rc2.orig/drivers/hwmon/adm1031.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/hwmon/adm1031.c	2005-11-26 13:42:27.000000000 +0100
@@ -107,7 +107,6 @@
 static struct i2c_driver adm1031_driver = {
 	.owner = THIS_MODULE,
 	.name = "adm1031",
-	.flags = I2C_DF_NOTIFY,
 	.attach_adapter = adm1031_attach_adapter,
 	.detach_client = adm1031_detach_client,
 };
--- linux-2.6.15-rc2.orig/drivers/hwmon/adm9240.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/hwmon/adm9240.c	2005-11-26 13:42:27.000000000 +0100
@@ -140,7 +140,6 @@
 	.owner		= THIS_MODULE,
 	.name		= "adm9240",
 	.id		= I2C_DRIVERID_ADM9240,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= adm9240_attach_adapter,
 	.detach_client	= adm9240_detach_client,
 };
--- linux-2.6.15-rc2.orig/drivers/hwmon/asb100.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/hwmon/asb100.c	2005-11-26 13:42:27.000000000 +0100
@@ -220,7 +220,6 @@
 	.owner		= THIS_MODULE,
 	.name		= "asb100",
 	.id		= I2C_DRIVERID_ASB100,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= asb100_attach_adapter,
 	.detach_client	= asb100_detach_client,
 };
--- linux-2.6.15-rc2.orig/drivers/hwmon/atxp1.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/hwmon/atxp1.c	2005-11-26 13:42:27.000000000 +0100
@@ -52,7 +52,6 @@
 static struct i2c_driver atxp1_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "atxp1",
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter = atxp1_attach_adapter,
 	.detach_client	= atxp1_detach_client,
 };
--- linux-2.6.15-rc2.orig/drivers/hwmon/ds1621.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/hwmon/ds1621.c	2005-11-26 13:42:27.000000000 +0100
@@ -92,7 +92,6 @@
 	.owner		= THIS_MODULE,
 	.name		= "ds1621",
 	.id		= I2C_DRIVERID_DS1621,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= ds1621_attach_adapter,
 	.detach_client	= ds1621_detach_client,
 };
--- linux-2.6.15-rc2.orig/drivers/hwmon/fscher.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/hwmon/fscher.c	2005-11-26 13:42:27.000000000 +0100
@@ -121,7 +121,6 @@
 	.owner		= THIS_MODULE,
 	.name		= "fscher",
 	.id		= I2C_DRIVERID_FSCHER,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= fscher_attach_adapter,
 	.detach_client	= fscher_detach_client,
 };
--- linux-2.6.15-rc2.orig/drivers/hwmon/fscpos.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/hwmon/fscpos.c	2005-11-26 13:42:27.000000000 +0100
@@ -103,7 +103,6 @@
 	.owner		= THIS_MODULE,
 	.name		= "fscpos",
 	.id		= I2C_DRIVERID_FSCPOS,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= fscpos_attach_adapter,
 	.detach_client	= fscpos_detach_client,
 };
--- linux-2.6.15-rc2.orig/drivers/hwmon/gl518sm.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/hwmon/gl518sm.c	2005-11-26 13:42:27.000000000 +0100
@@ -154,7 +154,6 @@
 	.owner		= THIS_MODULE,
 	.name		= "gl518sm",
 	.id		= I2C_DRIVERID_GL518,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= gl518_attach_adapter,
 	.detach_client	= gl518_detach_client,
 };
--- linux-2.6.15-rc2.orig/drivers/hwmon/gl520sm.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/hwmon/gl520sm.c	2005-11-26 13:42:27.000000000 +0100
@@ -112,7 +112,6 @@
 	.owner		= THIS_MODULE,
 	.name		= "gl520sm",
 	.id		= I2C_DRIVERID_GL520,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= gl520_attach_adapter,
 	.detach_client	= gl520_detach_client,
 };
--- linux-2.6.15-rc2.orig/drivers/hwmon/it87.c	2005-11-26 13:42:05.000000000 +0100
+++ linux-2.6.15-rc2/drivers/hwmon/it87.c	2005-11-26 13:42:27.000000000 +0100
@@ -237,7 +237,6 @@
 	.owner		= THIS_MODULE,
 	.name		= "it87",
 	.id		= I2C_DRIVERID_IT87,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= it87_attach_adapter,
 	.detach_client	= it87_detach_client,
 };
--- linux-2.6.15-rc2.orig/drivers/hwmon/lm63.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/hwmon/lm63.c	2005-11-26 13:42:27.000000000 +0100
@@ -141,7 +141,6 @@
 static struct i2c_driver lm63_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "lm63",
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= lm63_attach_adapter,
 	.detach_client	= lm63_detach_client,
 };
--- linux-2.6.15-rc2.orig/drivers/hwmon/lm75.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/hwmon/lm75.c	2005-11-26 13:42:27.000000000 +0100
@@ -69,7 +69,6 @@
 	.owner		= THIS_MODULE,
 	.name		= "lm75",
 	.id		= I2C_DRIVERID_LM75,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= lm75_attach_adapter,
 	.detach_client	= lm75_detach_client,
 };
--- linux-2.6.15-rc2.orig/drivers/hwmon/lm77.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/hwmon/lm77.c	2005-11-26 13:42:27.000000000 +0100
@@ -76,7 +76,6 @@
 static struct i2c_driver lm77_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "lm77",
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter = lm77_attach_adapter,
 	.detach_client	= lm77_detach_client,
 };
--- linux-2.6.15-rc2.orig/drivers/hwmon/lm78.c	2005-11-26 13:42:05.000000000 +0100
+++ linux-2.6.15-rc2/drivers/hwmon/lm78.c	2005-11-26 13:42:27.000000000 +0100
@@ -167,7 +167,6 @@
 	.owner		= THIS_MODULE,
 	.name		= "lm78",
 	.id		= I2C_DRIVERID_LM78,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= lm78_attach_adapter,
 	.detach_client	= lm78_detach_client,
 };
--- linux-2.6.15-rc2.orig/drivers/hwmon/lm80.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/hwmon/lm80.c	2005-11-26 13:42:27.000000000 +0100
@@ -146,7 +146,6 @@
 	.owner		= THIS_MODULE,
 	.name		= "lm80",
 	.id		= I2C_DRIVERID_LM80,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= lm80_attach_adapter,
 	.detach_client	= lm80_detach_client,
 };
--- linux-2.6.15-rc2.orig/drivers/hwmon/lm83.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/hwmon/lm83.c	2005-11-26 13:42:27.000000000 +0100
@@ -127,7 +127,6 @@
 	.owner		= THIS_MODULE,
 	.name		= "lm83",
 	.id		= I2C_DRIVERID_LM83,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= lm83_attach_adapter,
 	.detach_client	= lm83_detach_client,
 };
--- linux-2.6.15-rc2.orig/drivers/hwmon/lm85.c	2005-11-26 13:42:22.000000000 +0100
+++ linux-2.6.15-rc2/drivers/hwmon/lm85.c	2005-11-26 13:42:27.000000000 +0100
@@ -383,7 +383,6 @@
 	.owner          = THIS_MODULE,
 	.name           = "lm85",
 	.id             = I2C_DRIVERID_LM85,
-	.flags          = I2C_DF_NOTIFY,
 	.attach_adapter = lm85_attach_adapter,
 	.detach_client  = lm85_detach_client,
 };
--- linux-2.6.15-rc2.orig/drivers/hwmon/lm87.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/hwmon/lm87.c	2005-11-26 13:42:27.000000000 +0100
@@ -164,7 +164,6 @@
 	.owner		= THIS_MODULE,
 	.name		= "lm87",
 	.id		= I2C_DRIVERID_LM87,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= lm87_attach_adapter,
 	.detach_client	= lm87_detach_client,
 };
--- linux-2.6.15-rc2.orig/drivers/hwmon/lm90.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/hwmon/lm90.c	2005-11-26 13:42:27.000000000 +0100
@@ -189,7 +189,6 @@
 	.owner		= THIS_MODULE,
 	.name		= "lm90",
 	.id		= I2C_DRIVERID_LM90,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= lm90_attach_adapter,
 	.detach_client	= lm90_detach_client,
 };
--- linux-2.6.15-rc2.orig/drivers/hwmon/lm92.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/hwmon/lm92.c	2005-11-26 13:42:27.000000000 +0100
@@ -413,7 +413,6 @@
 	.owner		= THIS_MODULE,
 	.name		= "lm92",
 	.id		= I2C_DRIVERID_LM92,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= lm92_attach_adapter,
 	.detach_client	= lm92_detach_client,
 };
--- linux-2.6.15-rc2.orig/drivers/hwmon/max1619.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/hwmon/max1619.c	2005-11-26 13:42:27.000000000 +0100
@@ -92,7 +92,6 @@
 static struct i2c_driver max1619_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "max1619",
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= max1619_attach_adapter,
 	.detach_client	= max1619_detach_client,
 };
--- linux-2.6.15-rc2.orig/drivers/hwmon/w83781d.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/hwmon/w83781d.c	2005-11-26 13:42:27.000000000 +0100
@@ -272,7 +272,6 @@
 	.owner = THIS_MODULE,
 	.name = "w83781d",
 	.id = I2C_DRIVERID_W83781D,
-	.flags = I2C_DF_NOTIFY,
 	.attach_adapter = w83781d_attach_adapter,
 	.detach_client = w83781d_detach_client,
 };
--- linux-2.6.15-rc2.orig/drivers/hwmon/w83792d.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/hwmon/w83792d.c	2005-11-26 13:42:27.000000000 +0100
@@ -318,7 +318,6 @@
 static struct i2c_driver w83792d_driver = {
 	.owner = THIS_MODULE,
 	.name = "w83792d",
-	.flags = I2C_DF_NOTIFY,
 	.attach_adapter = w83792d_attach_adapter,
 	.detach_client = w83792d_detach_client,
 };
--- linux-2.6.15-rc2.orig/drivers/hwmon/w83l785ts.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/hwmon/w83l785ts.c	2005-11-26 13:42:27.000000000 +0100
@@ -95,7 +95,6 @@
 	.owner		= THIS_MODULE,
 	.name		= "w83l785ts",
 	.id		= I2C_DRIVERID_W83L785TS,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= w83l785ts_attach_adapter,
 	.detach_client	= w83l785ts_detach_client,
 };
--- linux-2.6.15-rc2.orig/drivers/i2c/chips/ds1337.c	2005-11-26 13:42:21.000000000 +0100
+++ linux-2.6.15-rc2/drivers/i2c/chips/ds1337.c	2005-11-26 13:42:27.000000000 +0100
@@ -54,7 +54,6 @@
 static struct i2c_driver ds1337_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "ds1337",
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= ds1337_attach_adapter,
 	.detach_client	= ds1337_detach_client,
 	.command	= ds1337_command,
--- linux-2.6.15-rc2.orig/drivers/i2c/chips/ds1374.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/i2c/chips/ds1374.c	2005-11-26 13:42:27.000000000 +0100
@@ -235,7 +235,6 @@
 	.owner = THIS_MODULE,
 	.name = DS1374_DRV_NAME,
 	.id = I2C_DRIVERID_DS1374,
-	.flags = I2C_DF_NOTIFY,
 	.attach_adapter = ds1374_attach,
 	.detach_client = ds1374_detach,
 };
--- linux-2.6.15-rc2.orig/drivers/i2c/chips/eeprom.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/i2c/chips/eeprom.c	2005-11-26 13:42:27.000000000 +0100
@@ -71,7 +71,6 @@
 	.owner		= THIS_MODULE,
 	.name		= "eeprom",
 	.id		= I2C_DRIVERID_EEPROM,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= eeprom_attach_adapter,
 	.detach_client	= eeprom_detach_client,
 };
--- linux-2.6.15-rc2.orig/drivers/i2c/chips/isp1301_omap.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/i2c/chips/isp1301_omap.c	2005-11-26 13:42:27.000000000 +0100
@@ -1636,7 +1636,6 @@
 	.name		= "isp1301_omap",
 	.id		= 1301,		/* FIXME "official", i2c-ids.h */
 	.class		= I2C_CLASS_HWMON,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= isp1301_scan_bus,
 	.detach_client	= isp1301_detach_client,
 };
--- linux-2.6.15-rc2.orig/drivers/i2c/chips/m41t00.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/i2c/chips/m41t00.c	2005-11-26 13:42:27.000000000 +0100
@@ -214,7 +214,6 @@
 	.owner		= THIS_MODULE,
 	.name		= M41T00_DRV_NAME,
 	.id		= I2C_DRIVERID_STM41T00,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= m41t00_attach,
 	.detach_client	= m41t00_detach,
 };
--- linux-2.6.15-rc2.orig/drivers/i2c/chips/max6875.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/i2c/chips/max6875.c	2005-11-26 13:42:27.000000000 +0100
@@ -69,7 +69,6 @@
 static struct i2c_driver max6875_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "max6875",
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= max6875_attach_adapter,
 	.detach_client	= max6875_detach_client,
 };
--- linux-2.6.15-rc2.orig/drivers/i2c/chips/pca9539.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/i2c/chips/pca9539.c	2005-11-26 13:42:27.000000000 +0100
@@ -40,7 +40,6 @@
 static struct i2c_driver pca9539_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "pca9539",
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= pca9539_attach_adapter,
 	.detach_client	= pca9539_detach_client,
 };
--- linux-2.6.15-rc2.orig/drivers/i2c/chips/pcf8574.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/i2c/chips/pcf8574.c	2005-11-26 13:42:27.000000000 +0100
@@ -68,7 +68,6 @@
 	.owner		= THIS_MODULE,
 	.name		= "pcf8574",
 	.id		= I2C_DRIVERID_PCF8574,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= pcf8574_attach_adapter,
 	.detach_client	= pcf8574_detach_client,
 };
--- linux-2.6.15-rc2.orig/drivers/i2c/chips/pcf8591.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/i2c/chips/pcf8591.c	2005-11-26 13:42:27.000000000 +0100
@@ -91,7 +91,6 @@
 	.owner		= THIS_MODULE,
 	.name		= "pcf8591",
 	.id		= I2C_DRIVERID_PCF8591,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= pcf8591_attach_adapter,
 	.detach_client	= pcf8591_detach_client,
 };
--- linux-2.6.15-rc2.orig/drivers/i2c/chips/rtc8564.c	2005-11-26 13:42:23.000000000 +0100
+++ linux-2.6.15-rc2/drivers/i2c/chips/rtc8564.c	2005-11-26 13:42:27.000000000 +0100
@@ -362,7 +362,6 @@
 	.owner		= THIS_MODULE,
 	.name		= "RTC8564",
 	.id		= I2C_DRIVERID_RTC8564,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter = rtc8564_probe,
 	.detach_client	= rtc8564_detach,
 	.command	= rtc8564_command
--- linux-2.6.15-rc2.orig/drivers/i2c/chips/tps65010.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/i2c/chips/tps65010.c	2005-11-26 13:42:27.000000000 +0100
@@ -639,7 +639,6 @@
 static struct i2c_driver tps65010_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "tps65010",
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= tps65010_scan_bus,
 	.detach_client	= __exit_p(tps65010_detach_client),
 };
--- linux-2.6.15-rc2.orig/drivers/i2c/chips/x1205.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/i2c/chips/x1205.c	2005-11-26 13:42:27.000000000 +0100
@@ -107,7 +107,6 @@
 static struct i2c_driver x1205_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "x1205",
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter = &x1205_attach,
 	.detach_client	= &x1205_detach,
 };
--- linux-2.6.15-rc2.orig/drivers/i2c/i2c-core.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/i2c/i2c-core.c	2005-11-26 13:42:27.000000000 +0100
@@ -197,7 +197,7 @@
 	/* inform drivers of new adapters */
 	list_for_each(item,&drivers) {
 		driver = list_entry(item, struct i2c_driver, list);
-		if (driver->flags & I2C_DF_NOTIFY)
+		if (driver->attach_adapter)
 			/* We ignore the return code; if it fails, too bad */
 			driver->attach_adapter(adap);
 	}
@@ -309,7 +309,7 @@
 	pr_debug("i2c-core: driver [%s] registered\n", driver->name);
 
 	/* now look for instances of driver on our adapters */
-	if (driver->flags & I2C_DF_NOTIFY) {
+	if (driver->attach_adapter) {
 		list_for_each(item,&adapters) {
 			adapter = list_entry(item, struct i2c_adapter, list);
 			driver->attach_adapter(adapter);
--- linux-2.6.15-rc2.orig/drivers/i2c/i2c-dev.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/i2c/i2c-dev.c	2005-11-26 13:42:27.000000000 +0100
@@ -484,7 +484,6 @@
 	.owner		= THIS_MODULE,
 	.name		= "dev_driver",
 	.id		= I2C_DRIVERID_I2CDEV,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= i2cdev_attach_adapter,
 	.detach_adapter	= i2cdev_detach_adapter,
 	.detach_client	= i2cdev_detach_client,
--- linux-2.6.15-rc2.orig/drivers/macintosh/therm_adt746x.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/macintosh/therm_adt746x.c	2005-11-26 13:42:27.000000000 +0100
@@ -173,7 +173,6 @@
 static struct i2c_driver thermostat_driver = {  
 	.owner		= THIS_MODULE,
 	.name		= "therm_adt746x",
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= attach_thermostat,
 	.detach_adapter	= detach_thermostat,
 };
--- linux-2.6.15-rc2.orig/drivers/macintosh/therm_pm72.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/macintosh/therm_pm72.c	2005-11-26 13:42:27.000000000 +0100
@@ -285,7 +285,6 @@
 {
 	.owner		= THIS_MODULE,
 	.name		= "therm_pm72",
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= therm_pm72_attach,
 	.detach_adapter	= therm_pm72_detach,
 };
--- linux-2.6.15-rc2.orig/drivers/macintosh/therm_windtunnel.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/macintosh/therm_windtunnel.c	2005-11-26 13:42:27.000000000 +0100
@@ -357,7 +357,6 @@
 	.owner		= THIS_MODULE,
 	.name		= "therm_windtunnel",
 	.id		= I2C_DRIVERID_G4FAN,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter = do_attach,
 	.detach_client	= do_detach,
 };
--- linux-2.6.15-rc2.orig/drivers/macintosh/windfarm_lm75_sensor.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/macintosh/windfarm_lm75_sensor.c	2005-11-26 13:42:27.000000000 +0100
@@ -49,7 +49,6 @@
 static struct i2c_driver wf_lm75_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "wf_lm75",
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= wf_lm75_attach,
 	.detach_client	= wf_lm75_detach,
 };
--- linux-2.6.15-rc2.orig/drivers/media/video/adv7170.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/adv7170.c	2005-11-26 13:42:27.000000000 +0100
@@ -502,7 +502,6 @@
 	.name = "adv7170",	/* name */
 
 	.id = I2C_DRIVERID_ADV7170,
-	.flags = I2C_DF_NOTIFY,
 
 	.attach_adapter = adv7170_attach_adapter,
 	.detach_client = adv7170_detach_client,
--- linux-2.6.15-rc2.orig/drivers/media/video/adv7175.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/adv7175.c	2005-11-26 13:42:27.000000000 +0100
@@ -552,7 +552,6 @@
 	.name = "adv7175",	/* name */
 
 	.id = I2C_DRIVERID_ADV7175,
-	.flags = I2C_DF_NOTIFY,
 
 	.attach_adapter = adv7175_attach_adapter,
 	.detach_client = adv7175_detach_client,
--- linux-2.6.15-rc2.orig/drivers/media/video/bt819.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/bt819.c	2005-11-26 13:42:27.000000000 +0100
@@ -627,7 +627,6 @@
 	.name = "bt819",
 
 	.id = I2C_DRIVERID_BT819,
-	.flags = I2C_DF_NOTIFY,
 
 	.attach_adapter = bt819_attach_adapter,
 	.detach_client = bt819_detach_client,
--- linux-2.6.15-rc2.orig/drivers/media/video/bt832.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/bt832.c	2005-11-26 13:42:27.000000000 +0100
@@ -233,7 +233,6 @@
 	.owner          = THIS_MODULE,
         .name           = "i2c bt832 driver",
         .id             = -1, /* FIXME */
-        .flags          = I2C_DF_NOTIFY,
         .attach_adapter = bt832_probe,
         .detach_client  = bt832_detach,
         .command        = bt832_command,
--- linux-2.6.15-rc2.orig/drivers/media/video/bt856.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/bt856.c	2005-11-26 13:42:27.000000000 +0100
@@ -409,7 +409,6 @@
 	.name = "bt856",
 
 	.id = I2C_DRIVERID_BT856,
-	.flags = I2C_DF_NOTIFY,
 
 	.attach_adapter = bt856_attach_adapter,
 	.detach_client = bt856_detach_client,
--- linux-2.6.15-rc2.orig/drivers/media/video/cs53l32a.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/cs53l32a.c	2005-11-26 13:42:27.000000000 +0100
@@ -218,7 +218,6 @@
 static struct i2c_driver i2c_driver = {
 	.name = "cs53l32a",
 	.id = I2C_DRIVERID_CS53L32A,
-	.flags = I2C_DF_NOTIFY,
 	.attach_adapter = cs53l32a_probe,
 	.detach_client = cs53l32a_detach,
 	.command = cs53l32a_command,
--- linux-2.6.15-rc2.orig/drivers/media/video/cx25840/cx25840-core.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/cx25840/cx25840-core.c	2005-11-26 13:42:27.000000000 +0100
@@ -811,7 +811,6 @@
 	.name = "cx25840",
 
 	.id = I2C_DRIVERID_CX25840,
-	.flags = I2C_DF_NOTIFY,
 
 	.attach_adapter = cx25840_attach_adapter,
 	.detach_client = cx25840_detach_client,
--- linux-2.6.15-rc2.orig/drivers/media/video/indycam.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/indycam.c	2005-11-26 13:42:27.000000000 +0100
@@ -454,7 +454,6 @@
 	.owner		= THIS_MODULE,
 	.name		= "indycam",
 	.id		= I2C_DRIVERID_INDYCAM,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter = indycam_probe,
 	.detach_client	= indycam_detach,
 	.command	= indycam_command,
--- linux-2.6.15-rc2.orig/drivers/media/video/ir-kbd-i2c.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/ir-kbd-i2c.c	2005-11-26 13:42:27.000000000 +0100
@@ -279,7 +279,6 @@
 static struct i2c_driver driver = {
 	.name           = "ir remote kbd driver",
 	.id             = I2C_DRIVERID_EXP3, /* FIXME */
-	.flags          = I2C_DF_NOTIFY,
 	.attach_adapter = ir_probe,
 	.detach_client  = ir_detach,
 };
--- linux-2.6.15-rc2.orig/drivers/media/video/msp3400.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/msp3400.c	2005-11-26 13:42:27.000000000 +0100
@@ -1560,7 +1560,6 @@
 	.owner          = THIS_MODULE,
 	.name           = "msp3400",
         .id             = I2C_DRIVERID_MSP3400,
-        .flags          = I2C_DF_NOTIFY,
         .attach_adapter = msp_probe,
         .detach_client  = msp_detach,
         .command        = msp_command,
--- linux-2.6.15-rc2.orig/drivers/media/video/ovcamchip/ovcamchip_core.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/ovcamchip/ovcamchip_core.c	2005-11-26 13:42:27.000000000 +0100
@@ -414,7 +414,6 @@
 	.name =			"ovcamchip",
 	.id =			I2C_DRIVERID_OVCAMCHIP,
 	.class =		I2C_CLASS_CAM_DIGITAL,
-	.flags =		I2C_DF_NOTIFY,
 	.attach_adapter =	ovcamchip_attach,
 	.detach_client =	ovcamchip_detach,
 	.command =		ovcamchip_command,
--- linux-2.6.15-rc2.orig/drivers/media/video/saa5246a.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/saa5246a.c	2005-11-26 13:42:27.000000000 +0100
@@ -166,7 +166,6 @@
 	.owner 		= THIS_MODULE,
 	.name 		= IF_NAME,		/* name */
 	.id 		= I2C_DRIVERID_SAA5249, /* in i2c.h */
-	.flags 		= I2C_DF_NOTIFY,
 	.attach_adapter = saa5246a_probe,
 	.detach_client  = saa5246a_detach,
 	.command 	= saa5246a_command
--- linux-2.6.15-rc2.orig/drivers/media/video/saa5249.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/saa5249.c	2005-11-26 13:42:27.000000000 +0100
@@ -239,7 +239,6 @@
 	.owner 		= THIS_MODULE,
 	.name 		= IF_NAME,		/* name */
 	.id 		= I2C_DRIVERID_SAA5249, /* in i2c.h */
-	.flags 		= I2C_DF_NOTIFY,
 	.attach_adapter = saa5249_probe,
 	.detach_client  = saa5249_detach,
 	.command 	= saa5249_command
--- linux-2.6.15-rc2.orig/drivers/media/video/saa6588.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/saa6588.c	2005-11-26 13:42:27.000000000 +0100
@@ -499,7 +499,6 @@
 	.owner = THIS_MODULE,
 	.name = "i2c saa6588 driver",
 	.id = -1,		/* FIXME */
-	.flags = I2C_DF_NOTIFY,
 	.attach_adapter = saa6588_probe,
 	.detach_client = saa6588_detach,
 	.command = saa6588_command,
--- linux-2.6.15-rc2.orig/drivers/media/video/saa7110.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/saa7110.c	2005-11-26 13:42:27.000000000 +0100
@@ -591,7 +591,6 @@
 	.name = "saa7110",
 
 	.id = I2C_DRIVERID_SAA7110,
-	.flags = I2C_DF_NOTIFY,
 
 	.attach_adapter = saa7110_attach_adapter,
 	.detach_client = saa7110_detach_client,
--- linux-2.6.15-rc2.orig/drivers/media/video/saa7111.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/saa7111.c	2005-11-26 13:42:27.000000000 +0100
@@ -594,7 +594,6 @@
 	.name = "saa7111",
 
 	.id = I2C_DRIVERID_SAA7111A,
-	.flags = I2C_DF_NOTIFY,
 
 	.attach_adapter = saa7111_attach_adapter,
 	.detach_client = saa7111_detach_client,
--- linux-2.6.15-rc2.orig/drivers/media/video/saa7114.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/saa7114.c	2005-11-26 13:42:27.000000000 +0100
@@ -1208,7 +1208,6 @@
 	.name = "saa7114",
 
 	.id = I2C_DRIVERID_SAA7114,
-	.flags = I2C_DF_NOTIFY,
 
 	.attach_adapter = saa7114_attach_adapter,
 	.detach_client = saa7114_detach_client,
--- linux-2.6.15-rc2.orig/drivers/media/video/saa7115.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/saa7115.c	2005-11-26 13:42:27.000000000 +0100
@@ -1354,7 +1354,6 @@
 static struct i2c_driver i2c_driver_saa7115 = {
 	.name = "saa7115",
 	.id = I2C_DRIVERID_SAA711X,
-	.flags = I2C_DF_NOTIFY,
 	.attach_adapter = saa7115_probe,
 	.detach_client = saa7115_detach,
 	.command = saa7115_command,
--- linux-2.6.15-rc2.orig/drivers/media/video/saa711x.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/saa711x.c	2005-11-26 13:42:27.000000000 +0100
@@ -569,7 +569,6 @@
 	.name = "saa711x",
 
 	.id = I2C_DRIVERID_SAA711X,
-	.flags = I2C_DF_NOTIFY,
 
 	.attach_adapter = saa711x_attach_adapter,
 	.detach_client = saa711x_detach_client,
--- linux-2.6.15-rc2.orig/drivers/media/video/saa7127.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/saa7127.c	2005-11-26 13:42:27.000000000 +0100
@@ -821,7 +821,6 @@
 struct i2c_driver i2c_driver_saa7127 = {
 	.name = "saa7127",
 	.id = I2C_DRIVERID_SAA7127,
-	.flags = I2C_DF_NOTIFY,
 	.attach_adapter = saa7127_probe,
 	.detach_client = saa7127_detach,
 	.command = saa7127_command,
--- linux-2.6.15-rc2.orig/drivers/media/video/saa7134/saa6752hs.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/saa7134/saa6752hs.c	2005-11-26 13:42:27.000000000 +0100
@@ -599,7 +599,6 @@
 	.owner          = THIS_MODULE,
         .name           = "i2c saa6752hs MPEG encoder",
         .id             = I2C_DRIVERID_SAA6752HS,
-        .flags          = I2C_DF_NOTIFY,
         .attach_adapter = saa6752hs_probe,
         .detach_client  = saa6752hs_detach,
         .command        = saa6752hs_command,
--- linux-2.6.15-rc2.orig/drivers/media/video/saa7185.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/saa7185.c	2005-11-26 13:42:27.000000000 +0100
@@ -491,7 +491,6 @@
 	.name = "saa7185",	/* name */
 
 	.id = I2C_DRIVERID_SAA7185B,
-	.flags = I2C_DF_NOTIFY,
 
 	.attach_adapter = saa7185_attach_adapter,
 	.detach_client = saa7185_detach_client,
--- linux-2.6.15-rc2.orig/drivers/media/video/saa7191.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/saa7191.c	2005-11-26 13:42:27.000000000 +0100
@@ -791,7 +791,6 @@
 	.owner		= THIS_MODULE,
 	.name		= "saa7191",
 	.id		= I2C_DRIVERID_SAA7191,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter = saa7191_probe,
 	.detach_client	= saa7191_detach,
 	.command	= saa7191_command
--- linux-2.6.15-rc2.orig/drivers/media/video/tda7432.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/tda7432.c	2005-11-26 13:42:27.000000000 +0100
@@ -504,7 +504,6 @@
 	.owner           = THIS_MODULE,
 	.name            = "i2c tda7432 driver",
 	.id              = I2C_DRIVERID_TDA7432,
-	.flags           = I2C_DF_NOTIFY,
 	.attach_adapter  = tda7432_probe,
 	.detach_client   = tda7432_detach,
 	.command         = tda7432_command,
--- linux-2.6.15-rc2.orig/drivers/media/video/tda9840.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/tda9840.c	2005-11-26 13:42:27.000000000 +0100
@@ -224,7 +224,6 @@
 	.owner	= THIS_MODULE,
 	.name	= "tda9840",
 	.id	= I2C_DRIVERID_TDA9840,
-	.flags	= I2C_DF_NOTIFY,
 	.attach_adapter	= attach,
 	.detach_client	= detach,
 	.command	= command,
--- linux-2.6.15-rc2.orig/drivers/media/video/tda9875.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/tda9875.c	2005-11-26 13:42:27.000000000 +0100
@@ -375,7 +375,6 @@
 	.owner          = THIS_MODULE,
 	.name           = "i2c tda9875 driver",
 	.id             = I2C_DRIVERID_TDA9875,
-	.flags          = I2C_DF_NOTIFY,
 	.attach_adapter = tda9875_probe,
 	.detach_client  = tda9875_detach,
 	.command        = tda9875_command,
--- linux-2.6.15-rc2.orig/drivers/media/video/tda9887.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/tda9887.c	2005-11-26 13:42:27.000000000 +0100
@@ -821,7 +821,6 @@
 	.owner          = THIS_MODULE,
         .name           = "i2c tda9887 driver",
         .id             = -1, /* FIXME */
-        .flags          = I2C_DF_NOTIFY,
         .attach_adapter = tda9887_probe,
         .detach_client  = tda9887_detach,
         .command        = tda9887_command,
--- linux-2.6.15-rc2.orig/drivers/media/video/tea6415c.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/tea6415c.c	2005-11-26 13:42:27.000000000 +0100
@@ -193,7 +193,6 @@
 	.owner	= THIS_MODULE,
 	.name 	= "tea6415c",
 	.id 	= I2C_DRIVERID_TEA6415C,
-	.flags 	= I2C_DF_NOTIFY,
 	.attach_adapter	= attach,
 	.detach_client	= detach,
 	.command	= command,
--- linux-2.6.15-rc2.orig/drivers/media/video/tea6420.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/tea6420.c	2005-11-26 13:42:27.000000000 +0100
@@ -170,7 +170,6 @@
 	.owner	= THIS_MODULE,
 	.name	= "tea6420",
 	.id	= I2C_DRIVERID_TEA6420,
-	.flags	= I2C_DF_NOTIFY,
 	.attach_adapter	= attach,
 	.detach_client	= detach,
 	.command	= command,
--- linux-2.6.15-rc2.orig/drivers/media/video/tuner-3036.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/tuner-3036.c	2005-11-26 13:42:27.000000000 +0100
@@ -178,7 +178,6 @@
 	.owner		=	THIS_MODULE,
 	.name		=	"sab3036",
 	.id		=	I2C_DRIVERID_SAB3036,
-        .flags		=	I2C_DF_NOTIFY,
 	.attach_adapter =	tuner_probe,
 	.detach_client  =	tuner_detach,
 	.command	=	tuner_command
--- linux-2.6.15-rc2.orig/drivers/media/video/tuner-core.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/tuner-core.c	2005-11-26 13:42:27.000000000 +0100
@@ -745,7 +745,6 @@
 	.owner = THIS_MODULE,
 	.name = "tuner",
 	.id = I2C_DRIVERID_TUNER,
-	.flags = I2C_DF_NOTIFY,
 	.attach_adapter = tuner_probe,
 	.detach_client = tuner_detach,
 	.command = tuner_command,
--- linux-2.6.15-rc2.orig/drivers/media/video/tvaudio.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/tvaudio.c	2005-11-26 13:42:27.000000000 +0100
@@ -1705,7 +1705,6 @@
 	.owner           = THIS_MODULE,
 	.name            = "generic i2c audio driver",
 	.id              = I2C_DRIVERID_TVAUDIO,
-	.flags           = I2C_DF_NOTIFY,
 	.attach_adapter  = chip_probe,
 	.detach_client   = chip_detach,
 	.command         = chip_command,
--- linux-2.6.15-rc2.orig/drivers/media/video/tveeprom.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/tveeprom.c	2005-11-26 13:42:27.000000000 +0100
@@ -739,7 +739,6 @@
 	.owner          = THIS_MODULE,
 	.name           = "tveeprom",
 	.id             = I2C_DRIVERID_TVEEPROM,
-	.flags          = I2C_DF_NOTIFY,
 	.attach_adapter = tveeprom_attach_adapter,
 	.detach_client  = tveeprom_detach_client,
 	.command        = tveeprom_command,
--- linux-2.6.15-rc2.orig/drivers/media/video/tvmixer.c	2005-11-26 13:42:26.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/tvmixer.c	2005-11-26 13:42:27.000000000 +0100
@@ -232,7 +232,6 @@
 #endif
 	.name            = "tv card mixer driver",
 	.id              = I2C_DRIVERID_TVMIXER,
-	.flags           = I2C_DF_NOTIFY,
 	.detach_adapter  = tvmixer_adapters,
 	.attach_adapter  = tvmixer_adapters,
 	.detach_client   = tvmixer_clients,
--- linux-2.6.15-rc2.orig/drivers/media/video/tvp5150.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/tvp5150.c	2005-11-26 13:42:27.000000000 +0100
@@ -807,7 +807,6 @@
 
 	/* FIXME */
 	.id = I2C_DRIVERID_SAA7110,
-	.flags = I2C_DF_NOTIFY,
 
 	.attach_adapter = tvp5150_attach_adapter,
 	.detach_client = tvp5150_detach_client,
--- linux-2.6.15-rc2.orig/drivers/media/video/vpx3220.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/vpx3220.c	2005-11-26 13:42:27.000000000 +0100
@@ -726,7 +726,6 @@
 	.name = "vpx3220",
 
 	.id = I2C_DRIVERID_VPX3220,
-	.flags = I2C_DF_NOTIFY,
 
 	.attach_adapter = vpx3220_attach_adapter,
 	.detach_client = vpx3220_detach_client,
--- linux-2.6.15-rc2.orig/drivers/media/video/wm8775.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/wm8775.c	2005-11-26 13:42:27.000000000 +0100
@@ -236,7 +236,6 @@
 	.name = "wm8775",
 
 	.id = I2C_DRIVERID_WM8775,
-	.flags = I2C_DF_NOTIFY,
 
 	.attach_adapter = wm8775_probe,
 	.detach_client = wm8775_detach,
--- linux-2.6.15-rc2.orig/drivers/video/matrox/matroxfb_maven.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/drivers/video/matrox/matroxfb_maven.c	2005-11-26 13:42:27.000000000 +0100
@@ -1296,7 +1296,6 @@
 	.owner		= THIS_MODULE,
 	.name		= "maven",
 	.id		= I2C_DRIVERID_MGATVO,
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= maven_attach_adapter,
 	.detach_client	= maven_detach_client,
 	.command	= maven_command,
--- linux-2.6.15-rc2.orig/include/linux/i2c.h	2005-11-26 13:42:26.000000000 +0100
+++ linux-2.6.15-rc2/include/linux/i2c.h	2005-11-26 13:42:27.000000000 +0100
@@ -251,7 +251,6 @@
 }
 
 /*flags for the driver struct: */
-#define I2C_DF_NOTIFY	0x01		/* notify on bus (de/a)ttaches 	*/
 
 /*flags for the client struct: */
 #define I2C_CLIENT_ALLOW_USE		0x01	/* Client allows access */
--- linux-2.6.15-rc2.orig/sound/oss/dmasound/dac3550a.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/sound/oss/dmasound/dac3550a.c	2005-11-26 13:42:27.000000000 +0100
@@ -44,7 +44,6 @@
 	.owner			= THIS_MODULE,
 	.name			= "DAC3550A driver  V " DACA_VERSION,
 	.id			= I2C_DRIVERID_DACA,
-	.flags			= I2C_DF_NOTIFY,
 	.attach_adapter		= daca_attach_adapter,
 	.detach_client		= daca_detach_client,
 };
--- linux-2.6.15-rc2.orig/sound/oss/dmasound/tas_common.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/sound/oss/dmasound/tas_common.c	2005-11-26 13:42:27.000000000 +0100
@@ -49,7 +49,6 @@
 struct i2c_driver tas_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "tas",
-	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= tas_attach_adapter,
 	.detach_client	= tas_detach_client,
 };
--- linux-2.6.15-rc2.orig/sound/ppc/keywest.c	2005-11-26 13:33:15.000000000 +0100
+++ linux-2.6.15-rc2/sound/ppc/keywest.c	2005-11-26 13:42:27.000000000 +0100
@@ -43,7 +43,6 @@
 struct i2c_driver keywest_driver = {  
 	.name = "PMac Keywest Audio",
 	.id = I2C_DRIVERID_KEYWEST,
-	.flags = I2C_DF_NOTIFY,
 	.attach_adapter = &keywest_attach_adapter,
 	.detach_client = &keywest_detach_client,
 };

-- 
Jean Delvare
