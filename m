From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: [PATCH] I2C fixes for 2.6.10-rc2
Message-Id: <11018600202671@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <11018600202097@kroah.com>
References: <20041119220001.GB15956@kroah.com>
In-Reply-To: <20041119220001.GB15956@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.2223.2.12, 2004/11/30 15:23:40-08:00, johnpol@2ka.mipt.ru

[PATCH] W1: check nls in return path.

Check netlink socket being non NULL in error return path.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/w1/w1_int.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/w1/w1_int.c b/drivers/w1/w1_int.c
--- a/drivers/w1/w1_int.c	2004-11-30 16:00:26 -08:00
+++ b/drivers/w1/w1_int.c	2004-11-30 16:00:26 -08:00
@@ -96,7 +96,7 @@
 	err = device_register(&dev->dev);
 	if (err) {
 		printk(KERN_ERR "Failed to register master device. err=%d\n", err);
-		if (dev->nls->sk_socket)
+		if (dev->nls && dev->nls->sk_socket)
 			sock_release(dev->nls->sk_socket);
 		memset(dev, 0, sizeof(struct w1_master));
 		kfree(dev);

