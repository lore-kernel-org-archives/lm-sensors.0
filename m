From: "Fenghua Yu" <fenghua.yu@intel.com>
Date: Wed, 18 Aug 2010 22:53:47 +0000
Subject: [lm-sensors] [PATCH] drivers/hwmon/pkgtemp: Fix improper locking in
Message-Id: <1282172027-640-3-git-send-email-fenghua.yu@intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1282172027-640-1-git-send-email-fenghua.yu@intel.com>
In-Reply-To: <1282172027-640-1-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rudolf Marek <r.marek@assembler.cz>, Huaxu Wan <huaxu.wan@intel.com>, H Peter Anvin <hpa@zytor.com>, Chen Gong <gong.chen@linux.intel.com>, Jean Delvare <khali@linux-fr.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>, Fenghua Yu <fenghua.yu@intel.com>

From: Fenghua Yu <fenghua.yu@intel.com>

When a sibling is added to dev_list after a cpu is hot-removed, pdev_list_mutex
has been locked already. But pkgtemp_device_add() tries to lock pdev_list_mutex
again. This is incorrect. The patch fixes this issue.

The patch also removes __cpuinit for pkgtemp_device_add() to avoid section
mismatch warning.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 drivers/hwmon/pkgtemp.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/pkgtemp.c b/drivers/hwmon/pkgtemp.c
index 74157fc..928a016 100644
--- a/drivers/hwmon/pkgtemp.c
+++ b/drivers/hwmon/pkgtemp.c
@@ -276,7 +276,7 @@ struct pdev_entry {
 static LIST_HEAD(pdev_list);
 static DEFINE_MUTEX(pdev_list_mutex);
 
-static int __cpuinit pkgtemp_device_add(unsigned int cpu)
+static int pkgtemp_device_add(unsigned int cpu)
 {
 	int err;
 	struct platform_device *pdev;
@@ -341,26 +341,34 @@ static void pkgtemp_device_remove(unsigned int cpu)
 {
 	struct pdev_entry *p, *n;
 	unsigned int i;
-	int err;
 
-	mutex_lock(&pdev_list_mutex);
 	list_for_each_entry_safe(p, n, &pdev_list, list) {
 		if (p->cpu != cpu)
 			continue;
 
+		mutex_lock(&pdev_list_mutex);
 		platform_device_unregister(p->pdev);
 		list_del(&p->list);
 		kfree(p);
+		mutex_unlock(&pdev_list_mutex);
+		/*
+		 * Select one of removed cpu's siblings to represent sensor
+		 * for this package.
+		 * If there is no more running sibling in a package, the
+		 * package sensor for this package is not available to user
+		 * space any more.
+		 */
 		for_each_cpu(i, cpu_core_mask(cpu)) {
+			int err;
+
 			if (i != cpu) {
 				err = pkgtemp_device_add(i);
 				if (!err)
 					break;
 			}
 		}
-		break;
+		return;
 	}
-	mutex_unlock(&pdev_list_mutex);
 }
 
 static int __cpuinit pkgtemp_cpu_callback(struct notifier_block *nfb,
-- 
1.6.0.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
