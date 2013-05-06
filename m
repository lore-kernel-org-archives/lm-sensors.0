From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 06 May 2013 03:57:40 +0000
Subject: [lm-sensors] [PATCH 2/5] hwmon: (coretemp) remove unnecessary platform_set_drvdata()
Message-Id: <002a01ce4a0d$dab7ec40$9027c4c0$@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The driver core clears the driver data to NULL after device_release
or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
(device-core: Ensure drvdata = NULL when no driver is bound).
Thus, it is not needed to manually clear the device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/hwmon/coretemp.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

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
1.7.2.5



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
