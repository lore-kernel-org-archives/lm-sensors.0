From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Date: Thu, 04 Apr 2013 19:11:28 +0000
Subject: [lm-sensors] [PATCH 3/4] hwmon: (coretemp) : Add notification support
Message-Id: <1365102689-12581-4-git-send-email-srinivas.pandruvada@linux.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch add support of uevent notification once the thresholds
are violated.
It adds a 5 seconds debounce affect, to avoid repeated notifications and
control the rate of notifications. Since the log bit is sticky, it will
preserve the status.
Coretemp sysfs uses different sysfs path for each physical cpu id. This
patch will issue unique uevent for each physical device id.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hwmon/coretemp.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 6767af1..689d3b8 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -39,6 +39,8 @@
 #include <asm/msr.h>
 #include <asm/processor.h>
 #include <asm/cpu_device_id.h>
+#include <asm/mce.h>
+
 
 #define DRVNAME	"coretemp"
 
@@ -120,6 +122,11 @@ struct attribute_info {
 static LIST_HEAD(pdev_list);
 static DEFINE_MUTEX(pdev_list_mutex);
 
+#define PKG_TEMP_NOTIFY_DELAY		msecs_to_jiffies(5000)
+static unsigned long pkg_temp_scheduled;
+static DEFINE_PER_CPU(struct delayed_work, pkg_temp_threshold_work);
+static atomic_t pkg_thres_device_cnt =	ATOMIC_INIT(0);
+
 #define define_device_show_thresholds(_index)		\
 static ssize_t show_threshold_##_index(struct device *dev, \
 			struct device_attribute *devattr, char *buf) \
@@ -274,6 +281,11 @@ static ssize_t show_temp(struct device *dev,
 	return tdata->valid ? sprintf(buf, "%d\n", tdata->temp) : -EAGAIN;
 }
 
+static bool pkg_temp_platform_thermal_rate_control(void)
+{
+	return true;
+}
+
 struct tjmax {
 	char const *id;
 	int tjmax;
@@ -548,6 +560,62 @@ static struct temp_data __cpuinit *init_temp_data(unsigned int cpu,
 	return tdata;
 }
 
+static void enable_pkg_thres_interrupt(void)
+{
+	u32 l, h;
+	rdmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT, l, h);
+	wrmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT,
+		l | (THERM_INT_THRESHOLD0_ENABLE |
+			THERM_INT_THRESHOLD1_ENABLE), h);
+
+}
+
+static void disable_pkg_thres_interrupt(void)
+{
+	u32 l, h;
+	rdmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT, l, h);
+	wrmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT,
+		l & (~THERM_INT_THRESHOLD0_ENABLE) &
+		(~THERM_INT_THRESHOLD1_ENABLE), h);
+}
+
+static void pkg_temp_threshold_work_fn(struct work_struct *work)
+{
+	struct platform_device *pdev = coretemp_get_pdev(smp_processor_id());
+	__u64 msr_val;
+	bool notify = false;
+
+	clear_bit_unlock(TO_PHYS_ID(smp_processor_id()), &pkg_temp_scheduled);
+	enable_pkg_thres_interrupt();
+	rdmsrl(MSR_IA32_PACKAGE_THERM_STATUS, msr_val);
+	if (msr_val & THERM_LOG_THRESHOLD0) {
+		wrmsrl(MSR_IA32_PACKAGE_THERM_STATUS,
+				msr_val & ~THERM_LOG_THRESHOLD0);
+		notify = true;
+	}
+	if (msr_val & THERM_LOG_THRESHOLD1) {
+		wrmsrl(MSR_IA32_PACKAGE_THERM_STATUS,
+				msr_val & ~THERM_LOG_THRESHOLD1);
+		notify = true;
+	}
+	if (notify)
+		kobject_uevent(&pdev->dev.kobj, KOBJ_CHANGE);
+}
+
+static int pkg_temp_platform_thermal_notify(__u64 msr_val)
+{
+	int cpu = smp_processor_id();
+
+	if (test_and_set_bit_lock(TO_PHYS_ID(cpu), &pkg_temp_scheduled))
+		return 0;
+	disable_pkg_thres_interrupt();
+	schedule_delayed_work_on(cpu,
+				&per_cpu(pkg_temp_threshold_work, cpu),
+				PKG_TEMP_NOTIFY_DELAY);
+
+	return 0;
+}
+
 static int __cpuinit create_core_data(struct platform_device *pdev,
 				unsigned int cpu, int pkg_flag)
 {
@@ -615,8 +683,10 @@ static int __cpuinit create_core_data(struct platform_device *pdev,
 		 */
 		thres_cnt = clamp_val(thres_cnt, 0, MAX_NON_CORE_ATTRS);
 		dev_dbg(&pdev->dev, "No of thresholds %d\n", thres_cnt);
-		if (thres_cnt)
+		if (thres_cnt) {
 			tdata->attr_size += thres_cnt;
+			atomic_inc(&pkg_thres_device_cnt);
+		}
 	}
 
 	pdata->core_data[attr_no] = tdata;
@@ -832,6 +902,17 @@ static void __cpuinit get_core_online(unsigned int cpu)
 	 * So, just add interfaces for this core.
 	 */
 	coretemp_add_core(cpu, 0);
+
+	INIT_DELAYED_WORK(&per_cpu(pkg_temp_threshold_work, cpu),
+				pkg_temp_threshold_work_fn);
+
+	if (atomic_read(&pkg_thres_device_cnt)) {
+		/* Add threshold interrupt callbacks */
+		platform_thermal_package_notify +				pkg_temp_platform_thermal_notify;
+		platform_thermal_package_rate_control +				pkg_temp_platform_thermal_rate_control;
+	}
 }
 
 static void __cpuinit put_core_offline(unsigned int cpu)
@@ -880,6 +961,13 @@ static void __cpuinit put_core_offline(unsigned int cpu)
 	 */
 	if (!is_any_core_online(pdata))
 		coretemp_device_remove(cpu);
+
+	cancel_delayed_work_sync(&per_cpu(pkg_temp_threshold_work, cpu));
+
+	if (atomic_dec_return(&pkg_thres_device_cnt) = 0) {
+		platform_thermal_package_notify = NULL;
+		platform_thermal_package_rate_control = NULL;
+	}
 }
 
 static int __cpuinit coretemp_cpu_callback(struct notifier_block *nfb,
@@ -953,6 +1041,9 @@ static void __exit coretemp_exit(void)
 {
 	struct pdev_entry *p, *n;
 
+	platform_thermal_package_notify = NULL;
+	platform_thermal_package_rate_control = NULL;
+
 	get_online_cpus();
 	unregister_hotcpu_notifier(&coretemp_cpu_notifier);
 	mutex_lock(&pdev_list_mutex);
-- 
1.7.11.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
