From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:23:58 +0000
Subject: Fix EINVAL in i2c.h
Message-Id: <3EE2494D.5060700@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Here is a patch to fix the EINVAL error in i2c.h

I've compiled the lk2-4 branch of i2c without this patch and it seems to work 
(not sure why though), but then when I tried to compile lm_sensors against the 
i2c, I got the EINVAL error again on one of the kernel/busses drivers...

So here is a patch to re-order and include linux/errno.h to solve the problem.

:v)
-------------- next part --------------
Index: i2c/kernel/i2c.h
=================================RCS file: /home/cvs/i2c/kernel/i2c.h,v
retrieving revision 1.68
diff -u -r1.68 i2c.h
--- i2c/kernel/i2c.h	21 Jan 2003 08:08:16 -0000	1.68
+++ i2c/kernel/i2c.h	7 Jun 2003 20:12:36 -0000
@@ -33,8 +33,9 @@
 
 #include <linux/module.h>
 #include <linux/types.h>
-#include "i2c-id.h"
+#include <linux/errno.h>
 #include <asm/semaphore.h>
+#include "i2c-id.h"
 
 /* --- General options ------------------------------------------------	*/
 
