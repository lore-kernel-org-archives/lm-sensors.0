From: "Jan Beulich" <JBeulich@novell.com>
Date: Mon, 13 Sep 2010 10:17:59 +0000
Subject: [lm-sensors] [PATCH] x86/hwmon: fix initialization of coretemp
Message-Id: <4C8E16770200007800015ACC@vpn.id2.novell.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: fenghua.yu@intel.com, khali@linux-fr.org
Cc: r.marek@assembler.cz, mingo@elte.hu, tglx@linutronix.de, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, hpa@zytor.com

Using cpuid_eax() to determine feature availability on other than
the current CPU is invalid. And feature availability should also be
checked in the hotplug code path.

Signed-off-by: Jan Beulich <jbeulich@novell.com>
Cc: Rudolf Marek <r.marek@assembler.cz>

---
 arch/x86/include/asm/cpufeature.h |    1 +
 arch/x86/kernel/cpu/scattered.c   |    1 +
 drivers/hwmon/coretemp.c          |   29 +++++++++++++----------------
 3 files changed, 15 insertions(+), 16 deletions(-)

--- linux-2.6.36-rc4/arch/x86/include/asm/cpufeature.h	2010-09-13 08:44:55.000000000 +0200
+++ 2.6.36-rc4-x86-coretemp-feature-check/arch/x86/include/asm/cpufeature.h	2010-09-01 09:18:17.000000000 +0200
@@ -168,6 +168,7 @@
 #define X86_FEATURE_XSAVEOPT	(7*32+ 4) /* Optimized Xsave */
 #define X86_FEATURE_PLN		(7*32+ 5) /* Intel Power Limit Notification */
 #define X86_FEATURE_PTS		(7*32+ 6) /* Intel Package Thermal Status */
+#define X86_FEATURE_DTS		(7*32+ 7) /* Digital Thermal Sensor */
 
 /* Virtualization flags: Linux defined, word 8 */
 #define X86_FEATURE_TPR_SHADOW  (8*32+ 0) /* Intel TPR Shadow */
--- linux-2.6.36-rc4/arch/x86/kernel/cpu/scattered.c	2010-09-13 08:44:55.000000000 +0200
+++ 2.6.36-rc4-x86-coretemp-feature-check/arch/x86/kernel/cpu/scattered.c	2010-09-01 09:19:38.000000000 +0200
@@ -31,6 +31,7 @@ void __cpuinit init_scattered_cpuid_feat
 	const struct cpuid_bit *cb;
 
 	static const struct cpuid_bit __cpuinitconst cpuid_bits[] = {
+		{ X86_FEATURE_DTS,		CR_EAX, 0, 0x00000006, 0 },
 		{ X86_FEATURE_IDA,		CR_EAX, 1, 0x00000006, 0 },
 		{ X86_FEATURE_ARAT,		CR_EAX, 2, 0x00000006, 0 },
 		{ X86_FEATURE_PLN,		CR_EAX, 4, 0x00000006, 0 },
--- linux-2.6.36-rc4/drivers/hwmon/coretemp.c	2010-09-13 08:45:02.000000000 +0200
+++ 2.6.36-rc4-x86-coretemp-feature-check/drivers/hwmon/coretemp.c	2010-09-03 17:54:14.000000000 +0200
@@ -423,9 +423,18 @@ static int __cpuinit coretemp_device_add
 	int err;
 	struct platform_device *pdev;
 	struct pdev_entry *pdev_entry;
-#ifdef CONFIG_SMP
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
-#endif
+
+	/*
+	 * CPUID.06H.EAX[0] indicates whether the CPU has thermal
+	 * sensors. We check this bit only, all the early CPUs
+	 * without thermal sensors will be filtered out.
+	 */
+	if (!cpu_has(c, X86_FEATURE_DTS)) {
+		printk(KERN_INFO DRVNAME ": CPU (model=0x%x)"
+		       " has no thermal sensor.\n", c->x86_model);
+		return 0;
+	}
 
 	mutex_lock(&pdev_list_mutex);
 
@@ -527,20 +536,8 @@ static int __init coretemp_init(void)
 	if (err)
 		goto exit;
 
-	for_each_online_cpu(i) {
-		struct cpuinfo_x86 *c = &cpu_data(i);
-		/*
-		 * CPUID.06H.EAX[0] indicates whether the CPU has thermal
-		 * sensors. We check this bit only, all the early CPUs
-		 * without thermal sensors will be filtered out.
-		 */
-		if (c->cpuid_level >= 6 && (cpuid_eax(0x06) & 0x01))
-			coretemp_device_add(i);
-		else {
-			printk(KERN_INFO DRVNAME ": CPU (model=0x%x)"
-				" has no thermal sensor.\n", c->x86_model);
-		}
-	}
+	for_each_online_cpu(i)
+		coretemp_device_add(i);
 	if (list_empty(&pdev_list)) {
 		err = -ENODEV;
 		goto exit_driver_unreg;




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
