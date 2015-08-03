From: Punit Agrawal <punit.agrawal@arm.com>
Date: Mon, 03 Aug 2015 15:22:50 +0000
Subject: [lm-sensors] [PATCH v2 02/10] cpufreq-dt: Supply power coefficient when registering cooling devices
Message-Id: <1438615378-14241-3-git-send-email-punit.agrawal@arm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1438615378-14241-1-git-send-email-punit.agrawal@arm.com>
In-Reply-To: <1438615378-14241-1-git-send-email-punit.agrawal@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-pm@vger.kernel.org
Cc: Punit Agrawal <punit.agrawal@arm.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, liviu.dudau@arm.com, Eduardo Valentin <edubezval@gmail.com>

Support registering cooling devices with dynamic power coefficient
where provided by the device tree. This allows OF registered cooling
devices driver to be used with the power_allocator thermal governor.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/cpufreq/cpufreq-dt.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 528a82bf..1d1f61a 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -344,8 +344,13 @@ static void cpufreq_ready(struct cpufreq_policy *policy)
 	 * thermal DT code takes care of matching them.
 	 */
 	if (of_find_property(np, "#cooling-cells", NULL)) {
-		priv->cdev = of_cpufreq_cooling_register(np,
-							 policy->related_cpus);
+		u32 power_coefficient = 0;
+
+		of_property_read_u32(np, "dynamic-power-coefficient",
+				     &power_coefficient);
+
+		priv->cdev = of_cpufreq_power_cooling_register(np,
+				policy->related_cpus, power_coefficient, NULL);
 		if (IS_ERR(priv->cdev)) {
 			dev_err(priv->cpu_dev,
 				"running cpufreq without cooling device: %ld\n",
-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
