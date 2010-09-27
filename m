From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 27 Sep 2010 11:59:56 +0000
Subject: [lm-sensors] [PATCH v2] hwmon (coretemp): Fix build breakage if SMP
Message-Id: <1285588796-20956-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Ingo Molnar <mingo@elte.hu>, torvalds@linux-foundation.org
Cc: Fenghua Yu <fenghua.yu@intel.com>, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>

Commit e40cc4bdfd4b89813f072f72bd9c7055814d3f0f introduced
a build breakage if CONFIG_SMP is undefined. This commit
fixes the problem.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
v2: Fix compile warning due to unused variable i if SMP is undefined.

 drivers/hwmon/coretemp.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index baa842a..138fe29 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -492,7 +492,9 @@ exit:
 static void coretemp_device_remove(unsigned int cpu)
 {
 	struct pdev_entry *p;
+#ifdef CONFIG_SMP
 	unsigned int i;
+#endif
 
 	mutex_lock(&pdev_list_mutex);
 	list_for_each_entry(p, &pdev_list, list) {
@@ -503,9 +505,11 @@ static void coretemp_device_remove(unsigned int cpu)
 		list_del(&p->list);
 		mutex_unlock(&pdev_list_mutex);
 		kfree(p);
+#ifdef CONFIG_SMP
 		for_each_cpu(i, cpu_sibling_mask(cpu))
 			if (i != cpu && !coretemp_device_add(i))
 				break;
+#endif
 		return;
 	}
 	mutex_unlock(&pdev_list_mutex);
-- 
1.7.0.87.g0901d


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
