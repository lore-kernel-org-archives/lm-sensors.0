From: Chen Gong <gong.chen@linux.intel.com>
Date: Sat, 09 Oct 2010 02:01:48 +0000
Subject: [lm-sensors] [PATCH] hwmon: cleanup useless hotplug related macro
Message-Id: <1286589708-18478-2-git-send-email-gong.chen@linux.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1286517216-15640-3-git-send-email-gong.chen@linux.intel.com>
In-Reply-To: <1286517216-15640-3-git-send-email-gong.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: guenter.roeck@ericsson.com
Cc: lm-sensors@lm-sensors.org, JBeulich@novell.com, linux-kernel@vger.kernel.org, Chen Gong <gong.chen@linux.intel.com>

CONFIG_HOTPLUG_CPU is used too much in some drivers.
This patch clean them up.

Signed-off-by: Chen Gong <gong.chen@linux.intel.com>
---
 drivers/hwmon/coretemp.c    |    3 +--
 drivers/hwmon/pkgtemp.c     |    7 +------
 drivers/hwmon/via-cputemp.c |    7 +------
 3 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index b4aea20..467488c 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -566,9 +566,8 @@ exit:
 static void __exit coretemp_exit(void)
 {
 	struct pdev_entry *p, *n;
-#ifdef CONFIG_HOTPLUG_CPU
+
 	unregister_hotcpu_notifier(&coretemp_cpu_notifier);
-#endif
 	mutex_lock(&pdev_list_mutex);
 	list_for_each_entry_safe(p, n, &pdev_list, list) {
 		platform_device_unregister(p->pdev);
diff --git a/drivers/hwmon/pkgtemp.c b/drivers/hwmon/pkgtemp.c
index a8fc35e..0798210 100644
--- a/drivers/hwmon/pkgtemp.c
+++ b/drivers/hwmon/pkgtemp.c
@@ -339,7 +339,6 @@ exit:
 	return err;
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
 static void __cpuinit pkgtemp_device_remove(unsigned int cpu)
 {
 	struct pdev_entry *p;
@@ -387,7 +386,6 @@ static int __cpuinit pkgtemp_cpu_callback(struct notifier_block *nfb,
 static struct notifier_block pkgtemp_cpu_notifier __refdata = {
 	.notifier_call = pkgtemp_cpu_callback,
 };
-#endif				/* !CONFIG_HOTPLUG_CPU */
 
 static int __init pkgtemp_init(void)
 {
@@ -411,9 +409,7 @@ static int __init pkgtemp_init(void)
 	}
 #endif
 
-#ifdef CONFIG_HOTPLUG_CPU
 	register_hotcpu_notifier(&pkgtemp_cpu_notifier);
-#endif
 	return 0;
 
 #ifndef CONFIG_HOTPLUG_CPU
@@ -427,9 +423,8 @@ exit:
 static void __exit pkgtemp_exit(void)
 {
 	struct pdev_entry *p, *n;
-#ifdef CONFIG_HOTPLUG_CPU
+
 	unregister_hotcpu_notifier(&pkgtemp_cpu_notifier);
-#endif
 	mutex_lock(&pdev_list_mutex);
 	list_for_each_entry_safe(p, n, &pdev_list, list) {
 		platform_device_unregister(p->pdev);
diff --git a/drivers/hwmon/via-cputemp.c b/drivers/hwmon/via-cputemp.c
index ba7839b..ec7fad7 100644
--- a/drivers/hwmon/via-cputemp.c
+++ b/drivers/hwmon/via-cputemp.c
@@ -235,7 +235,6 @@ exit:
 	return err;
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
 static void __cpuinit via_cputemp_device_remove(unsigned int cpu)
 {
 	struct pdev_entry *p, *n;
@@ -270,7 +269,6 @@ static int __cpuinit via_cputemp_cpu_callback(struct notifier_block *nfb,
 static struct notifier_block via_cputemp_cpu_notifier __refdata = {
 	.notifier_call = via_cputemp_cpu_callback,
 };
-#endif				/* !CONFIG_HOTPLUG_CPU */
 
 static int __init via_cputemp_init(void)
 {
@@ -311,9 +309,7 @@ static int __init via_cputemp_init(void)
 		goto exit_driver_unreg;
 	}
 
-#ifdef CONFIG_HOTPLUG_CPU
 	register_hotcpu_notifier(&via_cputemp_cpu_notifier);
-#endif
 	return 0;
 
 exit_devices_unreg:
@@ -333,9 +329,8 @@ exit:
 static void __exit via_cputemp_exit(void)
 {
 	struct pdev_entry *p, *n;
-#ifdef CONFIG_HOTPLUG_CPU
+
 	unregister_hotcpu_notifier(&via_cputemp_cpu_notifier);
-#endif
 	mutex_lock(&pdev_list_mutex);
 	list_for_each_entry_safe(p, n, &pdev_list, list) {
 		platform_device_unregister(p->pdev);
-- 
1.7.2.2.173.g515cc


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
