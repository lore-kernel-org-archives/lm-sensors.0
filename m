From: Punit Agrawal <punit.agrawal@arm.com>
Date: Mon, 03 Aug 2015 15:22:51 +0000
Subject: [lm-sensors] [PATCH v2 03/10] cpufreq: arm_big_little: Add support to register a cpufreq cooling dev
Message-Id: <1438615378-14241-4-git-send-email-punit.agrawal@arm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1438615378-14241-1-git-send-email-punit.agrawal@arm.com>
In-Reply-To: <1438615378-14241-1-git-send-email-punit.agrawal@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-pm@vger.kernel.org
Cc: Punit Agrawal <punit.agrawal@arm.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, liviu.dudau@arm.com, Sudeep Holla <sudeep.holla@arm.com>, Eduardo Valentin <edubezval@gmail.com>

Register passive cooling devices when initialising cpufreq on
big.LITTLE systems. If the device tree provides a dynamic power
coefficient for the CPUs then the bound cooling device will support
the extensions that allow it to be used with all the existing thermal
governors including the power allocator governor.

A cooling device will be created per individual frequency domain and
can be bound to thermal zones via the thermal DT bindings.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/cpufreq/arm_big_little.c | 52 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index f1e42f8..72a2777 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -23,6 +23,7 @@
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/cpumask.h>
+#include <linux/cpu_cooling.h>
 #include <linux/export.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -55,6 +56,10 @@ static bool bL_switching_enabled;
 #define ACTUAL_FREQ(cluster, freq)  ((cluster = A7_CLUSTER) ? freq << 1 : freq)
 #define VIRT_FREQ(cluster, freq)    ((cluster = A7_CLUSTER) ? freq >> 1 : freq)
 
+struct private_data {
+	struct thermal_cooling_device *cdev;
+};
+
 static struct cpufreq_arm_bL_ops *arm_bL_ops;
 static struct clk *clk[MAX_CLUSTERS];
 static struct cpufreq_frequency_table *freq_table[MAX_CLUSTERS + 1];
@@ -440,6 +445,7 @@ static int bL_cpufreq_init(struct cpufreq_policy *policy)
 {
 	u32 cur_cluster = cpu_to_cluster(policy->cpu);
 	struct device *cpu_dev;
+	struct private_data *priv;
 	int ret;
 
 	cpu_dev = get_cpu_device(policy->cpu);
@@ -457,9 +463,15 @@ static int bL_cpufreq_init(struct cpufreq_policy *policy)
 	if (ret) {
 		dev_err(cpu_dev, "CPU %d, cluster: %d invalid freq table\n",
 				policy->cpu, cur_cluster);
-		put_cluster_clk_and_freq_table(cpu_dev);
-		return ret;
+		goto out_free_cpufreq_table;
+	}
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		ret = -ENOMEM;
+		goto out_free_cpufreq_table;
 	}
+	policy->driver_data = priv;
 
 	if (cur_cluster < MAX_CLUSTERS) {
 		int cpu;
@@ -484,12 +496,19 @@ static int bL_cpufreq_init(struct cpufreq_policy *policy)
 
 	dev_info(cpu_dev, "%s: CPU %d initialized\n", __func__, policy->cpu);
 	return 0;
+
+out_free_cpufreq_table:
+	put_cluster_clk_and_freq_table(cpu_dev);
+
+	return ret;
 }
 
 static int bL_cpufreq_exit(struct cpufreq_policy *policy)
 {
 	struct device *cpu_dev;
+	struct private_data *priv = policy->driver_data;
 
+	cpufreq_cooling_unregister(priv->cdev);
 	cpu_dev = get_cpu_device(policy->cpu);
 	if (!cpu_dev) {
 		pr_err("%s: failed to get cpu%d device\n", __func__,
@@ -498,11 +517,39 @@ static int bL_cpufreq_exit(struct cpufreq_policy *policy)
 	}
 
 	put_cluster_clk_and_freq_table(cpu_dev);
+	kfree(priv);
 	dev_dbg(cpu_dev, "%s: Exited, cpu: %d\n", __func__, policy->cpu);
 
 	return 0;
 }
 
+static void bL_cpufreq_ready(struct cpufreq_policy *policy)
+{
+	struct device *cpu_dev = get_cpu_device(policy->cpu);
+	struct device_node *np = of_node_get(cpu_dev->of_node);
+	struct private_data *priv = policy->driver_data;
+
+	if (WARN_ON(!np))
+		return;
+
+	if (of_find_property(np, "#cooling-cells", NULL)) {
+		u32 power_coefficient = 0;
+
+		of_property_read_u32(np, "dynamic-power-coefficient",
+				     &power_coefficient);
+
+		priv->cdev = of_cpufreq_power_cooling_register(np,
+				policy->related_cpus, power_coefficient, NULL);
+		if (IS_ERR(priv->cdev)) {
+			dev_err(cpu_dev,
+				"running cpufreq without cooling device: %ld\n",
+				PTR_ERR(priv->cdev));
+			priv->cdev = NULL;
+		}
+	}
+	of_node_put(np);
+}
+
 static struct cpufreq_driver bL_cpufreq_driver = {
 	.name			= "arm-big-little",
 	.flags			= CPUFREQ_STICKY |
@@ -513,6 +560,7 @@ static struct cpufreq_driver bL_cpufreq_driver = {
 	.get			= bL_cpufreq_get_rate,
 	.init			= bL_cpufreq_init,
 	.exit			= bL_cpufreq_exit,
+	.ready			= bL_cpufreq_ready,
 	.attr			= cpufreq_generic_attr,
 };
 
-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
