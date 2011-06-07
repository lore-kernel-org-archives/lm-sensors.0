From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 07 Jun 2011 19:14:26 +0000
Subject: [lm-sensors] [PATCH] hwmon: (coretemp) Drop unused struct members
Message-Id: <20110607211426.19169f7a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

pdev_entry.cpu and pdev_entry.cpu_core_id aren't used anywhere in the
driver code so we can drop these struct members.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Durgadoss R <durgadoss.r@intel.com>
---
 drivers/hwmon/coretemp.c |    4 ----
 1 file changed, 4 deletions(-)

--- linux-3.0-rc2.orig/drivers/hwmon/coretemp.c	2011-06-07 09:27:38.000000000 +0200
+++ linux-3.0-rc2/drivers/hwmon/coretemp.c	2011-06-07 13:41:36.000000000 +0200
@@ -97,9 +97,7 @@ struct platform_data {
 struct pdev_entry {
 	struct list_head list;
 	struct platform_device *pdev;
-	unsigned int cpu;
 	u16 phys_proc_id;
-	u16 cpu_core_id;
 };
 
 static LIST_HEAD(pdev_list);
@@ -653,9 +651,7 @@ static int __cpuinit coretemp_device_add
 	}
 
 	pdev_entry->pdev = pdev;
-	pdev_entry->cpu = cpu;
 	pdev_entry->phys_proc_id = TO_PHYS_ID(cpu);
-	pdev_entry->cpu_core_id = TO_CORE_ID(cpu);
 
 	list_add_tail(&pdev_entry->list, &pdev_list);
 	mutex_unlock(&pdev_list_mutex);


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
