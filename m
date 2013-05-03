From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Fri, 03 May 2013 09:55:38 +0000
Subject: [lm-sensors] [PATCH 3/5] hwmon: i5k_amb: Remove redundant platform_set_drvdata()
Message-Id: <1367574220-15787-3-git-send-email-sachin.kamat@linaro.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Darrick J. Wong <djwong@us.ibm.com>
---
 drivers/hwmon/i5k_amb.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hwmon/i5k_amb.c b/drivers/hwmon/i5k_amb.c
index b87c2cc..de058c2 100644
--- a/drivers/hwmon/i5k_amb.c
+++ b/drivers/hwmon/i5k_amb.c
@@ -556,7 +556,6 @@ static int i5k_amb_probe(struct platform_device *pdev)
 
 err_init_failed:
 	iounmap(data->amb_mmio);
-	platform_set_drvdata(pdev, NULL);
 err_map_failed:
 	release_mem_region(data->amb_base, data->amb_len);
 err:
@@ -576,7 +575,6 @@ static int i5k_amb_remove(struct platform_device *pdev)
 	kfree(data->attrs);
 	iounmap(data->amb_mmio);
 	release_mem_region(data->amb_base, data->amb_len);
-	platform_set_drvdata(pdev, NULL);
 	kfree(data);
 	return 0;
 }
-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
