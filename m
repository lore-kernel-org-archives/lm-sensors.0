From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: [PATCH 2.6] Enable debugging in fscher
Message-Id: <20040210191533.19e6bbc7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

I just noticed that I forgot to enable debugging in the new fscher
driver. Sorry for that. Here is a patch that fixes this (applies on top
of 2.6.3-rc2). This can safely be delayed until after 2.6.3 is released,
of course.

Thanks.

--- linux-2.6.3-rc2/drivers/i2c/chips/fscher.c.orig	2004-02-10 15:47:27.000000000 +0100
+++ linux-2.6.3-rc2/drivers/i2c/chips/fscher.c	2004-02-10 15:48:05.000000000 +0100
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


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
