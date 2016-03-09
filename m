From: Eduardo Valentin <edubezval@gmail.com>
Date: Wed, 09 Mar 2016 21:35:29 +0000
Subject: [lm-sensors] [PATCH 07/13] thermal: convert mtk_thermal to use devm_thermal_zone_of_sensor_register
Message-Id: <1457559336-17652-8-git-send-email-edubezval@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1457559336-17652-1-git-send-email-edubezval@gmail.com>
In-Reply-To: <1457559336-17652-1-git-send-email-edubezval@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, Eduardo Valentin <edubezval@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

This changes the driver to use the devm_ version
of thermal_zone_of_sensor_register and cleans
up the  local points and unregister calls.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/mtk_thermal.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index 3d93b1c..2c40b0f 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -145,7 +145,6 @@ struct mtk_thermal {
 	s32 o_slope;
 	s32 vts[MT8173_NUM_SENSORS];
 
-	struct thermal_zone_device *tzd;
 };
 
 struct mtk_thermal_bank_cfg {
@@ -573,16 +572,11 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, mt);
 
-	mt->tzd = thermal_zone_of_sensor_register(&pdev->dev, 0, mt,
-				&mtk_thermal_ops);
-	if (IS_ERR(mt->tzd))
-		goto err_register;
+	devm_thermal_zone_of_sensor_register(&pdev->dev, 0, mt,
+					     &mtk_thermal_ops);
 
 	return 0;
 
-err_register:
-	clk_disable_unprepare(mt->clk_peri_therm);
-
 err_disable_clk_auxadc:
 	clk_disable_unprepare(mt->clk_auxadc);
 
@@ -593,8 +587,6 @@ static int mtk_thermal_remove(struct platform_device *pdev)
 {
 	struct mtk_thermal *mt = platform_get_drvdata(pdev);
 
-	thermal_zone_of_sensor_unregister(&pdev->dev, mt->tzd);
-
 	clk_disable_unprepare(mt->clk_peri_therm);
 	clk_disable_unprepare(mt->clk_auxadc);
 
-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
