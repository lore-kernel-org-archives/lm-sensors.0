From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: [PATCH] I2C fixes for 2.6.10-rc2
Message-Id: <11018600183171@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <11018600181498@kroah.com>
References: <20041119220001.GB15956@kroah.com>
In-Reply-To: <20041119220001.GB15956@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.2223.2.2, 2004/11/24 14:24:32-08:00, johnpol@2ka.mipt.ru

[PATCH] w1: do not stop and oops if netlink socket was not allocated.

Do not panic if netlink socket was not created.
This will allow only first device to broadcast it's slave updates.
We need kernel connector here.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/w1/w1_int.c     |    9 +++------
 drivers/w1/w1_netlink.c |    3 +++
 2 files changed, 6 insertions(+), 6 deletions(-)


diff -Nru a/drivers/w1/w1_int.c b/drivers/w1/w1_int.c
--- a/drivers/w1/w1_int.c	2004-11-30 16:01:21 -08:00
+++ b/drivers/w1/w1_int.c	2004-11-30 16:01:21 -08:00
@@ -89,11 +89,8 @@
 	dev->seq = 1;
 	dev->nls = netlink_kernel_create(NETLINK_NFLOG, NULL);
 	if (!dev->nls) {
-		printk(KERN_ERR "Failed to create new netlink socket(%u).\n",
-			NETLINK_NFLOG);
-		memset(dev, 0, sizeof(struct w1_master));
-		kfree(dev);
-		dev = NULL;
+		printk(KERN_ERR "Failed to create new netlink socket(%u) for w1 master %s.\n",
+			NETLINK_NFLOG, dev->dev.bus_id);
 	}
 
 	err = device_register(&dev->dev);
@@ -112,7 +109,7 @@
 void w1_free_dev(struct w1_master *dev)
 {
 	device_unregister(&dev->dev);
-	if (dev->nls->sk_socket)
+	if (dev->nls && dev->nls->sk_socket)
 		sock_release(dev->nls->sk_socket);
 	memset(dev, 0, sizeof(struct w1_master) + sizeof(struct w1_bus_master));
 	kfree(dev);
diff -Nru a/drivers/w1/w1_netlink.c b/drivers/w1/w1_netlink.c
--- a/drivers/w1/w1_netlink.c	2004-11-30 16:01:21 -08:00
+++ b/drivers/w1/w1_netlink.c	2004-11-30 16:01:21 -08:00
@@ -34,6 +34,9 @@
 	struct w1_netlink_msg *data;
 	struct nlmsghdr *nlh;
 
+	if (!dev->nls)
+		return;
+
 	size = NLMSG_SPACE(sizeof(struct w1_netlink_msg));
 
 	skb = alloc_skb(size, GFP_ATOMIC);

