From: "Fenghua Yu" <fenghua.yu@intel.com>
Date: Fri, 03 Sep 2010 00:45:26 +0000
Subject: [lm-sensors] [PATCH] therm_throt.c: Fix error handling in
Message-Id: <1283474726-20109-1-git-send-email-fenghua.yu@intel.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, H Peter Anvin <hpa@zytor.com>, Len Brown <lenb@kernel.org>, Jin Dongming <jin.dongming@np.css.fujitsu.com>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Jean Delvare <khali@linux-fr.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>, Fenghua Yu <fenghua.yu@intel.com>

From: Fenghua Yu <fenghua.yu@intel.com>

Warn when sysfs_add_file_to_group fails.

Also add missing curly braces.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/kernel/cpu/mcheck/therm_throt.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/therm_throt.c b/arch/x86/kernel/cpu/mcheck/therm_throt.c
index c2a8b26..4c3cd62 100644
--- a/arch/x86/kernel/cpu/mcheck/therm_throt.c
+++ b/arch/x86/kernel/cpu/mcheck/therm_throt.c
@@ -211,20 +211,26 @@ static __cpuinit int thermal_throttle_add_dev(struct sys_device *sys_dev)
 	if (err)
 		return err;
 
-	if (cpu_has(c, X86_FEATURE_PLN))
+	if (cpu_has(c, X86_FEATURE_PLN)) {
 		err = sysfs_add_file_to_group(&sys_dev->kobj,
 					      &attr_core_power_limit_count.attr,
 					      thermal_attr_group.name);
-	if (cpu_has(c, X86_FEATURE_PTS))
+		WARN_ON(err);
+	}
+	if (cpu_has(c, X86_FEATURE_PTS)) {
 		err = sysfs_add_file_to_group(&sys_dev->kobj,
 					      &attr_package_throttle_count.attr,
 					      thermal_attr_group.name);
-		if (cpu_has(c, X86_FEATURE_PLN))
+		WARN_ON(err);
+		if (cpu_has(c, X86_FEATURE_PLN)) {
 			err = sysfs_add_file_to_group(&sys_dev->kobj,
 					&attr_package_power_limit_count.attr,
 					thermal_attr_group.name);
+			WARN_ON(err);
+		}
+	}
 
-	return err;
+	return 0;
 }
 
 static __cpuinit void thermal_throttle_remove_dev(struct sys_device *sys_dev)
-- 
1.6.0.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
