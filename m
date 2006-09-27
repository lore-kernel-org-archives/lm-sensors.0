From: greg@kroah.com (Greg KH)
Date: Wed, 27 Sep 2006 01:01:45 +0000
Subject: [lm-sensors] [PATCH 14/30] i2c-algo-bit: Discard the mdelay data
Message-Id: <11593189672810-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

i2c-algo-bit: Discard the mdelay data struct member

The i2c_algo_bit_data structure has an mdelay member, which is not
used by the algorithm code (the code has always been ifdef'd out.)
Let's discard it to save some code and memory.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Acked-by: Mauro Carvalho Chehab <mchehab at brturbo.com.br>
Cc: Adrian Bunk <bunk at stusta.de>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/acorn/char/i2c.c                   |    1 -
 drivers/i2c/algos/i2c-algo-bit.c           |    4 ----
 drivers/i2c/busses/i2c-hydra.c             |    1 -
 drivers/i2c/busses/i2c-i810.c              |    2 --
 drivers/i2c/busses/i2c-ixp2000.c           |    1 -
 drivers/i2c/busses/i2c-ixp4xx.c            |    1 -
 drivers/i2c/busses/i2c-parport-light.c     |    1 -
 drivers/i2c/busses/i2c-parport.c           |    1 -
 drivers/i2c/busses/i2c-prosavage.c         |    1 -
 drivers/i2c/busses/i2c-savage4.c           |    1 -
 drivers/i2c/busses/i2c-via.c               |    1 -
 drivers/i2c/busses/i2c-voodoo3.c           |    2 --
 drivers/i2c/busses/scx200_i2c.c            |   12 ++++++------
 drivers/ieee1394/pcilynx.c                 |    1 -
 drivers/media/video/bt8xx/bttv-i2c.c       |    1 -
 drivers/media/video/cx88/cx88-i2c.c        |    1 -
 drivers/media/video/cx88/cx88-vp3054-i2c.c |    1 -
 drivers/media/video/zoran_card.c           |    1 -
 drivers/video/i810/i810-i2c.c              |    1 -
 drivers/video/matrox/i2c-matroxfb.c        |    1 -
 drivers/video/savage/savagefb-i2c.c        |    1 -
 include/linux/i2c-algo-bit.h               |    1 -
 22 files changed, 6 insertions(+), 32 deletions(-)

diff --git a/drivers/acorn/char/i2c.c b/drivers/acorn/char/i2c.c
index c26c08b..bdb9c8b 100644
--- a/drivers/acorn/char/i2c.c
+++ b/drivers/acorn/char/i2c.c
@@ -308,7 +308,6 @@ static struct i2c_algo_bit_data ioc_data
 	.getsda		= ioc_getsda,
 	.getscl		= ioc_getscl,
 	.udelay		= 80,
-	.mdelay		= 80,
 	.timeout	= 100
 };
 
diff --git a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-algo-bit.c
index ab230c0..761df16 100644
--- a/drivers/i2c/algos/i2c-algo-bit.c
+++ b/drivers/i2c/algos/i2c-algo-bit.c
@@ -354,10 +354,6 @@ static int sendbytes(struct i2c_adapter 
 			return (retval<0)? retval : -EFAULT;
 			        /* got a better one ?? */
 		}
-#if 0
-		/* from asm/delay.h */
-		__delay(adap->mdelay * (loops_per_sec / 1000) );
-#endif
 	}
 	return wrcount;
 }
diff --git a/drivers/i2c/busses/i2c-hydra.c b/drivers/i2c/busses/i2c-hydra.c
index e0cb3b0..457d48a 100644
--- a/drivers/i2c/busses/i2c-hydra.c
+++ b/drivers/i2c/busses/i2c-hydra.c
@@ -99,7 +99,6 @@ static struct i2c_algo_bit_data hydra_bi
 	.getsda		= hydra_bit_getsda,
 	.getscl		= hydra_bit_getscl,
 	.udelay		= 5,
-	.mdelay		= 5,
 	.timeout	= HZ
 };
 
diff --git a/drivers/i2c/busses/i2c-i810.c b/drivers/i2c/busses/i2c-i810.c
index 748be30..b66fb6b 100644
--- a/drivers/i2c/busses/i2c-i810.c
+++ b/drivers/i2c/busses/i2c-i810.c
@@ -166,7 +166,6 @@ static struct i2c_algo_bit_data i810_i2c
 	.getsda		= bit_i810i2c_getsda,
 	.getscl		= bit_i810i2c_getscl,
 	.udelay		= CYCLE_DELAY,
-	.mdelay		= CYCLE_DELAY,
 	.timeout	= TIMEOUT,
 };
 
@@ -182,7 +181,6 @@ static struct i2c_algo_bit_data i810_ddc
 	.getsda		= bit_i810ddc_getsda,
 	.getscl		= bit_i810ddc_getscl,
 	.udelay		= CYCLE_DELAY,
-	.mdelay		= CYCLE_DELAY,
 	.timeout	= TIMEOUT,
 };
 
diff --git a/drivers/i2c/busses/i2c-ixp2000.c b/drivers/i2c/busses/i2c-ixp2000.c
index cd6f45d..dd3f4cd 100644
--- a/drivers/i2c/busses/i2c-ixp2000.c
+++ b/drivers/i2c/busses/i2c-ixp2000.c
@@ -114,7 +114,6 @@ static int ixp2000_i2c_probe(struct plat
 	drv_data->algo_data.getsda = ixp2000_bit_getsda;
 	drv_data->algo_data.getscl = ixp2000_bit_getscl;
 	drv_data->algo_data.udelay = 6;
-	drv_data->algo_data.mdelay = 6;
 	drv_data->algo_data.timeout = 100;
 
 	drv_data->adapter.id = I2C_HW_B_IXP2000,
diff --git a/drivers/i2c/busses/i2c-ixp4xx.c b/drivers/i2c/busses/i2c-ixp4xx.c
index 2ed0711..ab57325 100644
--- a/drivers/i2c/busses/i2c-ixp4xx.c
+++ b/drivers/i2c/busses/i2c-ixp4xx.c
@@ -122,7 +122,6 @@ static int ixp4xx_i2c_probe(struct platf
 	drv_data->algo_data.getsda = ixp4xx_bit_getsda;
 	drv_data->algo_data.getscl = ixp4xx_bit_getscl;
 	drv_data->algo_data.udelay = 10;
-	drv_data->algo_data.mdelay = 10;
 	drv_data->algo_data.timeout = 100;
 
 	drv_data->adapter.id = I2C_HW_B_IXP4XX;
diff --git a/drivers/i2c/busses/i2c-parport-light.c b/drivers/i2c/busses/i2c-parport-light.c
index e09ebbb..5eb2bd2 100644
--- a/drivers/i2c/busses/i2c-parport-light.c
+++ b/drivers/i2c/busses/i2c-parport-light.c
@@ -103,7 +103,6 @@ static struct i2c_algo_bit_data parport_
 	.getsda		= parport_getsda,
 	.getscl		= parport_getscl,
 	.udelay		= 50,
-	.mdelay		= 50,
 	.timeout	= HZ,
 }; 
 
diff --git a/drivers/i2c/busses/i2c-parport.c b/drivers/i2c/busses/i2c-parport.c
index 934bd55..48a8294 100644
--- a/drivers/i2c/busses/i2c-parport.c
+++ b/drivers/i2c/busses/i2c-parport.c
@@ -138,7 +138,6 @@ static struct i2c_algo_bit_data parport_
 	.getsda		= parport_getsda,
 	.getscl		= parport_getscl,
 	.udelay		= 60,
-	.mdelay		= 60,
 	.timeout	= HZ,
 }; 
 
diff --git a/drivers/i2c/busses/i2c-prosavage.c b/drivers/i2c/busses/i2c-prosavage.c
index 9479525..7745e21 100644
--- a/drivers/i2c/busses/i2c-prosavage.c
+++ b/drivers/i2c/busses/i2c-prosavage.c
@@ -180,7 +180,6 @@ static int i2c_register_bus(struct pci_d
 	p->algo.getsda	  = bit_s3via_getsda;
 	p->algo.getscl	  = bit_s3via_getscl;
 	p->algo.udelay	  = CYCLE_DELAY;
-	p->algo.mdelay	  = CYCLE_DELAY;
 	p->algo.timeout	  = TIMEOUT;
 	p->algo.data	  = p;
 	p->mmvga	  = mmvga;
diff --git a/drivers/i2c/busses/i2c-savage4.c b/drivers/i2c/busses/i2c-savage4.c
index 0c85182..209f47e 100644
--- a/drivers/i2c/busses/i2c-savage4.c
+++ b/drivers/i2c/busses/i2c-savage4.c
@@ -140,7 +140,6 @@ static struct i2c_algo_bit_data sav_i2c_
 	.getsda		= bit_savi2c_getsda,
 	.getscl		= bit_savi2c_getscl,
 	.udelay		= CYCLE_DELAY,
-	.mdelay		= CYCLE_DELAY,
 	.timeout	= TIMEOUT
 };
 
diff --git a/drivers/i2c/busses/i2c-via.c b/drivers/i2c/busses/i2c-via.c
index 484bbac..910e200 100644
--- a/drivers/i2c/busses/i2c-via.c
+++ b/drivers/i2c/busses/i2c-via.c
@@ -81,7 +81,6 @@ static struct i2c_algo_bit_data bit_data
 	.getsda		= bit_via_getsda,
 	.getscl		= bit_via_getscl,
 	.udelay		= 5,
-	.mdelay		= 5,
 	.timeout	= HZ
 };
 
diff --git a/drivers/i2c/busses/i2c-voodoo3.c b/drivers/i2c/busses/i2c-voodoo3.c
index b675773..6c8d251 100644
--- a/drivers/i2c/busses/i2c-voodoo3.c
+++ b/drivers/i2c/busses/i2c-voodoo3.c
@@ -160,7 +160,6 @@ static struct i2c_algo_bit_data voo_i2c_
 	.getsda		= bit_vooi2c_getsda,
 	.getscl		= bit_vooi2c_getscl,
 	.udelay		= CYCLE_DELAY,
-	.mdelay		= CYCLE_DELAY,
 	.timeout	= TIMEOUT
 };
 
@@ -177,7 +176,6 @@ static struct i2c_algo_bit_data voo_ddc_
 	.getsda		= bit_vooddc_getsda,
 	.getscl		= bit_vooddc_getscl,
 	.udelay		= CYCLE_DELAY,
-	.mdelay		= CYCLE_DELAY,
 	.timeout	= TIMEOUT
 };
 
diff --git a/drivers/i2c/busses/scx200_i2c.c b/drivers/i2c/busses/scx200_i2c.c
index cb3ef5a..8b65a5c 100644
--- a/drivers/i2c/busses/scx200_i2c.c
+++ b/drivers/i2c/busses/scx200_i2c.c
@@ -71,12 +71,12 @@ static int scx200_i2c_getsda(void *data)
  */
 
 static struct i2c_algo_bit_data scx200_i2c_data = {
-	NULL,
-	scx200_i2c_setsda,
-	scx200_i2c_setscl,
-	scx200_i2c_getsda,
-	scx200_i2c_getscl,
-	10, 10, 100,		/* waits, timeout */
+	.setsda		= scx200_i2c_setsda,
+	.setscl		= scx200_i2c_setscl,
+	.getsda		= scx200_i2c_getsda,
+	.getscl		= scx200_i2c_getscl,
+	.udelay		= 10,
+	.timeout	= 100,
 };
 
 static struct i2c_adapter scx200_i2c_ops = {
diff --git a/drivers/ieee1394/pcilynx.c b/drivers/ieee1394/pcilynx.c
index e6f4123..b4f146f 100644
--- a/drivers/ieee1394/pcilynx.c
+++ b/drivers/ieee1394/pcilynx.c
@@ -137,7 +137,6 @@ static struct i2c_algo_bit_data bit_data
 	.getsda			= bit_getsda,
 	.getscl			= bit_getscl,
 	.udelay			= 5,
-	.mdelay			= 5,
 	.timeout		= 100,
 };
 
diff --git a/drivers/media/video/bt8xx/bttv-i2c.c b/drivers/media/video/bt8xx/bttv-i2c.c
index 4b562b3..0dfbcc8 100644
--- a/drivers/media/video/bt8xx/bttv-i2c.c
+++ b/drivers/media/video/bt8xx/bttv-i2c.c
@@ -100,7 +100,6 @@ static struct i2c_algo_bit_data bttv_i2c
 	.getsda  = bttv_bit_getsda,
 	.getscl  = bttv_bit_getscl,
 	.udelay  = 16,
-	.mdelay  = 10,
 	.timeout = 200,
 };
 
diff --git a/drivers/media/video/cx88/cx88-i2c.c b/drivers/media/video/cx88/cx88-i2c.c
index 7066380..7bea347 100644
--- a/drivers/media/video/cx88/cx88-i2c.c
+++ b/drivers/media/video/cx88/cx88-i2c.c
@@ -155,7 +155,6 @@ static struct i2c_algo_bit_data cx8800_i
 	.getsda  = cx8800_bit_getsda,
 	.getscl  = cx8800_bit_getscl,
 	.udelay  = 16,
-	.mdelay  = 10,
 	.timeout = 200,
 };
 
diff --git a/drivers/media/video/cx88/cx88-vp3054-i2c.c b/drivers/media/video/cx88/cx88-vp3054-i2c.c
index 751a754..2b4f197 100644
--- a/drivers/media/video/cx88/cx88-vp3054-i2c.c
+++ b/drivers/media/video/cx88/cx88-vp3054-i2c.c
@@ -100,7 +100,6 @@ static struct i2c_algo_bit_data vp3054_i
 	.getsda  = vp3054_bit_getsda,
 	.getscl  = vp3054_bit_getscl,
 	.udelay  = 16,
-	.mdelay  = 10,
 	.timeout = 200,
 };
 
diff --git a/drivers/media/video/zoran_card.c b/drivers/media/video/zoran_card.c
index f2249ed..29f59c3 100644
--- a/drivers/media/video/zoran_card.c
+++ b/drivers/media/video/zoran_card.c
@@ -820,7 +820,6 @@ static struct i2c_algo_bit_data zoran_i2
 	.getsda = zoran_i2c_getsda,
 	.getscl = zoran_i2c_getscl,
 	.udelay = 10,
-	.mdelay = 0,
 	.timeout = 100,
 };
 
diff --git a/drivers/video/i810/i810-i2c.c b/drivers/video/i810/i810-i2c.c
index c1f7b49..7d06b38 100644
--- a/drivers/video/i810/i810-i2c.c
+++ b/drivers/video/i810/i810-i2c.c
@@ -98,7 +98,6 @@ static int i810_setup_i2c_bus(struct i81
 	chan->algo.getsda               = i810i2c_getsda;
 	chan->algo.getscl               = i810i2c_getscl;
 	chan->algo.udelay               = 10;
-	chan->algo.mdelay               = 10;
         chan->algo.timeout              = (HZ/2);
         chan->algo.data                 = chan;
 
diff --git a/drivers/video/matrox/i2c-matroxfb.c b/drivers/video/matrox/i2c-matroxfb.c
index 9842042..795c1a9 100644
--- a/drivers/video/matrox/i2c-matroxfb.c
+++ b/drivers/video/matrox/i2c-matroxfb.c
@@ -100,7 +100,6 @@ static struct i2c_algo_bit_data matrox_i
 	.getsda		= matroxfb_gpio_getsda,
 	.getscl		= matroxfb_gpio_getscl,
 	.udelay		= 10,
-	.mdelay		= 10,
 	.timeout	= 100,
 };
 
diff --git a/drivers/video/savage/savagefb-i2c.c b/drivers/video/savage/savagefb-i2c.c
index e83befd..d7d810d 100644
--- a/drivers/video/savage/savagefb-i2c.c
+++ b/drivers/video/savage/savagefb-i2c.c
@@ -148,7 +148,6 @@ static int savage_setup_i2c_bus(struct s
 		chan->adapter.algo_data		= &chan->algo;
 		chan->adapter.dev.parent	= &chan->par->pcidev->dev;
 		chan->algo.udelay		= 40;
-		chan->algo.mdelay               = 5;
 		chan->algo.timeout		= 20;
 		chan->algo.data 		= chan;
 
diff --git a/include/linux/i2c-algo-bit.h b/include/linux/i2c-algo-bit.h
index c0e7fab..c8f8df2 100644
--- a/include/linux/i2c-algo-bit.h
+++ b/include/linux/i2c-algo-bit.h
@@ -40,7 +40,6 @@ struct i2c_algo_bit_data {
 	/* local settings */
 	int udelay;		/* half-clock-cycle time in microsecs */
 				/* i.e. clock is (500 / udelay) KHz */
-	int mdelay;		/* in millisecs, unused */
 	int timeout;		/* in jiffies */
 };
 
-- 
1.4.2.1


