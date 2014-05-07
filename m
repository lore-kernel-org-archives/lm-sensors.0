From: Jingoo Han <jg1.han@samsung.com>
Date: Wed, 07 May 2014 08:29:02 +0000
Subject: [lm-sensors] [PATCH 3/3] hwmon: (iio_hwmon) Make of_device_id array const
Message-Id: <020e01cf69ce$66c994a0$345cbde0$%han@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Make of_device_id array const, because all OF functions
handle it as const.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/hwmon/iio_hwmon.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
index 9fbb1b1..14c82da 100644
--- a/drivers/hwmon/iio_hwmon.c
+++ b/drivers/hwmon/iio_hwmon.c
@@ -163,7 +163,7 @@ static int iio_hwmon_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id iio_hwmon_of_match[] = {
+static const struct of_device_id iio_hwmon_of_match[] = {
 	{ .compatible = "iio-hwmon", },
 	{ }
 };
-- 
1.7.10.4



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
