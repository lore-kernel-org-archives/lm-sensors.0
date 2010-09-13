From: "Jan Beulich" <JBeulich@novell.com>
Date: Mon, 13 Sep 2010 10:23:05 +0000
Subject: [lm-sensors] [PATCH] x86/hwmon: register alternate sibling upon CPU
Message-Id: <4C8E17A90200007800015AE6@vpn.id2.novell.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: fenghua.yu@intel.com, khali@linux-fr.org
Cc: r.marek@assembler.cz, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Just like pkgtemp registers another core of the same package when one
gets removed, coretemp should register another hyperthread (if
available) in that situation.

As pointed out in the patch fixing the respective code in pkgtemp, the
list protectng mutex must be dropped before calling
coretemp_device_add(), and due to the restructured loop (including an
explicit return) the "safe" variant of the list iterator isn't needed
anymore.

Signed-off-by: Jan Beulich <jbeulich@novell.com>
Cc: Rudolf Marek <r.marek@assembler.cz>

---
 drivers/hwmon/coretemp.c |   22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

--- linux-2.6.36-rc4/drivers/hwmon/coretemp.c	2010-09-13 08:45:02.000000000 +0200
+++ 2.6.36-rc4-x86-coretemp-remove-deadlock/drivers/hwmon/coretemp.c	2010-09-03 17:54:14.000000000 +0200
@@ -482,14 +482,22 @@ exit:
 
 static void coretemp_device_remove(unsigned int cpu)
 {
-	struct pdev_entry *p, *n;
+	struct pdev_entry *p;
+	unsigned int i;
+
 	mutex_lock(&pdev_list_mutex);
-	list_for_each_entry_safe(p, n, &pdev_list, list) {
-		if (p->cpu = cpu) {
-			platform_device_unregister(p->pdev);
-			list_del(&p->list);
-			kfree(p);
-		}
+	list_for_each_entry(p, &pdev_list, list) {
+		if (p->cpu != cpu)
+			continue;
+
+		platform_device_unregister(p->pdev);
+		list_del(&p->list);
+		mutex_unlock(&pdev_list_mutex);
+		kfree(p);
+		for_each_cpu(i, cpu_sibling_mask(cpu))
+			if (i != cpu && !coretemp_device_add(i))
+				break;
+		return;
 	}
 	mutex_unlock(&pdev_list_mutex);
 }




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
