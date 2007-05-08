From: Dmitry Torokhov <dtor@insightbb.com>
Date: Tue, 08 May 2007 04:25:35 +0000
Subject: [lm-sensors] [PATCH] drivers/hwmon - switch to using
Message-Id: <200705080025.36131.dtor@insightbb.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

In preparation for struct class_device -> struct device input
core conversion, switch to using input_dev->dev.parent when
specifying device position in sysfs tree.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/hwmon/ams/ams-input.c |    2 +-
 drivers/hwmon/hdaps.c         |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: work/drivers/hwmon/ams/ams-input.c
=================================--- work.orig/drivers/hwmon/ams/ams-input.c
+++ work/drivers/hwmon/ams/ams-input.c
@@ -87,7 +87,7 @@ static void ams_input_enable(void)
 	ams_info.idev->id.vendor = 0;
 	ams_info.idev->open = ams_input_open;
 	ams_info.idev->close = ams_input_close;
-	ams_info.idev->cdev.dev = &ams_info.of_dev->dev;
+	ams_info.idev->dev.parent = &ams_info.of_dev->dev;
 
 	input_set_abs_params(ams_info.idev, ABS_X, -50, 50, 3, 0);
 	input_set_abs_params(ams_info.idev, ABS_Y, -50, 50, 3, 0);
Index: work/drivers/hwmon/hdaps.c
=================================--- work.orig/drivers/hwmon/hdaps.c
+++ work/drivers/hwmon/hdaps.c
@@ -572,7 +572,7 @@ static int __init hdaps_init(void)
 
 	/* initialize the input class */
 	hdaps_idev->name = "hdaps";
-	hdaps_idev->cdev.dev = &pdev->dev;
+	hdaps_idev->dev.parent = &pdev->dev;
 	hdaps_idev->evbit[0] = BIT(EV_ABS);
 	input_set_abs_params(hdaps_idev, ABS_X,
 			-256, 256, HDAPS_INPUT_FUZZ, HDAPS_INPUT_FLAT);

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
