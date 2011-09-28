From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 28 Sep 2011 09:57:11 +0000
Subject: Re: [lm-sensors] [PATCH] coretemp: don't use kernel assigned CPU
Message-Id: <20110928115711.136f2542@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4E7C7CF40200007800057865@nat28.tlf.novell.com>
In-Reply-To: <4E7C7CF40200007800057865@nat28.tlf.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jan, Guenter,

On Fri, 23 Sep 2011 10:37:58 -0700, Guenter Roeck wrote:
> On Fri, 2011-09-23 at 06:35 -0400, Jan Beulich wrote:
> > ... as that has the potential to conflict with (particularly soft) CPU
> > hot removal and re-adding.
> > 
> > Signed-off-by: Jan Beulich <jbeulich@suse.com>
> > 
> > ---
> >  drivers/hwmon/coretemp.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > --- 3.1-rc7-coretemp.orig/drivers/hwmon/coretemp.c
> > +++ 3.1-rc7-coretemp/drivers/hwmon/coretemp.c
> > @@ -724,7 +724,7 @@ static int __cpuinit coretemp_device_add
> >  
> >  	mutex_lock(&pdev_list_mutex);
> >  
> > -	pdev = platform_device_alloc(DRVNAME, cpu);
> > +	pdev = platform_device_alloc(DRVNAME, TO_PHYS_ID(cpu));
> 
> This is incomplete, unfortunately. pdev->id is assumed to match the CPU
> ID, not the physical ID, and the code executes TO_PHYS_ID() again on it.
> I'll update the patch to fix that problem and apply it.
> 
> Guenter

This has been on my to-do list for a long time but I never got around
to doing it. Thanks Jan for stepping in.

However it seems that the patch isn't OK, not even after Guenter's fix.
chk_ucode_version() assumes that pdev->id is a CPU number, not a
physical CPU ID, so currently the microcode checks are done on random
CPUs. Probably the microcode check should be moved from
coretemp_probe() to get_core_online(), which makes sense anyway, as
there is little point in creating a platform device if it's not going
to work.

I have the following fix:

From: Jean Delvare <khali@linux-fr.org>
Subject: hwmon: (coretemp) Fixup platform device ID change

With recent change "hwmon: (coretemp) don't use kernel assigned CPU
number as platform device ID", the microcode check is now running on
random CPU. Fix that by checking the microcode before creating the
platform device rather than at probe time.

Also avoid calling TO_PHYS_ID(cpu) twice in the same function, it's
expensive.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Jan Beulich <jbeulich@suse.com>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/coretemp.c |   27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

--- linux-3.1-rc4.orig/drivers/hwmon/coretemp.c	2011-09-27 17:01:28.000000000 +0200
+++ linux-3.1-rc4/drivers/hwmon/coretemp.c	2011-09-28 11:00:44.000000000 +0200
@@ -503,9 +503,9 @@ exit_free:
 }
 
 
-static int __devinit chk_ucode_version(struct platform_device *pdev)
+static int __cpuinit chk_ucode_version(unsigned int cpu)
 {
-	struct cpuinfo_x86 *c = &cpu_data(pdev->id);
+	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	int err;
 	u32 edx;
 
@@ -516,17 +516,15 @@ static int __devinit chk_ucode_version(s
 	 */
 	if (c->x86_model = 0xe && c->x86_mask < 0xc) {
 		/* check for microcode update */
-		err = smp_call_function_single(pdev->id, get_ucode_rev_on_cpu,
+		err = smp_call_function_single(cpu, get_ucode_rev_on_cpu,
 					       &edx, 1);
 		if (err) {
-			dev_err(&pdev->dev,
-				"Cannot determine microcode revision of "
-				"CPU#%u (%d)!\n", pdev->id, err);
+			pr_err("Cannot determine microcode revision of "
+			       "CPU#%u (%d)!\n", cpu, err);
 			return -ENODEV;
 		} else if (edx < 0x39) {
-			dev_err(&pdev->dev,
-				"Errata AE18 not fixed, update BIOS or "
-				"microcode of the CPU!\n");
+			pr_err("Errata AE18 not fixed, update BIOS or "
+			       "microcode of the CPU!\n");
 			return -ENODEV;
 		}
 	}
@@ -686,11 +684,6 @@ static int __devinit coretemp_probe(stru
 	struct platform_data *pdata;
 	int err;
 
-	/* Check the microcode version of the CPU */
-	err = chk_ucode_version(pdev);
-	if (err)
-		return err;
-
 	/* Initialize the per-package data structures */
 	pdata = kzalloc(sizeof(struct platform_data), GFP_KERNEL);
 	if (!pdata)
@@ -772,7 +765,7 @@ static int __cpuinit coretemp_device_add
 	}
 
 	pdev_entry->pdev = pdev;
-	pdev_entry->phys_proc_id = TO_PHYS_ID(cpu);
+	pdev_entry->phys_proc_id = pdev->id;
 
 	list_add_tail(&pdev_entry->list, &pdev_list);
 	mutex_unlock(&pdev_list_mutex);
@@ -833,6 +826,10 @@ static void __cpuinit get_core_online(un
 		return;
 
 	if (!pdev) {
+		/* Check the microcode version of the CPU */
+		if (chk_ucode_version(cpu))
+			return;
+
 		/*
 		 * Alright, we have DTS support.
 		 * We are bringing the _first_ core in this pkg




-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
