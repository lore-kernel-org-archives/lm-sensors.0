From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 26 Sep 2010 19:50:03 +0000
Subject: [lm-sensors] [PATCH] hwmon (coretemp): Fix build breakage if SMP is
Message-Id: <1285530603-2510-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Cc: Ingo Molnar <mingo@elte.hu>, Fenghua Yu <fenghua.yu@intel.com>, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>

Commit e40cc4bdfd4b89813f072f72bd9c7055814d3f0f introduced
a build breakage if CONFIG_SMP is undefined. This patch
fixes the problem.

Reported-by: Ingo Molnar <mingo@elte.hu>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>

---
 drivers/hwmon/coretemp.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index baa842a..58a3c2d 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -503,9 +503,11 @@ static void coretemp_device_remove(unsigned int cpu)
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
