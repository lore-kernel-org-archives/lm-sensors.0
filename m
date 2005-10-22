From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 22 Oct 2005 15:48:28 +0000
Subject: [lm-sensors] [PATCH 2.6] i2c: Fix incorrect ID uses
Message-Id: <20051022154830.0b7688ab.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I am enqueuing the following patch. Driver authors are invited to Ack
their respective parts, or voice in if anything doesn't look OK.

Thanks.

Fix several incorrect uses and redefinitions of i2c IDs.
In particular:
* i2c algorithm IDs are gone;
* i2c IDs must not be defined outside of i2c-id.h.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
CC: Henk Vergonet <henk@god.dyndns.org>
CC: Antonino Daplas <adaplas@pol.net>
CC: Mark McClelland <mark@alpha.dyndns.org>
CC: Ladislav Michl <ladis@linux-mips.org>
CC: Mikael Nousiainen <tmnousia@cc.hut.fi>

---
 drivers/i2c/busses/i2c-prosavage.c |    5 -----
 drivers/media/video/indycam.c      |    4 +---
 drivers/media/video/saa7191.c      |    8 +++-----
 drivers/video/i810/i810-i2c.c      |    5 +----
 include/media/ovcamchip.h          |   14 --------------
 5 files changed, 5 insertions(+), 31 deletions(-)

--- linux-2.6.14-rc4.orig/drivers/i2c/busses/i2c-prosavage.c	2005-10-17 21:08:53.000000000 +0200
+++ linux-2.6.14-rc4/drivers/i2c/busses/i2c-prosavage.c	2005-10-22 14:23:00.000000000 +0200
@@ -83,11 +83,6 @@
 /*
  * i2c configuration
  */
-#ifndef I2C_HW_B_S3VIA
-#define I2C_HW_B_S3VIA	0x18	/* S3VIA ProSavage adapter		*/
-#endif
-
-/* delays */
 #define CYCLE_DELAY	10
 #define TIMEOUT		(HZ / 2)
 
--- linux-2.6.14-rc4.orig/drivers/media/video/indycam.c	2005-10-18 22:49:10.000000000 +0200
+++ linux-2.6.14-rc4/drivers/media/video/indycam.c	2005-10-22 14:23:00.000000000 +0200
@@ -44,8 +44,6 @@
 #define indycam_regdump(client)
 #endif
 
-#define VINO_ADAPTER	(I2C_ALGO_SGI | I2C_HW_SGI_VINO)
-
 struct indycam {
 	struct i2c_client *client;
 	int version;
@@ -300,7 +298,7 @@
 static int indycam_probe(struct i2c_adapter *adap)
 {
 	/* Indy specific crap */
-	if (adap->id = VINO_ADAPTER)
+	if (adap->id = I2C_HW_SGI_VINO)
 		return indycam_attach(adap, INDYCAM_ADDR, 0);
 	/* Feel free to add probe here :-) */
 	return -ENODEV;
--- linux-2.6.14-rc4.orig/drivers/media/video/saa7191.c	2005-10-18 22:49:10.000000000 +0200
+++ linux-2.6.14-rc4/drivers/media/video/saa7191.c	2005-10-22 14:23:00.000000000 +0200
@@ -33,8 +33,6 @@
 MODULE_AUTHOR("Mikael Nousiainen <tmnousia@cc.hut.fi>");
 MODULE_LICENSE("GPL");
 
-#define VINO_ADAPTER	(I2C_ALGO_SGI | I2C_HW_SGI_VINO)
-
 struct saa7191 {
 	struct i2c_client *client;
 
@@ -337,7 +335,7 @@
 static int saa7191_probe(struct i2c_adapter *adap)
 {
 	/* Always connected to VINO */
-	if (adap->id = VINO_ADAPTER)
+	if (adap->id = I2C_HW_SGI_VINO)
 		return saa7191_attach(adap, SAA7191_ADDR, 0);
 	/* Feel free to add probe here :-) */
 	return -ENODEV;
@@ -364,7 +362,7 @@
 
 		cap->flags  = VIDEO_DECODER_PAL | VIDEO_DECODER_NTSC |
 			      VIDEO_DECODER_SECAM | VIDEO_DECODER_AUTO;
-		cap->inputs = (client->adapter->id = VINO_ADAPTER) ? 2 : 1;
+		cap->inputs = (client->adapter->id = I2C_HW_SGI_VINO) ? 2 : 1;
 		cap->outputs = 1;
 		break;
 	}
@@ -422,7 +420,7 @@
 		int *iarg = arg;
 
 		switch (client->adapter->id) {
-		case VINO_ADAPTER:
+		case I2C_HW_SGI_VINO:
 			return saa7191_set_input(client, *iarg);
 		default:
 			if (*iarg != 0)
--- linux-2.6.14-rc4.orig/drivers/video/i810/i810-i2c.c	2005-10-01 11:01:06.000000000 +0200
+++ linux-2.6.14-rc4/drivers/video/i810/i810-i2c.c	2005-10-22 15:06:24.000000000 +0200
@@ -128,8 +128,6 @@
 	return (0 != (i810_readl(mmio, GPIOA) & SDA_VAL_IN));
 }
 
-#define I2C_ALGO_DDC_I810   0x0e0000
-#define I2C_ALGO_I2C_I810   0x0f0000
 static int i810_setup_i2c_bus(struct i810fb_i2c_chan *chan, const char *name,
 			      int conn)
 {
@@ -139,16 +137,15 @@
         chan->adapter.owner             = THIS_MODULE;
         chan->adapter.algo_data         = &chan->algo;
         chan->adapter.dev.parent        = &chan->par->dev->dev;
+	chan->adapter.id		= I2C_HW_B_I810;
 	switch (conn) {
 	case 1:
-		chan->adapter.id                = I2C_ALGO_DDC_I810;
 		chan->algo.setsda               = i810ddc_setsda;
 		chan->algo.setscl               = i810ddc_setscl;
 		chan->algo.getsda               = i810ddc_getsda;
 		chan->algo.getscl               = i810ddc_getscl;
 		break;
 	case 2:
-		chan->adapter.id                = I2C_ALGO_I2C_I810;
 		chan->algo.setsda               = i810i2c_setsda;
 		chan->algo.setscl               = i810i2c_setscl;
 		chan->algo.getsda               = i810i2c_getsda;
--- linux-2.6.14-rc4.orig/include/media/ovcamchip.h	2004-12-24 22:35:40.000000000 +0100
+++ linux-2.6.14-rc4/include/media/ovcamchip.h	2005-10-22 14:23:00.000000000 +0200
@@ -17,20 +17,6 @@
 #include <linux/videodev.h>
 #include <linux/i2c.h>
 
-/* Remove these once they are officially defined */
-#ifndef I2C_DRIVERID_OVCAMCHIP
-	#define I2C_DRIVERID_OVCAMCHIP	0xf00f
-#endif
-#ifndef I2C_HW_SMBUS_OV511
-	#define I2C_HW_SMBUS_OV511	0xfe
-#endif
-#ifndef I2C_HW_SMBUS_OV518
-	#define I2C_HW_SMBUS_OV518	0xff
-#endif
-#ifndef I2C_HW_SMBUS_OVFX2
-	#define I2C_HW_SMBUS_OVFX2	0xfd
-#endif
-
 /* --------------------------------- */
 /*           ENUMERATIONS            */
 /* --------------------------------- */


-- 
Jean Delvare
