From: Wei Ni <wni@nvidia.com>
Date: Mon, 18 Feb 2013 11:30:29 +0000
Subject: [lm-sensors] [RFC PATCH 7/9] thermal: tegra30: add tegra30 thermal driver
Message-Id: <1361187031-3679-8-git-send-email-wni@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1361187031-3679-1-git-send-email-wni@nvidia.com>
In-Reply-To: <1361187031-3679-1-git-send-email-wni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: durgadoss.r@intel.com, rui.zhang@intel.com, MLongnecker@nvidia.com, khali@linux-fr.org
Cc: devicetree-discuss@lists.ozlabs.org, linux-tegra@vger.kernel.org, lm-sensors@lm-sensors.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.orgrs.org, linux-arm-kernel@lists.infradead.org, Wei Ni <wni@nvidia.com>

dd Tegra30 thermal driver support. It create thermal zone with thermal
sensors and cooling device to participate in the linux thermal management.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 drivers/thermal/Kconfig          |    9 ++
 drivers/thermal/Makefile         |    1 +
 drivers/thermal/tegra3_thermal.c |  289 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 299 insertions(+)
 create mode 100644 drivers/thermal/tegra3_thermal.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index eadef5b..2403681 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -141,6 +141,15 @@ config INTEL_POWERCLAMP
 	  enforce idle time which results in more package C-state residency. The
 	  user interface is exposed via generic thermal framework.
 
+config TEGRA30_THERMAL
+	tristate "Tegra30 thermal driver"
+	depends on ARCH_TEGRA
+	help
+	  Select this to enable the Tegra30 thermal driver. Adds Tegra30 thermal
+	  implementation according to the thermal management framework. Create
+	  thermal zone with thermal sensors and cooling device to participate
+	  in the linux thermal management.
+
 config THERMAL_TEST
 	tristate "test driver"
 	help
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index ee0f687..de0b411 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_EXYNOS_THERMAL)	+= exynos_thermal.o
 obj-$(CONFIG_DB8500_THERMAL)	+= db8500_thermal.o
 obj-$(CONFIG_DB8500_CPUFREQ_COOLING)	+= db8500_cpufreq_cooling.o
 obj-$(CONFIG_INTEL_POWERCLAMP)	+= intel_powerclamp.o
+obj-$(CONFIG_TEGRA30_THERMAL)	+= tegra3_thermal.o
 
 # dummy driver for testing
 obj-$(CONFIG_THERMAL_TEST)	+= thermal_test.o
diff --git a/drivers/thermal/tegra3_thermal.c b/drivers/thermal/tegra3_thermal.c
new file mode 100644
index 0000000..384168f
--- /dev/null
+++ b/drivers/thermal/tegra3_thermal.c
@@ -0,0 +1,289 @@
+/*
+ * Tegra thermal driver.
+ *
+ * Copyright (C) 2010-2013 NVIDIA Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/kernel.h>
+#include <linux/mutex.h>
+#include <linux/err.h>
+#include <linux/debugfs.h>
+#include <linux/of.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/thermal.h>
+
+#define MAX_THROT_TABLE_SIZE    (64)
+
+struct throttle_table {
+	unsigned int cpu_freq;
+	int core_cap_level;
+};
+
+struct balanced_throttle {
+	struct thermal_cooling_device *cdev;
+	struct list_head node;
+	int is_throttling;
+	int throttle_count;
+	int throttle_index;
+	int throt_tab_size;
+	struct throttle_table throt_tab[MAX_THROT_TABLE_SIZE + 1];
+};
+
+struct tegra_thermal_data {
+	struct thermal_zone *tz;
+	struct node_args np_args;
+	int passive_delay;
+	struct balanced_throttle tj_throttle;
+	struct thermal_trip_point trip_ext;
+};
+
+static DEFINE_MUTEX(cpu_throttle_lock);
+
+static int tegra_throttle_get_max_state(struct thermal_cooling_device *cdev,
+				unsigned long *max_state)
+{
+	struct balanced_throttle *bthrot = cdev->devdata;
+
+	*max_state = bthrot->throt_tab_size;
+
+	return 0;
+}
+
+static int
+tegra_throttle_get_cur_state(struct thermal_cooling_device *cdev,
+				unsigned long *cur_state)
+{
+	struct balanced_throttle *bthrot = cdev->devdata;
+
+	mutex_lock(&cpu_throttle_lock);
+	*cur_state = bthrot->is_throttling ?
+			(bthrot->throt_tab_size - bthrot->throttle_index) :
+			0;
+	mutex_unlock(&cpu_throttle_lock);
+
+	return 0;
+}
+
+static int
+tegra_throttle_set_cur_state(struct thermal_cooling_device *cdev,
+				unsigned long cur_state)
+{
+	struct balanced_throttle *bthrot = cdev->devdata;
+	int index;
+
+	mutex_lock(&cpu_throttle_lock);
+
+	/* TODO: we will handle the dvfs here */
+
+	bthrot->throttle_index = bthrot->throt_tab_size - cur_state;
+	index = bthrot->throttle_index;
+
+	mutex_unlock(&cpu_throttle_lock);
+
+	return 0;
+}
+
+static struct thermal_cooling_device_ops tegra_throttle_cooling_ops = {
+	.get_max_state = tegra_throttle_get_max_state,
+	.get_cur_state = tegra_throttle_get_cur_state,
+	.set_cur_state = tegra_throttle_set_cur_state,
+};
+
+struct thermal_cooling_device *balanced_throttle_register(
+		struct balanced_throttle *bthrot, char *type)
+{
+	bthrot->cdev = thermal_cooling_device_register(type, bthrot,
+						&tegra_throttle_cooling_ops);
+
+	if (IS_ERR(bthrot->cdev)) {
+		bthrot->cdev = NULL;
+		return ERR_PTR(-ENODEV);
+	}
+
+	return bthrot->cdev;
+}
+
+static struct tegra_thermal_data * __devinit thermal_tegra_dt_parse_pdata(
+						struct platform_device *pdev)
+{
+	struct tegra_thermal_data *tdata;
+	struct device_node *np = pdev->dev.of_node;
+	struct of_phandle_args args;
+	u32 val;
+	int ret;
+
+	if (!np)
+		return NULL;
+
+	tdata = devm_kzalloc(&pdev->dev, sizeof(*tdata), GFP_KERNEL);
+	if (!tdata) {
+		dev_err(&pdev->dev, "Can't allocate platform data\n");
+		return NULL;
+	}
+	memset(tdata, 0, sizeof(*tdata));
+
+	ret = of_parse_phandle_with_args(np, "sensors", "#sensor-cells", 0,
+					&args);
+	if (ret) {
+		dev_err(&pdev->dev, "Can't get sensor.\n");
+		return NULL;
+	}
+	tdata->np_args.np = args.np;
+	tdata->np_args.index = args.args[0];
+
+	ret = of_property_read_u32(np, "passive-delay", &val);
+	if (!ret)
+		tdata->passive_delay = val;
+
+	ret = of_property_read_u32(np, "num-passive-trips", &val);
+	if (!ret)
+		tdata->trip_ext.num_passive_trips = val;
+
+	if (tdata->trip_ext.num_passive_trips) {
+		tdata->trip_ext.passive_trips = devm_kzalloc(&pdev->dev,
+						sizeof(int) * val, GFP_KERNEL);
+
+		of_property_read_u32_array(np, "passive-trips",
+				(u32 *)(tdata->trip_ext.passive_trips),
+				tdata->trip_ext.num_passive_trips);
+	}
+
+	ret = of_property_read_u32(np, "num-active-trips", &val);
+	if (!ret)
+		tdata->trip_ext.num_active_trips = val;
+
+	if (tdata->trip_ext.num_active_trips) {
+		tdata->trip_ext.active_trips = devm_kzalloc(&pdev->dev,
+						sizeof(int) * val, GFP_KERNEL);
+
+		of_property_read_u32_array(np, "active-trips",
+				(u32 *)(tdata->trip_ext.active_trips),
+				tdata->trip_ext.num_active_trips);
+	}
+
+	ret = of_property_read_u32(np, "throt-tab-size", &val);
+	if (!ret)
+		tdata->tj_throttle.throt_tab_size = val;
+
+	of_property_read_u32_array(np, "throt-tab",
+				(u32 *)(&tdata->tj_throttle.throt_tab),
+				tdata->tj_throttle.throt_tab_size * 2);
+
+	return tdata;
+}
+
+static int tegra30_thermal_probe(struct platform_device *pdev)
+{
+	struct tegra_thermal_data *pdata = pdev->dev.platform_data;
+	struct thermal_zone *tz;
+	struct thermal_sensor *ts;
+	static struct thermal_cooling_device *cdev;
+	int ret;
+
+	pdata = thermal_tegra_dt_parse_pdata(pdev);
+	if (!pdata) {
+		dev_err(&pdev->dev, "Get platform data failed.\n");
+		return -EINVAL;
+	}
+
+	/* Create a thermal zone */
+	tz = create_thermal_zone("tz_tegra", NULL);
+	if (!tz) {
+		dev_err(&pdev->dev, "Create thermal_zone failed.\n");
+		return -EINVAL;
+	}
+
+	pdata->tz = tz;
+
+	/* Register cooling device */
+	cdev = balanced_throttle_register(&pdata->tj_throttle, "cdev_throttle");
+	if (!cdev) {
+		dev_err(&pdev->dev, "Register cooling device failed.\n");
+		goto exit_remove_thermal_zone;
+	}
+
+	/* Get sensor */
+	ts = get_sensor_by_node(&pdata->np_args);
+	if (!ts) {
+		dev_err(&pdev->dev, "get_sensor_by_node failed.\n");
+		goto exit_unregister_cooling;
+	}
+
+	ret = add_sensor_to_zone(pdata->tz, ts);
+	if (ret) {
+		dev_err(&pdev->dev, "add_sensor_to_zone failed.\n");
+		goto exit_unregister_cooling;
+	}
+
+	ret = add_cdev_to_zone(pdata->tz, cdev);
+	if (ret) {
+		dev_err(&pdev->dev, "add_cdev_to_zone failed.\n");
+		goto exit_unregister_cooling;
+	}
+
+	ret = add_sensor_trip_info(pdata->tz, ts, &pdata->trip_ext);
+	if (ret) {
+		dev_err(&pdev->dev, "add_sensor_trip_info failed.\n");
+		goto exit_unregister_cooling;
+	}
+
+	return 0;
+
+exit_unregister_cooling:
+	thermal_cooling_device_unregister(cdev);
+exit_remove_thermal_zone:
+	remove_thermal_zone(pdata->tz);
+	return -EINVAL;
+
+}
+
+static int tegra30_thermal_remove(struct platform_device *pdev)
+{
+	struct tegra_thermal_data *pdata = pdev->dev.platform_data;
+	int i;
+
+	for (i = 0; i < MAX_CDEVS_PER_ZONE; i++) {
+		if (pdata->tz->cdevs[i])
+			thermal_cooling_device_unregister(pdata->tz->cdevs[i]);
+		else
+			break;
+	}
+
+	remove_thermal_zone(pdata->tz);
+
+	return 0;
+}
+
+static const struct of_device_id tegra30_thermal_id_table[] = {
+	{ .compatible = "nvidia,tegra30-thermal" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, tegra30_thermal_id_table);
+
+static struct platform_driver tegra3_thermal_driver = {
+	.probe = tegra30_thermal_probe,
+	.remove = tegra30_thermal_remove,
+	.driver = {
+		.name = "tegra_thermal",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(tegra30_thermal_id_table),
+	},
+};
+module_platform_driver(tegra3_thermal_driver);
+
+MODULE_AUTHOR("Wei Ni <wni@nvidia.com>");
+MODULE_DESCRIPTION("Tegra30 thermal throttle driver");
+MODULE_LICENSE("GPL v2");
-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
