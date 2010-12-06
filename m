From: "Jan Beulich" <JBeulich@novell.com>
Date: Mon, 06 Dec 2010 16:48:35 +0000
Subject: [lm-sensors] [PATCH] sync via-cputemp with coretemp/pkgtemp
Message-Id: <4CFD21F302000078000262A5@vpn.id2.novell.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

... in terms of hotplug handling.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

---
 drivers/hwmon/via-cputemp.c |   25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

--- linux-2.6.37-rc4/drivers/hwmon/via-cputemp.c
+++ 2.6.37-rc4-x86-hwmon/drivers/hwmon/via-cputemp.c
@@ -237,13 +237,16 @@ exit:
 
 static void __cpuinit via_cputemp_device_remove(unsigned int cpu)
 {
-	struct pdev_entry *p, *n;
+	struct pdev_entry *p;
+
 	mutex_lock(&pdev_list_mutex);
-	list_for_each_entry_safe(p, n, &pdev_list, list) {
+	list_for_each_entry(p, &pdev_list, list) {
 		if (p->cpu = cpu) {
 			platform_device_unregister(p->pdev);
 			list_del(&p->list);
+			mutex_unlock(&pdev_list_mutex);
 			kfree(p);
+			return;
 		}
 	}
 	mutex_unlock(&pdev_list_mutex);
@@ -273,7 +276,6 @@ static struct notifier_block via_cputemp
 static int __init via_cputemp_init(void)
 {
 	int i, err;
-	struct pdev_entry *p, *n;
 
 	if (cpu_data(0).x86_vendor != X86_VENDOR_CENTAUR) {
 		printk(KERN_DEBUG DRVNAME ": Not a VIA CPU\n");
@@ -300,28 +302,23 @@ static int __init via_cputemp_init(void)
 			continue;
 		}
 
-		err = via_cputemp_device_add(i);
-		if (err)
-			goto exit_devices_unreg;
+		via_cputemp_device_add(i);
 	}
+
+#ifndef CONFIG_HOTPLUG_CPU
 	if (list_empty(&pdev_list)) {
 		err = -ENODEV;
 		goto exit_driver_unreg;
 	}
+#endif
 
 	register_hotcpu_notifier(&via_cputemp_cpu_notifier);
 	return 0;
 
-exit_devices_unreg:
-	mutex_lock(&pdev_list_mutex);
-	list_for_each_entry_safe(p, n, &pdev_list, list) {
-		platform_device_unregister(p->pdev);
-		list_del(&p->list);
-		kfree(p);
-	}
-	mutex_unlock(&pdev_list_mutex);
+#ifndef CONFIG_HOTPLUG_CPU
 exit_driver_unreg:
 	platform_driver_unregister(&via_cputemp_driver);
+#endif
 exit:
 	return err;
 }




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
