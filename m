From: Eduardo Valentin <edubezval@gmail.com>
Date: Wed, 09 Mar 2016 21:35:28 +0000
Subject: [lm-sensors] [PATCH 06/13] thermal: convert hisi_thermal to use devm_thermal_zone_of_sensor_register
Message-Id: <1457559336-17652-7-git-send-email-edubezval@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1457559336-17652-1-git-send-email-edubezval@gmail.com>
In-Reply-To: <1457559336-17652-1-git-send-email-edubezval@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, Eduardo Valentin <edubezval@gmail.com>

This changes the driver to use the devm_ version
of thermal_zone_of_sensor_register and cleans
up the  local points and unregister calls.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/hisi_thermal.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 36d0729..c9b2f81 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -243,8 +243,8 @@ static int hisi_thermal_register_sensor(struct platform_device *pdev,
 	sensor->id = index;
 	sensor->thermal = data;
 
-	sensor->tzd = thermal_zone_of_sensor_register(&pdev->dev, sensor->id,
-				sensor, &hisi_of_thermal_ops);
+	sensor->tzd = devm_thermal_zone_of_sensor_register(&pdev->dev,
+				sensor->id, sensor, &hisi_of_thermal_ops);
 	if (IS_ERR(sensor->tzd)) {
 		ret = PTR_ERR(sensor->tzd);
 		dev_err(&pdev->dev, "failed to register sensor id %d: %d\n",
@@ -364,7 +364,6 @@ static int hisi_thermal_remove(struct platform_device *pdev)
 		struct hisi_thermal_sensor *sensor = &data->sensors[i];
 
 		hisi_thermal_toggle_sensor(sensor, false);
-		thermal_zone_of_sensor_unregister(&pdev->dev, sensor->tzd);
 	}
 
 	hisi_thermal_disable_sensor(data);
-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
