From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Fri, 03 May 2013 09:55:36 +0000
Subject: [lm-sensors] [PATCH 1/5] hwmon: abituguru3: Remove redundant platform_set_drvdata()
Message-Id: <1367574220-15787-1-git-send-email-sachin.kamat@linaro.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hwmon/abituguru3.c |    1 -
 1 file changed, 1 deletion(-)

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
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
