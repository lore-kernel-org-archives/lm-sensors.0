From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:47 +0000
Subject: [PATCH] i2c driver fixes for 2.6.4
Message-Id: <10793913913301@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10793913911774@kroah.com>
References: <10793913903814@kroah.com>
In-Reply-To: <10793913903814@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1557.61.8, 2004/02/23 16:27:03-08:00, khali@linux-fr.org

[PATCH] I2C: fix space in message

BTW, I found something to be fixed in i2c-core:


 drivers/i2c/i2c-core.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	Mon Mar 15 14:37:19 2004
+++ b/drivers/i2c/i2c-core.c	Mon Mar 15 14:37:19 2004
@@ -175,7 +175,7 @@
 		driver = list_entry(item, struct i2c_driver, list);
 		if (driver->detach_adapter)
 			if ((res = driver->detach_adapter(adap))) {
-				dev_warn(&adap->dev, "can't detach adapter"
+				dev_warn(&adap->dev, "can't detach adapter "
 					 "while detaching driver %s: driver not "
 					 "detached!", driver->name);
 				goto out_unlock;

