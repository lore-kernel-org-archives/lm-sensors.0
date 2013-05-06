From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 06 May 2013 03:58:28 +0000
Subject: [lm-sensors] [PATCH 3/5] hwmon: (i5k_amb) remove unnecessary platform_set_drvdata()
Message-Id: <002b01ce4a0d$f799b8c0$e6cd2a40$@samsung.com>
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
 drivers/hwmon/i5k_amb.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

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
1.7.2.5



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
