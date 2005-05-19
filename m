From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: [PATCH] i2c driver fixes for 2.6.1
Message-Id: <10745567611379@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10745567603666@kroah.com>
References: <1074556757661@kroah.com>
In-Reply-To: <1074556757661@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1474.98.8, 2004/01/14 11:19:29-08:00, khali@linux-fr.org

[PATCH] I2C: i2c-rpx.c doesn't need ioports.h nor parport.h

One more simple patch... These headers are useless as far as I can see.


 drivers/i2c/busses/i2c-rpx.c |    2 --
 1 files changed, 2 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-rpx.c b/drivers/i2c/busses/i2c-rpx.c
--- a/drivers/i2c/busses/i2c-rpx.c	Mon Jan 19 15:31:59 2004
+++ b/drivers/i2c/busses/i2c-rpx.c	Mon Jan 19 15:31:59 2004
@@ -12,11 +12,9 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/ioport.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/stddef.h>
-#include <linux/parport.h>
 #include <linux/i2c.h>
 #include <linux/i2c-algo-8xx.h>
 #include <asm/mpc8xx.h>

