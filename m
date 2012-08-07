From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 07 Aug 2012 15:19:51 +0000
Subject: [lm-sensors] [PATCH 02/39] hwmon: (abituguru3) Convert to use devm_ functions
Message-Id: <1344352828-25143-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Alistair John Strachan <alistair@devzero.co.uk>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/abituguru3.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/abituguru3.c b/drivers/hwmon/abituguru3.c
index 5d582ae..b174b8b 100644
--- a/drivers/hwmon/abituguru3.c
+++ b/drivers/hwmon/abituguru3.c
@@ -976,7 +976,8 @@ static int __devinit abituguru3_probe(struct platform_device *pdev)
 	u8 buf[2];
 	u16 id;
 
-	data = kzalloc(sizeof(struct abituguru3_data), GFP_KERNEL);
+	data = devm_kzalloc(&pdev->dev, sizeof(struct abituguru3_data),
+			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -1068,7 +1069,6 @@ abituguru3_probe_error:
 	for (i = 0; i < ARRAY_SIZE(abituguru3_sysfs_attr); i++)
 		device_remove_file(&pdev->dev,
 			&abituguru3_sysfs_attr[i].dev_attr);
-	kfree(data);
 	return res;
 }
 
@@ -1084,8 +1084,6 @@ static int __devexit abituguru3_remove(struct platform_device *pdev)
 	for (i = 0; i < ARRAY_SIZE(abituguru3_sysfs_attr); i++)
 		device_remove_file(&pdev->dev,
 			&abituguru3_sysfs_attr[i].dev_attr);
-	kfree(data);
-
 	return 0;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
