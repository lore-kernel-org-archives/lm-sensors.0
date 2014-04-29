From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 29 Apr 2014 08:11:07 +0000
Subject: [lm-sensors] [PATCH 5/8] hwmon: (max197) remove unnecessary OOM messages
Message-Id: <001e01cf6382$92c58430$b8508c90$%han@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The site-specific OOM messages are unnecessary, because they
duplicate the MM subsystem generic OOM message.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/hwmon/max197.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hwmon/max197.c b/drivers/hwmon/max197.c
index 96dccaf..82128ad 100644
--- a/drivers/hwmon/max197.c
+++ b/drivers/hwmon/max197.c
@@ -275,10 +275,8 @@ static int max197_probe(struct platform_device *pdev)
 	}
 
 	data = devm_kzalloc(&pdev->dev, sizeof(struct max197_data), GFP_KERNEL);
-	if (!data) {
-		dev_err(&pdev->dev, "devm_kzalloc failed\n");
+	if (!data)
 		return -ENOMEM;
-	}
 
 	data->pdata = pdata;
 	mutex_init(&data->lock);
-- 
1.7.10.4



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
