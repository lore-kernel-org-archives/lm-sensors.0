From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 15 Aug 2010 11:46:04 +0000
Subject: [lm-sensors] [PATCH] hwmon: (coretemp) Fix harmless build warning
Message-Id: <20100815134604.5bf145cf@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fix the following build warning:

  CC [M]  drivers/hwmon/coretemp.o
drivers/hwmon/coretemp.c: In function "coretemp_init":
drivers/hwmon/coretemp.c:521: warning: unused variable "n"
drivers/hwmon/coretemp.c:521: warning: unused variable "p"

Introduced by commit 851b29cb3b196cb66452ec964ab5f66c9c9cd1ed. When
you drop code, you also have to drop the variables this code was
using.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Chen Gong <gong.chen@linux.intel.com>
Cc: Rudolf Marek <r.marek@assembler.cz>
Cc: Huaxu Wan <huaxu.wan@intel.com>
---
 drivers/hwmon/coretemp.c |    1 -
 1 file changed, 1 deletion(-)

--- linux-2.6.36-rc0.orig/drivers/hwmon/coretemp.c	2010-08-15 10:24:54.000000000 +0200
+++ linux-2.6.36-rc0/drivers/hwmon/coretemp.c	2010-08-15 13:39:08.000000000 +0200
@@ -518,7 +518,6 @@ static struct notifier_block coretemp_cp
 static int __init coretemp_init(void)
 {
 	int i, err = -ENODEV;
-	struct pdev_entry *p, *n;
 
 	/* quick check if we run Intel */
 	if (cpu_data(0).x86_vendor != X86_VENDOR_INTEL)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
