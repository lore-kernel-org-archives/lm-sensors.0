From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 07 Aug 2012 15:19:50 +0000
Subject: [lm-sensors] [PATCH 01/39] hwmon: (abituguru) Convert to use devm_ functions
Message-Id: <1344352828-25143-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/abituguru.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/abituguru.c b/drivers/hwmon/abituguru.c
index d4419b4..78b8179 100644
--- a/drivers/hwmon/abituguru.c
+++ b/drivers/hwmon/abituguru.c
@@ -1278,7 +1278,8 @@ static int __devinit abituguru_probe(struct platform_device *pdev)
 		0x00, 0x01, 0x03, 0x04, 0x0A, 0x08, 0x0E, 0x02,
 		0x09, 0x06, 0x05, 0x0B, 0x0F, 0x0D, 0x07, 0x0C };
 
-	data = kzalloc(sizeof(struct abituguru_data), GFP_KERNEL);
+	data = devm_kzalloc(&pdev->dev, sizeof(struct abituguru_data),
+			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -1430,8 +1431,6 @@ abituguru_probe_error:
 	for (i = 0; i < ARRAY_SIZE(abituguru_sysfs_attr); i++)
 		device_remove_file(&pdev->dev,
 			&abituguru_sysfs_attr[i].dev_attr);
-	platform_set_drvdata(pdev, NULL);
-	kfree(data);
 	return res;
 }
 
@@ -1446,8 +1445,6 @@ static int __devexit abituguru_remove(struct platform_device *pdev)
 	for (i = 0; i < ARRAY_SIZE(abituguru_sysfs_attr); i++)
 		device_remove_file(&pdev->dev,
 			&abituguru_sysfs_attr[i].dev_attr);
-	platform_set_drvdata(pdev, NULL);
-	kfree(data);
 
 	return 0;
 }
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
