From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 29 Apr 2014 08:12:25 +0000
Subject: [lm-sensors] [PATCH 7/8] hwmon: (s3c-hwmon) remove unnecessary OOM messages
Message-Id: <002001cf6382$c1520530$43f60f90$%han@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The site-specific OOM messages are unnecessary, because they
duplicate the MM subsystem generic OOM message.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/hwmon/s3c-hwmon.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hwmon/s3c-hwmon.c b/drivers/hwmon/s3c-hwmon.c
index 73bd64e..0674c13 100644
--- a/drivers/hwmon/s3c-hwmon.c
+++ b/drivers/hwmon/s3c-hwmon.c
@@ -285,10 +285,8 @@ static int s3c_hwmon_probe(struct platform_device *dev)
 	}
 
 	hwmon = devm_kzalloc(&dev->dev, sizeof(struct s3c_hwmon), GFP_KERNEL);
-	if (hwmon = NULL) {
-		dev_err(&dev->dev, "no memory\n");
+	if (hwmon = NULL)
 		return -ENOMEM;
-	}
 
 	platform_set_drvdata(dev, hwmon);
 
-- 
1.7.10.4



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
