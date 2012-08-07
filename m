From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 07 Aug 2012 15:20:21 +0000
Subject: [lm-sensors] [PATCH 32/39] hwmon: (sch5636) Convert to use devm_ functions
Message-Id: <1344352828-25143-33-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/sch5636.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/sch5636.c b/drivers/hwmon/sch5636.c
index 96a7e68..5171180 100644
--- a/drivers/hwmon/sch5636.c
+++ b/drivers/hwmon/sch5636.c
@@ -402,9 +402,6 @@ static int sch5636_remove(struct platform_device *pdev)
 		device_remove_file(&pdev->dev,
 				   &sch5636_fan_attr[i].dev_attr);
 
-	platform_set_drvdata(pdev, NULL);
-	kfree(data);
-
 	return 0;
 }
 
@@ -414,7 +411,8 @@ static int __devinit sch5636_probe(struct platform_device *pdev)
 	int i, err, val, revision[2];
 	char id[4];
 
-	data = kzalloc(sizeof(struct sch5636_data), GFP_KERNEL);
+	data = devm_kzalloc(&pdev->dev, sizeof(struct sch5636_data),
+			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
