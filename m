From: "Henrik Rydberg" <rydberg@euromail.se>
Date: Mon, 24 Aug 2009 23:42:01 +0000
Subject: [lm-sensors] [PATCH] hwmon: applesmc: restore accelerometer and
Message-Id: <1251157321-25535-1-git-send-email-rydberg@euromail.se>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: nicolas@boichat.ch, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

On resume from suspend, the driver currently resets the logical
state as if it was brought up from halt. This patch uses the
dev_pm_ops.resume/restore methods to synchronize the hardware with
the memorized logical state, in effect bringing back the accelerometer
and backlight to the state prior to suspend. Works for both suspend to
ram and hibernation. The patch has zero effect on the running state.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/hwmon/applesmc.c |   38 ++++++++++++++++++++++++++------------
 1 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index 678e34b..b7ab1a0 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -178,6 +178,8 @@ static const int debug;
 static struct platform_device *pdev;
 static s16 rest_x;
 static s16 rest_y;
+static u8 backlight_state[2];
+
 static struct device *hwmon_dev;
 static struct input_polled_dev *applesmc_idev;
 
@@ -497,17 +499,36 @@ static int applesmc_probe(struct platform_device *dev)
 	return 0;
 }
 
-static int applesmc_resume(struct platform_device *dev)
+/* Synchronize device with memorized backlight state */
+static int applesmc_pm_resume(struct device *dev)
 {
-	return applesmc_device_init();
+	mutex_lock(&applesmc_lock);
+	if (applesmc_light)
+		applesmc_write_key(BACKLIGHT_KEY, backlight_state, 2);
+	mutex_unlock(&applesmc_lock);
+	return 0;
 }
 
+/* Reinitialize device on resume from hibernation */
+static int applesmc_pm_restore(struct device *dev)
+{
+	int ret = applesmc_device_init();
+	if (ret)
+		return ret;
+	return applesmc_pm_resume(dev);
+}
+
+static struct dev_pm_ops applesmc_pm_ops = {
+	.resume = applesmc_pm_resume,
+	.restore = applesmc_pm_restore,
+};
+
 static struct platform_driver applesmc_driver = {
 	.probe = applesmc_probe,
-	.resume = applesmc_resume,
 	.driver	= {
 		.name = "applesmc",
 		.owner = THIS_MODULE,
+		.pm = &applesmc_pm_ops,
 	},
 };
 
@@ -804,17 +825,10 @@ static ssize_t applesmc_calibrate_store(struct device *dev,
 	return count;
 }
 
-/* Store the next backlight value to be written by the work */
-static unsigned int backlight_value;
-
 static void applesmc_backlight_set(struct work_struct *work)
 {
-	u8 buffer[2];
-
 	mutex_lock(&applesmc_lock);
-	buffer[0] = backlight_value;
-	buffer[1] = 0x00;
-	applesmc_write_key(BACKLIGHT_KEY, buffer, 2);
+	applesmc_write_key(BACKLIGHT_KEY, backlight_state, 2);
 	mutex_unlock(&applesmc_lock);
 }
 static DECLARE_WORK(backlight_work, &applesmc_backlight_set);
@@ -824,7 +838,7 @@ static void applesmc_brightness_set(struct led_classdev *led_cdev,
 {
 	int ret;
 
-	backlight_value = value;
+	backlight_state[0] = value;
 	ret = queue_work(applesmc_led_wq, &backlight_work);
 
 	if (debug && (!ret))
-- 
1.6.3.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
