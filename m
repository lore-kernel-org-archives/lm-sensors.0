From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 11 May 2010 14:42:42 +0000
Subject: Re: [lm-sensors] Intel Atom thermal sensors
Message-Id: <20100511164242.44c79015@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <u2oe21d97a51004271247n7f5d4fbcn2a3de7429c738a08@mail.gmail.com>
In-Reply-To: <u2oe21d97a51004271247n7f5d4fbcn2a3de7429c738a08@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Dmitry,

On Tue, 11 May 2010 09:44:49 -0400, Dmitry Gromov wrote:
> Hi!
> 
> Well, if anyone is interested. I successfully installed Ubuntu Server 10.04:
> 
> Linux dgwind1 2.6.32-21-generic #32-Ubuntu SMP Fri Apr 16 08:09:38 UTC
> 2010 x86_64 GNU/Linux
> 
> I re-run sensors-detect hoping it would fix configuration and allow
> Intel Atom sensors to be reported.
> It did detect those sensors... but failed to add coretemp driver to /etc/modules
> 
> Once I loaded coretemp driver, I was able to see 4 outputs of Atom
> temperature sensors - this is dual core N330 CPU, with hyperthreading.
> What is interesting though is that it seems like probe of one core
> reported as Core 0 and 2 and probe of the second core is reported as
> Core 1 and 3

This is my experience as well. And I think this is incorrect. I'm
almost certain that there's only one thermal sensor per core, so
hyperthreaded cores should only be listed once. I have a patch fixing
this see, below if you want to give it a try.

> - I thought, they'd be reported sequentially.

This is due to the way the kernel enumerates the CPUs. As I understand
it, it enumerates all cores first, and only then the hyperthreaded
siblings.

* * * * *

From: Jean Delvare <khali@linux-fr.org>
Subject: hwmon: (coretemp) Skip duplicate CPU entries

On hyperthreaded CPUs, each core appears twice in the CPU list. Skip
the second entry to avoid duplicate sensors.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/coretemp.c |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

Index: linux-2.6.33/drivers/hwmon/coretemp.c
=================================--- linux-2.6.33.orig/drivers/hwmon/coretemp.c
+++ linux-2.6.33/drivers/hwmon/coretemp.c
@@ -352,6 +352,8 @@ struct pdev_entry {
 	struct list_head list;
 	struct platform_device *pdev;
 	unsigned int cpu;
+	u16 phys_proc_id;
+	u16 cpu_core_id;
 };
 
 static LIST_HEAD(pdev_list);
@@ -362,6 +364,18 @@ static int __cpuinit coretemp_device_add
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
@@ -385,7 +399,8 @@ static int __cpuinit coretemp_device_add
 
 	pdev_entry->pdev = pdev;
 	pdev_entry->cpu = cpu;
-	mutex_lock(&pdev_list_mutex);
+	pdev_entry->phys_proc_id = c->phys_proc_id;
+	pdev_entry->cpu_core_id = c->cpu_core_id;
 	list_add_tail(&pdev_entry->list, &pdev_list);
 	mutex_unlock(&pdev_list_mutex);
 
@@ -396,6 +411,7 @@ exit_device_free:
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
