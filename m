From: Jesper Juhl <jesper.juhl@gmail.com>
Date: Sat, 21 Jul 2007 15:02:01 +0000
Subject: [lm-sensors] [PATCH][07/37] Clean up duplicate includes in
Message-Id: <200707211702.01755.jesper.juhl@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jesper Juhl <jesper.juhl@gmail.com>, Stelian Pop <stelian@popies.net>, Michael Hanselmann <linux-kernel@hansmi.ch>, Mark Hoffman <mhoffman@lightlink.com>, lm-sensors@lm-sensors.org

Hi,

This patch cleans up duplicate includes in
	drivers/hwmon/


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

diff --git a/drivers/hwmon/ams/ams-core.c b/drivers/hwmon/ams/ams-core.c
index 6db9737..a112a03 100644
--- a/drivers/hwmon/ams/ams-core.c
+++ b/drivers/hwmon/ams/ams-core.c
@@ -23,7 +23,6 @@
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/init.h>
-#include <linux/module.h>
 #include <asm/pmac_pfunc.h>
 #include <asm/of_platform.h>
 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
