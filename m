From: greg@kroah.com (Greg KH)
Date: Thu, 28 Sep 2006 22:48:24 +0000
Subject: [lm-sensors] [PATCH 4/39] hdaps: Handle errors from
Message-Id: <1159483750768-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Dmitry Torokhov <dtor at insightbb.com>

HDAPS: handle errors from input_register_device()

Signed-off-by: Dmitry Torokhov <dtor at mail.ru>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/hwmon/hdaps.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/hdaps.c b/drivers/hwmon/hdaps.c
index 42b6328..8e7b560 100644
--- a/drivers/hwmon/hdaps.c
+++ b/drivers/hwmon/hdaps.c
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
-- 
1.4.2.1


