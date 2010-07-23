From: Chen Gong <gong.chen@linux.intel.com>
Date: Fri, 23 Jul 2010 02:09:27 +0000
Subject: [lm-sensors] [PATCH V3 2/3] hwmon: (coretemp) enable coretemp
Message-Id: <1279850968-12154-3-git-send-email-gong.chen@linux.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

if one coretemp device can't be added, it should allow subsequent
adding operation because every new-added device will create a new
sysfs group, not an additional sensor sys entry.hwmon: (coretemp) enable
coretemp device add operation failure

if one coretemp device can't be added, it should allow subsequent
adding operation because every new-added device will create a new
sysfs group, not an additional sensor sys entry.

Signed-off-by: Chen Gong <gong.chen@linux.intel.com>
---
 drivers/hwmon/coretemp.c |   17 +++--------------
 1 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index a3bad59..bdb7448 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -537,12 +537,9 @@ static int __init coretemp_init(void)
 		 * sensors. We check this bit only, all the early CPUs
 		 * without thermal sensors will be filtered out.
 		 */
-		if (c->cpuid_level >= 6 && (cpuid_eax(0x06) & 0x01)) {
-			err = coretemp_device_add(i);
-			if (err)
-				goto exit_devices_unreg;
-
-		} else {
+		if (c->cpuid_level >= 6 && (cpuid_eax(0x06) & 0x01))
+			coretemp_device_add(i);
+		else {
 			printk(KERN_INFO DRVNAME ": CPU (model=0x%x)"
 				" has no thermal sensor.\n", c->x86_model);
 		}
@@ -557,14 +554,6 @@ static int __init coretemp_init(void)
 #endif
 	return 0;
 
-exit_devices_unreg:
-	mutex_lock(&pdev_list_mutex);
-	list_for_each_entry_safe(p, n, &pdev_list, list) {
-		platform_device_unregister(p->pdev);
-		list_del(&p->list);
-		kfree(p);
-	}
-	mutex_unlock(&pdev_list_mutex);
 exit_driver_unreg:
 #ifndef CONFIG_HOTPLUG_CPU
 	platform_driver_unregister(&coretemp_driver);
-- 
1.7.2.rc3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
