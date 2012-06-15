From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:23:51 +0000
Subject: [lm-sensors] [PATCH 70/95] hwmon: (sch5627) Convert to use devm_ functions
Message-Id: <1339773856-3443-71-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/sch5627.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/sch5627.c b/drivers/hwmon/sch5627.c
index 8342275..49f6230 100644
--- a/drivers/hwmon/sch5627.c
+++ b/drivers/hwmon/sch5627.c
@@ -461,8 +461,6 @@ static int sch5627_remove(struct platform_device *pdev)
 		hwmon_device_unregister(data->hwmon_dev);
 
 	sysfs_remove_group(&pdev->dev.kobj, &sch5627_group);
-	platform_set_drvdata(pdev, NULL);
-	kfree(data);
 
 	return 0;
 }
@@ -472,7 +470,8 @@ static int __devinit sch5627_probe(struct platform_device *pdev)
 	struct sch5627_data *data;
 	int err, build_code, build_id, hwmon_rev, val;
 
-	data = kzalloc(sizeof(struct sch5627_data), GFP_KERNEL);
+	data = devm_kzalloc(&pdev->dev, sizeof(struct sch5627_data),
+			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
