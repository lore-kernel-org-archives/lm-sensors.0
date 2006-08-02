From: dtor@insightbb.com (Dmitry Torokhov)
Date: Wed, 02 Aug 2006 02:37:30 +0000
Subject: [lm-sensors] [PATCH] HDAPS: handle errors from
Message-Id: <200608012237.30591.dtor@insightbb.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Compile-tested only (do not have the hardware)

-- 
Dmitry


HDAPS: handle errors from input_register_device()

Signed-off-by: Dmitry Torokhov <dtor at mail.ru>
---

 drivers/hwmon/hdaps.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)

Index: work/drivers/hwmon/hdaps.c
=================================--- work.orig/drivers/hwmon/hdaps.c
+++ work/drivers/hwmon/hdaps.c
@@ -587,7 +587,9 @@ static int __init hdaps_init(void)
 	input_set_abs_params(hdaps_idev, ABS_Y,
 			-256, 256, HDAPS_INPUT_FUZZ, HDAPS_INPUT_FLAT);
 
-	input_register_device(hdaps_idev);
+	ret = input_register_device(hdaps_idev);
+	if (ret)
+		goto out_idev;
 
 	/* start up our timer for the input device */
 	init_timer(&hdaps_timer);
@@ -598,6 +600,8 @@ static int __init hdaps_init(void)
 	printk(KERN_INFO "hdaps: driver successfully loaded.\n");
 	return 0;
 
+out_idev:
+	input_free_device(hdaps_idev);
 out_group:
 	sysfs_remove_group(&pdev->dev.kobj, &hdaps_attribute_group);
 out_device:

