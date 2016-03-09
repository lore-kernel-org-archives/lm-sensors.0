From: Eduardo Valentin <edubezval@gmail.com>
Date: Wed, 09 Mar 2016 21:35:34 +0000
Subject: [lm-sensors] [PATCH 12/13] thermal: convert tegra_thermal to use devm_thermal_zone_of_sensor_registe
Message-Id: <1457559336-17652-13-git-send-email-edubezval@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1457559336-17652-1-git-send-email-edubezval@gmail.com>
In-Reply-To: <1457559336-17652-1-git-send-email-edubezval@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, Eduardo Valentin <edubezval@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org

This changes the driver to use the devm_ version
of thermal_zone_of_sensor_register and cleans
up the  local points and unregister calls.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-tegra@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/tegra_soctherm.c | 31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/drivers/thermal/tegra_soctherm.c b/drivers/thermal/tegra_soctherm.c
index 74ea576..0018ccd 100644
--- a/drivers/thermal/tegra_soctherm.c
+++ b/drivers/thermal/tegra_soctherm.c
@@ -168,7 +168,7 @@ struct tegra_soctherm {
 	struct clk *clock_soctherm;
 	void __iomem *regs;
 
-	struct thermal_zone_device *thermctl_tzs[4];
+#define ZONE_NUMBER		4
 };
 
 struct tsensor_shared_calibration {
@@ -342,7 +342,7 @@ static const struct thermctl_zone_desc t124_thermctl_temp_zones[] = {
 static int tegra_soctherm_probe(struct platform_device *pdev)
 {
 	struct tegra_soctherm *tegra;
-	struct thermal_zone_device *tz;
+	struct thermal_zone_device *z;
 	struct tsensor_shared_calibration shared_calib;
 	struct resource *res;
 	unsigned int i;
@@ -408,36 +408,29 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 
 	/* Initialize thermctl sensors */
 
-	for (i = 0; i < ARRAY_SIZE(tegra->thermctl_tzs); ++i) {
+	for (i = 0; i < ZONE_NUMBER; ++i) {
 		struct tegra_thermctl_zone *zone  			devm_kzalloc(&pdev->dev, sizeof(*zone), GFP_KERNEL);
 		if (!zone) {
 			err = -ENOMEM;
-			goto unregister_tzs;
+			goto disable_clocks;
 		}
 
 		zone->reg = tegra->regs + t124_thermctl_temp_zones[i].offset;
 		zone->shift = t124_thermctl_temp_zones[i].shift;
 
-		tz = thermal_zone_of_sensor_register(&pdev->dev, i, zone,
-						     &tegra_of_thermal_ops);
-		if (IS_ERR(tz)) {
-			err = PTR_ERR(tz);
+		z = devm_thermal_zone_of_sensor_register(&pdev->dev, i, zone,
+							 &tegra_of_thermal_ops);
+		if (IS_ERR(z)) {
+			err = PTR_ERR(z);
 			dev_err(&pdev->dev, "failed to register sensor: %d\n",
 				err);
-			goto unregister_tzs;
+			goto disable_clocks;
 		}
-
-		tegra->thermctl_tzs[i] = tz;
 	}
 
 	return 0;
 
-unregister_tzs:
-	while (i--)
-		thermal_zone_of_sensor_unregister(&pdev->dev,
-						  tegra->thermctl_tzs[i]);
-
 disable_clocks:
 	clk_disable_unprepare(tegra->clock_tsensor);
 	clk_disable_unprepare(tegra->clock_soctherm);
@@ -448,12 +441,6 @@ disable_clocks:
 static int tegra_soctherm_remove(struct platform_device *pdev)
 {
 	struct tegra_soctherm *tegra = platform_get_drvdata(pdev);
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(tegra->thermctl_tzs); ++i) {
-		thermal_zone_of_sensor_unregister(&pdev->dev,
-						  tegra->thermctl_tzs[i]);
-	}
 
 	clk_disable_unprepare(tegra->clock_tsensor);
 	clk_disable_unprepare(tegra->clock_soctherm);
-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
