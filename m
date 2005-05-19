From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:34 +0000
Subject: [PATCH 2.6] I2C: unnecessary #includes in asb100.c
Message-Id: <20050131050010.GA5334@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean, Greg:

* Jean Delvare <khali@linux-fr.org> [2005-01-25 10:14:49 +0100]:
> Any reson why asb100.c (in linux 2.6.11-rc2) includes linux/ioport.h and
> asm/io.h? As an i2c-only chip driver, I don't think it needs these.
>
> As a side note, I also wonder what the inclusions of linux/config.h,
> linux/types.h and asm/errno.h are there for.

Because they look pretty?  Here's a patch Greg, please apply...

Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>

Index: linux-2.6.11-rc2-bk8/drivers/i2c/chips/asb100.c
=================================--- linux-2.6.11-rc2-bk8.orig/drivers/i2c/chips/asb100.c	2005-01-30 18:20:41.000000000 -0500
+++ linux-2.6.11-rc2-bk8/drivers/i2c/chips/asb100.c	2005-01-30 23:50:53.000000000 -0500
@@ -36,17 +36,12 @@
     asb100	7	3	1	4	0x31	0x0694	yes	no
 */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/slab.h>
-#include <linux/ioport.h>
-#include <linux/types.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
 #include <linux/init.h>
-#include <asm/errno.h>
-#include <asm/io.h>
 #include "lm75.h"
 
 /*

-- 
Mark M. Hoffman
mhoffman@lightlink.com
