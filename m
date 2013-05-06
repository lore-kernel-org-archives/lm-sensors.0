From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 06 May 2013 03:56:43 +0000
Subject: [lm-sensors] [PATCH 1/5] hwmon: (abituguru3) remove unnecessary platform_set_drvdata()
Message-Id: <002901ce4a0d$b899cac0$29cd6040$@samsung.com>
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
 drivers/hwmon/abituguru3.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/abituguru3.c b/drivers/hwmon/abituguru3.c
index 1d2da31..0cac8c0 100644
--- a/drivers/hwmon/abituguru3.c
+++ b/drivers/hwmon/abituguru3.c
@@ -1079,7 +1079,6 @@ static int abituguru3_remove(struct platform_device *pdev)
 	int i;
 	struct abituguru3_data *data = platform_get_drvdata(pdev);
 
-	platform_set_drvdata(pdev, NULL);
 	hwmon_device_unregister(data->hwmon_dev);
 	for (i = 0; data->sysfs_attr[i].dev_attr.attr.name; i++)
 		device_remove_file(&pdev->dev, &data->sysfs_attr[i].dev_attr);
-- 
1.7.2.5



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
