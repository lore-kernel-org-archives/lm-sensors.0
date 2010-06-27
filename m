From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 27 Jun 2010 11:34:31 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (coretemp) Skip duplicate CPU
Message-Id: <20100627133431.53116d80@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On hyper-threaded CPUs, each core appears twice in the CPU list. Skip
the second entry to avoid duplicate sensors.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Huaxu Wan <huaxu.wan@intel.com>
---
This assumes that there is a single sensor on hyper-threaded cores.
Huaxu, can you please confirm this?

 drivers/hwmon/coretemp.c |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

--- linux-2.6.35-rc3.orig/drivers/hwmon/coretemp.c	2010-05-31 09:59:19.000000000 +0200
+++ linux-2.6.35-rc3/drivers/hwmon/coretemp.c	2010-06-27 10:14:51.000000000 +0200
@@ -405,6 +405,8 @@ struct pdev_entry {
 	struct list_head list;
 	struct platform_device *pdev;
 	unsigned int cpu;
+	u16 phys_proc_id;
+	u16 cpu_core_id;
 };
 
 static LIST_HEAD(pdev_list);
@@ -415,6 +417,18 @@ static int __cpuinit coretemp_device_add
 	int err;
 	struct platform_device *pdev;
 	struct pdev_entry *pdev_entry;
+	struct cpuinfo_x86 *c = &cpu_data(cpu);
+
+	mutex_lock(&pdev_list_mutex);
+
+	/* Skip second HT entry of each core */
+	list_for_each_entry(pdev_entry, &pdev_list, list) {
+		if (c->phys_proc_id = pdev_entry->phys_proc_id &&
+		    c->cpu_core_id = pdev_entry->cpu_core_id) {
+			err = 0;	/* Not an error */
+			goto exit;
+		}
+	}
 
 	pdev = platform_device_alloc(DRVNAME, cpu);
 	if (!pdev) {
@@ -438,7 +452,8 @@ static int __cpuinit coretemp_device_add
 
 	pdev_entry->pdev = pdev;
 	pdev_entry->cpu = cpu;
-	mutex_lock(&pdev_list_mutex);
+	pdev_entry->phys_proc_id = c->phys_proc_id;
+	pdev_entry->cpu_core_id = c->cpu_core_id;
 	list_add_tail(&pdev_entry->list, &pdev_list);
 	mutex_unlock(&pdev_list_mutex);
 
@@ -449,6 +464,7 @@ exit_device_free:
 exit_device_put:
 	platform_device_put(pdev);
 exit:
+	mutex_unlock(&pdev_list_mutex);
 	return err;
 }
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
