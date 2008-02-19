From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Tue, 19 Feb 2008 03:10:27 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: normal_i2c arrays should be const
Message-Id: <20080219031027.GB2859@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080218033459.GB29415@jupiter.solarsys.private>
In-Reply-To: <20080218033459.GB29415@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2008-02-18 10:50:23 +0100]:
> Hi Mark,
> 
> On Sun, 17 Feb 2008 22:34:59 -0500, Mark M. Hoffman wrote:
> > commit 556782f2a261fe87d3aa820d24116660b16f3192
> > Author: Mark M. Hoffman <mhoffman@lightlink.com>
> > Date:   Sun Feb 17 22:28:03 2008 -0500
> > 
> >     hwmon: normal_i2c arrays should be const
> >     
> >     Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>
> > 
> 
> Looks good to me from a functional point of view.
> 
> Acked-by: Jean Delvare <khali@linux-fr.org>
> 
> Note though that checkpatch spits the following warnings, which you may
> want to fix:

Ah, thanks.  I thought I made those edits in an 80 column window, but I
guess it was off by 2 or 3.  Updated patch here (including adt7473) for
the sake of completeness...


commit 25e9c86d5a6d82ea45eb680fc66bf73ac5e50dff
Author: Mark M. Hoffman <mhoffman@lightlink.com>
Date:   Sun Feb 17 22:28:03 2008 -0500

    hwmon: normal_i2c arrays should be const
    
    Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>

diff --git a/drivers/hwmon/ad7418.c b/drivers/hwmon/ad7418.c
index fcd7fe7..466b9ee 100644
--- a/drivers/hwmon/ad7418.c
+++ b/drivers/hwmon/ad7418.c
@@ -26,7 +26,7 @@
 #define DRV_VERSION "0.3"
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { 0x28, I2C_CLIENT_END };
+static const unsigned short normal_i2c[] = { 0x28, I2C_CLIENT_END };
 /* Insmod parameters */
 I2C_CLIENT_INSMOD_3(ad7416, ad7417, ad7418);
 
diff --git a/drivers/hwmon/adm1021.c b/drivers/hwmon/adm1021.c
index b96be77..ecbf694 100644
--- a/drivers/hwmon/adm1021.c
+++ b/drivers/hwmon/adm1021.c
@@ -31,10 +31,8 @@
 
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { 0x18, 0x19, 0x1a,
-					0x29, 0x2a, 0x2b,
-					0x4c, 0x4d, 0x4e,
-					I2C_CLIENT_END };
+static const unsigned short normal_i2c[] = {
+	0x18, 0x19, 0x1a, 0x29, 0x2a, 0x2b, 0x4c, 0x4d, 0x4e, I2C_CLIENT_END };
 
 /* Insmod parameters */
 I2C_CLIENT_INSMOD_8(adm1021, adm1023, max1617, max1617a, thmc10, lm84, gl523sm,
diff --git a/drivers/hwmon/adm1025.c b/drivers/hwmon/adm1025.c
index e96c372..1d76de7 100644
--- a/drivers/hwmon/adm1025.c
+++ b/drivers/hwmon/adm1025.c
@@ -62,7 +62,7 @@
  * NE1619 has two possible addresses: 0x2c and 0x2d.
  */
 
-static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
+static const unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
 
 /*
  * Insmod parameters
diff --git a/drivers/hwmon/adm1026.c b/drivers/hwmon/adm1026.c
index b3e6b06..904c6ce 100644
--- a/drivers/hwmon/adm1026.c
+++ b/drivers/hwmon/adm1026.c
@@ -35,7 +35,7 @@
 #include <linux/mutex.h>
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
+static const unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
 
 /* Insmod parameters */
 I2C_CLIENT_INSMOD_1(adm1026);
diff --git a/drivers/hwmon/adm1029.c b/drivers/hwmon/adm1029.c
index 0bc897d..2c6608d 100644
--- a/drivers/hwmon/adm1029.c
+++ b/drivers/hwmon/adm1029.c
@@ -39,10 +39,8 @@
  * Addresses to scan
  */
 
-static unsigned short normal_i2c[] = {
-	0x28, 0x29, 0x2a,
-	0x2b, 0x2c, 0x2d,
-	0x2e, 0x2f, I2C_CLIENT_END
+static const unsigned short normal_i2c[] = { 0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d,
+						0x2e, 0x2f, I2C_CLIENT_END
 };
 
 /*
diff --git a/drivers/hwmon/adm1031.c b/drivers/hwmon/adm1031.c
index 5aaad36..2bffcab 100644
--- a/drivers/hwmon/adm1031.c
+++ b/drivers/hwmon/adm1031.c
@@ -61,7 +61,7 @@
 #define ADM1031_CONF2_TEMP_ENABLE(chan)	(0x10 << (chan))
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
+static const unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
 
 /* Insmod parameters */
 I2C_CLIENT_INSMOD_2(adm1030, adm1031);
diff --git a/drivers/hwmon/adm9240.c b/drivers/hwmon/adm9240.c
index 7671d2b..149ef25 100644
--- a/drivers/hwmon/adm9240.c
+++ b/drivers/hwmon/adm9240.c
@@ -52,7 +52,7 @@
 #include <linux/mutex.h>
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, 0x2f,
+static const unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, 0x2f,
 					I2C_CLIENT_END };
 
 /* Insmod parameters */
diff --git a/drivers/hwmon/ads7828.c b/drivers/hwmon/ads7828.c
index 6b8a73e..ed71a8b 100644
--- a/drivers/hwmon/ads7828.c
+++ b/drivers/hwmon/ads7828.c
@@ -44,7 +44,7 @@
 #define ADS7828_INT_VREF_MV 2500 /* Internal vref is 2.5V, 2500mV */
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b,
+static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b,
 	I2C_CLIENT_END };
 
 /* Insmod parameters */
diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
index 747693a..6b5325f 100644
--- a/drivers/hwmon/adt7470.c
+++ b/drivers/hwmon/adt7470.c
@@ -30,7 +30,7 @@
 #include <linux/log2.h>
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { 0x2C, 0x2E, 0x2F, I2C_CLIENT_END };
+static const unsigned short normal_i2c[] = { 0x2C, 0x2E, 0x2F, I2C_CLIENT_END };
 
 /* Insmod parameters */
 I2C_CLIENT_INSMOD_1(adt7470);
diff --git a/drivers/hwmon/adt7473.c b/drivers/hwmon/adt7473.c
index a3daeef..9587869 100644
--- a/drivers/hwmon/adt7473.c
+++ b/drivers/hwmon/adt7473.c
@@ -30,7 +30,7 @@
 #include <linux/log2.h>
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { 0x2C, 0x2D, 0x2E, I2C_CLIENT_END };
+static const unsigned short normal_i2c[] = { 0x2C, 0x2D, 0x2E, I2C_CLIENT_END };
 
 /* Insmod parameters */
 I2C_CLIENT_INSMOD_1(adt7473);
diff --git a/drivers/hwmon/asb100.c b/drivers/hwmon/asb100.c
index 950cea8..84712a2 100644
--- a/drivers/hwmon/asb100.c
+++ b/drivers/hwmon/asb100.c
@@ -49,7 +49,7 @@
 #include "lm75.h"
 
 /* I2C addresses to scan */
-static unsigned short normal_i2c[] = { 0x2d, I2C_CLIENT_END };
+static const unsigned short normal_i2c[] = { 0x2d, I2C_CLIENT_END };
 
 /* Insmod parameters */
 I2C_CLIENT_INSMOD_1(asb100);
diff --git a/drivers/hwmon/atxp1.c b/drivers/hwmon/atxp1.c
index cce3350..01c17e3 100644
--- a/drivers/hwmon/atxp1.c
+++ b/drivers/hwmon/atxp1.c
@@ -42,7 +42,7 @@ MODULE_AUTHOR("Sebastian Witt <se.witt@gmx.net>");
 #define ATXP1_VIDMASK	0x1f
 #define ATXP1_GPIO1MASK	0x0f
 
-static unsigned short normal_i2c[] = { 0x37, 0x4e, I2C_CLIENT_END };
+static const unsigned short normal_i2c[] = { 0x37, 0x4e, I2C_CLIENT_END };
 
 I2C_CLIENT_INSMOD_1(atxp1);
 
diff --git a/drivers/hwmon/dme1737.c b/drivers/hwmon/dme1737.c
index ddddd9f..7673f65 100644
--- a/drivers/hwmon/dme1737.c
+++ b/drivers/hwmon/dme1737.c
@@ -49,7 +49,7 @@ module_param(force_id, ushort, 0);
 MODULE_PARM_DESC(force_id, "Override the detected device ID");
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = {0x2c, 0x2d, 0x2e, I2C_CLIENT_END};
+static const unsigned short normal_i2c[] = {0x2c, 0x2d, 0x2e, I2C_CLIENT_END};
 
 /* Insmod parameters */
 I2C_CLIENT_INSMOD_1(dme1737);
diff --git a/drivers/hwmon/ds1621.c b/drivers/hwmon/ds1621.c
index 3f5163d..5f300ff 100644
--- a/drivers/hwmon/ds1621.c
+++ b/drivers/hwmon/ds1621.c
@@ -34,7 +34,7 @@
 #include "lm75.h"
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b, 0x4c,
+static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b, 0x4c,
 					0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
 
 /* Insmod parameters */
diff --git a/drivers/hwmon/f75375s.c b/drivers/hwmon/f75375s.c
index 6892f76..1464338 100644
--- a/drivers/hwmon/f75375s.c
+++ b/drivers/hwmon/f75375s.c
@@ -37,7 +37,7 @@
 #include <linux/f75375s.h>
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { 0x2d, 0x2e, I2C_CLIENT_END };
+static const unsigned short normal_i2c[] = { 0x2d, 0x2e, I2C_CLIENT_END };
 
 /* Insmod parameters */
 I2C_CLIENT_INSMOD_2(f75373, f75375);
diff --git a/drivers/hwmon/fscher.c b/drivers/hwmon/fscher.c
index 721c701..ed26b66 100644
--- a/drivers/hwmon/fscher.c
+++ b/drivers/hwmon/fscher.c
@@ -40,7 +40,7 @@
  * Addresses to scan
  */
 
-static unsigned short normal_i2c[] = { 0x73, I2C_CLIENT_END };
+static const unsigned short normal_i2c[] = { 0x73, I2C_CLIENT_END };
 
 /*
  * Insmod parameters
diff --git a/drivers/hwmon/fschmd.c b/drivers/hwmon/fschmd.c
index b7c9eef..bd89d27 100644
--- a/drivers/hwmon/fschmd.c
+++ b/drivers/hwmon/fschmd.c
@@ -44,7 +44,7 @@
 #include <linux/dmi.h>
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { 0x73, I2C_CLIENT_END };
+static const unsigned short normal_i2c[] = { 0x73, I2C_CLIENT_END };
 
 /* Insmod parameters */
 I2C_CLIENT_INSMOD_5(fscpos, fscher, fscscy, fschrc, fschmd);
diff --git a/drivers/hwmon/fscpos.c b/drivers/hwmon/fscpos.c
index 2f10753..00f4848 100644
--- a/drivers/hwmon/fscpos.c
+++ b/drivers/hwmon/fscpos.c
@@ -43,7 +43,7 @@
 /*
  * Addresses to scan
  */
-static unsigned short normal_i2c[] = { 0x73, I2C_CLIENT_END };
+static const unsigned short normal_i2c[] = { 0x73, I2C_CLIENT_END };
 
 /*
  * Insmod parameters
diff --git a/drivers/hwmon/gl518sm.c b/drivers/hwmon/gl518sm.c
index 3b1ac48..33e9e8a 100644
--- a/drivers/hwmon/gl518sm.c
+++ b/drivers/hwmon/gl518sm.c
@@ -44,7 +44,7 @@
 #include <linux/sysfs.h>
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { 0x2c, 0x2d, I2C_CLIENT_END };
+static const unsigned short normal_i2c[] = { 0x2c, 0x2d, I2C_CLIENT_END };
 
 /* Insmod parameters */
 I2C_CLIENT_INSMOD_2(gl518sm_r00, gl518sm_r80);
diff --git a/drivers/hwmon/gl520sm.c b/drivers/hwmon/gl520sm.c
index 03ecdc3..8984ef1 100644
--- a/drivers/hwmon/gl520sm.c
+++ b/drivers/hwmon/gl520sm.c
@@ -39,7 +39,7 @@ module_param(extra_sensor_type, ushort, 0);
 MODULE_PARM_DESC(extra_sensor_type, "Type of extra sensor (0=autodetect, 1=temperature, 2=voltage)");
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { 0x2c, 0x2d, I2C_CLIENT_END };
+static const unsigned short normal_i2c[] = { 0x2c, 0x2d, I2C_CLIENT_END };
 
 /* Insmod parameters */
 I2C_CLIENT_INSMOD_1(gl520sm);
diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
index 650b07d..1162870 100644
--- a/drivers/hwmon/lm63.c
+++ b/drivers/hwmon/lm63.c
@@ -53,7 +53,7 @@
  * Address is fully defined internally and cannot be changed.
  */
 
-static unsigned short normal_i2c[] = { 0x4c, I2C_CLIENT_END };
+static const unsigned short normal_i2c[] = { 0x4c, I2C_CLIENT_END };
 
 /*
  * Insmod parameters
diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index e5c35a3..115f409 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -31,7 +31,7 @@
 
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b, 0x4c,
+static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b, 0x4c,
 					0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
 
 /* Insmod parameters */
diff --git a/drivers/hwmon/lm77.c b/drivers/hwmon/lm77.c
index 459b70a..36d5a8c 100644
--- a/drivers/hwmon/lm77.c
+++ b/drivers/hwmon/lm77.c
@@ -36,7 +36,8 @@
 #include <linux/mutex.h>
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b, I2C_CLIENT_END };
+static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b,
+						I2C_CLIENT_END };
 
 /* Insmod parameters */
 I2C_CLIENT_INSMOD_1(lm77);
diff --git a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
index 0a9eb1f..ed7859f 100644
--- a/drivers/hwmon/lm78.c
+++ b/drivers/hwmon/lm78.c
@@ -37,8 +37,8 @@
 static struct platform_device *pdev;
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { 0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d,
-				       0x2e, 0x2f, I2C_CLIENT_END };
+static const unsigned short normal_i2c[] = { 0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d,
+						0x2e, 0x2f, I2C_CLIENT_END };
 static unsigned short isa_address = 0x290;
 
 /* Insmod parameters */
diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
index a2ca055..26c91c9 100644
--- a/drivers/hwmon/lm80.c
+++ b/drivers/hwmon/lm80.c
@@ -32,8 +32,8 @@
 #include <linux/mutex.h>
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { 0x28, 0x29, 0x2a, 0x2b, 0x2c,
-					0x2d, 0x2e, 0x2f, I2C_CLIENT_END };
+static const unsigned short normal_i2c[] = { 0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d,
+						0x2e, 0x2f, I2C_CLIENT_END };
 
 /* Insmod parameters */
 I2C_CLIENT_INSMOD_1(lm80);
diff --git a/drivers/hwmon/lm83.c b/drivers/hwmon/lm83.c
index 6e8903a..6a8642f 100644
--- a/drivers/hwmon/lm83.c
+++ b/drivers/hwmon/lm83.c
@@ -48,10 +48,8 @@
  * addresses.
  */
 
-static unsigned short normal_i2c[] = { 0x18, 0x19, 0x1a,
-					0x29, 0x2a, 0x2b,
-					0x4c, 0x4d, 0x4e,
-					I2C_CLIENT_END };
+static const unsigned short normal_i2c[] = {
+	0x18, 0x19, 0x1a, 0x29, 0x2a, 0x2b, 0x4c, 0x4d, 0x4e, I2C_CLIENT_END };
 
 /*
  * Insmod parameters
diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
index 4bb0f29..182fe6a 100644
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -35,7 +35,7 @@
 #include <linux/mutex.h>
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
+static const unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
 
 /* Insmod parameters */
 I2C_CLIENT_INSMOD_6(lm85b, lm85c, adm1027, adt7463, emc6d100, emc6d102);
diff --git a/drivers/hwmon/lm87.c b/drivers/hwmon/lm87.c
index 8ee07c5..e1c183f 100644
--- a/drivers/hwmon/lm87.c
+++ b/drivers/hwmon/lm87.c
@@ -73,7 +73,7 @@
  * LM87 has three possible addresses: 0x2c, 0x2d and 0x2e.
  */
 
-static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
+static const unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
 
 /*
  * Insmod parameters
diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index f7ec95b..d1a3da3 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -101,10 +101,8 @@
  * 0x4c, 0x4d or 0x4e.
  */
 
-static unsigned short normal_i2c[] = { 0x18, 0x19, 0x1a,
-				       0x29, 0x2a, 0x2b,
-				       0x4c, 0x4d, 0x4e,
-				       I2C_CLIENT_END };
+static const unsigned short normal_i2c[] = {
+	0x18, 0x19, 0x1a, 0x29, 0x2a, 0x2b, 0x4c, 0x4d, 0x4e, I2C_CLIENT_END };
 
 /*
  * Insmod parameters
diff --git a/drivers/hwmon/lm92.c b/drivers/hwmon/lm92.c
index a2b8041..c31942e 100644
--- a/drivers/hwmon/lm92.c
+++ b/drivers/hwmon/lm92.c
@@ -51,8 +51,8 @@
 
 /* The LM92 and MAX6635 have 2 two-state pins for address selection,
    resulting in 4 possible addresses. */
-static unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b,
-				       I2C_CLIENT_END };
+static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b,
+						I2C_CLIENT_END };
 
 /* Insmod parameters */
 I2C_CLIENT_INSMOD_1(lm92);
diff --git a/drivers/hwmon/lm93.c b/drivers/hwmon/lm93.c
index ea61946..5e678f5 100644
--- a/drivers/hwmon/lm93.c
+++ b/drivers/hwmon/lm93.c
@@ -142,7 +142,7 @@
 		I2C_FUNC_SMBUS_WORD_DATA)
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
+static const unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
 
 /* Insmod parameters */
 I2C_CLIENT_INSMOD_1(lm93);
diff --git a/drivers/hwmon/max1619.c b/drivers/hwmon/max1619.c
index 3428034..7e7267a 100644
--- a/drivers/hwmon/max1619.c
+++ b/drivers/hwmon/max1619.c
@@ -37,10 +37,8 @@
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
 
-static unsigned short normal_i2c[] = { 0x18, 0x19, 0x1a,
-					0x29, 0x2a, 0x2b,
-					0x4c, 0x4d, 0x4e,
-					I2C_CLIENT_END };
+static const unsigned short normal_i2c[] = {
+	0x18, 0x19, 0x1a, 0x29, 0x2a, 0x2b, 0x4c, 0x4d, 0x4e, I2C_CLIENT_END };
 
 /*
  * Insmod parameters
diff --git a/drivers/hwmon/max6650.c b/drivers/hwmon/max6650.c
index 755570c..52d528b 100644
--- a/drivers/hwmon/max6650.c
+++ b/drivers/hwmon/max6650.c
@@ -44,7 +44,8 @@
  * Addresses to scan. There are four disjoint possibilities, by pin config.
  */
 
-static unsigned short normal_i2c[] = {0x1b, 0x1f, 0x48, 0x4b, I2C_CLIENT_END};
+static const unsigned short normal_i2c[] = {0x1b, 0x1f, 0x48, 0x4b,
+						I2C_CLIENT_END};
 
 /*
  * Insmod parameters
diff --git a/drivers/hwmon/smsc47m192.c b/drivers/hwmon/smsc47m192.c
index 8b0c188..3c9db65 100644
--- a/drivers/hwmon/smsc47m192.c
+++ b/drivers/hwmon/smsc47m192.c
@@ -34,7 +34,7 @@
 #include <linux/mutex.h>
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { 0x2c, 0x2d, I2C_CLIENT_END };
+static const unsigned short normal_i2c[] = { 0x2c, 0x2d, I2C_CLIENT_END };
 
 /* Insmod parameters */
 I2C_CLIENT_INSMOD_1(smsc47m192);
diff --git a/drivers/hwmon/thmc50.c b/drivers/hwmon/thmc50.c
index a42a03c..76a3859 100644
--- a/drivers/hwmon/thmc50.c
+++ b/drivers/hwmon/thmc50.c
@@ -32,7 +32,7 @@
 MODULE_LICENSE("GPL");
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
+static const unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
 
 /* Insmod parameters */
 I2C_CLIENT_INSMOD_2(thmc50, adm1022);
diff --git a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
index 7421f6e..5c85670 100644
--- a/drivers/hwmon/w83781d.c
+++ b/drivers/hwmon/w83781d.c
@@ -53,8 +53,8 @@
 static struct platform_device *pdev;
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { 0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d,
-				       0x2e, 0x2f, I2C_CLIENT_END };
+static const unsigned short normal_i2c[] = { 0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d,
+						0x2e, 0x2f, I2C_CLIENT_END };
 static unsigned short isa_address = 0x290;
 
 /* Insmod parameters */
diff --git a/drivers/hwmon/w83791d.c b/drivers/hwmon/w83791d.c
index 85bd21e..85077c4 100644
--- a/drivers/hwmon/w83791d.c
+++ b/drivers/hwmon/w83791d.c
@@ -47,7 +47,8 @@
 #define NUMBER_OF_TEMPIN	3
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, 0x2f, I2C_CLIENT_END };
+static const unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, 0x2f,
+						I2C_CLIENT_END };
 
 /* Insmod parameters */
 I2C_CLIENT_INSMOD_1(w83791d);
diff --git a/drivers/hwmon/w83792d.c b/drivers/hwmon/w83792d.c
index 007449d..299629d 100644
--- a/drivers/hwmon/w83792d.c
+++ b/drivers/hwmon/w83792d.c
@@ -46,7 +46,8 @@
 #include <linux/sysfs.h>
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, 0x2f, I2C_CLIENT_END };
+static const unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, 0x2f,
+						I2C_CLIENT_END };
 
 /* Insmod parameters */
 I2C_CLIENT_INSMOD_1(w83792d);
diff --git a/drivers/hwmon/w83793.c b/drivers/hwmon/w83793.c
index 3ba1d6b..ee35af9 100644
--- a/drivers/hwmon/w83793.c
+++ b/drivers/hwmon/w83793.c
@@ -37,7 +37,8 @@
 #include <linux/mutex.h>
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, 0x2f, I2C_CLIENT_END };
+static const unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, 0x2f,
+						I2C_CLIENT_END };
 
 /* Insmod parameters */
 I2C_CLIENT_INSMOD_1(w83793);
diff --git a/drivers/hwmon/w83l785ts.c b/drivers/hwmon/w83l785ts.c
index 1d6259d..77f2d48 100644
--- a/drivers/hwmon/w83l785ts.c
+++ b/drivers/hwmon/w83l785ts.c
@@ -49,7 +49,7 @@
  * Address is fully defined internally and cannot be changed.
  */
 
-static unsigned short normal_i2c[] = { 0x2e, I2C_CLIENT_END };
+static const unsigned short normal_i2c[] = { 0x2e, I2C_CLIENT_END };
 
 /*
  * Insmod parameters
diff --git a/drivers/hwmon/w83l786ng.c b/drivers/hwmon/w83l786ng.c
index 1dbee4f..41e22dd 100644
--- a/drivers/hwmon/w83l786ng.c
+++ b/drivers/hwmon/w83l786ng.c
@@ -35,7 +35,7 @@
 #include <linux/mutex.h>
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { 0x2e, 0x2f, I2C_CLIENT_END };
+static const unsigned short normal_i2c[] = { 0x2e, 0x2f, I2C_CLIENT_END };
 
 /* Insmod parameters */
 I2C_CLIENT_INSMOD_1(w83l786ng);
-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
