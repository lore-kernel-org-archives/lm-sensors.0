From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: [PATCH 2.6] I2C: remove <linux/delay.h> from via686a
Message-Id: <947m71hvl7rt3efdmmi6ekbc3r9pakplmu@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

In my cross-reference checking of sysfs names, the via686a needs 
special case treatment as it the only driver expands S_IWUSR to 
00200 with gcc -E.  (00200 is the correct value for S_IWUSR).

This is caused by the driver including <linux/delay.h>, it compiles 
fine without that header but I am unable to test drive the change. 

--Grant.


Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 via686a.c |    1 -
 1 files changed, 1 deletion(-)

--- linux-2.6.12-rc3-mm3/drivers/i2c/chips/via686a.c	2005-05-06 04:43:26.000000000 +1000
+++ linux-2.6.12-rc3-mm3b/drivers/i2c/chips/via686a.c	2005-05-07 01:21:04.000000000 +1000
@@ -33,7 +33,6 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
-#include <linux/delay.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
