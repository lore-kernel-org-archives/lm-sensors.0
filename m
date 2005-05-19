From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:41 +0000
Subject: [PATCH] I2C: unnecessary #includes in asb100.c
Message-Id: <11099685953317@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <11099685951139@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Cc: mhoffman@lightlink.com

ChangeSet 1.2094, 2005/03/02 12:10:01-08:00, mhoffman@lightlink.com

[PATCH] I2C: unnecessary #includes in asb100.c

* Jean Delvare <khali@linux-fr.org> [2005-01-25 10:14:49 +0100]:
> Any reson why asb100.c (in linux 2.6.11-rc2) includes linux/ioport.h and
> asm/io.h? As an i2c-only chip driver, I don't think it needs these.
>
> As a side note, I also wonder what the inclusions of linux/config.h,
> linux/types.h and asm/errno.h are there for.

Because they look pretty?  Here's a patch Greg, please apply...

Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/asb100.c |    5 -----
 1 files changed, 5 deletions(-)


diff -Nru a/drivers/i2c/chips/asb100.c b/drivers/i2c/chips/asb100.c
--- a/drivers/i2c/chips/asb100.c	2005-03-04 12:25:10 -08:00
+++ b/drivers/i2c/chips/asb100.c	2005-03-04 12:25:10 -08:00
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

