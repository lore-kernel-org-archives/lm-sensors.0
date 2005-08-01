From: jcromie@divsol.com (Jim Cromie)
Date: Mon, 01 Aug 2005 21:36:49 +0000
Subject: [lm-sensors] Re: [patchset 1/23] include hwmon-sysfs in pc87360
Message-Id: <42EE79BF.1080109@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


include hwmon-sysfs in pc87360

diffstat 01-hwmon-sysfs
 pc87360.c |    1 +
 1 files changed, 1 insertion(+)

Signed-off-by:  Jim Cromie <jcromie@divsol.com>
-------------- next part --------------
diff -ruNp -X exclude-diffs ../linux-2.6.13-rc3-mm3/drivers/hwmon/pc87360.c lxC-1/drivers/hwmon/pc87360.c
--- ../linux-2.6.13-rc3-mm3/drivers/hwmon/pc87360.c	2005-07-28 17:58:32.000000000 -0600
+++ lxC-1/drivers/hwmon/pc87360.c	2005-07-31 12:07:32.000000000 -0600
@@ -41,6 +41,7 @@
 #include <linux/i2c-isa.h>
 #include <linux/i2c-vid.h>
 #include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <asm/io.h>
 
