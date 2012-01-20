From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 20 Jan 2012 19:39:23 +0000
Subject: [lm-sensors] [PATCH 11/13] hwmon: (coretemp) Fix checkpatch error
Message-Id: <1327088365-11149-12-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fix:
ERROR: Macros with complex values should be enclosed in parenthesis

Cc: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/coretemp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index a6c6ec3..30e30e8 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -57,8 +57,8 @@ MODULE_PARM_DESC(tjmax, "TjMax value in degrees Celsius");
 #define TOTAL_ATTRS		(MAX_CORE_ATTRS + 1)
 #define MAX_CORE_DATA		(NUM_REAL_CORES + BASE_SYSFS_ATTR_NO)
 
-#define TO_PHYS_ID(cpu)		cpu_data(cpu).phys_proc_id
-#define TO_CORE_ID(cpu)		cpu_data(cpu).cpu_core_id
+#define TO_PHYS_ID(cpu)		(cpu_data(cpu).phys_proc_id)
+#define TO_CORE_ID(cpu)		(cpu_data(cpu).cpu_core_id)
 #define TO_ATTR_NO(cpu)		(TO_CORE_ID(cpu) + BASE_SYSFS_ATTR_NO)
 
 #ifdef CONFIG_SMP
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
