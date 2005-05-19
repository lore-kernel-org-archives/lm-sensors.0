From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:47 +0000
Subject: [PATCH] i2c driver fixes for 2.6.4
Message-Id: <1079391390517@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10793913903814@kroah.com>
References: <10793913903814@kroah.com>
In-Reply-To: <10793913903814@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1557.61.2, 2004/02/17 14:40:59-08:00, khali@linux-fr.org

[PATCH] I2C: Enable debugging in fscher

I just noticed that I forgot to enable debugging in the new fscher
driver. Sorry for that. Here is a patch that fixes this.


 drivers/i2c/chips/fscher.c |    5 +++++
 1 files changed, 5 insertions(+)


diff -Nru a/drivers/i2c/chips/fscher.c b/drivers/i2c/chips/fscher.c
--- a/drivers/i2c/chips/fscher.c	Mon Mar 15 14:37:50 2004
+++ b/drivers/i2c/chips/fscher.c	Mon Mar 15 14:37:50 2004
@@ -26,6 +26,11 @@
  *  and Philip Edelbrock <phil@netroedge.com>
  */
 
+#include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_CHIP
+#define DEBUG	1
+#endif
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>

