From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: [PATCH] i2c driver fixes for 2.6.0-test5
Message-Id: <10642734183644@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10642734172743@kroah.com>
References: <1064273416272@kroah.com>
In-Reply-To: <1064273416272@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1153.85.4, 2003/08/27 15:32:44-07:00, hirofumi@mail.parknet.co.jp

[PATCH] DEVICE_NAME_SIZE/_HALF removal (I2C related, but v4l stuff)


 drivers/media/video/msp3400.c |    2 +-
 drivers/media/video/saa5249.c |    2 +-
 drivers/media/video/tuner.c   |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)


diff -Nru a/drivers/media/video/msp3400.c b/drivers/media/video/msp3400.c
--- a/drivers/media/video/msp3400.c	Mon Sep 22 16:16:43 2003
+++ b/drivers/media/video/msp3400.c	Mon Sep 22 16:16:43 2003
@@ -1316,7 +1316,7 @@
 #endif
 	msp3400c_setvolume(c,msp->muted,msp->left,msp->right);
 
-	snprintf(c->name, DEVICE_NAME_SIZE, "MSP34%02d%c-%c%d",
+	snprintf(c->name, I2C_NAME_SIZE, "MSP34%02d%c-%c%d",
 		 (msp->rev2>>8)&0xff, (msp->rev1&0xff)+'@',
 		 ((msp->rev1>>8)&0xff)+'@', msp->rev2&0x1f);
 
diff -Nru a/drivers/media/video/saa5249.c b/drivers/media/video/saa5249.c
--- a/drivers/media/video/saa5249.c	Mon Sep 22 16:16:43 2003
+++ b/drivers/media/video/saa5249.c	Mon Sep 22 16:16:43 2003
@@ -171,7 +171,7 @@
 		return -ENOMEM;
 	}
 	memset(t, 0, sizeof(*t));
-	strlcpy(client->name, IF_NAME, DEVICE_NAME_SIZE);
+	strlcpy(client->name, IF_NAME, I2C_NAME_SIZE);
 	init_MUTEX(&t->lock);
 	
 	/*
diff -Nru a/drivers/media/video/tuner.c b/drivers/media/video/tuner.c
--- a/drivers/media/video/tuner.c	Mon Sep 22 16:16:43 2003
+++ b/drivers/media/video/tuner.c	Mon Sep 22 16:16:43 2003
@@ -824,7 +824,7 @@
 	if (type < TUNERS) {
 		t->type = type;
 		printk("tuner(bttv): type forced to %d (%s) [insmod]\n",t->type,tuners[t->type].name);
-		strlcpy(client->name, tuners[t->type].name, DEVICE_NAME_SIZE);
+		strlcpy(client->name, tuners[t->type].name, I2C_NAME_SIZE);
 	}
         i2c_attach_client(client);
         if (t->type = TUNER_MT2032)
@@ -875,7 +875,7 @@
 		t->type = *iarg;
 		printk("tuner: type set to %d (%s)\n",
                         t->type,tuners[t->type].name);
-		strlcpy(client->name, tuners[t->type].name, DEVICE_NAME_SIZE);
+		strlcpy(client->name, tuners[t->type].name, I2C_NAME_SIZE);
 		if (t->type = TUNER_MT2032)
                         mt2032_init(client);
 		break;

