From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 23 May 2011 18:44:30 +0000
Subject: [lm-sensors] [PATCH] hwmon: (coretemp) Fix compile error if
Message-Id: <1306177601-8812-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

cpu_sibling_mask() is not defined unless CONFIG_SMP is defined, so it must not
be used directly in the code without ifdef protection.
To solve the problem and avoid ifdefs in the code, define for_each_sibling()
and use it instead.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Durgadoss R <durgadoss.r@intel.com>
---
 drivers/hwmon/coretemp.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 5c7cd60..a00245e 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -51,10 +51,12 @@
 #define TO_PHYS_ID(cpu)		cpu_data(cpu).phys_proc_id
 #define TO_CORE_ID(cpu)		cpu_data(cpu).cpu_core_id
 #define TO_ATTR_NO(cpu)		(TO_CORE_ID(cpu) + BASE_SYSFS_ATTR_NO)
+#define for_each_sibling(i, cpu)	for_each_cpu(i, cpu_sibling_mask(cpu))
 #else
 #define TO_PHYS_ID(cpu)		(cpu)
 #define TO_CORE_ID(cpu)		(cpu)
 #define TO_ATTR_NO(cpu)		(cpu)
+#define for_each_sibling(i, cpu)	for (i = 0; false; )
 #endif
 
 /*
@@ -762,7 +764,7 @@ static void __cpuinit put_core_offline(unsigned int cpu)
 		coretemp_remove_core(pdata, &pdev->dev, indx);
 
 	/* Online the HT version of this core, if any */
-	for_each_cpu(i, cpu_sibling_mask(cpu)) {
+	for_each_sibling(i, cpu) {
 		if (i != cpu) {
 			get_core_online(i);
 			break;
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
