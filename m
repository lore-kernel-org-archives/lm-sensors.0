From: Axel Lin <axel.lin@ingics.com>
Date: Mon, 13 May 2013 13:37:26 +0000
Subject: [lm-sensors] [PATCH] hwmon: (iio_hwmon) Fix null pointer dereference
Message-Id: <1368452246.10208.0.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch fixes the null pointer dereference in goto error_release_channels
path when allocate memory for st fails.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/iio_hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
index 368497f..52b77af 100644
--- a/drivers/hwmon/iio_hwmon.c
+++ b/drivers/hwmon/iio_hwmon.c
@@ -161,7 +161,7 @@ static int iio_hwmon_probe(struct platform_device *pdev)
 error_remove_group:
 	sysfs_remove_group(&dev->kobj, &st->attr_group);
 error_release_channels:
-	iio_channel_release_all(st->channels);
+	iio_channel_release_all(channels);
 	return ret;
 }
 
-- 
1.8.1.2




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
