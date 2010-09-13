From: "Jan Beulich" <JBeulich@novell.com>
Date: Mon, 13 Sep 2010 10:18:54 +0000
Subject: [lm-sensors] [PATCH] x86/hwmon: fix initialization of pkgtemp
Message-Id: <4C8E16AE0200007800015ACF@vpn.id2.novell.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4C8E16770200007800015ACC@vpn.id2.novell.com>
In-Reply-To: <4C8E16770200007800015ACC@vpn.id2.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: khali@linux-fr.org
Cc: fenghua.yu@intel.com, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Feature availability should also be checked in the hotplug code path.

Signed-off-by: Jan Beulich <jbeulich@novell.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>

---
 drivers/hwmon/pkgtemp.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

--- linux-2.6.36-rc4/drivers/hwmon/pkgtemp.c	2010-09-13 08:45:03.000000000 +0200
+++ 2.6.36-rc4-x86-pkgtemp-feature-check/drivers/hwmon/pkgtemp.c	2010-09-03 17:54:30.000000000 +0200
@@ -281,9 +281,10 @@ static int __cpuinit pkgtemp_device_add(
 	int err;
 	struct platform_device *pdev;
 	struct pdev_entry *pdev_entry;
-#ifdef CONFIG_SMP
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
-#endif
+
+	if (!cpu_has(c, X86_FEATURE_PTS))
+		return 0;
 
 	mutex_lock(&pdev_list_mutex);
 
@@ -399,11 +400,6 @@ static int __init pkgtemp_init(void)
 		goto exit;
 
 	for_each_online_cpu(i) {
-		struct cpuinfo_x86 *c = &cpu_data(i);
-
-		if (!cpu_has(c, X86_FEATURE_PTS))
-			continue;
-
 		err = pkgtemp_device_add(i);
 		if (err)
 			goto exit_devices_unreg;




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
