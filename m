From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: [PATCH] i2c driver fixes for 2.6.3-rc1
Message-Id: <10763687752678@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10763687753019@kroah.com>
References: <10763687741938@kroah.com>
In-Reply-To: <10763687741938@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1500.11.6, 2004/02/03 17:01:31-08:00, greg@kroah.com

[PATCH] I2C: fix oops when CONFIG_I2C_DEBUG_CORE is enabled and the bttv driver is loaded.


 drivers/i2c/i2c-core.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	Mon Feb  9 15:05:46 2004
+++ b/drivers/i2c/i2c-core.c	Mon Feb  9 15:05:46 2004
@@ -598,7 +598,7 @@
 		ret = adap->algo->master_xfer(adap,&msg,1);
 		up(&adap->bus_lock);
 	
-		dev_dbg(&client->dev, "master_recv: return:%d (count:%d, addr:0x%02x)\n",
+		dev_dbg(&client->adapter->dev, "master_recv: return:%d (count:%d, addr:0x%02x)\n",
 			ret, count, client->addr);
 	
 		/* if everything went ok (i.e. 1 msg transmitted), return #bytes

