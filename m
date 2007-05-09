From: Dmitry Torokhov <dtor@insightbb.com>
Date: Wed, 09 May 2007 03:13:13 +0000
Subject: [lm-sensors] [PATCH] drivers/hwmon - switch to using
Message-Id: <200705082313.13748.dtor@insightbb.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200705080025.36131.dtor@insightbb.com>
In-Reply-To: <200705080025.36131.dtor@insightbb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

In preparation for struct class_device -> struct device input
core conversion, switch to using input_dev->dev.parent when
specifying device position in sysfs tree.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

[Added applesmc to the mix]

 drivers/hwmon/ams/ams-input.c |    2 +-
 drivers/hwmon/applesmc.c      |    2 +-
 drivers/hwmon/hdaps.c         |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

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
@@ -574,7 +574,7 @@ static int __init hdaps_init(void)
 
 	/* initialize the input class */
 	hdaps_idev->name = "hdaps";
-	hdaps_idev->cdev.dev = &pdev->dev;
+	hdaps_idev->dev.parent = &pdev->dev;
 	hdaps_idev->evbit[0] = BIT(EV_ABS);
 	input_set_abs_params(hdaps_idev, ABS_X,
 			-256, 256, HDAPS_INPUT_FUZZ, HDAPS_INPUT_FLAT);
Index: work/drivers/hwmon/applesmc.c
=================================--- work.orig/drivers/hwmon/applesmc.c
+++ work/drivers/hwmon/applesmc.c
@@ -1100,7 +1100,7 @@ static int applesmc_create_accelerometer
 	/* initialize the input class */
 	applesmc_idev->name = "applesmc";
 	applesmc_idev->id.bustype = BUS_HOST;
-	applesmc_idev->cdev.dev = &pdev->dev;
+	applesmc_idev->dev.parent = &pdev->dev;
 	applesmc_idev->evbit[0] = BIT(EV_ABS);
 	applesmc_idev->open = applesmc_idev_open;
 	applesmc_idev->close = applesmc_idev_close;

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
