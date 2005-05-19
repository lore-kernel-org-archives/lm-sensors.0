From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: [PATCH] i2c driver fixes for 2.6.0-test5
Message-Id: <10642734181751@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10642734183644@kroah.com>
References: <1064273416272@kroah.com>
In-Reply-To: <1064273416272@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1153.85.5, 2003/08/27 15:32:59-07:00, hirofumi@mail.parknet.co.jp

[PATCH] DEVICE_NAME_SIZE/_HALF removal (I2C related, but fb stuff)


 drivers/video/matrox/i2c-matroxfb.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/video/matrox/i2c-matroxfb.c b/drivers/video/matrox/i2c-matroxfb.c
--- a/drivers/video/matrox/i2c-matroxfb.c	Mon Sep 22 16:16:30 2003
+++ b/drivers/video/matrox/i2c-matroxfb.c	Mon Sep 22 16:16:30 2003
@@ -111,7 +111,7 @@
 	b->mask.data = data;
 	b->mask.clock = clock;
 	b->adapter = matrox_i2c_adapter_template;
-	snprintf(b->adapter.name, DEVICE_NAME_SIZE, name,
+	snprintf(b->adapter.name, I2C_NAME_SIZE, name,
 		minfo->fbcon.node);
 	i2c_set_adapdata(&b->adapter, b);
 	b->adapter.algo_data = &b->bac;

