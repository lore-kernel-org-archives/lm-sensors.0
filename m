From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 23 Nov 2013 19:03:19 +0000
Subject: [lm-sensors] [PATCH 3/5] compal-laptop: Use devm_kzalloc to allocate local data structure
Message-Id: <1385233401-21517-4-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1385233401-21517-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1385233401-21517-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Garrett <matthew.garrett@nebula.com>
Cc: Corentin Chary <corentin.chary@gmail.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, acpi4asus-user@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

Reduce code size and simplify error path.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/platform/x86/compal-laptop.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/compal-laptop.c b/drivers/platform/x86/compal-laptop.c
index 8b119a7..9deb035 100644
--- a/drivers/platform/x86/compal-laptop.c
+++ b/drivers/platform/x86/compal-laptop.c
@@ -1026,24 +1026,21 @@ static int compal_probe(struct platform_device *pdev)
 		return 0;
 
 	/* Fan control */
-	data = kzalloc(sizeof(struct compal_data), GFP_KERNEL);
+	data = devm_kzalloc(&pdev->dev, sizeof(struct compal_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
 	initialize_fan_control_data(data);
 
 	err = sysfs_create_group(&pdev->dev.kobj, &compal_attribute_group);
-	if (err) {
-		kfree(data);
+	if (err)
 		return err;
-	}
 
 	data->hwmon_dev = hwmon_device_register(&pdev->dev);
 	if (IS_ERR(data->hwmon_dev)) {
 		err = PTR_ERR(data->hwmon_dev);
 		sysfs_remove_group(&pdev->dev.kobj,
 				&compal_attribute_group);
-		kfree(data);
 		return err;
 	}
 
@@ -1083,8 +1080,6 @@ static int compal_remove(struct platform_device *pdev)
 	hwmon_device_unregister(data->hwmon_dev);
 	power_supply_unregister(&data->psy);
 
-	kfree(data);
-
 	sysfs_remove_group(&pdev->dev.kobj, &compal_attribute_group);
 
 	return 0;
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
