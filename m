From: Eduardo Valentin <edubezval@gmail.com>
Date: Wed, 09 Mar 2016 21:35:32 +0000
Subject: [lm-sensors] [PATCH 10/13] thermal: convert rockchip_thermal to use devm_thermal_zone_of_sensor_regi
Message-Id: <1457559336-17652-11-git-send-email-edubezval@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1457559336-17652-1-git-send-email-edubezval@gmail.com>
In-Reply-To: <1457559336-17652-1-git-send-email-edubezval@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, Eduardo Valentin <edubezval@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org

This changes the driver to use the devm_ version
of thermal_zone_of_sensor_register and cleans
up the  local points and unregister calls.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/rockchip_thermal.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index b58e3fb..792c5d0 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -753,8 +753,8 @@ rockchip_thermal_register_sensor(struct platform_device *pdev,
 
 	sensor->thermal = thermal;
 	sensor->id = id;
-	sensor->tzd = thermal_zone_of_sensor_register(&pdev->dev, id, sensor,
-						      &rockchip_of_thermal_ops);
+	sensor->tzd = devm_thermal_zone_of_sensor_register(&pdev->dev, id,
+					sensor, &rockchip_of_thermal_ops);
 	if (IS_ERR(sensor->tzd)) {
 		error = PTR_ERR(sensor->tzd);
 		dev_err(&pdev->dev, "failed to register sensor %d: %d\n",
@@ -782,7 +782,7 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 	struct resource *res;
 	int irq;
-	int i, j;
+	int i;
 	int error;
 
 	match = of_match_node(of_rockchip_thermal_match, np);
@@ -865,9 +865,6 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"failed to register sensor[%d] : error = %d\n",
 				i, error);
-			for (j = 0; j < i; j++)
-				thermal_zone_of_sensor_unregister(&pdev->dev,
-						thermal->sensors[j].tzd);
 			goto err_disable_pclk;
 		}
 	}
@@ -879,7 +876,7 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 	if (error) {
 		dev_err(&pdev->dev,
 			"failed to request tsadc irq: %d\n", error);
-		goto err_unregister_sensor;
+		goto err_disable_pclk;
 	}
 
 	thermal->chip->control(thermal->regs, true);
@@ -891,11 +888,6 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 
 	return 0;
 
-err_unregister_sensor:
-	while (i--)
-		thermal_zone_of_sensor_unregister(&pdev->dev,
-						  thermal->sensors[i].tzd);
-
 err_disable_pclk:
 	clk_disable_unprepare(thermal->pclk);
 err_disable_clk:
@@ -913,7 +905,6 @@ static int rockchip_thermal_remove(struct platform_device *pdev)
 		struct rockchip_thermal_sensor *sensor = &thermal->sensors[i];
 
 		rockchip_thermal_toggle_sensor(sensor, false);
-		thermal_zone_of_sensor_unregister(&pdev->dev, sensor->tzd);
 	}
 
 	thermal->chip->control(thermal->regs, false);
-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
