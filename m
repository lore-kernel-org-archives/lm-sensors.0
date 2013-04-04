From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Date: Thu, 04 Apr 2013 19:11:29 +0000
Subject: [lm-sensors] [PATCH 4/4] drivers/hwmon/coretemp : Debug fs interface
Message-Id: <1365102689-12581-5-git-send-email-srinivas.pandruvada@linux.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Added debug fs interface to check numer of interrupts and
number of time work function is scheduled.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hwmon/coretemp.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 100 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 689d3b8..94dfa9e 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -40,7 +40,7 @@
 #include <asm/processor.h>
 #include <asm/cpu_device_id.h>
 #include <asm/mce.h>
-
+#include <linux/debugfs.h>
 
 #define DRVNAME	"coretemp"
 
@@ -127,6 +127,99 @@ static unsigned long pkg_temp_scheduled;
 static DEFINE_PER_CPU(struct delayed_work, pkg_temp_threshold_work);
 static atomic_t pkg_thres_device_cnt =	ATOMIC_INIT(0);
 
+
+#ifdef CONFIG_DEBUG_FS
+
+#define PKG_TEMP_RD_BUFSIZE	32
+static struct dentry *debugfs;
+static unsigned int pkg_interrupt_cnt;
+static unsigned int pkg_work_cnt;
+#define INC_INTR_COUNTER	++pkg_interrupt_cnt
+#define INC_WORK_COUNTER	++pkg_work_cnt
+
+static ssize_t show_work_count(struct file *file, char __user *user_buf,
+				size_t count, loff_t *ppos)
+{
+	char *buf;
+	u32 len = 0;
+	ssize_t ret;
+
+	buf = kzalloc(PKG_TEMP_RD_BUFSIZE, GFP_KERNEL);
+	if (!buf)
+		return 0;
+
+	len = snprintf(buf, PKG_TEMP_RD_BUFSIZE, "[%d]\n", pkg_work_cnt);
+	ret =  simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	kfree(buf);
+
+	return ret;
+}
+
+static ssize_t show_interrupt_count(struct file *file, char __user *user_buf,
+				size_t count, loff_t *ppos)
+{
+	char *buf;
+	u32 len = 0;
+	ssize_t ret;
+
+	buf = kzalloc(PKG_TEMP_RD_BUFSIZE, GFP_KERNEL);
+	if (!buf)
+		return 0;
+
+	len = snprintf(buf, PKG_TEMP_RD_BUFSIZE, "[%d]\n", pkg_interrupt_cnt);
+	ret =  simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	kfree(buf);
+
+	return ret;
+}
+
+static const struct file_operations pkg_temp_intr_ops = {
+	.owner		= THIS_MODULE,
+	.open		= simple_open,
+	.read		= show_interrupt_count,
+	.llseek		= default_llseek,
+};
+
+static const struct file_operations pkg_temp_work_ops = {
+	.owner		= THIS_MODULE,
+	.open		= simple_open,
+	.read		= show_work_count,
+	.llseek		= default_llseek,
+};
+
+static int pkg_temp_debugfs_init(void)
+{
+
+	debugfs = debugfs_create_dir("coretemp", NULL);
+	if (!debugfs)
+		return -ENOMEM;
+
+	debugfs_create_file("threshold_interrupt", S_IFREG | S_IRUGO,
+			debugfs, (void *)NULL, &pkg_temp_intr_ops);
+
+	debugfs_create_file("threshold_work_fn", S_IFREG | S_IRUGO,
+			debugfs, (void *)NULL, &pkg_temp_work_ops);
+	return 0;
+}
+
+static void pkg_temp_debugfs_remove(void)
+{
+	if (debugfs)
+		debugfs_remove_recursive(debugfs);
+}
+#else
+#define INC_INTR_COUNTER
+#define INC_WORK_COUNTER
+static inline int pkg_temp_debugfs_init(void)
+{
+	return 0;
+}
+
+static inline void pkg_temp_debugfs_remove(void)
+{
+}
+#endif /* CONFIG_DEBUG_FS */
+
 #define define_device_show_thresholds(_index)		\
 static ssize_t show_threshold_##_index(struct device *dev, \
 			struct device_attribute *devattr, char *buf) \
@@ -585,6 +678,7 @@ static void pkg_temp_threshold_work_fn(struct work_struct *work)
 	__u64 msr_val;
 	bool notify = false;
 
+	INC_WORK_COUNTER;
 	clear_bit_unlock(TO_PHYS_ID(smp_processor_id()), &pkg_temp_scheduled);
 	enable_pkg_thres_interrupt();
 	rdmsrl(MSR_IA32_PACKAGE_THERM_STATUS, msr_val);
@@ -606,6 +700,7 @@ static int pkg_temp_platform_thermal_notify(__u64 msr_val)
 {
 	int cpu = smp_processor_id();
 
+	INC_INTR_COUNTER;
 	if (test_and_set_bit_lock(TO_PHYS_ID(cpu), &pkg_temp_scheduled))
 		return 0;
 	disable_pkg_thres_interrupt();
@@ -1027,6 +1122,9 @@ static int __init coretemp_init(void)
 
 	register_hotcpu_notifier(&coretemp_cpu_notifier);
 	put_online_cpus();
+
+	pkg_temp_debugfs_init();
+
 	return 0;
 
 #ifndef CONFIG_HOTPLUG_CPU
@@ -1043,6 +1141,7 @@ static void __exit coretemp_exit(void)
 
 	platform_thermal_package_notify = NULL;
 	platform_thermal_package_rate_control = NULL;
+	pkg_temp_debugfs_remove();
 
 	get_online_cpus();
 	unregister_hotcpu_notifier(&coretemp_cpu_notifier);
-- 
1.7.11.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
