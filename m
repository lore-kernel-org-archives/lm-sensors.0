From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 22 Jul 2010 21:24:01 +0000
Subject: Re: [lm-sensors] [PATCH v2 0/3] hwmon: (coretemp) patches series
Message-Id: <20100722142401.417ec666.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1279530314-5945-1-git-send-email-gong.chen@linux.intel.com>
In-Reply-To: <1279530314-5945-1-git-send-email-gong.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 19 Jul 2010 17:05:11 +0800
Chen Gong <gong.chen@linux.intel.com> wrote:

> [PATCH v2 1/3] hwmon: (coretemp) update hotplug condition check
> [PATCH v2 2/3] hwmon: (coretemp) enable coretemp device add operation failure
> [PATCH v2 3/3] hwmon: (coretemp) documentation update and cleanup
> 
> discard the original one patch for package thermal sensor and send
> them to all guys in the get_maintainers.pl

The atches look OK to me.  I also queued up this cleanup:



Subject: drivers/hwmon/coretemp.c: remove unneeded #ifdef CONFIG_HOTPLUG_CPU

From: Andrew Morton <akpm@linux-foundation.org>

register_hotcpu_notifier() is designed to make these ifdefs unnecessary.

Cc: Chen Gong <gong.chen@linux.intel.com>
Cc: Rudolf Marek <r.marek@assembler.cz>
Cc: Huaxu Wan <huaxu.wan@intel.com>
Cc: Jean Delvare <khali@linux-fr.org>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/hwmon/coretemp.c |    4 ----
 1 file changed, 4 deletions(-)

diff -puN drivers/hwmon/coretemp.c~drivers-hwmon-coretempc-remove-unneeded-ifdef-config_cpu_hotplug drivers/hwmon/coretemp.c
--- a/drivers/hwmon/coretemp.c~drivers-hwmon-coretempc-remove-unneeded-ifdef-config_cpu_hotplug
+++ a/drivers/hwmon/coretemp.c
@@ -480,7 +480,6 @@ exit:
 	return err;
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
 static void coretemp_device_remove(unsigned int cpu)
 {
 	struct pdev_entry *p, *n;
@@ -518,7 +517,6 @@ static int __cpuinit coretemp_cpu_callba
 static struct notifier_block coretemp_cpu_notifier __refdata = {
 	.notifier_call = coretemp_cpu_callback,
 };
-#endif				/* !CONFIG_HOTPLUG_CPU */
 
 static int __init coretemp_init(void)
 {
@@ -552,9 +550,7 @@ static int __init coretemp_init(void)
 		goto exit_driver_unreg;
 	}
 
-#ifdef CONFIG_HOTPLUG_CPU
 	register_hotcpu_notifier(&coretemp_cpu_notifier);
-#endif
 	return 0;
 
 exit_driver_unreg:
_


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
