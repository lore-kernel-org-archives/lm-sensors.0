From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Fri, 03 May 2013 09:55:40 +0000
Subject: [lm-sensors] [PATCH 5/5] hwmon: w83627ehf: Remove redundant platform_set_drvdata()
Message-Id: <1367574220-15787-5-git-send-email-sachin.kamat@linaro.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83627ehf.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index 0160272..004801e 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -2598,7 +2598,6 @@ static int w83627ehf_probe(struct platform_device *pdev)
 exit_remove:
 	w83627ehf_device_remove_files(dev);
 exit_release:
-	platform_set_drvdata(pdev, NULL);
 	release_region(res->start, IOREGION_LENGTH);
 exit:
 	return err;
@@ -2611,7 +2610,6 @@ static int w83627ehf_remove(struct platform_device *pdev)
 	hwmon_device_unregister(data->hwmon_dev);
 	w83627ehf_device_remove_files(&pdev->dev);
 	release_region(data->addr, IOREGION_LENGTH);
-	platform_set_drvdata(pdev, NULL);
 
 	return 0;
 }
-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
