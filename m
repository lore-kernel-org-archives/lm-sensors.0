From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 14 Dec 2013 17:30:15 +0000
Subject: [lm-sensors] [PATCH 08/14] i8k: Force SMM to run on CPU 0
Message-Id: <1387042221-3671-9-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1387042221-3671-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1387042221-3671-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Jean Delvare <khali@linux-fr.org>

On Studio 1555 with dual-core CPU, reading sensor attributes
exported by this driver resulted in random failures combined
with system hangups and forced logouts. Information in
drivers/firmware/dcdbas.c suggests that SMM accesses must
run on CPU 0. With this patch, the problems are gone,
suggesting that this is in fact the case.

Code derived from drivers/firmware/dcdbas.c.

Cc: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/char/i8k.c |   19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/char/i8k.c b/drivers/char/i8k.c
index ad0acef..264be2b 100644
--- a/drivers/char/i8k.c
+++ b/drivers/char/i8k.c
@@ -31,6 +31,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/uaccess.h>
 #include <linux/io.h>
+#include <linux/sched.h>
 
 #include <linux/i8k.h>
 
@@ -130,6 +131,17 @@ static int i8k_smm(struct smm_regs *regs)
 {
 	int rc;
 	int eax = regs->eax;
+	cpumask_var_t old_mask;
+
+	/* SMM requires CPU 0 */
+	if (!alloc_cpumask_var(&old_mask, GFP_KERNEL))
+		return -ENOMEM;
+	cpumask_copy(old_mask, &current->cpus_allowed);
+	set_cpus_allowed_ptr(current, cpumask_of(0));
+	if (smp_processor_id() != 0) {
+		rc = -EBUSY;
+		goto out;
+	}
 
 #if defined(CONFIG_X86_64)
 	asm volatile("pushq %%rax\n\t"
@@ -185,9 +197,12 @@ static int i8k_smm(struct smm_regs *regs)
 	    :    "%ebx", "%ecx", "%edx", "%esi", "%edi", "memory");
 #endif
 	if (rc != 0 || (regs->eax & 0xffff) = 0xffff || regs->eax = eax)
-		return -EINVAL;
+		rc = -EINVAL;
 
-	return 0;
+out:
+	set_cpus_allowed_ptr(current, old_mask);
+	free_cpumask_var(old_mask);
+	return rc;
 }
 
 /*
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
