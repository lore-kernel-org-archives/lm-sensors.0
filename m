From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Date: Thu, 04 Apr 2013 19:11:26 +0000
Subject: [lm-sensors] [PATCH 1/4] x86, mcheck, therm_throt: Process package thresholds
Message-Id: <1365102689-12581-2-git-send-email-srinivas.pandruvada@linux.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Added callback registration for package threshold reports. Also added
a callback to check the rate control implemented in callback or not.
If there is no rate control implemented, then there is a default rate
control similar to core threshold notification by delaying 300HZ between
reports.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 arch/x86/include/asm/mce.h               |  7 ++++
 arch/x86/kernel/cpu/mcheck/therm_throt.c | 63 ++++++++++++++++++++++++++++++--
 2 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index f4076af..4c619bf 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -214,6 +214,13 @@ void mce_log_therm_throt_event(__u64 status);
 /* Interrupt Handler for core thermal thresholds */
 extern int (*platform_thermal_notify)(__u64 msr_val);
 
+/* Interrupt Handler for package thermal thresholds */
+extern int (*platform_thermal_package_notify)(__u64 msr_val);
+
+/* Callback support of rate control, return true, if
+ * callback has rate control */
+extern bool (*platform_thermal_package_rate_control)(void);
+
 #ifdef CONFIG_X86_THERMAL_VECTOR
 extern void mcheck_intel_therm_init(void);
 #else
diff --git a/arch/x86/kernel/cpu/mcheck/therm_throt.c b/arch/x86/kernel/cpu/mcheck/therm_throt.c
index 47a1870..28cecab 100644
--- a/arch/x86/kernel/cpu/mcheck/therm_throt.c
+++ b/arch/x86/kernel/cpu/mcheck/therm_throt.c
@@ -54,12 +54,24 @@ struct thermal_state {
 	struct _thermal_state package_power_limit;
 	struct _thermal_state core_thresh0;
 	struct _thermal_state core_thresh1;
+	struct _thermal_state pkg_thresh0;
+	struct _thermal_state pkg_thresh1;
 };
 
 /* Callback to handle core threshold interrupts */
 int (*platform_thermal_notify)(__u64 msr_val);
 EXPORT_SYMBOL(platform_thermal_notify);
 
+/* Callback to handle core package threshold_interrupts */
+int (*platform_thermal_package_notify)(__u64 msr_val);
+EXPORT_SYMBOL(platform_thermal_package_notify);
+
+/* Callback support of rate control, return true, if
+ * callback has rate control */
+bool (*platform_thermal_package_rate_control)(void);
+EXPORT_SYMBOL(platform_thermal_package_rate_control);
+
+
 static DEFINE_PER_CPU(struct thermal_state, thermal_state);
 
 static atomic_t therm_throt_en	= ATOMIC_INIT(0);
@@ -203,19 +215,25 @@ static int therm_throt_process(bool new_event, int event, int level)
 	return 0;
 }
 
-static int thresh_event_valid(int event)
+static int thresh_event_valid(int level, int event)
 {
 	struct _thermal_state *state;
 	unsigned int this_cpu = smp_processor_id();
 	struct thermal_state *pstate = &per_cpu(thermal_state, this_cpu);
 	u64 now = get_jiffies_64();
 
-	state = (event = 0) ? &pstate->core_thresh0 : &pstate->core_thresh1;
+	if (level = PACKAGE_LEVEL)
+		state = (event = 0) ? &pstate->pkg_thresh0 :
+						&pstate->pkg_thresh1;
+	else
+		state = (event = 0) ? &pstate->core_thresh0 :
+						&pstate->core_thresh1;
 
 	if (time_before64(now, state->next_check))
 		return 0;
 
 	state->next_check = now + CHECK_INTERVAL;
+
 	return 1;
 }
 
@@ -321,6 +339,39 @@ device_initcall(thermal_throttle_init_device);
 
 #endif /* CONFIG_SYSFS */
 
+static void notify_package_thresholds(__u64 msr_val)
+{
+	bool notify_thres_0 = false;
+	bool notify_thres_1 = false;
+
+	if (!platform_thermal_package_notify)
+		return;
+
+	/* lower threshold check */
+	if (msr_val & THERM_LOG_THRESHOLD0)
+		notify_thres_0 = true;
+	/* higher threshold check */
+	if (msr_val & THERM_LOG_THRESHOLD1)
+		notify_thres_1 = true;
+
+	if (!notify_thres_0 && !notify_thres_1)
+		return;
+
+	if (platform_thermal_package_rate_control &&
+		platform_thermal_package_rate_control()) {
+		/* Rate control is implemented in callback */
+		platform_thermal_package_notify(msr_val);
+		return;
+	}
+
+	/* lower threshold reached */
+	if (notify_thres_0 && thresh_event_valid(PACKAGE_LEVEL, 0))
+		platform_thermal_package_notify(msr_val);
+	/* higher threshold reached */
+	if (notify_thres_1 && thresh_event_valid(PACKAGE_LEVEL, 1))
+		platform_thermal_package_notify(msr_val);
+}
+
 static void notify_thresholds(__u64 msr_val)
 {
 	/* check whether the interrupt handler is defined;
@@ -330,10 +381,12 @@ static void notify_thresholds(__u64 msr_val)
 		return;
 
 	/* lower threshold reached */
-	if ((msr_val & THERM_LOG_THRESHOLD0) &&	thresh_event_valid(0))
+	if ((msr_val & THERM_LOG_THRESHOLD0) &&
+			thresh_event_valid(CORE_LEVEL, 0))
 		platform_thermal_notify(msr_val);
 	/* higher threshold reached */
-	if ((msr_val & THERM_LOG_THRESHOLD1) && thresh_event_valid(1))
+	if ((msr_val & THERM_LOG_THRESHOLD1) &&
+			thresh_event_valid(CORE_LEVEL, 1))
 		platform_thermal_notify(msr_val);
 }
 
@@ -359,6 +412,8 @@ static void intel_thermal_interrupt(void)
 
 	if (this_cpu_has(X86_FEATURE_PTS)) {
 		rdmsrl(MSR_IA32_PACKAGE_THERM_STATUS, msr_val);
+		/* check violations of package thermal thresholds */
+		notify_package_thresholds(msr_val);
 		therm_throt_process(msr_val & PACKAGE_THERM_STATUS_PROCHOT,
 					THERMAL_THROTTLING_EVENT,
 					PACKAGE_LEVEL);
-- 
1.7.11.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
