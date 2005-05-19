From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: RFC PATCH Trivial remove include from via686a
Message-Id: <5vae71hknfndfbuupopa2p6lfr78hf0b8i@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings,

I don't know if this indicates a problem, but the via686a behaves 
differently than the other drivers with 'gcc -E', producing 00200 
intead of S_IWUSR attribute.

Removing linux/delay.h stopped that from happening.  Any ideas?

--Grant.


Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 via686a.c |    1 -
 1 files changed, 1 deletion(-)

--- linux-2.6.12-rc3-mm2/drivers/i2c/chips/via686a.c	2005-04-30 21:12:20.000000000 +1000
+++ linux-2.6.12-rc3-mm2a/drivers/i2c/chips/via686a.c	2005-05-03 17:42:40.000000000 +1000
@@ -34,7 +34,6 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
-#include <linux/delay.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
