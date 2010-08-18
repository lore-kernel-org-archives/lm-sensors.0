From: "Fenghua Yu" <fenghua.yu@intel.com>
Date: Wed, 18 Aug 2010 22:53:45 +0000
Subject: [lm-sensors] [PATCH] drivers/hwmon/coretemp: Fix incorrect
Message-Id: <1282172027-640-1-git-send-email-fenghua.yu@intel.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rudolf Marek <r.marek@assembler.cz>, Huaxu Wan <huaxu.wan@intel.com>, H Peter Anvin <hpa@zytor.com>, Chen Gong <gong.chen@linux.intel.com>, Jean Delvare <khali@linux-fr.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>, Fenghua Yu <fenghua.yu@intel.com>

From: Fenghua Yu <fenghua.yu@intel.com>

In current coretemp driver, when a CPU in dev_list is hot-removed, although its
HT sibling is still running, its core sensor is gone and not available to user
level application any more.

When a CPU is hot-removed, its core sensor should be still available to upper
level application as long as the hot-removed CPU's HT sibling is still running.
A core sensor is invisible to user level only when all of siblings in a core are
hot-removed.

This patch fixes this issue.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 drivers/hwmon/coretemp.c |   25 ++++++++++++++++++++++---
 1 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index c070c97..2257cc4 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -418,7 +418,7 @@ struct pdev_entry {
 static LIST_HEAD(pdev_list);
 static DEFINE_MUTEX(pdev_list_mutex);
 
-static int __cpuinit coretemp_device_add(unsigned int cpu)
+static int coretemp_device_add(unsigned int cpu)
 {
 	int err;
 	struct platform_device *pdev;
@@ -483,15 +483,34 @@ exit:
 static void coretemp_device_remove(unsigned int cpu)
 {
 	struct pdev_entry *p, *n;
-	mutex_lock(&pdev_list_mutex);
+#ifdef CONFIG_SMP
+	int s;
+#endif
+
 	list_for_each_entry_safe(p, n, &pdev_list, list) {
 		if (p->cpu = cpu) {
+			mutex_lock(&pdev_list_mutex);
 			platform_device_unregister(p->pdev);
 			list_del(&p->list);
 			kfree(p);
+			mutex_unlock(&pdev_list_mutex);
+
+#ifdef CONFIG_SMP
+			/*
+			 * Add removed CPU's HT sibling to dev_list.
+			 * If there is no sibling available, the core sensor
+			 * is invisiable to user space any more.
+			 */
+			for_each_cpu(s, cpu_sibling_mask(cpu)) {
+				if (s != cpu) {
+					coretemp_device_add(s);
+					break;
+				}
+			}
+#endif
+			return;
 		}
 	}
-	mutex_unlock(&pdev_list_mutex);
 }
 
 static int __cpuinit coretemp_cpu_callback(struct notifier_block *nfb,
-- 
1.6.0.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
