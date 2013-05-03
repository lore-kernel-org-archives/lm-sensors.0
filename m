From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Fri, 03 May 2013 09:55:37 +0000
Subject: [lm-sensors] [PATCH 2/5] hwmon: coretemp: Remove redundant platform_set_drvdata()
Message-Id: <1367574220-15787-2-git-send-email-sachin.kamat@linaro.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Rudolf Marek <r.marek@assembler.cz>
---
 drivers/hwmon/coretemp.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 658ce3a..ade35cf 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -578,7 +578,6 @@ static int coretemp_probe(struct platform_device *pdev)
 
 exit_name:
 	device_remove_file(&pdev->dev, &pdata->name_attr);
-	platform_set_drvdata(pdev, NULL);
 exit_free:
 	kfree(pdata);
 	return err;
@@ -595,7 +594,6 @@ static int coretemp_remove(struct platform_device *pdev)
 
 	device_remove_file(&pdev->dev, &pdata->name_attr);
 	hwmon_device_unregister(pdata->hwmon_dev);
-	platform_set_drvdata(pdev, NULL);
 	kfree(pdata);
 	return 0;
 }
-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
