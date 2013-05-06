From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 06 May 2013 04:02:29 +0000
Subject: [lm-sensors] [PATCH 5/5] hwmon: (w83627ehf) remove unnecessary platform_set_drvdata()
Message-Id: <002d01ce4a0e$86e51240$94af36c0$@samsung.com>
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
 drivers/hwmon/w83627ehf.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

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
1.7.2.5



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
