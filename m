From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: [PATCH] More i2c driver fixes for 2.6.0-test7
Message-Id: <10662411473410@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <20031015180456.GA22107@kroah.com>
References: <1064526609700@kroah.com>
In-Reply-To: <1064526609700@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1347.1.1, 2003/10/13 11:28:27-07:00, greg@kroah.com

[PATCH] I2C: remove unneeded MOD_INC and MOD_DEC calls.


 drivers/i2c/algos/i2c-algo-ite.c |    7 -------
 1 files changed, 7 deletions(-)


diff -Nru a/drivers/i2c/algos/i2c-algo-ite.c b/drivers/i2c/algos/i2c-algo-ite.c
--- a/drivers/i2c/algos/i2c-algo-ite.c	Wed Oct 15 10:58:15 2003
+++ b/drivers/i2c/algos/i2c-algo-ite.c	Wed Oct 15 10:58:15 2003
@@ -779,10 +779,6 @@
 	adap->retries = 3;		/* be replaced by defines	*/
 	adap->flags = 0;
 
-#ifdef MODULE
-	MOD_INC_USE_COUNT;
-#endif
-
 	i2c_add_adapter(adap);
 	iic_init(iic_adap);
 
@@ -815,9 +811,6 @@
 		return res;
 	DEB2(printk("i2c-algo-ite: adapter unregistered: %s\n",adap->name));
 
-#ifdef MODULE
-	MOD_DEC_USE_COUNT;
-#endif
 	return 0;
 }
 

