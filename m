From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 28 Aug 2006 12:21:42 +0000
Subject: [lm-sensors] [PATCH 02/14] hdaps: Handle errors from
Message-Id: <20060828142142.d4dcad2c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Dmitry Torokhov <dtor at insightbb.com>
Content-Disposition: inline; filename=hwmon-hdaps-handle-errors-from-input-register-device.patch

HDAPS: handle errors from input_register_device()

Signed-off-by: Dmitry Torokhov <dtor at mail.ru>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
---

 drivers/hwmon/hdaps.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- linux-2.6.18-rc4.orig/drivers/hwmon/hdaps.c	2006-08-27 22:32:01.000000000 +0200
+++ linux-2.6.18-rc4/drivers/hwmon/hdaps.c	2006-08-27 22:38:41.000000000 +0200
@@ -587,7 +587,9 @@
 	input_set_abs_params(hdaps_idev, ABS_Y,
 			-256, 256, HDAPS_INPUT_FUZZ, HDAPS_INPUT_FLAT);
 
-	input_register_device(hdaps_idev);
+	ret = input_register_device(hdaps_idev);
+	if (ret)
+		goto out_idev;
 
 	/* start up our timer for the input device */
 	init_timer(&hdaps_timer);
@@ -598,6 +600,8 @@
 	printk(KERN_INFO "hdaps: driver successfully loaded.\n");
 	return 0;
 
+out_idev:
+	input_free_device(hdaps_idev);
 out_group:
 	sysfs_remove_group(&pdev->dev.kobj, &hdaps_attribute_group);
 out_device:

-- 
Jean Delvare

